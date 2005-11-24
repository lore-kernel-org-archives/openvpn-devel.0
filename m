From: Nielsen <nielsen@...505...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030006080901040303090002"
Message-Id: <20051125055759.373AE70DD18@...506...>
Subject: [Openvpn-devel] [PATCH] Allow dynamic choice of source port
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
Date: Thu Nov 24 21:45:00 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030006080901040303090002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

As it is openvpn has no way to allow the kernel to dynamically choose
a source port for it's connections. If you have two openvpn client
processes on the same machine both you have to configure lport to
different ports manually. This patch allows you to specify '--lport 0'
and get the behaviour of normal programs, where the source port is
dynamically chosen.

Not sure if this is an issue for others, but here's the patch in
case anyone has run into the same issue.

Cheers,
Nate Nielsen

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDhqR2e/sRCNknZa8RAkxcAKCLOrVEiVp0NZ3cBr0XQuemmGMkZQCdFbWl
hgFOINIEwoZnYcs2noCM8ik=
=2H3u
-----END PGP SIGNATURE-----

--------------030006080901040303090002
Content-Type: text/x-patch;
 name="openvpn-local-port.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-local-port.patch"

diff -rU 3 ../openvpn-2.0/options.c ./options.c
--- ../openvpn-2.0/options.c	2005-04-16 16:03:15.000000000 -0600
+++ ./options.c	2005-07-22 12:54:12.722483296 -0600
@@ -3189,7 +3189,7 @@
       ++i;
       VERIFY_PERMISSION (OPT_P_GENERAL);
       port = atoi (p[1]);
-      if (!legal_ipv4_port (port))
+      if (port != 0 && !legal_ipv4_port (port))
 	{
 	  msg (msglevel, "Bad local port number: %s", p[1]);
 	  goto err;
diff -rU 3 ../openvpn-2.0/socket.c ./socket.c
--- ../openvpn-2.0/socket.c	2005-04-10 21:43:58.000000000 -0600
+++ ./socket.c	2005-07-22 12:53:42.908015784 -0600
@@ -737,7 +737,20 @@
 	       print_sockaddr (&sock->info.lsa->local, &gc),
 	       strerror_ts (errnum, &gc));
 	}
+
+      /* If the local port was '0' look it up again */
+      if (sock->local_port == 0)
+	{
+	  socklen_t l = sizeof(sock->info.lsa->local);
+	  if (getsockname (sock->sd, (struct sockaddr *)&sock->info.lsa->local, &l) < 0)
+	    {
+	      const int errnum = openvpn_errno_socket ();
+	      msg (M_FATAL, "TCP/UDP: Socket lookup failed: %s",
+		   strerror_ts (errnum, &gc));
+	    }
+	}
     }
+
   gc_free (&gc);
 }
 

--------------030006080901040303090002--


