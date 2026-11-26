Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE04606A326
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=AM75Ydo/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Z2MDf5RP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mdluTzrb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=mUxDbVSG5Yu7D43gJP90MDsMU82XLcqv/V7Zn5yU040=; b=AM75Ydo/KY/LGw
	3CTTLCugQDXyq7GacZGBnZ95dGBiIP6OV2V2UPh1nyJgIQPWxh8sJkTUXBj2JoB07gjFolei6pLNN
	i/pW3EKYgH4JJcWPCvWUL7pRD4C/MFk5r5GcsTIb86SX9p/Jvfj+ZQPlP/qDX1Ke+mb5YUvPHBCp/
	S6M=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWWeb-000000003d5-2bFY;
	Thu, 26 Nov 2026 10:24:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xWWeW-000000003cf-09L1 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:24:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6f4m5atxx3Hhg3/rgjDpZq8IQknwGKBR47x3L0nv+9o=; b=Z2MDf5RP6gyfRzNbC6zoRlM9bY
 BJALh3vSppRDEWaF+yeJ4KVd9Ccv+NeKr4ILpERxKeDitqSwKBhqme+rhmVfZWf6raSsiqpPj+g8s
 jqIUMG00VPqSgolOpBbhonHajW8RfQZQ4VLRgEzScRBFITupt3dap+JGuUtZHLjefUeE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6f4m5atxx3Hhg3/rgjDpZq8IQknwGKBR47x3L0nv+9o=; b=mdluTzrbBy4i5zVQ0xxGzSCxo8
 l5WrDS4oSSyFmem7E6iqjbTHkqFumEy8OSniL7raNu8Dk9utp6aRHUiGBLRMIxjHVrTHq9e2Q2v6/
 9//wOmR2i1ZlNI2mbCpXCY61jSopLoKirhS7F0L27akIOhxkjgMRj8QaHO5acvpteXkg=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWWeS-000000003Rg-0OqJ for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 10:24:29 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6AQAOL7l029816
 for <openvpn-devel@lists.sourceforge.net>; Thu, 26 Nov 2026 11:24:21 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AQAOLjN029815
 for openvpn-devel@lists.sourceforge.net; Thu, 26 Nov 2026 11:24:21 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Thu, 26 Nov 2026 11:24:14 +0100
Message-ID: <20261126102421.29800-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
References: <gerrit.1795675637000.I247474b43ac7a22d16a150a856ae5643657eacdb@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xWWeS-000000003Rg-0OqJ
Subject: [Openvpn-devel] [PATCH v2] dns-scripts: don't re-evaluate collected
 search domains
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Heiko Hund <heiko@ist.eigentlich.net>

$domains was expanded before eval, so the domains collected so far
were parsed as shell code again. Escape it like the indexed variable.

Change-Id: I247474b43ac7a22d16a150a856ae5643657eacdb
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2347
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2347
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Razvan Cojocaru <razvanc@mailbox.org>

        
diff --git a/distro/dns-scripts/haikuos_file-dns-updown.sh b/distro/dns-scripts/haikuos_file-dns-updown.sh
index e19b2b7..04e9e26 100644
--- a/distro/dns-scripts/haikuos_file-dns-updown.sh
+++ b/distro/dns-scripts/haikuos_file-dns-updown.sh
@@ -75,7 +75,7 @@
 
     test -z "$dns_search_domain_1" || {
         for i in $(seq 1 6); do
-            eval domains=\"$domains\$dns_search_domain_${i} \" || break
+            eval domains=\"\$domains\$dns_search_domain_${i} \" || break
         done
         text="${text}search $domains\n"
     }
diff --git a/distro/dns-scripts/resolvconf_file-dns-updown.sh b/distro/dns-scripts/resolvconf_file-dns-updown.sh
index 8d23ed6..78bf9d3 100644
--- a/distro/dns-scripts/resolvconf_file-dns-updown.sh
+++ b/distro/dns-scripts/resolvconf_file-dns-updown.sh
@@ -75,7 +75,7 @@
 
     test -z "$dns_search_domain_1" || {
         for i in $(seq 1 6); do
-            eval domains=\"$domains\$dns_search_domain_${i} \" || break
+            eval domains=\"\$domains\$dns_search_domain_${i} \" || break
         done
         text="${text}search $domains\n"
     }
diff --git a/distro/dns-scripts/systemd-dns-updown.sh b/distro/dns-scripts/systemd-dns-updown.sh
index 553056b..3bdaa4b 100644
--- a/distro/dns-scripts/systemd-dns-updown.sh
+++ b/distro/dns-scripts/systemd-dns-updown.sh
@@ -227,7 +227,7 @@
 
         test -z "$dns_search_domain_1" || {
             for i in $(seq 1 6); do
-                eval domains=\"$domains\$dns_search_domain_${i} \" || break
+                eval domains=\"\$domains\$dns_search_domain_${i} \" || break
             done
             text="${text}search $domains\n"
         }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
