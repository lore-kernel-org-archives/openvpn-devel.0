Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6441C55174
	for <openvpn-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kjWdZ1ggfShyMiDd3KoBb2XBfonQayg2h8h4WVnsy4=; b=k3VlXYy6dFCwczz2DdjhjeQUrp
	pR1lF1rFc9WjtEGWKdW9urnWj1l0YFYeBzdzO7iZ5VkvoYrrjgsEmhOaU4tMpFeW3H+eVnt7SAVrF
	nmvb31d37C13ewQKkC5PGzf1SFoqwHF80c++yEnm3OWy9kgxcjtN+jGpKRCyZLwDhNxo=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wre6t-0003XP-FO;
	Wed, 05 Aug 2026 16:04:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wre6r-0003XI-Og
 for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 16:04:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=KgE1y8ZQPJlvXtZEZbtmgN5j/jv6el1w8fHqV2uHdQI=; b=OiCRDvJwxpAu0alZMX9MLSTb9x
 K1VnAzwU4Nuf8OAi9w4TxXH7/NkbcSrMgiQbHXyy/Sjhv/+wRQ8V10WkQIf0xZCKgvBWAtsy9RZRJ
 3915ebNSI4u0WjNiIMlieQBw8FZM3G+BTIE5qhtjZENR0wX0xrQmRKgPp35DPzOqpeUA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KgE1y8ZQPJlvXtZEZbtmgN5j/jv6el1w8fHqV2uHdQI=; b=i
 3XxCd4Ho7P0Lij8oXlLktbeDmZ2as48M4iSQHqC4C8YVJkPXvCcjBIYHkEKgCcgPDP5I1rIJLJfKQ
 W8j8T9NtY5brB3Zr5y6FuBRN6QDwY8mK/GMOcuvSVHNKG48e+g2pMADp3g4pNaQ48crPtS4Tqrx22
 juJ0AAdIXqS1Kp1E=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wre6u-0003rS-JX for openvpn-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 16:04:50 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so11353405e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 05 Aug 2026 09:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1785945882; x=1786550682; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KgE1y8ZQPJlvXtZEZbtmgN5j/jv6el1w8fHqV2uHdQI=;
 b=FRad/igN2sZ1xCtA41q5yA5pOm3XILZgqKZu8bLw08c1IYrnCqtzesvgDE1gtTZDMG
 exg3DIPT+UywHoCEYxbKO/6KT5v7F+bfrnqzkLBilS6xkjfXPXPhcqBI0Sq3Gnw149p9
 9Ze+g3kN4eL4voV+H2JhnUmJhx0iYpUTWBUrN0q0tMv5o8fSvLdqH0WXbP90sDeVKo4G
 RBLTYUpzKIALjSflQvmIYkiYTENZSVoti1M8UPak6sbeU/ZHkLGpJm5w3BAuYJCD4SKy
 ETsduvg2tJNS5eOJ7y75UxX04SCQtyn6OSQU7B4puB+yStKwFzpXAKJEaaRHEMAZ01HW
 ULdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785945882; x=1786550682;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=KgE1y8ZQPJlvXtZEZbtmgN5j/jv6el1w8fHqV2uHdQI=;
 b=GFRfsXkogFyLK/vDGzxDqBzOACJh1UusHKArLn0vs+7Vi3Lw9yzUwz1ROI6XCBonWe
 AI5mdjCutki6NCii72/gOYZ2GM53al86foLcWlC24F9W/3acGM1Dgsr3RDZ2xHSkQBXP
 LEhoxVf6O1stDfLfVricNAdiSrpswitC/0LdpXfglgYo6WRuFBE59lai7FoYs8eR2ThI
 QTZ9ccu6n0HIaKdmpaz/t4khuRWv5h4ihWHv5rZTwfPSU0UJZRRIdNNG2OQ6b0IDZTl1
 AKYAtnQwntaxVEY9AKR/cSq3+i5wBM/LZ4TYLrG/EYWEsNbV6UVxnkA/O5Oae9R+0Fpp
 f/nA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+G4rYK11lGzNhUTj6ds8Pesay75JrTAi4kCOdSOagvN2KKUJiI34gb93HMxmPdNzLfaxJ722/WIgZ1rpx@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzyF6MsT0KqaFTf5gauIwm8t2IzioQ8cu8SU0O37aDvOlqWtAM4
 /VyC0nOdNBXgbemdS+ofIj3cd1cvZINo10CGN+MSzmBskYdxRnkGChBV6jlVIrMpoWPZnffTZx9
 3gaPpnPoofGoHbXH7fIyQcihIo/ifTzoO3cPN+xMhyRiiAa/AlVrH9e+BKbGs7IqsCV33YxsVrv
 q5woZ8Wg==
X-Gm-Gg: AR+sD10SaExvN/ayrJZcptf1Z/scU32yGvgpgC+XtLC1cTACZ92BULFjcunVO10P9Yq
 v+I401M/C2tQ6DiVATbhz8JipQhEo9MvjQguE40u+TZA8pFUe9I/WIWn8YP5HvyPqxJfmGWD4Zb
 VxqKP9Fj8Gyucobgoe4Vve7WO5BTgh4xu9x8t4sQLGEFQRkibi9k2kC4PJMubq5Cz3DYOob4lKQ
 9Nc21MTTMhWX2wbY0i/WkbFmZtSdG2L1VnTig/aoltUVVicnhzSshmGiexeu6F324wThDS+1rin
 GGPN89WI31mTMPIKSt2sDYSQK+cMqZhtDBWO0o08rkaqrCheuik/Hg1T6MrRtnPQ1OsnqyGAUK/
 IGMH23WqQhNNzF1COMWtyH/jmNX8rjVaf/Xj3O4Ey8Cxj8fehYLX28yvUdykKOk3sCug7FiPqyL
 EixyVvV+hUNX3cLIOGeiwQxWA64tnfMh2KP4I2ZW9GwJoZDob4XDHL0/UlmJFWyQU5IBbKCq3Yv
 Ug9lpdp9L9Zpt4cdJDZRhjX8W17DpNR9nfJklEngzhfWnZlv5LLobH7SQF+yjCPQqV2ZOXq8EIK
 wP6JcNwHknN1O28HQLj9bQnkP9rpLUiG8HMLxtj8Un0DUVPSl79NXqPg1C1+Hw==
X-Received: by 2002:a05:600c:4444:b0:493:a438:7f98 with SMTP id
 5b1f17b1804b1-4994e7d4057mr102639735e9.18.1785945882305; 
 Wed, 05 Aug 2026 09:04:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fcb46esm213971235e9.5.2026.08.05.09.04.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 09:04:41 -0700 (PDT)
X-Google-Original-From: "ralf_lici (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 5 Aug 2026 16:04:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
X-Gerrit-Change-Number: 1835
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1835?usp=email>
X-Gerrit-Commit: 673e321220a104f42914bd04adb1968a7b2d9112
X-Gerrit-Comment-Date: Wed, 5 Aug 2026 16:04:40 +0000
In-Reply-To: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
References: <gerrit.1785893242000.I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg1ODkzMjQyMDAwLkk1NjRlZGM2ZTBjYzE3OWMyYjhiNWRkZWY1ZTgwODM4OTQ5ZmU5ZmNkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4c1b80e94921bc7d0b5912c0c4d2fe348a581a8b-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wre6u-0003rS-JX
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: do not exit the
 process when installing a DCO key fails
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
From: "ralf_lici \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: ralf@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 antonio@mandelbit.com
Cc: "ralf_lici \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7521938829209244980=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7521938829209244980==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IKjZcCevcO8="; charset=UTF-8

--IKjZcCevcO8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos=2E

ra=
lf_lici has posted comments on this change by ordex=2E ( http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1835?usp=3Demail )

Change subject: dco: do not exi=
t the process when installing a DCO key fails
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-Review+2

(1 comment)=


Patchset:

PS1: 
> I took inspiration from your suggestion, but I did not=
 go the full way as you described because that [=E2=80=A6]
Yes, v2 is indee=
d a better implementation of what I was suggesting!



-- 
To view, visit h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settin=
gs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd
=
Gerrit-Change-Number: 1835
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@=
mandelbit=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: flichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ger=
rit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Attention: ord=
ex <antonio@mandelbit=2Ecom>
Gerrit-Comment-Date: Wed, 05 Aug 2026 16:04:40=
 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: =
ordex <antonio@mandelbit=2Ecom>
Comment-In-Reply-To: ralf_lici <ralf@mandel=
bit=2Ecom>

--IKjZcCevcO8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, ordex, plaisthos=2E </p>
<p>Patch set 2=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3Demail">View Change=
</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: non=
e; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/18=
35?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I took=
 inspiration from your suggestion, but I did not go the full way as you des=
cribed because that [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Yes, v2 is indeed a bett=
er implementation of what I was suggesting!</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1835?usp=3De=
mail">change 1835</a>=2E To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settin=
gs</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1835?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I564edc6e0cc179c2b8b5ddef5e80838949fe9fcd </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 1835 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ord=
ex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;fran=
k@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Comment-Date: Wed, 05 Aug 2026 16:04:40 +0000 </div>
<div style=3D=
"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none">=
 Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Comment-In-Repl=
y-To: ordex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Comment-In-Reply-To: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>

</=
body></html>
--IKjZcCevcO8=--


--===============7521938829209244980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7521938829209244980==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7521938829209244980==--

