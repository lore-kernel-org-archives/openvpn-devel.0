Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3795DC982CF
	for <openvpn-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3XLqspFUqCRI7wke7ZS5/mNKLbwjz4SzCD2IUCRueXY=; b=d6ppFLEHPUI2yJbnBeu4wQ9ign
	Ac+cMRuwz2KqijaRgq5EtvPA7Pp/00K1yLYDoQ4rsdNBI8EcRIZOXjku4HERPA986mRQefalu5sSs
	o1I1PmZ5z0DcqlSzWNdPV4PRJvXfB9A0ebiS0OmlMVXeAGDNnSOFWmKgxmKTM6FkixcE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x7C0D-0000iy-N5;
	Thu, 17 Sep 2026 13:18:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x7C0C-0000il-9W
 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:18:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=t7fwx/3BvRiRdnw9mOUc/varMrEWCb6DNNcJAWlQygI=; b=NtzoqRhheWo1YI8vden2KZZaUE
 LKPTCQE5V4dm+HDWfjoqoANC60/5xLHvLCLBVV3JHVoJSiHspkV6ZcAKRTz9ept3UfYpbw4/XW6xk
 PA1Z6tV81X9l19WX0rJrkTNG1zCir34LnOlyohfKK4RhqBHh164qoH69VvdfYxjuvTY0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t7fwx/3BvRiRdnw9mOUc/varMrEWCb6DNNcJAWlQygI=; b=d
 juam0lnAPRTxhCDwK0oYNXWf4NqAF/4ez4DFtkqRBwuILW9aOXX7NjgQAWzjTCKlnmYNhcdjKaL1F
 QMajEkkEsMuLWtOA2ralpznTGviGeuBpLDGa8mvPx4beL/nINPgkZcXLq2hYMHGi0nQjvLmSBfkj+
 Wo7ZCAVg4MIvhngw=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7C0B-0007WA-G0 for openvpn-devel@lists.sourceforge.net;
 Thu, 17 Sep 2026 13:18:13 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so608253f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 17 Sep 2026 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789651085; x=1790255885; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=t7fwx/3BvRiRdnw9mOUc/varMrEWCb6DNNcJAWlQygI=;
 b=ej4O2L5Sg34c7d6d4XUanaAU06X5GAckNOF4I62x063yV9HsSmVTDKlUSHCcNc6oll
 X5jCsB2QxIQEnrKCvYTbRrOSiuQPCwPGuhriNeBzOjqiRsJbxcicx8p8OhxV2l6acbBi
 b1xpxOu9YiYvR/aghMpgolVDDqzvDW8k1E3BrPEel+XVlw7AT1fN6UVnpZaA3TXEaDRD
 vXk+NJLB24eOeYWDazQtAT6EKQr9P/jBfVcRiSeJMnocN19uKaiOPpOz9R6dVo/F2n9w
 UMj2Li/KSP4JfPMiQiZ99u75a/9AlRFxjAO1RFk4XPHSpfC0NQ/tLP9pelKwtvQgdXqT
 IktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789651085; x=1790255885;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=t7fwx/3BvRiRdnw9mOUc/varMrEWCb6DNNcJAWlQygI=;
 b=PsDXhyVgJAHZ7594jRDdzCHhkZUAIlmzcU+sbXRmMikLqUy48YyOSNyGo58GCfJsEK
 kcp8mkBk6gIK2GLPhnN6YAwX1dnDtwI23m22HhOA0i/3E0NqD+X/xIbhdA8WUbNp0mBr
 5qZjZsBwtNFXJXB4d3bjQcui1fW5OHsekO+3RFyEnwLUqtT+1lK7bO2vyGhQdK/tOL7f
 tcNFiwcnmQGpNnfrm57ZTERW9Jo6Fyc9XvBnvGdwHu7ijJgaXclPKbP0yqXotNDBhEWV
 jvxLnwC+vzh/2vdTt8xplPimT//bq2UKGHrbD0DdPmw/eP1fYxzwNI3m9xcFk7k30f2z
 cycQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByt3G+cNogvLgakWwB3y2U8deXrn4n9kriK86z1AP5Xt+AwNmTpJTvZwxAVkg2YAA161c4o9rTilG6VrCEB@lists.sourceforge.net
X-Gm-Message-State: AFuF++miXQNkkEYsljALnERwkdI1OQilUDKi2lRivlCnHx21MZ0G8v0w
 h027CUxqbzr7kEnS/zhrFT0OR/SWpYStxiu/c6nlJanXN4Z2pmzzO2Y23BPJ4GI+gmR26b+SEtY
 i3Ov10mvqCaqJi3vgdw+9lyICZsQMcCxp7o8AK3sn8ftUMZOLGdDeRs7avPH3nBPgPnWDxUjqyi
 kNbW2sZw==
X-Gm-Gg: AYBFou17mbLlWpcR12wbse/5yKghQ9waJP3iwAef8nGIyDOC+kyQ5oyjUTd7M8ZXH9b
 2I1Re40zY/f5kx1uxiaufRBPPuY7hTMEsWStIKSRVH1Mp+0fX+5GHuHNSXehJ4g1Avl3urwI0Bo
 G7mnIJkDk3oA9XtBClVD2+XWdQUL5yNVHaYyIQes/MlqB3b7lVSXUOBEmED6+Gn8EOqAM5Q6Dn+
 89LfPeZP3So/L13D4paVvDESeJ/X+RjGLROw4KE73goaTWXEDgYRQ7vOQPgRAjmE6soP16x4jOz
 6uBR7U9CAHlS0S3eEoEnyzokqqn6X7ImL1MbfRdODiziGRYWyflh5/UY2dj8To8ryOag8S/a5+G
 PmTGTujcvmhJ5GYEeE5TfNWKD/vewvRtttXYZUfRg0Uykp+aPDcA8thDhk4lPy8BLp4A5FGc3HY
 zFyXkA5bOo/VI2GtCaETVBErNAN8OxN17KT6UTyjjWbZN1cuXh8TZnMrX+awz2fsfLJvb4749zX
 quN64ZXG5Ga8ayeWSeMQuEOCScIJ5CDb+Chd/bRzyE9gP0IYlv/lgZy0UNVVPBHDRRUyyGG5Teh
 KqIeFL2/UEbh7mA2essphMxvKiRwi0bOCRy6POjPaZwm4L2oZKD4kfCXvGsW4g==
X-Received: by 2002:a05:6000:1787:b0:487:ee4:b5e4 with SMTP id
 ffacd0b85a97d-4870ee4b665mr12587483f8f.8.1789651084740; 
 Thu, 17 Sep 2026 06:18:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf27ce2sm15617427f8f.20.2026.09.17.06.18.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 06:18:04 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 17 Sep 2026 13:18:02 +0000
To: stipa <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 26
X-Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
X-Gerrit-Change-Number: 1748
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1748?usp=email>
X-Gerrit-Commit: 5fc002eff7bf1be5478dae6e28a336f1bc904b06
X-Gerrit-Comment-Date: Thu, 17 Sep 2026 13:18:02 +0000
In-Reply-To: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
References: <gerrit.1782719911000.I375a41749060b7d006647bc27002c55436c8a8bb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkzNzVhNDE3NDkwNjBiN2QwMDY2NDdiYzI3MDAyYzU1NDM2YzhhOGJiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2ad312378f69e3161ad25e73cf90b61c0cf7a3be-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x7C0B-0007WA-G0
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Measure probe
 RTT for candidate-band selection
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
 ralf@mandelbit.com, lstipakov@gmail.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7303510520782755534=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7303510520782755534==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pzWKuG8wN5w="; charset=UTF-8

--pzWKuG8wN5w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa=2E

plaisthos has posted commen=
ts on this change by stipa=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
748?usp=3Demail )

Change subject: oob: Measure probe RTT for candidate-ban=
d selection
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 26:

(1 comment)

File src/openvpn/oob_client=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1748/comment/187af1b5_b3445fac?usp=3Demail :
P=
S19, Line 274:         results[i]=2Ertt_ms =3D (ms > 0) ? (unsigned int)ms =
: 0;
> Deliberate: a reply carries nothing that ties it to a send round, so=
 measuring from a resend would m [=E2=80=A6]
So that seems like an omission=
 in our spec that we have this problem=2E We should correct this to not hav=
ing to resort to something like that=2E



-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I375a41749060b7d006647bc27002c55436c8a8bb
Gerrit-Chang=
e-Number: 1748
Gerrit-PatchSet: 26
Gerrit-Owner: stipa <lstipakov@gmail=2Ec=
om>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
=
Gerrit-Comment-Date: Thu, 17 Sep 2026 13:18:02 +0000
Gerrit-HasComments: Ye=
s
Gerrit-Has-Labels: No
Comment-In-Reply-To: ralf_lici <ralf@mandelbit=2Eco=
m>
Comment-In-Reply-To: stipa <lstipakov@gmail=2Ecom>

--pzWKuG8wN5w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: stipa=2E </p>
<p><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1748?usp=3Demail">View Change</a></p><p>1 comment:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0;"><p>File src/openvpn/oob_client=2Ec:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748/c=
omment/187af1b5_b3445fac?usp=3Demail">Patch Set #19, Line 274:</a> <code st=
yle=3D"font-family:monospace,monospace">        results[i]=2Ertt_ms =3D (ms=
 &gt; 0) ? (unsigned int)ms : 0;</code></p><p><blockquote style=3D"border-l=
eft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Deliberate: a reply =
carries nothing that ties it to a send round, so measuring from a resend wo=
uld m [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">So that seems like an omission in our sp=
ec that we have this problem=2E We should correct this to not having to res=
ort to something like that=2E</p></li></ul></li></ul><p>To view, visit <a h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3Demail">change 1=
748</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1748?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
375a41749060b7d006647bc27002c55436c8a8bb </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1748 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 26 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstip=
akov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: s=
tipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Comment-Date: Thu, 17 Sep 2026 13:18:02 +0000 </div>
<div style=3D"displ=
ay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: r=
alf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> C=
omment-In-Reply-To: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>

</body></ht=
ml>
--pzWKuG8wN5w=--


--===============7303510520782755534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7303510520782755534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7303510520782755534==--

