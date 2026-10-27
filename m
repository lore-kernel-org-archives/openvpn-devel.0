Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC83606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XCZD+CLl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZHymj1K6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WPFBgPaA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=237TN/78rwTJTGgJpeWwE/b1b0hjuF0puXt3iKqOB8Y=; b=XCZD+CLlq23rH1
	eW/vv1lV262x59UfzovXxNvKiQmLCMOqLtxHSYptG/y02AtocpuA6/6roUdfYTkNxo9buExrWKA1w
	i3409mMfqU993fhAJCq9KaxF6fevua82+JPqPbVH8tK6l9MITcsuAUrpHUj9OiTyJe6xKaAxsXf1L
	IPw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgna-000000002ov-0pZD;
	Tue, 27 Oct 2026 13:01:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xLgnY-000000002on-22Wx for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:01:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SGyluH2f09RHo/h/xNgQ5N+XjZh9kLefJ4L4BMzMTC8=; b=ZHymj1K68n/wfryU8rKnPn8fRQ
 SKhz8RQ/Ji36I+0LTv2tI9+jeQTSHFqX+zj9hTVwPocGLPxrrJLtSAh64RX4vn8uApL2R93yf/DuQ
 DJkPdRieoNIy4DjqZkFJFUVV5sJc0oPYQGarafg5327JXiQh6ym3ptQT5QbkSWmy42gQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SGyluH2f09RHo/h/xNgQ5N+XjZh9kLefJ4L4BMzMTC8=; b=WPFBgPaAlMaZGr+dJQq4w7SVR8
 KYvjFEHYO5EjrqxHwZIBzHgUH/py1czqIGQ0+S4RQQdqYHuypQ3zCbSZZJEOVeafxt7rgtrG/EJxb
 njOOi+kV2G1wqsjjs0qHFe7QgxIWBgqVdDR5xx+IZ5jzEKhmDBk0vSitM6l3SsVKWGmU=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLgnV-000000006EX-2a3K for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:01:04 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69RD0skT002302
 for <openvpn-devel@lists.sourceforge.net>; Tue, 27 Oct 2026 14:00:54 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69RD0sXT002301
 for openvpn-devel@lists.sourceforge.net; Tue, 27 Oct 2026 14:00:54 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 27 Oct 2026 14:00:49 +0100
Message-ID: <20261027130054.2283-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
References: <gerrit.1793045668000.Ifa4497963989c2d6ba68d75942d368c112ac6f67@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xLgnV-000000006EX-2a3K
Subject: [Openvpn-devel] [PATCH v1] win32: pass the buffer size in bytes to
 get_openvpn_reg_value()
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
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Heiko Hund <heiko@ist.eigentlich.net>

get_openvpn_reg_value() expects the size of the value buffer in bytes,
as documented and as RegGetValueW() expects it. All callers passed the
number of characters instead, so only half of the buffer was used.

Pass sizeof() of the buffers instead of _countof().

Change-Id: Ifa4497963989c2d6ba68d75942d368c112ac6f67
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2038
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2038
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index fde6412..3af58ed 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1491,7 +1491,7 @@
 set_openssl_env_vars(void)
 {
     WCHAR install_path[MAX_PATH] = { 0 };
-    if (!get_openvpn_reg_value(NULL, install_path, _countof(install_path)))
+    if (!get_openvpn_reg_value(NULL, install_path, sizeof(install_path)))
     {
         const WCHAR *ssl_fallback_dir = L"C:\\Windows\\System32";
         /* if we cannot find installation path from the registry,
@@ -1585,8 +1585,8 @@
 
     /* Attempt to retrieve the trusted plugin directory path from the registry,
      * using installation path as a fallback */
-    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, _countof(plugin_dir))
-        && !get_openvpn_reg_value(NULL, plugin_dir, _countof(plugin_dir)))
+    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, sizeof(plugin_dir))
+        && !get_openvpn_reg_value(NULL, plugin_dir, sizeof(plugin_dir)))
     {
         msg(M_WARN, "Installation path could not be determined.");
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
