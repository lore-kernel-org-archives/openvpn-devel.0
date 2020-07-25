From: Arne Schwabe <arne@...1227...>
Date: Sun, 26 Jul 2020 01:50:23 +0200
Message-Id: <20200725235023.22441-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Include utun device number in utun error
 messages
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

For lack of a better API (or knowledge about a better API) we try to
open utun devices on macOS by trying utun0 to utun255 and use the
first one that works. On my Mac I have already 4 devices that
do nothing but are just there and another VPN connection resulting in a
number of error messages. This explicitly  shows in the log that we
tried the devices instead of some unspecific error.

This changes the log from:

Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opening utun (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opened utun device utun5

to

Opening utun0 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opening utun1 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opening utun2 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opening utun3 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opening utun4 failed (connect(AF_SYS_CONTROL)): Resource busy (errno=16)
Opened utun device utun5

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/tun.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 82d96927..ed00644c 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2950,14 +2950,16 @@ utun_open_helper(struct ctl_info ctlInfo, int utunnum)
 
     if (fd < 0)
     {
-        msg(M_INFO | M_ERRNO, "Opening utun (socket(SYSPROTO_CONTROL))");
+        msg(M_INFO | M_ERRNO, "Opening utun%d failed (socket(SYSPROTO_CONTROL))",
+            utunnum);
         return -2;
     }
 
     if (ioctl(fd, CTLIOCGINFO, &ctlInfo) == -1)
     {
         close(fd);
-        msg(M_INFO | M_ERRNO, "Opening utun (ioctl(CTLIOCGINFO))");
+        msg(M_INFO | M_ERRNO, "Opening utun%d failed (ioctl(CTLIOCGINFO))",
+            utunnum);
         return -2;
     }
 
@@ -2975,7 +2977,8 @@ utun_open_helper(struct ctl_info ctlInfo, int utunnum)
 
     if (connect(fd, (struct sockaddr *)&sc, sizeof(sc)) < 0)
     {
-        msg(M_INFO | M_ERRNO, "Opening utun (connect(AF_SYS_CONTROL))");
+        msg(M_INFO | M_ERRNO, "Opening utun%d failed (connect(AF_SYS_CONTROL))",
+            utunnum);
         close(fd);
         return -1;
     }
@@ -5682,15 +5685,15 @@ write_dhcp_str(struct buffer *buf, const int type, const char *str, bool *error)
  *  0x1D  0x7 openvpn 0x3 net 0x00 0x0A duckduckgo 0x3 com 0x00
  */
 static void
-write_dhcp_search_str(struct buffer *buf, const int type, const char * const *str_array,
+write_dhcp_search_str(struct buffer *buf, const int type, const char *const *str_array,
                       int array_len, bool *error)
 {
-    char         tmp_buf[256];
-    int          i;
-    int          len = 0;
-    int          label_length_pos;
+    char tmp_buf[256];
+    int i;
+    int len = 0;
+    int label_length_pos;
 
-    for (i=0; i < array_len; i++)
+    for (i = 0; i < array_len; i++)
     {
         const char  *ptr = str_array[i];
 
@@ -5701,7 +5704,7 @@ write_dhcp_search_str(struct buffer *buf, const int type, const char * const *st
             return;
         }
         /* Loop over all subdomains separated by a dot and replace the dot
-           with the length of the subdomain */
+         * with the length of the subdomain */
 
         /* label_length_pos points to the byte to be replaced by the length
          * of the following domain label */
@@ -5709,7 +5712,7 @@ write_dhcp_search_str(struct buffer *buf, const int type, const char * const *st
 
         while (true)
         {
-            if (*ptr == '.' || *ptr == '\0' )
+            if (*ptr == '.' || *ptr == '\0')
             {
                 tmp_buf[label_length_pos] = (len-label_length_pos)-1;
                 label_length_pos = len;
@@ -5769,8 +5772,8 @@ build_dhcp_options_string(struct buffer *buf, const struct tuntap_options *o)
     if (o->domain_search_list_len > 0)
     {
         write_dhcp_search_str(buf, 119, o->domain_search_list,
-                                        o->domain_search_list_len,
-                                       &error);
+                              o->domain_search_list_len,
+                              &error);
     }
 
     /* the MS DHCP server option 'Disable Netbios-over-TCP/IP
@@ -6149,9 +6152,9 @@ wintun_register_ring_buffer(struct tuntap *tt, const char *device_guid)
     else
     {
         msg(M_FATAL, "ERROR:  Wintun requires SYSTEM privileges and therefore "
-                     "should be used with interactive service. If you want to "
-                     "use openvpn from command line, you need to do SYSTEM "
-                     "elevation yourself (for example with psexec).");
+            "should be used with interactive service. If you want to "
+            "use openvpn from command line, you need to do SYSTEM "
+            "elevation yourself (for example with psexec).");
     }
 
     return ret;
-- 
2.26.2


