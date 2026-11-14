Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263CC606A327
	for <openvpn-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=A9cWejpU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RRIzOgjQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=IXQjhGEO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jGZszV3M8ObTRCtn4iGwFA8ody6F2YO9DEo0kxTAh/0=; b=A9cWejpUH6mmmo
	yEuxDNGlUIhwLWuHbtiYqE5019lUUXZ5jlErDMKDyhK7k9RF2fNb09+y0h9nIiksYzMi11ABTgSH8
	zaDthgvlmUB3OJkxw2gxLncHINyxhT0o7bqq012FLvTCJsLAv+qhk+MQtoJhJ3CgovEkfGx60VeQd
	iuk=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSH1n-000000005pc-3Jxq;
	Sat, 14 Nov 2026 16:54:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSH1m-000000005pN-0JoA for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:54:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HQxvjGFWgTiA7rHpxxrTpDmfBcBaILg3ZuXybi0Yevs=; b=RRIzOgjQ38HUWOwXZJiMbXKgt5
 f9heY6QxhQR7/kkZXI/1WozoR7Pg6KeOrEwPriTX2cM1gjdVyuyUcpF7VTmkx0kIhz0ra2XXd1ybz
 TDANGOgjnCjYEZ4bwyZID00bgSPWHvTqDTTBNodwENj7LgFHpUKT8C8BpRJTSi0wbwDg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HQxvjGFWgTiA7rHpxxrTpDmfBcBaILg3ZuXybi0Yevs=; b=IXQjhGEOlE3/iwRz6aAwi4IaY+
 +NZgW/a0tNnwdcB/b6WEPaMX0YUYoyf6bPiMQzmWS9f0fpLGdox1CLwUuiJMFUJ/t6vynYnOKDSmQ
 ygfj3GsGPEs4y2hYJTgRHlJvukbjekDi09gLM4eKPnkJwMCtCr0uV2XXEVhruapGeFvM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSH1k-000000002Bn-21Pb for openvpn-devel@lists.sourceforge.net;
 Sat, 14 Nov 2026 16:54:58 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AEGsnk3008016
 for <openvpn-devel@lists.sourceforge.net>; Sat, 14 Nov 2026 17:54:50 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AEGsnpQ008015
 for openvpn-devel@lists.sourceforge.net; Sat, 14 Nov 2026 17:54:49 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 14 Nov 2026 17:54:44 +0100
Message-ID: <20261114165449.8002-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793094393000.I4379a167419d464c000dca3c5c032aaebb6dac73@gerrit.openvpn.net>
References: <gerrit.1793094393000.I4379a167419d464c000dca3c5c032aaebb6dac73@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSH1k-000000002Bn-21Pb
Subject: [Openvpn-devel] [PATCH v3] multi_io: avoid redundant event_ctl()
 calls in multi_io_wait()
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

From: Gianmarco De Gregori <gianmarco@mandelbit.com>

multi_io_wait() registered each server UDP socket through
multi_io_process_flags(), which calls socket_set() without a persistent
cache and tun_set() once more for every UDP socket, also without a
cache. Both ended up in an event_ctl() on every loop iteration even
though nothing changed.

Now that the UDP sockets and the tun device are only ever armed for
reading, set them directly with EVENT_READ, caching the UDP socket
rwflags in the new link_socket.rwflags_persistent and the tun ones in
multi_io->tun_rwflags.

On a server with two UDP and one TCP listener this removes the
remaining epoll_ctl() calls from the loop (syscalls per received
packet 4.64 -> 3.36, UDP only 5.29 -> 3.77); at saturation the
server delivers 2-7% more traffic with UDP and uses 4-13% less CPU
at a fixed load.

With --enable-async-push the inotify descriptor was also registered on
every iteration; register it once (1504 -> 12 epoll_ctl() with
deferred auth).

Change-Id: I4379a167419d464c000dca3c5c032aaebb6dac73
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2050
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2050
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 375635b..2b29f69 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -73,8 +73,7 @@
  * Evaluates the current I/O state (`flags`) and context mode to determine
  * which READ or WRITE events to register in the event loop.
  *
- * @note This function gets called from client instances from @c io_wait()
- * and from p2mp (Point-to-multipoint) instances in @c multi_io_wait().
+ * @note This function gets called from @c io_wait().
  *
  * @param c      Pointer to the core context.
  * @param es     The event set where descriptors are registered.
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 50c95b5..2a88356d 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -136,7 +136,6 @@
 multi_io_wait(struct multi_context *m)
 {
     int status;
-    unsigned int *persistent = &m->multi_io->tun_rwflags;
 
     for (int i = 0; i < m->top.c1.link_sockets_num; i++)
     {
@@ -144,7 +143,7 @@
 
         if (proto_is_dgram(sock->info.proto))
         {
-            multi_io_process_flags(&m->top, m->multi_io->es, sock, IOW_READ | IOW_WAIT_SIGNAL);
+            socket_set(sock, m->multi_io->es, EVENT_READ, &sock->ev_arg, &sock->rwflags_persistent);
         }
         else if (!tuntap_is_dco_win(m->top.c1.tuntap))
         {
@@ -152,7 +151,7 @@
         }
     }
 
-    tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
+    tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, &m->multi_io->tun_rwflags);
 #if defined(ENABLE_DCO)
     dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
 #endif
@@ -167,7 +166,11 @@
 
 #ifdef ENABLE_ASYNC_PUSH
     /* arm inotify watcher */
-    event_ctl(m->multi_io->es, m->top.c2.inotify_fd, EVENT_READ, MULTI_IO_FILE_CLOSE_WRITE);
+    if (!m->multi_io->inotify_set)
+    {
+        event_ctl(m->multi_io->es, m->top.c2.inotify_fd, EVENT_READ, MULTI_IO_FILE_CLOSE_WRITE);
+        m->multi_io->inotify_set = true;
+    }
 #endif
 
     status =
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index e178240..6c7fd11 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -55,6 +55,7 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rwflags;
+    bool inotify_set;
 #ifdef ENABLE_MANAGEMENT
     unsigned int management_persist_flags;
 #endif
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 52e09c9..e320ff3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -177,6 +177,9 @@
     /* used for long-term queueing of pre-accepted socket listen */
     bool listen_persistent_queued;
 
+    /* last rwflags set on the shared server-side UDP socket */
+    unsigned int rwflags_persistent;
+
     const char *remote_host;
     const char *remote_port;
     const char *local_host;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
