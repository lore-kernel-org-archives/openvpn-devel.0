Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E51C4452F
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZzYZ5fYwotgX7lAeTdwithVpat2aNk4ZvbEhSDhCUxw=; b=JcBIC0e40dvoGnZGQR4ItAgUis
	747NanegtI6tXTTPrR4CtQ2Gr2kC2Fs6ajXxiBQm6cKBK7/0tftJv9gJkQBfp85vORuPPztvAUaOR
	e7CPChMzQg291Tq8PHTTL0lPNHW3xxG6qO5VB3QetpGTfYJxCaSrLfPGEZLsDnfb12b4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wm9qS-0005Ru-1j;
	Tue, 21 Jul 2026 12:45:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wm9qQ-0005Rl-82
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:45:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RGPelwF/QI5ghepVUxtmIwJ8lBIIEofMe49W+z4r4pc=; b=lCdE/l/rP+MSoeFkocZK9GXMCr
 hZ2S/SznJrtFSAEkO5xk+o72WAR6clycQgocJO8TPDLzkF5pOePwJuxdSx7UI77rW13dxIhTzSNDG
 MyOvUYZOLIFr6xTeVFIy6y72Y5Cr3IifOpC7o+kh9ruCnUtjfymgxyva2SlcAatsdW90=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RGPelwF/QI5ghepVUxtmIwJ8lBIIEofMe49W+z4r4pc=; b=YoAOGByAMvP1zLWrFLNxNyV+H5
 gKXK2PUuVR6qe4gaVMGuA+zjI7AUj/LjzP0bINkZ90ldPqTNcuR3qwHFcl/a9qAybijL5QN5cicgk
 87IBz/XjuwyZR4OztKObJwd8fwgoTHHjIaIbdre1fLnnaO2Te+lhRyrRhnngMm/s1vyY=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wm9qK-00029U-NQ for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 12:45:07 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 66LCiqcu027854
 for <openvpn-devel@lists.sourceforge.net>; Tue, 21 Jul 2026 14:44:52 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 66LCiquT027853
 for openvpn-devel@lists.sourceforge.net; Tue, 21 Jul 2026 14:44:52 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 21 Jul 2026 14:44:46 +0200
Message-ID: <20260721124452.27832-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
References: <gerrit.1784586066000.I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wm9qK-00029U-NQ
Subject: [Openvpn-devel] [PATCH v3] Enable TCP_NODELAY by default and push
 it to clients
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

From: Antonio Quartulli <antonio@mandelbit.com>

TCP_NODELAY had to be requested explicitly via
--tcp-nodelay or "socket-flags TCP_NODELAY". Enable
it unconditionally on every TCP socket instead
(dco-win is skipped as it manages its own socket).
The socket_set_flags() and
link_socket_update_flags() plumbing that only ever
applied it is dropped; the SF_TCP_NODELAY sockflag
and "socket-flags TCP_NODELAY" become no-ops, the
latter kept for backwards compatibility.

--tcp-nodelay no longer touches the local socket
but, in --mode server, still pushes "socket-flags
TCP_NODELAY" to clients, for the benefit of clients
older than 2.7.6 that do not enable it by default.
On a client the option is deprecated and inert. It
can be dropped once such clients are gone.

Change-Id: I434a5373f77b0f7570a6a2aafe0eaf970e2eabe7
Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1797
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1797
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-options.rst
index df8c917..7c61b67 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -465,23 +465,20 @@
   trying to group several smaller packets into a larger packet.  This can
   result in a considerably improvement in latency.
 
-  This option is pushable from server to client, and should be used on
-  both client and server for maximum effect.
+  Since OpenVPN 2.7.6 :code:`TCP_NODELAY` is enabled by default on every TCP
+  socket, so specifying it here is no longer necessary.
 
 --tcp-nodelay
-  This macro sets the :code:`TCP_NODELAY` socket flag on the server as well
-  as pushes it to connecting clients. The :code:`TCP_NODELAY` flag disables
-  the Nagle algorithm on TCP sockets causing packets to be transmitted
-  immediately with low latency, rather than waiting a short period of time
-  in order to aggregate several packets into a larger containing packet.
-  In VPN applications over TCP, :code:`TCP_NODELAY` is generally a good
-  latency optimization.
+  :code:`TCP_NODELAY` is enabled by default on every TCP socket. In
+  ``--mode server`` this option additionally pushes
+  ``socket-flags TCP_NODELAY`` to connecting clients, so that clients older
+  than 2.7.6 get it too. The option can be removed once such clients are no
+  longer in use.
 
   The macro expands as follows:
   ::
 
      if mode server:
-         socket-flags TCP_NODELAY
          push "socket-flags TCP_NODELAY"
 
 --max-packet-size size
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 4c540a6..7c186c5 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -99,14 +99,6 @@
     return BSTR(&out);
 }
 
-static const char *
-print_str(const char *str, struct gc_arena *gc)
-{
-    struct buffer out = alloc_buf_gc(128, gc);
-    buf_printf(&out, "%s", str);
-    return BSTR(&out);
-}
-
 static void
 helper_add_route(const in_addr_t network, const in_addr_t netmask, struct options *o)
 {
@@ -597,22 +589,13 @@
  * EXPANDS TO:
  *
  * if mode server:
- *   socket-flags TCP_NODELAY
  *   push "socket-flags TCP_NODELAY"
  */
 void
 helper_tcp_nodelay(struct options *o)
 {
-    if (o->server_flags & SF_TCP_NODELAY_HELPER)
+    if ((o->server_flags & SF_TCP_NODELAY_HELPER) && o->mode == MODE_SERVER)
     {
-        if (o->mode == MODE_SERVER)
-        {
-            o->sockflags |= SF_TCP_NODELAY;
-            push_option(o, print_str("socket-flags TCP_NODELAY", &o->gc), M_USAGE);
-        }
-        else
-        {
-            o->sockflags |= SF_TCP_NODELAY;
-        }
+        push_option(o, "socket-flags TCP_NODELAY", M_USAGE);
     }
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index caaa769..914d191 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2650,15 +2650,6 @@
         }
     }
 
-    if (found & OPT_P_SOCKFLAGS)
-    {
-        msg(D_PUSH, "OPTIONS IMPORT: --socket-flags option modified");
-        for (int i = 0; i < c->c1.link_sockets_num; i++)
-        {
-            link_socket_update_flags(c->c2.link_sockets[i], c->options.sockflags);
-        }
-    }
-
     if (found & OPT_P_PERSIST)
     {
         msg(D_PUSH, "OPTIONS IMPORT: --persist options modified");
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 87218d4..49b604b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -486,8 +486,8 @@
     "                  virtual address table to v.\n"
     "--bcast-buffers n : Allocate n broadcast buffers.\n"
     "--tcp-queue-limit n : Maximum number of queued TCP output packets.\n"
-    "--tcp-nodelay   : Macro that sets TCP_NODELAY socket flag on the server\n"
-    "                  as well as pushes it to connecting clients.\n"
+    "--tcp-nodelay   : In server mode, push TCP_NODELAY to clients (it is\n"
+    "                  enabled by default on the local socket).\n"
     "--learn-address cmd : Run command cmd to validate client virtual addresses.\n"
     "--connect-freq n s : Allow a maximum of n new connections per s seconds.\n"
     "--connect-freq-initial n s : Allow a maximum of n replies for initial connections attempts per s seconds.\n"
@@ -2616,6 +2616,13 @@
             MUST_BE_UNDEF(vlan_accept, "vlan-accept");
             MUST_BE_UNDEF(vlan_pvid, "vlan-pvid");
         }
+
+        if (options->server_flags & SF_TCP_NODELAY_HELPER)
+        {
+            msg(M_INFO, "NOTE: TCP_NODELAY is always enabled locally; "
+                        "--tcp-nodelay is now only useful to push the flag to "
+                        "clients older than 2.7.6.");
+        }
     }
     else
     {
@@ -2646,9 +2653,7 @@
         MUST_BE_FALSE(options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL, "auth-user-pass-optional");
         if (options->server_flags & SF_TCP_NODELAY_HELPER)
         {
-            msg(M_WARN, "WARNING: setting tcp-nodelay on the client side will not "
-                        "affect the server. To have TCP_NODELAY in both direction use "
-                        "tcp-nodelay in the server configuration instead.");
+            msg(M_WARN, "DEPRECATED OPTION: --tcp-nodelay is always enabled on clients");
         }
         MUST_BE_UNDEF(auth_user_pass_verify_script, "auth-user-pass-verify");
         MUST_BE_UNDEF(auth_token_generate, "auth-gen-token");
@@ -6535,11 +6540,9 @@
         VERIFY_PERMISSION(OPT_P_SOCKFLAGS);
         for (j = 1; j < MAX_PARMS && p[j]; ++j)
         {
-            if (streq(p[j], "TCP_NODELAY"))
-            {
-                options->sockflags |= SF_TCP_NODELAY;
-            }
-            else
+            /* TCP_NODELAY is enabled by default; the flag is still accepted
+             * for backwards compatibility but no longer has any effect */
+            if (!streq(p[j], "TCP_NODELAY"))
             {
                 msg(msglevel, "unknown socket flag: %s", p[j]);
             }
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index df2cc9e..b73a5df 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -516,34 +516,6 @@
 #endif
 }
 
-static bool
-socket_set_flags(socket_descriptor_t sd, unsigned int sockflags)
-{
-    /* SF_TCP_NODELAY doesn't make sense for dco-win */
-    if ((sockflags & SF_TCP_NODELAY) && (!(sockflags & SF_DCO_WIN)))
-    {
-        return socket_set_tcp_nodelay(sd, 1);
-    }
-    else
-    {
-        return true;
-    }
-}
-
-bool
-link_socket_update_flags(struct link_socket *sock, unsigned int sockflags)
-{
-    if (sock && socket_defined(sock->sd))
-    {
-        sock->sockflags |= sockflags;
-        return socket_set_flags(sock->sd, sock->sockflags);
-    }
-    else
-    {
-        return false;
-    }
-}
-
 void
 link_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndbuf)
 {
@@ -1485,8 +1457,12 @@
 static void
 phase2_set_socket_flags(struct link_socket *sock)
 {
-    /* set misc socket parameters */
-    socket_set_flags(sock->sd, sock->sockflags);
+    /* TCP_NODELAY is enabled by default on every TCP socket; dco-win is
+     * skipped as it manages its own socket */
+    if (proto_is_tcp(sock->info.proto) && !(sock->sockflags & SF_DCO_WIN))
+    {
+        socket_set_tcp_nodelay(sock->sd, 1);
+    }
 
     /* set socket to non-blocking mode */
     set_nonblock(sock->sd);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cd4e8ed..5883592 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -207,7 +207,7 @@
     int mtu; /* OS discovered MTU, or 0 if unknown */
 
 #define SF_USE_IP_PKTINFO    (1 << 0)
-#define SF_TCP_NODELAY       (1 << 1)
+#define SF_TCP_NODELAY       (1 << 1) /* unused: flag always enabled */
 #define SF_PORT_SHARE        (1 << 2)
 #define SF_HOST_RANDOMIZE    (1 << 3)
 #define SF_GETADDRINFO_DGRAM (1 << 4)
@@ -390,8 +390,6 @@
 
 void setenv_trusted(struct env_set *es, const struct link_socket_info *info);
 
-bool link_socket_update_flags(struct link_socket *sock, unsigned int sockflags);
-
 void link_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int sndbuf);
 
 /*


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
