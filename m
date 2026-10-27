Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F884606A31A
	for <openvpn-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=leLa4OLz;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ctSpaY0W;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=H0/kWgLV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=F4d4BIBh9k+QKEbAh1gSDml5us0SD4W5fmMpTGEVEsI=; b=leLa4OLzbzVJAy
	LWK50NZ6hLg7o0Ij62B3E2bebJ+asWTqQOViwrQpkbmzkQnvPdS1g2A5HnTIMK3Z+YukuCUiaJ1EM
	6rosf9Nt14qDq933DGEAdAfwiWb7OHyz0UKlpulCVvsuy9bRkqxKhcudKtuyoOdUTA0ZsIeuE0Gqe
	JCk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLgnB-0000000010g-3jfH;
	Tue, 27 Oct 2026 13:00:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@blue4.greenie.muc.de>)
 id 1xLgnA-0000000010X-32ia for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:00:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PcaeUt9Ni033okFEhsKPlh+oHHVbIOsL9byL4CCXoIA=; b=ctSpaY0WEI1PPhvIArZFWB1FxN
 aGZkvReX+ETJja/o7e09bVQBDx6shkS7iaYoEwZcAB9n68HazCWKeJsL+bf9zQrdAXAzzyVglbgyv
 NKP6/giWoVPuu0yEf9F/p2ZjUYTwXx9YYofmb6m2b5hm/ctwSvjIwLJ1hyc18UqwWgEQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PcaeUt9Ni033okFEhsKPlh+oHHVbIOsL9byL4CCXoIA=; b=H0/kWgLVDeh24QJY9s3sh9bm4U
 aU5r3SgYzPFVdtH3ySqOjq/OOX1EfrQDnhJURDBUfIluvmJwsmmyXmZpLALDlfw8RKZ2INKnMEWi6
 PvtGHUbaWwRjFNSg1x8ne9kw/+Hf9TNUsq0tE/igIksEnJhlg2zWRAfEC++XyMY4hd6E=;
Received: from [193.149.48.129] (helo=blue.greenie.muc.de)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xLgn5-000000006lv-4BYd for openvpn-devel@lists.sourceforge.net;
 Tue, 27 Oct 2026 13:00:37 +0000
Received: from blue.greenie.muc.de (localhost [127.0.0.1])
 by blue.greenie.muc.de (8.18.1/8.18.1) with ESMTP id 69RD0Sob002241
 for <openvpn-devel@lists.sourceforge.net>; Tue, 27 Oct 2026 14:00:28 +0100
Received: (from gert@localhost)
 by blue.greenie.muc.de (8.18.2/8.18.1/Submit) id 69RD0SCo002240
 for openvpn-devel@lists.sourceforge.net; Tue, 27 Oct 2026 14:00:28 +0100
From: Gert Doering <gert@greenie.muc.de>
To: openvpn-devel@lists.sourceforge.net
Date: Tue, 27 Oct 2026 14:00:22 +0100
Message-ID: <20261027130028.2220-1-gert@greenie.muc.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
References: <gerrit.1793047006000.Ib40b439ad84a08fe6d5d4407da18ed78151327e7@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.3 (+)
X-Headers-End: 1xLgn5-000000006lv-4BYd
Subject: [Openvpn-devel] [PATCH v1] plugin: detect too long plugin paths on
 Windows
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

GetFullPathNameW() returns the required buffer size if the normalized
path doesn't fit. This case is currently not checked, so a normalized
path longer than MAX_PATH left the buffer empty and the plugin was
then rejected with the misleading message that it is not located in
a trusted directory.

Treat a return value that does not fit into the buffer as failure, so
that the error says that the path could not be normalized. Since
GetFullPathNameW() sets no error code, set ERROR_FILENAME_EXCED_RANGE
manually before logging.

Change-Id: Ib40b439ad84a08fe6d5d4407da18ed78151327e7
Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2039
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2039
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@lichtenheld.com>

        
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index a94f07b..9826510 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -284,8 +284,14 @@
     WCHAR *wpath = wide_string(p->so_pathname, &gc);
     WCHAR normalized_plugin_path[MAX_PATH] = { 0 };
     /* Normalize the plugin path, converting any relative paths to absolute paths. */
-    if (!GetFullPathNameW(wpath, MAX_PATH, normalized_plugin_path, NULL))
+    DWORD len = GetFullPathNameW(wpath, _countof(normalized_plugin_path), normalized_plugin_path, NULL);
+    if (len == 0 || len >= _countof(normalized_plugin_path))
     {
+        /* GetFullPathNameW() sets no error code if the buffer is too small */
+        if (len != 0)
+        {
+            SetLastError(ERROR_FILENAME_EXCED_RANGE);
+        }
         msg(M_ERR, "PLUGIN_INIT: could not load plugin DLL: %ls. Failed to normalize plugin path.",
             wpath);
     }


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
