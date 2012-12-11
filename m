Date: Tue, 11 Dec 2012 13:49:05 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20121211124905.GV22465@...1296...>
References: <50C12AFA.7020103@...1785...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L6+lUPd1XOsaFBch"
Content-Disposition: inline
In-Reply-To: <50C12AFA.7020103@...1785...>
Subject: Re: [Openvpn-devel] bug with "ip-win32 netsh"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David TAILLANDIER <david.taillandier@...1785...>
Cc: openvpn-devel@lists.sourceforge.net

--L6+lUPd1XOsaFBch
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Dec 07, 2012 at 12:32:10AM +0100, David TAILLANDIER wrote:
> Windows 7 64bit      OpenVPN 2.3_rc1 x86_64-w64-mingw32
>=20
> If the client configuration file contains "ip-win32 netsh", OpenVPN=20
> issue the following system command :
> c:\windows\system32\netsh.exe interface ip set address Local Area=20
> Connection 2 static 10.8.0.6 255.255.255.252
>=20
> The command fails when the interface name contains spaces, so it must be=
=20
> surrounded by double-quotes : "Local Area Connection 2"

Have you actually seen this fail *in openvpn's log*, or have you tried
the command show in the log in cmd.exe, and seen it fail there?

The openvpn argv_printf/execve mechanics is... magic, so the interface=20
name ends up in its own argv[] parameter towards netsh.exe, and quotes=20
are not(!) needed - to the contrary, if you add quotes there, they become
part of the interface name, and netsh will complain.  Copy-pasting the
command from the log to cmd.exe will not work, as cmd.exe would indeed
need the quotes.

I've just checked the code - while I never used "ip-win32 netsh", I did
the netsh calls for IPv6 routing, and they do not quotes either - and
work great for interface names with blanks in them (my test system uses
"My Tap Adapter").

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--L6+lUPd1XOsaFBch
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (NetBSD)

iQCVAwUBUMcrwakuBuNlUUl1AQLM3wP/YrhilCamdAfMh27OKbBtLK6oICZ7dd4k
hVPdFLrtPVB/2Jh7BzapfT/2ji3KROb2cRYgitfV8m/3GGCGWCYAHk+fPS8xNmBO
ogFeZKWtnV7bfbEZdXDw2PuHR5lFPgVZNuR8qO+qUKlX7pyrAVEPdbSU1WI5Evdf
pldh9aAH2Ns=
=W3LD
-----END PGP SIGNATURE-----

--L6+lUPd1XOsaFBch--

