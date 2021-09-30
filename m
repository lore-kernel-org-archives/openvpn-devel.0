From: Petr Mikhalicin <mkh199740@...450...>
Date: Thu, 30 Sep 2021 14:33:08 +0300
Message-Id: <20210930113308.815777-1-mkh199740@...450...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add ability to specify initialize flags for
 pkcs11 provider
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

New pkcs11-helper interface allows to setup pkcs11 provider via
properties: https://github.com/alonbl/pkcs11-helper/commit/b78d21c7e26041746aa4ae3d08b95469e1714a85

Also pkcs11-helper added ability to setup init args for pkcs11 provider:
https://github.com/alonbl/pkcs11-helper/commit/133f893e30856eba1de715ecd6fe176722eb3097

Signed-off-by: Petr Mikhalicin <mkh199740@...450...>
---
 src/openvpn/init.c    |  3 +-
 src/openvpn/options.c | 23 ++++++++++++
 src/openvpn/options.h |  1 +
 src/openvpn/pkcs11.c  | 82 ++++++++++++++++++++++++++++++++-----------
 src/openvpn/pkcs11.h  |  3 +-
 5 files changed, 90 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 6d09e566..6af585ac 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -682,7 +682,8 @@ context_init_1(struct context *c)
         for (i = 0; i<MAX_PARMS && c->options.pkcs11_providers[i] != NULL; i++)
         {
             pkcs11_addProvider(c->options.pkcs11_providers[i], c->options.pkcs11_protected_authentication[i],
-                               c->options.pkcs11_private_mode[i], c->options.pkcs11_cert_private[i]);
+                               c->options.pkcs11_private_mode[i], c->options.pkcs11_cert_private[i],
+                               c->options.pkcs11_init_flags[i]);
         }
     }
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b3a83aa1..0939ee86 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -664,6 +664,11 @@ static const char usage_message[] =
     "                              8       : Use Unwrap.\n"
     "--pkcs11-cert-private [0|1] ... : Set if login should be performed before\n"
     "                                  certificate can be accessed. Set for each provider.\n"
+    "--pkcs11-init-flags hex ...     : PKCS#11 init flags.\n"
+    "                              It's bitwise OR of some PKCS#11 initialize flags.\n"
+    "                              Most popular of them is:\n"
+    "                              1       : CKF_LIBRARY_CANT_CREATE_OS_THREADS\n"
+    "                              2       : CKF_OS_LOCKING_OK\n"
     "--pkcs11-pin-cache seconds      : Number of seconds to cache PIN. The default is -1\n"
     "                                  cache until token is removed.\n"
     "--pkcs11-id-management          : Acquire identity from management interface.\n"
@@ -1838,6 +1843,13 @@ show_settings(const struct options *o)
             SHOW_PARM(pkcs11_cert_private, o->pkcs11_cert_private[i] ? "ENABLED" : "DISABLED", "%s");
         }
     }
+    {
+        int i;
+        for (i = 0; i<MAX_PARMS; i++)
+        {
+            SHOW_PARM(pkcs11_init_flags, o->pkcs11_init_flags[i], "%08x");
+        }
+    }
     SHOW_INT(pkcs11_pin_cache_period);
     SHOW_STR(pkcs11_id);
     SHOW_BOOL(pkcs11_id_management);
@@ -8778,6 +8790,17 @@ add_option(struct options *options,
             options->pkcs11_cert_private[j-1] = atoi(p[j]) != 0 ? 1 : 0;
         }
     }
+    else if (streq(p[0], "pkcs11-init-flags"))
+    {
+        int j;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+
+        for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
+        {
+            sscanf(p[j], "%x", &(options->pkcs11_init_flags[j-1]));
+        }
+    }
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 98c21a2a..2317528e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -573,6 +573,7 @@ struct options
     unsigned pkcs11_private_mode[MAX_PARMS];
     bool pkcs11_protected_authentication[MAX_PARMS];
     bool pkcs11_cert_private[MAX_PARMS];
+    unsigned pkcs11_init_flags[MAX_PARMS];
     int pkcs11_pin_cache_period;
     const char *pkcs11_id;
     bool pkcs11_id_management;
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 02d0f51f..29db7ea4 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -374,12 +374,17 @@ pkcs11_terminate(void)
 bool
 pkcs11_addProvider(
     const char *const provider,
-    const bool protected_auth,
+    const bool _protected_auth,
     const unsigned private_mode,
-    const bool cert_private
+    const bool _cert_private,
+    const unsigned init_flags
     )
 {
     CK_RV rv = CKR_OK;
+    int success = true;
+    PKCS11H_BOOL protected_auth = _protected_auth;
+    PKCS11H_BOOL cert_private = _cert_private;
+    CK_C_INITIALIZE_ARGS_PTR p_init_args;
 
     ASSERT(provider!=NULL);
 
@@ -396,29 +401,66 @@ pkcs11_addProvider(
         provider
         );
 
-    if (
-        (rv = pkcs11h_addProvider(
-             provider,
-             provider,
-             protected_auth,
-             private_mode,
-             PKCS11H_SLOTEVENT_METHOD_AUTO,
-             0,
-             cert_private
-             )) != CKR_OK
-        )
-    {
-        msg(M_WARN, "PKCS#11: Cannot initialize provider '%s' %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
+    if ((rv = pkcs11h_registerProvider(provider)) != CKR_OK) {
+        msg(M_WARN, "PKCS#11: Cannot register provider '%s' %ld-'%s'", provider, rv, pkcs11h_getMessage(rv));
+	success = false;
+	goto exit;
+    }
+    if ((rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_LOCATION, provider, strlen(provider) + 1)) != CKR_OK) {
+        msg(M_WARN, "PKCS#11: Cannot setup provider '%s' location '%s' %ld-'%s'", provider, provider, rv, pkcs11h_getMessage(rv));
+	success = false;
+        goto cleanup;
+    }
+    if ((rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_ALLOW_PROTECTED_AUTH, &protected_auth, sizeof(protected_auth))) != CKR_OK) {
+        msg(M_WARN, "PKCS#11: Cannot setup provider '%s' ptorected auth mode '%s' %ld-'%s'", provider,  protected_auth ? "true" : "false", rv, pkcs11h_getMessage(rv));
+	success = false;
+        goto cleanup;
+    }
+    if ((rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_MASK_PRIVATE_MODE, &private_mode, sizeof(private_mode))) != CKR_OK) {
+        msg(M_WARN, "PKCS#11: Cannot setup provider '%s' private mask mode '%08x' %ld-'%s'", provider, private_mode, rv, pkcs11h_getMessage(rv));
+	success = false;
+        goto cleanup;
+    }
+    if ((rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_CERT_IS_PRIVATE, &cert_private, sizeof(cert_private))) != CKR_OK) {
+        msg(M_WARN, "PKCS#11: Cannot setup provider '%s' private cert mode '%s' %ld-'%s'", provider, cert_private ? "true" : "false", rv, pkcs11h_getMessage(rv));
+	success = false;
+        goto cleanup;
     }
 
+    // pkcs11-helper take ownership over this pointer
+    if ((p_init_args = malloc(sizeof(*p_init_args))) == NULL) {
+        msg(M_FATAL, "PKCS#11: Cannot allocate memory");
+	success = false;
+	goto cleanup;
+    }
+
+    memset(p_init_args, 0, sizeof(*p_init_args));
+    p_init_args->flags = init_flags;
+
+    if ((rv = pkcs11h_setProviderProperty(provider, PKCS11H_PROVIDER_PROPERTY_INIT_ARGS, &p_init_args, sizeof(p_init_args))) != CKR_OK) {
+        msg(M_WARN, "PKCS#11: Cannot setup provider '%s' init flags '%08x' %ld-'%s'", provider, init_flags, rv, pkcs11h_getMessage(rv));
+        free(p_init_args);
+	success = false;
+	goto cleanup;
+    }
+    if ((rv = pkcs11h_initializeProvider(provider)) != CKR_OK) {
+	success = false;
+        goto cleanup;
+    }
+
+cleanup:
+    if (!success) {
+        pkcs11h_removeProvider(provider);
+    }
+
+exit:
     dmsg(
         D_PKCS11_DEBUG,
-        "PKCS#11: pkcs11_addProvider - return rv=%ld-'%s'",
-        rv,
-        pkcs11h_getMessage(rv)
-        );
+        "PKCS#11: pkcs11 registration is %s",
+        success ? "success" : "failed"
+	);
 
-    return rv == CKR_OK;
+    return success;
 }
 
 int
diff --git a/src/openvpn/pkcs11.h b/src/openvpn/pkcs11.h
index ec524706..bf3f2dfa 100644
--- a/src/openvpn/pkcs11.h
+++ b/src/openvpn/pkcs11.h
@@ -42,7 +42,8 @@ pkcs11_addProvider(
     const char *const provider,
     const bool fProtectedAuthentication,
     const unsigned private_mode,
-    const bool fCertIsPrivate
+    const bool fCertIsPrivate,
+    const unsigned init_flags
     );
 
 int
-- 
2.31.1


