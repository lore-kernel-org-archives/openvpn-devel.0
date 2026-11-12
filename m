Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278A5606A31C
	for <openvpn-devel@archiver.kernel.org>; Thu, 12 Nov 2026 06:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EA7U5TW5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Dgz2iD15;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Uh8rHRMM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6d7TWYEhOQkgt5Eu0hNZhrb5lMFosG1+JZ9I52c1R34=; b=EA7U5TW5r8YWcK
	BIsZCNzkxI2xtX1SXEr/v4RsomWWMMNul56Wf0jJ7rPmlqKz8hYTYBaKmdI9EwFi+qDH5yHVQNzi9
	X+vB5i0fZJgR2pZ1d5nUoSn8tTE7RuhEVwf1eWvyoot4WlhJceQN4+c442W2SSu5udyugQY8vnPcS
	QKo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xROMV-0000000059l-0kNW;
	Thu, 12 Nov 2026 06:32:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xROMT-0000000059e-1k5P for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 06:32:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DgZv6POLR1N+3EKeQuzTfc0/r1dc340A5+2kvCON1I4=; b=Dgz2iD1562rRac7lC357YbGegG
 Mc966i7zQLQ8PxNGH0nWxQjBencGPwnjV8WgQ5qGpBGgbjxK4xb4x6HgUImjF6F2HCFbsaFd2Uoqn
 zt5lsDUGdoCkJv6Xkj/aay/mId159SRw25eMEmgjdM4vroZNrhi1qbrDz3xJsZG0uBHs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DgZv6POLR1N+3EKeQuzTfc0/r1dc340A5+2kvCON1I4=; b=Uh8rHRMMeqmJsf2jtwKhrjsRzJ
 j/ZIbGIHmBD4rCVGcI9TX7E0khTyx/VYA/QT3Ns7ylZPZF7c06NNKjPADAu3o5EjUxhQZOaO9ys/C
 6+6zeYDzDvMWyDHfPRq5+X7ImkUIshCcWw3fqO06MRWjInKEpazkF4tq3gIJaBMe5IXI=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xROMR-000000005Z7-3aw3 for openvpn-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 06:32:41 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AC6WXKb024015
 for <openvpn-devel@lists.sourceforge.net>; Thu, 12 Nov 2026 07:32:33 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AC6WWFq024014
 for openvpn-devel@lists.sourceforge.net; Thu, 12 Nov 2026 07:32:32 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 12 Nov 2026 07:32:26 +0100
Message-ID: <20261112063232.23999-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xROMR-000000005Z7-3aw3
Subject: [Openvpn-devel] [PATCH v2] openvpnserv: only remove search domains
 that were added
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

When AddDnsSearchDomains() failed, SetDnsSearchDomains() still called
RemoveDnsSearchDomains() with the new domains, which removes matching
domains already in the search list, e.g. ones configured before the
VPN connected. Record the undo data first, as done for NRPT rules, and
drop it if adding the domains fails.

Broken since ae90cbad ("dns: support multiple domains without DHCP").

Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Antonio Quartulli <antonio@mandelbit.com>
Acked-by: Heiko Hund <heiko@ist.eigentlich.net>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2161
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2161
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@mandelbit.com>
Heiko Hund <heiko@ist.eigentlich.net>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 81205d6..5d2abeb 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1823,13 +1823,19 @@
         strncpy_s(undo_data->itf_name, sizeof(undo_data->itf_name), itf_name, _TRUNCATE);
         undo_data->domains = wide_domains;
 
-        if (AddDnsSearchDomains(list_key, have_list, wide_domains) == FALSE
-            || AddListItem(&(*lists)[undo_domains], undo_data) != NO_ERROR)
+        /* Add undo information first in case there's no heap left */
+        if (AddListItem(&(*lists)[undo_domains], undo_data) != NO_ERROR)
         {
-            RemoveDnsSearchDomains(list_key, wide_domains);
             free(wide_domains);
             free(undo_data);
-            undo_data = NULL;
+            goto out;
+        }
+
+        if (!AddDnsSearchDomains(list_key, have_list, wide_domains))
+        {
+            RemoveListItem(&(*lists)[undo_domains], CmpAny, NULL);
+            free(wide_domains);
+            free(undo_data);
             goto out;
         }
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
