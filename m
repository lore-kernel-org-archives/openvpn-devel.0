From: Gert Doering <gert@...1296...>
Date: Mon, 22 Jul 2024 14:10:34 +0200
Message-ID: <20240722121034.10816-1-gert@...1296...>
In-Reply-To: <gerrit.1721648146000.Ic27d84c74c1dd6ff7973ca6966d186f475c67e21@...2715...>
References: <gerrit.1721648146000.Ic27d84c74c1dd6ff7973ca6966d186f475c67e21@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix missing spaces in various messages
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

These result from broken up literals where it
is easy to miss the missing space.

Change-Id: Ic27d84c74c1dd6ff7973ca6966d186f475c67e21
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/679
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 78243b1..7f0d53d 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -185,7 +185,7 @@
         }
         else
         {
-            msg(D_DCO_DEBUG, "Swapping primary and secondary keys to"
+            msg(D_DCO_DEBUG, "Swapping primary and secondary keys to "
                 "primary-id=%d secondary-id=(to be deleted)",
                 primary->key_id);
         }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 162b23e..03177bb 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1804,7 +1804,7 @@
     }
     else if (dco_enabled(o))
     {
-        msg(M_INFO, "Client does not support DATA_V2. Data channel offloaing "
+        msg(M_INFO, "Client does not support DATA_V2. Data channel offloading "
             "requires DATA_V2. Dropping client.");
         auth_set_client_reason(tls_multi, "Data channel negotiation "
                                "failed (missing DATA_V2)");
@@ -1815,7 +1815,7 @@
      * not accept our pushed ciphers */
     if (proto & IV_PROTO_NCP_P2P)
     {
-        msg(M_WARN, "Note: peer reports running in P2P mode (no --pull/--client"
+        msg(M_WARN, "Note: peer reports running in P2P mode (no --pull/--client "
             "option). It will not negotiate ciphers with this server. "
             "Expect this connection to fail.");
     }
@@ -2027,7 +2027,7 @@
         /* Not EOF but other error -> fall through to error state */
         default:
             /* We received an unknown/unexpected value.  Assume failure. */
-            msg(M_WARN, "WARNING: Unknown/unexpected value in deferred"
+            msg(M_WARN, "WARNING: Unknown/unexpected value in deferred "
                 "client-connect resultfile");
             ret = CC_RET_FAILED;
     }
@@ -2427,7 +2427,7 @@
      */
     if (!mi->context.c2.push_ifconfig_defined)
     {
-        msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote"
+        msg(D_MULTI_ERRORS, "MULTI: no dynamic or static remote "
             "--ifconfig address is available for %s",
             multi_instance_string(mi, false, &gc));
     }
@@ -2443,7 +2443,7 @@
             print_in_addr_t(mi->context.options.push_ifconfig_constraint_netmask, 0, &gc);
 
         /* JYFIXME -- this should cause the connection to fail */
-        msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s)"
+        msg(D_MULTI_ERRORS, "MULTI ERROR: primary virtual IP for %s (%s) "
             "violates tunnel network/netmask constraint (%s/%s)",
             multi_instance_string(mi, false, &gc),
             print_in_addr_t(mi->context.c2.push_ifconfig_local, 0, &gc),
@@ -2492,7 +2492,7 @@
     }
     else if (mi->context.options.iroutes)
     {
-        msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute"
+        msg(D_MULTI_ERRORS, "MULTI: --iroute options rejected for %s -- iroute "
             "only works with tun-style tunnels",
             multi_instance_string(mi, false, &gc));
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 64e67aa..ba9b05e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7033,7 +7033,7 @@
     }
     else if (streq(p[0], "max-routes") && !p[2])
     {
-        msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored."
+        msg(M_WARN, "DEPRECATED OPTION: --max-routes option ignored. "
             "The number of routes is unlimited as of OpenVPN 2.4. "
             "This option will be removed in a future version, "
             "please remove it from your configuration.");
@@ -9328,7 +9328,7 @@
                         s++;
                     }
                     msg(M_WARN, "DEPRECATED FEATURE: automatically upcased the "
-                        "--x509-username-field parameter to '%s'; please update your"
+                        "--x509-username-field parameter to '%s'; please update your "
                         "configuration", p[j]);
                 }
             }
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 934ff8d..0b0e2c3 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -717,7 +717,7 @@
         {
             const char *hex_fp = format_hex_ex(BPTR(&cert_fp), BLEN(&cert_fp),
                                                0, 1, ":", &gc);
-            msg(D_TLS_ERRORS, "TLS Error: --tls-verify/--peer-fingerprint"
+            msg(D_TLS_ERRORS, "TLS Error: --tls-verify/--peer-fingerprint "
                 "certificate hash verification failed. (got certificate "
                 "fingerprint: %s)", hex_fp);
             goto cleanup;

