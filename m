Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456F160A260A
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 09:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BuxCnFRY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HS1CTvGX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RXJMCOJe;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=A9QxmZxs
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=tggRQsHwEC0VsW9NtBHPE0zEMpkEFNirq9gVROySoa8=; b=BuxCnFRYBc8dJKNNPhfg+RadsW
	ePcgqIOCLCWGPMAxHqDSiCoBCFI1XxyQHJvgFgDYzDI1UeAwB2sGzfV8iWvIErlB5+Rv0X1Xb7VOf
	wGwGJQqKYYIN0fH6VyosBBl0ryN93tPtLZut4ra03UYJw4LpiVkG2xQyrgHUcAtvDk6k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR4Ro-0000000051S-10Zb;
	Wed, 11 Nov 2026 09:16:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR4Rm-00000000516-00Ow
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:16:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qGh1vdqhS19btXifKYJ/p8/PH8CuupAQbkhHak2XSDE=; b=HS1CTvGXiiMgNNsDhpziM4imjr
 FwHvJ1BsrP3nkBcArxUbQHSP6UyzryIHcEGKHVws2FXoGFlLy2ZakpfevYqnv5s43oGw2V77IrFVx
 Vchlog0gRrHBdZNhKRuCUKN5Wy8f2MsbMO6gHKUif1Hf8qO+//aSUiBHImMX6CrOSU6I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qGh1vdqhS19btXifKYJ/p8/PH8CuupAQbkhHak2XSDE=; b=RXJMCOJeBs4ZbAuOMVU67oXSke
 agVE+Pg9DLve9swWWlTFdvRusU4gbjfZTh9TPkbHVlp0oWUa1oBnN90qZohe1iqBh4n7by+eV88+Q
 6ZPaR7kMyZRGV5cePp2CNyIBZe+LuDXPWvn1kVam6VceBvFJRlfzfUIca0MMXyqYD7Ko=;
Received: from mail-ej1-f49.google.com ([209.85.218.49])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR4RK-000000008Kz-2lek for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 09:16:23 +0000
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c50715c2757so16700666b.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 01:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794388576; x=1794993376; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qGh1vdqhS19btXifKYJ/p8/PH8CuupAQbkhHak2XSDE=;
 b=A9QxmZxsoI4QH9n7FM2LmoELCk1Zq9/UjpldjUFWwDFMOC5h/oNrANz8oFZL9Caj0l
 PVUMU0wQE6kYRlHcb2/ipV/dCMyJIQiAedgD82BFQn7AayiBJGQenaUWjOWwfaLWtC+S
 0jmLRpAZfpjZj36vSDgMHbvmVxvS+UGnhE6+FNSAWh4CuPeDsuAJZacGzYaO1m5/aD4l
 0o7jCEvtdUz8Rrfib55P1xb2RtYaX9B02KmswUP/OLVuLyAfAO7YL6hQWYbf3B//juGn
 aU/xDoRK6j02m5WcjlnXH4kgWiuGcLezyo9Q1WTB5aHE35ZRBToMtRdfo3gy5S6guwXH
 NiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794388576; x=1794993376;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qGh1vdqhS19btXifKYJ/p8/PH8CuupAQbkhHak2XSDE=;
 b=HmKFIsosU6RkjnOgRsgKodQLym2DHaOioblT5/Xew1ZRtA5kDioQTQyFow8FHgj0DH
 OlHceSenMHYXKNARaYZRFj/M8Yfku4SFs1EWsAgNG0g+N8Sd4RbHVns7GlAYX16eVI4d
 LQdvJ62OGsF4VA258ikZVjLuDnx3GFvTYnViaxa3WAM1+4r9abMjsNWFWnyclSyh7Vj+
 mGeK5HxEOxDO+4hYE//DFgM2rYB3aFZ3pOx8SGzeztTn8Lga8P9K4dmcT4neIm/PWwue
 gSoUJ5qmL1d1Ncnt/sC1kD6rzFvdCcCEDSFrc4aYXHJvs5hHjT6JoljsFEYLwwbsg04p
 ysvg==
X-Forwarded-Encrypted: i=1;
 AL+hErEM/tSh+uxjL9gb+HgloD/aBhG0CU4B/HhIpCPfXmk4FPARD6lEhtv+Yli3QUf+0BQeYZDnhpWSL/lZde/e@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+9xg1mFUEkfU/ecZ4I1RvYplpB82OQS6g4OZCECXBfmZESg7B5
 ILLMs99PrbEUqVlBbBOuFPksWuYAx+h/59k2X/9mTjt5qOOZSGLWLtd8tAHiMda9GwYDSVBQL4X
 2eke4PHtX/x9vuKrpzvU9xLDE2oueuOILgyWk4ls6Oxk4KXZlTkCG82IlCM8D3H6/jW4phA3HXx
 Yl1/ZkBQ==
X-Gm-Gg: AYBFou0oGRZEnLbxv6sgaxM310Vu+IJZ4hWl69gYi94KedsBh5nJ624A3kUH2QxCjnS
 8Y7Z/vrz3f1cFilvbCvTMptir55sdlIdXnWCQE+ZQASs9MKE8/vFVxNLwiBrz4GB4U4JMakCsHf
 tEZ1iFGEzgikJA5eA0CaWPZAkhXdwU22YhUtC3Kix72dVbI6d6hs7q0wbnB3Z8/Mz6MCwo2BbAN
 veU5du0SEzq+FXM6l7nFehN/ewm1ATqXYfbk86pu04EgUy3zCK+9MF+1k2741UALXC3Y/M1zdsQ
 4TSbFGEmNkueKQOdFWVaxNY1NqdDpVaFErVNRAXKhqAgTs5apnp7nfQa28x+HNqWRFsTBBUdQa1
 4GKUIiloSDbvEkEYMq7eN4nFaEqxHBio69AgHpqiMrxxyxR2IR+woVqggjhVcLgBZNf4JDho1/p
 wQm/FZQAq1ZOQWRn4sbVGcI4zdal5dlPQb91pzXGJdWtGHLcsi0nC4IXNhmJTMBzoukDQMTG0o4
 Gum7+1RlP59rQZfr6jpsSDsdkudePtw+c1vwLKuRzHiyxavxr8L43de6IpUHjrzuSFiXVufmHRY
 vcKU/iOejYZ6nJsU42SvWTWkrel8RuLwah6+1jNQO8c0l4jtgaKwElQ+VXTbsg3GJO1sfsEwy7O
 k3Hwag1B43fZ0bxV78+AL/8QtKJBMi3D7KDXUJXTA2aLYM+un6KZkiX1jes7UlxuHzP8w6mDfu1
 FP1EOGsrqfJTkK7mM=
X-Received: by 2002:a17:907:ea8e:b0:c50:576f:b39e with SMTP id
 a640c23a62f3a-c5066af17b1mr120838866b.26.1794388575873; 
 Wed, 11 Nov 2026 01:16:15 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49836c835fcsm9379556f8f.59.2026.11.11.01.16.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 01:16:15 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 09:16:14 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
X-Gerrit-Change-Number: 2162
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2162?usp=email>
X-Gerrit-Commit: 2e800a1dd0418ad2290286c2154a9466036f6233
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 09:16:14 +0000
In-Reply-To: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
References: <gerrit.1794304288000.Ic602b125d857f1beed4af8661f522d339bc9e972@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA0Mjg4MDAwLkljNjAyYjEyNWQ4NTdmMWJlZWQ0YWY4NjYxZjUyMmQzMzliYzllOTcyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <da428c77e685da7a9d4765db1ecd1326b7cfe187-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR4RK-000000008Kz-2lek
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: keep
 IPv6 name servers in NRPT exclude rules
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1350092798283847697=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1350092798283847697==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DJsYT2AldOg="; charset=UTF-8

--DJsYT2AldOg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by R=C4=83zvan Cojocaru=2E ( https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail )

Change subject: openvp=
nserv: keep IPv6 name servers in NRPT exclude rules
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Patchs=
et:

PS2: 
> looks good now, thanks! [=E2=80=A6]
Sorry, I don't understand=
=2E "keep IPv6 name servers NRPT exclude rules" doesn't read grammatical I =
think=2E Am I misunderstanding the request?



-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972
Gerrit=
-Change-Number: 2162
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojocaru =
<razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@mandelb=
it=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attenti=
on: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 11 =
Nov 2026 09:16:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comme=
nt-In-Reply-To: Antonio Quartulli <antonio@mandelbit=2Ecom>

--DJsYT2AldOg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by R=C4=83zvan Cojocaru=2E</p><p><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?usp=3Demail">View Change</a></p=
><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2162?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">looks good n=
ow, thanks! [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Sorry, I don&#39;t understand=2E &=
quot;keep IPv6 name servers NRPT exclude rules&quot; doesn&#39;t read gramm=
atical I think=2E Am I misunderstanding the request?</p></li></ul></li></ul=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
62?usp=3Demail">change 2162</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2162?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: Ic602b125d857f1beed4af8661f522d339bc9e972 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2162 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </=
div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment=
-Date: Wed, 11 Nov 2026 09:16:14 +0000 </div>
<div style=3D"display:none"> =
Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labe=
ls: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--DJsYT2AldOg=--


--===============1350092798283847697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1350092798283847697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1350092798283847697==--

