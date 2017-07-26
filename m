Reply-To: openvpn-devel@lists.sourceforge.net
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <1500293278.28621.32.camel@...1866...>
 <b6adb528-5d31-fa7b-cd0c-e87b69e0854c@...515...>
 <1501010486.4771.113.camel@...1866...>
 <CAKh=nwEKFfAho0F7v0y3QJCq0s9-+iWfvg=YQVRHU=2JhNErcA@...278...>
 <1501056157.4771.133.camel@...1866...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <1cf29ced-4413-6b37-5cab-b6f0a8a1674d@...2080...>
Date: Wed, 26 Jul 2017 11:16:40 +0200
MIME-Version: 1.0
In-Reply-To: <1501056157.4771.133.camel@...1866...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="8VILgBHfIg7l539I0UldRn8hCGX1EOvRp"
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Woodhouse <dwmw2@...1866...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8VILgBHfIg7l539I0UldRn8hCGX1EOvRp
Content-Type: multipart/mixed; boundary="V1GtlH65lbrp1R8QMdhf14rSJdaxIb5md";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: David Woodhouse <dwmw2@...1866...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <1cf29ced-4413-6b37-5cab-b6f0a8a1674d@...2080...>
Subject: Re: [Openvpn-devel] Windows installer with updated pkcs11-helper
 (1.22) available for testing
References: <f7687ebf-a75f-095d-67ca-e32a5c4e53e7@...515...>
 <1500293278.28621.32.camel@...1866...>
 <b6adb528-5d31-fa7b-cd0c-e87b69e0854c@...515...>
 <1501010486.4771.113.camel@...1866...>
 <CAKh=nwEKFfAho0F7v0y3QJCq0s9-+iWfvg=YQVRHU=2JhNErcA@...278...>
 <1501056157.4771.133.camel@...1866...>
In-Reply-To: <1501056157.4771.133.camel@...1866...>

--V1GtlH65lbrp1R8QMdhf14rSJdaxIb5md
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 26/07/17 10:02, David Woodhouse wrote:
[...snip...]
>=20
> Well yes, that's true. But it's more likely that I'll finally get round
> to porting OpenVPN to something other than pkcs11-helper before that
> happens, unfortunately.

TL;DR:  If you or anyone else have a chance to look into this, we will
appreciate that effort enormously!  Just grab us on ML or the
#openvpn-devel IRC channel (FreeNode) and we can discuss it further.


Steffan and I discussed what is needed to be done to port p11-kit awhile
ago; we're also not too happy about the pkcs11-helper dependency.  If we
had only had support for one SSL library, it probably would have been
somewhat simpler.  But as we strive hard to have both mbed TLS and
OpenSSL builds to be fairly feature comparable (from an OpenVPN
perspective), this gets a bit more challenging.

IIRC, one of the more challenging parts here is to get p11-kit to play
nicely along with mbed TLS.  We are concerned that there are some need
to also adopt mbed TLS to support p11-kit.  However, I quite recently
heard some rumours that mbed TLS provides some API for offloading sign
and decrypt operations outside of the library; that needs to be
investigated further and to consider if this is a better way for the
integration.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--V1GtlH65lbrp1R8QMdhf14rSJdaxIb5md--

--8VILgBHfIg7l539I0UldRn8hCGX1EOvRp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZeF4AAAoJEIbPlEyWcf3yU/UP/Ag8s0V8jO50gd8ToCTKs8AI
t10L2W7mPzOKTKZEYiiz7F9JLPibW5JpmQZUnSvfbRiOX+XRMFHpX96W7RfcqkDQ
7fZ37Hf6S3Y+k9ONjwq1FTyiWJwqJ7A7Gb080k6qh5814c9Eon8Z6jh/hGleLbgn
mvwKnpuYXMOc6Mf1Xk9CRzekB+6fwDwkpgzKuuQn+vZz/rBXoYQ0x6R0/v9OXnFq
gyPsOoq1ZPbulIch2klaX3rbU+Y6iLK1hobH/2d7gX1Kux8rVwouipHFuTY/qwP4
RZfdegnX1mctycT1IgkKAKmNCLalK9Hpz1YBs8bFxBn0mV9Zwa9KrS2sVqGlBXAN
KgUmfKgj+7XhkyMzAy2MCA6rZ47shlzFFKH1yc98fuemn2w7nM783VmbD/qlZMJ6
6rWTVXhztQTOPyJRsV22eyumQuqqhuj9VJWwwu1PLeRbuAC35umgBQZfAaaGnFO9
K2shO6kFJ+GeLnUpXlOZwiiRyE9CuZUJVJn2F3BJBkiyvcBKkHvfIw3lp8CE1zaK
wZzSCwMsgjaHSBx51t3ILSDTFUjSN5mYebKeWwkEQ9AhX8ZJQF8Odyn08dYQscqQ
fFwdiOXRFWXos66o3Cay6T4pTJqbiWRkU0gGyHQw4i0KO09dsRovjO/QFY9Cerdl
lCvUOzhiQSkPKZs2I7g4
=PX36
-----END PGP SIGNATURE-----

--8VILgBHfIg7l539I0UldRn8hCGX1EOvRp--

