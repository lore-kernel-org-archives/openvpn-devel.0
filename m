Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF01606A884
	for <openvpn-devel@archiver.kernel.org>; Fri, 13 Nov 2026 12:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gW2ukhqC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ZQPKBabm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ihT/2WYS;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UImPwAhD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=0VLIy7y4mgrCiBF8ns+nPAuIuZ1Eh/ojn4XtRb8gRCQ=; b=gW2ukhqC7aKUmUJ+KkQwBUtGI2
	VtZPX0Gy/FGOIGYDGW10y4cgEptblIjUehbwwN+vn1vDawBtHTOCHYSJwYBJQ4xnU9PwA01DWFSdl
	j9Cy6PXR15pg/C9mux5fcMa5EvmdUpG3dIBGcVL71z2VcVpXAmcwpKmeEI2MGfwQpA8g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xRqNZ-000000005FJ-0IhI;
	Fri, 13 Nov 2026 12:27:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xRqNG-000000005F0-1roj
 for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 12:27:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9alUqzBsJ2N3R/MGteVJhBvgTIQJCzBxnnoy2wy54N4=; b=ZQPKBabmue45siyoBIMlofKiC2
 o9HOGKrCfPDSJwEq3HlSUOQu7bhiv5hHlCuJ9jp6jE8KGKTqhGe88jCcVTgnp6WUmsHUDXDQEpmex
 T7mzNCUerlTDm1uv5AOCi5iGI303Y2iA6I7sxJTj6BHlIsKyH89yLKqH1uCWA2n+rhxQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9alUqzBsJ2N3R/MGteVJhBvgTIQJCzBxnnoy2wy54N4=; b=ihT/2WYSUanAwDQraKGdrycXvZ
 oXTWDjVZxVYz2SYnQc8DtcNtZPscE/zfoRkB7P71u5m9FJDaJsHWP8yhL4NXO8jKP6yGWXocqkhIi
 4WHqsrU7UfLXIOhoNzuusBB3RDkGnexYdj5b4q2yxuATbs8VldkKGn2TUVn+kvTizdu4=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRqNB-000000003jG-038C for openvpn-devel@lists.sourceforge.net;
 Fri, 13 Nov 2026 12:27:18 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-49318428d98so318455f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 13 Nov 2026 04:27:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794572830; x=1795177630; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=9alUqzBsJ2N3R/MGteVJhBvgTIQJCzBxnnoy2wy54N4=;
 b=UImPwAhDN4Zf9hnhKPrZnT8X1Nf0G5WrWGsMKAFqJNAAr1vaXFiqnc29+w08oEn4+x
 fcDYh1byKj5R3ciajLzQdHmF34kAV1Bu1gcaSRfiE1ONJqJECQ1+XPdkCybcVpECEBQ+
 4YXe8gTMoQYoCyemeqbOJTbEaRKuKPtJupUrqXDFuCeE5w/8rDeTQYdvNB+qm9rIIomn
 hEZ7d9ONWiDxUtKuCs9L3ArTiMltPBFs7gJVLLMZnnVkkO35584mnk/CuEo2vJT5vTbo
 9zqxU/N33KXWhOsqa5znXSt5z38OqHbDpFXB1XdLAQ9jjk+AW+HCLZmAHG1rJUUuimxg
 SQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794572830; x=1795177630;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=9alUqzBsJ2N3R/MGteVJhBvgTIQJCzBxnnoy2wy54N4=;
 b=B0nSCJFa4w754fZ1dyC0G07libJEnJ9kJsI0ob05cXjvIlm6w9Kc7x0dpo+7LXFzJK
 oEqM51Sy7wYFNTwoHc/PdPQjyYHWzfjC7VcqzWPb1nBkU66ov4VCFN//u8h/U59hmOAe
 ABHmkXhKvPowiPnKHbe7T2tcFUO4QhqSswdWhzCpkV3FopGcNBOxcNvdnUjZEkU3cfdY
 pP9e20WocPrCqAzbQ+7XYbFMbJVtejtx+1NJegdtVtiB/FVQD+DgoddiuGXAU27OXzs9
 W33GaZ8EFOCo8IJYo8hfPOBQ5487aSeBeyOHwpk4AeTAVuAWg1x1erbMMAETLJCTUFxk
 K3SQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGIXSfUK7PV+Ny2u92GpWdt8FhY2UeyGVnP5BBJjU5bbGWiuyCMarmBvSmMU3Ud1W1JIXPEK/0MLsNuk4UY@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/XqxHMXww+2c2QnaO5YDA2IPEMqWUEf8KuD302wHtAG0CQioxB
 DeJSpGB2QzTVnJ2AyICThMpWTcE+pUbfjJ3IrMWH10yel60Kd07rg0yW1DsjLddBmOpWnTaABp5
 dxFo+cugfoheI956vogjTLFM7bpkeg+83Z2U2lG5Rzbser/CCB7FGM0pigwr1YpdxII8Bs6j9aB
 gFHv/xAA==
X-Gm-Gg: AYBFou2jSFE4/69TBtkAgliY/zoq59qTSe48LcGvmS5rS+vgwac7Va/yi6NnlXd5cSW
 M8gdCPA14KbgShbWjtkfUX6DemnT/fOZyTYxMzSGc5mK+yOwQ29zgSruJ6kJMGVWlQDFaihsjof
 UlHanr+pq/zC0/2xlii3/tqcFytFXQbidTkwrkwe4H71C40L+dwFdQuXqByqy/e7a/PSkKvJv3m
 e9N2PwuIKkz+c03qLrOwFh2OHA+acS8slXqlV/RtbU+fXFDxCbzQOgOfH/h6h7HNTpnslj7uSkB
 kvb08kWLGbTdZMsAjJhnBmpWZ4+G1rghD2xYEwIKCAlDKn5QLxgzy+gkdFZowipRlw/oqjgStSS
 KPx0S6Ce1i/mqC4M4GH6oa1kxR3F6BVNb/pBsF2cA7WYgAkLBPpc1a2GwRxW/qUKLoYB51ggCj1
 MF0na81YVwsqzBK59HU07voNRP7QPnOVwO+OrBo1mU0DGFgNKSOgaRsP1pXOWeZoamWTpSDqrKY
 Sg4Qwt2axauXGu/Nr0bKCSgtXBNvt18OKaVB7oavHC24Zmek0/5GYFX1DALTWUOdGvsGco498t8
 UlQbrUxuRnZ4TNoOKLvj4Ms/CtiklBi9f99+6Pet6QCM8EVG9V7rUZQPW1NstRS+x3b+LzE8YWB
 9YOL9UEN4W5WSiwtT5+Rx+gibl4XPWLDgGeRcrOBZQ3yGw28REfYo3luivRdAKVMoEUoFcH/TpV
 xmtvLAzIkC3lsziSU=
X-Received: by 2002:a5d:584b:0:b0:490:71a7:6f51 with SMTP id
 ffacd0b85a97d-49c72ba6509mr5125174f8f.45.1794572830129; 
 Fri, 13 Nov 2026 04:27:10 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49c5f78214dsm5237923f8f.25.2026.11.13.04.27.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 04:27:09 -0800 (PST)
X-Google-Original-From: "Steffan Karger (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 13 Nov 2026 12:27:08 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448
X-Gerrit-Change-Number: 2182
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2182?usp=email>
X-Gerrit-Commit: 0a9a9b27bc1a2477fa608774c78096ac787ffaea
X-Gerrit-Comment-Date: Fri, 13 Nov 2026 12:27:08 +0000
In-Reply-To: <gerrit.1794490356000.Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448@gerrit.openvpn.net>
References: <gerrit.1794490356000.Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0NDkwMzU2MDAwLkllZmNmZDlmMjkyNDRkOWFlNmE1YTY4YjZlOWI1MDdiNTVlM2JmNDQ4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cf303145d03e66de2de96919551e814d931aaf1d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xRqNB-000000003jG-038C
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mbedtls: print peer
 certificate details like the OpenSSL backend
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Steffan Karger \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: steffan@karger.me, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Steffan Karger \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7891946994741197806=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7891946994741197806==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3f9VxQeBneA="; charset=UTF-8

--3f9VxQeBneA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Steffan Karger has p=
osted comments on this change by Steffan Karger=2E ( https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2182?usp=3Demail )

Change subject: mbedtls: print pee=
r certificate details like the OpenSSL backend
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-2

(1 comment)=


This change is ready for review=2E

File src/openvpn/ssl_mbedtls=2Ec:

ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2182/comment/b064183f_ffcc5abe?usp=
=3Demail :
PS2, Line 1252:     else if (mbedtls_x509_get_sig_alg(&cert->sig=
_oid, &no_sig_params, &sig_md, &sig_pk) =3D=3D 0)
Need to revisit this=2E I=
s used to public in 3=2Ex, was removed in 4=2Ex, and is now back on the dev=
elopment branch=2E=2E=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2182?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Cha=
nge-Id: Iefcfd9f29244d9ae6a5a68b6e9b507b55e3bf448
Gerrit-Change-Number: 218=
2
Gerrit-PatchSet: 2
Gerrit-Owner: Steffan Karger <steffan@karger=2Eme>
Ger=
rit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: St=
effan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@=
lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Comment-Date: Fri, 13 Nov 2026 12:27:08 +0000
Gerrit-Has=
Comments: Yes
Gerrit-Has-Labels: Yes

--3f9VxQeBneA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Steffan Karger has posted com=
ments on this change by Steffan Karger=2E</p><p>Patch set 2:<span style=3D"=
border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;back=
ground-color: #ffd4d4;">Code-Review -2</span></p><p><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail">View Change</a></p><p>1 co=
mment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/ssl_mbedtls=2Ec:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2182/comment/b064183f_ffcc5abe?usp=3Demail">Patch Set #2, Line 1252=
:</a> <code style=3D"font-family:monospace,monospace">    else if (mbedtls_=
x509_get_sig_alg(&amp;cert-&gt;sig_oid, &amp;no_sig_params, &amp;sig_md, &a=
mp;sig_pk) =3D=3D 0)</code></p><p class=3D"blocks" style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Need to revisit this=2E Is used to public i=
n 3=2Ex, was removed in 4=2Ex, and is now back on the development branch=2E=
=2E=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail">change 2182</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2182?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefcfd9f29244d9ae6a5=
a68b6e9b507b55e3bf448 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2182 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Steffan Karger &lt;steffan@karger=
=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe=
 &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: Steffan Karger &lt;steffan@karger=2Eme&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne=
 Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Comment-Date: Fri, 13 Nov 2026 12:27:08 +0000 </div>
<div style=
=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:non=
e"> Gerrit-Has-Labels: Yes </div>

</body></html>
--3f9VxQeBneA=--


--===============7891946994741197806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7891946994741197806==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7891946994741197806==--

