Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36857C5AD2C
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 07:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y5/OFLlpK/H1EaOZtCzumpKGnDi/vkG1l+T0TlTdDJI=; b=APvpkHknGGEOAjzaNLbBHjvGBq
	C9cCW/GM4+1fj33BPwWnZ6UBSTTHLCqRLBCQgcEWlzdQY9TNtKtYAqsfzlCSwuoGMygGf2i9Jotus
	IwiInWTqhz4IQtl1yTyadORFDkvuI3gqFJkbL8vrKLknksUAG7hb1CQf9QwtVQeuyn1A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsbQ4-00054c-S1;
	Sat, 08 Aug 2026 07:24:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wsbQ3-00054U-Qd
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 07:24:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4CPum5KjGsdNfbAd3B2a7DGFnhvvU4tZGbUTHBVKt/g=; b=driY2Hn2zpvYDb9lekSFyZqyq8
 2SQGeI2xkpmwbNwcTTtS3HqW0+eQJCkjJT7994Be4HwKsbiETAPyJz0hgrWzVfAZaNB6MbAnRYSAI
 JtF5wHLixnI794mOdlTc5Q4npKzD9slQrk0dWdzTTj4MGW8MoNEYp0S4PiUS8WEWqu+4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4CPum5KjGsdNfbAd3B2a7DGFnhvvU4tZGbUTHBVKt/g=; b=NkPxZInE3u7w6UrztLh7Fz4KR+
 ZNui8Z+xs9wE5NWufXRBLL91IVgkTOZ1JX8RM+0BDxlKKk5DG8M7cTfW3xRP4mia0N2z0nEYH2lqE
 qJ9qkekNl7F7M7KMBz/2XwPKVYMcvRgtEf5wdfML+nN+22ZgB+Y9hkbc1gp0yK8Di6FI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsbQ2-0002R4-Tv for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 07:24:35 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6787ORmM006357
 for <openvpn-devel@lists.sourceforge.net>; Sat, 8 Aug 2026 09:24:27 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6787ORrg006356
 for openvpn-devel@lists.sourceforge.net; Sat, 8 Aug 2026 09:24:27 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat,  8 Aug 2026 09:24:20 +0200
Message-ID: <20260808072427.6344-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
References: <gerrit.1784290573000.Ib6956c3a8b332866a59b41c186cce4e0bc5f078f@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wsbQ2-0002R4-Tv
Subject: [Openvpn-devel] [PATCH v2] t_client.rc-sample: Add missing
 documentation for FPING_ARGS_x
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

Also include some smaller misc documentation fixes.

Change-Id: Ib6956c3a8b332866a59b41c186cce4e0bc5f078f
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1791
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1791
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index d07c376..defa4aa 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -8,9 +8,13 @@
 # define these - if empty, no tests will run
 #
 top_srcdir="${top_srcdir:-..}"
+
+# PKI args
 CA_CERT="${top_srcdir}/sample/sample-keys/ca.crt"
 CLIENT_KEY="${top_srcdir}/sample/sample-keys/client.key"
 CLIENT_CERT="${top_srcdir}/sample/sample-keys/client.crt"
+
+# Customize ping tests
 #FPING_EXTRA_ARGS="-t 1000"
 
 # Load EXPECT_IFCONFIG* parameters from cache
@@ -63,8 +67,8 @@
 
 #
 #
-# now define the individual tests - all variables suffixed with _1, _2 etc
-# will be used in test run "1", "2", etc.
+# now define the individual tests - all variables suffixed with _1, _2, _2n etc
+# will be used in test run "1", "2", "2n" etc.
 #
 # if something is not defined here, the corresponding test is not run
 #
@@ -86,6 +90,7 @@
 #
 # hook test options:
 #
+# FPING_ARGS_x      = "arguments to append to the fping command line"
 # CHECK_SKIP_x      = "commands to execute before openvpn, skip test on failure"
 # PREPARE_x         = "commands to execute before openvpn"
 # POSTINIT_CMD_x    = "commands to execute after openvpn but before ping"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
