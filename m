References: <de9db75e-98de-6a56-6f3c-6ba66f475cca@...1227...>
 <20200826165128.23117-1-themiron@...2010...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <e170069f-a0da-0f86-fb05-ec900e799f52@...1227...>
Date: Wed, 9 Sep 2020 13:28:31 +0200
MIME-Version: 1.0
In-Reply-To: <20200826165128.23117-1-themiron@...2010...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="omAcvAslKrvMbWS8KHt1SgnHG07M0JrSm"
Subject: Re: [Openvpn-devel] [PATCH v2] Add DNS SRV host discovery support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--omAcvAslKrvMbWS8KHt1SgnHG07M0JrSm
Content-Type: multipart/mixed; boundary="FdIXlT2OVLS9vOKU7G6hrXVVk0ajWYUUb"

--FdIXlT2OVLS9vOKU7G6hrXVVk0ajWYUUb
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 26.08.20 um 18:51 schrieb Vladislav Grishenko:
> DNS SRV host discovery allows to have multiple OpenVPN servers for a sing=
le
> domain w/o explicit profile enumeration, to move services from host to ho=
st
> with little fuss, and to designate hosts as primary servers for a service
> and others as backups.
> Feature has been asked several times already, useful in case of huge
> ammounts of client & servers deployed.
>=20
> Patch introduces "--remote-service-discovery [service]" option, which
> enables discovery and optionally allows to change "openvpn" default servi=
ce
> to user specified.
> Client will try to resolve ``_service._proto.host`` name via DNS
> and use returned DNS SRV records as OpenVPN remote server list
> ordered by server selection mechanism defined in RFC 2782:
>=20
>     A client MUST attempt to contact the target host with the
>     lowest-numbered priority field value it can reach, target hosts
>     with the same priority SHOULD be tried in an order defined by the
>     weight field.
>     The weight field specifies a relative weight for entries with the
>     same priority. Larger weights SHOULD be given a proportionately
>     higher probability of being selected.
>     Domain administrators SHOULD use Weight 0 when there isn't any
>     server selection to do. In the presence of records containing
>     weights greater than 0, records with weight 0 SHOULD have a very
>     small chance of being selected.
>=20
> Example: instead of multiple remotes on order in profile:
>     remote s1.example.com 1194 udp
>     remote s2.example.com 1194 udp
>     remote s3.example.com 1194 udp
>     remote s4.example.com 1194 udp
>     remote example.com 1194 udp
>=20
> now it's possible to specify one remote with discovery:
>     remote example.net 1194 udp
>     remote-service-discovery
>=20
> and addconfigure following DNS SRV records, for examle:
>      _openvpn._udp.example.net IN SRV 10 60 1194 s1.example.net
>      _openvpn._udp.example.net IN SRV 10 40 1194 s2.example.net
>      _openvpn._udp.example.net IN SRV 10  0 1194 s3.example.net
>      _openvpn._udp.example.net IN SRV 20  0 1194 s4.example.net

I haven't reviewed this yet but I think we need to agree what we
actually want to solve/implement here or what the overall goal is.

Traditionally OpenVPN is configure with a number of remotes in order of
preference: e.g.

server1 udp 1194
server1 tcp 443
server2 udp 1194
server2 tcp 443

DNS SRV discovery is a more modern way to get the actual
proto/protocol/IP to connect to. So I feel this should be able to
replace a handwritten list of remote in the config. E.g. something like

remote-srv mydomain

However, the current patches forces all remotes to be either UDP or TCP
or have a fixed UDP over TCP (or vice versa) priority.

Also reusing --remote for both service discovery and fallback is not
great a solution. It suffer from trying to force two very different
things into a single command.

I can see that a fallback behaviour if DNS SRV is desirable but I think
the normal case is not to fallback to just a single remote but rather a
list of --remote. So I would propose to instead have something like
remote-dnsserv that does all the discovery and *also* a list of
--remotes and then fallback to those if DNS SRV falls. If no fallback is
desired, then only remote-dnnsserv is specified.

I am sure that the current implementation is good enough for your use
case but I feel the current version is not useful enough as general
feature but more only solves a specific use case.

Arne


--FdIXlT2OVLS9vOKU7G6hrXVVk0ajWYUUb--

--omAcvAslKrvMbWS8KHt1SgnHG07M0JrSm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9YvF8ACgkQFRhsZwKx
RFTYdQ/+JTALm0Z7mEfPOOTCgPtQDI6h0aIWbttfE/5N3PDwUH5JcVitdEx7B+6r
9XPX7mrcUKNvf089Rjs33te6KFGvO4omyS6SEaKZ2hyx3+wBaz20IEifmXeDRaPF
6jONoyoGrVUTZRkq8E68AhutP0ANdRP0a+1DG3YjzSisNAYs7bJf8BXWYh/9HNxn
IyWCdgpQzS5yV4//UnpFit4sAy+0pAiMyXgSvuFxnxwiBMuMQILtMXjWCfwtTeXd
RQn0Bluwy6H3/9A2vPT6nE2k35kKJ6tnrK3Y9shnq1F2Qm1QiCPBS63F+eaAL2ur
Kew0ixOOmoPj7qCg/1WLGreBTV5pYD9zaMjv05UiS7lFBbRmmZoSz2ttMGSDQY7O
/OsCRK+Py7nr4BUcCcWkNJv1E4agLd8E1inHHwsK60Omv6jaj+7Le+g6gHgRuh1a
YbOp9AaYauKIXBcXJwxTB5j8C2OlkN5N6XWhVJ5ByMVAxm1zRsRF37KmyoHpKZ1w
zcMtUJ22o0dqiLfYY6R8FYDrhgCrS7Ueg/Yn/1/1n5/TQlTR6I2aI+60S1g9UR+K
0cMbnsvPq4iB/h28brMmr4jc/DFG8Ww9WspHyygbuCD7IK6tA7u7rs5HIyq7OFlw
OHmG19aMWEEhwlxxSxhgMBKKmHQ9oeMvebQunpfBcmkxDKWvbXU=
=KZ24
-----END PGP SIGNATURE-----

--omAcvAslKrvMbWS8KHt1SgnHG07M0JrSm--

