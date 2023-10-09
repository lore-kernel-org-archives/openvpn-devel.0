From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  9 Oct 2023 12:53:36 +0200
Message-Id: <20231009105336.34267-1-frank@...2641...>
In-Reply-To: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
References: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add warning if a p2p NCP client connects to
 a p2mp server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Arne Schwabe <arne@...1227...>

Change-Id: I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/323
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0d4e6f9..8b490ed 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1811,6 +1811,15 @@
         return false;
     }
 
+    /* Print a warning if we detect the client being in P2P mode and will
+     * not accept our pushed ciphers */
+    if (proto & IV_PROTO_NCP_P2P)
+    {
+        msg(M_WARN, "Note: peer reports running in P2P mode (no --pull/--client"
+            "option). It will not negotiate ciphers with this server. "
+            "Expect this connection to fail.");
+    }
+
     if (proto & IV_PROTO_REQUEST_PUSH)
     {
         c->c2.push_request_received = true;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index dafaef1..0ca6d42 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -24,7 +24,7 @@
  */
 
 /**
- * @file Control Channel SSL/Data dynamic negotion Module
+ * @file Control Channel SSL/Data dynamic negotiation Module
  * This file is split from ssl.c to be able to unit test it.
  */
 
@@ -258,8 +258,8 @@
 
     const char *peer_ncp_list = tls_peer_ncp_list(peer_info, &gc_tmp);
 
-    /* non-NCP client without OCC?  "assume nothing" */
-    /* For client doing the newer version of NCP (that send IV_CIPHER)
+    /* non-NCP clients without OCC?  "assume nothing" */
+    /* For client doing the newer version of NCP (that send IV_CIPHERS)
      * we cannot assume that they will accept remote_cipher */
     if (remote_cipher == NULL
         || (peer_info && strstr(peer_info, "IV_CIPHERS=")))
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index d27ed24..de7a0e4 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -23,7 +23,7 @@
  */
 
 /**
- * @file Control Channel SSL/Data dynamic negotion Module
+ * @file Control Channel SSL/Data dynamic negotiation Module
  * This file is split from ssl.h to be able to unit test it.
  */
 

