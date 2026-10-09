Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 549C2CA6015
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AFIRoYXSP9ojy158tQ809DUgdxGA+gyaqUIygVvXQPE=; b=gVKmWMq/FaVP5TGk1rar6ObTcE
	WC/eKeJckN4Rtnp3fVa/XoHUF5DnhGT5e2P6zblUjcsrjFvCQur9LNacDAKVGn5L6EQo0KL62fbLp
	YCKcUrv/iYA0t/5uLuVWgRIE6KIMPO8hB/Tanp8NHmi2vrgo4QEUq1mI+BMM0KQ/3i3A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFDIK-0003w1-U4;
	Fri, 09 Oct 2026 16:18:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1xFDI8-0003vb-9f
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:17:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2Z5KaH/6hotUsdOkhxhUjMnKmDtljGRc8x+L1LlpurY=; b=kD7voPRMlbensyZBDSp5miapbC
 MjgQf/tORjwwrozAnQUCUIl5YgPq2TyhK9/NrZbAkc1e9sK6TeARxbtcRRGcGzSIsOLPNQ3WAByMD
 uEEStOKUri84AD+gE9SzYkbR+mR7Z0pg5Ubsc7zDTWnuEGMyhF4gAo7YLpGLz5E+FDdo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2Z5KaH/6hotUsdOkhxhUjMnKmDtljGRc8x+L1LlpurY=; b=NRNOMHby2xaExAtRJIkEGpN3YX
 4pXqmt89ZW4mYtYstNsY9zsDF8a58o0p1E9xk/ppiZM7u1ge1BocxMJMtBFAYIANnCtmIhM9piV47
 MH4Ej4sYRArKbEcBOK0NSdnDx2sjS5deN/V2N+mPsMLcZy3+APgbSTiTQE/iMdQS4i7A=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFDI7-0005Fh-AB for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 16:17:52 +0000
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4j1X865R27zKnT6
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 18:17:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1791562662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Z5KaH/6hotUsdOkhxhUjMnKmDtljGRc8x+L1LlpurY=;
 b=IlrsbZ9XxiOxOAOt7fMxLKWUYXXu7QzkdnhGF81uutMxrkPTCHQ91PrHE2miTFsU2nF933
 +PS1CoCsvw6M7FEMkW+kXnzDu0tUAPTPnT/eqxMo+AK44XUxvis5J6bRcAeopy0DugmqOb
 c3101sk8WX77LPd/+GjvKXPbtlpxyk0J8MJ6oVJ9ILzH0it2GqetNW0fOGKqXUWb8Md+da
 TSKYIJo9KoTB2NqFJUicsWZ8zgFZIRl9BpbPiFT4AY/gfmZpNkg+EeWQTaD95PsxpWxaxi
 Jwrg+sSGs8E9YwR8RtL0OUMG3AIX6Nih5fTaYe3aPS1DcGoykONVn49/aifFeA==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  9 Oct 2026 18:17:41 +0200
Message-ID: <20261009161741.79370-1-frank@lichtenheld.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4j1X865R27zKnT6
X-Headers-End: 1xFDI7-0005Fh-AB
Subject: [Openvpn-devel] [PATCH v2] t_client.sh.in: Check whether addresses
 are in "tentative" state
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

We see this sometimes with IPv6 addresses (especially
in t_server context). Make sure we wait until the
tentative state is removed. Otherwise we might get
spurious failures on comparing state.

Change-Id: I07b373851175d865abdb1513f90655b3fa31d5fa
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1882
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1882
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 0568007..5e924bb 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -264,6 +264,27 @@
 }
 
 # ----------------------------------------------------------
+# check ifconfig output on whether some address is in "tentative" state
+# repeats calling get_ifconfig_route until it does not
+#  arg1: log file
+check_tentative_state()
+{
+    logfile="$1"
+    network_tentative_check=0
+    while grep -q tentative $logfile; do
+        output "waiting for tentative state to end ($network_tentative_check)"
+        if [ "$network_tentative_check" -ge 30 ]; then
+            fail "network interface stuck in tentative state"
+            return 1
+        fi
+        sleep 1
+        network_tentative_check=$((network_tentative_check + 1))
+        get_ifconfig_route >$logfile
+    done
+    return 0
+}
+
+# ----------------------------------------------------------
 # check ifconfig
 #  arg1: "4" or "6" -> for message
 #  arg2: IPv4/IPv6 address that must show up in out of "get_ifconfig_route"
@@ -392,6 +413,10 @@
 
     output "save pre-openvpn ifconfig + route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_pre.txt
+    if ! check_tentative_state $LOGDIR/$SUF:ifconfig_route_pre.txt; then
+        printf "$outbuf"
+        exit 1
+    fi
 
     output "\nrun pre-openvpn ping tests - targets must not be reachable..."
     run_ping_tests 4 want_fail "$ping4_hosts"
@@ -498,6 +523,10 @@
     # compare whether anything changed in ifconfig/route setup?
     output "save ifconfig+route"
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route.txt
+    if ! check_tentative_state $LOGDIR/$SUF:ifconfig_route.txt; then
+        printf "$outbuf"
+        exit 1
+    fi
 
     if [ "$expect_ifconfig4" = "-" ]; then
         output "skip ifconfig+route check"
@@ -535,6 +564,10 @@
 
     output "\nsave post-openvpn ifconfig + route..."
     get_ifconfig_route >$LOGDIR/$SUF:ifconfig_route_post.txt
+    if ! check_tentative_state $LOGDIR/$SUF:ifconfig_route_post.txt; then
+        printf "$outbuf"
+        exit 1
+    fi
 
     output -n "compare pre- and post-openvpn ifconfig + route..."
     if diff $LOGDIR/$SUF:ifconfig_route_pre.txt \


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
