Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188D5CD8C9F
	for <openvpn-devel@archiver.kernel.org>; Mon,  8 Jun 2026 12:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BSuCyKOZKy7VFBPhepRC4DwFcnUosI2TO92IjSaQiuY=; b=NGxfIlERGyd0yAYcmImVVT0s5y
	U1ylLm0mdogGjw8E89MkM0F7NI4kV4mOYd9x3voIdZU9XrYXUL567P/p5/wVMxftMzTnqyuqhuntV
	zYAKrJZdQIuDIdTythl/qBkItutYsUVFNQWr4a/+nMr5FtM2K8ioAsQ4UNvIHkTln8Wk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWZRO-0007c6-Lm;
	Mon, 08 Jun 2026 12:50:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWZRI-0007bw-IW
 for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:50:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6LsO/cuSD8JnPbPgliFppa9pb/j/R/CeZH3rWTBmJeg=; b=U0iRXA+z+KKPokvTj38uGaRD51
 6OKQUxWZvJ44DMc6NY42bkm+808NK66ver9q+eCtC3B30TlWgc7RgL0JbmstBb0HVRWX8k9LaLYZQ
 htHxAiwBxjgr0F3Gy9rNT3kI8POq+VR7cuigIUFckK6mT/FxYo9stjHbVnOWGfKXAaVE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6LsO/cuSD8JnPbPgliFppa9pb/j/R/CeZH3rWTBmJeg=; b=D
 9+ZI40dm0oOHaSrdfJ/X6mXyN7hCzioGB1ao3DbKyXfw/K5q0uSrHylqt/jFbNkHQnIzvaSJiK70j
 8/mSv1uruYc0F0piJwIAU5AzX7yRZNndjqVmwAmxTAhBjFRqlbC/F8DgAd+zEXfZjukea03aQIaGU
 3p7Vdrux8gw+kcPw=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWZRF-0000Jd-0L for openvpn-devel@lists.sourceforge.net;
 Mon, 08 Jun 2026 12:50:46 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-45ef56d9b67so3295837f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 08 Jun 2026 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780923034; x=1781527834; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6LsO/cuSD8JnPbPgliFppa9pb/j/R/CeZH3rWTBmJeg=;
 b=fgiD8lUzQcCjFopVvytKPr5K8nd52QdSx/j0AbajRyG/jrd/YLGpb/hLCUBfo1JlPW
 D6CULn9+RwJqF0WQoErHBjKeVA5ISTpBPJN2siVGU+JOOU+4gEADTSJ0i7ImYcjP0SIj
 HUDMDzqyVEKS5Icbr9wFVkR94r6Pbv8qPlmmw6GNMlauLITU29PVBsWyJe9JVaWVfBGI
 WnwFixn2pLQnzZc9kjtn2sXORZJIK8L+D6u2j2d9YAAXZGlGmrp241mm4MjnNPUFG0TS
 qJfEA+AAk5job1Oozk8sLLYCZ9R/p1zBARrZpU4qARyiyWBLcTAUS0T1YaDhT2a7tWBJ
 fhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780923034; x=1781527834;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6LsO/cuSD8JnPbPgliFppa9pb/j/R/CeZH3rWTBmJeg=;
 b=kVsOCdHmr3qzLm1R7q2W5zX4l3p14i96YJdt2eoBj/BN+RWWD1WzcGoc+TJeojxKgA
 wuMXgLpHAEidumLcWRMbkp/HLNCoI5wTR8EYVzCI+s4y7sn3JSLUv5GyRj3f+iPBA+3+
 D4gEbTIya31XfYXhYWi9UHDQsCtqEbV91I+5VOft5d12qEK8tLemZjRlTnuja1jbgR1H
 dGQ1A8fElJBHTtVhCF8semjE7YAA4q+j18tcM/gSLRLx1ifWoF5sXzLT/hn1h5mWTrp9
 /QwEWdD1BRfJQ8QtBN0W7Os0WDsA8eENTSHKJ2VyEOabnS437Gz7q/9tE67RHUJsWFdD
 harw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Gih2cXltpTVEoNO9hTE7PoTZIxbydAp06s6MAB7vQDezMLBPOnydStcTuXG5FLMNPXD8O/nOZq9K/ggpu@lists.sourceforge.net
X-Gm-Message-State: AOJu0YydxanbM1Lg0BXb4fSYC86/CfrBYDFSyA792gDZQFRyQ7lb9v9z
 sKwSqCk4mEhYl0sNXQm0glhhymKZtVj1PYTyXFmDyQ3+ekpfa86Dz9TsmA1U8vX0cOMxnOLCJM+
 G3uc0N2SGYxcGyuHR0EsN0qfEJDusywlj/Ri+JSMWfZ7TVKZWmxGrOCOdgqh82y32N6Xr
X-Gm-Gg: Acq92OHXHrZqRVQbzzEOoxAnRuyAWd4YrfX3YKSoXL4BmBDZ/HkT3pQIFGxC/7OPdE1
 QZsYk+OyVcMcEAs2YA0LLJqac1zzsOgzrrGIn862ncpRdipQsS6x95DrbiWcsvwDXiEivFKEJ3n
 +05fmm9HwYhZ0mr/7bWBpQobeuZMCQKjnteRfppdZdKmcUw2uxdFFQLJCCNmXwr77aPraO3n9Qx
 hJJIu2gsy1d3KVGQuyIFi8GkpfKxnGPihd9m/NuJA8ZkUpH4uAfEcPGgItL85BQ1CluHIqwshsQ
 fGZTL9IDlYJAUS+tFRenHeJQEM986c6JQ5X6VivlA2NlPne7/R8eu81Xf1NrD7yH/DovSHgv/u+
 4RlBFC2b6kCI8f8ZC+jc/LftTLKTKCVCqCY7hZXtReMlGqgeoLaSB+YNbZWz086A9tWuaWcVIXg
 7jq2/7CwQWmPFBxEliGlBE2Vwa1PAA0fkBu9QRklzHG9Vi7NT2XueusOnv77V3NNpdUu5vnlLI+
 j/AgRg8tYlngFhpGO5gDHbgCuJp1APQOPzZ/i102XikgQc0gAG28jwM4M9uKYOjOzMY7LUllP3i
 WgW4sIUdonSo75hARbPXIl+U
X-Received: by 2002:a05:6000:b84:b0:45e:ee20:b897 with SMTP id
 ffacd0b85a97d-460302e0351mr17095802f8f.6.1780923033825; 
 Mon, 08 Jun 2026 05:50:33 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2e4004sm52343380f8f.9.2026.06.08.05.50.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 05:50:33 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 8 Jun 2026 12:50:31 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
X-Gerrit-Change-Number: 1635
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1635?usp=email>
X-Gerrit-Commit: 6e690c619252e5d88271ace9b302f8abd626c965
X-Gerrit-Comment-Date: Mon, 8 Jun 2026 12:50:31 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc2NzgzMTAwMDAwLkk2YjMwMzgwNWEzNjg4YjZmNjM2MzE0MGM3Njg1M2E1OGJhZGVjZDhmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <28efa3b88884ec57bd6d1e7d2e3fab3be1512d97-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWZRF-0000Jd-0L
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com,
 gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5240247684589280429=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5240247684589280429==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="08PV19XuO+o="; charset=UTF-8

--08PV19XuO+o=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos=2E

its_Giaan=
 has posted comments on this change by its_Giaan=2E ( http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1635?usp=3Demail )

Change subject: Multisocket: use e=
vent engine rwflags for UDP I/O
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 5:

(1 comment)

File src/openvpn/multi_io=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635/comment/e598761a_da17=
cde1?usp=3Demail :
PS4, Line 180:                 unsigned int flags =3D
> =
not sure why we need to go to a new line here=2E
Done



-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8=
f
Gerrit-Change-Number: 1635
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gi=
anmarco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: ordex <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eo=
rg>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: ord=
ex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon, 08 Jun 2026 12:50:31=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: o=
rdex <antonio@mandelbit=2Ecom>

--08PV19XuO+o=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/multi_io=2Ec:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1635/comment/e598761a_da17cde1?usp=3Demail">Patch Set #4, Line 180:=
</a> <code style=3D"font-family:monospace,monospace">                unsign=
ed int flags =3D</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">not sure why we need to go to a new =
line here=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=3Demail">cha=
nge 1635</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1635?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I6b303805a3688b6f6363140c76853a58badecd8f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1635 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan =
&lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=
=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Comment-Date: Mon, 08 Jun 2026 12:50:31 +0000 </div>
<div style=3D"display=
:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-=
Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ord=
ex &lt;antonio@mandelbit=2Ecom&gt; </div>

</body></html>
--08PV19XuO+o=--


--===============5240247684589280429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5240247684589280429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5240247684589280429==--

