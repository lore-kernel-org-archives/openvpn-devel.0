From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 4 May 2026 14:42:14 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@...2715...>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d2e3779f0506529eee8656b3447bfdc049fecb0a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="82N2/GLFpsE="; charset=UTF-8
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

--82N2/GLFpsE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1618?usp=3Demail

to look at the new patch set (#5).


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
M tests/unit_tests/openvpn/test_dhcp.c
M tests/unit_tests/openvpn/test_push_update_msg.c
7 files changed, 47 insertions(+), 50 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1618/5

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index f1dccc1..c082f51 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1328,8 +1328,6 @@
 static void
 man_load_stats(struct management *man)
 {
-    extern counter_type link_read_bytes_global;
-    extern counter_type link_write_bytes_global;
     int nclients =3D 0;

     if (man->persist.callback.n_clients)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1d3d649..53fb060 100644
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
index e91f80c..4f9d218 100644
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
index 473a8d3..ace25b9 100644
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
diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tests/openvp=
n/test_dhcp.c
index 150a3aa..104fc9a 100644
--- a/tests/unit_tests/openvpn/test_dhcp.c
+++ b/tests/unit_tests/openvpn/test_dhcp.c
@@ -55,8 +55,8 @@
 {
     struct gc_arena gc =3D gc_new();
     struct buffer out_buf =3D alloc_buf_gc(512, &gc);
-    struct buffer clear_buf =3D alloc_buf_gc(512, &gc);
-    buf_clear(&clear_buf);
+    struct buffer clean_buf =3D alloc_buf_gc(512, &gc);
+    buf_clear(&clean_buf);
     bool error =3D false;

 #define LONGDOMAIN "a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaally-long-domain"
@@ -79,7 +79,7 @@
     struct buffer small_buf =3D alloc_buf_gc(sizeof(output_1) - 1, &gc);
     buf_clear(&small_buf);
     write_dhcp_search_str(&small_buf, DHCP_DOMAIN_SEARCH, search_list, 2, =
&error);
-    assert_memory_equal(BPTR(&small_buf), BPTR(&clear_buf), buf_forward_ca=
pacity_total(&small_buf));
+    assert_memory_equal(BPTR(&small_buf), BPTR(&clean_buf), buf_forward_ca=
pacity_total(&small_buf));
     assert_true(error);
     error =3D false;

@@ -103,13 +103,13 @@

     buf_clear(&out_buf);
     write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1=
, &error);
-    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capa=
city_total(&clear_buf));
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clean_buf), buf_forward_capa=
city_total(&clean_buf));
     assert_true(error);
     error =3D false;

     buf_clear(&out_buf);
     write_dhcp_search_str(&out_buf, DHCP_DOMAIN_SEARCH, search_list, 3, &e=
rror);
-    assert_memory_equal(BPTR(&out_buf), BPTR(&clear_buf), buf_forward_capa=
city_total(&clear_buf));
+    assert_memory_equal(BPTR(&out_buf), BPTR(&clean_buf), buf_forward_capa=
city_total(&clean_buf));
     assert_true(error);
     error =3D false;

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Gerrit-Change-Number: 1618
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--82N2/GLFpsE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #5</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1618?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Rename variables that shadow other variables or =
functions<br><br>Identified by cppcheck.<br><br>Change-Id: I528f5fd200d8778=
41e473e5e05b7ac7915fa2e33<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M src/openvpn/manage.c<br>M src/openvpn/options.c<br>=
M src/openvpn/push.c<br>M src/openvpn/tls_crypt.c<br>M src/openvpnserv/inte=
ractive.c<br>M tests/unit_tests/openvpn/test_dhcp.c<br>M tests/unit_tests/o=
penvpn/test_push_update_msg.c<br>7 files changed, 47 insertions(+), 50 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/18/1618/5</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b=
/src/openvpn/manage.c</span><br><span>index f1dccc1..c082f51 100644</span><=
br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manag=
e.c</span><br><span>@@ -1328,8 +1328,6 @@</span><br><span> static void</spa=
n><br><span> man_load_stats(struct management *man)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    extern counter_type li=
nk_read_bytes_global;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    extern counter_type link_write_bytes_global;</span><br><span>     int n=
clients =3D 0;</span><br><span> </span><br><span>     if (man-&gt;persist.c=
allback.n_clients)</span><br><span>diff --git a/src/openvpn/options.c b/src=
/openvpn/options.c</span><br><span>index 1d3d649..53fb060 100644</span><br>=
<span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options=
.c</span><br><span>@@ -2689,12 +2689,12 @@</span><br><span>                =
     &quot;may accept clients which do not present a certificate&quot;);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    const unsigned int tls_version_max =3D</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int tls_ver_max =
=3D</span><br><span>         (options-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSI=
ON_MAX_SHIFT) &amp; SSLF_TLS_VERSION_MAX_MASK;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const unsigned int tls_version_min =3D</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int tls_=
ver_min =3D</span><br><span>         (options-&gt;ssl_flags &gt;&gt; SSLF_T=
LS_VERSION_MIN_SHIFT) &amp; SSLF_TLS_VERSION_MIN_MASK;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tls_version_max =
&gt; 0 &amp;&amp; tls_version_max &lt; tls_version_min)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (tls_ver_max &gt; 0 &amp;&amp; t=
ls_ver_max &lt; tls_ver_min)</span><br><span>     {</span><br><span>       =
  msg(M_USAGE, &quot;--tls-version-min bigger than --tls-version-max&quot;)=
;</span><br><span>     }</span><br><span>@@ -3641,16 +3641,16 @@</span><br>=
<span>         {</span><br><span>             struct dns_domain **entry =3D=
 &amp;dns-&gt;search_domains;</span><br><span>             ALLOC_OBJ_CLEAR_=
GC(*entry, struct dns_domain, &amp;dns-&gt;gc);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            struct dns_domain *new =3D *entry;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            new-&gt;name=
 =3D dhcp-&gt;domain;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            entry =3D &amp;new-&gt;next;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            struct dns_domain *domain =3D *entry;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            domain-&gt;n=
ame =3D dhcp-&gt;domain;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            entry =3D &amp;domain-&gt;next;</span><br><span> </span><b=
r><span>             for (unsigned int i =3D 0; i &lt; dhcp-&gt;domain_sear=
ch_list_len; ++i)</span><br><span>             {</span><br><span>          =
       ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &amp;dns-&gt;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                struct dns=
_domain *new =3D *entry;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                new-&gt;name =3D dhcp-&gt;domain_search_list[i];</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                entry =3D &am=
p;new-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            struct dns_domain *search_domain =3D *entry;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                search_domain-&gt;name=
 =3D dhcp-&gt;domain_search_list[i];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                entry =3D &amp;search_domain-&gt;next;</sp=
an><br><span>             }</span><br><span> </span><br><span>             =
struct dns_server *server =3D dns_server_get(&amp;dns-&gt;servers, 0, &amp;=
dns-&gt;gc);</span><br><span>@@ -3743,7 +3743,6 @@</span><br><span> static =
void</span><br><span> options_postprocess_mutate(struct options *o, struct =
env_set *es)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int i;</span><br><span>     /*</span><br><span>      * Proces=
s helper-type options which map to other, more complex</span><br><span>    =
  * sequences of options.</span><br><span>@@ -3776,7 +3775,7 @@</span><br><=
span>          * Convert remotes into connection list</span><br><span>     =
     */</span><br><span>         const struct remote_list *rl =3D o-&gt;rem=
ote_list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for =
(i =3D 0; i &lt; rl-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        for (int i =3D 0; i &lt; rl-&gt;len; ++i)</span><br><=
span>         {</span><br><span>             const struct remote_entry *re =
=3D rl-&gt;array[i];</span><br><span>             struct connection_entry c=
e =3D o-&gt;ce;</span><br><span>@@ -3798,14 +3797,14 @@</span><br><span>   =
  }</span><br><span> </span><br><span>     ASSERT(o-&gt;connection_list);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt=
; o-&gt;connection_list-&gt;len; ++i)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int i =3D 0; i &lt; o-&gt;connection_list-&gt;le=
n; ++i)</span><br><span>     {</span><br><span>         options_postprocess=
_mutate_ce(o, o-&gt;connection_list-&gt;array[i]);</span><br><span>     }</=
span><br><span> </span><br><span>     if (o-&gt;ce.local_list)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for=
 (i =3D 0; i &lt; o-&gt;ce.local_list-&gt;len; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; o-&gt;ce=
.local_list-&gt;len; i++)</span><br><span>         {</span><br><span>      =
       options_postprocess_mutate_le(&amp;o-&gt;ce, o-&gt;ce.local_list-&gt=
;array[i], o-&gt;mode);</span><br><span>         }</span><br><span>@@ -3833=
,7 +3832,7 @@</span><br><span>     }</span><br><span> </span><br><span>    =
 /* use the same listen list for every outgoing connection */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; o-&gt;conn=
ection_list-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (int i =3D 0; i &lt; o-&gt;connection_list-&gt;len; ++i)</spa=
n><br><span>     {</span><br><span>         o-&gt;connection_list-&gt;array=
[i]-&gt;local_list =3D o-&gt;ce.local_list;</span><br><span>     }</span><b=
r><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><spa=
n>index 564ce86..ae0f0e2 100644</span><br><span>--- a/src/openvpn/push.c</s=
pan><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -994,10 +994,10 @=
@</span><br><span>     else if (tls_authentication_status(c-&gt;c2.tls_mult=
i) =3D=3D TLS_AUTHENTICATION_SUCCEEDED</span><br><span>              &amp;&=
amp; c-&gt;c2.tls_multi-&gt;multi_state &gt;=3D CAS_CONNECT_DONE)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
time_t now;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
time_t local_now;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        openvpn_time(&amp;now);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (c-&gt;c2.sent_push_reply_expiry &gt; no=
w)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        openvpn_t=
ime(&amp;local_now);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (c-&gt;c2.sent_push_reply_expiry &gt; local_now)</span><br><spa=
n>         {</span><br><span>             ret =3D PUSH_MSG_ALREADY_REPLIED;=
</span><br><span>         }</span><br><span>@@ -1011,7 +1011,7 @@</span><br=
><span>             if (send_push_reply(c, &amp;push_list))</span><br><span=
>             {</span><br><span>                 ret =3D PUSH_MSG_REQUEST;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-&gt;=
c2.sent_push_reply_expiry =3D now + 30;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                c-&gt;c2.sent_push_reply_expiry =3D loc=
al_now + 30;</span><br><span>             }</span><br><span>             gc=
_free(&amp;gc);</span><br><span>         }</span><br><span>diff --git a/src=
/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index e91f80=
c..4f9d218 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</span><br><=
span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -769,24 +769,24 @@</s=
pan><br><span>     }</span><br><span> </span><br><span>     /* Sanity check=
: load client key (as &quot;client&quot;) */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct key_ctx_bi test_client_key;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct buffer test_wrapped_clie=
nt_key;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct k=
ey_ctx_bi check_client_key;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer check_wrapped_client_key;</span><br><span>     st=
ruct key2 keydata;</span><br><span>     msg(D_GENKEY, &quot;Testing client-=
side key loading...&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    tls_crypt_v2_init_client_key(&amp;test_client_key, &amp;keydata, =
&amp;test_wrapped_client_key, client_file,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    tls_crypt_v2_init_client_key(&amp;check_client_k=
ey, &amp;keydata, &amp;check_wrapped_client_key, client_file,</span><br><sp=
an>                                  client_inline);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    free_key_ctx_bi(&amp;test_client_key);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_key_ctx_bi(=
&amp;check_client_key);</span><br><span> </span><br><span>     /* Sanity ch=
eck: unwrap and load client key (as &quot;server&quot;) */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    struct buffer test_metadata =3D al=
loc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &amp;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    struct key2 test_client_key2 =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer c=
heck_metadata =3D alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key2 check_c=
lient_key2 =3D { 0 };</span><br><span>     free_key_ctx(&amp;server_key);</=
span><br><span>     tls_crypt_v2_init_server_key(&amp;server_key, false, se=
rver_key_file, server_key_inline);</span><br><span>     msg(D_GENKEY, &quot=
;Testing server-side key loading...&quot;);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    ASSERT(tls_crypt_v2_unwrap_client_key(&amp;test_c=
lient_key2, &amp;test_metadata,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                          test_wrapped_client_key=
, &amp;server_key));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   secure_memzero(&amp;test_client_key2, sizeof(test_client_key2));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    free_buf(&amp;test_wrappe=
d_client_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    A=
SSERT(tls_crypt_v2_unwrap_client_key(&amp;check_client_key2, &amp;check_met=
adata,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                             check_wrapped_client_key, &amp;server_key));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    secure_memzero(&a=
mp;check_client_key2, sizeof(check_client_key2));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    free_buf(&amp;check_wrapped_client_key);<=
/span><br><span> </span><br><span> cleanup:</span><br><span>     secure_mem=
zero(&amp;client_key, sizeof(client_key));</span><br><span>diff --git a/src=
/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>=
index 473a8d3..ace25b9 100644</span><br><span>--- a/src/openvpnserv/interac=
tive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>=
@@ -540,19 +540,19 @@</span><br><span> static DWORD</span><br><span> Interf=
aceLuid(const char *iface_name, PNET_LUID luid)</span><br><span> {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    NETIO_STATUS status;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    NETIO_STATUS convert_=
status;</span><br><span>     LPWSTR wide_name =3D utf8to16(iface_name);</sp=
an><br><span> </span><br><span>     if (wide_name)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =3D Conv=
ertInterfaceAliasToLuid(wide_name, luid);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        convert_status =3D ConvertInterfaceAliasToLui=
d(wide_name, luid);</span><br><span>         free(wide_name);</span><br><sp=
an>     }</span><br><span>     else</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        status =3D ERROR_OUTOFMEMORY;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        convert_stat=
us =3D ERROR_OUTOFMEMORY;</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return status;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return convert_status;</span><br><span> }</sp=
an><br><span> </span><br><span> static BOOL</span><br><span>@@ -1174,8 +117=
4,8 @@</span><br><span>         goto out;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SERVICE_ST=
ATUS status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (C=
ontrolService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &amp;status) =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SERVICE_STATUS co=
ntrol_status;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (ControlService(dnssvc, SERVICE_CONTROL_PARAMCHANGE, &amp;control_status) =
=3D=3D 0)</span><br><span>     {</span><br><span>         MsgToEventLog(M_E=
RR, L&quot;%S: ControlService call failed (%lu)&quot;, __func__, GetLastErr=
or());</span><br><span>         goto out;</span><br><span>@@ -3644,12 +3644=
,12 @@</span><br><span> static DWORD WINAPI</span><br><span> ServiceCtrlInt=
eractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SERVICE_ST=
ATUS *status =3D ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SERVICE_STATUS *svc_status =3D ctx;</span><br><span>     switch (ctrl=
_code)</span><br><span>     {</span><br><span>         case SERVICE_CONTROL=
_STOP:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            sta=
tus-&gt;dwCurrentState =3D SERVICE_STOP_PENDING;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            ReportStatusToSCMgr(service, status)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            svc_st=
atus-&gt;dwCurrentState =3D SERVICE_STOP_PENDING;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            ReportStatusToSCMgr(service, svc_=
status);</span><br><span>             if (exit_event)</span><br><span>     =
        {</span><br><span>                 SetEvent(exit_event);</span><br>=
<span>diff --git a/tests/unit_tests/openvpn/test_dhcp.c b/tests/unit_tests/=
openvpn/test_dhcp.c</span><br><span>index 150a3aa..104fc9a 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_dhcp.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_dhcp.c</span><br><span>@@ -55,8 +55,8 @@</span><=
br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br=
><span>     struct buffer out_buf =3D alloc_buf_gc(512, &amp;gc);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer clear_buf =3D=
 alloc_buf_gc(512, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    buf_clear(&amp;clear_buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer clean_buf =3D alloc_buf_gc(512, &amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_clear(&am=
p;clean_buf);</span><br><span>     bool error =3D false;</span><br><span> <=
/span><br><span> #define LONGDOMAIN &quot;a-reaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaally-long-domain&quot;</span><br><span=
>@@ -79,7 +79,7 @@</span><br><span>     struct buffer small_buf =3D alloc_b=
uf_gc(sizeof(output_1) - 1, &amp;gc);</span><br><span>     buf_clear(&amp;s=
mall_buf);</span><br><span>     write_dhcp_search_str(&amp;small_buf, DHCP_=
DOMAIN_SEARCH, search_list, 2, &amp;error);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;small_buf), BPTR(&a=
mp;clear_buf), buf_forward_capacity_total(&amp;small_buf));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;s=
mall_buf), BPTR(&amp;clean_buf), buf_forward_capacity_total(&amp;small_buf)=
);</span><br><span>     assert_true(error);</span><br><span>     error =3D =
false;</span><br><span> </span><br><span>@@ -103,13 +103,13 @@</span><br><s=
pan> </span><br><span>     buf_clear(&amp;out_buf);</span><br><span>     wr=
ite_dhcp_search_str(&amp;out_buf, DHCP_DOMAIN_SEARCH, search_list + 5, 1, &=
amp;error);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert=
_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;clear_buf), buf_forward_capacit=
y_total(&amp;clear_buf));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_memory_equal(BPTR(&amp;out_buf), BPTR(&amp;clean_buf), buf=
_forward_capacity_total(&amp;clean_buf));</span><br><span>     assert_true(=
error);</span><br><span>     error =3D false;</span><br><span> </span><br><=
span>     buf_clear(&amp;out_buf);</span><br><span>     write_dhcp_search_s=
tr(&amp;out_buf, DHCP_DOMAIN_SEARCH, search_list, 3, &amp;error);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&a=
mp;out_buf), BPTR(&amp;clear_buf), buf_forward_capacity_total(&amp;clear_bu=
f));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(BPTR(&amp;out_buf), BPTR(&amp;clean_buf), buf_forward_capacity_tot=
al(&amp;clean_buf));</span><br><span>     assert_true(error);</span><br><sp=
an>     error =3D false;</span><br><span> </span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/openvpn/tes=
t_push_update_msg.c</span><br><span>index 219b476..eb5b22c 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><span>@@ =
-350,8 +350,8 @@</span><br><span> </span><br><span>     /* Message 1: first=
 batch of routes, continuation 2 (more coming) */</span><br><span>     stru=
ct buffer buf1 =3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const char *msg1 =3D &quot;PUSH_UPDATE, route 10.1.0.0 255=
.255.0.0, route 10.2.0.0 255.255.0.0, route 10.3.0.0 255.255.0.0,push-conti=
nuation 2&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
uf_write(&amp;buf1, msg1, strlen(msg1));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    const char *cmsg1 =3D &quot;PUSH_UPDATE, route 10.=
1.0.0 255.255.0.0, route 10.2.0.0 255.255.0.0, route 10.3.0.0 255.255.0.0,p=
ush-continuation 2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf_write(&amp;buf1, cmsg1, strlen(cmsg1));</span><br><span> </sp=
an><br><span>     assert_int_equal(process_incoming_push_msg(c, &amp;buf1, =
c-&gt;options.pull, pull_permission_mask(c),</span><br><span>              =
                                  &amp;option_types_found),</span><br><span=
>@@ -360,8 +360,8 @@</span><br><span> </span><br><span>     /* Message 2: m=
ore routes, continuation 2 (more coming) */</span><br><span>     struct buf=
fer buf2 =3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    const char *msg2 =3D &quot;PUSH_UPDATE, route 10.4.0.0 255.255.0=
.0, route 10.5.0.0 255.255.0.0, route 10.6.0.0 255.255.0.0,push-continuatio=
n 2&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_wri=
te(&amp;buf2, msg2, strlen(msg2));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const char *cmsg2 =3D &quot;PUSH_UPDATE, route 10.4.0.0 =
255.255.0.0, route 10.5.0.0 255.255.0.0, route 10.6.0.0 255.255.0.0,push-co=
ntinuation 2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    buf_write(&amp;buf2, cmsg2, strlen(cmsg2));</span><br><span> </span><br=
><span>     assert_int_equal(process_incoming_push_msg(c, &amp;buf2, c-&gt;=
options.pull, pull_permission_mask(c),</span><br><span>                    =
                            &amp;option_types_found),</span><br><span>@@ -3=
70,8 +370,8 @@</span><br><span> </span><br><span>     /* Message 3: final b=
atch of routes, continuation 1 (last message) */</span><br><span>     struc=
t buffer buf3 =3D alloc_buf(512);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const char *msg3 =3D &quot;PUSH_UPDATE, route 10.7.0.0 255.=
255.0.0, route 10.8.0.0 255.255.0.0, route 10.9.0.0 255.255.0.0,push-contin=
uation 1&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bu=
f_write(&amp;buf3, msg3, strlen(msg3));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *cmsg3 =3D &quot;PUSH_UPDATE, route 10.7=
.0.0 255.255.0.0, route 10.8.0.0 255.255.0.0, route 10.9.0.0 255.255.0.0,pu=
sh-continuation 1&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_write(&amp;buf3, cmsg3, strlen(cmsg3));</span><br><span> </spa=
n><br><span>     assert_int_equal(process_incoming_push_msg(c, &amp;buf3, c=
-&gt;options.pull, pull_permission_mask(c),</span><br><span>               =
                                 &amp;option_types_found),</span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1618?usp=3Demail">change 1618</a>. To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1618?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I528f5fd200d877841e473e5e05b=
7ac7915fa2e33 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1618 </div>
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

--82N2/GLFpsE=--

