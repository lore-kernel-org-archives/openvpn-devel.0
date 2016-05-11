References: <CAAM7bARYZSecZZb2aU7dTaRc1a6rP8dz4hsHR=tDUbTmSTpgFg@...278...>
	<CAFHpkQH--CiX4XguNMsoCNSKJ3GEFShPpae+=AVon-h6bT4c5Q@...278...>
From: s7r <s7r@...2137...>
Message-ID: <57338F0A.9050407@...2137...>
Date: Wed, 11 May 2016 22:59:06 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQH--CiX4XguNMsoCNSKJ3GEFShPpae+=AVon-h6bT4c5Q@...278...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0MKfmUjVqnOMkdQNuiDjJ7SlAgQRS4qu2"
Subject: Re: [Openvpn-devel] Need help for adding feature: Selecting remote
 servers by best latency
Reply-To: s7r@...2137...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0MKfmUjVqnOMkdQNuiDjJ7SlAgQRS4qu2
Content-Type: multipart/mixed; boundary="xW4N8Ouphac3o8tSeRbsv0HAV87L0Vrhv"
From: s7r <s7r@...2137...>
Reply-To: s7r@...2137...
To: openvpn-devel@lists.sourceforge.net
Message-ID: <57338F0A.9050407@...2137...>
Subject: Re: [Openvpn-devel] Need help for adding feature: Selecting remote
	servers by best latency
References: <CAAM7bARYZSecZZb2aU7dTaRc1a6rP8dz4hsHR=tDUbTmSTpgFg@...278...>
	<CAFHpkQH--CiX4XguNMsoCNSKJ3GEFShPpae+=AVon-h6bT4c5Q@...278...>
In-Reply-To: <CAFHpkQH--CiX4XguNMsoCNSKJ3GEFShPpae+=AVon-h6bT4c5Q@...278...>

--xW4N8Ouphac3o8tSeRbsv0HAV87L0Vrhv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I think he will map:
host.example.com -> a.a.a.a
                 -> b.b.b.b
                 -> c.c.c.c
and/or
host.example.com -> aaaa.aaaa.ipv6
                 -> bbbb.bbbb.ipv6
                 -> b.b.b.b

Make some kind of a table kept in temporary memory / RAM / disk with all
values (ip addresses) probe them individually with real tcp connections,
assign a 'latency' value to each entry in the table and sort the final
result by selecting the entry with lowest 'latency' value.

This can be quite time consuming there are many servers to probe, and
sane values should be chosen for timeouts and max retries as well as
trying v6 servers or not (maybe the client can't even reach v6 hosts)
otherwise this can lead to and endless loop.


On 5/11/2016 10:35 PM, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> how are you going to resolve
>=20
> a) host.example.com <http://host.example.com> resolves in multiple "A"
> records
> b) host.example.com <http://host.example.com> resolves in both "AAAA"
> and "A" records
>=20
> ?
>=20
> 2016-05-11 20:41 GMT+05:00 Paul Garnier <paul.garnier3@...277...
> <mailto:paul.garnier3@...277...>>:
>=20
>     Hello,
>=20
>=20
>     I=E2=80=99m actually trying to add an option in openvpn which will al=
low the
>     client to connect to the server with the lowest latency in his
>     remote list. For now there are only two options to choose between
>     servers : =E2=80=9C*--remote-random*=E2=80=9D  which randomize the or=
der of the
>     address list, the default one which will try the hosts in the order
>     of the config file, and I want to add  a 3^rd one. To start I want
>     to do it for udp and unix servers and clients.
>=20
>=20
>     I=E2=80=99m a beginner in things like this so I started  very simply =
: I
>     wrote a little program in C to ping a host:port using udp but I
>     can=E2=80=99t get an answer from an openvpn server. The only way I fo=
und to
>     get an answer was to make the packet I send look like the start of a
>     TLS transaction, but because of the TLS processing I can only get
>     the first ping right, after it takes way too long to come back to be
>     accurate.
>=20
>=20
>     So I started digging  in the source code to find where my packet is
>     thrown away and why I don=E2=80=99t get any answer (even an error mes=
sage
>     would be enough). I=E2=80=99ve found how a =E2=80=9Cnormal=E2=80=9D p=
acket is sent but what
>     I want is the latency with the server, not in the tunnel.  I don=E2=
=80=99t
>     want to establish a connection to test my link with each server and,
>     how I understand it, if I want use function like *encrypt_sign*() so
>     my packet is recognized**I need to have a tunnel set. I can=E2=80=99t
>     replicate how the existing *ping *and *occ *packets are sent.
>=20
>=20
>     What I would like to know is :=20
>=20
>=20
>     - where my packet is processed and rejected ?
>=20
>     - why I don't get any answer at all nor an error message on my server=
 ?
>=20
>     - is there a major issue making what I want to do impossible ?
>=20
>=20
>     Kind regards,
>=20
>=20
>     Paul Garnier
>=20
>=20


--xW4N8Ouphac3o8tSeRbsv0HAV87L0Vrhv--

--0MKfmUjVqnOMkdQNuiDjJ7SlAgQRS4qu2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (MingW32)

iQEcBAEBCAAGBQJXM48TAAoJEIN/pSyBJlsRoScH/19Q6OZViI8p4RVc0wtp+Mnv
4+rtgLb13BCPjq9cVxstad2HqR6cK57u83bjPJC13fQGr5y9af7fxGljlsTTZoIV
XuxHT/hGd0wXrfsVcFs4UnIZTNSDS9f0gM6S/eTQGOyM00Z3flO2Kw/93NiAEwZl
AZLslsd81tRYW6cmsHYG4t5rn4N4FdADGipbqjRlGgcLwfQv3irgeW0p7HL65hZ/
q9tHiIegUMRMaS8xr1BHRsu8v232QrMYiU/Ugl3+IVaywhMZRVqicssPxKeAZ93Z
BJ308CSjm7p8RNDoV3CCIwkjfujo++xUEWacl4DS9UjRnKclYxvhE/NfXbaF88w=
=a/ov
-----END PGP SIGNATURE-----

--0MKfmUjVqnOMkdQNuiDjJ7SlAgQRS4qu2--

