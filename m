From: Fabian Knittel <fabian.knittel@...1338...>
Date: Wed, 31 Mar 2010 23:58:16 +0200
Message-Id: <70dd1e1441bb32df36f449920384f20a3683a2f0.1270060247.git.fabian.knittel@...1338...>
In-Reply-To: <cover.1270060247.git.fabian.knittel@...1338...>
References: <cover.1270060247.git.fabian.knittel@...1338...>
Subject: [Openvpn-devel] [PATCH 3/9] vlan: Add per-client --vlan-tag option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This patch adds the new "--vlan-tag" integer option.  The option is valid
in server mode and can be set in a client context (e.g. from the client-connect
hook).  It defaults to 0.

The value indicates which VID (VLAN identifier) to associate with a client.
The client will only receive packets which belong to the same VLAN.  Packets
going out via the tap devie will be marked as belonging to the indicated VID.

The option has no immediate effect yet, but will be used by later patches.
---
 options.c |   25 +++++++++++++++++++++++--
 options.h |    1 +
 proto.h   |    4 ++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/options.c b/options.c
index 506fb49..aaf92f0 100644
--- a/options.c
+++ b/options.c
@@ -1178,6 +1178,7 @@ show_settings (const struct options *o)
   SHOW_BOOL (ifconfig_nowarn);
 
   SHOW_BOOL (vlan_tagging);
+  SHOW_INT (vlan_tag);
 
 #ifdef HAVE_GETTIMEOFDAY
   SHOW_INT (shaper);
@@ -1748,6 +1749,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	  msg (M_USAGE, "--script-security method='system' cannot be combined with --no-name-remapping");
       if (options->vlan_tagging && dev != DEV_TYPE_TAP)
 	msg (M_USAGE, "--vlan-tagging only works with --dev tap");
+      if (!options->vlan_tagging && options->vlan_tag)
+	msg (M_USAGE, "--vlan-tag must be used with activated --vlan-tagging");
     }
   else
     {
@@ -1794,8 +1797,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (options->port_share_host || options->port_share_port)
 	msg (M_USAGE, "--port-share requires TCP server mode (--mode server --proto tcp-server)");
 #endif
-      if (options->vlan_tagging)
-	msg (M_USAGE, "--vlan-tagging requires --mode server");
+      if (options->vlan_tagging || options->vlan_tag)
+	msg (M_USAGE, "--vlan-tagging/--vlan-tag requires --mode server");
 
     }
 #endif /* P2MP_SERVER */
@@ -5743,6 +5746,24 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->vlan_tagging = true;
     }
+  else if (streq (p[0], "vlan-tag"))
+    {
+      VERIFY_PERMISSION (OPT_P_INSTANCE);
+      if (p[1])
+	{
+	  options->vlan_tag = positive_atoi (p[1]);
+	  if (options->vlan_tag < OPENVPN_8021Q_MIN_VID || options->vlan_tag > OPENVPN_8021Q_MAX_VID)
+	    {
+	      msg (msglevel, "the parameter of --vlan-tag parameters must be >= %d and <= %d", OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
+	      goto err;
+	    }
+	}
+      else
+	{
+	  msg (msglevel, "error parsing --vlan-tag parameters");
+	  goto err;
+	}
+    }
   else
     {
       if (file)
diff --git a/options.h b/options.h
index 49fa596..f4ca502 100644
--- a/options.h
+++ b/options.h
@@ -511,6 +511,7 @@ struct options
 #endif
 
   bool vlan_tagging;
+  int vlan_tag;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/proto.h b/proto.h
index 628e991..f26cbc0 100644
--- a/proto.h
+++ b/proto.h
@@ -211,4 +211,8 @@ void ipv4_packet_size_verify (const uint8_t *data,
 			      counter_type *errors);
 #endif
 
+
+#define OPENVPN_8021Q_MIN_VID 1
+#define OPENVPN_8021Q_MAX_VID 0xFFFE
+
 #endif
-- 
1.7.0


