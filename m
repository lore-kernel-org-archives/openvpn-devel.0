Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BEEC2A09B
	for <openvpn-devel@archiver.kernel.org>; Fri,  7 Aug 2026 15:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uiIRpxB03MlF12BbxVicKesyKQJIxA3wTfWY0rxQiV0=; b=MQstfRmJDxfRfa0RCjUSfJcfDH
	KBqQ/vdITK5iNTQSVrXis5u87zIoYrzv9g1IMd71qLcBomRQU4lCWoAJLfppN3WunoKUC4rq/Zz0i
	KL7FJcNaqrp64so/0bVSlG/lgFpZsb46CAcW1erR4VMK68MhpXpoKp8mV2nFY+OrHprM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsMnt-0000tk-U1;
	Fri, 07 Aug 2026 15:48:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsMns-0000tX-LN
 for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:48:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Il8Q/I9EL2Y+bKIjQQgFosXqUaDOH3Dyml/uQtblpRE=; b=j45HvXKDnF59lGtfZYRASSqj93
 BWDGM2w4MJN6u6N9yzE7R6gSeHS0d4ESGG2QsX8Rm+7DLmlH6ir5AcaUYd2ZCePozYqRo3Fw5IzoS
 oVbw86EHDMUsTzkcmmTL8pS/WHSRaLKb9Pf6XPQayqJ6PkCl6StF/5NuN8RZmrf06mg4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Il8Q/I9EL2Y+bKIjQQgFosXqUaDOH3Dyml/uQtblpRE=; b=b
 imBYHZFNarEQG16E1UiPTTnicD7tx5TSbVyz4rHTqhSuc+An0xgsZj6dIc3NTI1+fSgoxddVkKnyB
 oW+OlYz9zONybe/aFlt3qsFLvdKY0WaOK4rZAnRwzvWfrJlkJ50EuyF4cgON+PMff+zI7a4ZZvu9a
 h+OknQ2EdHO2S0XE=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsMnv-0005CM-JT for openvpn-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 15:48:13 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49954b88fffso19086195e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 07 Aug 2026 08:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786117685; x=1786722485; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Il8Q/I9EL2Y+bKIjQQgFosXqUaDOH3Dyml/uQtblpRE=;
 b=D1HOmRGiveMcjh0L7iJgUzYcF4J3sizkkjeQSGiaErNU9gLt+lmUCNDHe/sfjkO78n
 YB8ByuTAbFMAOjE00n8oQsJ/gU76D6O+rTFPdQpf50/tdoqFP3o5eYZ6E7v2Pv6Z3fm1
 LWIYQhNkZdVcrgdAt9aOKfwmNHZL8F6PnPhIxSQ69RqwtHfEGpycv1ij2bFNDs9PKLG6
 L+ri5E15/sdwzTJeMRqEAOdQBcE8LVbw7I6GLf4040Va+RSRBMa80QNwZGTBVD2+LGR9
 liUejuEHVuamegFl5cSEu5dC/vqlzcO7Uw6aZ2xtIx1VpqxG+6QdF4+6dY92O9Lld6CH
 npVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786117685; x=1786722485;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Il8Q/I9EL2Y+bKIjQQgFosXqUaDOH3Dyml/uQtblpRE=;
 b=Ad5AVrI+eFN65QBcIqs3T0ELkVBdJ1Raf6SZyfxit2jQRXqSzOZ25pZER6HNFCCqpc
 hYBapj2utYidDidFylwOajdDdta3MGMEs0u+q4y8u9btezEsNDrShm30P7pynXxwNufy
 I7AT8tMVSC1/mKI6yDqHNF4M7D9ovoUZRnNO+F8J93MS3JBBtok4Lrc35ROdcRjqtQi1
 N/FnEU0Y3Ymh68bQ4Nl9FkbwpkriI/zYVWTxOjg/23/Z+uAps/6stoqKp1Iz5omxu+18
 QR18L4lxblKjbNPZWkewW4TQsUsUrhcTIgpQSOADMHoNRPK053EBYKtJy38iTJbPJ7Ss
 gbZw==
X-Gm-Message-State: AOJu0Ywqr3Uqo8zDI2yxPcJHbAZW4eUWNw7zTyS9m6woeVD4C96POi00
 ZVe2eratQxOljFnJBTtanuuUITJKoarw3NKqTHEWceF324vY5c9UZx90RtCXAsOrjGPN4q2WQn3
 hXONFmPD5onj7cTd3zmVV2uS9S6xlqum19ozodEjsm23l1U4cW7qpfwWQJGDObfSxxdxVY39b20
 b78M59Zw==
X-Gm-Gg: AR+sD10t3Nh8Y9fy+5QHkuSflmX2tk4unIjW09IGfx5j1psNR/wfGwBihzYiG8gA3sA
 LRtL+Wo7lNaEuuFy6yqPis2R9UB8vn48biMyHUJAFHztic6HD2yIe2ADaVziNypUsP8qsa2il4j
 A8EgPC9M6x44wPaHHVYlPUl1ddK7x9CrgiXTVHbAe2x7pQnotGc5qRdLZ+33bWnEnEBD6RlFIYO
 hwfyhFEyxHBUEfkp2rm4xTNFiVVX7Z0IJT+hGvD6n4KgzQZJIYt3tUGGJENob8XxRvcUTMVD8p3
 aNszeAzNlKkUUjruCufacVkFW5T3tfcgxAsfj7XWDBg9k7gpScS4vA3ZbRksKST/UGx2RjLfg4o
 V8hllRH6S+hPJqCwVO2JVCudMkZYEp8Ag3o4xNEcn0g7zGZw4WMznVn36h2KGCqRm1CfcNJaLuT
 ISOe5fBzrLiW32qv/3/vTmpWsOXs7/wRT6HSVfeFtrKvPt2fRasdrX0sciDk9gDu4zNiFoIYqHh
 ZQQPpC9zNlal0zof2GxC4VlerDex5jB65+/Ur5BTZZYxJFbx+dvn6D+yPoEvxlf3wJQ515gUnJp
 Bd8+spaNhPkiOqUZW5mERhYTJimLmsc1n9wF6mgVg0d3BcGPk0MkucnspGkFenk=
X-Received: by 2002:a05:600c:3586:b0:494:6baa:ccef with SMTP id
 5b1f17b1804b1-499619833admr7533025e9.11.1786117685298; 
 Fri, 07 Aug 2026 08:48:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8c5asm7507454f8f.18.2026.08.07.08.48.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 08:48:04 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 7 Aug 2026 15:48:02 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
X-Gerrit-Change-Number: 1581
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1581?usp=email>
X-Gerrit-Commit: dae71a5a2922c4289364250840dd08d5b9d2b086
X-Gerrit-Comment-Date: Fri, 7 Aug 2026 15:48:02 +0000
In-Reply-To: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
References: <gerrit.1773842036000.I350ca5b08379ede1480b81055d35dd9a33e30cff@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzczODQyMDM2MDAwLkkzNTBjYTViMDgzNzllZGUxNDgwYjgxMDU1ZDM1ZGQ5YTMzZTMwY2ZmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ef0f9ec5356d248cb45cae1a1d655be8a87fc999-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsMnv-0005CM-JT
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: doc: add Doxygen
 documentation to buffer.h
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
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1629000151743229889=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1629000151743229889==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HJr7sIIeIjM="; charset=UTF-8

--HJr7sIIeIjM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld=2E

plaisthos has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1581?usp=3Demail )

Change subject: doc: add Doxygen documenta=
tion to buffer=2Eh
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E


Patch Set 3: Code-Review+2


-- 
To view, visit http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1581?usp=3Demail
To unsubscribe, or for help writin=
g mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

G=
errit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Ge=
rrit-Change-Id: I350ca5b08379ede1480b81055d35dd9a33e30cff
Gerrit-Change-Num=
ber: 1581
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@lichtenheld=
=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Fri, 07 Aug 2026=
 15:48:02 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--HJr7sIIeIjM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld=2E </p>
<p>Patch set 3:<span style=3D"bo=
rder-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;backgr=
ound-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail">View Change</a></p><ul style=
=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail">change 1581</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope=
 itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1581?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I350ca5b08379ed=
e1480b81055d35dd9a33e30cff </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 1581 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div=
>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichten=
held=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisth=
os &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Fri, 07 Aug 2026 15:48:02 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--HJr7sIIeIjM=--


--===============1629000151743229889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1629000151743229889==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1629000151743229889==--

