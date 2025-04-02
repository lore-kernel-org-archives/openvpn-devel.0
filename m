From: Gert Doering <gert@...1296...>
Date: Wed,  2 Apr 2025 15:45:39 +0200
Message-ID: <20250402134546.3504-1-gert@...1296...>
In-Reply-To: <gerrit.1742815876000.I1c2c050dd160746a0f8d9c234abe1e258bc8e48d@...2715...>
References: <gerrit.1742815876000.I1c2c050dd160746a0f8d9c234abe1e258bc8e48d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Use USER_PASS_LEN instead of
 TLS_USERNAME_LEN for override-username
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

Currently override-username is artificially restricted to the length of
TLS common-name (64) for the corner case of using username-as-common-name,
which we explicitly do not recommend to use.

Do away with that limitation and only error out on longer usernames when
username-as-common-name is actually in effect.

Change-Id: I1c2c050dd160746a0f8d9c234abe1e258bc8e48d
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/913
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a673ec1..a2d3fd1 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2705,6 +2705,12 @@
     if (!multi->locked_original_username
         && strcmp(multi->locked_username, options->override_username) != 0)
     {
+        /* Check if the username length is acceptable */
+        if (!ssl_verify_username_length(session, options->override_username))
+        {
+            return false;
+        }
+
         multi->locked_original_username = multi->locked_username;
         multi->locked_username = strdup(options->override_username);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ab56609..f89fc7d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7875,10 +7875,10 @@
     else if (streq(p[0], "override-username") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INSTANCE);
-        if (strlen(p[1]) > TLS_USERNAME_LEN)
+        if (strlen(p[1]) > USER_PASS_LEN)
         {
             msg(msglevel, "override-username exceeds the maximum length of %d "
-                "characters", TLS_USERNAME_LEN);
+                "characters", USER_PASS_LEN);
 
             /* disable the connection since ignoring the request to
              * set another username might cause serious problems */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 5f8f1d3..d2cc3d1 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1568,6 +1568,24 @@
     }
 }
 
+bool
+ssl_verify_username_length(struct tls_session *session, const char *username)
+{
+    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
+        && strlen(username) > TLS_USERNAME_LEN)
+    {
+        msg(D_TLS_ERRORS,
+            "TLS Auth Error: --username-as-common name specified and "
+            "username is longer than the maximum permitted Common Name "
+            "length of %d characters", TLS_USERNAME_LEN);
+        return false;
+    }
+    else
+    {
+        return true;
+    }
+}
+
 /**
  * Main username/password verification entry point
  *
@@ -1689,15 +1707,12 @@
     }
 
     /* check sizing of username if it will become our common name */
-    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
-        && strlen(up->username)>TLS_USERNAME_LEN)
+    if (!ssl_verify_username_length(session, up->username))
     {
-        msg(D_TLS_ERRORS,
-            "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters",
-            TLS_USERNAME_LEN);
         plugin_status = OPENVPN_PLUGIN_FUNC_ERROR;
         script_status = OPENVPN_PLUGIN_FUNC_ERROR;
     }
+
     /* auth succeeded? */
     bool plugin_ok = plugin_status == OPENVPN_PLUGIN_FUNC_SUCCESS
                      || plugin_status == OPENVPN_PLUGIN_FUNC_DEFERRED;
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index eba3832..7a4d44a 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -192,6 +192,20 @@
                       struct tls_session *session);
 
 
+/**
+ * Checks if the username length is valid to use.  This checks when
+ * username-as-common-name is active if the username is shorter than
+ * the maximum TLS common name length (64).
+ *
+ * It will also display an error message if the name is too long
+ *
+ * @param session       current TLS session
+ * @param username      username to check
+ * @return              true if name is under limit or username-as-common-name
+ *                      is not active
+ */
+bool ssl_verify_username_length(struct tls_session *session,
+                                const char *username);
 
 /**
  * Runs the --client-crresponse script if one is defined.

