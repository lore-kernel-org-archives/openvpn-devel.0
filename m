Date: Fri, 5 Nov 2021 21:54:18 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YYWZ+oMHAjCrNLb8@...1296...>
References: <CAKuzo_jQvbGX8OEM4-c82F77gqyiCEyeVW-fVbt7EK=0p9kFZw@...278...>
 <CAKuzo_iGD2MGVOBf6+pegEYA0_VdnWKZbheaizshvqbOHB=h8g@...278...>
 <6a3a0ed8-5c38-a29d-bf71-a7555950e0c2@...1227...>
 <CAKuzo_gYfbtxiyW1HggYtGsFDdva_buegw0eSi=KFrQ-Yy9WXQ@...278...>
 <CAKuzo_iMTaRMNM2b_GsYDwFzMXw=Aw0UP+5e04QqGgLHQaPPEQ@...278...>
 <882f9257-9c7e-8a08-2324-76c182ac0f9d@...1227...>
 <e556418b-c5d7-49c7-e741-c8aed0a95ad8@...1227...>
 <CAKuzo_i9n6aJtLo1cGsdtLGK8RZR_ngN9LYKiHOwqFFAASdB3g@...278...>
 <CAKuzo_g6EcwatKLL_LgZSJY0PX4d+NO7W40E3D9aRpFwAc9taw@...278...>
 <CAKuzo_jejaV=PpoT3vmdJj8BcipMs7WLDuiahWYxuemi7cnBGA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="OUw/WkAVQ0SW/0Ot"
Content-Disposition: inline
In-Reply-To: <CAKuzo_jejaV=PpoT3vmdJj8BcipMs7WLDuiahWYxuemi7cnBGA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 0/9] A built-in OpenSSL3.0 provider for
 external-keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OUw/WkAVQ0SW/0Ot
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 02, 2021 at 12:40:50AM -0400, Selva Nair wrote:
> OpenSSL folks have merged their "fix" in the provider interface that I was
> waiting for. It will be in the 3.0.1 patch release. In the meantime, I ha=
ve
> opened a matching version of this patch set as a PR for OpenVPN for
> comments/tests/bug-reports/nitpicks. I skipped v2 and this version is
> tagged v3.
>=20
> Will post the patches to the list when OpenSSL 3.0.1 is released.
>=20
> On top of v1 patches this also includes handling pkcs11-id and
> cryptoapicert options through the provider. Requires OpenSSL from either
> the master branch (3.1.0-dev) or 3.0 branch (3.0.1-dev) post Oct. 27.

This sounds really nice.

I'll see if I can get Steffan, Max and Arne interested in looking at the
PR tomorrow :-) - face to face discussions can be some much faster than
email with asynchronous schedules...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--OUw/WkAVQ0SW/0Ot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhhZn6AAoJEB2Cnv7KVigSWEEL/0frQ9ULFhdzKuT9EjRgC1S6
+2nAatnDdoQWSk6LBETgI3OHK5kiC/A6AlF6IpTiDSnFW7LJxPfYHMiGKxQFxhGm
Uj7l949jTDQD5xuo2PUsXRHrOh7urk3N56Uzfew4N8UrxPa/JQXp3pJMeOcv/VAe
Rn0C8ti8XYLyxofQmjy1ujSL/eeKeUy127AwkLNysDtwNPY3he6UGgXetwG1mAdg
9VDk3Rn44W72DpwdqA6zUAyUnd5xnb3BvskQhgMjihGu1me3UzCiVGz2WoCwoV81
UPmefQISWUbE0dPaAe3MHMG/rnF4jFKrkKPqsx+B/aVw8kc89nmfDvr0DcewW/yL
g9DquieWkuQcsvn7V2hLY42obOS2mLFZgtMKwHb6oHUuLlqni5U40hREixH9ftRv
ZlO7JnOnwOHeqzqUwSuWwa4O44teaBbXPw3BxvJecbPmHu8UYvdelxkVy6MA1bFV
WcWicaElg0GQqhrO1HjsSYHDGlgzoTlFIR/5qkDZEg==
=Vl07
-----END PGP SIGNATURE-----

--OUw/WkAVQ0SW/0Ot--

