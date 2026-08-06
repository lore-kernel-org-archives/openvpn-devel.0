Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C80C55ABF
	for <openvpn-devel@archiver.kernel.org>; Thu,  6 Aug 2026 11:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ty+36ocN55AA5KbpleBqsIp0ppGUHgfzHM2OlBf+ZCc=; b=jUjcJXkkoIPHg33gwIpfflW2P2
	Gc6HuSXCGaB5r3x43CdyjRtQV0Y3lvxndfV953d10ITKdz3QKuRhxCo70i39G8IgSjYxmDy81nmP/
	zFa7tFh+lWbnlVjnS9n29hRPhzdlbLcpgsJE43qfUndzNe6NTcuVXPeUaAbUt/cbzh+E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wrw2X-0003Rk-JN;
	Thu, 06 Aug 2026 11:13:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wrw2W-0003RZ-BI
 for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YX7h4g07VTrO5X1VbMqaMgQU+UlEG6u/S0zf8vgw36o=; b=eIjOt/n14+1Cf2XJBf/rDMi1wh
 h2qvouSU+aAJGRBNcaeqqiP4MaTXb784QxAYEVwN566u3NgYvQITLglf1gQTjNgwKBo9SJeEA7Iik
 PqWEbV3KHado56OSgV+F6tgir6mFgFrD5Sfj5KVPcWmOd7RonP8oiGjwWFILqI8pxnNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YX7h4g07VTrO5X1VbMqaMgQU+UlEG6u/S0zf8vgw36o=; b=gcgT3HuMBkB78LPlA5bWtOAz9Z
 xwd4W5qXUugq1MEEGizykYKRLbzJ80kcrdFxGS94dPSL7lG/Hb9WQbSBT+xtapt+9jzjx1OoK706X
 NSSwIQkYSAjQ4oOnJhTjpAMEkeZvOts75wj1AXog4/edRDNYAJ52msjSUgQv4YUtQcV8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrw2Y-0001fE-5g for openvpn-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 11:13:32 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 676BDNMZ032163
 for <openvpn-devel@lists.sourceforge.net>; Thu, 6 Aug 2026 13:13:23 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 676BDNMP032162
 for openvpn-devel@lists.sourceforge.net; Thu, 6 Aug 2026 13:13:23 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  6 Aug 2026 13:13:17 +0200
Message-ID: <20260806111323.32150-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
References: <gerrit.1786014571000.I1a6a0ca8beba3214b21047755246ceeb30141c2a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wrw2Y-0001fE-5g
Subject: [Openvpn-devel] [PATCH v1] Make test_misc compile with -Werror
 again.
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

Commit 5978a46e3 (master)/3402f9aa0 (release/2.7) removed the
local prototype/function get_random in test_misc and use the
global prototype in crypto.h.

This made get_random return uint64_t instead of uint32_t.
Adjust the calls in test_list accordingly.

On master the general hash rewrite/cleanup completely
removes the iv argument from hash_init and therefore
only 2.7 requires this patch.

Change-Id: I1a6a0ca8beba3214b21047755246ceeb30141c2a
Signed-off-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1839
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.7.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1839
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index b9e2db0..a9c3845 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -170,8 +170,8 @@
      */
 
     struct gc_arena gc = gc_new();
-    struct hash *hash = hash_init(10000, get_random(), word_hash_function, word_compare_function);
-    struct hash *nhash = hash_init(256, get_random(), word_hash_function, word_compare_function);
+    struct hash *hash = hash_init(10000, (uint32_t)get_random(), word_hash_function, word_compare_function);
+    struct hash *nhash = hash_init(256, (uint32_t)get_random(), word_hash_function, word_compare_function);
 
     printf("hash_init n_buckets=%u mask=0x%08x\n", hash->n_buckets, hash->mask);
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
