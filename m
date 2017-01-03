From: selva.nair@...277...
Date: Tue,  3 Jan 2017 15:38:03 -0500
Message-Id: <1483475883-17450-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1483152307-15687-1-git-send-email-selva.nair@...277...>
References: <1483152307-15687-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Always release dhcp address in
	close_tun()
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

From: Selva Nair <selva.nair@...277...>

Also make sure --dhcp-pre-release results in not just dhcp_release()
in open_tun() but a subsequent dhcp_renew() as well. Else dhcp transaction
gets aborted as this call to release() happens after the adapter status
is changed to connected.

Fixes Trac #807 (but can't say the same for Trac #665 without knowing
how to reproduce it)

v2: Mark --dhcp-release as obsolete in mapage and option parser, and
remove the unused dhcp_release varaible.
Enforce dhcp-renew with dhcp-pre-release while parsing the option
instead of in open_tun().

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 doc/openvpn.8         | 4 +---
 src/openvpn/options.c | 6 ++----
 src/openvpn/tun.c     | 5 +----
 src/openvpn/tun.h     | 1 -
 4 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7bd6d9d..3e4c2e7 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5819,9 +5819,7 @@ flag.
 .TP
 .B \-\-dhcp\-release
 Ask Windows to release the TAP adapter lease on shutdown.
-This option has the same caveats as
-.B \-\-dhcp\-renew
-above.
+This option has no effect now, as it is enabled by default starting with version 2.4.1.
 .\"*********************************************************
 .TP
 .B \-\-register\-dns
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bfedb6a..4560b52 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -716,7 +716,6 @@ static const char usage_message[] =
     "--dhcp-renew       : Ask Windows to renew the TAP adapter lease on startup.\n"
     "--dhcp-pre-release : Ask Windows to release the previous TAP adapter lease on\n"
     "                       startup.\n"
-    "--dhcp-release     : Ask Windows to release the TAP adapter lease on shutdown.\n"
     "--register-dns  : Run ipconfig /flushdns and ipconfig /registerdns\n"
     "                  on connection initiation.\n"
     "--tap-sleep n   : Sleep for n seconds after TAP adapter open before\n"
@@ -1214,7 +1213,6 @@ show_tuntap_options(const struct tuntap_options *o)
     SHOW_BOOL(dhcp_options);
     SHOW_BOOL(dhcp_renew);
     SHOW_BOOL(dhcp_pre_release);
-    SHOW_BOOL(dhcp_release);
     SHOW_STR(domain);
     SHOW_STR(netbios_scope);
     SHOW_INT(netbios_node_type);
@@ -7200,11 +7198,11 @@ add_option(struct options *options,
     {
         VERIFY_PERMISSION(OPT_P_IPWIN32);
         options->tuntap_options.dhcp_pre_release = true;
+        options->tuntap_options.dhcp_renew = true;
     }
     else if (streq(p[0], "dhcp-release") && !p[1])
     {
-        VERIFY_PERMISSION(OPT_P_IPWIN32);
-        options->tuntap_options.dhcp_release = true;
+        msg(M_WARN, "Obsolete option --dhcp-release detected. This is now on by default");
     }
     else if (streq(p[0], "dhcp-internal") && p[1] && !p[2]) /* standalone method for internal use */
     {
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f812844..ec9997e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6224,10 +6224,7 @@ close_tun(struct tuntap *tt)
         }
 #endif
 
-        if (tt->options.dhcp_release)
-        {
-            dhcp_release(tt);
-        }
+        dhcp_release(tt);
 
         if (tt->hand != NULL)
         {
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index f4b600c..b39fe15 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -104,7 +104,6 @@ struct tuntap_options {
 
     bool dhcp_renew;
     bool dhcp_pre_release;
-    bool dhcp_release;
 
     bool register_dns;
 
-- 
2.1.4


