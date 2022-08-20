Date: Sat, 20 Aug 2022 11:45:15 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YwCtK2WhEu8P0tZk@...1296...>
References: <20220820084719.243-1-lstipakov@...277...>
 <202208200929.27K9Tt1M009928@...2054...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8GkbUwlTu3P11weN"
Content-Disposition: inline
In-Reply-To: <202208200929.27K9Tt1M009928@...2054...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: dco-win: use run-time
 dynamic linking for GetOverlappedResultEx
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lev@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--8GkbUwlTu3P11weN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Aug 20, 2022 at 11:29:55AM +0200, Gert Doering wrote:
> Acked-by: Gert Doering <gert@...1296...>
>=20
> I have *not* tested this, but we've discussed the patch on IRC, and the
> code matches what we want to achieve.  We've had GetProcAddress() dynamic
> resolution in the code before (some IPv6 vs XP/Vista stuff, IIRC) and
> this all looks reasonable.  GHA claims it compiles, and Lev said he has
> tested on Win7+Win10.
>=20
> (The intention is "have one single openvpn.exe binary for Win7 + Win10/11,
> which will do non-dco stuff on Win7 - no driver - and DCO stuff on=20
> Win10/11" - much simpler than having to build extra Win7 installers, and
> we still want to support Win7 "unless it's getting too costly")
>=20
> Your patch has been applied to the master branch.
>=20
> commit 2f8053f9a97584b759d11d05a668d38653508617
> Author: Lev Stipakov
> Date:   Sat Aug 20 11:47:19 2022 +0300

For the sake of transparency, I did a mispush of this commit to=20
github+gitlab, with the wrong URL: in the commit message (it was intended
to go to my github instance only).  I fixed this about 3 minutes later
for github, but it took a bit for gitlab.

So, if anyone noticed this commit with the ID 532c006b being in the
repo for a few minutes, this was not a malicious person, just fat fingers.

*No code change* between these revisions, just commit message.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--8GkbUwlTu3P11weN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjAK0rAAoJEB2Cnv7KVigSz6ML+gOPHsZnNCqQ965F+/H6rW/Q
06kCl2ZsBbxNZRD7zQWJGEPZdyzre9zVyceYeNYoog54FtEZXIFRWnFQdt5fvLFs
5IegpRVvQXsQIIiAMxcs5EUP5PW3VKoYmGV8gB/m5SG8o656oKVI143kLd8hj+Qh
d6KoLw3dcX0wAulArDGIxjiOMwH/11s6xYs5sp9Kqhf/ttqgQhlKSIfR/HJUeSle
zuPXBEslaH5Ehzs7C1jK57AKwlUBVwjh54cdF1K9y6/4TRcQphqclIMRL1LNkcTG
/QMjapaFaLtX0T8mzrq03NsO5w9el60vzMameklbYi9/hmazK6b19eUXAd7mMv3f
KlbS3fMSYW/9AQ47zDM1c+ieISAqNmK39U0YpiHjfwdJoJCeTdH2Gn/XRCMWO7rr
O9XEbNVxEkQtZhaI/IPiOEoB9Xzi+N+Rwcb+b4SRPCX5wAR2hZNvRhwaFXdFxQX8
GjARV3LYUIL0dfEfuAX03ZWGGT71FU0Qt9PLzorlNQ==
=DC76
-----END PGP SIGNATURE-----

--8GkbUwlTu3P11weN--

