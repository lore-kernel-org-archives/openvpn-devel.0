Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59859CA9EBD
	for <openvpn-devel@archiver.kernel.org>; Fri,  9 Oct 2026 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AwblQdjBXFGQVIJ0ubglvnys4XpfNGJLw0WZXVIMgic=; b=bYrPqBOYmiGpxkV3OjRn+YB68O
	n0eS72mSB25WNqIpiz09MVxU60ucNl2NgcsfUF142wR+2xFwC7iWxEFAF5h87+LUVkPOMqGy2zHzf
	pR3Cen3a5qPeJpNOeDRzQILeH/eOqmYLkhWf8GQmLSc7Jq8UBcVCfH8a73M354D9ZIvQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xFE1y-0003rf-15;
	Fri, 09 Oct 2026 17:05:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1xFE1v-0003rW-3K
 for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 17:05:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=00+qj1lbPPK86bBpoGYJvT2fTdUI/QctV25BDN31skE=; b=EO3+c7tWlD0A4WOrTklC+FXSZs
 E2gWcNTPP1EC+lGRmQZ6PlWoBEtCYahbTjqWLV/U4Dhu0H7/uh9YDI6J+QmG+fLhjmTiaMYTOC1/J
 F9DRHOOo+Po4uH0bhSVU8xxOoPL/rbb2pk8MoAsVBq2QdFYrVj05QUACG5UqTADw6/o8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=00+qj1lbPPK86bBpoGYJvT2fTdUI/QctV25BDN31skE=; b=nWAaHO2DfZTFs8HVkz7j94b5Ef
 eky0jg4KOfqw6dEr4LeVUyFjDKCbF5IYu0Uf/UHf1vAItaAw3x1TqktVZ95aPwpP3GicAg4nIYcA1
 8AIT6FeyfraF0rgoMUirWNCKsQyW/4UhnMgJm1P5oLRXhdMyFdrquxxaF2emC/YK5j+g=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xFE1q-0006I0-FU for openvpn-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 17:05:08 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 699H4xec016645
 for <openvpn-devel@lists.sourceforge.net>; Fri, 9 Oct 2026 19:04:59 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 699H4x0h016644
 for openvpn-devel@lists.sourceforge.net; Fri, 9 Oct 2026 19:04:59 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri,  9 Oct 2026 19:04:52 +0200
Message-ID: <20261009170458.16623-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
References: <gerrit.1787928357000.I07b373851175d865abdb1513f90655b3fa31d5fa@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1xFE1q-0006I0-FU
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

From: Frank Lichtenheld <frank@lichtenheld.com>

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
