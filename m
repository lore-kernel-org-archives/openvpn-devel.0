Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03637C61DB9
	for <openvpn-devel@archiver.kernel.org>; Thu, 27 Aug 2026 17:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gWMfSQ+ZBTb9xS0jjhOgU3it/QWtdkDBsvKuZwTrUu0=; b=N/i1STKm0fB8LunI/468bDPxhZ
	kuoQP6fXjJ5MzwEYb5PufvjjinBRNE+nsMaWemVQoSpmsBwb0c7D7D23E+d+rcHaqiNc1m7X6BaVG
	PkGGkcL+JF5o5ue/WY4L2zvavlo36krIrQqz/rMD3k1UY9xUF/fk35NcXsRADXbiZeok=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wzdVz-0005If-DQ;
	Thu, 27 Aug 2026 17:03:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wzdVm-0005Gz-IJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 17:03:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IHA/gHyJtuKwzkbzv3iaAbt5EsNwUkxhj8pXBHwYNBU=; b=k+Hm4pSIzWxICC/6dJ36hY75uO
 QpctBGtbyP3yPvNDAxu2T/eLsMEhQ7du7Vcds9ghvY+e55tGvcZf2d+mZ4Siodm4QEPJi6m+IfVgi
 vcUuABerQp6tans3ZJAVflMb9WyCg6SbV9frpo6qO1N7xItS4FJp6XP53h4OlH6xkwuI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IHA/gHyJtuKwzkbzv3iaAbt5EsNwUkxhj8pXBHwYNBU=; b=L/oKjjv3vWKzHbKxXwY7E2AMbD
 RwtyL3IIkHa8NYqxxL0Yak9TANr/n/YSFlS7VbGmLIpF27ltH1rTDYpjerCGkGjLHY0Qgwsg7p8kt
 lOTguaIGNDakRiLKFDCu13DVTkaJgc/3JguwzXQ30WM+oPu6gbsj5Ff1fv8Z1EF+Ax54=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzdVl-0005vF-TP for openvpn-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 17:03:35 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67RH3QiO013177
 for <openvpn-devel@lists.sourceforge.net>; Thu, 27 Aug 2026 19:03:26 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67RH3Qgr013176
 for openvpn-devel@lists.sourceforge.net; Thu, 27 Aug 2026 19:03:26 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 27 Aug 2026 19:03:20 +0200
Message-ID: <20260827170326.13161-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
References: <gerrit.1783945377000.I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wzdVl-0005vF-TP
Subject: [Openvpn-devel] [PATCH v7] t_client.sh.in: Add ability to filter by
 test group
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

Since we generally set this up in a way that one test
group corresponds to one server, it can be useful to
filter by the group. E.g. this allows one to potentially
parallelize test runs against different servers.

Change-Id: I4ebeb8c1f0f942da9b2e25f18f88566f8372fabf
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1777
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1777
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 4c87436..defa4aa 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -31,6 +31,21 @@
 #
 # tests to run (list suffixes for config stanzas below)
 #
+# The general idea is to use one number per server, so
+# e.g. use 1 for all tests talking to a UDP server, use
+# 2 for tests talking to a TCP server, and 3 for tests
+# talking to a P2P server.
+#
+# The indivdiual tests should then be indexed by using
+# letters.
+#
+# If you set TEST_RUN_GROUP=<number> then t_client.sh
+# will only run tests starting with that number. So
+# e.g. setting TEST_RUN_GROUP=1 will run 1 and 1a, but
+# not 2. This can be used to excercise only a specific
+# server, or to run tests against separate servers in
+# parallel.
+#
 TEST_RUN_LIST="1 2 2n"
 
 #
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index c3a9655..0568007 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -82,6 +82,21 @@
     exit "${TCLIENT_SKIP_RC}"
 fi
 
+if [ -n "$TEST_RUN_GROUP" ]; then
+    FILTERED_LIST=
+    for test in $TEST_RUN_LIST; do
+        group=$(echo $test | sed -E 's/^([0123456789]+).*/\1/')
+        if [ "$group" = "$TEST_RUN_GROUP" ]; then
+            FILTERED_LIST="$FILTERED_LIST $test"
+        fi
+    done
+    if [ -z "$FILTERED_LIST" ]; then
+        echo "Filtered TEST_RUN_LIST empty (group=$TEST_RUN_GROUP), no tests defined.  SKIP test." >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
+    TEST_RUN_LIST=$FILTERED_LIST
+fi
+
 # Ensure PREFER_KSU is in a known state
 PREFER_KSU="${PREFER_KSU:-0}"
 
@@ -121,6 +136,9 @@
 fi
 
 LOGDIR=t_client-$(hostname)-$(date +%Y%m%d-%H%M%S)
+if [ -n "$TEST_RUN_GROUP" ]; then
+    LOGDIR="${LOGDIR}-${TEST_RUN_GROUP}"
+fi
 LOGDIR_ABS="$PWD/$LOGDIR"
 if mkdir $LOGDIR; then
     :


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
