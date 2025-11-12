From: Gert Doering <gert@...1296...>
Date: Wed, 12 Nov 2025 10:27:37 +0100
Message-ID: <20251112092743.23173-1-gert@...1296...>
In-Reply-To: <gerrit.1761743833000.I6c502508026c6b85bb092ada4d16d985b20dd41f@...2715...>
References: <gerrit.1761743833000.I6c502508026c6b85bb092ada4d16d985b20dd41f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] clean up environment variable handling
 in verify_user_pass_script
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

The username environment variable is already set by the
set_verify_user_pass_env function before the verify_user_pass_script
function is called, so this call is not doing anything but might erroneously
made people think that this needs to be cleaned up.

Also ensure that the password is clean from the env even in an error case.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)
Change-Id: I6c502508026c6b85bb092ada4d16d985b20dd41f
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1326
Message-Id: <20251030194402.1729-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34069.html
Signed-off-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1326
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1326
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 04ef27e..993d22c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1329,7 +1329,7 @@
     }
     else
     {
-        setenv_str(session->opt->es, "username", up->username);
+        /* username env is already set by set_verify_user_pass_env */
         setenv_str(session->opt->es, "password", up->password);
     }
 
@@ -1377,10 +1377,6 @@
         /* purge auth control filename (and file itself) for non-deferred returns */
         key_state_rm_auth_control_files(&ks->script_auth);
     }
-    if (!session->opt->auth_user_pass_verify_script_via_file)
-    {
-        setenv_del(session->opt->es, "password");
-    }
 
 done:
     if (tmp_file && strlen(tmp_file) > 0)
@@ -1389,6 +1385,11 @@
     }
 
 error:
+    if (!session->opt->auth_user_pass_verify_script_via_file)
+    {
+        setenv_del(session->opt->es, "password");
+    }
+
     argv_free(&argv);
     gc_free(&gc);
     return retval;

