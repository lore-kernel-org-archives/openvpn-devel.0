Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6001CCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZF1T+pJqXwe1qUE0levfStnXCoIDDTtEBHny23t5pfA=; b=jfWKGnxTrilXkW43t002IMowpK
	PDNy+hyKfV0WlAMrsUYEuhQC5IpWJiaXLp83fQQlUHCbUAGD8rV25ZZ7BSyaTQlNFt29Tx5AEc1Lt
	TBKFGbO5/r9SoMCrT1rvKkLyNAFgOUWBnglrDOSzoJMdH/4JxyO8mEJsPiDSPb2imYaY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIQd1-0000R3-RC;
	Sun, 18 Oct 2026 13:08:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xIQd0-0000Qv-0o
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:08:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KWK0tYnvc3CfLXGBycTKjTZJ3MySrx/KQXcJDUvPiMw=; b=Ag3BD0j4wHEMoAgkTkMbUAT6nk
 YU3sdlfa7Vb1Xzgy6lT6ezeqHFX3V4uA9AttcUUYGrRVLPb0a9YLt7w+DDwgf6x2oGXr7X59uTNg6
 dSB1cLJeZ3z1fF2fPRmqHliZZ6x8UjjGdyq1NSF4L59jLCjrvZtvduhhY4U3EPrhnZWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KWK0tYnvc3CfLXGBycTKjTZJ3MySrx/KQXcJDUvPiMw=; b=j51rY7DskF325Hmf/Y76ymjDSG
 lKUdWzKyz3SKo9ANdK4cVQLdPvpvto2bQ6Ar4EzWd90FnHHevVFivcHDlfRgZC74zXMCFPKNDZPQ1
 JaveqoByOBXgCo0FUrm7ldEhrNDpHvwfjH4IMycyAKlE4CZIGENdne6SDuQ7lNazJh+4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIQcz-0006eB-Jq for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 13:08:42 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69ID8YmV011966
 for <openvpn-devel@lists.sourceforge.net>; Sun, 18 Oct 2026 15:08:34 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69ID8YsB011965
 for openvpn-devel@lists.sourceforge.net; Sun, 18 Oct 2026 15:08:34 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sun, 18 Oct 2026 15:08:26 +0200
Message-ID: <20261018130834.11953-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
References: <gerrit.1792274029000.Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xIQcz-0006eB-Jq
Subject: [Openvpn-devel] [PATCH v1] gen-sample-keys.sh: use a random serial
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

Instead of forcing openssl to create consecutive serial numbers, let it
generate random serials. Although not really relevant for the sample keys,
that is the best practice.

Signed-off-by: Steffan Karger <steffan@karger.me>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2010
Change-Id: Ic36123c5a4a2b2295ffdf47174e2aceb9d17d668
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2010
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/sample/sample-keys/gen-sample-keys.sh b/sample/sample-keys/gen-sample-keys.sh
index e5a11f5..e914fd2 100755
--- a/sample/sample-keys/gen-sample-keys.sh
+++ b/sample/sample-keys/gen-sample-keys.sh
@@ -22,7 +22,6 @@
 mkdir -p sample-ca
 rm -f sample-ca/index.txt
 touch sample-ca/index.txt
-echo "01" > sample-ca/serial
 
 # Generate CA key and cert
 openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 \
diff --git a/sample/sample-keys/openssl.cnf b/sample/sample-keys/openssl.cnf
index 02bf8ac..dcaebb7 100644
--- a/sample/sample-keys/openssl.cnf
+++ b/sample/sample-keys/openssl.cnf
@@ -14,7 +14,7 @@
 new_certs_dir	= $dir			# default place for new certs.
 
 certificate	= $dir/ca.crt	 	# The CA certificate
-serial		= $dir/serial 		# The current serial number
+rand_serial	= yes			# Use random serial numbers
 crl		= $dir/crl.pem 		# The current CRL
 private_key	= $dir/ca.key		# The private key
 RANDFILE	= $dir/.rand		# private random number file


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
