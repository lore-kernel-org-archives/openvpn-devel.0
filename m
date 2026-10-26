Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C8C606A31B
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L3h85a01;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BSF4Sod1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=j+lvyg9K
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pigruhvgqSMvpnre+fbeD37OIdKexmC24ViUpoFgyY8=; b=L3h85a01JZyvHE
	QtS2v99KtemoEgxs6H29OVsC84BjhQtC7GazbS4SjA83afLtR25Lkhshbj5gUiTCpFZiEQkSELBOP
	f6XC36SgZC/TDObip24WdDVKUFZppDDlS7g+bJHx53qHzTYpe0nBQBcFzHurXUAEQFQzJ3rRCV211
	8fg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLLRR-0000000067h-1i3N;
	Mon, 26 Oct 2026 14:12:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xLLRP-0000000067Y-0IH4 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:12:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3N7rHLespxTnLe1GAhn0yPbOiU6Ji6ykUXNaG9qJBOQ=; b=BSF4Sod12GJ9e9xI/B8rrrXDDt
 FHcWeCSBRKEu4xrOV7t4YGE+NECOqR+7DFRb2FRMHiEkhHePPwjOq7CdoOix3BhZxbmWX5LsuY/HW
 XZS1+incWMViFUcIXx1cc8TVhChIuaH4XdTCWZNQrR6vBka0q+XXsoY4RKJ1jW/tYQw4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3N7rHLespxTnLe1GAhn0yPbOiU6Ji6ykUXNaG9qJBOQ=; b=j+lvyg9KRJW8sB0bshwkmdpPKR
 uBtID0UbgYLegCIcmP6HNE8ulZOrlHE9HYJwfmm2zZZ4h3LWB6nlhqmF8RcNgTHbf22GTkpkH8vyv
 V2R+7JQb/wIvWHnRrq3x0TRsH8GD9uAeE9yzcjMGWWYWMsNhQ3zvRDBgd+xj62tm8ANU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLLRM-000000001o1-2Oyw for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:12:46 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69QECaB0003999
 for <openvpn-devel@lists.sourceforge.net>; Mon, 26 Oct 2026 15:12:36 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69QECatr003998
 for openvpn-devel@lists.sourceforge.net; Mon, 26 Oct 2026 15:12:36 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 26 Oct 2026 15:12:29 +0100
Message-ID: <20261026141235.3970-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
References: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xLLRM-000000001o1-2Oyw
Subject: [Openvpn-devel] [PATCH v2] run-cppcheck.sh: Make
 CPPCHECK_CHECK_LEVEL=normal the default
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Lichtenheld <frank@lichtenheld.com>

exhaustive is generally not usable since it runs for hours.
So avoid confusion by choosing a sane default.

Change-Id: Id206b12bd67c0b8a014a2c62277b43b18debfd43
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2033
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2033
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index a9c4643..07c0a6f 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -3,7 +3,7 @@
 set -eu
 
 : ${CPPCHECK_VERBOSE:=false}
-: ${CPPCHECK_CHECK_LEVEL:=exhaustive}
+: ${CPPCHECK_CHECK_LEVEL:=normal}
 
 if "${CPPCHECK_VERBOSE}"; then
     verbosity_arg="-v"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
