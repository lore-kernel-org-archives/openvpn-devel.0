From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 18:02:34 +0000
References: <gerrit.1769450543000.Ib6c3e154fbe14113ff990f13347f85a7c93dd3e0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2ae9de24c225e989c95adf3ffcd6bf8a2e36c077-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3fNT0GOfV+8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix various loop
 index types to avoid sign-compare issues
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

--3fNT0GOfV+8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1491?usp=3Demail

to review the following change.


Change subject: Fix various loop index types to avoid sign-compare issues
......................................................................

Fix various loop index types to avoid sign-compare issues

Just uses the correct types i.e. the same as the limit.
Since the index is usually only used as a non-negative
array index the type change does not cause any behavioral
changes.

But it avoids -Wsign-compare complaints and is just
cleaner.

Change-Id: Ib6c3e154fbe14113ff990f13347f85a7c93dd3e0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/argv.c
M src/openvpn/crypto_openssl.c
M src/openvpn/dco_win.c
M src/openvpn/dns.c
M src/openvpn/options.c
M src/openvpn/route.c
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpnserv/interactive.c
M src/plugins/down-root/down-root.c
M tests/unit_tests/openvpn/test_argv.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_ssl.c
14 files changed, 27 insertions(+), 30 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1491/1

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 922ece0..8e37115 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -293,7 +293,7 @@

     bool in_token =3D false;
     char *f =3D gc_malloc(strlen(format) + 1, true, gc);
-    for (int i =3D 0, j =3D 0; i < strlen(format); i++)
+    for (size_t i =3D 0, j =3D 0; i < strlen(format); i++)
     {
         if (format[i] =3D=3D ' ')
         {
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index ed39efa..2e49197 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -411,7 +411,7 @@

     printf("\nThe following ciphers have a block size of less than 128 bit=
s, \n"
            "and are therefore deprecated.  Do not use unless you have to.\=
n\n");
-    for (int i =3D 0; i < cipher_list.num; i++)
+    for (size_t i =3D 0; i < cipher_list.num; i++)
     {
         if (cipher_kt_insecure(EVP_CIPHER_get0_name(cipher_list.list[i])))
         {
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9599e9f3..695bf41 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -829,7 +829,7 @@
     }

     /* iterate over stats and update peers */
-    for (int i =3D 0; i < bytes_returned / sizeof(OVPN_PEER_STATS); ++i)
+    for (size_t i =3D 0; i < bytes_returned / sizeof(OVPN_PEER_STATS); ++i)
     {
         OVPN_PEER_STATS *stat =3D &peer_stats[i];

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index b367d87..996622a 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -785,7 +785,7 @@
     {
         msg(D_SHOW_PARMS, "  DNS server #%d:", i++);

-        for (int j =3D 0; j < server->addr_count; ++j)
+        for (size_t j =3D 0; j < server->addr_count; ++j)
         {
             const char *addr;
             const char *fmt_port;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 85669e0..9708062 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3547,7 +3547,7 @@
     while (s)
     {
         bool non_standard_server_port =3D false;
-        for (int i =3D 0; i < s->addr_count; ++i)
+        for (size_t i =3D 0; i < s->addr_count; ++i)
         {
             if (s->addr[i].port && s->addr[i].port !=3D 53)
             {
@@ -3564,7 +3564,7 @@
         else
         {
             bool overflow =3D false;
-            for (int i =3D 0; i < s->addr_count; ++i)
+            for (size_t i =3D 0; i < s->addr_count; ++i)
             {
                 if (s->addr[i].family =3D=3D AF_INET && tt->dns_len + 1 < =
N_DHCP_ADDR)
                 {
@@ -3664,7 +3664,7 @@
             new->name =3D dhcp->domain;
             entry =3D &new->next;

-            for (size_t i =3D 0; i < dhcp->domain_search_list_len; ++i)
+            for (int i =3D 0; i < dhcp->domain_search_list_len; ++i)
             {
                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
                 struct dns_domain *new =3D *entry;
@@ -3674,13 +3674,13 @@

             struct dns_server *server =3D dns_server_get(&dns->servers, 0,=
 &dns->gc);
             const size_t max_addrs =3D SIZE(server->addr);
-            for (size_t i =3D 0; i < dhcp->dns_len && server->addr_count <=
 max_addrs; ++i)
+            for (int i =3D 0; i < dhcp->dns_len && server->addr_count < ma=
x_addrs; ++i)
             {
                 server->addr[server->addr_count].in.a4.s_addr =3D htonl(dh=
cp->dns[i]);
                 server->addr[server->addr_count].family =3D AF_INET;
                 server->addr_count +=3D 1;
             }
-            for (size_t i =3D 0; i < dhcp->dns6_len && server->addr_count =
< max_addrs; ++i)
+            for (int i =3D 0; i < dhcp->dns6_len && server->addr_count < m=
ax_addrs; ++i)
             {
                 server->addr[server->addr_count].in.a6 =3D dhcp->dns6[i];
                 server->addr[server->addr_count].family =3D AF_INET6;
@@ -3702,7 +3702,7 @@
         while (s)
         {
             bool non_standard_server_port =3D false;
-            for (int i =3D 0; i < s->addr_count; ++i)
+            for (size_t i =3D 0; i < s->addr_count; ++i)
             {
                 if (s->addr[i].port && s->addr[i].port !=3D 53)
                 {
@@ -3718,7 +3718,7 @@
             }
             else
             {
-                for (int i =3D 0; i < s->addr_count; ++i)
+                for (size_t i =3D 0; i < s->addr_count; ++i)
                 {
                     const char *option;
                     const char *value;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 93f61a1..9a0dcc4 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -582,7 +582,7 @@
     add_block_local_item(rl, &rl->rgi.gateway, rl->spec.remote_endpoint);

     /* process additional subnets on gateway interface */
-    for (size_t i =3D 0; i < rl->rgi.n_addrs; ++i)
+    for (int i =3D 0; i < rl->rgi.n_addrs; ++i)
     {
         const struct route_gateway_address *gwa =3D &rl->rgi.addrs[i];
         /* omit the add/subnet in &rl->rgi which we processed above */
@@ -1452,8 +1452,7 @@
         else
         {
             /* examine additional subnets on gateway interface */
-            size_t i;
-            for (i =3D 0; i < rgi->n_addrs; ++i)
+            for (int i =3D 0; i < rgi->n_addrs; ++i)
             {
                 const struct route_gateway_address *gwa =3D &rgi->addrs[i];
                 if (((network ^ gwa->addr) & gwa->netmask) =3D=3D 0)
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 4c29bc8..ad5479c 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -573,7 +573,6 @@
 void
 x509_setenv(struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)
 {
-    int i;
     unsigned char c;
     const mbedtls_x509_name *name;
     char s[128] =3D { 0 };
@@ -594,9 +593,10 @@
             snprintf(name_expand, sizeof(name_expand), "X509_%d_\?\?", cer=
t_depth);
         }

+        size_t i;
         for (i =3D 0; i < name->val.len; i++)
         {
-            if (i >=3D (int)sizeof(s) - 1)
+            if (i >=3D sizeof(s) - 1)
             {
                 break;
             }
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ad19e2c..4fa4889 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1269,7 +1269,7 @@
     if (!err || err =3D=3D ERROR_MORE_DATA)
     {
         data[sizeof(data) - 1] =3D '\0';
-        for (int i =3D 0; i < strlen(data); ++i)
+        for (size_t i =3D 0; i < strlen(data); ++i)
         {
             if (isalnum(data[i]) || data[i] =3D=3D '-' || data[i] =3D=3D '=
.')
             {
@@ -1954,7 +1954,7 @@
 SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addresses)
 {
     const short families[] =3D { AF_INET, AF_INET6 };
-    for (int i =3D 0; i < _countof(families); i++)
+    for (size_t i =3D 0; i < _countof(families); i++)
     {
         short family =3D families[i];

@@ -2436,7 +2436,7 @@
         if (v4_addrs_size || v6_addrs_size)
         {
             /* Replace delimiters with semicolons, as required by NRPT */
-            for (int j =3D 0; j < sizeof(data[0].addresses) && data[i].add=
resses[j]; j++)
+            for (size_t j =3D 0; j < sizeof(data[0].addresses) && data[i].=
addresses[j]; j++)
             {
                 if (data[i].addresses[j] =3D=3D ',' || data[i].addresses[j=
] =3D=3D ' ')
                 {
@@ -2567,7 +2567,7 @@
     GetNrptExcludeData(search_domains, data, _countof(data));

     unsigned n =3D 0;
-    for (int i =3D 0; i < _countof(data); ++i)
+    for (size_t i =3D 0; i < _countof(data); ++i)
     {
         nrpt_exclude_data_t *d =3D &data[i];
         if (d->domains_size =3D=3D 0)
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down=
-root.c
index c0ea7a6..cd57189 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -318,7 +318,7 @@
     }

     /* Ignore argv[0], as it contains just the plug-in file name */
-    for (int i =3D 1; i < string_array_len(argv); i++)
+    for (size_t i =3D 1; i < string_array_len(argv); i++)
     {
         context->command[i - 1] =3D (char *)argv[i];
     }
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvp=
n/test_argv.c
index 25c0371..b1e3261 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -120,7 +120,6 @@
 static void
 argv_printf__long_args__data_correct(void **state)
 {
-    int i;
     struct argv a =3D argv_new();
     const char *args[] =3D {
         "good_tools_have_good_names_even_though_it_might_impair_typing",
@@ -131,7 +130,7 @@

     argv_printf(&a, "%s %s %s %s", args[0], args[1], args[2], args[3]);
     assert_int_equal(a.argc, 4);
-    for (i =3D 0; i < a.argc; i++)
+    for (size_t i =3D 0; i < a.argc; i++)
     {
         assert_string_equal(a.argv[i], args[i]);
     }
@@ -229,12 +228,11 @@
 {
     struct argv a =3D argv_new();
     struct argv b;
-    int i;

     argv_printf(&a, "%s", PATH2);
     b =3D argv_insert_head(&a, PATH1);
     assert_int_equal(b.argc, a.argc + 1);
-    for (i =3D 0; i < b.argc; i++)
+    for (size_t i =3D 0; i < b.argc; i++)
     {
         if (i =3D=3D 0)
         {
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index a1d7ddd..3d3e53a 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -101,7 +101,7 @@
     char *lower =3D string_alloc(ciphername, &gc);
     char *random_case =3D string_alloc(ciphername, &gc);

-    for (int i =3D 0; i < strlen(ciphername); i++)
+    for (size_t i =3D 0; i < strlen(ciphername); i++)
     {
         upper[i] =3D (char)toupper((unsigned char)ciphername[i]);
         lower[i] =3D (char)tolower((unsigned char)ciphername[i]);
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 4b5baf8..ce527d7 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -467,7 +467,7 @@
     unsigned char hash[255];
     (void)state;

-    for (int i =3D 0; i < _countof(valid_str); i++)
+    for (size_t i =3D 0; i < _countof(valid_str); i++)
     {
         int len =3D parse_hexstring(valid_str[i], hash, _countof(hash));
         assert_int_equal(len, sizeof(test_hash));
@@ -475,7 +475,7 @@
         memset(hash, 0, _countof(hash));
     }

-    for (int i =3D 0; i < _countof(invalid_str); i++)
+    for (size_t i =3D 0; i < _countof(invalid_str); i++)
     {
         int len =3D parse_hexstring(invalid_str[i], hash, _countof(hash));
         assert_int_equal(len, 0);
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index ca62b38..fc2c0a1 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -236,7 +236,7 @@
     free_tls_pre_decrypt_state(&state);

     /* flip a byte in various places */
-    for (int i =3D 0; i < sizeof(client_reset_v2_tls_crypt); i++)
+    for (size_t i =3D 0; i < sizeof(client_reset_v2_tls_crypt); i++)
     {
         buf_reset_len(&buf);
         buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_=
tls_crypt));
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 8ef9a3d..153aa77 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -620,7 +620,7 @@
      * Statickey but XOR it to not repeat it */
     uint8_t keydata[sizeof(key2.keys)];

-    for (int i =3D 0; i < sizeof(key2.keys); i++)
+    for (size_t i =3D 0; i < sizeof(key2.keys); i++)
     {
         keydata[i] =3D (uint8_t)(key[i % sizeof(key)] ^ i);
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1491?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib6c3e154fbe14113ff990f13347f85a7c93dd3e0
Gerrit-Change-Number: 1491
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--3fNT0GOfV+8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1491?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix various loop index types to avoid sign-=
compare issues<br><br>Just uses the correct types i.e. the same as the limi=
t.<br>Since the index is usually only used as a non-negative<br>array index=
 the type change does not cause any behavioral<br>changes.<br><br>But it av=
oids -Wsign-compare complaints and is just<br>cleaner.<br><br>Change-Id: Ib=
6c3e154fbe14113ff990f13347f85a7c93dd3e0<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/argv.c<br>M src/openvpn/c=
rypto_openssl.c<br>M src/openvpn/dco_win.c<br>M src/openvpn/dns.c<br>M src/=
openvpn/options.c<br>M src/openvpn/route.c<br>M src/openvpn/ssl_verify_mbed=
tls.c<br>M src/openvpnserv/interactive.c<br>M src/plugins/down-root/down-ro=
ot.c<br>M tests/unit_tests/openvpn/test_argv.c<br>M tests/unit_tests/openvp=
n/test_crypto.c<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>M tests/u=
nit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>14=
 files changed, 27 insertions(+), 30 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1491/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c</span><br><spa=
n>index 922ece0..8e37115 100644</span><br><span>--- a/src/openvpn/argv.c</s=
pan><br><span>+++ b/src/openvpn/argv.c</span><br><span>@@ -293,7 +293,7 @@<=
/span><br><span> </span><br><span>     bool in_token =3D false;</span><br><=
span>     char *f =3D gc_malloc(strlen(format) + 1, true, gc);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0, j =3D 0; i &=
lt; strlen(format); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    for (size_t i =3D 0, j =3D 0; i &lt; strlen(format); i++)</span><b=
r><span>     {</span><br><span>         if (format[i] =3D=3D &#39; &#39;)</=
span><br><span>         {</span><br><span>diff --git a/src/openvpn/crypto_o=
penssl.c b/src/openvpn/crypto_openssl.c</span><br><span>index ed39efa..2e49=
197 100644</span><br><span>--- a/src/openvpn/crypto_openssl.c</span><br><sp=
an>+++ b/src/openvpn/crypto_openssl.c</span><br><span>@@ -411,7 +411,7 @@</=
span><br><span> </span><br><span>     printf(&quot;\nThe following ciphers =
have a block size of less than 128 bits, \n&quot;</span><br><span>         =
   &quot;and are therefore deprecated.  Do not use unless you have to.\n\n&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i=
 =3D 0; i &lt; cipher_list.num; i++)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (size_t i =3D 0; i &lt; cipher_list.num; i++)</spa=
n><br><span>     {</span><br><span>         if (cipher_kt_insecure(EVP_CIPH=
ER_get0_name(cipher_list.list[i])))</span><br><span>         {</span><br><s=
pan>diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c</span><br><s=
pan>index 9599e9f3..695bf41 100644</span><br><span>--- a/src/openvpn/dco_wi=
n.c</span><br><span>+++ b/src/openvpn/dco_win.c</span><br><span>@@ -829,7 +=
829,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /* i=
terate over stats and update peers */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    for (int i =3D 0; i &lt; bytes_returned / sizeof(OVPN_P=
EER_STATS); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (size_t i =3D 0; i &lt; bytes_returned / sizeof(OVPN_PEER_STATS); ++i)=
</span><br><span>     {</span><br><span>         OVPN_PEER_STATS *stat =3D =
&amp;peer_stats[i];</span><br><span> </span><br><span>diff --git a/src/open=
vpn/dns.c b/src/openvpn/dns.c</span><br><span>index b367d87..996622a 100644=
</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/=
dns.c</span><br><span>@@ -785,7 +785,7 @@</span><br><span>     {</span><br>=
<span>         msg(D_SHOW_PARMS, &quot;  DNS server #%d:&quot;, i++);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        f=
or (int j =3D 0; j &lt; server-&gt;addr_count; ++j)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (size_t j =3D 0; j &lt; serve=
r-&gt;addr_count; ++j)</span><br><span>         {</span><br><span>         =
    const char *addr;</span><br><span>             const char *fmt_port;</s=
pan><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</s=
pan><br><span>index 85669e0..9708062 100644</span><br><span>--- a/src/openv=
pn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@=
 -3547,7 +3547,7 @@</span><br><span>     while (s)</span><br><span>     {</=
span><br><span>         bool non_standard_server_port =3D false;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &lt;=
 s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        for (size_t i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><s=
pan>         {</span><br><span>             if (s-&gt;addr[i].port &amp;&am=
p; s-&gt;addr[i].port !=3D 53)</span><br><span>             {</span><br><sp=
an>@@ -3564,7 +3564,7 @@</span><br><span>         else</span><br><span>    =
     {</span><br><span>             bool overflow =3D false;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            for (int i =3D 0; i &lt;=
 s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            for (size_t i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><b=
r><span>             {</span><br><span>                 if (s-&gt;addr[i].f=
amily =3D=3D AF_INET &amp;&amp; tt-&gt;dns_len + 1 &lt; N_DHCP_ADDR)</span>=
<br><span>                 {</span><br><span>@@ -3664,7 +3664,7 @@</span><b=
r><span>             new-&gt;name =3D dhcp-&gt;domain;</span><br><span>    =
         entry =3D &amp;new-&gt;next;</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            for (size_t i =3D 0; i &lt; d=
hcp-&gt;domain_search_list_len; ++i)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            for (int i =3D 0; i &lt; dhcp-&gt;domain_searc=
h_list_len; ++i)</span><br><span>             {</span><br><span>           =
      ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &amp;dns-&gt;gc);</span=
><br><span>                 struct dns_domain *new =3D *entry;</span><br><s=
pan>@@ -3674,13 +3674,13 @@</span><br><span> </span><br><span>             =
struct dns_server *server =3D dns_server_get(&amp;dns-&gt;servers, 0, &amp;=
dns-&gt;gc);</span><br><span>             const size_t max_addrs =3D SIZE(s=
erver-&gt;addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       for (size_t i =3D 0; i &lt; dhcp-&gt;dns_len &amp;&amp; server-&gt;a=
ddr_count &lt; max_addrs; ++i)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            for (int i =3D 0; i &lt; dhcp-&gt;dns_len &amp;&amp;=
 server-&gt;addr_count &lt; max_addrs; ++i)</span><br><span>             {<=
/span><br><span>                 server-&gt;addr[server-&gt;addr_count].in.=
a4.s_addr =3D htonl(dhcp-&gt;dns[i]);</span><br><span>                 serv=
er-&gt;addr[server-&gt;addr_count].family =3D AF_INET;</span><br><span>    =
             server-&gt;addr_count +=3D 1;</span><br><span>             }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            for (size_t=
 i =3D 0; i &lt; dhcp-&gt;dns6_len &amp;&amp; server-&gt;addr_count &lt; ma=
x_addrs; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      for (int i =3D 0; i &lt; dhcp-&gt;dns6_len &amp;&amp; server-&gt;addr=
_count &lt; max_addrs; ++i)</span><br><span>             {</span><br><span>=
                 server-&gt;addr[server-&gt;addr_count].in.a6 =3D dhcp-&gt;=
dns6[i];</span><br><span>                 server-&gt;addr[server-&gt;addr_c=
ount].family =3D AF_INET6;</span><br><span>@@ -3702,7 +3702,7 @@</span><br>=
<span>         while (s)</span><br><span>         {</span><br><span>       =
      bool non_standard_server_port =3D false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            for (int i =3D 0; i &lt; s-&gt;addr_co=
unt; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  for (size_t i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><span>      =
       {</span><br><span>                 if (s-&gt;addr[i].port &amp;&amp;=
 s-&gt;addr[i].port !=3D 53)</span><br><span>                 {</span><br><=
span>@@ -3718,7 +3718,7 @@</span><br><span>             }</span><br><span> =
            else</span><br><span>             {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                for (int i =3D 0; i &lt; s-&gt;ad=
dr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           for (size_t i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><sp=
an>                 {</span><br><span>                     const char *opti=
on;</span><br><span>                     const char *value;</span><br><span=
>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>ind=
ex 93f61a1..9a0dcc4 100644</span><br><span>--- a/src/openvpn/route.c</span>=
<br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -582,7 +582,7 @@</sp=
an><br><span>     add_block_local_item(rl, &amp;rl-&gt;rgi.gateway, rl-&gt;=
spec.remote_endpoint);</span><br><span> </span><br><span>     /* process ad=
ditional subnets on gateway interface */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; rl-&gt;rgi.n_addrs; ++i)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D =
0; i &lt; rl-&gt;rgi.n_addrs; ++i)</span><br><span>     {</span><br><span> =
        const struct route_gateway_address *gwa =3D &amp;rl-&gt;rgi.addrs[i=
];</span><br><span>         /* omit the add/subnet in &amp;rl-&gt;rgi which=
 we processed above */</span><br><span>@@ -1452,8 +1452,7 @@</span><br><spa=
n>         else</span><br><span>         {</span><br><span>             /* =
examine additional subnets on gateway interface */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            size_t i;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            for (i =3D 0; i &lt; rgi-&gt;n_add=
rs; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 for (int i =3D 0; i &lt; rgi-&gt;n_addrs; ++i)</span><br><span>           =
  {</span><br><span>                 const struct route_gateway_address *gw=
a =3D &amp;rgi-&gt;addrs[i];</span><br><span>                 if (((network=
 ^ gwa-&gt;addr) &amp; gwa-&gt;netmask) =3D=3D 0)</span><br><span>diff --gi=
t a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</sp=
an><br><span>index 4c29bc8..ad5479c 100644</span><br><span>--- a/src/openvp=
n/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=
.c</span><br><span>@@ -573,7 +573,6 @@</span><br><span> void</span><br><spa=
n> x509_setenv(struct env_set *es, int cert_depth, mbedtls_x509_crt *cert)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 int i;</span><br><span>     unsigned char c;</span><br><span>     const mb=
edtls_x509_name *name;</span><br><span>     char s[128] =3D { 0 };</span><b=
r><span>@@ -594,9 +593,10 @@</span><br><span>             snprintf(name_exp=
and, sizeof(name_expand), &quot;X509_%d_\?\?&quot;, cert_depth);</span><br>=
<span>         }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        size_t i;</span><br><span>         for (i =3D 0; i &=
lt; name-&gt;val.len; i++)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (i &gt;=3D (int)sizeof(s) - =
1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (i=
 &gt;=3D sizeof(s) - 1)</span><br><span>             {</span><br><span>    =
             break;</span><br><span>             }</span><br><span>diff --g=
it a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><b=
r><span>index ad19e2c..4fa4889 100644</span><br><span>--- a/src/openvpnserv=
/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><b=
r><span>@@ -1269,7 +1269,7 @@</span><br><span>     if (!err || err =3D=3D E=
RROR_MORE_DATA)</span><br><span>     {</span><br><span>         data[sizeof=
(data) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        for (int i =3D 0; i &lt; strlen(data); ++i)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        for (size_t i =3D 0; i &lt;=
 strlen(data); ++i)</span><br><span>         {</span><br><span>            =
 if (isalnum(data[i]) || data[i] =3D=3D &#39;-&#39; || data[i] =3D=3D &#39;=
.&#39;)</span><br><span>             {</span><br><span>@@ -1954,7 +1954,7 @=
@</span><br><span> SetNameServerAddresses(PWSTR itf_id, const nrpt_address_=
t *addresses)</span><br><span> {</span><br><span>     const short families[=
] =3D { AF_INET, AF_INET6 };</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    for (int i =3D 0; i &lt; _countof(families); i++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; _c=
ountof(families); i++)</span><br><span>     {</span><br><span>         shor=
t family =3D families[i];</span><br><span> </span><br><span>@@ -2436,7 +243=
6,7 @@</span><br><span>         if (v4_addrs_size || v6_addrs_size)</span><=
br><span>         {</span><br><span>             /* Replace delimiters with=
 semicolons, as required by NRPT */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            for (int j =3D 0; j &lt; sizeof(data[0].addresses=
) &amp;&amp; data[i].addresses[j]; j++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            for (size_t j =3D 0; j &lt; sizeof(data[0].=
addresses) &amp;&amp; data[i].addresses[j]; j++)</span><br><span>          =
   {</span><br><span>                 if (data[i].addresses[j] =3D=3D &#39;=
,&#39; || data[i].addresses[j] =3D=3D &#39; &#39;)</span><br><span>        =
         {</span><br><span>@@ -2567,7 +2567,7 @@</span><br><span>     GetNr=
ptExcludeData(search_domains, data, _countof(data));</span><br><span> </spa=
n><br><span>     unsigned n =3D 0;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    for (int i =3D 0; i &lt; _countof(data); ++i)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; =
_countof(data); ++i)</span><br><span>     {</span><br><span>         nrpt_e=
xclude_data_t *d =3D &amp;data[i];</span><br><span>         if (d-&gt;domai=
ns_size =3D=3D 0)</span><br><span>diff --git a/src/plugins/down-root/down-r=
oot.c b/src/plugins/down-root/down-root.c</span><br><span>index c0ea7a6..cd=
57189 100644</span><br><span>--- a/src/plugins/down-root/down-root.c</span>=
<br><span>+++ b/src/plugins/down-root/down-root.c</span><br><span>@@ -318,7=
 +318,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /*=
 Ignore argv[0], as it contains just the plug-in file name */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 1; i &lt; string=
_array_len(argv); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (size_t i =3D 1; i &lt; string_array_len(argv); i++)</span><br><=
span>     {</span><br><span>         context-&gt;command[i - 1] =3D (char *=
)argv[i];</span><br><span>     }</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c</span><br><s=
pan>index 25c0371..b1e3261 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_argv.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_argv.=
c</span><br><span>@@ -120,7 +120,6 @@</span><br><span> static void</span><b=
r><span> argv_printf__long_args__data_correct(void **state)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><=
br><span>     struct argv a =3D argv_new();</span><br><span>     const char=
 *args[] =3D {</span><br><span>         &quot;good_tools_have_good_names_ev=
en_though_it_might_impair_typing&quot;,</span><br><span>@@ -131,7 +130,7 @@=
</span><br><span> </span><br><span>     argv_printf(&amp;a, &quot;%s %s %s =
%s&quot;, args[0], args[1], args[2], args[3]);</span><br><span>     assert_=
int_equal(a.argc, 4);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (i =3D 0; i &lt; a.argc; i++)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (size_t i =3D 0; i &lt; a.argc; i++)</span><br><s=
pan>     {</span><br><span>         assert_string_equal(a.argv[i], args[i])=
;</span><br><span>     }</span><br><span>@@ -229,12 +228,11 @@</span><br><s=
pan> {</span><br><span>     struct argv a =3D argv_new();</span><br><span> =
    struct argv b;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 int i;</span><br><span> </span><br><span>     argv_printf(&amp;a, &quot;%s=
&quot;, PATH2);</span><br><span>     b =3D argv_insert_head(&amp;a, PATH1);=
</span><br><span>     assert_int_equal(b.argc, a.argc + 1);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; b.argc; i++)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =
=3D 0; i &lt; b.argc; i++)</span><br><span>     {</span><br><span>         =
if (i =3D=3D 0)</span><br><span>         {</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.=
c</span><br><span>index a1d7ddd..3d3e53a 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_crypto.c</span><br><span>@@ -101,7 +101,7 @@</span><br><span>   =
  char *lower =3D string_alloc(ciphername, &amp;gc);</span><br><span>     c=
har *random_case =3D string_alloc(ciphername, &amp;gc);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i=
 &lt; strlen(ciphername); i++)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    for (size_t i =3D 0; i &lt; strlen(ciphername); i++)</span><=
br><span>     {</span><br><span>         upper[i] =3D (char)toupper((unsign=
ed char)ciphername[i]);</span><br><span>         lower[i] =3D (char)tolower=
((unsigned char)ciphername[i]);</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c</sp=
an><br><span>index 4b5baf8..ce527d7 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_cryptoapi.c</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_cryptoapi.c</span><br><span>@@ -467,7 +467,7 @@</span><br><span>  =
   unsigned char hash[255];</span><br><span>     (void)state;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =
=3D 0; i &lt; _countof(valid_str); i++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; _countof(valid_str); i+=
+)</span><br><span>     {</span><br><span>         int len =3D parse_hexstr=
ing(valid_str[i], hash, _countof(hash));</span><br><span>         assert_in=
t_equal(len, sizeof(test_hash));</span><br><span>@@ -475,7 +475,7 @@</span>=
<br><span>         memset(hash, 0, _countof(hash));</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for (int i =3D 0; i &lt; _countof(invalid_str); i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; _countof(=
invalid_str); i++)</span><br><span>     {</span><br><span>         int len =
=3D parse_hexstring(invalid_str[i], hash, _countof(hash));</span><br><span>=
         assert_int_equal(len, 0);</span><br><span>diff --git a/tests/unit_=
tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><s=
pan>index ca62b38..fc2c0a1 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c<=
/span><br><span>@@ -236,7 +236,7 @@</span><br><span>     free_tls_pre_decry=
pt_state(&amp;state);</span><br><span> </span><br><span>     /* flip a byte=
 in various places */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (int i =3D 0; i &lt; sizeof(client_reset_v2_tls_crypt); i++)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i=
 &lt; sizeof(client_reset_v2_tls_crypt); i++)</span><br><span>     {</span>=
<br><span>         buf_reset_len(&amp;buf);</span><br><span>         buf_wr=
ite(&amp;buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_tls_crypt))=
;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/=
unit_tests/openvpn/test_ssl.c</span><br><span>index 8ef9a3d..153aa77 100644=
</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>=
+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -620,7 +620,7 =
@@</span><br><span>      * Statickey but XOR it to not repeat it */</span><=
br><span>     uint8_t keydata[sizeof(key2.keys)];</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; =
sizeof(key2.keys); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (size_t i =3D 0; i &lt; sizeof(key2.keys); i++)</span><br><span=
>     {</span><br><span>         keydata[i] =3D (uint8_t)(key[i % sizeof(ke=
y)] ^ i);</span><br><span>     }</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1491?usp=3Demail"=
>change 1491</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1491?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib6c3e154fbe14113ff990f13347=
f85a7c93dd3e0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1491 </div>
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

--3fNT0GOfV+8=--

