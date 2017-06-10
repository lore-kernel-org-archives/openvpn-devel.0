Date: Sat, 10 Jun 2017 20:33:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170610183303.GO97029@...1296...>
References: <8737brk7vm.fsf@...2274...>
	<20170526165606.GQ97029@...1296...>
	<CADxRZqwYw0RLxCDB-u3NmrLUBONng5DyT-1e9q-37HDHPpnCrQ@...278...>
	<877f0jvmwi.fsf@...2274...>
	<20170610174642.GK97029@...1296...>
	<8760g3u3m2.fsf@...2274...>
	<20170610181126.GN97029@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ntx0qR0AcFgD0gxf"
Content-Disposition: inline
In-Reply-To: <20170610181126.GN97029@...1296...>
Subject: Re: [Openvpn-devel] Alignement crash on sparc64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Anatoly Pugachev <matorola@...277...>, openvpn-devel@lists.sourceforge.net, Stefan Sperling <stsp@...2273...>

--Ntx0qR0AcFgD0gxf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 10, 2017 at 08:11:26PM +0200, Gert Doering wrote:
> > I merely copy/pasted the NetBSD code.
>=20
> Uh?  Is this from the NetBSD ports tree?  Because our tun.c does not
> have a single memcpy() today... :-)
>=20
> Actually, my tun.c's TARGET_NETBSD version of write_tun() has something
> similar to what I suggested:
>=20
>         struct openvpn_iphdr *iph;
>=20
>         iph =3D (struct openvpn_iphdr *) buf;
>=20
>         if (OPENVPN_IPH_GET_VER(iph->version_len) =3D=3D 6)
>=20
> ... slightly more speaking, and since "openvpn_iphdr" is a locally=20
> defined structure with "uchar version_len" at the very beginning, this
> amounts to the same thing.

Aaaah.  I have been enlightened - there was a second patch, which does
exactly this :-) - and I had not seen the mail yet.

Thanks, will give it a closer look.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ntx0qR0AcFgD0gxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJZPDtfAAoJEB2Cnv7KVigSHDYL/14pwl5X/CMEKdVzqeiH76Fj
r9mqim7PTQyI6aowyt0pjhOZvdVRYh/GwngFWr1lBX7C/ScKMR6mjdguY2Si4nG+
oR2xidkkeyHvnri/V28j9apOnL39FDYSCLj+pQRdQOuA13pPPfGPhHevo1BPE2HF
LzIe83tgwsqt1nKnuTJXBJKxWAqhdpJCcRtluaorsdx7Gsz6tr6m2V07a012Hh7d
tQziNhyC2d2v9PJc4HeCxWQ3/lSr0KSeWV9rtJr5PZf5+ePxTbEQJTvaf2c471+f
PHLZNlZmyFyb1sX6jwPDetM+9fZLwjvHm8TaluvHvN2N3l5kYEQ4297apMJeEWyi
lJ5NIRJuXzHsSD2WbDMt4SmhkMBhdCqAMLG5KT1Z4NCDUn/s4guA8Rm6fVo56M0k
3WapHhYOuMVuLaqrlnBKGdeXgkrdaIvbtWYO6nzJzG9nnn6/o3lOE0edv7p5aJlK
/6ld6QZJpv/MNw+xSHZGmeXJSOmI6Pzox2XjXciREw==
=zd0W
-----END PGP SIGNATURE-----

--Ntx0qR0AcFgD0gxf--

