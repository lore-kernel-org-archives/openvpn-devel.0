Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBEC1606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 16:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iPkqi25G;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h+FL4jgY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YlbjZ+L+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vG7guuJZ80l5f2dKsa39TdSgeW0D2UAlSG7HIwtoCsc=; b=iPkqi25GMsoX/f
	iiCunIrVre7Q9cVFAS9Q3/JxOpiUhCu1yyM7HcYn+vJkERqj+ctut3IGBLQ2dWfqKzZr/ky+GCW/+
	PUkN+XaODZrEe2aVh4RyrCex0+kBXW2CUcegMJAiVa/+MGS07bPwp/OgAaxnOxnpMfaKpivkrfa65
	b4w=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtLJ-0000000077L-2gqv;
	Tue, 24 Nov 2026 16:26:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVtLH-0000000077D-3pPs for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:26:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sWFjAvJpT4+fIbbUJ7svDMC8wOORo23McxoGopLsG8k=; b=h+FL4jgY6eyLRIfb/erTNB27A7
 pvH7jgVZZrRK+SB5HgGIHoDlGhWlDpWPGYvYrc7l73fNmagXjxpy/MsDXWcfPuZBnZCfYX4o2FAQ4
 iHWUyxNPYoETO7Esp7afO/Hu6Frf+W1p/oHTDl02Dks6l+YKcDBcTOVGCeBbbtpIUSJw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sWFjAvJpT4+fIbbUJ7svDMC8wOORo23McxoGopLsG8k=; b=YlbjZ+L+qJ9Orox6YGEhZAbJaq
 vBuJ52fOftSpxXG/5PfQaPejOMT6+3/oBZ5j+9u/OhEvm5/MaMjeaTJKJS76utRB71DmC6IXl1GVe
 BApd2ZhilICWVvkR/vNci+apkhe0MCJwOBjKdfs1f9srzLoP27Nh4a61YJowRETwPeNk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVtLG-000000006n5-24vf for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 16:26:03 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AOGPtJo000737
 for <openvpn-devel@lists.sourceforge.net>; Tue, 24 Nov 2026 17:25:55 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOGPt4r000735
 for openvpn-devel@lists.sourceforge.net; Tue, 24 Nov 2026 17:25:55 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 24 Nov 2026 17:25:50 +0100
Message-ID: <20261124162555.722-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVtLG-000000006n5-24vf
Subject: [Openvpn-devel] [PATCH v13] socket: Let an optional UDP socket give
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
caller passes M_FATAL and keeps its behaviour. With more than one return
path the gc arena no longer belongs at the top of the function, so it
moves into the bind failure, the only branch that formats an address.

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
This mail reflects revision 13 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index addd6f2..bbf454a 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2080,7 +2080,7 @@
         {
             man->connection.sd_top = create_socket_tcp(man->settings.local);
             socket_bind(man->connection.sd_top, man->settings.local, man->settings.local->ai_family,
-                        "MANAGEMENT", false);
+                        "MANAGEMENT", false, M_FATAL);
         }
 
         /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index c07ef60..36cb0e5 100644
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
@@ -558,12 +561,10 @@
     return new_sd;
 }
 
-void
+bool
 socket_bind(socket_descriptor_t sd, const struct addrinfo *local, int ai_family,
-            const char *prefix, bool ipv6only)
+            const char *prefix, bool ipv6only, msglvl_t msglevel)
 {
-    struct gc_arena gc = gc_new();
-
     /* FIXME (schwabe)
      * getaddrinfo for the bind address might return multiple AF_INET/AF_INET6
      * entries for the requested protocol.
@@ -584,8 +585,9 @@
     }
     if (!cur)
     {
-        msg(M_FATAL, "%s: Socket bind failed: Addr to bind has no %s record", prefix,
+        msg(msglevel, "%s: Socket bind failed: Addr to bind has no %s record", prefix,
             addr_family_name(ai_family));
+        return false;
     }
 
     if (ai_family == AF_INET6)
@@ -600,10 +602,13 @@
     }
     if (openvpn_bind(sd, cur->ai_addr, cur->ai_addrlen))
     {
-        msg(M_FATAL | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
-            print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
+        struct gc_arena gc = gc_new();
+        msg(msglevel | M_ERRNO, "%s: Socket bind failed on local address %s", prefix,
+            print_sockaddr_ex(cur->ai_addr, ":", PS_SHOW_PORT, &gc));
+        gc_free(&gc);
+        return false;
     }
-    gc_free(&gc);
+    return true;
 }
 
 int
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2210bfe..084b9cc 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -346,8 +346,15 @@
 
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
@@ -401,9 +408,9 @@
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
