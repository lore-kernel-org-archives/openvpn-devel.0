Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114DD606A32D
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 11:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Nv82cEBC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dEzeVN/s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fNa+eHQ7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kxPxRbgEI2GjU/SV34T1q6Gtms457XjwUgpAdubhtNk=; b=Nv82cEBCpqeh5p
	tBxyLDrZaDajCC5h5Q1n+Inh1N3KVuLATgNQ7n+qPzw+8wbVSCzZLm5DLl0jyt//ERmmWt7oWN9I4
	0SrqYY6uuNz0hERh+6Op0dLJwd/5WcDLrjP8fhoa5fmYidPuBlyZBkX1EEykcJd78wvMeL3YAPMhX
	FSs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNqgK-000000005jy-2S9R;
	Mon, 02 Nov 2026 11:58:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNqgF-000000005jV-2Knz for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:58:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1DxaacC0+6FGJwOt96JmLDqj3IU4Az1xVsO03UOJ3KM=; b=dEzeVN/sX2xcU4GCw4J7i++ACs
 EdY59X1nOofMJo3uPke88svosivvilTdrNyYxFHXe3vcvz5lmiDfSuna2h6n0vpJdfP139uuMCOao
 7fmaoQ4Fhpn1dvCKhoSg06PiKSjRbz0zxfeHDy7C8whDIUhA9HnYjnsUM0J/X2FKp+7w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1DxaacC0+6FGJwOt96JmLDqj3IU4Az1xVsO03UOJ3KM=; b=fNa+eHQ7IKUc438PISnvtV4fGF
 CCo+nQTB6b7dOlDOzyepcRXSLbKKwia6Ty4Jgd9zVf6hL3hXdokkYkSOqG7gm9pI7wp10Oa2PREg4
 o3HPeoStc4hERN1HNTsT2bSF15CrbXxp/tD+I/Pg/GvBQAyKhgPDm893POjnZXMJsHec=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNqgD-000000005z5-3iQc for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 11:58:27 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2BwINb014201
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 12:58:18 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2BwIq7014200
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 12:58:18 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 12:58:13 +0100
Message-ID: <20261102115818.14189-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
References: <gerrit.1793618639000.Ia3f6dd4ce35869c92619ce0c56eeda8796bde006@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNqgD-000000005z5-3iQc
Subject: [Openvpn-devel] [PATCH v1] check_file_access: fix --extra-certs
 access check
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

The file name was passed as the is_inline flag, so the check was
always skipped. Pass extra_certs_file_inline instead.

Broken since cb2e9218 ("convert *_inline attributes to bool").

Change-Id: Ia3f6dd4ce35869c92619ce0c56eeda8796bde006
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2084
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2084
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/check_file_access.c b/src/openvpn/check_file_access.c
index 83654b2..25d7f90 100644
--- a/src/openvpn/check_file_access.c
+++ b/src/openvpn/check_file_access.c
@@ -267,7 +267,7 @@
     errs |= check_file_access_inline(options->cert_file_inline, CHKACC_FILE | CHKACC_ACCEPT_URI,
                                      options->cert_file, R_OK, "--cert");
 
-    errs |= check_file_access_inline(options->extra_certs_file, CHKACC_FILE,
+    errs |= check_file_access_inline(options->extra_certs_file_inline, CHKACC_FILE,
                                      options->extra_certs_file, R_OK, "--extra-certs");
 
     if (!(options->management_flags & MF_EXTERNAL_KEY))


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
