Message-ID: <47ED5E94.4010701@...1085...>
Date: Fri, 28 Mar 2008 16:09:40 -0500
From: Josh Cepek <josh.cepek@...1085...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC30B395F37952EBCE7A50FC8"
Subject: [Openvpn-devel] [patch] Windows --up parameter quoting problem
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC30B395F37952EBCE7A50FC8
Content-Type: multipart/mixed; boundary="------------010603060900000609060002"

This is a multi-part message in MIME format.
--------------010603060900000609060002
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable

Under Windows, when run_up_down() from misc.c executes the --up script,=20
the position of the parameters depends on the device name of the tun/tap=20
adapter.  For example, a default installation creates a device that may=20
be called "Local Area Connection 2" (number varies), but this device=20
name isn't quoted when passed to the --up program.  This makes=20
determining the actual name (or any other parameters for that matter)=20
nearly impossible.

I've attached a patch that quotes the device argument in the=20
run_up_down() function insuring it is always the first argument to the=20
--up script no matter how many spaces appear in the device name.

--=20
Josh


--------------010603060900000609060002
Content-Type: text/plain; charset="utf-8"; name=device_name_command.patch
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
 filename="device_name_command.patch"

diff -Naur openvpn-2.1_rc7/misc.c openvpn-2.1_rc7_new/misc.c
--- openvpn-2.1_rc7/misc.c	2008-01-23 21:08:41.000000000 +0000
+++ openvpn-2.1_rc7_new/misc.c	2008-03-28 20:34:15.000000000 +0000
@@ -206,7 +206,7 @@
       ASSERT (arg);
=20
       buf_printf (&cmd,
-		  "%s %d %d %s %s %s",
+		  "\"%s\" %d %d %s %s %s",
 		  arg,
 		  tun_mtu, link_mtu,
 		  ifconfig_local, ifconfig_remote,
@@ -225,7 +225,7 @@
       setenv_str (es, "script_type", script_type);
=20
       buf_printf (&cmd,
-		  "%s %s %d %d %s %s %s",
+		  "%s \"%s\" %d %d %s %s %s",
 		  command,
 		  arg,
 		  tun_mtu, link_mtu,

--------------010603060900000609060002--

--------------enigC30B395F37952EBCE7A50FC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFH7V6YHSSgJy5aUScRAkkuAJ97c//lX5Us627T+gzQJ1nwa82KJwCfV8RH
nVnyHFlf/YDg/wkFoDrX4r0=
=7TgF
-----END PGP SIGNATURE-----

--------------enigC30B395F37952EBCE7A50FC8--


