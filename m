Date: Wed, 8 Sep 2010 16:11:34 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100908141133.GM10703@...1296...>
References: <201008132145.25557.hhund@...194...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="myGquMeQRBVzK6Jb"
Content-Disposition: inline
In-Reply-To: <201008132145.25557.hhund@...194...>
Subject: Re: [Openvpn-devel] New openvpn-gui snapshot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <hhund@...194...>
Cc: openvpn-devel@lists.sourceforge.net

--myGquMeQRBVzK6Jb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Aug 13, 2010 at 09:45:24PM +0200, Heiko Hund wrote:
> I have uploaded a new snapshot binary to Sourceforge today [1]. The GUI n=
ow=20
> uses the OpenVPN management interface as a first step towards connecting=
=20
> without elevated rights under Windows Vista and later.
>=20
> That unfortunately means that nothing new can be seen really as all the=20
> changes happened in the non-GUI part. However, I would like to encourage =
you=20
> to check it out with your current setup anyways, as I'm pretty sure that =
I've=20
> introduced regressions. Comments and bug reports are very welcome.

Maybe it's just me, but the new openvpn-gui just doesn't *do* anthing
for me... I can start openvpn-gui-<number>.exe --help, and then I get
a "help" window, but if I run it without any flags, it will just return
to the prompt, and that's it.  No message, no windows, no tray icon...

(This is on Windows XP SP 3, trying to build an openvpn-devel installer
that includes a working openvpn-gui, ipv6-enabled openvpn.exe and=20
ipv6-enabled-and-signed tap driver...)

gert

PS: if you're around, just grab me in #openvpn-devel
--=20
usenet is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--myGquMeQRBVzK6Jb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTIeZlakuBuNlUUl1AQLcxgQAt32mrfTf3fv1SGi17fA1/6bAVARxySwU
oPANt2+YPACaKQihjmA41xbx+Mevqnj3tzblrIq4ADap0GJopnoKgDfYV+yJ9MIe
VHbhb6HB6sYSvol7IiLUgKCF7jh1Mi/p/777HyiqlZkgWTDW1nVfLh/mfqwqh+89
iNv7pCTkHnc=
=z3Xa
-----END PGP SIGNATURE-----

--myGquMeQRBVzK6Jb--

