# Overrides loc authority from qa gem to handle rdftypes for subauthorities

require 'uri'

module Qa::Authorities
  module Loc
    extend AuthorityWithSubAuthority

    require 'qa/authorities/loc/generic_authority'
    def self.subauthority_for(subauthority)
      validate_subauthority!(subauthority)
      GenericAuthority.new(subauthority)
    end

    extend LocSubauthority
    def self.subauthorities
      authorities + vocabularies + datatypes + preservation + rdftypes
    end
  end
end
