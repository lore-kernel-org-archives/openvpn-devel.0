Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA70C531D0
	for <openvpn-devel@archiver.kernel.org>; Mon, 27 Jul 2026 13:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r7JLnWUfTpmSRwARBBysfubXRXISayZMMHA0kkHLGtY=; b=C+IkSzSn7CVH3QVxLj7A93H9+k
	JOpOjSbbCVYvtGj0c+U2BIW0CmAsHsy1V7GB0jc8qczF+ec0kD57JgrfBTJeQGHIxTT7CfuMLdA2D
	5+dUTdDZCcUbIOsXnZ3kUCi6WwtNOg18NBy+R+BDYXz0tMsYEuUjiZI656vwnp6XP70s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1woLao-0001RR-PQ;
	Mon, 27 Jul 2026 13:42:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1woLan-0001RL-M4
 for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 13:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=1tsmE6zA4Gg88P/DMXKKKjfI9JozEMkM2TngKG3oUnE=; b=k89HrgTwB78GU/hUq061YFOGLP
 n2P0vz/JGGJDIbJAey+9JeEGX+k4kEq1cwIREsFAZ24uQTKadRfd6Cb/VJ6WHPXsKVqNCp7gIUwrT
 s7o0R/m+HzmBMY9C2Jwqs0AevWGfKEsj3ynj/2eCri8kkdQOHNyNxA3Km7pckbIZrIGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1tsmE6zA4Gg88P/DMXKKKjfI9JozEMkM2TngKG3oUnE=; b=D
 8hhYBifljX/EEI9y0keAB45+YKWKxSfpG/dd1K6xhDC2YLhruKLsWO30oqqmIkWLCNKaKTxyqPAnM
 t3R/P2/IqkHehfQQrPXG4kK7IRgIha0GrezVk8Lj+3LzU8cpt3CB9jkFXPEXrDZvZPvC1vpoYvc8d
 p76vMJT6ZsTczAiQ=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1woLao-0008Kb-Mk for openvpn-devel@lists.sourceforge.net;
 Mon, 27 Jul 2026 13:42:05 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-495590dde14so29898325e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 27 Jul 2026 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785159716; x=1785764516; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1tsmE6zA4Gg88P/DMXKKKjfI9JozEMkM2TngKG3oUnE=;
 b=eExximPKzkrZ48EDoNF4Po631mYhAiMp0TvRS7LCfYlocU999JqFC46id1zVM96me5
 06fZUUkWGmwetXCCXyfbvEs92qqvFq9effjdDQpN62105H7gp7jJnBl9V7iG6KRV40oz
 UjfyH1H3FL6auEcPGMqTI8596Ue2tD6Jg6w2mprEnUyV/uUFo64YlLDKtIn/XwL4VcUq
 Rmcbd/qtn7gm3DfKFZ0nYA3mhBjhn5ejDBkrPtbPjRlkok3KvzylNSPBk4+Ll6kADLS1
 eaZbD2zz4e/vsRrNeVT4xl6+Kir9Nnq4ml0IurWWAmD8z1eTETplcyQqS53glTYnIhsJ
 6ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785159716; x=1785764516;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=1tsmE6zA4Gg88P/DMXKKKjfI9JozEMkM2TngKG3oUnE=;
 b=VqmyqDLv12Z0NeUkGtIOH+U/WjRL4vfEyQB7kMl/K7fX5+UAI/mQcDngilOVpyOwCy
 952DUy0wohnUWMUfdlJYO7B6wrq6ynOmkikrZbx7zZKh9yHT4Sc8zwTfHMspVzK381Xy
 2yTYXpK7j+1wLWKg+JlKC0O0UBxOYrFd7RUtHNNIgbgiGpD2ELe9wttIxHf1HWWZX3zo
 vFPWiiXgAue4kvtzueOcQOV9S/6+leO8S+jBHJkvL6Ud9hAbpAaL6QGy6gDTMujn9X/2
 SKoYLOqwIkR1vnlXW+KBqFILDEnDlj/TVjkZgm1BggG+O6p6K2SBzWMiZgLbuXecJpiX
 xpSA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpo8KDk3z+1v/4FmghI2x8W26xbC1CtKmVIQOVmun0LaU2QHZCyy7l+ffuZ6OxIxAcaHz5jDw0MgNNol7ux@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxJftQPSdPqSW/JzhlSAdesJ9pd2jh/T2U+bQs97cxbTOQUUmEn
 /X1/AMMUqiq/Yh8vnxkeYMXf26YkJBzegFhWfULr5IUpH30oZHxNdAGWMEmtG7dnQocwYM3xWJ7
 /D8lZPzQcDpSmb5R1ZeKjwkweeJIDvx8w82z3hd40n3lz5D7Axvj/Sc8kGefRbNS9cOYf
X-Gm-Gg: AR+sD11a3bha8M9yyqDEKoMPex5PaRnrVavH9jjXVQLvgJWoKOOjalCeXVZNrESzNT/
 o/gyZwjI+xB3iE2A1nXGg91dHlgdXdCrp3IzF15ERgnmzL9LGrlKr+RpWmQy6CtJhdjrnxgKfmm
 rFM/CRZyOdCkvAtAF+5osnjND4WNzXG2H8wNCRv3e4bRD2FhliapIx94kzljq0WP0UjudKl5L+P
 lLRn9SmsK19pOYJhimP+dg66BWMSWQrQ6Y7k0o5fdLNAG+pH49/u4gP7V7CyO9aLwOiN39LEtjJ
 +l41LDhQXUUNZ3lWNpne63/4lYE+v9wl9F7Y+LUWsxkmblH66eS3U3TB32fozn4+sGJhEiFiqds
 KNdz5/HXBYB63fWAeFnB0kixD2mrNfUQly2fAOZwVlgcUGrbF8iPLM0xu0o/8R4iZ2sJIo4zDH8
 kgA0vaWJgZCYfr2HCqDYXSPZ7LHrkZL5FEGdZ80MG9FXglIe0xi4vihk0t8sdsLPY2GDfz/GrN4
 DToFRd4I5FAzHlWvYEA6tEfito81CUNPDMZH50g6zSU6W1GIZzREALo2qlG//+0ylQ+
X-Received: by 2002:a05:600c:19c7:b0:495:7379:17b1 with SMTP id
 5b1f17b1804b1-496c3a61973mr10171945e9.30.1785159716219; 
 Mon, 27 Jul 2026 06:41:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f302f8sm216325505e9.12.2026.07.27.06.41.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 06:41:55 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 27 Jul 2026 13:41:51 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 25f3955efd71e5c7ab54e0da3d4181610cb0b5c9
X-Gerrit-Comment-Date: Mon, 27 Jul 2026 13:41:51 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <03d3a149be70791d281fffa97bcd7e4eb3a04dfa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1woLao-0008Kb-Mk
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7224129690003249770=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7224129690003249770==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gkZP12KWFtg="; charset=UTF-8

--gkZP12KWFtg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos=2E

cron2 has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 27: Code-Review-2

(2 comments)

Patchset=
:

PS27: 
getting there, just one small irk remaining


File src/openvpn/ss=
l=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/be3a2177_8ee=
1643b?usp=3Demail :
PS27, Line 1193:             uint8_t peerid[3];
please =
rewrite using `multi->rx_peer_id =3D get_random() & 0xffffff` - shorter, ea=
sier to understand=2E

Or we can get rid of the loop doing maybe `get_rando=
m % (MAX_PEER_ID-1)` if uniformness is less important=2E  Or `& 0xefffff` i=
f only half the number space is sufficient ;-)



-- 
To view, visit http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?us=
p=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branc=
h: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerri=
t-Change-Number: 1089
Gerrit-PatchSet: 27
Gerrit-Owner: its_Giaan <gianmarc=
o@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-=
Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan =
<gianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichtenheld <frank@lichtenhe=
ld=2Ecom>
Gerrit-Attention: ordex <antonio@mandelbit=2Ecom>
Gerrit-Comment-=
Date: Mon, 27 Jul 2026 13:41:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-La=
bels: Yes

--gkZP12KWFtg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, ordex, plaisthos=2E </p>
<p>=
Patch set 27:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span></=
p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"=
>View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1089?tab=3Dcomments&amp;usp=3Demail">Patch Set #27:</a> </p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">get=
ting there, just one small irk remaining</p></li></ul></li><li style=3D"mar=
gin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1089/comment/be3a2177_8ee1643b?usp=3Demail">Patch Set #27, Line 1193:</=
a> <code style=3D"font-family:monospace,monospace">            uint8_t peer=
id[3];</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">please rewrite using `multi-&gt;rx_peer_id =3D get_random=
() &amp; 0xffffff` - shorter, easier to understand=2E</p><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">Or we can get rid=
 of the loop doing maybe `get_random % (MAX_PEER_ID-1)` if uniformness is l=
ess important=2E  Or `&amp; 0xefffff` if only half the number space is suff=
icient ;-)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:non=
e"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-=
Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master =
</div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20ea=
bcee3bab3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Numb=
er: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 27 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;g=
ert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandel=
bit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichte=
nheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-Comment-Date: Mon, 27 Jul 2026 13:41:51 +0000 </div>=

<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"=
display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--gkZP12KWFtg=--


--===============7224129690003249770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7224129690003249770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7224129690003249770==--

