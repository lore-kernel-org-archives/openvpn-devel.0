From: Gert Doering <gert@...1296...>
Date: Thu,  5 Sep 2024 12:07:24 +0200
Message-ID: <20240905100724.4105-1-gert@...1296...>
In-Reply-To: <gerrit.1723691967000.Ic6d63a319d272a56ac0e278f1356bc5241b56a34@...2715...>
References: <gerrit.1723691967000.Ic6d63a319d272a56ac0e278f1356bc5241b56a34@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] proxy.c: Clear sensitive data after use
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

From: Selva Nair <selva.nair@...277...>

Usage of credentials  is a bit odd in this file.
Actually the copy of "struct user_pass" kept in p->up is not
required at all. It just defeats the purpose of auth-nocahe
as it never gets cleared.

Removing it is beyond the scope of this patch -- we just ensure
it's purged after use.

Change-Id: Ic6d63a319d272a56ac0e278f1356bc5241b56a34
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/727
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 5de0da4..eddacc9 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -247,7 +247,9 @@
     struct buffer out = alloc_buf_gc(strlen(p->up.username) + strlen(p->up.password) + 2, gc);
     ASSERT(strlen(p->up.username) > 0);
     buf_printf(&out, "%s:%s", p->up.username, p->up.password);
-    return (const char *)make_base64_string((const uint8_t *)BSTR(&out), gc);
+    char *ret = (char *)make_base64_string((const uint8_t *)BSTR(&out), gc);
+    secure_memzero(BSTR(&out), out.len);
+    return ret;
 }
 
 static void
@@ -736,6 +738,9 @@
                 ASSERT(0);
         }
 
+        /* clear any sensitive content in buf */
+        secure_memzero(buf, sizeof(buf));
+
         /* send empty CR, LF */
         if (!send_crlf(sd))
         {
@@ -983,6 +988,8 @@
                 {
                     goto error;
                 }
+                /* clear any sensitive content in buf */
+                secure_memzero(buf, sizeof(buf));
 
                 /* receive reply from proxy */
                 if (!recv_line(sd, buf, sizeof(buf), get_server_poll_remaining_time(server_poll_timeout), true, NULL, signal_received))
@@ -1086,10 +1093,12 @@
 #endif
 
 done:
+    purge_user_pass(&p->up, true);
     gc_free(&gc);
     return ret;
 
 error:
+    purge_user_pass(&p->up, true);
     register_signal(sig_info, SIGUSR1, "HTTP proxy error"); /* SOFT-SIGUSR1 -- HTTP proxy error */
     gc_free(&gc);
     return ret;

