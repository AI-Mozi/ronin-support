# frozen_string_literal: true
#
# Copyright (c) 2006-2022 Hal Brodigan (postmodern.mod3 at gmail.com)
#
# ronin-support is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ronin-support is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public License
# along with ronin-support.  If not, see <https://www.gnu.org/licenses/>.
#

module Ronin
  module Support
    module Text
      #
      # @since 0.3.0
      #
      module Patterns
        # Regular expression for finding words
        #
        # @since 0.5.0
        WORD = /[A-Za-z][A-Za-z'\-\.]*[A-Za-z]/

        #
        # @group Numeric Patterns
        #
        
        # Regular expression for finding all numbers in text.
        #
        # @since 1.0.0
        NUMBER = /[0-9]+/

        # Regular expression for finding a decimal octet (0 - 255)
        #
        # @since 0.4.0
        DECIMAL_OCTET = /(?<=[^\d]|^)(?:25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]|[0-9])(?=[^\d]|$)/

        # Regular expression for finding all hexadecimal numbers in text.
        #
        # @since 1.0.0
        HEX_NUMBER = /(?:0x)?[0-9a-fA-F]+/

        # Regular expression for finding version numbers in text.
        #
        # @since 1.0.0
        VERSION_NUMBER = /(<=[^\d]|^)\d+(?:\.\d+){1,3}(?:[-.]?[A-Za-z]+(?:[-.]?\d+)?)?/

        #
        # @group Cryptography Patterns
        #

        # Regular expression for finding all MD5 hashes in text.
        #
        # @since 1.0.0
        MD5 = /(?<=[^0-9a-fA-F]|^)[0-9a-fA-F]{32}(?=[^0-9a-fA-F]|$)/

        # Regular expression for finding all SHA1 hashes in text.
        #
        # @since 1.0.0
        SHA1 = /(?<=[^0-9a-fA-F]|^)[0-9a-fA-F]{40}(?=[^0-9a-fA-F]|$)/

        # Regular expression for finding all SHA256 hashes in text.
        #
        # @since 1.0.0
        SHA256 = /(?<=[^0-9a-fA-F]|^)[0-9a-fA-F]{64}(?=[^0-9a-fA-F]|$)/

        # Regular expression for finding all SHA512 hashes in text.
        #
        # @since 1.0.0
        SHA512 = /(?<=[^0-9a-fA-F]|^)[0-9a-fA-F]{128}(?=[^0-9a-fA-F]|$)/

        # Regular expression for finding all hashes in text.
        #
        # @since 1.0.0
        HASH = /#{SHA512}|#{SHA256}|#{SHA1}|#{MD5}/

        # Regular expression for finding all public keys in text.
        #
        # @since 1.0.0
        PUBLIC_KEY = /-----BEGIN PUBLIC KEY-----\n(?:.+)\n-----END PUBLIC KEY-----/m

        # Regular expression for finding all SSH public keys in text.
        #
        # @since 1.0.0
        SSH_PUBLIC_KEY = /(?:ssh-(?:rsa|dss|ed25519(?:@openssh.com)?)|ecdsa-sha2-nistp(?:256|384|521)(?:@openssh.com)?) AAAA[A-Za-z0-9+\/]+[=]{0,3} [^@\s]+@[^@\s]+/

        #
        # @group Credential Patterns
        #

        # Regular expression for finding all SSH private keys in text.
        #
        # @since 1.0.0
        SSH_PRIVATE_KEY = /-----BEGIN OPENSSH PRIVATE KEY-----\n(?:.+)\n-----END OPENSSH PRIVATE KEY-----/m

        # Regular expression for finding all DSA private keys in text.
        #
        # @since 1.0.0
        DSA_PRIVATE_KEY = /-----BEGIN DSA PRIVATE KEY-----\n(?:.+)\n-----END DSA PRIVATE KEY-----/m

        # Regular expression for finding all EC private keys in text.
        #
        # @since 1.0.0
        EC_PRIVATE_KEY = /-----BEGIN EC PRIVATE KEY-----\n(?:.+)\n-----END EC PRIVATE KEY-----/m

        # Regular expression for finding all RSA private keys in text.
        #
        # @since 1.0.0
        RSA_PRIVATE_KEY = /-----BEGIN RSA PRIVATE KEY-----\n(?:.+)\n-----END RSA PRIVATE KEY-----/m

        # Regular expression for finding all private keys in text.
        #
        # @since 1.0.0
        PRIVATE_KEY = /#{RSA_PRIVATE_KEY}|#{DSA_PRIVATE_KEY}|#{EC_PRIVATE_KEY}/

        # Regular expression for finding all AWS access key IDs
        #
        # @since 1.0.0
        AWS_ACCESS_KEY_ID = /(?<=[^A-Z0-9]|^)[A-Z0-9]{20}(?=[^A-Z0-9]|$)/

        # Regular expression for finding all AWS secret access key 
        #
        # @since 1.0.0
        AWS_SECRET_ACCESS_KEY = /(?<=[^A-Za-z0-9\/+=]|^)[A-Za-z0-9\/+=]{40}(?=[^A-Za-z0-9\/+=]|$)/

        # Regular expression for finding all API keys (md5, sha1, sha256,
        # sha512, AWS access key ID or AWS secret access key).
        #
        # @since 1.0.0
        API_KEY = /#{HASH}|#{AWS_ACCESS_KEY_ID}|#{AWS_SECRET_ACCESS_KEY}/

        #
        # @group Networking Patterns
        #

        # Regular expression for finding MAC addresses in text
        #
        # @since 1.0.0
        MAC_ADDR = /[0-9a-fA-F]{2}(?::[0-9a-fA-F]{2}){5}/

        # A regular expression for matching IPv4 Addresses.
        #
        # @since 1.0.0
        IPV4_ADDR = /#{DECIMAL_OCTET}(?:\.#{DECIMAL_OCTET}){3}(?:\/\d{1,2})?/

        # A regular expression for matching IPv6 Addresses.
        #
        # @since 1.0.0
        IPV6_ADDR = Regexp.union(
          /(?:[0-9a-f]{1,4}:){6}#{IPV4_ADDR}/,
          /(?:[0-9a-f]{1,4}:){5}[0-9a-f]{1,4}:#{IPV4_ADDR}/,
          /(?:[0-9a-f]{1,4}:){5}:[0-9a-f]{1,4}:#{IPV4_ADDR}/,
          /(?:[0-9a-f]{1,4}:){1,1}(?::[0-9a-f]{1,4}){1,4}:#{IPV4_ADDR}/,
          /(?:[0-9a-f]{1,4}:){1,2}(?::[0-9a-f]{1,4}){1,3}:#{IPV4_ADDR}/,
          /(?:[0-9a-f]{1,4}:){1,3}(?::[0-9a-f]{1,4}){1,2}:#{IPV4_ADDR}/,
          /(?:[0-9a-f]{1,4}:){1,4}(?::[0-9a-f]{1,4}){1,1}:#{IPV4_ADDR}/,
          /:(?::[0-9a-f]{1,4}){1,5}:#{IPV4_ADDR}/,
          /(?:(?:[0-9a-f]{1,4}:){1,5}|:):#{IPV4_ADDR}/,
          /(?:[0-9a-f]{1,4}:){1,1}(?::[0-9a-f]{1,4}){1,6}(?:\/\d{1,3})?/,
          /(?:[0-9a-f]{1,4}:){1,2}(?::[0-9a-f]{1,4}){1,5}(?:\/\d{1,3})?/,
          /(?:[0-9a-f]{1,4}:){1,3}(?::[0-9a-f]{1,4}){1,4}(?:\/\d{1,3})?/,
          /(?:[0-9a-f]{1,4}:){1,4}(?::[0-9a-f]{1,4}){1,3}(?:\/\d{1,3})?/,
          /(?:[0-9a-f]{1,4}:){1,5}(?::[0-9a-f]{1,4}){1,2}(?:\/\d{1,3})?/,
          /(?:[0-9a-f]{1,4}:){1,6}(?::[0-9a-f]{1,4}){1,1}(?:\/\d{1,3})?/,
          /[0-9a-f]{1,4}(?::[0-9a-f]{1,4}){7}(?:\/\d{1,3})?/,
          /:(?::[0-9a-f]{1,4}){1,7}(?:\/\d{1,3})?/,
          /(?:(?:[0-9a-f]{1,4}:){1,7}|:):(?:\/\d{1,3})?/
        )

        # A regular expression for matching IP Addresses.
        #
        # @since 1.0.0
        IP_ADDR = /#{IPV4_ADDR}|#{IPV6_ADDR}/

        # @see IP_ADDR
        IP = IP_ADDR

        # Regular expression to match all domain public suffixes.
        #
        # @note
        #   This regex may be out of date since the [public suffix list] is
        #   updated on a monthly basis, but should still match the majority of
        #   valid TLDs.
        #
        # [public suffix list]: https://publicsuffix.org/
        #
        # @since 1.0.0
        PUBLIC_SUFFIX = /(?<=[^a-zA-Z0-9_-]|^)(?-mix:(?-mix:(?:(?-mix:com|edu|gov|net|mil|org|drr)\.)?ac)|(?-mix:(?:nom\.)?ad)|(?-mix:(?:(?-mix:co|net|org|sch|ac|gov|mil|blogspot)\.)?ae)|(?-mix:(?:(?-mix:accident\-investigation|accident\-prevention|aerobatic|aeroclub|aerodrome|agents|aircraft|airline|airport|air\-surveillance|airtraffic|air\-traffic\-control|ambulance|amusement|association|author|ballooning|broker|caa|cargo|catering|certification|championship|charter|civilaviation|club|conference|consultant|consulting|control|council|crew|design|dgca|educator|emergency|engine|engineer|entertainment|equipment|exchange|express|federation|flight|fuel|gliding|government|groundhandling|group|hanggliding|homebuilt|insurance|journal|journalist|leasing|logistics|magazine|maintenance|media|microlight|modelling|navigation|parachuting|paragliding|passenger\-association|pilot|press|production|recreation|repbody|res|research|rotorcraft|safety|scientist|services|show|skydiving|software|student|trader|trading|trainer|union|workinggroup|works)\.)?aero)|(?-mix:(?:(?-mix:gov|com|org|net|edu)\.)?af)|(?-mix:(?:(?-mix:com|org|net|co|nom)\.)?ag)|(?-mix:(?:(?-mix:off|com|net|org|uwu)\.)?ai)|(?-mix:(?:(?-mix:com|edu|gov|mil|net|org|blogspot)\.)?al)|(?-mix:(?:(?-mix:co|com|commune|net|org|radio|blogspot|neko|nyaa)\.)?am)|(?-mix:(?:(?-mix:ed|gv|og|co|pb|it)\.)?ao)|aq|(?-mix:(?:(?-mix:bet|(?-mix:(?:blogspot\.)?com)|coop|edu|gob|gov|int|mil|musica|mutual|net|org|senasa|tur)\.)?ar)|(?-mix:(?:(?-mix:e164|in\-addr|ip6|iris|uri|urn)\.)?arpa)|(?-mix:(?:gov\.)?as)|(?-mix:(?:cloudns\.)?asia)|(?-mix:(?:(?-mix:(?-mix:(?:sth\.)?ac)|(?-mix:(?:blogspot\.)?co)|gv|or|(?-mix:(?:wien\.)?funkfeuer)|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?ex)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?in))\.)?futurecms)|futurehosting|futuremailing|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?ex)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?kunden))\.)?ortsinfo)|biz|info|priv|myspreadshop|12hp|2ix|4lima|lima\-city)\.)?at)|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:blogspot|(?-mix:(?:mel\.)?cloudlets)|myspreadshop)\.)?com)|net|org|(?-mix:(?:(?-mix:act|catholic|(?-mix:(?:schools\.)?nsw)|nt|qld|sa|tas|vic|wa)\.)?edu)|(?-mix:(?:(?-mix:qld|sa|tas|vic|wa)\.)?gov)|asn|id|info|conf|oz|act|nsw|nt|qld|sa|tas|vic|wa)\.)?au)|(?-mix:(?:com\.)?aw)|(?-mix:(?:(?-mix:be|cat|es|eu|gg|mc|us|xy)\.)?ax)|(?-mix:(?:(?-mix:com|net|int|gov|org|edu|info|pp|mil|name|pro|biz)\.)?az)|(?-mix:(?:(?-mix:com|edu|gov|mil|net|org|rs|blogspot)\.)?ba)|(?-mix:(?:(?-mix:biz|co|com|edu|gov|info|net|org|store|tv)\.)?bb)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?bd)|(?-mix:(?:(?-mix:ac|webhosting|blogspot|(?-mix:(?:cloud\.)?interhostsolutions)|(?-mix:(?:ezproxy\.)?kuleuven)|myspreadshop|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?transurl))\.)?be)|(?-mix:(?:gov\.)?bf)|(?-mix:(?:(?-mix:a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z|0|1|2|3|4|5|6|7|8|9|blogspot|barsy)\.)?bg)|(?-mix:(?:(?-mix:com|edu|net|org|gov)\.)?bh)|(?-mix:(?:(?-mix:co|com|edu|or|org)\.)?bi)|(?-mix:(?:(?-mix:cloudns|jozi|dyndns|for\-better|for\-more|for\-some|for\-the|selfip|webhop|orx|mmafan|myftp|no\-ip|dscloud)\.)?biz)|(?-mix:(?:(?-mix:asso|barreau|gouv|blogspot)\.)?bj)|(?-mix:(?:(?-mix:com|edu|gov|net|org)\.)?bm)|(?-mix:(?:(?-mix:com|edu|gov|net|org|co)\.)?bn)|(?-mix:(?:(?-mix:com|edu|gob|int|org|net|mil|tv|web|academia|agro|arte|blog|bolivia|ciencia|cooperativa|democracia|deporte|ecologia|economia|empresa|indigena|industria|info|medicina|movimiento|musica|natural|nombre|noticias|patria|politica|profesional|plurinacional|pueblo|revista|salud|tecnologia|tksat|transporte|wiki)\.)?bo)|(?-mix:(?:(?-mix:9guacu|abc|adm|adv|agr|aju|am|anani|aparecida|app|arq|art|ato|b|barueri|belem|bhz|bib|bio|blog|bmd|boavista|bsb|campinagrande|campinas|caxias|cim|cng|cnt|(?-mix:(?:(?-mix:blogspot|(?-mix:(?:(?-mix:(?:users\.)?scale)\.)?virtualcloud))\.)?com)|contagem|coop|coz|cri|cuiaba|curitiba|def|des|det|dev|ecn|eco|edu|emp|enf|eng|esp|etc|eti|far|feira|flog|floripa|fm|fnd|fortal|fot|foz|fst|g12|geo|ggf|goiania|(?-mix:(?:(?-mix:ac|al|am|ap|ba|ce|df|es|go|ma|mg|ms|mt|pa|pb|pe|pi|pr|rj|rn|ro|rr|rs|sc|se|sp|to)\.)?gov)|gru|imb|ind|inf|jab|jampa|jdf|joinville|jor|jus|(?-mix:(?:(?-mix:ac|al|am|ap|ba|ce|df|es|go|ma|mg|ms|mt|pa|pb|pe|pi|pr|rj|rn|ro|rr|rs|sc|se|sp|to)\.)?leg)|lel|log|londrina|macapa|maceio|manaus|maringa|mat|med|mil|morena|mp|mus|natal|net|niteroi|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?nom)|not|ntr|odo|ong|org|osasco|palmas|poa|ppg|pro|psc|psi|pvh|qsl|radio|rec|recife|rep|ribeirao|rio|riobranco|riopreto|salvador|sampa|santamaria|santoandre|saobernardo|saogonca|seg|sjc|slg|slz|sorocaba|srv|taxi|tc|tec|teo|the|tmp|trd|tur|tv|udi|vet|vix|vlog|wiki|zlg)\.)?br)|(?-mix:(?:(?-mix:com|net|org|edu|gov|we)\.)?bs)|(?-mix:(?:(?-mix:com|edu|gov|net|org)\.)?bt)|bv|(?-mix:(?:(?-mix:co|org)\.)?bw)|(?-mix:(?:(?-mix:gov|mil|(?-mix:(?:blogspot\.)?com)|of|mycloud|mediatech)\.)?by)|(?-mix:(?:(?-mix:com|net|org|edu|gov|za|gsj)\.)?bz)|(?-mix:(?:(?-mix:ab|bc|mb|nb|nf|nl|ns|nt|nu|on|pe|qc|sk|yk|gc|barsy|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?awdev)|co|blogspot|no\-ip|myspreadshop)\.)?ca)|cat|(?-mix:(?:(?-mix:cloudns|ftpaccess|game\-server|myphotos|scrapping|twmail|csx|fantasyleague|(?-mix:(?:instances\.)?spawn))\.)?cc)|(?-mix:(?:gov\.)?cd)|(?-mix:(?:blogspot\.)?cf)|cg|(?-mix:(?:(?-mix:square7|blogspot|(?-mix:(?:(?-mix:(?-mix:(?:alp1\.)?ae)|appengine)\.)?flow)|linkyard\-cloud|dnsking|gotdns|myspreadshop|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?svc))\.)?firenet)|12hp|2ix|4lima|lima\-city)\.)?ch)|(?-mix:(?:(?-mix:org|or|com|co|edu|ed|ac|net|go|asso|aéroport|int|presse|md|gouv|fin|nl)\.)?ci)|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|!www)\.)?ck)|(?-mix:(?:(?-mix:co|gob|gov|mil|blogspot)\.)?cl)|(?-mix:(?:(?-mix:co|com|gov|net)\.)?cm)|(?-mix:(?:(?-mix:ac|(?-mix:(?:(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?compute)|(?-mix:(?:(?-mix:cn\-north\-1|cn\-northwest\-1)\.)?eb)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?elb)|(?-mix:(?:s3\.)?cn-north-1))\.)?amazonaws)\.)?com)|edu|gov|net|org|mil|公司|网络|網絡|ah|bj|cq|fj|gd|gs|gz|gx|ha|hb|he|hi|hl|hn|jl|js|jx|ln|nm|nx|qh|sc|sd|sh|sn|sx|tj|xj|xz|yn|zj|hk|mo|tw|instantcloud|(?-mix:(?:direct\.)?quickconnect))\.)?cn)|(?-mix:(?:(?-mix:arts|(?-mix:(?:blogspot\.)?com)|edu|firm|gov|info|int|mil|net|nom|org|rec|web|carrd|crd|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?otap)|leadpages|lpages|mypi|n4t|(?-mix:(?:id\.)?repl)|supabase)\.)?co)|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?devcdnaccesso)|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?dev)\.)?adobeaemcloud)|airkitapps|airkitapps\-au|aivencloud|kasserver|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?compute)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?compute-1)|(?-mix:(?:(?-mix:(?:s3\.)?dualstack)\.)?us-east-1)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?elb)|s3|s3\-ap\-northeast\-1|s3\-ap\-northeast\-2|s3\-ap\-south\-1|s3\-ap\-southeast\-1|s3\-ap\-southeast\-2|s3\-ca\-central\-1|s3\-eu\-central\-1|s3\-eu\-west\-1|s3\-eu\-west\-2|s3\-eu\-west\-3|s3\-external\-1|s3\-fips\-us\-gov\-west\-1|s3\-sa\-east\-1|s3\-us\-gov\-west\-1|s3\-us\-east\-2|s3\-us\-west\-1|s3\-us\-west\-2|(?-mix:(?:(?-mix:s3|(?-mix:(?:s3\.)?dualstack)|s3\-website)\.)?ap-northeast-2)|(?-mix:(?:(?-mix:s3|(?-mix:(?:s3\.)?dualstack)|s3\-website)\.)?ap-south-1)|(?-mix:(?:(?-mix:s3|(?-mix:(?:s3\.)?dualstack)|s3\-website)\.)?ca-central-1)|(?-mix:(?:(?-mix:s3|(?-mix:(?:s3\.)?dualstack)|s3\-website)\.)?eu-central-1)|(?-mix:(?:(?-mix:s3|(?-mix:(?:s3\.)?dualstack)|s3\-website)\.)?eu-west-2)|(?-mix:(?:(?-mix:s3|(?-mix:(?:s3\.)?dualstack)|s3\-website)\.)?eu-west-3)|(?-mix:(?:(?-mix:s3|(?-mix:(?:s3\.)?dualstack)|s3\-website)\.)?us-east-2)|(?-mix:(?:(?-mix:(?:s3\.)?dualstack)\.)?ap-northeast-1)|(?-mix:(?:(?-mix:(?:s3\.)?dualstack)\.)?ap-southeast-1)|(?-mix:(?:(?-mix:(?:s3\.)?dualstack)\.)?ap-southeast-2)|(?-mix:(?:(?-mix:(?:s3\.)?dualstack)\.)?eu-west-1)|(?-mix:(?:(?-mix:(?:s3\.)?dualstack)\.)?sa-east-1)|s3\-website\-us\-east\-1|s3\-website\-us\-west\-1|s3\-website\-us\-west\-2|s3\-website\-ap\-northeast\-1|s3\-website\-ap\-southeast\-1|s3\-website\-ap\-southeast\-2|s3\-website\-eu\-west\-1|s3\-website\-sa\-east\-1)\.)?amazonaws)|(?-mix:(?:(?-mix:ap\-northeast\-1|ap\-northeast\-2|ap\-northeast\-3|ap\-south\-1|ap\-southeast\-1|ap\-southeast\-2|ca\-central\-1|eu\-central\-1|eu\-west\-1|eu\-west\-2|eu\-west\-3|sa\-east\-1|us\-east\-1|us\-east\-2|us\-gov\-west\-1|us\-west\-1|us\-west\-2)\.)?elasticbeanstalk)|awsglobalaccelerator|siiites|appspacehosted|appspaceusercontent|on\-aptible|myasustor|balena\-devices|betainabox|boutir|bplaced|cafjs|br|cn|de|eu|jpn|mex|ru|sa|uk|us|za|ar|hu|kr|no|qc|uy|africa|gr|co|jdevcloud|wpdevcloud|cloudcontrolled|cloudcontrolapp|trycloudflare|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?oci)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?ocp)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?ocs))\.)?customer-oci)|dattolocal|dattorelay|dattoweb|mydatto|builtwithdark|(?-mix:(?:(?-mix:demo|instance)\.)?datadetect)|ddns5|discordsays|discordsez|drayddns|dreamhosters|mydrobo|dyndns\-at\-home|dyndns\-at\-work|dyndns\-blog|dyndns\-free|dyndns\-home|dyndns\-ip|dyndns\-mail|dyndns\-office|dyndns\-pics|dyndns\-remote|dyndns\-server|dyndns\-web|dyndns\-wiki|dyndns\-work|blogdns|cechire|dnsalias|dnsdojo|doesntexist|dontexist|doomdns|dyn\-o\-saur|dynalias|est\-a\-la\-maison|est\-a\-la\-masion|est\-le\-patron|est\-mon\-blogueur|from\-ak|from\-al|from\-ar|from\-ca|from\-ct|from\-dc|from\-de|from\-fl|from\-ga|from\-hi|from\-ia|from\-id|from\-il|from\-in|from\-ks|from\-ky|from\-ma|from\-md|from\-mi|from\-mn|from\-mo|from\-ms|from\-mt|from\-nc|from\-nd|from\-ne|from\-nh|from\-nj|from\-nm|from\-nv|from\-oh|from\-ok|from\-or|from\-pa|from\-pr|from\-ri|from\-sc|from\-sd|from\-tn|from\-tx|from\-ut|from\-va|from\-vt|from\-wa|from\-wi|from\-wv|from\-wy|getmyip|gotdns|hobby\-site|homelinux|homeunix|iamallama|is\-a\-anarchist|is\-a\-blogger|is\-a\-bookkeeper|is\-a\-bulls\-fan|is\-a\-caterer|is\-a\-chef|is\-a\-conservative|is\-a\-cpa|is\-a\-cubicle\-slave|is\-a\-democrat|is\-a\-designer|is\-a\-doctor|is\-a\-financialadvisor|is\-a\-geek|is\-a\-green|is\-a\-guru|is\-a\-hard\-worker|is\-a\-hunter|is\-a\-landscaper|is\-a\-lawyer|is\-a\-liberal|is\-a\-libertarian|is\-a\-llama|is\-a\-musician|is\-a\-nascarfan|is\-a\-nurse|is\-a\-painter|is\-a\-personaltrainer|is\-a\-photographer|is\-a\-player|is\-a\-republican|is\-a\-rockstar|is\-a\-socialist|is\-a\-student|is\-a\-teacher|is\-a\-techie|is\-a\-therapist|is\-an\-accountant|is\-an\-actor|is\-an\-actress|is\-an\-anarchist|is\-an\-artist|is\-an\-engineer|is\-an\-entertainer|is\-certified|is\-gone|is\-into\-anime|is\-into\-cars|is\-into\-cartoons|is\-into\-games|is\-leet|is\-not\-certified|is\-slick|is\-uberleet|is\-with\-theband|isa\-geek|isa\-hockeynut|issmarterthanyou|likes\-pie|likescandy|neat\-url|saves\-the\-whales|selfip|sells\-for\-less|sells\-for\-u|servebbs|simple\-url|space\-to\-rent|teaches\-yoga|writesthisblog|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?digitaloceanspaces)|ddnsfree|ddnsgeek|giize|gleeze|kozow|loseyourip|ooguy|theworkpc|mytuleap|tuleap\-partners|encoreapi|(?-mix:(?:(?-mix:eu\-1|eu\-2|eu\-3|eu\-4|us\-1|us\-2|us\-3|us\-4)\.)?evennode)|onfabrica|(?-mix:(?:apps\.)?fbsbx)|fastly\-terrarium|fastvps\-server|mydobiss|firebaseapp|fldrv|forgeblocks|framercanvas|freebox\-os|freeboxos|freemyip|gentapps|gentlentapis|githubusercontent|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?0emm)|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?r)\.)?appspot)|codespot|googleapis|googlecode|pagespeedmobilizer|publishproxy|withgoogle|withyoutube|blogspot|awsmppl|herokuapp|herokussl|myravendb|impertrixcdn|impertrix|smushcdn|wphostedmail|wpmucdn|pixolino|amscompute|clicketcloud|dopaas|hidora|(?-mix:(?:paas\.)?hosted-by-previder)|(?-mix:(?:(?-mix:rag\-cloud|rag\-cloud\-ch)\.)?hosteur)|(?-mix:(?:(?-mix:jcloud|jcloud\-ver\-jpc)\.)?ik-server)|(?-mix:(?:demo\.)?jelastic)|kilatiron|(?-mix:(?:paas\.)?massivegrid)|(?-mix:(?:(?-mix:jed|lon|ryd)\.)?wafaicloud)|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?cns)\.)?joyent)|ktistory|lpusercontent|(?-mix:(?:app\.)?lmpm)|(?-mix:(?:(?-mix:members|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?nodebalancer))\.)?linode)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?linodeobjects)|(?-mix:(?:ip\.)?linodeusercontent)|barsycenter|barsyonline|mazeplay|miniserver|(?-mix:(?:eu\.)?meteorapp)|hostedpi|(?-mix:(?:(?-mix:customer|caracal|fentiger|lynx|ocelot|oncilla|onza|sphinx|vs|x|yali)\.)?mythic-beasts)|(?-mix:(?:cloud\.)?nospamproxy)|4u|nfshost|001www|ddnslive|myiphost|blogsyte|ciscofreak|damnserver|ditchyourip|dnsiskinky|dynns|geekgalaxy|health\-carereform|homesecuritymac|homesecuritypc|myactivedirectory|mysecuritycamera|net\-freaks|onthewifi|point2this|quicksytes|securitytactics|serveexchange|servehumour|servep2p|servesarcasm|stufftoread|unusualperson|workisboring|3utilities|ddnsking|myvnc|servebeer|servecounterstrike|serveftp|servegame|servehalflife|servehttp|serveirc|servemp3|servepics|servequake|(?-mix:(?:static\.)?observableusercontent)|orsites|operaunite|authgear\-staging|authgearapps|skygearapp|outsystemscloud|ownprovider|pgfog|pagefrontapp|pagexl|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?paywhirl)|gotpantheon|platter\-app|pleskns|postman\-echo|(?-mix:(?:xen\.)?prgmr)|(?-mix:(?:eu\.)?pythonanywhere)|qualifioapp|qbuser|qa2|dev\-myqnapcloud|alpha\-myqnapcloud|myqnapcloud|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?quipelements)|rackmaze|rhcloud|(?-mix:(?:app\.)?render)|onrender|(?-mix:(?:(?-mix:builder|dev\-builder|stg\-builder)\.)?code)|logoip|scrysec|firewall\-gateway|myshopblocks|myshopify|shopitsite|1kapp|appchizi|applinzi|sinaapp|vipsinaapp|(?-mix:(?:(?-mix:alpha|beta)\.)?bounty-full)|try\-snowplow|stackhero\-network|playstation\-cloud|myspreadshop|(?-mix:(?:api\.)?stdlib)|temp\-dns|dsmynas|familyds|(?-mix:(?:site\.)?tb-hosting)|reservd|thingdustdata|bloxcms|townnews\-staging|(?-mix:(?:pro\.)?typeform)|hk|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?vultrobjects)|wafflecell|reserve\-online|hotelwithflight|remotewd|(?-mix:(?:pages\.)?wiardweb)|messwithdns|woltlab\-demo|(?-mix:(?:js\.)?wpenginepowered)|wixsite|(?-mix:(?:(?-mix:u2|u2\-local)\.)?xnbay)|yolasite)\.)?com)|coop|(?-mix:(?:(?-mix:ac|co|ed|fi|go|or|sa)\.)?cr)|(?-mix:(?:(?-mix:com|edu|org|net|gov|inf)\.)?cu)|(?-mix:(?:(?-mix:com|edu|int|nome|org|blogspot)\.)?cv)|(?-mix:(?:(?-mix:com|edu|net|org)\.)?cw)|(?-mix:(?:(?-mix:gov|ath|info)\.)?cx)|(?-mix:(?:(?-mix:ac|biz|(?-mix:(?:(?-mix:blogspot|(?-mix:(?:j\.)?scaleforce))\.)?com)|ekloges|gov|ltd|mil|net|org|press|pro|tm)\.)?cy)|(?-mix:(?:(?-mix:co|realm|e4|blogspot|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?cloud)|custom)\.)?metacentrum)|(?-mix:(?:(?-mix:(?:(?-mix:flt|usr)\.)?cloud)\.)?muni))\.)?cz)|(?-mix:(?:(?-mix:bplaced|square7|com|(?-mix:(?:dyn\.)?cosidns)|dynamisches\-dns|dnsupdater|internet\-dns|l\-o\-g\-i\-n|dnshome|fuettertdasnetz|isteingeek|istmein|lebtimnetz|leitungsen|traeumtgerade|(?-mix:(?:(?-mix:dyn|dyndns)\.)?ddnss)|dyndns1|dyn\-ip24|(?-mix:(?:dyn\.)?home-webserver)|myhome\-server|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?frusky)|goip|blogspot|günstigbestellen|günstigliefern|(?-mix:(?:(?-mix:(?:pages\.)?it)\.)?hs-heilbronn)|dyn\-berlin|in\-berlin|in\-brb|in\-butter|in\-dsl|in\-vpn|mein\-iserv|schulserver|test\-iserv|keymachine|git\-repos|lcube\-server|svn\-repos|barsy|logoip|firewall\-gateway|my\-gateway|my\-router|spdns|(?-mix:(?:customer\.)?speedpartner)|myspreadshop|taifun\-dns|12hp|2ix|4lima|lima\-city|dd\-dns|dray\-dns|draydns|dyn\-vpn|dynvpn|mein\-vigor|my\-vigor|my\-wan|syno\-ds|synology\-diskstation|synology\-ds|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?uberspace)|virtualuser|virtual\-user|community\-pro|diskussionsbereich)\.)?de)|dj|(?-mix:(?:(?-mix:biz|co|firm|reg|store|blogspot|myspreadshop)\.)?dk)|(?-mix:(?:(?-mix:com|net|org|edu|gov)\.)?dm)|(?-mix:(?:(?-mix:art|com|edu|gob|gov|mil|net|org|sld|web)\.)?do)|(?-mix:(?:(?-mix:art|asso|com|edu|gov|org|net|pol|soc|tm)\.)?dz)|(?-mix:(?:(?-mix:com|info|net|fin|k12|med|pro|org|edu|gov|gob|mil|base|official)\.)?ec)|(?-mix:(?:(?-mix:(?:git-pages\.)?rit)\.)?edu)|(?-mix:(?:(?-mix:edu|gov|riik|lib|med|(?-mix:(?:blogspot\.)?com)|pri|aip|org|fie)\.)?ee)|(?-mix:(?:(?-mix:(?-mix:(?:blogspot\.)?com)|edu|eun|gov|mil|name|net|org|sci)\.)?eg)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?er)|(?-mix:(?:(?-mix:(?-mix:(?:blogspot\.)?com)|nom|org|gob|edu|myspreadshop)\.)?es)|(?-mix:(?:(?-mix:com|gov|org|edu|biz|name|info|net)\.)?et)|(?-mix:(?:(?-mix:airkitapps|mycd|cloudns|(?-mix:(?:jelastic\.)?dogado)|barsy|wellbeingzone|spdns|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?transurl)|diskstation)\.)?eu)|(?-mix:(?:(?-mix:aland|dy|blogspot|häkkinen|iki|(?-mix:(?:fi\.)?cloudplatform)|(?-mix:(?:(?-mix:demo|paas)\.)?datacenter)|kapsi|myspreadshop)\.)?fi)|(?-mix:(?:(?-mix:ac|biz|com|gov|info|mil|name|net|org|pro)\.)?fj)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?fk)|(?-mix:(?:(?-mix:com|edu|net|org|radio)\.)?fm)|fo|(?-mix:(?:(?-mix:asso|com|gouv|nom|prd|tm|aeroport|avocat|avoues|cci|chambagri|chirurgiens\-dentistes|experts\-comptables|geometre\-expert|greta|huissier\-justice|medecin|notaires|pharmacien|port|veterinaire|en\-root|fbx\-os|fbxos|freebox\-os|freeboxos|blogspot|goupile|on\-web|chirurgiens\-dentistes\-en\-france|dedibox|myspreadshop|ynh)\.)?fr)|ga|gb|(?-mix:(?:(?-mix:edu|gov)\.)?gd)|(?-mix:(?:(?-mix:com|edu|gov|org|mil|net|pvt)\.)?ge)|gf|(?-mix:(?:(?-mix:co|net|org|kaas|cya|(?-mix:(?:daemon\.)?panel))\.)?gg)|(?-mix:(?:(?-mix:com|edu|gov|org|mil)\.)?gh)|(?-mix:(?:(?-mix:com|ltd|gov|mod|edu|org)\.)?gi)|(?-mix:(?:(?-mix:co|com|edu|net|org|biz|xx)\.)?gl)|gm|(?-mix:(?:(?-mix:ac|com|edu|gov|org|net)\.)?gn)|gov|(?-mix:(?:(?-mix:com|net|mobi|edu|org|asso|app)\.)?gp)|gq|(?-mix:(?:(?-mix:com|edu|net|org|gov|blogspot)\.)?gr)|gs|(?-mix:(?:(?-mix:com|edu|gob|ind|mil|net|org|blog|de|to)\.)?gt)|(?-mix:(?:(?-mix:com|edu|gov|guam|info|net|org|web)\.)?gu)|gw|(?-mix:(?:(?-mix:co|com|edu|gov|net|org|be)\.)?gy)|(?-mix:(?:(?-mix:com|edu|gov|idv|net|org|公司|教育|敎育|政府|個人|个人|箇人|網络|网络|组織|網絡|网絡|组织|組織|組织|blogspot|secaas|ltd|inc)\.)?hk)|hm|(?-mix:(?:(?-mix:com|edu|org|net|mil|gob|cc)\.)?hn)|(?-mix:(?:(?-mix:iz|from|name|com|blogspot|free)\.)?hr)|(?-mix:(?:(?-mix:com|shop|firm|info|adult|net|pro|org|med|art|coop|pol|asso|edu|rel|gouv|perso)\.)?ht)|(?-mix:(?:(?-mix:co|info|org|priv|sport|tm|2000|agrar|bolt|casino|city|erotica|erotika|film|forum|games|hotel|ingatlan|jogasz|konyvelo|lakas|media|news|reklam|sex|shop|suli|szex|tozsde|utazas|video|blogspot)\.)?hu)|(?-mix:(?:(?-mix:ac|biz|(?-mix:(?:blogspot\.)?co)|desa|go|mil|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?rss)\.)?my)|net|or|ponpes|sch|web|flap|forte)\.)?id)|(?-mix:(?:(?-mix:gov|blogspot|myspreadshop)\.)?ie)|(?-mix:(?:(?-mix:ac|(?-mix:(?:(?-mix:ravpage|blogspot|tabitorder)\.)?co)|gov|idf|k12|muni|net|org)\.)?il)|(?-mix:(?:(?-mix:ac|(?-mix:(?:(?-mix:ltd|plc)\.)?co)|com|net|org|tt|tv|ro)\.)?im)|(?-mix:(?:(?-mix:co|firm|net|org|gen|ind|nic|ac|edu|res|gov|mil|web|cloudns|blogspot|barsy|supabase)\.)?in)|(?-mix:(?:(?-mix:cloudns|dynamic\-dns|dyndns|barrel\-of\-knowledge|barrell\-of\-knowledge|for\-our|groks\-the|groks\-this|here\-for\-more|knowsitall|selfip|webhop|barsy|mayfirst|forumz|nsupdate|dvrcam|ilovecollege|no\-ip|dnsupdate|v\-info)\.)?info)|(?-mix:(?:eu\.)?int)|(?-mix:(?:(?-mix:com|apigee|b\-data|backplaneapp|(?-mix:(?:(?-mix:app|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?backyards))\.)?banzaicloud)|bitbucket|bluebite|boxfuse|browsersafetymark|(?-mix:(?:uk0\.)?bigv)|cleverapps|(?-mix:(?:dyndns\.)?dappnode)|dedyn|drud|definima|fh\-muenster|shw|(?-mix:(?:id\.)?forgerock)|ghost|github|gitlab|lolipop|hasura\-app|hostyhosting|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?moonscale)|(?-mix:(?:paas\.)?beebyte)|(?-mix:(?:sekd1\.)?beebyteapp)|jele|(?-mix:(?:cloud-fr1\.)?unispace)|webthings|loginline|barsy|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?azurecontainer)|ngrok|(?-mix:(?:stage\.)?nodeart)|nid|pantheonsite|dyn53|(?-mix:(?:mock\.)?pstmn)|protonet|qoto|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?sys)\.)?qcx)|vaporcloud|(?-mix:(?:g\.)?vbrplsbx)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?on-k3s)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?on-rio)|readthedocs|resindevice|(?-mix:(?:devices\.)?resinstaging)|hzc|sandcats|shiftcrypto|shiftedit|mo\-siemens|musician|(?-mix:(?:apps\.)?lair)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?stolos)|spacekit|utwente|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?s5y)|edugit|telebit|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:cust|reservd)\.)?dev)|(?-mix:(?:(?-mix:cust|reservd)\.)?disrec)|(?-mix:(?:cust\.)?prod)|(?-mix:(?:(?-mix:cust|reservd)\.)?testing))\.)?thingdust)|tickets|upli|2038|wedeploy|editorx|basicserver|virtualserver)\.)?io)|(?-mix:(?:(?-mix:gov|edu|mil|com|org|net)\.)?iq)|(?-mix:(?:(?-mix:ac|co|gov|id|net|org|sch|ایران|ايران)\.)?ir)|(?-mix:(?:(?-mix:net|com|edu|gov|org|int|cupcake|blogspot)\.)?is)|(?-mix:(?:(?-mix:gov|edu|abr|abruzzo|aosta\-valley|aostavalley|bas|basilicata|cal|calabria|cam|campania|emilia\-romagna|emiliaromagna|emr|friuli\-v\-giulia|friuli\-ve\-giulia|friuli\-vegiulia|friuli\-venezia\-giulia|friuli\-veneziagiulia|friuli\-vgiulia|friuliv\-giulia|friulive\-giulia|friulivegiulia|friulivenezia\-giulia|friuliveneziagiulia|friulivgiulia|fvg|laz|lazio|lig|liguria|lom|lombardia|lombardy|lucania|mar|marche|mol|molise|piedmont|piemonte|pmn|pug|puglia|sar|sardegna|sardinia|sic|sicilia|sicily|taa|tos|toscana|trentin\-sud\-tirol|trentin\-süd\-tirol|trentin\-sudtirol|trentin\-südtirol|trentin\-sued\-tirol|trentin\-suedtirol|trentino\-a\-adige|trentino\-aadige|trentino\-alto\-adige|trentino\-altoadige|trentino\-s\-tirol|trentino\-stirol|trentino\-sud\-tirol|trentino\-süd\-tirol|trentino\-sudtirol|trentino\-südtirol|trentino\-sued\-tirol|trentino\-suedtirol|trentino|trentinoa\-adige|trentinoaadige|trentinoalto\-adige|trentinoaltoadige|trentinos\-tirol|trentinostirol|trentinosud\-tirol|trentinosüd\-tirol|trentinosudtirol|trentinosüdtirol|trentinosued\-tirol|trentinosuedtirol|trentinsud\-tirol|trentinsüd\-tirol|trentinsudtirol|trentinsüdtirol|trentinsued\-tirol|trentinsuedtirol|tuscany|umb|umbria|val\-d\-aosta|val\-daosta|vald\-aosta|valdaosta|valle\-aosta|valle\-d\-aosta|valle\-daosta|valleaosta|valled\-aosta|valledaosta|vallee\-aoste|vallée\-aoste|vallee\-d\-aoste|vallée\-d\-aoste|valleeaoste|valléeaoste|valleedaoste|valléedaoste|vao|vda|ven|veneto|ag|agrigento|al|alessandria|alto\-adige|altoadige|an|ancona|andria\-barletta\-trani|andria\-trani\-barletta|andriabarlettatrani|andriatranibarletta|ao|aosta|aoste|ap|aq|aquila|ar|arezzo|ascoli\-piceno|ascolipiceno|asti|at|av|avellino|ba|balsan\-sudtirol|balsan\-südtirol|balsan\-suedtirol|balsan|bari|barletta\-trani\-andria|barlettatraniandria|belluno|benevento|bergamo|bg|bi|biella|bl|bn|bo|bologna|bolzano\-altoadige|bolzano|bozen\-sudtirol|bozen\-südtirol|bozen\-suedtirol|bozen|br|brescia|brindisi|bs|bt|bulsan\-sudtirol|bulsan\-südtirol|bulsan\-suedtirol|bulsan|bz|ca|cagliari|caltanissetta|campidano\-medio|campidanomedio|campobasso|carbonia\-iglesias|carboniaiglesias|carrara\-massa|carraramassa|caserta|catania|catanzaro|cb|ce|cesena\-forli|cesena\-forlì|cesenaforli|cesenaforlì|ch|chieti|ci|cl|cn|co|como|cosenza|cr|cremona|crotone|cs|ct|cuneo|cz|dell\-ogliastra|dellogliastra|en|enna|fc|fe|fermo|ferrara|fg|fi|firenze|florence|fm|foggia|forli\-cesena|forlì\-cesena|forlicesena|forlìcesena|fr|frosinone|ge|genoa|genova|go|gorizia|gr|grosseto|iglesias\-carbonia|iglesiascarbonia|im|imperia|is|isernia|kr|la\-spezia|laquila|laspezia|latina|lc|le|lecce|lecco|li|livorno|lo|lodi|lt|lu|lucca|macerata|mantova|massa\-carrara|massacarrara|matera|mb|mc|me|medio\-campidano|mediocampidano|messina|mi|milan|milano|mn|mo|modena|monza\-brianza|monza\-e\-della\-brianza|monza|monzabrianza|monzaebrianza|monzaedellabrianza|ms|mt|na|naples|napoli|no|novara|nu|nuoro|og|ogliastra|olbia\-tempio|olbiatempio|or|oristano|ot|pa|padova|padua|palermo|parma|pavia|pc|pd|pe|perugia|pesaro\-urbino|pesarourbino|pescara|pg|pi|piacenza|pisa|pistoia|pn|po|pordenone|potenza|pr|prato|pt|pu|pv|pz|ra|ragusa|ravenna|rc|re|reggio\-calabria|reggio\-emilia|reggiocalabria|reggioemilia|rg|ri|rieti|rimini|rm|rn|ro|roma|rome|rovigo|sa|salerno|sassari|savona|si|siena|siracusa|so|sondrio|sp|sr|ss|suedtirol|südtirol|sv|ta|taranto|te|tempio\-olbia|tempioolbia|teramo|terni|tn|to|torino|tp|tr|trani\-andria\-barletta|trani\-barletta\-andria|traniandriabarletta|tranibarlettaandria|trapani|trento|treviso|trieste|ts|turin|tv|ud|udine|urbino\-pesaro|urbinopesaro|va|varese|vb|vc|ve|venezia|venice|verbania|vercelli|verona|vi|vibo\-valentia|vibovalentia|vicenza|viterbo|vr|vs|vt|vv|blogspot|(?-mix:(?:jc\.)?neen)|(?-mix:(?:(?-mix:(?:(?-mix:(?:cloud\.)?jelastic)\.)?open)\.)?tim)|16\-b|32\-b|64\-b|myspreadshop|syncloud)\.)?it)|(?-mix:(?:(?-mix:co|net|org|of)\.)?je)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?jm)|(?-mix:(?:(?-mix:com|org|net|edu|sch|gov|mil|name)\.)?jo)|jobs|(?-mix:(?:(?-mix:ac|ad|co|ed|go|gr|lg|(?-mix:(?:(?-mix:(?-mix:(?:user\.)?aseinet)|gehirn)\.)?ne)|or|(?-mix:(?:(?-mix:aisai|ama|anjo|asuke|chiryu|chita|fuso|gamagori|handa|hazu|hekinan|higashiura|ichinomiya|inazawa|inuyama|isshiki|iwakura|kanie|kariya|kasugai|kira|kiyosu|komaki|konan|kota|mihama|miyoshi|nishio|nisshin|obu|oguchi|oharu|okazaki|owariasahi|seto|shikatsu|shinshiro|shitara|tahara|takahama|tobishima|toei|togo|tokai|tokoname|toyoake|toyohashi|toyokawa|toyone|toyota|tsushima|yatomi)\.)?aichi)|(?-mix:(?:(?-mix:akita|daisen|fujisato|gojome|hachirogata|happou|higashinaruse|honjo|honjyo|ikawa|kamikoani|kamioka|katagami|kazuno|kitaakita|kosaka|kyowa|misato|mitane|moriyoshi|nikaho|noshiro|odate|oga|ogata|semboku|yokote|yurihonjo)\.)?akita)|(?-mix:(?:(?-mix:aomori|gonohe|hachinohe|hashikami|hiranai|hirosaki|itayanagi|kuroishi|misawa|mutsu|nakadomari|noheji|oirase|owani|rokunohe|sannohe|shichinohe|shingo|takko|towada|tsugaru|tsuruta)\.)?aomori)|(?-mix:(?:(?-mix:abiko|asahi|chonan|chosei|choshi|chuo|funabashi|futtsu|hanamigawa|ichihara|ichikawa|ichinomiya|inzai|isumi|kamagaya|kamogawa|kashiwa|katori|katsuura|kimitsu|kisarazu|kozaki|kujukuri|kyonan|matsudo|midori|mihama|minamiboso|mobara|mutsuzawa|nagara|nagareyama|narashino|narita|noda|oamishirasato|omigawa|onjuku|otaki|sakae|sakura|shimofusa|shirako|shiroi|shisui|sodegaura|sosa|tako|tateyama|togane|tohnosho|tomisato|urayasu|yachimata|yachiyo|yokaichiba|yokoshibahikari|yotsukaido)\.)?chiba)|(?-mix:(?:(?-mix:ainan|honai|ikata|imabari|iyo|kamijima|kihoku|kumakogen|masaki|matsuno|matsuyama|namikata|niihama|ozu|saijo|seiyo|shikokuchuo|tobe|toon|uchiko|uwajima|yawatahama)\.)?ehime)|(?-mix:(?:(?-mix:echizen|eiheiji|fukui|ikeda|katsuyama|mihama|minamiechizen|obama|ohi|ono|sabae|sakai|takahama|tsuruga|wakasa)\.)?fukui)|(?-mix:(?:(?-mix:ashiya|buzen|chikugo|chikuho|chikujo|chikushino|chikuzen|chuo|dazaifu|fukuchi|hakata|higashi|hirokawa|hisayama|iizuka|inatsuki|kaho|kasuga|kasuya|kawara|keisen|koga|kurate|kurogi|kurume|minami|miyako|miyama|miyawaka|mizumaki|munakata|nakagawa|nakama|nishi|nogata|ogori|okagaki|okawa|oki|omuta|onga|onojo|oto|saigawa|sasaguri|shingu|shinyoshitomi|shonai|soeda|sue|tachiarai|tagawa|takata|toho|toyotsu|tsuiki|ukiha|umi|usui|yamada|yame|yanagawa|yukuhashi)\.)?fukuoka)|(?-mix:(?:(?-mix:aizubange|aizumisato|aizuwakamatsu|asakawa|bandai|date|fukushima|furudono|futaba|hanawa|higashi|hirata|hirono|iitate|inawashiro|ishikawa|iwaki|izumizaki|kagamiishi|kaneyama|kawamata|kitakata|kitashiobara|koori|koriyama|kunimi|miharu|mishima|namie|nango|nishiaizu|nishigo|okuma|omotego|ono|otama|samegawa|shimogo|shirakawa|showa|soma|sukagawa|taishin|tamakawa|tanagura|tenei|yabuki|yamato|yamatsuri|yanaizu|yugawa)\.)?fukushima)|(?-mix:(?:(?-mix:anpachi|ena|gifu|ginan|godo|gujo|hashima|hichiso|hida|higashishirakawa|ibigawa|ikeda|kakamigahara|kani|kasahara|kasamatsu|kawaue|kitagata|mino|minokamo|mitake|mizunami|motosu|nakatsugawa|ogaki|sakahogi|seki|sekigahara|shirakawa|tajimi|takayama|tarui|toki|tomika|wanouchi|yamagata|yaotsu|yoro)\.)?gifu)|(?-mix:(?:(?-mix:annaka|chiyoda|fujioka|higashiagatsuma|isesaki|itakura|kanna|kanra|katashina|kawaba|kiryu|kusatsu|maebashi|meiwa|midori|minakami|naganohara|nakanojo|nanmoku|numata|oizumi|ora|ota|shibukawa|shimonita|shinto|showa|takasaki|takayama|tamamura|tatebayashi|tomioka|tsukiyono|tsumagoi|ueno|yoshioka)\.)?gunma)|(?-mix:(?:(?-mix:asaminami|daiwa|etajima|fuchu|fukuyama|hatsukaichi|higashihiroshima|hongo|jinsekikogen|kaita|kui|kumano|kure|mihara|miyoshi|naka|onomichi|osakikamijima|otake|saka|sera|seranishi|shinichi|shobara|takehara)\.)?hiroshima)|(?-mix:(?:(?-mix:abashiri|abira|aibetsu|akabira|akkeshi|asahikawa|ashibetsu|ashoro|assabu|atsuma|bibai|biei|bifuka|bihoro|biratori|chippubetsu|chitose|date|ebetsu|embetsu|eniwa|erimo|esan|esashi|fukagawa|fukushima|furano|furubira|haboro|hakodate|hamatonbetsu|hidaka|higashikagura|higashikawa|hiroo|hokuryu|hokuto|honbetsu|horokanai|horonobe|ikeda|imakane|ishikari|iwamizawa|iwanai|kamifurano|kamikawa|kamishihoro|kamisunagawa|kamoenai|kayabe|kembuchi|kikonai|kimobetsu|kitahiroshima|kitami|kiyosato|koshimizu|kunneppu|kuriyama|kuromatsunai|kushiro|kutchan|kyowa|mashike|matsumae|mikasa|minamifurano|mombetsu|moseushi|mukawa|muroran|naie|nakagawa|nakasatsunai|nakatombetsu|nanae|nanporo|nayoro|nemuro|niikappu|niki|nishiokoppe|noboribetsu|numata|obihiro|obira|oketo|okoppe|otaru|otobe|otofuke|otoineppu|oumu|ozora|pippu|rankoshi|rebun|rikubetsu|rishiri|rishirifuji|saroma|sarufutsu|shakotan|shari|shibecha|shibetsu|shikabe|shikaoi|shimamaki|shimizu|shimokawa|shinshinotsu|shintoku|shiranuka|shiraoi|shiriuchi|sobetsu|sunagawa|taiki|takasu|takikawa|takinoue|teshikaga|tobetsu|tohma|tomakomai|tomari|toya|toyako|toyotomi|toyoura|tsubetsu|tsukigata|urakawa|urausu|uryu|utashinai|wakkanai|wassamu|yakumo|yoichi)\.)?hokkaido)|(?-mix:(?:(?-mix:aioi|akashi|ako|amagasaki|aogaki|asago|ashiya|awaji|fukusaki|goshiki|harima|himeji|ichikawa|inagawa|itami|kakogawa|kamigori|kamikawa|kasai|kasuga|kawanishi|miki|minamiawaji|nishinomiya|nishiwaki|ono|sanda|sannan|sasayama|sayo|shingu|shinonsen|shiso|sumoto|taishi|taka|takarazuka|takasago|takino|tamba|tatsuno|toyooka|yabu|yashiro|yoka|yokawa)\.)?hyogo)|(?-mix:(?:(?-mix:ami|asahi|bando|chikusei|daigo|fujishiro|hitachi|hitachinaka|hitachiomiya|hitachiota|ibaraki|ina|inashiki|itako|iwama|joso|kamisu|kasama|kashima|kasumigaura|koga|miho|mito|moriya|naka|namegata|oarai|ogawa|omitama|ryugasaki|sakai|sakuragawa|shimodate|shimotsuma|shirosato|sowa|suifu|takahagi|tamatsukuri|tokai|tomobe|tone|toride|tsuchiura|tsukuba|uchihara|ushiku|yachiyo|yamagata|yawara|yuki)\.)?ibaraki)|(?-mix:(?:(?-mix:anamizu|hakui|hakusan|kaga|kahoku|kanazawa|kawakita|komatsu|nakanoto|nanao|nomi|nonoichi|noto|shika|suzu|tsubata|tsurugi|uchinada|wajima)\.)?ishikawa)|(?-mix:(?:(?-mix:fudai|fujisawa|hanamaki|hiraizumi|hirono|ichinohe|ichinoseki|iwaizumi|iwate|joboji|kamaishi|kanegasaki|karumai|kawai|kitakami|kuji|kunohe|kuzumaki|miyako|mizusawa|morioka|ninohe|noda|ofunato|oshu|otsuchi|rikuzentakata|shiwa|shizukuishi|sumita|tanohata|tono|yahaba|yamada)\.)?iwate)|(?-mix:(?:(?-mix:ayagawa|higashikagawa|kanonji|kotohira|manno|marugame|mitoyo|naoshima|sanuki|tadotsu|takamatsu|tonosho|uchinomi|utazu|zentsuji)\.)?kagawa)|(?-mix:(?:(?-mix:akune|amami|hioki|isa|isen|izumi|kagoshima|kanoya|kawanabe|kinko|kouyama|makurazaki|matsumoto|minamitane|nakatane|nishinoomote|satsumasendai|soo|tarumizu|yusui)\.)?kagoshima)|(?-mix:(?:(?-mix:aikawa|atsugi|ayase|chigasaki|ebina|fujisawa|hadano|hakone|hiratsuka|isehara|kaisei|kamakura|kiyokawa|matsuda|minamiashigara|miura|nakai|ninomiya|odawara|oi|oiso|sagamihara|samukawa|tsukui|yamakita|yamato|yokosuka|yugawara|zama|zushi)\.)?kanagawa)|(?-mix:(?:(?-mix:aki|geisei|hidaka|higashitsuno|ino|kagami|kami|kitagawa|kochi|mihara|motoyama|muroto|nahari|nakamura|nankoku|nishitosa|niyodogawa|ochi|okawa|otoyo|otsuki|sakawa|sukumo|susaki|tosa|tosashimizu|toyo|tsuno|umaji|yasuda|yusuhara)\.)?kochi)|(?-mix:(?:(?-mix:amakusa|arao|aso|choyo|gyokuto|kamiamakusa|kikuchi|kumamoto|mashiki|mifune|minamata|minamioguni|nagasu|nishihara|oguni|ozu|sumoto|takamori|uki|uto|yamaga|yamato|yatsushiro)\.)?kumamoto)|(?-mix:(?:(?-mix:ayabe|fukuchiyama|higashiyama|ide|ine|joyo|kameoka|kamo|kita|kizu|kumiyama|kyotamba|kyotanabe|kyotango|maizuru|minami|minamiyamashiro|miyazu|muko|nagaokakyo|nakagyo|nantan|oyamazaki|sakyo|seika|tanabe|uji|ujitawara|wazuka|yamashina|yawata)\.)?kyoto)|(?-mix:(?:(?-mix:asahi|inabe|ise|kameyama|kawagoe|kiho|kisosaki|kiwa|komono|kumano|kuwana|matsusaka|meiwa|mihama|minamiise|misugi|miyama|nabari|shima|suzuka|tado|taiki|taki|tamaki|toba|tsu|udono|ureshino|watarai|yokkaichi)\.)?mie)|(?-mix:(?:(?-mix:furukawa|higashimatsushima|ishinomaki|iwanuma|kakuda|kami|kawasaki|marumori|matsushima|minamisanriku|misato|murata|natori|ogawara|ohira|onagawa|osaki|rifu|semine|shibata|shichikashuku|shikama|shiogama|shiroishi|tagajo|taiwa|tome|tomiya|wakuya|watari|yamamoto|zao)\.)?miyagi)|(?-mix:(?:(?-mix:aya|ebino|gokase|hyuga|kadogawa|kawaminami|kijo|kitagawa|kitakata|kitaura|kobayashi|kunitomi|kushima|mimata|miyakonojo|miyazaki|morotsuka|nichinan|nishimera|nobeoka|saito|shiiba|shintomi|takaharu|takanabe|takazaki|tsuno)\.)?miyazaki)|(?-mix:(?:(?-mix:achi|agematsu|anan|aoki|asahi|azumino|chikuhoku|chikuma|chino|fujimi|hakuba|hara|hiraya|iida|iijima|iiyama|iizuna|ikeda|ikusaka|ina|karuizawa|kawakami|kiso|kisofukushima|kitaaiki|komagane|komoro|matsukawa|matsumoto|miasa|minamiaiki|minamimaki|minamiminowa|minowa|miyada|miyota|mochizuki|nagano|nagawa|nagiso|nakagawa|nakano|nozawaonsen|obuse|ogawa|okaya|omachi|omi|ookuwa|ooshika|otaki|otari|sakae|sakaki|saku|sakuho|shimosuwa|shinanomachi|shiojiri|suwa|suzaka|takagi|takamori|takayama|tateshina|tatsuno|togakushi|togura|tomi|ueda|wada|yamagata|yamanouchi|yasaka|yasuoka)\.)?nagano)|(?-mix:(?:(?-mix:chijiwa|futsu|goto|hasami|hirado|iki|isahaya|kawatana|kuchinotsu|matsuura|nagasaki|obama|omura|oseto|saikai|sasebo|seihi|shimabara|shinkamigoto|togitsu|tsushima|unzen)\.)?nagasaki)|(?-mix:(?:(?-mix:ando|gose|heguri|higashiyoshino|ikaruga|ikoma|kamikitayama|kanmaki|kashiba|kashihara|katsuragi|kawai|kawakami|kawanishi|koryo|kurotaki|mitsue|miyake|nara|nosegawa|oji|ouda|oyodo|sakurai|sango|shimoichi|shimokitayama|shinjo|soni|takatori|tawaramoto|tenkawa|tenri|uda|yamatokoriyama|yamatotakada|yamazoe|yoshino)\.)?nara)|(?-mix:(?:(?-mix:aga|agano|gosen|itoigawa|izumozaki|joetsu|kamo|kariwa|kashiwazaki|minamiuonuma|mitsuke|muika|murakami|myoko|nagaoka|niigata|ojiya|omi|sado|sanjo|seiro|seirou|sekikawa|shibata|tagami|tainai|tochio|tokamachi|tsubame|tsunan|uonuma|yahiko|yoita|yuzawa)\.)?niigata)|(?-mix:(?:(?-mix:beppu|bungoono|bungotakada|hasama|hiji|himeshima|hita|kamitsue|kokonoe|kuju|kunisaki|kusu|oita|saiki|taketa|tsukumi|usa|usuki|yufu)\.)?oita)|(?-mix:(?:(?-mix:akaiwa|asakuchi|bizen|hayashima|ibara|kagamino|kasaoka|kibichuo|kumenan|kurashiki|maniwa|misaki|nagi|niimi|nishiawakura|okayama|satosho|setouchi|shinjo|shoo|soja|takahashi|tamano|tsuyama|wake|yakage)\.)?okayama)|(?-mix:(?:(?-mix:aguni|ginowan|ginoza|gushikami|haebaru|higashi|hirara|iheya|ishigaki|ishikawa|itoman|izena|kadena|kin|kitadaito|kitanakagusuku|kumejima|kunigami|minamidaito|motobu|nago|naha|nakagusuku|nakijin|nanjo|nishihara|ogimi|okinawa|onna|shimoji|taketomi|tarama|tokashiki|tomigusuku|tonaki|urasoe|uruma|yaese|yomitan|yonabaru|yonaguni|zamami)\.)?okinawa)|(?-mix:(?:(?-mix:abeno|chihayaakasaka|chuo|daito|fujiidera|habikino|hannan|higashiosaka|higashisumiyoshi|higashiyodogawa|hirakata|ibaraki|ikeda|izumi|izumiotsu|izumisano|kadoma|kaizuka|kanan|kashiwara|katano|kawachinagano|kishiwada|kita|kumatori|matsubara|minato|minoh|misaki|moriguchi|neyagawa|nishi|nose|osakasayama|sakai|sayama|sennan|settsu|shijonawate|shimamoto|suita|tadaoka|taishi|tajiri|takaishi|takatsuki|tondabayashi|toyonaka|toyono|yao)\.)?osaka)|(?-mix:(?:(?-mix:ariake|arita|fukudomi|genkai|hamatama|hizen|imari|kamimine|kanzaki|karatsu|kashima|kitagata|kitahata|kiyama|kouhoku|kyuragi|nishiarita|ogi|omachi|ouchi|saga|shiroishi|taku|tara|tosu|yoshinogari)\.)?saga)|(?-mix:(?:(?-mix:arakawa|asaka|chichibu|fujimi|fujimino|fukaya|hanno|hanyu|hasuda|hatogaya|hatoyama|hidaka|higashichichibu|higashimatsuyama|honjo|ina|iruma|iwatsuki|kamiizumi|kamikawa|kamisato|kasukabe|kawagoe|kawaguchi|kawajima|kazo|kitamoto|koshigaya|kounosu|kuki|kumagaya|matsubushi|minano|misato|miyashiro|miyoshi|moroyama|nagatoro|namegawa|niiza|ogano|ogawa|ogose|okegawa|omiya|otaki|ranzan|ryokami|saitama|sakado|satte|sayama|shiki|shiraoka|soka|sugito|toda|tokigawa|tokorozawa|tsurugashima|urawa|warabi|yashio|yokoze|yono|yorii|yoshida|yoshikawa|yoshimi)\.)?saitama)|(?-mix:(?:(?-mix:aisho|gamo|higashiomi|hikone|koka|konan|kosei|koto|kusatsu|maibara|moriyama|nagahama|nishiazai|notogawa|omihachiman|otsu|ritto|ryuoh|takashima|takatsuki|torahime|toyosato|yasu)\.)?shiga)|(?-mix:(?:(?-mix:akagi|ama|gotsu|hamada|higashiizumo|hikawa|hikimi|izumo|kakinoki|masuda|matsue|misato|nishinoshima|ohda|okinoshima|okuizumo|shimane|tamayu|tsuwano|unnan|yakumo|yasugi|yatsuka)\.)?shimane)|(?-mix:(?:(?-mix:arai|atami|fuji|fujieda|fujikawa|fujinomiya|fukuroi|gotemba|haibara|hamamatsu|higashiizu|ito|iwata|izu|izunokuni|kakegawa|kannami|kawanehon|kawazu|kikugawa|kosai|makinohara|matsuzaki|minamiizu|mishima|morimachi|nishiizu|numazu|omaezaki|shimada|shimizu|shimoda|shizuoka|susono|yaizu|yoshida)\.)?shizuoka)|(?-mix:(?:(?-mix:ashikaga|bato|haga|ichikai|iwafune|kaminokawa|kanuma|karasuyama|kuroiso|mashiko|mibu|moka|motegi|nasu|nasushiobara|nikko|nishikata|nogi|ohira|ohtawara|oyama|sakura|sano|shimotsuke|shioya|takanezawa|tochigi|tsuga|ujiie|utsunomiya|yaita)\.)?tochigi)|(?-mix:(?:(?-mix:aizumi|anan|ichiba|itano|kainan|komatsushima|matsushige|mima|minami|miyoshi|mugi|nakagawa|naruto|sanagochi|shishikui|tokushima|wajiki)\.)?tokushima)|(?-mix:(?:(?-mix:adachi|akiruno|akishima|aogashima|arakawa|bunkyo|chiyoda|chofu|chuo|edogawa|fuchu|fussa|hachijo|hachioji|hamura|higashikurume|higashimurayama|higashiyamato|hino|hinode|hinohara|inagi|itabashi|katsushika|kita|kiyose|kodaira|koganei|kokubunji|komae|koto|kouzushima|kunitachi|machida|meguro|minato|mitaka|mizuho|musashimurayama|musashino|nakano|nerima|ogasawara|okutama|ome|oshima|ota|setagaya|shibuya|shinagawa|shinjuku|suginami|sumida|tachikawa|taito|tama|toshima)\.)?tokyo)|(?-mix:(?:(?-mix:chizu|hino|kawahara|koge|kotoura|misasa|nanbu|nichinan|sakaiminato|tottori|wakasa|yazu|yonago)\.)?tottori)|(?-mix:(?:(?-mix:asahi|fuchu|fukumitsu|funahashi|himi|imizu|inami|johana|kamiichi|kurobe|nakaniikawa|namerikawa|nanto|nyuzen|oyabe|taira|takaoka|tateyama|toga|tonami|toyama|unazuki|uozu|yamada)\.)?toyama)|(?-mix:(?:(?-mix:arida|aridagawa|gobo|hashimoto|hidaka|hirogawa|inami|iwade|kainan|kamitonda|katsuragi|kimino|kinokawa|kitayama|koya|koza|kozagawa|kudoyama|kushimoto|mihama|misato|nachikatsuura|shingu|shirahama|taiji|tanabe|wakayama|yuasa|yura)\.)?wakayama)|(?-mix:(?:(?-mix:asahi|funagata|higashine|iide|kahoku|kaminoyama|kaneyama|kawanishi|mamurogawa|mikawa|murayama|nagai|nakayama|nanyo|nishikawa|obanazawa|oe|oguni|ohkura|oishida|sagae|sakata|sakegawa|shinjo|shirataka|shonai|takahata|tendo|tozawa|tsuruoka|yamagata|yamanobe|yonezawa|yuza)\.)?yamagata)|(?-mix:(?:(?-mix:abu|hagi|hikari|hofu|iwakuni|kudamatsu|mitou|nagato|oshima|shimonoseki|shunan|tabuse|tokuyama|toyota|ube|yuu)\.)?yamaguchi)|(?-mix:(?:(?-mix:chuo|doshi|fuefuki|fujikawa|fujikawaguchiko|fujiyoshida|hayakawa|hokuto|ichikawamisato|kai|kofu|koshu|kosuge|minami\-alps|minobu|nakamichi|nanbu|narusawa|nirasaki|nishikatsura|oshino|otsuki|showa|tabayama|tsuru|uenohara|yamanakako|yamanashi)\.)?yamanashi)|栃木|愛知|愛媛|兵庫|熊本|茨城|北海道|千葉|和歌山|長崎|長野|新潟|青森|静岡|東京|石川|埼玉|三重|京都|佐賀|大分|大阪|奈良|宮城|宮崎|富山|山口|山形|山梨|岩手|岐阜|岡山|島根|広島|徳島|沖縄|滋賀|神奈川|福井|福岡|福島|秋田|群馬|香川|高知|鳥取|鹿児島|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|!city)\.)?kawasaki)|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|!city)\.)?kitakyushu)|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|!city)\.)?kobe)|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|!city)\.)?nagoya)|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|!city)\.)?sapporo)|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|!city)\.)?sendai)|(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|!city)\.)?yokohama)|buyshop|fashionstore|handcrafted|kawaiishop|supersale|theshop|usercontent|angry|babyblue|babymilk|backdrop|bambina|bitter|blush|boo|boy|boyfriend|but|candypop|capoo|catfood|cheap|chicappa|chillout|chips|chowder|chu|ciao|cocotte|coolblog|cranky|cutegirl|daa|deca|deci|digick|egoism|fakefur|fem|flier|floppy|fool|frenchkiss|girlfriend|girly|gloomy|gonna|greater|hacca|heavy|her|hiho|hippy|holy|hungry|icurus|itigo|jellybean|kikirara|kill|kilo|kuron|littlestar|lolitapunk|lomo|lovepop|lovesick|main|mods|mond|mongolian|moo|namaste|nikita|nobushi|noor|oops|parallel|parasite|pecori|peewee|penne|pepper|perma|pigboat|pinoko|punyu|pupu|pussycat|pya|raindrop|readymade|sadist|schoolbus|secret|staba|stripper|sub|sunnyday|thick|tonkotsu|under|upper|velvet|verse|versus|vivian|watson|weblike|whitesnow|zombie|blogspot)\.)?jp)|(?-mix:(?:(?-mix:ac|(?-mix:(?:blogspot\.)?co)|go|info|me|mobi|ne|or|sc)\.)?ke)|(?-mix:(?:(?-mix:org|net|com|edu|gov|mil|blog|io|jp|tv|uk|us)\.)?kg)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?kh)|(?-mix:(?:(?-mix:edu|biz|net|org|gov|info|com)\.)?ki)|(?-mix:(?:(?-mix:org|nom|gov|prd|tm|edu|mil|ass|com|coop|asso|presse|medecin|notaires|pharmaciens|veterinaire|gouv)\.)?km)|(?-mix:(?:(?-mix:net|org|edu|gov)\.)?kn)|(?-mix:(?:(?-mix:com|edu|gov|org|rep|tra)\.)?kp)|(?-mix:(?:(?-mix:ac|co|es|go|hs|kg|mil|ms|ne|or|pe|re|sc|busan|chungbuk|chungnam|daegu|daejeon|gangwon|gwangju|gyeongbuk|gyeonggi|gyeongnam|incheon|jeju|jeonbuk|jeonnam|seoul|ulsan|blogspot)\.)?kr)|(?-mix:(?:(?-mix:com|edu|emb|gov|ind|net|org)\.)?kw)|(?-mix:(?:(?-mix:com|edu|net|org)\.)?ky)|(?-mix:(?:(?-mix:org|edu|net|gov|mil|com|jcloud|(?-mix:(?:upaas\.)?kazteleport))\.)?kz)|(?-mix:(?:(?-mix:int|net|info|edu|gov|per|com|org|bnr|c)\.)?la)|(?-mix:(?:(?-mix:com|edu|gov|net|org)\.)?lb)|(?-mix:(?:(?-mix:com|net|co|org|edu|gov|oy)\.)?lc)|(?-mix:(?:(?-mix:blogspot|caa)\.)?li)|(?-mix:(?:(?-mix:gov|sch|net|int|com|org|edu|ngo|soc|web|ltd|assn|grp|hotel|ac)\.)?lk)|(?-mix:(?:(?-mix:com|edu|gov|org|net)\.)?lr)|(?-mix:(?:(?-mix:ac|biz|co|edu|gov|info|net|org|sc|de)\.)?ls)|(?-mix:(?:(?-mix:gov|blogspot)\.)?lt)|(?-mix:(?:blogspot\.)?lu)|(?-mix:(?:(?-mix:com|edu|gov|org|mil|id|net|asn|conf)\.)?lv)|(?-mix:(?:(?-mix:com|net|gov|plc|edu|sch|med|org|id)\.)?ly)|(?-mix:(?:(?-mix:co|net|gov|org|ac|press)\.)?ma)|(?-mix:(?:(?-mix:tm|asso)\.)?mc)|(?-mix:(?:(?-mix:blogspot|at|de|jp|to)\.)?md)|(?-mix:(?:(?-mix:co|net|org|edu|ac|gov|its|priv|c66|(?-mix:(?:localhost\.)?daplie)|edgestack|filegear|filegear\-au|filegear\-de|filegear\-gb|filegear\-ie|filegear\-jp|filegear\-sg|glitch|ravendb|lohmus|barsy|mcpe|mcdir|soundcast|tcp4|brasilia|ddns|dnsfor|hopto|loginto|noip|webhop|vp4|diskstation|dscloud|i234|myds|synology|tbits|(?-mix:(?:site\.)?transip)|wedeploy|yombo|nohost)\.)?me)|(?-mix:(?:(?-mix:org|nom|gov|prd|tm|edu|mil|com|co)\.)?mg)|mh|mil|(?-mix:(?:(?-mix:com|org|net|edu|gov|inf|name|blogspot)\.)?mk)|(?-mix:(?:(?-mix:com|edu|gouv|gov|net|org|presse)\.)?ml)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?mm)|(?-mix:(?:(?-mix:gov|edu|org|nyc)\.)?mn)|(?-mix:(?:(?-mix:com|net|org|edu|gov)\.)?mo)|(?-mix:(?:(?-mix:barsy|dscloud)\.)?mobi)|(?-mix:(?:ju\.)?mp)|mq|(?-mix:(?:(?-mix:gov|blogspot)\.)?mr)|(?-mix:(?:(?-mix:com|edu|gov|net|org|lab|minisite)\.)?ms)|(?-mix:(?:(?-mix:(?-mix:(?:blogspot\.)?com)|edu|net|org)\.)?mt)|(?-mix:(?:(?-mix:com|net|org|gov|ac|co|or)\.)?mu)|(?-mix:(?:(?-mix:academy|agriculture|air|airguard|alabama|alaska|amber|ambulance|american|americana|americanantiques|americanart|amsterdam|and|annefrank|anthro|anthropology|antiques|aquarium|arboretum|archaeological|archaeology|architecture|art|artanddesign|artcenter|artdeco|arteducation|artgallery|arts|artsandcrafts|asmatart|assassination|assisi|association|astronomy|atlanta|austin|australia|automotive|aviation|axis|badajoz|baghdad|bahn|bale|baltimore|barcelona|baseball|basel|baths|bauern|beauxarts|beeldengeluid|bellevue|bergbau|berkeley|berlin|bern|bible|bilbao|bill|birdart|birthplace|bonn|boston|botanical|botanicalgarden|botanicgarden|botany|brandywinevalley|brasil|bristol|british|britishcolumbia|broadcast|brunel|brussel|brussels|bruxelles|building|burghof|bus|bushey|cadaques|california|cambridge|can|canada|capebreton|carrier|cartoonart|casadelamoneda|castle|castres|celtic|center|chattanooga|cheltenham|chesapeakebay|chicago|children|childrens|childrensgarden|chiropractic|chocolate|christiansburg|cincinnati|cinema|circus|civilisation|civilization|civilwar|clinton|clock|coal|coastaldefence|cody|coldwar|collection|colonialwilliamsburg|coloradoplateau|columbia|columbus|communication|communications|community|computer|computerhistory|comunicações|contemporary|contemporaryart|convent|copenhagen|corporation|correios\-e\-telecomunicações|corvette|costume|countryestate|county|crafts|cranbrook|creation|cultural|culturalcenter|culture|cyber|cymru|dali|dallas|database|ddr|decorativearts|delaware|delmenhorst|denmark|depot|design|detroit|dinosaur|discovery|dolls|donostia|durham|eastafrica|eastcoast|education|educational|egyptian|eisenbahn|elburg|elvendrell|embroidery|encyclopedic|england|entomology|environment|environmentalconservation|epilepsy|essex|estate|ethnology|exeter|exhibition|family|farm|farmequipment|farmers|farmstead|field|figueres|filatelia|film|fineart|finearts|finland|flanders|florida|force|fortmissoula|fortworth|foundation|francaise|frankfurt|franziskaner|freemasonry|freiburg|fribourg|frog|fundacio|furniture|gallery|garden|gateway|geelvinck|gemological|geology|georgia|giessen|glas|glass|gorge|grandrapids|graz|guernsey|halloffame|hamburg|handson|harvestcelebration|hawaii|health|heimatunduhren|hellas|helsinki|hembygdsforbund|heritage|histoire|historical|historicalsociety|historichouses|historisch|historisches|history|historyofscience|horology|house|humanities|illustration|imageandsound|indian|indiana|indianapolis|indianmarket|intelligence|interactive|iraq|iron|isleofman|jamison|jefferson|jerusalem|jewelry|jewish|jewishart|jfk|journalism|judaica|judygarland|juedisches|juif|karate|karikatur|kids|koebenhavn|koeln|kunst|kunstsammlung|kunstunddesign|labor|labour|lajolla|lancashire|landes|lans|läns|larsson|lewismiller|lincoln|linz|living|livinghistory|localhistory|london|losangeles|louvre|loyalist|lucerne|luxembourg|luzern|mad|madrid|mallorca|manchester|mansion|mansions|manx|marburg|maritime|maritimo|maryland|marylhurst|media|medical|medizinhistorisches|meeres|memorial|mesaverde|michigan|midatlantic|military|mill|miners|mining|minnesota|missile|missoula|modern|moma|money|monmouth|monticello|montreal|moscow|motorcycle|muenchen|muenster|mulhouse|muncie|museet|museumcenter|museumvereniging|music|national|nationalfirearms|nationalheritage|nativeamerican|naturalhistory|naturalhistorymuseum|naturalsciences|nature|naturhistorisches|natuurwetenschappen|naumburg|naval|nebraska|neues|newhampshire|newjersey|newmexico|newport|newspaper|newyork|niepce|norfolk|north|nrw|nyc|nyny|oceanographic|oceanographique|omaha|online|ontario|openair|oregon|oregontrail|otago|oxford|pacific|paderborn|palace|paleo|palmsprings|panama|paris|pasadena|pharmacy|philadelphia|philadelphiaarea|philately|phoenix|photography|pilots|pittsburgh|planetarium|plantation|plants|plaza|portal|portland|portlligat|posts\-and\-telecommunications|preservation|presidio|press|project|public|pubol|quebec|railroad|railway|research|resistance|riodejaneiro|rochester|rockart|roma|russia|saintlouis|salem|salvadordali|salzburg|sandiego|sanfrancisco|santabarbara|santacruz|santafe|saskatchewan|satx|savannahga|schlesisches|schoenbrunn|schokoladen|school|schweiz|science|scienceandhistory|scienceandindustry|sciencecenter|sciencecenters|science\-fiction|sciencehistory|sciences|sciencesnaturelles|scotland|seaport|settlement|settlers|shell|sherbrooke|sibenik|silk|ski|skole|society|sologne|soundandvision|southcarolina|southwest|space|spy|square|stadt|stalbans|starnberg|state|stateofdelaware|station|steam|steiermark|stjohn|stockholm|stpetersburg|stuttgart|suisse|surgeonshall|surrey|svizzera|sweden|sydney|tank|tcm|technology|telekommunikation|television|texas|textile|theater|time|timekeeping|topology|torino|touch|town|transport|tree|trolley|trust|trustee|uhren|ulm|undersea|university|usa|usantiques|usarts|uscountryestate|usculture|usdecorativearts|usgarden|ushistory|ushuaia|uslivinghistory|utah|uvic|valley|vantaa|versailles|viking|village|virginia|virtual|virtuel|vlaanderen|volkenkunde|wales|wallonie|war|washingtondc|watchandclock|watch\-and\-clock|western|westfalen|whaling|wildlife|williamsburg|windmill|workshop|york|yorkshire|yosemite|youth|zoological|zoology|ירושלים|иком)\.)?museum)|(?-mix:(?:(?-mix:aero|biz|com|coop|edu|gov|info|int|mil|museum|name|net|org|pro)\.)?mv)|(?-mix:(?:(?-mix:ac|biz|co|com|coop|edu|gov|int|museum|net|org)\.)?mw)|(?-mix:(?:(?-mix:com|org|gob|edu|net|blogspot)\.)?mx)|(?-mix:(?:(?-mix:biz|com|edu|gov|mil|name|net|org|blogspot)\.)?my)|(?-mix:(?:(?-mix:ac|adv|co|edu|gov|mil|net|org)\.)?mz)|(?-mix:(?:(?-mix:info|pro|name|school|or|dr|us|mx|ca|in|cc|tv|ws|mobi|co|com|org)\.)?na)|(?-mix:(?:(?-mix:(?-mix:(?:forgot\.)?her)|(?-mix:(?:forgot\.)?his))\.)?name)|(?-mix:(?:(?-mix:asso|nom)\.)?nc)|ne|(?-mix:(?:(?-mix:adobeaemcloud|alwaysdata|cloudfront|t3l3p0rt|appudo|(?-mix:(?:(?-mix:(?:cdn\.)?prod)\.)?atlassian-dev)|myfritz|onavstack|shopselect|blackbaudcdn|boomla|bplaced|square7|gb|hu|jp|se|uk|in|clickrising|cloudaccess|cdn77\-ssl|(?-mix:(?:r\.)?cdn77)|feste\-ip|knx\-server|static\-access|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?cryptonomic)|dattolocal|mydatto|debian|bitbridge|at\-band\-camp|blogdns|broke\-it|buyshouses|dnsalias|dnsdojo|does\-it|dontexist|dynalias|dynathome|endofinternet|from\-az|from\-co|from\-la|from\-ny|gets\-it|ham\-radio\-op|homeftp|homeip|homelinux|homeunix|in\-the\-band|is\-a\-chef|is\-a\-geek|isa\-geek|kicks\-ass|office\-on\-the|podzone|scrapper\-site|selfip|sells\-it|servebbs|serveftp|thruhere|webhop|definima|casacam|dynu|dynv6|twmail|ru|(?-mix:(?:u\.)?channelsdvr)|(?-mix:(?:map\.)?fastlylb)|(?-mix:(?:(?-mix:freetls|map|(?-mix:(?:(?-mix:a|global)\.)?prod)|(?-mix:(?:(?-mix:a|b|global)\.)?ssl))\.)?fastly)|edgeapp|flynnhosting|cdn\-edges|heteml|cloudfunctions|moonscale|in\-dsl|in\-vpn|ipifony|iobb|(?-mix:(?:(?-mix:fra1\-de|west1\-us)\.)?cloudjiffy)|(?-mix:(?:(?-mix:jls\-sto1|jls\-sto2|jls\-sto3)\.)?elastx)|faststacks|(?-mix:(?:(?-mix:(?:(?-mix:fr\-1|lon\-1|lon\-2|ny\-1|ny\-2|sg\-1)\.)?paas)\.)?massivegrid)|(?-mix:(?:(?-mix:jelastic|nordeste\-idc)\.)?saveincloud)|(?-mix:(?:j\.)?scaleforce)|(?-mix:(?:jelastic\.)?tsukaeru)|kinghost|uni5|krellian|barsy|memset|azurewebsites|azure\-mobile|cloudapp|(?-mix:(?:(?-mix:1|centralus|eastasia|eastus2|westeurope|westus2)\.)?azurestaticapps)|dnsup|hicam|now\-dns|ownip|vpndns|eating\-organic|mydissent|myeffect|mymediapc|mypsx|mysecuritycamera|nhlfan|no\-ip|pgafan|privatizehealthinsurance|bounceme|ddns|redirectme|serveblog|serveminecraft|sytes|cloudycluster|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?webpaas)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?hosting))\.)?ovh)|bar0|bar1|bar2|rackmaze|schokokeks|firewall\-gateway|seidat|senseering|siteleaf|(?-mix:(?:(?-mix:(?:(?-mix:atl|njs|ric)\.)?jelastic)\.)?vps-host)|myspreadshop|(?-mix:(?:(?-mix:soc|user)\.)?srcf)|supabase|dsmynas|familyds|(?-mix:(?:beta\.)?tailscale)|ts|(?-mix:(?:pages\.)?torproject)|reserve\-online|community\-pro|meinforum|(?-mix:(?:(?-mix:storage|website)\.)?yandexcloud)|za)\.)?net)|(?-mix:(?:(?-mix:com|net|per|rec|web|arts|firm|info|other|store)\.)?nf)|(?-mix:(?:(?-mix:(?-mix:(?:blogspot\.)?com)|edu|gov|i|mil|mobi|name|net|org|sch|col|firm|gen|ltd|ngo)\.)?ng)|(?-mix:(?:(?-mix:ac|biz|co|com|edu|gob|in|info|int|mil|net|nom|org|web)\.)?ni)|(?-mix:(?:(?-mix:co|hosting\-cluster|blogspot|gov|khplay|myspreadshop|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?transurl)|cistron|demon)\.)?nl)|(?-mix:(?:(?-mix:fhs|vgs|fylkesbibl|folkebibl|museum|idrett|priv|mil|stat|dep|kommune|herad|(?-mix:(?:gs\.)?aa)|(?-mix:(?:gs\.)?ah)|(?-mix:(?:gs\.)?bu)|(?-mix:(?:gs\.)?fm)|(?-mix:(?:gs\.)?hl)|(?-mix:(?:gs\.)?hm)|(?-mix:(?:gs\.)?jan-mayen)|(?-mix:(?:gs\.)?mr)|(?-mix:(?:gs\.)?nl)|(?-mix:(?:gs\.)?nt)|(?-mix:(?:gs\.)?of)|(?-mix:(?:gs\.)?ol)|(?-mix:(?:gs\.)?oslo)|(?-mix:(?:gs\.)?rl)|(?-mix:(?:gs\.)?sf)|(?-mix:(?:gs\.)?st)|(?-mix:(?:gs\.)?svalbard)|(?-mix:(?:gs\.)?tm)|(?-mix:(?:gs\.)?tr)|(?-mix:(?:gs\.)?va)|(?-mix:(?:gs\.)?vf)|akrehamn|åkrehamn|algard|ålgård|arna|brumunddal|bryne|bronnoysund|brønnøysund|drobak|drøbak|egersund|fetsund|floro|florø|fredrikstad|hokksund|honefoss|hønefoss|jessheim|jorpeland|jørpeland|kirkenes|kopervik|krokstadelva|langevag|langevåg|leirvik|mjondalen|mjøndalen|mo\-i\-rana|mosjoen|mosjøen|nesoddtangen|orkanger|osoyro|osøyro|raholt|råholt|sandnessjoen|sandnessjøen|skedsmokorset|slattum|spjelkavik|stathelle|stavern|stjordalshalsen|stjørdalshalsen|tananger|tranby|vossevangen|afjord|åfjord|agdenes|al|ål|alesund|ålesund|alstahaug|alta|áltá|alaheadju|álaheadju|alvdal|amli|åmli|amot|åmot|andebu|andoy|andøy|andasuolo|ardal|årdal|aremark|arendal|ås|aseral|åseral|asker|askim|askvoll|askoy|askøy|asnes|åsnes|audnedaln|aukra|aure|aurland|aurskog\-holand|aurskog\-høland|austevoll|austrheim|averoy|averøy|balestrand|ballangen|balat|bálát|balsfjord|bahccavuotna|báhccavuotna|bamble|bardu|beardu|beiarn|bajddar|bájddar|baidar|báidár|berg|bergen|berlevag|berlevåg|bearalvahki|bearalváhki|bindal|birkenes|bjarkoy|bjarkøy|bjerkreim|bjugn|bodo|bodø|badaddja|bådåddjå|budejju|bokn|bremanger|bronnoy|brønnøy|bygland|bykle|barum|bærum|(?-mix:(?:(?-mix:bo|bø)\.)?telemark)|(?-mix:(?:(?-mix:bo|bø|heroy|herøy)\.)?nordland)|bievat|bievát|bomlo|bømlo|batsfjord|båtsfjord|bahcavuotna|báhcavuotna|dovre|drammen|drangedal|dyroy|dyrøy|donna|dønna|eid|eidfjord|eidsberg|eidskog|eidsvoll|eigersund|elverum|enebakk|engerdal|etne|etnedal|evenes|evenassi|evenášši|evje\-og\-hornnes|farsund|fauske|fuossko|fuoisku|fedje|fet|finnoy|finnøy|fitjar|fjaler|fjell|flakstad|flatanger|flekkefjord|flesberg|flora|fla|flå|folldal|forsand|fosnes|frei|frogn|froland|frosta|frana|fræna|froya|frøya|fusa|fyresdal|forde|førde|gamvik|gangaviika|gáŋgaviika|gaular|gausdal|gildeskal|gildeskål|giske|gjemnes|gjerdrum|gjerstad|gjesdal|gjovik|gjøvik|gloppen|gol|gran|grane|granvin|gratangen|grimstad|grong|kraanghke|kråanghke|grue|gulen|hadsel|halden|halsa|hamar|hamaroy|habmer|hábmer|hapmir|hápmir|hammerfest|hammarfeasta|hámmárfeasta|haram|hareid|harstad|hasvik|aknoluokta|ákŋoluokta|hattfjelldal|aarborte|haugesund|hemne|hemnes|hemsedal|(?-mix:(?:(?-mix:heroy|sande)\.)?more-og-romsdal)|(?-mix:(?:(?-mix:herøy|sande)\.)?møre-og-romsdal)|hitra|hjartdal|hjelmeland|hobol|hobøl|hof|hol|hole|holmestrand|holtalen|holtålen|hornindal|horten|hurdal|hurum|hvaler|hyllestad|hagebostad|hægebostad|hoyanger|høyanger|hoylandet|høylandet|ha|hå|ibestad|inderoy|inderøy|iveland|jevnaker|jondal|jolster|jølster|karasjok|karasjohka|kárášjohka|karlsoy|galsa|gálsá|karmoy|karmøy|kautokeino|guovdageaidnu|klepp|klabu|klæbu|kongsberg|kongsvinger|kragero|kragerø|kristiansand|kristiansund|krodsherad|krødsherad|kvalsund|rahkkeravju|ráhkkerávju|kvam|kvinesdal|kvinnherad|kviteseid|kvitsoy|kvitsøy|kvafjord|kvæfjord|giehtavuoatna|kvanangen|kvænangen|navuotna|návuotna|kafjord|kåfjord|gaivuotna|gáivuotna|larvik|lavangen|lavagis|loabat|loabát|lebesby|davvesiida|leikanger|leirfjord|leka|leksvik|lenvik|leangaviika|leaŋgaviika|lesja|levanger|lier|lierne|lillehammer|lillesand|lindesnes|lindas|lindås|lom|loppa|lahppi|láhppi|lund|lunner|luroy|lurøy|luster|lyngdal|lyngen|ivgu|lardal|lerdal|lærdal|lodingen|lødingen|lorenskog|lørenskog|loten|løten|malvik|masoy|måsøy|muosat|muosát|mandal|marker|marnardal|masfjorden|meland|meldal|melhus|meloy|meløy|meraker|meråker|moareke|moåreke|midsund|midtre\-gauldal|modalen|modum|molde|moskenes|moss|mosvik|malselv|målselv|malatvuopmi|málatvuopmi|namdalseid|aejrie|namsos|namsskogan|naamesjevuemie|nååmesjevuemie|laakesvuemie|nannestad|narvik|narviika|naustdal|nedre\-eiker|(?-mix:(?:nes\.)?akershus)|(?-mix:(?:nes\.)?buskerud)|nesna|nesodden|nesseby|unjarga|unjárga|nesset|nissedal|nittedal|nord\-aurdal|nord\-fron|nord\-odal|norddal|nordkapp|davvenjarga|davvenjárga|nordre\-land|nordreisa|raisa|ráisa|nore\-og\-uvdal|notodden|naroy|nærøy|notteroy|nøtterøy|odda|oksnes|øksnes|oppdal|oppegard|oppegård|orkdal|orland|ørland|orskog|ørskog|orsta|ørsta|(?-mix:(?:(?-mix:os|valer|våler)\.)?hedmark)|(?-mix:(?:os\.)?hordaland)|osen|osteroy|osterøy|ostre\-toten|østre\-toten|overhalla|ovre\-eiker|øvre\-eiker|oyer|øyer|oygarden|øygarden|oystre\-slidre|øystre\-slidre|porsanger|porsangu|porsáŋgu|porsgrunn|radoy|radøy|rakkestad|rana|ruovat|randaberg|rauma|rendalen|rennebu|rennesoy|rennesøy|rindal|ringebu|ringerike|ringsaker|rissa|risor|risør|roan|rollag|rygge|ralingen|rælingen|rodoy|rødøy|romskog|rømskog|roros|røros|rost|røst|royken|røyken|royrvik|røyrvik|rade|råde|salangen|siellak|saltdal|salat|sálát|sálat|samnanger|(?-mix:(?:sande\.)?vestfold)|sandefjord|sandnes|sandoy|sandøy|sarpsborg|sauda|sauherad|sel|selbu|selje|seljord|sigdal|siljan|sirdal|skaun|skedsmo|ski|skien|skiptvet|skjervoy|skjervøy|skierva|skiervá|skjak|skjåk|skodje|skanland|skånland|skanit|skánit|smola|smøla|snillfjord|snasa|snåsa|snoasa|snaase|snåase|sogndal|sokndal|sola|solund|songdalen|sortland|spydeberg|stange|stavanger|steigen|steinkjer|stjordal|stjørdal|stokke|stor\-elvdal|stord|stordal|storfjord|omasvuotna|strand|stranda|stryn|sula|suldal|sund|sunndal|surnadal|sveio|svelvik|sykkylven|sogne|søgne|somna|sømna|sondre\-land|søndre\-land|sor\-aurdal|sør\-aurdal|sor\-fron|sør\-fron|sor\-odal|sør\-odal|sor\-varanger|sør\-varanger|matta\-varjjat|mátta\-várjjat|sorfold|sørfold|sorreisa|sørreisa|sorum|sørum|tana|deatnu|time|tingvoll|tinn|tjeldsund|dielddanuorri|tjome|tjøme|tokke|tolga|torsken|tranoy|tranøy|tromso|tromsø|tromsa|romsa|trondheim|troandin|trysil|trana|træna|trogstad|trøgstad|tvedestrand|tydal|tynset|tysfjord|divtasvuodna|divttasvuotna|tysnes|tysvar|tysvær|tonsberg|tønsberg|ullensaker|ullensvang|ulvik|utsira|vadso|vadsø|cahcesuolo|čáhcesuolo|vaksdal|valle|vang|vanylven|vardo|vardø|varggat|várggát|vefsn|vaapste|vega|vegarshei|vegårshei|vennesla|verdal|verran|vestby|vestnes|vestre\-slidre|vestre\-toten|vestvagoy|vestvågøy|vevelstad|vik|vikna|vindafjord|volda|voss|varoy|værøy|vagan|vågan|voagat|vagsoy|vågsøy|vaga|vågå|(?-mix:(?:valer\.)?ostfold)|(?-mix:(?:våler\.)?østfold)|co|blogspot|myspreadshop)\.)?no)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?np)|(?-mix:(?:(?-mix:biz|info|gov|edu|org|net|com)\.)?nr)|(?-mix:(?:(?-mix:merseine|mine|shacknet|enterprisecloud)\.)?nu)|(?-mix:(?:(?-mix:ac|(?-mix:(?:blogspot\.)?co)|cri|geek|gen|govt|health|iwi|kiwi|maori|mil|māori|net|org|parliament|school)\.)?nz)|(?-mix:(?:(?-mix:co|com|edu|gov|med|museum|net|org|pro)\.)?om)|onion|(?-mix:(?:(?-mix:altervista|(?-mix:(?:tele\.)?amune)|pimienta|poivron|potager|sweetpepper|ae|us|certmgr|(?-mix:(?:(?-mix:c|rsc)\.)?cdn77)|(?-mix:(?:(?-mix:(?:ssl\.)?origin)\.)?cdn77-secure)|cloudns|duckdns|tunk|(?-mix:(?:(?-mix:go|home)\.)?dyndns)|blogdns|blogsite|boldlygoingnowhere|dnsalias|dnsdojo|doesntexist|dontexist|doomdns|dvrdns|dynalias|endofinternet|endoftheinternet|from\-me|game\-host|gotdns|hobby\-site|homedns|homeftp|homelinux|homeunix|is\-a\-bruinsfan|is\-a\-candidate|is\-a\-celticsfan|is\-a\-chef|is\-a\-geek|is\-a\-knight|is\-a\-linux\-user|is\-a\-patsfan|is\-a\-soxfan|is\-found|is\-lost|is\-saved|is\-very\-bad|is\-very\-evil|is\-very\-good|is\-very\-nice|is\-very\-sweet|isa\-geek|kicks\-ass|misconfused|podzone|readmyblog|selfip|sellsyourhome|servebbs|serveftp|servegame|stuff\-4\-sale|webhop|ddnss|accesscam|camdvr|freeddns|mywire|webredirect|(?-mix:(?:(?-mix:al|asso|at|au|be|bg|ca|cd|ch|cn|cy|cz|de|dk|edu|ee|es|fi|fr|gr|hr|hu|ie|il|in|int|is|it|jp|kr|lt|lu|lv|mc|me|mk|mt|my|net|ng|nl|no|nz|paris|pl|pt|q\-a|ro|ru|se|si|sk|tr|uk|us)\.)?eu)|twmail|fedorainfracloud|fedorapeople|(?-mix:(?:(?-mix:cloud|(?-mix:(?:app\.)?os)|(?-mix:(?:(?-mix:(?:app\.)?os)\.)?stg))\.)?fedoraproject)|freedesktop|hepforge|in\-dsl|in\-vpn|js|barsy|mayfirst|mozilla\-iot|bmoattachments|dynserv|now\-dns|cable\-modem|collegefan|couchpotatofries|mlbfan|mysecuritycamera|nflfan|read\-books|ufcfan|hopto|myftp|no\-ip|zapto|httpbin|pubtls|my\-firewall|myfirewall|spdns|small\-web|dsmynas|familyds|(?-mix:(?:s3\.)?teckids)|tuxfamily|diskstation|hk|wmflabs|toolforge|wmcloud|za)\.)?org)|(?-mix:(?:(?-mix:ac|gob|com|org|sld|edu|net|ing|abo|med|nom)\.)?pa)|(?-mix:(?:(?-mix:edu|gob|nom|mil|org|com|net|blogspot)\.)?pe)|(?-mix:(?:(?-mix:com|org|edu)\.)?pf)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?pg)|(?-mix:(?:(?-mix:com|net|org|gov|edu|ngo|mil|i)\.)?ph)|(?-mix:(?:(?-mix:com|net|edu|org|fam|biz|web|gov|gob|gok|gon|gop|gos|info)\.)?pk)|(?-mix:(?:(?-mix:com|net|org|aid|agro|atm|auto|biz|edu|gmina|gsm|info|mail|miasta|media|mil|nieruchomosci|nom|pc|powiat|priv|realestate|rel|sex|shop|sklep|sos|szkola|targi|tm|tourism|travel|turystyka|(?-mix:(?:(?-mix:ap|ic|is|us|kmpsp|kppsp|kwpsp|psp|wskr|kwp|mw|ug|um|umig|ugim|upow|uw|starostwo|pa|po|psse|pup|rzgw|sa|so|sr|wsa|sko|uzs|wiih|winb|pinb|wios|witd|wzmiuw|piw|wiw|griw|wif|oum|sdn|zp|uppo|mup|wuoz|konsulat|oirm)\.)?gov)|augustow|babia\-gora|bedzin|beskidy|bialowieza|bialystok|bielawa|bieszczady|boleslawiec|bydgoszcz|bytom|cieszyn|czeladz|czest|dlugoleka|elblag|elk|glogow|gniezno|gorlice|grajewo|ilawa|jaworzno|jelenia\-gora|jgora|kalisz|kazimierz\-dolny|karpacz|kartuzy|kaszuby|katowice|kepno|ketrzyn|klodzko|kobierzyce|kolobrzeg|konin|konskowola|kutno|lapy|lebork|legnica|lezajsk|limanowa|lomza|lowicz|lubin|lukow|malbork|malopolska|mazowsze|mazury|mielec|mielno|mragowo|naklo|nowaruda|nysa|olawa|olecko|olkusz|olsztyn|opoczno|opole|ostroda|ostroleka|ostrowiec|ostrowwlkp|pila|pisz|podhale|podlasie|polkowice|pomorze|pomorskie|prochowice|pruszkow|przeworsk|pulawy|radom|rawa\-maz|rybnik|rzeszow|sanok|sejny|slask|slupsk|sosnowiec|stalowa\-wola|skoczow|starachowice|stargard|suwalki|swidnica|swiebodzin|swinoujscie|szczecin|szczytno|tarnobrzeg|tgory|turek|tychy|ustka|walbrzych|warmia|warszawa|waw|wegrow|wielun|wlocl|wloclawek|wodzislaw|wolomin|wroclaw|zachpomor|zagan|zarow|zgora|zgorzelec|beep|ecommerce\-shop|shoparena|homesklep|sdscloud|unicloud|krasnik|leczna|lubartow|lublin|poniatowa|swidnik|co|art|gliwice|krakow|poznan|wroc|zakopane|myspreadshop|gda|gdansk|gdynia|med|sopot)\.)?pl)|(?-mix:(?:(?-mix:own|name)\.)?pm)|(?-mix:(?:(?-mix:gov|co|org|edu|net)\.)?pn)|post|(?-mix:(?:(?-mix:com|net|org|gov|edu|isla|pro|biz|info|name|est|prof|ac)\.)?pr)|(?-mix:(?:(?-mix:aaa|aca|acct|avocat|bar|cpa|eng|jur|law|med|recht|cloudns|(?-mix:(?:bci\.)?dnstrace)|barsy)\.)?pro)|(?-mix:(?:(?-mix:edu|gov|sec|plo|com|org|net)\.)?ps)|(?-mix:(?:(?-mix:net|gov|org|edu|int|publ|com|nome|blogspot)\.)?pt)|(?-mix:(?:(?-mix:co|ne|or|ed|go|belau|cloudns|x443)\.)?pw)|(?-mix:(?:(?-mix:com|coop|edu|gov|mil|net|org)\.)?py)|(?-mix:(?:(?-mix:com|edu|gov|mil|name|net|org|sch|blogspot)\.)?qa)|(?-mix:(?:(?-mix:asso|com|nom|blogspot)\.)?re)|(?-mix:(?:(?-mix:arts|com|firm|info|nom|nt|org|rec|store|tm|www|co|shop|blogspot|barsy)\.)?ro)|(?-mix:(?:(?-mix:ac|co|edu|gov|in|org|(?-mix:(?:shop\.)?brendly)|blogspot|ua|ox)\.)?rs)|(?-mix:(?:(?-mix:ac|edu|gov|int|mil|test|eurodir|adygeya|bashkiria|bir|cbg|com|dagestan|grozny|kalmykia|kustanai|marine|mordovia|msk|mytis|nalchik|nov|pyatigorsk|spb|vladikavkaz|vladimir|blogspot|na4u|mircloud|(?-mix:(?:jelastic\.)?regruhosting)|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?hosting)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?landing)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?spectrum)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?vps))\.)?myjino)|(?-mix:(?:hb\.)?cldmail)|(?-mix:(?:vps\.)?mcdir)|mcpre|net|org|pp|lk3|ras)\.)?ru)|(?-mix:(?:(?-mix:ac|co|coop|gov|mil|net|org)\.)?rw)|(?-mix:(?:(?-mix:com|net|org|gov|med|pub|edu|sch)\.)?sa)|(?-mix:(?:(?-mix:com|edu|gov|net|org)\.)?sb)|(?-mix:(?:(?-mix:com|gov|net|org|edu)\.)?sc)|(?-mix:(?:(?-mix:com|net|org|edu|med|tv|gov|info)\.)?sd)|(?-mix:(?:(?-mix:a|ac|b|bd|brand|c|d|e|f|fh|fhsk|fhv|g|h|i|k|komforb|kommunalforbund|komvux|l|lanbib|m|n|naturbruksgymn|o|org|p|parti|pp|press|r|s|t|tm|u|w|x|y|z|com|blogspot|conf|iopsys|itcouldbewor|myspreadshop|(?-mix:(?:su\.)?paba))\.)?se)|(?-mix:(?:(?-mix:com|net|org|gov|edu|per|blogspot|enscaled)\.)?sg)|(?-mix:(?:(?-mix:com|net|gov|org|mil|bip|hashbang|(?-mix:(?:(?-mix:bc|ent|eu|us)\.)?platform)|now|vxl|wedeploy)\.)?sh)|(?-mix:(?:(?-mix:gitapp|gitpage|blogspot)\.)?si)|sj|(?-mix:(?:blogspot\.)?sk)|(?-mix:(?:(?-mix:com|net|edu|gov|org)\.)?sl)|sm|(?-mix:(?:(?-mix:art|com|edu|gouv|org|perso|univ|blogspot)\.)?sn)|(?-mix:(?:(?-mix:com|edu|gov|me|net|org|sch)\.)?so)|sr|(?-mix:(?:(?-mix:biz|com|edu|gov|me|net|org|sch)\.)?ss)|(?-mix:(?:(?-mix:co|com|consulado|edu|embaixada|mil|net|org|principe|saotome|store|noho)\.)?st)|(?-mix:(?:(?-mix:abkhazia|adygeya|aktyubinsk|arkhangelsk|armenia|ashgabad|azerbaijan|balashov|bashkiria|bryansk|bukhara|chimkent|dagestan|east\-kazakhstan|exnet|georgia|grozny|ivanovo|jambyl|kalmykia|kaluga|karacol|karaganda|karelia|khakassia|krasnodar|kurgan|kustanai|lenug|mangyshlak|mordovia|msk|murmansk|nalchik|navoi|north\-kazakhstan|nov|obninsk|penza|pokrovsk|sochi|spb|tashkent|termez|togliatti|troitsk|tselinograd|tula|tuva|vladikavkaz|vladimir|vologda)\.)?su)|(?-mix:(?:(?-mix:com|edu|gob|org|red)\.)?sv)|(?-mix:(?:gov\.)?sx)|(?-mix:(?:(?-mix:edu|gov|net|mil|com|org)\.)?sy)|(?-mix:(?:(?-mix:co|ac|org)\.)?sz)|(?-mix:(?:(?-mix:ch|me|we)\.)?tc)|(?-mix:(?:blogspot\.)?td)|tel|(?-mix:(?:sch\.)?tf)|tg|(?-mix:(?:(?-mix:ac|co|go|in|mi|net|or|online|shop)\.)?th)|(?-mix:(?:(?-mix:ac|biz|co|com|edu|go|gov|int|mil|name|net|nic|org|test|web)\.)?tj)|tk|(?-mix:(?:gov\.)?tl)|(?-mix:(?:(?-mix:com|co|org|net|nom|gov|mil|edu)\.)?tm)|(?-mix:(?:(?-mix:com|ens|fin|gov|ind|info|intl|mincom|nat|net|org|perso|tourism|orangecloud)\.)?tn)|(?-mix:(?:(?-mix:com|gov|net|org|edu|mil|611|oya|rdv|vpnplus|(?-mix:(?:direct\.)?quickconnect)|nyan)\.)?to)|(?-mix:(?:(?-mix:av|bbs|bel|biz|(?-mix:(?:blogspot\.)?com)|dr|edu|gen|gov|info|mil|k12|kep|name|net|org|pol|tel|tsk|tv|web|(?-mix:(?:gov\.)?nc))\.)?tr)|(?-mix:(?:(?-mix:co|com|org|net|biz|info|pro|int|coop|jobs|mobi|travel|museum|aero|name|gov|edu)\.)?tt)|(?-mix:(?:(?-mix:dyndns|better\-than|on\-the\-web|worse\-than)\.)?tv)|(?-mix:(?:(?-mix:edu|gov|mil|(?-mix:(?:mymailer\.)?com)|net|org|idv|game|ebiz|club|網路|組織|商業|url|blogspot)\.)?tw)|(?-mix:(?:(?-mix:ac|co|go|hotel|info|me|mil|mobi|ne|or|sc|tv)\.)?tz)|(?-mix:(?:(?-mix:com|edu|gov|in|net|org|cherkassy|cherkasy|chernigov|chernihiv|chernivtsi|chernovtsy|ck|cn|cr|crimea|cv|dn|dnepropetrovsk|dnipropetrovsk|donetsk|dp|if|ivano\-frankivsk|kh|kharkiv|kharkov|kherson|khmelnitskiy|khmelnytskyi|kiev|kirovograd|km|kr|krym|ks|kv|kyiv|lg|lt|lugansk|lutsk|lv|lviv|mk|mykolaiv|nikolaev|od|odesa|odessa|pl|poltava|rivne|rovno|rv|sb|sebastopol|sevastopol|sm|sumy|te|ternopil|uz|uzhgorod|vinnica|vinnytsia|vn|volyn|yalta|zaporizhzhe|zaporizhzhia|zhitomir|zhytomyr|zp|zt|cc|inf|ltd|cx|biz|co|pp|v)\.)?ua)|(?-mix:(?:(?-mix:co|or|ac|sc|go|ne|com|org|blogspot)\.)?ug)|(?-mix:(?:(?-mix:ac|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:dh|vm)\.)?bytemark)|blogspot|(?-mix:(?:j\.)?layershift)|barsy|barsyonline|(?-mix:(?:cust\.)?retrosnub)|nh\-serv|no\-ip|wellbeingzone|adimo|myspreadshop|gwiddle)\.)?co)|(?-mix:(?:(?-mix:campaign|service|api|homeoffice)\.)?gov)|ltd|me|net|nhs|(?-mix:(?:(?-mix:glug|lug|lugs|affinitylottery|raffleentry|weeklylottery)\.)?org)|plc|police|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?sch)|conn|copro|hosp|independent\-commission|independent\-inquest|independent\-inquiry|independent\-panel|independent\-review|public\-inquiry|royal\-commission|pymnt|barsy)\.)?uk)|(?-mix:(?:(?-mix:dni|fed|isa|kids|nsn|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ak)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?al)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ar)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?as)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?az)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ca)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?co)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ct)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?dc)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?de)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?fl)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ga)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?gu)|(?-mix:(?:(?-mix:cc|lib)\.)?hi)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ia)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?id)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?il)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?in)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ks)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ky)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?la)|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:pvt|chtr|paroch)\.)?k12)|cc|lib)\.)?ma)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?md)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?me)|(?-mix:(?:(?-mix:k12|cc|lib|ann\-arbor|cog|dst|eaton|gen|mus|tec|washtenaw)\.)?mi)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?mn)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?mo)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ms)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?mt)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?nc)|(?-mix:(?:(?-mix:cc|lib)\.)?nd)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ne)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?nh)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?nj)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?nm)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?nv)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ny)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?oh)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ok)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?or)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?pa)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?pr)|(?-mix:(?:(?-mix:cc|lib)\.)?ri)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?sc)|(?-mix:(?:(?-mix:cc|lib)\.)?sd)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?tn)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?tx)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?ut)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?vi)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?vt)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?va)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?wa)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?wi)|(?-mix:(?:cc\.)?wv)|(?-mix:(?:(?-mix:k12|cc|lib)\.)?wy)|graphox|cloudns|drud|is\-by|land\-4\-sale|stuff\-4\-sale|(?-mix:(?:phx\.)?enscaled)|mircloud|freeddns|golffan|noip|pointto|platterp)\.)?us)|(?-mix:(?:(?-mix:(?-mix:(?:blogspot\.)?com)|edu|gub|mil|net|org)\.)?uy)|(?-mix:(?:(?-mix:co|com|net|org)\.)?uz)|va|(?-mix:(?:(?-mix:com|net|org|gov|mil|edu|(?-mix:(?:d\.)?gv)|0e)\.)?vc)|(?-mix:(?:(?-mix:arts|bib|co|com|e12|edu|firm|gob|gov|info|int|mil|net|nom|org|rar|rec|store|tec|web)\.)?ve)|(?-mix:(?:at\.)?vg)|(?-mix:(?:(?-mix:co|com|k12|net|org)\.)?vi)|(?-mix:(?:(?-mix:com|net|org|edu|gov|int|ac|biz|info|name|pro|health|blogspot)\.)?vn)|(?-mix:(?:(?-mix:com|edu|net|org|cn|blog|dev|me)\.)?vu)|(?-mix:(?:(?-mix:biz|sch)\.)?wf)|(?-mix:(?:(?-mix:com|net|org|gov|edu|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?advisor)|cloud66|dyndns|mypets)\.)?ws)|(?-mix:(?:org\.)?yt)|امارات|հայ|বাংলা|бг|البحرين|бел|中国|中國|الجزائر|مصر|ею|ευ|موريتانيا|გე|ελ|(?-mix:(?:(?-mix:公司|教育|政府|個人|網絡|組織)\.)?香港)|ಭಾರತ|ଭାରତ|ভাৰত|भारतम्|भारोत|ڀارت|ഭാരതം|भारत|بارت|بھارت|భారత్|ભારત|ਭਾਰਤ|ভারত|இந்தியா|ایران|ايران|عراق|الاردن|한국|қаз|ລາວ|ලංකා|இலங்கை|المغرب|мкд|мон|澳門|澳门|مليسيا|عمان|پاکستان|پاكستان|فلسطين|(?-mix:(?:(?-mix:пр|орг|обр|од|упр|ак)\.)?срб)|рф|قطر|السعودية|السعودیة|السعودیۃ|السعوديه|سودان|新加坡|சிங்கப்பூர்|سورية|سوريا|(?-mix:(?:(?-mix:ศึกษา|ธุรกิจ|รัฐบาล|ทหาร|เน็ต|องค์กร)\.)?ไทย)|تونس|台灣|台湾|臺灣|укр|اليمن|xxx|(?-mix:(?:(?-mix:com|edu|gov|net|mil|org)\.)?ye)|(?-mix:(?:(?-mix:ac|agric|alt|(?-mix:(?:blogspot\.)?co)|edu|gov|grondar|law|mil|net|ngo|nic|nis|nom|org|school|tm|web)\.)?za)|(?-mix:(?:(?-mix:ac|biz|co|com|edu|gov|info|mil|net|org|sch)\.)?zm)|(?-mix:(?:(?-mix:ac|co|gov|mil|org)\.)?zw)|aaa|aarp|abarth|abb|abbott|abbvie|abc|able|abogado|abudhabi|(?-mix:(?:official\.)?academy)|accenture|accountant|accountants|aco|actor|adac|ads|adult|aeg|aetna|afl|africa|agakhan|agency|aig|airbus|airforce|airtel|akdn|alfaromeo|alibaba|alipay|allfinanz|allstate|ally|alsace|alstom|amazon|americanexpress|americanfamily|amex|amfam|amica|amsterdam|analytics|android|anquan|anz|aol|apartments|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?beget)|clerk|clerkstage|wnext|platform0|deta|ondigitalocean|encr|edgecompute|fireweb|onflashdrive|framer|(?-mix:(?:a\.)?run)|web|hasura|loginline|netlify|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?developer)|noop|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?northflank)|telebit|typedream|vercel|bookonline)\.)?app)|apple|aquarelle|arab|aramco|archi|army|art|arte|asda|associates|athleta|attorney|auction|audi|audible|audio|auspost|author|auto|autos|avianca|aws|axa|azure|baby|baidu|banamex|bananarepublic|band|bank|bar|barcelona|barclaycard|barclays|barefoot|bargains|baseball|(?-mix:(?:(?-mix:aus|nz)\.)?basketball)|bauhaus|bayern|bbc|bbt|bbva|bcg|bcn|beats|beauty|beer|bentley|berlin|best|bestbuy|bet|bharti|bible|bid|bike|bing|bingo|bio|black|blackfriday|blockbuster|blog|bloomberg|blue|bms|bmw|bnpparibas|boats|boehringer|bofa|bom|bond|boo|book|booking|bosch|bostik|boston|bot|boutique|box|bradesco|bridgestone|broadway|broker|brother|brussels|bugatti|build|(?-mix:(?:cloudsite\.)?builders)|(?-mix:(?:co\.)?business)|buy|buzz|bzh|cab|cafe|cal|call|calvinklein|cam|camera|camp|cancerresearch|canon|capetown|capital|capitalone|car|caravan|cards|care|career|careers|cars|(?-mix:(?:(?-mix:(?:ui\.)?nabu)\.)?casa)|case|cash|casino|catering|catholic|cba|cbn|cbre|cbs|center|ceo|cern|cfa|cfd|chanel|channel|charity|chase|chat|cheap|chintai|christmas|chrome|church|cipriani|circle|cisco|citadel|citi|citic|city|cityeats|claims|cleaning|click|clinic|clinique|clothing|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?banzai)|elementor|(?-mix:(?:eu\.)?encoway)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?statics)|ravendb|(?-mix:(?:es-1\.)?axarnet)|diadem|(?-mix:(?:vip\.)?jelastic)|jele|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:(?:it1\.)?eur)\.)?aruba)|it1)\.)?jenv-aruba)|(?-mix:(?:cs\.)?keliweb)|(?-mix:(?:(?-mix:tn|uk)\.)?oxa)|(?-mix:(?:uk\.)?primetel)|(?-mix:(?:(?-mix:ca|uk|us)\.)?reclaim)|(?-mix:(?:(?-mix:ch|de)\.)?trendhosting)|jotelulu|kuleuven|linkyard|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?magentosite)|perspecta|vapor|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?on-rancher)|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:fr\-par\-1|fr\-par\-2|nl\-ams\-1)\.)?baremetal)|(?-mix:(?:(?-mix:(?-mix:(?:functions\.)?fnc)|(?-mix:(?:nodes\.)?k8s)|s3|s3\-website|whm)\.)?fr-par)|(?-mix:(?:(?-mix:priv|pub)\.)?instances)|k8s|(?-mix:(?:(?-mix:(?-mix:(?:nodes\.)?k8s)|s3|s3\-website|whm)\.)?nl-ams)|(?-mix:(?:(?-mix:(?-mix:(?:nodes\.)?k8s)|s3|s3\-website)\.)?pl-waw)|scalebook|smartlabeling)\.)?scw)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?sensiosite)|trafficplex|urown|voorloper)\.)?cloud)|(?-mix:(?:(?-mix:cloudns|jele|barsy|pony)\.)?club)|clubmed|coach|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?owo)\.)?codes)|coffee|college|cologne|comcast|commbank|(?-mix:(?:(?-mix:nog|ravendb|myforum)\.)?community)|company|compare|computer|comsec|condos|construction|consulting|contact|contractors|cooking|cookingchannel|(?-mix:(?:(?-mix:elementor|de)\.)?cool)|corsica|country|coupon|coupons|courses|cpa|credit|creditcard|creditunion|cricket|crown|crs|cruise|cruises|cuisinella|cymru|cyou|dabur|dad|dance|data|date|dating|datsun|day|dclk|dds|deal|dealer|deals|degree|delivery|dell|deloitte|delta|democrat|dental|dentist|desi|(?-mix:(?:bss\.)?design)|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?lcl)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?lclstage)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?stg)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?stgstage)|pages|workers|curv|deno|deno\-staging|deta|fly|githubpreview|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?gateway)|iserv|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?user)\.)?localcert)|loginline|mediatech|platter\-app|shiftcrypto|vercel|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?webhare))\.)?dev)|dhl|diamonds|diet|(?-mix:(?:(?-mix:(?:london\.)?cloudapps)\.)?digital)|direct|directory|discount|discover|dish|diy|dnp|docs|doctor|dog|domains|dot|download|drive|dtv|dubai|dunlop|dupont|durban|dvag|dvr|(?-mix:(?:(?-mix:(?:(?-mix:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?bzz))\.)?dapps)\.)?earth)|eat|eco|edeka|(?-mix:(?:co\.)?education)|email|emerck|energy|engineer|engineering|enterprises|epson|equipment|ericsson|erni|esq|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?compute)\.)?estate)|etisalat|eurovision|(?-mix:(?:(?-mix:(?:user\.)?party)\.)?eus)|(?-mix:(?:(?-mix:koobin|co)\.)?events)|exchange|expert|exposed|express|extraspace|fage|fail|fairwinds|(?-mix:(?:ybo\.)?faith)|family|fan|fans|(?-mix:(?:storj\.)?farm)|farmers|(?-mix:(?:of\.)?fashion)|fast|fedex|feedback|ferrari|ferrero|fiat|fidelity|fido|film|final|finance|(?-mix:(?:co\.)?financial)|fire|firestone|firmdale|fish|fishing|fit|fitness|flickr|flights|flir|florist|flowers|fly|foo|food|foodnetwork|football|ford|forex|forsale|forum|foundation|fox|free|fresenius|frl|frogans|frontdoor|frontier|ftr|fujitsu|fun|fund|furniture|futbol|fyi|gal|gallery|gallo|gallup|game|games|gap|garden|gay|gbiz|(?-mix:(?:cnpy\.)?gdn)|gea|gent|genting|george|ggee|gift|gifts|gives|giving|glass|gle|global|globo|gmail|gmbh|gmo|gmx|godaddy|gold|goldpoint|golf|goo|goodyear|(?-mix:(?:(?-mix:cloud|translate|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?usercontent))\.)?goog)|google|gop|got|grainger|graphics|gratis|green|gripe|grocery|(?-mix:(?:discourse\.)?group)|guardian|gucci|guge|guide|guitars|guru|hair|hamburg|hangout|haus|hbo|hdfc|hdfcbank|(?-mix:(?:hra\.)?health)|healthcare|help|helsinki|here|hermes|hgtv|hiphop|hisamitsu|hitachi|hiv|hkt|hockey|holdings|holiday|homedepot|homegoods|homes|homesense|honda|horse|hospital|(?-mix:(?:(?-mix:cloudaccess|freesite|fastvps|myfast|tempurl|wpmudev|jele|mircloud|pcloud|half)\.)?host)|(?-mix:(?:opencraft\.)?hosting)|hot|hoteles|hotels|hotmail|house|how|hsbc|hughes|hyatt|hyundai|ibm|icbc|ice|icu|ieee|ifm|ikano|imamat|imdb|immo|immobilien|inc|industries|infiniti|ing|ink|institute|insurance|insure|international|intuit|investments|ipiranga|irish|ismaili|ist|istanbul|itau|itv|jaguar|java|jcb|jeep|jetzt|jewelry|jio|jll|jmp|jnj|joburg|jot|joy|jpmorgan|jprs|juegos|juniper|kaufen|kddi|kerryhotels|kerrylogistics|kerryproperties|kfh|kia|kids|kim|kinder|kindle|kitchen|kiwi|koeln|komatsu|kosher|kpmg|kpn|(?-mix:(?:(?-mix:co|edu)\.)?krd)|kred|kuokgroup|kyoto|lacaixa|lamborghini|lamer|lancaster|lancia|(?-mix:(?:(?-mix:(?:(?-mix:dev|sites)\.)?static)\.)?land)|landrover|lanxess|lasalle|lat|latino|latrobe|law|lawyer|lds|lease|leclerc|lefrak|legal|lego|lexus|lgbt|lidl|life|lifeinsurance|lifestyle|lighting|like|lilly|limited|limo|lincoln|linde|(?-mix:(?:(?-mix:cyon|mypep|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?dweb))\.)?link)|lipsy|(?-mix:(?:hlx\.)?live)|living|llc|llp|loan|loans|locker|locus|loft|(?-mix:(?:omg\.)?lol)|(?-mix:(?:(?-mix:in|of)\.)?london)|lotte|lotto|love|lpl|lplfinancial|ltd|ltda|lundbeck|luxe|luxury|macys|madrid|maif|maison|makeup|man|(?-mix:(?:router\.)?management)|mango|map|market|(?-mix:(?:(?-mix:from|with)\.)?marketing)|markets|marriott|marshalls|maserati|mattel|mba|mckinsey|med|media|meet|melbourne|meme|memorial|(?-mix:(?:(?-mix:for|repair)\.)?men)|(?-mix:(?:barsy\.)?menu)|merckmsd|miami|microsoft|mini|mint|mit|mitsubishi|mlb|mls|mma|mobile|moda|moe|moi|(?-mix:(?:(?-mix:and|for)\.)?mom)|monash|money|monster|mormon|mortgage|moscow|moto|motorcycles|mov|movie|msd|mtn|mtr|music|mutual|nab|nagoya|natura|navy|nba|nec|netbank|netflix|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?alces)|co|arvo|azimuth|tlon)\.)?network)|neustar|new|(?-mix:(?:noticeable\.)?news)|next|nextdirect|nexus|nfl|ngo|nhk|nico|nike|nikon|ninja|nissan|nissay|nokia|northwesternmutual|norton|now|nowruz|nowtv|nra|nrw|ntt|nyc|obi|observer|office|okinawa|olayan|olayangroup|oldnavy|ollo|omega|(?-mix:(?:(?-mix:(?-mix:(?:staging\.)?onred)|for|under|service|homelink)\.)?one)|ong|onl|(?-mix:(?:(?-mix:eero|eero\-stage|barsy)\.)?online)|ooo|open|oracle|(?-mix:(?:tech\.)?orange)|organic|origins|osaka|otsuka|ott|(?-mix:(?:nerdpol\.)?ovh)|(?-mix:(?:(?-mix:hlx|hlx3|translated|codeberg|pdns|plesk|prvcy|rocky|magnet)\.)?page)|panasonic|paris|pars|partners|parts|(?-mix:(?:ybo\.)?party)|passagens|pay|pccw|pet|pfizer|pharmacy|phd|philips|phone|photo|photography|photos|physio|pics|pictet|(?-mix:(?:1337\.)?pictures)|pid|pin|ping|pink|pioneer|pizza|(?-mix:(?:co\.)?place)|play|playstation|plumbing|plus|pnc|pohl|poker|politie|(?-mix:(?:indie\.)?porn)|pramerica|praxi|press|prime|prod|productions|prof|progressive|promo|properties|property|protection|pru|prudential|(?-mix:(?:barsy\.)?pub)|pwc|qpon|quebec|quest|racing|radio|read|realestate|realtor|realty|recipes|red|redstone|redumbrella|rehab|reise|reisen|reit|reliance|ren|rent|rentals|repair|report|republican|rest|restaurant|(?-mix:(?:ybo\.)?review)|reviews|rexroth|rich|richardli|ricoh|ril|rio|(?-mix:(?:clan\.)?rip)|rocher|(?-mix:(?:(?-mix:myddns|lima\-city|webspace)\.)?rocks)|rodeo|rogers|room|rsvp|rugby|ruhr|(?-mix:(?:(?-mix:hs|development|ravendb|servers|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?build)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?code)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?database)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?migration)|onporter|repl)\.)?run)|rwe|ryukyu|saarland|safe|safety|sakura|(?-mix:(?:for\.)?sale)|salon|samsclub|samsung|sandvik|sandvikcoromant|sanofi|sap|sarl|sas|save|saxo|sbi|sbs|sca|scb|schaeffler|schmidt|scholarships|school|schule|schwarz|(?-mix:(?:ybo\.)?science)|(?-mix:(?:(?-mix:edu|(?-mix:(?:service\.)?gov))\.)?scot)|search|seat|secure|security|seek|select|sener|(?-mix:(?:loginline\.)?services)|ses|seven|sew|sex|sexy|sfr|shangrila|sharp|shaw|shell|shia|shiksha|shoes|(?-mix:(?:(?-mix:base|hoplix|barsy)\.)?shop)|shopping|shouji|show|showtime|silk|sina|singles|(?-mix:(?:(?-mix:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?cloudera)|cyon|fnwk|folionetwork|fastvps|jele|lelux|loginline|barsy|mintere|omniwe|opensocial|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?platformsh)|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?tst)|byen|srht|novecore)\.)?site)|ski|skin|sky|skype|sling|smart|smile|sncf|soccer|social|softbank|software|sohu|solar|(?-mix:(?:(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?diher)\.)?solutions)|song|sony|soy|spa|(?-mix:(?:(?-mix:myfast|uber|xs4all)\.)?space)|sport|spot|srl|stada|staples|star|statebank|statefarm|stc|stcgroup|stockholm|storage|(?-mix:(?:(?-mix:sellfy|shopware|storebase)\.)?store)|stream|studio|study|style|sucks|supplies|supply|(?-mix:(?:barsy\.)?support)|surf|surgery|suzuki|swatch|swiss|sydney|(?-mix:(?:knightpoint\.)?systems)|tab|taipei|talk|taobao|target|tatamotors|tatar|tattoo|tax|taxi|tci|tdk|(?-mix:(?:(?-mix:discourse|jelastic)\.)?team)|tech|(?-mix:(?:co\.)?technology)|temasek|tennis|teva|thd|theater|theatre|tiaa|tickets|tienda|tiffany|tips|tires|tirol|tjmaxx|tjx|tkmaxx|tmall|(?-mix:(?:prequalifyme\.)?today)|tokyo|tools|(?-mix:(?:(?-mix:now\-dns|ntdll)\.)?top)|toray|toshiba|total|tours|town|toyota|toys|(?-mix:(?:ybo\.)?trade)|trading|training|travel|travelchannel|travelers|travelersinsurance|trust|trv|tube|tui|tunes|tushu|tvs|ubank|ubs|unicom|university|uno|uol|ups|vacations|vana|vanguard|vegas|ventures|verisign|versicherung|vet|viajes|video|vig|viking|villas|vin|vip|virgin|visa|vision|viva|vivo|vlaanderen|vodka|volkswagen|volvo|vote|voting|voto|voyage|vuelos|wales|walmart|walter|wang|wanggou|watch|watches|weather|weatherchannel|webcam|weber|website|wedding|weibo|weir|whoswho|wien|wiki|williamhill|(?-mix:(?:that\.)?win)|windows|wine|winners|wme|wolterskluwer|woodside|(?-mix:(?:(?-mix:from|to)\.)?work)|works|world|wow|wtc|wtf|xbox|xerox|xfinity|xihuan|xin|कॉम|セール|佛山|慈善|集团|在线|点看|คอม|八卦|موقع|公益|公司|香格里拉|网站|移动|我爱你|москва|католик|онлайн|сайт|联通|קום|时尚|微博|淡马锡|ファッション|орг|नेट|ストア|アマゾン|삼성|商标|商店|商城|дети|ポイント|新闻|家電|كوم|中文网|中信|娱乐|谷歌|電訊盈科|购物|クラウド|通販|网店|संगठन|餐厅|网络|ком|亚马逊|诺基亚|食品|飞利浦|手机|ارامكو|العليان|اتصالات|بازار|ابوظبي|كاثوليك|همراه|닷컴|政府|شبكة|بيتك|عرب|机构|组织机构|健康|招聘|(?-mix:(?:(?-mix:биз|ком|крым|мир|мск|орг|самара|сочи|спб|я)\.)?рус)|大拿|みんな|グーグル|世界|書籍|网址|닷넷|コム|天主教|游戏|vermögensberater|vermögensberatung|企业|信息|嘉里大酒店|嘉里|广东|政务|(?-mix:(?:(?-mix:blogsite|localzone|crafting|zapto|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?telebit))\.)?xyz)|yachts|yahoo|yamaxun|yandex|yodobashi|yoga|yokohama|you|youtube|yun|zappos|zara|zero|zip|(?-mix:(?:(?-mix:cloud66|hs|(?-mix:(?:(?-mix:[a-z0-9]+(?:-[a-z0-9]+)*)\.)?triton)|lima)\.)?zone)|zuerich)(?=[^\.a-z0-9-]|$)/

        # Regular expression used to find domain names in text
        #
        # @since 1.0.0
        DOMAIN = /(?<=[^a-zA-Z0-9_-]|^)[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*\.#{PUBLIC_SUFFIX}(?=[^a-zA-Z0-9\._-]|$)/

        # Regular expression used to find host-names in text
        HOST_NAME = /(?<=[^a-zA-Z0-9\._-]|^)(?:[a-zA-Z0-9_-]{1,63}\.)*#{DOMAIN}/

        scheme           = "[a-zA-Z][\\-+.a-zA-Z\\d]*"
        reserved_chars   = ";/?:@&=+$,\\[\\]"
        unreserved_chars = "\\-_.!~*'()a-zA-Z\\d"
        escaped_char     = "%[a-fA-F\\d]{2}"
        user_info        = "(?:[#{unreserved_chars};:&=+$,]|#{escaped_char})*"
        reg_name         = "(?:[#{unreserved_chars}$,;:@&=+]|#{escaped_char})+"
        pchar            = "(?:[#{unreserved_chars}:@&=+$,]|#{escaped_char})"
        param            = "#{pchar}*"
        path_segment     = "#{pchar}*(?:;#{param})*"
        path_segments    = "#{path_segment}(?:/#{path_segment})*"
        abs_path         = "/#{path_segments}"
        char             = "(?:[#{unreserved_chars}#{reserved_chars}]|#{escaped_char})"
        query            = "#{char}*"
        fragment         = "#{char}*"

        # Regular expression to match URIs in text
        #
        # @since 1.0.0
        URI = %r{
          #{scheme}:                                         (?# 1: scheme)
          (?:
            //
            (?:
              (?:#{user_info}@)?                             (?# 1: userinfo)
              (?:#{HOST_NAME}|#{IPV4_ADDR}|\[#{IPV6_ADDR}\]) (?# 2: host)
              (?::\d*)?                                      (?# 3: port)
              |#{reg_name}                                   (?# 4: registry)
            )
          )?
          (?:#{abs_path})?                                   (?# 6: abs_path)
          (?:\?#{query})?                                    (?# 7: query)
          (?:\##{fragment})?                                 (?# 8: fragment)
        }x

        # Regular expression to match URLs in text
        #
        # @since 1.0.0
        URL = %r{
          #{scheme}:                                         (?# 1: scheme)
          (?:
            //
            (?:
              (?:#{user_info}@)?                             (?# 1: userinfo)
              (?:#{HOST_NAME}|#{IPV4_ADDR}|\[#{IPV6_ADDR}\]) (?# 2: host)
              (?::\d*)?                                      (?# 3: port)
              |#{reg_name}                                   (?# 4: registry)
            )
          )
          (?:#{abs_path})?                                   (?# 6: abs_path)
          (?:\?#{query})?                                    (?# 7: query)
          (?:\##{fragment})?                                 (?# 8: fragment)
        }x

        #
        # @group PII Patterns
        #

        # Regular expression to match a word in the username of an email address
        USER_NAME = /[A-Za-z](?:[A-Za-z0-9]*[\._-])*[A-Za-z0-9]+/

        # Regular expression to find email addresses in text
        #
        # @since 1.0.0
        EMAIL_ADDRESS = /#{USER_NAME}\@#{HOST_NAME}/

        # @see EMAIL_ADDRESS
        EMAIL_ADDR = EMAIL_ADDRESS

        # Regular expression to match `.`, ` AT `, ` at `, `[AT]`, `[at]`,
        # `<AT>`, `<at>`, `{AT}`, `{at}`, `(AT)`, `(at)`.
        #
        # @since 1.0.0
        OBFUSCATED_EMAIL_AT = /\@|\s+(?:AT|at)\s+|\s*\[(?:AT|at)\]\s*|\s*\<(?:AT|at)\>\s*|\s*\{(?:AT|at)\}\s*|\s*\((?:AT|at)\)\s*/

        # Regular expression to match `.`, ` DOT `, ` dot `, `[DOT]`, `[dot]`,
        # `<DOT>`, `<dot>`, `{DOT}`, `{dot}`, `(DOT)`, `(dot)`.
        #
        # @since 1.0.0
        OBFUSCATED_EMAIL_DOT = /\.|\s+(?:DOT|dot)\s+|\s*\[(?:DOT|dot)\]\s*|\s*\<(?:DOT|dot)\>\s*|\s*\{(?:DOT|dot)\}\s*|\s*\((?:DOT|dot)\)\s*/

        # Regular expression to find obfuscated email addresses in text.
        #
        # @since 1.0.0
        OBFUSCATED_EMAIL_ADDRESS = /[a-zA-Z][a-zA-Z0-9_-]*(?:#{OBFUSCATED_EMAIL_DOT}[a-zA-Z][a-zA-Z0-9_-]*)*#{OBFUSCATED_EMAIL_AT}(?:[a-zA-Z0-9_-]{1,63}#{OBFUSCATED_EMAIL_DOT})*[a-zA-Z0-9]+(?:-[a-zA-Z0-9]+)*#{OBFUSCATED_EMAIL_DOT}#{PUBLIC_SUFFIX}(?=[^a-zA-Z0-9\._-]|$)/

        # @see OBFUSCATED_EMAIL_ADDRESS
        OBFUSCATED_EMAIL_ADDR = OBFUSCATED_EMAIL_ADDRESS

        # Regular expression to find phone numbers in text
        #
        # @since 0.5.0
        PHONE_NUMBER = /(?:\d[ \-\.]?)?(?:\d{3}[ \-\.]?)?\d{3}[ \-\.]?\d{4}(?:x\d+)?/

        # Regular expression to find Social Security Numbers (SSNs) in text
        #
        # @since 1.0.0
        SSN = /(?<=[^\d]|^)\d{3}-\d{2}-\d{4}(?=[^\d]|$)/

        # Regular expression to find AMEX card numbers in text
        #
        # @since 1.0.0
        AMEX_CC = /(?<=[^\d]|^)3[47][0-9]{13}(?=[^\d]|$)/

        # Regular expression to find Discord card numbers in text
        #
        # @since 1.0.0
        DISCOVER_CC = /(?<=[^\d]|^)(?:65[4-9][0-9]{13}|64[4-9][0-9]{13}|6011[0-9]{12}|(?:622(?:12[6-9]|1[3-9][0-9]|[2-8][0-9][0-9]|9[01][0-9]|92[0-5])[0-9]{10}))(?=[^\d]|$)/

        # Regular expression to find Masterdard numbers in text
        #
        # @since 1.0.0
        MASTERCARD_CC = /(?<=[^\d]|^)(?:5[1-5][0-9]{14}|2(?:22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[0-1][0-9]{13}|720[0-9]{12}))(?=[^\d]|$)/

        # Regular expression to find VISA numbers in text
        #
        # @since 1.0.0
        VISA_CC = /(?<=[^\d]|^)4[0-9]{12}(?:[0-9]{3})?(?=[^\d]|$)/

        # Regular expression to find VISA Masterdard numbers in text
        #
        # @since 1.0.0
        VISA_MASTERCARD_CC = /(?<=[^\d]|^)(?:4[0-9]{12}(?:[0-9]{3})?|5[1-5][0-9]{14})(?=[^\d]|$)/

        # Regular expression to find Credit Card (CC) numbers in text
        #
        # @since 1.0.0
        CC = /#{VISA_CC}|#{VISA_MASTERCARD_CC}|#{MASTERCARD_CC}|#{DISCOVER_CC}|#{AMEX_CC}/

        #
        # @group Source Code Patterns
        #

        # Regular expression to find deliminators in text
        #
        # @since 0.4.0
        DELIM = /[;&\n\r]/

        # Regular expression to find identifier in text
        #
        # @since 0.4.0
        IDENTIFIER = /[_]*[a-zA-Z]+[a-zA-Z0-9_-]*/

        # Regular expression to find all variable names in text.
        #
        # @see IDENTIFIER
        #
        # @since 1.0.0
        VARIABLE_NAME = /#{IDENTIFIER}(?=\s*=\s*[^;\n]+)/

        # Regular expression to find all variable assignments in text.
        #
        # @see VARIABLE_NAME
        #
        # @since 1.0.0
        VARIABLE_ASSIGNMENT = /#{IDENTIFIER}\s*=\s*[^;\n]+/

        # Regular expression to find all function names in text.
        #
        # @see IDENTIFIER
        #
        # @since 1.0.0
        FUNCTION_NAME = /#{IDENTIFIER}(?=\()/

        # Regular expression to find all double quoted strings in text.
        #
        # @since 1.0.0
        DOUBLE_QUOTED_STRING = /"(?:\\.|[^"])*"/

        # Regular expression to find all single quoted strings in text.
        #
        # @since 1.0.0
        SINGLE_QUOTED_STRING = /'(?:\\[\\']|[^'])*'/

        # Regular expression to find all single or double quoted strings in
        # text.
        #
        # @since 1.0.0
        STRING = /#{DOUBLE_QUOTED_STRING}|#{SINGLE_QUOTED_STRING}/

        # Regular expression to find all Base64 encoded strings in the text.
        #
        # @since 1.0.0
        BASE64 = /(?:[A-Za-z0-9+\/]{4}\n?)+(?:[A-Za-z0-9+\/]{2}==\n?|[A-Za-z0-9+\/]{3}=\n?)?|[A-Za-z0-9+\/]{2}==\n?|[A-Za-z0-9+\/]{3}=\n?/

        # Regular expression to match any single-line or multi-line C-style
        # comments.
        #
        # @since 1.0.0
        C_STYLE_COMMENT = %r{(?://(?:[^\r\n]*)(?:\r?\n|\z))+|(?:/\*[\s\S]*?\*/)}

        # Regular expression to match any single-line or multi-line C comments.
        #
        # @since 1.0.0
        C_COMMENT = C_STYLE_COMMENT

        # Regular expression to match any single-line or multi-line C++
        # comments.
        #
        # @since 1.0.0
        CPP_COMMENT = C_STYLE_COMMENT

        # Regular expression to match any single-line or multi-line Java
        # comments.
        #
        # @since 1.0.0
        JAVA_COMMENT = C_STYLE_COMMENT

        # Regular expression to match any single-line or multi-line JavaScript
        # comments.
        #
        # @since 1.0.0
        JAVASCRIPT_COMMENT = C_STYLE_COMMENT

        # Regular expression to match any single-line or multi-line shell-style
        # comments.
        #
        # @since 1.0.0
        SHELL_STYLE_COMMENT = /(?:#(?:[^\r\n]*)(?:\r?\n|\z))+/

        # Regular expression to match any single-line or multi-line shell script
        # comments.
        #
        # @since 1.0.0
        SHELL_COMMENT = SHELL_STYLE_COMMENT

        # Regular expression to match any single-line or multi-line Bash
        # comments.
        #
        # @since 1.0.0
        BASH_COMMENT = SHELL_STYLE_COMMENT

        # Regular expression to match any single-line or multi-line Ruby
        # comments.
        #
        # @since 1.0.0
        RUBY_COMMENT = SHELL_STYLE_COMMENT

        # Regular expression to match any single-line or multi-line Python
        # comments.
        #
        # @since 1.0.0
        PYTHON_COMMENT = SHELL_STYLE_COMMENT

        # Regular expression to match any single-line or multi-line comments.
        #
        # @since 1.0.0
        COMMENT = /#{SHELL_COMMENT}|#{C_COMMENT}/

        #
        # @group File System Patterns
        #

        # Regular expression to find File extensions in text
        #
        # @since 0.4.0
        FILE_EXT = /(?:\.[A-Za-z0-9]+)+/

        # Regular expression to find file names in text
        #
        # @since 0.4.0
        FILE_NAME = /(?:[^\/\\\. ]|\\[\/\\ ])+(?:#{FILE_EXT})?/

        # Regular expression to find Directory names in text
        #
        # @since 1.0.0
        DIR_NAME = /(?:\.\.|\.|#{FILE_NAME})/

        # Regular expression to find local UNIX Paths in text
        #
        # @since 0.4.0
        RELATIVE_UNIX_PATH = /(?:#{DIR_NAME}\/)+#{DIR_NAME}\/?/

        # Regular expression to find absolute UNIX Paths in text
        #
        # @since 0.4.0
        ABSOLUTE_UNIX_PATH = /(?:\/#{FILE_NAME})+\/?/

        # Regular expression to find UNIX Paths in text
        #
        # @since 0.4.0
        UNIX_PATH = /#{ABSOLUTE_UNIX_PATH}|#{RELATIVE_UNIX_PATH}/

        # Regular expression to find local Windows Paths in text
        #
        # @since 0.4.0
        RELATIVE_WINDOWS_PATH = /(?:#{DIR_NAME}\\)+#{DIR_NAME}\\?/

        # Regular expression to find absolute Windows Paths in text
        #
        # @since 0.4.0
        ABSOLUTE_WINDOWS_PATH = /[A-Za-z]:(?:\\#{FILE_NAME})+\\?/

        # Regular expression to find Windows Paths in text
        #
        # @since 0.4.0
        WINDOWS_PATH = /#{ABSOLUTE_WINDOWS_PATH}|#{RELATIVE_WINDOWS_PATH}/

        # Regular expression to find local Paths in text
        #
        # @since 0.4.0
        RELATIVE_PATH = /#{RELATIVE_UNIX_PATH}|#{RELATIVE_WINDOWS_PATH}/

        # Regular expression to find absolute Paths in text
        #
        # @since 0.4.0
        ABSOLUTE_PATH = /#{ABSOLUTE_UNIX_PATH}|#{ABSOLUTE_WINDOWS_PATH}/

        # Regular expression to find Paths in text
        #
        # @since 0.4.0
        PATH = /#{UNIX_PATH}|#{WINDOWS_PATH}/

      end
    end
  end
end
