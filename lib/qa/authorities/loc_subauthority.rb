# Overrides loc authority from qa gem to handle rdftypes for subauthorities

module Qa::Authorities::LocSubauthority
  def get_url_for_authority(authority)
    if authorities.include?(authority) then authority_base_url
    elsif vocabularies.include?(authority) then vocab_base_url
    elsif datatypes.include?(authority)    then datatype_base_url
    elsif preservation.include?(authority) then vocab_preservation_base_url
    end
  end

  def get_authority(authority)
    rdftypes.include?(authority) ? authority.split('_')[0] : authority
  end

  def get_rdftype(authority)
    rdftypes.include?(authority) ? authority.split('_')[-1] : nil
  end

  def authorities
    [
      "classification",
      "childrensSubjects",
      "demographicTerms",
      "genreForms",
      "names",
      "performanceMediums",
      "subjects",
    ]
  end

  def vocabularies # rubocop:disable Metrics/MethodLength
    [
      "actionsGranted",
      "agentType",
      "bookformat",
      "carriers",
      "classSchemes",
      "contentTypes",
      "countries",
      "descriptionConventions",
      "ethnographicTerms",
      "frequencies",
      "geographicAreas",
      "graphicMaterials",
      "iso639-1",
      "iso639-2",
      "iso639-5",
      "issuance",
      "languages",
      "marcauthen",
      "maspect",
      "maudience",
      "mbroadstd",
      "mcapturestorage",
      "mcolor",
      "mediaTypes",
      "mencformat",
      "menclvl",
      "mfiletype",
      "mfont",
      "mgeneration",
      "mgovtpubtype",
      "mgroove",
      "millus",
      "mlayout",
      "mmaterial",
      "mmusicformat",
      "mmusnotation",
      "mnotetype",
      "mplayback",
      "mplayspeed",
      "mpolarity",
      "mpresformat",
      "mproduction",
      "mprojection",
      "mrecmedium",
      "mrectype",
      "mreductionratio",
      "mregencoding",
      "mrelief",
      "mscale",
      "mscript",
      "mserialpubtype",
      "msoundcontent",
      "mspecplayback",
      "mstatus",
      "msupplcont",
      "mtactile",
      "mtapeconfig",
      "mtechnique",
      "mvidformat",
      "organizations",
      "preservation",
      "rbmscv",
      "rbmsrel",
      "relationship",
      "relators",
      "resourceComponents",
    ]
  end

  def datatypes
    ["edtf"]
  end

  def preservation # rubocop:disable Metrics/MethodLength
    [
      "contentLocationType",
      "copyrightStatus",
      "cryptographicHashFunctions",
      "environmentCharacteristic",
      "environmentPurpose",
      "eventRelatedAgentRole",
      "eventRelatedObjectRole",
      "eventType",
      "formatRegistryRole",
      "hardwareType",
      "inhibitorTarget",
      "inhibitorType",
      "objectCategory",
      "preservationLevelRole",
      "relationshipSubType",
      "relationshipType",
      "rightsBasis",
      "rightsRelatedAgentRole",
      "signatureEncoding",
      "signatureMethod",
      "softwareType",
      "storageMedium"
    ]
  end

  def rdftypes
    [
      "names_ConferenceName",
      "names_CorporateName",
      "names_FamilyName",
      "names_Geographic",
      "names_PersonalName"
    ]
  end

  private

    def vocab_base_url
      "cs%3Ahttp%3A%2F%2Fid.loc.gov%2Fvocabulary%2F"
    end

    def authority_base_url
      "cs%3Ahttp%3A%2F%2Fid.loc.gov%2Fauthorities%2F"
    end

    def datatype_base_url
      "cs%3Ahttp%3A%2F%2Fid.loc.gov%2Fdatatypes%2F"
    end

    def vocab_preservation_base_url
      "cs%3Ahttp%3A%2F%2Fid.loc.gov%2Fvocabulary%2Fpreservation%2F"
    end
end
