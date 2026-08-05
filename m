Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166B8C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pN052cMjn0DJCVluFTGIPulRHeA9ZRewCOLyN/8/VA4=; b=DUX5WeZW1zzZNQCbiLB6f05/Zu
	8NihQrh2lhqBTP+g6e0gXukcDT2KLsgIoLNOZOoYRaXhnM97LsZhjVDatSuCjfJFoe2dgPoWP1oIy
	rzSTnnMy2MeE0eSvim92IsHQRrU/RdL1PVVIDRQwOFcOs5laVT8Ass+MoGG+sG0R/Tbo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrbxz-0000kn-Rk;
	Wed, 05 Aug 2026 13:47:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wrbxz-0000kd-6w
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:47:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VotXnl+W0hc+eVLG2+k+HW60V49jekOnnhQVfaR1mlc=; b=jnxll1ksJjANwkVefUHNSn+xoN
 iAbqzcWDcLpV1cLjh6WTwdB55ZvGmQ3jhsPDtVngyCU5tFH068aC0I5SxnuCUNCDBfL0hhVIx2CCi
 Obh7df0gyDRwqbejbXDZ8DnrTkhuK7O4TLbTU7ijje6wq8rNGcOdt+St4y9Axn2anyJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VotXnl+W0hc+eVLG2+k+HW60V49jekOnnhQVfaR1mlc=; b=gWrEIScKpdED3AgVMSRA9YzXgC
 904GqZ56peKd30zNEhnlpQA867a+gvPU65C9PMzdjC7+AGy0s3EJgjL15uvtOkjB+8qe93U8z5kXq
 olnNlCgCcqGWVpcu428gd3a7Ok+H0MLpn0ICzlgjV84r7L8qvdCNXF3iHho3M0CsHfpE=;
Received: from mout-p-202.mailbox.org ([80.241.56.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrby0-00087H-Pu for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 13:47:31 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hFWtd01NFzMlMZ;
 Wed, 05 Aug 2026 15:47:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1785937641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VotXnl+W0hc+eVLG2+k+HW60V49jekOnnhQVfaR1mlc=;
 b=tL1jOcyJex4Ygl44CDfe02eA7Pb6VnKOjkvp8uF95Zpz+rnL8u1xN8pWMRjgPfmDVlNP5r
 AjcpXCrsgwSPN1u0QF1g/GqSq/oZkb0VH+1v8lxyF3Dav4iF2UX6P3WkulIB5+UTFnCUHQ
 SOz2CAupxQ1nQIPtSPAz4/UB/HkUmZvgn4S4E+p9tb2IZDaws6RqzHygZDorZ5OpOCErR7
 mUtVgLVTqVR3ZfwqKra3pYTVQ8hJbACqAIBQ5tHc0UAp7LpG4VMgVH0Teyx6kPqsDOhdsr
 84jKV0pCitglRFeVXZ+SlkRu6ngKzTX4zj8k4QtebfVENXcjqxSU5PXwGGTILQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  5 Aug 2026 15:47:19 +0200
Message-ID: <20260805134719.164126-1-frank@lichtenheld.com>
In-Reply-To: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
References: <gerrit.1785766260000.I3db70001be7f39cf84d562517647f1a305962b42@gerrit.openvpn.net>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4hFWtd01NFzMlMZ
X-Headers-End: 1wrby0-00087H-Pu
Subject: [Openvpn-devel] [PATCH v1] Remove local get_random in test_misc.c
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

From: Arne Schwabe <arne@rfc2549.org>

The get_random in test_misc.c conflicts
with the get_random function that OpenVPN defines in crypto.h
Also adjust the implementation in mock_get_random.c to match the
prototype in crypto.h

Change-Id: I3db70001be7f39cf84d562517647f1a305962b42
Signed-off-by: Arne Schwabe <arne@rfc2549.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1834
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1834
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
index 0840e31..5cb768b 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -28,7 +28,7 @@
 #include <stdint.h>
 #include <cmocka.h>
 
-unsigned long
+int64_t
 get_random(void)
 {
     /* rand() is not very random, but it's C99 and this is just for testing */
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 501286c..8da7abe 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -38,6 +38,7 @@
 #include "test_common.h"
 #include "list.h"
 #include "mock_msg.h"
+#include "crypto.h"
 #ifdef _WIN32
 #include "win32-util.h"
 #endif
@@ -141,13 +142,6 @@
     return strcmp((const char *)key1, (const char *)key2) == 0;
 }
 
-static uint32_t
-get_random(void)
-{
-    /* rand() is not very random, but it's C99 and this is just for testing */
-    return (uint32_t)rand();
-}
-
 static struct hash_element *
 hash_lookup_by_value(struct hash *hash, void *value)
 {
@@ -263,7 +257,7 @@
         {
             struct hash_iterator hi;
             struct hash_element *he;
-            inc = (get_random() % 3) + 1;
+            inc = ((uint32_t)get_random() % 3) + 1;
             hash_iterator_init_range(hash, &hi, base, base + inc);
 
             while ((he = hash_iterator_next(&hi)))


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
