Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042D3606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=D2CUmvYu;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TNmKN9Vp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NhV/vSZE;
	dkim=neutral header.d=nethesis.it header.i=@nethesis.it header.a=rsa-sha256 header.s=default header.b=GyCA85JT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=XFA0Bk/KtY7f2a8EOwLpT74kymS3OwCX8ToMNLpoqzI=; b=D2CUmvYuTetv+lQLX1bi5ijEQ1
	HukNbnVnN2BPPve5X05KP2sVXpzuYKA1YFuotscERKf9/PG3Xb90qREq6Bvry8an/kGKVT2+MrALW
	+aLQB0mzgNBghOuJZgCgWjmWEIFoEWiBpdveqtsq4nuz7po/LNoGgMpEX480+dKgMIW8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTGhh-000000005na-1h4u;
	Tue, 17 Nov 2026 10:46:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tommaso.bailetti@nethesis.it>)
 id 1xTGhg-000000005n4-2M6o for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:46:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NPQINTVYPKt/kniK1PfEJVSwySQ3NVcb7U4+NDiRnaE=; b=TNmKN9VpfwBHMYfP3kWK9Y8I3A
 l8f6kYA/fYt0usqzpawr2Yo0a58v84/XZf9nPwjL9xwGw2oLQikTR4BT85tq6PrQVkTR/mkF8q0Yo
 2v1gSBptnuQluGhbKG8Xpvu5b7vIutow4vin0QZusT8vUyJt6ohatUyw1ZJI45gDYz9c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NPQINTVYPKt/kniK1PfEJVSwySQ3NVcb7U4+NDiRnaE=; b=NhV/vSZE7kEY3gkzpGwo+bjiKp
 /P1irUIZTg5ZayYmpJjeuuvJg36+kjtCcgkI1p5Be8GvGGuwdiuwxFiBH83uUOlnzOtcRrIkFEA2S
 g60T5+zxPy5EqEbVyzDk1MXxk7eiFF7TK6bj08y36mRrTp2xJG7d4D2yXodSeHz3TGxA=;
Received: from nethservice.nethesis.it ([2.119.67.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTGhD-000000002QS-43oy for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 10:45:54 +0000
Received: from probook445g10.fritz.box (unknown [10.9.9.106])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by nethservice.nethesis.it (Postfix) with ESMTPSA id D4E7A3592E2;
 Tue, 17 Nov 2026 10:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nethesis.it; s=default;
 t=1794912344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NPQINTVYPKt/kniK1PfEJVSwySQ3NVcb7U4+NDiRnaE=;
 b=GyCA85JTCespgB8H2hkx47O1GKD6UcN50uDdxxcM9WwW6UYAfa51fVirWtHrw/p7KWGjVC
 6cF+1WuTgejfFMCterIkyMjkAPrukpnn/OAN+cJtQdyQybHUi0mQV4xtqBj49piW6PmnEr
 3EHma2eUBEpEsNrJ62/+M4cIqhJsBUZoYTQ7rmO2R8QLUfhtWp5ZJhVxNtu2TUBhYjFmtz
 3jHFsXs2KeLsJJ1LNc6JF+MhAdf4IVb+z6xWw4DDp4SY5Q+iDK0hIw/crAGmEs6Zmeev4k
 TDD6Cnlizv7FEX/njovCLxn38umTbLNk4lQEHdYcVVVCyvLUq7t1yuNfVq3RXg==
From: Tommaso Bailetti <tommaso.bailetti@nethesis.it>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 17 Nov 2026 11:45:37 +0100
Message-ID: <20261117104537.317440-1-tommaso.bailetti@nethesis.it>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <gerrit.1794843268000.I831224f06e2f35bfcc9d0fec7d8edfc344c59406@gerrit.openvpn.net>
References: <gerrit.1794843268000.I831224f06e2f35bfcc9d0fec7d8edfc344c59406@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Flag-Threshold: 6
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTGhD-000000002QS-43oy
Subject: [Openvpn-devel] [PATCH v1] dco: always print the status block
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Antonio Quartulli <antonio@mandelbit.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When DCO is enabled print_status() bails out if dco_get_peer_stats()
fails, without writing anything. On a client this happens during the
whole reconnect after a ping-restart, since there's no DCO interface,
so the management "status" command never gets an answer, not even
"END", and the --status file isn't updated either.

Print the status anyway. On a real DCO error SIGUSR1 is still raised
by dco_get_peer_stats(), so the session restart keeps working.

GitHub: closes OpenVPN/openvpn#1146
Change-Id: I831224f06e2f35bfcc9d0fec7d8edfc344c59406
Signed-off-by: Tommaso Bailetti <tommaso.bailetti@nethesis.it>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2201
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2201
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 0cdb01a..8ea756c 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -483,10 +483,7 @@
 
     if (dco_enabled(&c->options))
     {
-        if (dco_get_peer_stats(c, true) < 0)
-        {
-            return;
-        }
+        dco_get_peer_stats(c, true);
     }
 
     status_printf(so, "OpenVPN STATISTICS");


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
