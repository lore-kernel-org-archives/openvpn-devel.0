From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Dec 2022 20:01:37 +0100
Message-Id: <20221215190143.2107896-3-arne@...1227...>
In-Reply-To: <20221215190143.2107896-1-arne@...1227...>
References: <20221215190143.2107896-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/8] ssl_verify: Fix memleak if creating
 deferred auth control files fails
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
Cc: David Sommerseth <davids@...515...>

From: David Sommerseth <davids@...515...>

If the key_state_gen_auth_control_files() call fails, the code would
just return without freeing the argv container.  Instead the code should
jump to an appropriate exit point where memory is being released.

Also adjust the related comment, to indicate that these deferred auth
control files are really pre-created.

Signed-off-by: David Sommerseth <davids@...515...>

Reported-by: Trial of Bits (TOB-OVPN-2)
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_verify.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 76cb9f19b..228cf16e1 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1358,12 +1358,13 @@ verify_user_pass_script(struct tls_session *session, struct tls_multi *multi,
         setenv_str(session->opt->es, "password", up->password);
     }
 
-    /* generate filename for deferred auth control file */
+    /* pre-create files for deferred auth control */
     if (!key_state_gen_auth_control_files(&ks->script_auth, session->opt))
     {
         msg(D_TLS_ERRORS, "TLS Auth Error (%s): "
             "could not create deferred auth control file", __func__);
-        return OPENVPN_PLUGIN_FUNC_ERROR;
+        retval = OPENVPN_PLUGIN_FUNC_ERROR;
+        goto error;
     }
 
     /* call command */
@@ -1412,6 +1413,7 @@ done:
         platform_unlink(tmp_file);
     }
 
+error:
     argv_free(&argv);
     gc_free(&gc);
     return retval;
-- 
2.37.1 (Apple Git-137.1)


