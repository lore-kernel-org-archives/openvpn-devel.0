Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C82606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 17:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IEFQ50T4;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OLlI0plY;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fGJCxa7P;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VrtvSW1N
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tivhhtFCYHF8NPooXt6cTWMGAKV9oukP+EaS7XgYHq0=; b=IEFQ50T4gRyKaoo06RLmOYxZ6L
	mr12WY/ITRkMDhlAj41l3CsPx49k17hl84l53yJeMLiXVXc0pRklqktmzQU4FrZPWdEe4kCglL1Oo
	24ZuVEcd2he78bIqwgmvuyjuVV2J6HOI80PcJJzA7l+KUbwxKWRemSAagxRy33RCmfss=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVtvm-0000000045B-43sb;
	Tue, 24 Nov 2026 17:03:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVtvU-0000000044t-351F
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 17:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TowQGEpYaiF/As5D9f+QgK3Dh6F65T2RDW94WrTi8ek=; b=OLlI0plYl5JhgEeiHqXPYCzBOm
 lCZM3tkNVRUD3dWVfXPcHl538t9lP3hdCdLnqA9Jl/N+fc+6Xv/fdUeBa0VTT1uvT5DM3gAizIURN
 dd0eLNVLdR2NdATms2BTe8o6YDMB5ghjf2F6G16Eb3cHTn2CzH0oheiY4+ZZgwx1tzxY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TowQGEpYaiF/As5D9f+QgK3Dh6F65T2RDW94WrTi8ek=; b=fGJCxa7PYK4rZ2tax3dg9URAdl
 80Rh1N+0dm6siw41A3U83TOcfvZxIUr7PNqR6c4k78FCPDL3Ze8JAzrUVc94mqh4JqRKanGk//APQ
 4Q+NfSIRxs3JbOl+4lBB3ns7XxzIbNMbG/Sm/0+vfbvZYou08EFhiqkPpxgNuwazG3K0=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVtvQ-000000000ZD-2m33 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 17:03:28 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so40910505e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 09:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795539798; x=1796144598; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TowQGEpYaiF/As5D9f+QgK3Dh6F65T2RDW94WrTi8ek=;
 b=VrtvSW1N+EJ1we3Rx2R9/Puh0SdPfovcq/1RRL/+xkUinX9AJRIMIjNweM1KUSMNsO
 9VT/sNFJsfYv0SdLwa0jpQZquIB9GfNTI2GLkKedpEDjICZ8yIFGWeGfmYShkuIIPw6G
 +ULZlT5niGgUrnC7oaOr3OLpfT9dCLS2yghztaVoax0eZbih81q6JcvufuJM2hYQ7tP/
 Au8Q5ruLltMU9uI/JQk9CQgf3Xmj6lwGZghpNd0/CwD3O0stZ1iajaSsQPJRB5ZSeL1y
 4OH1gGLg9kOTFFjmC2MhKAmOCSsCB7e6g9Hq07S/OnM8AHskwQQk1wJDVV8DV2HAn0XE
 LIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795539798; x=1796144598;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TowQGEpYaiF/As5D9f+QgK3Dh6F65T2RDW94WrTi8ek=;
 b=dlUtLieDLM4ZRI9gfJdfcLbQSocG4F9nPPhj+hbRkMaGWf4lETdNokRBVD/P5ovwUs
 APwDjALVOv07gCVWok+FjSR8PuSUO1eII0EIy8+uzO9d9kds2QUJqJKT7Yi4qAuDHi5o
 L2UJr9oN25ZQOFB2iYg8iAq8X3f76RkDkSK90YRxXGFHT7DFNAcftLEdMhUE1T8Gvl9O
 gVzv3Ls/c5A4FqZ2xvNIjLTMKYKjWXjht9F4Q9AWOqvxcmBJlu5C3QH7NJ0lIrg0Ln6W
 HNTRT+Pe4Cf9jJqgUeOjaLZDzOXbb61DOntmxkLitBp95fcKE+huAi9rRXHyYkU0x1AF
 DMvQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHT0OgBm13QtDH0yNu4Z7Al3OqZNXxRBbUcPJeYnadIMSz/1R+9L6WKpmxAU82w5qUcUWzW/Af4Uy3cUgOT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8qcj7dUTKWlJ/uJKSZ8cKahWXKvVQHMKqP296eisRYGOp4VZIr
 VJ2EBoeRAmfqjzKZ6+r6HtDiU3g2C1XstXJDB5bNoV8gxauXBAII5FgaJ9qPxvnS01BYC8KE/K4
 AKsxKF3VHFZSJ9e50NTeiliBxEt+0+lWrz3y9gGhIv14MsPkrF4GgV0ZOTq6bVuM1lVZsHbZ206
 j0ogVczA==
X-Gm-Gg: AZFdTZfIQN1FuUQvpwlQcHjTNrrBOvnNliS4G0AAv+7noWE7Xr3YZk3CwxyPJcRu6b1
 2QYZT3llxX5zKW1zE3YWUvH11ooeTfQTfpLpVwv8upD16yAjTPtVR6/zi8FNRSer1daUA7Hhtv6
 D0yObTBC83pP9xJSCi0c9SKjEB5bCc3STFXyTxJ6FoEYRo+rOJgADJwXUNrDRyjUX8RbEvmDLvR
 KhzfHKdpFgx/QBCsKsVaRK1y98vDNLS7KXU/c6pD/oND30CDzagEX/bvEM4s2ro5ATrlA+bAYuz
 ytAreUDPpD4sDP52OOW/HCi0gCWxPEzX2CHP+8QY6izDAwsn2140kzXbacf9lE+FwG+xd+y8gcz
 fKfaKwK1LEJef517ikrhUk4zPGrWHyOtxx6EVf9w+l9mM5Z7qBmNboypeAv6FXXtqvOZ4z81LfI
 7GYAcDrysEqvS/xA2Vk2jiCxA2vSb8MZf6KdhXBmWNFQj4Bf629dL/qudjuKP/P1OyI2Vvoas9l
 Yt5zpG/npN6yjc3AYiH5B/LEL7nRRJRS5tKf8MMr5mLyovnVk89LH4yHxI8/mXaSuWUTcZT21gd
 Y798EThYt6qdnaxAtJKDZD2LyplURZy2+ep8qbNvUGsfYQQ2m5WKHnWGeC7PWZ2IaW2sbWji2uD
 SEnmDSO647lmtyHP0LJwjocrkfA7Ag8Cy9VEiZMm+/aI62kfkaa2cb5AGeIeEG9lzEX3LrS1G7B
 Z7SgmGZqCyKgZr50c=
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id
 5b1f17b1804b1-4bb8882432bmr308827285e9.25.1795539796666; 
 Tue, 24 Nov 2026 09:03:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb853b216esm504155525e9.12.2026.11.24.09.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 09:03:16 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 17:03:15 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Id5152a5aacdd50f2fa9c5b3dfab92be8887541db
X-Gerrit-Change-Number: 2340
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2340?usp=email>
X-Gerrit-Commit: 1293f16f252440a4bb29d286d2f8f6e1f117d3f3
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 17:03:15 +0000
In-Reply-To: <gerrit.1795539493000.Id5152a5aacdd50f2fa9c5b3dfab92be8887541db@gerrit.openvpn.net>
References: <gerrit.1795539493000.Id5152a5aacdd50f2fa9c5b3dfab92be8887541db@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1NTM5NDkzMDAwLklkNTE1MmE1YWFjZGQ1MGYyZmE5YzViM2RmYWI5MmJlODg4NzU0MWRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <2bffd61db6b4a3ce9368f779e2fcfac698944f0d-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVtvQ-000000000ZD-2m33
Subject: [Openvpn-devel] [S] Change in openvpn[master]: argv: Fix conversion
 warnings in argv_printf_arglist
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
Content-Type: multipart/mixed; boundary="===============2187771098154312868=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2187771098154312868==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Uf61cTkYYNU="; charset=UTF-8

--Uf61cTkYYNU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2340?usp=3Demail )

Change=
 subject: argv: Fix conversion warnings in argv_printf_arglist
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review=
+2


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2340?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id5152a5aacdd50=
f2fa9c5b3dfab92be8887541db
Gerrit-Change-Number: 2340
Gerrit-PatchSet: 1
Ge=
rrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Co=
mment-Date: Tue, 24 Nov 2026 17:03:15 +0000
Gerrit-HasComments: No
Gerrit-H=
as-Labels: Yes

--Uf61cTkYYNU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2340?usp=3Demail=
">View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To=
 view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2340?usp=
=3Demail">change 2340</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2340?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: Id5152a5aacdd50f2fa9c5b3dfab92be8887541db </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2340 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eor=
g&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojo=
caru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 17:03:15 +0000 </div>
<div=
 style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Uf61cTkYYNU=--


--===============2187771098154312868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2187771098154312868==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2187771098154312868==--

