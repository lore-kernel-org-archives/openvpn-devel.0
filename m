From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 20:39:36 +0000
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <37107a1dff61bcf3be69a3b816ea37a7c0e63832-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/f7wHcrKxKs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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

--/f7wHcrKxKs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1618?usp=3Demail

to review the following change.


Change subject: Rename variables that shadow other variables or functions
......................................................................

Rename variables that shadow other variables or functions

Identified by cppcheck.

Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/manage.c
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/tls_crypt.c
M src/openvpnserv/interactive.c
M tests/unit_tests/openvpn/test_push_update_msg.c
6 files changed, 42 insertions(+), 45 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1618/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 31dcd4f..9efc08f 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1254,8 +1254,6 @@
 static void
 man_load_stats(struct management *man)
 {
-    extern counter_type link_read_bytes_global;
-    extern counter_type link_write_bytes_global;
     int nclients =3D 0;

     if (man->persist.callback.n_clients)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 28275cc..186b2d2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2689,12 +2689,12 @@
                     "may accept clients which do not present a certificate=
");
     }

-    const unsigned int tls_version_max =3D
+    const unsigned int tls_ver_max =3D
         (options->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT) & SSLF_TLS_VERS=
ION_MAX_MASK;
-    const unsigned int tls_version_min =3D
+    const unsigned int tls_ver_min =3D
         (options->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT) & SSLF_TLS_VERS=
ION_MIN_MASK;

-    if (tls_version_max > 0 && tls_version_max < tls_version_min)
+    if (tls_ver_max > 0 && tls_ver_max < tls_ver_min)
     {
         msg(M_USAGE, "--tls-version-min bigger than --tls-version-max");
     }
@@ -3641,16 +3641,16 @@
         {
             struct dns_domain **entry =3D &dns->search_domains;
             ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
-            struct dns_domain *new =3D *entry;
-            new->name =3D dhcp->domain;
-            entry =3D &new->next;
+            struct dns_domain *domain =3D *entry;
+            domain->name =3D dhcp->domain;
+            entry =3D &domain->next;

             for (unsigned int i =3D 0; i < dhcp->domain_search_list_len; +=
+i)
             {
                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
-                struct dns_domain *new =3D *entry;
-                new->name =3D dhcp->domain_search_list[i];
-                entry =3D &new->next;
+                struct dns_domain *search_domain =3D *entry;
+                search_domain->name =3D dhcp->domain_search_list[i];
+                entry =3D &search_domain->next;
             }

             struct dns_server *server =3D dns_server_get(&dns->servers, 0,=
 &dns->gc);
@@ -3743,7 +3743,6 @@
 static void
 options_postprocess_mutate(struct options *o, struct env_set *es)
 {
-    int i;
     /*
      * Process helper-type options which map to other, more complex
      * sequences of options.
@@ -3776,7 +3775,7 @@
          * Convert remotes into connection list
          */
         const struct remote_list *rl =3D o->remote_list;
-        for (i =3D 0; i < rl->len; ++i)
+        for (int i =3D 0; i < rl->len; ++i)
         {
             const struct remote_entry *re =3D rl->array[i];
             struct connection_entry ce =3D o->ce;
@@ -3798,14 +3797,14 @@
     }

     ASSERT(o->connection_list);
-    for (i =3D 0; i < o->connection_list->len; ++i)
+    for (int i =3D 0; i < o->connection_list->len; ++i)
     {
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
     }

     if (o->ce.local_list)
     {
-        for (i =3D 0; i < o->ce.local_list->len; i++)
+        for (int i =3D 0; i < o->ce.local_list->len; i++)
         {
             options_postprocess_mutate_le(&o->ce, o->ce.local_list->array[=
i], o->mode);
         }
@@ -3833,7 +3832,7 @@
     }

     /* use the same listen list for every outgoing connection */
-    for (i =3D 0; i < o->connection_list->len; ++i)
+    for (int i =3D 0; i < o->connection_list->len; ++i)
     {
         o->connection_list->array[i]->local_list =3D o->ce.local_list;
     }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 564ce86..ae0f0e2 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -994,10 +994,10 @@
     else if (tls_authentication_status(c->c2.tls_multi) =3D=3D TLS_AUTHENT=
ICATION_SUCCEEDED
              && c->c2.tls_multi->multi_state >=3D CAS_CONNECT_DONE)
     {
-        time_t now;
+        time_t local_now;

-        openvpn_time(&now);
-        if (c->c2.sent_push_reply_expiry > now)
+        openvpn_time(&local_now);
+        if (c->c2.sent_push_reply_expiry > local_now)
         {
             ret =3D PUSH_MSG_ALREADY_REPLIED;
         }
@@ -1011,7 +1011,7 @@
             if (send_push_reply(c, &push_list))
             {
                 ret =3D PUSH_MSG_REQUEST;
-                c->c2.sent_push_reply_expiry =3D now + 30;
+                c->c2.sent_push_reply_expiry =3D local_now + 30;
             }
             gc_free(&gc);
         }
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 70889dc..c25986f 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -769,24 +769,24 @@
     }

     /* Sanity check: load client key (as "client") */
-    struct key_ctx_bi test_client_key;
-    struct buffer test_wrapped_client_key;
+    struct key_ctx_bi check_client_key;
+    struct buffer check_wrapped_client_key;
     struct key2 keydata;
     msg(D_GENKEY, "Testing client-side key loading...");
-    tls_crypt_v2_init_client_key(&test_client_key, &keydata, &test_wrapped=
_client_key, client_file,
+    tls_crypt_v2_init_client_key(&check_client_key, &keydata, &check_wrapp=
ed_client_key, client_file,
                                  client_inline);
-    free_key_ctx_bi(&test_client_key);
+    free_key_ctx_bi(&check_client_key);

     /* Sanity check: unwrap and load client key (as "server") */
-    struct buffer test_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA=
_LEN, &gc);
-    struct key2 test_client_key2 =3D { 0 };
+    struct buffer check_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADAT=
A_LEN, &gc);
+    struct key2 check_client_key2 =3D { 0 };
     free_key_ctx(&server_key);
     tls_crypt_v2_init_server_key(&server_key, false, server_key_file, serv=
er_key_inline);
     msg(D_GENKEY, "Testing server-side key loading...");
-    ASSERT(tls_crypt_v2_unwrap_client_key(&test_client_key2, &test_metadat=
a,
-                                          test_wrapped_client_key, &server=
_key));
-    secure_memzero(&test_client_key2, sizeof(test_client_key2));
-    free_buf(&test_wrapped_client_key);
+    ASSERT(tls_crypt_v2_unwrap_client_key(&check_client_key2, &check_metad=
ata,
+                                          check_wrapped_client_key, &serve=
r_key));
+    secure_memzero(&check_client_key2, sizeof(check_client_key2));
+    free_buf(&check_wrapped_client_key);

 cleanup:
     secure_memzero(&client_key, sizeof(client_key));
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 322461e..a2f9f09 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -540,19 +540,19 @@
 static DWORD
 InterfaceLuid(const char *iface_name, PNET_LUID luid)
 {
-    NETIO_STATUS status;
+    NETIO_STATUS convert_status;
     LPWSTR wide_name =3D utf8to16(iface_name);

     if (wide_name)
     {
-        status =3D ConvertInterfaceAliasToLuid(wide_name, luid);
+        convert_status =3D ConvertInterfaceAliasToLuid(wide_name, luid);
         free(wide_name);
     }
     else
     {
-        status =3D ERROR_OUTOFMEMORY;
+        convert_status =3D ERROR_OUTOFMEMORY;
     }
-    return status;
+    return convert_status;
 }

 static BOOL
@@ -1174,8 +1174,8 @@
         goto out;
     }

-    SERVICE_STATUS status;
-    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &status) =3D=
=3D 0)
+    SERVICE_STATUS control_status;
+    if (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &control_statu=
s) =3D=3D 0)
     {
         MsgToEventLog(M_ERR, L"%S: ControlService call failed (%lu)", __fu=
nc__, GetLastError());
         goto out;
@@ -3644,12 +3644,12 @@
 static DWORD WINAPI
 ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID c=
tx)
 {
-    SERVICE_STATUS *status =3D ctx;
+    SERVICE_STATUS *svc_status =3D ctx;
     switch (ctrl_code)
     {
         case SERVICE_CONTROL_STOP:
-            status->dwCurrentState =3D SERVICE_STOP_PENDING;
-            ReportStatusToSCMgr(service, status);
+            svc_status->dwCurrentState =3D SERVICE_STOP_PENDING;
+            ReportStatusToSCMgr(service, svc_status);
             if (exit_event)
             {
                 SetEvent(exit_event);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 219b476..eb5b22c 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -350,8 +350,8 @@

     /* Message 1: first batch of routes, continuation 2 (more coming) */
     struct buffer buf1 =3D alloc_buf(512);
-    const char *msg1 =3D "PUSH_UPDATE, route 10.1.0.0 255.255.0.0, route 1=
0.2.0.0 255.255.0.0, route 10.3.0.0 255.255.0.0,push-continuation 2";
-    buf_write(&buf1, msg1, strlen(msg1));
+    const char *cmsg1 =3D "PUSH_UPDATE, route 10.1.0.0 255.255.0.0, route =
10.2.0.0 255.255.0.0, route 10.3.0.0 255.255.0.0,push-continuation 2";
+    buf_write(&buf1, cmsg1, strlen(cmsg1));

     assert_int_equal(process_incoming_push_msg(c, &buf1, c->options.pull, =
pull_permission_mask(c),
                                                &option_types_found),
@@ -360,8 +360,8 @@

     /* Message 2: more routes, continuation 2 (more coming) */
     struct buffer buf2 =3D alloc_buf(512);
-    const char *msg2 =3D "PUSH_UPDATE, route 10.4.0.0 255.255.0.0, route 1=
0.5.0.0 255.255.0.0, route 10.6.0.0 255.255.0.0,push-continuation 2";
-    buf_write(&buf2, msg2, strlen(msg2));
+    const char *cmsg2 =3D "PUSH_UPDATE, route 10.4.0.0 255.255.0.0, route =
10.5.0.0 255.255.0.0, route 10.6.0.0 255.255.0.0,push-continuation 2";
+    buf_write(&buf2, cmsg2, strlen(cmsg2));

     assert_int_equal(process_incoming_push_msg(c, &buf2, c->options.pull, =
pull_permission_mask(c),
                                                &option_types_found),
@@ -370,8 +370,8 @@

     /* Message 3: final batch of routes, continuation 1 (last message) */
     struct buffer buf3 =3D alloc_buf(512);
-    const char *msg3 =3D "PUSH_UPDATE, route 10.7.0.0 255.255.0.0, route 1=
0.8.0.0 255.255.0.0, route 10.9.0.0 255.255.0.0,push-continuation 1";
-    buf_write(&buf3, msg3, strlen(msg3));
+    const char *cmsg3 =3D "PUSH_UPDATE, route 10.7.0.0 255.255.0.0, route =
10.8.0.0 255.255.0.0, route 10.9.0.0 255.255.0.0,push-continuation 1";
+    buf_write(&buf3, cmsg3, strlen(cmsg3));

     assert_int_equal(process_incoming_push_msg(c, &buf3, c->options.pull, =
pull_permission_mask(c),
                                                &option_types_found),

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1618?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Gerrit-Change-Number: 1618
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--/f7wHcrKxKs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1618?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Rename variables that shadow other variable=
s or functions<br><br>Identified by cppcheck.<br><br>Change-Id: I528f5fd200=
d877841e473e5e05b7ac7915fa2e33<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M src/openvpn/manage.c<br>M src/openvpn/options.=
c<br>M src/openvpn/push.c<br>M src/openvpn/tls_crypt.c<br>M src/openvpnserv=
/interactive.c<br>M tests/unit_tests/openvpn/test_push_update_msg.c<br>6 fi=
les changed, 42 insertions(+), 45 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1618/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index 31dcd4f..9efc08f 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -1254,8 +1254,=
6 @@</span><br><span> static void</span><br><span> man_load_stats(struct ma=
nagement *man)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    extern counter_type link_read_bytes_global;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    extern counter_type link_write_by=
tes_global;</span><br><span>     int nclients =3D 0;</span><br><span> </spa=
n><br><span>     if (man-&gt;persist.callback.n_clients)</span><br><span>di=
ff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>in=
dex 28275cc..186b2d2 100644</span><br><span>--- a/src/openvpn/options.c</sp=
an><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -2689,12 +2689,=
12 @@</span><br><span>                     &quot;may accept clients which d=
o not present a certificate&quot;);</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned i=
nt tls_version_max =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const unsigned int tls_ver_max =3D</span><br><span>         (options=
-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT) &amp; SSLF_TLS_VERSION_=
MAX_MASK;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const un=
signed int tls_version_min =3D</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const unsigned int tls_ver_min =3D</span><br><span>         =
(options-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT) &amp; SSLF_TLS_=
VERSION_MIN_MASK;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (tls_version_max &gt; 0 &amp;&amp; tls_version_max &lt=
; tls_version_min)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (tls_ver_max &gt; 0 &amp;&amp; tls_ver_max &lt; tls_ver_min)</span><b=
r><span>     {</span><br><span>         msg(M_USAGE, &quot;--tls-version-mi=
n bigger than --tls-version-max&quot;);</span><br><span>     }</span><br><s=
pan>@@ -3641,16 +3641,16 @@</span><br><span>         {</span><br><span>    =
         struct dns_domain **entry =3D &amp;dns-&gt;search_domains;</span><=
br><span>             ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &amp;dn=
s-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 struct dns_domain *new =3D *entry;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            new-&gt;name =3D dhcp-&gt;domain;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            entry =3D &amp;new-&gt;ne=
xt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            stru=
ct dns_domain *domain =3D *entry;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            domain-&gt;name =3D dhcp-&gt;domain;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            entry =3D &amp;domai=
n-&gt;next;</span><br><span> </span><br><span>             for (unsigned in=
t i =3D 0; i &lt; dhcp-&gt;domain_search_list_len; ++i)</span><br><span>   =
          {</span><br><span>                 ALLOC_OBJ_CLEAR_GC(*entry, str=
uct dns_domain, &amp;dns-&gt;gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                struct dns_domain *new =3D *entry;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                new-&gt;name =3D d=
hcp-&gt;domain_search_list[i];</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                entry =3D &amp;new-&gt;next;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                struct dns_domain *search=
_domain =3D *entry;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                search_domain-&gt;name =3D dhcp-&gt;domain_search_list[i];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                entr=
y =3D &amp;search_domain-&gt;next;</span><br><span>             }</span><br=
><span> </span><br><span>             struct dns_server *server =3D dns_ser=
ver_get(&amp;dns-&gt;servers, 0, &amp;dns-&gt;gc);</span><br><span>@@ -3743=
,7 +3743,6 @@</span><br><span> static void</span><br><span> options_postpro=
cess_mutate(struct options *o, struct env_set *es)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span>=
     /*</span><br><span>      * Process helper-type options which map to ot=
her, more complex</span><br><span>      * sequences of options.</span><br><=
span>@@ -3776,7 +3775,7 @@</span><br><span>          * Convert remotes into=
 connection list</span><br><span>          */</span><br><span>         cons=
t struct remote_list *rl =3D o-&gt;remote_list;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; rl-&gt;len; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D =
0; i &lt; rl-&gt;len; ++i)</span><br><span>         {</span><br><span>     =
        const struct remote_entry *re =3D rl-&gt;array[i];</span><br><span>=
             struct connection_entry ce =3D o-&gt;ce;</span><br><span>@@ -3=
798,14 +3797,14 @@</span><br><span>     }</span><br><span> </span><br><span=
>     ASSERT(o-&gt;connection_list);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span><br><span>     {</span>=
<br><span>         options_postprocess_mutate_ce(o, o-&gt;connection_list-&=
gt;array[i]);</span><br><span>     }</span><br><span> </span><br><span>    =
 if (o-&gt;ce.local_list)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; o-&gt;ce.local_list=
-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   for (int i =3D 0; i &lt; o-&gt;ce.local_list-&gt;len; i++)</span><br><sp=
an>         {</span><br><span>             options_postprocess_mutate_le(&a=
mp;o-&gt;ce, o-&gt;ce.local_list-&gt;array[i], o-&gt;mode);</span><br><span=
>         }</span><br><span>@@ -3833,7 +3832,7 @@</span><br><span>     }</s=
pan><br><span> </span><br><span>     /* use the same listen list for every =
outgoing connection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    for (i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; o-&g=
t;connection_list-&gt;len; ++i)</span><br><span>     {</span><br><span>    =
     o-&gt;connection_list-&gt;array[i]-&gt;local_list =3D o-&gt;ce.local_l=
ist;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/push.c=
 b/src/openvpn/push.c</span><br><span>index 564ce86..ae0f0e2 100644</span><=
br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c<=
/span><br><span>@@ -994,10 +994,10 @@</span><br><span>     else if (tls_aut=
hentication_status(c-&gt;c2.tls_multi) =3D=3D TLS_AUTHENTICATION_SUCCEEDED<=
/span><br><span>              &amp;&amp; c-&gt;c2.tls_multi-&gt;multi_state=
 &gt;=3D CAS_CONNECT_DONE)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        time_t now;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        time_t local_now;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_time(&amp=
;now);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c-&=
gt;c2.sent_push_reply_expiry &gt; now)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        openvpn_time(&amp;local_now);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2.sent_push_reply_e=
xpiry &gt; local_now)</span><br><span>         {</span><br><span>          =
   ret =3D PUSH_MSG_ALREADY_REPLIED;</span><br><span>         }</span><br><=
span>@@ -1011,7 +1011,7 @@</span><br><span>             if (send_push_reply=
(c, &amp;push_list))</span><br><span>             {</span><br><span>       =
          ret =3D PUSH_MSG_REQUEST;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                c-&gt;c2.sent_push_reply_expiry =3D now + 30;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                c-&=
gt;c2.sent_push_reply_expiry =3D local_now + 30;</span><br><span>          =
   }</span><br><span>             gc_free(&amp;gc);</span><br><span>       =
  }</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_=
crypt.c</span><br><span>index 70889dc..c25986f 100644</span><br><span>--- a=
/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</spa=
n><br><span>@@ -769,24 +769,24 @@</span><br><span>     }</span><br><span> <=
/span><br><span>     /* Sanity check: load client key (as &quot;client&quot=
;) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct key_c=
tx_bi test_client_key;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    struct buffer test_wrapped_client_key;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct key_ctx_bi check_client_key;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer check_wrapped=
_client_key;</span><br><span>     struct key2 keydata;</span><br><span>    =
 msg(D_GENKEY, &quot;Testing client-side key loading...&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    tls_crypt_v2_init_client_key(=
&amp;test_client_key, &amp;keydata, &amp;test_wrapped_client_key, client_fi=
le,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_crypt_v2=
_init_client_key(&amp;check_client_key, &amp;keydata, &amp;check_wrapped_cl=
ient_key, client_file,</span><br><span>                                  cl=
ient_inline);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    free=
_key_ctx_bi(&amp;test_client_key);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free_key_ctx_bi(&amp;check_client_key);</span><br><span>=
 </span><br><span>     /* Sanity check: unwrap and load client key (as &quo=
t;server&quot;) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 struct buffer test_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN=
, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct=
 key2 test_client_key2 =3D { 0 };</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct buffer check_metadata =3D alloc_buf_gc(TLS_CRYPT_V=
2_MAX_METADATA_LEN, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct key2 check_client_key2 =3D { 0 };</span><br><span>    =
 free_key_ctx(&amp;server_key);</span><br><span>     tls_crypt_v2_init_serv=
er_key(&amp;server_key, false, server_key_file, server_key_inline);</span><=
br><span>     msg(D_GENKEY, &quot;Testing server-side key loading...&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(tls_crypt=
_v2_unwrap_client_key(&amp;test_client_key2, &amp;test_metadata,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
          test_wrapped_client_key, &amp;server_key));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    secure_memzero(&amp;test_client_key2, s=
izeof(test_client_key2));</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    free_buf(&amp;test_wrapped_client_key);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(tls_crypt_v2_unwrap_client_key(&amp;=
check_client_key2, &amp;check_metadata,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                          check_wrapped=
_client_key, &amp;server_key));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    secure_memzero(&amp;check_client_key2, sizeof(check_client_=
key2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf=
(&amp;check_wrapped_client_key);</span><br><span> </span><br><span> cleanup=
:</span><br><span>     secure_memzero(&amp;client_key, sizeof(client_key));=
</span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnse=
rv/interactive.c</span><br><span>index 322461e..a2f9f09 100644</span><br><s=
pan>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnse=
rv/interactive.c</span><br><span>@@ -540,19 +540,19 @@</span><br><span> sta=
tic DWORD</span><br><span> InterfaceLuid(const char *iface_name, PNET_LUID =
luid)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    NETIO_STATUS status;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    NETIO_STATUS convert_status;</span><br><span>     LPWSTR wide_n=
ame =3D utf8to16(iface_name);</span><br><span> </span><br><span>     if (wi=
de_name)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        status =3D ConvertInterfaceAliasToLuid(wide_name, luid);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        convert_stat=
us =3D ConvertInterfaceAliasToLuid(wide_name, luid);</span><br><span>      =
   free(wide_name);</span><br><span>     }</span><br><span>     else</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   status =3D ERROR_OUTOFMEMORY;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        convert_status =3D ERROR_OUTOFMEMORY;</span><br><span>=
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return stat=
us;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return conve=
rt_status;</span><br><span> }</span><br><span> </span><br><span> static BOO=
L</span><br><span>@@ -1174,8 +1174,8 @@</span><br><span>         goto out;<=
/span><br><span>     }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SERVICE_STATUS status;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (ControlService(dnssvc, SERVICE_CONTROL_PARA=
MCHANGE, &amp;status) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SERVICE_STATUS control_status;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (ControlService(dnssvc, SERVICE_CONTROL_P=
ARAMCHANGE, &amp;control_status) =3D=3D 0)</span><br><span>     {</span><br=
><span>         MsgToEventLog(M_ERR, L&quot;%S: ControlService call failed =
(%lu)&quot;, __func__, GetLastError());</span><br><span>         goto out;<=
/span><br><span>@@ -3644,12 +3644,12 @@</span><br><span> static DWORD WINAP=
I</span><br><span> ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPV=
OID data, LPVOID ctx)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    SERVICE_STATUS *status =3D ctx;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SERVICE_STATUS *svc_status =3D ctx;<=
/span><br><span>     switch (ctrl_code)</span><br><span>     {</span><br><s=
pan>         case SERVICE_CONTROL_STOP:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            status-&gt;dwCurrentState =3D SERVICE_STOP_PE=
NDING;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            Rep=
ortStatusToSCMgr(service, status);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            svc_status-&gt;dwCurrentState =3D SERVICE_STOP_P=
ENDING;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
ReportStatusToSCMgr(service, svc_status);</span><br><span>             if (=
exit_event)</span><br><span>             {</span><br><span>                =
 SetEvent(exit_event);</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c<=
/span><br><span>index 219b476..eb5b22c 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_push_update_msg.c</span><br><span>+++ b/tests/unit_t=
ests/openvpn/test_push_update_msg.c</span><br><span>@@ -350,8 +350,8 @@</sp=
an><br><span> </span><br><span>     /* Message 1: first batch of routes, co=
ntinuation 2 (more coming) */</span><br><span>     struct buffer buf1 =3D a=
lloc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st char *msg1 =3D &quot;PUSH_UPDATE, route 10.1.0.0 255.255.0.0, route 10.2=
.0.0 255.255.0.0, route 10.3.0.0 255.255.0.0,push-continuation 2&quot;;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf1, =
msg1, strlen(msg1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const char *cmsg1 =3D &quot;PUSH_UPDATE, route 10.1.0.0 255.255.0.0, r=
oute 10.2.0.0 255.255.0.0, route 10.3.0.0 255.255.0.0,push-continuation 2&q=
uot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(=
&amp;buf1, cmsg1, strlen(cmsg1));</span><br><span> </span><br><span>     as=
sert_int_equal(process_incoming_push_msg(c, &amp;buf1, c-&gt;options.pull, =
pull_permission_mask(c),</span><br><span>                                  =
              &amp;option_types_found),</span><br><span>@@ -360,8 +360,8 @@=
</span><br><span> </span><br><span>     /* Message 2: more routes, continua=
tion 2 (more coming) */</span><br><span>     struct buffer buf2 =3D alloc_b=
uf(512);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *msg2 =3D &quot;PUSH_UPDATE, route 10.4.0.0 255.255.0.0, route 10.5.0.0 2=
55.255.0.0, route 10.6.0.0 255.255.0.0,push-continuation 2&quot;;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf2, msg2, =
strlen(msg2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *cmsg2 =3D &quot;PUSH_UPDATE, route 10.4.0.0 255.255.0.0, route 1=
0.5.0.0 255.255.0.0, route 10.6.0.0 255.255.0.0,push-continuation 2&quot;;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;b=
uf2, cmsg2, strlen(cmsg2));</span><br><span> </span><br><span>     assert_i=
nt_equal(process_incoming_push_msg(c, &amp;buf2, c-&gt;options.pull, pull_p=
ermission_mask(c),</span><br><span>                                        =
        &amp;option_types_found),</span><br><span>@@ -370,8 +370,8 @@</span=
><br><span> </span><br><span>     /* Message 3: final batch of routes, cont=
inuation 1 (last message) */</span><br><span>     struct buffer buf3 =3D al=
loc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cons=
t char *msg3 =3D &quot;PUSH_UPDATE, route 10.7.0.0 255.255.0.0, route 10.8.=
0.0 255.255.0.0, route 10.9.0.0 255.255.0.0,push-continuation 1&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write(&amp;buf3, m=
sg3, strlen(msg3));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *cmsg3 =3D &quot;PUSH_UPDATE, route 10.7.0.0 255.255.0.0, ro=
ute 10.8.0.0 255.255.0.0, route 10.9.0.0 255.255.0.0,push-continuation 1&qu=
ot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&=
amp;buf3, cmsg3, strlen(cmsg3));</span><br><span> </span><br><span>     ass=
ert_int_equal(process_incoming_push_msg(c, &amp;buf3, c-&gt;options.pull, p=
ull_permission_mask(c),</span><br><span>                                   =
             &amp;option_types_found),</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1618?usp=3D=
email">change 1618</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1618?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I528f5fd200d877841e473e5e05b=
7ac7915fa2e33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1618 </div>
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

--/f7wHcrKxKs=--

