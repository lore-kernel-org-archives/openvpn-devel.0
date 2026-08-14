Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E48C5CFC1
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 11:15:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D/nLSsM7lAS+CtvAqv0k/co6oB67hGE/FnVsHt1tQxg=; b=IjtrMOSGOsQ6vq/E1HFG7f2A/h
	eafx0q+vga+7ArXYhxn4Cn5DU1JlPnl1arBSCvwKhjA+bW/1a1oIVdf2mJivfKqY7PTczoTgTRMhB
	VU64G+g7BAqVyk6WBO+zeW1jMiASdgOw0k1lTKa8VBgkBtHver6nIFDFoYeUU2cEHJ4s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wupt4-0000cB-9L;
	Fri, 14 Aug 2026 11:15:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wupss-0000bz-Jc
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:15:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Rh+KKzVY/hcfzCII4h2y0GGzHFjBb4gTSG1WBG1UgHg=; b=TZ7sZD9xLag7rHSq9cq0HyfhwM
 s0nYeTvzJRHdqyqowmtUauZ0tVKrOUleewlmJi9aMp48HyZyPZmru/cOTBo5TAjUMgG3LPi7ru0bG
 lPeV/Mb1xAIiRbw/ApgaHYuZENGQnSILV9UxG4crwrVtB5m3mG3f544MRkKvK2swmc9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Rh+KKzVY/hcfzCII4h2y0GGzHFjBb4gTSG1WBG1UgHg=; b=R
 QOTeZBZLNp007aUi2amLBRngZmOlTYhqe+o/wwBQGziHZHEvqPvgKvJ4TwSKPFhKunaRJ64urKFYZ
 du5zAf3vM4BMPjlivmKlDPJU0bsXFQk2uY/LSzrOih/7snzYevfIRuHV0v9YzDYoxpBK58O7MKLSR
 EkYN0Qd+XUVwvUgs=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wupss-0004fS-6S for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 11:15:34 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso11131985e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 04:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786706124; x=1787310924; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Rh+KKzVY/hcfzCII4h2y0GGzHFjBb4gTSG1WBG1UgHg=;
 b=ARiU1D5NO2yQLTJoav6xB1tIblY438Ke9FzsilI9bVLQBNBQLexjmdtsebV2RIZe9e
 GGVNLXc+IZ5ktO8Hf1/Y18sTfXwsoCpf9y9+CyRlyEMOZv7Ig6fxcINGD/e4g6HASklV
 1Mt0L737QgByEPj+NyWNrlAZG2WQAdIJBlek7kz6d92ZRE49o1VhP0+ji75rMq/STkTd
 18SBvG42e1lY5WcL60O+BU7JfkI+6fX8RwAiXEY9vdSz/g1bzbjUpIfIY+jXuebMuUPL
 RUtSMN6ZoElDP+HVlHhfCfZUaj29LL1LvT1jMock6JM4CGroJsKPvvTfjqNVeyUTrXYA
 YRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786706124; x=1787310924;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Rh+KKzVY/hcfzCII4h2y0GGzHFjBb4gTSG1WBG1UgHg=;
 b=f3dcZVrWKxRTAB3X5NjiKDwgLsbWQsd53aCn0vJrQF8cGr29gH09lUhwOLxBEOEUFS
 Kp5/NooHCMYq20Vi7w7hb1cguI54uGSxV4cs72v0b0xJLEbrteIfTDT++fXmz300BWPo
 6zAOsGuBlWLkSOYB3/SfwY60VziRcuoD3JCs1M/dG+jxLPjDUGYgfKZvnCczBDYo4pA7
 xNuRFkYiRAWqHjo7ruRMaDddoTvMcMyRDz/zz+kZBliBo4khLsA5MzIp+MndNFka6KtJ
 Qi8/U30frJ0uZCH6R3mCfn4qzZ1qK2msHiBeXfNIWPU53Pf7y+71pzNiqpMFodoFtCml
 tE2Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2sgMcm1HDp4CgfXgsG6Pi5vcIfs7RFkG8R+YO1DQhoWhDXeaRDtVQvxOm9n7pK9jlBZqik3oyc+HHdS8w@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzNVj/5FjxiEd266ytJnuuINF+QE1Sr1J/SNPaxFZm8WFlUfIH3
 KAqBFXXWl3mibeOlin4bFSArk+Yjx+9UBidNNug6teuLEZViPAAn+AGV9k6JJFU1J3whU9zyICT
 oVR4fvXVqahk3BTwY5Rpts7JKMfYyd6URGWTek7Cftay0gfetWIF+kFdDBL4ij+qg2jvgslTKPl
 qAPPLZEA==
X-Gm-Gg: AR+sD11IvbRloDmvZmVy3WltpWZpDD/oEjHE3Gh8F5nEGZiSZ/a43SvRPMT+svo5u3H
 jZbZ62YdfoTwfhANjSVL4hcSe/ptAtycRU0LcQ2tJHN7oY6q8orq+v3wmznWEGYApfSf0BDVD+5
 2F1LxW/i6Pik88DHBOr8G7ck1vGjBEu9JuQNMlryztBMQdVHLrGW0Zq+2TZPWcXjsNjGlhELzEK
 3iJ7qafBpEZKI+BTAIFVtYK33zaFRs4HhT1ErT2+PXuF+TcNEs1utMtxvHYTiiMhIM3JqSUNuXw
 r4saIZnHSKcACiQqJrK7KitQi88w+RIXJ0JwQ1FYlIiQpy9KDetbiY4JTULE54XLHrQweKsYK/O
 BwNo7kXUcTtNTfcGlH9SrvL3fKxffRwfweAMw2uCoSJuUx/jirP8XY4rtoWFXoipg+boKhQwmcM
 7mwZ2Qirb+Ri/hXTjT74byyEsVzjsIuBf2ctXpGOd2uMBriHxT/lT4YDrvwl4m1RM11gAu38hOZ
 qj9k2Y5gltzmFBoPT75btbOeHmlDbzhyaHbxvZS18Kxdrr9yHDAqox0sG2iFztXWS4OvVp9neIB
 H/UVIfebGgpVtpvbpw3rYcChaLoiwt1LW4yOzl2ELqrelidFXontLjipXZSwmg==
X-Received: by 2002:a05:600c:3114:b0:495:63e4:7f78 with SMTP id
 5b1f17b1804b1-49987971986mr65098225e9.10.1786706123985; 
 Fri, 14 Aug 2026 04:15:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49988ae8af3sm37944565e9.4.2026.08.14.04.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 04:15:23 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 11:15:21 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
X-Gerrit-Change-Number: 1407
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1407?usp=email>
X-Gerrit-Commit: 8535abbeca3e048d7a90af0e14bd5d812649fe86
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 11:15:21 +0000
In-Reply-To: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
References: <gerrit.1764168347000.Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzY0MTY4MzQ3MDAwLkliMDU4NGU4NzI4NzAxY2NhMTBhYzU2NzVjOWNiMGU2ZjVlYjkwMWFjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <16cdf6d420497f757ac428446101a99dd4392ac9-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wupss-0004fS-6S
Subject: [Openvpn-devel] [M] Change in openvpn[master]: packet_id: Avoid
 conversion warnings
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2282836829920293322=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2282836829920293322==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KqcEOMAr/SA="; charset=UTF-8

--KqcEOMAr/SA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1407?usp=3Demail )

Change subject: packet_id: Avoid conversio=
n warnings
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 8:

(2 comments)

File src/openvpn/packet_id=2Ec:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/d746266a_5080ebe3?usp=3Demail :
P=
S7, Line 255:             if (diff >=3D (packet_id_type)CIRC_LIST_SIZE(p->s=
eq_list))
> Technically since CIRC_LIST_SIZE is no longer restricted to (in=
t), this now opens up a theoretical p [=E2=80=A6]
Again you're confusing x_=
size and x_sizeof


http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407/comment/=
6fab0707_3187f2c9?usp=3Demail :
PS7, Line 261:             {
> These bracke=
ts are confusing=2E [=E2=80=A6]
Done



-- 
To view, visit http://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1407?usp=3Demail
To unsubscribe, or for help writ=
ing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail
=

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
=
Gerrit-Change-Id: Ib0584e8728701cca10ac5675c9cb0e6f5eb901ac
Gerrit-Change-N=
umber: 1407
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC:=
 openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Fri, 14 Aug 202=
6 11:15:21 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-R=
eply-To: plaisthos <arne-openvpn@rfc2549=2Eorg>

--KqcEOMAr/SA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1407?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/packet_id=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407=
/comment/d746266a_5080ebe3?usp=3Demail">Patch Set #7, Line 255:</a> <code s=
tyle=3D"font-family:monospace,monospace">            if (diff &gt;=3D (pack=
et_id_type)CIRC_LIST_SIZE(p-&gt;seq_list))</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Technica=
lly since CIRC_LIST_SIZE is no longer restricted to (int), this now opens u=
p a theoretical p [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Again you&#39;re confusing x=
_size and x_sizeof</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1407/comment/6fab0707_3187f2c9?usp=3Demail">Patch Set #7, Line 261=
:</a> <code style=3D"font-family:monospace,monospace">            {</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">These brackets are confusing=2E [=E2=80=A6]</blockquote></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1407?usp=3Demail">change 1407</a>=2E To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1407?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib0584e8728701cca10ac5=
675c9cb0e6f5eb901ac </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1407 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div =
style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri,=
 14 Aug 2026 11:15:21 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </di=
v>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--KqcEOMAr/SA=--


--===============2282836829920293322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2282836829920293322==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2282836829920293322==--

