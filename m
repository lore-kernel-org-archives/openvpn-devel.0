Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169AC606A880
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DpRuIzwo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LQ+uSmoJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ox42x2V8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=dP4hD3JoJ/f6IilHKhfmYYse+/DqHB+Z1YltgUgf47E=; b=DpRuIzwohhK/Qd
	exPWlpyxsruaivaO417Fu7hIYGFFWOsmSza+IEy98gjNeng0oqBBsPBeksAFBUcbwlYsQJZL0zrzF
	CgsKwER8qngaANClnETfNuZtqgdfi9KK4uc6OekPTR2l6z0QFX+0N8M95X9Sw4HomoaeIucRBEeNL
	a6c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xT0Ws-000000008R3-0q2p;
	Mon, 16 Nov 2026 17:30:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xT0Wq-000000008Qp-1hIa for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:30:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6kj/TVJW2sOkdqbK0DcFLA1kIX7TKQ52ncqLQfloiu8=; b=LQ+uSmoJ4DFIUaIxwWv7EpwWBq
 cela8avG95tmMlBFXL+q9OYOcDy0Q+sFPSn2eKGByjjYI9j9suRsLmSeUpY/GU+vy2ytuuGDn7pGU
 NaepoOMbwVtbRKxtDKOFzJJdKzMG0cHlUen6m+mWzYBuGKC54A7WPMAtJWrThU3ZajyU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6kj/TVJW2sOkdqbK0DcFLA1kIX7TKQ52ncqLQfloiu8=; b=Ox42x2V8rFhO+BZSxXB+4lKyk+
 Pv9b/B0qIOK7SWlTZg42wbTC9rvwLpYrTpMpz9vqjBOsJ/cSyzreolKaXpgCW3DoWlSpb0BenPiDK
 9Y9hFAiB6VAZso3stXVWeaUFi49H0/LLt0SsMyAJf8oI2jekKnSlT2V7mxBGmZHSj8Ew=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xT0Wm-000000004rU-0tAz for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 17:30:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AGHTrUM023891
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 18:29:53 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGHTr20023890
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 18:29:53 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 18:29:44 +0100
Message-ID: <20261116172950.23858-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xT0Wm-000000004rU-0tAz
Subject: [Openvpn-devel] [PATCH v8] control_msg: Add a shared TLV codec and
 use it for early negotiation
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

Early negotiation in the reset packets is a sequence of TLVs, and
planned out-of-band and control data messages will use the same TLV
format and type space. Add one TLV codec for all of them,
control_msg.c/h, and move early negotiation onto it.

The codec only handles the framing: reading and writing TLV headers,
writing a 16-bit TLV, and walking a payload TLV by TLV with each value
checked against the payload. How to treat an unknown type is up to each
message. With the optional flag clear the codec writes the same bytes as
the hand-rolled code it replaces.

In the codec the most significant bit of the type field is the
"optional" flag rather than part of the type. The old parser compared
the whole type word, so 0x8001 did not match the flags TLV and was
skipped as unknown; now it matches and is parsed as one.

Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Signed-off-by: Lev Stipakov <lev@openvpn.net>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1965
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1965
This mail reflects revision 8 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5cf1a30..305c26c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -457,6 +457,8 @@
     src/openvpn/console.c
     src/openvpn/console_builtin.c
     src/openvpn/console.h
+    src/openvpn/control_msg.c
+    src/openvpn/control_msg.h
     src/openvpn/crypto.c
     src/openvpn/crypto.h
     src/openvpn/crypto_backend.h
@@ -896,6 +898,8 @@
 
     target_sources(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_execve.c
+        tests/unit_tests/openvpn/test_control_msg.c
+        src/openvpn/control_msg.c
         src/openvpn/argv.c
         src/openvpn/base64.c
         src/openvpn/crypto_epoch.c
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index bb31053..be1044d 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -57,6 +57,7 @@
 	common.h \
 	comp.c comp.h compstub.c \
 	comp-lz4.c comp-lz4.h \
+	control_msg.c control_msg.h \
 	crypto.c crypto.h crypto_backend.h \
 	crypto_openssl.c crypto_openssl.h \
 	crypto_mbedtls.c crypto_mbedtls.h \
diff --git a/src/openvpn/control_msg.c b/src/openvpn/control_msg.c
new file mode 100644
index 0000000..e14355c
--- /dev/null
+++ b/src/openvpn/control_msg.c
@@ -0,0 +1,93 @@
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
+#include "control_msg.h"
+
+bool
+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional, uint16_t value_len)
+{
+    /* the type has 15 bits; the top bit is the optional flag */
+    ASSERT(type <= CTRL_MSG_TLV_TYPE_MASK);
+
+    /* Write nothing unless the whole TLV fits. The header promises that
+     * value_len bytes follow it, so a header written without room for the
+     * value would leave a partial TLV in buf. */
+    if (!buf_safe(buf, (size_t)CTRL_MSG_TLV_HEADER_LEN + value_len))
+    {
+        return false;
+    }
+    uint16_t field = type;
+    if (optional)
+    {
+        field |= CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(buf, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t value)
+{
+    return ctrl_msg_tlv_write_header(buf, type, optional, sizeof(uint16_t))
+           && buf_write_u16(buf, value);
+}
+
+bool
+ctrl_msg_tlv_peek_header(const struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    if (BLEN(buf) < CTRL_MSG_TLV_HEADER_LEN)
+    {
+        return false; /* fewer than 4 bytes left: truncated header */
+    }
+    /* read from a copy, so that buf is left where it was */
+    struct buffer tmp = *buf;
+    uint16_t field = (uint16_t)buf_read_u16(&tmp);
+    hdr->value_len = (uint16_t)buf_read_u16(&tmp);
+    hdr->type = field & CTRL_MSG_TLV_TYPE_MASK;
+    hdr->optional = (field & CTRL_MSG_TLV_OPTIONAL_FLAG) != 0;
+    return true;
+}
+
+bool
+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value)
+{
+    if (!ctrl_msg_tlv_peek_header(buf, hdr))
+    {
+        return false;
+    }
+    /* Consume nothing unless the whole TLV is there, so that a value shorter
+     * than the header claims leaves buf untouched. */
+    if (BLEN(buf) < CTRL_MSG_TLV_HEADER_LEN + hdr->value_len)
+    {
+        return false;
+    }
+    ASSERT(buf_advance(buf, CTRL_MSG_TLV_HEADER_LEN));
+    const uint8_t *v = buf_read_alloc(buf, hdr->value_len);
+    ASSERT(v);
+    buf_set_read(value, v, hdr->value_len);
+    return true;
+}
diff --git a/src/openvpn/control_msg.h b/src/openvpn/control_msg.h
new file mode 100644
index 0000000..92572cb
--- /dev/null
+++ b/src/openvpn/control_msg.h
@@ -0,0 +1,108 @@
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
+ * TLV framing shared by the TLV-based control messages of the wire protocol.
+ *
+ * Such a message payload is a sequence of TLV entries. Each TLV starts with a
+ * 4-byte header: a 16-bit field whose most significant bit is the "optional"
+ * flag and whose remaining 15 bits are the type, followed by a 16-bit length
+ * giving the size of the value that follows the header.
+ *
+ * All of these messages share one TLV type space, so the TLV types are all
+ * defined here. Only the framing is handled here: what a message does with a
+ * TLV type it does not know, marked optional or not, is up to its parser.
+ */
+
+#ifndef CONTROL_MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer.h"
+
+/* TLV types */
+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset packets */
+
+/* A TLV header is a 16-bit type/optional field plus a 16-bit length */
+#define CTRL_MSG_TLV_HEADER_LEN 4
+
+/* bit layout of the first 16-bit field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/** The header every TLV carries: the 15-bit type and optional flag packed into
+ * the first 16-bit field, then the length of the value that follows. */
+struct ctrl_msg_tlv_header
+{
+    uint16_t type;      /**< the 15-bit TLV type */
+    bool optional;      /**< value of the optional flag */
+    uint16_t value_len; /**< length of the value following the header */
+};
+
+/**
+ * Write a TLV header (type + optional flag + value length) to buf.
+ * type must fit in the 15 bits of the type field.
+ *
+ * Nothing is written unless the header and the value_len bytes of value
+ * that follow it both fit, so a failed write never leaves a partial TLV
+ * behind.
+ *
+ * @return true on success, false if buf has insufficient space.
+ */
+bool ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional,
+                               uint16_t value_len);
+
+/**
+ * Write a complete TLV whose value is a single 16-bit integer to buf.
+ *
+ * @return true on success, false if buf has insufficient space.
+ */
+bool ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t value);
+
+/**
+ * Read a TLV header from buf without consuming it.
+ *
+ * @param buf  buffer positioned at the TLV header
+ * @param hdr  filled with the type, optional flag and value length on success
+ * @return true on success, false if there are not enough bytes for a header.
+ */
+bool ctrl_msg_tlv_peek_header(const struct buffer *buf, struct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Read the next TLV from buf, advancing past its header and value. Call it
+ * while BLEN(buf) > 0 to walk a whole payload.
+ *
+ * The length from the header is validated against buf, so on success the
+ * whole value is present: a header claiming more bytes than buf holds is
+ * rejected. Nothing is consumed unless the whole TLV is there, so a failed
+ * read never leaves a partial TLV behind.
+ *
+ * @param buf    buffer positioned at a TLV header
+ * @param hdr    filled with the TLV's type, optional flag and value length
+ * @param value  set to a buffer covering exactly the TLV's value; it points
+ *               into buf and owns no storage
+ * @return true on success, false if the header or the value is truncated,
+ *         with buf left untouched.
+ */
+bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);
+
+#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 420daef..9a72614 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -52,6 +52,7 @@
 #include "pkcs11.h"
 #include "route.h"
 #include "tls_crypt.h"
+#include "control_msg.h"
 
 #include "crypto_epoch.h"
 #include "ssl.h"
@@ -2644,26 +2645,21 @@
 {
     while (buf->len > 0)
     {
-        if (buf_len(buf) < 4)
-        {
-            goto error;
-        }
-        /* read type */
-        int type = buf_read_u16(buf);
-        int len = buf_read_u16(buf);
-        if (type < 0 || len < 0 || buf_len(buf) < len)
+        struct ctrl_msg_tlv_header hdr;
+        struct buffer value;
+        if (!ctrl_msg_tlv_next(buf, &hdr, &value))
         {
             goto error;
         }
 
-        switch (type)
+        switch (hdr.type)
         {
             case TLV_TYPE_EARLY_NEG_FLAGS:
-                if (len != sizeof(uint16_t))
+                if (BLEN(&value) != sizeof(uint16_t))
                 {
                     goto error;
                 }
-                int flags = buf_read_u16(buf);
+                int flags = buf_read_u16(&value);
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
@@ -2682,8 +2678,8 @@
                 break;
 
             default:
-                /* Skip types we do not parse */
-                buf_advance(buf, len);
+                /* Skip types we do not parse, marked optional or not */
+                break;
         }
     }
     reliable_mark_deleted(ks->rec_reliable, buf);
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index f78782f..f4564ef 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -33,6 +33,7 @@
 #include "reliable.h"
 #include "siphash.h"
 #include "tls_crypt.h"
+#include "control_msg.h"
 
 /*
  * Dependent on hmac size, opcode size, and session_id size.
@@ -432,9 +433,8 @@
     /* Add indication for tls-crypt-v2 to resend the WKc with the reply */
     if (request_resend_wkc)
     {
-        buf_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */
-        buf_write_u16(&buf, sizeof(uint16_t));
-        buf_write_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
+        ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+                                      EARLY_NEG_FLAG_RESEND_WKC));
     }
 
     /* Add tls-auth/tls-crypt wrapping, this might replace buf with
diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
index 8203e4a..218c6bb 100644
--- a/src/openvpn/ssl_pkt.h
+++ b/src/openvpn/ssl_pkt.h
@@ -306,10 +306,8 @@
 #define EARLY_NEG_START 0x0f000000
 
 
-/* Early negotiation that part of the server response in the RESET_V2 packet.
- * Since clients that announce early negotiation support will treat the payload
- * of reset packets special and parse it as TLV messages.
- * as TLV (type, length, value) */
-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001
+/* Early negotiation: clients that announce support for it parse the payload of
+ * the reset packets as TLVs (see control_msg.h). Flags carried in the value of
+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #define EARLY_NEG_FLAG_RESEND_WKC 0x0001
 #endif /* ifndef SSL_PKT_H */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 70cf7b2..11f92f4 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -164,11 +164,15 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS = @TEST_LDFLAGS@
-pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c test_common.h \
+pkt_testdriver_SOURCES = test_pkt.c \
+	test_control_msg.c test_control_msg.h \
+	mock_msg.c mock_msg.h mock_win32_execve.c \
+	test_common.h \
 	$(top_srcdir)/src/compat/compat-strlcpy.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/control_msg.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
diff --git a/tests/unit_tests/openvpn/test_control_msg.c b/tests/unit_tests/openvpn/test_control_msg.c
new file mode 100644
index 0000000..ad4c565
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_control_msg.c
@@ -0,0 +1,181 @@
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
+#include "ssl_pkt.h"
+#include "test_common.h"
+#include "test_control_msg.h"
+
+/* The early negotiation flags TLV of a reset packet asking a tls-crypt-v2
+ * client to resend its WKc. */
+void
+test_tlv_write_u16_wire_format(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+                                       EARLY_NEG_FLAG_RESEND_WKC));
+    const uint8_t expected[] = { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    /* the optional flag is the most significant bit of the type field */
+    buf_clear(&buf);
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));
+    assert_int_equal(BPTR(&buf)[0], 0x80);
+    assert_int_equal(BPTR(&buf)[1], 0x01);
+
+    gc_free(&gc);
+}
+
+/* A TLV header survives the round trip, the optional flag kept apart from
+ * the 15-bit type. */
+void
+test_tlv_header_roundtrip(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x1234, true, 5));
+    assert_int_equal(BLEN(&buf), 4);
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+    assert_int_equal(hdr.type, 0x1234);
+    assert_true(hdr.optional);
+    assert_int_equal(hdr.value_len, 5);
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN); /* peek consumes nothing */
+
+    gc_free(&gc);
+}
+
+/* Walking a payload returns each TLV in turn, with a value covering exactly
+ * its bytes, and consumes the payload. */
+void
+test_tlv_next_walks_payload(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0x11223344));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x5, false, 0)); /* empty value */
+
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer value;
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr.type, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_false(hdr.optional);
+    assert_int_equal(BLEN(&value), 2);
+    assert_int_equal(buf_read_u16(&value), 0xabcd);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr.type, 0x7ff);
+    assert_true(hdr.optional);
+    assert_int_equal(BLEN(&value), 4);
+    assert_int_equal(buf_read_u32(&value, NULL), 0x11223344);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr.type, 0x5);
+    assert_int_equal(BLEN(&value), 0);
+
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than the payload holds is rejected,
+ * rather than read past the end of the payload, and leaves buf untouched. */
+void
+test_tlv_next_value_truncated(void **state)
+{
+    struct gc_arena gc = gc_new();
+    struct buffer buf = alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer value;
+    assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + sizeof(uint32_t));
+
+    gc_free(&gc);
+}
+
+/* Reading a TLV header must fail, rather than read past the available data,
+ * when the buffer holds less than a complete 4-byte header, and must leave
+ * buf untouched. */
+void
+test_tlv_header_truncated(void **state)
+{
+    struct gc_arena gc = gc_new();
+    const uint8_t bytes[] = { 0x00, 0x01, 0x00 };
+
+    /* 0 to 3 bytes: none, part of the type field, the type field, and the type
+     * field with half of the length */
+    for (size_t n = 0; n <= sizeof(bytes); n++)
+    {
+        struct buffer buf = alloc_buf_gc(16, &gc);
+        assert_true(buf_write(&buf, bytes, n));
+
+        struct ctrl_msg_tlv_header hdr;
+        struct buffer value;
+        assert_false(ctrl_msg_tlv_peek_header(&buf, &hdr));
+        assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value));
+        assert_int_equal(BLEN(&buf), n);
+    }
+
+    gc_free(&gc);
+}
+
+/* Writing fails, rather than writes a partial TLV, when buf is too small. */
+void
+test_tlv_write_no_room(void **state)
+{
+    struct gc_arena gc = gc_new();
+
+    struct buffer buf = alloc_buf_gc(3, &gc);
+    assert_false(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));
+    assert_int_equal(BLEN(&buf), 0);
+
+    /* room for the header but not the value */
+    buf = alloc_buf_gc(5, &gc);
+    assert_false(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_control_msg.h b/tests/unit_tests/openvpn/test_control_msg.h
new file mode 100644
index 0000000..ef7a030
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_control_msg.h
@@ -0,0 +1,37 @@
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
+#ifndef TEST_CONTROL_MSG_H
+#define TEST_CONTROL_MSG_H
+
+void test_tlv_write_u16_wire_format(void **state);
+
+void test_tlv_header_roundtrip(void **state);
+
+void test_tlv_next_walks_payload(void **state);
+
+void test_tlv_next_value_truncated(void **state);
+
+void test_tlv_header_truncated(void **state);
+
+void test_tlv_write_no_room(void **state);
+#endif
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index fbbb40f..7dc07aa 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -37,12 +37,14 @@
 #include "crypto.h"
 #include "options.h"
 #include "ssl_backend.h"
+#include "control_msg.h"
 #include "ssl_pkt.h"
 #include "tls_crypt.h"
 
 #include "mss.h"
 #include "reliable.h"
 #include "siphash.h"
+#include "test_control_msg.h"
 
 int
 parse_line(const char *line, char **p, const int n, const char *file, const int line_num,
@@ -655,6 +657,45 @@
     free_buf(&tas.workbuf);
 }
 
+/* A reset reply asking a tls-crypt-v2 client to resend its WKc ends in the
+ * early negotiation flags TLV, and that TLV parses back. */
+static void
+test_generate_reset_packet_resend_wkc(void **ut_state)
+{
+    struct tls_auth_standalone tas = { 0 };
+
+    struct session_id client_id = { { 0, 1, 2, 3, 4, 5, 6, 7 } };
+    struct session_id server_id = { { 8, 9, 0, 9, 8, 7, 6, 2 } };
+
+    tas.tls_wrap.mode = TLS_WRAP_NONE;
+    struct frame frame = { .buf = { .headroom = 200, .payload_size = 1400 }, 0 };
+    tas.frame = frame;
+    tas.workbuf = alloc_buf(1600);
+
+    uint8_t header = 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
+
+    struct buffer plain =
+        tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, header, false);
+    const int plain_len = BLEN(&plain);
+    struct buffer buf =
+        tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, header, true);
+
+    const uint8_t tlv[] = { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf), plain_len + (int)sizeof(tlv));
+    assert_memory_equal(BPTR(&buf) + plain_len, tlv, sizeof(tlv));
+
+    struct buffer payload = buf;
+    assert_true(buf_advance(&payload, plain_len));
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer value;
+    assert_true(ctrl_msg_tlv_next(&payload, &hdr, &value));
+    assert_int_equal(hdr.type, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_int_equal(buf_read_u16(&value), EARLY_NEG_FLAG_RESEND_WKC);
+    assert_int_equal(BLEN(&payload), 0);
+
+    free_buf(&tas.workbuf);
+}
+
 static void
 test_generate_reset_packet_tls_auth(void **ut_state)
 {
@@ -791,9 +832,16 @@
         cmocka_unit_test(test_verify_hmac_tls_auth),
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain),
+        cmocka_unit_test(test_generate_reset_packet_resend_wkc),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit_test(test_wkc_not_appended_without_key),
-        cmocka_unit_test(test_extract_control_message)
+        cmocka_unit_test(test_extract_control_message),
+        cmocka_unit_test(test_tlv_write_u16_wire_format),
+        cmocka_unit_test(test_tlv_header_roundtrip),
+        cmocka_unit_test(test_tlv_next_walks_payload),
+        cmocka_unit_test(test_tlv_next_value_truncated),
+        cmocka_unit_test(test_tlv_header_truncated),
+        cmocka_unit_test(test_tlv_write_no_room)
     };
 
     return cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
