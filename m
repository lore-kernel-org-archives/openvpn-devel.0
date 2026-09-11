Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5563DC88E50
	for <openvpn-devel@archiver.kernel.org>; Fri, 11 Sep 2026 13:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=URMOE43hGMSU05kdDrrvaG+OGDHjB+6lLFoACGKZ5b8=; b=YpHO8L2gOfY02lcoQlXeIO5dsz
	Sx5dUSwUhi7b42TELKGeIywSITe2nNsQr2IIbTt/+LDWfFLXZzkaS0zRAkDNvffLK1njlKnrDsb0N
	Q2op5ri6Rf6boW2J5twa97wurFDy4IpGG+Z6QFE3Ou/D9vsIdeLTs5Un02A0rnd7MJg0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x51M0-0007pj-Rf;
	Fri, 11 Sep 2026 13:31:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x51Ly-0007pZ-FT
 for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:31:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A8pCH5cFoUdorbYw/9dR1XMgCAida6GBj4S6Nuq8L2E=; b=cQL64Y7UJxExbgMUC3AgN2kP1b
 UC0XVRcgPTgJ4ti2e+YPhUuAObPlkM4v4DSESyGxDmv6yo28z5yTlyoNf12UqjkHjov6zWQUrCsRN
 m8PdXpzdMGkBNBrKVlUAH9VLvCioOruLYERGe9xX+ZKEdX0+TXvjL9wH8tY2YakpVfdc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A8pCH5cFoUdorbYw/9dR1XMgCAida6GBj4S6Nuq8L2E=; b=S
 KGMuhD/i/bWVWbWqFZf2St8B9OaHY37MrGa3wyHgCt+x+yKn6pwCyB2byhloNwNCX5YlJ6C+rrq1e
 4eHaObgjPQx41RRY8z/zvO9HRihljCwYYZ/8evmFDjYgaw4cN93qImRqpdKoNCAU6lQE58Lg25boE
 XgH8NVBk1w5vIZ7g=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x51Lq-0003r4-RL for openvpn-devel@lists.sourceforge.net;
 Fri, 11 Sep 2026 13:31:36 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so504888f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 11 Sep 2026 06:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789133488; x=1789738288; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A8pCH5cFoUdorbYw/9dR1XMgCAida6GBj4S6Nuq8L2E=;
 b=YictVb0QBfEP/sbLQVuztupgEJCSlvvZICTdYbsgWl0cZmFw9Pe+H2DRLDztVViZVO
 LOhlrtsuaY1wmTtSf48JWGE3Hr54zqOA3jFwx+VXtxVim1JNLFcvv24aKICzGhy/uiDT
 aVyipedWBK+znwLJ8sn+wnUfXjkijYQz7DaxhbWATRaygtJXR5XjJlnRIUskLrztNrr7
 IcEgO2i/7dxHNQ/ScvdE6quI70GZWVJZ8g55t1Nab1f/Xdw0pO7MiLlGrkq67uRfn4Xk
 XGSpqqYanxEudnPyvNObfK99DKFwtynYnsT1FzlG4j3WEIbYN0vPFfVZ4OfbHrEYPt3e
 Mt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789133488; x=1789738288;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A8pCH5cFoUdorbYw/9dR1XMgCAida6GBj4S6Nuq8L2E=;
 b=Fu04Ft6HZsBWHfqwI2C3XgjyeJPFmzbDtj8RFtzPvmLHijmqIhD+Nq7rBkmrcscCKQ
 OENcPWPPkKscLLH/MmaiGmAqD3hjX8Dfi6ywCtzTAIFjL3YrPYA+XnUwh8BZAWyQ9Rm/
 TNbPNw+FaWwnR5Cu4vwtQjUgI7olrwb/igBmFP9FMwDjrd4vOB0Z405GOERizIBOZd/D
 UiFpXLUt6l3BRCMhoLcS/tChp/+Cn+2BB4ysSnRsRJypyY8tkwkduqPBIqquRvxR+LeX
 hVGedzcW/d9OAX3liEPoel3hTiD/0/L9vLiWkxqvIlGY+KpH5Y3/RhV6hhmG/Zt1iPb2
 DGmw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQbU460J3fVSUf1yd1lUKvuYAG5cIcvToJhbRb9h+1NETTfaNcQ+abWHtBvEp0ONnhxlxfW84Q6M8aIBPQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++kTXFUXAXizFyiHGyXbIWUwpK2lCWcL6NA1Zscw8s6cBFvcqhk8
 nYR21mHdDxSM1/dXPS6q5PFVCxKiwpAlVlL4QQRO/T+Jh+p18WVQTjb14t0K1pN8kjY6K+Oj8lf
 vgI1aTP3XarzoqAt3WV5s5ULlRUOZCHaU8WakSQSmHyY39W2vjjeQHweEMJjKQFsTq2Zq
X-Gm-Gg: AYBFou2+6MaY6k+lxakgFKzEhrK2rdfUPfPKAe2xdEjiqidRxzehd9bDf1oEHBpi2sP
 TCzUFAIGwW5lS3dHLgpGd+RoexznvEG7vKHhSuMnooxs0DZxxYIedmux7+jWnhhT5rxM4mLZj9d
 JzMdl/7gBNBryrwkB3R7qTyPpn2McFnR5hA9bGq83UOnRuFsjp9PUHyP0Bc26TMp1V8f5A+8QYQ
 36p3gnjcu6YD/j8MpKa1CgupVbOYWFXF/5oOQfZzqRVK7a1Dn7JBtNgb9oaU+PqcZ9HNcARhRkU
 P1JM4GCaOOJnJ2c60m0KYVB8BvkqoQyKk7cB3cHvmKNwYL3KTqJkMrl7K/tNJPiGt8ZRshLtAsA
 orpg1aGSsgkrUVSZa4EmovAjmo6PGz3miI5Z2qTUNmgA9bQdIt8DWWmFfFKiELy2pXRO9I7cwH5
 TGm/NtxguMiPslzDclDYpDGwZBzkfTw8zvca2naZy2PINY5trZ35M6N2Qa8SA8G6TL3sQxSuMwE
 aPd/gbYslfbcxpWVLyk0aUK5tX/sIkmp8jZnE4IGhqJuTXfb7bv5TgKgKBlOYv5g9Fbu8MmncqH
 AAw6V81LL3mTYUXMHQl8VtUIV/Gk8oTQUL8truDOoAXwYKq5fpGC4FX1Gt3qwA==
X-Received: by 2002:a5d:5886:0:b0:485:a09c:650d with SMTP id
 ffacd0b85a97d-486eb1d378cmr8943146f8f.3.1789133487943; 
 Fri, 11 Sep 2026 06:31:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb2ed0fbsm6126052f8f.3.2026.09.11.06.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:31:27 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 11 Sep 2026 13:31:25 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf
X-Gerrit-Change-Number: 1912
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1912?usp=email>
X-Gerrit-Commit: c674d3c37f1d589451feb45c760b2b63f4bae94a
X-Gerrit-Comment-Date: Fri, 11 Sep 2026 13:31:25 +0000
In-Reply-To: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
References: <gerrit.1789127367000.I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5MTI3MzY3MDAwLkkwYWM5MzRkYTVlZWVkMDQyNGI1NGVkOWI1MjhhMmJmMmI1NjFmZmRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <255e37fa293f051ef379d5a09b4634121d5177fb-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x51Lq-0003r4-RL
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix various function
 parameters shadowing other symbols
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
From: "razvanc \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3146538497581781065=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3146538497581781065==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sVNaYbV7W8Y="; charset=UTF-8

--sVNaYbV7W8Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1912?usp=3Demail )

Change subject: Fix various funct=
ion parameters shadowing other symbols
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(2 comments)

Commit Message:

htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912/comment/ced08c1d_6cb6db53?usp=
=3Demail :
PS2, Line 14: either renaming the global variables, the function=
 parameters=2E
Missing "or"?


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/19=
12/comment/88271b22_1ccc07ea?usp=3Demail :
PS2, Line 16: In one case I remo=
ved the parameter since it only cointained
Typo: "contained"=2E



-- 
To v=
iew, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail
To un=
subscribe, or for help writing mail filters, visit http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a=
2bf2b561ffdf
Gerrit-Change-Number: 1912
Gerrit-PatchSet: 2
Gerrit-Owner: fl=
ichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plai=
sthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@li=
chtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 11 Sep 2026 13:31:25 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: No

--sVNaYbV7W8Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912/c=
omment/ced08c1d_6cb6db53?usp=3Demail">Patch Set #2, Line 14:</a> <code styl=
e=3D"font-family:monospace,monospace">either renaming the global variables,=
 the function parameters=2E</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Missing &quot;or&quot;?</p></li><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912/comment/88271b22_=
1ccc07ea?usp=3Demail">Patch Set #2, Line 16:</a> <code style=3D"font-family=
:monospace,monospace">In one case I removed the parameter since it only coi=
ntained</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">Typo: &quot;contained&quot;=2E</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1912?u=
sp=3Demail">change 1912</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1912?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I0ac934da5eeed0424b54ed9b528a2bf2b561ffdf </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1912 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri=
, 11 Sep 2026 13:31:25 +0000 </div>
<div style=3D"display:none"> Gerrit-Has=
Comments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </d=
iv>

</body></html>
--sVNaYbV7W8Y=--


--===============3146538497581781065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3146538497581781065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3146538497581781065==--

