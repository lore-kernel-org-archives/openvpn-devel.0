Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F73C61DBE
	for <openvpn-devel@archiver.kernel.org>; Tue, 25 Aug 2026 15:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NL22E/Yi2Vb+ZkkHuxYlor+IA0qIDgbbCkwnR/Fyz5U=; b=aQjs5r93hH82FJb1MXb5A/zixh
	NxP6iXPe+rEzeScLXz1bYDbibkXOEgmg7GxK/T48dmb/XCH4sgY+pzcYH3VG7UURX6zN3VMUbU8cE
	F0OFxI4tSrpHLTMXWcUtYCw3k807zgW8x0kj2MVWUnBjCMpFgWxA1Pka18aPkXdz9g2g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wytT6-0002Dq-Dt;
	Tue, 25 Aug 2026 15:53:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wytSy-0002Df-F6
 for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:53:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LrFBpYjCctKc0Sp44UY5IsQZJpMkzKP1vwDWADL26/8=; b=EFj3gSDSDcUv3uNiCK534oDvlK
 iPHj+ex2a2pvxy/ZCKsN4QFsild7lbjxjFypIFIiuUhjXqW8kApqnLrBHE/IlYL+xCcBliSpcNOUm
 m6ZU8UYMw/hE30svmg46/JFpMggP44HUnNBC0k4vpkx9GtodaiKpjB+N6Nav912Gfi/Q=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LrFBpYjCctKc0Sp44UY5IsQZJpMkzKP1vwDWADL26/8=; b=TcJfaQzMvY0asCvQEP8wIapilX
 1mu3FF0qJfi8Mk0jIzTqmQBhn2/bzRuw5me6DUZX9p2AeMJL96rKcANTRihBYwTcB//b5hfuWq4Q6
 VuB2SMRDqc4h1i0Qd23ypAWn6uv/ULq/dE/1zVP+re0SAex9uKOp87Dl62+r54rbTZZM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wytSt-0002Px-VS for openvpn-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 15:53:33 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67PFrPvr004972
 for <openvpn-devel@lists.sourceforge.net>; Tue, 25 Aug 2026 17:53:25 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67PFrPiP004971
 for openvpn-devel@lists.sourceforge.net; Tue, 25 Aug 2026 17:53:25 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 25 Aug 2026 17:53:19 +0200
Message-ID: <20260825155325.4960-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
References: <gerrit.1782741377000.I6c51bcdda5666e0dab2adcdaff28408c9bfcb844@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wytSt-0002Px-VS
Subject: [Openvpn-devel] [PATCH v5] t_client.sh.in: Add support for expected
 test failures
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

Allow to mark tests that must fail. The EXPECT_FAIL
message must contain a message that can be found in
the log output. OpenVPN must not start up successfully,
so this does not allow to test for failures that only
affect the traffic over the link.

This is based on work by Gert Doering for the t_server
test infrastructure.

Change-Id: I6c51bcdda5666e0dab2adcdaff28408c9bfcb844
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1755
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1755
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):

        
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index a35d185..04714ef 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -65,6 +65,7 @@
 # EXPECT_IFCONFIG6_x = "this IPv6 address needs to show up in ifconfig"
 # PING4_HOSTS_x      = "these hosts musts ping when openvpn is up (IPv4 fping)"
 # PING6_HOSTS_x      = "these hosts musts ping when openvpn is up (IPv6 fping6)"
+# EXPECT_FAIL_x      = "instead of waiting for connection wait for this error message"
 #
 # hook test options:
 #
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 230a273..dd7f743 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -321,6 +321,7 @@
     eval expect_ifconfig6=\"\$EXPECT_IFCONFIG6_$SUF\"
     eval ping4_hosts=\"\$PING4_HOSTS_$SUF\"
     eval ping6_hosts=\"\$PING6_HOSTS_$SUF\"
+    eval expect_fail=\"\$EXPECT_FAIL_$SUF\"
     eval fping_args=\"\$FPING_EXTRA_ARGS \$FPING_ARGS_$SUF\"
 
     # If EXCEPT_IFCONFIG* variables for this test are missing, run an --up
@@ -332,6 +333,9 @@
     fi
 
     output_start "### test run $SUF: '$test_run_title' ###"
+    if [ -n "$expect_fail" ]; then
+        output "### expect failure: '$expect_fail'"
+    fi
     fail_count=0
 
     if [ -n "$test_check_skip" ]; then
@@ -380,23 +384,62 @@
     ovpn_init_check=30
     ovpn_init_success=0
     while [ $ovpn_init_check -gt 0 ]; do
-        sleep 1 # Wait for OpenVPN to initialize and have had time to write the pid file
-        grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >/dev/null
-        if [ $? -eq 0 ]; then
-            ovpn_init_check=0
-            ovpn_init_success=1
+        sleep 1 # Wait for OpenVPN to initialize and to write the pid file
+        if [ -n "$expect_fail" ]; then
+            grep "$expect_fail" $LOGDIR/$SUF:openvpn.log >/dev/null
+            if [ $? -eq 0 ]; then
+                ovpn_init_check=0
+                ovpn_init_success=1
+                sleep 5 # give openvpn time to quit
+            fi
+        else
+            grep "Initialization Sequence Completed" $LOGDIR/$SUF:openvpn.log >/dev/null
+            if [ $? -eq 0 ]; then
+                ovpn_init_check=0
+                ovpn_init_success=1
+            fi
         fi
         ovpn_init_check=$((ovpn_init_check - 1))
     done
 
-    opid=$(cat $pidfile)
+    opid=$([ -e $pidfile ] && cat $pidfile)
     if [ -n "$opid" ]; then
         output "  OpenVPN running with PID $opid"
     else
-        output "  Could not read OpenVPN PID file"
+        if [ -z "$expect_fail" ]; then # print this only if unexpected
+            output "  Could not read OpenVPN PID file"
+        fi
     fi
 
-    # If OpenVPN did not start
+    # did we expect a failure?
+    if [ -n "$expect_fail" ]; then
+        if [ -n "$opid" ]; then # OpenVPN did start!
+            output "$0: OpenVPN did start up, expected failure"
+            $RUN_SUDO $KILL_EXEC $opid $sudopid
+            output "tail -5 $SUF:openvpn.log"
+            output "$(tail -5 $LOGDIR/$SUF:openvpn.log)"
+            fail "skip rest of sub-tests for test run $SUF."
+            trap - 0 1 2 3 15
+            SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
+            exit_code=32
+            printf "$outbuf"
+            continue
+        elif [ $ovpn_init_success -eq 0 ]; then
+            output "$0: OpenVPN failure did not match expected failure"
+            output "tail -5 $SUF:openvpn.log"
+            output "$(tail -5 $LOGDIR/$SUF:openvpn.log)"
+            SUMMARY_FAIL="$SUMMARY_FAIL $SUF"
+            exit_code=33
+            printf "$outbuf"
+            continue
+        else
+            output "test run $SUF: all tests OK (saw expected failure)."
+            SUMMARY_OK="$SUMMARY_OK $SUF"
+            continue
+        fi
+    fi
+
+    # If OpenVPN did not start but should have
     if [ $ovpn_init_success -ne 1 -o -z "$opid" ]; then
         output "$0:  OpenVPN did not initialize in a reasonable time"
         if [ -n "$opid" ]; then


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
