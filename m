Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CB9C5CFDB
	for <openvpn-devel@archiver.kernel.org>; Fri, 14 Aug 2026 12:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y2PekARh3B9zAlBwB/Toi6R2fYsXtfCjDvIluMso7Zo=; b=dndgHmhDiQbpI1GsPdF6DzulQP
	2HBu/nRMdqkVJzH4U7pUeG3P8n9m/+bi3WOyUMrbVbt+v311Q303RLmQE9FyihwhXoZIcEjGRUOgO
	488XbfB+Nc0yY0Zq6EByLghfwtLSdPgFkQtB+BE5j9BCiqZt8p2bG/wNFuxAgCYElZOA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wurUW-0002eg-3g;
	Fri, 14 Aug 2026 12:58:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wurUU-0002ea-WB
 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 12:58:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=zXpJ1Vmb3/pxsmmJrPFG45+FLsMwc07DL7r0H6dw2lU=; b=aBVEqXEs0zM79JwCCujEdj7nAZ
 LRAVfJUtjPE+L/8rie7qcczJnDHNmbIk0fiP/Dz8Iag63zzhwoWd4Diogl8bVSvZp3zMHP1nHFeXq
 TpOsRJhFPOOROd3AnEqSWg4h2PFKPPAb+5pRNYYuhyMUFnN1HQAv0N9zsHssjl7FFGHg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zXpJ1Vmb3/pxsmmJrPFG45+FLsMwc07DL7r0H6dw2lU=; b=c
 orK65R39a6ZvSjA1RPCiDh2V516mq/jdMtRVizhqcfPrhJcj6FUfK0raPiJccurprSdwf4AfoBqCq
 TofsQsHBtHZESsf2O5oS2sdQPznm6AQsZePknVQKt4gtr5DXn3cZrjacS+igEzmeBvmnxODbtFJK6
 9EeUbyunT1iMH9R4=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wurUS-0006YC-59 for openvpn-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 12:58:30 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4954d29264cso5245765e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786712301; x=1787317101; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=zXpJ1Vmb3/pxsmmJrPFG45+FLsMwc07DL7r0H6dw2lU=;
 b=ZIxjGAJmP8/r0j2yE32NnVmyjE19wERngmHaEAn1b3Lvqwiu2gw9LpPUH5CML1qozc
 X6FDVLB7mV0i3YT8ulolw/TJMj4Ywyq1bdTYsT5JY9gRwOHgUQTQZiMpJ1mrZFGfci4y
 DDhSmBBhrWxuIS8RmlE12MXfr4rz2vnmoQPw7bs6x47V7c+sxspiOSsr/Nqo1GGRNCJw
 kXdp0DIy5eqBGg1LBX7FJUgjQkMNvTJRFWOiE1236/pTifYOBXB5NkXlOcmFED/WFVp0
 3roT9bOSkuH2CMrVSsIbZlnOXQNRPs6cmGVot/MqX1TBoCLiJ+GPZGwDlMXz9OQa7mKX
 tdig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786712301; x=1787317101;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=zXpJ1Vmb3/pxsmmJrPFG45+FLsMwc07DL7r0H6dw2lU=;
 b=PbLjLk31m0yWWJN9nVAoGRsmIkMI2LBVtQz9EhUEHclm4ZbNL1e9CTEggq+Tsa2Vdy
 +Zkdkt8XZhk1hqYNxwzPNb0uIlEwuz7sOnPeIxJC7dZD3mfXS6HW0C9pj2/9Kbjd8IiU
 6UKDmO3I9zyTdfJxCKpRa29yN56bGTqP2b5PH8J0nVTxWLUV2texrpi4/zI7bSZpGsrj
 FopuxdG5097Gs1rbmF9ktVTHyVetnkO4+/YRarMIIv6+cttYUg0zj9SGYUNbu6bhsTSU
 4BBECGgd25Y1qMjU7KRcXiaJDs9OQ2ChmiY7kldZrQMRIKvuOIaHunqFLdma63f7YCZ9
 Uekw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqPHIX1rFJswMMv9CBWcuWeRFv/K8Rl147tVdRrC+Miy44XQxUN+jl1wt7wpgOH8nw3cimU9qC+hj6hdMn7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwS8XhLFDp721+RyYWhWWdQqi/WnYx0w4QJcS0KPcx39bSFLuX5
 VZe8OFEMxm5t/n4N0E9c+/K7QdgcewZLJR0cd+Pe9/Nt5O5ckNBIxpgm0pGTs3J2TvULdhFAIT+
 zvfC/sDXR9Jef/4snd5NwSVGJBsaC4Jhq9EpUZ4mLxTvlb7P/7AN0qSGhIhdISDuddXps7zSVRK
 zdMbw1+g==
X-Gm-Gg: AR+sD12P47iQDX/d2LZNVrsKA6az09+35b0wRHFGAXplgjoaZaH4+usZEQ2uGTUmpB5
 ScqxAhOVGYVdlhIDVwQRiYolqJCk0HAnAvqnQqEeoKe0Uo9fb6Vb2hsr2ry7ukDDkZdF9u0UR8p
 25cM5Bm/ej9Lyo4f4KrWycdt5kvc66l9ofhYS3jvPomzI3MCg96RZERlGu5hwFKzhn9b+CCZNtG
 pJyJXzzhdPRdEy7dJVa34uLZ5g/2xXq0zrTsZxnPzB99rQswVnPFHSs76lhZCyMIBoL+MzW/wRd
 NCJihMTHlWSLwLA+w6B/nszMWe4c4o28vwU7UZpiy2Hk9jBtE7o60pvjn3x1C1oWyvrt0WS7GpI
 67LrymOSIOHJAJTvpLesUl4m+2HFe34WvU3qbffdgiKs4L6c/EvzmXOnnqIpSd9PR7GAB64M4nu
 pq+Leu0qF8QI6eQblVWV417B5EanW8geheRLob35RxLUY339E+ntTq/fd/emJzsEf2i3gqh/fAj
 BtE0eFVNA8FgclxP2Am28z+qGeRIIQr45hpcIIUfz0nFSViqdpYut2pNlaK0hZtSW03ZXVmmL4D
 8BZHRjeUU0rh/Fytl5GCbUGAmcfp8vF0OC3Qih1N7pVSCYokieA=
X-Received: by 2002:a05:600c:6a10:b0:499:79ba:a754 with SMTP id
 5b1f17b1804b1-49987973094mr68547415e9.11.1786712301461; 
 Fri, 14 Aug 2026 05:58:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2c18cbsm6984971f8f.29.2026.08.14.05.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 05:58:21 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 14 Aug 2026 12:58:19 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
X-Gerrit-Change-Number: 1618
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1618?usp=email>
X-Gerrit-Commit: ed759afec30cf6e1ce9c06af92679a17afdc89f1
X-Gerrit-Comment-Date: Fri, 14 Aug 2026 12:58:19 +0000
In-Reply-To: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
References: <gerrit.1775421558000.I528f5fd200d877841e473e5e05b7ac7915fa2e33@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLkk1MjhmNWZkMjAwZDg3Nzg0MWU0NzNlNWUwNWI3YWM3OTE1ZmEyZTMzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e243ae83c1ef67f154aff6a67284b46e05498057-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wurUS-0006YC-59
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Rename variables
 that shadow other variables or functions
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
Content-Type: multipart/mixed; boundary="===============2354444536504792643=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2354444536504792643==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1yTzJRVTWhA="; charset=UTF-8

--1yTzJRVTWhA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

razvanc h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1618?usp=3Demail )

Change subject: Rename variables =
that shadow other variables or functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 13:

(2 comments)

File tests/unit_=
tests/openvpn/test_dhcp=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/161=
8/comment/8c28ed03_34fae63e?usp=3Demail :
PS13, Line 58:     struct buffer =
clean_buf =3D alloc_buf_gc(512, &gc);
clear_buf vs=2E clean_buf is slightly=
 pushing it for mishaps I think? =F0=9F=98=8A


File tests/unit_tests/openv=
pn/test_push_update_msg=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/161=
8/comment/45a8658f_1443ba3e?usp=3Demail :
PS13, Line 347:     const char *c=
msg1 =3D "PUSH_UPDATE, route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=
=2E0=2E0 255=2E255=2E0=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-con=
tinuation 2";
Maybe push_msg1 here (and the same strategy below)? Would it =
make it a bit clearer?



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1618?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: I528f5fd200d877841e473e5e05b7ac7915fa2e33
Gerrit-Change-Number: 1618
Ge=
rrit-PatchSet: 13
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mai=
lbox=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit=
-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri=
, 14 Aug 2026 12:58:19 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--1yTzJRVTWhA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">View Change</a></p><p>=
2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/test_dhcp=2Ec:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1618/comment/8c28ed03_34fae63e?usp=3Demail">Patch Se=
t #13, Line 58:</a> <code style=3D"font-family:monospace,monospace">    str=
uct buffer clean_buf =3D alloc_buf_gc(512, &amp;gc);</code></p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">clear_buf v=
s=2E clean_buf is slightly pushing it for mishaps I think? =F0=9F=98=8A</p>=
</li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_test=
s/openvpn/test_push_update_msg=2Ec:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618/comme=
nt/45a8658f_1443ba3e?usp=3Demail">Patch Set #13, Line 347:</a> <code style=
=3D"font-family:monospace,monospace">    const char *cmsg1 =3D &quot;PUSH_U=
PDATE, route 10=2E1=2E0=2E0 255=2E255=2E0=2E0, route 10=2E2=2E0=2E0 255=2E2=
55=2E0=2E0, route 10=2E3=2E0=2E0 255=2E255=2E0=2E0,push-continuation 2&quot=
;;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Maybe push_msg1 here (and the same strategy below)? Would it =
make it a bit clearer?</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail">change 1618</a>=
=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div ite=
mscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1618?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I528f5fd2=
00d877841e473e5e05b7ac7915fa2e33 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1618 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@=
lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Comment-Date: Fri, 14 Aug 2026 12:58:19 +0000=
 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div st=
yle=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--1yTzJRVTWhA=--


--===============2354444536504792643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2354444536504792643==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2354444536504792643==--

