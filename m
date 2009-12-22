Date: Tue, 22 Dec 2009 12:15:45 +0100
From: Frederic Jaeckel <jchome@...1283...>
Message-ID: <20091222121545.6310972bjchome@...1283...@jc-ix.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
	boundary="Sig_/n0JiqYp7kF8BRgohIcZ/cPT";
	protocol="application/pgp-signature"
Subject: [Openvpn-devel] Setting lladdr in NetBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Sig_/n0JiqYp7kF8BRgohIcZ/cPT
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hi,

todays openvpn isn't supporting NetBSDs way to set the lladdr for
tap(4) devices.

Here's the patch to support this.

Please integrate this in the next release.

best regards and thanks for the work,
Frederic Jaeckel

--- lladdr.c    2009-12-22 12:08:23.000000000 +0100
+++ lladdr.c.b  2009-12-22 12:08:14.000000000 +0100
@@ -36,6 +36,11 @@=20=20
                    "%s %s lladdr %s",
                    IFCONFIG_PATH,
                    ifname, lladdr);
+#elif defined(TARGET_NETBSD)
+  argv_printf (&argv,
+                   "%s %s link %s",
+                   IFCONFIG_PATH,
+                   ifname, lladdr);
 #elif defined(TARGET_DARWIN)
   argv_printf (&argv,
                    "%s %s lladdr %s",

--Sig_/n0JiqYp7kF8BRgohIcZ/cPT
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkswqmIACgkQ33vaRvWgIxSfCwCcC27SCw5IvLUUDiFMN5gf5ak5
NaIAn0B1/p9yYrJeYwTci5GmXGw3rC5m
=3EWq
-----END PGP SIGNATURE-----

--Sig_/n0JiqYp7kF8BRgohIcZ/cPT--

