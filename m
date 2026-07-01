Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD56C43458
	for <openvpn-devel@archiver.kernel.org>; Wed,  1 Jul 2026 18:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=L8Tr3akkNNzpnrf8NOOB6LZ5pGOnQhmO/WZB4dLnX/A=; b=ipRcnUS2uX/Kiyr/JaqkJKJIUB
	RrmHxNuoGGuFDvs/i5c5hYm4biONOStjvx6z5wLjFojJ+vgnbRk0ediz3HOVac+49K1ryEVt4Z5hw
	D74Sw/5t0+SlwfHUx8toeerC3ivTrhZwlnt+3mYpm2azq6EPuMQ3qaBpNZ8MlIyxNLgs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wezoC-0002ck-2o;
	Wed, 01 Jul 2026 18:37:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <matthias.andree@gmx.de>) id 1wezo6-0002cb-4r
 for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ny944puhnjyK8Y0mBI8Fd0DwH5v18QQixGuW8M/da4U=; b=CBJOtQUxOE+f1lN+bUIufU/atx
 V+D6d63k6Ac8xq1tMUgJmo2RCXndBequy6s9cEwOpzuSvLHCl10i4GRfFibaXxF5sTWpx8w89wRZT
 9VNGFiWyRal7c36fUJg5A/KssNFhoNKoypZv04INAbIGHiQFNeSkWYktCPbqjK+rYvBE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ny944puhnjyK8Y0mBI8Fd0DwH5v18QQixGuW8M/da4U=; b=m
 UsidzS+cTa7ik1gEbIfjq24un2q62B8fHkCHXEV7YoGCp93A+Mqzby6Dw7vJergDLJmTui2N7lvm4
 vvN+xorsRG/oIA0j8bsInGMLy57b49q7YuqKkKCATj9glH/VvJ1DbI5yaPViWVcXgxI7p41epmQJK
 svsOjI8Kxx407eQU=;
Received: from mout.gmx.net ([212.227.15.19])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wezo4-0004z7-0u for openvpn-devel@lists.sourceforge.net;
 Wed, 01 Jul 2026 18:37:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782931017; x=1783535817; i=matthias.andree@gmx.de;
 bh=ny944puhnjyK8Y0mBI8Fd0DwH5v18QQixGuW8M/da4U=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
 MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lrOT15Vdp76zBEYGCL6rQf3/fhnCksIPFLYuWHx2jK8B/rxTb+musITGDMm8rtBc
 k3GU6OXlaLb2fDMZ62pwV2mb5GzADXj5d83w2jFxxZvfGLuUA5Z5lkD/0wDJGrsqH
 ikK+v5I+cYH4ti2dbzTjuCrt0CxCRMqnj13P8NrKLWwIsEvrXZX0wPOPP8+OkP+dh
 QGBW3CqaiSMi7X1Wy2f/j/oi3I0A5pyS+1yfaGh0r6hPMWo+pBEp0w0xpDLYslBhr
 c0VjEa8FAonw+C84ju7hIKS8GUYgsf5zrWJDW1nA5jdKkMf2q3sU+GoKwXbcjtlPR
 Ok4To+9hw4A249obQg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MdvqW-1xDm7q3e46-00kwF8; Wed, 01
 Jul 2026 20:36:56 +0200
Received: by ryzen.an3e.de (Postfix, from userid 1000)
 id F3FAA4680F2C; Wed, 01 Jul 2026 20:36:55 +0200 (CEST)
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  1 Jul 2026 20:36:50 +0200
Message-ID: <20260701183650.29936-1-matthias.andree@gmx.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:TJxOU+fJIS5prUPgY72xbc8li5qXIscCgNAotiX059WcZ8nr4jD
 zhd7Dux6JRuhDkp/vLIgZ7sNTXjgJaQgJajNG1Iq5XpoA4g7Ab1UWdShWn/mVtJR/zRBx5r
 HrPWfX7svw0q+XsQpKnmjvnGwuIqwtIezfez2PhB5zkxl+M/4F8UzFk5S6XncnPQoE1LYZt
 K301VZ72LEjYJKSdFtk0Q==
UI-OutboundReport: notjunk:1;M01:P0:9R9hmTkbjr8=;TtMTBw+9zwn5DIYywThwK9I0/NU
 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
 hdBLbQ==
X-Headers-End: 1wezo4-0004z7-0u
Subject: [Openvpn-devel] [PATCH] Limit file size assignment to safe size_t
 range.
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
From: Matthias Andree via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Matthias Andree <matthias.andree@gmx.de>
Cc: Matthias Andree <matthias.andree@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Some operating systems (FreeBSD 14 on i386) have
sizeof(size_t) == 4 (which is used for object sizes)
sizeof(off_t)  == 8 (which is used for file sizes),
so assigning a file size obtained from stat to a size_t
causes justified compiler warnings about a narrowing
conversion.

It is safe to assume a 32-bit platform will not want
to load a >= 4 GB file there, so let's just ASSERT()
that the off_t we are about to assign fits into
a size_t object.

Signed-off-by: Matthias Andree <matthias.andree@gmx.de>
---
 src/openvpn/buffer.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 5f2b2338..4b6acb36 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1391,7 +1391,10 @@ buffer_read_from_file(const char *filename, struct gc_arena *gc)
         return ret;
     }
 
-    const size_t size = file_stat.st_size;
+    /* for some systems, off_t is 63 bits wide + sign bit and size_t is 32 bits
+     * wide, and we need to avoid negative garbage wrapping around */
+    ASSERT(file_stat.st_size >= 0 && file_stat.st_size <= SIZE_MAX);
+    const size_t size = (size_t)file_stat.st_size;
     ret = alloc_buf_gc(size + 1, gc); /* space for trailing \0 */
     size_t read_size = fread(BPTR(&ret), 1, size, fp);
     if (read_size == 0)
-- 
2.54.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
