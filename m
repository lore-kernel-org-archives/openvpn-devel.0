MIME-Version: 1.0
From: Janito Vaqueiro Filho <janito@...2382...>
Date: Wed, 4 Apr 2018 11:43:48 -0300
Message-ID: <CAFvKqoEvVYg87Vwu=E_Wp0cOk7qZfsgBoguiX5ToLMNqW4wKRw@...278...>
Content-Type: multipart/alternative; boundary="001a114daa2cd1a9ce056906d9ce"
Subject: [Openvpn-devel] [PATCH] Send authentication failure reason between
 plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001a114daa2cd1a9ce056906d9ce
Content-Type: text/plain; charset="UTF-8"

This patch implements support for sending an authentication failure
reason from a server plugin to a client plugin. Currently this can only
be done using the management interface. To allow this to be done through
the use of plugins, two changes were made.

The first change is to allow a plugin to set the failure reason through
an approach similar to how deferred authentication is done. The reason
should be written as a single line to an external file whose path is
specified in the plugin environment variable "auth_failure_reason_file".

The second change introduces a new plugin event: "AUTH_FAILED". Plugins
running in the client that register to receive this event are notified
when an authentication failure is reported from the server. The
authentication failure reason, if one was received, is set to the
"auth_failed_reason" environment variable.

Signed-off-by: Janito Vaqueiro Ferreira Filho <janito@...2382...>
---
 include/openvpn-plugin.h.in |  3 +-
 src/openvpn/plugin.c        |  3 ++
 src/openvpn/push.c          | 24 ++++++++++++++
 src/openvpn/ssl.c           |  5 +--
 src/openvpn/ssl_common.h    |  1 +
 src/openvpn/ssl_verify.c    | 79
++++++++++++++++++++++++++++++++++++++++++---
 src/openvpn/ssl_verify.h    | 12 +++++--
 7 files changed, 118 insertions(+), 9 deletions(-)

diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
index a90a998e..c3b8c476 100644
--- a/include/openvpn-plugin.h.in
+++ b/include/openvpn-plugin.h.in
@@ -129,7 +129,8 @@ extern "C" {
 #define OPENVPN_PLUGIN_TLS_FINAL             10
 #define OPENVPN_PLUGIN_ENABLE_PF             11
 #define OPENVPN_PLUGIN_ROUTE_PREDOWN         12
-#define OPENVPN_PLUGIN_N                     13
+#define OPENVPN_PLUGIN_AUTH_FAILED           13
+#define OPENVPN_PLUGIN_N                     14

 /*
  * Build a mask out of a set of plug-in types.
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 0f091ef5..3310c69d 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -118,6 +118,9 @@ plugin_type_name(const int type)
         case OPENVPN_PLUGIN_ROUTE_PREDOWN:
             return "PLUGIN_ROUTE_PREDOWN";

+        case OPENVPN_PLUGIN_AUTH_FAILED:
+            return "PLUGIN_AUTH_FAILED";
+
         default:
             return "PLUGIN_???";
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 6a30e479..3fbaa035 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -34,6 +34,7 @@
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "manage.h"
+#include "plugin.h"

 #include "memdbg.h"

@@ -72,6 +73,29 @@ receive_auth_failed(struct context *c, const struct
buffer *buffer)
                 ASSERT(0);
         }
         c->sig->signal_text = "auth-failure";
+
+        if (plugin_defined(c->plugins, OPENVPN_PLUGIN_AUTH_FAILED))
+        {
+            struct argv argv = argv_new();
+            const char *reason = NULL;
+            struct buffer buf = *buffer;
+            if (buf_string_compare_advance(&buf, "AUTH_FAILED,") &&
BLEN(&buf))
+            {
+                reason = BSTR(&buf);
+                setenv_str(c->c2.es, "auth_failed_reason", reason);
+            }
+
+            if (plugin_call(c->plugins, OPENVPN_PLUGIN_AUTH_FAILED, &argv,
NULL, c->c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+            {
+                msg(M_WARN, "WARNING: authfailed plugin call failed");
+            }
+
+            if (reason)
+            {
+                setenv_del(c->c2.es, "auth_failed_reason");
+            }
+        }
+
 #ifdef ENABLE_MANAGEMENT
         if (management)
         {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 669f941b..b416aa3c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1015,6 +1015,7 @@ key_state_free(struct key_state *ks, bool clear)

 #ifdef PLUGIN_DEF_AUTH
     key_state_rm_auth_control_file(ks);
+    key_state_rm_auth_failure_reason_file(ks);
 #endif

     if (clear)
@@ -1347,8 +1348,8 @@ tls_multi_free(struct tls_multi *multi, bool clear)

     ASSERT(multi);

-#ifdef MANAGEMENT_DEF_AUTH
-    man_def_auth_set_client_reason(multi, NULL);
+#ifdef ENABLE_DEF_AUTH
+    tls_def_auth_set_client_reason(multi, NULL);

 #endif
 #if P2MP_SERVER
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 08ef6ffa..f47609b4 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -199,6 +199,7 @@ struct key_state
     unsigned int auth_control_status;
     time_t acf_last_mod;
     char *auth_control_file;
+    char *auth_failure_reason_file;
 #endif
 #endif
 };
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 25395b27..031bee21 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -837,9 +837,9 @@ cleanup:
 #define ACF_FAILED    3
 #endif

-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_DEF_AUTH
 void
-man_def_auth_set_client_reason(struct tls_multi *multi, const char
*client_reason)
+tls_def_auth_set_client_reason(struct tls_multi *multi, const char
*client_reason)
 {
     if (multi->client_reason)
     {
@@ -852,7 +852,9 @@ man_def_auth_set_client_reason(struct tls_multi *multi,
const char *client_reaso
         multi->client_reason = string_alloc(client_reason, NULL);
     }
 }
+#endif /* ifdef ENABLE_DEF_AUTH */

+#ifdef MANAGEMENT_DEF_AUTH
 static inline unsigned int
 man_def_auth_test(const struct key_state *ks)
 {
@@ -930,6 +932,58 @@ key_state_test_auth_control_file(struct key_state *ks)
     return ACF_DISABLED;
 }

+/*
+ * auth_failure_reason_file functions
+ */
+
+void
+key_state_rm_auth_failure_reason_file(struct key_state *ks)
+{
+    if (ks && ks->auth_failure_reason_file)
+    {
+        platform_unlink(ks->auth_failure_reason_file);
+        free(ks->auth_failure_reason_file);
+        ks->auth_failure_reason_file = NULL;
+    }
+}
+
+static bool
+key_state_gen_auth_failure_reason_file(struct key_state *ks, const struct
tls_options *opt)
+{
+    struct gc_arena gc = gc_new();
+
+    key_state_rm_auth_failure_reason_file(ks);
+    const char *acf = create_temp_file(opt->tmp_dir, "afrf", &gc);
+    if (acf)
+    {
+        ks->auth_failure_reason_file = string_alloc(acf, NULL);
+        setenv_str(opt->es, "auth_failure_reason_file",
ks->auth_failure_reason_file);
+    }
+
+    gc_free(&gc);
+    return acf;
+}
+
+static char *
+key_state_read_auth_failure_reason_file(struct key_state *ks)
+{
+    char *line = NULL;
+    size_t line_len = 0;
+    if (ks && ks->auth_failure_reason_file)
+    {
+        FILE *fp = fopen(ks->auth_failure_reason_file, "r");
+        if (fp)
+        {
+            if (getline(&line, &line_len, fp) < 0)
+            {
+                line = NULL;
+            }
+            fclose(fp);
+        }
+    }
+    return line;
+}
+
 #endif /* ifdef PLUGIN_DEF_AUTH */

 /*
@@ -987,6 +1041,7 @@ tls_authentication_status(struct tls_multi *multi,
const int latency)
                 if (ks->authenticated)
                 {
 #ifdef ENABLE_DEF_AUTH
+                    char *reason = NULL;
                     unsigned int s1 = ACF_DISABLED;
                     unsigned int s2 = ACF_DISABLED;
 #ifdef PLUGIN_DEF_AUTH
@@ -1012,6 +1067,12 @@ tls_authentication_status(struct tls_multi *multi,
const int latency)
                             break;

                         case ACF_FAILED:
+#ifdef PLUGIN_DEF_AUTH
+                            reason =
key_state_read_auth_failure_reason_file(ks);
+                            tls_def_auth_set_client_reason(multi, reason);
+                            free(reason);
+                            reason = NULL;
+#endif /* PLUGIN_DEF_AUTH */
                             ks->authenticated = false;
                             break;

@@ -1056,7 +1117,7 @@ tls_authenticate_key(struct tls_multi *multi, const
unsigned int mda_key_id, con
     if (multi)
     {
         int i;
-        man_def_auth_set_client_reason(multi, client_reason);
+        tls_def_auth_set_client_reason(multi, client_reason);
         for (i = 0; i < KEY_SCAN_SIZE; ++i)
         {
             struct key_state *ks = multi->key_scan[i];
@@ -1195,16 +1256,26 @@ verify_user_pass_plugin(struct tls_session
*session, const struct user_pass *up,
                  "could not create deferred auth control file", __func__);
             goto cleanup;
         }
+
+        /* generate filename for deferred auth failure reason file */
+        if (!key_state_gen_auth_failure_reason_file(ks, session->opt))
+        {
+            key_state_rm_auth_failure_reason_file(ks);
+            msg (D_TLS_ERRORS, "TLS Auth Error (%s): "
+                 "could not create deferred auth failure reason file",
__func__);
+            goto cleanup;
+        }
 #endif

         /* call command */
         retval = plugin_call(session->opt->plugins,
OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);

 #ifdef PLUGIN_DEF_AUTH
-        /* purge auth control filename (and file itself) for non-deferred
returns */
+        /* purge auth control filenames (and files themselves) for
non-deferred returns */
         if (retval != OPENVPN_PLUGIN_FUNC_DEFERRED)
         {
             key_state_rm_auth_control_file(ks);
+            key_state_rm_auth_failure_reason_file(ks);
         }
 #endif

diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 64f27efb..88b790ff 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -96,6 +96,13 @@ int tls_authentication_status(struct tls_multi *multi,
const int latency);
 void key_state_rm_auth_control_file(struct key_state *ks);

 /**
+ * Remove the given key state's auth failure reason file, if it exists.
+ *
+ * @param ks    The key state the remove the file for
+ */
+void key_state_rm_auth_failure_reason_file(struct key_state *ks);
+
+/**
  * Frees the given set of certificate hashes.
  *
  * @param chs   The certificate hash set to free.
@@ -223,9 +230,10 @@ struct x509_track
  */
 #ifdef MANAGEMENT_DEF_AUTH
 bool tls_authenticate_key(struct tls_multi *multi, const unsigned int
mda_key_id, const bool auth, const char *client_reason);
+#endif

-void man_def_auth_set_client_reason(struct tls_multi *multi, const char
*client_reason);
-
+#ifdef ENABLE_DEF_AUTH
+void tls_def_auth_set_client_reason(struct tls_multi *multi, const char
*client_reason);
 #endif

 static inline const char *
-- 
2.13.6

--001a114daa2cd1a9ce056906d9ce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+VGhpcyBwYXRjaCBpbXBsZW1lbnRzIHN1cHBvcnQgZm9yIHNlbmRpbmcg
YW4gYXV0aGVudGljYXRpb24gZmFpbHVyZTxicj5yZWFzb24gZnJvbSBhIHNlcnZlciBwbHVnaW4g
dG8gYSBjbGllbnQgcGx1Z2luLiBDdXJyZW50bHkgdGhpcyBjYW4gb25seTxicj5iZSBkb25lIHVz
aW5nIHRoZSBtYW5hZ2VtZW50IGludGVyZmFjZS4gVG8gYWxsb3cgdGhpcyB0byBiZSBkb25lIHRo
cm91Z2g8YnI+dGhlIHVzZSBvZiBwbHVnaW5zLCB0d28gY2hhbmdlcyB3ZXJlIG1hZGUuPGJyPjxi
cj5UaGUgZmlyc3QgY2hhbmdlIGlzIHRvIGFsbG93IGEgcGx1Z2luIHRvIHNldCB0aGUgZmFpbHVy
ZSByZWFzb24gdGhyb3VnaDxicj5hbiBhcHByb2FjaCBzaW1pbGFyIHRvIGhvdyBkZWZlcnJlZCBh
dXRoZW50aWNhdGlvbiBpcyBkb25lLiBUaGUgcmVhc29uPGJyPnNob3VsZCBiZSB3cml0dGVuIGFz
IGEgc2luZ2xlIGxpbmUgdG8gYW4gZXh0ZXJuYWwgZmlsZSB3aG9zZSBwYXRoIGlzPGJyPnNwZWNp
ZmllZCBpbiB0aGUgcGx1Z2luIGVudmlyb25tZW50IHZhcmlhYmxlICZxdW90O2F1dGhfZmFpbHVy
ZV9yZWFzb25fZmlsZSZxdW90Oy48YnI+PGJyPlRoZSBzZWNvbmQgY2hhbmdlIGludHJvZHVjZXMg
YSBuZXcgcGx1Z2luIGV2ZW50OiAmcXVvdDtBVVRIX0ZBSUxFRCZxdW90Oy4gUGx1Z2luczxicj5y
dW5uaW5nIGluIHRoZSBjbGllbnQgdGhhdCByZWdpc3RlciB0byByZWNlaXZlIHRoaXMgZXZlbnQg
YXJlIG5vdGlmaWVkPGJyPndoZW4gYW4gYXV0aGVudGljYXRpb24gZmFpbHVyZSBpcyByZXBvcnRl
ZCBmcm9tIHRoZSBzZXJ2ZXIuIFRoZTxicj5hdXRoZW50aWNhdGlvbiBmYWlsdXJlIHJlYXNvbiwg
aWYgb25lIHdhcyByZWNlaXZlZCwgaXMgc2V0IHRvIHRoZTxicj4mcXVvdDthdXRoX2ZhaWxlZF9y
ZWFzb24mcXVvdDsgZW52aXJvbm1lbnQgdmFyaWFibGUuPGJyPjxicj5TaWduZWQtb2ZmLWJ5OiBK
YW5pdG8gVmFxdWVpcm8gRmVycmVpcmEgRmlsaG8gJmx0OzxhIGhyZWY9Im1haWx0bzpqYW5pdG9A
Li4uMjM4Mi4uLiI+amFuaXRvQC4uLjIzODIuLi48L2E+Jmd0Ozxicj4tLS08YnI+wqBpbmNsdWRl
LzxhIGhyZWY9Imh0dHA6Ly9vcGVudnBuLXBsdWdpbi5oLmluIj5vcGVudnBuLXBsdWdpbi5oLmlu
PC9hPiB8wqAgMyArLTxicj7CoHNyYy9vcGVudnBuL3BsdWdpbi5jwqDCoMKgwqDCoMKgwqAgfMKg
IDMgKys8YnI+wqBzcmMvb3BlbnZwbi9wdXNoLmPCoMKgwqDCoMKgwqDCoMKgwqAgfCAyNCArKysr
KysrKysrKysrKzxicj7CoHNyYy9vcGVudnBuL3NzbC5jwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
IDUgKy0tPGJyPsKgc3JjL29wZW52cG4vc3NsX2NvbW1vbi5owqDCoMKgIHzCoCAxICs8YnI+wqBz
cmMvb3BlbnZwbi9zc2xfdmVyaWZ5LmPCoMKgwqAgfCA3OSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS08YnI+wqBzcmMvb3BlbnZwbi9zc2xfdmVyaWZ5LmjCoMKg
wqAgfCAxMiArKysrKy0tPGJyPsKgNyBmaWxlcyBjaGFuZ2VkLCAxMTggaW5zZXJ0aW9ucygrKSwg
OSBkZWxldGlvbnMoLSk8YnI+PGJyPmRpZmYgLS1naXQgYS9pbmNsdWRlLzxhIGhyZWY9Imh0dHA6
Ly9vcGVudnBuLXBsdWdpbi5oLmluIj5vcGVudnBuLXBsdWdpbi5oLmluPC9hPiBiL2luY2x1ZGUv
PGEgaHJlZj0iaHR0cDovL29wZW52cG4tcGx1Z2luLmguaW4iPm9wZW52cG4tcGx1Z2luLmguaW48
L2E+PGJyPmluZGV4IGE5MGE5OThlLi5jM2I4YzQ3NiAxMDA2NDQ8YnI+LS0tIGEvaW5jbHVkZS88
YSBocmVmPSJodHRwOi8vb3BlbnZwbi1wbHVnaW4uaC5pbiI+b3BlbnZwbi1wbHVnaW4uaC5pbjwv
YT48YnI+KysrIGIvaW5jbHVkZS88YSBocmVmPSJodHRwOi8vb3BlbnZwbi1wbHVnaW4uaC5pbiI+
b3BlbnZwbi1wbHVnaW4uaC5pbjwvYT48YnI+QEAgLTEyOSw3ICsxMjksOCBAQCBleHRlcm4gJnF1
b3Q7QyZxdW90OyB7PGJyPsKgI2RlZmluZSBPUEVOVlBOX1BMVUdJTl9UTFNfRklOQUzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgMTA8YnI+wqAjZGVmaW5lIE9QRU5WUE5fUExVR0lOX0VOQUJMRV9Q
RsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMTxicj7CoCNkZWZpbmUgT1BFTlZQTl9QTFVHSU5f
Uk9VVEVfUFJFRE9XTsKgwqDCoMKgwqDCoMKgwqAgMTI8YnI+LSNkZWZpbmUgT1BFTlZQTl9QTFVH
SU5fTsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTM8YnI+KyNkZWZp
bmUgT1BFTlZQTl9QTFVHSU5fQVVUSF9GQUlMRUTCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMzxicj4r
I2RlZmluZSBPUEVOVlBOX1BMVUdJTl9OwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAxNDxicj7CoDxicj7CoC8qPGJyPsKgICogQnVpbGQgYSBtYXNrIG91dCBvZiBhIHNl
dCBvZiBwbHVnLWluIHR5cGVzLjxicj5kaWZmIC0tZ2l0IGEvc3JjL29wZW52cG4vcGx1Z2luLmMg
Yi9zcmMvb3BlbnZwbi9wbHVnaW4uYzxicj5pbmRleCAwZjA5MWVmNS4uMzMxMGM2OWQgMTAwNjQ0
PGJyPi0tLSBhL3NyYy9vcGVudnBuL3BsdWdpbi5jPGJyPisrKyBiL3NyYy9vcGVudnBuL3BsdWdp
bi5jPGJyPkBAIC0xMTgsNiArMTE4LDkgQEAgcGx1Z2luX3R5cGVfbmFtZShjb25zdCBpbnQgdHlw
ZSk8YnI+wqDCoMKgwqDCoMKgwqDCoCBjYXNlIE9QRU5WUE5fUExVR0lOX1JPVVRFX1BSRURPV046
PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gJnF1b3Q7UExVR0lOX1JPVVRFX1BS
RURPV04mcXVvdDs7PGJyPsKgPGJyPivCoMKgwqDCoMKgwqDCoCBjYXNlIE9QRU5WUE5fUExVR0lO
X0FVVEhfRkFJTEVEOjxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gJnF1b3Q7UExV
R0lOX0FVVEhfRkFJTEVEJnF1b3Q7Ozxicj4rPGJyPsKgwqDCoMKgwqDCoMKgwqAgZGVmYXVsdDo8
YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAmcXVvdDtQTFVHSU5fPz8/JnF1b3Q7
Ozxicj7CoMKgwqDCoCB9PGJyPmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9wdXNoLmMgYi9zcmMv
b3BlbnZwbi9wdXNoLmM8YnI+aW5kZXggNmEzMGU0NzkuLjNmYmFhMDM1IDEwMDY0NDxicj4tLS0g
YS9zcmMvb3BlbnZwbi9wdXNoLmM8YnI+KysrIGIvc3JjL29wZW52cG4vcHVzaC5jPGJyPkBAIC0z
NCw2ICszNCw3IEBAPGJyPsKgI2luY2x1ZGUgJnF1b3Q7c3NsLmgmcXVvdDs8YnI+wqAjaW5jbHVk
ZSAmcXVvdDtzc2xfdmVyaWZ5LmgmcXVvdDs8YnI+wqAjaW5jbHVkZSAmcXVvdDttYW5hZ2UuaCZx
dW90Ozxicj4rI2luY2x1ZGUgJnF1b3Q7cGx1Z2luLmgmcXVvdDs8YnI+wqA8YnI+wqAjaW5jbHVk
ZSAmcXVvdDttZW1kYmcuaCZxdW90Ozxicj7CoDxicj5AQCAtNzIsNiArNzMsMjkgQEAgcmVjZWl2
ZV9hdXRoX2ZhaWxlZChzdHJ1Y3QgY29udGV4dCAqYywgY29uc3Qgc3RydWN0IGJ1ZmZlciAqYnVm
ZmVyKTxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBBU1NFUlQoMCk7PGJyPsKg
wqDCoMKgwqDCoMKgwqAgfTxicj7CoMKgwqDCoMKgwqDCoMKgIGMtJmd0O3NpZy0mZ3Q7c2lnbmFs
X3RleHQgPSAmcXVvdDthdXRoLWZhaWx1cmUmcXVvdDs7PGJyPis8YnI+K8KgwqDCoMKgwqDCoMKg
IGlmIChwbHVnaW5fZGVmaW5lZChjLSZndDtwbHVnaW5zLCBPUEVOVlBOX1BMVUdJTl9BVVRIX0ZB
SUxFRCkpPGJyPivCoMKgwqDCoMKgwqDCoCB7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0
cnVjdCBhcmd2IGFyZ3YgPSBhcmd2X25ldygpOzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBj
b25zdCBjaGFyICpyZWFzb24gPSBOVUxMOzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1
Y3QgYnVmZmVyIGJ1ZiA9ICpidWZmZXI7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChi
dWZfc3RyaW5nX2NvbXBhcmVfYWR2YW5jZSgmYW1wO2J1ZiwgJnF1b3Q7QVVUSF9GQUlMRUQsJnF1
b3Q7KSAmYW1wOyZhbXA7IEJMRU4oJmFtcDtidWYpKTxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVhc29uID0gQlNUUigmYW1w
O2J1Zik7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0ZW52X3N0cihjLSZn
dDs8YSBocmVmPSJodHRwOi8vYzIuZXMiPmMyLmVzPC9hPiwgJnF1b3Q7YXV0aF9mYWlsZWRfcmVh
c29uJnF1b3Q7LCByZWFzb24pOzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9PGJyPis8YnI+
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHBsdWdpbl9jYWxsKGMtJmd0O3BsdWdpbnMsIE9Q
RU5WUE5fUExVR0lOX0FVVEhfRkFJTEVELCAmYW1wO2FyZ3YsIE5VTEwsIGMtJmd0OzxhIGhyZWY9
Imh0dHA6Ly9jMi5lcyI+YzIuZXM8L2E+KSAhPSBPUEVOVlBOX1BMVUdJTl9GVU5DX1NVQ0NFU1Mp
PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBtc2coTV9XQVJOLCAmcXVvdDtXQVJOSU5HOiBhdXRoZmFpbGVkIHBsdWdpbiBjYWxs
IGZhaWxlZCZxdW90Oyk7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH08YnI+Kzxicj4rwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmVhc29uKTxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2V0ZW52X2RlbChjLSZndDs8
YSBocmVmPSJodHRwOi8vYzIuZXMiPmMyLmVzPC9hPiwgJnF1b3Q7YXV0aF9mYWlsZWRfcmVhc29u
JnF1b3Q7KTs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfTxicj4rwqDCoMKgwqDCoMKgwqAg
fTxicj4rPGJyPsKgI2lmZGVmIEVOQUJMRV9NQU5BR0VNRU5UPGJyPsKgwqDCoMKgwqDCoMKgwqAg
aWYgKG1hbmFnZW1lbnQpPGJyPsKgwqDCoMKgwqDCoMKgwqAgezxicj5kaWZmIC0tZ2l0IGEvc3Jj
L29wZW52cG4vc3NsLmMgYi9zcmMvb3BlbnZwbi9zc2wuYzxicj5pbmRleCA2NjlmOTQxYi4uYjQx
NmFhM2MgMTAwNjQ0PGJyPi0tLSBhL3NyYy9vcGVudnBuL3NzbC5jPGJyPisrKyBiL3NyYy9vcGVu
dnBuL3NzbC5jPGJyPkBAIC0xMDE1LDYgKzEwMTUsNyBAQCBrZXlfc3RhdGVfZnJlZShzdHJ1Y3Qg
a2V5X3N0YXRlICprcywgYm9vbCBjbGVhcik8YnI+wqA8YnI+wqAjaWZkZWYgUExVR0lOX0RFRl9B
VVRIPGJyPsKgwqDCoMKgIGtleV9zdGF0ZV9ybV9hdXRoX2NvbnRyb2xfZmlsZShrcyk7PGJyPivC
oMKgwqAga2V5X3N0YXRlX3JtX2F1dGhfZmFpbHVyZV9yZWFzb25fZmlsZShrcyk7PGJyPsKgI2Vu
ZGlmPGJyPsKgPGJyPsKgwqDCoMKgIGlmIChjbGVhcik8YnI+QEAgLTEzNDcsOCArMTM0OCw4IEBA
IHRsc19tdWx0aV9mcmVlKHN0cnVjdCB0bHNfbXVsdGkgKm11bHRpLCBib29sIGNsZWFyKTxicj7C
oDxicj7CoMKgwqDCoCBBU1NFUlQobXVsdGkpOzxicj7CoDxicj4tI2lmZGVmIE1BTkFHRU1FTlRf
REVGX0FVVEg8YnI+LcKgwqDCoCBtYW5fZGVmX2F1dGhfc2V0X2NsaWVudF9yZWFzb24obXVsdGks
IE5VTEwpOzxicj4rI2lmZGVmIEVOQUJMRV9ERUZfQVVUSDxicj4rwqDCoMKgIHRsc19kZWZfYXV0
aF9zZXRfY2xpZW50X3JlYXNvbihtdWx0aSwgTlVMTCk7PGJyPsKgPGJyPsKgI2VuZGlmPGJyPsKg
I2lmIFAyTVBfU0VSVkVSPGJyPmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9zc2xfY29tbW9uLmgg
Yi9zcmMvb3BlbnZwbi9zc2xfY29tbW9uLmg8YnI+aW5kZXggMDhlZjZmZmEuLmY0NzYwOWI0IDEw
MDY0NDxicj4tLS0gYS9zcmMvb3BlbnZwbi9zc2xfY29tbW9uLmg8YnI+KysrIGIvc3JjL29wZW52
cG4vc3NsX2NvbW1vbi5oPGJyPkBAIC0xOTksNiArMTk5LDcgQEAgc3RydWN0IGtleV9zdGF0ZTxi
cj7CoMKgwqDCoCB1bnNpZ25lZCBpbnQgYXV0aF9jb250cm9sX3N0YXR1czs8YnI+wqDCoMKgwqAg
dGltZV90IGFjZl9sYXN0X21vZDs8YnI+wqDCoMKgwqAgY2hhciAqYXV0aF9jb250cm9sX2ZpbGU7
PGJyPivCoMKgwqAgY2hhciAqYXV0aF9mYWlsdXJlX3JlYXNvbl9maWxlOzxicj7CoCNlbmRpZjxi
cj7CoCNlbmRpZjxicj7CoH07PGJyPmRpZmYgLS1naXQgYS9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5
LmMgYi9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5LmM8YnI+aW5kZXggMjUzOTViMjcuLjAzMWJlZTIx
IDEwMDY0NDxicj4tLS0gYS9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5LmM8YnI+KysrIGIvc3JjL29w
ZW52cG4vc3NsX3ZlcmlmeS5jPGJyPkBAIC04MzcsOSArODM3LDkgQEAgY2xlYW51cDo8YnI+wqAj
ZGVmaW5lIEFDRl9GQUlMRUTCoMKgwqAgMzxicj7CoCNlbmRpZjxicj7CoDxicj4tI2lmZGVmIE1B
TkFHRU1FTlRfREVGX0FVVEg8YnI+KyNpZmRlZiBFTkFCTEVfREVGX0FVVEg8YnI+wqB2b2lkPGJy
Pi1tYW5fZGVmX2F1dGhfc2V0X2NsaWVudF9yZWFzb24oc3RydWN0IHRsc19tdWx0aSAqbXVsdGks
IGNvbnN0IGNoYXIgKmNsaWVudF9yZWFzb24pPGJyPit0bHNfZGVmX2F1dGhfc2V0X2NsaWVudF9y
ZWFzb24oc3RydWN0IHRsc19tdWx0aSAqbXVsdGksIGNvbnN0IGNoYXIgKmNsaWVudF9yZWFzb24p
PGJyPsKgezxicj7CoMKgwqDCoCBpZiAobXVsdGktJmd0O2NsaWVudF9yZWFzb24pPGJyPsKgwqDC
oMKgIHs8YnI+QEAgLTg1Miw3ICs4NTIsOSBAQCBtYW5fZGVmX2F1dGhfc2V0X2NsaWVudF9yZWFz
b24oc3RydWN0IHRsc19tdWx0aSAqbXVsdGksIGNvbnN0IGNoYXIgKmNsaWVudF9yZWFzbzxicj7C
oMKgwqDCoMKgwqDCoMKgIG11bHRpLSZndDtjbGllbnRfcmVhc29uID0gc3RyaW5nX2FsbG9jKGNs
aWVudF9yZWFzb24sIE5VTEwpOzxicj7CoMKgwqDCoCB9PGJyPsKgfTxicj4rI2VuZGlmIC8qIGlm
ZGVmIEVOQUJMRV9ERUZfQVVUSCAqLzxicj7CoDxicj4rI2lmZGVmIE1BTkFHRU1FTlRfREVGX0FV
VEg8YnI+wqBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGludDxicj7CoG1hbl9kZWZfYXV0aF90ZXN0
KGNvbnN0IHN0cnVjdCBrZXlfc3RhdGUgKmtzKTxicj7CoHs8YnI+QEAgLTkzMCw2ICs5MzIsNTgg
QEAga2V5X3N0YXRlX3Rlc3RfYXV0aF9jb250cm9sX2ZpbGUoc3RydWN0IGtleV9zdGF0ZSAqa3Mp
PGJyPsKgwqDCoMKgIHJldHVybiBBQ0ZfRElTQUJMRUQ7PGJyPsKgfTxicj7CoDxicj4rLyo8YnI+
KyAqIGF1dGhfZmFpbHVyZV9yZWFzb25fZmlsZSBmdW5jdGlvbnM8YnI+KyAqLzxicj4rPGJyPit2
b2lkPGJyPitrZXlfc3RhdGVfcm1fYXV0aF9mYWlsdXJlX3JlYXNvbl9maWxlKHN0cnVjdCBrZXlf
c3RhdGUgKmtzKTxicj4rezxicj4rwqDCoMKgIGlmIChrcyAmYW1wOyZhbXA7IGtzLSZndDthdXRo
X2ZhaWx1cmVfcmVhc29uX2ZpbGUpPGJyPivCoMKgwqAgezxicj4rwqDCoMKgwqDCoMKgwqAgcGxh
dGZvcm1fdW5saW5rKGtzLSZndDthdXRoX2ZhaWx1cmVfcmVhc29uX2ZpbGUpOzxicj4rwqDCoMKg
wqDCoMKgwqAgZnJlZShrcy0mZ3Q7YXV0aF9mYWlsdXJlX3JlYXNvbl9maWxlKTs8YnI+K8KgwqDC
oMKgwqDCoMKgIGtzLSZndDthdXRoX2ZhaWx1cmVfcmVhc29uX2ZpbGUgPSBOVUxMOzxicj4rwqDC
oMKgIH08YnI+K308YnI+Kzxicj4rc3RhdGljIGJvb2w8YnI+K2tleV9zdGF0ZV9nZW5fYXV0aF9m
YWlsdXJlX3JlYXNvbl9maWxlKHN0cnVjdCBrZXlfc3RhdGUgKmtzLCBjb25zdCBzdHJ1Y3QgdGxz
X29wdGlvbnMgKm9wdCk8YnI+K3s8YnI+K8KgwqDCoCBzdHJ1Y3QgZ2NfYXJlbmEgZ2MgPSBnY19u
ZXcoKTs8YnI+Kzxicj4rwqDCoMKgIGtleV9zdGF0ZV9ybV9hdXRoX2ZhaWx1cmVfcmVhc29uX2Zp
bGUoa3MpOzxicj4rwqDCoMKgIGNvbnN0IGNoYXIgKmFjZiA9IGNyZWF0ZV90ZW1wX2ZpbGUob3B0
LSZndDt0bXBfZGlyLCAmcXVvdDthZnJmJnF1b3Q7LCAmYW1wO2djKTs8YnI+K8KgwqDCoCBpZiAo
YWNmKTxicj4rwqDCoMKgIHs8YnI+K8KgwqDCoMKgwqDCoMKgIGtzLSZndDthdXRoX2ZhaWx1cmVf
cmVhc29uX2ZpbGUgPSBzdHJpbmdfYWxsb2MoYWNmLCBOVUxMKTs8YnI+K8KgwqDCoMKgwqDCoMKg
IHNldGVudl9zdHIob3B0LSZndDtlcywgJnF1b3Q7YXV0aF9mYWlsdXJlX3JlYXNvbl9maWxlJnF1
b3Q7LCBrcy0mZ3Q7YXV0aF9mYWlsdXJlX3JlYXNvbl9maWxlKTs8YnI+K8KgwqDCoCB9PGJyPis8
YnI+K8KgwqDCoCBnY19mcmVlKCZhbXA7Z2MpOzxicj4rwqDCoMKgIHJldHVybiBhY2Y7PGJyPit9
PGJyPis8YnI+K3N0YXRpYyBjaGFyICo8YnI+K2tleV9zdGF0ZV9yZWFkX2F1dGhfZmFpbHVyZV9y
ZWFzb25fZmlsZShzdHJ1Y3Qga2V5X3N0YXRlICprcyk8YnI+K3s8YnI+K8KgwqDCoCBjaGFyICps
aW5lID0gTlVMTDs8YnI+K8KgwqDCoCBzaXplX3QgbGluZV9sZW4gPSAwOzxicj4rwqDCoMKgIGlm
IChrcyAmYW1wOyZhbXA7IGtzLSZndDthdXRoX2ZhaWx1cmVfcmVhc29uX2ZpbGUpPGJyPivCoMKg
wqAgezxicj4rwqDCoMKgwqDCoMKgwqAgRklMRSAqZnAgPSBmb3Blbihrcy0mZ3Q7YXV0aF9mYWls
dXJlX3JlYXNvbl9maWxlLCAmcXVvdDtyJnF1b3Q7KTs8YnI+K8KgwqDCoMKgwqDCoMKgIGlmIChm
cCk8YnI+K8KgwqDCoMKgwqDCoMKgIHs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGdl
dGxpbmUoJmFtcDtsaW5lLCAmYW1wO2xpbmVfbGVuLCBmcCkgJmx0OyAwKTxicj4rwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbGluZSA9
IE5VTEw7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH08YnI+K8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZmNsb3NlKGZwKTs8YnI+K8KgwqDCoMKgwqDCoMKgIH08YnI+K8KgwqDCoCB9PGJyPivC
oMKgwqAgcmV0dXJuIGxpbmU7PGJyPit9PGJyPis8YnI+wqAjZW5kaWYgLyogaWZkZWYgUExVR0lO
X0RFRl9BVVRIICovPGJyPsKgPGJyPsKgLyo8YnI+QEAgLTk4Nyw2ICsxMDQxLDcgQEAgdGxzX2F1
dGhlbnRpY2F0aW9uX3N0YXR1cyhzdHJ1Y3QgdGxzX211bHRpICptdWx0aSwgY29uc3QgaW50IGxh
dGVuY3kpPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChrcy0mZ3Q7YXV0
aGVudGljYXRlZCk8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgezxicj7CoCNp
ZmRlZiBFTkFCTEVfREVGX0FVVEg8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGNoYXIgKnJlYXNvbiA9IE5VTEw7PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHMxID0gQUNGX0RJU0FCTEVEOzxicj7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGludCBzMiA9IEFDRl9E
SVNBQkxFRDs8YnI+wqAjaWZkZWYgUExVR0lOX0RFRl9BVVRIPGJyPkBAIC0xMDEyLDYgKzEwNjcs
MTIgQEAgdGxzX2F1dGhlbnRpY2F0aW9uX3N0YXR1cyhzdHJ1Y3QgdGxzX211bHRpICptdWx0aSwg
Y29uc3QgaW50IGxhdGVuY3kpPGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOzxicj7CoDxicj7CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY2FzZSBBQ0ZfRkFJTEVEOjxicj4rI2lmZGVm
IFBMVUdJTl9ERUZfQVVUSDxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJlYXNvbiA9IGtleV9zdGF0ZV9yZWFkX2F1dGhfZmFpbHVyZV9y
ZWFzb25fZmlsZShrcyk7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgdGxzX2RlZl9hdXRoX3NldF9jbGllbnRfcmVhc29uKG11bHRpLCBy
ZWFzb24pOzxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGZyZWUocmVhc29uKTs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZWFzb24gPSBOVUxMOzxicj4rI2VuZGlmIC8qIFBM
VUdJTl9ERUZfQVVUSCAqLzxicj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBrcy0mZ3Q7YXV0aGVudGljYXRlZCA9IGZhbHNlOzxicj7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBicmVh
azs8YnI+wqA8YnI+QEAgLTEwNTYsNyArMTExNyw3IEBAIHRsc19hdXRoZW50aWNhdGVfa2V5KHN0
cnVjdCB0bHNfbXVsdGkgKm11bHRpLCBjb25zdCB1bnNpZ25lZCBpbnQgbWRhX2tleV9pZCwgY29u
PGJyPsKgwqDCoMKgIGlmIChtdWx0aSk8YnI+wqDCoMKgwqAgezxicj7CoMKgwqDCoMKgwqDCoMKg
IGludCBpOzxicj4twqDCoMKgwqDCoMKgwqAgbWFuX2RlZl9hdXRoX3NldF9jbGllbnRfcmVhc29u
KG11bHRpLCBjbGllbnRfcmVhc29uKTs8YnI+K8KgwqDCoMKgwqDCoMKgIHRsc19kZWZfYXV0aF9z
ZXRfY2xpZW50X3JlYXNvbihtdWx0aSwgY2xpZW50X3JlYXNvbik7PGJyPsKgwqDCoMKgwqDCoMKg
wqAgZm9yIChpID0gMDsgaSAmbHQ7IEtFWV9TQ0FOX1NJWkU7ICsraSk8YnI+wqDCoMKgwqDCoMKg
wqDCoCB7PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3Qga2V5X3N0YXRlICprcyA9
IG11bHRpLSZndDtrZXlfc2NhbltpXTs8YnI+QEAgLTExOTUsMTYgKzEyNTYsMjYgQEAgdmVyaWZ5
X3VzZXJfcGFzc19wbHVnaW4oc3RydWN0IHRsc19zZXNzaW9uICpzZXNzaW9uLCBjb25zdCBzdHJ1
Y3QgdXNlcl9wYXNzICp1cCw8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAm
cXVvdDtjb3VsZCBub3QgY3JlYXRlIGRlZmVycmVkIGF1dGggY29udHJvbCBmaWxlJnF1b3Q7LCBf
X2Z1bmNfXyk7PGJyPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnb3RvIGNsZWFudXA7PGJyPsKg
wqDCoMKgwqDCoMKgwqAgfTxicj4rPGJyPivCoMKgwqDCoMKgwqDCoCAvKiBnZW5lcmF0ZSBmaWxl
bmFtZSBmb3IgZGVmZXJyZWQgYXV0aCBmYWlsdXJlIHJlYXNvbiBmaWxlICovPGJyPivCoMKgwqDC
oMKgwqDCoCBpZiAoIWtleV9zdGF0ZV9nZW5fYXV0aF9mYWlsdXJlX3JlYXNvbl9maWxlKGtzLCBz
ZXNzaW9uLSZndDtvcHQpKTxicj4rwqDCoMKgwqDCoMKgwqAgezxicj4rwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBrZXlfc3RhdGVfcm1fYXV0aF9mYWlsdXJlX3JlYXNvbl9maWxlKGtzKTs8YnI+K8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbXNnIChEX1RMU19FUlJPUlMsICZxdW90O1RMUyBBdXRoIEVy
cm9yICglcyk6ICZxdW90Ozxicj4rwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnF1
b3Q7Y291bGQgbm90IGNyZWF0ZSBkZWZlcnJlZCBhdXRoIGZhaWx1cmUgcmVhc29uIGZpbGUmcXVv
dDssIF9fZnVuY19fKTs8YnI+K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBjbGVhbnVwOzxi
cj4rwqDCoMKgwqDCoMKgwqAgfTxicj7CoCNlbmRpZjxicj7CoDxicj7CoMKgwqDCoMKgwqDCoMKg
IC8qIGNhbGwgY29tbWFuZCAqLzxicj7CoMKgwqDCoMKgwqDCoMKgIHJldHZhbCA9IHBsdWdpbl9j
YWxsKHNlc3Npb24tJmd0O29wdC0mZ3Q7cGx1Z2lucywgT1BFTlZQTl9QTFVHSU5fQVVUSF9VU0VS
X1BBU1NfVkVSSUZZLCBOVUxMLCBOVUxMLCBzZXNzaW9uLSZndDtvcHQtJmd0O2VzKTs8YnI+wqA8
YnI+wqAjaWZkZWYgUExVR0lOX0RFRl9BVVRIPGJyPi3CoMKgwqDCoMKgwqDCoCAvKiBwdXJnZSBh
dXRoIGNvbnRyb2wgZmlsZW5hbWUgKGFuZCBmaWxlIGl0c2VsZikgZm9yIG5vbi1kZWZlcnJlZCBy
ZXR1cm5zICovPGJyPivCoMKgwqDCoMKgwqDCoCAvKiBwdXJnZSBhdXRoIGNvbnRyb2wgZmlsZW5h
bWVzIChhbmQgZmlsZXMgdGhlbXNlbHZlcykgZm9yIG5vbi1kZWZlcnJlZCByZXR1cm5zICovPGJy
PsKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldHZhbCAhPSBPUEVOVlBOX1BMVUdJTl9GVU5DX0RFRkVS
UkVEKTxicj7CoMKgwqDCoMKgwqDCoMKgIHs8YnI+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtl
eV9zdGF0ZV9ybV9hdXRoX2NvbnRyb2xfZmlsZShrcyk7PGJyPivCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGtleV9zdGF0ZV9ybV9hdXRoX2ZhaWx1cmVfcmVhc29uX2ZpbGUoa3MpOzxicj7CoMKgwqDC
oMKgwqDCoMKgIH08YnI+wqAjZW5kaWY8YnI+wqA8YnI+ZGlmZiAtLWdpdCBhL3NyYy9vcGVudnBu
L3NzbF92ZXJpZnkuaCBiL3NyYy9vcGVudnBuL3NzbF92ZXJpZnkuaDxicj5pbmRleCA2NGYyN2Vm
Yi4uODhiNzkwZmYgMTAwNjQ0PGJyPi0tLSBhL3NyYy9vcGVudnBuL3NzbF92ZXJpZnkuaDxicj4r
KysgYi9zcmMvb3BlbnZwbi9zc2xfdmVyaWZ5Lmg8YnI+QEAgLTk2LDYgKzk2LDEzIEBAIGludCB0
bHNfYXV0aGVudGljYXRpb25fc3RhdHVzKHN0cnVjdCB0bHNfbXVsdGkgKm11bHRpLCBjb25zdCBp
bnQgbGF0ZW5jeSk7PGJyPsKgdm9pZCBrZXlfc3RhdGVfcm1fYXV0aF9jb250cm9sX2ZpbGUoc3Ry
dWN0IGtleV9zdGF0ZSAqa3MpOzxicj7CoDxicj7CoC8qKjxicj4rICogUmVtb3ZlIHRoZSBnaXZl
biBrZXkgc3RhdGUmIzM5O3MgYXV0aCBmYWlsdXJlIHJlYXNvbiBmaWxlLCBpZiBpdCBleGlzdHMu
PGJyPisgKjxicj4rICogQHBhcmFtIGtzwqDCoMKgIFRoZSBrZXkgc3RhdGUgdGhlIHJlbW92ZSB0
aGUgZmlsZSBmb3I8YnI+KyAqLzxicj4rdm9pZCBrZXlfc3RhdGVfcm1fYXV0aF9mYWlsdXJlX3Jl
YXNvbl9maWxlKHN0cnVjdCBrZXlfc3RhdGUgKmtzKTs8YnI+Kzxicj4rLyoqPGJyPsKgICogRnJl
ZXMgdGhlIGdpdmVuIHNldCBvZiBjZXJ0aWZpY2F0ZSBoYXNoZXMuPGJyPsKgICo8YnI+wqAgKiBA
cGFyYW0gY2hzwqDCoCBUaGUgY2VydGlmaWNhdGUgaGFzaCBzZXQgdG8gZnJlZS48YnI+QEAgLTIy
Myw5ICsyMzAsMTAgQEAgc3RydWN0IHg1MDlfdHJhY2s8YnI+wqAgKi88YnI+wqAjaWZkZWYgTUFO
QUdFTUVOVF9ERUZfQVVUSDxicj7CoGJvb2wgdGxzX2F1dGhlbnRpY2F0ZV9rZXkoc3RydWN0IHRs
c19tdWx0aSAqbXVsdGksIGNvbnN0IHVuc2lnbmVkIGludCBtZGFfa2V5X2lkLCBjb25zdCBib29s
IGF1dGgsIGNvbnN0IGNoYXIgKmNsaWVudF9yZWFzb24pOzxicj4rI2VuZGlmPGJyPsKgPGJyPi12
b2lkIG1hbl9kZWZfYXV0aF9zZXRfY2xpZW50X3JlYXNvbihzdHJ1Y3QgdGxzX211bHRpICptdWx0
aSwgY29uc3QgY2hhciAqY2xpZW50X3JlYXNvbik7PGJyPi08YnI+KyNpZmRlZiBFTkFCTEVfREVG
X0FVVEg8YnI+K3ZvaWQgdGxzX2RlZl9hdXRoX3NldF9jbGllbnRfcmVhc29uKHN0cnVjdCB0bHNf
bXVsdGkgKm11bHRpLCBjb25zdCBjaGFyICpjbGllbnRfcmVhc29uKTs8YnI+wqAjZW5kaWY8YnI+
wqA8YnI+wqBzdGF0aWMgaW5saW5lIGNvbnN0IGNoYXIgKjxicj4tLSA8YnI+Mi4xMy42PGJyPjxi
cj48L2Rpdj4NCg==

--001a114daa2cd1a9ce056906d9ce--

