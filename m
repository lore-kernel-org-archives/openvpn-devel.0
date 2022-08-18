From: Antonio Quartulli <a@...2181...>
Date: Thu, 18 Aug 2022 12:09:53 +0200
Message-Id: <20220818100953.191328-1-a@...2181...>
In-Reply-To: <20220818092638.189632-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v103 2/7] dco-win: check for incompatible
 options
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
Cc: Antonio Quartulli <a@...2181...>, Lev Stipakov <lev@...515...>

At the moment dco-win doesn't support --persist-tun and --server,
so check for these options at startup time.

Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Lev Stipakov <lev@...515...>
---

Changes from v102:
* remove platform defined log level and make check_options_ calls on
  Windows explicit and document why.

Changes from v101:
* rebased
* remove call to dco_check_option_ from verify() and reuse invocation
  that was already implemented for linux/freebsd in mutate_ce()
* hide log level to use in case of option check failure inside
  dco_win/linux/freebsd.h

Changes from v100:
* improved commit title/message
---
 src/openvpn/dco.c     | 17 +++++++++++++++--
 src/openvpn/options.c |  8 +++++++-
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 757ac19b..0aeecc54 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -225,7 +225,20 @@ dco_update_keys(dco_context_t *dco, struct tls_multi *multi)
 bool
 dco_check_startup_option_conflict(int msglevel, const struct options *o)
 {
-#if defined(TARGET_LINUX)
+#if defined(_WIN32)
+    if (o->mode == MODE_SERVER)
+    {
+        msg(msglevel, "Only client and p2p data channel offload is supported "
+            "with ovpn-dco-win.");
+        return false;
+    }
+
+    if (o->persist_tun)
+    {
+        msg(msglevel, "--persist-tun is not supported with ovpn-dco-win.");
+        return false;
+    }
+#elif defined(TARGET_LINUX)
     /* if the device name is fixed, we need to check if an interface with this
      * name already exists. IF it does, it must be a DCO interface, otherwise
      * DCO has to be disabled in order to continue.
@@ -250,7 +263,7 @@ dco_check_startup_option_conflict(int msglevel, const struct options *o)
                 strerror(-ret), ret);
         }
     }
-#endif /* if defined(TARGET_LINUX) */
+#endif /* if defined(_WIN32) */
 
 #if defined(HAVE_LIBCAPNG)
     /* DCO can't operate without CAP_NET_ADMIN. To retain it when switching user
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2415c1a8..272f8741 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3669,10 +3669,16 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
             "incompatible with each other.");
     }
 
+#if defined(TARGET_LINUX) && defined(TARGET_FREEBSD)
     /* check if any option should force disabling DCO */
-#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o)
                                     || !dco_check_startup_option_conflict(D_DCO, o);
+#elif defined(_WIN32)
+    /* in Windows we have no 'fallback to non-DCO' strategy, so if a conflicting
+     * option is found, we simply bail out by means of M_USAGE
+     */
+    dco_check_option_conflict(M_USAGE, o);
+    dco_check_startup_option_conflict(M_USAGE, o);
 #endif
 
     if (dco_enabled(o) && o->dev_node)
-- 
2.30.2


