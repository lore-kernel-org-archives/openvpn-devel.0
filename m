From: Gert Doering <gert@...1296...>
Date: Thu, 16 Aug 2012 20:09:09 +0200
Message-Id: <1345140549-29256-1-git-send-email-gert@...1296...>
In-Reply-To: <5DDA5487-D6B2-4EF2-8F20-D4324FBEB843@...1286...>
References: <5DDA5487-D6B2-4EF2-8F20-D4324FBEB843@...1286...>
Subject: [Openvpn-devel] [PATCH] Keep pre-existing tun/tap devices around on
	*BSD
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

This amends commit 62c613d46dc49 to check whether a named tun/tap
device ("--dev tunX" instead of "--dev tun") exists before OpenVPN
started - if yes, keep around at program end.  If no, destroy.

Also has a spelling fix, and changes clear_tuntap() to be "static"
(only ever called from within tun.c).

Tested on FreeBSD 7.4, FreeBSD 9.0, NetBSD 5.1, OpenBSD 4.9

Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Eric Crist <ecrist@...1286...>
---
 src/openvpn/tun.c |   22 +++++++++++++++++-----
 src/openvpn/tun.h |    4 +++-
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6218b73..ed67261 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -890,7 +890,7 @@ do_ifconfig (struct tuntap *tt,
 #elif defined(TARGET_OPENBSD)
 
       /*
-       * On OpenBSD, tun interfaces are persistant if created with
+       * On OpenBSD, tun interfaces are persistent if created with
        * "ifconfig tunX create", and auto-destroyed if created by
        * opening "/dev/tunX" (so we just use the /dev/tunX)
        */
@@ -1235,7 +1235,7 @@ do_ifconfig (struct tuntap *tt,
   gc_free (&gc);
 }
 
-void
+static void
 clear_tuntap (struct tuntap *tuntap)
 {
   CLEAR (*tuntap);
@@ -1344,6 +1344,13 @@ open_tun_generic (const char *dev, const char *dev_type, const char *dev_node,
 
       if (!dynamic_opened)
 	{
+  	  /* has named device existed before? if so, don't destroy at end */
+	  if ( if_nametoindex( dev ) > 0 )
+	    {
+	      msg (M_INFO, "TUN/TAP device %s exists previously, keep at program end", dev );
+	      tt->persistent_if = true;
+	    }
+
 	  if ((tt->fd = open (tunname, O_RDWR)) < 0)
 	    msg (M_ERR, "Cannot open TUN/TAP dev %s", tunname);
 	}
@@ -2030,7 +2037,7 @@ close_tun (struct tuntap* tt)
 {
   /* only *TAP* devices need destroying, tun devices auto-self-destruct
    */
-  if (tt && tt->type == DEV_TYPE_TUN )
+  if (tt && (tt->type == DEV_TYPE_TUN || tt->persistent_if ) )
     {
       close_tun_generic (tt);
       free(tt);
@@ -2165,7 +2172,7 @@ close_tun (struct tuntap *tt)
 {
   /* only tun devices need destroying, tap devices auto-self-destruct
    */
-  if (tt && tt->type != DEV_TYPE_TUN )
+  if (tt && ( tt->type != DEV_TYPE_TUN || tt->persistent_if ) )
     {
       close_tun_generic (tt);
       free(tt);
@@ -2303,7 +2310,12 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
 void
 close_tun (struct tuntap *tt)
 {
-  if (tt)
+  if (tt && tt->persistent_if )		/* keep pre-existing if around */
+    {
+      close_tun_generic (tt);
+      free (tt);
+    }
+  else if (tt)				/* close and destroy */
     {
       struct gc_arena gc = gc_new ();
       struct argv argv;
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 9bd990f..8622bf8 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -137,6 +137,8 @@ struct tuntap
 
   bool ipv6;
 
+  bool persistent_if;		/* if existed before, keep on program end */
+
   struct tuntap_options options; /* options set on command line */
 
   char *actual_name; /* actual name of TUN/TAP dev, usually including unit number */
@@ -201,7 +203,7 @@ tuntap_defined (const struct tuntap *tt)
  * Function prototypes
  */
 
-void clear_tuntap (struct tuntap *tuntap);
+static void clear_tuntap (struct tuntap *tuntap);
 
 void open_tun (const char *dev, const char *dev_type, const char *dev_node,
 	       struct tuntap *tt);
-- 
1.7.3.5


