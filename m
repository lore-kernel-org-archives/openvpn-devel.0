Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36A0606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 19:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M26a7XRS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=L+1J72v+;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YRTRrTYh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jyaITcD1TYaRtWLzXakMuTy24aGuIbvtORgNiumxmHc=; b=M26a7XRSEqkMAb
	J6h30nYYkog4B/uZvKNyIYrmvdWyvc0O/AHwvQInqGX28l1JTJgGYIYxB8gjj31NNkPm+TWJ1LM97
	OsbUCQvxEixIgKvV9YbkSAL6H+6Bfk71xD9zPIaO+VTVwkEsqzX1WeYSaBVFFlzyt7JrzS9xORQ7r
	Dx8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNEQV-000000000YM-1OOC;
	Sat, 31 Oct 2026 19:07:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNEQT-000000000YF-2Dpn for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 19:07:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vm6CRJYhGTSY0V4E41zgUeow/5HnDH8cJlVzDBGYV0E=; b=L
 +1J72v+sMyB09pMBrhPT2Au0XzqkXCeiNcvIaiF1NU4q7WuagSgMBdTCVzV1BjJde4u0lKNhELuSH
 XzQbozdzOaNJoMxqOCNL3qUDWPo8NIJTVn9LlpLDokyZLXMQXzRCaCJ+k8qAtzpDlbOhcT7C5nqA1
 fRj+HoUIS8AWw/j0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vm6CRJYhGTSY0V4E41zgUeow/5HnDH8cJlVzDBGYV0E=; b=YRTRrTYhCHetZ8u0O7zXtbfQKk
 mKW4tOKEy7p6mg7UvmARpIw5s1Kj+M6XZB2dTKCWTbTnQ3AWRPqcMrAcEr2S5kkMNlocmaydwuSUL
 MCUfjhLAI8ZR5iYAY2FcDWjWDhNuOHKEwihqUUwJBgqkZygwGZtYLUjsM4zeAp+EN/F8=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNEQR-000000001Jn-1cYt for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 19:07:37 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69VJ7SgB096726;
 Sat, 31 Oct 2026 20:07:28 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69VJ7Sbp096725;
 Sat, 31 Oct 2026 20:07:28 +0100 (CET) (envelope-from gert)
Date: Sat, 31 Oct 2026 20:07:28 +0100 (CET)
Message-Id: <202610311907.69VJ7Sbp096725@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261026110324.55339-1-frank@lichtenheld.com>
References: <20261026110324.55339-1-frank@lichtenheld.com>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNEQR-000000001Jn-1cYt
Subject: [Openvpn-devel] [PATCH applied] Re: multi: release the session-id
 hash reference on shutdown
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

This seems to make sense (and if Arne says so, I won't argue).  BB all
green, too.

I have amended the comment a bit, because "... for shutdown, too" does
not really make sense if this ends up being the only place where it
happens (it makes sense in the commit message).

Your patch has been applied to the master branch.

commit 3e2d92c7f7e53f329795c865cb36d1fc788e9a9a
Author: Antonio Quartulli
Date:   Mon Oct 26 12:03:24 2026 +0100

     multi: release the session-id hash reference on shutdown

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2032
     Message-Id: <20261026110324.55339-1-frank@lichtenheld.com>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40135.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
