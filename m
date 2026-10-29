Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB9E606A327
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CsD1ItX5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MuLQ1pUE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QF5zzNBx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UUwrK4dTb5h54cTlM4GYFo1inQeQyafohRwBLudoNQ4=; b=CsD1ItX5oV1Cs6
	EduXWtOq5v1/vIij7DewOz6Hrc1ub7e6XD4SjL/psX9PS7X2c3D+AOAs45jEVipIY1YvYfHqFtzrI
	GRWdzooh4xongpLWrwJwo85m+lGN93YVfXVArZQ8q94KGJ2qXcaskf9eSFnmDOqHyq85QCAQwxcmj
	Y7Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMYQq-000000008A2-1bc9;
	Thu, 29 Oct 2026 22:17:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xMYQo-0000000089o-0HyX for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 22:17:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CriPhI0c5jkB5KdbRHd7v6i6XRJ/fvX3mECqdqhbSyw=; b=MuLQ1pUE9oZSE+iBzOyDfBAen8
 73598nLuv48+VEBXwk45RspYqoWPQjfrqoDIOgLmhlxhY+bZ5E8sM35a3tYJeNT9otVYr9z3XF+14
 FH4ks50efudpl4P2ky8nJAoPbB5hMER8NprZxRaACX9XumOUe59vX6/M8SPdjtbi6rus=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CriPhI0c5jkB5KdbRHd7v6i6XRJ/fvX3mECqdqhbSyw=; b=QF5zzNBxYu5Y8KAPjGYwUgte6M
 2osvrtDOfKUOdQqf/j5jjict3zeQHCLWdjUrZHwVzn14/ydaVYdNsdwl5/D/tCuba7s0laKGp+K+m
 9rS45EOvwE+M4fe724ltNJgkDukklvQ7Hr0lxdYgg8OhgJRZmPC93dWBZxgI9sOA1vgI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMYQm-0000000052r-2ysQ for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 22:17:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69TMH1xm030310
 for <openvpn-devel@lists.sourceforge.net>; Thu, 29 Oct 2026 23:17:01 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69TMH1HC030309
 for openvpn-devel@lists.sourceforge.net; Thu, 29 Oct 2026 23:17:01 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 29 Oct 2026 23:16:46 +0100
Message-ID: <20261029221700.30289-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
References: <gerrit.1793298866000.I5aa1a838afa924df292e630efb173c3b1dc5b407@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xMYQm-0000000052r-2ysQ
Subject: [Openvpn-devel] [PATCH v1] cmake: don't prefix the event message
 DLL with lib
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

From: Heiko Hund <heiko@ist.eigentlich.net>

MinGW builds named the DLL libopenvpnservmsg.dll, while the event log
expects openvpnservmsg.dll.

Change-Id: I5aa1a838afa924df292e630efb173c3b1dc5b407
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2072
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2072
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 2cc4a93..35f1efe 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -69,7 +69,8 @@
 if (MSVC)
     set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS "/NOENTRY")
 else()
-    set_target_properties(openvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME "openvpnservmsg")
+    set_target_properties(openvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME "openvpnservmsg"
+                                                   PREFIX "")
     target_link_options(openvpnservmsg PRIVATE
         -Wl,--entry=0
         -nostdlib


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
