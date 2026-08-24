Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC2FEC5DF9C
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 18:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sohn757pKl1WcXHDAMhInVHxnEvei17f65/rgihh73k=; b=EOme++2+1R60mHozsz5mSyyg6L
	B5xMm5JsgTM2/W7RFxo6QVeNXli5M+RRqj6Ekpvqr+jYzVOmHu7hC9hYmFXkoiwkGOlRr5a+xHuCd
	q1HeMwLraIy0xaO12rEn8d8m6oUjGTN0T1LyjXF0X3gJ/JStOguRtXU3Tc9Z0WgOjbo8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyZ1l-0004yp-K3;
	Mon, 24 Aug 2026 18:04:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wyZ1j-0004yj-V6
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 18:04:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c5F/IKv50IDWuBpnyOalNOukiG+/fDQQRz+1le+QFg4=; b=bXnLyiUV6ocMp8HIyZcMMZwvGm
 Hb4iH+kH9K+6Cd9pKVKVzJfqa7+7bQajdqSAZCzCzMFbCRJ0BXY6KVAtqtQIbF5iSOK+Y6/jadgW1
 8GcBsLg0EhKlYGSYJMxgFdw17bEgItyFD5QPCT/CsFzSMUNRmWA/W+YvjQeKH7yh2PBw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=c5F/IKv50IDWuBpnyOalNOukiG+/fDQQRz+1le+QFg4=; b=beKnXBXNCGEwAdhKP7BOWeimAx
 bgssX7ADDMsaOTnssoqtiDiE2rvb+APSaVxlqja2Mj3E+cpuWnGYvW35MmG1wSU2/kDrZ6VUfUnO8
 p/ZJvZ9Q/H4NkHQtYPg6YjnzRmntxcHjasJje9r8POV5tCnRwBeJTWncwy40E2BYH47c=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyZ1f-00060t-D2 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 18:04:05 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67OI3ukD012100
 for <openvpn-devel@lists.sourceforge.net>; Mon, 24 Aug 2026 20:03:56 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67OI3u1E012099
 for openvpn-devel@lists.sourceforge.net; Mon, 24 Aug 2026 20:03:56 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Mon, 24 Aug 2026 20:03:47 +0200
Message-ID: <20260824180353.12076-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wyZ1f-00060t-D2
Subject: [Openvpn-devel] [PATCH v5] t_client.sh.in: Allow to override the
 location of t_client_ips.rc
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

Makes it easier to use t_client.sh in other contexts.

This is based on work by Gert Doering for the t_server
test infrastructure.

Change-Id: Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1756
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1756
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 04714ef..4c87436 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -18,8 +18,8 @@
 #FPING_EXTRA_ARGS="-t 1000"
 
 # Load EXPECT_IFCONFIG* parameters from cache
-if [ -r "${top_builddir}/t_client_ips.rc" ]; then
-    . "${top_builddir}/t_client_ips.rc"
+if [ -r "${t_client_ips_rc}" ]; then
+    . "${t_client_ips_rc}"
 else
     echo "NOTICE: missing t_client_ips.rc will be auto-generated"
 fi
@@ -67,6 +67,12 @@
 # PING6_HOSTS_x      = "these hosts musts ping when openvpn is up (IPv6 fping6)"
 # EXPECT_FAIL_x      = "instead of waiting for connection wait for this error message"
 #
+# Note that the EXPECT_IFCONFIG{4,6} options are not generally required, the
+# tests will remember the ip address they got on the first run in t_client_ips.rc
+# and will expect to get the same address again. But it can be useful to hard-code
+# the IP when the server is expected to send a very specific address, e.g. when
+# using ccd on the server-side or in a P2P scenario.
+#
 # hook test options:
 #
 # FPING_ARGS_x      = "arguments to append to the fping command line"
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index dd7f743..7c23020 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -19,6 +19,9 @@
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
 openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
+t_client_ips_rc="${t_client_ips_rc:-${top_builddir}/t_client_ips.rc}"
+update_t_client_ips="${update_t_client_ips:-${srcdir}/update_t_client_ips.sh}"
+
 if [ -r "${top_builddir}"/t_client.rc ]; then
     . "${top_builddir}"/t_client.rc
 elif [ -r "${srcdir}"/t_client.rc ]; then
@@ -327,7 +330,7 @@
     # If EXCEPT_IFCONFIG* variables for this test are missing, run an --up
     # script to generate them dynamically.
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; then
-        up="--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --script-security 2 --up ${srcdir}/update_t_client_ips.sh"
+        up="--setenv TESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-security 2 --up ${update_t_client_ips}"
     else
         up=""
     fi
diff --git a/tests/update_t_client_ips.sh b/tests/update_t_client_ips.sh
index 777a286..f02dc7f 100755
--- a/tests/update_t_client_ips.sh
+++ b/tests/update_t_client_ips.sh
@@ -3,8 +3,6 @@
 # This --up script caches the IPs handed out by the test VPN server to a file
 # for later use.
 
-RC="$TOP_BUILDDIR/t_client_ips.rc"
-
 grep EXPECT_IFCONFIG4_$TESTNUM= $RC >/dev/null 2>&1
 if [ $? -ne 0 ]; then
     echo "EXPECT_IFCONFIG4_$TESTNUM=$ifconfig_local" >>$RC


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
