From: Mike Auty <mike.auty@...277...>
Message-ID: <57016640.1060208@...277...>
Date: Sun, 3 Apr 2016 19:51:44 +0100
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/7] vlan: Add global,
	per-client 802.1q-based options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch add the new global "--vlan-tagging" boolean switch.  This specifies
whether openvpn should handle 802.1q tagged packets in any way.

This patch also adds the new global '--vlan-accept tagged|untagged|all' which
specifies the behaviour of the tap device with regards to 802.1q vlan tagged
packets.

This patch also adds the new "--vlan-pvid" integer option.  The option is valid
in server mode and can be set in a client context (e.g. from the client-connect
hook).  It defaults to 1.

 The value indicates which VID (VLAN identifier) to associate with a client
 or (in global context) with the tap device.
 It also serves as the Port VLAN Identifier, i.e. the VID to use for incoming
 and outgoing untagged or priority-tagged frames.

 The client will only receive packets which belong to the same VLAN.

These options have no immediate effect yet, but will be used by later patches.

Patch authored by Fabian Knittel <fabian.knittel@...2126...>.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/options.c | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 02def3a..7616f23 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -477,6 +477,11 @@ static const char usage_message[] =
   "                  sessions to a web server at host:port.  dir specifies an\n"
   "                  optional directory to write origin IP:port data.\n"
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+  "--vlan-tagging  : Enable 802.1Q-based VLAN tagging.\n"
+  "--vlan-accept tagged|untagged|all : Set VLAN tagging mode. Default is 'all'.\n"
+  "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
+#endif
 #endif
   "\n"
   "Client options (when connecting to a multi-client server):\n"
@@ -852,6 +857,10 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_PKCS11
   o->pkcs11_pin_cache_period = -1;
 #endif			/* ENABLE_PKCS11 */
+#ifdef ENABLE_VLAN_TAGGING
+  o->vlan_accept = VAF_ALL;
+  o->vlan_pvid = 1;
+#endif
 
 /* tmp is only used in P2MP server context */
 #if P2MP_SERVER
@@ -1160,6 +1169,23 @@ dhcp_option_address_parse (const char *name, const char *parm, in_addr_t *array,
 
 #endif
 
+#ifdef ENABLE_VLAN_TAGGING
+static const char *
+print_vlan_accept (enum vlan_acceptable_frames mode)
+{
+  switch (mode)
+   {
+    case VAF_ONLY_VLAN_TAGGED:
+      return "tagged";
+    case VAF_ONLY_UNTAGGED_OR_PRIORITY:
+      return "untagged";
+    case VAF_ALL:
+      return "all";
+   }
+  return NULL;
+}
+#endif
+
 #if P2MP
 
 #ifndef ENABLE_SMALL
@@ -1225,6 +1251,11 @@ show_p2mp_parms (const struct options *o)
   SHOW_STR (port_share_host);
   SHOW_STR (port_share_port);
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+  SHOW_BOOL (vlan_tagging);
+  msg (D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept (o->vlan_accept));
+  SHOW_INT (vlan_pvid);
+#endif
 #endif /* P2MP_SERVER */
 
   SHOW_BOOL (client);
@@ -2076,6 +2107,17 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	  if ((options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) && !ccnr)
 	    msg (M_USAGE, "--auth-user-pass-optional %s", postfix);
 	}
+#ifdef ENABLE_VLAN_TAGGING
+      if (options->vlan_tagging && dev != DEV_TYPE_TAP)
+	msg (M_USAGE, "--vlan-tagging must be used with --dev tap");
+      if (!options->vlan_tagging)
+	{
+	  if (options->vlan_accept != defaults.vlan_accept)
+	    msg (M_USAGE, "--vlan-accept requires --vlan-tagging");
+	  if (options->vlan_pvid != defaults.vlan_pvid)
+	    msg (M_USAGE, "--vlan-pvid requires --vlan-tagging");
+	}
+#endif
     }
   else
     {
@@ -2122,6 +2164,10 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (options->port_share_host || options->port_share_port)
 	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+      if (options->vlan_tagging)
+	msg (M_USAGE, "--vlan-tagging requires --mode server");
+#endif
 
       if (options->stale_routes_check_interval)
         msg (M_USAGE, "--stale-routes-check requires --mode server");
@@ -7178,6 +7224,45 @@ add_option (struct options *options,
       options->keying_material_exporter_length = ekm_length;
     }
 #endif
+#ifdef ENABLE_VLAN_TAGGING
+  else if (streq (p[0], "vlan-tagging"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->vlan_tagging = true;
+    }
+  else if (streq (p[0], "vlan-accept") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (streq (p[1], "tagged"))
+	{
+	  options->vlan_accept = VAF_ONLY_VLAN_TAGGED;
+	}
+      else if (streq (p[1], "untagged"))
+	{
+	  options->vlan_accept = VAF_ONLY_UNTAGGED_OR_PRIORITY;
+	}
+      else if (streq (p[1], "all"))
+	{
+	  options->vlan_accept = VAF_ALL;
+	}
+      else
+	{
+	  msg (msglevel, "--vlan-accept must be 'tagged', 'untagged' or 'all'");
+	  goto err;
+	}
+    }
+  else if (streq (p[0], "vlan-pvid") && p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL|OPT_P_INSTANCE);
+      options->vlan_pvid = positive_atoi (p[1]);
+      if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID ||
+	  options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
+	{
+	  msg (msglevel, "the parameter of --vlan-pvid parameters must be >= %u and <= %u", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
+	  goto err;
+	}
+    }
+#endif
   else
     {
       int i;
-- 
2.7.1

