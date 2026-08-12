Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C6AC5B572
	for <openvpn-devel@archiver.kernel.org>; Wed, 12 Aug 2026 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZB/v7LrjJZV9fyhBXqvh5LmatPHMMzn6PIPgR7e5mzk=; b=VQVc16D6J60zz0ijNn8bN96W4u
	A/0zRALSqY0PNxPQjY6D5nuH6QaVjBM5uG2dlWRmhn5btZwt2zl4WKCX4UZanKHZdzSCL3cNtBlco
	OqP8t1dk/8Z77kNmcyzypXEeGoT172/dJMswC7SOfIv2mjPaLmwSK0L7SmsmotabJZRI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wu9aY-0001EO-Gi;
	Wed, 12 Aug 2026 14:05:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <razvanc@mailbox.org>) id 1wu9aW-0001EI-T1
 for openvpn-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 14:05:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JfrLHCPd+DqJrpambZAvNSTQ3N/8vtp0vyYTW2xCLfQ=; b=ET5a2pjWJdVkCLaYX8MInMd8Ht
 j6vY1icVSbzHvMMj3I/xoNBit/m3xFu2erOfbgEit/XpPBpwuXeq66E+JxZQ65M0wEcnYY/tsQ1eH
 htpqBDmuFZ3RCEawZRfx8z3u1t8488EDsO+9sUcqyTp/3KSi8fVhnw5Pt95ca+MogGkY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JfrLHCPd+DqJrpambZAvNSTQ3N/8vtp0vyYTW2xCLfQ=; b=c
 4GHW2fLVoPC/mUGPvYqByqRmbKxxGxYefm3kWt/hA/fVi1x6v98Fh1Eb1JGUqdrFBfmFIafvoDgf+
 YNE/vK9OfnSfPBh04onB5K9/kVczLpZ0JquHtVCc3TbDtjyE5gvrAeJ+U9Hdypjzy6f++6l6SsuCo
 kvwWzw3Nh0Ey5qj4=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wu9aV-0007hK-Te for openvpn-devel@lists.sourceforge.net;
 Wed, 12 Aug 2026 14:05:49 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hKqyX6rbpzKv7L
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 12 Aug 2026 16:05:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786543540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JfrLHCPd+DqJrpambZAvNSTQ3N/8vtp0vyYTW2xCLfQ=;
 b=gk4SU4E3QWfZVFC+P9JAsc4gmLknFkmPH6nwlCmRQNf2ZlLmsiv/7tt9kmYI+zj9nfN5GZ
 YK/vE62gbHsBuLcw3rS/R8wM88ZpxHUlA0aikA6ulIpWV0K5B8M6J201fsJq89J2glLSFQ
 arel7cJA2FG6sE/U/2DfyA4L/MpzRN7tqFlR/wdIzYXjUyN5gCXaFgGCfZvUYx2VJpg+Wt
 z6Ao6Z9qPt05P8SAuGWHThNpQNmJSVYrBQ3lCumqtsQVlRcC1j1LjIdpF3R4UiCQwe5EGW
 IedXX05cvxRs5enIBBipzqOQPpjLy6WlGuuYTv0+vfP1NMmn1DbyuBn1cjFJ0g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1786543539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=JfrLHCPd+DqJrpambZAvNSTQ3N/8vtp0vyYTW2xCLfQ=;
 b=t4idh6XroHS3EEeadPOTpfmRCY5SaGDWjvmJ2vvm8+qGcElo3YMHSd+fttQphJx4jb85ww
 jv0+LQKKcy4si/GteXtK5KJufjy80YKQAd6pfXH/fnwlRPeRFXMep2PGLZwrE8utcci77o
 L2pu4wxtHEKb5K+O2Iwb7NwnXnswmASeRkrFLtmlwbiXZ8TpfgAova8c5nSc4LC4ZzmmGT
 pQyUHUcjmwd93doIgY2hwcZF45xN8fa0pKZMHG2rKI2iu02w3frEObiWGIHCF3lMbWiuOW
 4Kiqn6Y4yfurDmS46XlWBdSHtmCjufZjqba79TLP47BggaQb/z8cZ0ybAsb7tQ==
To: openvpn-devel@lists.sourceforge.net
Date: Wed, 12 Aug 2026 17:05:15 +0300
Message-ID: <20260812140515.107442-1-razvanc@mailbox.org>
MIME-Version: 1.0
X-MBO-RS-META: rc8bti1f1rjuofotw5jguaort1pretg7
X-MBO-RS-ID: 7968f19fa37f150cf9d
X-Headers-End: 1wu9aV-0007hK-Te
Subject: [Openvpn-devel] [PATCH] buffer.h: Fix buf_substring_len()
 documentation
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
From: Razvan Cojocaru via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Reply-To: Razvan Cojocaru <razvanc@mailbox.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

The documentation added in 21ef7fa8 described neither the return value
nor the not-found case correctly: the count includes the delimiter, and
a missing delimiter yields -1 rather than the buffer length.

Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
---
 src/openvpn/buffer.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 74c84b29..85277ff8 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1605,17 +1605,17 @@ bool buf_string_match_head_str(const struct buffer *src, const char *match);
 bool buf_string_compare_advance(struct buffer *src, const char *match);
 
 /**
- * Return the length of the next token in a buffer up to a delimiter.
+ * Return the number of bytes in a buffer up to and including a delimiter.
  *
- * Scans the buffer content for \c delim and returns the number of bytes
- * up to (but not including) the delimiter, or the full buffer length if
- * the delimiter is not found.
+ * The count includes the delimiter byte, so it can be passed straight to
+ * \c buf_copy_excess() to split off a complete record, keeping the
+ * delimiter with it.
  *
  * @param buf    The buffer to scan.
  * @param delim  Delimiter byte to search for.
  *
- * @return Number of bytes before the first occurrence of \c delim, or -1
- *         if the buffer is empty.
+ * @return Byte count including the first \c delim, or -1 if the buffer
+ *         contains no \c delim.
  */
 int buf_substring_len(const struct buffer *buf, int delim);
 
-- 
2.55.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
