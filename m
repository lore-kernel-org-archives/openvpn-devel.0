From: Franco Fichtner <franco@...2219...>
Date: Tue, 28 May 2024 17:42:52 +0000
Message-ID: <AE20A784-506C-488B-9302-2D3AE775B168@...2219...>
Content-Language: en-US
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/1] Allow to set ifmode for existing DCO
 interfaces in FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-ID: <3C0514A7C472FA408A78F5DB015D68F1@...2802...>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

While prexisting devices work well TUN/TAP the DCO interfaces require
setting the ifmode which cannot be done by FreeBSD base tooling.  In
peer-to-peer mode this is not a problem because that is the default mode.
Subnet mode, however, will fail to be set and the resulting connection does
not start:

  Failed to create interface ovpns2 (SIOCSIFNAME): File exists (errno=3D17)
  DCO device ovpns2 already exists, won't be destroyed at shutdown
  /sbin/ifconfig ovpns2 10.1.8.1/24 mtu 1500 up
  ifconfig: in_exec_nl(): Empty IFA_LOCAL/IFA_ADDRESS
  ifconfig: ioctl (SIOCAIFADDR): Invalid argument
  FreeBSD ifconfig failed: external program exited with error status: 1
  Exiting due to fatal error

Slightly restructure the code to catch the specific error
condition and execute dco_set_ifmode() in this case as well.

Signed-off-by: Franco Fichtner <franco@...2219...>
---
 src/openvpn/dco_freebsd.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 577c65f8..7c8b29c9 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -219,6 +219,9 @@ create_interface(struct tuntap *tt, const char *dev)
     {
         ifr.ifr_data =3D (char *)dev;
     }
+
+    snprintf(tt->dco.ifname, IFNAMSIZ, "%s", ifr.ifr_data);
+
     ret =3D ioctl(tt->dco.fd, SIOCSIFNAME, &ifr);
     if (ret)
     {
@@ -229,16 +232,6 @@ create_interface(struct tuntap *tt, const char *dev)
         return ret;
     }
  -    snprintf(tt->dco.ifname, IFNAMSIZ, "%s", ifr.ifr_data);
-
-    /* see "Interface Flags" in ifnet(9) */
-    int i =3D IFF_POINTOPOINT | IFF_MULTICAST;
-    if (tt->topology =3D=3D TOP_SUBNET)
-    {
-        i =3D IFF_BROADCAST | IFF_MULTICAST;
-    }
-    dco_set_ifmode(&tt->dco, i);
-
     return 0;
 }
  @@ -265,7 +258,20 @@ remove_interface(struct tuntap *tt)
 int
 open_tun_dco(struct tuntap *tt, openvpn_net_ctx_t *ctx, const char *dev)
 {
-    return create_interface(tt, dev);
+    int ret =3D create_interface(tt, dev);
+
+    if (ret >=3D 0 || ret =3D=3D -EEXIST)
+    {
+        /* see "Interface Flags" in ifnet(9) */
+        int i =3D IFF_POINTOPOINT | IFF_MULTICAST;
+        if (tt->topology =3D=3D TOP_SUBNET)
+        {
+            i =3D IFF_BROADCAST | IFF_MULTICAST;
+        }
+        dco_set_ifmode(&tt->dco, i);
+    }
+
+    return ret;
 }
   void

