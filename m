From: Arne Schwabe <arne@...1227...>
Date: Tue, 14 Mar 2023 15:48:54 +0100
Message-Id: <20230314144854.182110-2-arne@...1227...>
In-Reply-To: <20230314144854.182110-1-arne@...1227...>
References: <20230314144854.182110-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Fix memory leaks in dco open tun
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

The open_tun_dco_generic already allocates the actual_name string, this
shadows the allocation in the FreeBSD/Linux specific methods.

Found-By: clang with asan
Change-Id: I51f5fcfff4e5f8203fdb9aec0245cfccd17043cc
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_freebsd.c | 1 -
 src/openvpn/dco_linux.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index ecca2a076..225b3cf88 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -232,7 +232,6 @@ create_interface(struct tuntap *tt, const char *dev)
     }
 
     snprintf(tt->dco.ifname, IFNAMSIZ, "%s", ifr.ifr_data);
-    tt->actual_name = string_alloc(tt->dco.ifname, NULL);
 
     /* see "Interface Flags" in ifnet(9) */
     int i = IFF_POINTOPOINT | IFF_MULTICAST;
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index b2fdbf53f..e5cea3c71 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -457,7 +457,6 @@ open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
         msg(M_FATAL, "DCO: cannot retrieve ifindex for interface %s", dev);
     }
 
-    tt->actual_name = string_alloc(dev, NULL);
     tt->dco.dco_message_peer_id = -1;
 
     ovpn_dco_register(&tt->dco);
-- 
2.37.1 (Apple Git-137.1)


