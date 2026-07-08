Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758AAC43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  8 Jul 2026 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HxWY1gxb0l1U2Bvjar0fIZFbLIxVsLmXdpr1b7d52o4=; b=i6X81QniwNy/Xa5S4iT4zocklj
	dEXn3eo+coNeZ1QenqizrWJYDfhuI/AVnL8zSdaZAeB+Esup6AO+rwcfsorSybyiOJ5jvjChNPjs5
	QRr588EHT1bTv//zEOh+s+EWPdrgNIwsJt/QSjpTPB60RrY/v2kTstEBDeKGi8WwWNrw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1whXST-0004dZ-F1;
	Wed, 08 Jul 2026 18:57:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1whXSF-0004ca-Vk
 for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 18:57:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DrO3qyrbBRK8RxlHrhLI580Q2XUOcLOV32ACP/DG0FE=; b=bL8/MA8Po6eyOG/94WGG38meHU
 gd3oCwtHL+i60YhJi1gmTmaEjG2DJvO0hpWUxiEmx55BQ5vKxtrrk6SYgpqHSiwLv20/0Cp9MgnCX
 QoMlOYOI3MhATXMHKyFeqKi1ZhIrhIhcwNevURZzWzdKI3mrEURF+uLo73U54T3V7eMg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=DrO3qyrbBRK8RxlHrhLI580Q2XUOcLOV32ACP/DG0FE=; b=hallWgCI60AFDTvdiC+/MbKdJG
 ypo2aCcPfCVHr3rhlEfUKoMgIkAOgeDci5ZdNdYwdsvh75VR6bkv7tuN9PaJpVmXBVenKMCUC0Wpl
 UW6fH/+6eYCoamG3AmoTvJ6P+tffnqwPRLz8TIUpQLk+ClRr7uH5Oe80dX5LO8/5V7l8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whXSF-0005Uf-4O for openvpn-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 18:57:08 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 668Iuxjg010260
 for <openvpn-devel@lists.sourceforge.net>; Wed, 8 Jul 2026 20:56:59 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 668Iux2B010256
 for openvpn-devel@lists.sourceforge.net; Wed, 8 Jul 2026 20:56:59 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  8 Jul 2026 20:56:53 +0200
Message-ID: <20260708185659.10219-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
References: <gerrit.1782500411000.I6595695ab6401047d498d530f8739686880bea3a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1whXSF-0005Uf-4O
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
