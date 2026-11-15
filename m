Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7A2606A327
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 16:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iPVDPspy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Fun0G04+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OWYD69H1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=J878fV2KvdAW5xSMHAGKOuBsgrqKf7q6QYd7md0EMwU=; b=iPVDPspytRTMDi
	P/DJlMHOsKgqFNjEmfSnGnPOug/hsm+Gy9PMtFFiXcYG2XdRjU65EYwHVgW43VesccxJi4HryvbqY
	9yrqf49y7Jzv/X6T6nqcTu59eMRK3gZNigId7imX97a8yR1bl/HpyA061P+qathpoufsZp4I04gya
	Rxs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSdKP-000000002mX-3vrO;
	Sun, 15 Nov 2026 16:43:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSdKO-000000002mI-0ryg for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:43:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQ87OEVZb07QuFnxcQOtNxRLfEMrSY1jSqe67dp3bxY=; b=Fun0G04+hSLaonL7ZC50zDRQsG
 IAGzTXg1gQw6Vo+cJQ319Mwyc8w8bmxYfQ+uuXzPC2rqJSRsc2uJNWcFzulsFHZd2kJ9LgyqKiK3p
 kKtXf0JjVA8BhwdZcuMGTOU0vhVy/LTf2UOlk5nLPpMxCzQ2s6Sw8XpnBFw4uf+MFu2g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tQ87OEVZb07QuFnxcQOtNxRLfEMrSY1jSqe67dp3bxY=; b=OWYD69H1iYxBER/6Z6K7Otl2zi
 jafgcl93nzOatni8f2LQqTtcuOea9/bQ3ykASQ5gu7yYjWM+K+1FdmJSKUYR6Jm9lGji+w7jcj+yn
 u4wJHlveqNg4Ivx/YJkrtncLnGIDyhcwcLX4PHuzFRnUsZlOJ+tqsqOe9C96h9lx0kOI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSdKM-000000003X8-2e7V for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 16:43:40 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AFGhVJF008525
 for <openvpn-devel@lists.sourceforge.net>; Sun, 15 Nov 2026 17:43:31 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFGhVC7008524
 for openvpn-devel@lists.sourceforge.net; Sun, 15 Nov 2026 17:43:31 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 15 Nov 2026 17:43:24 +0100
Message-ID: <20261115164331.8511-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSdKM-000000003X8-2e7V
Subject: [Openvpn-devel] [PATCH v3] DragonFly: bring things back into a
 working state
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

- t_client.sh(.in): add "DragonFly" to the OS versions "like FreeBSD"

- tun.c open_tun()
   - add DragonFly specific handling of dynamic tun/tap devices
     (open /dev/{tun,tap}, assigns first-free node, fdevname(fd) returns
      true device name)
     --dev tunN (and tapN) works "the old way", by opening /dev/tunN - but
     only for devices pre-created with "ifconfig tun3 create"
   - set ioctl(TUNSIFMODE, IFF_BROADCAST=1) for "topology subnet" tun ifs
     -> this is sufficient to make FreeBSD "ifconfig ipv4" code work
     (DragonFly was broken by FreeBSD commit 94db3261659)

- tun.c do_ifconfig_ipv4()
   - use TARGET_FREEBSD code path for DragonFly too, just amend the
     error message ("FreeBSD/DragonFly ifconfig failed")

- tun.c do_ifconfig_ipv6()
   - needs "add_route_connected_v6_net()" for tun and tap(!) devices,
     otherwise the on-link /64 is not routed to the tun device

- tun.c undo_ifconfig_ipv4(), undo_ifconfig_ipv6()
   - share FreeBSD code to undo IPv4/IPv6 ifconfig on precreated interfaces
   - add delete_route_connected_v6_net() call for DragonFly only
     (this is not removing fe80:: addresses from the tun if, which upsets
      t_client test, but for normal usage is considered "reasonably fine")

- lladdr.c: add TARGET_DRAGONFLY to TARGET_FREEBSD format

v1 -> v2:
 - fix clang-format issues
 - introduce TUNSIFMODE setting
 - revert do_ifconfig_ipv4 change from v1 (use FREEBSD code path)
 - use M_ERR instead of M_FATAL
 - gate --dev tun/tap check on --dev-node being unset

v2 -> v3:
 - clang-format in lladdr.c and t_client.sh.in

Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
Signed-off-by: Gert Doering <gert@greenie.muc.de>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2170
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2170
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index 8bd572a..43480f1 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -24,7 +24,7 @@
 }
 #else /* TARGET_LINUX */
 
-#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN)
+#if defined(TARGET_OPENBSD) || defined(TARGET_FREEBSD) || defined(TARGET_DARWIN) || defined(TARGET_DRAGONFLY)
 #define IFCONFIG_LLADDR_FMT "%s %s lladdr %s"
 #elif defined(TARGET_NETBSD)
 #define IFCONFIG_LLADDR_FMT "%s %s link %s active"
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 70fdd7e..c1c5548 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -979,7 +979,7 @@
 #endif /* ifdef _WIN32 */
 }
 
-#if defined(_WIN32)
+#if defined(_WIN32) || defined(TARGET_DRAGONFLY)
 
 /* some of the platforms will auto-add a "network route" pointing
  * to the interface on "ifconfig tunX 2001:db8::1/64", others need
@@ -1160,6 +1160,10 @@
     openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD BSD 'ifconfig inet6 -ifdisabled' failed");
 #endif
 
+#ifdef TARGET_DRAGONFLY
+    add_route_connected_v6_net(tt, es);
+#endif
+
 #elif defined(TARGET_AIX)
     argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifname, ifconfig_ipv6_local,
                 tt->netbits_ipv6, tun_mtu);
@@ -1490,7 +1494,7 @@
     }
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed");
+    openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD/DragonFly ifconfig failed");
 
 #elif defined(TARGET_AIX)
     {
@@ -1623,14 +1627,14 @@
             msg(M_WARN, "Linux can't del IP from iface %s", tt->actual_name);
         }
     }
-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
     struct gc_arena gc = gc_new();
     const char *ifconfig_local = print_in_addr_t(tt->local, 0, &gc);
     struct argv argv = argv_new();
 
     argv_printf(&argv, "%s %s %s -alias", IFCONFIG_PATH, tt->actual_name, ifconfig_local);
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "FreeBSD ip addr del failed");
+    openvpn_execve_check(&argv, NULL, 0, "FreeBSD/DragonFly ip addr del failed");
 
     argv_free(&argv);
     gc_free(&gc);
@@ -1646,7 +1650,12 @@
     {
         msg(M_WARN, "Linux can't del IPv6 from iface %s", tt->actual_name);
     }
-#elif defined(TARGET_FREEBSD)
+#elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
+
+#ifdef TARGET_DRAGONFLY
+    delete_route_connected_v6_net(tt);
+#endif
+
     struct gc_arena gc = gc_new();
     const char *ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0, &gc);
     struct argv argv = argv_new();
@@ -1655,7 +1664,7 @@
                 ifconfig_ipv6_local, tt->netbits_ipv6);
 
     argv_msg(M_INFO, &argv);
-    openvpn_execve_check(&argv, NULL, 0, "FreeBSD ip -6 addr del failed");
+    openvpn_execve_check(&argv, NULL, 0, "FreeBSD/DragonFly ip -6 addr del failed");
 
     argv_free(&argv);
     gc_free(&gc);
@@ -2897,20 +2906,70 @@
 
 #elif defined(TARGET_DRAGONFLY)
 
+/* DragonFly tun/tap devices are similar to NetBSD
+ *  - for a dynamic tun/tap, open /dev/tun or /dev/tap, get assigned
+ *    the first free device, ask with (f)devname(3) what you got, and
+ *    the interface will auto-destruct on close
+ *  - for a pre-created tun/tap, open "/dev/tun3"
+ *  - using "--dev tun3" and have it dynamically created needs a call
+ *    to "ifconfig tun3 create" which we don't currently do
+ */
+
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, tt);
-
-    if (tt->fd >= 0)
+    if (!dev_node && (strcmp(dev, "tap") == 0 || strcmp(dev, "tun") == 0))
     {
-        int i = 0;
+        char tunname[256];
+        snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
 
-        /* Disable extended modes */
+        if ((tt->fd = open(tunname, O_RDWR)) < 0)
+        {
+            msg(M_ERR, "Cannot allocate DragonFly TUN/TAP %s dynamically", tunname);
+        }
+
+        char *devname = fdevname(tt->fd);
+        if (devname == NULL)
+        {
+            msg(M_ERR, "Cannot query DragonFly TUN/TAP device name");
+        }
+        set_nonblock(tt->fd);
+        set_cloexec(tt->fd); /* don't pass fd to scripts */
+        msg(M_INFO, "TUN/TAP device %s opened", devname);
+
+        tt->actual_name = string_alloc(devname, NULL);
+    }
+    else
+    {
+        open_tun_generic(dev, dev_type, dev_node, tt);
+    }
+
+    if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
+    {
+        /* see "Interface Flags" in ifnet(9) */
+        int i = IFF_POINTOPOINT | IFF_MULTICAST;
+        if (tt->topology == TOP_SUBNET)
+        {
+            i = IFF_BROADCAST | IFF_MULTICAST;
+        }
+
+        if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
+        {
+            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
+        }
+
+        /* Disable "link layer" mode (would prepend route-nexthop address
+         * on read, but is incompatible with TUNSIFHEAD multi-af mode) */
+        i = 0;
         ioctl(tt->fd, TUNSLMODE, &i);
+
+        /* multi_af mode for v4+v6, see "tun(4)" */
         i = 1;
-        ioctl(tt->fd, TUNSIFHEAD, &i);
+        if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
+        {
+            msg(M_WARN | M_ERRNO, "ioctl(TUNSIFHEAD)");
+        }
     }
 }
 
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 5e924bb..d81cef0 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -212,8 +212,8 @@
                 LANG=C @NETSTAT@ -rn -4 -6
             fi
             ;;
-        FreeBSD | NetBSD | Darwin)
-            echo "-- FreeBSD/NetBSD/Darwin [MacOS X] --"
+        FreeBSD | DragonFly | NetBSD | Darwin)
+            echo "-- FreeBSD/DragonFly/NetBSD/Darwin [MacOS X] --"
             @IFCONFIG@ -a | egrep "(flags=|inet)"
             @NETSTAT@ -rn | awk '$3 !~ /^UHL/ { print $1,$2,$3,$NF }'
             ;;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
