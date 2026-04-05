From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 20:39:37 +0000
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f1bb40b9451bef89e74ec2bf875f4a9fda58fe0b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3/ZggpT5O2o="; charset=UTF-8
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

--3/ZggpT5O2o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1617?usp=3Demail

to review the following change.


Change subject: Remove various useless assignments
......................................................................

Remove various useless assignments

The values assigned by these are never actually used
for something.

Identified by cppcheck.

Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto.c
M src/openvpn/error.h
M src/openvpn/forward.c
M src/openvpn/manage.c
M src/openvpn/options.c
M src/openvpn/pkcs11_openssl.c
M src/openvpn/push_util.c
M src/openvpn/ssl_openssl.c
M src/openvpnmsica/openvpnmsica.c
M src/tapctl/tap.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/openvpnserv/test_openvpnserv.c
12 files changed, 22 insertions(+), 40 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/1617/1

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
index 62948aa..62389af 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -406,8 +406,8 @@
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
index d776908..31dcd4f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -912,10 +912,9 @@
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
@@ -3660,7 +3659,6 @@
     struct gc_arena gc =3D gc_new();
     int ret =3D 0;
     volatile int signal_received =3D 0;
-    struct buffer alert_msg =3D clear_buf();
     const bool standalone_disabled_save =3D man->persist.standalone_disabl=
ed;
     struct man_connection *mc =3D &man->connection;

@@ -3672,6 +3670,7 @@

         *state =3D EKS_SOLICIT;

+        struct buffer alert_msg;
         if (b64_data)
         {
             alert_msg =3D alloc_buf_gc(strlen(b64_data) + strlen(prompt) +=
 3, &gc);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 200e3cd..28275cc 100644
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
index e129403..2e5ac40 100644
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
index 234b0b6..44062c9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2602,15 +2602,13 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-Number: 1617
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--3/ZggpT5O2o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1617?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove various useless assignments<br><br>T=
he values assigned by these are never actually used<br>for something.<br><b=
r>Identified by cppcheck.<br><br>Change-Id: Id0caa497c4ff1ad8743cb23f332f00=
3b2d3393ed<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
---<br>M src/openvpn/crypto.c<br>M src/openvpn/error.h<br>M src/openvpn/for=
ward.c<br>M src/openvpn/manage.c<br>M src/openvpn/options.c<br>M src/openvp=
n/pkcs11_openssl.c<br>M src/openvpn/push_util.c<br>M src/openvpn/ssl_openss=
l.c<br>M src/openvpnmsica/openvpnmsica.c<br>M src/tapctl/tap.c<br>M tests/u=
nit_tests/openvpn/test_ssl.c<br>M tests/unit_tests/openvpnserv/test_openvpn=
serv.c<br>12 files changed, 22 insertions(+), 40 deletions(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
17/1617/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c<=
/span><br><span>index 7954e8a..df9b905 100644</span><br><span>--- a/src/ope=
nvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@=
 -1204,8 +1204,6 @@</span><br><span>     struct buffer work =3D alloc_buf_g=
c(BUF_SIZE(frame), &amp;gc);</span><br><span>     struct buffer encrypt_wor=
kspace =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</span><br><span>     str=
uct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(frame), &amp;gc);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =
=3D clear_buf();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    v=
oid *buf_p;</span><br><span> </span><br><span>     /* init work */</span><b=
r><span>     ASSERT(buf_init(&amp;work, frame-&gt;buf.headroom));</span><br=
><span>@@ -1242,8 +1240,8 @@</span><br><span>         ASSERT(rand_bytes(BPT=
R(&amp;src), BLEN(&amp;src)));</span><br><span> </span><br><span>         /=
* copy source to input buf */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        buf =3D work;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer buf=
 =3D work;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        v=
oid *buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>=
         ASSERT(buf_p);</span><br><span>         memcpy(buf_p, BPTR(&amp;sr=
c), BLENZ(&amp;src));</span><br><span> </span><br><span>diff --git a/src/op=
envpn/error.h b/src/openvpn/error.h</span><br><span>index 62948aa..62389af =
100644</span><br><span>--- a/src/openvpn/error.h</span><br><span>+++ b/src/=
openvpn/error.h</span><br><span>@@ -406,8 +406,8 @@</span><br><span> openvp=
n_errno_maybe_crt(bool *crt_error)</span><br><span> {</span><br><span>     =
int err =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *cr=
t_error =3D false;</span><br><span> #ifdef _WIN32</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    *crt_error =3D false;</span><br><span>   =
  err =3D GetLastError();</span><br><span>     if (err =3D=3D ERROR_SUCCESS=
)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/forward.c=
 b/src/openvpn/forward.c</span><br><span>index 27cfd36..53eab4d 100644</spa=
n><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/f=
orward.c</span><br><span>@@ -1746,7 +1746,6 @@</span><br><span> process_out=
going_link(struct context *c, struct link_socket *sock)</span><br><span> {<=
/span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int error_code =3D 0;</span><br><span> =
</span><br><span>     if (c-&gt;c2.to_link.len &gt; 0 &amp;&amp; c-&gt;c2.t=
o_link.len &lt;=3D c-&gt;c2.frame.buf.payload_size)</span><br><span>     {<=
/span><br><span>@@ -1821,7 +1820,7 @@</span><br><span>         }</span><br>=
<span> </span><br><span>         /* Check return status */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        error_code =3D openvpn_errno()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int error_=
code =3D openvpn_errno();</span><br><span>         check_status(size, &quot=
;write&quot;, sock, NULL);</span><br><span> </span><br><span>         if (s=
ize &gt; 0)</span><br><span>diff --git a/src/openvpn/manage.c b/src/openvpn=
/manage.c</span><br><span>index d776908..31dcd4f 100644</span><br><span>---=
 a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><b=
r><span>@@ -912,10 +912,9 @@</span><br><span> static void</span><br><span> =
man_remote_entry_count(struct management *man)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned count =3D 0;</span=
><br><span>     if (man-&gt;persist.callback.remote_entry_count)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
ount =3D (*man-&gt;persist.callback.remote_entry_count)(man-&gt;persist.cal=
lback.arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
unsigned int count =3D (*man-&gt;persist.callback.remote_entry_count)(man-&=
gt;persist.callback.arg);</span><br><span>         msg(M_CLIENT, &quot;%u&q=
uot;, count);</span><br><span>         msg(M_CLIENT, &quot;END&quot;);</spa=
n><br><span>     }</span><br><span>@@ -3660,7 +3659,6 @@</span><br><span>  =
   struct gc_arena gc =3D gc_new();</span><br><span>     int ret =3D 0;</sp=
an><br><span>     volatile int signal_received =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct buffer alert_msg =3D clear_buf()=
;</span><br><span>     const bool standalone_disabled_save =3D man-&gt;pers=
ist.standalone_disabled;</span><br><span>     struct man_connection *mc =3D=
 &amp;man-&gt;connection;</span><br><span> </span><br><span>@@ -3672,6 +367=
0,7 @@</span><br><span> </span><br><span>         *state =3D EKS_SOLICIT;</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     struct buffer alert_msg;</span><br><span>         if (b64_data)</span>=
<br><span>         {</span><br><span>             alert_msg =3D alloc_buf_g=
c(strlen(b64_data) + strlen(prompt) + 3, &amp;gc);</span><br><span>diff --g=
it a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 20=
0e3cd..28275cc 100644</span><br><span>--- a/src/openvpn/options.c</span><br=
><span>+++ b/src/openvpn/options.c</span><br><span>@@ -7091,7 +7091,6 @@</s=
pan><br><span>             if (streq(p[1], &quot;FORWARD_COMPATIBLE&quot;) =
&amp;&amp; p[2] &amp;&amp; streq(p[2], &quot;1&quot;))</span><br><span>    =
         {</span><br><span>                 options-&gt;forward_compatible =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    msglevel_fc =3D msglevel_forward_compatible(options, msglevel);</span><=
br><span>             }</span><br><span>             setenv_str(es, p[1], p=
[2] ? p[2] : &quot;&quot;);</span><br><span>         }</span><br><span>diff=
 --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c</span>=
<br><span>index b6c1624..69c5a50 100644</span><br><span>--- a/src/openvpn/p=
kcs11_openssl.c</span><br><span>+++ b/src/openvpn/pkcs11_openssl.c</span><b=
r><span>@@ -384,7 +384,6 @@</span><br><span>     if (certificate !=3D NULL)=
</span><br><span>     {</span><br><span>         pkcs11h_certificate_freeCe=
rtificate(certificate);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        certificate =3D NULL;</span><br><span>     }</span><br><span> </s=
pan><br><span>     /*</span><br><span>@@ -400,7 +399,6 @@</span><br><span> =
    if (openssl_session !=3D NULL)</span><br><span>     {</span><br><span> =
        pkcs11h_openssl_freeSession(openssl_session);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        openssl_session =3D NULL;</span><br=
><span>     }</span><br><span>     return ret;</span><br><span> #endif     =
                                                     /* ifdef HAVE_XKEY_PRO=
VIDER */</span><br><span>diff --git a/src/openvpn/push_util.c b/src/openvpn=
/push_util.c</span><br><span>index e129403..2e5ac40 100644</span><br><span>=
--- a/src/openvpn/push_util.c</span><br><span>+++ b/src/openvpn/push_util.c=
</span><br><span>@@ -99,7 +99,6 @@</span><br><span>     }</span><br><span> =
</span><br><span>     char *str =3D gc_strdup(s, gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    size_t i =3D 0;</span><br><span> </span=
><br><span>     while (*str)</span><br><span>     {</span><br><span>@@ -112=
,11 +111,11 @@</span><br><span>                 /* if no commas were found =
go to fail, do not send any message */</span><br><span>                 ret=
urn false;</span><br><span>             }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            /* copy from current position to (ci - 1)=
 */</span><br><span>             str[ci] =3D &#39;\0&#39;;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            /* copy from i to (ci -1) =
*/</span><br><span>             struct buffer tmp =3D forge_msg(str, &quot;=
,push-continuation 2&quot;, gc);</span><br><span>             buffer_list_p=
ush(msgs, BSTR(&amp;tmp));</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            i =3D ci + 1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            str +=3D ci + 1;</span><br><span>         }</span><b=
r><span>         else</span><br><span>         {</span><br><span>@@ -130,9 =
+129,8 @@</span><br><span>                 struct buffer tmp =3D forge_msg(=
str, NULL, gc);</span><br><span>                 buffer_list_push(msgs, BST=
R(&amp;tmp));</span><br><span>             }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            i =3D strlen(str);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span>      =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        str =3D &=
amp;str[i];</span><br><span>     }</span><br><span>     return true;</span>=
<br><span> }</span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/o=
penvpn/ssl_openssl.c</span><br><span>index 234b0b6..44062c9 100644</span><b=
r><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/s=
sl_openssl.c</span><br><span>@@ -2602,15 +2602,13 @@</span><br><span>      =
      &quot;builtin EC curves. It does not list additional curves nor X448 =
or X25519\n&quot;);</span><br><span> #ifndef OPENSSL_NO_EC</span><br><span>=
     EC_builtin_curve *curves =3D NULL;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    size_t crv_len =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    size_t n =3D 0;</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    crv_len =3D EC_get_builtin_curves=
(NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_=
t crv_len =3D EC_get_builtin_curves(NULL, 0);</span><br><span>     ALLOC_AR=
RAY(curves, EC_builtin_curve, crv_len);</span><br><span>     if (EC_get_bui=
ltin_curves(curves, crv_len))</span><br><span>     {</span><br><span>      =
   printf(&quot;\nAvailable Elliptic curves/groups:\n&quot;);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        for (n =3D 0; n &lt; crv_le=
n; n++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for =
(size_t n =3D 0; n &lt; crv_len; n++)</span><br><span>         {</span><br>=
<span>             const char *sname;</span><br><span>             sname =
=3D OBJ_nid2sn(curves[n].nid);</span><br><span>diff --git a/src/openvpnmsic=
a/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c</span><br><span>index fd=
b610c..d698c04 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.c=
</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.c</span><br><span>@@ -=
711,7 +711,6 @@</span><br><span>         uiResult =3D MsiViewFetch(hViewST,=
 &amp;hRecord);</span><br><span>         if (uiResult =3D=3D ERROR_NO_MORE_=
ITEMS)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            uiResult =3D ERROR_SUCCESS;</span><br><span>       =
      break;</span><br><span>         }</span><br><span>         else if (u=
iResult !=3D ERROR_SUCCESS)</span><br><span>diff --git a/src/tapctl/tap.c b=
/src/tapctl/tap.c</span><br><span>index 16e3c0b..6ed395d 100644</span><br><=
span>--- a/src/tapctl/tap.c</span><br><span>+++ b/src/tapctl/tap.c</span><b=
r><span>@@ -473,7 +473,7 @@</span><br><span>                         return=
 ERROR_OUTOFMEMORY;</span><br><span>                     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
dwCountExpResult =3D ExpandEnvironmentStrings(szValue, szValueExp, dwCountE=
xp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     ExpandEnvironmentStrings(szValue, szValueExp, dwCountExp);</span><br><=
span>                     free(szValue);</span><br><span>                  =
   *pszValue =3D szValueExp;</span><br><span>                     return ER=
ROR_SUCCESS;</span><br><span>@@ -601,8 +601,6 @@</span><br><span>          =
               _In_ DWORD dwProperty, _Out_opt_ LPDWORD pdwPropertyRegDataT=
ype,</span><br><span>                         _Out_ LPVOID *ppData)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DWORD =
dwResult =3D ERROR_BAD_ARGUMENTS;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     if (ppData =3D=3D NULL)</span><br><span> =
    {</span><br><span>         return ERROR_BAD_ARGUMENTS;</span><br><span>=
@@ -628,7 +626,7 @@</span><br><span>     }</span><br><span>     else</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   dwResult =3D GetLastError();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        DWORD dwResult =3D GetLastError();</span><br><span>    =
     if (dwResult =3D=3D ERROR_INSUFFICIENT_BUFFER)</span><br><span>       =
  {</span><br><span>             /* Allocate on heap and retry. */</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests=
/openvpn/test_ssl.c</span><br><span>index 0e9cecf..c40845a 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/test=
s/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -303,8 +303,6 @@</span><=
br><span>     struct buffer work =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &am=
p;gc);</span><br><span>     struct buffer encrypt_workspace =3D alloc_buf_g=
c(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer decryp=
t_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf(=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    void *buf_p;</s=
pan><br><span> </span><br><span>     /* init work */</span><br><span>     A=
SSERT(buf_init(&amp;work, frame.buf.headroom));</span><br><span>@@ -325,8 +=
323,8 @@</span><br><span>         ASSERT(rand_bytes(BPTR(&amp;src), BLEN(&a=
mp;src)));</span><br><span> </span><br><span>         /* copy source to inp=
ut buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf =
=3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_=
p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer buf =3D work;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        void *buf_p =3D buf_w=
rite_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT(buf_=
p);</span><br><span>         memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src))=
;</span><br><span> </span><br><span>@@ -356,7 +354,6 @@</span><br><span>   =
  struct buffer encrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &a=
mp;gc);</span><br><span>     struct buffer decrypt_workspace =3D alloc_buf_=
gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer work =
=3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    struct buffer buf =3D clear_buf();</span><br=
><span>     struct buffer src =3D alloc_buf_gc(frame.buf.payload_size, &amp=
;gc);</span><br><span>     void *buf_p;</span><br><span> </span><br><span>@=
@ -371,7 +368,7 @@</span><br><span>     ASSERT(rand_bytes(BPTR(&amp;src), B=
LEN(&amp;src)));</span><br><span> </span><br><span>     /* copy source to i=
nput buf */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =
=3D work;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D work;</span><br><span>     buf_p =3D buf_write_alloc(&amp;b=
uf, BLENZ(&amp;src));</span><br><span>     ASSERT(buf_p);</span><br><span> =
    memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span>@@ -652=
,7 +649,6 @@</span><br><span>     struct buffer work =3D alloc_buf_gc(BUF_S=
IZE(&amp;frame), &amp;gc);</span><br><span>     struct buffer encrypt_works=
pace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp;gc);</span><br><span>     =
struct buffer decrypt_workspace =3D alloc_buf_gc(BUF_SIZE(&amp;frame), &amp=
;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffe=
r buf =3D clear_buf();</span><br><span>     void *buf_p;</span><br><span> <=
/span><br><span>     /* init work */</span><br><span>@@ -669,7 +665,7 @@</s=
pan><br><span>     ASSERT(buf_write(&amp;src, plaintext, strlen(plaintext))=
);</span><br><span> </span><br><span>     /* copy source to input buf */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf =3D work;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D =
work;</span><br><span>     buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;s=
rc));</span><br><span>     ASSERT(buf_p);</span><br><span>     memcpy(buf_p=
, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span>diff --git a/tests/unit=
_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_o=
penvpnserv.c</span><br><span>index 45096a1..6a6aee4 100644</span><br><span>=
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c</span><br><span>+++ b=
/tests/unit_tests/openvpnserv/test_openvpnserv.c</span><br><span>@@ -57,13 =
+57,13 @@</span><br><span> static void</span><br><span> test_convert_itf_dn=
s_domains(void **state)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    DWORD size, orig_size, len, res_len;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    DWORD size, len, res_len;</sp=
an><br><span>     LSTATUS err;</span><br><span>     const DWORD glyph_size =
=3D sizeof(wchar_t);</span><br><span> </span><br><span>     wchar_t domains=
_1[BUF_SIZE] =3D L&quot;openvpn.com&quot;;</span><br><span>     len =3D (DW=
ORD)wcslen(domains_1) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    size =3D orig_size =3D len * glyph_size;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</span><br><spa=
n>     wchar_t domains_1_res[BUF_SIZE] =3D L&quot;.openvpn.com&quot;;</span=
><br><span>     res_len =3D len + 2; /* adds . and \0 */</span><br><span>  =
   err =3D ConvertItfDnsDomains(L&quot;openvpn.net&quot;, domains_1, &amp;s=
ize, BUF_SIZE);</span><br><span>@@ -73,7 +73,7 @@</span><br><span> </span><=
br><span>     wchar_t domains_2[BUF_SIZE] =3D L&quot;openvpn.com,openvpn.ne=
t&quot;;</span><br><span>     len =3D (DWORD)wcslen(domains_2) + 1;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D orig_size =3D le=
n * glyph_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
size =3D len * glyph_size;</span><br><span>     wchar_t domains_2_res[BUF_S=
IZE] =3D L&quot;.openvpn.com&quot;;</span><br><span>     res_len =3D (DWORD=
)wcslen(domains_2_res) + 2;</span><br><span>     err =3D ConvertItfDnsDomai=
ns(L&quot;openvpn.net&quot;, domains_2, &amp;size, BUF_SIZE);</span><br><sp=
an>@@ -83,7 +83,7 @@</span><br><span> </span><br><span>     wchar_t domains=
_3[BUF_SIZE] =3D L&quot;openvpn.com,openvpn.net&quot;;</span><br><span>    =
 len =3D (DWORD)wcslen(domains_3) + 1;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    size =3D orig_size =3D len * glyph_size;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    size =3D len * glyph_size;</s=
pan><br><span>     wchar_t domains_3_res[BUF_SIZE] =3D L&quot;.openvpn.net&=
quot;;</span><br><span>     res_len =3D (DWORD)wcslen(domains_3_res) + 2;</=
span><br><span>     err =3D ConvertItfDnsDomains(L&quot;openvpn.com&quot;, =
domains_3, &amp;size, BUF_SIZE);</span><br><span>@@ -93,7 +93,7 @@</span><b=
r><span> </span><br><span>     wchar_t domains_4[BUF_SIZE] =3D L&quot;openv=
pn.com,openvpn.net&quot;;</span><br><span>     len =3D (DWORD)wcslen(domain=
s_4) + 1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    size =3D=
 orig_size =3D len * glyph_size;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    size =3D len * glyph_size;</span><br><span>     wchar_t do=
mains_4_res[BUF_SIZE] =3D L&quot;.openvpn.com\0.openvpn.net&quot;;</span><b=
r><span>     res_len =3D len + 3; /* adds two . and one \0 */</span><br><sp=
an>     err =3D ConvertItfDnsDomains(NULL, domains_4, &amp;size, BUF_SIZE);=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1617?usp=3Demail">change 1617</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1617?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332=
f003b2d3393ed </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1617 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--3/ZggpT5O2o=--

