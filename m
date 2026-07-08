Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AC5C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HxWY1gxb0l1U2Bvjar0fIZFbLIxVsLmXdpr1b7d52o4=; b=jdu+X60uErktsOyq/w3oOlY5IA
	gSNpQfVWm7t+CNJBaXy/xrJ201bDEmvRZqzAK2rTYIFb8m+j1Y5ZVaO6RtCjCGRGTEhBN7kyVKJ28
	HDhZ50pjICaYaWOEg8BK4U824xi8pTh5JGDacX0Tz1t+zj1r/ij3FdlTYnmE9jsR1r1s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whUEF-0005TK-PN;
	Wed, 08 Jul 2026 15:30:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1whUE9-0005Rt-8s
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:30:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DrO3qyrbBRK8RxlHrhLI580Q2XUOcLOV32ACP/DG0FE=; b=apE+YJ/xAT3vFHJAZ+Z9RmLXlw
 VQxhHsXsVWmDsKA4NPhddc6yZpOSDn45DIzz/glaLdFsTM7a1C5gH0SDjBaVSPlLHzIVRoSROa3Tn
 t78gi5VihUWvU3PN/Xo0Y7aSWu19tXqd9KeGsdT5krf3OhcebSHvCY7N+0rarRLo/BiE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DrO3qyrbBRK8RxlHrhLI580Q2XUOcLOV32ACP/DG0FE=; b=UzlwyHUUAanOSFzPZnnfoxK6yC
 gjGAH7JoqbBXiYoLj8QfbHRzimTRm8gAaeouAkcREw7p0DztYOZrWutwaUgNOZrhkiYh7F9PYV/IG
 LteEmGiZvRLobd4GkMdZP96eLDb+Gl1UKChwdYFtPwjBcZ6sYC2tDYljgWHBqIFKNu2I=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whUDu-0007Yp-6L for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 15:30:07 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gwMTr5wmZzMlMd;
 Wed, 08 Jul 2026 17:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1783524592;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DrO3qyrbBRK8RxlHrhLI580Q2XUOcLOV32ACP/DG0FE=;
 b=Nos8AXYxKHHgzNC6HUvHKN1OZOIqoYUEJJ1nLKWtn7YnU6eyW2lzykbvOtUAXWGUSV3YNZ
 V1pCn4EBT8AXuV7hx4uhE2pl9EPAxvROxlMBe4LGt31XXUvoTad8wrNBrQNNY/YdvgciW0
 qYgiscVmlhWqCq6hPykLD1WdjtmAKVXem1HmYMpgJhV55ibO/g9jiv0/rzY3HiZwjpGhGN
 tXfM6SXK9PPxRcKL7o/QmHXLF5DNONxcALM4t55cdj7x9Yk/niUFJRv6hbpVueyFqszoPx
 UaYb1bY/3MBL8lkaU/IOWBxYEnYIzmwCIvo0xk/nFHEpUW+xy03es8p++ECAAg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  8 Jul 2026 17:29:51 +0200
Message-ID: <20260708152951.60515-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
References: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4gwMTr5wmZzMlMd
X-Headers-End: 1whUDu-0007Yp-6L
Subject: [Openvpn-devel] [PATCH v2] mingw: avoid C99 "hh" scanf length
 modifier
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

From: Heiko Hund <heiko@ist.eigentlich.net>

read_key_file() and parse_hexstring() parse hex bytes with sscanf()
using the C99 "hh" length modifier, storing directly into an octet.

This is not portable to the legacy MSVCRT runtime that Ubuntu
resolute's (26.04) mingw toolchain links against.

Scan into an unsigned int and cast to the octet instead. The field width
caps the value at 0xFF, so the narrowing cast cannot lose data.

Change-Id: I6595695ab6401047d498d530f8739686880bea3a
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1733
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1733
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 3d79fe5..ee43d65 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1473,9 +1473,9 @@
                     hex_byte[hb_index++] = c;
                     if (hb_index == 2)
                     {
-                        uint8_t u;
-                        ASSERT(sscanf((const char *)hex_byte, "%" SCNx8, &u) == 1);
-                        *out++ = u;
+                        unsigned int u;
+                        ASSERT(sscanf((const char *)hex_byte, "%2x", &u) == 1);
+                        *out++ = (uint8_t)u;
                         hb_index = 0;
                         if (++count == keylen)
                         {
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index bf80bbd..0f95ab7 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -169,10 +169,12 @@
             break;
         }
 
-        if (!isxdigit(p[0]) || !isxdigit(p[1]) || sscanf(p, "%2hhx", &arr[i++]) != 1)
+        unsigned int b;
+        if (!isxdigit(p[0]) || !isxdigit(p[1]) || sscanf(p, "%2x", &b) != 1)
         {
             return 0;
         }
+        arr[i++] = (unsigned char)b;
     }
     return i;
 }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
