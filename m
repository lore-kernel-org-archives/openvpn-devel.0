From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jan 2022 17:25:19 +0100
Message-Id: <20220101162532.2251835-2-arne@...1227...>
In-Reply-To: <20220101162532.2251835-1-arne@...1227...>
References: <20220101162532.2251835-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 01/14] Deprecate link-mtu
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

This options might have been useful in the past but nowadays it has a very
unclear semantics, so better remove/deprecate it.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/man-sections/link-options.rst | 7 ++++++-
 src/openvpn/options.c             | 4 +---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index 32e72a1b..b1ae4e75 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -82,10 +82,15 @@ the local and the remote host.
          ping-restart 60            # Argument: timeout
 
 --link-mtu n
-  Sets an upper bound on the size of UDP packets which are sent between
+  **DEPRECATED** Sets an upper bound on the size of UDP packets which are sent between
   OpenVPN peers. *It's best not to set this parameter unless you know what
   you're doing.*
 
+  Due to variable header size of IP header (20 bytes for IPv4 and 40 bytes
+  for IPv6) and dynamically negotiated data channel cipher, this option
+  is not reliable. It is recommended to set tun-mtu with enough headroom
+  instead.
+
 --local host
   Local host name or IP address for bind. If specified, OpenVPN will bind
   to this address only. If unspecified, OpenVPN will bind to all
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0529c141..2ca24685 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2111,9 +2111,7 @@ options_postprocess_verify_ce(const struct options *options,
      */
     if (options->ce.tun_mtu_defined && options->ce.link_mtu_defined)
     {
-        msg(M_USAGE,
-            "only one of --tun-mtu or --link-mtu may be defined (note that "
-            "--ifconfig implies --link-mtu %d)", LINK_MTU_DEFAULT);
+        msg(M_USAGE, "only one of --tun-mtu or --link-mtu may be defined");
     }
 
     if (!proto_is_udp(ce->proto) && options->mtu_test)
-- 
2.33.0


