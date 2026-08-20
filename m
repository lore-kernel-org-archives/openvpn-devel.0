Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9002EC5DF81
	for <openvpn-devel@archiver.kernel.org>; Thu, 20 Aug 2026 10:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xtS3LwfVyLQ4Un3MFOt5m3ZecjgDxXCPyvkRU2sLGc0=; b=gFC+iMx7lANzpMqCr1Ahgi7IbK
	9rcN9JkUM4noSyqDokz5byJCm05hM5/A42gos0yEPUpsV5rIkiEC/eQq0697gIjOFhSXOEdDF8yBt
	0soFxUF7XU0/GJOgvf1Dapdd+IBhqxoGkWPnIeruIsP+9FIzhAb2hQkJoVmhDojRUaGk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wwzol-0008Hy-NB;
	Thu, 20 Aug 2026 10:16:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1wwzok-0008Hn-6k
 for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:16:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PAV/6oRoaF6sGawxC6eMPEK1seB3i1HeeBcUi7Ptjvk=; b=ZbPFNW4WFLBHdO9xRlZV9nwuYF
 U3bxuv5In7LmhGCpgWCbGO9IwJ7Yp0omUsUnBLMo68Lv/Hi3QO5fsCP28ug1LtdJ8VAAt72PIhSTh
 nBpBQdgXwW6u3YUVm3U7acqyNoM8pKUghTxegKdYNnS1CBh7vUJwDZ4rMHiigbskr0ZU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PAV/6oRoaF6sGawxC6eMPEK1seB3i1HeeBcUi7Ptjvk=; b=WlF2d+o/siv3qALIQdpbgjydfu
 CpjgJCIn3RtzeCp3O0m+s695G1pg57vCvWfBKJtwMgBppYZWFPOEW6ZhG1FgBjrRSWGLL1k9xraIg
 ADoydBbXeCdg/4v8H2v1te/kce+jUKv2fFKWVmh/5n4XGVIu/C7aNWKuEFnfya5pS74I=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wwzog-0004w1-1R for openvpn-devel@lists.sourceforge.net;
 Thu, 20 Aug 2026 10:16:11 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 67KAFtrD061234;
 Thu, 20 Aug 2026 12:15:55 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 67KAFta3061233;
 Thu, 20 Aug 2026 12:15:55 +0200 (CEST) (envelope-from gert)
Date: Thu, 20 Aug 2026 12:15:55 +0200 (CEST)
Message-Id: <202608201015.67KAFta3061233@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Frank Lichtenheld <frank@lichtenheld.com>
X-Patchwork-State: Accepted
In-Reply-To: <20260820091512.4550-1-gert@greenie.muc.de>
References: <20260820091512.4550-1-gert@greenie.muc.de>
X-Headers-End: 1wwzog-0004w1-1R
Subject: [Openvpn-devel] [PATCH applied] Re: dev-tools/reformat-shell.sh:
 Make our shell code more consistent
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

This doesn't add or change any code in the repo yet, but it provides the
tooling to keep our shell scripts in matching style later on - and having
it in the repo means "everyone can run it".  As we usually do :-)

Nothing tested yet, but we discussed the desired output, and what comes
in the next patch "all makes sense".

Your patch has been applied to the master branch.

commit 5663fd71f4358e404031d57f9ec1acbb0b78358a
Author: Frank Lichtenheld
Date:   Thu Aug 20 11:15:07 2026 +0200

     dev-tools/reformat-shell.sh: Make our shell code more consistent

     Signed-off-by: Frank Lichtenheld <frank@lichtenheld.com>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1792
     Message-Id: <20260820091512.4550-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg38546.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
