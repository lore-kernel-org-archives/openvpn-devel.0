Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD5D606A31A
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MN/of4xZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=ObI0cytM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Cay+fwpC;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DbKmULHr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KO7epGgnA8Ehy7QsExr2qJxyTzZ2AGAfgKfA9A8NrY4=; b=MN/of4xZmXKmwOdKacSle2Ekbg
	692XfW8Dd17EuJw70S/BcIRYNAo1RbSVZyIqgG1coETwdn97Wzgc5G2fdml3H0GedR9q++zJAifk+
	pqimlZIl0vwoU3g6t3XeHNv1a6psnfA6I3UND/rk5SNVZ7nuaD3mKAAi5dEksYqye4Hg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMm9u-000000003tR-0btf;
	Fri, 30 Oct 2026 12:56:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMm9e-000000003sA-2PWo
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 12:56:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rDLsF5HwDVvRq81EOfea6kBK4XCWuHM0gyWmRY21U5U=; b=ObI0cytMau3y2dw/0cUSZJsLM3
 7OtciT/NzDQ094RJdYCZK2N85LZha4V67qieoUnigWhOAZUI0FICfyn4og7zWj0cFhzaynKEZIzBS
 Bl2Mct09UNckF5q5QCZHZIQQHj/OGQCaWi/Nlr2vSSlJXw2Gq3SGeMo9qKNpmPzArj78=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rDLsF5HwDVvRq81EOfea6kBK4XCWuHM0gyWmRY21U5U=; b=Cay+fwpC3X/JSkHZd3j3dUTeQL
 Uyd4CTDKilj3IhmETZENXaIQSru2a/8FQo0fAdAC5NX2W4XkCZiaHc4DXOoeo07SElS5bneLcbge3
 Sm9iWsiutPGtgj6muIQAvESfN1scZVcLxrHMTdI/+oniFWGYjGvy29UHHqRmedDdhfR4=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMm9c-000000005Lk-1E3C for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 12:56:22 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso327979f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 05:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793364974; x=1793969774; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=rDLsF5HwDVvRq81EOfea6kBK4XCWuHM0gyWmRY21U5U=;
 b=DbKmULHr6UK9zVLUqQr9FLvw1jQ/fO5/jpJex0D82ZMxbNmAw+BTmB5YqdWTeQxDoz
 gJjYU2Ooi2YToFNOgGDaSqpZCSn9gPaIR4HfXQWHslOuNGaeGzXcYUVxmAZY7JcGPFwH
 0bjutRK1wa5Ds20ahHYxiq1oxqA5cHLG0H5OXkESmQbqIPqXMnQ7U+v/PHw1D0s0DVvz
 F6I44NEYODSnzG0QdR5nOrZ6bXatLf7lYFTvO6Ozx/6QImJws4Wu5EaPEv5pW3oF1xmq
 KmsbD/PZHN+nNcn921Ca57ADI2JN5Yi/kZEixw4mj182HIUirINXXwpodL0DQdki30yB
 3uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793364974; x=1793969774;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=rDLsF5HwDVvRq81EOfea6kBK4XCWuHM0gyWmRY21U5U=;
 b=BGIs1mQuQTlHYCGamT2U89o5TRulWveBmVTlwifosjZe9wCM1Sp4dxFRSr2PPJYLMQ
 +QXu5aGz8d+5tOblfmnTMA2X/bze0NUKdvZ8SKzN9qFvO2iUJ1WsFOjqvY+qfuyPJlcP
 8bApvV4YPm0/fmpoN/uegRD8woUtwung1B/bg7taK8+VDh+QEPsWhgTfy9f368aAYOeM
 +8S4F0qH1Mw6hr1D6qeyF4cg/sZGuzg3K3wEiEyyfW3Q19qsuIBdIZYKxq4O93Asey55
 rdU7pfZf/5OTSkjNZaVgVhetQ3m2A2ah18mQqnxgzp8J2VxPCLUfsE7CRxLMUTrSvd3m
 HKzA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1zmGzjh7MjO5OkRXDZdUFrW5Od1Jl/Ylan8qdfdTB+IFvAZmXofhWGImZXSVrMOmckYq+7UbB1pYGfMlo@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJrnHQYzqSM8mnwgRFEFOA2C+p4kzAzZYtJDC0Qr3RccVTI9G1M
 LHvW7BOHxlr4e/0SABsZRbDNShWz9pg89kMytY3lj8Ka7+Z+SsHgFrbf0I2fc45yhgHSaLiIiW5
 IzdMq+Xib53OGGC/MZg1qTYrt3PZS3XZO60o5MSkivnuwatrcOctR2s3IwARI8IWLhK9E
X-Gm-Gg: AYBFou2wdL3Y8aOD7VmUW7ggNrNqW3uiYdUsPZDXxIrRCC06xVScrhCMa7C4k3NcRLn
 z5RiWYjrqwJEFEdzglVLBiR3DFPQIyZ+cAlFElNG1AwSu7NnUnxOA57o2hbo0ALBFH3Gt4gAtca
 dWYrrxttqYlLo4Bt/zArgT773WstYhQs2/NgHOw4+4bE07Iqub3XiYiJ7Wg0GVA+JYMS6+DelZA
 4v/IUr8E+bpYX4eVFGBwHgMT7RT0qLeLmhuqZ7dHXMWuHnQKRy8Fcqyr4eKMqPXzNIpkhVQ89a8
 yC/phmcL9Bkt49M5A/ghkT/Ved+dmwkQ4iZ/BYbnwr5tUhtQWRjaPQCug32f4EtYhN3UejFlCU8
 RnsqAlGH4V4Ogxy+0WG8MWgB8okETL1BFJh0w1hXTwo7PCXz98SrSrdMkNlNY98OoMEoejuzWqg
 oWSwgv9jXq9m0eGw611jAYh6v9NNWntbE7P+dmTrCv75fAs+EuK2DXeftKyvIdGogrjb2VJ+C5n
 3qQPKY0X0CPbM30QTk5BTn4X6Py3S1yNAcWrcek4oZ9aq3jw57oDPBzCawzvf3WLuj4ZZuZb7H1
 TGAR0WFVEq0Gu9BmGgFqufDtoNeDUupFHD1WeUJzkVNEY5JRlH2mYL1kqNX+T6uXpGwRqxYscdI
 VXStHDxY1bTlUmpgSrjabDhk2teT/Ouz79Er0yk0UiI2mJfoOHfu0zDl/Z6Bv98fRLvsjBeKJmg
 cG7pQS78CAIFoLnU4e00ljVgyggEuVol/ZY+qC
X-Received: by 2002:a05:6000:d8c:b0:48e:1c72:abc with SMTP id
 ffacd0b85a97d-48e6e5066a2mr4134601f8f.35.1793364973328; 
 Fri, 30 Oct 2026 05:56:13 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm2736597f8f.59.2026.10.30.05.56.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 05:56:12 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 12:56:10 +0000
To: David Sarkisyan <david@srkyn.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 6
X-Gerrit-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55
X-Gerrit-Change-Number: 1881
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1881?usp=email>
X-Gerrit-Commit: aa282bbb84187cc76c48f8a8805e14eb31ed95a7
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 12:56:10 +0000
In-Reply-To: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
References: <gerrit.1787849678000.Iacd56d245e9ab30cfb25b2b364ca661fa289dc55@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3ODQ5Njc4MDAwLklhY2Q1NmQyNDVlOWFiMzBjZmIyNWIyYjM2NGNhNjYxZmEyODlkYzU1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ec9cc892398aaec639ba243efbcbaa443eafa67e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMm9c-000000005Lk-1E3C
Subject: [Openvpn-devel] [L] Change in openvpn[master]: compat: close all
 unrelated fds in forked helpers
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, david@srkyn.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3779571281275336771=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3779571281275336771==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i7ovB7gTwvM="; charset=UTF-8

--i7ovB7gTwvM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: David Sarkisyan, Gert Doering=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by David Sarkisyan=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail )

Change=
 subject: compat: close all unrelated fds in forked helpers
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 6: Code-Review+2
=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-=
Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacd56d245e9ab30cf=
b25b2b364ca661fa289dc55
Gerrit-Change-Number: 1881
Gerrit-PatchSet: 6
Gerri=
t-Owner: David Sarkisyan <david@srkyn=2Ecom>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-CC: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: David Sarkisyan <da=
vid@srkyn=2Ecom>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ede>
G=
errit-Comment-Date: Fri, 30 Oct 2026 12:56:10 +0000
Gerrit-HasComments: No
=
Gerrit-Has-Labels: Yes

--i7ovB7gTwvM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: David Sarkisyan, Gert Doering=2E </p>
<p>R=C4=83zvan =
Cojocaru has posted comments on this change by David Sarkisyan=2E</p><p>Pat=
ch set 6:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1881?usp=3De=
mail">change 1881</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1881?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Iacd56d245e9ab30cfb25b2b364ca661fa289dc55 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1881 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 David Sarkisyan &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Frank=
 Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Es=
ourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
David Sarkisyan &lt;david@srkyn=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Comment-Date: Fri, 30 Oct 2026 12:56:10 +=
0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div=
 style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--i7ovB7gTwvM=--


--===============3779571281275336771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3779571281275336771==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3779571281275336771==--

