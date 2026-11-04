Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38CF606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=af1KNUAZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g9+xqYw3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jbZmpjWz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=O/+sRe2sKcN8HIunp+IbaMihhj5AA6LwyPjAuJZZRUc=; b=af1KNUAZn3SQ9h
	C7xMOnHfMgAHr/KQjzDNWCXT8gJGYCvh0ebm066gyhv8UtiMooFay5J+k6IiG7rYVzYIGGIA7Z/VD
	1ycV/UD66Ru+DrmiEmz9jU7JRlqeUM/Zy7Q56z7e3VhZMrCtNQ0+Lae/AfYKKbN7vmHgpUmSg9lUA
	++c=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVj3-000000007Un-1KoB;
	Wed, 04 Nov 2026 07:48:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOVj0-000000007Ud-3OAC for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:48:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rkpzTRn4oF3b5coqf+opwIjvuqkGpIt3A3K184QqVHg=; b=g9+xqYw3Z1Pg3oaDOo2YhtuSIB
 9d/Epo7mnJf1AMnvz9EFWhFae+uBS39z49mgmNvk990jO6zploqrMve9+bE7udp4WsYh6yAbq98Ql
 ZiB3/+UfuxMSKhh3yItuDuRevhc8L2wZgZvTaSq/grDW4lWf2w5ZK1ncdIGePZlCGdzM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rkpzTRn4oF3b5coqf+opwIjvuqkGpIt3A3K184QqVHg=; b=jbZmpjWz4mP5ds+lrI4aP5axKE
 ywj5/aSclwB+mFSngyeU14z0F55VRzoQDv9x4YQtjIrYaLpVjKp6TjrCA9Nugnp+rcPORyvMOh2q4
 ZFxFVCDQYQGO5B86V5i0gz6SUYJ/xGotaEcLPhEKEuQt781pVLYBZ8OmsS5M0RlI/S7o=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOViw-000000000ML-1dQ9 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:48:02 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A47lpxh021363
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 08:47:51 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A47lpSs021362
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 08:47:51 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 08:47:45 +0100
Message-ID: <20261104074751.21336-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
References: <gerrit.1793733834000.Ifc707ef69d614c3408b6f88c780e337e95baafac@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOViw-000000000ML-1dQ9
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: free security descriptors
 in RunOpenvpn()
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

The DACL from SetEntriesInAcl() and the pipe security descriptor from
ConvertStringSecurityDescriptorToSecurityDescriptorW() were never
freed, leaking both on every client connection. Initialize them to
NULL at the top and LocalFree() them at out.

DACL leaked since a24dd2e3 ("interactive service v3"), pipe security
descriptor since 0a429cb1 ("Restrict access to the service pipe to
SYSTEM and owner").

Change-Id: Ifc707ef69d614c3408b6f88c780e337e95baafac
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Heiko Hund <heiko@openvpn.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2111
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2111
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Heiko Hund <heiko@openvpn.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 484f27c..4ddc354 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3444,7 +3444,8 @@
                                         .lpSecurityDescriptor = NULL,
                                         .bInheritHandle = TRUE };
 
-    PACL ovpn_dacl;
+    PACL ovpn_dacl = NULL;
+    PSECURITY_DESCRIPTOR pSD = NULL;
     EXPLICIT_ACCESS ea[2];
     SECURITY_DESCRIPTOR ovpn_sd;
     SECURITY_ATTRIBUTES ovpn_sa = { .nLength = sizeof(ovpn_sa),
@@ -3624,7 +3625,6 @@
      */
 
     SECURITY_ATTRIBUTES sa;
-    PSECURITY_DESCRIPTOR pSD = NULL;
     LPCWSTR szSDDL = L"D:(A;;GA;;;SY)(A;;GA;;;OW)";
     if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(
             szSDDL, SDDL_REVISION_1, &pSD, NULL))
@@ -3764,6 +3764,8 @@
     free(ovpn_user);
     free(svc_user);
     free(cmdline);
+    LocalFree(pSD);
+    LocalFree(ovpn_dacl);
     DestroyEnvironmentBlock(user_env);
     FreeStartupData(&sud);
     CloseHandleEx(&proc_info.hProcess);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
