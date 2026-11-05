Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A878606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BTo5cunc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=loUPqNTh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OX0nvkn1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=WmLPkBQ/JrIqtM6jWQvFlwc1ZnC8gWj2yUrjCL5/sZY=; b=BTo5cunc5ux75I
	1EVATaq0+2Yw7+X567w/jAzMKtki2+zY0YasLLThrINgeirICpflNBWQN7DPGMdQ0nFONJMqcoHFR
	p5v6PQQUBBLS6xpWdiXggMQKIGLGttZrnOTqakd+ct+jTHyBHvsVf79bOCG07TGeDBXJdGYZMhCRE
	SqU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOxoV-000000007og-1dAx;
	Thu, 05 Nov 2026 13:47:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOxoT-000000007oa-3Utq for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:47:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WR4GPHANCbl80IHadmUf6BEmzrsoVLGtDSk2E5So558=; b=loUPqNThMvfUDwtA5bwMxUW9wR
 CoH5FPKPwYiHAOdIvQ7IkTlHR3IB47zTnr1TdOIZK8yXiQooVkQwFakcXlyvttg8h4+3pnds63YOv
 9O2kplXkOcboCB7Sn3egsdNnC+SqVdGQcoiVrlKipPVTS23lJEEIyu72ka4UIG9/bcVM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WR4GPHANCbl80IHadmUf6BEmzrsoVLGtDSk2E5So558=; b=OX0nvkn1cdxyGUXNVyYN7a/oGu
 o3ekC9QhpHBlgpnU3w/A07NJZj/tAYYft1GGiEfqwnmWo5hrIQ6POZP6AraBXgr0LYLellIp2pXnv
 Lh9fSgmpQt4wTL0RoGDPGyrN/HWssUlOLqNHqeZlziwsstOdu40rAZcq+BmgFaJL+B38=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOxoR-000000005Gt-47TE for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:47:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A5DlOPr006637
 for <openvpn-devel@lists.sourceforge.net>; Thu, 5 Nov 2026 14:47:24 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A5DlOqc006636
 for openvpn-devel@lists.sourceforge.net; Thu, 5 Nov 2026 14:47:24 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu,  5 Nov 2026 14:47:19 +0100
Message-ID: <20261105134724.6621-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793747232000.I056164a3016d62152dfcbd57f75d58534dda8fc8@gerrit.openvpn.net>
References: <gerrit.1793747232000.I056164a3016d62152dfcbd57f75d58534dda8fc8@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOxoR-000000005Gt-47TE
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: report error if the pipe
 cannot be created on start
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

If the first pipe instance could not be created, the service stopped
with exit code 0, e.g. when another process already owned the name.

Keep the error code of CreateClientPipeInstance() intact, logging it
before LocalFree() may change it, and use it as the exit code.

Change-Id: I056164a3016d62152dfcbd57f75d58534dda8fc8
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2113
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2113
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 5e4b555..bffc9da 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3832,7 +3832,9 @@
     if (!ConvertStringSecurityDescriptorToSecurityDescriptor(sddlString, SDDL_REVISION_1, &sd,
                                                              NULL))
     {
-        MsgToEventLog(M_SYSERR, L"ConvertStringSecurityDescriptorToSecurityDescriptor failed.");
+        DWORD error =
+            MsgToEventLog(M_SYSERR, L"ConvertStringSecurityDescriptorToSecurityDescriptor failed.");
+        SetLastError(error);
         return INVALID_HANDLE_VALUE;
     }
 
@@ -3871,14 +3873,15 @@
                                &sa);
     }
 
-    LocalFree(sd);
-
     if (pipe == INVALID_HANDLE_VALUE)
     {
-        MsgToEventLog(M_SYSERR, L"Could not create named pipe");
+        DWORD error = MsgToEventLog(M_SYSERR, L"Could not create named pipe");
+        LocalFree(sd);
+        SetLastError(error);
         return INVALID_HANDLE_VALUE;
     }
 
+    LocalFree(sd);
     return pipe;
 }
 
@@ -4043,6 +4046,7 @@
     pipe = CreateClientPipeInstance();
     if (pipe == INVALID_HANDLE_VALUE)
     {
+        error = GetLastError();
         goto out;
     }
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
