Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF21606A320
	for <openvpn-devel@archiver.kernel.org>; Sat, 21 Nov 2026 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NvxoeC0B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UtBKCXl5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jpD4otDw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ICNJx9nt2Gus31E3fdsRIuPzNMTXC3pi9OhH3dJITJg=; b=NvxoeC0BqtsOLm
	nQWMOfUspeiYLLYcM5cBtVmgj60dH4iUqIpaTeiM4yOgO1WmCYOOYRlLI2Ea0v1o1Dul1s6931L/y
	DxDrzg6gLDgvCRROzWyr7SsLKoofKg/lHpPjp3Te8g0w3PBraA/yFGLd8JaMsYdg5Sf8sCrs1mWAU
	6vY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUjN9-000000004Bm-18Pp;
	Sat, 21 Nov 2026 11:35:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xUjMu-000000004Ai-0ThP for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 11:34:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=32VtfRY2jS7SUioW/+g23pFZaU60XWhJpIQ9Rucip2o=; b=UtBKCXl5Y6e82JhWTftliFa/c+
 uYJsAtViBVbyjY36SDYI0nTlf4K39XLEMjv9KLPoAtc3Qaqge9trAhyAfafyEMPcWVUxcDBAufq0U
 SW6/HTAGsABG5Kf8slw03aWYaSmEHtCGs0jSKz8vq2JW1Fuz7ENtuFb8r+5RvLmB+V2I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=32VtfRY2jS7SUioW/+g23pFZaU60XWhJpIQ9Rucip2o=; b=jpD4otDwbcB0A9mMVI1do5z5VE
 K3kDzqkStiAEmGc4QDreUEYF74ytPv7bHzcI1KVzONNbcrFQ6MsS8RlkkvqXuKCPqcR0SLEWWqVBm
 HRFx9X5Ak7RiI2VhyGB4DoEOAkFs3XJQoqdVwL9rHC57QF/ZYO8sZbh0bnwD97B/yKWo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUjMs-000000004lh-0sjz for openvpn-devel@lists.sourceforge.net;
 Sat, 21 Nov 2026 11:34:56 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ALBYlTa006842
 for <openvpn-devel@lists.sourceforge.net>; Sat, 21 Nov 2026 12:34:47 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ALBYlR9006841
 for openvpn-devel@lists.sourceforge.net; Sat, 21 Nov 2026 12:34:47 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 21 Nov 2026 12:34:41 +0100
Message-ID: <20261121113446.6828-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795179338000.Ie074a6f52589f9bb3c0c98b95def5e8115a7c621@gerrit.openvpn.net>
References: <gerrit.1795179338000.Ie074a6f52589f9bb3c0c98b95def5e8115a7c621@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xUjMs-000000004lh-0sjz
Subject: [Openvpn-devel] [PATCH v1] Remove orphaned ring_buffer.h and
 ffdhe2048.pem
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
X-Spam-Status: No, score=-21.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Razvan Cojocaru <razvanc@mailbox.org>

ring_buffer.h was deleted with Wintun support in ad7a6945 but came back
with the clang-format reformat in 3cca3367. Nothing includes it. Also
drop the unused TUN_IOCTL_REGISTER_RINGS define in interactive.c.

ffdhe2048.pem was added for the t_server_null tests in b60ba20c, which
switched to --dh none in 494fb718. Nothing references it.

Change-Id: Ie074a6f52589f9bb3c0c98b95def5e8115a7c621
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2230
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2230
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@ist.eigentlich.net>

        
diff --git a/sample/sample-keys/ffdhe2048.pem b/sample/sample-keys/ffdhe2048.pem
deleted file mode 100644
index 9b182b7..0000000
--- a/sample/sample-keys/ffdhe2048.pem
+++ /dev/null
@@ -1,8 +0,0 @@
------BEGIN DH PARAMETERS-----
-MIIBCAKCAQEA//////////+t+FRYortKmq/cViAnPTzx2LnFg84tNpWp4TZBFGQz
-+8yTnc4kmz75fS/jY2MMddj2gbICrsRhetPfHtXV/WVhJDP1H18GbtCFY2VVPe0a
-87VXE15/V8k1mE8McODmi3fipona8+/och3xWKE2rec1MKzKT0g6eXq8CrGCsyT7
-YdEIqUuyyOP7uWrat2DX9GgdT0Kj3jlN9K5W7edjcrsZCwenyO4KbXCeAvzhzffi
-7MA0BM0oNC9hkXL+nOmFg/+OTxIy7vKBg8P+OxtMb61zO7X8vC7CIAXFjvGDfRaD
-ssbzSibBsu/6iGtCOGEoXJf//////////wIBAg==
------END DH PARAMETERS-----
diff --git a/src/openvpn/ring_buffer.h b/src/openvpn/ring_buffer.h
deleted file mode 100644
index aebcd9c..0000000
--- a/src/openvpn/ring_buffer.h
+++ /dev/null
@@ -1,124 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn.net>
- *                2019 Lev Stipakov <lev@openvpn.net>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-#ifdef _WIN32
-#ifndef OPENVPN_RING_BUFFER_H
-#define OPENVPN_RING_BUFFER_H
-
-#include <windows.h>
-#include <winioctl.h>
-
-#include <stdint.h>
-#include <stdbool.h>
-
-/*
- * Values below are taken from Wireguard Windows client
- * https://github.com/WireGuard/wireguard-go/blob/master/tun/wintun/ring_windows.go#L14
- */
-#define WINTUN_RING_CAPACITY       0x800000
-#define WINTUN_RING_TRAILING_BYTES 0x10000
-#define WINTUN_MAX_PACKET_SIZE     0xffff
-#define WINTUN_PACKET_ALIGN        4
-
-#define TUN_IOCTL_REGISTER_RINGS \
-    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
-
-/**
- * Wintun ring buffer
- * See https://github.com/WireGuard/wintun#ring-layout
- */
-struct tun_ring
-{
-    volatile ULONG head;
-    volatile ULONG tail;
-    volatile LONG alertable;
-    UCHAR data[WINTUN_RING_CAPACITY + WINTUN_RING_TRAILING_BYTES];
-};
-
-/**
- * Struct for ring buffers registration
- * See https://github.com/WireGuard/wintun#registering-rings
- */
-struct tun_register_rings
-{
-    struct
-    {
-        ULONG ring_size;
-        struct tun_ring *ring;
-        HANDLE tail_moved;
-    } send, receive;
-};
-
-struct TUN_PACKET_HEADER
-{
-    uint32_t size;
-};
-
-struct TUN_PACKET
-{
-    uint32_t size;
-    UCHAR data[WINTUN_MAX_PACKET_SIZE];
-};
-
-/**
- * Registers ring buffers used to exchange data between
- * userspace openvpn process and wintun kernel driver,
- * see https://github.com/WireGuard/wintun#registering-rings
- *
- * @param device              handle to opened wintun device
- * @param send_ring           pointer to send ring
- * @param receive_ring        pointer to receive ring
- * @param send_tail_moved     event set by wintun to signal openvpn
- *                            that data is available for reading in send ring
- * @param receive_tail_moved  event set by openvpn to signal wintun
- *                            that data has been written to receive ring
- * @return                    true if registration is successful, false otherwise - use
- * GetLastError()
- */
-static inline bool
-register_ring_buffers(HANDLE device, struct tun_ring *send_ring, struct tun_ring *receive_ring,
-                      HANDLE send_tail_moved, HANDLE receive_tail_moved)
-{
-    struct tun_register_rings rr;
-    BOOL res;
-    DWORD bytes_returned;
-
-    ZeroMemory(&rr, sizeof(rr));
-
-    rr.send.ring = send_ring;
-    rr.send.ring_size = sizeof(struct tun_ring);
-    rr.send.tail_moved = send_tail_moved;
-
-    rr.receive.ring = receive_ring;
-    rr.receive.ring_size = sizeof(struct tun_ring);
-    rr.receive.tail_moved = receive_tail_moved;
-
-    res = DeviceIoControl(device, TUN_IOCTL_REGISTER_RINGS, &rr, sizeof(rr), NULL, 0,
-                          &bytes_returned, NULL);
-
-    return res != FALSE;
-}
-
-#endif /* ifndef OPENVPN_RING_BUFFER_H */
-#endif /* ifdef _WIN32 */
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 354fe09..6bd679f 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -55,9 +55,6 @@
 static HANDLE rdns_semaphore = NULL;
 #define RDNS_TIMEOUT 600 /* seconds to wait for the semaphore */
 
-#define TUN_IOCTL_REGISTER_RINGS \
-    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_DATA)
-
 openvpn_service_t interactive_service = { interactive, _L(PACKAGE_NAME) L"ServiceInteractive",
                                           _L(PACKAGE_NAME) L" Interactive Service",
                                           SERVICE_DEPENDENCIES, SERVICE_AUTO_START };


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
