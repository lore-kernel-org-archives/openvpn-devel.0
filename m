Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02C606A319
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 08:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PIu9faAH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=LxK92WK0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=eAEU6ZfY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jYzNYOvUUolFprCDg0SGWUoQ/YPhpdCAqrRaso4NWDg=; b=PIu9faAHLdDIGE
	cjY8wQbSodEmT3AHZeIp2hDTXLrhSVgl5kXk0yDJNH6D1ItT76PIWKT4kkSGizSmWO+GrsqdQws4Z
	LnLg+6RE5cvZ5z+HDNFhWPEFUg5QbRmi7jWAdFYdZyhiMewZwkFJM5O/D33KX7qFbosbhsCTDsQ4Q
	KOY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJnxT-000000001Zy-2D2i;
	Thu, 22 Oct 2026 08:15:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xJnxR-000000001Zr-2o3t for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 08:15:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x3w8RoVjlgtGPgtrRw2jVkBdHJSc6cnprMts+McU7gY=; b=LxK92WK0sWK0hEL5BIy/8ILrnI
 Nx5mleIu3OqctQT5BNcPH8As/q5Lkskbyz50o5Z9VntymiUc02x33MG97aCvE1ucblpyp0gOYqyo+
 I4i7N8l68WN7B3ia+lwmP1CfgJMyL61xtIV5+gFD+mfq5hWcYCQDvHPeUmC357lcCErs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x3w8RoVjlgtGPgtrRw2jVkBdHJSc6cnprMts+McU7gY=; b=eAEU6ZfYnJkjMLlkMzSTygVYxp
 p6jUJrPrJYCWmceo5cTfBswUohyE+SVPfKA1j8smFMiPqBWejlLV2WmNK0YpANDdX87IyPKbkbOc3
 FBDPUwqFmeAxmBlOWIZzVeVUlIS+Eh5Bo4h1IIHCGpGxHtqdqPy7JljkRWOQeVMwUHb4=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xJnxM-000000006FI-3t06 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 08:15:29 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69M8FIt0002898
 for <openvpn-devel@lists.sourceforge.net>; Thu, 22 Oct 2026 10:15:18 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69M8FH2T002897
 for openvpn-devel@lists.sourceforge.net; Thu, 22 Oct 2026 10:15:17 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 22 Oct 2026 10:15:08 +0200
Message-ID: <20261022081514.2882-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1792504491000.I230654e770c0556976a9bf4aaae9bcbea79b31e9@gerrit.openvpn.net>
References: <gerrit.1792504491000.I230654e770c0556976a9bf4aaae9bcbea79b31e9@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xJnxM-000000006FI-3t06
Subject: [Openvpn-devel] [PATCH v1] configure: Output compiler version
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

From: Frank Lichtenheld <frank@lichtenheld.com>

CMake does this and it is really useful when looking at
logs in buildbot, so one does know which compiler was
used.

Change-Id: I230654e770c0556976a9bf4aaae9bcbea79b31e9
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2026
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2026
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/configure.ac b/configure.ac
index e83aba7..818b10d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -391,6 +391,10 @@
 fi
 
 AC_PROG_CC
+# AC_PROG_CC doesn't output any useful information
+AC_MSG_CHECKING([compiler version])
+CC_version=$($CC --version | head -n1)
+AC_MSG_RESULT([$CC_version])
 AC_PROG_CPP
 AC_PROG_INSTALL
 AC_PROG_LN_S


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
