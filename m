Date: Fri, 10 Nov 2023 10:51:34 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZU39JoRBq8R_NgD6@...1296...>
References: <13E5C41C-8358-4252-A751-8FDA9EE95B7D@...2722...>
 <0acc8d93-6175-4d7e-a39a-269a9652ac3e@...1823...>
 <f2f54207-f37c-4c0d-96a3-a600cd2bb811@...1823...>
 <ZU3aVt0EgPyOQWEe@...1296...>
 <ae5ddbf4-44fd-4d4b-a045-53274aa9cc5d@...1823...>
 <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="uJx1Qn7HTTALkggc"
Content-Disposition: inline
In-Reply-To: <fe0a4e43-4015-4834-a9bd-8764baf0134a@...1823...>
Subject: Re: [Openvpn-devel] OpenVPN 2.6.7 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Dmitry Melekhov <dm@...1823...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--uJx1Qn7HTTALkggc
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Nov 10, 2023 at 12:25:22PM +0400, Dmitry Melekhov wrote:
> btw, what I missed, openvpn dies:
>=20
> openvpn[11346]: segfault at 0 ip 000055e33503f5f3 sp 00007fff33642390 err=
or
> 4 in openvpn[55e334fc8000+8f000]
>=20
> but only=A0 multipoint udp .

This is bad (but very different from "it stops forwarding", so it should
be much easier to reproduce).  Can you produce a log file with "verb 4" so
it shows what is happening before that?

I'll see if I can reproduce this case here and we'll fix it ASAP.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--uJx1Qn7HTTALkggc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJlTf0mAAoJEB2Cnv7KVigSBeUL/jyNRXvQh4lUsmK6Z2TNechZ
HX1V+rahkAn91aMqLMISsmBMMqR4TAKpJet37W3fOGh75sRdEj7ExodaZ4WGBCjZ
Fcu6HQqRNo0MtXflpwJbQ9kAyE3C31u8Iiv2MjGG4BeagW2b0L5A47zb5zgjr0wv
fNiTgBs5uO9giaMz0WpGC1FpVH2E0OELaDnC1KKG0u8xayzEqIasZfuJRz9OxDKK
+daiF2mFw3wkIjZwQbbVeO1bQQjwkgYjgJ7ihGAsgDCnz1tyKQsjsK0T3JqdNBFL
jKrYX5/2j9Ba+wJRANI159qDi34yyablwCKbdL/YJrwsUIxp3XDo043dL+vhArwf
X8WLW1ubp4BTPmcACLatm6v3wq8kVVBeUvQvTbqcZD1Gcy/lGjZuHR7d5jlh9A0d
oc6XRwc5xUAQZgHMDrs0WZbw7drM0lntIYA9V3eDfrWqGC4Qo5ywIxPyciaRONXX
m+wbvh7ZmELwHAOTLXLKb76o9CS15NlCa+hDhAYWXA==
=TYOR
-----END PGP SIGNATURE-----

--uJx1Qn7HTTALkggc--

