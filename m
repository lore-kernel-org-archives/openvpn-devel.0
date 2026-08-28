Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EEDC61DB9
	for <openvpn-devel@archiver.kernel.org>; Fri, 28 Aug 2026 09:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+0t/wAEiA9PfMbPcrSGItUvvHkwBi/XT3uQOtBdTkxE=; b=AnFAPc3tVCKyw99jPBi2iOGS2S
	/DAcbu8ya+KOjaFQJzJ+K9riI8UCqjukTC3AhnDjapsvh1dFZQm23COrYpvQfQhOBn9DsES59sNlC
	WDmhvGoHG6+VLNSHLV54l8h+1KFEjOBCnXoieBTLXgF9WVLDEsxpPZtUkoQwVUnyuRdQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wztH5-0005Hu-OD;
	Fri, 28 Aug 2026 09:53:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@blue4.greenie.muc.de>) id 1wztGo-0005Hd-SI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 09:53:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GY7yZoGy85Rb7teCryeoF0S/9zqnSNjqUkfFc8VogKY=; b=Wv3+4bz16uGrSZcRIy08uHIqJW
 dk76aRpVGUtyYN8MrZzpIfi5d8gPIblimx952lyDcZSpV+2oqtd17MOpJcJJpfcSE9cBBmMeoKHeg
 xi11QHlwIKzO5vbFsmr+0Kotp63kJXUOxDZi1qJZovoWX1NgyqYCqtmyyJK2zDC5OfKg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GY7yZoGy85Rb7teCryeoF0S/9zqnSNjqUkfFc8VogKY=; b=QrxqjSA3QszCgtTSd+QGn/FdX9
 FjDIKqjB2G8NMtMVY0JGvEvasKodZSO9I4h2o/7mA1iC+qBz6Csk/Grtq46FVVwyzYcWc9hBnnRiW
 fY85SghbmV7x4t87jdb5ZULIxw0eZ5Yqzl0OUmha2szTlwpc5Z/eG/kFvJKaH5BXc/8w=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wztGn-0006ir-GN for openvpn-devel@lists.sourceforge.net;
 Fri, 28 Aug 2026 09:53:10 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 67S9r1SS009667
 for <openvpn-devel@lists.sourceforge.net>; Fri, 28 Aug 2026 11:53:01 +0200
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 67S9r17I009666
 for openvpn-devel@lists.sourceforge.net; Fri, 28 Aug 2026 11:53:01 +0200
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Fri, 28 Aug 2026 11:52:52 +0200
Message-ID: <20260828095300.9652-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
References: <gerrit.1782933852000.I1905d9494336da4e91f1946d2ffd875720605b41@gerrit.openvpn.net>
MIME-Version: 1.0
X-Headers-End: 1wztGn-0006ir-GN
Subject: [Openvpn-devel] [PATCH v5] t_client.sh.in: Add utility function
 needs_openvpn()
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

This allows to skip tests on old versions of openvpn.
Makes it much easier to maintain a t_client.rc across
multiple versions.

Change-Id: I1905d9494336da4e91f1946d2ffd875720605b41
Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1763
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1763
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 7c23020..c3a9655 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -22,14 +22,16 @@
 t_client_ips_rc="${t_client_ips_rc:-${top_builddir}/t_client_ips.rc}"
 update_t_client_ips="${update_t_client_ips:-${srcdir}/update_t_client_ips.sh}"
 
-if [ -r "${top_builddir}"/t_client.rc ]; then
-    . "${top_builddir}"/t_client.rc
-elif [ -r "${srcdir}"/t_client.rc ]; then
-    . "${srcdir}"/t_client.rc
-else
-    echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
-    echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
-    exit "${TCLIENT_SKIP_RC}"
+if [ -z "${t_client_rc}" ]; then
+    if [ -r "${top_builddir}"/t_client.rc ]; then
+        t_client_rc="${top_builddir}"/t_client.rc
+    elif [ -r "${srcdir}"/t_client.rc ]; then
+        t_client_rc="${srcdir}"/t_client.rc
+    else
+        echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
+        echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
+        exit "${TCLIENT_SKIP_RC}"
+    fi
 fi
 
 # Check for external dependencies
@@ -63,6 +65,18 @@
     exit 1
 fi
 
+openvpn_version=$(${openvpn} --version | head -n 1 | cut -f2 -d" " | sed -E 's/^2\.([0123456789]+).*$/2\1/')
+
+needs_openvpn()
+{
+    needs_version=$1
+
+    [ "$openvpn_version" -ge "$needs_version" ]
+    return $?
+}
+
+. "${t_client_rc}"
+
 if [ -z "$TEST_RUN_LIST" ]; then
     echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
     exit "${TCLIENT_SKIP_RC}"


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
