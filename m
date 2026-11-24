Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A93C606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=V0T11I65;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kk4NKMqg;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Hx9YV7ux
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pKRG9P+3CoKUWRNS7RHkdKb2zocoKngf8aOxcGBheGk=; b=V0T11I65pO3U0O
	FLRLf2EnCiALhFOBPKgkMG5bJxhf3wDPl1Ecr2Fsi43JDzzs1c69B93EwKcppur3P5H0JoSuCIg1a
	4whtJ/JsH9Re5yNSWuU9++ItdA5cItWN81vfj0ZYsdA/Bahqb4yP7931ZFfk5lKA/WQ3eB9eZedA8
	xT0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVpba-000000002Cw-32XI;
	Tue, 24 Nov 2026 12:26:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVpbY-000000002Cp-260z for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:26:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2adv5oNtZFe8b8gj+w/atV23noqNfug7ts0YyBkuy7o=; b=kk4NKMqgsJhRdWkbUHF/VnwfiG
 Zk6qE20BssLKmYmy4L2+7rW7DWDgkDU9CwoYj8/kuvudS8wpoNCZKgHOfK3DE4ajkYfy7qNDzyaQj
 gRlq1nQ3FDe0oKOLK2hBLEJz0YNDbD9XbFnJZNZXc5/hISQOOexr09HO2w7X2BDOxuf8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2adv5oNtZFe8b8gj+w/atV23noqNfug7ts0YyBkuy7o=; b=Hx9YV7uxAScThPYtw5vG4ZIZ9l
 077ufxJSkYne6qu+a5pnNxj8j3H6NoM1WM8jnX5ZVPhT0i4Drhh7IXSnovbckbmRnAnjOv2JJa2aN
 wsq6aJPHzRzlLPayI2whXKQ+a7kVw+pRaNmukIBb3TzctEfjdqNdZmr0nMVsH/Lu/jCo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVpbX-000000000vC-2hpx for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 12:26:36 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AOCQTuZ008616
 for <openvpn-devel@lists.sourceforge.net>; Tue, 24 Nov 2026 13:26:29 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOCQTaN008615
 for openvpn-devel@lists.sourceforge.net; Tue, 24 Nov 2026 13:26:29 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 24 Nov 2026 13:26:22 +0100
Message-ID: <20261124122628.8605-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
References: <gerrit.1795514253000.I878ba525232afffa95e6b7c972ae349d6b488a2d@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVpbX-000000000vC-2hpx
Subject: [Openvpn-devel] [PATCH v1] init: compare context mode against
 CM_P2P in do_up()
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

c->mode holds a CM_* value, but do_up() compared it against
MODE_POINT_TO_POINT, an options mode. This only worked because both
are 0.

While at it, drop a duplicate #include "occ.h".

Change-Id: I878ba525232afffa95e6b7c972ae349d6b488a2d
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Lev Stipakov <lstipakov@gmail.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2332
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2332
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@gmail.com>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e1052c5..8b64944 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -39,7 +39,6 @@
 #include "otime.h"
 #include "pool.h"
 #include "gremlin.h"
-#include "occ.h"
 #include "pkcs11.h"
 #include "ps.h"
 #include "lladdr.h"
@@ -2363,7 +2362,7 @@
     if (!c->c2.do_up_ran
         || (c->c2.tls_multi && c->c2.tls_multi->multi_state == CAS_RECONNECT_PENDING))
     {
-        if (c->mode == MODE_POINT_TO_POINT)
+        if (c->mode == CM_P2P)
         {
             /* ovpn-dco requires adding the peer now, before any option can be set,
              * but *after* having parsed the pushed peer-id in do_deferred_options()
@@ -2391,7 +2390,7 @@
         }
         else
         {
-            if (c->mode == MODE_POINT_TO_POINT)
+            if (c->mode == CM_P2P)
             {
                 if (!do_deferred_p2p_ncp(c))
                 {


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
