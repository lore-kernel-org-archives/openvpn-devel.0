Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3AD1C4452D
	for <openvpn-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XVd4ounLScf1kBQgQ2K/G0xbrBlbseODD4midHjXgQc=; b=avOPOs3WzDUSUOSkAC3tlbX3UY
	2ADN3YYZZW/Tj+hOMW1eKfntOG78QXjrJ38pYuF2Sr4f3I8zrhSrOda7LVTfImLg1ICr6+Twnsdxh
	TAwlR7mMYO/2tAIcJJC6F/3R9M1d8IAeeBwuYMCVprawzEX3/fzZVHwT7+EOuNAKV1a4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wmJNp-0007UR-To;
	Tue, 21 Jul 2026 22:56:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wmJNY-0007Tt-CP
 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:56:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=fLdwQGLli6pdCMBtI4ZyYqUpkF6ED14NOhjxLdI9efY=; b=IzfJk64AJZePkatUhWb8afJWhk
 F6o4jttyyyJIRkJdAs3y3U8+/RuTTR4a69WsyB2+20vIKJMQZG4284Z/53E2T5BFxsk0T+iNxk1l+
 b6frowAEZ8bHLXgZmkDqLH+KX4QlRtsYFzffA2PQwrsNSnfL9mUysoj1F7jBiw05TXlY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fLdwQGLli6pdCMBtI4ZyYqUpkF6ED14NOhjxLdI9efY=; b=V
 QTFRbT+iAkxg51JwcY1v/fQsQGn+rSY4GrCh3No1T+vHGAhp4Cj9FZuvz9GbegLPi7VU6sSsvUESQ
 DoWAke2BWHaStrnryVy+tELZ5cpHUbdjfRPdQxjx0PSSVaDuNbpgcFvgSXwJS0qYhL3heZN71Tnlj
 N9qg8+d27HIDr/7A=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wmJNL-0004RO-P8 for openvpn-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:55:49 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4954a32cf1eso19940635e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 21 Jul 2026 15:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784674541; x=1785279341; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fLdwQGLli6pdCMBtI4ZyYqUpkF6ED14NOhjxLdI9efY=;
 b=Eiz3XxP6sxlpVuS80Irt3a9w8mbsVqwb4HYLCDv8m1pahd+VaZyxp2q9RtCeNQDb8z
 oUT55+V4fdhwBq3lzjEj8PIF1hVXG+4xP2SZWYTT/5tSgh3ZMt+VYlJoPSYXMMjRxzpg
 bY2wLsyupOj6BCTK8xYPq+oe9aL7XinRxTfnx47NP/p5hsc9rs/J4UTG2eFuj5Y6wLE0
 Vq9gZlMY3da1K/CpBnO5QA4lx8B3iuhtu0/AQiqt7uRlcmcNgbf9X7Z3Bl7OBj8W1aDP
 sX3Fcew1kejZSDnCAmknMGsIaCqmaR2Uy9wIVbofbBwKUa4NOApNczIH7EBrdY8pFy4b
 3jpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784674541; x=1785279341;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=fLdwQGLli6pdCMBtI4ZyYqUpkF6ED14NOhjxLdI9efY=;
 b=CZB1rXhSjKUS07IpdyshuMjvOxzvP3ryBTAmVIqcUZ9CNM65x2VpzutXxLk25YHVHm
 J2URqGHvcoaRN6/rfs9tBPK5uSicNVEeJA9kKJ3+L/0JAYw49ZZ92AftTp9d1iSCsugw
 deaOktzOsjUEVxx8uvCoopJ6mXyfryinRN0y7wBqh1ad3HUdmxutXzOqztVE7KMc55Ti
 sqsVSd8vXtlcywYRyuC9VvWtkWtigqAdIEt5UL/XCht7jDx4KOXR8pUBkaaGIe5+MkkT
 69pTeTshwKD7ZN0MYu4OGMqYNBrsJLQcu9z9tKsILk4yJplYp0sVG4PoSNXxq9VBqKJG
 wiWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrGmXSylmP2Vi4nrC6N85km6/Pdu0rLMIIcj+NeYxFRMSKku+M8SA0UhM/yiVmv0KjgE5E4DPNFz0+Ylz2Q@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy4z8nbCcBQvSpebPF4IWxqqXTyvCuxxvcYnke5lYDHs10ojz5b
 DYFel1FU+aBBixFWSt89hrOmyEKAMmxsWRiRTfOIk2UFhSjNm1g7TN22ZcEwV4hYTr5vqZW/VGd
 rTXVGB6NqcoVV0xyyWZ7bVysQhEplWqN+E7zkUd76EewG0ZySN4t6+Tr5Kh87FGUI9ElQ
X-Gm-Gg: AfdE7ckdsAkgKZ3HvpKSMTq/pL/EvASRZR5E5yZtaoB58681/zkEN7JXpMbhPHetHbG
 B/uGMGBEpaWkxvnKi98YImd0r8R6Fb4C5fiJRgnhV5PoXvG8TvnHpLMTn8dAClnRQcjrJbuy9s8
 2o56nDyUWzeOGLxatiwZ1nHOthbLzTItiodwr+JlVIRhLhTxjNUk+MFIVbBSWr50oXrYXAcBdMJ
 M7wgU2AaAeGmlzvD8ykiZNrQPZIs8Xhp/7FvSjTmXfW4Bkjtw5cIGDiWThqsibwfgux+1evTwYS
 rJhGu2PzbBv+FNzJ+6aRLHoAz3Pne9Js09kdaGriZpE0JDlED0iBCTAPtcgPg3Z8IWkhdiQw6er
 xquZF4Qlr8f+6775XErgcUGKGMQwQAOueA9bn1hm+aMD3/ThfJzqoTK5AKEw5y+zZTx2L1698b0
 bKGoCRMRrNw7ZZzS+oPRieS7e+gycL838hCL1GoeeD6aKsTcz0bXDgGIFSP4ZNE0I21QSO3MAMq
 mdBrSamRT+HrDerArtnnXfQCmonaAT4JIUJTuYd+YUZutS8evhhYHcHyHhEDC6fURAG
X-Received: by 2002:a05:600c:6c98:b0:493:f6c1:2f09 with SMTP id
 5b1f17b1804b1-4954a3d2fcdmr164912505e9.6.1784674541003; 
 Tue, 21 Jul 2026 15:55:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a508aa6sm25443905e9.7.2026.07.21.15.55.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 15:55:40 -0700 (PDT)
X-Google-Original-From: "ordex (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 21 Jul 2026 22:55:38 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 5738669616b166a39c7b91d031672c8e7fabb5c8
X-Gerrit-Comment-Date: Tue, 21 Jul 2026 22:55:38 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b3cafca95fab023d4cb0f8833f43f3ed2af2d90a-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wmJNL-0004RO-P8
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
From: "ordex \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, gert@greenie.muc.de
Cc: "ordex \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2280073780578577048=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2280073780578577048==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XXudukEYORo="; charset=UTF-8

--XXudukEYORo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, plais=
thos=2E

ordex has posted comments on this change by its_Giaan=2E ( http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail )

Change subject: mult=
ipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E


Patch Set 19:

(2 comments)

File src/openvpn/ssl=
=2Ec:

http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/ff85c098_36cb=
0bb2?usp=3Demail :
PS19, Line 1200:             multi->rx_peer_id =3D ((uin=
t32_t)peerid[0] << 16)
what happens if this turns to be MAX_PEER_ID (0xFFFF=
FF)? Could this be problematic?


File src/openvpn/ssl_util=2Ec:

http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/9284a278_d1666f37?usp=3Demail=
 :
PS19, Line 78:     const char *optstr =3D peer_info ? strstr(peer_info, =
"ID=3D") : NULL;
could the strstr() also match substrings like "UV_ID=3D=2E=
=2E=2E" or "GUID=3D=2E=2E=2E"?



-- 
To view, visit http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number:=
 1089
Gerrit-PatchSet: 19
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Eco=
m>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-CC: ordex <antonio@mandelbit=2Ecom>
Gerrit-Attention: plaist=
hos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <gianmarco@man=
delbit=2Ecom>
Gerrit-Attention: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Atte=
ntion: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Tue, 21 =
Jul 2026 22:55:38 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--XXudukEYORo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, its_Giaan, plaisthos=2E </p>
<p>=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View=
 Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl=2Ec:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1089/comment/ff85c098_36cb0bb2?usp=3Demail">Patch Set=
 #19, Line 1200:</a> <code style=3D"font-family:monospace,monospace">      =
      multi-&gt;rx_peer_id =3D ((uint32_t)peerid[0] &lt;&lt; 16)</code></p>=
<p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;"=
>what happens if this turns to be MAX_PEER_ID (0xFFFFFF)? Could this be pro=
blematic?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sr=
c/openvpn/ssl_util=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089/comment/9284a278_=
d1666f37?usp=3Demail">Patch Set #19, Line 78:</a> <code style=3D"font-famil=
y:monospace,monospace">    const char *optstr =3D peer_info ? strstr(peer_i=
nfo, &quot;ID=3D&quot;) : NULL;</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">could the strstr() also match su=
bstrings like &quot;UV_ID=3D=2E=2E=2E&quot; or &quot;GUID=3D=2E=2E=2E&quot;=
?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1089?usp=3Demail">change 1089</a>=2E To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ger=
rit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project=
: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
=
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 108=
9 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=
=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@green=
ie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ord=
ex &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert=
@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Attentio=
n: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Comment-Date: Tue, 21 Jul 2026 22:55:38 +0000 </div>
<div s=
tyle=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display=
:none"> Gerrit-Has-Labels: No </div>

</body></html>
--XXudukEYORo=--


--===============2280073780578577048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2280073780578577048==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2280073780578577048==--

