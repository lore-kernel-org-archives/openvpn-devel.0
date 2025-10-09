From: Gert Doering <gert@...1296...>
Date: Thu,  9 Oct 2025 22:59:46 +0200
Message-ID: <20251009205951.32301-1-gert@...1296...>
In-Reply-To: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
References: <gerrit.1755877911000.Id440917f433aab1a7db608ba04fa95ba47c2ddde@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] options: Review use of positive_atoi vs
 atoi_constrained
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

Replace where it is useful.

While here also add a missing cast in atoi_constrained.

Change-Id: Id440917f433aab1a7db608ba04fa95ba47c2ddde
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1153
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1153
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f2e6dec..e6e0b6f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6415,21 +6415,15 @@
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        int max_mtu = positive_atoi(p[1], msglevel);
-        if (max_mtu < 68 || max_mtu > 65536)
-        {
-            msg(msglevel, "--tun-mtu-max value '%s' is invalid", p[1]);
-        }
-        else
-        {
-            options->ce.tun_mtu_max = max_mtu;
-        }
+        atoi_constrained(p[1], &options->ce.tun_mtu_max, p[0], TUN_MTU_MAX_MIN, 65536, msglevel);
     }
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        options->ce.tun_mtu_extra = positive_atoi(p[1], msglevel);
-        options->ce.tun_mtu_extra_defined = true;
+        if (atoi_constrained(p[1], &options->ce.tun_mtu_extra, p[0], 0, 65536, msglevel))
+        {
+            options->ce.tun_mtu_extra_defined = true;
+        }
     }
     else if (streq(p[0], "max-packet-size") && p[1] && !p[2])
     {
@@ -6461,11 +6455,8 @@
     else if (streq(p[0], "fragment") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU | OPT_P_CONNECTION);
-        options->ce.fragment = positive_atoi(p[1], msglevel);
-
-        if (options->ce.fragment < 68)
+        if (!atoi_constrained(p[1], &options->ce.fragment, p[0], 68, INT_MAX, msglevel))
         {
-            msg(msglevel, "--fragment needs to be at least 68");
             goto err;
         }
 
@@ -7139,12 +7130,14 @@
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
         if (p[1])
         {
-            int mssfix = positive_atoi(p[1], msglevel);
-            /* can be 0, but otherwise it needs to be high enough so we can
-             * substract room for headers. */
-            if (mssfix != 0 && (mssfix < TLS_CHANNEL_MTU_MIN || mssfix > UINT16_MAX))
+            int mssfix;
+            if (!atoi_constrained(p[1], &mssfix, p[0], 0, UINT16_MAX, msglevel))
             {
-                msg(msglevel, "--mssfix value '%s' is invalid", p[1]);
+                goto err;
+            }
+            if (mssfix != 0 && mssfix < TLS_CHANNEL_MTU_MIN)
+            {
+                msg(msglevel, "mssfix needs to be >= %d, not %d", TLS_CHANNEL_MTU_MIN, mssfix);
                 goto err;
             }
 
@@ -7397,7 +7390,7 @@
     else if (streq(p[0], "max-routes-per-client") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INHERIT);
-        options->max_routes_per_client = max_int(positive_atoi(p[1], msglevel), 1);
+        atoi_constrained(p[1], &options->max_routes_per_client, p[0], 1, INT_MAX, msglevel);
     }
     else if (streq(p[0], "client-cert-not-required") && !p[1])
     {
@@ -9216,8 +9209,6 @@
     }
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
-        int ekm_length = positive_atoi(p[2], msglevel);
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
         if (strncmp(p[1], "EXPORTER", 8))
@@ -9231,14 +9222,14 @@
             msg(msglevel,
                 "Keying material exporter label must not be '" EXPORT_KEY_DATA_LABEL "'.");
         }
-        if (ekm_length < 16 || ekm_length > 4095)
+
+        if (!atoi_constrained(p[2], &options->keying_material_exporter_length,
+                              p[0], 16, 4095, msglevel))
         {
-            msg(msglevel, "Invalid keying material exporter length");
             goto err;
         }
 
         options->keying_material_exporter_label = p[1];
-        options->keying_material_exporter_length = ekm_length;
     }
     else if (streq(p[0], "allow-recursive-routing") && !p[1])
     {
@@ -9273,15 +9264,14 @@
     }
     else if (streq(p[0], "vlan-pvid") && p[1] && !p[2])
     {
+        int vlan_pvid;
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_INSTANCE);
-        options->vlan_pvid = positive_atoi(p[1], msglevel);
-        if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID
-            || options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
+        if (!atoi_constrained(p[1], &vlan_pvid, p[0],
+                              OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID, msglevel))
         {
-            msg(msglevel, "the parameter of --vlan-pvid parameters must be >= %u and <= %u",
-                OPENVPN_8021Q_MIN_VID, OPENVPN_8021Q_MAX_VID);
             goto err;
         }
+        options->vlan_pvid = (uint16_t)vlan_pvid;
     }
     else
     {

