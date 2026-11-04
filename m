Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184D7606A31B
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dbpG2o1k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GP+SRD/1;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NnwxNaJN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=vFqNpMwQJVwxCF5+FKLyj8l+ehyJtMaHy/2KBMVedgs=; b=dbpG2o1kSxO+jk
	oooQjJrYzFLM3lCHRMN2LE5jlzhA1y7MJasidK6TO+D/LlDFqtD8nth4GZJaLIN/AkNZXX1KyOvtY
	MgaW65ZpUiTAGgVM6V4OviskiQQmslFW5Qd+InZJtJJZJKz5BR/P9pbarwm57EhYH9Qk6ppfz5u27
	C6I=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOaQ8-000000006Wn-2K2r;
	Wed, 04 Nov 2026 12:48:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xOaQ7-000000006Wf-0nab for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:48:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tV+S0LbN79DuEFoDdqWXaQqJ7SJTaXutoF1nh8xQZPc=; b=GP+SRD/1nJetpe+FYymbsjYkch
 9PElpkiDUfDu2VEP8g5GfRQFiTzSowOiOCIUxpLGiR1+mhyoWsZDjx6616JJlbX94/JMZeQ9HjDtU
 xJb6OWo5NRbTeFpKW4QFkrgWGgczu0PmECHDgYfJvVBEeK96BzYlUygI5zegQXXnJxkU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tV+S0LbN79DuEFoDdqWXaQqJ7SJTaXutoF1nh8xQZPc=; b=NnwxNaJN/U3KOkIVSQE8mQu9HR
 a95Ao6RjwivGvvIJAdjpThc/wOTv3N0lCo6MHjeE6tUn2ASJ4zry/kJRAJSyRb+W/XEK86FjNc0oS
 58Q8NxgMasz6fdNmL+RmSROcVD8rQFbbEn3t22y1168D2xi3vPpdD1mCh3IK9MldZkqM=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOaQ5-000000000Rr-29w0 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 12:48:51 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 6A4Cmggv018396
 for <openvpn-devel@lists.sourceforge.net>; Wed, 4 Nov 2026 13:48:43 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4Cmgw0018395
 for openvpn-devel@lists.sourceforge.net; Wed, 4 Nov 2026 13:48:42 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Wed,  4 Nov 2026 13:48:37 +0100
Message-ID: <20261104124842.18381-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
References: <gerrit.1793781422000.I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xOaQ5-000000000Rr-29w0
Subject: [Openvpn-devel] [PATCH v1] tun: return NULL when the second adapter
 info query fails
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

get_per_adapter_info() and get_interface_info_list() returned the
allocated but unfilled buffer when the second GetPerAdapterInfo() or
GetInterfaceInfo() call failed, so callers read uninitialized data.
Return NULL, as get_adapter_info_list() already does. All callers
check for it.

Change-Id: I2d677eeb6ae9186ede2aeb3c2e0c12d25c935fcd
Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2127
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2127
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 225d8b1..7637dc0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4129,6 +4129,7 @@
             {
                 msg(M_INFO, "GetPerAdapterInfo #2 failed (status=%lu) : %s", status,
                     strerror_win32(status, gc));
+                pi = NULL;
             }
         }
     }
@@ -4158,6 +4159,7 @@
         {
             msg(M_INFO, "GetInterfaceInfo #2 failed (status=%lu) : %s", status,
                 strerror_win32(status, gc));
+            ii = NULL;
         }
     }
     return ii;


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
