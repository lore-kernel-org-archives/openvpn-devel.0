Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785D8C43458
	for <openvpn-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:Subject:References:In-Reply-To:Cc:To:From:Message-Id:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pl1B3xb5V9cpmONWC4PrqMLyEIBBQdUysYeOv83FkHQ=; b=K2NMPk4CayGsOfY2Vd4Vh6SG+4
	jTUEtm85fYF9kSfqc1FqHws2fRjI1f8tj9K0pd+Dzc1hCUSV954F3LeO0qDdABM+lGvG4W4bl7lDt
	xB3w6uwnN5DlEo9U+3iOL+aCRDX4djEIvbmj7ZdstCSH/1QVDErCLXuxvJ4HiGRyyK+Y=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1weSWw-0006il-7P;
	Tue, 30 Jun 2026 07:05:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1weSWu-0006iY-Qt
 for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 07:05:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qIXa7klUAiRMUBOVjmqG0/BdUQtWlmn5JCp7m4hRrkw=; b=LY7dC1Nc+oCme/agCyXF117l1Z
 E+W9meQ1yflsXKvMQ0UrKOaSHbcT7Ra9CONlsCjzGrj0rjQyNRv/PqTxDV8nT8FRZtgwDf7wnH65z
 g3GksnZXpRUdJj8G/fh+1gD06BbrQjUGfKnPGD+mQ83G8SdWcAC0qETC7xACkW/lFAwM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qIXa7klUAiRMUBOVjmqG0/BdUQtWlmn5JCp7m4hRrkw=; b=UZ1jIjpn7wCi530H4RjBfO9SkE
 ahKxwYRy0NEZso0H3fdUEfUX/FgyweoLbnCShFPSJXePJVnRFnSvbtOhv3gffdUUaSYLAGaAHPBLO
 d7K67gygUO+ojP+86gddxtaARVknLShVAX1g3nncBQvsKjlmV3OssI644twqQIeBZD88=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1weSWs-0003nK-1i for openvpn-devel@lists.sourceforge.net;
 Tue, 30 Jun 2026 07:05:13 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 65U74wuu092696
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 30 Jun 2026 09:04:58 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 65U74wAS092695;
 Tue, 30 Jun 2026 09:04:58 +0200 (CEST) (envelope-from gert)
Date: Tue, 30 Jun 2026 09:04:58 +0200 (CEST)
Message-Id: <202606300704.65U74wAS092695@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Sami Rusani via Openvpn-devel <openvpn-devel@lists.sourceforge.net>
Cc: openvpn-devel@lists.sourceforge.net
X-Patchwork-State: Accepted
In-Reply-To: <SXGKysQ5xx6qb0pPY8pAk_wO-B0Pl44xmifYB_bBdqIXMtGir8GTPKxhB2kivfBvPO2uU9bBnxbJVTTy2IDBqXlumDVRYOLOE-qEZfea5TQ=@pm.me>
References: <SXGKysQ5xx6qb0pPY8pAk_wO-B0Pl44xmifYB_bBdqIXMtGir8GTPKxhB2kivfBvPO2uU9bBnxbJVTTy2IDBqXlumDVRYOLOE-qEZfea5TQ=@pm.me>
X-Headers-End: 1weSWs-0003nK-1i
Subject: [Openvpn-devel] [PATCH applied] Re: doc: clarify that --float only
 applies to UDP
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

Thanks :-) - this one came "inline" and nicely fit my workflow.

Your patch has been applied to the master and release/2.7 branch
("documentation improvement").

commit fb863b6daa4f5a2033b937b60f9e93241546666d (master)
commit addf19c07964dfe5971a50f2b41f2021ec5f6480 (release/2.7)
Author: Sami Rusani via Openvpn-devel
Date:   Mon Jun 29 21:45:17 2026 +0000

     doc: clarify that --float only applies to UDP

     Acked-by: Gert Doering <gert@greenie.muc.de>
     Message-Id: <SXGKysQ5xx6qb0pPY8pAk_wO-B0Pl44xmifYB_bBdqIXMtGir8GTPKxhB2kivfBvPO2uU9bBnxbJVTTy2IDBqXlumDVRYOLOE-qEZfea5TQ=@pm.me>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg37401.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
