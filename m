Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03E8C5B572
	for <openvpn-devel@archiver.kernel.org>; Sat, 22 Aug 2026 16:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fl+P8FLRJXdo0k5ngVDdIablu0Sn/2IQFZpdamqsN/0=; b=Yc5zHPmwNPDeJw1sLOqu0eQJdU
	scBFd+QjbBH4ODsiRWzhujuTFgWkgnsgxptXMVDCGxhM14pJBrJJ0ptMjTVhaz6MYYSkzurFMeSZJ
	dOI4mW3KRki2TkK8AW2FdP0bHuy6FjYSKP8kkASaU6y3HKkcp8mTMZoWptWM/7S1Su5Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wxoLB-00061b-AU;
	Sat, 22 Aug 2026 16:13:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wxoKr-00060x-1k
 for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:12:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ddyAWNPM+bKMi/whb6eDZzB/NPIDCuJz0QEXpv5a1VQ=; b=WW6mjpe3UOBQSFvKppGencBsVe
 qTQs9Avf/TU9T4zf4G8xyUNMdPYP7MTl9krdpqDH/K3FvwSyhd9QeXrRD3uJMj+EkvUPj+lheVUG2
 wDykMBN4E1RgMwCtRhJDHkxAa5G35xeNbty3EVGAk84orUXnJZQbd6KzIvapYtCIWvfM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ddyAWNPM+bKMi/whb6eDZzB/NPIDCuJz0QEXpv5a1VQ=; b=XAmBKnTFIErnMsPQCtt/cUXmta
 PbppPIik3ZhLZNUVjQsetfBUSKimF5rPNoy222FmSZILNQkDz6xLTM/cRcbQwC7USZiWSSd2U+Elg
 ewLq1uoQ751uvK6Pg33w8IEZhv0MrkOpcD1UKopqkUxRUZcOUBjp7JRI9kc7UQDnA3ac=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wxoKa-0003xR-5U for openvpn-devel@lists.sourceforge.net;
 Sat, 22 Aug 2026 16:12:29 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67MGCLOs004172
 for <openvpn-devel@lists.sourceforge.net>; Sat, 22 Aug 2026 18:12:21 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67MGCLGE004162
 for openvpn-devel@lists.sourceforge.net; Sat, 22 Aug 2026 18:12:21 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Sat, 22 Aug 2026 18:12:15 +0200
Message-ID: <20260822161220.4145-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
References: <gerrit.1782741377000.Ia4a9a6bafb6bcb3fe331a92cfbb64be78f6aa33a@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wxoKa-0003xR-5U
Subject: [Openvpn-devel] [PATCH v3] t_client.sh.in: Allow to override the
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
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 2a4bdb4..003dec4 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -14,8 +14,8 @@
 #FPING_EXTRA_ARGS="-t 1000"
 
 # Load EXPECT_IFCONFIG* parameters from cache
-if [ -r "${top_builddir}/t_client_ips.rc" ]; then
-    . "${top_builddir}/t_client_ips.rc"
+if [ -r "${t_client_ips_rc}" ]; then
+    . "${t_client_ips_rc}"
 else
     echo "NOTICE: missing t_client_ips.rc will be auto-generated"
 fi
@@ -63,6 +63,12 @@
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
 # CHECK_SKIP_x      = "commands to execute before openvpn, skip test on failure"
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 0ef2ec5..9f32a5a 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -19,6 +19,9 @@
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
 openvpn="${openvpn:-${top_builddir}/src/openvpn/openvpn}"
+t_client_ips_rc="${t_client_ips_rc:-${top_builddir}/t_client_ips.rc}"
+update_t_client_ips="${update_t_client_ips:-${srcdir}/update_t_client_ips.sh}"
+
 if [ -r "${top_builddir}"/t_client.rc ] ; then
     . "${top_builddir}"/t_client.rc
 elif [ -r "${srcdir}"/t_client.rc ] ; then
@@ -326,7 +329,7 @@
     # If EXCEPT_IFCONFIG* variables for this test are missing, run an --up
     # script to generate them dynamically.
     if [ -z "$expect_ifconfig4" ] || [ -z "$expect_ifconfig6" ]; then
-        up="--setenv TESTNUM $SUF --setenv TOP_BUILDDIR ${top_builddir} --script-security 2 --up ${srcdir}/update_t_client_ips.sh"
+        up="--setenv TESTNUM $SUF --setenv RC ${t_client_ips_rc} --script-security 2 --up ${update_t_client_ips}"
     else
         up=""
     fi
diff --git a/tests/update_t_client_ips.sh b/tests/update_t_client_ips.sh
index 96e3826..013504f 100755
--- a/tests/update_t_client_ips.sh
+++ b/tests/update_t_client_ips.sh
@@ -2,9 +2,6 @@
 #
 # This --up script caches the IPs handed out by the test VPN server to a file
 # for later use.
-
-RC="$TOP_BUILDDIR/t_client_ips.rc"
-
 grep EXPECT_IFCONFIG4_$TESTNUM= $RC > /dev/null 2>&1
 if [ $? -ne 0 ]; then
     echo "EXPECT_IFCONFIG4_$TESTNUM=$ifconfig_local" >> $RC


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
