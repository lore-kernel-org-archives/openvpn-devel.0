Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA68ACCF2C4
	for <openvpn-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f7feXfPvu8zwDK1FgF4sU/if47mdwhRFwGAX+LvdGr4=; b=XE8bOi8hfXeo0Q+BlNFLaM/Btq
	EiFttMjgjVW5VKJoFNHmVsRLgcT5ol6+8wGpzc/zQXSkjDZCOS+AbtKWtQFHZbsOr5L8kYmz+pJk2
	5f6fa2wXBfm//xvIahnnlbUlQB1oQ7bjrkhDzI/+CHBeEXj5Py+EJlEhCa18x/KGlCZE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIS29-0000VB-7S;
	Sun, 18 Oct 2026 14:38:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gert@chekov.greenie.muc.de>) id 1xIS27-0000V5-8B
 for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:38:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hrtcKLfumu1J16kJcm7v+eRoWcX4shEASj8VcjwzsQw=; b=mjbiltNX8E5G+aeVPxzUsZcjGc
 IrZKuN3S+TK8YIw/BXRdUJUe0Flsz8aqwG3R5zCqPZSkzT/NeE5lcwOkvGRHTQRD4F7SeFMDDUch9
 thMxomJZGNVyyEl0dPS/Kzm/xunT5Qt7uumQBPOFbF/BtclvbvJEg9fWvuaCW5MDcHRw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hrtcKLfumu1J16kJcm7v+eRoWcX4shEASj8VcjwzsQw=; b=TS+wP01evWtlj+5o7Qf4SJviC3
 f+jQ83f08n/Atn4eeNqUfIL9y+CtYmAfO7jSmP+Tn59ydwcG/wW9zn2PwyQduHBfeaxwBrOe0JjkY
 3pctTFHngso67rznEAo12CeH0umDkZV7wPsD0mAcfNKj/JGr7Xym+QxfIqAXQD++gZN0=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIS25-00006v-Cw for openvpn-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 14:38:43 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69IEcXjh023604;
 Sun, 18 Oct 2026 16:38:33 +0200 (CEST)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69IEcXlI023603;
 Sun, 18 Oct 2026 16:38:33 +0200 (CEST) (envelope-from gert)
Date: Sun, 18 Oct 2026 16:38:33 +0200 (CEST)
Message-Id: <202610181438.69IEcXlI023603@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Steffan Karger <steffan@karger.me>
X-Patchwork-State: Accepted
In-Reply-To: <20261018070320.15749-1-gert@greenie.muc.de>
References: <20261018070320.15749-1-gert@greenie.muc.de>
X-Headers-End: 1xIS25-00006v-Cw
Subject: [Openvpn-devel] [PATCH applied] Re: gen-sample-keys.sh: Don't apply
 server extensions to CSRs
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

"This seems to make sense" ;-) - have done a test run and produced
properly-looking key material.

Your patch has been applied to the master and release/2.7 branch.

commit 1b0bd8c6f60df96356e956b9982550902a622c5a (master)
commit 28847bce2d26e0a9afb6185a247c52528fc12fb8 (release/2.7)
Author: Steffan Karger
Date:   Sun Oct 18 09:03:15 2026 +0200

     gen-sample-keys.sh: Don't apply server extensions to CSRs

     Signed-off-by: Steffan Karger <steffan@karger.me>
     Acked-by: Razvan Cojocaru <razvanc@mailbox.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2009
     Message-Id: <20261018070320.15749-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg39973.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
