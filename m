Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EDC3606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 29 Oct 2026 17:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BY7b4vrS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=KgOnKUOa;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZE0P33wn;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YYaKhqUE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LBGB0mQ9XeA+0sAtNqHFEMLRfeHaj+RxvY+TCDWrEDU=; b=BY7b4vrS+iHixf0qvhJmZ2Ynj0
	Vf6cu0p6BdxlUmCW9cn8I8hHg01cgViIi97gYfaNhcqbyxvwk4QfFEwNsbn8mkqXf/VnEp7yU6uCo
	l50GvKhW1A/w1PGNyr+zapFb70/Iy4xoKxq4BCQFNmTTuBOFGkyO9QWghmi2t1IAUA44=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMTpk-0000000011r-1nRu;
	Thu, 29 Oct 2026 17:22:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMTpk-0000000011j-0BQA
 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:22:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AH7f5L4Lm/LXxUN17tMPDoabwrnCFj+SuJR/I0IWnOc=; b=KgOnKUOam/HEiye8UOsc5pCZKT
 2Pv1iFcFfox+56BX+t8N4Nv09SkqljCm87Bb0oYoifPMbkZVoIAanYdT7t532Et6XIJqARALtIitm
 XMvTOIhwRGdSNMGnwzUNXkeTN4ML/SI3sHJ3Ib0AEXop8mrcc1km2fjWkpWLojTaous4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AH7f5L4Lm/LXxUN17tMPDoabwrnCFj+SuJR/I0IWnOc=; b=ZE0P33wn6b4z/+eQYss/6s9qYX
 DAFWBfCYxVdIlCfzcGdaIxIin7ABm+gK+Hz08kB16s6CIjnfNDn4L588yQ+glADgGuXCOmoUMp3vl
 Hs5SaZlLCcqarF4N9F77+rSYfWoywvTe7gAsQbfrr7RAcHltMI5E2Q9Ma+85AxOYsxR0=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMTpi-000000000zs-1HR7 for openvpn-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 17:22:35 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso1396804f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 10:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793294548; x=1793899348; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AH7f5L4Lm/LXxUN17tMPDoabwrnCFj+SuJR/I0IWnOc=;
 b=YYaKhqUEwVgVLcDUI/juYBlJbBtjztckYeCsStTP2WvQ/Vx6PK0epbSv5KbDz+yKYF
 IdBXCxdDMfrGohxjlYnq9FzMItSzABibwifeOsrMz+Hyy4tlWlHCpEmWWZ+FluWjq4nL
 jwQZ9HPvTHo8tB3JHk5FWFcupX0wE2WLNXmuAcymx3seKqmyA4yHKdzgMPOJ23mC1uUO
 orPm1/TB/vwPVQPnMS/iAjrL99PJiMNB/4rk6vKbuavYgNRqNAFWS1hlS47irUe54Wx4
 fQXTkFo1LKpNYu6flAioxy8mNvyAX79BpIdbjq620NTu6EdoEfSUmaHkwbHBdHPU5+EF
 9MMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793294548; x=1793899348;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AH7f5L4Lm/LXxUN17tMPDoabwrnCFj+SuJR/I0IWnOc=;
 b=Dg6Ammk1l1i3wy5eewvglB+ykHSlD1qDt79r45joKriJY4EfgivLedHTf6t+LDJmBX
 mq6ImD322pEyhSEGAXzBzgi2PL8jfkq/ljcjkSDV8kxy75qow/jsQQopo5mk8r+HZvzo
 ZPiw/k43HVq9NZLZSmv4PuVXi5eWJYovNp2yymZIhzqGv/uh8QCIBVIyLn5NVUnLcBe0
 pWLgk9m6waqAtZWmYewNDOnmcOgr7E7i1AGV77C6GGE8rCISjkgtoGAv9tHGNF/dxera
 uo6q2vSbZr9i7INPAxGR9sv/vSrlEyjtgXhHDfKBUj+98RgAVK9u3yK4ariuTzzTuJZT
 F6CQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwgqh7d9LS3/V3LAkfCoBYGUDDGMbqEbcRdNmwduuHu9WF1JL4jA2TsRkfXTym4arCnRgM6k/K3F126OxQG@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLP3BIylFqbWz72d3C4Ji7xc/ngviL/HqDEs4hZIhmEYjk2c4yj
 0nNRV2ZVHBJ9JV3eiwoaUYMMkYicy4rmPkTCkxDXaJ7xgJNNydaRjwJTwIMZGE9CgAHATeGBp9U
 xkXmVps8dYVGkP4tR6ZYKSMdP/fnakwb8KdNLdxazz1acpMTQZhf51O8KzwcbHrDnQ39Y
X-Gm-Gg: AYBFou1JyvtCNtFD3/ui3li4+nxyigTAbL7PbETMao7yz1vUjOA1nesVdPwFM21uXXG
 2kFPMYL0olfxEeZQ0e3vlEX1O7RTnamPpjE+rkjJiamgLHsmWkZkNC10WhEjyBkbPoqTqzU1NKF
 p7Chb9rV84hmsJTSdeIsshq7w7HyluSX8CQPJ7BN3EekTCrQat0gyQBq8W4xSDdLybQETv7Kyoh
 zbwlxw6JyLfGbPpLKNjT/nbwntb4kxclfckIJ26lCOVyub4SnbtvYspbQBkoWPS8A8HX8orMELP
 byEbxbN6shK+t2j7XOqzoRpOA1eC+QvIR3APwXbjaa6FW510c9RvZkPiTyT/f+Epwx67xMiXvk4
 5j5H+kg+qhyrDQysQSWgL0lt3OhWc23QGrwOMCyDNvNqdo47lmhfX5i7yMJI9KTTxzqDD+apkJc
 SYxLsQfr41AnWXi87MPVk6n9Wvo4Zr+FA1cHbTOALVO6dvy/5+AFRJ1jcBqaKC6zain96wKU/fU
 whsn9jVeq0VF6Tjl7Yr/oqvrNHgNSHWRYKdogw5FEsw/HjEqcRww4OKgY35ep4Rxv90JJYBcvDf
 OU8t8lpf3SZcgBGqHo9ZrVvXC7W09fdve5fN5FVSDLYpVsRw2g6xUoKf+ZibvCLyof2IiIpyG3D
 dhotXTYA4bLqhq2saUWJSgn1ffeNugyqJjawqAl1x4BGel1a3C28gfPQp6BNQJiTCMm7uETC/PQ
 SML2wtswyz8PPye8DJ
X-Received: by 2002:a05:6000:1ac5:b0:48b:116d:56fb with SMTP id
 ffacd0b85a97d-48e6e2bbfe0mr228382f8f.1.1793294547434; 
 Thu, 29 Oct 2026 10:22:27 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e6df87f26sm446704f8f.17.2026.10.29.10.22.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 10:22:26 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 29 Oct 2026 17:22:24 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
X-Gerrit-Change-Number: 1858
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1858?usp=email>
X-Gerrit-Commit: 0d8719830b6fb0a55223b6d99b9b458ddfdb63cd
X-Gerrit-Comment-Date: Thu, 29 Oct 2026 17:22:24 +0000
In-Reply-To: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
References: <gerrit.1787327336000.I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3MzI3MzM2MDAwLkk0YTZhNmVmNDFlMTU4OTZiOGI3OWQ3OTViMmE2ZGU4NmI4YWU0Yzg0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6288a099921db7ec37dba94d69243e83cb6c4cd0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMTpi-000000000zs-1HR7
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement
 sending/receiving app custom control protocol messages
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 chugly <charlie.vigue@openvpn.com>
Content-Type: multipart/mixed; boundary="===============5136652831337592078=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5136652831337592078==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PNsjq4cOqcw="; charset=UTF-8

--PNsjq4cOqcw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Arne Schwabe=2E (=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail )

Change subj=
ect: Implement sending/receiving app custom control protocol messages
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 23: C=
ode-Review-1

(2 comments)

Patchset:

PS23: 
Unfortunately the new code in=
 the latest iteration of the patch introduced a small regression=2E


File =
src/openvpn/manage=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/co=
mment/07e5a071_d89dd7a4?usp=3Demail :
PS23, Line 4468:     while ((flag =3D=
 strsep(&encoding, ":")))
The new else-branch now rejects `A`=2E We should =
probably accept only one of `A` or `6`=2E



-- 
To view, visit https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84
Gerrit=
-Change-Number: 1858
Gerrit-PatchSet: 23
Gerrit-Owner: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Thu, 29 Oct 2026 17:22:24 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: Yes

--PNsjq4cOqcw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Arne Schwabe=2E</p><p>Patc=
h set 23:<span style=3D"border-radius: 3px; display: inline-block; margin: =
0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p=
><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3Demail">Vi=
ew Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/1858?tab=3Dcomments&amp;usp=3Demail">Patch Set #23:</a> </p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Unfor=
tunately the new code in the latest iteration of the patch introduced a sma=
ll regression=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>=
File src/openvpn/manage=2Ec:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858/comment/07e=
5a071_d89dd7a4?usp=3Demail">Patch Set #23, Line 4468:</a> <code style=3D"fo=
nt-family:monospace,monospace">    while ((flag =3D strsep(&amp;encoding, &=
quot;:&quot;)))</code></p><p class=3D"blocks" style=3D"white-space: pre-wra=
p; word-wrap: break-word;">The new else-branch now rejects `A`=2E We should=
 probably accept only one of `A` or `6`=2E</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1858?usp=3De=
mail">change 1858</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setti=
ngs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActi=
on"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1858?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: I4a6a6ef41e15896b8b79d795b2a6de86b8ae4c84 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1858 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2E=
net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Comment-Date: Thu, 29 Oct 2026 17:22:24 +00=
00 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div =
style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--PNsjq4cOqcw=--


--===============5136652831337592078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5136652831337592078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5136652831337592078==--

