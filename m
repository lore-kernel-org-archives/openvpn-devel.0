Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F63C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=69X62O2luAyLvOXNhDU/uSCqgnMxfDOusskpw8bAHNI=; b=gkF2/YK6DyZmVYkeZsqjrFC9no
	EvwNWOiJRRC1taU4NmTYDIBhUIr5y6C7y0qqQ3vU/yArXFwSJvTzqpHMtFrkTq3DZC3d2L7nleWXZ
	kYmzFiTOV2xKE9XD77tQAHw8x/UkwQRPOL5OnQB3OAF8w4ZXhdv4LtdnEdRwr7oy6m2s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whUCv-0004St-1g;
	Wed, 08 Jul 2026 15:29:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1whUCs-0004SS-83
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:29:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ih+miIYndSGy4VYw6k1TCxrtC6Y5+G7br/EtmyuKwho=; b=EqPfAPNpkWaAF1KEY8b1nLpujx
 rQiEsQs0lI7GaGIeU+yTx2USwLa/PgWRa2Mqh/tcVXjJrYgLeMrhBNIOz4IyL4XGljH9W7nOqgJQY
 w7cVYxhiUYPglu5mD4Qs8mq3Jwi/G/wPSxYOtY6xXJlee3E64LRw9mmZBjYeq3obXCZk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ih+miIYndSGy4VYw6k1TCxrtC6Y5+G7br/EtmyuKwho=; b=Ap+IUo/BmRJm85vHvijXpr/hzl
 QV7M1b+JCqVgLosZgHpPlv31sV68hA6qPh9EiKHu/04abtBQ/Nx9JrvGm5wKag66Y3Dxyaqf3kj0k
 7Y3+nbBOKxtRXtaixj8XCCopsBlwnfFQvcJhtm+3l8eyouYrwDNQ/HvJkXj/JbJc+BAk=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whUCn-0007VE-Gz for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:28:59 +0000
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gwMSd0tSGzKw3L;
 Wed, 08 Jul 2026 17:28:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1783524529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ih+miIYndSGy4VYw6k1TCxrtC6Y5+G7br/EtmyuKwho=;
 b=DjIaNn2/VS+Q7ktfKLBoFWndWQ4zrSr8RDx2WDtylWO0xSrI4Nt93Ml+uD4+cE30hHM8jZ
 jYkpO738iWFxFfBuOwsbKeFKGyJbQf+0lCWsVFXU02/N1MziUqJIUYvZfi3nAtriwYX8BP
 ngyKA4nuZS4B0oc33usDBLsDguuH5BRS1XCbYvxpuneknAvRlcTOoUe91BNWMAxW9gGm9l
 +nHeHxqVrfXTfWxTh1QFfQ1UEnVx+QjgQQYSD/PB5UoCAxKOB5OOyjvssJY9gAOSH9d/NR
 uoqeTaNQcHltndxYQwytP1HmScyK1yxuxKeOlSRfKz1COK+apVZbyhtcLrJfdA==
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  8 Jul 2026 17:28:47 +0200
Message-ID: <20260708152847.60245-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@gerrit.openvpn.net>
References: <gerrit.1772554170000.Iabe1992b2608661b862a81363574e957d18395f0@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1whUCn-0007VE-Gz
Subject: [Openvpn-devel] [PATCH v4] socket: Never use negative buf->len in
 link_socket_read*
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
Cc: Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

We really don't want to use negative buf lengths in
our code. So remove some places where we did so before.

Change-Id: Iabe1992b2608661b862a81363574e957d18395f0
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1554
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1554
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d24f534..30a117c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -929,14 +929,12 @@
      * Set up for recvfrom call to read datagram
      * sent to our TCP/UDP port.
      */
-    int status;
-
     /*ASSERT (!c->c2.to_tun.len);*/
 
     c->c2.buf = c->c2.buffers->read_link_buf;
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
 
-    status = link_socket_read(sock, &c->c2.buf, &c->c2.from);
+    ssize_t status = link_socket_read(sock, &c->c2.buf, &c->c2.from);
 
     if (socket_connection_reset(sock, status))
     {
@@ -955,14 +953,14 @@
             if (event_timeout_defined(&c->c2.explicit_exit_notification_interval))
             {
                 msg(D_STREAM_ERRORS,
-                    "Connection reset during exit notification period, ignoring [%d]", status);
+                    "Connection reset during exit notification period, ignoring [%zd]", status);
                 management_sleep(1);
             }
             else
             {
                 register_signal(c->sig, SIGUSR1,
                                 "connection-reset"); /* SOFT-SIGUSR1 -- TCP connection reset */
-                msg(D_STREAM_ERRORS, "Connection reset, restarting [%d]", status);
+                msg(D_STREAM_ERRORS, "Connection reset, restarting [%zd]", status);
             }
         }
         return;
@@ -1026,7 +1024,7 @@
      * Good, non-zero length packet received.
      * Commence multi-stage processing of packet,
      * such as authenticate, decrypt, decompress.
-     * If any stage fails, it sets buf.len to 0 or -1,
+     * If any stage fails, it sets buf.len to 0,
      * telling downstream stages to ignore the packet.
      */
     if (c->c2.buf.len > 0)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index df2cc9e..7a0d9ca 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1130,7 +1130,7 @@
 
 static void stream_buf_close(struct stream_buf *sb);
 
-static bool stream_buf_added(struct stream_buf *sb, int length_added);
+static bool stream_buf_added(struct stream_buf *sb, ssize_t length_added);
 
 /* For stream protocols, allocate a buffer to build up packet.
  * Called after frame has been finalized. */
@@ -1799,6 +1799,10 @@
     }
 }
 
+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic pop
+#endif
+
 void
 link_socket_close(struct link_socket *sock)
 {
@@ -2166,12 +2170,13 @@
  * @return true if \c sb->buf contains fully reassembled packet
  */
 static bool
-stream_buf_added(struct stream_buf *sb, int length_added)
+stream_buf_added(struct stream_buf *sb, ssize_t length_added)
 {
-    dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=%d", length_added);
+    dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=%zd", length_added);
     if (length_added > 0)
     {
-        sb->buf.len += length_added;
+        ASSERT(sb->buf.len + length_added <= INT_MAX);
+        sb->buf.len += (int)length_added;
     }
 
     /* if length unknown, see if we can get the length prefix from
@@ -2273,10 +2278,10 @@
  * Socket Read Routines
  */
 
-int
+ssize_t
 link_socket_read_tcp(struct link_socket *sock, struct buffer *buf)
 {
-    int len = 0;
+    ssize_t len = 0;
 
     if (!sock->stream_buf.residual_fully_formed)
     {
@@ -2306,7 +2311,8 @@
         }
         if (len <= 0)
         {
-            return buf->len = len;
+            buf->len = 0;
+            return len;
         }
     }
 
@@ -2338,14 +2344,14 @@
     max_int(CMSG_SPACE(sizeof(struct in6_pktinfo)), CMSG_SPACE(sizeof(struct in_addr)))
 #endif
 
-static socklen_t
+static ssize_t
 link_socket_read_udp_posix_recvmsg(struct link_socket *sock, struct buffer *buf,
-                                   struct link_socket_actual *from)
+                                   struct link_socket_actual *from, socklen_t *fromlen)
 {
     struct iovec iov;
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
     struct msghdr mesg = { 0 };
-    socklen_t fromlen = sizeof(from->dest.addr);
+    *fromlen = sizeof(from->dest.addr);
 
     ASSERT(sock->sd >= 0); /* can't happen */
 
@@ -2354,62 +2360,67 @@
     mesg.msg_iov = &iov;
     mesg.msg_iovlen = 1;
     mesg.msg_name = &from->dest.addr;
-    mesg.msg_namelen = fromlen;
+    mesg.msg_namelen = *fromlen;
     mesg.msg_control = pktinfo_buf;
-    mesg.msg_controllen = sizeof pktinfo_buf;
-    buf->len = recvmsg(sock->sd, &mesg, 0);
-    if (buf->len >= 0)
+    mesg.msg_controllen = (socklen_t)sizeof(pktinfo_buf);
+    ssize_t len = recvmsg(sock->sd, &mesg, 0);
+    if (len < 0)
     {
-        struct cmsghdr *cmsg;
-        fromlen = mesg.msg_namelen;
-        cmsg = CMSG_FIRSTHDR(&mesg);
-        if (cmsg != NULL && CMSG_NXTHDR(&mesg, cmsg) == NULL
+        buf->len = 0;
+        return len;
+    }
+    ASSERT(len <= INT_MAX);
+    buf->len = (int)len;
+    struct cmsghdr *cmsg;
+    *fromlen = mesg.msg_namelen;
+    cmsg = CMSG_FIRSTHDR(&mesg);
+    if (cmsg != NULL && CMSG_NXTHDR(&mesg, cmsg) == NULL
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-            && cmsg->cmsg_level == SOL_IP && cmsg->cmsg_type == IP_PKTINFO
-            && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in_pktinfo)))
+        && cmsg->cmsg_level == SOL_IP && cmsg->cmsg_type == IP_PKTINFO
+        && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in_pktinfo)))
 #elif defined(IP_RECVDSTADDR)
-            && cmsg->cmsg_level == IPPROTO_IP && cmsg->cmsg_type == IP_RECVDSTADDR
-            && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in_addr)))
+        && cmsg->cmsg_level == IPPROTO_IP && cmsg->cmsg_type == IP_RECVDSTADDR
+        && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in_addr)))
 #else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
 #endif
-        {
+    {
 #if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST)
-            struct in_pktinfo *pkti = (struct in_pktinfo *)CMSG_DATA(cmsg);
-            from->pi.in4.ipi_ifindex =
-                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti->ipi_ifindex : 0;
-            from->pi.in4.ipi_spec_dst = pkti->ipi_spec_dst;
+        struct in_pktinfo *pkti = (struct in_pktinfo *)CMSG_DATA(cmsg);
+        from->pi.in4.ipi_ifindex =
+            (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti->ipi_ifindex : 0;
+        from->pi.in4.ipi_spec_dst = pkti->ipi_spec_dst;
 #elif defined(IP_RECVDSTADDR)
-            from->pi.in4 = *(struct in_addr *)CMSG_DATA(cmsg);
+        from->pi.in4 = *(struct in_addr *)CMSG_DATA(cmsg);
 #else /* if defined(HAVE_IN_PKTINFO) && defined(HAVE_IPI_SPEC_DST) */
 #error ENABLE_IP_PKTINFO is set without IP_PKTINFO xor IP_RECVDSTADDR (fix syshead.h)
 #endif
-        }
-        else if (cmsg != NULL && CMSG_NXTHDR(&mesg, cmsg) == NULL
-                 && cmsg->cmsg_level == IPPROTO_IPV6 && cmsg->cmsg_type == IPV6_PKTINFO
-                 && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in6_pktinfo)))
-        {
-            struct in6_pktinfo *pkti6 = (struct in6_pktinfo *)CMSG_DATA(cmsg);
-            from->pi.in6.ipi6_ifindex =
-                (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti6->ipi6_ifindex : 0;
-            from->pi.in6.ipi6_addr = pkti6->ipi6_addr;
-        }
-        else if (cmsg != NULL)
-        {
-            msg(M_WARN,
-                "CMSG received that cannot be parsed (cmsg_level=%d, cmsg_type=%d, cmsg=len=%d)",
-                (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cmsg_len);
-        }
+    }
+    else if (cmsg != NULL && CMSG_NXTHDR(&mesg, cmsg) == NULL
+             && cmsg->cmsg_level == IPPROTO_IPV6 && cmsg->cmsg_type == IPV6_PKTINFO
+             && cmsg->cmsg_len >= CMSG_LEN(sizeof(struct in6_pktinfo)))
+    {
+        struct in6_pktinfo *pkti6 = (struct in6_pktinfo *)CMSG_DATA(cmsg);
+        from->pi.in6.ipi6_ifindex =
+            (sock->sockflags & SF_PKTINFO_COPY_IIF) ? pkti6->ipi6_ifindex : 0;
+        from->pi.in6.ipi6_addr = pkti6->ipi6_addr;
+    }
+    else if (cmsg != NULL)
+    {
+        msg(M_WARN,
+            "CMSG received that cannot be parsed (cmsg_level=%d, cmsg_type=%d, cmsg=len=%d)",
+            (int)cmsg->cmsg_level, (int)cmsg->cmsg_type, (int)cmsg->cmsg_len);
     }
 
-    return fromlen;
+    return buf->len;
 }
 #endif /* if ENABLE_IP_PKTINFO */
 
-int
+ssize_t
 link_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,
                            struct link_socket_actual *from)
 {
+    ssize_t recvlen;
     socklen_t fromlen = sizeof(from->dest.addr);
     socklen_t expectedlen = af_addr_size(sock->info.af);
     addr_zero_host(&from->dest);
@@ -2420,16 +2431,23 @@
     /* Both PROTO_UDPv4 and PROTO_UDPv6 */
     if (sock->info.proto == PROTO_UDP && sock->sockflags & SF_USE_IP_PKTINFO)
     {
-        fromlen = link_socket_read_udp_posix_recvmsg(sock, buf, from);
+        recvlen = link_socket_read_udp_posix_recvmsg(sock, buf, from, &fromlen);
     }
     else
 #endif
     {
-        buf->len = recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(buf), 0, &from->dest.addr.sa,
-                            &fromlen);
+        recvlen = recvfrom(sock->sd, BPTR(buf), buf_forward_capacity(buf), 0,
+                           &from->dest.addr.sa, &fromlen);
     }
+    if (recvlen < 0)
+    {
+        buf->len = 0;
+        return recvlen;
+    }
+    ASSERT(recvlen <= INT_MAX);
+    buf->len = (int)recvlen;
     /* FIXME: won't do anything when sock->info.af == AF_UNSPEC */
-    if (buf->len >= 0 && expectedlen && fromlen != expectedlen)
+    if (expectedlen && fromlen != expectedlen)
     {
         bad_address_length(fromlen, expectedlen);
     }
@@ -2445,7 +2463,9 @@
 ssize_t
 link_socket_write_tcp(struct link_socket *sock, struct buffer *buf, struct link_socket_actual *to)
 {
-    packet_size_type len = (packet_size_type)BLENZ(buf);
+    const int blen = BLEN(buf);
+    ASSERT(blen >= 0 && blen <= PACKET_SIZE_MAX);
+    packet_size_type len = (packet_size_type)blen;
     dmsg(D_STREAM_DEBUG, "STREAM: WRITE %u offset=%d", len, buf->offset);
     ASSERT(len <= sock->stream_buf.maxlen);
     len = htonps(len);
@@ -2457,10 +2477,6 @@
 #endif
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #if ENABLE_IP_PKTINFO
 
 ssize_t
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cd4e8ed..8b49f75 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -54,6 +54,7 @@
  */
 
 typedef uint16_t packet_size_type;
+#define PACKET_SIZE_MAX UINT16_MAX
 
 /* convert a packet_size_type from host to network order */
 #define htonps(x) htons(x)
@@ -459,7 +460,7 @@
 #endif /* if PORT_SHARE */
 
 static inline bool
-socket_connection_reset(const struct link_socket *sock, int status)
+socket_connection_reset(const struct link_socket *sock, ssize_t status)
 {
     if (link_socket_connection_oriented(sock))
     {
@@ -586,7 +587,7 @@
  * Socket Read Routines
  */
 
-int link_socket_read_tcp(struct link_socket *sock, struct buffer *buf);
+ssize_t link_socket_read_tcp(struct link_socket *sock, struct buffer *buf);
 
 #ifdef _WIN32
 
@@ -606,20 +607,20 @@
 
 #else  /* ifdef _WIN32 */
 
-int link_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,
-                               struct link_socket_actual *from);
+ssize_t link_socket_read_udp_posix(struct link_socket *sock, struct buffer *buf,
+                                   struct link_socket_actual *from);
 
 #endif /* ifdef _WIN32 */
 
 /* read a TCP or UDP packet from link */
-static inline int
+static inline ssize_t
 link_socket_read(struct link_socket *sock, struct buffer *buf, struct link_socket_actual *from)
 {
     if (proto_is_udp(sock->info.proto) || socket_is_dco_win(sock))
     /* unified UDPv4 and UDPv6, for DCO-WIN the kernel
      * will strip the length header */
     {
-        int res;
+        ssize_t res;
 
 #ifdef _WIN32
         res = link_socket_read_udp_win32(sock, buf, from);
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 6a7af85..931e54d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -535,7 +535,7 @@
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
 {
     return tuntap_is_dco_win(tt) && (status < 0) && (openvpn_errno() == ERROR_NETNAME_DELETED);
 }
@@ -573,7 +573,7 @@
 }
 
 static inline bool
-tuntap_is_dco_win_timeout(struct tuntap *tt, int status)
+tuntap_is_dco_win_timeout(struct tuntap *tt, ssize_t status)
 {
     return false;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
