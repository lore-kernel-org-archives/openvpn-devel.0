Date: Wed, 8 Sep 2010 17:34:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20100908153428.GP10703@...1296...>
References: <201008132145.25557.hhund@...194...>
	<20100908141133.GM10703@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SSjFkhywpXnVG+rz"
Content-Disposition: inline
In-Reply-To: <20100908141133.GM10703@...1296...>
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

--SSjFkhywpXnVG+rz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Sep 08, 2010 at 04:11:34PM +0200, Gert Doering wrote:
> Maybe it's just me, but the new openvpn-gui just doesn't *do* anthing
> for me... I can start openvpn-gui-<number>.exe --help, and then I get
> a "help" window, but if I run it without any flags, it will just return
> to the prompt, and that's it.  No message, no windows, no tray icon...

OK, that was my doing.  The gui checks the version number of openvpn,=20
and if openvpn reports "openvpn-testing-<commitid>", the gui doesn't=20
like that...

Version number is now "2.x-testing-93dc9179e978", and *that* works.

So - if you want to play with it, here's a windows binary of "testing",
"allmerged", with IPv6, James' signed TAP drivers(!), and a working GUI:

http://www.greenie.net/ipv6/openvpn-2.x-testing-93dc9179e978-install.exe


We found one problem in the GUI already: if you only have a single openvpn
config file (foo.ovpn) in your config directory, the gui crashes if you
double-left-click on the tray icon.  It works if you right-click on
the tray icon and then click on "connect".  (Heiko can reproduce it,
so it's fixable :-) ).

While you are connected, double-clicking works :-), and then clicking
on "disconnect" also works.


Please reports bugs to the mailing list or to Heiko (gui related) or
me directly (openvpn/IPv6 related).  Please include your windows version.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--SSjFkhywpXnVG+rz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBTIetA6kuBuNlUUl1AQL1AwP/f4sZ+zw/nYPfxyF1ydUYkhCSLGqizSaX
fyi7ey3OJBWFRnOv4xnXbpL+0AUAQxyIrxZr78iNgtAlkHOfWMjwcNNg1aGs9mmz
ByMRnTk83kvJ6k+PfMMI5dvWIRoj07xWonqdpD9Jh0tcXQrcKRqt933dBYoxpJLw
Xu2fyTnrYsk=
=KAjy
-----END PGP SIGNATURE-----

--SSjFkhywpXnVG+rz--

