Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E681D606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BcDC4NDD;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iVChCxc6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=HCHXeGTT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=P2Jyd1HKrhcOb0RfzrEBrHNQ85q/wUo7zR+FZERq4TM=; b=BcDC4NDDWaZNmj
	XUSBgG+GzcYsJFR/NjT+tlya1LaTwYCa658NFuGDpyde9d6npGoBtGexiq7d9vpaRvCBlAXTeXZoU
	WDeUeRtaUMKHnU9BRJCNqky3+EGFrDS8mF3TxlFP1OF/XoRuSZq7xJxfmC1VHNuxdHYxIkfsWK/g3
	i+k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV81D-000000008S1-36ME;
	Sun, 22 Nov 2026 13:54:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xV81D-000000008Rs-0dYO for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 13:54:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uvVspdnWVqOwvrEx2vrDaCMp/2kZT6IFFU69EV78Xzw=; b=iVChCxc6KDbPUTHHyzTxipPlDM
 UEZWmwnRcNnxc/5+zjznDPK3i93tWQh+aPtsHK1QoUSWwS6AWBI7Nnx7JLKBuAqliYn1yHQmR9wzJ
 YXgR4Wpouyo00mJYPcY+EQazXtUG1RSQft1uPI5j2lU3h+CLqBYCWsyZRxLStFHXna3A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uvVspdnWVqOwvrEx2vrDaCMp/2kZT6IFFU69EV78Xzw=; b=HCHXeGTTK3Zporxe4VUYZXcZif
 olrnlf70HDzioM70hqvgcaMtl/vz/EnJQhtFJHfLSxbWFZeIpEVjfrHOIvU+WRonppqcD56V76CDi
 FO2Ikmn0rys9EVi4fLpk+FwgjtNXAxaqfwjBlvLRW6q2YA6gXxkJ6ssjG7BXga/th6OM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xV81B-000000001gM-3QHJ for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 13:54:11 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AMDs2Lc012183
 for <openvpn-devel@lists.sourceforge.net>; Sun, 22 Nov 2026 14:54:02 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AMDs2CP012182
 for openvpn-devel@lists.sourceforge.net; Sun, 22 Nov 2026 14:54:02 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 22 Nov 2026 14:53:56 +0100
Message-ID: <20261122135402.12147-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xV81B-000000001gM-3QHJ
Subject: [Openvpn-devel] [PATCH v12] socket: Let an optional UDP socket give
 up on a failed bind
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

From: Lev Stipakov <lev@openvpn.net>

create_socket_udp_configured()'s "optional" argument covers only the
socket() call: socket_bind() is fatal, so a caller that can do without
the socket still dies if the address is unavailable.

That is a problem for the upcoming --server-probe, which binds a probe
socket for every address family in use, while a connection binds only
the family of the remote it is about to try. A --lport whose IPv6 port
happens to be taken by another process would therefore kill a client
that could have connected over IPv4.

Give socket_bind() a msglevel and a return value, and let "optional"
apply to the bind as well: the socket is closed and SOCKET_UNDEFINED is
returned, so the caller can skip that address family. Every existing
caller passes M_FATAL and keeps its behaviour.

The failure message now reports the address that was actually bound,
cur, rather than the head of the list, local, which may belong to a
different address family. Until now that message was always followed by
a fatal exit; with an optional bind it is printed while the client
carries on, so it needs to name the right address.

Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1915
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1915
This mail reflects revision 12 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 58f63e6..013d516 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2105,7 +2105,7 @@
         {
             man->connection.sd_top = create_socket_tcp(man->settings.local);
             socket_bind(man->connection.sd_top, man->settings.local, man->settings.local->ai_family,
-                        "MANAGEMENT", false);
+                        "MANAGEMENT", false, M_FATAL);
         }
 
         /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 307b5c6..c7de904 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -268,12 +268,13 @@
     {
         if (sock->socks_proxy && sock->info.proto == PROTO_UDP)
         {
-            socket_bind(sock->ctrl_sd, sock->info.lsa->bind_local, sock->info.af, "SOCKS", false);
+            socket_bind(sock->ctrl_sd, sock->info.lsa->bind_local, sock->info.af, "SOCKS", false,
+                        M_FATAL);
         }
         else
         {
             socket_bind(sock->sd, sock->info.lsa->bind_local, sock->info.af, "TCP/UDP",
-                        sock->info.bind_ipv6_only);
+                        sock->info.bind_ipv6_only, M_FATAL);
         }
     }
 }
@@ -319,9 +320,11 @@
     }
 
     socket_apply_options(sd, sbs, mark, bind_dev);
-    if (bind_addr)
+    if (bind_addr
+        && !socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only, optional ? D_LOW : M_FATAL))
     {
-        socket_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only);
+        openvpn_close_socket(sd);
+        return SOCKET_UNDEFINED;
     }
     return sd;
 }
@@ -556,9 +559,9 @@
     return new_sd;
 }
 
-void
+bool
 socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int ai_family,
-            const char *prefix, bool ipv6only)
+            const char *prefix, bool ipv6only, msglvl_t msglevel)
 {
     struct gc_arena gc = gc_new();
 
@@ -582,8 +585,10 @@
     }
     if (!cur)
     {
-        msg(M_FATAL, "%s: Socket bind failed: Addr to bind has no %s record", prefix,
+        msg(msglevel, "%s: Socket bind failed: Addr to bind has no %s record", prefix,
             addr_family_name(ai_family));
+        gc_free(&gc);
+        return false;
     }
 
     if (ai_family == AF_INET6)
@@ -598,10 +603,13 @@
     }
     if (openvpn_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
-            print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
+        msg(msglevel | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
+            print_sockaddr_ex(cur->ai_addr, ":", PS_SHOW_PORT, &gc));
+        gc_free(&gc);
+        return false;
     }
     gc_free(&gc);
+    return true;
 }
 
 int
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 52e09c9..88c51fa 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -337,8 +337,15 @@
 
 struct link_socket *link_socket_new(void);
 
-void socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_family,
-                 const char *prefix, bool ipv6only);
+/**
+ * Bind @p sd to the first @p af_family address of @p local. A failure is
+ * reported at @p msglevel, so a caller that can do without the bind passes a
+ * non-fatal level and checks the result.
+ *
+ * @return whether the socket was bound
+ */
+bool socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int af_family,
+                 const char *prefix, bool ipv6only, msglvl_t msglevel);
 
 int openvpn_connect(socket_descriptor_t sd, const struct sockaddr *remote, int connect_timeout,
                     volatile int *signal_received);
@@ -392,9 +399,9 @@
  * Create a UDP socket for @p af set up the way a link socket is: --sndbuf/--rcvbuf,
  * --mark, --bind-dev and, when @p bind_addr is given, the local bind (IPV6_V6ONLY
  * per @p bind_ipv6_only). Shared by create_socket() and the --server-probe sockets,
- * so a probe socket is the connection socket it may become. A failed bind is
- * fatal; with @p optional a socket the host cannot create is not, so
- * --server-probe can skip that address family (SOCKET_UNDEFINED is returned).
+ * so a probe socket is the connection socket it may become. With @p optional a
+ * socket the host cannot create or bind is not fatal, so --server-probe can skip
+ * that address family (SOCKET_UNDEFINED is returned).
  */
 socket_descriptor_t create_socket_udp_configured(sa_family_t af, unsigned int sockflags,
                                                  const struct socket_buffer_size *sbs, int mark,


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
