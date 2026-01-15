From: Gert Doering <gert@...1296...>
Date: Thu, 15 Jan 2026 10:32:29 +0100
Message-ID: <20260115093235.25635-1-gert@...1296...>
In-Reply-To: <gerrit.1766154207000.I8a5efb2ed009a702f10dc8f40c677f014547b4c8@...2715...>
References: <gerrit.1766154207000.I8a5efb2ed009a702f10dc8f40c677f014547b4c8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] ssl_verify: Fix parsing of timeout from
 auth pending file
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

From: Frank Lichtenheld <frank@...2641...>

Make sure the value is not negative before casting
it to unsigned.

Change-Id: I8a5efb2ed009a702f10dc8f40c677f014547b4c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1451
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1451
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index a11003c..5effa2c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -874,11 +874,6 @@
     return supported;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  *  Checks if the deferred state should also send auth pending
  *  request to the client. Also removes the auth_pending control file
@@ -888,7 +883,8 @@
  *  @returns false  The file had an invlaid format or another error occured
  */
 static bool
-key_state_check_auth_pending_file(struct auth_deferred_status *ads, struct tls_multi *multi,
+key_state_check_auth_pending_file(struct auth_deferred_status *ads,
+                                  struct tls_multi *multi,
                                   struct tls_session *session)
 {
     bool ret = true;
@@ -916,7 +912,7 @@
             buf_chomp(extra_buf);
 
             long timeout = strtol(BSTR(timeout_buf), NULL, 10);
-            if (timeout == 0)
+            if (timeout <= 0)
             {
                 msg(M_WARN, "could not parse auth pending file timeout");
                 buffer_list_free(lines);
@@ -933,14 +929,14 @@
                          pending_method);
                 auth_set_client_reason(multi, buf);
                 msg(M_INFO,
-                    "Client does not supported auth pending method "
-                    "'%s'",
+                    "Client does not supported auth pending method '%s'",
                     pending_method);
                 ret = false;
             }
             else
             {
-                send_auth_pending_messages(multi, session, BSTR(extra_buf), timeout);
+                send_auth_pending_messages(multi, session, BSTR(extra_buf),
+                                           (unsigned int)timeout);
             }
         }
 
@@ -950,10 +946,6 @@
     return ret;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /**
  *  Removes auth_pending and auth_control files from file system
  *  and key_state structure

