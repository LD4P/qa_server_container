module Qa::Authorities
  # A wrapper around the Wikidata api for use with questioning_authority
  # API documentation:
  # http://www.oclc.org/developer/develop/web-services/fast-api/assign-fast.en.html
  class Wikidata::GenericAuthority < Base
    attr_reader :subauthority
    def initialize(subauthority)
      @subauthority = subauthority
    end

    include WebServiceBase

    # require 'qa/authorities/wikidata/space_fix_encoder'
    # Wikidata returns json
    def response(url)
      # space_fix_encoder = Wikidata::SpaceFixEncoder.new
      Faraday.get(url) do |req|
        # req.options.params_encoder = space_fix_encoder
        req.headers['Accept'] = 'application/json'
      end
    end

    # Search the FAST api
    #
    # @param q [String] the query
    # @return json results with response_header and results
    def search(q)
      url = build_query_url q
      begin
        raw_response = json(url)
      rescue JSON::ParserError
        Rails.logger.info "Could not parse response as JSON. Request url: #{url}"
        return []
      end
      parse_authority_response(raw_response)
    end

    # Build a Wikidata url
    #
    # @param q [String] the query
    # @return [String] the url
    def build_query_url(q)
      # escaped_query = clean_query_string q # TODO: Is this needed for wikidata similar to FAST
      escaped_query = q
      num_rows = 20 # max allowed by the API
      "https://www.wikidata.org/w/api.php?action=wbsearchentities&search=#{escaped_query}&language=en&limit=#{num_rows}&type=#{subauthority}&format=json"
    end

    private

      # # Removes characters from the query string that are not tolerated by the API
      # #   See oclc sample code at
      # #   http://experimental.worldcat.org/fast/wikidata/js/wikidataComplete.js
      # def clean_query_string(q)
      #   ERB::Util.url_encode(q.gsub(/-|\(|\)|:/, ""))
      # end

      # @note WARNING: If this is moved to QA, it should NOT return json with results: and response_header: keys
      #                unless code is put in place to process a request for the response_header data.
      def parse_authority_response(raw_response)
        formatted_response = raw_response['search'].map do |doc|
          { id: doc['id'], uri: doc['concepturi'], label: doc['label'], context: extended_context(doc) }
        end
        {
          results: formatted_response,
          response_header: {
            start_record: 1,
            requested_records: "UNKNOWN",
            retrieved_records: raw_response.count,
            total_records: "UNKNOWN"
          }
        }
      end

      def extended_context(doc)
        extended_context = []
        extended_context << { property: 'label', values: [doc['label']] } if doc.key? 'label'
        extended_context << { property: 'q_number', values: [doc['title']] } if doc.key? 'title'
        extended_context << { property: 'description', values: [doc['description']] } if doc.key? 'description'
        extended_context
      end
  end
end
