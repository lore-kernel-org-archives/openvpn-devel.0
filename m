From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 May 2026 21:20:59 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@...2715...>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c49ae1a09db9f5ecc45d146b7c4607cfcadbb1f6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jEQ1hmBv+3w="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jEQ1hmBv+3w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1617?usp=3Demail

to look at the new patch set (#5).


Change subject: Remove various useless assignments
......................................................................

Remove various useless assignments

The values assigned by these are never actually used
for something.

Identified by cppcheck.

Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/console_builtin.c
M src/openvpn/crypto.c
M src/openvpn/error.h
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/options.c
M src/openvpn/pkcs11.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/push_util.c
M src/openvpn/ssl_openssl.c
M src/openvpn/win32.c
M src/openvpnmsica/openvpnmsica.c
M src/tapctl/tap.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/openvpnserv/test_openvpnserv.c
15 files changed, 41 insertions(+), 58 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1617/5

diff --git a/src/openvpn/console_builtin.c b/src/openvpn/console_builtin.c
index 2a9f3b6..9c8d72a 100644
--- a/src/openvpn/console_builtin.c
+++ b/src/openvpn/console_builtin.c
@@ -192,7 +192,6 @@
 static bool
 get_console_input(const char *prompt, const bool echo, char *input, const =
int capacity)
 {
-    bool ret =3D false;
     ASSERT(prompt);
     ASSERT(input);
     ASSERT(capacity > 0);
@@ -200,8 +199,11 @@

 #if defined(_WIN32)
     return get_console_input_win32(prompt, echo, input, capacity);
-#elif defined(HAVE_TERMIOS_H)
+#elif !defined(HAVE_TERMIOS_H)
+    msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", p=
rompt);
+#else
     bool restore_tty =3D false;
+    bool ret =3D false;
     struct termios tty_tmp, tty_save;

     /* did we --daemon'ize before asking for passwords?
@@ -258,10 +260,8 @@
     }

     close_tty(fp);
-#else  /* if defined(_WIN32) */
-    msg(M_FATAL, "Sorry, but I can't get console input on this OS (%s)", p=
rompt);
-#endif /* if defined(_WIN32) */
     return ret;
+#endif /* if defined(_WIN32) */
 }

 /**
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 7954e8a..df9b905 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1204,8 +1204,6 @@
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &gc);
-    struct buffer buf =3D clear_buf();
-    void *buf_p;

     /* init work */
     ASSERT(buf_init(&work, frame->buf.headroom));
@@ -1242,8 +1240,8 @@
         ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));

         /* copy source to input buf */
-        buf =3D work;
-        buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
+        struct buffer buf =3D work;
+        void *buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLENZ(&src));

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 45826a2..a887fc7 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -408,8 +408,8 @@
 openvpn_errno_maybe_crt(bool *crt_error)
 {
     int err =3D 0;
-    *crt_error =3D false;
 #ifdef _WIN32
+    *crt_error =3D false;
     err =3D GetLastError();
     if (err =3D=3D ERROR_SUCCESS)
     {
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27cfd36..53eab4d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1746,7 +1746,6 @@
 process_outgoing_link(struct context *c, struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
-    int error_code =3D 0;

     if (c->c2.to_link.len > 0 && c->c2.to_link.len <=3D c->c2.frame.buf.pa=
yload_size)
     {
@@ -1821,7 +1820,7 @@
         }

         /* Check return status */
-        error_code =3D openvpn_errno();
+        int error_code =3D openvpn_errno();
         check_status(size, "write", sock, NULL);

         if (size > 0)
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 2a3023c..f1dccc1 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -916,10 +916,9 @@
 static void
 man_remote_entry_count(struct management *man)
 {
-    unsigned count =3D 0;
     if (man->persist.callback.remote_entry_count)
     {
-        count =3D (*man->persist.callback.remote_entry_count)(man->persist=
.callback.arg);
+        unsigned int count =3D (*man->persist.callback.remote_entry_count)=
(man->persist.callback.arg);
         msg(M_CLIENT, "%u", count);
         msg(M_CLIENT, "END");
     }
@@ -3745,7 +3744,6 @@
     struct gc_arena gc =3D gc_new();
     int ret =3D 0;
     volatile int signal_received =3D 0;
-    struct buffer alert_msg =3D clear_buf();
     const bool standalone_disabled_save =3D man->persist.standalone_disabl=
ed;
     struct man_connection *mc =3D &man->connection;

@@ -3757,6 +3755,7 @@

         *state =3D EKS_SOLICIT;

+        struct buffer alert_msg;
         if (b64_data)
         {
             alert_msg =3D alloc_buf_gc(strlen(b64_data) + strlen(prompt) +=
 3, &gc);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0c2866c..1d3d649 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7091,7 +7091,6 @@
             if (streq(p[1], "FORWARD_COMPATIBLE") && p[2] && streq(p[2], "=
1"))
             {
                 options->forward_compatible =3D true;
-                msglevel_fc =3D msglevel_forward_compatible(options, msgle=
vel);
             }
             setenv_str(es, p[1], p[2] ? p[2] : "");
         }
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index cfcd372..d115e0a 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -79,6 +79,9 @@
 static msglvl_t
 _pkcs11_msg_pkcs112openvpn(const unsigned flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return M_INFO;
+#else
     msglvl_t openvpn_flags;

     switch (flags)
@@ -108,16 +111,16 @@
             break;
     }

-#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-    openvpn_flags =3D M_INFO;
-#endif
-
     return openvpn_flags;
+#endif
 }

 static unsigned
 _pkcs11_msg_openvpn2pkcs11(const msglvl_t flags)
 {
+#ifdef ENABLE_PKCS11_FORCE_DEBUG
+    return PKCS11H_LOG_DEBUG2;
+#else
     unsigned pkcs11_flags;

     if ((flags & D_PKCS11_DEBUG) !=3D 0)
@@ -145,11 +148,8 @@
         pkcs11_flags =3D PKCS11H_LOG_ERROR;
     }

-#if defined(ENABLE_PKCS11_FORCE_DEBUG)
-    pkcs11_flags =3D PKCS11H_LOG_DEBUG2;
-#endif
-
     return pkcs11_flags;
+#endif
 }

 static void
diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index b6c1624..69c5a50 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -384,7 +384,6 @@
     if (certificate !=3D NULL)
     {
         pkcs11h_certificate_freeCertificate(certificate);
-        certificate =3D NULL;
     }

     /*
@@ -400,7 +399,6 @@
     if (openssl_session !=3D NULL)
     {
         pkcs11h_openssl_freeSession(openssl_session);
-        openssl_session =3D NULL;
     }
     return ret;
 #endif                                                          /* ifdef H=
AVE_XKEY_PROVIDER */
diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index f57f54d..af22af5 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -99,7 +99,6 @@
     }

     char *str =3D gc_strdup(s, gc);
-    size_t i =3D 0;

     while (*str)
     {
@@ -112,11 +111,11 @@
                 /* if no commas were found go to fail, do not send any mes=
sage */
                 return false;
             }
+            /* copy from current position to (ci - 1) */
             str[ci] =3D '\0';
-            /* copy from i to (ci -1) */
             struct buffer tmp =3D forge_msg(str, ",push-continuation 2", g=
c);
             buffer_list_push(msgs, BSTR(&tmp));
-            i =3D ci + 1;
+            str +=3D ci + 1;
         }
         else
         {
@@ -130,9 +129,8 @@
                 struct buffer tmp =3D forge_msg(str, NULL, gc);
                 buffer_list_push(msgs, BSTR(&tmp));
             }
-            i =3D strlen(str);
+            break;
         }
-        str =3D &str[i];
     }
     return true;
 }
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index c47e3d2..306f85cd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2353,13 +2353,13 @@
     }

     int typeid =3D EVP_PKEY_id(pkey);
+
+#ifndef OPENSSL_NO_EC
 #if OPENSSL_VERSION_NUMBER < 0x30000000L
     bool is_ec =3D typeid =3D=3D EVP_PKEY_EC;
 #else
     bool is_ec =3D EVP_PKEY_is_a(pkey, "EC");
 #endif
-
-#ifndef OPENSSL_NO_EC
     char groupname[64];
     if (is_ec)
     {
@@ -2667,15 +2667,13 @@
            "builtin EC curves. It does not list additional curves nor X448=
 or X25519\n");
 #ifndef OPENSSL_NO_EC
     EC_builtin_curve *curves =3D NULL;
-    size_t crv_len =3D 0;
-    size_t n =3D 0;

-    crv_len =3D EC_get_builtin_curves(NULL, 0);
+    size_t crv_len =3D EC_get_builtin_curves(NULL, 0);
     ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);
     if (EC_get_builtin_curves(curves, crv_len))
     {
         printf("\nAvailable Elliptic curves/groups:\n");
-        for (n =3D 0; n < crv_len; n++)
+        for (size_t n =3D 0; n < crv_len; n++)
         {
             const char *sname;
             sname =3D OBJ_nid2sn(curves[n].nid);
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index b2a7331..5ee65fb 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1293,9 +1293,6 @@
     is_wow64_process2_t is_wow64_process2 =3D
         (is_wow64_process2_t)GetProcAddress(GetModuleHandle("Kernel32.dll"=
), "IsWow64Process2");

-    USHORT process_machine =3D 0;
-    USHORT native_machine =3D 0;
-
 #ifdef _ARM64_
     *process_arch =3D ARCH_ARM64;
 #elif defined(_WIN64)
@@ -1303,6 +1300,8 @@
     if (is_wow64_process2)
     {
         /* this could be amd64 on arm64 */
+        USHORT process_machine =3D 0;
+        USHORT native_machine =3D 0;
         BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &process_=
machine, &native_machine);
         if (is_wow64 && native_machine =3D=3D IMAGE_FILE_MACHINE_ARM64)
         {
@@ -1315,6 +1314,8 @@
     if (is_wow64_process2)
     {
         /* check if we're running on arm64 or amd64 machine */
+        USHORT process_machine =3D 0;
+        USHORT native_machine =3D 0;
         BOOL is_wow64 =3D is_wow64_process2(GetCurrentProcess(), &process_=
machine, &native_machine);
         if (is_wow64)
         {
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index fdb610c..d698c04 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -711,7 +711,6 @@
         uiResult =3D MsiViewFetch(hViewST, &hRecord);
         if (uiResult =3D=3D ERROR_NO_MORE_ITEMS)
         {
-            uiResult =3D ERROR_SUCCESS;
             break;
         }
         else if (uiResult !=3D ERROR_SUCCESS)
diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c
index 16e3c0b..6ed395d 100644
--- a/src/tapctl/tap.c
+++ b/src/tapctl/tap.c
@@ -473,7 +473,7 @@
                         return ERROR_OUTOFMEMORY;
                     }

-                    dwCountExpResult =3D ExpandEnvironmentStrings(szValue,=
 szValueExp, dwCountExp);
+                    ExpandEnvironmentStrings(szValue, szValueExp, dwCountE=
xp);
                     free(szValue);
                     *pszValue =3D szValueExp;
                     return ERROR_SUCCESS;
@@ -601,8 +601,6 @@
                         _In_ DWORD dwProperty, _Out_opt_ LPDWORD pdwProper=
tyRegDataType,
                         _Out_ LPVOID *ppData)
 {
-    DWORD dwResult =3D ERROR_BAD_ARGUMENTS;
-
     if (ppData =3D=3D NULL)
     {
         return ERROR_BAD_ARGUMENTS;
@@ -628,7 +626,7 @@
     }
     else
     {
-        dwResult =3D GetLastError();
+        DWORD dwResult =3D GetLastError();
         if (dwResult =3D=3D ERROR_INSUFFICIENT_BUFFER)
         {
             /* Allocate on heap and retry. */
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 0e9cecf..c40845a 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -303,8 +303,6 @@
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
-    struct buffer buf =3D clear_buf();
-    void *buf_p;

     /* init work */
     ASSERT(buf_init(&work, frame.buf.headroom));
@@ -325,8 +323,8 @@
         ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));

         /* copy source to input buf */
-        buf =3D work;
-        buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
+        struct buffer buf =3D work;
+        void *buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
         memcpy(buf_p, BPTR(&src), BLENZ(&src));

@@ -356,7 +354,6 @@
     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
-    struct buffer buf =3D clear_buf();
     struct buffer src =3D alloc_buf_gc(frame.buf.payload_size, &gc);
     void *buf_p;

@@ -371,7 +368,7 @@
     ASSERT(rand_bytes(BPTR(&src), BLEN(&src)));

     /* copy source to input buf */
-    buf =3D work;
+    struct buffer buf =3D work;
     buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ(&src));
@@ -652,7 +649,6 @@
     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&frame), &gc);
     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&frame), &gc=
);
-    struct buffer buf =3D clear_buf();
     void *buf_p;

     /* init work */
@@ -669,7 +665,7 @@
     ASSERT(buf_write(&src, plaintext, strlen(plaintext)));

     /* copy source to input buf */
-    buf =3D work;
+    struct buffer buf =3D work;
     buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
     memcpy(buf_p, BPTR(&src), BLENZ(&src));
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_t=
ests/openvpnserv/test_openvpnserv.c
index 45096a1..6a6aee4 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -57,13 +57,13 @@
 static void
 test_convert_itf_dns_domains(void **state)
 {
-    DWORD size, orig_size, len, res_len;
+    DWORD size, len, res_len;
     LSTATUS err;
     const DWORD glyph_size =3D sizeof(wchar_t);

     wchar_t domains_1[BUF_SIZE] =3D L"openvpn.com";
     len =3D (DWORD)wcslen(domains_1) + 1;
-    size =3D orig_size =3D len * glyph_size;
+    size =3D len * glyph_size;
     wchar_t domains_1_res[BUF_SIZE] =3D L".openvpn.com";
     res_len =3D len + 2; /* adds . and \0 */
     err =3D ConvertItfDnsDomains(L"openvpn.net", domains_1, &size, BUF_SIZ=
E);
@@ -73,7 +73,7 @@

     wchar_t domains_2[BUF_SIZE] =3D L"openvpn.com,openvpn.net";
     len =3D (DWORD)wcslen(domains_2) + 1;
-    size =3D orig_size =3D len * glyph_size;
+    size =3D len * glyph_size;
     wchar_t domains_2_res[BUF_SIZE] =3D L".openvpn.com";
     res_len =3D (DWORD)wcslen(domains_2_res) + 2;
     err =3D ConvertItfDnsDomains(L"openvpn.net", domains_2, &size, BUF_SIZ=
E);
@@ -83,7 +83,7 @@

     wchar_t domains_3[BUF_SIZE] =3D L"openvpn.com,openvpn.net";
     len =3D (DWORD)wcslen(domains_3) + 1;
-    size =3D orig_size =3D len * glyph_size;
+    size =3D len * glyph_size;
     wchar_t domains_3_res[BUF_SIZE] =3D L".openvpn.net";
     res_len =3D (DWORD)wcslen(domains_3_res) + 2;
     err =3D ConvertItfDnsDomains(L"openvpn.com", domains_3, &size, BUF_SIZ=
E);
@@ -93,7 +93,7 @@

     wchar_t domains_4[BUF_SIZE] =3D L"openvpn.com,openvpn.net";
     len =3D (DWORD)wcslen(domains_4) + 1;
-    size =3D orig_size =3D len * glyph_size;
+    size =3D len * glyph_size;
     wchar_t domains_4_res[BUF_SIZE] =3D L".openvpn.com\0.openvpn.net";
     res_len =3D len + 3; /* adds two . and one \0 */
     err =3D ConvertItfDnsDomains(NULL, domains_4, &size, BUF_SIZE);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1617?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-Number: 1617
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--jEQ1hmBv+3w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #5</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1617?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Remove various useless assignments<br><br>The va=
lues assigned by these are never actually used<br>for something.<br><br>Ide=
ntified by cppcheck.<br><br>Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3=
393ed<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<b=
r>M src/openvpn/console_builtin.c<br>M src/openvpn/crypto.c<br>M src/openvp=
n/error.h<br>M src/openvpn/forward.c<br>M src/openvpn/manage.c<br>M src/ope=
nvpn/options.c<br>M src/openvpn/pkcs11.c<br>M src/openvpn/pkcs11_openssl.c<=
br>M src/openvpn/push_util.c<br>M src/openvpn/ssl_openssl.c<br>M src/openvp=
n/win32.c<br>M src/openvpnmsica/openvpnmsica.c<br>M src/tapctl/tap.c<br>M t=
ests/unit_tests/openvpn/test_ssl.c<br>M tests/unit_tests/openvpnserv/test_o=
penvpnserv.c<br>15 files changed, 41 insertions(+), 58 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/17/1617/5</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/console_builtin.c b/src/op=
envpn/console_builtin.c</span><br><span>index 2a9f3b6..9c8d72a 100644</span=
><br><span>--- a/src/openvpn/console_builtin.c</span><br><span>+++ b/src/op=
envpn/console_builtin.c</span><br><span>@@ -192,7 +192,6 @@</span><br><span=
> static bool</span><br><span> get_console_input(const char *prompt, const =
bool echo, char *input, const int capacity)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br>=
<span>     ASSERT(prompt);</span><br><span>     ASSERT(input);</span><br><s=
pan>     ASSERT(capacity &gt; 0);</span><br><span>@@ -200,8 +199,11 @@</spa=
n><br><span> </span><br><span> #if defined(_WIN32)</span><br><span>     ret=
urn get_console_input_win32(prompt, echo, input, capacity);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#elif defined(HAVE_TERMIOS_H)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#elif !defined(HAVE_TERMIOS=
_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL,=
 &quot;Sorry, but I can&#39;t get console input on this OS (%s)&quot;, prom=
pt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span>     bool restore_tty =3D false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool ret =3D false;</span><br><span>     struct ter=
mios tty_tmp, tty_save;</span><br><span> </span><br><span>     /* did we --=
daemon&#39;ize before asking for passwords?</span><br><span>@@ -258,10 +260=
,8 @@</span><br><span>     }</span><br><span> </span><br><span>     close_t=
ty(fp);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if d=
efined(_WIN32) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
msg(M_FATAL, &quot;Sorry, but I can&#39;t get console input on this OS (%s)=
&quot;, prompt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endi=
f /* if defined(_WIN32) */</span><br><span>     return ret;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN32) */</sp=
an><br><span> }</span><br><span> </span><br><span> /**</span><br><span>diff=
 --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index =
7954e8a..df9b905 100644</span><br><span>--- a/src/openvpn/crypto.c</span><b=
r><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -1204,8 +1204,6 @@</s=
pan><br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(frame), &am=
p;gc);</span><br><span>     struct buffer encrypt_workspace =3D alloc_buf_g=
c(BUF_SIZE(frame), &amp;gc);</span><br><span>     struct buffer decrypt_wor=
kspace =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;</span><br><s=
pan> </span><br><span>     /* init work */</span><br><span>     ASSERT(buf_=
init(&amp;work, frame-&gt;buf.headroom));</span><br><span>@@ -1242,8 +1240,=
8 @@</span><br><span>         ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&amp;s=
rc)));</span><br><span> </span><br><span>         /* copy source to input b=
uf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =3D =
work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_p =
=3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer buf =3D work;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        void *buf_p =3D buf_wri=
te_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT(buf_p)=
;</span><br><span>         memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/error.h b/src/op=
envpn/error.h</span><br><span>index 45826a2..a887fc7 100644</span><br><span=
>--- a/src/openvpn/error.h</span><br><span>+++ b/src/openvpn/error.h</span>=
<br><span>@@ -408,8 +408,8 @@</span><br><span> openvpn_errno_maybe_crt(bool=
 *crt_error)</span><br><span> {</span><br><span>     int err =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    *crt_error =3D false;</sp=
an><br><span> #ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    *crt_error =3D false;</span><br><span>     err =3D GetLastError=
();</span><br><span>     if (err =3D=3D ERROR_SUCCESS)</span><br><span>    =
 {</span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward=
.c</span><br><span>index 27cfd36..53eab4d 100644</span><br><span>--- a/src/=
openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><sp=
an>@@ -1746,7 +1746,6 @@</span><br><span> process_outgoing_link(struct cont=
ext *c, struct link_socket *sock)</span><br><span> {</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int error_code =3D 0;</span><br><span> </span><br><span>     =
if (c-&gt;c2.to_link.len &gt; 0 &amp;&amp; c-&gt;c2.to_link.len &lt;=3D c-&=
gt;c2.frame.buf.payload_size)</span><br><span>     {</span><br><span>@@ -18=
21,7 +1820,7 @@</span><br><span>         }</span><br><span> </span><br><spa=
n>         /* Check return status */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        error_code =3D openvpn_errno();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        int error_code =3D openvpn_errno=
();</span><br><span>         check_status(size, &quot;write&quot;, sock, NU=
LL);</span><br><span> </span><br><span>         if (size &gt; 0)</span><br>=
<span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><s=
pan>index 2a3023c..f1dccc1 100644</span><br><span>--- a/src/openvpn/manage.=
c</span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -916,10 +91=
6,9 @@</span><br><span> static void</span><br><span> man_remote_entry_count=
(struct management *man)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    unsigned count =3D 0;</span><br><span>     if (ma=
n-&gt;persist.callback.remote_entry_count)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        count =3D (*man-&gt;per=
sist.callback.remote_entry_count)(man-&gt;persist.callback.arg);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int count =3D=
 (*man-&gt;persist.callback.remote_entry_count)(man-&gt;persist.callback.ar=
g);</span><br><span>         msg(M_CLIENT, &quot;%u&quot;, count);</span><b=
r><span>         msg(M_CLIENT, &quot;END&quot;);</span><br><span>     }</sp=
an><br><span>@@ -3745,7 +3744,6 @@</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     int ret =3D 0;</span><br><span>     vola=
tile int signal_received =3D 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    struct buffer alert_msg =3D clear_buf();</span><br><span>    =
 const bool standalone_disabled_save =3D man-&gt;persist.standalone_disable=
d;</span><br><span>     struct man_connection *mc =3D &amp;man-&gt;connecti=
on;</span><br><span> </span><br><span>@@ -3757,6 +3755,7 @@</span><br><span=
> </span><br><span>         *state =3D EKS_SOLICIT;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer ale=
rt_msg;</span><br><span>         if (b64_data)</span><br><span>         {</=
span><br><span>             alert_msg =3D alloc_buf_gc(strlen(b64_data) + s=
trlen(prompt) + 3, &amp;gc);</span><br><span>diff --git a/src/openvpn/optio=
ns.c b/src/openvpn/options.c</span><br><span>index 0c2866c..1d3d649 100644<=
/span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openv=
pn/options.c</span><br><span>@@ -7091,7 +7091,6 @@</span><br><span>        =
     if (streq(p[1], &quot;FORWARD_COMPATIBLE&quot;) &amp;&amp; p[2] &amp;&=
amp; streq(p[2], &quot;1&quot;))</span><br><span>             {</span><br><=
span>                 options-&gt;forward_compatible =3D true;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                msglevel_fc =3D ms=
glevel_forward_compatible(options, msglevel);</span><br><span>             =
}</span><br><span>             setenv_str(es, p[1], p[2] ? p[2] : &quot;&qu=
ot;);</span><br><span>         }</span><br><span>diff --git a/src/openvpn/p=
kcs11.c b/src/openvpn/pkcs11.c</span><br><span>index cfcd372..d115e0a 10064=
4</span><br><span>--- a/src/openvpn/pkcs11.c</span><br><span>+++ b/src/open=
vpn/pkcs11.c</span><br><span>@@ -79,6 +79,9 @@</span><br><span> static msgl=
vl_t</span><br><span> _pkcs11_msg_pkcs112openvpn(const unsigned flags)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f ENABLE_PKCS11_FORCE_DEBUG</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return M_INFO;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#else</span><br><span>     msglvl_t openvpn_flags;</span><br><span> =
</span><br><span>     switch (flags)</span><br><span>@@ -108,16 +111,16 @@<=
/span><br><span>             break;</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_P=
KCS11_FORCE_DEBUG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 openvpn_flags =3D M_INFO;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span>     return openvpn_flags;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br><span> =
static unsigned</span><br><span> _pkcs11_msg_openvpn2pkcs11(const msglvl_t =
flags)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifdef ENABLE_PKCS11_FORCE_DEBUG</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return PKCS11H_LOG_DEBUG2;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#else</span><br><span>     unsigned pkcs11_fl=
ags;</span><br><span> </span><br><span>     if ((flags &amp; D_PKCS11_DEBUG=
) !=3D 0)</span><br><span>@@ -145,11 +148,8 @@</span><br><span>         pkc=
s11_flags =3D PKCS11H_LOG_ERROR;</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_PKCS=
11_FORCE_DEBUG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pk=
cs11_flags =3D PKCS11H_LOG_DEBUG2;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span>     return pkcs11_flags;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br>=
<span> static void</span><br><span>diff --git a/src/openvpn/pkcs11_openssl.=
c b/src/openvpn/pkcs11_openssl.c</span><br><span>index b6c1624..69c5a50 100=
644</span><br><span>--- a/src/openvpn/pkcs11_openssl.c</span><br><span>+++ =
b/src/openvpn/pkcs11_openssl.c</span><br><span>@@ -384,7 +384,6 @@</span><b=
r><span>     if (certificate !=3D NULL)</span><br><span>     {</span><br><s=
pan>         pkcs11h_certificate_freeCertificate(certificate);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        certificate =3D NULL;</spa=
n><br><span>     }</span><br><span> </span><br><span>     /*</span><br><spa=
n>@@ -400,7 +399,6 @@</span><br><span>     if (openssl_session !=3D NULL)</=
span><br><span>     {</span><br><span>         pkcs11h_openssl_freeSession(=
openssl_session);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    openssl_session =3D NULL;</span><br><span>     }</span><br><span>     r=
eturn ret;</span><br><span> #endif                                         =
                 /* ifdef HAVE_XKEY_PROVIDER */</span><br><span>diff --git =
a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br><span>index f=
57f54d..af22af5 100644</span><br><span>--- a/src/openvpn/push_util.c</span>=
<br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -99,7 +99,6 @@</=
span><br><span>     }</span><br><span> </span><br><span>     char *str =3D =
gc_strdup(s, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
size_t i =3D 0;</span><br><span> </span><br><span>     while (*str)</span><=
br><span>     {</span><br><span>@@ -112,11 +111,11 @@</span><br><span>     =
            /* if no commas were found go to fail, do not send any message =
*/</span><br><span>                 return false;</span><br><span>         =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*=
 copy from current position to (ci - 1) */</span><br><span>             str=
[ci] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            /* copy from i to (ci -1) */</span><br><span>             stru=
ct buffer tmp =3D forge_msg(str, &quot;,push-continuation 2&quot;, gc);</sp=
an><br><span>             buffer_list_push(msgs, BSTR(&amp;tmp));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            i =3D ci + 1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            str +=3D ci +=
 1;</span><br><span>         }</span><br><span>         else</span><br><spa=
n>         {</span><br><span>@@ -130,9 +129,8 @@</span><br><span>          =
       struct buffer tmp =3D forge_msg(str, NULL, gc);</span><br><span>    =
             buffer_list_push(msgs, BSTR(&amp;tmp));</span><br><span>      =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
 =3D strlen(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          break;</span><br><span>         }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        str =3D &amp;str[i];</span><br><span>     }</=
span><br><span>     return true;</span><br><span> }</span><br><span>diff --=
git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span=
>index c47e3d2..306f85cd 100644</span><br><span>--- a/src/openvpn/ssl_opens=
sl.c</span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -23=
53,13 +2353,13 @@</span><br><span>     }</span><br><span> </span><br><span>=
     int typeid =3D EVP_PKEY_id(pkey);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef OPENSSL_NO_EC</span><br><span> #if OPENSSL_VERSION_NUMBER &lt; 0x30=
000000L</span><br><span>     bool is_ec =3D typeid =3D=3D EVP_PKEY_EC;</spa=
n><br><span> #else</span><br><span>     bool is_ec =3D EVP_PKEY_is_a(pkey, =
&quot;EC&quot;);</span><br><span> #endif</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fndef OPENSSL_NO_EC</span><br><span>     char groupname[64];</span><br><spa=
n>     if (is_ec)</span><br><span>     {</span><br><span>@@ -2667,15 +2667,=
13 @@</span><br><span>            &quot;builtin EC curves. It does not list=
 additional curves nor X448 or X25519\n&quot;);</span><br><span> #ifndef OP=
ENSSL_NO_EC</span><br><span>     EC_builtin_curve *curves =3D NULL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t crv_len =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    size_t n =3D 0;</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crv_l=
en =3D EC_get_builtin_curves(NULL, 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    size_t crv_len =3D EC_get_builtin_curves(NULL, 0);</=
span><br><span>     ALLOC_ARRAY(curves, EC_builtin_curve, crv_len);</span><=
br><span>     if (EC_get_builtin_curves(curves, crv_len))</span><br><span> =
    {</span><br><span>         printf(&quot;\nAvailable Elliptic curves/gro=
ups:\n&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 for (n =3D 0; n &lt; crv_len; n++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        for (size_t n =3D 0; n &lt; crv_len; n++)</span><br=
><span>         {</span><br><span>             const char *sname;</span><br=
><span>             sname =3D OBJ_nid2sn(curves[n].nid);</span><br><span>di=
ff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><span>index =
b2a7331..5ee65fb 100644</span><br><span>--- a/src/openvpn/win32.c</span><br=
><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -1293,9 +1293,6 @@</spa=
n><br><span>     is_wow64_process2_t is_wow64_process2 =3D</span><br><span>=
         (is_wow64_process2_t)GetProcAddress(GetModuleHandle(&quot;Kernel32=
.dll&quot;), &quot;IsWow64Process2&quot;);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    USHORT process_machine =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    USHORT native_machin=
e =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #ifdef _ARM64_</span><br><span>     *process_arch =3D ARCH_ARM64;</spa=
n><br><span> #elif defined(_WIN64)</span><br><span>@@ -1303,6 +1300,8 @@</s=
pan><br><span>     if (is_wow64_process2)</span><br><span>     {</span><br>=
<span>         /* this could be amd64 on arm64 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        USHORT process_machine =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        USHORT native_machi=
ne =3D 0;</span><br><span>         BOOL is_wow64 =3D is_wow64_process2(GetC=
urrentProcess(), &amp;process_machine, &amp;native_machine);</span><br><spa=
n>         if (is_wow64 &amp;&amp; native_machine =3D=3D IMAGE_FILE_MACHINE=
_ARM64)</span><br><span>         {</span><br><span>@@ -1315,6 +1314,8 @@</s=
pan><br><span>     if (is_wow64_process2)</span><br><span>     {</span><br>=
<span>         /* check if we&#39;re running on arm64 or amd64 machine */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        USHORT proces=
s_machine =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     USHORT native_machine =3D 0;</span><br><span>         BOOL is_wow64 =
=3D is_wow64_process2(GetCurrentProcess(), &amp;process_machine, &amp;nativ=
e_machine);</span><br><span>         if (is_wow64)</span><br><span>        =
 {</span><br><span>diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openv=
pnmsica/openvpnmsica.c</span><br><span>index fdb610c..d698c04 100644</span>=
<br><span>--- a/src/openvpnmsica/openvpnmsica.c</span><br><span>+++ b/src/o=
penvpnmsica/openvpnmsica.c</span><br><span>@@ -711,7 +711,6 @@</span><br><s=
pan>         uiResult =3D MsiViewFetch(hViewST, &amp;hRecord);</span><br><s=
pan>         if (uiResult =3D=3D ERROR_NO_MORE_ITEMS)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            uiRe=
sult =3D ERROR_SUCCESS;</span><br><span>             break;</span><br><span=
>         }</span><br><span>         else if (uiResult !=3D ERROR_SUCCESS)<=
/span><br><span>diff --git a/src/tapctl/tap.c b/src/tapctl/tap.c</span><br>=
<span>index 16e3c0b..6ed395d 100644</span><br><span>--- a/src/tapctl/tap.c<=
/span><br><span>+++ b/src/tapctl/tap.c</span><br><span>@@ -473,7 +473,7 @@<=
/span><br><span>                         return ERROR_OUTOFMEMORY;</span><b=
r><span>                     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                    dwCountExpResult =3D ExpandE=
nvironmentStrings(szValue, szValueExp, dwCountExp);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    ExpandEnvironmentStri=
ngs(szValue, szValueExp, dwCountExp);</span><br><span>                     =
free(szValue);</span><br><span>                     *pszValue =3D szValueEx=
p;</span><br><span>                     return ERROR_SUCCESS;</span><br><sp=
an>@@ -601,8 +601,6 @@</span><br><span>                         _In_ DWORD =
dwProperty, _Out_opt_ LPDWORD pdwPropertyRegDataType,</span><br><span>     =
                    _Out_ LPVOID *ppData)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    DWORD dwResult =3D ERROR_BAD_ARG=
UMENTS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an>     if (ppData =3D=3D NULL)</span><br><span>     {</span><br><span>    =
     return ERROR_BAD_ARGUMENTS;</span><br><span>@@ -628,7 +626,7 @@</span>=
<br><span>     }</span><br><span>     else</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        dwResult =3D GetLastErr=
or();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD =
dwResult =3D GetLastError();</span><br><span>         if (dwResult =3D=3D E=
RROR_INSUFFICIENT_BUFFER)</span><br><span>         {</span><br><span>      =
       /* Allocate on heap and retry. */</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span>=
<br><span>index 0e9cecf..c40845a 100644</span><br><span>--- a/tests/unit_te=
sts/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
ssl.c</span><br><span>@@ -303,8 +303,6 @@</span><br><span>     struct buffe=
r work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>   =
  struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &a=
mp;gc);</span><br><span>     struct buffer decrypt_workspace =3D alloc_buf_=
gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    struct buffer buf =3D clear_buf();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;</span><br><span> </span><b=
r><span>     /* init work */</span><br><span>     ASSERT(buf_init(&amp;work=
, frame.buf.headroom));</span><br><span>@@ -325,8 +323,8 @@</span><br><span=
>         ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&amp;src)));</span><br><sp=
an> </span><br><span>         /* copy source to input buf */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        buf =3D work;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        buf_p =3D buf_write_alloc(&a=
mp;buf, BLENZ(&amp;src));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct buffer buf =3D work;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        void *buf_p =3D buf_write_alloc(&amp;buf, BLE=
NZ(&amp;src));</span><br><span>         ASSERT(buf_p);</span><br><span>    =
     memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span> </spa=
n><br><span>@@ -356,7 +354,6 @@</span><br><span>     struct buffer encrypt_=
workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>=
     struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame),=
 &amp;gc);</span><br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZ=
E(&amp;frame), &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    struct buffer buf =3D clear_buf();</span><br><span>     struct buffe=
r src =3D alloc_buf_gc(frame.buf.payload_size, &amp;gc);</span><br><span>  =
   void *buf_p;</span><br><span> </span><br><span>@@ -371,7 +368,7 @@</span=
><br><span>     ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&amp;src)));</span><=
br><span> </span><br><span>     /* copy source to input buf */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    buf =3D work;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D work;</spa=
n><br><span>     buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</spa=
n><br><span>     ASSERT(buf_p);</span><br><span>     memcpy(buf_p, BPTR(&am=
p;src), BLENZ(&amp;src));</span><br><span>@@ -652,7 +649,6 @@</span><br><sp=
an>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);=
</span><br><span>     struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_=
SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer decrypt_work=
space =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</sp=
an><br><span>     void *buf_p;</span><br><span> </span><br><span>     /* in=
it work */</span><br><span>@@ -669,7 +665,7 @@</span><br><span>     ASSERT(=
buf_write(&amp;src, plaintext, strlen(plaintext)));</span><br><span> </span=
><br><span>     /* copy source to input buf */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    buf =3D work;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer buf =3D work;</span><br><span>    =
 buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>    =
 ASSERT(buf_p);</span><br><span>     memcpy(buf_p, BPTR(&amp;src), BLENZ(&a=
mp;src));</span><br><span>diff --git a/tests/unit_tests/openvpnserv/test_op=
envpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c</span><br><sp=
an>index 45096a1..6a6aee4 100644</span><br><span>--- a/tests/unit_tests/ope=
nvpnserv/test_openvpnserv.c</span><br><span>+++ b/tests/unit_tests/openvpns=
erv/test_openvpnserv.c</span><br><span>@@ -57,13 +57,13 @@</span><br><span>=
 static void</span><br><span> test_convert_itf_dns_domains(void **state)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    D=
WORD size, orig_size, len, res_len;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    DWORD size, len, res_len;</span><br><span>     LSTATUS =
err;</span><br><span>     const DWORD glyph_size =3D sizeof(wchar_t);</span=
><br><span> </span><br><span>     wchar_t domains_1[BUF_SIZE] =3D L&quot;op=
envpn.com&quot;;</span><br><span>     len =3D (DWORD)wcslen(domains_1) + 1;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D orig_siz=
e =3D len * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    size =3D len * glyph_size;</span><br><span>     wchar_t domains_1_r=
es[BUF_SIZE] =3D L&quot;.openvpn.com&quot;;</span><br><span>     res_len =
=3D len + 2; /* adds . and \0 */</span><br><span>     err =3D ConvertItfDns=
Domains(L&quot;openvpn.net&quot;, domains_1, &amp;size, BUF_SIZE);</span><b=
r><span>@@ -73,7 +73,7 @@</span><br><span> </span><br><span>     wchar_t do=
mains_2[BUF_SIZE] =3D L&quot;openvpn.com,openvpn.net&quot;;</span><br><span=
>     len =3D (DWORD)wcslen(domains_2) + 1;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    size =3D orig_size =3D len * glyph_size;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_siz=
e;</span><br><span>     wchar_t domains_2_res[BUF_SIZE] =3D L&quot;.openvpn=
.com&quot;;</span><br><span>     res_len =3D (DWORD)wcslen(domains_2_res) +=
 2;</span><br><span>     err =3D ConvertItfDnsDomains(L&quot;openvpn.net&qu=
ot;, domains_2, &amp;size, BUF_SIZE);</span><br><span>@@ -83,7 +83,7 @@</sp=
an><br><span> </span><br><span>     wchar_t domains_3[BUF_SIZE] =3D L&quot;=
openvpn.com,openvpn.net&quot;;</span><br><span>     len =3D (DWORD)wcslen(d=
omains_3) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    siz=
e =3D orig_size =3D len * glyph_size;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    size =3D len * glyph_size;</span><br><span>     wchar=
_t domains_3_res[BUF_SIZE] =3D L&quot;.openvpn.net&quot;;</span><br><span> =
    res_len =3D (DWORD)wcslen(domains_3_res) + 2;</span><br><span>     err =
=3D ConvertItfDnsDomains(L&quot;openvpn.com&quot;, domains_3, &amp;size, BU=
F_SIZE);</span><br><span>@@ -93,7 +93,7 @@</span><br><span> </span><br><spa=
n>     wchar_t domains_4[BUF_SIZE] =3D L&quot;openvpn.com,openvpn.net&quot;=
;</span><br><span>     len =3D (DWORD)wcslen(domains_4) + 1;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    size =3D orig_size =3D len * gly=
ph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size =
=3D len * glyph_size;</span><br><span>     wchar_t domains_4_res[BUF_SIZE] =
=3D L&quot;.openvpn.com\0.openvpn.net&quot;;</span><br><span>     res_len =
=3D len + 3; /* adds two . and one \0 */</span><br><span>     err =3D Conve=
rtItfDnsDomains(NULL, domains_4, &amp;size, BUF_SIZE);</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1617?usp=3Demail">change 1617</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1617?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332=
f003b2d3393ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1617 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--jEQ1hmBv+3w=--

