From: Neil Brown <neilb@...253...>
MIME-Version: 1.0
Message-ID: <16645.48660.718636.245182@...253...>
Subject: [Openvpn-devel] [PATCH - 3 of 4]  separate "net-type" from "interface-type"
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Jul 26 19:30:05 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net


This is the third for 4 patches.  Possible it is a little more
controversial.
This patch doesn't actually make any functional change to openvpn.
However it prepares the way for a functional change to be implemented
in the next patch.

(Ignoring null,) openvpn has two types for devices, tun and tap.
It also has two ways of configuring the local interface: pointopoint
or subnet.
This is most obvious in the usage of "ifconfig": in "pointopoint" mode
the second argument is the remote IP address, in subnet mode the
second argument is a subnet.

Currently openvpn has a built in assumption that if it is using a tun
device it should work in pointopoint mode, and if it is use a tap
device it should work in subnet mode.

I don't think this assumption is necessarily correct.  In particular,
I think it can be useful to run with a tun device and subnet mode.

This would be only really useful when using the new server mode, but
it is (for me at least) particularly useful in that situation.

I want to use tun devices (as I am only interested in IP traffic, and
I want some checking of source IP address to be done) but I want to
treat the collection of openvpn instances (the server and several
clients) as a single subnet.
A particular advantage of this is that ifconfig-pool can hand out
individual IP addresses to clients instead of 2-bit subnets.

This patch introduces a concept of a "NET_TYPE" which can be
NET_TYPE_PTP or NET_TYPE_SUBNET.  In this patch, the NET_TYPE is
determines directly from the TUNNEL_TYPE.  

All the times where TUNNEL_TYPE are currently used where the important
issues is "subnet or pointopoint" have been change to use NET_TYPE
instead.

Thus this change does (as mentioned) not actually affect functionality
(yet), only appearance of the code.

If you aren't convinced that this is a good idea, I am happy to
discuss it further.

Thanks,
NeilBrown

========================================
### Diffstat output
 ./init.c  |    4 +--
 ./multi.c |   12 +++++-----
 ./tun.c   |   72 +++++++++++++++++++++++++++++++-------------------------------
 ./tun.h   |   14 ++++++++++++
 4 files changed, 58 insertions(+), 44 deletions(-)

diff ./init.c~current~ ./init.c
--- ./init.c~current~	2004-07-27 11:44:22.000000000 +1000
+++ ./init.c	2004-07-27 11:44:22.000000000 +1000
@@ -492,9 +492,9 @@ do_init_route_list (const struct options
 		    bool fatal)
 {
   const char *gw = NULL;
-  int dev = dev_type_enum (options->dev, options->dev_type);
+  int net = dev_to_net (dev_type_enum (options->dev, options->dev_type));
 
-  if (dev == DEV_TYPE_TUN)
+  if (net == NET_TYPE_PTP)
     gw = options->ifconfig_remote_netmask;
   if (options->route_default_gateway)
     gw = options->route_default_gateway;

diff ./multi.c~current~ ./multi.c
--- ./multi.c~current~	2004-07-26 14:36:35.000000000 +1000
+++ ./multi.c	2004-07-27 11:44:22.000000000 +1000
@@ -195,7 +195,7 @@ reap_buckets_per_pass (int n_buckets)
 static void
 multi_init (struct multi_context *m, struct context *t)
 {
-  int dev = DEV_TYPE_UNDEF;
+  int net = NET_TYPE_UNDEF;
 
   msg (D_MULTI_LOW, "MULTI: multi_init called, r=%d v=%d",
        t->options.real_hash_size,
@@ -204,7 +204,7 @@ multi_init (struct multi_context *m, str
   /*
    * Get tun/tap/null device type
    */
-  dev = dev_type_enum (t->options.dev, t->options.dev_type);
+  net = dev_to_net (dev_type_enum (t->options.dev, t->options.dev_type));
 
   /*
    * Init our multi_context object.
@@ -263,13 +263,13 @@ multi_init (struct multi_context *m, str
    */
   if (t->options.ifconfig_pool_defined)
     {
-      if (dev == DEV_TYPE_TUN)
+      if (net == NET_TYPE_PTP)
 	{
 	  m->ifconfig_pool = ifconfig_pool_init (IFCONFIG_POOL_30NET,
 						 t->options.ifconfig_pool_start,
 						 t->options.ifconfig_pool_end);
 	}
-      else if (dev == DEV_TYPE_TAP)
+      else if (net == NET_TYPE_SUBNET)
 	{
 	  m->ifconfig_pool = ifconfig_pool_init (IFCONFIG_POOL_INDIV,
 						 t->options.ifconfig_pool_start,
@@ -1066,12 +1066,12 @@ multi_connection_established (struct mul
 	{
 	  /* use pool ifconfig address(es) */
 	  mi->context.c2.push_ifconfig_local = remote;
-	  if (TUNNEL_TYPE (mi->context.c1.tuntap) == DEV_TYPE_TUN)
+	  if (NET_TYPE (mi->context.c1.tuntap) == NET_TYPE_PTP)
 	    {
 	      mi->context.c2.push_ifconfig_remote_netmask = local;
 	      mi->context.c2.push_ifconfig_defined = true;
 	    }
-	  else if (TUNNEL_TYPE (mi->context.c1.tuntap) == DEV_TYPE_TAP)
+	  else if (NET_TYPE (mi->context.c1.tuntap) == NET_TYPE_SUBNET)
 	    {
 	      mi->context.c2.push_ifconfig_remote_netmask = mi->context.c1.tuntap->remote_netmask;
 	      mi->context.c2.push_ifconfig_defined = true;

diff ./tun.c~current~ ./tun.c
--- ./tun.c~current~	2004-07-27 11:44:22.000000000 +1000
+++ ./tun.c	2004-07-27 11:44:22.000000000 +1000
@@ -157,23 +157,23 @@ ipv6_support (bool ipv6, bool ipv6_expli
 }
 
 /*
- * If !tun, make sure ifconfig_remote_netmask looks
+ * If !ptp, make sure ifconfig_remote_netmask looks
  *  like a netmask.
  *
- * If tun, make sure ifconfig_remote_netmask looks
+ * If ptp, make sure ifconfig_remote_netmask looks
  *  like an IPv4 address.
  */
 static void
-ifconfig_sanity_check (bool tun, in_addr_t addr)
+ifconfig_sanity_check (bool ptp, in_addr_t addr)
 {
   struct gc_arena gc = gc_new ();
   const bool looks_like_netmask = ((addr & 0xFF000000) == 0xFF000000);
-  if (tun)
+  if (ptp)
     {
       if (looks_like_netmask)
 	msg (M_WARN, "WARNING: Since you are using --dev tun, the second argument to --ifconfig must be an IP address.  You are using something (%s) that looks more like a netmask.", print_in_addr_t (addr, false, &gc));
     }
-  else /* tap */
+  else /* subnet */
     {
       if (!looks_like_netmask)
 	msg (M_WARN, "WARNING: Since you are using --dev tap, the second argument to --ifconfig must be a netmask, for example something like 255.255.255.0.");
@@ -213,7 +213,7 @@ check_addr_clash (const char *name,
 
   if (public)
     {
-      if (type == DEV_TYPE_TUN)
+      if (type == NET_TYPE_PTP)
 	{
 	  const in_addr_t test_netmask = 0xFFFFFF00;
 	  const in_addr_t public_net = public & test_netmask;
@@ -236,7 +236,7 @@ check_addr_clash (const char *name,
 		 print_in_addr_t (local, false, &gc),
 		 print_in_addr_t (remote_netmask, false, &gc));
 	}
-      else if (type == DEV_TYPE_TAP)
+      else if (type == NET_TYPE_SUBNET)
 	{
 	  const in_addr_t public_network = public & remote_netmask;
 	  const in_addr_t virtual_network = local & remote_netmask;
@@ -272,7 +272,7 @@ ifconfig_options_string (const struct tu
   struct buffer out = alloc_buf_gc (256, gc);
   if (tt->did_ifconfig_setup && !disable)
     {
-      if (tt->type == DEV_TYPE_TUN)
+      if (NET_TYPE(tt) == NET_TYPE_PTP)
 	{
 	  const char *l, *r;
 	  if (remote)
@@ -287,7 +287,7 @@ ifconfig_options_string (const struct tu
 	    }
 	  buf_printf (&out, "%s %s", r, l);
 	}
-      else if (tt->type == DEV_TYPE_TAP)
+      else if (NET_TYPE(tt) == NET_TYPE_SUBNET)
 	{
 	  buf_printf (&out, "%s %s",
 		      print_in_addr_t (tt->local & tt->remote_netmask, false, gc),
@@ -358,7 +358,7 @@ init_tun (const char *dev,       /* --de
 
   if (ifconfig_local_parm && ifconfig_remote_netmask_parm)
     {
-      bool tun = false;
+      bool ptp = false;
       const char *ifconfig_local = NULL;
       const char *ifconfig_remote_netmask = NULL;
       const char *ifconfig_broadcast = NULL;
@@ -366,10 +366,10 @@ init_tun (const char *dev,       /* --de
       /*
        * We only handle TUN/TAP devices here, not --dev null devices.
        */
-      if (tt->type == DEV_TYPE_TUN)
-	tun = true;
-      else if (tt->type == DEV_TYPE_TAP)
-	tun = false;
+      if (NET_TYPE(tt) == NET_TYPE_PTP)
+	ptp = true;
+      else if (NET_TYPE(tt) == NET_TYPE_SUBNET)
+	ptp = false;
       else
 	msg (M_FATAL, "'%s' is not a TUN/TAP device.  The --ifconfig option works only for TUN/TAP devices.", dev);
 
@@ -388,7 +388,7 @@ init_tun (const char *dev,       /* --de
 			   NULL);
 
       tt->remote_netmask = getaddr (
-				    (tun ? GETADDR_RESOLVE : 0)
+				    (ptp ? GETADDR_RESOLVE : 0)
 				    | GETADDR_FATAL
 				    | GETADDR_HOST_ORDER
 				    | GETADDR_FATAL_ON_SIGNAL,
@@ -397,7 +397,7 @@ init_tun (const char *dev,       /* --de
 				    NULL,
 				    NULL);
 
-      ifconfig_sanity_check (tun, tt->remote_netmask);
+      ifconfig_sanity_check (ptp, tt->remote_netmask);
 
       /*
        * If local_public or remote_public addresses are defined,
@@ -405,13 +405,13 @@ init_tun (const char *dev,       /* --de
        */
 
       check_addr_clash ("local",
-			tt->type,
+			NET_TYPE(tt),
 			local_public,
 			tt->local,
 			tt->remote_netmask);
 
       check_addr_clash ("remote",
-			tt->type,
+			NET_TYPE(tt),
 			remote_public,
 			tt->local,
 			tt->remote_netmask);
@@ -425,7 +425,7 @@ init_tun (const char *dev,       /* --de
       /*
        * If TAP-style interface, generate broadcast address.
        */
-      if (!tun)
+      if (!ptp)
 	{
 	  tt->broadcast = generate_ifconfig_broadcast_addr (tt->local, tt->remote_netmask);
 	  ifconfig_broadcast = print_in_addr_t (tt->broadcast, false, &gc);
@@ -435,7 +435,7 @@ init_tun (const char *dev,       /* --de
        * Set environmental variables with ifconfig parameters.
        */
       setenv_str ("ifconfig_local", ifconfig_local);
-      if (tun)
+      if (ptp)
 	{
 	  setenv_str ("ifconfig_remote", ifconfig_remote_netmask);
 	}
@@ -478,7 +478,7 @@ do_ifconfig (struct tuntap *tt,
 
   if (tt->did_ifconfig_setup)
     {
-      bool tun = false;
+      bool ptp = false;
       const char *ifconfig_local = NULL;
       const char *ifconfig_remote_netmask = NULL;
       const char *ifconfig_broadcast = NULL;
@@ -487,10 +487,10 @@ do_ifconfig (struct tuntap *tt,
       /*
        * We only handle TUN/TAP devices here, not --dev null devices.
        */
-      if (tt->type == DEV_TYPE_TUN)
-	tun = true;
-      else if (tt->type == DEV_TYPE_TAP)
-	tun = false;
+      if (NET_TYPE(tt) == NET_TYPE_PTP)
+	ptp = true;
+      else if (NET_TYPE(tt) == NET_TYPE_SUBNET)
+	ptp = false;
       else
 	ASSERT (0); /* should have been caught in init_tun */
 
@@ -503,7 +503,7 @@ do_ifconfig (struct tuntap *tt,
       /*
        * If TAP-style device, generate broadcast address.
        */
-      if (!tun)
+      if (!ptp)
 	ifconfig_broadcast = print_in_addr_t (tt->broadcast, false, &gc);
 
 #if defined(TARGET_LINUX)
@@ -520,7 +520,7 @@ do_ifconfig (struct tuntap *tt,
 	  system_check (command_line, "Linux ip link set failed", true);
 
 
-	if (tun) {
+	if (ptp) {
 
 		/*
 		 * Set the address for the device
@@ -547,7 +547,7 @@ do_ifconfig (struct tuntap *tt,
 	}
 	tt->did_ifconfig = true;
 #else
-      if (tun)
+      if (ptp)
 	openvpn_snprintf (command_line, sizeof (command_line),
 			  IFCONFIG_PATH " %s %s pointopoint %s mtu %d",
 			  actual,
@@ -572,7 +572,7 @@ do_ifconfig (struct tuntap *tt,
 #elif defined(TARGET_SOLARIS)
 
       /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-      if (tun)
+      if (ptp)
 	openvpn_snprintf (command_line, sizeof (command_line),
 			  IFCONFIG_PATH " %s %s %s mtu %d netmask 255.255.255.255 up",
 			  actual,
@@ -611,7 +611,7 @@ do_ifconfig (struct tuntap *tt,
       msg (M_INFO, "NOTE: Tried to delete pre-existing tun/tap instance -- No Problem if failure");
 
       /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-      if (tun)
+      if (ptp)
 	openvpn_snprintf (command_line, sizeof (command_line),
 			  IFCONFIG_PATH " %s %s %s mtu %d netmask 255.255.255.255 up",
 			  actual,
@@ -627,7 +627,7 @@ do_ifconfig (struct tuntap *tt,
 
 #elif defined(TARGET_NETBSD)
 
-      if (tun)
+      if (ptp)
 	openvpn_snprintf (command_line, sizeof (command_line),
 			  IFCONFIG_PATH " %s %s %s mtu %d netmask 255.255.255.255 up",
 			  actual,
@@ -656,7 +656,7 @@ do_ifconfig (struct tuntap *tt,
 
 
       /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-      if (tun)
+      if (ptp)
 	openvpn_snprintf (command_line, sizeof (command_line),
 			  IFCONFIG_PATH " %s %s %s mtu %d netmask 255.255.255.255 up",
 			  actual,
@@ -673,7 +673,7 @@ do_ifconfig (struct tuntap *tt,
 #elif defined(TARGET_FREEBSD)
 
       /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.255.255 up */
-      if (tun)
+      if (ptp)
 	openvpn_snprintf (command_line, sizeof (command_line),
 			  IFCONFIG_PATH " %s %s %s mtu %d netmask 255.255.255.255 up",
 			  actual,
@@ -702,7 +702,7 @@ do_ifconfig (struct tuntap *tt,
 	 * Make sure that both ifconfig addresses are part of the
 	 * same .252 subnet.
 	 */
-	if (tun)
+	if (ptp)
 	  {
 	    verify_255_255_255_252 (tt->local, tt->remote_netmask);
 	    tt->adapter_netmask = ~3;
@@ -2481,7 +2481,7 @@ open_tun (const char *dev, const char *d
       ep[1] = htonl (tt->adapter_netmask);
 
       /* At what IP address should the DHCP server masquerade at? */
-      if (tt->type == DEV_TYPE_TUN)
+      if (NET_TYPE(tt) == NET_TYPE_PTP)
 	{
 	  ep[2] = htonl (tt->remote_netmask);
 	  if (tt->options.dhcp_masq_custom_offset)
@@ -2491,7 +2491,7 @@ open_tun (const char *dev, const char *d
 	{
 	  in_addr_t dsa; /* DHCP server addr */
 
-	  ASSERT (tt->type == DEV_TYPE_TAP);
+	  ASSERT (NET_TYPE(tt) == NET_TYPE_SUBNET);
 
 	  if (tt->options.dhcp_masq_offset < 0)
 	    dsa = (tt->local | (~tt->adapter_netmask)) + tt->options.dhcp_masq_offset;

diff ./tun.h~current~ ./tun.h
--- ./tun.h~current~	2004-07-27 11:44:22.000000000 +1000
+++ ./tun.h	2004-07-27 11:44:22.000000000 +1000
@@ -107,9 +107,23 @@ struct tuntap_options {
  * Define a TUN/TAP dev.
  */
 
+/* The device can be configured as pointopoint or subnet */
+#define	NET_TYPE_UNDEF	0
+#define	NET_TYPE_PTP	2	/* two IP addresses */
+#define	NET_TYPE_SUBNET 3	/* an IP address and a subnet mask */
+
+static inline dev_to_net(int dev)
+{
+	/* values for NET_TYPE cunning chosen to match
+	 * DEV_TYPE for which they match 
+	 */
+	return dev;
+}
+
 struct tuntap
 {
 # define TUNNEL_TYPE(tt) ((tt) ? ((tt)->type) : DEV_TYPE_UNDEF)
+# define NET_TYPE(tt) (dev_to_net(TUNNEL_TYPE(tt)))
   int type; /* DEV_TYPE_x as defined in proto.h */
 
   bool did_ifconfig_setup;

