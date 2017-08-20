References: <1503220744-5569-1-git-send-email-steffan@...1856...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <a3a90358-ada4-2016-cd7e-98f94ec2a3b5@...2181...>
Date: Sun, 20 Aug 2017 17:59:51 +0800
MIME-Version: 1.0
In-Reply-To: <1503220744-5569-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="9XU3AmO6hx6eVancusO5d901QLTHfFWQI"
Subject: Re: [Openvpn-devel] [PATCH] travis: reorder matrix to speed up build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9XU3AmO6hx6eVancusO5d901QLTHfFWQI
Content-Type: multipart/mixed; boundary="GgMIqNGaFtCpuUICXLgorjl62qfNonC1h";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <a3a90358-ada4-2016-cd7e-98f94ec2a3b5@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] travis: reorder matrix to speed up build
References: <1503220744-5569-1-git-send-email-steffan@...1856...>
In-Reply-To: <1503220744-5569-1-git-send-email-steffan@...1856...>

--GgMIqNGaFtCpuUICXLgorjl62qfNonC1h
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/08/17 17:19, Steffan Karger wrote:
> The OSX and mingw builds are much slower than the other jobs.  Our free
> travis account can only use 4 build executors in parallel. Run the slow
> builds earlier, so that when one or more of these finish, the free build
> executors will start building the configure variants in parallel with the
> slow ones.  (Instead of doing the slow ones last, which results in using
> only 1-2 executors during the end stage.)
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>

Nice idea! This should indeed help quite a bit.
Patch is easy and does exactly what the commit message says. ACK.

Cheers,


--=20
Antonio Quartulli


--GgMIqNGaFtCpuUICXLgorjl62qfNonC1h--

--9XU3AmO6hx6eVancusO5d901QLTHfFWQI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAlmZXZ8ACgkQ0+HICM1s
oFBLjQ//YVfLxd8+RNdgSnWLknKwtNOKKcI5Z4JLTYoZA+10qZSQRB3FJnMvQaQq
/aj7P+ises9TZmhQ+JtvhDcIQVSWF9H3QNm7trGTCviw2ZlF2JtUzYOkB90EP09c
nt4PP26zz6IvNTc/TaT5HVKD3YKR/y1v+PHnnooN7UOSMmgAaRgwS3+NOUa0xrFe
qEU1BDGjKb7Cmvqo8O4lg1UTU6h4cOfk+ybx8gquty/OvepFENt2osV3Tdp5D07E
RJOAd9rv63w8MOP9gr1oepmp6jnlBX8CdvKf3gUzFsmFXiYU5l6i/+yOD3f1fliv
z43j0aDlGwRQhG3LII4+0AHMJe9Kc8AFrhx/EvUfaMt4d6fKcg+S7QvOCMmdWsGn
LJvQVidj/2KwKeSqRzCfIUJ991JmVPvVeflYVmDMePgVg4sJeO0QoFy4FsnBgBUk
mrLmeVvhrZNNVlCoF5HYBI6v3r1S6fZwfb557OFQhuUvBTYkcBW3fTJeUr8kCGDh
H58fNSWD+BJfv9iEhU50HHFyt0zs3xCq5V0cu+MzctkbWz7ceIrvZ0moLetwpjBT
dfJESb89vB9U2IdB7ICL3uYuhRQLR6/eSLRFSweefQc1QBf2wRAD7Cy4hUGpZuxw
0FWKHp8DFGc13t3SPLAUnfYI2zZXG7vQwmLJbLxnABK5uhUyjSU=
=K+6q
-----END PGP SIGNATURE-----

--9XU3AmO6hx6eVancusO5d901QLTHfFWQI--

