Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 074D6CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Wed,  7 Oct 2026 17:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvPZeZY7sV7h/ytXHsaqGWVeySXGLbm9UIy0CN93Bn0=; b=OAVqSrK3+Ke04I4549QaOG7mP0
	dHr4+8qJYEo7fS6WM2o/Xe99EzTYfr2RduppUrdXE71FRG1YvZbsSC1Rq978Mr8yWMTNRD/wnXhtG
	ueKtmTJj+p+h+0+4gIRDTSLn8b6Dc/cItzo2sMlqbvGmtDFyPeyNumsE/hvE5agQbNQQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xEVBz-0001W5-Km;
	Wed, 07 Oct 2026 17:12:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xEVBx-0001Vu-Vn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:12:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=34qTiiY57iTKvhk6vdO/n/dh0Lj2ikPRgw6ztVptV2I=; b=mBQyR+YSC281g11t7dSu43PWkI
 6cMeXXzPtbHK2p4apromlRMhqQ2dTPa126F6Vfj0xLnqvSpbZx22vzMnh2gqFL/BY1GbjOkMvaA0p
 i7DbIRPLPO+8Kk5H0210rgWFMes5SXvcf/DR1+6ZtOSpmN2H0p5240dSg6ZWAxnSvO1s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=34qTiiY57iTKvhk6vdO/n/dh0Lj2ikPRgw6ztVptV2I=; b=T
 u7SbHKyACneEhy7Y4QAg+L2gNGnxqeJTTBx1GDa62++Wuy9cLyvA0WnwjBPK2CmYtvDb6CYdpzxXw
 tYkAvbgmqnXOauIcDZY3q0U7lOo06E0e6KIFK2wPt8K8bD2QG15L4OqrrBsm/HdGGCjVNVZ/kuSMV
 aqyMmMJpNGxB4Jbg=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEVBu-0004Vc-UU for openvpn-devel@lists.sourceforge.net;
 Wed, 07 Oct 2026 17:12:31 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a020e65269so16545345e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 07 Oct 2026 10:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791393144; x=1791997944; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=34qTiiY57iTKvhk6vdO/n/dh0Lj2ikPRgw6ztVptV2I=;
 b=ZG7CEF6PR6y6pFbmKqpmJeOJnatr6R67Kqetf3/k5fsI5TzrV6Rk7R4eaG4QWrNegS
 eQVbhzi2TwHHRFUWhBR8+sLBokm/eUuq9YH5R3NmkW/07lHyAQ5O/l2se1KhPR7nuCAG
 vlFHwQF5tCEtCyeGrwzfJ6j4W2kKERFU5ooLh4xEZpAMdC2Y4KVt8SAHB8JK5UGwW0g+
 VEQfJ4h/s3qbhejRhIUJTUVMF1Bi/QM3Ah2ii2uopNQjxofqQtMJB9XL1TsJ9OroNAyb
 wivEXRhza7E5x/a0nlFgwJwLCLWSOvC6kOXqXf3SlNt03Ren4bwubu7YG7t9o03kkkfb
 +Cxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791393144; x=1791997944;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=34qTiiY57iTKvhk6vdO/n/dh0Lj2ikPRgw6ztVptV2I=;
 b=KcaXh6uQVWEZPcwQT0kqRL7hpkUkVHulLVo7KL/ELVbThQF2gLagq7QNH425/H45Zl
 J/tiSSw2ZN2As/vxNsoc2325EnYD9zzKcN+6ffZLZMItl5JgBY9DY+OTinAsfIAJf9O3
 orckd7z/KUBXZDFwnQB4EV+aEoLky0Ncb/3C+KNh7ttZfPOb9PazVspDWI5OQ4APQDyA
 dCzGpmIqtwK0jf9xDmyTB+yzkKZF1z8sx3TVAbqbbonW2fNGmlRcRK5hf8LYkPvePssH
 VKJl9DZw0Uckiebp/RlWCkE67zmWAI6M+H10Fo4caGvdXpuPzIws75GZ/EArx2YHyDCR
 6ugg==
X-Gm-Message-State: AFuF++kqSPReww5k3hEXJEFfwhNonQ8znTcT110+qgYMRbRXB96k+7H0
 4JZ2U7kERmUmjGHeysxtE2qSJ4aNqpTlrCeSppuw/XRxCOkRQmdAdMmOfQuLYOVtmR3E/+jfaZm
 oGR2RUdeb5HgGtsjnppjPvF4cUnQBCuXKa0ZbUG2Xjh1s6HJ9f1usdAcBVYNHzXmj5Noz
X-Gm-Gg: AYBFou1xeFGcUdE6r1uUfDAJTcMtNvr9mHxQSx5FMEwgL4SKee9OTnmSbRD/WfNPYfP
 GTkSmLSc1WVc7mQgGzY+E5y9u/n51kALADpyQRJLq2+kkAK80pvFw0RSUyNk6RsQ0vNSIBu3zMh
 z8xYtxW9AJMbJmPJsEosjfU7tItUbToTlRyhsiiNvkTkOd9sp97ssUhX3ouuYSI9ZaV05Fz1wdu
 DTUT4dNythbWi4xBGCon7npBGkLCJaddqRjpIT5UGQ4VjcL1qm5R+063GPoTQDmEsK9DcsKVFUp
 Pf8oFUVisKgsKwAniI2J9nsmE79WFJjieDpi086/b3lGgtN9JCnLpe5n8q9/XU7YG2ra8YpVk7W
 J0pucRytcsoyda84tPLiYdXtuHzHPuwaC34JMA9xrWHoVNQE5WdwK9gLAioBmhE4v1GhaLT1A+z
 nG8RM7Jz/EpZH83s/G+d+tq19yScfQXDNgpcuFZXFadJIvPZEbPl8IbOUq93v8fCCO7QPd6g0ec
 SDOUX8Fkrvo6vMXfI1lCqE0wKoDtINFMWClL6zkZYnjS7kdAO3PIea0P2ZooSScKTysr6krTT3F
 wHxg20XBb5qzJx3SYLv0yuQx3rOrdiV1N7fwZx6NEqBXlauhvfJJS3wyFTwV
X-Received: by 2002:a05:600c:5397:b0:4a0:258a:b25c with SMTP id
 5b1f17b1804b1-4a1806648admr49603435e9.29.1791393143849; 
 Wed, 07 Oct 2026 10:12:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1803040cbsm41601475e9.4.2026.10.07.10.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 10:12:23 -0700 (PDT)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 7 Oct 2026 17:12:20 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
X-Gerrit-Change-Number: 1901
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1901?usp=email>
X-Gerrit-Commit: d5e69f956cb2f6fb32c32d449d6204604a041768
X-Gerrit-Comment-Date: Wed, 7 Oct 2026 17:12:20 +0000
In-Reply-To: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
References: <gerrit.1788765781000.I63c141075d89ae6a07872e784faff817dd3350b1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4NzY1NzgxMDAwLkk2M2MxNDEwNzVkODlhZTZhMDc4NzJlNzg0ZmFmZjgxN2RkMzM1MGIxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6136919f19cfb11cafabdc8e46d0fc34f075adc7-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xEVBu-0004Vc-UU
Subject: [Openvpn-devel] [M] Change in openvpn[master]: reliable: fix the
 send window width
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
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8499012068533907727=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8499012068533907727==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KAYNQkNgvI8="; charset=UTF-8

--KAYNQkNgvI8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: R=C4=83zvan Cojocaru=2E

Arne Schwabe=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail )

Change subject: reliab=
le: fix the send window width
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I63c141075d89ae6a07872e784faff817dd3350b1
Gerrit=
-Change-Number: 1901
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
=
Gerrit-Attention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Comme=
nt-Date: Wed, 07 Oct 2026 17:12:20 +0000
Gerrit-HasComments: No
Gerrit-Has-=
Labels: Yes

--KAYNQkNgvI8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: R=C4=83zvan Cojocaru=2E </p>
<p>Arne Schwabe has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p>Patch set 2:<sp=
an style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; paddi=
ng: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail">View Change</a=
></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=3Demail">change=
 1901</a>=2E To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</=
p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link it=
emprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1901?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I63c141075d89ae6a07872e784faff817dd3350b1 </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1901 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zva=
n Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Comment-Date: Wed, 07 Oct 2026 17:12:20 +0000 </d=
iv>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=
=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--KAYNQkNgvI8=--


--===============8499012068533907727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8499012068533907727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8499012068533907727==--

