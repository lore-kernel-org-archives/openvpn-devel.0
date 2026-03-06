From: Gert Doering <gert@...1296...>
Date: Fri,  6 Mar 2026 17:29:19 +0100
Message-ID: <20260306162925.2359-1-gert@...1296...>
In-Reply-To: <gerrit.1771008284000.Ifc7ad2407b9cca8cfcef79d7392a058735416139@...2715...>
References: <gerrit.1771008284000.Ifc7ad2407b9cca8cfcef79d7392a058735416139@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] tun: Avoid sign-compare issues in
 tun_read_queue
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

Just use the same type that the other values
already have.

While here review and remove some other useless
casts in msg() calls.

Change-Id: Ifc7ad2407b9cca8cfcef79d7392a058735416139
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1525
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1525
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 8105db2..f46802f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3264,24 +3264,18 @@
 
 #elif defined(_WIN32)
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 int
 tun_read_queue(struct tuntap *tt, int maxsize)
 {
     if (tt->reads.iostate == IOSTATE_INITIAL)
     {
-        DWORD len;
         BOOL status;
         int err;
 
         /* reset buf to its initial state */
         tt->reads.buf = tt->reads.buf_init;
 
-        len = maxsize ? maxsize : BLEN(&tt->reads.buf);
+        int len = maxsize ? maxsize : BLEN(&tt->reads.buf);
         ASSERT(len <= BLEN(&tt->reads.buf));
 
         /* the overlapped read will signal this event on I/O completion */
@@ -3298,8 +3292,8 @@
             tt->reads.iostate = IOSTATE_IMMEDIATE_RETURN;
             tt->reads.status = 0;
 
-            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read immediate return [%d,%d]", (int)len,
-                 (int)tt->reads.size);
+            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read immediate return [%d,%lu]", len,
+                 tt->reads.size);
         }
         else
         {
@@ -3308,7 +3302,7 @@
             {
                 tt->reads.iostate = IOSTATE_QUEUED;
                 tt->reads.status = err;
-                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read queued [%d]", (int)len);
+                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read queued [%d]", len);
             }
             else /* error occurred */
             {
@@ -3316,7 +3310,7 @@
                 ASSERT(SetEvent(tt->reads.overlapped.hEvent));
                 tt->reads.iostate = IOSTATE_IMMEDIATE_RETURN;
                 tt->reads.status = err;
-                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read error [%d] : %s", (int)len,
+                dmsg(D_WIN32_IO, "WIN32 I/O: TAP Read error [%d] : %s", len,
                      strerror_win32(status, &gc));
                 gc_free(&gc);
             }
@@ -3353,8 +3347,8 @@
 
             tt->writes.status = 0;
 
-            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Write immediate return [%d,%d]", BLEN(&tt->writes.buf),
-                 (int)tt->writes.size);
+            dmsg(D_WIN32_IO, "WIN32 I/O: TAP Write immediate return [%d,%lu]", BLEN(&tt->writes.buf),
+                 tt->writes.size);
         }
         else
         {
@@ -5447,14 +5441,14 @@
     if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_VERSION, &info, sizeof(info), &info,
                         sizeof(info), &len, NULL))
     {
-        msg(D_TUNTAP_INFO, "TAP-Windows Driver Version %d.%d %s", (int)info[0], (int)info[1],
+        msg(D_TUNTAP_INFO, "TAP-Windows Driver Version %lu.%lu %s", info[0], info[1],
             (info[2] ? "(DEBUG)" : ""));
     }
     if (!(info[0] == TAP_WIN_MIN_MAJOR && info[1] >= TAP_WIN_MIN_MINOR))
     {
         msg(M_FATAL,
             "ERROR:  This version of " PACKAGE_NAME
-            " requires a TAP-Windows driver that is at least version %d.%d -- If you recently upgraded your " PACKAGE_NAME
+            " requires a TAP-Windows driver that is at least version %u.%u -- If you recently upgraded your " PACKAGE_NAME
             " distribution, a reboot is probably required at this point to get Windows to see the new driver.",
             TAP_WIN_MIN_MAJOR, TAP_WIN_MIN_MINOR);
     }
@@ -5465,8 +5459,8 @@
     if (tt->type == DEV_TYPE_TUN && info[0] == 9 && info[1] < 8)
     {
         msg(M_INFO,
-            "WARNING:  Tap-Win32 driver version %d.%d does not support IPv6 in TUN mode. IPv6 will not work. Upgrade your Tap-Win32 driver.",
-            (int)info[0], (int)info[1]);
+            "WARNING:  Tap-Win32 driver version %lu.%lu does not support IPv6 in TUN mode. IPv6 will not work. Upgrade your Tap-Win32 driver.",
+            info[0], info[1]);
     }
 
     /* tap driver 9.8 (2.2.0 and 2.2.1 release) is buggy
@@ -5474,8 +5468,7 @@
     if (tt->type == DEV_TYPE_TUN && info[0] == 9 && info[1] == 8)
     {
         msg(M_FATAL,
-            "ERROR:  Tap-Win32 driver version %d.%d is buggy regarding small IPv4 packets in TUN mode. Upgrade your Tap-Win32 driver.",
-            (int)info[0], (int)info[1]);
+            "ERROR:  Tap-Win32 driver version 9.8 is buggy regarding small IPv4 packets in TUN mode. Upgrade your Tap-Win32 driver.");
     }
 }
 
@@ -5487,7 +5480,7 @@
     if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU, &mtu, sizeof(mtu), &mtu, sizeof(mtu), &len,
                         NULL))
     {
-        msg(D_MTU_INFO, "TAP-Windows MTU=%d", (int)mtu);
+        msg(D_MTU_INFO, "TAP-Windows MTU=%lu", mtu);
     }
 }
 
@@ -5608,10 +5601,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 tuntap_set_connected(const struct tuntap *tt)
 {

