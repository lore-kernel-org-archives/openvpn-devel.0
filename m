Reply-To: openvpn-devel@lists.sourceforge.net
References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
	<bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
	<1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
	<6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
	<ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
	<36e89683-6f8f-7595-d140-64d64f71b0f0@...277...>
	<2720741f-5df5-96ba-b253-5b84a9c5ad00@...2080...>
	<ebd2f501-ff03-ee3c-7aeb-a10b6e1489ab@...277...>
	<20170529145009.GX97029@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <dc53b349-cdd1-c26c-a105-18a8f294844a@...2080...>
Date: Mon, 29 May 2017 17:43:52 +0200
MIME-Version: 1.0
In-Reply-To: <20170529145009.GX97029@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RLXoVe5JVLUuFjchoNTBM4Fp7r1WNQAl2"
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RLXoVe5JVLUuFjchoNTBM4Fp7r1WNQAl2
Content-Type: multipart/mixed; boundary="OuT9rxeHsIoGals29v5Ran0KwdCAllfii";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Gert Doering <gert@...1296...>, debbie10t <debbie10t@...277...>
Cc: openvpn-devel@lists.sourceforge.net
Message-ID: <dc53b349-cdd1-c26c-a105-18a8f294844a@...2080...>
Subject: Re: [Openvpn-devel] Ubuntu 16.04.2 LTS --enable-systemd ./configure
 error
References: <b40a8930-a6aa-cd9d-8cfb-0ed57d1cdc93@...277...>
 <bfb1203d-06e7-8242-c4bd-091e7d50801f@...2080...>
 <1a69f080-a1bc-f646-ffdc-5c5ca27ac1f4@...277...>
 <6ec92ca3-7050-6e6e-533e-4771e4970816@...515...>
 <ec48fefc-8b36-d34c-9ddb-18f196eabd8e@...2080...>
 <36e89683-6f8f-7595-d140-64d64f71b0f0@...277...>
 <2720741f-5df5-96ba-b253-5b84a9c5ad00@...2080...>
 <ebd2f501-ff03-ee3c-7aeb-a10b6e1489ab@...277...>
 <20170529145009.GX97029@...1296...>
In-Reply-To: <20170529145009.GX97029@...1296...>

--OuT9rxeHsIoGals29v5Ran0KwdCAllfii
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 29/05/17 16:50, Gert Doering wrote:
> Hi,
>=20
> On Mon, May 29, 2017 at 02:01:14PM +0100, debbie10t wrote:
>> FYI:
>> pkg-config was only required for --enable-systemd
>> Running './configure' only did not need pkg-config.
>> I don't know if it is required for any other options.
>=20
> pkg-config is used for OpenSSL checking, but if it's not there, we fall
> back to "just see if it works" - because the BSDs do not (all) have=20
> pkg-config files for openssl.
>=20
> As systemd is linux specific (today), and linux has pkg-config, it needs
> to be there...
>=20
> Maybe our configure should point this out more clearly, that is, if
> "--enable-systemd" is given and pkg-config cannot be found, complain
> about lack of *pkg-config*...

Actually, pkcs11-helper and p11-kit checks also depends on pkg-config
... the systemd pkg-config calls just happens to be run first to bail
out if it can't figure out the systemd details.  It seems pkg-config
first called on pkcs11-helper, then openssl - both which considers
"failure" as non-critical.

If it is only the openssl.pc missing on some *BSD distros, then I think
we can have pkg-config being a requirement which is checked for as early
as possible.  Otherwise, we'll need to check for pkg-config if
pkcs11-helper, p11-kit or systemd is enabled.  And for each new
dependency with pkg-config support.

Btw ... I also see we could utilize pkg-config for lz4 too (at least
with lz4-1.7.3)


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--OuT9rxeHsIoGals29v5Ran0KwdCAllfii--

--RLXoVe5JVLUuFjchoNTBM4Fp7r1WNQAl2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZLEG8AAoJEIbPlEyWcf3y6LAP/31bCRDNoRaiswM7VTC1uXeQ
HgOsNFUgEqZSrRqHQACF0YWXZsQ3Zvh5IK/Gw2Q9fXiOmxwqMCVe8xocBZyJkHZm
3klaQktJNzTmud8WwbL0x0sXlqgj2H0OPlaeMEid8fC19k6QPFDqXAPAgvsO7i4X
wCyJgWZd/okPEYpJ0vZ684tXAKOp8ec4wQ/Ub9UaZLLKy9nTWLCzgHQl7UsB3Swy
7ujPglWsUO2ZUXZSGTKa7jafZdUzx7HN8VW8ubJDPKdx1/0JcUD+Co9Q16stpJPm
H/TrkOLoArKBZ/Pi50qSvzMJu4+fHjWcv1h2q4gwhrCpTawbdTcGZ4HY5kWbA4PC
P1oFf+YnCXoRsHyWv3b4qI//ZcpV2gudTJ/4Sr7CWUITGYXXTmkmoXtnMjj8o6Vf
6roNp/xjH/ImsIA/SyP0U77BepasQzz3vnCFfzTLNkXG19QN/KVHrP2pVWkQhOTC
9TF1rTjggsQPDpQZpnygFOfv/Wfxs5Uev/c6YW8r9b5SgJY9/Lev+Ngco50RpwLB
lXZX40oOWGD/9DahiUX+f6hGc9iIsgRnsCDd2jAAjQEDwweHqrAqu7BkENXEtPH+
h/GE1ATYiBCbHRA4gI2/52UIMZWp2Htbb02rAMNOraT8Vl91QJC0IwV4cRRjWOmN
0/UpyQW2Ao0Lz22Njfcq
=k4Wy
-----END PGP SIGNATURE-----

--RLXoVe5JVLUuFjchoNTBM4Fp7r1WNQAl2--

