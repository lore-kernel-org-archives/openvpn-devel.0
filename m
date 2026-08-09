Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55482C5AD4E
	for <openvpn-devel@archiver.kernel.org>; Sun,  9 Aug 2026 08:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MisZqxrxoP0cLuOoUd1+d/hJMGLsJbeZZ/V1Z8+QVLA=; b=i/Qv4KRr07A8//SbxLaVoaDlBi
	27Jp2EmNyBGubUnMonJuzI7QFlfyaLvkTR/myakihYX80adqhx9kpdYYsSGPPepHPXil7qXxHIjna
	RpZOIF0yGKiWeTHLZVsE+1bwYDxA+sMUPBqUf+oMArxccBaOmz5Hi6valZ6R8gq3hheE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsyvz-0001Rw-57;
	Sun, 09 Aug 2026 08:31:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wsyvt-0001Rm-5W
 for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:31:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=me+0/ccPQ+w0a/mI46CkjgUWPUlGff3fRberkmKY+7o=; b=XY8OJVXjnso1C03DUSpX+IgemM
 AO6bfE8CiPMqXHTd5VMOkongxOZNqdrlPiBJkb9k+PAIoXdOCX6YNCVYqiOFzJ2t4uHaDgvbHLzDg
 klgvnRFHQ/xiGJdc50c1jv9MA3QYoEwiehkfi8Kgsl40CQIu8j/f2H2VmwhJqG5VJSwk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=me+0/ccPQ+w0a/mI46CkjgUWPUlGff3fRberkmKY+7o=; b=m2gTe7F6fMkbgH4zaoA0JAOTsI
 wp7qYz1FJ0K2zY4gthGzOvR2iifWBKlNE5PyWRKfjUB/Cw5WkQEP3XOg/06YtqAEN6vlR7fG5dq1g
 2afE2Ea/4b63b5NT7amlapYIuYLT8lpKBQx9s0VzxgYujbkvkxqWZ4Y1TsAm/UOYbegA=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsyvs-0000nr-1R for openvpn-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 08:31:01 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6798UqGT002572;
 Sun, 9 Aug 2026 10:30:52 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6798UqC0002571;
 Sun, 9 Aug 2026 10:30:52 +0200 (CEST) (envelope-from gert)
Date: Sun, 9 Aug 2026 10:30:52 +0200 (CEST)
Message-Id: <202608090830.6798UqC0002571@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Arne Schwabe <arne@rfc2549.org>
X-Patchwork-State: Accepted
In-Reply-To: <20260808154933.17540-1-gert@greenie.muc.de>
References: <20260808154933.17540-1-gert@greenie.muc.de>
X-Headers-End: 1wsyvs-0000nr-1R
Subject: [Openvpn-devel] [PATCH applied] Re: Allow extracing other integers
 from peer info and add a unit test for it
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

Nice code improvement.  Stared-at-code, and ran server-side tests that
excercise parsing of IV_PROTO=, IV_CIPHER= (plus the unit tests, of 
course).

..
[ RUN      ] ssl_test_extract_peer_info
[       OK ] ssl_test_extract_peer_info
[==========] ssl tests: 19 test(s) run.

Your patch has been applied to the master branch.

commit 06ced3fd84e4e28f2774c4156f8032a2bed736a2
Author: Arne Schwabe
Date:   Sat Aug 8 17:49:28 2026 +0200

     Allow extracing other integers from peer info and add a unit test for it

     Signed-off-by: Arne Schwabe <arne@rfc2549.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1800
     Message-Id: <20260808154933.17540-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38241.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
