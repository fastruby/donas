require "resolv"
require "donas/errors"
require "donas/version"

class Donas
  SEPARATOR = ".".freeze

  # Returns an {Array} with {Resolv::DNS::Resource::IN::MX} objects.
  #
  # @param [String] domain
  # @return [Array]
  def self.mx_records(domain)
    resolver.getresources(safe(domain), Resolv::DNS::Resource::IN::MX)
  end

  # Returns an {Array} with {Resolv::DNS::Resource::IN::NS} objects.
  #
  # @param [String] domain
  # @return [Array]
  def self.nameservers(domain)
    safe_domain = safe(domain)
    main_domain = safe_domain.split(SEPARATOR).last(2).join(SEPARATOR)
    resolver.getresources(main_domain, Resolv::DNS::Resource::IN::NS)
  end

  # Returns a record with DNS information.
  #
  # @param [String] domain
  # @return [Resolv::DNS::Resource::IN::A,Resolv::DNS::Resource::IN::CNAME,Resolv::DNS::Resource::IN::TXT]
  # @raise [Resolv::ResolvError]
  def self.get_record(domain)
    resolver.getresource(safe(domain), Resolv::DNS::Resource::IN::ANY)
  end

  # Returns a {Resolv::IPv4} or {Resolv::IPv6} object for the domain.
  #
  # @param [String] domain
  # @return [Resolv::IPv4, Resolv::IPv6]
  # @raise [Resolv::ResolvError]
  def self.get_address(domain)
    record = get_record(safe(domain))

    if record.respond_to? :address
      record.address
    else
      get_address(record.name.to_s)
    end
  end

  # Returns an {Array} with {Resolv::DNS::Resource::IN::A},
  # {Resolv::DNS::Resource::IN::CNAME}, {Resolv::DNS::Resource::IN::TXT}
  # objects.
  #
  # @param [String] domain
  # @return [Array]
  def self.get_records(domain)
    resolver.getresources(safe(domain), Resolv::DNS::Resource::IN::ANY)
  end

  # Returns a {Hash} with all the information about the DNS records of a domain
  #
  # @param [String] domain
  # @return [Hash]
  def self.summary(domain)
    {
      nameservers: nameservers(domain),
      mx_records: mx_records(domain)
    }
  end

  def self.resolver
    Resolv::DNS.new
  end

  def self.safe(domain)
    names = domain.split(SEPARATOR)
    raise BadFormatError.new("#{domain} not valid") if names.size < 2
    domain
  end
end
