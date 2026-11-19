Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F43606A324
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LmhIjkzz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jKYj6svR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kwNinU/4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Q9Ytf5Wm5JLLRqdS3kGUzXta6RTLYT++v61fidYnzrw=; b=LmhIjkzzF8aKtO
	iiqbAgs7W8L35bhkDkU9TRO1Z6n2kjhbn3HDwakIdDLRSQJHcNQOpfxYixFzy3+vgybb8UU+y+vmj
	qHGONnmTtDatKnK4iZ4UcXhIXVuT7O1u8QPUsVlcv9B9qS6acmUlv6ac7U43Qn6YCwEWTSzzOvwsP
	rKs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU1oR-000000003Ri-0WZJ;
	Thu, 19 Nov 2026 13:04:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xU1oP-000000003Rb-3GoF for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:04:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9xI3vLGoE8kHu5VcDDgsAUw30VXldGXyFs4APx/iLQw=; b=jKYj6svRO9smkMoqUhK5QAJXOG
 A/Gf9zRs+5+qdGSsaPpzlnzRXMRKRu8kPgNC7hENrdV4bT7n/z7NbS9b1DRNJfQ0yOewINUS5ntBm
 bdRjJvFXNqZFx2QMySiTiYAKA569tsSyio0bHwbfDgsnc4LMe/jyV0ro/s7X46RVu1q0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9xI3vLGoE8kHu5VcDDgsAUw30VXldGXyFs4APx/iLQw=; b=kwNinU/4bgOmj6xQG/4atf6MVA
 axWrB4u9tDMmkuxX3h97J6frBvsND2xEBrxj/HozC8FmpCl+U9nLFFrlZF60CD7qZrJ0x7q9y2dDa
 /EjzNf/UK6B7OJEtuwIixWXVJdKyw+k3NtlJgG+NEXNmNsTgKAJ46zrcPGMVCriy93PI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xU1oM-000000000gv-0smT for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 13:04:25 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AJD4FT3020290
 for <openvpn-devel@lists.sourceforge.net>; Thu, 19 Nov 2026 14:04:15 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AJD4FN6020289
 for openvpn-devel@lists.sourceforge.net; Thu, 19 Nov 2026 14:04:15 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 19 Nov 2026 14:04:08 +0100
Message-ID: <20261119130414.20274-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xU1oM-000000000gv-0smT
Subject: [Openvpn-devel] [PATCH v28] control_msg: Add P_CONTROL_V2 and the
 probe request and reply TLVs
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

A client probes a server before connecting by sending a P_CONTROL_V2
message carrying a probe request TLV, and the server answers with a
P_CONTROL_V2 carrying a probe reply. The reply tells the client how the
server wants to be ranked against the other remotes, and can also serve
as the second packet of the three-way handshake.

Add the two opcodes and the two TLV codecs the probe needs. P_CONTROL_V2
is framed like P_CONTROL_V1 but without the fields of the reliability
layer: a session id and then the TLVs, with no control message id and no
ACK array. P_CONTROL_WKC_V2 is the same with the wrapped client key
appended, as P_CONTROL_WKC_V1 is to P_CONTROL_V1.

The TLVs use the shared TLV codec, control_msg.c/h, and their two types
join the others there. The codec gains ctrl_msg_find_tlv(), which scans
a payload for the one mandatory TLV of a message. The scan is strict: a
truncated TLV header or value, a second TLV of the wanted type, or an
unknown TLV not marked optional rejects the whole message.

Both readers accept a value longer than the fields they know and ignore
the excess, which is how the TLVs are meant to be extended. The probe
reply reader does reject the two flag combinations the protocol rules
out, as neither can be acted on: the other addresses of a remote cannot
be both the same server and distinct ones, and the connect_lifetime
cannot be extended to those addresses without first calling them the
same server.

The reliable control path no longer decides what it handles from an
opcode range. P_FIRST_OPCODE and P_LAST_OPCODE give way to
opcode_is_reliable_control(), which lists the opcodes that carry a
message id and an ACK array, and tls_pre_decrypt_verify_opcode() and
write_control_auth() test that instead. Defining an opcode therefore no
longer joins it to that set, so the two opcodes added here need no
carve-out from a range.

No opcode changes hands: the old range covered exactly the seven listed,
plus the two data channel opcodes, which are handled before the check is
reached.

The probe is not sent or answered yet; that follows.

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1741
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1741
This mail reflects revision 28 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 50b2d68..c6dcf65 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -565,6 +565,8 @@
     src/openvpn/plugin.h
     src/openvpn/pool.c
     src/openvpn/pool.h
+    src/openvpn/probe.c
+    src/openvpn/probe.h
     src/openvpn/proto.c
     src/openvpn/proto.h
     src/openvpn/proxy.c
@@ -899,7 +901,9 @@
     target_sources(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_execve.c
         tests/unit_tests/openvpn/test_control_msg.c
+        tests/unit_tests/openvpn/test_probe.c
         src/openvpn/control_msg.c
+        src/openvpn/probe.c
         src/openvpn/argv.c
         src/openvpn/base64.c
         src/openvpn/crypto_epoch.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index be1044d..4c8edea 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -121,6 +121,7 @@
 	ping.c ping.h \
 	plugin.c plugin.h \
 	pool.c pool.h \
+	probe.c probe.h \
 	proto.c proto.h \
 	proxy.c proxy.h \
 	ps.c ps.h \
diff --git a/src/openvpn/control_msg.c b/src/openvpn/control_msg.c
index e14355c..a77413f 100644
--- a/src/openvpn/control_msg.c
+++ b/src/openvpn/control_msg.c
@@ -91,3 +91,32 @@
     buf_set_read(value, v, hdr->value_len);
     return true;
 }
+
+bool
+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *value)
+{
+    bool found = false;
+    while (BLEN(payload) > 0)
+    {
+        struct ctrl_msg_tlv_header hdr;
+        struct buffer v;
+        if (!ctrl_msg_tlv_next(payload, &hdr, &v))
+        {
+            return false;
+        }
+        if (hdr.type == wanted_type)
+        {
+            if (found)
+            {
+                return false; /* the TLV may occur only once */
+            }
+            *value = v;
+            found = true;
+        }
+        else if (!hdr.optional)
+        {
+            return false; /* a mandatory TLV we do not understand, wherever it sits */
+        }
+    }
+    return found;
+}
diff --git a/src/openvpn/control_msg.h b/src/openvpn/control_msg.h
index 92572cb..8ad5530 100644
--- a/src/openvpn/control_msg.h
+++ b/src/openvpn/control_msg.h
@@ -41,6 +41,8 @@
 
 /* TLV types */
 #define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset packets */
+#define TLV_TYPE_PROBE_REQUEST   0x0002 /* a client probing a server, in P_CONTROL_V2 */
+#define TLV_TYPE_PROBE_REPLY     0x0003 /* the server's answer, in P_CONTROL_V2 */
 
 /* A TLV header is a 16-bit type/optional field plus a 16-bit length */
 #define CTRL_MSG_TLV_HEADER_LEN 4
@@ -105,4 +107,28 @@
  */
 bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);
 
+/**
+ * Scan payload for the TLV of type wanted_type, skipping any other TLV type
+ * that is marked optional.
+ *
+ * This is for messages that carry exactly one mandatory TLV, which is what the
+ * probe messages are. Any other TLV that is not marked optional invalidates
+ * the message wherever it appears, as does a second TLV of wanted_type, so the
+ * whole sequence is walked even once the wanted TLV has been found. A message
+ * carrying several mandatory TLVs walks them with ctrl_msg_tlv_next() instead.
+ *
+ * On success value covers exactly the found TLV's value bytes; as in
+ * ctrl_msg_tlv_next(), a header claiming more bytes than payload holds is
+ * rejected rather than reported as found. payload is consumed as it is read.
+ *
+ * @param payload      buffer positioned at a TLV header
+ * @param wanted_type  the TLV type to look for
+ * @param value        set to a buffer covering the found TLV's value; it points
+ *                     into payload and owns no storage
+ * @return true if the TLV was found, false if it is absent or present more
+ *         than once, if a TLV header or value is malformed or truncated, or if
+ *         a TLV we do not understand is not marked optional.
+ */
+bool ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *value);
+
 #endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/probe.c b/src/openvpn/probe.c
new file mode 100644
index 0000000..2497b07
--- /dev/null
+++ b/src/openvpn/probe.c
@@ -0,0 +1,94 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "probe.h"
+#include "control_msg.h"
+
+bool
+probe_request_write(struct buffer *buf, const struct probe_request *r)
+{
+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN)
+           && buf_write_u64(buf, r->request_id) && buf_write_u64(buf, r->timestamp)
+           && buf_write_u32(buf, r->flags);
+}
+
+bool
+probe_request_read(struct buffer *buf, struct probe_request *r)
+{
+    /* One bounds check covers the whole value: every field read below then fits
+     * by construction, PROBE_REQUEST_LEN being the sum of their sizes, so none
+     * of them needs its own error handling. Trailing bytes this version does
+     * not understand are simply left unread. */
+    if (buf_len(buf) < PROBE_REQUEST_LEN)
+    {
+        return false;
+    }
+    r->request_id = buf_read_u64(buf, NULL);
+    r->timestamp = buf_read_u64(buf, NULL);
+    r->flags = buf_read_u32(buf, NULL);
+    return true;
+}
+
+bool
+probe_reply_write(struct buffer *buf, const struct probe_reply *r)
+{
+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REPLY, false, PROBE_REPLY_LEN)
+           && buf_write_u64(buf, r->request_id) && buf_write_u16(buf, r->priority)
+           && buf_write_u16(buf, r->weight) && buf_write_u16(buf, r->max_latency_diff)
+           && buf_write_u16(buf, r->connect_lifetime) && buf_write_u16(buf, r->flags);
+}
+
+bool
+probe_reply_read(struct buffer *buf, struct probe_reply *r)
+{
+    /* One bounds check for the whole value, as in probe_request_read(). */
+    if (buf_len(buf) < PROBE_REPLY_LEN)
+    {
+        return false;
+    }
+    r->request_id = buf_read_u64(buf, NULL);
+    r->priority = (uint16_t)buf_read_u16(buf);
+    r->weight = (uint16_t)buf_read_u16(buf);
+    r->max_latency_diff = (uint16_t)buf_read_u16(buf);
+    r->connect_lifetime = (uint16_t)buf_read_u16(buf);
+    r->flags = (uint16_t)buf_read_u16(buf);
+
+    /* The other addresses of the remote cannot be both the same server and
+     * distinct ones. And LIFETIME_SHARED extends the connect_lifetime to those
+     * other addresses, which says nothing unless ADDRS_EQUAL has declared them
+     * the same server to begin with. */
+    if ((r->flags & PROBE_REPLY_FLAG_ADDRS_EQUAL) && (r->flags & PROBE_REPLY_FLAG_PROBE_MORE))
+    {
+        return false;
+    }
+    if ((r->flags & PROBE_REPLY_FLAG_LIFETIME_SHARED) && !(r->flags & PROBE_REPLY_FLAG_ADDRS_EQUAL))
+    {
+        return false;
+    }
+    return true;
+}
diff --git a/src/openvpn/probe.h b/src/openvpn/probe.h
new file mode 100644
index 0000000..6001774
--- /dev/null
+++ b/src/openvpn/probe.h
@@ -0,0 +1,141 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+/**
+ * @file
+ * Encoding and decoding of the server probe TLVs.
+ *
+ * A client probes a server by sending a P_CONTROL_V2 message whose payload
+ * carries a probe request TLV, and the server answers with a P_CONTROL_V2
+ * message carrying a probe reply TLV. The reply tells the client how the
+ * server wants to be ranked against the other remotes, and can also serve
+ * as the second packet of the three-way handshake.
+ *
+ * The TLV framing and the TLV type space are shared with the other TLV-based
+ * control messages and live in control_msg.h; this file holds the two probe
+ * TLVs and what their fields mean.
+ */
+
+#ifndef PROBE_H
+#define PROBE_H
+
+#include "buffer.h"
+#include "control_msg.h"
+
+/** probe request flags. The client is only probing: it does not want to
+ * continue into a handshake, and the server may forget it right away. */
+#define PROBE_REQUEST_FLAG_PROBE_ONLY 0x00000001
+
+/* probe reply flags */
+/** complete the handshake with P_CONTROL_WKC_V1 rather than P_CONTROL_V1 */
+#define PROBE_REPLY_FLAG_RESEND_WKC      0x0001
+/** the other addresses of this remote are the same server, no need to probe them */
+#define PROBE_REPLY_FLAG_ADDRS_EQUAL     0x0002
+/** the connect_lifetime holds against those other addresses too, so a reply
+ * from one of them can skip the handshake with another. Only meaningful
+ * together with ADDRS_EQUAL, which is what names those addresses. */
+#define PROBE_REPLY_FLAG_LIFETIME_SHARED 0x0004
+/** the other addresses of this remote are distinct servers, so probe them too */
+#define PROBE_REPLY_FLAG_PROBE_MORE      0x0008
+
+/** probe request TLV, sent by a client to probe a server */
+struct probe_request
+{
+    uint64_t request_id; /**< identifies this probe, echoed in the reply */
+    /** The client clock as a UNIX timestamp in seconds. It is there for the
+     * server, which uses it to bound how old a request it will answer and so
+     * how long a captured one can be replayed. The reply does not echo it: a
+     * client times the round trip itself, by the request_id. */
+    uint64_t timestamp;
+    uint32_t flags; /**< PROBE_REQUEST_FLAG_* */
+};
+
+/** probe reply TLV, a server's answer to a probe request */
+struct probe_reply
+{
+    uint64_t request_id;       /**< echoes the request_id of the request */
+    uint16_t priority;         /**< DNS SRV style priority, lower is preferred */
+    uint16_t weight;           /**< DNS SRV style weight */
+    uint16_t max_latency_diff; /**< candidate band in ms around the fastest server */
+    /** For how many seconds, counted from the moment the client sent its own
+     * probe request, the server will still treat this exchange as the first
+     * two packets of the handshake. Within that window the client may send the
+     * third packet straight away instead of starting a handshake of its own.
+     * 0 means it cannot, so it has to begin a fresh one. */
+    uint16_t connect_lifetime;
+    uint16_t flags; /**< PROBE_REPLY_FLAG_* */
+};
+
+/* Smallest on-wire value length (the TLV header not counted) of each TLV: the
+ * sizes of the fixed fields above, in wire order. A value may be longer, which
+ * is how the TLVs are extended; trailing bytes that are not understood are
+ * ignored on read. */
+
+/** request_id (u64), timestamp (u64), flags (u32) */
+#define PROBE_REQUEST_LEN ((uint16_t)(2 * sizeof(uint64_t) + sizeof(uint32_t)))
+
+/** request_id (u64), then priority, weight, max_latency_diff,
+ * connect_lifetime and flags (u16 each) */
+#define PROBE_REPLY_LEN ((uint16_t)(sizeof(uint64_t) + 5 * sizeof(uint16_t)))
+
+/**
+ * Write a complete probe request TLV, header and value, to buf.
+ *
+ * @return true on success, false if buf has insufficient space.
+ */
+bool probe_request_write(struct buffer *buf, const struct probe_request *r);
+
+/**
+ * Read a probe request TLV value from buf.
+ *
+ * buf must cover exactly the TLV's value, as ctrl_msg_find_tlv() returns it.
+ * Bytes beyond the fields understood here are ignored, so a longer value from
+ * a future version still parses. Flag bits that are not known are kept in
+ * flags rather than rejected, for the same reason.
+ *
+ * @return true on success, false if buf is shorter than the mandatory fields.
+ */
+bool probe_request_read(struct buffer *buf, struct probe_request *r);
+
+/**
+ * Write a complete probe reply TLV, header and value, to buf.
+ *
+ * @return true on success, false if buf has insufficient space.
+ */
+bool probe_reply_write(struct buffer *buf, const struct probe_reply *r);
+
+/**
+ * Read a probe reply TLV value from buf. The calling convention is that of
+ * probe_request_read().
+ *
+ * The two flag combinations the protocol rules out are rejected here, since
+ * neither can be acted on: a reply must not call the other addresses of the
+ * remote both the same server and distinct ones, and it must not extend the
+ * connect_lifetime to those addresses without first calling them the same
+ * server.
+ *
+ * @return true on success, false if buf is shorter than the mandatory fields
+ *         or the flags contradict each other.
+ */
+bool probe_reply_read(struct buffer *buf, struct probe_reply *r);
+
+#endif /* ifndef PROBE_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e06659a..da87b3f 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3746,21 +3746,32 @@
 
 /**
  * Does a very coarse check on the received opcode. It only checks if the
- * opcode is an allowed op code for the peer to send at all, not if this
- * opcode is valid for the current state.
+ * opcode is one the peer may send on the reliable control channel at all,
+ * not if this opcode is valid for the current state.
  */
 static bool
 tls_pre_decrypt_verify_opcode(int op, bool server, const struct link_socket_actual *from)
 {
-    if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    if (!opcode_is_reliable_control(op))
     {
         if (op == P_CONTROL_HARD_RESET_CLIENT_V1 || op == P_CONTROL_HARD_RESET_SERVER_V1)
         {
             msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
         }
         struct gc_arena gc = gc_new();
-        msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s op=%d",
-            print_link_socket_actual(from, &gc), op);
+        if (op == P_CONTROL_V2 || op == P_CONTROL_WKC_V2)
+        {
+            /* a defined opcode, just not one this path can parse */
+            msg(D_TLS_ERRORS,
+                "TLS Error: %s received from %s, which is not part of "
+                "the reliable control channel",
+                packet_opcode_name(op), print_link_socket_actual(from, &gc));
+        }
+        else
+        {
+            msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s op=%d",
+                print_link_socket_actual(from, &gc), op);
+        }
         gc_free(&gc);
         return false;
     }
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index dad58c3..b0377f3 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -174,7 +174,8 @@
                    bool prepend_ack)
 {
     ASSERT(ks->key_id >= 0 && ks->key_id <= P_KEY_ID_MASK);
-    ASSERT(opcode >= 0 && opcode <= P_LAST_OPCODE);
+    /* this writes the message id and ACK array, which only these opcodes have */
+    ASSERT(opcode_is_reliable_control(opcode));
     uint8_t header = (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT));
 
     /* Workaround for Softether servers. Softether has a bug that it only
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 218c6bb..3b45492 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -58,11 +58,50 @@
  * like P_CONTROL_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* define the range of legal opcodes
- * Since we do no longer support key-method 1 we consider
- * the v1 op codes invalid */
-#define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  11
+/* Control channel packet carrying a TLV payload, e.g. a server probe. Framed
+ * like P_CONTROL_V1 but without the fields of the reliability layer: a session
+ * id and then the TLVs, with no message id and no ACK array. It is wrapped by
+ * tls-auth or tls-crypt like any other control channel packet, and with
+ * neither configured it travels unauthenticated, as they do. */
+#define P_CONTROL_V2 12
+
+/* Variant of P_CONTROL_V2 with the wrapped client key appended,
+ * like P_CONTROL_WKC_V1 is to P_CONTROL_V1 */
+#define P_CONTROL_WKC_V2 13
+
+/**
+ * Is a packet with opcode op carried by the reliable control channel?
+ *
+ * These opcodes are followed by an ACK array and a control message id, which
+ * is what the reliable path reads once it is past the session id. An opcode
+ * that is not one of them has something else there: P_CONTROL_V2 has its TLVs.
+ * Handing such a packet to that path would read the first bytes of that
+ * payload as an ACK count and a message id, and ACK or queue whatever it made
+ * of them.
+ *
+ * The opcodes are listed rather than bounded by a range, so that defining one
+ * does not silently add it to the set. Key method 1 is no longer supported, so
+ * its two reset opcodes are not here, and the data channel opcodes are handled
+ * before this is reached.
+ */
+static inline bool
+opcode_is_reliable_control(int op)
+{
+    switch (op)
+    {
+        case P_CONTROL_SOFT_RESET_V1:
+        case P_CONTROL_V1:
+        case P_ACK_V1:
+        case P_CONTROL_HARD_RESET_CLIENT_V2:
+        case P_CONTROL_HARD_RESET_SERVER_V2:
+        case P_CONTROL_HARD_RESET_CLIENT_V3:
+        case P_CONTROL_WKC_V1:
+            return true;
+
+        default:
+            return false;
+    }
+}
 
 /*
  * Define number of buffers for send and receive in the reliability layer.
@@ -257,6 +296,12 @@
         case P_CONTROL_WKC_V1:
             return "P_CONTROL_WKC_V1";
 
+        case P_CONTROL_V2:
+            return "P_CONTROL_V2";
+
+        case P_CONTROL_WKC_V2:
+            return "P_CONTROL_WKC_V2";
+
         case P_ACK_V1:
             return "P_ACK_V1";
 
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index e3404754..b06ae5e 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -166,6 +166,7 @@
 pkt_testdriver_LDFLAGS = @TEST_LDFLAGS@
 pkt_testdriver_SOURCES = test_pkt.c \
 	test_control_msg.c test_control_msg.h \
+	test_probe.c test_probe.h \
 	mock_msg.c mock_msg.h mock_win32_execve.c \
 	test_common.h \
 	$(top_srcdir)/src/compat/compat-strlcpy.c \
@@ -181,6 +182,7 @@
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
 	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/probe.c \
 	$(top_srcdir)/src/openvpn/reliable.c \
 	$(top_srcdir)/src/openvpn/run_command.c \
 	$(top_srcdir)/src/openvpn/session_id.c \
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index f34bd41..5609c67 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -45,6 +45,7 @@
 #include "reliable.h"
 #include "siphash.h"
 #include "test_control_msg.h"
+#include "test_probe.h"
 
 int
 parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
@@ -841,7 +842,21 @@
         cmocka_unit_test(test_tlv_next_walks_payload),
         cmocka_unit_test(test_tlv_next_value_truncated),
         cmocka_unit_test(test_tlv_header_truncated),
-        cmocka_unit_test(test_tlv_write_no_room)
+        cmocka_unit_test(test_tlv_write_no_room),
+        cmocka_unit_test(test_probe_request_roundtrip),
+        cmocka_unit_test(test_probe_request_wire_format),
+        cmocka_unit_test(test_probe_reply_roundtrip),
+        cmocka_unit_test(test_probe_reply_wire_format),
+        cmocka_unit_test(test_probe_request_forward_compat),
+        cmocka_unit_test(test_probe_request_too_short),
+        cmocka_unit_test(test_probe_reply_too_short),
+        cmocka_unit_test(test_probe_reply_flags_contradict),
+        cmocka_unit_test(test_find_tlv_value_truncated),
+        cmocka_unit_test(test_find_tlv_trailing_bytes),
+        cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),
+        cmocka_unit_test(test_find_tlv_rejects_unknown_mandatory),
+        cmocka_unit_test(test_find_tlv_rejects_duplicate),
+        cmocka_unit_test(test_find_tlv_empty_payload)
     };
 
     return cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_probe.c b/tests/unit_tests/openvpn/test_probe.c
new file mode 100644
index 0000000..967252c
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_probe.c
@@ -0,0 +1,425 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <stdarg.h>
+#include <stddef.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "control_msg.h"
+#include "probe.h"
+#include "test_common.h"
+#include "test_probe.h"
+
+/* Write a probe request TLV and read it back; the fields must survive the
+ * round trip and the whole buffer must be consumed. */
+void
+test_probe_request_roundtrip(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(128, &gc);
+
+    const struct probe_request in = {
+        .request_id = 0xdeadbeefcafef00dULL,
+        .timestamp = 0x0123456789abcdefULL,
+        .flags = PROBE_REQUEST_FLAG_PROBE_ONLY,
+    };
+    assert_true(probe_request_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REQUEST_LEN);
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+    assert_int_equal(hdr.type, TLV_TYPE_PROBE_REQUEST);
+    assert_false(hdr.optional);
+    assert_int_equal(hdr.value_len, PROBE_REQUEST_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value), PROBE_REQUEST_LEN);
+
+    struct probe_request out = { 0 };
+    assert_true(probe_request_read(&value, &out));
+    assert_true(in.request_id == out.request_id);
+    assert_true(in.timestamp == out.timestamp);
+    assert_int_equal(in.flags, out.flags);
+    /* the scan consumed header and value alike */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe request wire format is locked to the field order of the spec
+ * (request_id, timestamp, flags), big-endian. */
+void
+test_probe_request_wire_format(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(128, &gc);
+
+    const struct probe_request in = {
+        .request_id = 0x1122334455667788ULL,
+        .timestamp = 0x0102030405060708ULL,
+        .flags = 0,
+    };
+    assert_true(probe_request_write(&buf, &in));
+
+    /* clang-format off */
+    const uint8_t expected[] = {
+        0x00, 0x02,                                     /* TLV type 2, not optional */
+        0x00, 0x14,                                     /* TLV value length = 20 */
+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id */
+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, /* timestamp */
+        0x00, 0x00, 0x00, 0x00,                         /* flags */
+    };
+    /* clang-format on */
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV and read it back. */
+void
+test_probe_reply_roundtrip(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(128, &gc);
+
+    const struct probe_reply in = {
+        .request_id = 0x1122334455667788ULL,
+        .priority = 10,
+        .weight = 100,
+        .max_latency_diff = 25,
+        .connect_lifetime = 30,
+        .flags = PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert_true(probe_reply_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REPLY_LEN);
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+    assert_int_equal(hdr.type, TLV_TYPE_PROBE_REPLY);
+    assert_false(hdr.optional);
+    assert_int_equal(hdr.value_len, PROBE_REPLY_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REPLY, &value));
+
+    struct probe_reply out = { 0 };
+    assert_true(probe_reply_read(&value, &out));
+    assert_true(in.request_id == out.request_id);
+    assert_int_equal(in.priority, out.priority);
+    assert_int_equal(in.weight, out.weight);
+    assert_int_equal(in.max_latency_diff, out.max_latency_diff);
+    assert_int_equal(in.connect_lifetime, out.connect_lifetime);
+    assert_int_equal(in.flags, out.flags);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe reply wire format is locked to the field order of the spec
+ * (request_id, priority, weight, max_latency_diff, connect_lifetime, flags),
+ * big-endian. */
+void
+test_probe_reply_wire_format(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(128, &gc);
+
+    const struct probe_reply in = {
+        .request_id = 0x1122334455667788ULL,
+        .priority = 10,
+        .weight = 100,
+        .max_latency_diff = 25,
+        .connect_lifetime = 30,
+        .flags = PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert_true(probe_reply_write(&buf, &in));
+
+    /* clang-format off */
+    const uint8_t expected[] = {
+        0x00, 0x03,                                     /* TLV type 3, not optional */
+        0x00, 0x12,                                     /* TLV value length = 18 */
+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id */
+        0x00, 0x0a,                                     /* priority = 10 */
+        0x00, 0x64,                                     /* weight = 100 */
+        0x00, 0x19,                                     /* max_latency_diff = 25 */
+        0x00, 0x1e,                                     /* connect_lifetime = 30 */
+        0x00, 0x01,                                     /* flags = RESEND_WKC */
+    };
+    /* clang-format on */
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    gc_free(&gc);
+}
+
+/* A TLV with a longer-than-known value must still parse: the known fields are
+ * read and the trailing bytes are skipped. Flag bits we do not know are kept
+ * rather than rejected, for the same forward compatibility. */
+void
+test_probe_request_forward_compat(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(128, &gc);
+
+    const uint16_t extended_len = PROBE_REQUEST_LEN + 4;
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST, false, extended_len));
+    assert_true(buf_write_u64(&buf, 7));             /* request_id */
+    assert_true(buf_write_u64(&buf, 0xdeadbeefULL)); /* timestamp */
+    assert_true(buf_write_u32(&buf, 0x80000000));    /* flags, unknown bit set */
+    assert_true(buf_write_u32(&buf, 0x11223344));    /* unknown trailing field */
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value), extended_len);
+
+    struct probe_request out = { 0 };
+    assert_true(probe_request_read(&value, &out));
+    assert_true(out.request_id == 7);
+    assert_true(out.timestamp == 0xdeadbeefULL);
+    assert_true(out.flags == 0x80000000);
+    /* the unknown trailing field must have been consumed from the payload */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A value shorter than the mandatory fields must be rejected, even when it
+ * holds enough bytes for some of the individual fields to read successfully. */
+void
+test_probe_request_too_short(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(128, &gc);
+
+    /* 8 of the 20 mandatory value bytes: enough for the request_id alone */
+    assert_true(buf_write_u64(&buf, 0xdeadbeefULL));
+
+    struct probe_request out = { 0 };
+    assert_false(probe_request_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* The same for the reply, one u16 short of its 18 mandatory bytes. */
+void
+test_probe_reply_too_short(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u64(&buf, 1));
+    for (int i = 0; i < 4; i++)
+    {
+        assert_true(buf_write_u16(&buf, 0));
+    }
+
+    struct probe_reply out = { 0 };
+    assert_false(probe_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* The flag combinations the protocol rules out must be rejected: the other
+ * addresses of a remote cannot be both the same server and distinct ones, and
+ * a shared connect_lifetime needs them to have been called equal. */
+void
+test_probe_reply_flags_contradict(void **state)
+{
+    struct gc_arena gc = gc_new();
+    const uint16_t bad[] = {
+        PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_PROBE_MORE,
+        PROBE_REPLY_FLAG_LIFETIME_SHARED,
+        PROBE_REPLY_FLAG_LIFETIME_SHARED | PROBE_REPLY_FLAG_PROBE_MORE,
+    };
+    const uint16_t good[] = {
+        0,
+        PROBE_REPLY_FLAG_ADDRS_EQUAL,
+        PROBE_REPLY_FLAG_PROBE_MORE,
+        PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_LIFETIME_SHARED,
+    };
+
+    for (size_t i = 0; i < SIZE(bad) + SIZE(good); i++)
+    {
+        const bool expect_ok = i >= SIZE(bad);
+        const uint16_t flags = expect_ok ? good[i - SIZE(bad)] : bad[i];
+
+        struct buffer buf = alloc_buf_gc(128, &gc);
+        const struct probe_reply in = { .request_id = 1, .flags = flags };
+        assert_true(probe_reply_write(&buf, &in));
+
+        struct buffer value;
+        assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REPLY, &value));
+
+        struct probe_reply out = { 0 };
+        assert_int_equal(probe_reply_read(&value, &out), expect_ok);
+    }
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than the payload holds must be
+ * rejected by the scan rather than reported as found -- for the TLV being
+ * looked for as much as for one that would merely be skipped. */
+void
+test_find_tlv_value_truncated(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer value;
+
+    /* the wanted TLV declares 20 value bytes, only 8 are present */
+    struct buffer buf = alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN));
+    assert_true(buf_write_u64(&buf, 0xdeadbeefULL));
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    /* same defect on a TLV that would be skipped: the scan must not walk past
+     * the end of the payload looking for the next header */
+    struct buffer buf2 = alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&buf2, 0x7ff, false, 64));
+    assert_true(buf_write_u32(&buf2, 0));
+    assert_false(ctrl_msg_find_tlv(&buf2, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* Bytes left over after the last TLV that are too few for a header make the
+ * message malformed, even when the wanted TLV was already found. */
+void
+test_find_tlv_trailing_bytes(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer value;
+
+    /* 1 to 3 bytes: less than a 4-byte TLV header */
+    for (int trailing = 1; trailing < CTRL_MSG_TLV_HEADER_LEN; trailing++)
+    {
+        struct buffer buf = alloc_buf_gc(128, &gc);
+        const struct probe_request in = { .request_id = 1, .timestamp = 1 };
+        assert_true(probe_request_write(&buf, &in));
+        for (int i = 0; i < trailing; i++)
+        {
+            assert_true(buf_write_u8(&buf, 0));
+        }
+        assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV marked optional after the wanted one is skipped, and the
+ * wanted value is still the one returned. */
+void
+test_find_tlv_skips_optional_after_wanted(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(128, &gc);
+    struct buffer value;
+
+    const struct probe_request in = { .request_id = 1, .timestamp = 7 };
+    assert_true(probe_request_write(&buf, &in));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value), PROBE_REQUEST_LEN);
+    struct probe_request out = { 0 };
+    assert_true(probe_request_read(&value, &out));
+    assert_true(out.timestamp == 7);
+
+    gc_free(&gc);
+}
+
+/* A TLV we do not know that is not marked optional carries something its
+ * sender requires us to act on, so the scan rejects the message whether that
+ * TLV comes before or after the wanted one. */
+void
+test_find_tlv_rejects_unknown_mandatory(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer value;
+    const struct probe_request in = { .request_id = 1, .timestamp = 7 };
+
+    struct buffer before = alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&before, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&before, 0xcafef00d));
+    assert_true(probe_request_write(&before, &in));
+
+    struct buffer after = alloc_buf_gc(128, &gc);
+    assert_true(probe_request_write(&after, &in));
+    assert_true(ctrl_msg_tlv_write_header(&after, 0x7ff, false, 4));
+    assert_true(buf_write_u32(&after, 0xcafef00d));
+
+    assert_false(ctrl_msg_find_tlv(&before, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_false(ctrl_msg_find_tlv(&after, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* The wanted TLV may occur only once: a second one rejects the message. Repeats
+ * of an unknown TLV marked optional are skipped like any other. */
+void
+test_find_tlv_rejects_duplicate(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer value;
+    const struct probe_request in = { .request_id = 1 };
+
+    struct buffer buf = alloc_buf_gc(128, &gc);
+    assert_true(probe_request_write(&buf, &in));
+    assert_true(probe_request_write(&buf, &in));
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    buf = alloc_buf_gc(128, &gc);
+    for (int i = 0; i < 2; i++)
+    {
+        assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+        assert_true(buf_write_u32(&buf, 0));
+    }
+    assert_true(probe_request_write(&buf, &in));
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* An empty payload holds no TLV. */
+void
+test_find_tlv_empty_payload(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(16, &gc);
+    struct buffer value;
+
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_probe.h b/tests/unit_tests/openvpn/test_probe.h
new file mode 100644
index 0000000..9c4137d
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_probe.h
@@ -0,0 +1,54 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifndef TEST_PROBE_H
+#define TEST_PROBE_H
+
+void test_probe_request_roundtrip(void **state);
+
+void test_probe_request_wire_format(void **state);
+
+void test_probe_reply_roundtrip(void **state);
+
+void test_probe_reply_wire_format(void **state);
+
+void test_probe_request_forward_compat(void **state);
+
+void test_probe_request_too_short(void **state);
+
+void test_probe_reply_too_short(void **state);
+
+void test_probe_reply_flags_contradict(void **state);
+
+void test_find_tlv_value_truncated(void **state);
+
+void test_find_tlv_trailing_bytes(void **state);
+
+void test_find_tlv_skips_optional_after_wanted(void **state);
+
+void test_find_tlv_rejects_unknown_mandatory(void **state);
+
+void test_find_tlv_rejects_duplicate(void **state);
+
+void test_find_tlv_empty_payload(void **state);
+
+#endif


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
