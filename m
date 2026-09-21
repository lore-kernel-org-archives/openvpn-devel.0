Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A217C982ED
	for <openvpn-devel@archiver.kernel.org>; Mon, 21 Sep 2026 17:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Z10RzW3USlFnishCdsNq+1GRGeRPMJ5132K9GCmFTs=; b=A2iHX9cytcTMEQiqgoTrWPd63V
	EeTPVZPPzymo/+c/U6BB6bSUkFwJgvu+QkivOulbYRDT3g1pkDEyHAau8khTf5jLlcrXSnNgqs7oN
	NpzuaJ5MXgZcy37L9/+iPibvdXn5qhCIt1M0dsObLbImA64cKoRVZjgWS49ea0K1ZFpc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x8hVL-0002QI-F6;
	Mon, 21 Sep 2026 17:08:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1x8hVI-0002QB-Ru
 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 17:08:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tTKP1xbXOxd+TuerMjwFWzL2tfnpyanaANEVfH05teY=; b=SeLcmT2QgwK0exc63Tx/sZBhAm
 hUOfJV7UZz5WEVqjs6nVOdnkG90x33mQHIwg6cvfjtoXGlEWQ5sTwOaS7KQBo5sJ5QW3hkeT9WM7d
 BtxLmtjfmjUpv4wlEW9mDbJdkWYiC6IYJqxO3DLnEXqvisAXl3sR/hkeYLTKwndpHyAc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tTKP1xbXOxd+TuerMjwFWzL2tfnpyanaANEVfH05teY=; b=BN0JxxnIvzYZJ2bxJE6wJrNXZE
 NoAeQCmvpOFJOiGRGb5iEAp2aduZq5ECrzgCdQ/6WISrSQ2z+x/8V8nkvSP6fKum0QNeAgXlWPfEc
 Icmm0HZDDO9tvNu8uUsIQYYfWU4nTQuiL9d9xxOcB7/+IKSL7V9d5jY0bMfQ4fyb1kjA=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8hVI-0004Ae-B9 for openvpn-devel@lists.sourceforge.net;
 Mon, 21 Sep 2026 17:08:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68LH8PBu008061
 for <openvpn-devel@lists.sourceforge.net>; Mon, 21 Sep 2026 19:08:25 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68LH8PDE008060
 for openvpn-devel@lists.sourceforge.net; Mon, 21 Sep 2026 19:08:25 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 21 Sep 2026 19:08:19 +0200
Message-ID: <20260921170825.8046-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
References: <gerrit.1790006381000.Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1x8hVI-0004Ae-B9
Subject: [Openvpn-devel] [PATCH v1] GHA: Explicitly set PKG_CONFIG_PATH in
 Android build
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

From: Frank Lichtenheld <frank@lichtenheld.com>

Otherwise CMake could use the wrong pkg-config file.
It was still using the correct libraries due to
architecture config. However, in Ubuntu 26.04 lz4 has
an additional xxhash dependency and this dependency
was wrongly used.

Change-Id: Icaa76a20ef41e26044fa684d5297f40d8d5ddc8d
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1921
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1921
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 56dd3ed..d67c215 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -62,6 +62,8 @@
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
+        env:
+          PKG_CONFIG_PATH: "${{ env.VCPKG_INSTALLED_DIR }}/${{ matrix.vcpkg_triplet }}/lib/pkgconfig"
         run: |
           cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=yes \
             -DCMAKE_SYSTEM_NAME=Android -DCMAKE_SYSTEM_VERSION=28 \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
