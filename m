From: Gert Doering <gert@...1296...>
Date: Wed, 12 Oct 2022 16:59:15 +0200
Message-Id: <20221012145915.25810-2-gert@...1296...>
In-Reply-To: <20221012145915.25810-1-gert@...1296...>
References: <20221012145915.25810-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] FreeBSD DCO: introduce real subnet mode
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

To be able to configure a FreeBSD interface to "subnet" mode
(as opposed to point-to-point mode), it needs to have its
if_iflags set to IFF_BROADCAST.  For tun(4) interface this is
done with the TUNSIFMODE ioctl(), but this does not work for
more modern interfaces like ovpn(4) which communicate over
a common SIOCSDRVSPEC ioctl() that contains a "cmd" and a
"parameter list".

Introduce OVPN_SET_IFMODE cmd, add dco_set_ifmode() function
to put kernel interface into IFF_BROADCAST or IFF_POINTOPOINT
as needed.

(This needs a kernel patch to add the OVPN_SET_IFMODE on the
other side - with an older kernel, OpenVPN will just fail now)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/dco_freebsd.c      | 36 ++++++++++++++++++++++++++++++++++
 src/openvpn/ovpn_dco_freebsd.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index c6da6ce3..8adbf7f1 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -165,6 +165,34 @@ ovpn_dco_init(int mode, dco_context_t *dco)
     return true;
 }
 
+static int
+dco_set_ifmode(dco_context_t *dco, int ifmode)
+{
+    struct ifdrv drv;
+    nvlist_t *nvl;
+    int ret;
+
+    msg(M_INFO, "ifmode=%08x", ifmode);
+    nvl = nvlist_create(0);
+    nvlist_add_number(nvl, "ifmode", ifmode);
+
+    CLEAR(drv);
+    snprintf(drv.ifd_name, IFNAMSIZ, "%s", dco->ifname);
+    drv.ifd_cmd = OVPN_SET_IFMODE;
+    drv.ifd_data = nvlist_pack(nvl, &drv.ifd_len);
+
+    ret = ioctl(dco->fd, SIOCSDRVSPEC, &drv);
+    if (ret)
+    {
+        msg(M_WARN | M_ERRNO, "Failed to set ifmode");
+    }
+
+    free(drv.ifd_data);
+    nvlist_destroy(nvl);
+
+    return ret;
+}
+
 static int
 create_interface(struct tuntap *tt, const char *dev)
 {
@@ -205,6 +233,14 @@ create_interface(struct tuntap *tt, const char *dev)
     snprintf(tt->dco.ifname, IFNAMSIZ, "%s", ifr.ifr_data);
     tt->actual_name = string_alloc(tt->dco.ifname, NULL);
 
+    /* see "Interface Flags" in ifnet(9) */
+    int i = IFF_POINTOPOINT | IFF_MULTICAST;
+    if (tt->topology == TOP_SUBNET)
+    {
+        i = IFF_BROADCAST | IFF_MULTICAST;
+    }
+    dco_set_ifmode(&tt->dco, i);
+
     return 0;
 }
 
diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h
index 7ceec06e..cf92d597 100644
--- a/src/openvpn/ovpn_dco_freebsd.h
+++ b/src/openvpn/ovpn_dco_freebsd.h
@@ -60,5 +60,6 @@ enum ovpn_key_cipher {
 #define OVPN_SEND_PKT           _IO('D', 9)
 #define OVPN_POLL_PKT           _IO('D', 10)
 #define OVPN_GET_PKT            _IO('D', 11)
+#define OVPN_SET_IFMODE         _IO('D', 12)
 
 #endif /* ifndef _NET_IF_OVPN_H_ */
-- 
2.37.3


