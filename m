Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55047C531C9
	for <openvpn-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8ZFJIOcWfoA+0xzDef+52iQuB7mL7cxQv+PnH7s4Pw=; b=RHd3TxGAhALaXAdIZAZsqGAP0a
	vc7HFSEn2NVEbpk5jlq8Xpa3IE3E8gL5q2zYQljChZj2y1nWkrGkDVlzMPae+P0tRshPm/X+POzB2
	PbpmpAFrMshwYzFjqgSMJUGA7hjd3b4wEqKNbuNxMA8uZC8/7FuUJF8yfm7afXg1EHkM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wnDfE-0004xJ-CG;
	Fri, 24 Jul 2026 11:02:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wnDf9-0004x7-W1
 for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 11:01:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cetO6QnrAXaBWMB+cecNPUu1O0iuiaDIKACcxCNf7yQ=; b=m2jEPmb1dI7Hpyj6qARL8EHEad
 vF1ST/m4F6/ZbbsdfBqIizv1NUpPm8nfsxd7TUItkRKiyFYIIUWRobOkOnPeCqXUMZRex1fDIysMX
 2t1HlQVxuPm+TWYrOJod4Im9rUwnXEBQO5F1YBZkXbDu4fiUGE/HL0AsKtdABIjK8Zgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cetO6QnrAXaBWMB+cecNPUu1O0iuiaDIKACcxCNf7yQ=; b=f
 xHdd1zeVUpeuBnJ6UMFJPscRO1glyUvw/LN0W2JxQ+g5dUa2d/63KrmPYnuzyRHsrU20FDCQwDsdT
 ZGYtdptIgGy1TlzBBqyYTSBeBRwnsVTJA2923Qvds1si4N/YA0bo8ROX5ksEbLFXqpt2/jl3LR+BC
 D3kgkwXSsWvct6U8=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wnDfC-0003gl-3u for openvpn-devel@lists.sourceforge.net;
 Fri, 24 Jul 2026 11:01:55 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-495590ba856so2998545e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 24 Jul 2026 04:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784890908; x=1785495708; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cetO6QnrAXaBWMB+cecNPUu1O0iuiaDIKACcxCNf7yQ=;
 b=dnDvQib+mmbCJXeygxNiMpEuNP0WNBYdq7lH2zYnMAjWlju31kyR4Dr1+tdtKP10F7
 xGR7fmiWNsQP/Hy8NHBz4JCxFz2BEbE24ZZbk5z0tjTl21SC4JzIA01oWdm8j8Mm7IMT
 O6qjECT1aOM/X334qI/9HPhhw4xYEu8TQlAkWNGwsxHpYs7DOu9apXV/8DAT24ZtF0c7
 KNQ6rR8ULLnX+m0W2ckKvrQE+nWnghGJFigHMrjn7G4d4zNXV2lUbbXOc11lmQZ3xagH
 GuEOo49z+LSVeuzJnFj7EnxjJph99S5L3nTluPuFx+/eLFXmco+osCDAOXBFPadL7i9S
 MntQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784890908; x=1785495708;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=cetO6QnrAXaBWMB+cecNPUu1O0iuiaDIKACcxCNf7yQ=;
 b=h0m7Jtl0gxaeULu/+i5lKrkJ18zaQ4GIPq73+1Pku56Bfqt/sEj031ijPJhrHZ2CFQ
 qiyDDx/Ee4iuQ4b2iEYPLdOmidhuaDhoGoGzfiXgI58jwcJB6f1SzeP+jCCSb2Cqg3WT
 26VJNyJ5l/HXVXqK5al7cm0FTmFNDM/mztC7LVgK1s0DMkORWuBpCJTbGLNl+RLLW/H4
 DdvyiQqIJedR5L0O4xOkDbHl9NvjNDEmYl01hfNdQj88HKAzP07OF9QwgNMpcdhD9E27
 D2JRH8UtvMtY6JWzo1qG3g4RfTg8ktofIf7LDgVIwnFhGTPMi8akIxPyrizjgJ2x6f07
 /RWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpGEGXZ0ozijTIH8aJtvZII57uCPWaoqz9RF2duL7KI+dpreML4iju4Wt5mgcC79GxwC3KHodvVxV4pZ3C/@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yz0LPIotk06BQ57AR95o9w7LoM0Krs2mbvtxfhb3VvExbI5Rbh0
 3wly8A7qmRo4OmpDw3UfkFsLca3IcghU59Wl8nWIqNEi3Jd/4xKL45LJ340bvRhvSXZsNmgPq7f
 XANRYe1ljKXMSu3ljrVmldYw2mRJrNXRIer4dRDGGQbevDbXE4ONSHbWG12eWvIy5vs7MNuhEmy
 5GiwzTsg==
X-Gm-Gg: AR+sD11ZMw4hK75MxEGAmRfx6v7IzK+vm5QLx7VzfjTAOrXlFPyhUh5S/aC/9G7ax8O
 xkliL3PRnKA26SbYOnhqnRgSfXI3aWxk4pPZsaciQ27MhE6wBEuAFtde7a486eJOqKsnwK/laEv
 0LJXZ2EM1LYRT/T1X+C7kw3xRs2TGmUe0We+gLaV/1HhbPzHpEzFWnxyxYGEvq9Ur7VOfF9gv3B
 5c3joXS9BvPgtUsl4HjYBKJLino+SVI6C35XoZi01rIrAGD8uBYhQd8/eNC8rXMscipwizdXhBi
 j/bfWt8g6eD5mCVsWA084ymJjjQjV1jJpah9IbSA4Fvqiy6jJc7vHOvu9kr+cwcdBudAZSNpzwA
 Y8e4HziWh51gxeQ2BFn/kCbn2zg2dJBn933l3llpuBOpOtvrDqV3NDzyEAk6hYxUD2nVq1C8ReT
 s56svRzR0KXoPRMaQ2LgAGBP+6OseZiTrMapLK9GJcG0mxI4WK7XlyBA9yqr8zEgbuT0bUFcwn8
 2fkXEbdDDQ86skOfEbRjN4qAQnwYbgAGajopoPFXfxvUutA/AadMxoEY37THzsOKZUA
X-Received: by 2002:a05:600c:6d90:b0:493:c8c6:4989 with SMTP id
 5b1f17b1804b1-49573cc162amr52248485e9.6.1784890907781; 
 Fri, 24 Jul 2026 04:01:47 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957afbf943sm63105545e9.15.2026.07.24.04.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 04:01:47 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 24 Jul 2026 11:01:45 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0
X-Gerrit-Change-Number: 31
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/31?usp=email>
X-Gerrit-Commit: 7f223f70b33634472d7e5329855567546ce327ff
X-Gerrit-Comment-Date: Fri, 24 Jul 2026 11:01:45 +0000
In-Reply-To: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
References: <gerrit.1677175662000.I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwOWFhMjdjYWExYTNhYWIwZDFiZTYxMThiMjZkNTRhMWMxYmY3YWEwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0eba8f41382bb42229165cf100b312bbc82f7f2d-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wnDfC-0003gl-3u
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Allow to use
 OpenSSL's SIPHASH implementation when available
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8850047813858178760=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8850047813858178760==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qHqGa/luDPE="; charset=UTF-8

--qHqGa/luDPE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by plaisthos=2E ( http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/31?usp=3Demail )

Change subject: Allow to use OpenSSL's SIPHASH =
implementation when available
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 20:

(2 comments)

File src/openvpn/siphash_ope=
nssl=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31/comment/757021fb_e8=
295323?usp=3Demail :
PS20, Line 82:     ALLOC_OBJ(sip, struct siphash_conte=
xt);
> Strictly speaking this requires buffer=2E [=E2=80=A6]
Done


File te=
sts/unit_tests/openvpn/test_crypto=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/31/comment/436475ab_bd3ca198?usp=3Demail :
PS20, Line 935:     cons=
t char *message =3D "Look behind you, a Three-Headed Monkey!";
> All this t=
est data is duplicated, could be shared between the two tests
Done



-- 
T=
o view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail
To u=
nsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I09aa27caa1a3aab0d1be6118b26d=
54a1c1bf7aa0
Gerrit-Change-Number: 31
Gerrit-PatchSet: 20
Gerrit-Owner: pla=
isthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Co=
mment-Date: Fri, 24 Jul 2026 11:01:45 +0000
Gerrit-HasComments: Yes
Gerrit-=
Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@lichtenheld=2Ecom>

--qHqGa/luDPE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p><a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/31?usp=3Demail">View Change</a></p><p>2 comments:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0;"><p>File src/openvpn/siphash_openssl=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/31/comment/757021fb_e8295323?usp=3Demail">Patch Set #20, Line 82:</a> <c=
ode style=3D"font-family:monospace,monospace">    ALLOC_OBJ(sip, struct sip=
hash_context);</code></p><p><blockquote style=3D"border-left: 1px solid #aa=
a; margin: 10px 0; padding: 0 10px;">Strictly speaking this requires buffer=
=2E [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin=
: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_crypto=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/31/comment/436475ab_bd3ca198?usp=3Demail">Patch Set #=
20, Line 935:</a> <code style=3D"font-family:monospace,monospace">    const=
 char *message =3D &quot;Look behind you, a Three-Headed Monkey!&quot;;</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">All this test data is duplicated, could be shared betwee=
n the two tests</blockquote></p><p class=3D"blocks" style=3D"white-space: p=
re-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, vi=
sit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3Demail">ch=
ange 31</a>=2E To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E<=
/p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/31?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div=
 style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I09aa27caa1a3aab0d1be6118b26d54a1c1bf7aa0 </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 31 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 20 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Fri, 24 Jul 2026 11:01:45 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: f=
lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--qHqGa/luDPE=--


--===============8850047813858178760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8850047813858178760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8850047813858178760==--

