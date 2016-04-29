# Donas

Easily find DNS details for a domain or subdomain: Name servers, MX records, IP resolution.

## Installation

With Bundler:

```ruby
gem 'donas'
```

Without Bundler:

```bash
gem install donas
```

## Usage

### Command Line

If you want to use the command line tool:

```bash
$ donas ombushop.com
Domain: ombushop.com
IP: 50.16.228.254

Name servers:
ns-1222.awsdns-24.org
ns-2028.awsdns-61.co.uk
ns-38.awsdns-04.com
ns-779.awsdns-33.net

MX records:
1 aspmx.l.google.com
10 aspmx2.googlemail.com
10 aspmx3.googlemail.com
5 alt1.aspmx.l.google.com
5 alt2.aspmx.l.google.com
```

If you want to use it in your application:

### DNS Records

This will return A, TXT, NS and CNAME records.

```ruby
> Donas.a_record "www.ombushop.com"
=> #<Resolv::DNS::Resource::IN::A:0x007f831d16c220 @address=#<Resolv::IPv4 50.16.228.254>, @ttl=59>
> Donas.get_record "ombulabs.com"
=> #<Resolv::DNS::Resource::IN::A:0x007f831d16c220 @address=#<Resolv::IPv4 50.16.228.254>, @ttl=59>
> Donas.get_record "shop.ombulabs.com"
=> #<Resolv::DNS::Resource::IN::CNAME:0x007f831d3174a8 @name=#<Resolv::DNS::Name: tiendaombulabs.ombushop.com.>, @ttl=21277>
> Donas.get_records "ombushop.com"
 => [#<Resolv::DNS::Resource::IN::A:0x007f831d81ff18 @address=#<Resolv::IPv4 50.16.228.254>, @ttl=3599>, #<Resolv::DNS::Resource::IN::NS:0x007f831d81f540 @name=#<Resolv::DNS::Name: ns-1222.awsdns-24.org.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831d81eaa0 @name=#<Resolv::DNS::Name: ns-2028.awsdns-61.co.uk.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831d81df88 @name=#<Resolv::DNS::Name: ns-38.awsdns-04.com.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831d81d5b0 @name=#<Resolv::DNS::Name: ns-779.awsdns-33.net.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::SOA:0x007f831d81c390 @mname=#<Resolv::DNS::Name: ns-1222.awsdns-24.org.>, @rname=#<Resolv::DNS::Name: awsdns-hostmaster.amazon.com.>, @serial=1, @refresh=7200, @retry=900, @expire=1209600, @minimum=86400, @ttl=899>, #<Resolv::DNS::Resource::IN::MX:0x007f831d827f38 @preference=1, @exchange=#<Resolv::DNS::Name: aspmx.l.google.com.>, @ttl=299>, #<Resolv::DNS::Resource::IN::MX:0x007f831d827308 @preference=10, @exchange=#<Resolv::DNS::Name: aspmx2.googlemail.com.>, @ttl=299>, #<Resolv::DNS::Resource::IN::MX:0x007f831d826598 @preference=10, @exchange=#<Resolv::DNS::Name: aspmx3.googlemail.com.>, @ttl=299>, #<Resolv::DNS::Resource::IN::MX:0x007f831d825698 @preference=5, @exchange=#<Resolv::DNS::Name: alt1.aspmx.l.google.com.>, @ttl=299>, #<Resolv::DNS::Resource::IN::MX:0x007f831d824798 @preference=5, @exchange=#<Resolv::DNS::Name: alt2.aspmx.l.google.com.>, @ttl=299>, #<Resolv::DNS::Resource::IN::TXT:0x007f831d824018 @strings=["v=spf1 include:_spf.google.com ~all"], @ttl=3599>, #<Resolv::DNS::Resource::IN::TXT:0x007f831d0f5a58 @strings=["v=spf1 include:sendgrid.net ~all"], @ttl=3599>, #<Resolv::DNS::Resource::Generic::Type99_Class1:0x007f831d82f9b8 @data="#v=spf1 include:_spf.google.com ~all", @ttl=3599>]
```

### IP Addresses

This will return an IP address, even if the initial record is a CNAME.

```ruby
> Donas.get_address "shop.ombulabs.com"
=> #<Resolv::IPv4 50.16.228.254>
```

### MX Records

This will return the MX records for a domain.

```ruby
> Donas.mx_records "ombulabs.com"
=> [#<Resolv::DNS::Resource::IN::MX:0x007f831c35eb60 @preference=1, @exchange=#<Resolv::DNS::Name: aspmx.l.google.com.>, @ttl=3599>, #<Resolv::DNS::Resource::IN::MX:0x007f831c35dc60 @preference=10, @exchange=#<Resolv::DNS::Name: alt3.aspmx.l.google.com.>, @ttl=3599>, #<Resolv::DNS::Resource::IN::MX:0x007f831c35cd60 @preference=10, @exchange=#<Resolv::DNS::Name: alt4.aspmx.l.google.com.>, @ttl=3599>, #<Resolv::DNS::Resource::IN::MX:0x007f831d114f70 @preference=5, @exchange=#<Resolv::DNS::Name: alt1.aspmx.l.google.com.>, @ttl=3599>, #<Resolv::DNS::Resource::IN::MX:0x007f831c3670f8 @preference=5, @exchange=#<Resolv::DNS::Name: alt2.aspmx.l.google.com.>, @ttl=3599>]
```

### Name Servers

This will return the name servers for the main domain (even if you provide a subdomain)

```ruby
> Donas.nameservers "ombulabs.com"
=> [#<Resolv::DNS::Resource::IN::NS:0x007f831d32e7c0 @name=#<Resolv::DNS::Name: ns-1052.awsdns-03.org.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831d32dd20 @name=#<Resolv::DNS::Name: ns-1839.awsdns-37.co.uk.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831d32d208 @name=#<Resolv::DNS::Name: ns-469.awsdns-58.com.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831d32c830 @name=#<Resolv::DNS::Name: ns-665.awsdns-19.net.>, @ttl=21599>]
```

### Summary of a Domain

This will return MX and name records.

```ruby
> Donas.summary "ombulabs.com"
=> {:nameservers=>[#<Resolv::DNS::Resource::IN::NS:0x007f831c3779d0 @name=#<Resolv::DNS::Name: ns-1052.awsdns-03.org.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831c376f30 @name=#<Resolv::DNS::Name: ns-1839.awsdns-37.co.uk.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831c376418 @name=#<Resolv::DNS::Name: ns-469.awsdns-58.com.>, @ttl=21599>, #<Resolv::DNS::Resource::IN::NS:0x007f831c375a40 @name=#<Resolv::DNS::Name: ns-665.awsdns-19.net.>, @ttl=21599>], :mx_records=>[#<Resolv::DNS::Resource::IN::MX:0x007f831c37d1c8 @preference=1, @exchange=#<Resolv::DNS::Name: aspmx.l.google.com.>, @ttl=3599>, #<Resolv::DNS::Resource::IN::MX:0x007f831c37c2c8 @preference=10, @exchange=#<Resolv::DNS::Name: alt3.aspmx.l.google.com.>, @ttl=3599>, #<Resolv::DNS::Resource::IN::MX:0x007f831c387678 @preference=10, @exchange=#<Resolv::DNS::Name: alt4.aspmx.l.google.com.>, @ttl=3599>, #<Resolv::DNS::Resource::IN::MX:0x007f831c386778 @preference=5, @exchange=#<Resolv::DNS::Name: alt1.aspmx.l.google.com.>, @ttl=3599>, #<Resolv::DNS::Resource::IN::MX:0x007f831c385878 @preference=5, @exchange=#<Resolv::DNS::Name: alt2.aspmx.l.google.com.>, @ttl=3599>]}
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

Then, run `rake` to run the tests.

You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ombulabs/donas. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
