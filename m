Date: Wed, 5 Aug 2020 08:43:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200805064318.GY75094@...1296...>
References: <20200729113835.2415-1-arne@...1227...>
 <20200804202010.GV75094@...1296...>
 <b8c90764-96e4-6e6d-2060-ee3d84cb446d@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="VaKJWhUROU/xPxjb"
Content-Disposition: inline
In-Reply-To: <b8c90764-96e4-6e6d-2060-ee3d84cb446d@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Rework NCP compability logic and
 drop BF-CBC support by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--VaKJWhUROU/xPxjb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Wed, Aug 05, 2020 at 12:20:54AM +0200, Arne Schwabe wrote:
> > Is that intentional?
>=20
> Yes. That is intentional. If you do not have any cipher option in the
> config, there is nowadays a very high change that you allow BF-CBC by
> "accident". I encountered this first-hand ("I do want to put as few
> option in a config as possible").

OK, I can see that line of reasoning.  This needs to be put very
prominently into the release notes.


Updating on server test success - with the core dump fix, but still
*no* "--cipher" in the server configs, I get

22...
Test sets succeeded: 8.
Test sets failed: 1 2 3 4 6.
23.small...
Test sets succeeded: none.
Test sets failed: 1 2 3 4.
23...
Test sets succeeded: 8 8a 9.
Test sets failed: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2b 2d 2e 3 5 6 8 8a 9.
Test sets failed: 2a 2c 4 4a.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2b 2c 2d 2e 3 5 5a 5b 5c 5d 5v1 5v2=
 5v3 5w1 5w2 5w3 5w4 5x1 5x2 5x3 5x4 6 7 7x 8 8a 9 2f.
Test sets failed: 2a 4 4b.

so the 2.2/2.3-small/2.3 failures are expected.

2a and 2c (for 2.4) is expected, because that's "--ncp-disable"


4 got broken somewhat accidently - this is tap tests, relying on a=20
secondary client to be connected to ping "across the tap".  That client
is using pushed ccd ciphers, which fails in interesting ways

Aug  5 08:39:33 gentoo tap-udp-p2mp[2418]: freebsd-74-amd64/2001:608:0:814:=
:f000:3 PUSH: No common cipher between server and client. Server data-ciphe=
rs: 'CAMELLIA-128-CBC', client supported ciphers 'AES-256-GCM:AES-128-GCM'

but this error message is misleading - the client has=20

  ncp-ciphers CAMELLIA-128-CBC:AES-256-GCM:AES-128-GCM

in its config, but it's a 2.4 client so cannot signal this to the master.


So we *will* break pushed ciphers to 2.4 client swith non-AEAD ciphers=20
here.  Any idea how to tackle this?


Test run with "cipher bf-cbc" in all server configs next...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--VaKJWhUROU/xPxjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfKlUFAAoJEB2Cnv7KVigSgu8L/RgvdvK3QhLor8qKZOIHCcj0
TPstofjMaed+/i855ldksVccvDOqBu014dT2OKVIwOqT2oLu8QdNFpyg5iZmvnjz
+44bdbDqDwsHbl/GYXQUqj6joZi0BdxQEPs4CcZhn/o6H+ZHw57rVkNSn6UsNmwX
FIVpYy1hzejpHWRbZyH0rgiD8NQ7rwasyMZR3lZEyEUvLKs4a7vdWY3MttMmnp+c
a1NmjjQjYDDHInNIMcmyQ1amwOm9gX16hJHQSd3RJc+UYWxaQI2KnKNnxRRnTLGB
zK1syO4G6kpmO7t31eJZ9sBg3Sew8GJlw13N5no35ifJwyOyniZfxGN0MbFdxGBn
vaObj/uQ8Y/V2+mQmVRVSOBXNaMiuV1pi6dHdyAVIX3QEGGfGI6w/cxQ33RTKUi5
qchF0twUvO2Z9QUw+I1MfEc4j5KEmKODyZuaeMLdrb/vNMKfK1mrZJ4fhncO3FGk
hso8hFGKgSXnV88WBImf4do3aioGUgGyorsgTVgfgg==
=I14O
-----END PGP SIGNATURE-----

--VaKJWhUROU/xPxjb--

