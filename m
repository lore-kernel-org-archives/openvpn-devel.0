References: <20180423092813.24844-1-list@...1798...>
 <20180424083801.GB24895@...2161...> <20180424120337.0fab107d@...1799...>
 <20180424130817.GA20143@...2161...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a0da03f3-a1bb-6d2b-bdb5-500db52c5dc1@...2181...>
Date: Tue, 24 Apr 2018 23:08:22 +0800
MIME-Version: 1.0
In-Reply-To: <20180424130817.GA20143@...2161...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="D1OBxlwclPietP2UDFhWNaubdjnsIFmC1"
Subject: Re: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated
 user
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Simon Ruderich <simon@...2161...>, Christian Hesse <list@...1798...>
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D1OBxlwclPietP2UDFhWNaubdjnsIFmC1
Content-Type: multipart/mixed; boundary="QTQDFlQwLEENIwrNHnZslBvnFaIqVYzQN";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Simon Ruderich <simon@...2161...>, Christian Hesse <list@...1798...>
Cc: OpenVPN Development <openvpn-devel@lists.sourceforge.net>
Message-ID: <a0da03f3-a1bb-6d2b-bdb5-500db52c5dc1@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 1/1] systemd: run openvpn with dedicated
 user
References: <20180423092813.24844-1-list@...1798...>
 <20180424083801.GB24895@...2161...> <20180424120337.0fab107d@...1799...>
 <20180424130817.GA20143@...2161...>
In-Reply-To: <20180424130817.GA20143@...2161...>

--QTQDFlQwLEENIwrNHnZslBvnFaIqVYzQN
Content-Language: en-US
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

On 24/04/18 21:08, Simon Ruderich wrote:
>> I do not agree that the process is running with root privileges. It has =
some
>> extra capabilities, but it can not kill processes, fork away and change
>> cgroups, etc.
>> IMHO that is what we want to achieve.
>=20
> I disagree. A process with CAP_DAC_OVERRIDE can read/write
> _every_ file on the system (man 7 capabilities)! This equals root
> privileges. Even CAP_NET_ADMIN is very powerful as it allows
> modifying the firewall which might give access to sensitive
> services which are normally not exposed.
>=20
>> For this patch I took the current set of capabilities and stripped CAP_S=
ETGID
>> and CAP_SETUID for the netlink version. Whether or not the other capabil=
ities
>> are required should be discussed independently. Wondering why we have
>> CAP_DAC_OVERRIDE in our capability capability set... That looks suspicio=
us
>> indeed.
>=20
> Even with CAP_DAC_OVERRIDE stripped this change keeps openvpn
> running with (much) more privileges than before. Is this
> desirable?

I think it depends on your perspective.

What Christian says is that with this patch:

1) you can start openvpn as non-root directly (impossible right now)

2) you have full support for tunnel reconfiguration even when running as
non-root (people willing to achieve this now must start and keep openvpn
running as root)

I consider both points above steps forward towards a better security
model for OpenVPN.


OTOH I understand that there are people that don't care about having a
working tunnel reconfiguration and are fine with starting openvpn as
root (and then dropping privileges).

For these people, adding the above capabilities results in giving the
openvpn process more power than before.

Maybe users willing to adopt this stricter behaviour should have a knob
somewhere that will enable the usual
run-as-root-and-then-drop-priv-with-no-caps?

Generally speaking I believe that openvpn, as a VPN and partly routing
daemon, should be allowed to run with CAP_NET_ADMIN set as it enables
more features (tunnel reconfiguration to start with).

Maybe clients should run with the caps by default while servers should
be launched with the original behaviour? Not sure, honestly.

Cheers,



--=20
Antonio Quartulli


--QTQDFlQwLEENIwrNHnZslBvnFaIqVYzQN--

--D1OBxlwclPietP2UDFhWNaubdjnsIFmC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlrfSGYACgkQB6U8WA7y
zXQpYg/7Beu/bNZlC65BpU4KV1vTVO9buBvUXi8rQxUZcVSEl43Od1XgnoIkKP/e
sZtcp32BY1SD2oDYm8LWTRNVvrMlB/uRQfctEA6azyHrzVPfpQIMFdgTjSbR3rwe
CJ9FDenPPthJyhfIa+NDq9jFj4mNaFmkQU+KjZgdH3UXgZJ2NkQ2PVFIHkMidTS3
HgN/bGo4hghcxx8uSp1n/CFSNH0ZzpRPgCER4PNl6U5bALUEo0rxzHIB34jhoqxi
272NkMM0bvtLd/nmJ/ENuHkqOZGGNWlQS9wT3ynVEWhIlQJnfGI1oa35oA/yJkJq
BRglTLCMDmwHPFAXSd1QGaXKHX3VF2elFNM9x3zlUqugmARCPaP4DtXUVy2jyoVS
klNu8ReZi+lB2Ne//uiD3lFPnrd7Rm9ZStLxlKaM+umoc1hqjc0v43wrqkX7wYGe
ByKxvGLoekIrJTe9d3SfduWS+xjEHLM/GR4mxK24xmg8yNAgKoPauGN5aPIT0q20
rm/kmlBwhgWoiHqEXpJ9U9I5oNNp0PQaeqPjzxGb/jsVqH1AI5ihMyHYTC7bQvzn
YtwZCuhyJBc5sbOKQxfnw0+lxSXQ24q1FNe1jvJf0M7OOYxsDmMmhZ9vE8O4axV+
RKgzVeST9ssp7Etcqjnt5wcnH4ITQHNt7Tfzfeqv9iQqHuRpBlo=
=IZDN
-----END PGP SIGNATURE-----

--D1OBxlwclPietP2UDFhWNaubdjnsIFmC1--

