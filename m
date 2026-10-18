Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB31CCF2C9
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 07:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W8N662BAjnSOsIgec4nNh5qnIv0Y2PkLxMn9EyZbjBo=; b=S3Y7DFamasFgXlxNFYiuLbWwRZ
	t5NCd8vcVwEoqvpnuQDPh8Iww2FKKMo1AJX6hL9DL9rCOuiYu/bOUy2j5H163m0dyaDXcK9lOHnp3
	IjWVKkuELWAx5lehjFBkXxTmfJo7PLl8ufUNISTQ1hDTYBmWRwI5qex5xlr3c4ubO4V0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIKvk-0007VK-NC;
	Sun, 18 Oct 2026 07:03:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xIKva-0007V7-2K
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 07:03:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XdQAEXhLnZvjOklu4ePt0mi/Y5BWFl/IuNB7dL3R9pA=; b=hNfJlenmxiew1T9Z/6GLMTH+Gn
 diB1Jdf4vu2kNXqvaZJ/z5eaVjGnUA34SjcDxpUcoMVPeGt+/EntHHYJloiE0Co6xfCPV/uDOWGM6
 HllLHUAk2H5J9NtiAvrjHaoXvCQdRcDHRMZMbaim4Y/I2fMiGFfZL2P2ITkOT8WvxHyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XdQAEXhLnZvjOklu4ePt0mi/Y5BWFl/IuNB7dL3R9pA=; b=MLqZKStWMeREo3Zg95kZe9lYac
 5iSL6zNuCsaFdnIRc8VwW9pRMNtHbTDutSucrLOVImVqPXT3ZUxkSx6A4K8FPW/LsuRW2Ef/XSs8W
 pPW93CRHMsSGNIEEfsSE57BCYGFChh/ukyN6/nA2lYpcp4bebmYz5SdtriXneEF8zCw0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIKvY-0004Zt-6p for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 07:03:30 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69I73LHq015764
 for <openvpn-devel@lists.sourceforge.net>; Sun, 18 Oct 2026 09:03:21 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69I73L6I015763
 for openvpn-devel@lists.sourceforge.net; Sun, 18 Oct 2026 09:03:21 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2026 09:03:15 +0200
Message-ID: <20261018070320.15749-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
References: <gerrit.1792274029000.I3513563f199e1c5ac98219a527695e40540a9f73@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xIKvY-0004Zt-6p
Subject: [Openvpn-devel] [PATCH v1] gen-sample-keys.sh: Don't apply server
 extensions to CSRs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Steffan Karger <steffan@karger.me>

Newer OpenSSL versions refuse to add authorityKeyIdentifier with
issuer:always to a CSR, since there is no issuer certificate yet. The
extensions are already applied when signing with 'openssl ca', so drop
them from the 'openssl req' calls.

Change-Id: I3513563f199e1c5ac98219a527695e40540a9f73
Signed-off-by: Steffan Karger <steffan@karger.me>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2009
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2009
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index fa5f697..e5a11f5 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -31,7 +31,7 @@
     -config openssl.cnf
 
 # Create server key and cert
-openssl req -new -nodes -config openssl.cnf -extensions server \
+openssl req -new -nodes -config openssl.cnf \
     -keyout sample-ca/server.key -out sample-ca/server.csr \
     -subj "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server/emailAddress=me@myhost.mydomain"
 openssl ca -batch -config openssl.cnf -extensions server \
@@ -66,7 +66,6 @@
 openssl dsaparam -out sample-ca/dsaparams.pem 2048
 
 openssl req -new -newkey dsa:sample-ca/dsaparams.pem -nodes -config openssl.cnf \
-    -extensions server \
     -keyout sample-ca/server-dsa.key -out sample-ca/server-dsa.csr \
     -subj "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server-DSA/emailAddress=me@myhost.mydomain"
 openssl ca -batch -config openssl.cnf -extensions server \
@@ -82,7 +81,6 @@
 openssl ecparam -out sample-ca/secp256k1.pem -name secp256k1
 
 openssl req -new -newkey ec:sample-ca/secp256k1.pem -nodes -config openssl.cnf \
-    -extensions server \
     -keyout sample-ca/server-ec.key -out sample-ca/server-ec.csr \
     -subj "/C=KG/ST=NA/O=OpenVPN-TEST/CN=Test-Server-EC/emailAddress=me@myhost.mydomain"
 openssl ca -batch -config openssl.cnf -extensions server \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
