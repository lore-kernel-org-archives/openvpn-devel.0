From: Fritz Elfert <fritz.elfert@...347...>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1285922.mbGntviEVa";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200502020908.26984.fritz.elfert@...347...>
Subject: [Openvpn-devel] Got OpenVPN 2.0rc6 working with OpenSC Smartcard support
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Feb  2 00:13:33 2005
To: openvpn-devel@lists.sourceforge.net

--nextPart1285922.mbGntviEVa
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


My mail got just bounced because it's too big so here it is again
without the patch ... Ill upload the patch to the SF patchmanager.

Hi guys,

I played around with OpenVPN on Fedora FC3 and Win2K and found it pretty
nice. Since i use the OpenSC (http://www.opensc.org) SmartCard framework
on both Win32 and Linux anyway, i wanted OpenVPN using it also ....

So here is a patch which adds OpenSC SmartCard support.
The patch is versus OpenVPN 2.0rc6 and is tested on both Linux (Fedora FC3)
and Win2K (built with VC6).

Some details and remarks:

Most of the stuff is in 4 new files:

opensc.c opensc.h - The basic OpenSC support, similar to win32 cryptoapi
support.

askphrase.c askphrase.h - A minimalistic GUI (native GDI on Win32, native
X11 on Unix) for several dialogs:
 - Requesting the user to insert his Card into the Reader (or an USB token
   or whatever OpenSC-supported device)
 - Asking for a PIN to access the SmartCard

The GUI gan be built both as a standalone app as well as _builtin_ into
openvpn (which i prefer). On Win, the GUI is capable to interact with the
user even when it is running as a service. On Linux, it needs a DISPLAY
 envvar to know where to connect and of course permission to connect to the
 users display. When built standalone it is something like openssh-askpass or
 pinentry. Currently, calling it from within openvpn is not implemented
 (would be similar like in openssh) but you can try it on a console.

Other (small) changes:

- Added an option for OpenSC: --opensc-cert
  argument is the cert-id as hex-string (just like in openssh)
- Added some code to tweak logfile permissions on Win32.
- Added some code to make running setuid on Linux working.
- Added a new subdir "win32" with Visual Studio project files,
  resouces icons etc.)
- Added misc automake stuff for Linux

Notes:
 On Win32, the binary distribution of OpenSC is linked agains a different
 openssl version. Since you cannot use 2 versions of the same DLL from
 within one binary, on Win32 one must rebuild OpenSC and/or OpenVPN linking
 against the same openssl lib.

 The icons for the win32 subdir cannot be in a patch - therefore separately
 attached.

I plan to build a more client-oriented multi-platform GUI (using wxWidgets)
which runs as a service on win32 (making openvpnserv.exe unnecessary)
and uses probably management IF on Unix (should be extended to use
Unix-Sockets). I also have an InnoSetup based Installer here (i don't like
nsis) here just in case someone is interested.

Well, for now thats all ... awaiting your comments / discussion ..

- Fritz

--
Fritz Elfert <fritz.elfert@...347...>                     Millenux GmbH
Lilienthalstr. 2                                  Phone: +49 711 88770 300
70825 Stuttgart                                     FAX: +49 711 88770 349
--------------------------------------------------------------------------

--nextPart1285922.mbGntviEVa
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCAIp6boM4mAMyprARAiAaAJ4hphc38oRJglmJ4ABK8VaStK5zdwCgp7j1
mRX+XWzwEPpbtUzL+L/fXbo=
=ybXN
-----END PGP SIGNATURE-----

--nextPart1285922.mbGntviEVa--

