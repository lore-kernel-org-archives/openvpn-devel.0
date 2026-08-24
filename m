Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F11C5DF94
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5CcUZ1YlZnSKgJSsxlO2XL7HYXJ6/VQjU18fPbjeIMo=; b=hfLIUWc6n66Oo5BXBLy5yE0mfG
	l+pQB4XhDkk62vpN3PFrwajYWLayH/CZMsquomkRW1+7LlC3Dr4ASetxVfB2s2URErjre3hvuekx5
	3AQ6UD23SAtaxowVcM5hdnqvdg6ptXDBjjWWwX2q2d7SrZwQCCKChs3PBRqXjLZnno+k=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wySn7-0001VK-RP;
	Mon, 24 Aug 2026 11:24:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wySn6-0001V7-SN
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:24:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=nkQIAZ8fXs8xkO/ROBMq2Xb5gRMADEozUIekJzAFg14=; b=CN1qjmNpxyI1xDCFkeK2zK7kvj
 3nj5L03Cp8t/cRvQ4b3YNxcP7sSAXaPKXwWfbDSCHYqnI0KxOyDhGJ+q57sTTSKlVwHunCILvPsLl
 YEJA31CQcgEK+ibShvnJLgU5Gcjs/bCNp52uvA42MCVGzDJ1oHu0i9VB8KciwjkqMt5c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nkQIAZ8fXs8xkO/ROBMq2Xb5gRMADEozUIekJzAFg14=; b=i
 duUj4G/mTlsSlBgzZsmt0dqsWt4ytGFONrozCkXqGK9w1wnRQ2Xk4RIeJRSpDt6KY7D000v6a1V93
 hkLrfy7ENXenxZmG7+FV9UaQBObBC/h7jvb3JiAgm+GMGqBVnRHpLAGcIDsPpkjK9hd/2+TPu4MsM
 /M76rmuOxtaxC8iw=;
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wySn5-00072M-QY for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 11:24:37 +0000
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c2022323c37so517912066b.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 04:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787570669; x=1788175469; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=nkQIAZ8fXs8xkO/ROBMq2Xb5gRMADEozUIekJzAFg14=;
 b=Y3/tQ1iX0MnWSN1Buiq9UCZO6Qg6Wvmzi2/yTSODCjHJUXO7de42oxE8OqE8AN9BeC
 X7k5giFWjAJnApuf9ydr344rfyin7VL5m94wbNgVvrAR7kCLI4jZq9SDcEo/yRvm8yKL
 gLVS/3D3MNUT5SpclgHil6hGRG3p5PmnJMrNN2lxX8Q4eCnlpIKN8DiIVyjSIKhF9+6a
 XAORr9b6azglTbakh954qlaf4FcSr6qRvEPBiqEiO2v4pK/oVuCh2S/hBHJM4LvBPmrV
 2Dh1USmh8nea9gSU+TdJjHFHciyvnOn/NBHP0nRFS0bgiaSm+SwIds0j8291ouRb7uE8
 BqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787570669; x=1788175469;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=nkQIAZ8fXs8xkO/ROBMq2Xb5gRMADEozUIekJzAFg14=;
 b=N1u3T5yjU6qeavPajrQaouxfrcHC2CCPkd5IZ9MTJtn+Cc6t6L+sfpZJzRBPxYYByn
 GFgCqCgZ3tBbU/CDChE3be0abgOJgsssFlCrKpZBd3agQF8UvokhhYW2omfTLtzt7xGO
 XU8gOOD2zLkqXl7u6DtKsj7lAPznD65XX+7g9VnR1ui6/d3ZmIcYUpOVj+zrKJMO8Z7i
 YfOowbDwlAWQWBuVFerFFfjV/lniyxbpDay8q11OEbYiEIIxXPBej/M2bOg36FjkHTRy
 FPx9qMo7oMXeDN74AETIG/xoZt5ihrHyDvUlPwwkRLQMTM1btfXeZ+yru7TTHyjvm5ne
 x6MA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roy9YwtySOx6/GJM+0JYSqI9h3TqcUe+IlsMUujtHDnE4ywPzLm8s8K/aUWmM+nrwfVgFBRSYHsRJFVrwRt@lists.sourceforge.net
X-Gm-Message-State: AFuF++l0rh5BzHSotBqVYE4QnSR5Pbqt1DslfvsvvQTabqf+OhlsptoL
 EVyvELv0mnEhEd0NNH5UNshzWc3HNKyphyGyrRT5wSv4SBHq8HdUmqTO3ORvLEp+psp9vz5M266
 1AJ2c0KJ3Tce7KBDhe/SaJEVmu/tFgvyNwLJBbrIFr6ErbyiEZ4ZI/tofPMTQSiwOmsdK
X-Gm-Gg: AR+sD12Q0Hc6jEjWzyCpV5GDuzcmwns017okZozFxXsPNXO9ygKoFcOJhzlMD32R1Vs
 IzKLBCxCq4mntsIbvp/1BhtdLZReT1iHBtEBGNr5g7YK7trtbpCmFQBT0RMJF2NLv45zQQZJYip
 kS+rxbGRe1nMDXomymdIdtOfQdXX6X6kTO8IfJJQH7dxr01eKc0mWijxbrxrYJ6wnN04a8OZyug
 4uJGsaTWfQKm/jGPLOxrSmgmAjlq1a6TmyuuqsmrCHFjtsl61JbrDXXuFn3XrwAJGX3pjWZHmmL
 5sNZwZ5M4TKoXe7vZNq/7SoiJ92WlBGLW0TB6kqNld0yczj8Q04gvfFwP0Zn1Ga4sOw29TxTTlc
 N+Qx8j6p6YDkqQDgYg3vgmfH2Tg5OsMeNQ8xgrhnTvY4r67ZHSZO9jVWuJD4ak2UHT6OvxbfH17
 vtrBUoWFNZiCADP7TrxjSXVl/7Eru1JsfLwOK/BEwB1/DyHF5agpIds5NOto4QzGFZk2HJMD7vl
 cGg7EMARkpnaMpVbcxvfJnVLlyXHYYOdgBBWTLIX/NbhGHgxQPkWpbcNS0SXPvQmmGMsMwlXAc4
 3ILT0m9jyfbfhCVDLP4yAZNDWl1UOj+jq7FpZOPTsGUdOoKUX9U18MzocsTx3tE=
X-Received: by 2002:a17:907:e90:b0:c20:33db:41d3 with SMTP id
 a640c23a62f3a-c246a5f45aamr3212110566b.11.1787570669027; 
 Mon, 24 Aug 2026 04:24:29 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f64e0sm1488454266b.32.2026.08.24.04.24.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 04:24:28 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 11:24:25 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 15
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: 580974871f6664ce68e8f5e0034a27970063d7bf
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 11:24:25 +0000
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bb11e282eb06ffbf3c10ab0104263dceb9f8e3cf-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wySn5-00072M-QY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 unused functions
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7094884608338469934=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7094884608338469934==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="btzpEarKkMQ="; charset=UTF-8

--btzpEarKkMQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc, stipa=2E

flichte=
nheld has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail )

Change subject: Remove var=
ious unused functions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 15:

(2 comments)

Patchset:

PS14: 
> LGTM=2E But be=
fore I +2, are we sure that [=E2=80=A6]
I have started to move functions th=
at I think can clearly be removed to their own patches to avoid having disc=
ussions about all of them in this single change=2E


File src/openvpn/plugi=
n=2Eh:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610/comment/dab46727_e9d=
20d97?usp=3Demail :
PS14, Line 138: 
> This change now leaves two blank lin=
es=2E
Done



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1610?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tp://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comme=
nt
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82a4e82=
ff876fab715e052de1903c65b835360b5
Gerrit-Change-Number: 1610
Gerrit-PatchSe=
t: 15
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer:=
 plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@g=
mail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>
Gerrit-CC: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: razvanc <razvanc@mailbox=2Eo=
rg>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-Date: Mo=
n, 24 Aug 2026 11:24:25 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No=

Comment-In-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--btzpEarKkMQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc, stipa=2E </p>
<p><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><=
p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bo=
ttom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?tab=
=3Dcomments&amp;usp=3Demail">Patch Set #14:</a> </p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">LGTM=2E But=
 before I +2, are we sure that [=E2=80=A6]</blockquote></p><p class=3D"bloc=
ks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I have started =
to move functions that I think can clearly be removed to their own patches =
to avoid having discussions about all of them in this single change=2E</p><=
/li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/plug=
in=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin:=
 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610/comment/dab46727_e9d20d97?usp=3De=
mail">Patch Set #14, Line 138:</a> <code style=3D"font-family:monospace,mon=
ospace"></code></p><p><blockquote style=3D"border-left: 1px solid #aaa; mar=
gin: 10px 0; padding: 0 10px;">This change now leaves two blank lines=2E</b=
lockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">change 1610</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"=
display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:non=
e"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bran=
ch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I82a4e82ff=
876fab715e052de1903c65b835360b5 </div>
<div style=3D"display:none"> Gerrit-=
Change-Number: 1610 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15=
 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: razvanc &lt=
;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Atten=
tion: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@gmail=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Au=
g 2026 11:24:25 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComment=
s: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<di=
v style=3D"display:none"> Comment-In-Reply-To: razvanc &lt;razvanc@mailbox=
=2Eorg&gt; </div>

</body></html>
--btzpEarKkMQ=--


--===============7094884608338469934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7094884608338469934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7094884608338469934==--

