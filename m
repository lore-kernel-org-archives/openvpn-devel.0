Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F93606A31D
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LtMl0PY0;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=SM0naXle;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BVsjv+CP;
	dkim=neutral header.d=lichtenheld.com header.i=@lichtenheld.com header.a=rsa-sha256 header.s=MBO0001 header.b=DNfFBiax
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=YGElSjIJhdiSRgz2XewcA19bp1mxqQS3mGFfk4dkT9Y=; b=LtMl0PY0YXAfuv7Yp8LiP9/6fC
	We3YnvlH7wo1fGTPZM9emMSwAbmCKPwY9g+GklhGJPTbMq+0p4MM0hNF+vF3JQ1jv+LIauBkhfdwc
	UrNFzXZUQEaq9SG5tZ3efV2DWgmFhjlSzJ9cHKwZRtg1RH9TiJD9L5x/ge0vOR62Tcm4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLJVp-000000003CS-1OJI;
	Mon, 26 Oct 2026 12:09:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <frank@lichtenheld.com>) id 1xLJVn-000000003CK-0a6a
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 12:09:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QcXAITel45DkK8bUf27Kvd50198iEE1CCWDu4rbGN0w=; b=SM0naXleCeJBYsark5nqZmsKto
 vY2iE9bqY0ApxZk40PEW6Sy6KSsWK2sFRR4bMSnJOPupFDc/BtyVmUffOs3vfqeijlonUaR4kVx7T
 Db5toOYLUH2Ki3O/JNQxsuEu0PYsTUDZ0BgkERfIcBiUbY8YL7lBQ4vgv4p31j6X7Gfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QcXAITel45DkK8bUf27Kvd50198iEE1CCWDu4rbGN0w=; b=BVsjv+CPuLsM5DDT4om6VdAFW/
 e+drrhghO2fyOc/6xQb6BBRy7gcq92cE+tbxjXA4FaXtS31F+ZaQSQbFYvCNJtiJ2mpX5wks6mTPY
 vfbLLX//aGolILxUyqULdBaZoAoK4IDLJTWH+fmpIWTTi/MnkZGaArNgWaUDSjXPImHI=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLJVl-000000008Oh-1dww for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 12:09:10 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jCsqJ5pZrz8v5r;
 Mon, 26 Oct 2026 13:09:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1793016540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcXAITel45DkK8bUf27Kvd50198iEE1CCWDu4rbGN0w=;
 b=DNfFBiaxvv8h/ZZVKhq0x99kZ23HwuCRHlsf27KUoVgI/JZD0ny6XI/41696ZYgmVBrgdg
 zXX1nl7zmPqtz3EyNm+cuTmiQUnvjSYObsbKBurfWlHguZIIpXLbNiH/W+Mz2mrpVo6zNf
 jdgIPl9ryXRHkenXRhfGY8GQbaeZ8zO/T0kISSeGObhLJ4QQ426g8ZvWES2bP7BmD16P5l
 0LK4pU8i+fbkrAo1+D6PHjTaFiXcQaLXjwm4ApQn/WnPrR7pj1KtcTzd80+GFOZCQkjG/D
 APCdlr08IjknFyf1FsW9f84dPzgubv8cKS299o19FA5uowKoLgmcMU1q3G8ODg==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 26 Oct 2026 13:08:59 +0100
Message-ID: <20261026120859.76788-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
References: <gerrit.1793012308000.Id206b12bd67c0b8a014a2c62277b43b18debfd43@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4jCsqJ5pZrz8v5r
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLJVl-000000008Oh-1dww
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
Cc: Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
