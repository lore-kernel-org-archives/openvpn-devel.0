From: selva.nair@...277...
Date: Mon,  2 Jan 2023 14:41:56 -0500
Message-Id: <20230102194156.1560195-1-selva.nair@...277...>
In-Reply-To: <20230101215109.1521549-5-selva.nair@...277...>
References: <20230101215109.1521549-5-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 4/5] Fix signal handling on Windows
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

From: Selva Nair <selva.nair@...277...>

- In win32_signal_get() re-order the check so that Windows
  signals are picked up even if signal_received is non-zero

- When management is not active, management_sleep() becomes sleep()
  but it is not interruptible by signals on Windows. Fix this by
  periodically checking for signal.

Fixes Trac #311 #639 (windows specific part)

Github: Fixes OpenVPN/openvpn#205 (windows specific part)
Note: if stuck  in address resolution, press ctrl-C and wait for getaddrinfo()
to timeout.

v2: WIN32 --> _WIN32
    add a chunk in management_sleep that was missed by sloppy conflict-resolution

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/manage.c | 16 +++++++-
 src/openvpn/win32.c  | 98 +++++++++++++++++++++++++++++---------------
 src/openvpn/win32.h  |  3 ++
 3 files changed, 81 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5465b7e9..9bd5ef4e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4045,9 +4045,16 @@ management_sleep(const int n)
     {
         management_event_loop_n_seconds(management, n);
     }
-    else if (n > 0)
+    else
     {
-        sleep(n);
+#ifdef _WIN32
+        win32_sleep(n);
+#else
+        if (n > 0)
+        {
+            sleep(n);
+        }
+#endif
     }
 }
 
@@ -4088,13 +4095,18 @@ man_persist_client_stats(struct management *man, struct context *c)
 
 #else  /* ifdef ENABLE_MANAGEMENT */
 
+#include "win32.h"
 void
 management_sleep(const int n)
 {
+#ifdef _WIN32
+    win32_sleep(n);
+#else
     if (n > 0)
     {
         sleep(n);
     }
+#endif /* ifdef _WIN32 */
 }
 
 #endif /* ENABLE_MANAGEMENT */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index c3520bca..e16d5461 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -642,50 +642,44 @@ int
 win32_signal_get(struct win32_signal *ws)
 {
     int ret = 0;
-    if (siginfo_static.signal_received)
-    {
-        ret = siginfo_static.signal_received;
-    }
-    else
+
+    if (ws->mode == WSO_MODE_SERVICE)
     {
-        if (ws->mode == WSO_MODE_SERVICE)
+        if (win32_service_interrupt(ws))
         {
-            if (win32_service_interrupt(ws))
-            {
-                ret = SIGTERM;
-            }
+            ret = SIGTERM;
         }
-        else if (ws->mode == WSO_MODE_CONSOLE)
+    }
+    else if (ws->mode == WSO_MODE_CONSOLE)
+    {
+        switch (win32_keyboard_get(ws))
         {
-            switch (win32_keyboard_get(ws))
-            {
-                case 0x3B: /* F1 -> USR1 */
-                    ret = SIGUSR1;
-                    break;
+            case 0x3B: /* F1 -> USR1 */
+                ret = SIGUSR1;
+                break;
 
-                case 0x3C: /* F2 -> USR2 */
-                    ret = SIGUSR2;
-                    break;
+            case 0x3C: /* F2 -> USR2 */
+                ret = SIGUSR2;
+                break;
 
-                case 0x3D: /* F3 -> HUP */
-                    ret = SIGHUP;
-                    break;
+            case 0x3D: /* F3 -> HUP */
+                ret = SIGHUP;
+                break;
 
-                case 0x3E: /* F4 -> TERM */
-                    ret = SIGTERM;
-                    break;
+            case 0x3E: /* F4 -> TERM */
+                ret = SIGTERM;
+                break;
 
-                case 0x03: /* CTRL-C -> TERM */
-                    ret = SIGTERM;
-                    break;
-            }
-        }
-        if (ret)
-        {
-            throw_signal(ret); /* this will update signinfo_static.signal received */
+            case 0x03: /* CTRL-C -> TERM */
+                ret = SIGTERM;
+                break;
         }
     }
-    return ret;
+    if (ret)
+    {
+        throw_signal(ret); /* this will update signinfo_static.signal received */
+    }
+    return (siginfo_static.signal_received);
 }
 
 void
@@ -1603,4 +1597,40 @@ set_openssl_env_vars()
     }
 }
 
+void
+win32_sleep(const int n)
+{
+    if (n < 0)
+    {
+        return;
+    }
+
+    /* Sleep() is not interruptible. Use a WAIT_OBJECT to catch signal */
+    if (HANDLE_DEFINED(win32_signal.in.read))
+    {
+        time_t expire = 0;
+        update_time();
+        expire = now + n;
+        while (expire >= now)
+        {
+            DWORD status = WaitForSingleObject(win32_signal.in.read, (expire - now)*1000);
+            if (win32_signal_get(&win32_signal) || status == WAIT_TIMEOUT)
+            {
+                return;
+            }
+
+            update_time();
+
+            if (status == WAIT_FAILED && expire > now)
+            {
+                Sleep((expire-now)*1000);
+                return;
+            }
+        }
+    }
+    else
+    {
+        Sleep(n*1000);
+    }
+}
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index b1371999..26d5ef8f 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -330,5 +330,8 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
 bool
 openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
 
+/* Sleep that can be interrupted by signals and exit event */
+void win32_sleep(const int n);
+
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
-- 
2.34.1


