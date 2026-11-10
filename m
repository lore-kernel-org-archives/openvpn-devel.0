Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7A0606A33B
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NI1rCHMT;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UPuth98B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dbqOLNKP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vZ7VgQbvTRC+Un+e3JUMxxDsUGmyJCLri2hR0YOuCs0=; b=NI1rCHMTax0qJl
	8mqxI4TvXYRhtcZ1argoYsLvajB9XBVhjE7H9IU/44DT2SK7c6Sv9+uuxIwuIOPltu4MwtZaxSeYj
	YklMBlEIe94+fln8RIKcmaQ0y8KrKBRRfj4RtjQjMvD0rYh1rrvtJdcSQrnT1jxLujL4kzEfHfWfD
	bw8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQnLT-000000002Oh-2fkh;
	Tue, 10 Nov 2026 15:01:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xQnLS-000000002OY-1unr for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 15:01:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iyto1FqbfVce/XSzmeF+v62y818cnyaHdbcei/N6GVg=; b=UPuth98BLae8yFxBatuiM50q/L
 a8Blw29+YZrBe2ajX0jMwb5m0ALZEIPpc4Hy04U+aAkp+zSlJpPfmVtFdm8WOIVV06Fc1SXQClpUI
 CfQP/LSmZ5a6Sfxyi8gqw7D/86zsWMbqhgsIIlaY6EToS1aUs85fWac04+5nHBMh0a4M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iyto1FqbfVce/XSzmeF+v62y818cnyaHdbcei/N6GVg=; b=dbqOLNKPoNvWQDreC6/GkRXuxR
 1M7PhNwu4++hCC5ZMe5KZCY9znKk12ujhCsXLudF/DN32U9WDVOA8vAHYpvWKcQeH433S/QSZ7Euq
 tZm3iT5vkxi9JakG+bxcXCrjDy/ht/eRIlrDhodiFOO/t978oqccbWHQp4ujZf87oLl8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xQnLP-000000000dP-2IFq for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 15:01:10 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AAF10Yh017837
 for <openvpn-devel@lists.sourceforge.net>; Tue, 10 Nov 2026 16:01:00 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AAF10g4017836
 for openvpn-devel@lists.sourceforge.net; Tue, 10 Nov 2026 16:01:00 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 10 Nov 2026 16:00:55 +0100
Message-ID: <20261110150100.17824-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
References: <gerrit.1794320197000.I5a827f4c6d169420504a48e13ee6eb28053dbc4c@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xQnLP-000000000dP-2IFq
Subject: [Openvpn-devel] [PATCH v1] init: drop dead code in
 inherit_context_child()
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

The ciphername/authname copies are overwritten by the
dest->options = src->options assignment that follows, and the
trailing IS_SIG() return is a no-op.

Change-Id: I5a827f4c6d169420504a48e13ee6eb28053dbc4c
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2167
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2167
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3bc4de4..bf88213 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4871,9 +4871,6 @@
     dest->c1.ks.tls_wrap_key = src->c1.ks.tls_wrap_key;
     dest->c1.ks.tls_auth_key_type = src->c1.ks.tls_auth_key_type;
     dest->c1.ks.tls_crypt_v2_server_key = src->c1.ks.tls_crypt_v2_server_key;
-    /* inherit pre-NCP ciphers */
-    dest->options.ciphername = src->options.ciphername;
-    dest->options.authname = src->options.authname;
 
     /* inherit auth-token */
     dest->c1.ks.auth_token_key = src->c1.ks.auth_token_key;
@@ -4930,10 +4927,6 @@
     }
 
     init_instance(dest, src->c2.es, CC_NO_CLOSE | CC_USR1_TO_HUP);
-    if (IS_SIG(dest))
-    {
-        return;
-    }
 }
 
 void


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
