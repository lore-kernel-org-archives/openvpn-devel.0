Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B373A60A2609
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EzoTNQL2;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=P2CNgpWw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h5qvpivf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=7jbqzi0Rg0GPsk7IHUJfqNCk5+OOfoG6NaHob52sMQg=; b=EzoTNQL2IbJsXs
	GNRh3yOxkh5RN2obYDMOKltdYhiKE9b3+CS/2wO8Ack5UxVjW3Mf+j3bWPin7Jr58oIoieEe33FCz
	FON/OCRYV5ALixKeUWqWuQjEhRgmozw19lWV01k1lbKMRq5gCx8LASNWAT2vQ0LqNOp1AcbVaHBpX
	eOQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNp3x-000000007dV-1pFc;
	Mon, 02 Nov 2026 10:14:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xNp3w-000000007dN-01LK for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:14:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MB0UEkoEHUyHvJjyGK+vGmydNg/S13eD++UsvdLrgzI=; b=P2CNgpWwu44Vte97n55c1w75OP
 yIwyYPKf8t/H7Wbi6ewfsYmNJMVl/QBh6Ar6ZhpfkWzC+jH5ryOWLg3q5xRpfHJKkBFErQCTSkBYF
 UTgUx8p3pV/FG1sZncYwC/deT5cuB+SgP4kr7OFAiYTKp22QFJwPNTwMvE2FgpJF9wac=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MB0UEkoEHUyHvJjyGK+vGmydNg/S13eD++UsvdLrgzI=; b=h5qvpivfp6bMEPnEVe6oSyr66c
 Sd+siE/7FMDuErlYzpchTZq4VOi3day3Q1hyzLLd7bvGgIb6G1+RQ26RAIHcg/w6wg4WPuCeSzlN9
 Ji+H2SkYEzcajnzK1le1Qmyvlsy6KmSHRtobuIaz5ymnSMi7w2YUpYBhBIc4PWyJOnj0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNp3s-0000000038r-3gmU for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:14:47 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A2AEcpw001240
 for <openvpn-devel@lists.sourceforge.net>; Mon, 2 Nov 2026 11:14:38 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2AEcLj001239
 for openvpn-devel@lists.sourceforge.net; Mon, 2 Nov 2026 11:14:38 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon,  2 Nov 2026 11:14:31 +0100
Message-ID: <20261102101437.1209-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
References: <gerrit.1793594388000.I8e02b4cf39cc431f1f2c058db95997c8907557c0@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xNp3s-0000000038r-3gmU
Subject: [Openvpn-devel] [PATCH v1] tls_crypt: Wipe the tls-crypt-v2 client
 key copies
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

From: Hansaem Wi <hansaemw@gmail.com>

tls_crypt_v2_init_client_key() reads the client key into a struct key2
on the stack, copies it to *original_key and returns without clearing
it, so every client start leaves the tls-crypt-v2 client key on the
stack. crypto_read_openvpn_key() does the same copy for tls-auth and
tls-crypt keys and clears its struct key2 afterwards; do the same here.

The --genkey tls-crypt-v2-client sanity check in
tls_crypt_v2_write_client_key_file() has two more copies:
- keydata, the struct key2 that tls_crypt_v2_init_client_key() fills;
  clear it after use.
- check_wrapped_client_key, the decoded key file buffer: the client key
  is still in front of the wrapped key when it is freed. Clear it with
  buf_clear() before free_buf(), as do_close_free_key_schedule() does
  for the client's tls_crypt_v2_wkc.

Assisted-by: Claude Code:claude-opus-5-5
Change-Id: I8e02b4cf39cc431f1f2c058db95997c8907557c0
Signed-off-by: Hansaem Wi <hansaemw@gmail.com>
Acked-by: Steffan Karger <steffan@karger.me>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2079
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2079
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Steffan Karger <steffan@karger.me>

        
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 23c7975..ee4acdf 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -331,6 +331,7 @@
 
     tls_crypt_v2_load_client_key(key, &key2, false);
     *original_key = key2;
+    secure_memzero(&key2, sizeof(key2));
 
     *wkc_buf = client_key;
 }
@@ -783,6 +784,7 @@
     tls_crypt_v2_init_client_key(&check_client_key, &keydata, &check_wrapped_client_key, client_file,
                                  client_inline);
     free_key_ctx_bi(&check_client_key);
+    secure_memzero(&keydata, sizeof(keydata));
 
     /* Sanity check: unwrap and load client key (as "server") */
     struct buffer check_metadata = alloc_buf_gc(TLS_CRYPT_V2_MAX_METADATA_LEN, &gc);
@@ -793,6 +795,7 @@
     ASSERT(tls_crypt_v2_unwrap_client_key(&check_client_key2, &check_metadata,
                                           check_wrapped_client_key, &server_key));
     secure_memzero(&check_client_key2, sizeof(check_client_key2));
+    buf_clear(&check_wrapped_client_key);
     free_buf(&check_wrapped_client_key);
 
 cleanup:


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
