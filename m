From: =?UTF-8?q?Ji=C5=99=C3=AD=20Engelthaler?= <EngyCZ@...277...>
Date: Tue,  5 Dec 2017 13:19:52 +0100
Message-Id: <20171205121952.13008-1-EngyCZ@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add a warning for disabled DHCP media sense
 on Window
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

When DHCP media sense configuration is disabled, network applications
including DHCP client will not receive information about link status
changes and the link seems to be always connected. This lead to the
non-renewal DHCP address on OpenVPN connect.

DHCP media sense status can by shown with command
"netsh interface ipv4 show global"

There are several reports of problems with DHCP address renewal.
https://community.openvpn.net/openvpn/ticket/665
https://community.openvpn.net/openvpn/ticket/807

Added checking of disabled DHCP media sense and print a warning with
forced dhcp-renew option and suggestion to enable DHCP media sense.

Signed-off-by: Jiří Engelthaler <EngyCZ@...277...>
---
 src/openvpn/tun.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 25831ce3..35811975 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -62,6 +62,8 @@
 #define NI_IP_NETMASK  (1<<1)
 #define NI_OPTIONS     (1<<2)
 
+#define TCPIP_PARAMS "SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters"
+
 static void netsh_ifconfig(const struct tuntap_options *to,
                            const char *flex_name,
                            const in_addr_t ip,
@@ -3827,6 +3829,56 @@ get_panel_reg(struct gc_arena *gc)
     return first;
 }
 
+/*
+ * Return DhcpMediaSense enabled value
+ */
+static bool
+get_dhcp_media_sense(void)
+{
+    HKEY tcpip_params;
+    LONG status;
+    DWORD len;
+    char  disable_dhcp_media_sense_string[] = "DisableDHCPMediaSense";
+    DWORD disable_dhcp_media_sense;
+    DWORD data_type;
+    bool ret_value = true;
+
+    status = RegOpenKeyEx(
+        HKEY_LOCAL_MACHINE,
+        TCPIP_PARAMS,
+        0,
+        KEY_READ,
+        &tcpip_params);
+    
+    if (status != ERROR_SUCCESS)
+    {
+        msg(M_WARN, "Error opening registry key: %s", TCPIP_PARAMS);
+    }
+    else
+    {
+        len = sizeof(disable_dhcp_media_sense);
+        status = RegQueryValueEx(
+            tcpip_params,
+            disable_dhcp_media_sense_string,
+            NULL,
+            &data_type,
+            (PBYTE)&disable_dhcp_media_sense,
+            &len);
+
+        if (status == ERROR_SUCCESS && data_type == REG_DWORD)
+        {
+            if (disable_dhcp_media_sense != 0)
+            {
+                ret_value = false;
+            }
+        }
+
+        RegCloseKey(tcpip_params);
+    }
+
+    return ret_value;
+}
+
 /*
  * Check that two addresses are part of the same 255.255.255.252 subnet.
  */
@@ -5901,6 +5953,13 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     {
         uint32_t ep[4];
 
+        /* Check DHCP media sense value */
+        if (!tt->options.dhcp_renew && !get_dhcp_media_sense())
+        {
+            msg(M_WARN, "WARNING: DHCP media sense disabled, dhcp_renew option forced. You can enable media sense with \"netsh interface ipv4 set global dhcpmediasense=enabled\" shell command");
+            tt->options.dhcp_renew = true;
+        }
+
         /* We will answer DHCP requests with a reply to set IP/subnet to these values */
         ep[0] = htonl(tt->local);
         ep[1] = htonl(tt->adapter_netmask);
-- 
2.14.2.windows.3


