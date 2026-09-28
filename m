Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 281AECA5FA2
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=owTlKF72y3sfaiXn3JVFu2pMCp7O30U/hVrkloh3Eig=; b=nNihtSaEw6DqFpTH33a+zcYFlp
	9wQ8lo6pf2ssQAoRXxJ4WXw/U849za1T6T6GIcmdORavf+HUa0iQdjDwvgPfmaNazZMBoQXkWgcGV
	N+6OnSw5meKV9pRjW64Zjw1DGndmYJpwQnFVBvnn0gKzai9ArKWxYy2PiwXOevQIIOu4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBC9S-000124-05;
	Mon, 28 Sep 2026 14:16:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xBC9P-00011p-Mg
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:16:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wVMCPeGpt5JC6o82DiEJR+1VVLeMxlEJ6xmammSowOs=; b=IDB+aMB7P365dHf9GdC2btMSMw
 pz+Qgcm4WfZmi/0R4iCq5t0el9HPpcydvnD1EmxdLqnOHPIAvK6FbjK5zMv4tIx3D9GxxpuYmyA5n
 vufO6gFWgdznJlXep4Zjj8sDDoQTEGDG273EKtcazguw4AMIjke9pWtdMYzcsYbthZSs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wVMCPeGpt5JC6o82DiEJR+1VVLeMxlEJ6xmammSowOs=; b=KGp4x0+2VSuqWYQ7BNchMdvk/w
 Y+xolS00keuwQI7kYO78zAzH8eUZyUAOFKlSuDCxxasqTsJr/96t9XF0TWq4YDXVzPTH9TBEgXbMp
 falqsABvlEIvNad5dyk2UukSaXQ56BD10irB6bRkHbzDqnsD6GDMh8idpLqcJckhqJp8=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBC9G-0006W1-RB for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 14:16:09 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 68SEFx2u011906
 for <openvpn-devel@lists.sourceforge.net>; Mon, 28 Sep 2026 16:15:59 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 68SEFxvG011905
 for openvpn-devel@lists.sourceforge.net; Mon, 28 Sep 2026 16:15:59 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 28 Sep 2026 16:15:53 +0200
Message-ID: <20260928141559.11880-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
References: <gerrit.1790604535000.I3b835558451414d8a4e8058114643555be69d391@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xBC9G-0006W1-RB
Subject: [Openvpn-devel] [PATCH v1] cppcheck: Fix handling of likely() on
 Windows
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

Since we do not force __GNUC__ to undefined on Windows
(since we want to support MinGW) cppcheck might stumble
upon __builtin_expect(). When running with gnu.cfg (which
we do not want to do for Windows code) then that has an
existing override. But for our Windows checks we need to
add our own override.

This caused false-positives in buffer code.

Change-Id: I3b835558451414d8a4e8058114643555be69d391
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1957
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1957
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@rfc2549.org>

        
diff --git a/dev-tools/openvpn-cppcheck-windows.cfg b/dev-tools/openvpn-cppcheck-windows.cfg
new file mode 100644
index 0000000..9ac7282
--- /dev/null
+++ b/dev-tools/openvpn-cppcheck-windows.cfg
@@ -0,0 +1,10 @@
+<?xml version ="1.0"?>
+<!-- Only used for the Windows run. Can't be in openvpn-cppcheck-library.cfg
+     because it conflicts with gnu.cfg. -->
+<def>
+  <!-- MinGW uses GCC, so we need to handle GCC builtins. gnu.cfg has these,
+       but we do not load it for Windows. Without this cppcheck does not
+       understand our likely()/unlikely() macros. -->
+  <define name="__builtin_expect(X,Y)" value="(X)" />
+  <define name="__builtin_expect_with_probability(exp,c,probability)" value="(exp)" />
+</def>
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
index 6b2c2be..3c71c83 100755
--- a/dev-tools/run-cppcheck.sh
+++ b/dev-tools/run-cppcheck.sh
@@ -49,7 +49,7 @@
     tests/unit_tests/plugins/ || ret=$?
 cppcheck $COMMON_ARGS \
     --platform=win64 \
-    --library=windows.cfg \
+    --library=windows.cfg --library=${SCRIPT_DIR}/openvpn-cppcheck-windows.cfg \
     -D_WIN32 \
     -UTARGET_LINUX -UTARGET_FREEBSD -UTARGET_OPENBSD -UTARGET_NETBSD \
     -UTARGET_DARWIN -UTARGET_ANDROID -UTARGET_SOLARIS -UTARGET_DRAGONFLY \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
