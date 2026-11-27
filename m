Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E388606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 27 Nov 2026 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Qw0OAAJ8;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Qy2/BAwM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=mlpm4Gn6;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ORZsZ1Mu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=EFkUnlD+SNseVIgfUttTeV+83+6fR3bpyC86DbTckEI=; b=Qw0OAAJ8GZhi3yZq3G0ifDFdrY
	s9C8ykgD9BgKkeEiWi+WoBYz3j7gBxvHLGefDHlcEQs8yIlEoyaWD8pvWTEs686MLwt0NOMSGbGkm
	W5eVnXncBJnlR9F0mYSKDFcpLfGWTNP5sTkWATI55LKx0JJ20YjT26b9nSW3m4bxFucE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWxXd-000000000JZ-1p5o;
	Fri, 27 Nov 2026 15:07:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWxXU-000000000JE-0iOa
 for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:07:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nlepeAw5DRYRA14XcTkITb/fukC2TRUYHet8SPl3jqA=; b=Qy2/BAwM6Rj4D5tENXmSF4deSG
 qrEqOyA8vV+D9DN1HDqjxAlgrINOrHdAaYASe9yr7R8yK8S9l7yy+zGOyhrPG2a7Oi6cO8iAMw7wE
 b1agztZhTMcOuKVc3J+Dxii0xvi+xgwUbiK45aJ0dUtXNWF1Kb+3hh6iWXh18BTH09OE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nlepeAw5DRYRA14XcTkITb/fukC2TRUYHet8SPl3jqA=; b=mlpm4Gn66344GcMCLrYHkxW1Vm
 YA/FkwL33qfymLyoxqbvEq6IXSQoJxvOZmemaeusl4CAFHBsuv9+nioDNP9XsQDpgA/pvkQHrVYw7
 evqEO44C/35mb04GGAmaYacOax8e0RbtEihMEjIalgjLODz6rupNq4IK0BXE6e0A7yvU=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWxXN-000000006sh-3X3H for openvpn-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 15:06:59 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so83391445e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 27 Nov 2026 07:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795792011; x=1796396811; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nlepeAw5DRYRA14XcTkITb/fukC2TRUYHet8SPl3jqA=;
 b=ORZsZ1MuKz0Vk9gYQJOjHe4PG2LsuYpa41XkS3giJWLhZldGo6FrrOa5+r+Yxw4fZR
 EcTFGBuS1QxC9mS+DZPaIx+WyC0KmNmBUVUA/wQeXPoJCpCdR/v5z21Bsd4+AyorFYUy
 M1mUp0r49IEHHA6FrHl2W0CvphxE1nOVMvSVb6sbpV6X3OiDJiV8JF6iLEeqc6Tb9VnQ
 6W3tV6o9Ud6xgGc7wAIVVyWj736qK6U/6UL+1OCaprWaV181g9w3XnVeovFkYIjnQjWx
 jo2RFqH9C3iPPRE31i+oIuK+X8SI1JjanBJTDk5nig3/9NJPKrblk7/JikUMlp2PfWt2
 MfNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795792011; x=1796396811;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nlepeAw5DRYRA14XcTkITb/fukC2TRUYHet8SPl3jqA=;
 b=kGBRS/o0YcNo3vgoyugAuNjsVZdWL1AONsFr8I3xptmWx2i4hKJaOifQ7HQBnfJWF6
 8Zkpzwh6OR0+D9USzltLhYPeogKlhc7jqhtSJ31lYSfcaZhDpyWyPv/g6oQ4akKEId12
 GX1MzClPkxvFCs+FaKe1yqqdXSvbp8QbvfBZrDCXYfPsxfXACtx+xAD5W/xNaBFCag/o
 ky9h9EDkqp4xTzt4jb6MiAXqGV+ICiCo2jGuMf0QfYeVsXBNE7S+slMY/A7MMGuWGKLy
 dg4P0M+397FGc1+TZVnbI7REIrcvp4mMIRBa1fruJIA4Hk5FiA4MnFiSw1p7K5eQrfyP
 fvbw==
X-Forwarded-Encrypted: i=1;
 AL+hErHP9E29IEmhP/jzTKUCzj5Gr7+ii+D4O5ovN9pykaMUnouJI/6vFOJgKK4/d/e5Q4SRzBUNfYdCd+AVZJCH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+y5wpxw4mRXS86HaMemwH7SvORHJRa7WxtfH6OyHjX+anNqUTf
 EsDef490QOhlUj/SUTjKHoTDV4IY3XYp97pM2UV6reNYCYGO4dhnD+FL0BKQY5fPpPFASdtojY/
 Y18rSvKyijmlA+w8uThN0KnQ5ZkhlgZ5Iu3tB5vTYWPRwn8u8cjMADbSaIOAYabX0G47V6GayQO
 kgNF61wg==
X-Gm-Gg: AZFdTZePrEIOiXPP1q9J5rSzIBgXZ7h0YWwu6YfiwsECSmS3Ld9u7AP7WiAlA1xOG5a
 8ctiiGOcg/Jnom7Ep6ISuRKcVEMj97xzBti8RdvGM0CpIsCsFA4IEpJV+y7pPF16l/wlxlE98+x
 oVa6hWIO85g3CDYLFQqmrMQbIWtUuSo9a5NBmEI3JyVxtzv9GWOPLwsTsJ4lP7uk37ytpMN872J
 cPHGPhSaN14O56BChNQtl/ncVZ58FGNjSCARZBUUqrQ1jmpjs7VP/ywpR6Xc+Xb9/u0ecKN/hfM
 EPeM1Zlpj+00cAQ+1J+9G2bPh6Gv+oEql+KA4kUECQQdsirPaP2JhH2ZQ6pi3sAPyanQ/qctLC1
 F6KKUFbx35kQAByuu1/ec3qeqk8zcJV2Mq4v4EJumAFx4YJw7AHZCaaxyzWCKde+89A9RUWXFOq
 g80gQP3OeSv67VNIiPRzR409N/UmGLe8sJtLGWIvJSHZmf5g2eeulSYl081B7jTQM2H2VnnCa9M
 H2Z2S7y5ozzLe24UtA2WluxijUgBnn4otGyl/Xv9s3aP9nA22on1ZyO/C13uwTGqnYJM7ZR8eA3
 PPAZYzIOcx35ZQ4hTt8jM10v9J3/A+9hmQmCrkD/zYGkMYJieYCiHr3a90tH82D1/JwFnYuYeNu
 ixXrZYmRGiZleWWBd+dtEi5Gf9y9RNvgM7D2yajWrrtMlScPvE4Z+h+YreP7rRm+osPrtbX+wP0
 58xZ0LhqsQJ+6+aI0=
X-Received: by 2002:a05:600c:a085:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4bb887ca0dfmr525501705e9.4.1795792011069; 
 Fri, 27 Nov 2026 07:06:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8849e598sm686526325e9.8.2026.11.27.07.06.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 07:06:50 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 27 Nov 2026 15:06:49 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b
X-Gerrit-Change-Number: 2363
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2363?usp=email>
X-Gerrit-Commit: f04d6e6e58496e544fb7af8b7fe836277ceeb2c6
X-Gerrit-Comment-Date: Fri, 27 Nov 2026 15:06:49 +0000
In-Reply-To: <gerrit.1795791294000.I8a1b576401313f826a188dc40f226726f378066b@gerrit.openvpn.net>
References: <gerrit.1795791294000.I8a1b576401313f826a188dc40f226726f378066b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NzkxMjk0MDAwLkk4YTFiNTc2NDAxMzEzZjgyNmExODhkYzQwZjIyNjcyNmYzNzgwNjZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b7d7b9e4d1b62dda16a890b2c9a1ceec22c0874a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xWxXN-000000006sh-3X3H
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: xkey_provider: free
 the signing context when sign init fails
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
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
Content-Type: multipart/mixed; boundary="===============7674952289076601457=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7674952289076601457==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="K+DozrKzRvM="; charset=UTF-8

--K+DozrKzRvM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail )

Cha=
nge subject: xkey_provider: free the signing context when sign init fails
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=


(1 comment)

File src/openvpn/xkey_provider=2Ec:

https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2363/comment/8ed6006a_5c539457?usp=3Demail :
PS1, Line =
1097:     int ret =3D 0;
> while we're in the function maybe we can remove =
the useless assignment here as well?
Done



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I8a1b576401313f826a188dc40f226726f378066b
Gerrit=
-Change-Number: 2363
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 27 Nov 2026 15:06:49 +=
0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Fra=
nk Lichtenheld <frank@lichtenheld=2Ecom>

--K+DozrKzRvM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/xkey_provide=
r=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363/comment/8ed6006a_5c539457?usp=3De=
mail">Patch Set #1, Line 1097:</a> <code style=3D"font-family:monospace,mon=
ospace">    int ret =3D 0;</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">while we&#39;re in the fun=
ction maybe we can remove the useless assignment here as well?</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail">change 2363</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2363?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a1b576401313f82=
6a188dc40f226726f378066b </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 2363 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
=
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 27 Nov=
 2026 15:06:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments=
: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div=
 style=3D"display:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>

</body></html>
--K+DozrKzRvM=--


--===============7674952289076601457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7674952289076601457==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7674952289076601457==--

