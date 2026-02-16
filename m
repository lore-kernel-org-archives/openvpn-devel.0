From: Gert Doering <gert@...1296...>
Date: Mon, 16 Feb 2026 22:27:56 +0100
Message-ID: <20260216212805.7808-1-gert@...1296...>
In-Reply-To: <gerrit.1769450543000.Ib6c3e154fbe14113ff990f13347f85a7c93dd3e0@...2715...>
References: <gerrit.1769450543000.Ib6c3e154fbe14113ff990f13347f85a7c93dd3e0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Fix various loop index types to avoid
 sign-compare issues
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

From: Frank Lichtenheld <frank@...2641...>

Just uses the correct types i.e. the same as the limit.
Since the index is usually only used as a non-negative
array index the type change does not cause any behavioral
changes.

But it avoids -Wsign-compare complaints and is just
cleaner.

Change-Id: Ib6c3e154fbe14113ff990f13347f85a7c93dd3e0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1491
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1491
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 922ece0..8e37115 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -293,7 +293,7 @@
 
     bool in_token = false;
     char *f = gc_malloc(strlen(format) + 1, true, gc);
-    for (int i = 0, j = 0; i < strlen(format); i++)
+    for (size_t i = 0, j = 0; i < strlen(format); i++)
     {
         if (format[i] == ' ')
         {
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 0c6de18..a8507c2 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -411,7 +411,7 @@
 
     printf("\nThe following ciphers have a block size of less than 128 bits, \n"
            "and are therefore deprecated.  Do not use unless you have to.\n\n");
-    for (int i = 0; i < cipher_list.num; i++)
+    for (size_t i = 0; i < cipher_list.num; i++)
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
-    for (int i = 0; i < bytes_returned / sizeof(OVPN_PEER_STATS); ++i)
+    for (size_t i = 0; i < bytes_returned / sizeof(OVPN_PEER_STATS); ++i)
     {
         OVPN_PEER_STATS *stat = &peer_stats[i];
 
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 99092fb..03b9efb 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -785,7 +785,7 @@
     {
         msg(D_SHOW_PARMS, "  DNS server #%d:", i++);
 
-        for (int j = 0; j < server->addr_count; ++j)
+        for (size_t j = 0; j < server->addr_count; ++j)
         {
             const char *addr;
             const char *fmt_port;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cdb02e9..ea05ef0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3536,7 +3536,7 @@
     while (s)
     {
         bool non_standard_server_port = false;
-        for (int i = 0; i < s->addr_count; ++i)
+        for (size_t i = 0; i < s->addr_count; ++i)
         {
             if (s->addr[i].port && s->addr[i].port != 53)
             {
@@ -3553,7 +3553,7 @@
         else
         {
             bool overflow = false;
-            for (int i = 0; i < s->addr_count; ++i)
+            for (size_t i = 0; i < s->addr_count; ++i)
             {
                 if (s->addr[i].family == AF_INET && tt->dns_len + 1 < N_DHCP_ADDR)
                 {
@@ -3653,7 +3653,7 @@
             new->name = dhcp->domain;
             entry = &new->next;
 
-            for (size_t i = 0; i < dhcp->domain_search_list_len; ++i)
+            for (int i = 0; i < dhcp->domain_search_list_len; ++i)
             {
                 ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
                 struct dns_domain *new = *entry;
@@ -3663,13 +3663,13 @@
 
             struct dns_server *server = dns_server_get(&dns->servers, 0, &dns->gc);
             const size_t max_addrs = SIZE(server->addr);
-            for (size_t i = 0; i < dhcp->dns_len && server->addr_count < max_addrs; ++i)
+            for (int i = 0; i < dhcp->dns_len && server->addr_count < max_addrs; ++i)
             {
                 server->addr[server->addr_count].in.a4.s_addr = htonl(dhcp->dns[i]);
                 server->addr[server->addr_count].family = AF_INET;
                 server->addr_count += 1;
             }
-            for (size_t i = 0; i < dhcp->dns6_len && server->addr_count < max_addrs; ++i)
+            for (int i = 0; i < dhcp->dns6_len && server->addr_count < max_addrs; ++i)
             {
                 server->addr[server->addr_count].in.a6 = dhcp->dns6[i];
                 server->addr[server->addr_count].family = AF_INET6;
@@ -3691,7 +3691,7 @@
         while (s)
         {
             bool non_standard_server_port = false;
-            for (int i = 0; i < s->addr_count; ++i)
+            for (size_t i = 0; i < s->addr_count; ++i)
             {
                 if (s->addr[i].port && s->addr[i].port != 53)
                 {
@@ -3707,7 +3707,7 @@
             }
             else
             {
-                for (int i = 0; i < s->addr_count; ++i)
+                for (size_t i = 0; i < s->addr_count; ++i)
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
-    for (size_t i = 0; i < rl->rgi.n_addrs; ++i)
+    for (int i = 0; i < rl->rgi.n_addrs; ++i)
     {
         const struct route_gateway_address *gwa = &rl->rgi.addrs[i];
         /* omit the add/subnet in &rl->rgi which we processed above */
@@ -1452,8 +1452,7 @@
         else
         {
             /* examine additional subnets on gateway interface */
-            size_t i;
-            for (i = 0; i < rgi->n_addrs; ++i)
+            for (int i = 0; i < rgi->n_addrs; ++i)
             {
                 const struct route_gateway_address *gwa = &rgi->addrs[i];
                 if (((network ^ gwa->addr) & gwa->netmask) == 0)
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
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
     char s[128] = { 0 };
@@ -594,9 +593,10 @@
             snprintf(name_expand, sizeof(name_expand), "X509_%d_\?\?", cert_depth);
         }
 
+        size_t i;
         for (i = 0; i < name->val.len; i++)
         {
-            if (i >= (int)sizeof(s) - 1)
+            if (i >= sizeof(s) - 1)
             {
                 break;
             }
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ad19e2c..4fa4889 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1269,7 +1269,7 @@
     if (!err || err == ERROR_MORE_DATA)
     {
         data[sizeof(data) - 1] = '\0';
-        for (int i = 0; i < strlen(data); ++i)
+        for (size_t i = 0; i < strlen(data); ++i)
         {
             if (isalnum(data[i]) || data[i] == '-' || data[i] == '.')
             {
@@ -1954,7 +1954,7 @@
 SetNameServerAddresses(PWSTR itf_id, const nrpt_address_t *addresses)
 {
     const short families[] = { AF_INET, AF_INET6 };
-    for (int i = 0; i < _countof(families); i++)
+    for (size_t i = 0; i < _countof(families); i++)
     {
         short family = families[i];
 
@@ -2436,7 +2436,7 @@
         if (v4_addrs_size || v6_addrs_size)
         {
             /* Replace delimiters with semicolons, as required by NRPT */
-            for (int j = 0; j < sizeof(data[0].addresses) && data[i].addresses[j]; j++)
+            for (size_t j = 0; j < sizeof(data[0].addresses) && data[i].addresses[j]; j++)
             {
                 if (data[i].addresses[j] == ',' || data[i].addresses[j] == ' ')
                 {
@@ -2567,7 +2567,7 @@
     GetNrptExcludeData(search_domains, data, _countof(data));
 
     unsigned n = 0;
-    for (int i = 0; i < _countof(data); ++i)
+    for (size_t i = 0; i < _countof(data); ++i)
     {
         nrpt_exclude_data_t *d = &data[i];
         if (d->domains_size == 0)
diff --git a/src/plugins/down-root/down-root.c b/src/plugins/down-root/down-root.c
index c0ea7a6..cd57189 100644
--- a/src/plugins/down-root/down-root.c
+++ b/src/plugins/down-root/down-root.c
@@ -318,7 +318,7 @@
     }
 
     /* Ignore argv[0], as it contains just the plug-in file name */
-    for (int i = 1; i < string_array_len(argv); i++)
+    for (size_t i = 1; i < string_array_len(argv); i++)
     {
         context->command[i - 1] = (char *)argv[i];
     }
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 25c0371..b1e3261 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -120,7 +120,6 @@
 static void
 argv_printf__long_args__data_correct(void **state)
 {
-    int i;
     struct argv a = argv_new();
     const char *args[] = {
         "good_tools_have_good_names_even_though_it_might_impair_typing",
@@ -131,7 +130,7 @@
 
     argv_printf(&a, "%s %s %s %s", args[0], args[1], args[2], args[3]);
     assert_int_equal(a.argc, 4);
-    for (i = 0; i < a.argc; i++)
+    for (size_t i = 0; i < a.argc; i++)
     {
         assert_string_equal(a.argv[i], args[i]);
     }
@@ -229,12 +228,11 @@
 {
     struct argv a = argv_new();
     struct argv b;
-    int i;
 
     argv_printf(&a, "%s", PATH2);
     b = argv_insert_head(&a, PATH1);
     assert_int_equal(b.argc, a.argc + 1);
-    for (i = 0; i < b.argc; i++)
+    for (size_t i = 0; i < b.argc; i++)
     {
         if (i == 0)
         {
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index a1d7ddd..3d3e53a 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -101,7 +101,7 @@
     char *lower = string_alloc(ciphername, &gc);
     char *random_case = string_alloc(ciphername, &gc);
 
-    for (int i = 0; i < strlen(ciphername); i++)
+    for (size_t i = 0; i < strlen(ciphername); i++)
     {
         upper[i] = (char)toupper((unsigned char)ciphername[i]);
         lower[i] = (char)tolower((unsigned char)ciphername[i]);
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 4b5baf8..ce527d7 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -467,7 +467,7 @@
     unsigned char hash[255];
     (void)state;
 
-    for (int i = 0; i < _countof(valid_str); i++)
+    for (size_t i = 0; i < _countof(valid_str); i++)
     {
         int len = parse_hexstring(valid_str[i], hash, _countof(hash));
         assert_int_equal(len, sizeof(test_hash));
@@ -475,7 +475,7 @@
         memset(hash, 0, _countof(hash));
     }
 
-    for (int i = 0; i < _countof(invalid_str); i++)
+    for (size_t i = 0; i < _countof(invalid_str); i++)
     {
         int len = parse_hexstring(invalid_str[i], hash, _countof(hash));
         assert_int_equal(len, 0);
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index ca62b38..fc2c0a1 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -236,7 +236,7 @@
     free_tls_pre_decrypt_state(&state);
 
     /* flip a byte in various places */
-    for (int i = 0; i < sizeof(client_reset_v2_tls_crypt); i++)
+    for (size_t i = 0; i < sizeof(client_reset_v2_tls_crypt); i++)
     {
         buf_reset_len(&buf);
         buf_write(&buf, client_reset_v2_tls_crypt, sizeof(client_reset_v2_tls_crypt));
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 8ef9a3d..153aa77 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -620,7 +620,7 @@
      * Statickey but XOR it to not repeat it */
     uint8_t keydata[sizeof(key2.keys)];
 
-    for (int i = 0; i < sizeof(key2.keys); i++)
+    for (size_t i = 0; i < sizeof(key2.keys); i++)
     {
         keydata[i] = (uint8_t)(key[i % sizeof(key)] ^ i);
     }

