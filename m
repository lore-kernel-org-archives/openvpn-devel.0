Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EFFCD98CC
	for <openvpn-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KKz39peuaWJ3M5dk0Im9b1K1yq/QjYIVhSohS+QIfq0=; b=cOkVVxiq3bSI+qhDoo6YiiAR06
	pOKGY2hk8ZR9fIZulqTZ9UJkjl0xQac+HZUVf3hUMGCxO8a8k5s+eN92RTZsGqJr99RA5AQbBUdg5
	2Uc7JiAklTRHdiPUxXNhY++0xQEnjpiVZRVScUKrHoWQ4qZWQXBN3Iqr81UtQql7k61E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wXM6q-00053n-3d;
	Wed, 10 Jun 2026 16:48:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wXM6o-00053g-00
 for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 16:48:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2qu4emrOvN7Dqm0fz+8+2AhYXinwGeBBU3M6/EkucRk=; b=Gt0CfyC2JTc+p46LJQeaVjINN7
 hIqnyLlen7S8sBPbaPs+MYxcNewoMMbFA3RAOcrJMIH+KS//6wXrIiBJZtYTYUgEQ+sqcf/sU/DQ3
 lPYTgIGsXsEsn+pi7AA89VCPauOLUbGGuRVNr+bD4m8tOGgnGhX/xxKG7p26Z6mKQGYY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2qu4emrOvN7Dqm0fz+8+2AhYXinwGeBBU3M6/EkucRk=; b=P5UoZUD3DQTeY7rvxceBvthemJ
 +8FwUO2VAru+Xw6FU/sq0fYrbYlScX0aliUpwSAKnoK8DMtA+gYaHUOlVJWUyA4HYFz7vCaqGF89G
 jL82949KgrCMVfqes5e30hZUcArahH9krEwOFosKOn93COCdP46ZGrnDPVQttXhWmj+I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXM6g-0004JJ-HC for openvpn-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 16:48:50 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65AGmWZB001921;
 Wed, 10 Jun 2026 18:48:32 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65AGmWpY001920
 for ordex-1702-hmac-reset-ev-v2.reply; Wed, 10 Jun 2026 18:48:32 +0200 (CEST)
 (envelope-from gert)
Date: Wed, 10 Jun 2026 18:48:32 +0200 (CEST)
Message-Id: <202606101648.65AGmWpY001920@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Antonio Quartulli <antonio@mandelbit.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260608060227.9892-1-gert@greenie.muc.de>
References: <20260608060227.9892-1-gert@greenie.muc.de>
X-Headers-End: 1wXM6g-0004JJ-HC
Subject: [Openvpn-devel] [PATCH applied] Re: mudp: send HMAC reset reply
 synchronously
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

So, the need for this is "not directly obvious", because, "everything
works fine", no?  Discussed this on IRC with Antonio and Gianmarco, and
the finding they made is that basically this is just working by accident,
given that the event handler does not work really well for setups with
multiple UDP sockets having activity at the same time.  Gerrit#1635 sets
out to fix this - and uncovers that our "initial packet reply" code
is misbehaving, so if you have multiple sockets receiving RESET packets
at the same time, replies get sent to the wrong address.  Very bad.

Now, to trigger this, you need to actually have multiple sockets at
the same time, *and* lots of concurrent connection activities - which
is not very typical at steady state, but after restarting a busy server,
this might get hit.

I have stared at it "and it seems to make sense", and also my t_server
testbed passes all server side tests just fine - so it's not breaking
anything ;-) - also, Arne had a close look and since he understands the
initial handshake bits best, if he's fine, so am I.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 9a80d609674b70324abf23ded4d2133f967f99d3
Author: Antonio Quartulli
Date:   Mon Jun 8 08:02:20 2026 +0200

     mudp: send HMAC reset reply synchronously

     Signed-off-by: Antonio Quartulli <antonio@mandelbit.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1702
     Message-Id: <20260608060227.9892-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37081.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
