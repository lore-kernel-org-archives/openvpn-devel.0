Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC354606A32A
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=f3i/TfF5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=i2TqNNlQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MKQSgWXK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=tTG+Sf4O7EzrEhTp4O9HKjugK9OwXlSH8mmZLfJ60pE=; b=f3i/TfF5wEU8q9
	7CNZBYhMn58JW6PD+z8UrQs/Lhy3hE1zWNltmbKHeiKr+2BkGaRaTGmoI0a4NvxVNRWSauw6chvvY
	bcgOm2xXnv5h21SSHuG78K906KrVJkdIRq3kHtL934e9bVQLWtg+62t4o6RV8tI5SI1n4MPxGCCeG
	zOA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSttv-000000002tZ-1Boq;
	Mon, 16 Nov 2026 10:25:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSttu-000000002tN-0bdL for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:25:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y11KRqbJgnDICHM223FH/VLvqwEbPVu2uUwZA2Hsb/A=; b=i2TqNNlQWmx9z0LM+4/SddykVn
 eVVJ7BzwpkHcV1haLAlhdsbHUSB7xr8Lxnn9V/XNhPJdwYVDOyiBdxAwUX8UpNADMH9PWAea7D6au
 NzhZ2qosoMCC67gXXqLvVVMhuPF6A9XRuDB8Wzn9egYP5+WNjbwJMgkDreFCe+u0UA7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y11KRqbJgnDICHM223FH/VLvqwEbPVu2uUwZA2Hsb/A=; b=MKQSgWXK1fk86tX/40USmZCw+I
 HiDdN8wLFo/zoqf7qu0c8ijVrv5h2vCGlnQl6F/ButKRjTGgEC4McLnkgIly3Lqd8pPRghRToE0i5
 yS/Xzyj15SAjzvQVTnl+1xUaIzn4a8iWK0WbXcgU7V3opQFhn8oeQq8QePRVQ//XzcjA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xStts-00000000376-1FOP for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 10:25:26 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AGAPH8c014507
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 11:25:17 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGAPHMR014506
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 11:25:17 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 11:25:11 +0100
Message-ID: <20261116102516.14493-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
References: <gerrit.1793693047000.Idb3c52174e588016240e9c9162a1676e1531c551@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xStts-00000000376-1FOP
Subject: [Openvpn-devel] [PATCH v1] dco_linux: check ovpn_dco_nlmsg_create()
 result in new/get peer
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

dco_new_peer() and dco_get_peer() passed the result straight to
nla_nest_start() without checking for NULL. Return -ENOMEM like the
other callers.

dco_new_peer() unchecked since e34437c2 ("dco: introduce low-level code
for handling ovpn-dco in the Linux kernel"), dco_get_peer() since
5a8fb55a ("dco-linux: implement dco_get_peer_stats{, multi} API").

Change-Id: Idb3c52174e588016240e9c9162a1676e1531c551
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2101
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2101
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>

        
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 4412ad0..50d4c54 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -234,6 +234,12 @@
     msg(D_DCO_DEBUG, "%s: peer-id %u, fd %d, remote addr: %s", __func__, peerid, sd, remotestr);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);
+    if (!nl_msg)
+    {
+        gc_free(&gc);
+        return -ENOMEM;
+    }
+
     struct nlattr *attr = nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret = -EMSGSIZE;
 
@@ -1229,6 +1235,11 @@
     msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __func__, peer_id);
 
     struct nl_msg *nl_msg = ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_GET);
+    if (!nl_msg)
+    {
+        return -ENOMEM;
+    }
+
     struct nlattr *attr = nla_nest_start(nl_msg, OVPN_A_PEER);
     int ret = -EMSGSIZE;
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
