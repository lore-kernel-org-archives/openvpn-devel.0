Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5DADC5DF7D
	for <openvpn-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yC38FF+7ItIaQPJJ4xinNWGrjtW5B06jQiRrcET3MX0=; b=N+8e62P+y9n8Q5kDRQ1vIwBZPS
	H27RNPkUBDeaxdeaOEMkvCpGqyx0ekiMAoncvenwdeSVEIStybVQS+5/qGvxx/G+5oQ2T4/Jbf7SG
	s4l2J+VXox6czKFi/yRlYZn0dfqEaf+gNnfoMAGdowv/7lKn4j+jkGwhKSKcmCuF5FGs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwKid-0007Cv-Cd;
	Tue, 18 Aug 2026 14:23:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwKia-0007C7-Rr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:23:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2A3Egs8K6eYSRn4b0lath2ENyWOtz8WGeVSL3f/RBDE=; b=D/o5UtpSNgA/EYpqXTUwhl0q8v
 w6+K0uO5dv53vFlLBGZy7JqQWD0A4LeqZ+YE7SNzbY5WdPJnxnsHFH0haNm8Q0lohx8Qnm+7bev4x
 4hRirW71BB/5qDq9IJmOVTS6T+sUbIqpGM2gzNqGi0fq6oE0p9FX3FMJHFD0d6LFyupI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2A3Egs8K6eYSRn4b0lath2ENyWOtz8WGeVSL3f/RBDE=; b=HjhjSzktWkBy8o2AvVcLcE321s
 DlePgHXhD4iTaLiHfm7Lz3h/yM2kLkLhR5n9lzlCRpnLxV4cX9AjfAEhVhCxqX+G5K8EgwS2YaQK6
 lM0MiTwD7FDwmd4GJpeSP9viuASurepbJFkICFcTZBEjQutawZcce7JxwvGUR33NSGxw=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwKiR-000624-B0 for openvpn-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 14:23:00 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67IEMqvt027242
 for <openvpn-devel@lists.sourceforge.net>; Tue, 18 Aug 2026 16:22:52 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67IEMqFT027241
 for openvpn-devel@lists.sourceforge.net; Tue, 18 Aug 2026 16:22:52 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 18 Aug 2026 16:22:46 +0200
Message-ID: <20260818142252.27227-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
References: <gerrit.1786968495000.I450568c0307a6372506d115cb389d172472140d4@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwKiR-000624-B0
Subject: [Openvpn-devel] [PATCH v1] buffer: Remove some useless casts on
 BLAST returns
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

From: Frank Lichtenheld <frank@lichtenheld.com>

We can compare to '\0' without having to do casting.

Change-Id: I450568c0307a6372506d115cb389d172472140d4
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1845
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1845
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index bf38c68..87d3094 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -500,7 +500,7 @@
 void
 buf_null_terminate(struct buffer *buf)
 {
-    const char *last = (char *)BLAST(buf);
+    const uint8_t *last = BLAST(buf);
     if (last && *last == '\0') /* already terminated? */
     {
         return;
@@ -523,12 +523,12 @@
 {
     while (true)
     {
-        const char *last = (char *)BLAST(buf);
+        const uint8_t *last = BLAST(buf);
         if (!last)
         {
             break;
         }
-        if (char_class((unsigned char)*last, CC_CRLF | CC_NULL))
+        if (char_class(*last, CC_CRLF | CC_NULL))
         {
             if (!buf_inc_len(buf, -1))
             {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
