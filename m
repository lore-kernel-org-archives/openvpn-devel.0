Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF842C61DD9
	for <openvpn-devel@archiver.kernel.org>; Sun, 30 Aug 2026 18:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zYUFmcdA//rhlrtnhOOuByMciNPQqqPc2jbt4NCq0GI=; b=MnohMPfJDykDA6CoXi9ZYQJbWT
	REOnipLtxDcN9EjB9H4RrGou/+NapIT7ArMoRO8MvAKljO4f5PeMZYtBW75xjTm+LsAE1rxajzUoB
	k2dW/sQ+PJHGii+6rq+5UDc10b65IexZt/5Ri627/oLKBBFdnHvN9cojSDzVbMALStWs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x0k5H-0006IL-Lv;
	Sun, 30 Aug 2026 18:16:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x0k5F-0006ID-Uo
 for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 18:16:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=geebPRNWY1ioqHixTWH+IaiAZtzBLnB2l5QyWhsWVHQ=; b=JMuyNuDNQ+7yw0ZDK8VAh1mmEz
 ThAd+sENstQm/xv3SJ8qTTTyBsvpUie4M9G6WfEqsXzysgmeTu039C67gl6XB8oeZYqnIaACHNo+4
 cjJNjxj9o6FcOp4Nc5acwtuDVK9H/C31LNx+I5pHJqm4kzhBXDnTlij1/ot2z0PDcCg0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=geebPRNWY1ioqHixTWH+IaiAZtzBLnB2l5QyWhsWVHQ=; b=H
 gYu13jmZ6M1rsuXcJ+QHYh8mWdf2nfx5PoGZXtAbIB2tnGFxeqlGKV5jfpa795cLcZlA0/AVcyMP4
 jEkgtD/w54BfexbMMiU6kz3pu8vOlPaZ/3C1Q31iA6ZoPds3+aJBFIQWUwqh8WPfBw+I5uXYWcP4c
 ACnf1M+l72YVSoh4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x0k5F-0002fX-8a for openvpn-devel@lists.sourceforge.net;
 Sun, 30 Aug 2026 18:16:45 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso18473425e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 30 Aug 2026 11:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788113799; x=1788718599; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=geebPRNWY1ioqHixTWH+IaiAZtzBLnB2l5QyWhsWVHQ=;
 b=DGIcSuN2uqcbzlSfkZ16i4L+GQszzy+fGKQYEBok3haSbIH6z8+t7NIl27PlizSIAh
 wPNqTRFUO05ImMkAQFDFUDl1hYjZ4HIallXYBiu+G2nXJPTGOSf+sravhQW8YKeRuo5O
 1WPZpNQeFiRfs+2Uy9CN0xeKajL571fdQQcdflsV8gth8Tngaqjrnd5M56q+zbmREVaU
 MuD/shfpSRRLWKkVObSWZv8gpSxVpGIXTypzCfzP8v3sEuItlDoSc1b4Hs4rq7omCojS
 MbMhL3nbXncP0fp/Cba/TqO4/TVRdYjeW+KiUpo7n9iiYQ2/ut/G38Yl3PuI9/WUt8/Y
 h6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788113799; x=1788718599;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=geebPRNWY1ioqHixTWH+IaiAZtzBLnB2l5QyWhsWVHQ=;
 b=XXbCOVN4tuUEeHSDh+R4I62QFngXcwZvtQDILCysg19ZRKgp+PA2TJDFlKdY77Zlt5
 6j9/q99dx+IKgVgDzzfVHJIQBUxi/93a4dIhK+kQ2F1AgYnB5/cPSovMOoD0F1oiHbUT
 a3hkPhV8jHrzWlfKVWwnqwIdX7Y27AwnDpcS2avAqiOMzMM6ieQbmWPqQovCLLl0PJka
 CvS2ahoThVsA4yl+6zKM2JFT0w/romwseoSR56ZRvSqJlmUMahjPaSwMa3mjiASbZaXI
 /hIbvQo4JQk7G0tg9soXJA+oXGDNU6B9/Ggsyfbqstd/vc/9PcHTCYD7UCF0tU7VIAdl
 v2rg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqb6AG0KVpQ7ZXMP/fPxoDaCXgklh6mAI8BZrjZNbE7n2eR0weor52cunKrSnFqFYpql3U4Ihh8i2pKuSel@lists.sourceforge.net
X-Gm-Message-State: AFuF++mmfXWVQ0auGJ1HTArhIYczQaWwzN3HEWBVJFnD5DRwY3y82QVn
 0OvAmZY23zt1qmondsjQ/29aQMCQ0GCwYvOnVAbSrQAFXynebUK8FRw0d3tXxYA6QzRv7up8O3o
 EDvQnllpGnDQqwOVSphuE6k1FD3zMyZl+tPBo8Z3z9N58eo6UaZy5ZA5rOyIq2XyL6sHK
X-Gm-Gg: AR+sD126BDUo5qLF+NZDziVAGPLludP9roX2NHnxME2EU3yBe7LQs64zRxXJtcjUbCA
 D3YbxnCwdaZGz0GDI70Qg/HA0/C7xzkwFBOKKEIAtBdMZmTVNSX7J6WNcf8WjzVYBhHX0YviLs6
 RU64OmL1+MA0M8wKaTrGakhO7d1aJaNycYwOVTaW6cy6gUrw/yg3BEzp5BfCsDyh7G3/2B4MVZL
 SoX5Vr1FmJ8ll/9VUABdEn7V0vPJ3Cs2IGHTO9zl5kBi82bo+rpYMjITD0ypu8ucvBQvWrsHej1
 5FoL18sk6qrt0FU5f7mjhRCVp0Io1MJ7S7ynCA7k4Xc4z+2GkkEQc2rOrOfMlZKlkuaRT0p/kwT
 64wxMrq4GnHXZgZRTxDXd/3hqZXn+RII203ZUXUR7BFVk6spgnX4Tr33rkX79JLgR4xnX3R2a2O
 DqzcTWX9JI7rZAQKE9VzVcbbuq954Hz34QFJtRnMT+47Cz7wjvu8XE8617wa2w4/MEHh/2MSLIA
 ngdsBEx/DgogJdYXRH84v1avI3MhM83W4H8U3tSzC63CwCTt3p2hW/RR8VgwxtKafMOSed/2FGD
 glF4ORD85uHhl7o9PTMCNa9N+zXpeuHcUte4VJY49MCisLyv2OY=
X-Received: by 2002:a05:600c:3f0c:b0:49c:cedf:f870 with SMTP id
 5b1f17b1804b1-49ccedff89amr145621415e9.16.1788113798591; 
 Sun, 30 Aug 2026 11:16:38 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cd33074e3sm57162185e9.3.2026.08.30.11.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 11:16:38 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 30 Aug 2026 18:16:37 +0000
To: d12fk <heiko@openvpn.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a
X-Gerrit-Change-Number: 1883
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1883?usp=email>
X-Gerrit-Commit: 5df16c3a170e08f59f94b7c36b73d5c84883148f
X-Gerrit-Comment-Date: Sun, 30 Aug 2026 18:16:37 +0000
In-Reply-To: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
References: <gerrit.1788113537000.Ica5d43989b441d4377a3908f811a2953b7a9d45a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg4MTEzNTM3MDAwLkljYTVkNDM5ODliNDQxZDQzNzdhMzkwOGY4MTFhMjk1M2I3YTlkNDVhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <781f1bbd91aba902d1ea768eb114ae05aeda4c63-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x0k5F-0002fX-8a
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: openvpnserv:
 detect sibling dirs in CheckConfigPath
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5036484643533952845=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5036484643533952845==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dfmuHmzouj0="; charset=UTF-8

--dfmuHmzouj0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos=2E

razvanc h=
as posted comments on this change by cron2=2E ( http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1883?usp=3Demail )

Change subject: openvpnserv: detect sibl=
ing dirs in CheckConfigPath
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 1: Code-Review+2


-- 
To view, visit http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail
To unsubscribe, or for he=
lp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: release/2=2E6
Gerrit-Change-Id: Ica5d43989b441d4377a3908f811a2953b7a9d45a=

Gerrit-Change-Number: 1883
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@gr=
eenie=2Emuc=2Ede>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Revie=
wer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razva=
nc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefor=
ge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-A=
ttention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Attention: d12fk <heiko@op=
envpn=2Enet>
Gerrit-Comment-Date: Sun, 30 Aug 2026 18:16:37 +0000
Gerrit-Ha=
sComments: No
Gerrit-Has-Labels: Yes

--dfmuHmzouj0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, d12fk, plaisthos=2E </p>
<p>Patch set 1:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail">change 1883=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1883?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: release/2=2E6 </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: Ica5d43989b441d4377a3908f811a2953b7a9d45a </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 1883 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;ger=
t@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@greenie=2Emuc=2Ede&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@open=
vpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun,=
 30 Aug 2026 18:16:37 +0000 </div>
<div style=3D"display:none"> Gerrit-HasC=
omments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </di=
v>

</body></html>
--dfmuHmzouj0=--


--===============5036484643533952845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5036484643533952845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5036484643533952845==--

