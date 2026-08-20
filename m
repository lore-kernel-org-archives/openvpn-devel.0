Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CAA5C5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RFlhMvQ9zn+jGhGVIZkyzxefKhsO07j7RnZNum9FVe4=; b=KWhEn0E7KygBGSCaROzslWooJh
	Zru4SN9fTAt0xyilY5GJ6D8jgcTNoxNMrFQ9CblAFi0f4WmUYEL//lfW82ghLGljrF4GdF4sIgQTV
	IJ2BCB59SItDiD124aPgVHTLsrWC+y7A1XA7oc/b3iVG84t6cmUXcYWvZoaMlMUCTRuQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwysv-0003T4-9n;
	Thu, 20 Aug 2026 09:16:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wwysu-0003Sx-3s
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 09:16:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9KRsbAmzW1Jt8PZEubB1vOQSP3PgXBHfiQtVuUsVZeI=; b=Zmq4MDGPIbR6lg52oAZ3jlaiDH
 Zeu9nDv0ZpTKquSehxSkgRWA3/URGJa7NrmPLfMQ9vcYPCfFr8bkDhbjpVA3m3NefyXUBCngxEUF1
 zhY9TA7xzmDmMkVzpJaSP/9Uoo+qt4+Gjk52K33Dir9V+parvLBGniiOv2zlP+RJyKwo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9KRsbAmzW1Jt8PZEubB1vOQSP3PgXBHfiQtVuUsVZeI=; b=Yaltox2hNvn4pjiZrfbl4exWV3
 w/uZErRERROM1NMNv024mCers61CGU/2j7vol7NT2jqXN6b4m7l79h7etLSkyCdnq5DCAN6757hFv
 z/N5KFmaOFvEIRjEtjnXs6YtFcnMWL87s+flAnVm/NzhMcqyzO8YHzTfhBePb6dz1wwc=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwyso-000871-JM for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 09:16:25 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67K9GFRX004672
 for <openvpn-devel@lists.sourceforge.net>; Thu, 20 Aug 2026 11:16:15 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67K9GFCe004671
 for openvpn-devel@lists.sourceforge.net; Thu, 20 Aug 2026 11:16:15 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 20 Aug 2026 11:16:09 +0200
Message-ID: <20260820091615.4656-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
References: <gerrit.1784305303000.Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wwyso-000871-JM
Subject: [Openvpn-devel] [PATCH v4] reformat-shell.sh: Add --simplify
 argument
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

And apply the changes.

Change-Id: Id4d04bebdb8b2cb56e8dd16a386c41fdb95c0413
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1794
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1794
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/dev-tools/reformat-shell.sh b/dev-tools/reformat-shell.sh
index dbbdaa9..d76eae7 100755
--- a/dev-tools/reformat-shell.sh
+++ b/dev-tools/reformat-shell.sh
@@ -5,7 +5,7 @@
 
 set -u
 
-FORMAT_ARGS="--indent=4 --func-next-line --case-indent"
+FORMAT_ARGS="--simplify --indent=4 --func-next-line --case-indent"
 FORMAT_CMD="shfmt --list --write"
 
 # hardcoded to --posix due to .in filename and invalid shebang
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 305441be..230a273 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -155,7 +155,7 @@
 fail()
 {
     output "FAIL: $@\n"
-    fail_count=$(($fail_count + 1))
+    fail_count=$((fail_count + 1))
 }
 
 # print "all interface IP addresses" + "all routes"
@@ -386,7 +386,7 @@
             ovpn_init_check=0
             ovpn_init_success=1
         fi
-        ovpn_init_check=$(($ovpn_init_check - 1))
+        ovpn_init_check=$((ovpn_init_check - 1))
     done
 
     opid=$(cat $pidfile)
diff --git a/tests/t_lpback.sh b/tests/t_lpback.sh
index 058206f..ec0a220 100755
--- a/tests/t_lpback.sh
+++ b/tests/t_lpback.sh
@@ -59,13 +59,13 @@
                 ;;
         esac
         e=1
-        tests_failed=$(($tests_failed + 1))
+        tests_failed=$((tests_failed + 1))
     else
         case $V in
             0 | 1) ;;       # no per-test output for 'OK'
             *) echo "OK" ;; # print all
         esac
-        tests_passed=$(($tests_passed + 1))
+        tests_passed=$((tests_passed + 1))
     fi
 }
 
diff --git a/tests/t_net.sh b/tests/t_net.sh
index 17e028e..d63f648 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -162,7 +162,7 @@
 # remove interface for good
 $RUN_SUDO ip link del $IFACE
 
-for i in $(seq $(($LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
+for i in $(seq $((LAST_AUTO_TEST + 1)) ${LAST_TEST}); do
     $RUN_SUDO $UNIT_TEST $i
     if [ $? -ne 0 ]; then
         echo "unit-test $i errored out"
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 3203cc2..9f4168b 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -164,7 +164,7 @@
             continue
         fi
         if $RUN_SUDO kill -0 $server_pid >/dev/null 2>&1; then
-            servers_up=$(($servers_up + 1))
+            servers_up=$((servers_up + 1))
         fi
     done
 


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
