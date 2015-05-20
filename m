Message-ID: <555BF270.3090706@...1147...>
Date: Wed, 20 May 2015 04:33:20 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010408050001030203090006"
Subject: [Openvpn-devel] patch for bug #93: up-restart env vars
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------010408050001030203090006
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

hi all,

here's my patch for bug #93: missing ifconfig_* env vars after 
up-restart. Tested with both IPv4, IPv6, topology subnet and topology net30

cheers,

JJK




--------------010408050001030203090006
Content-Type: text/x-patch;
 name="ifconfig_envvar.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ifconfig_envvar.patch"

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 42cb3e2..a4b5e05 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1486,6 +1486,9 @@ do_open_tun (struct context *c)
       msg (M_INFO, "Preserving previous TUN/TAP instance: %s",
 	   c->c1.tuntap->actual_name);
 
+      /* explicitly set the ifconfig_* env vars */
+      do_ifconfig_setenv(c->c1.tuntap, c->c2.es);
+    
       /* run the up script if user specified --up-restart */
       if (c->options.up_restart)
 	run_up_down (c->options.up_script,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ce3ed85..aeff5e7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -397,6 +397,45 @@ is_tun_p2p (const struct tuntap *tt)
 }
 
 /*
+ * Set the ifconfig_* environment variables, both for IPv4 and IPv6
+ */
+void
+do_ifconfig_setenv (const struct tuntap *tt, struct env_set *es)
+{
+  struct gc_arena gc = gc_new ();
+  bool tun = is_tun_p2p (tt);
+  const char *ifconfig_local = print_in_addr_t (tt->local, 0, &gc);
+  const char *ifconfig_remote_netmask = print_in_addr_t (tt->remote_netmask, 0, &gc);
+
+  /*
+   * Set environmental variables with ifconfig parameters.
+   */
+  setenv_str (es, "ifconfig_local", ifconfig_local);
+  if (tun)
+  {
+    setenv_str (es, "ifconfig_remote", ifconfig_remote_netmask);
+  }
+  else
+  {
+    const char *ifconfig_broadcast = print_in_addr_t (tt->broadcast, 0, &gc);
+    setenv_str (es, "ifconfig_netmask", ifconfig_remote_netmask);
+    setenv_str (es, "ifconfig_broadcast", ifconfig_broadcast);
+  }
+
+  if (tt->did_ifconfig_ipv6_setup)
+  {
+    const char *ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
+    const char *ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
+
+    setenv_str (es, "ifconfig_ipv6_local", ifconfig_ipv6_local);
+    setenv_int (es, "ifconfig_ipv6_netbits", tt->netbits_ipv6);
+    setenv_str (es, "ifconfig_ipv6_remote", ifconfig_ipv6_remote);
+  }
+
+  gc_free (&gc);
+}
+
+/*
  * Init tun/tap object.
  *
  * Set up tuntap structure for ifconfig,
@@ -428,9 +467,6 @@ init_tun (const char *dev,       /* --dev option */
   if (ifconfig_local_parm && ifconfig_remote_netmask_parm)
     {
       bool tun = false;
-      const char *ifconfig_local = NULL;
-      const char *ifconfig_remote_netmask = NULL;
-      const char *ifconfig_broadcast = NULL;
 
       /*
        * We only handle TUN/TAP devices here, not --dev null devices.
@@ -471,7 +507,7 @@ init_tun (const char *dev,       /* --dev option */
 
 	  /*
 	   * If local_public or remote_public addresses are defined,
-	   * make sure they do not clash with our virtual subnet.
+	    make sure they do not clash with our virtual subnet.
 	   */
 
           for(curele=local_public;curele;curele=curele->ai_next) {
@@ -499,44 +535,19 @@ init_tun (const char *dev,       /* --dev option */
 	}
 
       /*
-       * Set ifconfig parameters
-       */
-      ifconfig_local = print_in_addr_t (tt->local, 0, &gc);
-      ifconfig_remote_netmask = print_in_addr_t (tt->remote_netmask, 0, &gc);
-
-      /*
        * If TAP-style interface, generate broadcast address.
        */
       if (!tun)
 	{
 	  tt->broadcast = generate_ifconfig_broadcast_addr (tt->local, tt->remote_netmask);
-	  ifconfig_broadcast = print_in_addr_t (tt->broadcast, 0, &gc);
 	}
 
-      /*
-       * Set environmental variables with ifconfig parameters.
-       */
-      if (es)
-	{
-	  setenv_str (es, "ifconfig_local", ifconfig_local);
-	  if (tun)
-	    {
-	      setenv_str (es, "ifconfig_remote", ifconfig_remote_netmask);
-	    }
-	  else
-	    {
-	      setenv_str (es, "ifconfig_netmask", ifconfig_remote_netmask);
-	      setenv_str (es, "ifconfig_broadcast", ifconfig_broadcast);
-	    }
-	}
 
       tt->did_ifconfig_setup = true;
     }
 
   if (ifconfig_ipv6_local_parm && ifconfig_ipv6_remote_parm)
     {
-      const char *ifconfig_ipv6_local = NULL;
-      const char *ifconfig_ipv6_remote = NULL;
 
       /*
        * Convert arguments to binary IPv6 addresses.
@@ -549,24 +560,14 @@ init_tun (const char *dev,       /* --dev option */
 	}
       tt->netbits_ipv6 = ifconfig_ipv6_netbits_parm;
 
-      /*
-       * Set ifconfig parameters
-       */
-      ifconfig_ipv6_local = print_in6_addr (tt->local_ipv6, 0, &gc);
-      ifconfig_ipv6_remote = print_in6_addr (tt->remote_ipv6, 0, &gc);
-
-      /*
-       * Set environmental variables with ifconfig parameters.
-       */
-      if (es)
-	{
-	  setenv_str (es, "ifconfig_ipv6_local", ifconfig_ipv6_local);
-	  setenv_int (es, "ifconfig_ipv6_netbits", tt->netbits_ipv6);
-	  setenv_str (es, "ifconfig_ipv6_remote", ifconfig_ipv6_remote);
-	}
       tt->did_ifconfig_ipv6_setup = true;
     }
 
+  /*
+   * Set environmental variables with ifconfig parameters.
+   */
+  if (es) do_ifconfig_setenv(tt, es);
+
   gc_free (&gc);
   return tt;
 }
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 79e2d18..65bacac 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -241,6 +241,9 @@ void init_tun_post (struct tuntap *tt,
 		    const struct frame *frame,
 		    const struct tuntap_options *options);
 
+void do_ifconfig_setenv (const struct tuntap *tt,
+		  struct env_set *es);
+
 void do_ifconfig (struct tuntap *tt,
 		  const char *actual,    /* actual device name */
 		  int tun_mtu,

--------------010408050001030203090006--

