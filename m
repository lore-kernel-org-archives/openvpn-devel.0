Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EC9C61DD3
	for <openvpn-devel@archiver.kernel.org>; Mon, 31 Aug 2026 06:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=obwaNbcKpVV+VQmktzg9Hckl0nfu74WM8QAsCz9LmKw=; b=HGOeZDFe4566qE8TJ1t7bQeevr
	qj8OL5PgKpPD7CUIj3CLBCZNXQgguyIvXD5AEmsruCsdT41TxUK+9GczEeV7Xfjseovpp8Y+khRIZ
	x6gZUvtgTw+dVyyOrl9bTG7fQLR9YYojdq8ai1yWhg9OcjGbFJjTtMfN6HmiLjU/f8Vw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0vo2-0003Wx-MY;
	Mon, 31 Aug 2026 06:47:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1x0vo1-0003Wr-6q
 for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 06:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=odHtquBAHGS9sKdCy8LlXQrqBK5o1NPTVfAbb/W9jmw=; b=ZE4pPzMbCjKV091fOmPRk7re/J
 Lc0sEoiKlrIyh4RPUHIMY9fYZRYU2mXi2sE/ARygKnS3hodaZYQSvvBtDBAaybjt9+zhUe/yxGU3o
 IzSg3nIFw5TYTmg9DlPhxiPLnG7Cpggv/lqzttn7SfxAZQTERfTRpDB1u3yM0gkWtrYI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=odHtquBAHGS9sKdCy8LlXQrqBK5o1NPTVfAbb/W9jmw=; b=ArSOUAS5eUtM3o/BSgLCw/h3sX
 mf9EHFlqNs+EjHWpcm1m7l90RP9PZ4fxxyM25xfEItlF/fKKlowRSitiduwRqBYo77nZ/M6wTAP+2
 IvEPYykH5y/Sovj6rLUtVKznBqkgzyMr4whJ/gL/+pzK2yyFeTjCfnmo7T1X7Jlg5kqU=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x0vnx-0001Eb-2i for openvpn-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 06:47:42 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67V6lTa6084378;
 Mon, 31 Aug 2026 08:47:29 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67V6lTeF084377;
 Mon, 31 Aug 2026 08:47:29 +0200 (CEST) (envelope-from gert)
Date: Mon, 31 Aug 2026 08:47:29 +0200 (CEST)
Message-Id: <202608310647.67V6lTeF084377@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Heiko Hund <heiko@ist.eigentlich.net>
X-Patchwork-State: Accepted
In-Reply-To: <20260830182134.32251-1-gert@greenie.muc.de>
References: <20260830182134.32251-1-gert@greenie.muc.de>
X-Headers-End: 1x0vnx-0001Eb-2i
Subject: [Openvpn-devel] [PATCH applied] Re: openvpnserv: detect sibling
 dirs in CheckConfigPath
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
Cc: Harshit Varu <harshitvaru666@gmail.com>,
 openvpn-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This is, basically, a simplified backport of the fix that went into
"what became 2.7.0" - we did not do 2.6 at the time because the 2.7 fix
used a newer windows API that would have broken in-train compat for
2.6 (and then we forgot about it).

Arne's ACK was reported in the private GH repo, Razvan's both in Gerrit
and GH.  Harshit Varu reported this to us, and confirmed the patch fixes
the issue.  Thanks :-)

Your patch has been applied to the release/2.6 branch.

commit 927b18dff00a8ec0e9233a9689569e4519fc7de6 (release/2.6)
Author: Heiko Hund
Date:   Sun Aug 30 20:21:27 2026 +0200

     openvpnserv: detect sibling dirs in CheckConfigPath

     Signed-off-by: Heiko Hund <heiko@ist.eigentlich.net>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Arne Schwabe <arne@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1883
     Message-Id: <20260830182134.32251-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38828.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
