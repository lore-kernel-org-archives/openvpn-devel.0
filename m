Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03662C44501
	for <openvpn-devel@archiver.kernel.org>; Wed, 15 Jul 2026 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:To:From:Date:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nyTiXWGlGLh/e/5O69PASZNqGjC/p8wzQdkXujLNg6o=; b=IkaiC33AhUP2WMPK4bsQW/qgNV
	shAyH9S6Hzsh/PJarqAf9qvr6CveLoktTrYdg0Gvdd0PSjSz94eub6o+zj/FvwahU3DBjMUc3bjKc
	MpFq2FpnTo3vKaB/l8a+bGwQ+6G3b1cr2jvTa65tVZCNLmu2A20ci3ooki72/uPwlvHA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wk1p1-0007KI-9Y;
	Wed, 15 Jul 2026 15:46:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <frank@lichtenheld.com>) id 1wk1ox-0007K0-Dw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:46:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cz93eohlerwtd5pHXnyq/8n/34/evee5giEctO1iJHY=; b=jtAqdsENIaKVHxDvN9FV5ygC8X
 ynBqIenJVnxSZj3WCrqzdo90tkxadwVbmccFOUpqEUu18MePOp/tZDRAjVATEBb6mdNgZ7rgmUU9O
 vjxObkkeYtYytnAZuSRSaAJFD5AHMWyJIDmiZLC5CfVjmC93zz2dmnaGkxoaj0zo9PPM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:From:Date:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cz93eohlerwtd5pHXnyq/8n/34/evee5giEctO1iJHY=; b=M
 b61p8QKq9l7OQ/MQX6Z7Bjd5nD08qYemATubXOLFuRMoMsPAfiGphkV6aVnJf3Dm1sEyK2wja6+mE
 WN/FClknz8QD93XCJJMJFnHQl+dWL2MKaQF33OCtA6DivIaAlwIjOviYyXmcsOn/O9dBVaeUjoiSp
 bk0yplL/0wfpClvs=;
Received: from mout-p-102.mailbox.org ([80.241.56.152])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wk1of-00014y-3r for openvpn-devel@lists.sourceforge.net;
 Wed, 15 Jul 2026 15:46:35 +0000
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h0cG94vnKzKmHZ
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 15 Jul 2026 15:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lichtenheld.com;
 s=MBO0001; t=1784121569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type;
 bh=cz93eohlerwtd5pHXnyq/8n/34/evee5giEctO1iJHY=;
 b=L8Qj76MZ1p771LVlYhQMIrwEb9Qqz9i1kptv7vSRhmkiMlWfMXes/blHH4SD5FXRRmZ2fK
 445SPUgk9YuFB4hxQoYaXMu28ACuIj7W8/TniCTbHg0CZAC1OKlzYjply7DdrsZ64XUyf2
 Is15muC8H3LqGejCT8DavEGcUNNZumop+ek8pDcYqMKA6yQ/xY3W5v7kS63XU5vrkty1gY
 0emN3RhRQTikNxvhyVxpof9wwYxZMc3afUnjzvNra+9TPfZZtvSWRXu/5Ld6rybyn9Y2IH
 5zGTDB4jGik2C9+LH6/qlYGcU1gsKQBPPVomjf/M9ia5wQuW2fjI/smE/Rb73g==
Date: Wed, 15 Jul 2026 15:19:27 +0200
From: Frank Lichtenheld <frank@lichtenheld.com>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <aleI34U0t6KRFj7E@flichtenheld-TUXEDO-InfinityBook-S-15-17-Gen7>
MIME-Version: 1.0
Content-Disposition: inline
X-Headers-End: 1wk1of-00014y-3r
Subject: [Openvpn-devel] IRC community meeting summary (July 15)
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

* 2.7.5 release

We want to do another release soonish due to some pending security fixes. We're not 
sure the changes will be ready for next week, or whether we need another two weeks. 
Will need to reassess at the start of next week.

* Amount of open changes in the queue

Some discussion about the number of open patches (e.g. about 120 open changes in 
Gerrit). We definitely need to look into our processes again and how to spread all 
that work reviewing, testing, and integrating. Likely also a topic for the 2026 
Community Meetup in Paderborn. djpig is working on better documenting the current 
processes, see e.g. #1776 ("Start a new document CODE_CHECKLIST") in Gerrit.

* Coordinating big changes

A related discussion is how to handle big changesets (e.g. currently the multipeer 
changes from plaisthos and the oob changes from lev). There was some unhappiness 
that these changesets are dropped without sufficient context and that makes it hard 
to keep track of all the developments. One advise is that developers that want to 
have big (or many) changes merged are encouraged to write a mail to the mailing 
list to provide a "cover letter" for the patch set and a convenient place to 
discuss the overall direction without getting bogged down in the discussion of 
individual changes. We have lost this practice since not generally using mail-based 
patchsets anymore. That can be also a good opportunity to point out dicussions 
happening in PRs for the RFC document.

Regards,
-- 
  Frank Lichtenheld


_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
