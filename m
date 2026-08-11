Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7249EC5CFC1
	for <openvpn-devel@archiver.kernel.org>; Tue, 11 Aug 2026 09:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rL6Xn6aXFL9hmT6vP0WttqkRaybqTRbrVxclovaAiEs=; b=E4G9Pm09RaG7Qphr3ZMklHoCSY
	8pdvyfy+emMXiyYxkcTacYf5/XRcC+KKl21Iha7RE06nToPnvJEH47+G/WmVtnDtqhtdgUbLHyq06
	WaHT98N0TC33e2nt2sqOXrxoFPYdKVe5/0iZKTJLijJwA1Uj4EUdvqpTTaG3gsy/1dn8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtitT-0006Xk-I7;
	Tue, 11 Aug 2026 09:35:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtit7-0006XO-Vr
 for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 09:35:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KlRIZhd2F4mn4MwGxKctU6k3yH8NP//1F6Zvey2T/AI=; b=M+Mvw7gyzC/lagcVfgdY9tRwEw
 7J2IvL7/D8B6vtdiOVtJvozxeSyhoWY2ZNDAGTHIOsaT+kRp6c1rMU0L6sd0ru3ri1xt0+SQj5bTr
 z9y46pBFfCtVA9dtpoVWvMRzUMcgWNe6HosJsC9rg3WrTC5c0xF9KWMVqoVWwYQH5OSs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KlRIZhd2F4mn4MwGxKctU6k3yH8NP//1F6Zvey2T/AI=; b=m
 3aanN+dvYv4qUg9HN/l5o8dqt7K6S+PLu/8Y6RDBQtRna1BAq+lZgchFTRGxdmL1Bc0eWDTT4GSci
 KdAtYuCaiFSZbrK5Wh082MauegOuApnrMf2k3SVCQILd//2qdjcErQ1scW+SVvcALEfxRnMNzfelH
 ULs1HABe2D9W2tUA=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtit2-0004QW-T6 for openvpn-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 09:35:06 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-49557167508so23515695e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 02:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786440899; x=1787045699; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KlRIZhd2F4mn4MwGxKctU6k3yH8NP//1F6Zvey2T/AI=;
 b=diknzqYa4+KQAIMLbBScjcq8KVh9lMIyQcym0Evxaw9+wqQ7RNO4ftNELr5HHYIqpJ
 bcBjDJSxjDq8mqM7M8pi/5usPxnZeu5Gt50XKr0zMZqvw2aOrMI/nwAK6SuPvzFTdTMg
 w5VROZcEPC+qY3muctFHETyCQk7u7IxGBsiRyvyB0mJ1nLecBAvABj7x63F5Cwnb2eWB
 ItNOfZyvAl6xcFZW0Dbby5Q7UskO/jn1W4sIkgPSX9LIUPMiccwRzqTyA0zKnpS5d7If
 xM7otmHTcnMv00hihUiOh9X5W91Ck9fqoe4D9sA6KRwutU4HIlGS98+uMd7jedruy20e
 HkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786440899; x=1787045699;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KlRIZhd2F4mn4MwGxKctU6k3yH8NP//1F6Zvey2T/AI=;
 b=HIwDdps2kg0iYS0KSdEOk5y9q1/E+XZaSGHV4bFXZb0wblJOtsBmfKmUB8Nx9qXa7y
 32hkJd9CNqLbOh6me1lUMIVnYz+MNmb5v4nT39gQOwjT+pL+GuVfukM4jDGlkvSpM0Gv
 lnPw3fdmRM2ACN5Uox+3XD0jUFJekkwchexuzQ/2BYDuEkuEiGtbM2c7MlJDBN3TZdn/
 IoibG4+mxbwWI+Ix6AfHHq0WqhRpb8An9Hm2A3OY53tPzTmlOZ37lRKT3YiDPWQdPSGA
 9iaG3bPIbdAC7D0Qt+lplO2sP8ENzv9NWE5+oYhrS50zY4gcF7FTITKo73nAAgWwhKP0
 CEKw==
X-Gm-Message-State: AOJu0YwLba1fzTVprBCKbJf3RY/ox3C7a9tovteajPT0LvKyxg19zdG9
 x5YfIcreVTm2KIcnW70m/ZWU/iQORsWCctE+gs43bMmr4eAAk45WVp3NPBr8qv2mU94YZSHV2QJ
 LEZrdfPzivreTijpKQdcEoKjl12xgewgwOq/J+0hQyuaCl30ukTkaBhMTMawwXyQW1RLXonWA7+
 srcf3iXg==
X-Gm-Gg: AR+sD12e3FrTcDBT/8OyDJReyUVZbH2aA8KbCAWOuBvWsbiwMCSI/6shmOnxEI48qXx
 cdCgI86FDVErDnbxYhSbsOuhb5AvTvTLd+47syqbJ7EmrhHCM7hc6nUUWx6WYmotph5D9wcm422
 xgLKCdOYMu3HZK19us3LyoFeEDccUdrOYaXkeZmOJJbKq0XsJHHXhSlKKroYVQgg6TzDfm4UEGY
 MuNRG4AZQVIweNzlyEtWc4s/LNoPdBExI+Zc2X0Cx7/2JgScsEttokvwmchWbLw+CQ75eZdkCdo
 hvOUzp8FOej5Fyi+jX3gfEhMsLCEic1fmvPzdwwa9f1i4eB0SJcSaYOkS2W0r0NeLgl2L08u9CS
 VKSghivicgDstkui7s58yMslEZU7mHAA/58iJNJA8bJZQaCjN5KGQIlqe6q0t7DxK9RivDN4JHu
 so147Us/we1cdXF7RsamenQE8jYq08Rv/epS6D7r/nAfKqATELRWtvL/DQb3tphrjLuSthdonlL
 DDcb/UOGxNCb/Rucegnykvfjkv6fYDEnLkhq6tsIjmhQXGYZ2cQJiOp6KntAh4+IA9l811f/dPh
 m1dM4ZRweTqhqUKvlYeEhOH/Gdm3tlDCbAVs3RpUDy+4igjBeF8=
X-Received: by 2002:a05:600c:c83:b0:495:573e:1c54 with SMTP id
 5b1f17b1804b1-499784613f2mr27183675e9.9.1786440898635; 
 Tue, 11 Aug 2026 02:34:58 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499788b24f8sm24226735e9.7.2026.08.11.02.34.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 02:34:57 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 11 Aug 2026 09:34:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f
X-Gerrit-Change-Number: 1840
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1840?usp=email>
X-Gerrit-Commit: f893e6e68b48f09a37edb9ffe0c89c519051017e
X-Gerrit-Comment-Date: Tue, 11 Aug 2026 09:34:56 +0000
In-Reply-To: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
References: <gerrit.1786440840000.I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg2NDQwODQwMDAwLkkxOTEzYTZlNjRiN2NlMjJiNjZkMjAzNGRmMmEyZmFjMzNmNjBlYTlmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cee100d04d7bab9ac347d833b6cbc618758c33b0-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtit2-0004QW-T6
Subject: [Openvpn-devel] [S] Change in openvpn[master]: OpenSSL: avoid
 resetting the HMAC key on every packet
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1589378065228961175=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1589378065228961175==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zENgsG73xX0="; charset=UTF-8

--zENgsG73xX0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has posted comments on this change by plaisthos=2E ( http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail )

Change subject: OpenSSL: =
avoid resetting the HMAC key on every packet
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2

(1 comment)

P=
atchset:

PS1: 
I picked up this patch from https://github=2Ecom/OpenVPN/op=
envpn/pull/1088 and fix the small white space issue in the original patch=
=2E

Ubuntu 22=2E04 still uses OpenSSL 3=2E0=2E2 so I think we still need t=
hat ifdef=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1840?usp=3Demail
To unsubscribe, or for help writing mail filters, visit =
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: com=
ment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1913a=
6e64b7ce22b66d2034df2a2fac33f60ea9f
Gerrit-Change-Number: 1840
Gerrit-Patch=
Set: 1
Gerrit-Owner: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-=
devel@lists=2Esourceforge=2Enet>
Gerrit-Comment-Date: Tue, 11 Aug 2026 09:3=
4:56 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--zENgsG73xX0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Patch set 1:<span=
 style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding=
: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?usp=3Demail">View Change</a></=
p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">I picked up this patch =
from https://github=2Ecom/OpenVPN/openvpn/pull/1088 and fix the small white=
 space issue in the original patch=2E</p><p class=3D"blocks" style=3D"white=
-space: pre-wrap; word-wrap: break-word;">Ubuntu 22=2E04 still uses OpenSSL=
 3=2E0=2E2 so I think we still need that ifdef=2E</p></li></ul></li></ul><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1840?u=
sp=3Demail">change 1840</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1840?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1913a6e64b7ce22b66d2034df2a2fac33f60ea9f </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1840 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Tue, 11 Aug 2026 09:34:56 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: Yes </div>

</body></html>
--zENgsG73xX0=--


--===============1589378065228961175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1589378065228961175==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1589378065228961175==--

