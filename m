Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FDCCD98CE
	for <openvpn-devel@archiver.kernel.org>; Fri, 12 Jun 2026 13:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qft3tDiUa5YbuQTrC7GqtkIOxHOlt9yxREbxH7uikgs=; b=ObWTNQ4Mfj2sKfsQKgjPr/r3UY
	C166FM9L96Z6xNHqPny1hMdsSku40PUah22sVqE7ivIb53vo0i7YGt7PZFnzCvx48I2FXsG+YqIng
	Dfwe6JULxc0FjvPLiCCbVluHKX0cQmoSZePtUMirApJHN+CoClJS8UiKqn+lFW76NIvE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wY2N8-0002Vs-AX;
	Fri, 12 Jun 2026 13:56:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wY2N6-0002Vk-A4
 for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 13:56:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rM63bieiPOhic0eiantJboeSZspDpHarJDMmDliXBY4=; b=Sf2i937L42e2XtBqM2c2S3lZhO
 wsWa/KyKHpCCpnery27G29yFbMyP/0YTue8QR4/iKtyXSzL9F8/7Tsdx/9P8vca65Szw97sfvT/IA
 v0o3FWoisXSi0eSSuM444hX/FGN/42qmD/hhkrMmFj5Nde005znysql7xqG0L7iS+QsM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rM63bieiPOhic0eiantJboeSZspDpHarJDMmDliXBY4=; b=A1sObfoY5urpH6qPKxc8R+52U4
 YQqjYKSdaHxds6sFVf9EGhSstRACy2Gr3nIHBx0Or+v00+u48P53BmXUIh7rFM5D/I72Ai9wmPbwY
 KR+T7Q5lwQyZ1lX13tIqVmJiNI0UwXqKb9syBrIaU2MYICT431gV+cfim3cu9WGGx1mY=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wY2N4-0000Wl-UD for openvpn-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 13:56:33 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65CDuC9x076913;
 Fri, 12 Jun 2026 15:56:12 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65CDuCIu076912;
 Fri, 12 Jun 2026 15:56:12 +0200 (CEST) (envelope-from gert)
Date: Fri, 12 Jun 2026 15:56:12 +0200 (CEST)
Message-Id: <202606121356.65CDuCIu076912@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260612113309.29903-1-gert@greenie.muc.de>
References: <20260612113309.29903-1-gert@greenie.muc.de>
X-Headers-End: 1wY2N4-0000Wl-UD
Subject: [Openvpn-devel] [PATCH applied] Re: push: Fix conversion issues
 related to timeout in send_auth_pending_messages
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

More integer cleanups... (this one was brought back to attention because
the underflow in question was reported as a new GH issue).

Stared at code, ACK from Arne, BB all green.

Your patch has been applied to the master branch.

commit 8d23076babece34581ae9396b6280eb34c86c422
Author: Frank Lichtenheld
Date:   Fri Jun 12 13:33:02 2026 +0200

     push: Fix conversion issues related to timeout in send_auth_pending_messages

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1293
     Message-Id: <20260612113309.29903-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37184.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
