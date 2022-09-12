From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 12 Sep 2022 12:10:57 +0300
Message-Id: <20220912091057.752-1-lstipakov@...277...>
In-Reply-To: <Yx5JdRcEXh2tTqPE@...1296...>
References: <Yx5JdRcEXh2tTqPE@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Use DCO on Windows by default
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

On startup, check following conditions:

 - ovpn-dco-win driver is installed. Perform this check
by trying to open adapter by symbolic name.

 - options are compatible with dco. Same checks as on
Linux and FreeBSD. In addition, check that --mode server
is not used and --windows-driver is not set to tap-windows6/wintun.

If both checks are passed, use DCO.

Move options_postprocess_mutate_invariant() call
below since it depends on selected windows driver.

dco_check_option() has side effect on Windows -
if dco is not used, it might complain "cipher chachapoly
not supported by dco, disabling dco" if chachapoly
support is missing system-wide. To not to see this,
check dco options only if dco is enabled. This means
moving dco_enabled() from dco_check_startup_option()
to one level above. We do similar thing in
multi_connection_established() before checking ccd options.


Signed-off-by: Lev Stipakov <lev@...515...>
---
v2:

 - initialize disable_dco to true if ENABLE_DCO is not set,
this allows to get rid of "else" branch in options_postprocess_mutate()

 - use dco_enabled() wrapper instead of accessing o->tt.disable_dco

 src/openvpn/dco.c     | 19 +++++++++++------
 src/openvpn/dco_win.c | 23 ++++++++++++++++++++-
 src/openvpn/options.c | 48 +++++++++++++++++++++++++++++--------------
 src/openvpn/options.h |  4 +---
 src/openvpn/tun.c     | 19 -----------------
 src/openvpn/tun.h     | 19 +++++++++++++++++
 6 files changed, 88 insertions(+), 44 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index d9e49781..a76cdd0c 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -257,11 +257,11 @@ dco_check_option_ce(const struct connection_entry *ce, int msglevel)
 bool
 dco_check_startup_option(int msglevel, const struct options *o)
 {
-    /* check if DCO was already disabled by the user or if no dev name was
-     * specified at all. In the latter case, later logic will most likely stop
-     * OpenVPN, so no need to print any message here.
+    /* check if no dev name was specified at all. In the case,
+     * later logic will most likely stop OpenVPN, so no need to
+     * print any message here.
      */
-    if (!dco_enabled(o) || !o->dev)
+    if (!o->dev)
     {
         return false;
     }
@@ -294,8 +294,15 @@ dco_check_startup_option(int msglevel, const struct options *o)
 #if defined(_WIN32)
     if (o->mode == MODE_SERVER)
     {
-        msg(msglevel, "Only client and p2p data channel offload is supported "
-            "with ovpn-dco.");
+        msg(msglevel, "--mode server is set. Disabling Data Channel Offload");
+        return false;
+    }
+
+    if ((o->windows_driver == WINDOWS_DRIVER_WINTUN)
+        || (o->windows_driver == WINDOWS_DRIVER_TAP_WINDOWS6))
+    {
+        msg(msglevel, "--windows-driver is set to '%s'. Disabling Data Channel Offload",
+            print_windows_driver(o->windows_driver));
         return false;
     }
 
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 22f30280..48a1755a 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -359,7 +359,28 @@ dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
 bool
 dco_available(int msglevel)
 {
-    return true;
+    /* try to open device by symbolic name */
+    HANDLE h = CreateFile("\\\\.\\ovpn-dco", GENERIC_READ | GENERIC_WRITE,
+                          0, NULL, OPEN_EXISTING, FILE_ATTRIBUTE_SYSTEM | FILE_FLAG_OVERLAPPED, NULL);
+
+    if (h != INVALID_HANDLE_VALUE)
+    {
+        CloseHandle(h);
+        return true;
+    }
+
+    DWORD err = GetLastError();
+    if (err == ERROR_ACCESS_DENIED)
+    {
+        /* this likely means that device exists but is already in use,
+         * don't bail out since later we try to open all existing dco
+         * devices and then bail out if all devices are in use
+         */
+        return true;
+    }
+
+    msg(msglevel, "Note: ovpn-dco-win driver is missing, disabling data channel offload.");
+    return false;
 }
 
 int
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2e567571..2a379f94 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -183,7 +183,7 @@ static const char usage_message[] =
     "                  does not begin with \"tun\" or \"tap\".\n"
     "--dev-node node : Explicitly set the device node rather than using\n"
     "                  /dev/net/tun, /dev/tun, /dev/tap, etc.\n"
-#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))
+#if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32))
     "--disable-dco   : Do not attempt using Data Channel Offload.\n"
 #endif
     "--lladdr hw     : Set the link layer address of the tap device.\n"
@@ -851,7 +851,7 @@ init_options(struct options *o, const bool init_gc)
     o->tuntap_options.dhcp_masq_offset = 0;     /* use network address as internal DHCP server address */
     o->route_method = ROUTE_METHOD_ADAPTIVE;
     o->block_outside_dns = false;
-    o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
+    o->windows_driver = WINDOWS_DRIVER_UNSPECIFIED;
 #endif
     o->vlan_accept = VLAN_ALL;
     o->vlan_pvid = 1;
@@ -903,6 +903,10 @@ init_options(struct options *o, const bool init_gc)
     }
 #endif /* _WIN32 */
     o->allow_recursive_routing = false;
+
+#if !defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32))
+    o->tuntap_options.disable_dco = true;
+#endif /* !defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)) */
 }
 
 void
@@ -3606,8 +3610,6 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
     options_set_backwards_compatible_options(o);
 
     options_postprocess_cipher(o);
-    options_postprocess_mutate_invariant(o);
-
     o->ncp_ciphers = mutate_ncp_cipher_list(o->ncp_ciphers, &o->gc);
     if (o->ncp_ciphers == NULL)
     {
@@ -3683,18 +3685,31 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
             "incompatible with each other.");
     }
 
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    /* check if any option should force disabling DCO */
-    o->tuntap_options.disable_dco = !dco_check_option(D_DCO, o)
-                                    || !dco_check_startup_option(D_DCO, o);
-#elif defined(_WIN32)
-    /* in Windows we have no 'fallback to non-DCO' strategy, so if a conflicting
-     * option is found, we simply bail out by means of M_USAGE
-     */
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
+    if (dco_enabled(o))
+    {
+        /* check if any option should force disabling DCO */
+        o->tuntap_options.disable_dco = !dco_check_option(D_DCO, o)
+                                        || !dco_check_startup_option(D_DCO, o);
+    }
+#endif
+
+#ifdef _WIN32
     if (dco_enabled(o))
     {
-        dco_check_option(M_USAGE, o);
-        dco_check_startup_option(M_USAGE, o);
+        o->windows_driver = WINDOWS_DRIVER_DCO;
+    }
+    else
+    {
+        if (o->windows_driver == WINDOWS_DRIVER_DCO)
+        {
+            msg(M_WARN, "Option --windows-driver ovpn-dco is ignored because Data Channel Offload is disabled");
+            o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
+        }
+        else if (o->windows_driver == WINDOWS_DRIVER_UNSPECIFIED)
+        {
+            o->windows_driver = WINDOWS_DRIVER_TAP_WINDOWS6;
+        }
     }
 #endif
 
@@ -3705,6 +3720,9 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
         o->dev_node = NULL;
     }
 
+    /* this depends on o->windows_driver, which is set above */
+    options_postprocess_mutate_invariant(o);
+
     /*
      * Save certain parms before modifying options during connect, especially
      * when using --pull
@@ -5903,7 +5921,7 @@ add_option(struct options *options,
 #endif
     else if (streq(p[0], "disable-dco"))
     {
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) || defined(_WIN32)
         options->tuntap_options.disable_dco = true;
 #endif
     }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6d9174a4..557054ba 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -882,9 +882,7 @@ bool key_is_external(const struct options *options);
 static inline bool
 dco_enabled(const struct options *o)
 {
-#if defined(_WIN32)
-    return o->windows_driver == WINDOWS_DRIVER_DCO;
-#elif defined(ENABLE_DCO)
+#if defined(ENABLE_DCO)
     return !o->tuntap_options.disable_dco;
 #else
     return false;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 94803acd..cb2a8fb6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3539,25 +3539,6 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 
 #elif defined(_WIN32)
 
-static const char *
-print_windows_driver(enum windows_driver_type windows_driver)
-{
-    switch (windows_driver)
-    {
-        case WINDOWS_DRIVER_TAP_WINDOWS6:
-            return "tap-windows6";
-
-        case WINDOWS_DRIVER_WINTUN:
-            return "wintun";
-
-        case WINDOWS_DRIVER_DCO:
-            return "ovpn-dco";
-
-        default:
-            return "unspecified";
-    }
-}
-
 int
 tun_read_queue(struct tuntap *tt, int maxsize)
 {
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 1cca1cfb..b7d54f2f 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -660,6 +660,25 @@ tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() == ERROR_NETNAME_DELETED);
 }
 
+static const char *
+print_windows_driver(enum windows_driver_type windows_driver)
+{
+    switch (windows_driver)
+    {
+        case WINDOWS_DRIVER_TAP_WINDOWS6:
+            return "tap-windows6";
+
+        case WINDOWS_DRIVER_WINTUN:
+            return "wintun";
+
+        case WINDOWS_DRIVER_DCO:
+            return "ovpn-dco";
+
+        default:
+            return "unspecified";
+    }
+}
+
 #else  /* ifdef _WIN32 */
 
 static inline bool
-- 
2.23.0.windows.1


