Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A6D606A32D
	for <openvpn-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GLaTYFh+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KhP5Et2k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=i1kopoJk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=9sjIgT6N2X6/lyE7pO/5mbBNkjWyaxyZ3JRzRHXukmA=; b=GLaTYFh+e2BFS3
	h3rSB0VTlSKAqIJCk0wjwp+TX+OBt0S5ATLuoVuig86ysJbpdca7aC4/sXIRh6OLBbJTYlexP+JZ7
	mqhPHuAw9tyWlZ1I1gi1p+0nzCmmz/lVUIK38Qd+bB2d/sNjeEQAlvrTZ3X1f+J2v3/3wpnE8WEiD
	mQA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOJVI-000000006Kz-3Xu0;
	Tue, 03 Nov 2026 18:45:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOJVH-000000006Ko-1rHj for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dtDMVTi21q0zRHqIhyq8vwIBsNAeIyN0f2MLDv6U6oU=; b=KhP5Et2kQ9W8ZkqUrnGd2sDm7S
 7shWUWcdT/pWy2tRtid5JQNaZtDU/3gF1hgDCDEHzyeNyKInY08NGFQSlqDT/kIRhMD7kXWDIlEFx
 PEpd1kFZ30ZZvvOgU3p8v5DPyDoAJlyNuK+JRzp6pwQ6JDaUJeMQVF2L7/xcjO+UZSMI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dtDMVTi21q0zRHqIhyq8vwIBsNAeIyN0f2MLDv6U6oU=; b=i1kopoJk2NjQSezGUxfQJng+5D
 yWV+iNW+F2Gnj7ZOUap9aivh+J84y8r7p+Eg5ZilrQ+TO4aeTSHo5itcxJHb/JSV9B+l5OlHq8ROW
 POeYT0d+Oko0LQOcC+EANyYAlQXvgSm7uPkDBzMJ8C2g83j7R+3tz5SeY4yoZa2bjtH0=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOJVE-000000005CH-2Mwg for openvpn-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 18:45:03 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A3Iirog009567
 for <openvpn-devel@lists.sourceforge.net>; Tue, 3 Nov 2026 19:44:53 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A3Iir3N009566
 for openvpn-devel@lists.sourceforge.net; Tue, 3 Nov 2026 19:44:53 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue,  3 Nov 2026 19:44:45 +0100
Message-ID: <20261103184453.9550-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
References: <gerrit.1793731291000.I9eb4b74b53d680c160b8ac65ab844f6404431e62@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOJVE-000000005CH-2Mwg
Subject: [Openvpn-devel] [PATCH v1] openvpnserv: check DhcpNameServer lookup
 in GetItfDnsServersV4()
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

From: Razvan Cojocaru <razvanc@mailbox.org>

The RegGetValueA() result for DhcpNameServer was discarded and the
error from the earlier NameServer lookup was tested instead. With no
NameServer value, err was still ERROR_FILE_NOT_FOUND, so the DHCP
fallback always failed.

Broken since 0f3b7d17 ("win: implement --dns option support with
NRPT").

Change-Id: I9eb4b74b53d680c160b8ac65ab844f6404431e62
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Gert Doering <gert@greenie.muc.de>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2109
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2109
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@greenie.muc.de>

        
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 484f27c..4a8d0b5 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2151,7 +2151,7 @@
     if (!strchr(addrs, '.') && IsDhcpEnabled(itf_key))
     {
         s = *size;
-        RegGetValueA(itf_key, NULL, "DhcpNameServer", RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
+        err = RegGetValueA(itf_key, NULL, "DhcpNameServer", RRF_RT_REG_SZ, NULL, (PBYTE)addrs, &s);
         if (err)
         {
             *size = 0;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
