Date: Sun, 20 Feb 2022 15:04:30 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YhJKbnyZYeuTk0Fd@...1296...>
References: <20220107145359.311-1-lstipakov@...277...>
 <CAGyAFMXNQnQ_jeoQXJSkW8xXn8QM0nqeJHYB5xL288U6t+TcJw@...278...>
 <CAFHpkQFwO0qMqWhtUidv0TNWyGrsnMHqYVib12yCzowBgL1KtQ@...278...>
 <CAFHpkQE-LBkt-Lyz97vLdgQFt7VPLmedw8ogNojVy2p3GsdaiQ@...278...>
 <CAGyAFMWQLs2=BoF6fhUcG6gLN5LvPA9xHZ8JRocdH5-DL5LW_w@...278...>
 <CAFHpkQHURwN2x=AC_RK38tjwD8kGgHhSbq==espXJHSM33L6ZA@...278...>
 <CAGyAFMWN-4rLAjPEwUbDqE79gs3bUWWSFLSnzz9QaTgiQSKQHA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZxB+x/qpBfo192Sf"
Content-Disposition: inline
In-Reply-To: <CAGyAFMWN-4rLAjPEwUbDqE79gs3bUWWSFLSnzz9QaTgiQSKQHA@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2.5] msvc: adjust build options to
 harden binaries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: ???????? ?????????????? <chipitsine@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZxB+x/qpBfo192Sf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 17, 2022 at 01:55:35PM +0200, Lev Stipakov wrote:
> > can you please apply "pdb" patch to your branch ?
> > CI: github actions: keep "pdb" in artifacts =B7 OpenVPN/openvpn@...2658...=
...
>=20
> Done! https://github.com/lstipakov/openvpn/actions/runs/1858390624
>=20
> > BinSkim uses pdb for analysis.
> >
> > probably, it makes sense to apply this patch to release/2.5 branch as w=
ell
>=20
> I agree. /me looks at Gert.

I'm a bit confused on what exactly you want applied where now.

What is "this patch"?  This one, or "the pdb patch", or yet something
else mentioned in this thread?

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZxB+x/qpBfo192Sf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiEkpuAAoJEB2Cnv7KVigSssAL/1vKyDkATBEcZRHm0nQ2ZZiI
kpPyec0+gtVPl/x+pFfbbLc+8vmyru9jS5I5SY/mchngfdC5P+Ai6shlHPpxdVO3
TBANchM4zUPWr5QfcgPBBA11fq9Z20s0TtYzfWqZQuEnWG1H1nmrFjvJfL9pgRo+
pJPYFkrn7VP5baE/8aIro95rIxrY5X8yGNwqW+F7BojnQLTcyymMWwwkNJ04UKdX
vI08HBFoygizNsc1QIfRyk2mo9baBNfIre/jpfFCOl7crDoHCdig43sOQ4YL/ju2
l/jUpulRTRarqP0hzggO09fXcvIFVC8cucJv+8KKhzNKk+mmFN1wo9P944qUikee
aegUZDGEQWRvQ+8suqVUn+Z21c7Dv8hrNR/n0DoJjgljbNmygndYNtdw9Lc/Ahcy
hIorRPgXHpGSFmixXfJdKsdB3ESXDTSCpRNzsIeQk80gOsEnF5bdjsTQs+IgX7FS
3J3exnjIRnyEE+ASp0cUiEB8CNp1yyuQ5/DxRQMfpw==
=bA3o
-----END PGP SIGNATURE-----

--ZxB+x/qpBfo192Sf--

