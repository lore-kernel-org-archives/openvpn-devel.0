From: "Vladislav Grishenko" <themiron@...2010...>
References: <de9db75e-98de-6a56-6f3c-6ba66f475cca@...1227...>
 <20200826165128.23117-1-themiron@...2010...>
 <e170069f-a0da-0f86-fb05-ec900e799f52@...1227...>
In-Reply-To: <e170069f-a0da-0f86-fb05-ec900e799f52@...1227...>
Date: Wed, 9 Sep 2020 16:48:45 +0500
Message-ID: <027b01d6869f$2ce27910$86a76b30$@yandex-team.ru>
MIME-Version: 1.0
Content-Language: ru
Subject: Re: [Openvpn-devel] [PATCH v2] Add DNS SRV host discovery support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: 'Arne Schwabe' <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi, Arne

> From: Arne Schwabe
> Sent: Wednesday, September 9, 2020 4:29 PM
> Am 26.08.20 um 18:51 schrieb Vladislav Grishenko:
> > DNS SRV host discovery allows to have multiple OpenVPN servers for a
> > single domain w/o explicit profile enumeration, to move services from
> > host to host with little fuss, and to designate hosts as primary
> > servers for a service and others as backups.
> > Feature has been asked several times already, useful in case of huge
> > ammounts of client & servers deployed.
> >
> > Patch introduces "--remote-service-discovery [service]" option, which
> > enables discovery and optionally allows to change "openvpn" default
> > service to user specified.
> > Client will try to resolve ``_service._proto.host`` name via DNS and
> > use returned DNS SRV records as OpenVPN remote server list ordered by
> > server selection mechanism defined in RFC 2782:
> >
> >     A client MUST attempt to contact the target host with the
> >     lowest-numbered priority field value it can reach, target hosts
> >     with the same priority SHOULD be tried in an order defined by the
> >     weight field.
> >     The weight field specifies a relative weight for entries with the
> >     same priority. Larger weights SHOULD be given a proportionately
> >     higher probability of being selected.
> >     Domain administrators SHOULD use Weight 0 when there isn't any
> >     server selection to do. In the presence of records containing
> >     weights greater than 0, records with weight 0 SHOULD have a very
> >     small chance of being selected.
> >
> > Example: instead of multiple remotes on order in profile:
> >     remote s1.example.com 1194 udp
> >     remote s2.example.com 1194 udp
> >     remote s3.example.com 1194 udp
> >     remote s4.example.com 1194 udp
> >     remote example.com 1194 udp
> >
> > now it's possible to specify one remote with discovery:
> >     remote example.net 1194 udp
> >     remote-service-discovery
> >
> > and addconfigure following DNS SRV records, for examle:
> >      _openvpn._udp.example.net IN SRV 10 60 1194 s1.example.net
> >      _openvpn._udp.example.net IN SRV 10 40 1194 s2.example.net
> >      _openvpn._udp.example.net IN SRV 10  0 1194 s3.example.net
> >      _openvpn._udp.example.net IN SRV 20  0 1194 s4.example.net
>=20
> I haven't reviewed this yet but I think we need to agree what we actually=
 want
> to solve/implement here or what the overall goal is.
>=20
> Traditionally OpenVPN is configure with a number of remotes in order of
> preference: e.g.
>=20
> server1 udp 1194
> server1 tcp 443
> server2 udp 1194
> server2 tcp 443
>=20
> DNS SRV discovery is a more modern way to get the actual proto/protocol/I=
P to
> connect to. So I feel this should be able to replace a handwritten list o=
f remote
> in the config. E.g. something like
>=20
> remote-srv mydomain
>=20
> However, the current patches forces all remotes to be either UDP or TCP or
> have a fixed UDP over TCP (or vice versa) priority.
>=20
> Also reusing --remote for both service discovery and fallback is not grea=
t a
> solution. It suffer from trying to force two very different things into a=
 single
> command.
>=20
> I can see that a fallback behaviour if DNS SRV is desirable but I think t=
he normal
> case is not to fallback to just a single remote but rather a list of --re=
mote. So I
> would propose to instead have something like remote-dnsserv that does all=
 the
> discovery and *also* a list of --remotes and then fallback to those if DN=
S SRV
> falls. If no fallback is desired, then only remote-dnnsserv is specified.
>=20
> I am sure that the current implementation is good enough for your use cas=
e but I
> feel the current version is not useful enough as general feature but more=
 only
> solves a specific use case.
>=20
> Arne

I see your point, thank you.
Fallback is done just to conform RFC 2782 suggestion, personally I feel it'=
s hardly be used with controllable client profiles when it's known that dom=
ain.tld does dns srv.

Additional --remote-srv indeed has benefits:
* opens a non-conflicting syntax way to have multiple udp/tcp dns srv reque=
sts, as you wrote in earlier mails. This will allow to sort them all by pri=
o/weight.
* cleaner syntax for specifying custom dns srv service name, with default "=
openvpn" and protocol (if need to limit discovery to only udp or tcp)
So, in my mind syntax looks like:
	--remote-srv [service] [protocol], where both args are optional, by defaul=
t service=3D=3Dopenvpn, protocol=3D=3Dany

And, important thing, multiple --remote-srv still needs to be supported for:
* custom order of protocol
* different service names
* allow to reuse --remote-random with --random-srv as well to achieve dns-s=
rv-based lb

Is it good enough in this form?

--
Best Regards, Vladislav Grishenko



