From: Gert Doering <gert@...1296...>
Date: Fri, 17 Oct 2025 22:58:31 +0200
Message-ID: <20251017205837.8553-1-gert@...1296...>
In-Reply-To: <gerrit.1760513121000.I61f9d9bb26112eac0c0a47cb9d17982b075887ff@...2715...>
References: <gerrit.1760513121000.I61f9d9bb26112eac0c0a47cb9d17982b075887ff@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] dco: remove dco_read/write_bytes from
 dco_context_t
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

From: Ralf Lici <ralf@...2726...>

Remove dco_read_bytes and dco_write_bytes from all dco_context_t
structures, as peer statistics are now stored directly in the
corresponding c2 fields across all DCO interfaces.

Change-Id: I61f9d9bb26112eac0c0a47cb9d17982b075887ff
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1276
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1276
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
index 2f486f0..0797b82 100644
--- a/src/openvpn/dco_freebsd.h
+++ b/src/openvpn/dco_freebsd.h
@@ -59,8 +59,6 @@
     int dco_message_peer_id;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
-    uint64_t dco_read_bytes;
-    uint64_t dco_write_bytes;
 
     struct context *c;
 } dco_context_t;
diff --git a/src/openvpn/dco_linux.h b/src/openvpn/dco_linux.h
index 310d433..efd5b27 100644
--- a/src/openvpn/dco_linux.h
+++ b/src/openvpn/dco_linux.h
@@ -81,8 +81,6 @@
     int dco_message_key_id;
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
-    uint64_t dco_read_bytes;
-    uint64_t dco_write_bytes;
 } dco_context_t;
 
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4f3f028..02b8389 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -55,9 +55,6 @@
     int dco_del_peer_reason;
     struct sockaddr_storage dco_float_peer_ss;
 
-    uint64_t dco_read_bytes;
-    uint64_t dco_write_bytes;
-
     struct context *c;
 };
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2863ff1..053c54d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3266,8 +3266,6 @@
      * installed, and we do not need to clean up the state in the kernel */
     mi->context.c2.tls_multi->dco_peer_id = -1;
     mi->context.sig->signal_text = reason;
-    mi->context.c2.dco_read_bytes = dco->dco_read_bytes;
-    mi->context.c2.dco_write_bytes = dco->dco_write_bytes;
     multi_signal_instance(m, mi, SIGTERM);
 }
 
@@ -3337,8 +3335,6 @@
     dco->dco_message_type = 0;
     dco->dco_message_peer_id = -1;
     dco->dco_del_peer_reason = -1;
-    dco->dco_read_bytes = 0;
-    dco->dco_write_bytes = 0;
     return ret > 0;
 }
 #endif /* if defined(ENABLE_DCO) */

