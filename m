Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8DF606A33B
	for <openvpn-devel@archiver.kernel.org>; Mon, 23 Nov 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BimCixDz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=msGJrPDS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eHjOQCnw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=1y3B4n5JbQu8cQhnVsL7rHHa7wThdTDm2GT+oZm014g=; b=BimCixDzrmlCv9
	PSMmJ72B1b1eLjkbf+l1Z6aEStnISNEzAzYKdX6zCIwxolukIGEWRXRwZYWSMIRVkjTmHVwVF/El3
	JLwbK1JpCpjUNX0IbDUwYtlc4fmuY9n0J8pSe4yV4E+13IyNP4lF9+u5ixEJlVyaCK14S3yR6yqsh
	VAI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVUQH-000000003k5-3Qy7;
	Mon, 23 Nov 2026 13:49:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xVUQG-000000003jX-1Cxk for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:49:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PExV2HQw8cjzHVoCbqjb6Tu9g2celH2E3PNt9eoTd7U=; b=msGJrPDSoQlkfN1yNx/XIvAqKI
 SNNMQruu6pvBlT4ybhvTbpc0hOeIKdPrfs2zd5WAZ9FBbjyduVsDVBIQ3vB/4nF3wj/lpxo5oEytE
 u8HEEb5fkdfBs/dNZGyyRvSG381i38agIVnocmP61kgGoZtjcsX5V5GXtTvrO8SY+t4k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PExV2HQw8cjzHVoCbqjb6Tu9g2celH2E3PNt9eoTd7U=; b=eHjOQCnwot+sgx0Y0N82rWqoPu
 DkRwQOTjXJ/oVF0Xl/GuS0tLOqdAeHi/CXBKqtakYQYH7sQh9iZ/Iv16q4PhAtPrOZYU0idgKniX9
 whQHkevIfEuY1U1+tSbMoW9wPLGax2FqfxTXJpzmTL9AQT6dnkZudcHWWf5MFiV9/qw4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVUPx-00000000370-3XAo for openvpn-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 13:49:15 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6ANDn7BG031712
 for <openvpn-devel@lists.sourceforge.net>; Mon, 23 Nov 2026 14:49:07 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6ANDn7bx031711
 for openvpn-devel@lists.sourceforge.net; Mon, 23 Nov 2026 14:49:07 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 23 Nov 2026 14:49:01 +0100
Message-ID: <20261123134906.31644-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
References: <gerrit.1795353062000.I58b88ca3934e52cfc5140a564c9ed7260857ce80@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xVUPx-00000000370-3XAo
Subject: [Openvpn-devel] [PATCH v1] manage: drop redundant NULL checks
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

man_need() already guarantees p[1] for log and echo, and
up_query_type is non-NULL once "needed" holds in
man_query_password_base64().

Change-Id: I58b88ca3934e52cfc5140a564c9ed7260857ce80
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2238
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2238
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 86c498e..d5b1ff8 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1051,7 +1051,7 @@
         msg(M_CLIENT, "ERROR: no password is currently needed at this time");
         return;
     }
-    if (!man->connection.up_query_type || !streq(man->connection.up_query_type, type))
+    if (!streq(man->connection.up_query_type, type))
     {
         msg(M_CLIENT, "ERROR: password of type '%s' entered, but we need one of type '%s'",
             type, man->connection.up_query_type);
@@ -1684,10 +1684,7 @@
     {
         if (man_need(p, 1, MN_AT_LEAST))
         {
-            if (p[1])
-            {
-                man_log(man, p[1]);
-            }
+            man_log(man, p[1]);
             if (p[2])
             {
                 man_log(man, p[2]);
@@ -1698,10 +1695,7 @@
     {
         if (man_need(p, 1, MN_AT_LEAST))
         {
-            if (p[1])
-            {
-                man_echo(man, p[1]);
-            }
+            man_echo(man, p[1]);
             if (p[2])
             {
                 man_echo(man, p[2]);


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
