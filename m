Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B760A2612
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 13:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VPU+ZRUV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L8xasx8q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dkZZA1I0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=/Md7Pif4nS90O4FpNMA50EeOgGoX9o/a9jkPDYE0UU8=; b=VPU+ZRUVGi8XaT
	iz4YWJJ8SNhq5ADYO2ojhHxGF+ujDnKx2cPS1R6KB7ik5+bRiGA9+a8B9kqlKH2S1bW6Yiu9x1QG8
	yQp/w+7PVQnqIULkZyUelReYQQI2U9Edw5jPs9kaFm3y4TYDFWo3ylcPUbdqiEVRx+DoxROoFHDwa
	ajw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrhW-000000005kr-3CaG;
	Mon, 02 Nov 2026 13:03:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNrhU-000000005ki-2m2M for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:03:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SP21e5mK5T04vEqZRjRFIxRrSCtDg030R4TODWrSpvM=; b=L
 8xasx8qD9JkFuy+FtHrrki4u4wcdvT07W7UphAKhC6kpiLElHMewOgzTlGTkwx+HJm1S9hzaZY0wB
 UTM9liSislCxYnuyCreLU48h3NpzSVIWrwHEgh2HWyBA9u2jfZ3KUUDDw7dHmiDgI8auZivcmcFZK
 yqiJLFSJxXrNcxVU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SP21e5mK5T04vEqZRjRFIxRrSCtDg030R4TODWrSpvM=; b=dkZZA1I0y5b+muFArnf4GzkII+
 plw4jynF+V+4uF5uWygMS+VpLKX0Fk6QJpMXzWh3tqbarU+B7MRGVNdKHTWGfMTqWQGnZhBhX1Zl/
 R60XndlwoHMLTBVOkI27su4RboBNvhSOxZfI0GZSuG9kb3mTBTzvPPlZpMK6ek8nyXTk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNrhP-000000007lr-2Dx9 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 13:03:47 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A2D3Z9X057862;
 Mon, 2 Nov 2026 14:03:35 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A2D3ZwE057861;
 Mon, 2 Nov 2026 14:03:35 +0100 (CET) (envelope-from gert)
Date: Mon, 2 Nov 2026 14:03:35 +0100 (CET)
Message-Id: <202611021303.6A2D3ZwE057861@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Jeff Bindel <jeff@incrediblybased.co>
X-Patchwork-State: Accepted
In-Reply-To: <20261027130252.2457-1-gert@greenie.muc.de>
References: <20261027130252.2457-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNrhP-000000007lr-2Dx9
Subject: [Openvpn-devel] [PATCH applied] Re: buffer: restructure some loops
 and assignments
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Not all of this is really the way I prefer to see loops written, but
I accept that this helps the compiler to verify "array-ish lists with
a terminator (NULL)", so be it.  Frank and Arne are fine with it.

BB did not test this (untrusted submitter), so I ran a few local tests,
including t_server and GHA runs, and submitted a "v2" to gerrit, which
basically is the same code just to trigger a full build.

There is one hunk here that leaves me feeling a bit uneasy

         /* check if this object is the one we want to delete */
-        if ((uint8_t *)(*e + 1) == buf->data)
+        if ((uintptr_t)*e + sizeof(struct gc_entry) == (uintptr_t)buf->data)

.. if structure-in-array packing ends up being not multiples of sizeof()
(due to alignment) this would produce different code - but I couldn't get
the FreeBSD clang to actually produce such a scenario (and maybe the C
standard is also clear on this).


Your patch has been applied to the master branch.

commit 16c3f4df69f51ffcf403527fbe0bc8c0bffd9417
Author: Jeff Bindel
Date:   Tue Oct 27 14:02:45 2026 +0100

     buffer: restructure some loops and assignments

     Signed-off-by: Jeff Bindel <jeff@incrediblybased.co>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2034
     Message-Id: <20261027130252.2457-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40197.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
