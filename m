Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E41B606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 17:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=RZ9dZwtR;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gJbsY2Jr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ili/XDCm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pGXEbQxOZC44Agp5++OLM0rBZa422dfoi+8Nj//XAiY=; b=RZ9dZwtRMDj1tQ
	jSCm2w1rptRgId9O8xWF/NJHiVvMcLqp9W/J567OTIkghFROdK9iwJcW2XzzG5eOFtrdMUPAqQZCY
	/etj5C1W2/zbbk7hG8xq8FEVE/zPHV2UspnPO1PwPJHQ3PwzsWyfAXMepMItlzDfrY/JCU8HjBxlO
	Yxg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTjqk-0000000040T-0AEE;
	Wed, 18 Nov 2026 17:53:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xTjqi-0000000040M-2PkP for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:53:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7FDPzzWJioc9jz0tzvGQXg3E3f0wDAHftsuH2yOMOwc=; b=gJbsY2JraJ0MDHAez/XQY93+p7
 jbki+7jhmF3hcpdWMlZXnqWP+HA4zwjAlPW5zwPVO5jgD2pqg/elLcGohGlKliOyUgHy4ybTfzLNm
 hFXz302Nl5S/McC9K+ZCPpL2K4/jVv4XAv+6PAtCo8TsspfoHV4XuLiSI56R/vGEFm74=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7FDPzzWJioc9jz0tzvGQXg3E3f0wDAHftsuH2yOMOwc=; b=ili/XDCmsO3Th2yEvLyNF7kMUM
 YmFbc5U6+rxapMPF9UO4Qu7PbR2bWnnQmGgqVTEh0fLXsiJ05kVgLJjTd5ryu1ZDbRSS5XnYwmdL1
 7f4pTC21aiU/rY62J4PYuCKaV9hcLEkc3tPtnr8IawMwvgi1sr5veBA8/xVLSXHqzHeI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTjqh-00000000669-1rIB for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 17:53:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AIHrS5K032759
 for <openvpn-devel@lists.sourceforge.net>; Wed, 18 Nov 2026 18:53:28 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AIHrSKW032758
 for openvpn-devel@lists.sourceforge.net; Wed, 18 Nov 2026 18:53:28 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 18 Nov 2026 18:53:23 +0100
Message-ID: <20261118175328.32744-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
References: <gerrit.1794924454000.I978041ea4e6323f5a92d8721809f0fa44b9c2e03@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xTjqh-00000000669-1rIB
Subject: [Openvpn-devel] [PATCH v3] socket: pause the listeners when
 accept() runs out of resources
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

When accept() fails with EMFILE, Linux and FreeBSD leave the pending
connection in the listen queue and the level-triggered listener is
reported again on every wait. The server keeps creating and destroying
an instance for it, never gets an empty event set, so the timers do not
run and hand-window never reaps the idle connections that hold the
descriptors: the server stays at 100% CPU, writes the failure to the log
in a loop and stops serving new TCP and UDP clients until the peer
closes its connections. A management client connecting while the
descriptors are exhausted causes the same loop on the management
listener.

When accept() fails for lack of resources, stop polling the TCP
listeners and, in server mode, the management listener for up to a
second. Clients may see failed connections meanwhile, so log a warning,
at most once a minute.

GitHub: OpenVPN/openvpn#1148
Change-Id: I978041ea4e6323f5a92d8721809f0fa44b9c2e03
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2210
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2210
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index ae30930..bada1ae 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3292,6 +3292,18 @@
     msg(M_CLIENT, ">PASSWORD:Auth-Token:%s", token);
 }
 
+/**
+ * Track which event the management socket is registered for in a persistent
+ * event set, so that event_ctl() is only called when it changes.
+ *
+ * @param persistent  The cached state, or NULL if the event set is rebuilt
+ *                    before every wait.
+ * @param n           The new state: 1 listening, 2 waiting to read from the
+ *                    client, 3 waiting to write to the client, 4 listening
+ *                    while accept() is paused for lack of resources.
+ *
+ * @return true if the socket must be registered again with event_ctl().
+ */
 static inline bool
 man_persist_state(unsigned int *persistent, const int n)
 {
@@ -3320,11 +3332,14 @@
         switch (man->connection.state)
         {
             case MS_LISTEN:
-                if (man_persist_state(persistent, 1))
+            {
+                const bool paused = (man->settings.flags & MF_SERVER) && socket_accept_paused();
+                if (man_persist_state(persistent, paused ? 4 : 1))
                 {
-                    event_ctl(es, ev, EVENT_READ, arg);
+                    event_ctl(es, ev, paused ? 0 : EVENT_READ, arg);
                 }
                 break;
+            }
 
             case MS_CC_WAIT_READ:
                 if (man_persist_state(persistent, 2))
@@ -3402,11 +3417,14 @@
     switch (man->connection.state)
     {
         case MS_LISTEN:
-            if (man_persist_state(persistent, 1))
+        {
+            const bool paused = (man->settings.flags & MF_SERVER) && socket_accept_paused();
+            if (man_persist_state(persistent, paused ? 4 : 1))
             {
-                event_ctl(es, man->connection.sd_top, EVENT_READ, arg);
+                event_ctl(es, man->connection.sd_top, paused ? 0 : EVENT_READ, arg);
             }
             break;
+        }
 
         case MS_CC_WAIT_READ:
             if (man_persist_state(persistent, 2))
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e07b691..c06fbda 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -187,10 +187,25 @@
         }
         else if (!tuntap_is_dco_win(m->top.c1.tuntap))
         {
-            socket_set_listen_persistent(sock, m->multi_io->es, &sock->ev_arg);
+            if (socket_accept_paused())
+            {
+                socket_unset_listen_persistent(sock, m->multi_io->es);
+            }
+            else
+            {
+                socket_set_listen_persistent(sock, m->multi_io->es, &sock->ev_arg);
+            }
         }
     }
 
+    const time_t delay = socket_accept_paused();
+    if (delay && m->top.c2.timeval.tv_sec >= delay)
+    {
+        m->top.c2.timeval.tv_sec = (tv_sec_t)delay;
+        m->top.c2.timeval.tv_usec = 0;
+        m->earliest_wakeup = NULL;
+    }
+
     tun_set(m->top.c1.tuntap, m->multi_io->es, EVENT_READ, MULTI_IO_TUN, persistent);
 #if defined(ENABLE_DCO)
     dco_event_set(&m->top.c1.tuntap->dco, m->multi_io->es, MULTI_IO_DCO);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c07ef60..d756527 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -422,6 +422,38 @@
     gc_free(&gc);
 }
 
+/* accept() failed for lack of resources: no new accept() before this time */
+static time_t accept_resume = 0;       /* GLOBAL */
+static time_t accept_pause_logged = 0; /* GLOBAL */
+
+static void
+accept_check_resources(const int err)
+{
+#ifdef _WIN32
+    const bool out_of_resources = (err == WSAEMFILE || err == WSAENOBUFS);
+#else
+    const bool out_of_resources =
+        (err == EMFILE || err == ENFILE || err == ENOBUFS || err == ENOMEM);
+#endif
+    if (out_of_resources)
+    {
+        accept_resume = now + 1;
+        if (now >= accept_pause_logged + 60)
+        {
+            msg(M_WARN, "WARNING: out of resources to accept new connections, not accepting any "
+                        "for a second. New connections may fail meanwhile; check the open files "
+                        "limit. This message is shown at most once a minute.");
+            accept_pause_logged = now;
+        }
+    }
+}
+
+time_t
+socket_accept_paused(void)
+{
+    return now < accept_resume ? accept_resume - now : 0;
+}
+
 #if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic push
 #pragma GCC diagnostic ignored "-Wsign-conversion"
@@ -456,6 +488,10 @@
     else
     {
         new_sd = accept(sd, &act->dest.addr.sa, &remote_len);
+        if (!socket_defined(new_sd))
+        {
+            accept_check_resources(openvpn_errno());
+        }
     }
 
 #if 0 /* For debugging only, test the effect of accept() failures */
@@ -2700,6 +2736,10 @@
          * scripts don't have access to it */
         set_cloexec(ret);
     }
+    else
+    {
+        accept_check_resources(openvpn_errno());
+    }
     return ret;
 }
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2210bfe..6324a17 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -410,6 +410,9 @@
                                                  const char *bind_dev, struct addrinfo *bind_addr,
                                                  bool bind_ipv6_only, bool optional);
 
+/* Seconds left before accept() is retried after it failed for lack of resources */
+time_t socket_accept_paused(void);
+
 socket_descriptor_t socket_do_accept(socket_descriptor_t sd, struct link_socket_actual *act,
                                      const bool nowait);
 
@@ -846,6 +849,16 @@
 }
 
 static inline void
+socket_unset_listen_persistent(struct link_socket *sock, struct event_set *es)
+{
+    if (sock && sock->listen_persistent_queued)
+    {
+        event_del(es, socket_listen_event_handle(sock));
+        sock->listen_persistent_queued = false;
+    }
+}
+
+static inline void
 socket_reset_listen_persistent(struct link_socket *sock)
 {
 #ifdef _WIN32


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
