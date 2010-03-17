Date: Wed, 17 Mar 2010 23:53:25 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20100317225325.GE25238@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NZ00oluAJr3A0NMv"
Content-Disposition: inline
Subject: [Openvpn-devel] Windows, OpenVPN-GUI, disconnect
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--NZ00oluAJr3A0NMv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

can one of you tell me what happens "under the hood" if I click the
"disconnect" button of the openvpn-gui under Windows XP?

Why am I asking?  I managed to get my windows build environment working
well enough that I can now build a complete installer package with the
IPv6 patches, and with the adapted tun/tap driver - but it breaks in
funny ways.

 - Installation works fine
 - running the openvpn-gui (precompiled) works fine
 - (client) connection to a TUN server works fine
   [initiated by pressing the "connect..." button of the GUI in the=20
    windowsstatus bar]
 - IPv4 and IPv6 connectivity works

 - pressing the "disconnection" button of the GUI doesn't seem to do=20
   anything.  Well, the status window says "disconnecting..." and the
   button is greyed out - but no update in the log file or the status=20
   window, no nothing.

I assume that "something is miscompiled" or "a newer version of mingw
has some surprising side effects" - but to know where to start looking,
it would be helpful to understand what signalling is used=20

  openvpn-gui --> openvpn.exe

to signal disconnect.

(Since I didn't touch any of the signal handling stuff, I'm fairly sure
that it wasn't one of my changes, but I still want to have a working
Windows bundle to get people to test it)

thanks,

gert

PS: the TAP driver changes have been successfully tested on 3 different
WinXP systems now.  Win7 doesn't work "as is", as it requires a signed
driver.
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NZ00oluAJr3A0NMv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (NetBSD)

iQCVAwUBS6FdZakuBuNlUUl1AQL8DQP/e4TOs+AgDOd7RwQzvQdn8SQUqk9v3D40
UTH1MBVQC6yMV3hIAdOLb1dUazW6CnggB4bkcB9Mfi+gQkdHAB9/2fsj4RtfpjI8
2Npy0B19dmkPUyn9u5Pfc6da8tgCITteGiZWPUh9/iF+mA9ykfD2grBQIZVcjqqn
A6PbO+wJIOo=
=37fN
-----END PGP SIGNATURE-----

--NZ00oluAJr3A0NMv--

