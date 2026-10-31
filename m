Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBFE606A31A
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jrQ5Vn0k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JWPXXS0Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TmuoASz6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:References:In-Reply-To:To:From:Message-Id:
	Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=+e1qFNuhWU1TJDBZjpQVmF3EJDzsjq4pUpGE/iuQk04=; b=jrQ5Vn0kGUybBj
	vqhYHrT5iMHJ4yNXot6oVewrG6q/IcOJjjiLy8Nqh1GlM7fVpV5vrXybogSPDDAsv16F9nmAdytAS
	VUGKIZZReYpkehkVZIDuDrFtzSI6BYvnOi1fuDiWcGJmupds/Y7uswwRbVmM3j7Ce6suAD+Bfl/pn
	r7s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNBsD-000000006pf-2pqa;
	Sat, 31 Oct 2026 16:24:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gert@chekov.greenie.muc.de>)
 id 1xNBsC-000000006pZ-3A8E for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:24:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=References:In-Reply-To:Subject:Cc:To:From:
 Message-Id:Date:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dgps+Lgx7AXvgupLtt6/Lq+9B2VA1YawJD/uApCoG5k=; b=J
 WPXXS0QJ03I4lWu2YJkG0ROYJvlJcpOCFSCfcCxZ1TysWcaay81Oc5HX9dvEjMcSl8pjztB3Ua0sb
 IwHrMFNEFf4DFBTiEZTVCTHPgjRkZ+loog7GUVBu5sMX1v2EO0zTEnJSouKnHOtOdOtj9SfyHRtYw
 SaNFrRRvMOhQ+eEo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=References:In-Reply-To:Subject:Cc:To:From:Message-Id:Date:Sender:Reply-To
 :MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dgps+Lgx7AXvgupLtt6/Lq+9B2VA1YawJD/uApCoG5k=; b=TmuoASz68dg+vII7Dv5pUEjlKj
 7lhASXIQEuaCmewkzZRsW5alUBi/uzHVhbaVVV/Uq8eMZvwLo1bwFh9UbEPz5IgbsXYg3ejflfL4Q
 eacGEsFz6cejIEU+Vfj/g8HwlkB1/VVICs2ewG9YEYgrO1i56YGpNSbdYsQQ2hSGwrTk=;
Received: from chekov.greenie.muc.de ([193.149.48.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNBsB-000000006n3-3XFp for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:24:04 +0000
Received: from chekov.greenie.muc.de (localhost [IPv6:0:0:0:0:0:0:0:1])
 by chekov.greenie.muc.de (8.18.2/8.18.1) with ESMTP id 69VGNuiH091804;
 Sat, 31 Oct 2026 17:23:56 +0100 (CET)
 (envelope-from gert@chekov.greenie.muc.de)
Received: (from gert@localhost)
 by chekov.greenie.muc.de (8.18.2/8.18.1/Submit) id 69VGNuJU091803;
 Sat, 31 Oct 2026 17:23:56 +0100 (CET) (envelope-from gert)
Date: Sat, 31 Oct 2026 17:23:56 +0100 (CET)
Message-Id: <202610311623.69VGNuJU091803@chekov.greenie.muc.de>
From: Gert Doering <gert@greenie.muc.de>
To: Selva Nair <selva.nair@gmail.com>
X-Patchwork-State: Accepted
In-Reply-To: <20261028201609.13684-1-gert@greenie.muc.de>
References: <20261028201609.13684-1-gert@greenie.muc.de>
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xNBsB-000000006n3-3XFp
Subject: [Openvpn-devel] [PATCH applied] Re: Fix numbering of examples in
 management-notes.txt
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

Yeah, maths is hard... thanks for spotting this and sending a patch.

Your patch has been applied to the master and release/2.7 branch (bugfix).

commit 0975c6e707fe742aaddf02049d70942bb04676a0 (master)
commit 0233b02a6329593ac88b0bbe295624db94898420 (release/2.7)
Author: Selva Nair
Date:   Wed Oct 28 21:16:04 2026 +0100

     Fix numbering of examples in management-notes.txt

     Signed-off-by: Selva Nair <selva.nair@gmail.com>
     Acked-by: Arne Schwabe <arne-openvpn@rfc2549.org>
     Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/2068
     Message-Id: <20261028201609.13684-1-gert@greenie.muc.de>
     URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg40270.html
     Signed-off-by: Gert Doering <gert@greenie.muc.de>


--
kind regards,

Gert Doering



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel
