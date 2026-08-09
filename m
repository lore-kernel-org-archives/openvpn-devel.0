Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91618C5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 21:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GSbjkcKj2d7EqPja32aA9BiZeF+CFSq2bjBeeJFOKsc=; b=Amql5VJe031VtrwwO7QEpnkwJh
	zMqDnsx5sZ5twP436KPC7Aun7Dg5+8ti0kmEvBc4tbzzm80RW0g/LuMRamG+Pl/+4AoZJvf73Asvm
	KWJ4YchFWzPCpJuKGUtgInqhgarWGR/apcm7XZpUWZKQcOPG5/83efI2Ua+jVxJ1rnRU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtAf4-0000cx-N2;
	Sun, 09 Aug 2026 21:02:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wtAf2-0000cn-KR
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 21:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EP0c5paH7g12PT6UILQuuu4L6OKfEMJ3R7QPgoSgj6w=; b=XIjkehGTdw8eJknxBLbWQleuUO
 6hFJk5LrsX8fLgnqgOGJj8vvnhygq70xnD7pHgemaQWRFYvJUHNN0uVIL3kjUYlhUhmKSlTnnK2P0
 0j3mqMzx0NGHtvehbCCnPd8jMxAt9Xro7JLrgaGefJH8nvAQnN0b/8WkzDEvGn31kGPQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EP0c5paH7g12PT6UILQuuu4L6OKfEMJ3R7QPgoSgj6w=; b=Qd3zWCM3d5PwanlNubTJRA/19T
 tViwFEypFj2Len+VtMpBV2ZS5G8DiF2LJ2j+v5uGGbmZld4P5ouySkd8OKYwz27P5Jn0D28skyCYx
 AVnI4nCFlrEFIoH1qEF70NiStM+qS82axpsVeFbjUTCcc85KTdLnV2KXAtVn523AzpZI=;
Received: from mout-p-103.mailbox.org ([80.241.56.161])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtAf2-00070e-2r for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 21:02:22 +0000
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hJ9LX3zLCzKnSL;
 Sun, 09 Aug 2026 23:02:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1786309332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EP0c5paH7g12PT6UILQuuu4L6OKfEMJ3R7QPgoSgj6w=;
 b=H45zRIHCOOg2UjQ+Kxrt+KRfpBQxpPoPqH7KovlF4GVQMmyOLwt+1igxZywnBqsFlDF2gM
 dU8IIgUSGx2H3R3hjpHorGQXzybTn+8gKBgVOv6XYE5Uo+7bfwqz0kvxbcUk3X5rCyoWfW
 dmDNAHLR9Tbg7YWB8GulGsA/uEPTZrDoGiNf/PdM6DdhknVNmAiTWlhVaD6tyuMQYqsR3g
 t1ZHm1eDYEc1CXZxJEyLOB4l74DAgfXZI00l7eHRXVl/EQX5aZF2ewBbHt/ivqVUVmRCZ4
 IGuAfC9JW78s6nxDG6oEKtGMXdh8BsYAHOB0wttHuYIq+KMyKVBhlt8HiKKjAQ==
From: Antonio Quartulli <a@unstable.cc>
To: openvpn-devel@lists.sourceforge.net,
	Ralf Lici <ralf@mandelbit.com>
Date: Sun,  9 Aug 2026 23:02:09 +0200
Message-ID: <178630931180.2213360.15311021822042856779.b4-ty@b4>
In-Reply-To: <1ece7178e4ddce746c4dfc972e7bf51ff56ed625.1786088883.git.ralf@mandelbit.com>
References: <1ece7178e4ddce746c4dfc972e7bf51ff56ed625.1786088883.git.ralf@mandelbit.com>
MIME-Version: 1.0
X-Headers-End: 1wtAf2-00070e-2r
Subject: Re: [Openvpn-devel] [PATCH ovpn net v7] ovpn: run deferred work on
 a module-owned workqueue
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
Cc: Antonio Quartulli <antonio@mandelbit.com>,
 Antonio Quartulli <antonio@openvpn.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

From: Antonio Quartulli <antonio@openvpn.net>


On Fri, 07 Aug 2026 09:55:43 +0200, Ralf Lici wrote:
> ovpn queues several work items whose callbacks execute module text.
> These works currently run on the global system workqueues, so module
> exit has no driver-owned drain point that guarantees the callbacks have
> fully returned before the module text can be freed.
> 
> Object references protect the objects used by the callbacks, but they do
> not prove that a workqueue function has returned. In particular, a
> worker can drop the final reference that unblocks device teardown while
> it is still executing ovpn code.
> 
> [...]

Applied, thanks!

[1/1] ovpn: run deferred work on a module-owned workqueue
      commit: e9714db8041763f59dde152c812b96b3de05c6d9

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
