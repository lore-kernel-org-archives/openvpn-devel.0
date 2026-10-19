Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7F5CCF2E3
	for <openvpn-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d4ggu2TLXQH52g3b8K2oqJTfy+rFHpDPIu+j+N68wHk=; b=Oc9zXoNGQPe3sj5Ga3Bqa+m0Mj
	jB1uzHEqcUbuACsaK02pkjqA34VzLQEP63JTSNQUZOmYLjh/Dpxu5ki69+6N2PUFLDR4LzXMjmI6C
	3q+JdMSgM3OI0dwrePWJ+lx1AdyZ8mSSjYpg8IPI68okndLfaXgmzBQhE7FHcqWImMo8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xIlOp-0005zh-LJ;
	Mon, 19 Oct 2026 11:19:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xIlOo-0005zb-8d
 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 11:19:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Mfm2MnqPYbaccOOEiZCrYrhGKkeptkKLy8tzt4saY8Q=; b=V/iZ++DETI8b1s1qF3zPHUpkRG
 QFzoom51vwmTBUDBM6D2ltT2HDLicZwqZeERMWjTBjJRgeND6C5RoJSBOuwIii0/ywYxoQCyvIuVq
 7nhSFSHElRtvsjZdH0Z73OHo79FtEzTrhOCJG4P0KGXDId1l5KsYWfQbTmY3UWTNi3fY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Mfm2MnqPYbaccOOEiZCrYrhGKkeptkKLy8tzt4saY8Q=; b=F
 gcekS5Oax2dXQdIyScnz1iuQrPrGiM5+nL0i4HvyrSTngo8uZwHYRHmKy3VcjUy+Zlst0ySO++zEh
 wjYT15ZnnrdD7UrGZ1yEPy1Ec6PKEy7/p9T25FSUc2+f0juT3PR1R8VkBgmziHuulXPUDSThIy4Tx
 2n74b+h4TPiBe9+8=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIlOj-00087b-K4 for openvpn-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 11:19:23 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a018792ab3so14701985e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 04:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792408755; x=1793013555; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Mfm2MnqPYbaccOOEiZCrYrhGKkeptkKLy8tzt4saY8Q=;
 b=TwmCqtiMKhMZe98snNL49XrWQ77aSwImm9y9YsFpUK+WHoM14xsLfhjZmRELzvZBUK
 yb3quZEhnekrBAU7lUMwvV72sK8X+fG52s+ztZyAes4JWPHVthemDXs06vCznHjoTMcc
 pAJR01Z2fHSy6J3bOChr9oT9ecfm9drLS3ZJI30fFUzc8oWKiejtEQ4mszv2O+HfMc7A
 e3XsLqNgemL6EbwDmcLOmV14IBjyMP8zyUrHQI7dVzEELxBuRg377JZHD0ihAYlo07V0
 CxakCR/a95EOkiqowECqy7FxLWpcvwA2bRA9zAVl8PnEOvbRcDDFwDzmJuw/DBIouStK
 LPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792408755; x=1793013555;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Mfm2MnqPYbaccOOEiZCrYrhGKkeptkKLy8tzt4saY8Q=;
 b=rkP7sNcffhgMfDAtCann8ZnrFFDjDDXqV+BZc2EW1CnHTSzUXI2EJeV0lhW0FCt7yP
 q2RelNKdKCpmQzIh718wctMSp29r5MGBo1fzUFZJoNy+7xLa2IeWsJttSN3rVPIxnalM
 Fd5ex2ghQJHrnyu36pWegMaOrHgaybiVxDxGiPFuFwchM9b+n98ZsX+nolBPtC/bwP/O
 1FkuBezTau8xDdBhXm3pOALDqa+CmGvyqSljvUGyCT0yN/bM2zyrpa7pQKmbgWmFRO+H
 UreAywgniYaStBrp2z6gvMQpFypOmjtcM+JGYLuANEFzAtzrxJQtsri1IM3ovWPK72v2
 +V+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ0bOBKq+UEpCega5Qe9KvJn/cEUGVSMY9Jvv5N0hHLYblnMoMkntAtZZ20hSbks72gRsmDElcnGOndYVd@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJkfaIKNqdfK1BBvt8u2OZbjn6cqcF4CoFMB7O7/WfeeHfW/hXa
 fv0RAoS3EgI32GbMDZgA6vYSPX+gCXBuiTcRdJEfe+2TT46AorTCxbNSTe3zMEDFD15wlQXicKn
 SJvWzZjAhstkMZvn2wESeJfA5bahA4DVBcZ5xIbHui4l07aBrEKlPPWyC7unxwdWpNtRO
X-Gm-Gg: AYBFou0dKyAOsEue3ZULlTzgy9O57VKUyLykmt7wjb0CgWFFnQhV45OHQyDV4QA8L8s
 iOaVimvchHw6xDDNKhGGnOcotTjZW1iu+XdOMr09cf+wgdVRMlUp5PH+xNI3owXs9wY6Bjn9GxR
 rr+C9aDDECBMirq65kLoMN0qvNFtRcNRV14xiXMZlv7sazg8U4LgnUSvTevPhOhQLDIqxA4/tqN
 0k87vpQyTcicB/0e7JwI5T0cxJ34tjrnbTeR9uH6/OHa2h53c0CYtK7+6+g1zSJ+eCLcqok1ME2
 bTx/wZw6EN2KV7X9N4YDWHpAGbk4qfZKYzoIGrapmgP6Zo4gLQDyrwQ3Uw2TLpEdKcITbuBlGZS
 PP3ALW5GfLJNFRljvPpPIXGF8KUy9Kt0pBuTJ2OF1CXVilQ/YtixJvNOPTdinvkGNjqwV+T1umf
 cZ++tj+f+69kp41D6wBoVjeBrDg/PojjBLJGx4juv4MaqgbVlGfgzWwfCbE2DBWqfYicwnH8epf
 lvLjkQMGHLnn9frwTshNYHclUzh+Y35675RdGTvEPrnQZWmmbp4JNT9i11bGtFAiUmTvIQuL507
 704ZgQZBfCySC+qIcli6t+YzlSq3NgpCiouc5bKlYCTou0hZbR1wuIKstA2G4/SKqM+Q52Y=
X-Received: by 2002:a05:600c:1d06:b0:49f:ce73:5e94 with SMTP id
 5b1f17b1804b1-4a1d7616d1emr148474335e9.34.1792408754005; 
 Mon, 19 Oct 2026 04:19:14 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd409989sm23602880f8f.0.2026.10.19.04.19.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 04:19:13 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 19 Oct 2026 11:19:11 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I149d0ba7011e62a115a565813e1f5873907d464e
X-Gerrit-Change-Number: 2022
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2022?usp=email>
X-Gerrit-Commit: 3db18c73c453fff97f95abb0fce091e09530564b
X-Gerrit-Comment-Date: Mon, 19 Oct 2026 11:19:11 +0000
In-Reply-To: <gerrit.1792405183000.I149d0ba7011e62a115a565813e1f5873907d464e@gerrit.openvpn.net>
References: <gerrit.1792405183000.I149d0ba7011e62a115a565813e1f5873907d464e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNDA1MTgzMDAwLkkxNDlkMGJhNzAxMWU2MmExMTVhNTY1ODEzZTFmNTg3MzkwN2Q0NjRlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c768b6611f33bdcc1398690bf088c85f665a6320-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xIlOj-00087b-K4
Subject: [Openvpn-devel] [S] Change in openvpn[master]: automake: Add
 build-tests recursive target
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5494033329416707953=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5494033329416707953==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CwQ3JkBHsXk="; charset=UTF-8

--CwQ3JkBHsXk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail )

Change=
 subject: automake: Add build-tests recursive target
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(1 co=
mment)

File configure=2Eac:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
22/comment/ac748aa7_37ef7fd6?usp=3Demail :
PS1, Line 57: AM_INIT_AUTOMAKE(f=
oreign subdir_objects 1=2E9) dnl NB: Do not [quote] this parameter=2E
This =
now needs to be 1=2E13 to support `AM_EXTRA_RECURSIVE_TARGETS`



-- 
To vi=
ew, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I149d0ba7011e62a115a565813e1f=
5873907d464e
Gerrit-Change-Number: 2022
Gerrit-PatchSet: 1
Gerrit-Owner: Fr=
ank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@ma=
ilbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Mo=
n, 19 Oct 2026 11:19:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Ye=
s

--CwQ3JkBHsXk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail=
">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>File configure=2Eac:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2022/comment/ac748aa7_37ef7fd6?usp=3Demail">Patch Se=
t #1, Line 57:</a> <code style=3D"font-family:monospace,monospace">AM_INIT_=
AUTOMAKE(foreign subdir_objects 1=2E9) dnl NB: Do not [quote] this paramete=
r=2E</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">This now needs to be 1=2E13 to support `AM_EXTRA_RECURSIVE_=
TARGETS`</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail">change 2022</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2022?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I149d0ba7011e62a115a=
565813e1f5873907d464e </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2022 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 1=
9 Oct 2026 11:19:11 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div=
>

</body></html>
--CwQ3JkBHsXk=--


--===============5494033329416707953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5494033329416707953==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5494033329416707953==--

