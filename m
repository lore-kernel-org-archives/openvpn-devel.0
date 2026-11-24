Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40DD606A330
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YcNWjkp4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V3Ia5Vra;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YwYareWf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Q/K/nlxmBs78vNv3SkflRxebTuGEXaaDI2v7bJjxxek=; b=YcNWjkp4VdBsi6
	RtK5jA2w3ZT6+eq5nwsG2fYxexzjqsJldg3/VySfVq73gHNXRABGSZf6w0S+gVRLPskS/Rz/iGarz
	Xw56+MVGUoJ5pvXO1nSXGsMZBwNwF01LuCu0Wzcw7mI25VcLM+G+Q5Ut20f2ZLAi/93d+6aA/fPtD
	3lg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVrRF-000000007WO-0ilu;
	Tue, 24 Nov 2026 14:24:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVrRD-000000007WF-0rOr for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:24:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sc9Yc87jxZ8BZghHHLWsEzVOYyPhQQgs+i5NAB1wa3c=; b=V3Ia5VrayGr2tDp/3o0y4GKxac
 SgbSdrHPN5H/jddqTiC2GLZqrgyplSp/R1CaniteCZ1ENy/WdtNoFAVvV2q3NT4bcPinuX7A2Jb5G
 omUZruqiCX+l64YrsQa5fr5YekObu2QXiiO/pX2MgjAfH8xaXtMMbPCpfVHoe9CZb0os=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sc9Yc87jxZ8BZghHHLWsEzVOYyPhQQgs+i5NAB1wa3c=; b=YwYareWfO4dCNyThTBPYzVpd5L
 qZzbABix1Kucoq5NKMpqoX4WeMMC2u2BhOk6f5Ov8VKPrccA3VnaOR2GQ103vLEfiuNGWGXLG0f5D
 296oduAeBDJZ6238JfXnpVIhRhpjlMTtPXnUliIk0/3j5pc9bdQR9MuICJAhy1B/mr6k=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVrRA-000000003eJ-1WIW for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:24:03 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AOENrGC020260
 for <openvpn-devel@lists.sourceforge.net>; Tue, 24 Nov 2026 15:23:53 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AOENrVH020259
 for openvpn-devel@lists.sourceforge.net; Tue, 24 Nov 2026 15:23:53 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 24 Nov 2026 15:23:46 +0100
Message-ID: <20261124142352.20244-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
References: <gerrit.1795529786000.Icb913d6e890607c79a45a0e63e9a1ba44151e8e2@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVrRA-000000003eJ-1WIW
Subject: [Openvpn-devel] [PATCH v1] list: drop redundant check in
 hash_iterator_next()
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

hi->elem is set from b->list, which was just checked to be non-NULL.

Change-Id: Icb913d6e890607c79a45a0e63e9a1ba44151e8e2
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2337
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2337
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index dcd59d7..505be30 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -294,12 +294,9 @@
             {
                 hash_iterator_lock(hi, b);
                 hi->elem = b->list;
-                if (hi->elem)
-                {
-                    ret = hi->elem;
-                    hash_iterator_advance(hi);
-                    break;
-                }
+                ret = hi->elem;
+                hash_iterator_advance(hi);
+                break;
             }
         }
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
