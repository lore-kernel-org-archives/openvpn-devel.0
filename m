Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA95606B838
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gpRi4oxh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DtSZ2j+Z;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=iy8TwIHT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=nmoaO5ZZ6g/WXHbTxpHdBHGGohKAVtT3rFy5Id4iw1w=; b=gpRi4oxhooPgiv
	aVwXYp4h9/ePifc+4kcPlM8CqvKGKKLrGl+/ZqzzW3KjGE6ZVhg24U4oh1lOjuoT78Rnvdj9hvdR+
	1HRilYu+iwBE1U8wI7KNI2PMmu9bcp6+ju1/G7NyIZiX07UIaACb2COz6pkkifP/aepMcot3wvFdX
	xHY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRVdb-000000005uu-2Plx;
	Thu, 12 Nov 2026 14:18:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xRVdY-000000005uf-0c9D for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:18:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+QcpsKqEMDXk8WeQjRo8sAe8ZMOkc5yyQQUmOYnE21c=; b=DtSZ2j+ZMEowwFcBpaoV2tiARF
 wOn4n1QTa4QTfzaTmu/fJc3vyv3Lu0GZ36boR/+WQpNy8fKftWPnxZkWkMSV6kJcUOS4Byu0Jsufr
 ctl28mJUYx6A5YPpabLMUnFji9vjumMBjgdkkLGa1YuoWFGOemTovYkNqmoulqcdAQIs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+QcpsKqEMDXk8WeQjRo8sAe8ZMOkc5yyQQUmOYnE21c=; b=iy8TwIHTBDsNUUcHYiKIiGJoWL
 wdw+hBB/AZ7pSwWTYxOkcPlJb2v11ROk0iHLICyF6I2ZQXkbdCCmsQQCC6E8JbkookwYmI4Zn11xE
 6roQbZlsodWwPPdTpnUpeKNUwOvH63H05985sBEhvUmWlq4uGg4lU4rxhj+B8/wUTwQI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xRVdW-000000002sy-24CG for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:18:48 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ACEIdKB005159
 for <openvpn-devel@lists.sourceforge.net>; Thu, 12 Nov 2026 15:18:39 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ACEIdGD005158
 for openvpn-devel@lists.sourceforge.net; Thu, 12 Nov 2026 15:18:39 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 12 Nov 2026 15:18:33 +0100
Message-ID: <20261112141839.5147-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
References: <gerrit.1794486687000.I793327150883ea0207bcb9724341e750bab92474@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xRVdW-000000002sy-24CG
Subject: [Openvpn-devel] [PATCH v1] auth-pam: wipe and free partial
 responses on conversation failure
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

When a later message failed, my_conv() freed the response array but
not the responses already filled in, leaking copies of the password,
username or OTP without wiping them.

Change-Id: I793327150883ea0207bcb9724341e750bab92474
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2179
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2179
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/plugins/auth-pam/auth-pam.c b/src/plugins/auth-pam/auth-pam.c
index 948b6af..d179533 100644
--- a/src/plugins/auth-pam/auth-pam.c
+++ b/src/plugins/auth-pam/auth-pam.c
@@ -779,6 +779,14 @@
     }
     else
     {
+        for (int i = 0; i < num_msg; ++i)
+        {
+            if (aresp[i].resp)
+            {
+                plugin_secure_memzero(aresp[i].resp, strlen(aresp[i].resp));
+                free(aresp[i].resp);
+            }
+        }
         free(aresp);
     }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
