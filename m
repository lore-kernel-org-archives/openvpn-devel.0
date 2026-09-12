Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9940CC88E53
	for <openvpn-devel@archiver.kernel.org>; Sat, 12 Sep 2026 09:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R43MbRpNNkweUgV4gMmTU7ZnknhIkNnfyeBMscxIa7s=; b=YHUvAvzpZeAKq9J6Asnp6XQDYL
	Izh7L39r+rz/gvxzjdNREYWQ2fkszxD0C7yXhyFHduIfON0Z55U4owxqHTYnnJe43yZVS/X26BkUO
	bGdaY5uAYxqVBdqTAWA/bUB8/VdV0MZq05ddcV5gClt+y3aaBGs6a0Bn9CnHHj3IzwjA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x5K34-0006GC-Qs;
	Sat, 12 Sep 2026 09:29:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x5K33-0006G6-J2
 for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 09:29:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wMB5KUhee7jfpbry3HOmfzAnem0QWpWskk2fRf1xkpI=; b=aqI5LTA/TkyCitE+ufuP4YqrDX
 VUikCsOodZKS9Xot9BWjD/sxApzqWj6hcSfUfRK4hc6VFNnYo3UKn69Iima7ipzmE3JPh2BimhR3L
 WO1z8LMrzs6XHmdA2Fe4EmHauTD7FHX/RM8Ztsn0Rk2ULJA6KHI8zhg1Hixxlu5XF+08=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wMB5KUhee7jfpbry3HOmfzAnem0QWpWskk2fRf1xkpI=; b=fsGev6Y4NUih5WUMddzopHwqqr
 unXECoy1LneoZaDRIf2rFoAcFRHGj8F7LOMVQLgl7eW1HZSFYR8DSyD7rcTJtYN6F04nh+p4OuTvk
 Gni117+qfb2BXhPRJ1slRcKuDn7lf0Y1a2P2SxWVkpv5VQAevq6TSu2HDsHU0HgVvpak=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x5K32-0004MW-Rd for openvpn-devel@lists.sourceforge.net;
 Sat, 12 Sep 2026 09:29:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68C9THBl027254
 for <openvpn-devel@lists.sourceforge.net>; Sat, 12 Sep 2026 11:29:17 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68C9THGR027253
 for openvpn-devel@lists.sourceforge.net; Sat, 12 Sep 2026 11:29:17 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 12 Sep 2026 11:29:12 +0200
Message-ID: <20260912092917.27218-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
References: <gerrit.1789114696000.I8f2bd694146aacd244a1d385ddfe9bb84ec29334@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x5K32-0004MW-Rd
Subject: [Openvpn-devel] [PATCH v4] socket: factor out UDP socket creation
 and setup
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

From: Lev Stipakov <lev@openvpn.net>

create_socket() creates the UDP socket and then applies the link
socket's options and local bind in place. Pull that sequence into
create_socket_udp_configured(), taking the address family and the
option values rather than a struct link_socket, and have create_socket()
call it; the TCP path keeps its own sequence through the shared
socket_apply_options().

--server-probe will open its probe sockets through the same function, so
a probe socket is set up and bound exactly like the connection socket it
may later become. Its "optional" argument lets that caller treat a
socket the host cannot create as "do not probe this address family"
instead of dying; the connection path passes false and keeps the fatal
error. No behaviour change for existing callers.

Change-Id: I8f2bd694146aacd244a1d385ddfe9bb84ec29334
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1910
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1910
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7c6217a..e9181c8 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -565,7 +565,7 @@
 }
 
 static socket_descriptor_t
-create_socket_udp(struct addrinfo *addrinfo, const unsigned int flags)
+create_socket_udp(struct addrinfo *addrinfo, const unsigned int flags, bool optional)
 {
     socket_descriptor_t sd;
 
@@ -575,7 +575,8 @@
     if ((sd = socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol))
         == SOCKET_UNDEFINED)
     {
-        msg(M_ERR, "UDP: Cannot create UDP/UDP6 socket");
+        msg(optional ? D_LOW | M_ERRNO : M_ERR, "UDP: Cannot create UDP/UDP6 socket");
+        return SOCKET_UNDEFINED;
     }
 #if ENABLE_IP_PKTINFO
     else if (flags & SF_USE_IP_PKTINFO)
@@ -636,12 +637,70 @@
     }
 }
 
+/* The per-socket options every link socket gets right after creation. */
+static void
+socket_apply_options(socket_descriptor_t sd, const struct socket_buffer_size *sbs, int mark,
+                     const char *bind_dev)
+{
+    /* set socket buffers based on --sndbuf and --rcvbuf options */
+    socket_set_buffers(sd, sbs, true);
+
+    /* set socket to --mark packets with given value */
+    socket_set_mark(sd, mark);
+
+#if defined(TARGET_LINUX)
+    if (bind_dev)
+    {
+        msg(M_INFO, "Using bind-dev %s", bind_dev);
+        /* Note: We verify strlen of bind_dev in options parsing */
+        if (setsockopt(sd, SOL_SOCKET, SO_BINDTODEVICE, bind_dev, (socklen_t)(strlen(bind_dev) + 1))
+            != 0)
+        {
+            msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s failed", bind_dev);
+        }
+    }
+#else
+    (void)bind_dev;
+#endif
+}
+
+socket_descriptor_t
+create_socket_udp_configured(sa_family_t af, unsigned int sockflags, const struct socket_buffer_size *sbs,
+                             int mark, const char *bind_dev, struct addrinfo *bind_addr,
+                             bool bind_ipv6_only, bool optional)
+{
+    struct addrinfo ai = { .ai_family = af, .ai_socktype = SOCK_DGRAM, .ai_protocol = IPPROTO_UDP };
+    socket_descriptor_t sd = create_socket_udp(&ai, sockflags, optional);
+
+    if (sd == SOCKET_UNDEFINED)
+    {
+        return SOCKET_UNDEFINED;
+    }
+
+    socket_apply_options(sd, sbs, mark, bind_dev);
+    if (bind_addr)
+    {
+        socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only);
+    }
+    return sd;
+}
+
 static void
 create_socket(struct link_socket *sock, struct addrinfo *addr)
 {
+    /* Set af field of sock->info, so it always reflects the address family
+     * of the created socket */
+    sock->info.af = (sa_family_t)addr->ai_family;
+
     if (addr->ai_protocol == IPPROTO_UDP || addr->ai_socktype == SOCK_DGRAM)
     {
-        sock->sd = create_socket_udp(addr, sock->sockflags);
+        /* With a SOCKS proxy the local bind goes on the control socket instead
+         * (see bind_local()), so the UDP socket is created unbound then. */
+        struct addrinfo *bind_addr =
+            (sock->bind_local && !sock->socks_proxy) ? sock->info.lsa->bind_local : NULL;
+        sock->sd = create_socket_udp_configured(sock->info.af, sock->sockflags, &sock->socket_buffer_sizes,
+                                                sock->mark, sock->bind_dev, bind_addr,
+                                                sock->info.bind_ipv6_only, false);
         sock->sockflags |= SF_GETADDRINFO_DGRAM;
 
         /* Assume that control socket and data socket to the socks proxy
@@ -655,41 +714,19 @@
             addrinfo_tmp.ai_socktype = SOCK_STREAM;
             addrinfo_tmp.ai_protocol = IPPROTO_TCP;
             sock->ctrl_sd = create_socket_tcp(&addrinfo_tmp);
+            bind_local(sock);
         }
     }
     else if (addr->ai_protocol == IPPROTO_TCP || addr->ai_socktype == SOCK_STREAM)
     {
         sock->sd = create_socket_tcp(addr);
+        socket_apply_options(sock->sd, &sock->socket_buffer_sizes, sock->mark, sock->bind_dev);
+        bind_local(sock);
     }
     else
     {
         ASSERT(0);
     }
-    /* Set af field of sock->info, so it always reflects the address family
-     * of the created socket */
-    sock->info.af = (sa_family_t)addr->ai_family;
-
-    /* set socket buffers based on --sndbuf and --rcvbuf options */
-    socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
-
-    /* set socket to --mark packets with given value */
-    socket_set_mark(sock->sd, sock->mark);
-
-#if defined(TARGET_LINUX)
-    if (sock->bind_dev)
-    {
-        msg(M_INFO, "Using bind-dev %s", sock->bind_dev);
-        /* Note: We verify strlen of bind_dev in options parsing */
-        if (setsockopt(sock->sd, SOL_SOCKET, SO_BINDTODEVICE, sock->bind_dev,
-                       (socklen_t)(strlen(sock->bind_dev) + 1))
-            != 0)
-        {
-            msg(M_WARN | M_ERRNO, "WARN: setsockopt SO_BINDTODEVICE=%s failed", sock->bind_dev);
-        }
-    }
-#endif
-
-    bind_local(sock);
 }
 
 #ifdef TARGET_ANDROID
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 89465bc..d296d3b 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -401,6 +401,19 @@
 
 socket_descriptor_t create_socket_tcp(struct addrinfo *);
 
+/**
+ * Create a UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,
+ * --mark, --bind-dev and, when @p bind_addr is given, the local bind (IPV6_V6ONLY
+ * per @p bind_ipv6_only). Shared by create_socket() and the --server-probe sockets,
+ * so a probe socket is the connection socket it may become. A failed bind is
+ * fatal; with @p optional a socket the host cannot create is not, so
+ * --server-probe can skip that address family (SOCKET_UNDEFINED is returned).
+ */
+socket_descriptor_t create_socket_udp_configured(sa_family_t af, unsigned int sockflags,
+                                                 const struct socket_buffer_size *sbs, int mark,
+                                                 const char *bind_dev, struct addrinfo *bind_addr,
+                                                 bool bind_ipv6_only, bool optional);
+
 socket_descriptor_t socket_do_accept(socket_descriptor_t sd, struct link_socket_actual *act,
                                      const bool nowait);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
