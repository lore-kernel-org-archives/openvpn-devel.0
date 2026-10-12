Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85ECCA9ED2
	for <openvpn-devel@archiver.kernel.org>; Mon, 12 Oct 2026 08:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jomN69ZmJngPbaqwmmuIArDXEkZ2gYwvtVk/dFWdt/M=; b=CkFYPTrvdbFcyqT3wp4+aQJGD2
	LH8QHdP3bSDxTNrwbzSObMr1j+Bg0OkFc6B8e+eZnx47+T9CKOhFw6ELvVRt579LL3+pssVMZiqjk
	mQ4cF7CpK9It+0qL0OgGavslivPWxYIAxZsT7B0gt0XSUYYyaAoS3PT3wIEKPrBX72NI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xGB12-00032p-FY;
	Mon, 12 Oct 2026 08:04:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xGB10-00032j-Oc
 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 08:04:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=xg4EwPDsPNGCE4DrHea47n/Hih4SaJRPzPU54T1Ek04=; b=CQoEm63W9LS036ygmGRPZXYbTQ
 lmujwTn3C8/U2fMFeKurr12GyrNAE1/sURebNx4UPmvAJLSSuBCmUlNLRyqnM+DehjS4A+UOUgKUr
 /PxmWsdJix1rNhJ5c4jISaug9AFPAjWO3T9ZeunqVGDY0PmTh5uWrzwNQBHG85AtwkcA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=xg4EwPDsPNGCE4DrHea47n/Hih4SaJRPzPU54T1Ek04=; b=O
 mZzwmcBhcxUoc9wgyknPY2hCBr5ErihqLJVYJam6fDwcAOfNmhugAtJWqYs/0Jz9rW7axXisJva+Q
 IY7cNGH/brDH8lkjENv5LF6bBWhiOLKFYoxUhZx6stVjf9PX9yVw15EypiVAOqwPq0j5G7eGGoQAz
 21m6qOz8DQLz6Hv0=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGB10-0007zd-P3 for openvpn-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 08:04:11 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a061a13884so13384225e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 01:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791792244; x=1792397044; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xg4EwPDsPNGCE4DrHea47n/Hih4SaJRPzPU54T1Ek04=;
 b=ItC1/w3CabIviKgQLNVvrd0/RZzOPaJVUtKBmu9XlsbqlhhiKxHZCP9Kq5qbdkh5fP
 Huq2mrTs5a3ifvoGJ7f1OVqoQPt++QwMUyAw9dSTFgbGP4HMrUKbrIhbHimIV3HZEaES
 tmtT9IecqAeBAnYe/ZJ4DCAr8XnDXB8jglSeTrEYo8m/+BAKcKe8xrA+tnbQdVgaNs2F
 sHbsPqfwhzV6nQ4HLLcBXnJec++irKWzLbZ+DcbJCnoVOm8CmUvzgglxxIJRJEvs1p1P
 xelTfC2s0xV3bJ5mkDCq9HXpACTArdxCW9Dl7tYX5WupMe+VsMOaD5tp7FjIy11wOh3v
 N2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791792244; x=1792397044;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xg4EwPDsPNGCE4DrHea47n/Hih4SaJRPzPU54T1Ek04=;
 b=GZo3CQuaVdW/lNAdgi+BzpbNStnZillxRmZPi70I0wMzpeVvU/ln75U8XfFFjclU28
 zG8PQcl//zkLgdIbzgulqn+qxUTuKhbgCNOat+SUf7zKEZjHbkBLfg7g3pFoij11l05t
 BO3aRhiKkI7zzQz+UZHxEchcoIOv8eIOHmmQEmTK2d3Lv3dGNZTVfTTElIwrtPn4yKhm
 /RzmetNq/OymnNHpG/x1eunOlV18CshdnajkhqPWTCdaw2jliR7aKhALBkSP33nmx2w7
 o0nSrMrlTQn9/RdK9rduajR3yXee7pDWsvraithHigXCYUCfQZCq0xLusVQAsSpG3pwD
 L/xA==
X-Gm-Message-State: AFq9FYLB3AE79/JwN8RSx+X7lQMHNOSDUjH1WyUhhl+uGpEFWVbW8f7H
 8aTWoygxLITgsSQUqyG/YThnEMoKl5lEbjHpOvSnVZAEst1LPf3+G1yDMLQFlK7HqmjOS9kaoxC
 J52v1dJNsRcjTcP+TttIMlXwXCSmdBBtFPCF+rPZqCCze/cQiYWWfWdQuJVDJSYmzsTTopBT6xw
 d4RErutw==
X-Gm-Gg: AYBFou0FtmZk2eUEGpwI8b0SnTwvPQxB8iEIBn7SUPcrU3UdRY2040Nd2NvprjZqJng
 D6UpDqeTRcestqkogZuLmu/UkdxzDCaIx+GwoT17uXmJy1/bOQJxmz0nm3CxZkCIdBrQyMhug1N
 tfsIXMjZQJGWJaPdTAK2iDyLS+iI5pLCHcD6pngComIM9rayaXpo6jldlimdQGcZMi2p7Ue1Kwz
 WLqihu/M6GJZweBnRjDUvXrEBhaI5dvpSBPNX1icoBNEVgBKwpPjV6/EJV2OMLs2oPMRpo1nuUh
 NlHeqgaBgVESQSP249Mf6awxPKtRLZ5dwzN5pTEb8aquQsKGj7svTd8DTFtFwssJbTLfjMHpWXM
 tg0EQEpWCA+WpqLzXmh30PLBW51jH3MxpFlhOPGOqDBsIBG6+0Jv8ehYYfZ/nbQh8Jm4wpVOq8d
 O242XnqComVAmNfGA7hFBP2OAUcaLWbjerrk6kCED2b27cx78iZ90yHkSawaVlbTQJL9suzCTzA
 Tv9sZJOGCn6PUOWjofqGREzkZcgAdscpvh+cP6wsQ+cd46qUf6qkPeh7KxZwLyBdxJnheR7LjWj
 g+McyL0uXq1eyIHJukmYiCgb2EzD7TSl3eqkmcODL8WrlbnxC6nJzeJDJ3fh
X-Received: by 2002:a05:600c:630f:b0:4a1:9f59:ee7 with SMTP id
 5b1f17b1804b1-4a19f5911f4mr34045045e9.0.1791792243614; 
 Mon, 12 Oct 2026 01:04:03 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9ade914sm16850318f8f.54.2026.10.12.01.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 01:04:02 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 12 Oct 2026 08:04:00 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438
X-Gerrit-Change-Number: 1950
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1950?usp=email>
X-Gerrit-Commit: 6aab116b2955902fe81349e5cfd1e92f6a49fb8a
X-Gerrit-Comment-Date: Mon, 12 Oct 2026 08:04:00 +0000
In-Reply-To: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
References: <gerrit.1790329891000.I440c4c73865fdbd80f2c607e83c50e345a0e2438@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzI5ODkxMDAwLkk0NDBjNGM3Mzg2NWZkYmQ4MGYyYzYwN2U4M2M1MGUzNDVhMGUyNDM4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <70b5625c202103334c4d8ad20be3c020df194381-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xGB10-0007zd-P3
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not look up the
 "none" cipher or digest in OpenSSL
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6486795616582493441=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6486795616582493441==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Juxme5b/CGA="; charset=UTF-8

--Juxme5b/CGA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

R=C4=83zvan Cojocaru=
 has posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1950?usp=3Demail )

Change subject: Do not look up=
 the "none" cipher or digest in OpenSSL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review-1

(1 comment)

File=
 src/openvpn/crypto_openssl=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1950/comment/cedba6d5_edec6826?usp=3Demail :
PS2, Line 999:     }
This hu=
nk does not protect anything, and it changes how this function presents fai=
lure=2E It also, if I'm reading it correctly, invalidates the commit messag=
e's claim: "has the same shape and would leave the same entry"=2E

I also c=
ould not find any current callers that can reach it: `md_kt_name()` and `md=
_kt_size()` check for "none" first, and other callers either pass valid str=
ings here or are guarded by `md_defined()`=2E

Once this hunk is gone (and =
the commit message amended), I'm happy to give this an ack=2E



-- 
To vie=
w, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail
To uns=
ubscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I440c4c73865fdbd80f2c607e83c5=
0e345a0e2438
Gerrit-Change-Number: 1950
Gerrit-PatchSet: 2
Gerrit-Owner: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Comment-Date: Mon, 12 Oct 2026 08:04:00 +0000
Gerrit-HasComments=
: Yes
Gerrit-Has-Labels: Yes

--Juxme5b/CGA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru has post=
ed comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=
=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;=
background-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/crypto_openssl=2Ec:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1950/comment/cedba6d5_edec6826?usp=3Demail">Patch Set #2, Li=
ne 999:</a> <code style=3D"font-family:monospace,monospace">    }</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">This hunk does not protect anything, and it changes how this function pre=
sents failure=2E It also, if I&#39;m reading it correctly, invalidates the =
commit message&#39;s claim: &quot;has the same shape and would leave the sa=
me entry&quot;=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">I also could not find any current callers that can re=
ach it: `md_kt_name()` and `md_kt_size()` check for &quot;none&quot; first,=
 and other callers either pass valid strings here or are guarded by `md_def=
ined()`=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Once this hunk is gone (and the commit message amended), I&#=
39;m happy to give this an ack=2E</p></li></ul></li></ul><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950?usp=3Demail">cha=
nge 1950</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1950=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I440c4c73865fdbd80f2c607e83c50e345a0e2438 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1950 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@li=
sts=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Atte=
ntion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 12 Oct 2026 08:04:00 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--Juxme5b/CGA=--


--===============6486795616582493441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6486795616582493441==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6486795616582493441==--

