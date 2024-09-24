From: Gert Doering <gert@...1296...>
Date: Tue, 24 Sep 2024 14:55:13 +0200
Message-ID: <20240924125513.10710-1-gert@...1296...>
In-Reply-To: <gerrit.1726491830000.Ib8f12516dbe294e21d3fed77478fb7660d4600c1@...2715...>
References: <gerrit.1726491830000.Ib8f12516dbe294e21d3fed77478fb7660d4600c1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Use print_tun_backend_driver instead of
 custom code to print type
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

Also show the device type that we opened always instead of certain
conditions only.

Change-Id: Ib8f12516dbe294e21d3fed77478fb7660d4600c1
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/749
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fbf2c5b..cd9203a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1876,6 +1876,7 @@
         open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
                  tt, &c->net_ctx);
     }
+    msg(M_INFO, "%s device [%s] opened", print_tun_backend_driver(tt->backend_driver), tt->actual_name);
 }
 
 
@@ -2056,7 +2057,7 @@
 do_close_tun_simple(struct context *c)
 {
     msg(D_CLOSE, "Closing %s interface",
-        dco_enabled(&c->options) ? "DCO" : "TUN/TAP");
+        print_tun_backend_driver(c->c1.tuntap->backend_driver));
 
     if (c->c1.tuntap)
     {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 770e806..206ddc0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6678,7 +6678,6 @@
      * GUID using the registry */
     tt->actual_name = string_alloc((const char *)actual_buffer, NULL);
 
-    msg(M_INFO, "%s device [%s] opened", print_tun_backend_driver(tt->backend_driver), tt->actual_name);
     tt->adapter_index = get_adapter_index(*device_guid);
 }
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index b2c1b01..329cd10 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -361,6 +361,12 @@
 
 void warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx);
 
+/**
+ * Return a string representation of the tun backed driver type
+ */
+const char *
+print_tun_backend_driver(enum tun_driver_type driver);
+
 /*
  * Should ifconfig be called before or after
  * tun dev open?
@@ -689,9 +695,6 @@
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() == ERROR_NETNAME_DELETED);
 }
 
-const char *
-print_tun_backend_driver(enum tun_driver_type driver);
-
 #else  /* ifdef _WIN32 */
 
 static inline bool

