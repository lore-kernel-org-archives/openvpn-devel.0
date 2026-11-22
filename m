Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5703C606A320
	for <openvpn-devel@archiver.kernel.org>; Sun, 22 Nov 2026 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=C2c/gVBq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kTKF/y7S;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=jmSzXPwB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=OugUaYR89l+RUUNADRNVAt8EFvYGdnXWAiPKGatowhw=; b=C2c/gVBqbKgBuH
	NYmKFJRueQqjDV7tkUxtxTSEOFEE8RH281jr9Ywz1sbqOBXjKaX2wDZF+r2Jad8GS7iLekhYHCuSw
	dGbF3eUVkuu6VNrJAlLKpMJOOdizsxcxu+AZmlAH0VkX+ub+M/XRIijijhMfnKAIehwF1kV4LXfPa
	42U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xV5aw-000000007MB-38rl;
	Sun, 22 Nov 2026 11:18:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xV5av-000000007M4-1jls for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:18:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=IVjBJWwW68q96v51M6h5UQwO41DC+xWpYLultCbFW+U=; b=k
 TKF/y7SdYGIHMduc+7yTxTaG8+lrwjVVFvtKfsMezh5IIP+cxn3i4pnHx+Sybj61uMxCQT/8cFB8m
 vH2zFdenWiSoZDt00HE/QIlqpdxexFIF4xcubKXYWQfgiToy1emINwZ2C/nDvFdYyPqd7qAAJsB3s
 787Vf4vtgET1BXc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IVjBJWwW68q96v51M6h5UQwO41DC+xWpYLultCbFW+U=; b=jmSzXPwBE6S/K1oJscf7PI+ioC
 Cf87ejjeIubT/aX5uguGnSqhwqMlpPak9EJ56u8zeFETxVOCVf2SyvNUTWuayn+rANSk+PITcIr8Q
 lJ/3V5JR5eYNcBOPJ62YjLpRVfLz2wriHLX1xIH7kvbL2meWZ5W/aLEYijaMeXvk++cI=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xV5au-0000000086P-2Tib for openvpn-devel@lists.sourceforge.net;
 Sun, 22 Nov 2026 11:18:53 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 6AMBIkWh037078;
 Sun, 22 Nov 2026 12:18:46 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 6AMBIktw037077;
 Sun, 22 Nov 2026 12:18:46 +0100 (CET) (envelope-from gert)
Date: Sun, 22 Nov 2026 12:18:46 +0100 (CET)
Message-Id: <202611221118.6AMBIktw037077@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Razvan Cojocaru <razvanc@mailbox.org>
X-Patchwork-State: Accepted
In-Reply-To: <20261121144850.26734-1-gert@greenie.muc.de>
References: <20261121144850.26734-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xV5au-0000000086P-2Tib
Subject: [Openvpn-devel] [PATCH applied] Re: route: initialize the table of
 block-local routes
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel@lists.sourceforge.net
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is a bugfix for something that was discovered in the ramp-up of
commit c482c663506d - r->table_id is not initialized in this branch,
and inherits "random stack garbage".  The other hunks touched in said
commit (in add/del_route3()) do not need a fix, as the route is CLEAR()ed
there.

Arguably we could do "ALLOC_OBJ_CLEAR()" here instead... but this does the
job (and master wants "-1" there anyway, not 0).

Backporting to 2.6 is not needed because there is no "route table ID"
handling in 2.6 - so the uninitialized member of "struct route_ipv4" does
not exist yet.

Your patch has been applied to the release/2.7 branch.

commit fb4ef462b3e88579aac06ae13c6144018768d120
Author: Razvan Cojocaru
Date:   Sat Nov 21 15:48:45 2026 +0100

     route: initialize the table of block-local routes

     Signed-off-by: Razvan Cojocaru <razvanc@mailbox.org>
     Acked-by: Gert Doering <gert@greenie.muc.de>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2227
     Message-Id: <20261121144850.26734-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg41757.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
