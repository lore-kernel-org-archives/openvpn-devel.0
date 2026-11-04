Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0A8606A32F
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TDHtJqs6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=h6W7TaNM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=S9SPxyCi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=29P5SuTJ1ZTsBsLcWgxexzhFvZy5kIBJgoZX+rQdH9Q=; b=TDHtJqs6A3P5KU
	Nq7US1J+cjAZE0TVwRRwrVYlu/3vr2C//EmxSdSCMjtbCXCqT77/liToY4/CUzcT5y5D7uqTiqEqE
	6XKGQ0GLPywVYVjhhDqEkYwHzKzNGOdY2mCLAW7we8Z4zEnET4Ysay2L+jk4OiF2A9yKJXXdayqrf
	yw0=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOeGU-000000004Js-1RGE;
	Wed, 04 Nov 2026 16:55:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xOeGT-000000004IF-0FhZ for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:55:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=W9Seh5aMivGQ3wKHDquOKYkXUnEIaartHeMELIvSHbg=; b=h
 6W7TaNMNst+3QfTrxlXdCjabTjw6yhPpT2WmEdg0iOiZwQqSOArRjVnIdFS3vfrRIg/g+TBsoFSqj
 wNZj0fxe6DjIGucc5UGJGbYQ+elgsjzRtYUav4TGH/xdTEseuOMd9iPizuY19amS8BQZT8cqq14l0
 svXbt0GDc0fU4IOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=W9Seh5aMivGQ3wKHDquOKYkXUnEIaartHeMELIvSHbg=; b=S9SPxyCiZsKoNOS3zM16s4zowP
 I9r9UFFK1Laj2td0dg9cuqbU41zp4c32yo6llUEpDq0HY35fWt09n12SJQ1gAmNQTngcpWuL+oXVp
 U8JUTVquwIJF9fYC8k1glmpzauIhyCUFLgkMGGlS0/KJsPY1o5vbgD6sdjiNW8NoQmRc=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOeGG-000000007CT-2bCP for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:54:58 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6A4GsnTS097038;
 Wed, 4 Nov 2026 17:54:49 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6A4Gsnj6097037;
 Wed, 4 Nov 2026 17:54:49 +0100 (CET) (envelope-from gert)
Date: Wed, 4 Nov 2026 17:54:49 +0100 (CET)
Message-Id: <202611041654.6A4Gsnj6097037@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261104124842.18381-1-gert@greenie.muc.de>
References: <20261104124842.18381-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOeGG-000000007CT-2bCP
Subject: [Openvpn-devel] [PATCH applied] Re: tun: return NULL when the
 second adapter info query fails
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

This functions would definitely benefit from a refactoring towards
"early return"... nest too deep for no good (and so the error path
is less than clear... the "success -> return pi/ii" is deeply nested,
and then why have a "return pi/ii" at all on failure?).

Your patch has been applied to the master and release/2.7 branch
("bugfix, do not access uninitialized structure pointers").

commit 6649526a4da30e3234ec3386133c50b9c5e83a17 (master)
commit acac32d12e1ed3456d731b7c69459e2b6ea22c11 (release/2.7)
Author: Razvan Cojocaru
Date:   Wed Nov 4 13:48:37 2026 +0100

     tun: return NULL when the second adapter info query fails

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Frank Lichtenheld <frank@lichtenheld.com>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2127
     Message-Id: <20261104124842.18381-1-gert@greenie.muc.de>
     URL: https://lore.kernel.org/openvpn-devel/20261104124842.18381-1-gert@greenie.muc.de
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
