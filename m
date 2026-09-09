Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E867CC79F8C
	for <openvpn-devel@archiver.kernel.org>; Wed,  9 Sep 2026 07:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JYDRW9tHBKn5HW0RY2pbw2nJMW6gnH+OJW1hNT4v6io=; b=WApN9rvT4w7tf4YREFXRXL0A98
	T4IcwFd8oixz2fwAQYqBJysIT521xu/IcqYan5zq+XeDrIZegThckv0puewNQ+69CICtEhmvXSTm+
	TmUrAareR+Fu+hvJOix5YBC1bNNaAMhf83B5HlDCHne3J9eXD6TMNP8TPhJHXChVNp5s=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x4Cje-0007gZ-BO;
	Wed, 09 Sep 2026 07:28:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x4Cjc-0007gR-SK
 for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:28:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=6ZWvwzhZhV6auvH2Go1bXP/BKzGaBDfunD9Uz4PLcoA=; b=cc+y+XvBu0HfIP9GehnMyZBmAH
 K1m+xu7FpgSnPuK7594uAt2wO8ggfnhMq4euJeXMMt6qaE8dmvrEhthc+RxzNiP/Bqhmh8cy3ILbE
 asdQ4EBk47tpeuGhAQJtSItQoaCBugKrSd1E5YxRgsoEx85UD4gj5m9uQZ5iAm8RZy5M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=6ZWvwzhZhV6auvH2Go1bXP/BKzGaBDfunD9Uz4PLcoA=; b=G
 VUdLE3eNla40SBTy6GRCgolEDeeIvK12enwAABNhHzMZXCkczeJbD0tve+Yj/T7kIVYkL2zWs1oUH
 ToFyh0b0RLIoNj5DEc+AGTtnvR3BXWfR6pYiU9GtWuVDk4sMAoPM9gwHODxu9Qlx1zdzYKIMRbpNO
 Z7LdJM+t6lLMlXMw=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4CjZ-0008QT-MZ for openvpn-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 07:28:42 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48436251906so6133914f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 00:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788938915; x=1789543715; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6ZWvwzhZhV6auvH2Go1bXP/BKzGaBDfunD9Uz4PLcoA=;
 b=UxHjLhXHkHGB/MvGmGE2om8lCa5cfqqdp97OOxwzbN8ORiSim+jFO6Bhb2SyuEKWLL
 2iLAI/az+aFSDZl9iX/eGy/JSW48STjd6P4rUcjXFuGVNybm1vZs/d0UdPv80h9hEaHE
 fQFCcCGdNzk3KZNHqHegajzpyfvSRwf7o9ukOex9WqEFEPzr0VbxB9joUIj0WefI8CtG
 4LrXI/cz69pqHGctkbGqtySPqU4GhYT3QqrnwoUP2MJLH5Gnvxa73hzTgxULoJokMoP0
 BMLj9+Zu5/+xAgmCnk7kGn3gaXU1lofG0wN8b08/dbvRGQ29A2RZjezg28g+SON3Ks+T
 DMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788938915; x=1789543715;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6ZWvwzhZhV6auvH2Go1bXP/BKzGaBDfunD9Uz4PLcoA=;
 b=WFqzjH5ZH4+36BU9T1PL+/ddzmcVce7YJIH6k95PGNBnM+HVnksPbfKc6aZWM0j7wr
 rFNuWtGXDmLfZdi31viWLhie1nNtibn1uCwQVsLpSmEX7CWDEwUxMQcQFAqEYNqowisy
 M9JoK3mE50thP3Jejk9RTL9U+nqrpMl6u5rrEvMsfKLFLsUbvwmZhFpOxMqokUpsM+SG
 pizTrowpbRXpxOEzoW/t6wEL7Xq8nTZigfTr+NjvEkRP58CarD0W/y7TW8IO4ga8iHMN
 Hna725BOXSkkR88LrwYyv1tPb3Hz3FwOQBMVIPQVoQ+2mrH/k/PBXJ6TO5K31ednVFBy
 TzXA==
X-Forwarded-Encrypted: i=1;
 AKwUvBySSAXM99yCa4A52JKtL8qOgn/tRDD2jMDRLDWBygTt+N5JKHDPYl3ag9FDWOgXdBpiEbgpI6EJLUIrSDBY@lists.sourceforge.net
X-Gm-Message-State: AFuF++m4l6BHHNpQX4otUKZV9GZMMuSa2Qn0kdD823sPxKM/kHKpc9NV
 AoYV+u9cvXonc3WdxM8jFPQvylm8UwlrjI+gF485cboY/p4HRsC1obCIOZU/Agb7RkQfXVrLjvj
 MvVf5l/vDibDGGhmxbJ6y5YEuToKyirDcJLp9JjdfsFvpDWcCbhZAFjMIzWvb1zLHbGOr
X-Gm-Gg: AYBFou1qq73QYeZ2yu7fcS7EtoZ+KLJoH4T3rVxwNtdBxt7++NKVJrFfNMJvgtcXr3B
 q1YiwMoKjZ8akOQZneSlGQ8ZdkQI+WlbJlkwIQp78G7VnA22zEY75vGpD918rKIcYS+JSLihqXy
 0olgNbU+cq5yyHyW6e1u2UNi0+tl4sVjzYtXqvu+WnQ9Aboz3fPCIIwY0s8uiQBn5UQ6Rh9LV8Z
 4lfegERZqCuMg8vThyIJFX4rLM0qj+Bh8EKp1sYBHcVRnPaHc2c+/WspYs/bGzQSJ8dQ4bsRqI9
 9E2kqYFGfPfH9CRrOXZ0I7lkDXEDQM+FFhT5qylIbP05N5/uUw8hna6jX7o/lLDaIrqykLlNRRL
 hnc0CPJHj+NHjp9TPKcTk0QVeTftP4G6Lcncd9TYH21Wc253BVslMOjIycQQW8S9K78RzHCrciv
 R0kH7NcrwgdXfbf1aefdsUv6B99oqsf1XkM8rCg54Z/7UcSeQF0a1jBnD+vGHpICrZyyruJ4zhH
 MlyqUdFpwt+ZTfuIZYPT4qEFEFV3/Y7WeTm9z6T4nLRirZfpg0d+h+hdKbsH7CnQ8L5Yl46Vk/E
 OG06pbUZZX5KLGo/FYIgnfwA6C3yrc8o690pZm4+doJIKxpJGiyCCooGqhIhYJ8=
X-Received: by 2002:a05:6000:70b:b0:485:8be1:378d with SMTP id
 ffacd0b85a97d-4858be14b94mr67558571f8f.12.1788938915056; 
 Wed, 09 Sep 2026 00:28:35 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485885bfe14sm42344263f8f.35.2026.09.09.00.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 00:28:34 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 9 Sep 2026 07:28:33 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a373f
X-Gerrit-Change-Number: 1745
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1745?usp=email>
X-Gerrit-Commit: 9fbd7ea4380f1158846bb9346d3b6d35712e7a8f
X-Gerrit-Comment-Date: Wed, 9 Sep 2026 07:28:33 +0000
In-Reply-To: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
References: <gerrit.1782719911000.If04ce09d4c353f5384c0c48f48f63e05869a373f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLklmMDRjZTA5ZDRjMzUzZjUzODRjMGM0OGY0OGY2M2UwNTg2OWEzNzNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <474f6bb1cf43d97bce36335f052eaa3d7f450e38-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x4CjZ-0008QT-MZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: oob: Add client
 PROBE_REPLY parser
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4013393308631958389=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4013393308631958389==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sIkehRdVjV4="; charset=UTF-8

--sIkehRdVjV4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


stipa has posted comments on this change by stipa=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1745?usp=3Demail )

Change subject: oob: Add client=
 PROBE_REPLY parser
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 13:

(2 comments)

File src/openvpn/oob=2Eh:

http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1745/comment/13b3b4d4_305ee648?usp=3Demail =
:
PS12, Line 137:  * oob_server_probe_read()=2E TLV types other than probe_=
reply are skipped=2E
> nit: TLV types other than probe_reply *marked option=
al* are skipped=2E
Done=2E


File tests/unit_tests/openvpn/test_oob=2Ec:

h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745/comment/6d08263c_b2351458?usp=
=3Demail :
PS12, Line 479:     };
> nit: why not include max_latency_diff h=
ere as well?
Done=2E Added to the input struct and the asserts=2E



-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: o=
penvpn
Gerrit-Branch: master
Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f=
63e05869a373f
Gerrit-Change-Number: 1745
Gerrit-PatchSet: 13
Gerrit-Owner: =
stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-R=
eviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Ge=
rrit-Attention: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, =
09 Sep 2026 07:28:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Co=
mment-In-Reply-To: ralf_lici <ralf@mandelbit=2Ecom>

--sIkehRdVjV4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1745?usp=3Demail">View Change=
</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0;"><p>File src/openvpn/oob=2Eh:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1745/comment/13b3b4d4_305ee648?usp=3Demail">Patch Set #1=
2, Line 137:</a> <code style=3D"font-family:monospace,monospace"> * oob_ser=
ver_probe_read()=2E TLV types other than probe_reply are skipped=2E</code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">nit: TLV types other than probe_reply *marked optional* are =
skipped=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done=2E</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File tests/unit_tests/openvpn/test_oob=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1745/comment/6d08263c_b2351458?usp=3Demail">Patch Set #1=
2, Line 479:</a> <code style=3D"font-family:monospace,monospace">    };</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">nit: why not include max_latency_diff here as well?</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done=2E Added to the input struct and the asserts=2E</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1745?usp=3Demail">change 1745</a>=2E To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1745?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn <=
/div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: If04ce09d4c353f5384c0c48f48f63e05869a3=
73f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1745 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"displa=
y:none"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"=
display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 09 Sep 2026 07:2=
8:33 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </di=
v>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"=
display:none"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>

</body></html>
--sIkehRdVjV4=--


--===============4013393308631958389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4013393308631958389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4013393308631958389==--

