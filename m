Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB452606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b6xRITEa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RA5AQbw2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B7cviJUq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3cFBOjaKwu4yzJAKvfe7DDvXWko1pCp7MsBW3NkCVHc=; b=b6xRITEadJwycf
	pffVkzWVbomwyS0pGgxMZLvmy2u7xT8h0XF+b7Jx1Q4zELGR99kvD58YXqaXihS6rxp31AiZefOSF
	rFR8zMQUqF9KU3DupZrVhW/7A01TcSzBi3VbDb9FDsYs43B6ITubxuVUevK6YQ5gtRpkpqw6e/0zg
	Nvo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMq11-0000000010h-3RqV;
	Fri, 30 Oct 2026 17:03:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMq0p-0000000010T-3V78 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 17:03:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=49zHcVS+/UIJeGPH+5uVKFalYkhTcGJqqjpsX/OlBuw=; b=RA5AQbw2h5PPb0qwkxeG5Ig8Xf
 x5nxOdMhZw4c1NKwVk3iaEIDOA89Id0SaE2UFEDXxyOq1fX4KVkU+3YpUmjzkrTV0WUQifG2geVAM
 HqLd6Bcau7fCQv+LA07iyEBeD2K7rwUV0wS5qYcKHll8QHKcpsQKUruwzV0kcmUgLVSk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=49zHcVS+/UIJeGPH+5uVKFalYkhTcGJqqjpsX/OlBuw=; b=B7cviJUqce64edhNvc6jmQXusF
 1ysiz7ZyLAdjyex9Na0rQUQqybxNLNxEphLA7rXJ8NP6wtFXgDH0TSQbvLMfAEYH8K3KkOzqczwxE
 qA1eVz0QH1GQkiIeoGa1Qv13WoYMdEdRYeQGseUn6+pRbknwCEcnuX2V33Z54fN8Yu7g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMq0m-000000007OC-09V9 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 17:03:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69UH3Lqt006169
 for <openvpn-devel@lists.sourceforge.net>; Fri, 30 Oct 2026 18:03:21 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69UH3L0G006168
 for openvpn-devel@lists.sourceforge.net; Fri, 30 Oct 2026 18:03:21 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 30 Oct 2026 18:03:15 +0100
Message-ID: <20261030170320.6133-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMq0m-000000007OC-09V9
Subject: [Openvpn-devel] [PATCH v25] Implement sending/receiving app custom
 control protocol messages
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

From: Arne Schwabe <arne@rfc2549.org>

This allows openvpn GUI/front-ends and server via management
to use the OpenVPN control channel to pass messages between each other
while OpenVPN handles the marshalling/unmarshalling of these and
negotiate the common app custom control protocols.

This provides an easy to use secure channel that does not depend on
the network itself to work and can also be used before fully
authenticating the client. See the management-notes.txt for more
details how to use this feature. An upcoming patch will also add
some example python scripts that showcase this feature.

Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1858
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1858
This mail reflects revision 25 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 184a95a..4deabe7 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -435,6 +435,8 @@
     src/compat/compat-strlcpy.c
     src/compat/compat-strsep.c
     src/compat/compat-strtok_r.c
+    src/openvpn/acc.c
+    src/openvpn/acc.h
     src/openvpn/argv.c
     src/openvpn/argv.h
     src/openvpn/base64.c
@@ -826,6 +828,8 @@
             tests/unit_tests/openvpn/mock_management.c
             tests/unit_tests/openvpn/mock_ssl_dependencies.c
             tests/unit_tests/openvpn/mock_win32_execve.c
+            tests/unit_tests/openvpn/test_acc.c
+            src/openvpn/acc.c
             src/openvpn/argv.c
             src/openvpn/base64.c
             src/openvpn/crypto_epoch.c
@@ -842,6 +846,7 @@
             src/openvpn/packet_id.c
             src/openvpn/run_command.c
             src/openvpn/ssl_mbedtls.c
+            src/openvpn/ssl_ncp.c
             src/openvpn/ssl_openssl.c
             src/openvpn/ssl_util.c
             src/openvpn/ssl_verify_mbedtls.c
diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-options.rst
index 87c138a..16309f9 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -437,6 +437,12 @@
         Additional authentication methods supported by the client.
         This may be set by the client UI/GUI using ``--setenv``.
 
+  :code:`IV_ACC=<max_msg_len>,<flags>,<protocols>`
+        If the option ``--app-custom-control`` is set, the client will
+        send the supported max ACC message length, the supported formats
+        as (:code:`A:6`) and the list of configured protocols (e.g.
+        :code:`flower:happy:power`)
+
   The following flags depend on which compression formats are compiled in
   and whether compression is allowed by options. See `Protocol options`_
   for more details.
diff --git a/doc/man-sections/management-options.rst b/doc/man-sections/management-options.rst
index 2c79d05..315e567 100644
--- a/doc/man-sections/management-options.rst
+++ b/doc/man-sections/management-options.rst
@@ -144,3 +144,17 @@
 
 --management-up-down
   Report tunnel up/down events to management interface.
+
+--app-custom-control protocol-list
+  Sets the list of supported app custom control protocols.
+  These protocols are announced to the server via the IV_ACC peer info
+  variable when this option is used on a client.
+  If the option is set on a server it will negotiate common protocols
+  with the client.
+
+  The protocol-list is a : separated list of protocol identifiers. Protocol
+  identifiers must consist of alphanumeric characters, :code:`-`, and
+  :code:`_`.
+
+  See management-notes.txt in the OpenVPN distribution and the OpenVPN RFC
+  draft for a description of app custom control protocol support.
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst
index f420380f..474c7fd 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -1006,3 +1006,12 @@
        X509_1_L=BISHKEK
        X509_1_ST=NA
        X509_1_C=KG
+
+:code:`acc_protocols`
+    If ``--app-custom-control`` is configured and the client supports any of the
+    protocols that server also supports, this variable contains a list of
+    common protocols separated by :.
+
+:code:`acc_message_len`
+    if :code:`acc_protocols` is set, this variable contains the maximum
+    message length for app custom protocol message.
diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 4d726c4..3f12c83 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -828,6 +828,59 @@
 that is required to continue the connection (unlike MFA or opening a browser)
 this message is not negotiated but can just be sent as a gratuitous message.
 
+app custom control
+==================
+If the special string "ACC" is passed as {EXTRA} OpenVPN will determine
+the common app custom protocols between the client and the server and instruct
+the client that the server will send control messages to the client using
+the ACC protocol.
+
+The server should then use client-acc-msg command to send app custom
+control messages to the client to facilitate the pending authentication.
+
+COMMAND -- client-acc-msg (OpenVPN 2.8 or higher)
+-------------------------------------------------
+
+On an OpenVPN instance running in server mode this command sends an
+app custom control message to a client. The format of the command is:
+
+  client-acc-msg {CID} {KID}
+  {protocol}
+  {flags}
+  {message}
+  END
+
+CID,KID -- client ID and Key ID. See documentation for ">CLIENT:"
+notification for more info.
+
+protocol -- the ACC protocol identifier that this message should be
+            tagged with.
+
+flags    -- a concatenation of letters for the encoding ('A' or '6')
+            and the lette 'F' if the message is a fragment. E.g.
+            "6F" for a base64 encoded message that is also a fragment
+            and not complete yet.
+
+message  -- The message encoded in the encoding specified in flags
+
+
+COMMAND -- acc-msg (OpenVPN 2.8 or higher)
+------------------------------------------
+
+When OpenVPN is running in --client mode this command sends an app
+custom command to the server. The format of the command is
+
+  acc-msg
+  {protocol}
+  {flags}
+  {message}
+  END
+
+See the client-acc-msg command for more details about the format of the
+message. Since a client has only one peer there is no need to specify the
+client id and key id.
+
+
 COMMAND -- client-deny  (OpenVPN 2.1 or higher)
 -----------------------------------------------
 
@@ -1302,6 +1355,52 @@
    response. Mechanisms that need multiple rounds or more complex answers
    should implement a different response type than CR_RESPONSE.
 
+(6) App custom control message
+
+    This message is an application specific payload message that is transported
+    over the OpenVPN control channel.
+
+    In server mode:
+
+    >CLIENT:ACC,{CID},{KID},{protocol},{fragment},{msg_base64}
+
+    In client mode:
+
+    >ACC:{protocol},{fragment},{msg_base64}
+
+    The protocol is a short ascii string identifying the app specific custom
+    protocol. If fragment is set to 1, the message is not complete and the
+    next message should be concatenated to this message to form a complete
+    message.
+
+    Note that the OpenVPN implementation operates here with the robustness
+    principle ("be conservative in what you send, be liberal in what you
+    accept" - RFC 793 and others) and allows receiving messages longer than
+    maximum allowed message length. Implementations should be prepared to
+    handle messages that are longer than the maximum allowed message length.
+
+    OpenVPN does not verify that the message is valid base64. A peer that
+    sends invalid base64 payload will be passed to the management interface.
+    An implementation should be prepared to handle invalid base64 and
+    handle accordingly (e.g. disconnect the client via client-deny or
+    ignore such messages).
+
+(7) App custom control protocol message
+
+   This message informs the client about the common ACC
+   protocols and the maximum message length for an ACC message.
+
+   In client mode:
+
+   >ACC_PROTOCOLS:protocols={protocol_list},message_len={max_msg_len}
+
+   protocol_list is the list of supported protocols by both server and client.
+   For example flower:power:sys_info would indicate these three protocols
+   are supported. max_msg_len specifies the maximum message length that the
+   peer supports.
+
+   In server mode these information are available in the acc_protocols and
+   acc_message_len variables of the client environment.
 
 Variables:
 
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 8a60a94..ebc4db6 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -45,6 +45,7 @@
 sbin_PROGRAMS = openvpn
 
 openvpn_SOURCES = \
+	acc.c acc.h \
 	argv.c argv.h \
 	auth_token.c auth_token.h \
 	base64.c base64.h \
@@ -124,7 +125,8 @@
 	proto.c proto.h \
 	proxy.c proxy.h \
 	ps.c ps.h \
-	push.c push_util.c push.h \
+	push.c push.h \
+	push_util.c \
 	pushlist.h \
 	reflect_filter.c reflect_filter.h \
 	reliable.c reliable.h \
diff --git a/src/openvpn/acc.c b/src/openvpn/acc.c
new file mode 100644
index 0000000..455f56d
--- /dev/null
+++ b/src/openvpn/acc.c
@@ -0,0 +1,445 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn.net>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549.org>
+ *
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
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <string.h>
+#include "buffer.h"
+#include "error.h"
+#include "acc.h"
+#include "forward.h"
+#include "options_util.h"
+#include "ssl_util.h"
+#include "ssl_ncp.h"
+#include "multi.h"
+
+static void
+log_acc_message(struct context *c, const struct buffer *buf, int payload_len,
+                const char *protocol, int flags)
+{
+    bool fragment = flags & ACC_MESSAGE_FLAGS_FRAGMENT;
+#ifdef ENABLE_MANAGEMENT
+    struct gc_arena gc = gc_new();
+    const char *payload_msg = NULL;
+
+    /* For simplicity, we always encode payload to be base64 encoded
+     * if not already in base64 format */
+    if (flags & ACC_MESSAGE_FLAGS_ASCII)
+    {
+        char *b64out = NULL;
+        ASSERT(openvpn_base64_encode(CBPTR(buf), payload_len, &b64out) >= 0);
+        gc_addspecial(b64out, free, &gc);
+        payload_msg = b64out;
+    }
+    else
+    {
+        payload_msg = CBSTR(buf);
+    }
+
+    if (management)
+    {
+        struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+
+        if (c->options.mode == MODE_SERVER)
+        {
+            /* server mode. Report client context */
+            struct man_def_auth_context *mda = session->opt->mda_context;
+            unsigned int mda_key_id = get_primary_key(c->c2.tls_multi)->mda_key_id;
+            msg(M_CLIENT, ">CLIENT:ACC,%lu,%u,%s,%d,%s",
+                mda->cid, mda_key_id, protocol, fragment, payload_msg);
+        }
+        else
+        {
+            /* Client mode. Do not a report a CLIENT id */
+            msg(M_CLIENT, ">ACC:%s,%d,%s", protocol, fragment, payload_msg);
+        }
+    }
+    gc_free(&gc);
+#endif /* ifdef ENABLE_MANAGEMENT */
+    msg(D_PUSH, "Received custom app control message (protocol '%s'%s)",
+        protocol, fragment ? ", fragment" : "");
+}
+
+
+int
+parse_acc_message_flags(const char *flags, const char **err_reason, struct gc_arena *gc)
+{
+    int acc_flags = 0;
+
+    for (const char *flag = flags; *flag != '\0'; flag++)
+    {
+        if (*flag == 'A')
+        {
+            acc_flags |= ACC_MESSAGE_FLAGS_ASCII;
+        }
+        else if (*flag == '6')
+        {
+            acc_flags |= ACC_MESSAGE_FLAGS_BASE64;
+        }
+        else if (*flag == 'F')
+        {
+            acc_flags |= ACC_MESSAGE_FLAGS_FRAGMENT;
+        }
+        else
+        {
+            *err_reason = "Unknown flag in flags";
+            return -1;
+        }
+    }
+    /* The message should be encoded with exactly one encoding. Ensure that
+     * only one of the flags is present */
+    bool asciienc = (bool)(acc_flags & ACC_MESSAGE_FLAGS_ASCII);
+    bool base64enc = (bool)(acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+
+    if (base64enc + asciienc != 1)
+    {
+        char *tmp = gc_malloc(512, 1, gc);
+        snprintf(tmp, 512, "number of encodings must be exactly one "
+                           "(B64=%d, ASCII=%d)",
+                 base64enc, asciienc);
+        *err_reason = tmp;
+        return -1;
+    }
+
+    return acc_flags;
+}
+
+/**
+ * Wrapper around parse_acc_message_flags to also include the step of
+ * extracting the flags from the buffer and forwarding the buffer
+ * beyond the flags field.
+ */
+static int
+parse_acc_message_flags_buf(struct buffer *buf, const char **err_reason, struct gc_arena *gc)
+{
+    const char *flags = buf_extract_field(buf, ',', gc);
+
+    if (!flags)
+    {
+        *err_reason = "could not extract flags field";
+        return -1;
+    }
+    return parse_acc_message_flags(flags, err_reason, gc);
+}
+
+void
+receive_acc_message(struct context *c, const struct buffer *buffer)
+{
+    struct gc_arena gc = gc_new();
+    const char *err_reason = "";
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    struct buffer buf = *buffer;
+
+    const struct tls_multi *multi = c->c2.tls_multi;
+    if (!multi->acc_negotiated_protocols)
+    {
+        err_reason = "ACC not enabled or no negotiated protocols";
+        goto err;
+    }
+
+    if (!buf_advance(&buf, strlen("ACC")) || buf_read_u8(&buf) != ',')
+    {
+        err_reason = "missing , after ACC";
+        goto err;
+    }
+
+    /* extract protocol, payload length, flags substrings */
+    const char *protocol = buf_extract_field(&buf, ',', &gc);
+    if (!protocol)
+    {
+        err_reason = "could not extract protocol field";
+        goto err;
+    }
+
+    if (!tls_item_in_cipher_list(protocol, multi->acc_negotiated_protocols))
+    {
+        struct buffer msg_buf = alloc_buf_gc(1024, &gc);
+        buf_printf(&msg_buf, "protocol '%s' not in list of negotiated protocols '%s'",
+                   protocol, multi->acc_negotiated_protocols);
+        err_reason = buf_cstr(&msg_buf);
+
+
+        goto err;
+    }
+
+    /* We do not check the length here. We make no promises to support
+     * anything larger than our announced message length but according to
+     * the robustness principle
+     * ("be conservative in what you send, be liberal in what you accept" - RFC 793 and others)
+     * we accept also longer messages */
+
+    int payload_len;
+    const char *payload_len_str = buf_extract_field(&buf, ',', &gc);
+    if (!payload_len_str
+        || !atoi_constrained(payload_len_str, &payload_len, "acc_payload_len", 0, TLS_CHANNEL_BUF_SIZE - 1, D_PUSH_ERRORS))
+    {
+        err_reason = "could not extract payload length field";
+        goto err;
+    }
+
+    int flags = parse_acc_message_flags_buf(&buf, &err_reason, &gc);
+
+    if (flags < 0)
+    {
+        goto err;
+    }
+
+    /* We should have a final NUL byte in the control message buffer
+     * and thus the length of the buffer should be payload_len + 1 */
+    if (buf_len(&buf) != payload_len + 1)
+    {
+        char *tmp = gc_malloc(512, 1, &gc);
+        snprintf(tmp, 512, "field length %d, payload length %d mismatch",
+                 payload_len, buf_len(&buf) - 1);
+        err_reason = tmp;
+        goto err;
+    }
+
+
+    log_acc_message(c, &buf, payload_len, protocol, flags);
+    gc_free(&gc);
+    return;
+
+err:
+    msg(D_PUSH_ERRORS, "WARNING: Received malformed custom app control channel "
+                       "message (%s): %s",
+        err_reason,
+        format_hex(CBPTR(buffer), BLEN(buffer), 80, &gc));
+    gc_free(&gc);
+}
+
+
+bool
+send_acc_message(struct context *c,
+                 struct tls_multi *multi,
+                 struct tls_session *session,
+                 const char *protocol, bool fragment,
+                 const char *acc_msg_payload, bool base64)
+{
+    /*
+     * length of the protocol string + one ','
+     * 2 for the encoding (A or 6), potential F (fragment), and 1 for the ',',
+     * 4 for the message size itself and one comma
+     * 1 for the comma before the message itself */
+    const size_t max_header_size = strlen("ACC,") + strlen(protocol) + 1 + 4 + 1 + 2 + 1;
+    size_t len = max_header_size + strlen(acc_msg_payload);
+
+    if (len > TLS_CHANNEL_BUF_SIZE)
+    {
+        msg(M_CLIENT, "message length (%zu) exceeds maximum possible message length (%d)", len, TLS_CHANNEL_BUF_SIZE);
+        return false;
+    }
+
+    if ((int)len > multi->acc_max_message_length)
+    {
+        msg(M_CLIENT, "header (%zu) + message size (%zu) length (%zu) exceeds "
+                      "maximum allowed length negotiated with peer (%d)",
+            max_header_size, strlen(acc_msg_payload), len,
+            multi->acc_max_message_length);
+        return false;
+    }
+
+    struct gc_arena gc = gc_new();
+    /* add 1 for the final \0 */
+    struct buffer buf = alloc_buf_gc(len + 1, &gc);
+
+    /* Example message: ACC,muppets,15,A,I am Miss Piggy */
+    buf_printf(&buf, "ACC,%s,%zu,%s%s,%s", protocol,
+               strlen(acc_msg_payload),
+               base64 ? "6" : "A",
+               fragment ? "F" : "",
+               acc_msg_payload);
+
+    bool ret = send_control_channel_string_dowork(session, BSTR(&buf), D_PUSH);
+    reschedule_multi_process(c);
+    gc_free(&gc);
+    return ret;
+}
+
+char *
+parse_acc_parameters(const char *capabilities,
+                     const char *delim,
+                     int *max_acc_len,
+                     bool server,
+                     struct gc_arena *gc)
+{
+    char *tmp_message = string_alloc(capabilities, NULL);
+    char *tmp_message_orig = tmp_message;
+    char *lasts = NULL;
+
+    const char *token = strtok_r(tmp_message, delim, &lasts);
+
+    int p = 0;
+    int acclen = 0;
+    const char *protocols = NULL;
+    char *ret = NULL;
+
+    /* In server mode we allow more capabilities than our own, in client
+     * mode we reject if we should use capabilities that we do not support */
+    int allowed_acc_len = server ? INT_MAX : ACC_MAX_MSG_LEN;
+
+    while (token)
+    {
+        if (p == 0 && !atoi_constrained(token, &acclen, "ACC message length", ACC_MIN_MSG_LEN, allowed_acc_len, D_PUSH_ERRORS))
+        {
+            goto done;
+        }
+
+        if (p == 1 && (!tls_item_in_cipher_list("A", token) || !tls_item_in_cipher_list("6", token)))
+        {
+            msg(D_PUSH_ERRORS, "App custom control encoding must include base64 and ascii");
+            goto done;
+        }
+
+        if (p == 1 && !server && strcmp(token, "A:6") && strcmp(token, "6:A"))
+        {
+            msg(D_PUSH_ERRORS, "App custom control encoding must be exactly base64 and ascii");
+            goto done;
+        }
+
+        if (p == 2)
+        {
+            protocols = token;
+        }
+
+        if (p == 3)
+        {
+            msg(D_PUSH_ERRORS, "Too many parameters for INFO ACC message/IV_ACC.");
+            goto done;
+        }
+
+        token = strtok_r(NULL, delim, &lasts);
+        p++;
+    }
+
+    *max_acc_len = min_int(acclen, ACC_MAX_MSG_LEN);
+    ret = string_alloc(protocols, gc);
+
+done:
+    free(tmp_message_orig);
+    return ret;
+}
+
+struct buffer
+get_list_intersection(struct gc_arena *gc, const char *list1, const char *list2)
+{
+    char *tmp = string_alloc(list1, NULL);
+    char *lasts = NULL;
+    const char *token = strtok_r(tmp, ":", &lasts);
+
+    /* The maximum possible length is the shorter of the two input lists */
+    size_t max_len = min_size(strlen(list1), strlen(list2));
+
+    struct buffer common_protocols = alloc_buf_gc(max_len + 1, gc);
+
+    while (token)
+    {
+        /* check for every items is in both lists and not already in the
+         * common list */
+        if (tls_item_in_cipher_list(token, list2)
+            && !tls_item_in_cipher_list(token, buf_cstr(&common_protocols)))
+        {
+            if (buf_len(&common_protocols) > 0)
+            {
+                buf_write_u8(&common_protocols, ':');
+            }
+            buf_printf(&common_protocols, "%s", token);
+        }
+        token = strtok_r(NULL, ":", &lasts);
+    }
+    free(tmp);
+    return common_protocols;
+}
+
+void
+determine_common_acc_protocols(struct tls_multi *multi, struct tls_session *session)
+{
+    if (!multi->opt.acc_protocols)
+    {
+        /* No app custom protocols have been configured server-side. */
+        return;
+    }
+
+    if (multi->acc_negotiated_protocols)
+    {
+        /* We already have determined the common protocols. */
+        return;
+    }
+
+    struct gc_arena gc = gc_new();
+
+    /* example IV_ACC: IV_ACC=2048,6:A,flower:power */
+    const char *peer_info = multi->peer_info;
+    const char *iv_acc = extract_var_peer_info(peer_info, "IV_ACC=", &gc);
+    if (!iv_acc)
+    {
+        gc_free(&gc);
+        return;
+    }
+
+    int max_acc_len = 0;
+    const char *protocols = parse_acc_parameters(iv_acc, ",", &max_acc_len, true, &gc);
+
+    if (!protocols)
+    {
+        gc_free(&gc);
+        msg(D_PUSH_ERRORS, "WARNING: IV_ACC peer info variable of peer is malformed");
+        return;
+    }
+
+    struct buffer common_protocols = get_list_intersection(&gc, multi->opt.acc_protocols, protocols);
+
+    if (buf_len(&common_protocols) == 0)
+    {
+        msg(D_PUSH_DEBUG, "WARNING: No common app custom control protocol.");
+        gc_free(&gc);
+        return;
+    }
+
+    multi->acc_negotiated_protocols = string_alloc(buf_str(&common_protocols), NULL);
+    multi->acc_max_message_length = max_acc_len;
+
+    setenv_str(session->opt->es, "acc_protocols", multi->acc_negotiated_protocols);
+    setenv_int(session->opt->es, "acc_message_len", multi->acc_max_message_length);
+
+    gc_free(&gc);
+}
+
+void
+notify_client_acc_protocols(struct tls_multi *multi)
+{
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        msg(M_CLIENT, ">ACC_PROTOCOLS:protocols=%s,message_len=%d",
+            multi->acc_negotiated_protocols, multi->acc_max_message_length);
+    }
+#endif
+}
diff --git a/src/openvpn/acc.h b/src/openvpn/acc.h
new file mode 100644
index 0000000..9c99b11
--- /dev/null
+++ b/src/openvpn/acc.h
@@ -0,0 +1,130 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn.net>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549.org>
+ *
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
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef ACC_H
+#define ACC_H
+
+#include "openvpn.h"
+
+#define ACC_MIN_MSG_LEN 64
+#define ACC_MAX_MSG_LEN 1280
+
+/**
+ * This method parses an app custom control message and delivers it to the
+ * management interface. We leave reassembly of fragmented messages to the
+ * management interface.
+ *
+ * @param c            The context struct
+ * @param buffer       Buffer containing the control message with ACC
+ */
+void
+receive_acc_message(struct context *c, const struct buffer *buffer);
+
+bool
+send_acc_message(struct context *c,
+                 struct tls_multi *tls_multi,
+                 struct tls_session *session,
+                 const char *protocol, bool fragment,
+                 const char *msg, bool base64);
+
+
+/**
+ * Parses an info message from the server that contains app custom control info
+ * information prior to the PUSH_REPLY to be able to use app custom control
+ * protocols before sending
+ *
+ * In client mode only allow what we support ourselves. In server mode
+ * allow also capabilities that we not support ourselves.
+ *
+ * @param capabilities      The string to parse
+ * @param delim             The delimiter to use when parsing the string.
+ *                          IV_ACC uses "," as delimiter while the
+ *                          custom-control PUSH message uses " " as "," is
+ *                          already used to separate different push directives
+ * @param max_acc_len       Set to the maximum ACC message length
+ * @param server            Whether we are server or client
+ * @param gc                The gc arena to use for allocating the resulting string
+ * @return                  The resulting protocol string or NULL on error
+ */
+char *
+parse_acc_parameters(const char *capabilities,
+                     const char *delim,
+                     int *max_acc_len,
+                     bool server,
+                     struct gc_arena *gc);
+
+/**
+ * Parses the IV_ACC of the peer and sets multi.acc_negotiated_protocols
+ * to the common protocols of server and client and
+ * multi.acc_max_message_length  to the maximum length of the ACC message
+ * support by both server and client.
+ *
+ * If there is no common protocol or the client does not support any app custom
+ * protocol multi.acc_negotiated_protocols will be set to NULL.
+ *
+ * @param multi      the multi instance to use the set the app custom protocols.
+ * @param session    the session to read the client env from
+ */
+void
+determine_common_acc_protocols(struct tls_multi *multi, struct tls_session *session);
+
+/**
+ * Flags returned by the parse_acc_message_flags method
+ */
+enum acc_message_flag
+{
+    ACC_MESSAGE_FLAGS_ASCII = 1,
+    ACC_MESSAGE_FLAGS_BASE64 = 2,
+    ACC_MESSAGE_FLAGS_FRAGMENT = 4,
+};
+
+/**
+ *  Parses the flags field of an app control message If there is an
+ *  error parsing the flags field the method returns -1 and
+ *  puts the error reason in err_reason
+ */
+int
+parse_acc_message_flags(const char *flags, const char **err_reason, struct gc_arena *gc);
+
+/**
+ * Calculates the intersection of two list that are both separated by :
+ * Items in the result will have the same ordering as in the list1
+ * parameters
+ * @param gc            Returned buffer will be allocated in this gc
+ * @param list1         First list to intersect
+ * @param list2         Second list to intersect.
+ * @return A (potentially empty) buffer containing an intersection list
+ */
+struct buffer
+get_list_intersection(struct gc_arena *gc, const char *list1, const char *list2);
+
+/**
+ * Notifies a client via management interface of the negotiated app
+ * custom protocols
+ * @param multi the tls_multi instance of the connection
+ */
+void
+notify_client_acc_protocols(struct tls_multi *multi);
+#endif
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 681210d..eb41d03 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -42,6 +42,7 @@
 #include "dco.h"
 #include "auth_token.h"
 #include "tun_afunix.h"
+#include "acc.h"
 
 #include "memdbg.h"
 
@@ -257,11 +258,11 @@
     }
     else if (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        server_pushed_info(buf, 8);
+        peer_pushed_info(c, buf, 8);
     }
     else if (buf_string_match_head_str(buf, "INFO"))
     {
-        server_pushed_info(buf, 4);
+        peer_pushed_info(c, buf, 4);
     }
     else if (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
@@ -271,6 +272,10 @@
     {
         receive_auth_pending(c, buf);
     }
+    else if (buf_string_match_head_str(buf, "ACC"))
+    {
+        receive_acc_message(c, buf);
+    }
     else if (buf_string_match_head_str(buf, "EXIT"))
     {
         receive_exit_message(c);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1b8b2a5..e0b99a4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -56,6 +56,7 @@
 #include "schedule.h"
 #include "options_string.h"
 #include "resolve.h"
+#include "acc.h"
 
 #include "memdbg.h"
 
@@ -2279,6 +2280,13 @@
         }
     }
 
+    struct tls_multi *multi = c->c2.tls_multi;
+    if (multi && multi->acc_negotiated_protocols)
+    {
+        buf_printf(&out, " custom-control %d A:6 %s",
+                   multi->acc_max_message_length, multi->acc_negotiated_protocols);
+    }
+
     if (BLENZ(&out) > strlen(header))
     {
         msg(D_HANDSHAKE, "%s", BSTR(&out));
@@ -2522,6 +2530,11 @@
         flags |= (OPT_P_ROUTE | OPT_P_DHCPDNS);
     }
 
+    if (c->options.acc_protocols)
+    {
+        flags |= OPT_P_ACC;
+    }
+
     return flags;
 }
 
@@ -2730,6 +2743,18 @@
         frame->tun_mtu = min_int(frame->tun_max_mtu, c->options.ce.tun_mtu);
     }
 
+    if (found & OPT_P_ACC && c->options.pushed_acc_negotiated_protocols)
+    {
+        struct tls_multi *multi = c->c2.tls_multi;
+        free(multi->acc_negotiated_protocols);
+        multi->acc_negotiated_protocols = string_alloc(c->options.pushed_acc_negotiated_protocols, NULL);
+        multi->acc_max_message_length = c->options.pushed_acc_max_message_length;
+
+        msg(D_PUSH, "OPTIONS IMPORT: ACC protocols: %s, msg len: %d",
+            multi->acc_negotiated_protocols, multi->acc_max_message_length);
+        notify_client_acc_protocols(multi);
+    }
+
     return true;
 }
 
@@ -3352,6 +3377,7 @@
     to.verify_hash_depth = options->verify_hash_depth;
     to.verify_hash_no_ca = options->verify_hash_no_ca;
     memcpy(to.x509_username_field, options->x509_username_field, sizeof(to.x509_username_field));
+    to.acc_protocols = options->acc_protocols;
     to.es = c->c2.es;
     to.net_ctx = &c->net_ctx;
 
@@ -4306,6 +4332,24 @@
 }
 #endif /* ifdef TARGET_ANDROID */
 
+static bool
+management_acc_msg(void *arg,
+                   struct buffer_list *input) /* ownership transferred */
+{
+    struct context *c = arg;
+
+    bool ret = false;
+    if (buffer_list_defined(input) && c->c2.tls_multi)
+    {
+        struct tls_multi *multi = c->c2.tls_multi;
+        struct tls_session *session = &multi->session[TM_ACTIVE];
+
+        ret = management_send_acc_message(c, multi, session, input);
+    }
+
+    buffer_list_free(input);
+    return ret;
+}
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 void
@@ -4322,6 +4366,7 @@
         cb.proxy_cmd = management_callback_proxy_cmd;
         cb.remote_cmd = management_callback_remote_cmd;
         cb.send_cc_message = management_callback_send_cc_message;
+        cb.acc_msg = management_acc_msg;
 #ifdef TARGET_ANDROID
         cb.network_change = management_callback_network_change;
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index ac3d4b7..aff8146 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -45,9 +45,11 @@
 #include "push.h"
 #include "multi.h"
 #include "resolve.h"
+#include "acc.h"
 
 #include "memdbg.h"
 #include "run_command.h"
+#include "ssl_ncp.h"
 
 #ifdef ENABLE_PKCS11
 #include "pkcs11.h"
@@ -1081,6 +1083,35 @@
             }
             break;
 
+        case IEC_CLIENT_ACC_MSG:
+            if (man->persist.callback.client_acc_msg)
+            {
+                bool status = (*man->persist.callback.client_acc_msg)(man->persist.callback.arg,
+                                                                      man->connection.in_extra_cid,
+                                                                      man->connection.in_extra_kid,
+                                                                      man->connection.in_extra);
+                man->connection.in_extra = NULL;
+                report_command_status(status, "client-acc-msg");
+            }
+            else
+            {
+                man_command_unsupported("client-acc-msg");
+            }
+            break;
+
+        case IEC_ACC_MSG:
+            if (man->persist.callback.acc_msg)
+            {
+                bool status = (*man->persist.callback.acc_msg)(man->persist.callback.arg,
+                                                               man->connection.in_extra);
+                man->connection.in_extra = NULL;
+                report_command_status(status, "acc-msg");
+            }
+            else
+            {
+                man_command_unsupported("acc-msg");
+            }
+            break;
         case IEC_PK_SIGN:
             man->connection.ext_key_state = EKS_READY;
             buffer_list_free(man->connection.ext_key_input);
@@ -1205,6 +1236,29 @@
 }
 
 static void
+man_client_acc_msg(struct management *man, const char *cid_str,
+                   const char *kid_str)
+{
+    struct man_connection *mc = &man->connection;
+    mc->in_extra_cid = 0;
+    mc->in_extra_kid = 0;
+    if (parse_cid(cid_str, &mc->in_extra_cid)
+        && parse_uint(kid_str, "KID", &mc->in_extra_kid))
+    {
+        mc->in_extra_cmd = IEC_CLIENT_ACC_MSG;
+        in_extra_reset(mc, IER_NEW);
+    }
+}
+
+static void
+man_acc_msg(struct management *man)
+{
+    struct man_connection *mc = &man->connection;
+    mc->in_extra_cmd = IEC_ACC_MSG;
+    in_extra_reset(mc, IER_NEW);
+}
+
+static void
 man_client_auth(struct management *man, const char *cid_str, const char *kid_str, const bool extra)
 {
     struct man_connection *mc = &man->connection;
@@ -1759,6 +1813,17 @@
             man_client_pending_auth(man, p[1], p[2], p[3], p[4]);
         }
     }
+    else if (streq(p[0], "client-acc-msg"))
+    {
+        if (man_need(p, 2, 0))
+        {
+            man_client_acc_msg(man, p[1], p[2]);
+        }
+    }
+    else if (streq(p[0], "acc-msg"))
+    {
+        man_acc_msg(man);
+    }
     else if (streq(p[0], "rsa-sig"))
     {
         man_pk_sig(man, "rsa-sig");
@@ -2975,7 +3040,9 @@
                                        "bytes_sent=",
                                        "bytes_received=",
                                        "session_id=",
-                                       "session_state=" };
+                                       "session_state=",
+                                       "acc_protocols=",
+                                       "acc_message_len=" };
 
     if (env_filter_level == 0)
     {
@@ -3130,6 +3197,7 @@
     }
 }
 
+
 void
 management_connection_established(struct management *man, struct man_def_auth_context *mdac,
                                   const struct env_set *es)
@@ -4372,6 +4440,58 @@
     }
 }
 
+bool
+management_send_acc_message(struct context *c, struct tls_multi *multi, struct tls_session *session,
+                            struct buffer_list *input)
+{
+    /* also ensures that are enough inputs in the list to safely call
+     * buffer_list_peek without extra NULL checks */
+    if (!input || input->size < 3)
+    {
+        msg(M_CLIENT, "not enough input lines for sending acc message, "
+                      "missing protocol, flag and/or messages lines");
+        return false;
+    }
+
+    struct gc_arena gc = gc_new();
+
+    const struct buffer *proto_buf = buffer_list_peek(input);
+    const char *protocol = string_alloc(CBSTR(proto_buf), &gc);
+    buffer_list_pop(input);
+
+    const struct buffer *encoding_buf = buffer_list_peek(input);
+
+    const char *acc_err_reason = NULL;
+    int acc_flags = parse_acc_message_flags(buf_cstr(encoding_buf), &acc_err_reason, &gc);
+    if (acc_flags < 0)
+    {
+        msg(M_CLIENT, "ERROR: parsing acc message flags failed: %s", acc_err_reason);
+        goto error;
+    }
+
+    buffer_list_pop(input);
+
+    buffer_list_aggregate_separator(input, 10000, "");
+    const struct buffer *acc_msg_buf = buffer_list_peek(input);
+
+    if (!multi->acc_negotiated_protocols
+        || !tls_item_in_cipher_list(protocol, multi->acc_negotiated_protocols))
+    {
+        msg(M_CLIENT, "ERROR: protocol not in the list of negotiated protocols: %s",
+            np(multi->acc_negotiated_protocols));
+        goto error;
+    }
+
+    bool ret = send_acc_message(c, multi, session, protocol,
+                                acc_flags & ACC_MESSAGE_FLAGS_FRAGMENT,
+                                buf_cstr(acc_msg_buf),
+                                acc_flags & ACC_MESSAGE_FLAGS_BASE64);
+    gc_free(&gc);
+    return ret;
+error:
+    gc_free(&gc);
+    return false;
+}
 #else /* ifdef ENABLE_MANAGEMENT */
 
 #include "win32.h"
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 157039d..cc9c264 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -184,12 +184,19 @@
     int (*n_clients)(void *arg);
     bool (*send_cc_message)(void *arg, const char *message, const char *parameter);
     bool (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);
+
     bool (*client_auth)(void *arg, const unsigned long cid, const unsigned int mda_key_id,
                         const bool auth, const char *reason, const char *client_reason,
                         struct buffer_list *cc_config); /* ownership transferred */
     bool (*client_pending_auth)(void *arg, const unsigned long cid, const unsigned int kid,
                                 const char *extra, unsigned int timeout);
     char *(*get_peer_info)(void *arg, const unsigned long cid);
+    bool (*client_acc_msg)(void *arg,
+                           const unsigned long cid,
+                           const unsigned int mda_key_id,
+                           struct buffer_list *msg);
+    bool (*acc_msg)(void *arg,
+                    struct buffer_list *msg);
     bool (*proxy_cmd)(void *arg, const char **p);
     bool (*remote_cmd)(void *arg, const char **p);
 #ifdef TARGET_ANDROID
@@ -292,13 +299,15 @@
     struct command_line *in;
     struct buffer_list *out;
 
-#define IEC_UNDEF       0
-#define IEC_CLIENT_AUTH 1
+#define IEC_UNDEF          0
+#define IEC_CLIENT_AUTH    1
 /* #define IEC_CLIENT_PF   2 *REMOVED FEATURE* */
-#define IEC_RSA_SIGN    3
-#define IEC_CERTIFICATE 4
-#define IEC_PK_SIGN     5
-#define IEC_PASSWORD    6
+#define IEC_RSA_SIGN       3
+#define IEC_CERTIFICATE    4
+#define IEC_PK_SIGN        5
+#define IEC_PASSWORD       6
+#define IEC_CLIENT_ACC_MSG 7
+#define IEC_ACC_MSG        8
     int in_extra_cmd;
     struct buffer_list *in_extra;
     unsigned long in_extra_cid;
@@ -503,6 +512,14 @@
 
 void man_persist_client_stats(struct management *man, struct context *c);
 
+/** Parses the ACC message from the input buffer_list and send to the
+ * session identified by session and multi
+ */
+struct tls_session;
+struct tls_multi;
+bool
+management_send_acc_message(struct context *c, struct tls_multi *multi,
+                            struct tls_session *session, struct buffer_list *input);
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e302a81..a3eb3ca 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -53,6 +53,7 @@
 #include "ssl_util.h"
 #include "dco.h"
 #include "reflect_filter.h"
+#include "acc.h"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -4085,6 +4086,26 @@
     }
 }
 
+static const char *
+calculate_app_control_extra(struct multi_instance *mi, struct gc_arena *gc)
+{
+    struct context *c = &mi->context;
+    struct tls_multi *multi = c->c2.tls_multi;
+
+    if (!multi->acc_negotiated_protocols)
+    {
+        msg(M_CLIENT, "ACC: No negotiated protocols");
+        return NULL;
+    }
+
+    struct buffer buf = alloc_buf_gc(1024, gc);
+
+    buf_printf(&buf, "ACC:%d A:6 %s", multi->acc_max_message_length,
+               multi->acc_negotiated_protocols);
+    return buf_str(&buf);
+}
+
+
 static bool
 management_client_pending_auth(void *arg, const unsigned long cid, const unsigned int mda_key_id,
                                const char *extra, unsigned int timeout)
@@ -4095,10 +4116,22 @@
     if (mi)
     {
         struct tls_multi *multi = mi->context.c2.tls_multi;
+
+        struct gc_arena gc = gc_new();
+        if (!strcmp(extra, "ACC"))
+        {
+            extra = calculate_app_control_extra(mi, &gc);
+            if (!extra)
+            {
+                gc_free(&gc);
+                return false;
+            }
+        }
         struct tls_session *session = lookup_session_by_mda_key_id(multi, mda_key_id);
 
         if (!session)
         {
+            gc_free(&gc);
             return false;
         }
 
@@ -4106,6 +4139,7 @@
         bool ret = send_auth_pending_messages(multi, session, extra, timeout);
         reschedule_multi_process(&mi->context);
         multi_schedule_context_wakeup(m, mi);
+        gc_free(&gc);
         return ret;
     }
     return false;
@@ -4149,6 +4183,37 @@
     return ret;
 }
 
+
+static bool
+management_client_acc_msg(void *arg,
+                          const unsigned long cid,
+                          const unsigned int mda_key_id,
+                          struct buffer_list *input) /* ownership transferred */
+{
+    struct multi_context *m = (struct multi_context *)arg;
+    struct multi_instance *mi = lookup_by_cid(m, cid);
+
+    bool ret = false;
+    if (mi && buffer_list_defined(input))
+    {
+        struct tls_multi *multi = mi->context.c2.tls_multi;
+        struct tls_session *session = lookup_session_by_mda_key_id(multi, mda_key_id);
+        if (!session)
+        {
+            msg(M_CLIENT, "client session not found");
+            buffer_list_free(input);
+            return false;
+        }
+
+        ret = management_send_acc_message(&mi->context, multi, session, input);
+        multi_schedule_context_wakeup(m, mi);
+    }
+
+    buffer_list_free(input);
+    return ret;
+}
+
+
 static char *
 management_get_peer_info(void *arg, const unsigned long cid)
 {
@@ -4185,6 +4250,7 @@
         cb.n_clients = management_callback_n_clients;
         cb.kill_by_cid = management_kill_by_cid;
         cb.client_auth = management_client_auth;
+        cb.client_acc_msg = management_client_acc_msg;
         cb.client_pending_auth = management_client_pending_auth;
         cb.get_peer_info = management_get_peer_info;
         cb.push_update_broadcast = management_callback_send_push_update_broadcast;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fb319ae..a5e7396 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -35,6 +35,7 @@
 
 #include "syshead.h"
 
+#include "acc.h"
 #include "buffer.h"
 #include "error.h"
 #include "common.h"
@@ -2552,6 +2553,8 @@
     o->push_option_types_found = 0;
     o->push_update_options_found = 0;
     o->imported_protocol_flags = 0;
+    o->pushed_acc_max_message_length = 0;
+    o->pushed_acc_negotiated_protocols = NULL;
 }
 
 static void
@@ -7107,6 +7110,47 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->force_key_material_export = true;
     }
+    else if (streq(p[0], "app-custom-control") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        if (!string_class(p[1], CC_ALNUM | CC_COLON | CC_UNDERBAR | CC_DASH, 0))
+        {
+            msg(msglevel, "App custom control protocols must only contain "
+                          "alphanumeric characters, '-', and '_'.");
+            goto err;
+        }
+        options->acc_protocols = p[1];
+    }
+    else if (streq(p[0], "custom-control") && p[1] && p[2] && p[3] && !p[4])
+    {
+        VERIFY_PERMISSION(OPT_P_ACC);
+
+        /* check if the list from the server is a real subset of our list */
+        struct gc_arena gc_local = gc_new();
+        struct buffer common_list = get_list_intersection(&gc_local, p[3], options->acc_protocols);
+
+        if (buf_len(&common_list) == 0 || !streq(p[3], buf_cstr(&common_list)))
+        {
+            msg(msglevel, "App custom control list from server contains "
+                          "unsupported protocols");
+            gc_free(&gc_local);
+            goto err;
+        }
+        gc_free(&gc_local);
+
+        if (!streq(p[2], "6:A") && !streq(p[2], "A:6"))
+        {
+            msg(msglevel, "App custom control encoding must be base64 and ascii");
+            goto err;
+        }
+
+        if (!atoi_constrained(p[1], &options->pushed_acc_max_message_length,
+                              "app custom message message length", ACC_MIN_MSG_LEN, ACC_MAX_MSG_LEN, msglevel))
+        {
+            goto err;
+        }
+        options->pushed_acc_negotiated_protocols = p[3];
+    }
     else if (streq(p[0], "prng") && p[1] && !p[3])
     {
         msg(M_WARN, "NOTICE: --prng option ignored (SSL library PRNG is used)");
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6a3bf61..b7945e0 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -715,6 +715,18 @@
     /* force using TLS key material export for data channel key generation */
     bool force_key_material_export;
 
+    /** The app custom control protocols we should announce as supported */
+    const char *acc_protocols;
+
+    /** the protocols that are negotiated with the peer. This is a
+     *  a temporary variable since options.c push parser cannot access
+     *  tls multi struct */
+    const char *pushed_acc_negotiated_protocols;
+
+    /** the maximum length of an ACC control channel message via push message
+     * */
+    int pushed_acc_max_message_length;
+
     bool vlan_tagging;
     enum vlan_acceptable_frames vlan_accept;
     uint16_t vlan_pvid;
@@ -764,8 +776,10 @@
 #define OPT_P_INLINE          (1u << 29)
 #define OPT_P_PUSH_MTU        (1u << 30)
 #define OPT_P_ROUTE_TABLE     (1u << 31)
+#define OPT_P_ACC             (1ull << 32)
 
-#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | 0x0ull))
+/* Options allowed in the normal configuration file (vs pushed options or in ccd files) */
+#define OPT_P_DEFAULT (~(OPT_P_INSTANCE | OPT_P_PULL_MODE | OPT_P_PEER_ID | OPT_P_ACC))
 
 #define PULL_DEFINED(opt) ((opt)->pull)
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 42259c3..a18f33b 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -27,6 +27,8 @@
 #include "syshead.h"
 
 #include "push.h"
+
+#include "acc.h"
 #include "options.h"
 #include "crypto.h"
 #include "ssl.h"
@@ -221,9 +223,56 @@
 #endif
 }
 
+static void
+parse_server_pushed_info_acc(struct context *c, struct buffer *buf)
+{
+    int max_acc_len = 0;
+    struct tls_multi *multi = c->c2.tls_multi;
+
+    if (multi->acc_negotiated_protocols)
+    {
+        return;
+    }
+
+    if (!multi->opt.acc_protocols || !c->options.pull)
+    {
+        msg(D_PUSH_ERRORS, "Peer tried to push app custom control list "
+                           "without client announcing support for it");
+        return;
+    }
+
+    /* example string to parse: ACC:1400 A:6 flower:happy */
+    /* Skip over the ACC: prefix */
+    buf_advance(buf, 4);
+
+    struct gc_arena gc = gc_new();
+    const char *protocols = parse_acc_parameters(buf_cstr(buf), " ", &max_acc_len, false, &gc);
+    if (!protocols)
+    {
+        msg(D_PUSH_ERRORS, "WARNING: Received ACC info command with invalid parameters");
+        gc_free(&gc);
+        return;
+    }
+
+    /* check if the list from the server is a real subset of our list */
+    struct buffer common_list = get_list_intersection(&gc, protocols, multi->opt.acc_protocols);
+
+    if (buf_len(&common_list) == 0 || !streq(protocols, buf_cstr(&common_list)))
+    {
+        msg(D_PUSH_ERRORS, "App custom control list from server contains "
+                           "unsupported protocols");
+        gc_free(&gc);
+        return;
+    }
+
+    multi->acc_negotiated_protocols = string_alloc(protocols, NULL);
+    multi->acc_max_message_length = max_acc_len;
+    notify_client_acc_protocols(multi);
+    gc_free(&gc);
+}
 
 void
-server_pushed_info(const struct buffer *buffer, const int adv)
+peer_pushed_info(struct context *c, const struct buffer *buffer, const int adv)
 {
     const char *m = "";
     struct buffer buf = *buffer;
@@ -233,6 +282,12 @@
         m = BSTR(&buf);
     }
 
+    if (strncmp(m, "ACC:", 4) == 0)
+    {
+        parse_server_pushed_info_acc(c, &buf);
+        return;
+    }
+
 #ifdef ENABLE_MANAGEMENT
     struct gc_arena gc;
     if (management)
@@ -257,7 +312,7 @@
         gc_free(&gc);
     }
 #endif
-    msg(D_PUSH, "Info command was pushed by server ('%s')", m);
+    msg(D_PUSH, "Info command was pushed by peer ('%s')", m);
 }
 
 void
@@ -285,6 +340,7 @@
     msg(D_PUSH, "CR response was sent by client ('%s')", m);
 }
 
+
 /**
  * Parse the keyword for the AUTH_PENDING request
  * @param buffer                buffer containing the keywords, the buffer's
@@ -441,7 +497,6 @@
     const char *const peer_info = tls_multi->peer_info;
     unsigned int proto = extract_iv_proto(peer_info);
 
-
     /* Calculate the maximum timeout and subtract the time we already waited */
     unsigned int max_timeout =
         max_uint(tls_multi->opt.renegotiate_seconds / 2, tls_multi->opt.handshake_window);
@@ -732,6 +787,12 @@
                 client_max_mtu, o->ce.tun_mtu, o->ce.tun_mtu);
         }
     }
+
+    if (tls_multi->acc_negotiated_protocols)
+    {
+        push_option_fmt(gc, push_list, M_USAGE, "custom-control %d A:6 %s",
+                        tls_multi->acc_max_message_length, tls_multi->acc_negotiated_protocols);
+    }
 }
 
 static bool
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 39302f6..e08cd66 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -52,6 +52,7 @@
 
 int process_incoming_push_request(struct context *c);
 
+
 /**
  * @brief Handles the receiving of a push-update message and applies updates to the specified
  * options.
@@ -92,7 +93,15 @@
 
 void receive_exit_message(struct context *c);
 
-void server_pushed_info(const struct buffer *buffer, const int adv);
+/**
+ * This message is called when an INFO or INFO_PRE message is received from
+ * a peer.
+ *
+ * @param c         Context of the peer.
+ * @param buffer    Buffer containing the INFO/INFO_PRE message.
+ * @param adv       number of character to advance past the INFO/INFO_PRE header
+ */
+void peer_pushed_info(struct context *c, const struct buffer *buffer, const int adv);
 
 void receive_cr_response(struct context *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 086a6fc..97ef9b0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -55,6 +55,7 @@
 
 #include "crypto_epoch.h"
 #include "ssl.h"
+#include "acc.h"
 #include "ssl_verify.h"
 #include "ssl_backend.h"
 #include "ssl_ncp.h"
@@ -1279,6 +1280,7 @@
     free(multi->locked_cn);
     free(multi->locked_username);
     free(multi->locked_original_username);
+    free(multi->acc_negotiated_protocols);
 
     cert_hash_free(multi->locked_cert_hash_set);
 
@@ -2098,6 +2100,11 @@
 #endif
         }
 
+        if (session->opt->acc_protocols)
+        {
+            buf_printf(&out, "IV_ACC=%d,A:6,%s\n", ACC_MAX_MSG_LEN, session->opt->acc_protocols);
+        }
+
         if (session->opt->push_peer_info_detail > 1)
         {
             struct env_set *es = session->opt->es;
@@ -2398,6 +2405,8 @@
         multi->remote_ciphername = string_alloc("none", NULL);
     }
 
+    determine_common_acc_protocols(multi, session);
+
     if (username_len < 0 || password_len < 0)
     {
         msg(D_TLS_ERRORS, "TLS Error: Username (%d) or password (%d) too long", abs(username_len),
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9a55ead..436770b 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -457,6 +457,9 @@
     size_t ekm_size;
 
     bool dco_enabled; /**< Whether keys have to be installed in DCO or not */
+
+    /** The app custom control protocols we should announce as supported */
+    const char *acc_protocols;
 };
 
 /** @addtogroup control_processor
@@ -730,6 +733,12 @@
     int dco_peer_id;
 
     dco_context_t *dco;
+
+    /** the protocols that are negotiated with the peer. */
+    char *acc_negotiated_protocols;
+
+    /** the maximum length of an ACC control channel message */
+    int acc_max_message_length;
 };
 
 /**  gets an item  of \c key_state objects in the
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 43a6743..6a73e1e 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -107,10 +107,12 @@
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS = @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
 ssl_testdriver_SOURCES = test_ssl.c \
+	test_acc.c test_acc.h \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_management.c \
 	mock_ssl_dependencies.c mock_win32_execve.c \
 	$(top_srcdir)/src/compat/compat-strlcpy.c \
+	$(top_srcdir)/src/openvpn/acc.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -132,6 +134,7 @@
 	$(top_srcdir)/src/openvpn/run_command.c \
 	$(top_srcdir)/src/openvpn/ssl_openssl.c \
 	$(top_srcdir)/src/openvpn/ssl_mbedtls.c \
+	$(top_srcdir)/src/openvpn/ssl_ncp.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c \
 	$(top_srcdir)/src/openvpn/ssl_verify_mbedtls.c \
 	$(top_srcdir)/src/openvpn/ssl_verify_openssl.c \
diff --git a/tests/unit_tests/openvpn/mock_management.c b/tests/unit_tests/openvpn/mock_management.c
index fff4c2b..f572dbb 100644
--- a/tests/unit_tests/openvpn/mock_management.c
+++ b/tests/unit_tests/openvpn/mock_management.c
@@ -29,6 +29,7 @@
 
 #include "syshead.h"
 
+#include <stdlib.h>
 #include "manage.h"
 
 #ifdef ENABLE_MANAGEMENT
diff --git a/tests/unit_tests/openvpn/mock_push_dependencies.c b/tests/unit_tests/openvpn/mock_push_dependencies.c
index bf2ccf3..f083f89 100644
--- a/tests/unit_tests/openvpn/mock_push_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_push_dependencies.c
@@ -43,7 +43,8 @@
     uint64_t flags = OPT_P_UP | OPT_P_ROUTE_EXTRAS | OPT_P_SOCKBUF | OPT_P_SOCKFLAGS
                      | OPT_P_SETENV | OPT_P_SHAPER | OPT_P_TIMER | OPT_P_COMP | OPT_P_PERSIST
                      | OPT_P_MESSAGES | OPT_P_EXPLICIT_NOTIFY | OPT_P_ECHO | OPT_P_PULL_MODE
-                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS;
+                     | OPT_P_PEER_ID | OPT_P_NCP | OPT_P_PUSH_MTU | OPT_P_ROUTE | OPT_P_DHCPDNS
+                     | OPT_P_ACC;
     return flags;
 }
 
diff --git a/tests/unit_tests/openvpn/test_acc.c b/tests/unit_tests/openvpn/test_acc.c
new file mode 100644
index 0000000..9364d12
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc.c
@@ -0,0 +1,353 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@openvpn.net>
+ *  Copyright (C) 2025 Arne Schwabe <arne@rfc2549.org>
+ *
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
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "acc.h"
+#include "test_acc.h"
+#include "test_common.h"
+
+#include "mock_msg.h"
+#include "multi.h"
+
+char control_channel_message_sent[2048];
+
+/* Mock functions */
+bool
+send_control_channel_string_dowork(struct tls_session *session,
+                                   const char *str, unsigned int msglevel)
+{
+    assert_int_in_range(strlen(str), 0, 2047);
+
+    strcpy(control_channel_message_sent, str);
+    return true;
+}
+
+void
+send_push_reply_auth_token(struct tls_multi *multi)
+{
+}
+
+void
+auth_set_client_reason(struct tls_multi *multi, const char *reason)
+{
+}
+
+#define MSG_PAYLOAD "FgMBARkBAAEVAwNanUalkEDDxLBpZw9JnjI3tBM"                \
+                    "r4engpg/cDgS48DMaxyCdbzofNjQJU9Y0DD66z/notFT0cF1d60nTS" \
+                    "4md4OJwoQAwEwITAxMBwCzAMACfzKnMqMyqwCvALwCewCTAKABrwCP" \
+                    "AJwBnwArAFAA5wAnAEwAzAQAAnP8BAAEAAAsABAMAAQIACgAWABQAH" \
+                    "QAXAB4AGQAYAQABAQECAQMBBAAWAAAAFwAAAA0AMAAuBAMFAwYDCAc" \
+                    "ICAgaCBsIHAgJCAoICwgECAUIBgQBBQEGAQMDAwEDAgQCBQIGAgArA" \
+                    "AUEAwQDAwAtAAIBAQAzACYAJAAdACCk4Tz2PB/2FsxOfOIV4gn/NyJ" \
+                    "93rQwityP9eKSijXgcQ=="
+
+void
+test_acc_parse_client_messages(void **state)
+{
+#ifndef ENABLE_MANAGEMENT
+    skip();
+#else
+    /* ensure that the messages get to mock_msg */
+    x_debug_level = 3;
+    management = (void *)0x12345678;
+    struct gc_arena gc = gc_new();
+
+    /* contains a TLS 1.3 ClientHello */
+    const char msg[] = "ACC,cck1,384,6," MSG_PAYLOAD;
+
+    struct buffer msg_buf;
+    struct context c = { 0 };
+    c.options.mode = MODE_SERVER;
+
+    ALLOC_OBJ_CLEAR_GC(c.c2.tls_multi, struct tls_multi, &gc);
+
+    c.c2.tls_multi->session[TM_ACTIVE].opt = &c.c2.tls_multi->opt;
+    c.c2.tls_multi->session[TM_ACTIVE].opt->mda_context = &c.c2.mda_context;
+    buf_set_read(&msg_buf, (void *)msg, sizeof(msg));
+
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "WARNING: Received malformed custom app control channel message (ACC not enabled or no negotiated protocols): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more...]");
+    assert_string_equal(mock_managment_buf, "");
+
+    c.c2.tls_multi->acc_negotiated_protocols = "no:common:protocol";
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "WARNING: Received malformed custom app control channel message (protocol 'cck1' not in list of negotiated protocols 'no:common:protocol'): 4143432c 63636b31 2c333834 2c362c46 674d4241 526b4241 41455641 774e616[more...]");
+    assert_string_equal(mock_managment_buf, "");
+
+    c.c2.tls_multi->acc_negotiated_protocols = "cck1:flower:power:fortune";
+    receive_acc_message(&c, &msg_buf);
+
+    assert_string_equal(mock_msg_buf, "Received custom app control message (protocol 'cck1')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,cck1,0," MSG_PAYLOAD);
+
+    const char flower_msg[] = "ACC,flower,48,6,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA==";
+    buf_set_read(&msg_buf, (void *)flower_msg, sizeof(flower_msg));
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom app control message (protocol 'flower')");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,flower,0,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA==");
+
+    CLEAR(mock_managment_buf);
+    const char msg_incorrect_len[] = "ACC,fortune,62,6,InsgIm1lIjogImZyb2ciLCAAeGZm/SJtc2ciOiAiSSBhbSAAS2VybWl0IiB9Ig==";
+    buf_set_read(&msg_buf, (void *)msg_incorrect_len, sizeof(msg_incorrect_len));
+    receive_acc_message(&c, &msg_buf);
+    const char *error = "WARNING: Received malformed custom app control channel "
+                        "message (field length 62, payload length 64 mismatch): "
+                        "4143432c 666f7274 756e652c 36322c36 2c496e73 67496d31 "
+                        "6c496a6f 67496d5[more...]";
+
+    assert_string_equal(mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+    CLEAR(mock_managment_buf);
+    const char msg_fragment[] = "ACC,power,12,6F,aGVsbG8gdw==";
+    buf_set_read(&msg_buf, (void *)msg_fragment, sizeof(msg_fragment));
+    receive_acc_message(&c, &msg_buf);
+    assert_string_equal(mock_msg_buf, "Received custom app control message (protocol 'power', fragment)");
+    assert_string_equal(mock_managment_buf, ">CLIENT:ACC,0,0,power,1,aGVsbG8gdw==");
+
+    CLEAR(mock_managment_buf);
+    /* check two encoding present */
+    const char flower_msg_two_encs[] = "ACC,flower,48,6A,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA==";
+    buf_set_read(&msg_buf, (void *)flower_msg_two_encs, sizeof(flower_msg_two_encs));
+    receive_acc_message(&c, &msg_buf);
+
+    error = "WARNING: Received malformed custom app control channel message "
+            "(number of encodings must be exactly one (B64=1, ASCII=1)): "
+            "4143432c 666c6f77 65722c34 382c3641 2c535342 68625341 41494574 "
+            "6c636d3[more...]";
+
+    assert_string_equal(mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+    /* no encoding present */
+    const char flower_msg_no_encs[] = "ACC,flower,48,,SSBhbSAAIEtlcm1pdCD//SB0aGUg77+94oCPZnJvZyEAAA==";
+    buf_set_read(&msg_buf, (void *)flower_msg_no_encs, sizeof(flower_msg_no_encs));
+    receive_acc_message(&c, &msg_buf);
+
+    error = "WARNING: Received malformed custom app control channel message "
+            "(number of encodings must be exactly one (B64=0, ASCII=0)): "
+            "4143432c 666c6f77 65722c34 382c2c53 53426862 53414149 45746c63 "
+            "6d31706[more...]";
+    assert_string_equal(mock_msg_buf, error);
+    assert_string_equal(mock_managment_buf, "");
+
+    x_debug_level = 0;
+    management = NULL;
+    gc_free(&gc);
+#endif
+}
+
+void
+test_parse_acc_parameters(void **state)
+{
+    struct gc_arena gc = gc_new();
+    /* parameters to INFO message */
+    const char *info_acc_msg = "4096 A:6 flower:happy";
+
+    int max_len = 0;
+    const char *protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1280);
+
+    /* a client does not accept a length longer than it supports */
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+    /* message with lower limit than our, should work for client and server */
+    info_acc_msg = "1111 A:6 flower:happy";
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1111);
+
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1111);
+
+    /* more encodings than supported. Server should be okay, client should fail */
+    info_acc_msg = "1200 A:6:B flower:happy";
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy");
+    assert_int_equal(max_len, 1200);
+
+    /* extra parameter */
+    info_acc_msg = "1400 A:6 flower:happy 77";
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, false, &gc);
+    assert_null(protocols);
+
+
+    const char *iv_acc_capabilities = "1400,A:6,flower:happy:power";
+    protocols = parse_acc_parameters(iv_acc_capabilities, ",", &max_len, true, &gc);
+    assert_string_equal(protocols, "flower:happy:power");
+
+    /* too small protocol length */
+    info_acc_msg = "32 A:6 flower:happy";
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    /* non-numerical protocol length */
+    info_acc_msg = "abff A:6 flower:happy";
+    protocols = parse_acc_parameters(info_acc_msg, " ", &max_len, true, &gc);
+    assert_null(protocols);
+
+    gc_free(&gc);
+}
+
+void
+test_acc_common_protocols(void **state)
+{
+    struct multi_instance mi = { 0 };
+    struct context *c = &mi.context;
+    c->options.gc = gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2.tls_multi, struct tls_multi, &c->options.gc);
+
+    c->c2.tls_multi->peer_info = "IV_PROTO=4321\nIV_ACC=1400,A:6,flower:happy:power";
+    c->options.acc_protocols = "power:flower:star";
+    struct tls_multi *multi = c->c2.tls_multi;
+    multi->opt.acc_protocols = c->options.acc_protocols;
+    multi->session[TM_ACTIVE].opt = &multi->opt;
+    multi->opt.es = env_set_create(&c->options.gc);
+
+    determine_common_acc_protocols(multi, &c->c2.tls_multi->session[TM_ACTIVE]);
+
+    assert_int_equal(multi->acc_max_message_length, ACC_MAX_MSG_LEN);
+    assert_string_equal(multi->acc_negotiated_protocols, "power:flower");
+
+    assert_string_equal(env_set_get(multi->opt.es, "acc_protocols"), "acc_protocols=power:flower");
+    assert_string_equal(env_set_get(multi->opt.es, "acc_message_len"), "acc_message_len=1280");
+
+    free(multi->acc_negotiated_protocols);
+    gc_free(&c->options.gc);
+}
+
+void
+test_acc_send_message(void **state)
+{
+    struct multi_instance mi = { 0 };
+    struct context *c = &mi.context;
+    c->options.gc = gc_new();
+
+    ALLOC_OBJ_CLEAR_GC(c->c2.tls_multi, struct tls_multi, &c->options.gc);
+    bool ret;
+    struct tls_multi *multi = c->c2.tls_multi;
+    c->options.acc_protocols = "power:flower:emergency";
+    multi->opt.acc_protocols = c->options.acc_protocols;
+    multi->session[TM_ACTIVE].opt = &multi->opt;
+    multi->opt.es = env_set_create(&c->options.gc);
+
+    c->c2.tls_multi->peer_info = "IV_PROTO=4321\nIV_ACC=1400,A:6,flower:emergency:power";
+    determine_common_acc_protocols(multi, &c->c2.tls_multi->session[TM_ACTIVE]);
+
+    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+
+    ret = send_acc_message(c, c->c2.tls_multi, session, "emergency", true,
+                           "EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:", false);
+
+    assert_true(ret);
+    assert_string_equal(control_channel_message_sent,
+                        "ACC,emergency,50,AF,EMERGENCY BROADCAST MESSAGE - THIS IS NOT A DRILL:");
+
+    ret = send_acc_message(c, c->c2.tls_multi, session, "emergency", false,
+                           "THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA.", false);
+    assert_true(ret);
+    assert_string_equal(control_channel_message_sent,
+                        "ACC,emergency,65,A,THE GOVERNMENT HAS ISSUED A RAINBOW COLOURED ALERT FOR YOUR AREA.");
+
+
+    /* test a long message (> 1000) with fragment to get the maximum header size */
+    char long_message[1200] = { 0 };
+
+    for (int i = 0; i < 1024; i++)
+    {
+        long_message[i] = (char)(' ' + (i % 95));
+    }
+
+    /* last char of the message is a i and then a \0 */
+    assert_int_equal(long_message[1023], 'i');
+    assert_int_equal(long_message[1024], '\0');
+
+    ret = send_acc_message(c, c->c2.tls_multi, session, "emergency", true,
+                           long_message, false);
+
+    assert_true(ret);
+    size_t cc_len = strlen(control_channel_message_sent);
+    assert_int_equal(control_channel_message_sent[cc_len - 1], 'i');
+    const char *expected_start_cc = "ACC,emergency,1024,AF, !\"#$%&'()*+,-./012345";
+    assert_memory_equal(control_channel_message_sent, expected_start_cc, strlen(expected_start_cc));
+
+    free(multi->acc_negotiated_protocols);
+    gc_free(&c->options.gc);
+}
+
+void
+test_list_intersection(void **state)
+{
+    const char *empty = "";
+    const char *protos = "power:flower:emergency";
+
+    struct gc_arena gc = gc_new();
+
+    struct buffer t1 = get_list_intersection(&gc, empty, protos);
+    assert_int_equal(buf_len(&t1), 0);
+
+    struct buffer t2 = get_list_intersection(&gc, protos, empty);
+    assert_int_equal(buf_len(&t2), 0);
+
+    struct buffer t3 = get_list_intersection(&gc, protos, protos);
+    assert_string_equal(buf_cstr(&t3), protos);
+
+    const char *protos2 = "flower:emergency:power:mario";
+    struct buffer t4 = get_list_intersection(&gc, protos2, protos);
+    assert_string_equal(buf_cstr(&t4), "flower:emergency:power");
+
+    const char *protos3 = "super:paper:mario:flower";
+    struct buffer t5 = get_list_intersection(&gc, protos2, protos3);
+    assert_string_equal(buf_cstr(&t5), "flower:mario");
+
+    const char *proto4 = "flower:flower:flower:flower";
+    struct buffer t6 = get_list_intersection(&gc, proto4, "flower");
+    assert_string_equal(buf_cstr(&t6), "flower");
+
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_acc.h b/tests/unit_tests/openvpn/test_acc.h
new file mode 100644
index 0000000..32421fb
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_acc.h
@@ -0,0 +1,35 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
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
+
+#ifndef TEST_ACC_H
+#define TEST_ACC_H
+void test_acc_parse_client_messages(void **state);
+
+void test_parse_acc_parameters(void **state);
+
+void test_acc_common_protocols(void **state);
+
+void test_acc_send_message(void **state);
+
+void test_list_intersection(void **state);
+#endif
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h
index 8db4ea6..c865142 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -43,11 +43,13 @@
 #define LargestIntegralType uintmax_t
 #endif
 /* redefine 2.x API in terms of 1.x API */
-#define CMockaValueData             LargestIntegralType
-#define check_expected_uint         check_expected
-#define expect_uint_value           expect_value
-#define expect_check_data           expect_check
-#define cast_ptr_to_cmocka_value(x) (x)
+#define CMockaValueData                       LargestIntegralType
+#define check_expected_uint                   check_expected
+#define expect_uint_value                     expect_value
+#define expect_check_data                     expect_check
+#define cast_ptr_to_cmocka_value(x)           (x)
+#define assert_int_in_range(value, min, max)  assert_in_range((value), (min), (max))
+#define assert_uint_in_range(value, min, max) assert_in_range((value), (min), (max))
 #endif
 
 /**
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 4baf8cc..4987dd0 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -52,6 +52,8 @@
 #include "ssl_verify.h"
 #include "openvpn.h"
 
+#include "test_acc.h"
+
 /* Mock function to be allowed to include win32.c which is required for
  * getting the temp directory */
 #ifdef _WIN32
@@ -86,6 +88,20 @@
 {
     return;
 }
+void
+reschedule_multi_process(struct context *c)
+{
+}
+
+/* Define a dummy dco cipher option to avoid linking against all the DCO
+ * units */
+#if defined(ENABLE_DCO)
+const char *
+dco_get_supported_ciphers(void)
+{
+    return "AES-192-GCM:AES-128-CBC:AES-256-GCM:AES-128-GCM:CHACHA20-POLY1305";
+}
+#endif
 
 /* generated using
  * openssl req -x509 -newkey ec -pkeyopt ec_paramgen_curve:secp384r1 -keyout - \
@@ -1111,8 +1127,12 @@
         cmocka_unit_test(ssl_test_extract_last_matching_field),
         cmocka_unit_test(ssl_test_reject_null_in_cert_subject),
         cmocka_unit_test(ssl_test_escape_rfc_2253_chars_in_subject),
-        cmocka_unit_test(ssl_test_extract_peer_info)
-
+        cmocka_unit_test(ssl_test_extract_peer_info),
+        cmocka_unit_test(test_acc_parse_client_messages),
+        cmocka_unit_test(test_parse_acc_parameters),
+        cmocka_unit_test(test_acc_common_protocols),
+        cmocka_unit_test(test_acc_send_message),
+        cmocka_unit_test(test_list_intersection)
     };
 
 #if defined(ENABLE_CRYPTO_OPENSSL)


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
