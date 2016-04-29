require "spec_helper"

describe Donas do
  it "has a version number" do
    expect(Donas::VERSION).not_to be nil
  end

  describe "Donas.get_address" do
    context "with a valid domain" do
      context "with a CNAME" do
        it "returns an IP" do
          result = Donas.get_address "ombushop.com"
          expect(result).to be_a Resolv::IPv4
        end
      end

      context "with an A record" do
        it "returns an IP" do
          result = Donas.get_address "shop.ombulabs.com"
          expect(result).to be_a Resolv::IPv4
        end
      end
    end

    context "with an invalid domain" do
      it "raises an error" do
        expect do
          Donas.get_address "asljflkajsdfjlasdfombushop.com"
        end.to raise_error(Resolv::ResolvError)
      end

      it "raises a BadFormatError" do
        expect do
          Donas.get_address "pepe"
        end.to raise_error(Donas::BadFormatError)
      end
    end
  end

  describe "Donas.get_record" do
    context "with a valid domain" do
      it "returns a Resolv::DNS::Resource::IN::A object" do
        result = Donas.get_record "ombushop.com"
        expect(result).to be_a Resolv::DNS::Resource::IN::A
        expect(result.address).to be_a Resolv::IPv4
        expect(result.address.to_s).to eq "50.16.228.254"
      end
    end

    context "with an invalid domain" do
      it "doesn't return a record" do
        expect do
          Donas.get_record "alskdjfaljksdflkaslkajsdfombushop.com"
        end.to raise_error(Resolv::ResolvError)
      end
    end
  end

  describe "Donas.a_record" do
    context "with an invalid domain" do
      it "returns nil" do
        domain = "jkldsjflasjdflksajflksjaflkjsadklfjlsakfdjlsafdjlksadfj.com"
        a = Donas.a_record(domain)
        expect(a).to eq nil
      end
    end

    context "with a valid domain" do
      it "returns a Resolv::DNS::Resource::IN::A" do
        domain = "www.ombushop.com"
        a = Donas.a_record(domain)
        expect(a).to be_a Resolv::DNS::Resource::IN::A
        expect(a.address.to_s).to eql "50.16.228.254"
      end
    end
  end

  describe "Donas.mx_records" do
    context "with an invalid domain" do
      it "returns an empty array" do
        domain = "jkldsjflasjdflksajflksjaflkjsadklfjlsakfdjlsafdjlksadfj.com"
        mxs = Donas.mx_records(domain)
        expect(mxs).to eq []
      end
    end

    context "with a valid domain" do
      before(:all) do
        @mxs = Donas.mx_records("ombulabs.com")
      end

      it "returns Resolv::DNS::Resource::IN::MX with preferences" do
        expect(@mxs.size).to eq 5
        expect(@mxs[0].preference).to eq 1
        expect(@mxs[1].preference).to eq 10
        expect(@mxs[2].preference).to eq 10
        expect(@mxs[3].preference).to eq 5
        expect(@mxs[4].preference).to eq 5
      end

      it "returns exchanges for each record" do
        @mxs.each do |record|
          expect(record.exchange).to be_a Resolv::DNS::Name
        end
        expect(@mxs[0].exchange.to_s).to eq "aspmx.l.google.com"
        expect(@mxs[1].exchange.to_s).to eq "alt3.aspmx.l.google.com"
        expect(@mxs[2].exchange.to_s).to eq "alt4.aspmx.l.google.com"
        expect(@mxs[3].exchange.to_s).to eq "alt1.aspmx.l.google.com"
        expect(@mxs[4].exchange.to_s).to eq "alt2.aspmx.l.google.com"
      end

      it "returns Resolv::DNS::Resource::IN::MX objects" do
        @mxs.each do |record|
          expect(record).to be_a Resolv::DNS::Resource::IN::MX
        end
      end
    end
  end

  describe "Donas.nameservers" do
    context "with an invalid domain" do
      it "returns an empty array" do
        domain = "jkldsjflasjdflksajflksjaflkjsadklfjlsakfdjlsafdjlksadfj.com"
        nameservers = Donas.nameservers(domain)
        expect(nameservers).to eq []
      end
    end

    context "with a valid domain" do
      before(:all) do
        @nameservers = Donas.nameservers("ombulabs.com")
      end

      it "returns four name servers" do
        expect(@nameservers.size).to eq 4
      end

      it "returns Resolv::DNS::Resource::IN::NS objects" do
        @nameservers.each do |record|
          expect(record).to be_a Resolv::DNS::Resource::IN::NS
        end
      end

      it "returns Resolv::DNS::Name inside the NS objects" do
        @nameservers.each do |record|
          expect(record.name).to be_a Resolv::DNS::Name
        end

        expect(@nameservers[0].name.to_s).to eq "ns-1052.awsdns-03.org"
        expect(@nameservers[1].name.to_s).to eq "ns-1839.awsdns-37.co.uk"
        expect(@nameservers[2].name.to_s).to eq "ns-469.awsdns-58.com"
        expect(@nameservers[3].name.to_s).to eq "ns-665.awsdns-19.net"
      end
    end
  end

  describe "Donas.summary" do
    context "with an invalid domain" do
      it "returns empty arrays inside the hash" do
        domain = "jkldsjflasjdflksajflksjaflkjsadklfjlsakfdjlsafdjlksadfj.com"
        expect(Donas.summary(domain)).to eq(nameservers: [], mx_records: [])
      end
    end
  end
end
