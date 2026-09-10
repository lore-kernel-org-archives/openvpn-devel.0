Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20647C88E41
	for <openvpn-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QsPXzQ67q8dnmELRY6tR42KQYYhOR29kYts8z+h2mgE=; b=XLKsyF4f/mVZoAHakFBGUSx5Yb
	eltf49FMEhbgkWur4YEyxgU1Nlk/fpIqP2YqCpE1p6pONNTn7VLDgQ5Gu0fIyAdQHs/a/oE5GDJLb
	s+tTRa2kE/gH2x1tNj4lKJ5Bt8xpY0ZBZEE7Iu0LW2qd2LMCg+MJQW6hW0/fWO5pg25g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4aew-0003OI-S1;
	Thu, 10 Sep 2026 09:01:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4aev-0003OB-Ju
 for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 09:01:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=t5QG9rEIb+PxkkcJQxwBMeUEFagaHLxHsRBbCEJKQCQ=; b=XNnTEjsW+QWGufMSkKp0Jscfrx
 gdfqehsqu9wytgEfSnQLBLP3KcKNaUUzYdUrFSphh4imXGMQDB7nDGX5DpX4W/vDZImyMN5cymri+
 uPEqEz2ox3EG3xd6APXZwibxajOmnMvyewP14LsFEyfam8oYu4hIuvhzsB7P74pEMyrU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t5QG9rEIb+PxkkcJQxwBMeUEFagaHLxHsRBbCEJKQCQ=; b=Q
 /QPkOUjmYzlniSm9wR99S1kHIM8SNhjYNjQXzxFCZPqw4ccOEV+QYLqTAGVlI30M/ATAjaN0JgR2a
 P943uX81DH6VWGuaMuTgMBXCSGGtVIb3ctycTwwFutoACpVo8txwXObRDH+8D0E8zpekZPc2YOOOm
 3fN1/dq982l14eAQ=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4aev-0002B6-Mb for openvpn-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 09:01:30 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-482f2ee53e7so4954363f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 02:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789030883; x=1789635683; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t5QG9rEIb+PxkkcJQxwBMeUEFagaHLxHsRBbCEJKQCQ=;
 b=FsjJEI3DorO7u4hRk/5Nt4d6FKb4okwU3VSwhXvvuTGTagYqnU1/UqEQwTxABLVV6z
 +HA43fJJEpSvU06yNkOd5TGeGK3t5PIyM/XxgOC+Yo38HBU4Y0xlhihbkz2TaR4JqNRN
 8SnQ5j1shiMV9Cb5OqPU0lugKEx0bId8DJebE61A1FD/JWRCpJkup7YfFJLywB4aeIIa
 MJ2xT4VaRhdF64la3eSvUIc5xXcpNiiU6fRfatQCJxTAfw832ci7yeToazXzY38SaVMz
 Gixc1S436daj5tQdnV1SMjkzrpckwLiqzwl6gCUVSaqZ61kZ6W5O3/xTnz1ia0MdtTTD
 fYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789030883; x=1789635683;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=t5QG9rEIb+PxkkcJQxwBMeUEFagaHLxHsRBbCEJKQCQ=;
 b=p3lyNfmFnf/QWbH0ckzyG54voqZshqWvYPp71XVj9WFlx9QHZgEsh7JF7XBfwU42lq
 6+RMxoJytAVxYXYmQ779gae9ka6nEqv9aLIvVobWCDLa2WlbKcJdec3eoJWML25IlOvG
 jvlixwCSbQoFsUJmn8VDUFAPYBdb8kUCpauwcsSAK+E5G5d4H0eRxTnL8UcCptC12XbA
 q6H0yfglmcCqpDupuhOriYh7ReT93gc6gdbOGbecjVYQ2bFhaILRlyL5cV1TuPG8OMaV
 KNfdt60jJqh8edh04SLBUlboNbQ/OlbOROiwKOvOTc3Qc0IwmCKWqa+BwbLTs9fPzB3U
 cZrg==
X-Forwarded-Encrypted: i=1;
 AKwUvByUYxybN2kLr0BgODO4TXstbtsO5fOB576atSt4/k31IG34c7zfsYV+NVB/xL3GV3pWENhEqPvHvrVExZDN@lists.sourceforge.net
X-Gm-Message-State: AFuF++lLLZmW6jPmzHryehnoMVRcdrk2LMdTO8zeyKbXT00Lc3GNpRKh
 OImJD18hdbI1vvtM1MitTOnm1rCMJffGzCZb1YwlaLBumOyLszHDR+szsv4w8lwZwNgyO6nGT4y
 B2QnB4gnSlXUNPVJGrUs3jRhla+zOwAGgU/SOV94C34IDyQl0gwYbdslf99ydibxI1Qhm
X-Gm-Gg: AYBFou2C4tNf4KvZk02jeWifDk1MMC7WAHNVPVqr+qEMIdciCanoMahWDYxEakMQGPv
 rlt7ikk52wXsKc2/ZMsjBPt3+17iA16DmxtdFXmDR4avSmGLOv5HSiNFiwPHbJ7VD0sgehnMZoa
 5oDEYwnJBKk/44puZpy52wdDfOji31c+SKXfVqpfpNU3A8CydK7JvNG2J59TNEfLMpZj9bPOmC9
 iBwkyYVThlWzA+3MJoF7bBF52EOaYWrMKeDkq2rn/iAZRfZg6nf6LCYyA/ErwYl+Zk7DqhlB2dK
 ATIWLWY0dg1LbbdKKwRsxJiFYoJJlbVaqNH0Qj082Lyks4K3J06jI4gh+7rlHik/t5DC5b/sNzC
 vKUCRFZiTCzxgATxu/K70n740fjVu2Z3Nv0APFaoX48d2UJgtJyF0H8yCHomsfmNADDVZOZ2+dY
 glVMQx5sVA8G5l0DOTVeYZLTdgTnNz+YnmKj+NSxUmCHnRZcBcgINI3mc0rcpaYsBr8XJ0p6HKY
 pHr9ga3vFoBJZqrGi8OwffFsA07KNlGuoO89lgPgwW5nlLM3v2HKyfvy3HRnsWNlkfwBqvCa4l2
 Vlb9LDBP/I8b3dMoMjsYaV/YdwYVr5KMNOvTImv84JbMmTEot6XXINpug97z3Q==
X-Received: by 2002:a5d:64cc:0:b0:485:8fb5:20e2 with SMTP id
 ffacd0b85a97d-4858fb522edmr36149093f8f.12.1789030882980; 
 Thu, 10 Sep 2026 02:01:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm48794394f8f.3.2026.09.10.02.01.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 02:01:22 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 10 Sep 2026 09:01:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f
X-Gerrit-Change-Number: 1683
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1683?usp=email>
X-Gerrit-Commit: 162d13467d7eb9df027f1d6b3bd8b21257f8bc71
X-Gerrit-Comment-Date: Thu, 10 Sep 2026 09:01:21 +0000
In-Reply-To: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
References: <gerrit.1779265416000.I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5MjY1NDE2MDAwLkkwYmE3MjNkMTJkNDMzZTZlMDIwNTg4YjdiMGMzYmExMGJjZjhjNDRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <12197f387abb37a609fdc46152f2093133111dde-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4aev-0002B6-Mb
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: remove iroute
 at client exit time instead of delayed exit
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2009619986593419369=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2009619986593419369==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fX96VQelZFI="; charset=UTF-8

--fX96VQelZFI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

ra=
zvanc has posted comments on this change by ordex=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1683?usp=3Demail )

Change subject: dco: remove irout=
e at client exit time instead of delayed exit
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2


-- 
To vie=
w, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I0ba723d12d433e6e020588b7b0c3ba1=
0bcf8c44f
Gerrit-Change-Number: 1683
Gerrit-PatchSet: 6
Gerrit-Owner: ordex=
 <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Revi=
ewer: razvanc <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Thu, 10 Se=
p 2026 09:01:21 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--fX96VQelZFI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>Patch set 6=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">View Change=
</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit =
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=3Demail">chan=
ge 1683</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1683?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I0ba723d12d433e6e020588b7b0c3ba10bcf8c44f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1683 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;=
antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Revi=
ewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mai=
lbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel=
 &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Comment-Date: Thu, 10 Sep 2026 09:01:21 +0000 </div>
<div style=3D"d=
isplay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Ge=
rrit-Has-Labels: Yes </div>

</body></html>
--fX96VQelZFI=--


--===============2009619986593419369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2009619986593419369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2009619986593419369==--

