From: Gert Doering <gert@...1296...>
Date: Fri, 19 Aug 2022 20:24:39 +0200
Message-Id: <20220819182439.71531-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] FreeBSD-DCO: repair device iteration to
 find first free interface.
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

During review/update phase, FreeBSD/DCO's ability to find the first
free tun interface on "--dev tun" got broken, due to two issues:

 - create_interface() called msg(M_ERR|...), which is a fatal error
   and aborts OpenVPN, so "no retry with 'tun1' after 'tun0' failed"

   Change to M_WARN|M_ERRNO (= warning level, add strerror(errno), return).

 - open_tun_dco_generic() expects "-errno" as return value of
   open_tun_dco(), and breaks the loop on -EPERM.  create_interface()
   was returning "-1" instead (ioctl() error signalling), which happens
   to be "-EPERM" on FreeBSD.

   Change create_interface() to return -errno.

While at it, remove logging of errors from dco_freebsd.c::open_tun_dco()
(because all errors from create_interface() would be already logged there),
reducing open_tun_dco() to just a wrapper around create_interface().

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/dco_freebsd.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 06b4d6a9..c6da6ce3 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -178,7 +178,8 @@ create_interface(struct tuntap *tt, const char *dev)
     ret = ioctl(tt->dco.fd, SIOCIFCREATE2, &ifr);
     if (ret)
     {
-        msg(M_ERR | M_ERRNO, "Failed to create interface %s", ifr.ifr_name);
+        ret = -errno;
+        msg(M_WARN|M_ERRNO, "Failed to create interface %s (SIOCIFCREATE2)", ifr.ifr_name);
         return ret;
     }
 
@@ -194,9 +195,10 @@ create_interface(struct tuntap *tt, const char *dev)
     ret = ioctl(tt->dco.fd, SIOCSIFNAME, &ifr);
     if (ret)
     {
+        ret = -errno;
         /* Delete the created interface again. */
         (void)ioctl(tt->dco.fd, SIOCIFDESTROY, &ifr);
-        msg(M_ERR | M_ERRNO, "Failed to create interface %s", ifr.ifr_data);
+        msg(M_WARN|M_ERRNO, "Failed to create interface %s (SIOCSIFNAME)", ifr.ifr_data);
         return ret;
     }
 
@@ -229,16 +231,7 @@ remove_interface(struct tuntap *tt)
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
 {
-    int ret;
-
-    ret = create_interface(tt, dev);
-
-    if (ret < 0)
-    {
-        msg(M_ERR, "Failed to create interface");
-    }
-
-    return ret;
+    return create_interface(tt, dev);
 }
 
 void
-- 
2.37.1


