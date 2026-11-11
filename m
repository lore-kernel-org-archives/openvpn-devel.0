Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2096660A2601
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gI5Lrydw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=G1zfV+s5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TiZ7m+q9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Hsr85e2k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iJ0iJpbnjbBKzYK8T/eEH6iXJEfqMz0qnTdAV6TbxA4=; b=gI5LrydwPgiD9xKjRrMYnTbSzy
	Ui1yc1ZG9p2Qp/zk9pOKmIAALEcEO+/2PgPKKOGV3lfWe9oYRJH06MBRWUxSFFJavVGPIH4IKXGxk
	PISByHasycuXD8Z2cWU7TkdWmHvxoECJL3Dz5YfYs62LNuVTvXaq2lcDTSwpFEDgEBp8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR6Ao-0000000089v-2qtC;
	Wed, 11 Nov 2026 11:07:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR6Am-0000000089o-42lh
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:07:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1gdqsJiWiFaAca7BrJLlPR6AIqow2VcYM57UcptqlJE=; b=G1zfV+s5uBqKoaawYhuKWq4R4H
 Ft0UAH+2rakUcXwiF6V37BgSFIYAxEQ2B+a9XCZOxZEwMAejWf7It3Vmg3nqI3Y2Xr3A97z6isCLb
 EQk12PP2I996+gRYtWcmfxxRWiR26e4FGM1I0aZHUJfi5FPfCzFVkTp4YSECtCt1iboU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1gdqsJiWiFaAca7BrJLlPR6AIqow2VcYM57UcptqlJE=; b=TiZ7m+q9dRz2LzqUan4cIC+OBg
 bZNlITk6CKRwig6WTm6PzB6XXIiBtRa/U96dmMmI7yRqE3pldBG9wDf2LBUm+GFNlVD7/QVPdP9Z+
 jtrh+QlY2OYUmatHvLwFimyqkcvnaLTFwjZWSD7dBYHZfci69JGLfTujP+BmL2c3NQbo=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR6Ak-000000005QB-33wT for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 11:07:24 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-492f0a1b685so2088202f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 03:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794395236; x=1795000036; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1gdqsJiWiFaAca7BrJLlPR6AIqow2VcYM57UcptqlJE=;
 b=Hsr85e2kHNK7AJ9nmKnl/fzOzFr415PajnZqqsup8H5FDFIeKObMq3BKkww3SbcJer
 XiHW/3k8lHXuLkydOFsBzL/oeo1eG7gj/UkK+RF0OKfSQtv2Jo/6TTQFNM1erssLxKLr
 olHZgFbC70QZ8fvkFGFcAB6yb85EwloM2dvPTBAVTAlE2fzEBUuVOqL6MXG4OEintvWB
 O73a3XTLDx/UKXkUYNDd8vXWfLA9zui2SyLMRcG/1CJ4UyO1wPqWC0eqR/1VvWJZZtb8
 j0k0S1S9xcFaETh+rApsNPx4jXs/W1mMiM8RzNYgDHf6udJaYnUS1GimH4Vc/s4N55U5
 5EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794395236; x=1795000036;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1gdqsJiWiFaAca7BrJLlPR6AIqow2VcYM57UcptqlJE=;
 b=whT8MhlolUuhLGJdmjECTJ4PGFzLHgJJ6SabaSM/JjdSimUc70q9vPIS9CsFWZSCkZ
 du8JtipXQW2o9gcEt8Ydo/lpMUh5ybYgbykOAfdNeL33PSLKOhwCg93iiPnZ5dCgXRD+
 h4Rp7VZGW1SFMZC49QLviBqakXItncBh9BpgvIQEkz26XlzpCrBt3KuCvaT4kieOgft7
 jUtY/qfQfcO+yjItI9q8mQDMfwrPxtCuPXP6QPwjqJL9jnIfVOTbbIXXIs8D9EIWsglY
 rvV3GZMFoZ5nadnXDOTI4TFje++DEwWYDP4+/9n2MTYhZJ+8IL4J1YrddV/g5owi0f+7
 5pHQ==
X-Gm-Message-State: APuU4Z/JB1O3zEvH55I7xs6zkpZnbla5IvfvJnt9zFH7sb7QcP0iW+xz
 afpPOMrLHojjMN8fT/AytfDgqtootuBaVaomr0XJjAiZKNaUl3kno6ajsJOcW4yTrcc5jaOE3+L
 1XuSMMmJkyk+9PV9Uo8XzIu+OIEvVJcryGkRjd9mFMg66F3YgaKeedXSDEzk36ulVF7GJICBtnU
 Zqt43bUA==
X-Gm-Gg: AYBFou39X0T598evJmvroab1ByoaDNAVJvn1E2kSj1cc/5iJ2Z/MoLDi/mLGh8et5W9
 fnk7OBSGBMr+eW1j5AItbNjjXjg2jiUv6ZAU51EgouoRSuWHsAMLxuE12qzVafH4hnsNy+LjONS
 vrlQNewVY6lQr0Hyrwbov/nl7iAHj2rNO+FRKglKbO5bk9AGHL4A7c8KZioXntmZkxcNtY8Nj6P
 IT/JS3tzngyoAvTX0sdkNQz38g/LqnYb8RA+PZcUbI88Ohq4DEpGxMzN7RoMk5YQ43PSN3/SoW0
 EGCTRCtJvewaX4yXKV0AQnJ+g4mX6vYfIL4dXQvAqGXjTXj7QORYnI5wXoPcX5myRDZKE8r9UhG
 jqi9Yt2G1FBwdt6n5QzWDC3yi/G/0hZAd+j6i4CoYmeTMGOCpFd9hcB8ZrWKl+WanpgnptGprpg
 vR/o6nYJgvTkxSA2LVkN0JNtp9/VI0Zp0p00R2FTFU0Zphycit4hDcoRhH/JyDCBuxDcnDJJNH+
 jOuGgFs1vv0WNYoXZ++3NOKtZJl/kydkywfbyB78u5w5setcWkGnC9zIR/asZCu++IZ6lknibV6
 taMctmXK55VxzTFEhUnmnh1+MFIjpFE7rXJz5gWg/SOzbEZvfKeimMLdkLJ6ECrZewJtn35fUCr
 pcWWPUzrgvh+MmxOehx4DbtibbWGaXekNKinjis8amsTELmo2RDVPNFXSeyMrUnolonJ2CoP+Ke
 QqHBvlOZHfpGlm0B4=
X-Received: by 2002:a05:6000:428a:b0:492:9630:6a7f with SMTP id
 ffacd0b85a97d-499c7a26735mr3640679f8f.55.1794395236065; 
 Wed, 11 Nov 2026 03:07:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a4238sm10791845f8f.54.2026.11.11.03.07.15
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 03:07:15 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 11:07:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff539e1
X-Gerrit-Change-Number: 2169
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2169?usp=email>
X-Gerrit-Commit: 07f6f57e5f8ddd13fe97d81397579999a4e84442
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 11:07:14 +0000
In-Reply-To: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
References: <gerrit.1794332732000.I86154e5c997b044f6913bddab58b43193ff539e1@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzMyNzMyMDAwLkk4NjE1NGU1Yzk5N2IwNDRmNjkxM2JkZGFiNThiNDMxOTNmZjUzOWUxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <fa370ae6f4e0874992064b1bf633064f337e9fa1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR6Ak-000000005QB-33wT
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Extract
 tls_pre_decrypt_verify_opcode from tls_pre_decrypt
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 antonio@mandelbit.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4397506169980313019=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4397506169980313019==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="d5zgjTKoPwk="; charset=UTF-8

--d5zgjTKoPwk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2169?usp=3Demail )

Change subject: Extract tls_pre_d=
ecrypt_verify_opcode from tls_pre_decrypt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Patchset:

PS1: 
>=
 the patch by itself looks reasonable, but it is not doing what the commit =
says=2E=2E=2E [=E2=80=A6]
The extra hunk existed before but I forgot to sta=
ge it removal so it is now there twice=2E Fixed that in the v2=2E



-- 
To=
 view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail
To=
 unsubscribe, or for help writing mail filters, visit https://gerrit=2Eopen=
vpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project:=
 openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I86154e5c997b044f6913bddab=
58b43193ff539e1
Gerrit-Change-Number: 2169
Gerrit-PatchSet: 2
Gerrit-Owner:=
 Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Antonio Quartul=
li <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbi=
t=2Ecom>
Gerrit-Comment-Date: Wed, 11 Nov 2026 11:07:14 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Antonio Quartulli <an=
tonio@mandelbit=2Ecom>

--d5zgjTKoPwk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2169?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2169?tab=3Dcomment=
s&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">the patch by itself lo=
oks reasonable, but it is not doing what the commit says=2E=2E=2E [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">The extra hunk existed before but I forgot to stage i=
t removal so it is now there twice=2E Fixed that in the v2=2E</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2169?usp=3Demail">change 2169</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2169?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: I86154e5c997b044f6913bddab58b43193ff53=
9e1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2169 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display=
:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;anton=
io@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;antonio@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 1=
1 Nov 2026 11:07:14 +0000 </div>
<div style=3D"display:none"> Gerrit-HasCom=
ments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>=

<div style=3D"display:none"> Comment-In-Reply-To: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>

</body></html>
--d5zgjTKoPwk=--


--===============4397506169980313019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4397506169980313019==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4397506169980313019==--

