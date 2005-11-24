From: Nielsen <nielsen@...505...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030306090901090905090401"
Message-Id: <20051125060059.3AA4570DD18@...506...>
Subject: [Openvpn-devel] [HACK/PATCH] Prioritize TCP ACKs
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
Date: Thu Nov 24 21:48:00 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030306090901090905090401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here's a hack of a patch which puts nice TOS bits on TCP ACK packets.
This allows you to use pf or another firewall to prioritize the
resulting openvpn traffic in the way you normally do over asynchronous
connections.

Certaintly no need to put this in openvpn. Just figured someone else out
there might have run into the same problems.

Cheers,
Nate Nielsen
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDhqUue/sRCNknZa8RAoDpAKCI/Fk1EdV49UGY2act8kLnWb0zpACgoLYG
drRf/4s1cX8QrlxcYyfqv+k=
=5Xea
-----END PGP SIGNATURE-----

--------------030306090901090905090401
Content-Type: text/x-patch;
 name="openvpn-tcp-tos.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-tcp-tos.patch"

diff -rU3 ../openvpn-2.0.orig/socket.h ./socket.h
--- ../openvpn-2.0.orig/socket.h	2005-04-10 21:43:58.000000000 -0600
+++ ./socket.h	2005-08-09 13:23:12.874844376 -0600
@@ -737,6 +737,14 @@
       struct openvpn_iphdr *iph = (struct openvpn_iphdr *) BPTR (ipbuf);
       ls->ptos = iph->tos;
       ls->ptos_defined = true;
+
+      if (iph->protocol == OPENVPN_IPPROTO_TCP)
+        {
+          struct openvpn_tcphdr *tcp = (struct openvpn_tcphdr *) (BPTR(ipbuf) + OPENVPN_IPH_GET_LEN (iph->version_len));
+	  if ((tcp->flags & (OPENVPN_TCPH_SYN_MASK | OPENVPN_TCPH_ACK_MASK)) == OPENVPN_TCPH_ACK_MASK && 
+	      iph->tot_len <= 80)
+		ls->ptos |= 0x10;
+	}
     }
 }
 

--------------030306090901090905090401--


