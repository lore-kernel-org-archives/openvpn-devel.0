Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA4A606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b8DSq7vi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mTpfZnLX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Fi5zklZd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0YEIYJMm+YP+iWsOStPwrJtAA9gXzFQug0bYWvuIYLw=; b=b8DSq7vi0KKn8U
	Uy7B5+2ZuigNaco0/eVIS7Z26xDlKGgczkTCveRMX8q2g4CTC4iQ33MOLjgsqkO0eAWqpduLpxGQe
	Bibulnv2DGxLihGr8z6uR6T24/wgzKdsM4SUl4jimqwUGdRDsGyQk1Ort5BLtyrpZ1AmLlOygDi6z
	KpY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaQQ-000000001c4-30Bk;
	Wed, 04 Nov 2026 12:49:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOaQO-000000001bw-32Ii for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:49:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hiqc+QwwSKkvX/Q8gASp2uy0ZmpLf9hHCMwhBwMjDIc=; b=mTpfZnLX9qHCsYf/JYQjUl1uJQ
 a1h7GHzVYhE/WtOuy+G2BETNE8nfeygMPrMsiIzQjaqLiADOGjMwJvUbB2VCnNO4WOYzuZ8HYMiEP
 MskaisqXUvkaW3YGsBlv1ZwQEdnoXc3j3hg22pnwGvH9QT5La1qG0tuo6jLh1CffhbmE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hiqc+QwwSKkvX/Q8gASp2uy0ZmpLf9hHCMwhBwMjDIc=; b=Fi5zklZdpZPS4h4lF+5oDMsvMT
 cNEO8PSmbR5CL67iURka366nZKraLwIaIAtenn1i07n0ZEfA6Pw8sixM+oqfoNch1HN3VQjug2tDf
 w1hcP42snp4hhuv9WWzDTaEANfiQkMPimpKgfLiefsgYJtHDpuTavon3zmi1M3VPJTIU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOaQN-000000002oZ-0AER for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:49:08 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4CmxvF018431
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 13:48:59 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4CmxSF018430
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 13:48:59 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 13:48:54 +0100
Message-ID: <20261104124859.18417-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
References: <gerrit.1793779900000.I40059eb9af845a5070ebb8caff741b0794632de2@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOaQN-000000002oZ-0AER
Subject: [Openvpn-devel] [PATCH v1] manage: drop unused input parameter of
 management_query_multiline()
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

From: Razvan Cojocaru <razvanc@mailbox.org>

The parameter has never been used since the function was added in
39e3d336 ("Mac OS X Keychain management client"). Its callers read the
input list themselves.

Change-Id: I40059eb9af845a5070ebb8caff741b0794632de2
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2125
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2125
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 58f63e6..57a9561 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3830,7 +3830,7 @@
 
 static int
 management_query_multiline(struct management *man, const char *b64_data, const char *prompt,
-                           const char *cmd, int *state, struct buffer_list **input)
+                           const char *cmd, int *state)
 {
     struct gc_arena gc = gc_new();
     int ret = 0;
@@ -3914,7 +3914,7 @@
     int ok;
     char *result = NULL;
 
-    ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
+    ok = management_query_multiline(man, b64_data, prompt, cmd, state);
     if (ok && buffer_list_defined(*input))
     {
         buffer_list_aggregate_separator(*input, 10000, "\n");
@@ -3941,7 +3941,7 @@
 {
     char *result = NULL;
 
-    const int ok = management_query_multiline(man, b64_data, prompt, cmd, state, input);
+    const int ok = management_query_multiline(man, b64_data, prompt, cmd, state);
     if (ok && buffer_list_defined(*input))
     {
         buffer_list_aggregate(*input, 2048);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
