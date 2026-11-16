Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24786606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AKmA1dMK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hrrrvXgi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=UmmiC9zs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YOO1frWnbrL+n8PvsIP/WOBYn1uf+d0EGb4rfMr93fs=; b=AKmA1dMKo+VToO
	gs/RzUwIBRaCA0j6jq8b9OmFQn5lXdSzDBgu12oEVwMKtNMS922mkmEDF6oLnOlj8+hgMgLDPDx6e
	HGDpd/WNI+sO0uWGzbQCvra1wpw0ugvw71dFlrMn9v4NnBtCcIc/jQ0R45gD5721VH5sGHiYLgBo/
	QUo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSwlS-000000002SD-1Bx6;
	Mon, 16 Nov 2026 13:28:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xSwlB-000000002Rp-0n1I for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:28:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dnsNlRhIQZYMjjBZfRCJQygPFSKy0M+AGS6nTgquvhc=; b=hrrrvXgiBhV4nwpaYYJRf2MP0g
 NqLNTO5HKn2uo0JzQHQ8T8YohYsyuBpIzbJwgXJXJdRqOAcOcPqvpv+aRdv9w/Bw5vIxEsEXvn3kU
 f0BQGfVfM2AjSXgpDrlz0gFlzBTzO7+kRgwaSRi3GmYfWzWhD3azKOuHPrLecBNJp2Z4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dnsNlRhIQZYMjjBZfRCJQygPFSKy0M+AGS6nTgquvhc=; b=UmmiC9zsRr2jTaAMZnck3WdfLM
 xD9OfR16LxRSHxBUJRZPSthXK6nAASsi6drEklyWkh4HPDMdLks/kI2BzRlS+TErojA2q4CZIRxmT
 YhOd5WOgEWTbuwUOHNsU5H1Z79mAx9tdTRTSUzzDHBM/Z7zFwcTBSWPayPqiwyQgOGDk=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xSwl9-000000007Ln-1mDS for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 13:28:37 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AGDSSmw031958
 for <openvpn-devel@lists.sourceforge.net>; Mon, 16 Nov 2026 14:28:28 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AGDSSmk031957
 for openvpn-devel@lists.sourceforge.net; Mon, 16 Nov 2026 14:28:28 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 16 Nov 2026 14:28:23 +0100
Message-ID: <20261116132828.31945-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
References: <gerrit.1794832910000.I6079f454e5bb1ce7c4ecc5343ce2231c417ca879@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xSwl9-000000007Ln-1mDS
Subject: [Openvpn-devel] [PATCH v1] GHA: Disable -Werror for MinGW 32bit
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

There are some build failures related to -Wsign-conversion
now that look like clear bugs in MinGW. Since we do not plan
to support 32bit Windows going forward, let's not worry too
much about compiler warnings anymore. We will still detect if
we break the build completely, for now.

While investigating the issue, remove a wrong comment. With
-Wsign-conversion, all builds need the casts.

Change-Id: I6079f454e5bb1ce7c4ecc5343ce2231c417ca879
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2193
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2193
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 27f08df..d50b7ff 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -81,6 +81,10 @@
         arch: [x86, x64]
         build: [Release, Debug]
 
+        include:
+         - arch: x86
+           configure-args: "['-DUSE_WERROR=OFF']"
+
     name: "gcc-mingw - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     runs-on: ubuntu-26.04
     env:
@@ -113,6 +117,7 @@
         uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10.9
         with:
           configurePreset: mingw-${{ matrix.arch }}
+          configurePresetAdditionalArgs: ${{ matrix.configure-args }}
           buildPreset: mingw-${{ matrix.arch }}
           buildPresetAdditionalArgs: "['--config ${{ matrix.build }}']"
 
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 703a0b2..261c7c2 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -364,7 +364,6 @@
 
     /* Accept session tokens only if their timestamp is in the acceptable range
      * for renegotiations.
-     * Cast is required for systems with 32bit time_t, e.g. Windows x86.
      */
     const time_t token_reneg_deadline = (time_t)timestamp + 2 * session->opt->auth_token_renewal;
     bool in_renegotiation_time = now >= (time_t)timestamp && now < token_reneg_deadline;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
