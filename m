Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D124606A31E
	for <openvpn-devel@archiver.kernel.org>; Sun, 15 Nov 2026 17:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DPna6LAf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eyLq0AxU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZgPWhoCm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FjZuz8dTBSQ3x2pwkiCtXGy85uRzbQMkL5+329VgPws=; b=DPna6LAfnMlLov
	x77A2xGzjkSBeziPEbOHO21oA1hWKEb8ko38nnC8WmZF5IO6bveUaFqvPUaQ4oyvZ7pPjAm9XT6TX
	mX266t2cXhpoyDjbzxhgAI/1LvFC6gXrP/xsZ10KxfGyfcu1M9AT/Ui95YXjXUSMBbTD6YwQkKGWp
	ZN8=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSdab-000000004D1-0sdY;
	Sun, 15 Nov 2026 17:00:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSdaa-000000004Cq-0H9l for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 17:00:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JotvMQIueXBZFkWYP9hqhYvfsxHqqMc/pwdQf3Y9h7w=; b=eyLq0AxUejrcTrmEQgE3wmlai6
 KlzL3eYyE2Y0OltrkYvtS5f0UgmveDE4+ezw4JumLzoI+y+TLKloB09Lc56RqNq0eEUUvbIC8gsBc
 XXoKneQjgjuf9WCD4XnBIidUD6odihzLegs+ii983hsmElbHA9k1aGpT26xcYCGoZd24=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JotvMQIueXBZFkWYP9hqhYvfsxHqqMc/pwdQf3Y9h7w=; b=ZgPWhoCmsp+fgXK8H7e7gW7hB6
 QOgMxGG1VoA5nlpCQgk697qI7XwryR9Osbvkrio03oDLge4LkjRxEJ1gAhvLcFsRWgrRY1c0o9wwn
 SUyHGh+BrVfeJV12S3k+0wb3X16ltOp57YIDyTC28tkdZGQMFRniV4bgAZqAYeNrLgdE=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSdaZ-0000000054Y-0Ilq for openvpn-devel@lists.sourceforge.net;
 Sun, 15 Nov 2026 17:00:23 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AFH0Gjr010319
 for <openvpn-devel@lists.sourceforge.net>; Sun, 15 Nov 2026 18:00:16 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AFH0G4Z010318
 for openvpn-devel@lists.sourceforge.net; Sun, 15 Nov 2026 18:00:16 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 15 Nov 2026 18:00:10 +0100
Message-ID: <20261115170015.10294-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
References: <gerrit.1794653707000.Ib8a47751bb0d559083d1a50aab82c06fb0dad110@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSdaZ-0000000054Y-0Ilq
Subject: [Openvpn-devel] [PATCH v1] auth-pam: Include dlfcn.h for dlerror()
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

With --enable-pam-dlopen, auth-pam.c calls dlerror() without a
declaration. Broken since ce8271f5.

Change-Id: Ib8a47751bb0d559083d1a50aab82c06fb0dad110
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2184
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2184
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 0cd201d..72c047d 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -32,6 +32,7 @@
 #include <security/pam_appl.h>
 
 #ifdef USE_PAM_DLOPEN
+#include <dlfcn.h>
 #include "pamdl.h"
 #endif
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
