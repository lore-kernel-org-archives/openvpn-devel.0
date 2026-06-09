Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 118B2CD8CA4
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u3XAPeW/RjOzdbciNZ64j/uQY7Dbe/bUVlWChxa1WN4=; b=gFCAOfcDa+MODO6qWT+iinOetR
	O/m3dT+PHlR1O3OfT9nA7YEFILkBpvK0fdldgfVaLuZe+EYLH1TXUIzaKOn0ArY9oKAhdL9uYmIxw
	wrSb1TVldr1j0p0/7UBEk1FYl2uzUa0TGoumC6uIrq4jSpS5Gex4TITjEV16re1pgbTs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWyGj-0005dd-1v;
	Tue, 09 Jun 2026 15:21:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wWyGh-0005dT-1H
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:21:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RNsd1WDD6gfKSc4G4OM0xXgMiwDdiqzhLuNXh9+szZ4=; b=HNGl2rBBd0mLx9oBuMCezOENHb
 N/zvsTCSCht918OiVn+PG+KY1dBlIi7w0Bi9eqcVA6hwyQ6khd4BtW4z7jcJZqj82MS1nfAh9NQ0P
 shMZ1QorFeCjkBgLMMfj3uC+/ao+RvyY8jKs7CEWRmUEWy4CuoYNhVHPTuMRNrukGzUY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=RNsd1WDD6gfKSc4G4OM0xXgMiwDdiqzhLuNXh9+szZ4=; b=dFbmvChhntTA/y9D6yp1tzoP4R
 DNlkZxuf5tx1/2GUh11PcQphBbHmdu/WEXM+rriVDl2SiXEXd2z4Q/2yV/oXSvf73Mq8Inpc08wBp
 7pafISIUar+hWI55C6zf7jdjCaFzU2JHHYvouUPYyyLjUZgZU8PenSMRs2BXAOmHxrOo=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wWyGf-0003jf-Jo for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:21:31 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 659FLNbV027475
 for <openvpn-devel@lists.sourceforge.net>; Tue, 9 Jun 2026 17:21:23 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 659FLN3u027474
 for openvpn-devel@lists.sourceforge.net; Tue, 9 Jun 2026 17:21:23 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  9 Jun 2026 17:21:17 +0200
Message-ID: <20260609152123.27460-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
References: <gerrit.1781017122000.I8a17d452e9e5690a5507d17129286142df6c88f1@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wWyGf-0003jf-Jo
Subject: [Openvpn-devel] [PATCH v1] GHA: Switch to using VS 2026
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

Since Github will switch to windows-2025 image to use
VS 2026 at some point in the near future (according to
https://github.blog/changelog/2026-02-05-github-actions-early-february-2026-updates/#windows-server-2025-with-visual-studio-2026-image-now-available-for-github-hosted-runners)
enforce that switch to avoid any build failures. Since
we hardcode the VS version in CMakePresets.json (and I
do not see an easy way to avoid this with CMake), we
need to override the generator value. We can switch the
default once our release infrastructure has been switched
to VS 2026.

Change-Id: I8a17d452e9e5690a5507d17129286142df6c88f1
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1711
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1711
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 323645a..4cab0ac 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -138,7 +138,7 @@
         test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, openvpnserv, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
         build: [Release, Debug]
 
-    runs-on: windows-2025
+    runs-on: windows-2025-vs2026
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - ${{ matrix.build }} - OSSL"
     steps:
       - name: Checkout OpenVPN
@@ -285,7 +285,7 @@
         VCPKG_BINARY_SOURCES: clear;default,readwrite
         VCPKG_GIT_COMMIT_ID: 75672db6bd812b060482b0f00b5a16b18a0c0f07
 
-      runs-on: windows-2025
+      runs-on: windows-2025-vs2026
       steps:
       - uses: actions/checkout@df4cb1c069e1874edd31b4311f1884172cec0e10 # v6.0.3
       - uses: lukka/get-cmake@591817e96fcad43505fb4eae36172462abb3a42e # v4.3.3
@@ -315,6 +315,7 @@
         with:
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
+          configurePresetAdditionalArgs: "['-GVisual Studio 18 2026']"
 
       - name: Run CMake with vcpkg.json manifest
         uses: lukka/run-cmake@5d55ea7949e25f69f0ecb516d8d572297e03a956 # v10.9
@@ -323,6 +324,7 @@
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
           testPreset: win-${{ matrix.arch }}-release
+          configurePresetAdditionalArgs: "['-GVisual Studio 18 2026']"
           testPresetAdditionalArgs: "['--output-on-failure']"
 
       - uses: actions/upload-artifact@043fb46d1a93c77aae656e7c1c64a875d1fc6a0a # v7.0.1


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
