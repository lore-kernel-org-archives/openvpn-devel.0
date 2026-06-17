Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E0A7CD98E2
	for <openvpn-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CXzAvtO4LE5NNaaWJ3tn67e7Fvt1n8WJlS6vNdraSo0=; b=A/Jk0R1PkUZIFSJkycUGA6SZL+
	W5ROqzMs85svWk35lyCV19njluJEgCLoc4eIMJnZzkoJtZr8kRy6FrblqPVyGcmvxUEB7ls6a7JUE
	ErpD5copIAMgoY3Sob58up+DtiWwQBmpk+iUKuvnu/FHliOGhe0cUtdvnKbxjLeem27o=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wZwib-00066D-JR;
	Wed, 17 Jun 2026 20:18:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wZwiZ-00065v-M8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 20:18:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=M0OlC1p0yjOJeWYznlT+vfLJfVzFwF9+hNgPxrZXaPE=; b=kIBQgGwLx3gDVnwVfOAEZQtrkx
 at6hj+LhHbR5bhFcDKQbw+ayjbt/za1zyFvO3YTtKtgQPtTyeWgO63PsCBVRYTPexl6YEeGg2ozFS
 xRZYeahNgr/7/NvJVPMphU1shAZ2/SGAjFAiBzgPjpBQhLgVhYTmpNgkeJfbJYuPZjng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M0OlC1p0yjOJeWYznlT+vfLJfVzFwF9+hNgPxrZXaPE=; b=a
 m4znGcVSl/EwcMkvBQZwWHkz5xiOEVlZABNTdcPil+LWCjRO0twYIxylv2ojpiHgpOdiMPSzYbXns
 STjmQ1Q4+jW3trv25emtAmD0JFRwE96iSPuCG3v6y0Y4+qx0A8ZXysqsI/qwBO9qemE9LKbyrVISV
 D+KKSU7flz4j+xLU=;
Received: from mail-wr1-f48.google.com ([209.85.221.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wZwiX-00008d-QD for openvpn-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 20:18:36 +0000
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4602e2a0372so167342f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 17 Jun 2026 13:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781727503; x=1782332303; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=M0OlC1p0yjOJeWYznlT+vfLJfVzFwF9+hNgPxrZXaPE=;
 b=LoOXk/1egE7gHWCJffTbHu+oR/k1Fy8kKSgyj/w4O+j15t/M5fjCmoQNgk5sfapfto
 Wl/SJJO0G9SlIMWBA1XazzG9DgP2btIFTma1I9b28g2wC3iHjeUoqAkJ1BrXiB6TYbRS
 b4xpJy7lsG3Gquh9m1oKpuMCUFsmW3bDhkRiohqmUeZ3YG/BQ0hVFBHHLecWw+P6y1es
 x5T8OgkMvv89FkmuF56z5ZFl3f4ykFao8T++YHxBkNeXYK+bgk8V+Er5OacZedTuwb4u
 77Wx04pja6FtetjxSTCvEMxeKIDVxMB9di2fguA8d0IuHdhivjEl5VxFM/ux2mUY0zpD
 88ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781727503; x=1782332303;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M0OlC1p0yjOJeWYznlT+vfLJfVzFwF9+hNgPxrZXaPE=;
 b=H2m0+edMCklb08IVIx+xTqLbHjs/g1oVrzKd+XxPmG7xoq1JrcKkhOIUem1IhimoRL
 tlZGPDLo/xlnhPbwzUGCvT7ziWizQuGIvNttRVr3DAiXLsu6pexg7P8Lj+5KC9iCHAb9
 coHv5XEGCNYRWxNlJb0XCgE1BhgjLhe0xRvfaAgROeoAlApdZy03AhCV7WRCdf3gPLhS
 cHg46O0F2y+c4dW+zx9aGVYkZpScVkyWQ7V2Bl7g613N0K+mhMAXz4kquzgZQJwSfPoG
 u/Yf1dLFWlfWGusXc8knnUYD/JaGH1Tmh9pSZ1jg7ZUBSfazjWtsztXVKAK3qD5y526x
 kFKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/55szyNcVy9v21JBNf4GtIh2dy+kcREJJYuPvgAwHLSBCNheyxAneITReKgZnhTJeUVk4C9I77FuzXzksZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yyt112kylP+ta4O/4gVm0DKGXKBPznQhibsNwDwCHMwboOJ01Mt
 FrMH6JuVL+s3R1rbTlBH2OZCFOFQTYhNvfGeS3jyA9mZqZopejonJvoRqlW4Loz4387DqV4S6NJ
 pKZdtEaXLQbelbypGE3Q+suYnvMkMh8Q8KgtH7AH4yb3MzYN+fSr7BSOcPCWsHh1XI9qb
X-Gm-Gg: AfdE7clZHaokeq7o6IH5hJGEHVi2eGbExhEs4qJzuxd7P/3pa/0l9ILSfnoQFHLPNah
 DM02erWr5LNHrDVefNe1KChqng/NHtU1iFXKas8uU7qGvycGBP/gSwytuhFPVNt9CArw3Y0OuzN
 I+XGsbXnEfqGzXg0LCmIfkETLbI0ye+qEqd1Upe8XhohoPTLafTxx8TJVpvfze+lUVmySAXcWLX
 yqzUvNzRAiyVWiBscSSR5qslAAIxvlCfGavIjrhLYTkbNLfAJ6s654YoeZJCwLfkPp6tnAeVeOa
 Jk+1v/slFxyHXADiRSt5tIoS5M9lVDAP/af731MDwF3weFxbpQCyzX7H5Q2VgGwF+mH7YxI/x00
 xQ3RzE4lG72gNYjAy1a1Iui68tOAG+NXzIotyHY9v4naypo3rbrbb9PKS331uwBfGOi0QAyECO1
 O74XcEe2pCYW3guHamQNWbQIyk5LQ2Koi6JlrperVXh1QcQvaEzHBxIppSjFyBlthe/r/CRuPZi
 7RhmFQgsO6ZmKMBH6t17BQ1njv28PDxR9tZ2xr2e1NYctyi7vS0LIX3Or768zocWkHqxLk1DVTs
 MHw=
X-Received: by 2002:a5d:588d:0:b0:45e:b21e:f840 with SMTP id
 ffacd0b85a97d-4623ea35934mr8840944f8f.8.1781727502563; 
 Wed, 17 Jun 2026 13:18:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2dbfb1sm60190225f8f.35.2026.06.17.13.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 13:18:22 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 17 Jun 2026 20:18:20 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
X-Gerrit-Change-Number: 1712
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1712?usp=email>
X-Gerrit-Commit: 98434caa86b9fbee586d14b65c82cf0274661155
X-Gerrit-Comment-Date: Wed, 17 Jun 2026 20:18:20 +0000
In-Reply-To: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
References: <gerrit.1781714533000.I7ec318c86af994284d1c6272e3bbe2b1ede160fd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgxNzE0NTMzMDAwLkk3ZWMzMThjODZhZjk5NDI4NGQxYzYyNzJlM2JiZTJiMWVkZTE2MGZkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0f3bcd67808900edaf91967599393ff17ec1e66f-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wZwiX-00008d-QD
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dns: Fix memory
 leak in dns_server_addr_parse
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@openvpn.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3190137398530512695=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3190137398530512695==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="549xx+c9EDA="; charset=UTF-8

--549xx+c9EDA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos=2E

ordex has posted=
 comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1712?usp=3Demail )

Change subject: dns: Fix memory leak in dns_serve=
r_addr_parse
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=



Patch Set 2:

(1 comment)

Patchset:

PS2: 
I wonder why we don't move t=
he check directly at the beginning of the function=2E
What's the purpose of=
 performing that kind of check after having done a lot of things that have =
no meaning if the check if false?



-- 
To view, visit http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1712?usp=3Demail
To unsubscribe, or for help writing=
 mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd
Gerrit-Change-Numb=
er: 1712
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@greenie=2Emuc=2Ede>
G=
errit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: plaisthos <arn=
e-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attentio=
n: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: cron2 <gert@gre=
enie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 17 Jun 2026 20:18:20 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: No

--549xx+c9EDA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos=2E </p>
<p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail">View Change</a></p><p>1 comm=
ent:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0;=
 padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?tab=3Dcomments=
&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">I wonder why we don&#39;t move the=
 check directly at the beginning of the function=2E<br>What&#39;s the purpo=
se of performing that kind of check after having done a lot of things that =
have no meaning if the check if false?</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712?usp=3Demail"=
>change 1712</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a=
>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1712=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I7ec318c86af994284d1c6272e3bbe2b1ede160fd </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 1712 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &l=
t;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ord=
ex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 17 Jun 2026 =
20:18:20 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes =
</div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></=
html>
--549xx+c9EDA=--


--===============3190137398530512695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3190137398530512695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3190137398530512695==--

