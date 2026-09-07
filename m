Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D89EC79FA0
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 19:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HTthTPFoABg2F7GtjI7uR3rcuSdQkvYa7DGsfAsci5U=; b=TuHvWf5IIZ5PJwefBikB45bKup
	h/9clAJKab6eR8MSjSBdSG9bwbgy6Kfz2eFMumhYqEQbRAEu6wNsRyHZ7rAHX1I9awv1cIdpqbOQ1
	4AFlFkUQuSxKRjAfeknGxJBjoLj1LpY7V3IMHhDdPL+NxgDPn3fKfoHDo3jbkGQSyD0w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3fBF-0001Ik-Ho;
	Mon, 07 Sep 2026 19:39:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1x3fBD-0001IM-R7
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 19:39:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0yJF4FXHuBKxT//FGNPluDYseWjQeDSuMg0GKeBJzOo=; b=LcC1m0hwa/rhrAiak/gHcGPLqK
 B+C1dsjNuHzikURZZpBt287Bg/l0sP2m264PgAH+l34t//OMYZ4Xi8QKwNqbrdUzztN+NzD7uJadK
 BFb0DHXNi7CZovVyqgkg9TGoC+qv4ZZh4BXKRU2pUsq+MHqpGb1NZAx19zu9HSF9VVqs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0yJF4FXHuBKxT//FGNPluDYseWjQeDSuMg0GKeBJzOo=; b=YvUmlrUcq4PGOGqS7irAAJuHqM
 9LfIdpwdyViZOlDp0n9+/MWJ02M4cLMQR7GPEpwEw4zrUTpfTObVfanfUT3N0qKwkfVfP/lb+h3Y0
 OrHnvfRmaAQORatRkRDOKNTYlqDMvNBhaqDL527XnK/sw0jmWlD2BjYrVC4SerQcw6D0=;
Received: from mout-p-101.mailbox.org ([80.241.56.151])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3fBD-00072Q-J1 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 19:39:00 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hdy6z4Zhkz8t0M;
 Mon, 07 Sep 2026 21:38:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1788809931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0yJF4FXHuBKxT//FGNPluDYseWjQeDSuMg0GKeBJzOo=;
 b=u85MYoco2/3FAW4HoaaltEoawwZqtUbG1vPAq++VdIbsDFsS6mj/NHOmQCSrZ9kIe3ZY/+
 AAJYAhtQ/rrybcOyDgGYfBl7anHUG2YY9EPsxtQfL6nAxiFHYgqpRXLcleqLgXgdyOSusv
 ot0Ekmax23g/r1od9C5mQ4hPJYbVmqQ2Y/Q/n2RxVCSXLAK/q9jk9PiImnL55kSntBBoLK
 gchAjP6J9mYFIgEyX+GihQXjtQuqcp5jIKxQ/udS+iD+XNcyuqGihpb8/JWZhrZYuB60Cx
 QHnagm5U1rrYYfUZG366v19rJIvNXHohwSYznU2NaDTGFLRd1kn3IGP4A9x8+g==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of frank@lichtenheld.com designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=frank@lichtenheld.com
Date: Mon, 7 Sep 2026 21:38:49 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: Gert Doering <gert@greenie.muc.de>
Message-ID: <ap8Sye4MWwMGbaQv@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
References: <20260907154412.29523-1-gert@greenie.muc.de>
 <202609071813.687IDgCV038538@chekov.greenie.muc.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202609071813.687IDgCV038538@chekov.greenie.muc.de>
X-Rspamd-Queue-Id: 4hdy6z4Zhkz8t0M
X-Headers-End: 1x3fBD-00072Q-J1
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Convert Changes.rst to
 Markdown
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
Cc: openvpn-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

On Mon, Sep 07, 2026 at 08:13:42PM +0200, Gert Doering wrote:
> Nothing to test here :-)  (except for "distcheck" but that should be fine).
> 
> Your patch has been applied to the master branch.
> 
> Do we want to do that for 2.7 as well?

Yes, we should do that. Otherwise it will only save us time during
releasing in two years ;) I will see when I get around to it.

Regards,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
