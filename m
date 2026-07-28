Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF97C531F9
	for <openvpn-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QEHYzg8adPUraz23rJ452kZHPuyr6nSbIsfxT3qwAM=; b=Cj7gdz6hhaglszBlsPWvPlt0xG
	X9GfDnie6qg4hdBKdM9CESHZkt27/DqRax/qA2NmB64Mg3x5avzypGH+SrT+DQL9wEu5pksgojE+/
	R2AqFCp+iJ41tmpbIH/R9+P4PAbJ8DtB82r7Pms3CL7hMQpGKaLEdPGIT0eTjvAXNdVE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wog6N-0002iv-El;
	Tue, 28 Jul 2026 11:36:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <a@unstable.cc>) id 1wog68-0002if-Pz
 for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:35:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BCY4myUB65QXVasuDxfB4Whamu3ir3pueMO4e8yJ0T4=; b=EzFQZsqelVj84YqEFdc5q773lY
 GG/Ji3PrEsM51fZvTL/+H3znY4hjmuHQb+NQ+86e9iiP5HEiunkLmlPEp3XXzIOJfLBXMERvMmxuV
 3G7S210kmY/DH2Qa55t/B6vr6I2LEGgHyTcsDFgefJcyvPyYQRzkg55Nyfe1BjZchLX4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BCY4myUB65QXVasuDxfB4Whamu3ir3pueMO4e8yJ0T4=; b=S2lPYuYZ7FzlDbYC4e7rX7uhQB
 rOBmXdHiyWVTeMKQPEZZPZP8QMXryDsDG9ch5AFnq+OUTsvWYMIOofdTtporsovEXjVaYLpkxZWQV
 yyAeSB7kSbcwXBEYOugD+kqvYBXJOIyMTgSVGQDCmYLW0VQrwdnUzzd9nGE5NDXoCuIA=;
Received: from mout-p-201.mailbox.org ([80.241.56.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wog67-0002r1-DL for openvpn-devel@lists.sourceforge.net;
 Tue, 28 Jul 2026 11:35:46 +0000
Received: from smtp2.mailbox.org (unknown [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4h8YLH5WDvzMlGL;
 Tue, 28 Jul 2026 13:35:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unstable.cc; s=MBO0001;
 t=1785238535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BCY4myUB65QXVasuDxfB4Whamu3ir3pueMO4e8yJ0T4=;
 b=zNHddE9Cj/tzQ0aH70326apGwA4QAoVQinp3YRb6kKu3+9qmgZIleYGdRiwpXQDTorZq0i
 Nu1/gEiJDWgkUHdpLLLZn1OG+7q1GfxgD6kKlhcl512EZEVN5tpBZ8Xcu6KbnNnni1Q0SL
 0hVi1UpJEikZQAAzhzREHzQw3Mf5clbeg9/B9CRUg4Ih0s00hibNpm79b+O7pCFUMEkMPI
 2EqxOUdJ8k5EM8RiQ+aifKn9xC8qcnMqWV1tO27jjc6+aFnOoqLzgGrJzSM48MfqRqwLS4
 tixWMmzuCMi6Q1ceDrhvSVn0jTWORyGmb2+zxl+jouC6Lq9oKnNof932tbAGow==
Message-ID: <e17854e9-45d0-4688-9864-68f050f1fd45@unstable.cc>
Date: Tue, 28 Jul 2026 13:35:32 +0200
MIME-Version: 1.0
To: openvpn-devel@lists.sourceforge.net
References: <20260727200705.869169-1-a@unstable.cc>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <20260727200705.869169-1-a@unstable.cc>
X-Headers-End: 1wog67-0002r1-DL
Subject: Re: [Openvpn-devel] [PATCH ovpn net v3 0/9] ovpn: assorted net fixes
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
Cc: Antonio Quartulli <antonio@openvpn.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

This series is being dropped to address a few subtle issues identified 
by Sashiko.

Regards,


-- 
Antonio Quartulli



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
