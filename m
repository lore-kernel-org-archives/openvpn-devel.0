Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E71C5DF9D
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XusDdBb9lwMNIj2+fFecu9CUSBSRV6xMdk02wluy06A=; b=IQuRupCzLR/FAJExZV6sHmXCKl
	E+Om2ZqOjEHAOur7nkf4+PEUcqNeKEWU7uUZbCHY4XXG26qj1msqKTT3Y8+XhIAh5FoI2jnMqgAw0
	WOnhtOFfKgw/4W9/4a5xe3/XVsI+Fl6mVqheJcb8/xxhPVytwiSGYhhKNC+/W/XC225M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyXBW-0002r1-8g;
	Mon, 24 Aug 2026 16:06:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyXBU-0002qt-If
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:06:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S7D3FOsdexT/DfHblc5bcl77XJxUGs1+zfIm1iYIxO0=; b=MTrpkQ52N97ZBhnAKCot2nNz3k
 +czSzTI/+2FDa9jsCUPZFXUyptFM25pwBelAXeOPaWjN6VIQyRnUNFbScjO44Uw7vILr+dJ+Efhgm
 u7m7VvJtGUVAqj1nAQO1o9enDExZwewcqAjp5AlPWhMNYS2sy+lTb777ObCoXBuaHtuQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S7D3FOsdexT/DfHblc5bcl77XJxUGs1+zfIm1iYIxO0=; b=MaaFXaqM9/i7Qxo8iDvU7DAWPG
 j5kyiNWilAy7nDf3xLpodm7Xl2H3CQcbyA2A1pbfvmN6v0rWndnwb2rVctGydUa1qFnSyVbmTXNDZ
 WcMiogTiFVQ8+rMrl+heThQPpKTXnLfNLuaamo3gYwNVyT1sbgtaHla7SrP7wOc+KObY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyXBR-00019g-71 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 16:06:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OG5saX000775
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 18:05:54 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OG5s9r000774
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 18:05:54 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 18:05:47 +0200
Message-ID: <20260824160553.761-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
References: <gerrit.1768578994000.I7be7427480d3540d43dd818eddb6eb5860956459@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyXBR-00019g-71
Subject: [Openvpn-devel] [PATCH v10] socket: Fix various conversion warnings
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Frank Lichtenheld <frank@lichtenheld.com>

- We assume that addrinfo->ai_family always fits
  into a sa_family_t, so we do not check those.
- Reduce places where we explicitly pass ai_family
  and prefer sock->info.af.
- Make sure that --bind-dev has a suitable length.
- Treat PROTO_* as uint8_t where possible (however,
  much code uses proto = -1 for various error handling).

Change-Id: I7be7427480d3540d43dd818eddb6eb5860956459
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1476
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1476
This mail reflects revision 10 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 107b3fa9..089bff4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5125,7 +5125,15 @@
     else if (streq(p[0], "bind-dev") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);
-        options->bind_dev = p[1];
+        if (strlen(p[1]) < IFNAMSIZ)
+        {
+            options->bind_dev = p[1];
+        }
+        else
+        {
+            msg(msglevel, "argument to --bind-dev is longer than allowed %u", IFNAMSIZ - 1);
+            goto err;
+        }
     }
 #endif
     else if (streq(p[0], "txqueuelen") && p[1] && !p[2])
@@ -5211,11 +5219,9 @@
     }
     else if (streq(p[0], "proto") && p[1] && !p[2])
     {
-        int proto;
-        sa_family_t af;
         VERIFY_PERMISSION(OPT_P_GENERAL | OPT_P_CONNECTION);
-        proto = ascii2proto(p[1]);
-        af = ascii2af(p[1]);
+        int proto = ascii2proto(p[1]);
+        sa_family_t af = ascii2af(p[1]);
         if (proto < 0)
         {
             msg(msglevel, "Bad protocol: '%s'. Allowed protocols with --proto option: %s", p[1],
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0f66ad51..0a08267 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -619,28 +619,23 @@
 }
 
 static void
-bind_local(struct link_socket *sock, const sa_family_t ai_family)
+bind_local(struct link_socket *sock)
 {
     /* bind to local address/port */
     if (sock->bind_local)
     {
         if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
         {
-            socket_bind(sock->ctrl_sd, sock->info.lsa->bind_local, ai_family, "SOCKS", false);
+            socket_bind(sock->ctrl_sd, sock->info.lsa->bind_local, sock->info.af, "SOCKS", false);
         }
         else
         {
-            socket_bind(sock->sd, sock->info.lsa->bind_local, ai_family, "TCP/UDP",
+            socket_bind(sock->sd, sock->info.lsa->bind_local, sock->info.af, "TCP/UDP",
                         sock->info.bind_ipv6_only);
         }
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 create_socket(struct link_socket *sock, struct addrinfo *addr)
 {
@@ -672,7 +667,7 @@
     }
     /* Set af field of sock->info, so it always reflects the address family
      * of the created socket */
-    sock->info.af = addr->ai_family;
+    sock->info.af = (sa_family_t)addr->ai_family;
 
     /* set socket buffers based on --sndbuf and --rcvbuf options */
     socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
@@ -684,8 +679,9 @@
     if (sock->bind_dev)
     {
         msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
+        /* Note: We verify strlen of bind_dev in options parsing */
         if (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
-                       strlen(sock->bind_dev) + 1)
+                       (socklen_t)(strlen(sock->bind_dev) + 1))
             != 0)
         {
             msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s failed", sock->bind_dev);
@@ -693,13 +689,9 @@
     }
 #endif
 
-    bind_local(sock, addr->ai_family);
+    bind_local(sock);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #ifdef TARGET_ANDROID
 static void
 protect_fd_nonlocal(int fd, const struct sockaddr *addr)
@@ -1131,13 +1123,8 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
-resolve_bind_local(struct link_socket *sock, const sa_family_t af)
+resolve_bind_local(struct link_socket *sock)
 {
     struct gc_arena gc = gc_new();
 
@@ -1153,12 +1140,12 @@
         }
 
         /* will return AF_{INET|INET6}from local_host */
-        status = get_cached_dns_entry(sock->dns_cache, sock->local_host, sock->local_port, af,
+        status = get_cached_dns_entry(sock->dns_cache, sock->local_host, sock->local_port, sock->info.af,
                                       flags, &sock->info.lsa->bind_local);
 
         if (status)
         {
-            status = openvpn_getaddrinfo(flags, sock->local_host, sock->local_port, 0, NULL, af,
+            status = openvpn_getaddrinfo(flags, sock->local_host, sock->local_port, 0, NULL, sock->info.af,
                                          &sock->info.lsa->bind_local);
         }
 
@@ -1179,7 +1166,7 @@
             /* the resolved 'local entry' might have a different family than
              * what was globally configured
              */
-            sock->info.af = sock->info.lsa->bind_local->ai_family;
+            sock->info.af = (sa_family_t)sock->info.lsa->bind_local->ai_family;
         }
     }
 
@@ -1382,7 +1369,8 @@
 
     sock->mark = o->mark;
     sock->bind_dev = o->bind_dev;
-    sock->info.proto = proto;
+    ASSERT(proto >= 0 && proto < PROTO_N);
+    sock->info.proto = (uint8_t)proto;
     sock->info.af = o->ce.af;
     sock->info.remote_float = o->ce.remote_float;
     sock->info.lsa = &c->c1.link_socket_addrs[sock_index];
@@ -1448,7 +1436,7 @@
     {
         if (sock->bind_local)
         {
-            resolve_bind_local(sock, sock->info.af);
+            resolve_bind_local(sock);
         }
         resolve_remote(sock, 1, NULL);
     }
@@ -1713,9 +1701,9 @@
              * and we should not connect a remote */
             if (sock->info.af == AF_UNSPEC)
             {
+                sock->info.af = (sa_family_t)sock->info.lsa->bind_local->ai_family;
                 msg(M_WARN, "Could not determine IPv4/IPv6 protocol. Using %s",
-                    addr_family_name(sock->info.lsa->bind_local->ai_family));
-                sock->info.af = sock->info.lsa->bind_local->ai_family;
+                    addr_family_name(sock->info.af));
             }
             create_socket(sock, sock->info.lsa->bind_local);
         }
@@ -1775,10 +1763,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 link_socket_close(struct link_socket *sock)
 {
@@ -2384,8 +2368,8 @@
     else if (cmsg != NULL)
     {
         msg(M_WARN,
-            "CMSG received that cannot be parsed (cmsg_level=%d, cmsg_type=%d, cmsg=len=%d)",
-            (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cmsg_len);
+            "CMSG received that cannot be parsed (cmsg_level=%d, cmsg_type=%d, cmsg=len=%zu)",
+            cmsg->cmsg_level, cmsg->cmsg_type, (size_t)cmsg->cmsg_len);
     }
 
     return buf->len;
diff --git a/src/openvpn/socket_util.c b/src/openvpn/socket_util.c
index 0194f38..913ac69 100644
--- a/src/openvpn/socket_util.c
+++ b/src/openvpn/socket_util.c
@@ -356,7 +356,7 @@
     const char *short_form;
     const char *display_form;
     sa_family_t proto_af;
-    int proto;
+    uint8_t proto;
 };
 
 /* Indexed by PROTO_x */


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
