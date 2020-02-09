Date: Sun, 9 Feb 2020 10:50:39 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20200209095039.GY1431@...1296...>
References: <20200207174818.21050-1-juliusz@...2525...>
 <20200208084558.GV1431@...1296...>
 <23330b19-35b6-7e4e-2f2e-9c3c1626f53d@...2525...>
 <fb9901f1-d304-ca31-cd9c-23712f320bd3@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pcjGMRtmGLNVN1Bo"
Content-Disposition: inline
In-Reply-To: <fb9901f1-d304-ca31-cd9c-23712f320bd3@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL with OpenVPN master
 branch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Juliusz Sosinowicz <juliusz@...2525...>, Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--pcjGMRtmGLNVN1Bo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Feb 09, 2020 at 10:44:48AM +0100, Antonio Quartulli wrote:
> if wolfssl support is being introduced by means of the openssl
> compatibility layer, why do people need to configure OpenVPN with
> "./configure --with-crypto-library=3Dwolfssl", rather than just using
> openssl and specifying a different path for headers/libraries?
>=20
> Isn't the compat layer in wolfssl operating as a drop-in replacement for
> openssl?

This question has been asked before and answered :-) - most of the
compat functions seem to be implemented as macros, which our configure
will not find.  So, configure needs to explicitely define what is there
and what not.

I do not like the extra include very much, but that seems to be hard=20
to avoid with the current WolfSSL header file setup.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pcjGMRtmGLNVN1Bo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJeP9XvAAoJEB2Cnv7KVigS1b0L/i6fogjskrhKHtszQ2H3tLab
8NP/KZ0Epi1rkXiQ4l3ild3BNmzl65DeOjJ0Nw706AWGDsGzVS0IjTio0eCnli2y
pvOP3Ma/nPHaX0plRSEmXbvQQ5tBE6JYFxLnLXUa59q5EZFe06exDfu/LcQp9fqd
MyuNcGyG5t22i2RACR34sfYtmN+fSYMwgx6akRPTd+zOmMrLV4bLvZpjpFmGR2y+
+ENlqKTrW9ALTkPCj3mt/1wIQx/MlqE1NQX+GJhnNm3FxJGz1kQwcJEPr+QrzVNG
3cRQ78IcV5IXiSoJloziX7aJSd0x82CpZbNF4L/w5pO52zpuOSrqRwE9+ATd9qbu
VG1OAnA0mJ/Q0wZ2lcK33qs5MGuIzetE0phl4tsjXeshofpJx/JoWBM+QBgpVWU+
GQfC/Vb1FVrcGZXMBno/cpLVkdXcaE4bSvsCS7QV3FCqWPwWJ+ODPbtljhISos8A
U+R5B/S7Jlm4T4co76pE9+Fk8nYBHITYNlHxmXGQ7Q==
=OF4L
-----END PGP SIGNATURE-----

--pcjGMRtmGLNVN1Bo--

