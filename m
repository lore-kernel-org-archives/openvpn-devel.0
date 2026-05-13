Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C7BCD4851
	for <openvpn-devel@archiver.kernel.org>; Wed, 13 May 2026 14:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	MIME-Version:Message-ID:References:In-Reply-To:To:Date:From:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/R5RWeY2RTtA8A0NvyanPd4JEAr02ujv1FcSH4M1FJQ=; b=EixXk+2PulfFu6AqDoEviPZwlz
	fU4Se6kErWA3035OOEUeWxS4cjRaATfAaUpNGyCdipdabmwLKzLACuMzPlzc68c4H28/s4JZr+HJM
	jqZcSmC/7aQKhs75DGCu/vZczbO6wdgvtUVZs+U6H4wa7/d8RAmE7MnLOwwRA8Se9ccg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wNAlE-0007dI-Dj;
	Wed, 13 May 2026 14:40:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wNAl1-0007d2-Lv
 for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 14:40:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=dHrBuaqqm05uu0tnaLpYaN/AU0VcB2oCHTywBFcFPbY=; b=jqt8JVQlpzzv91nmb4ZCryqrBi
 daZ8tof2vLPoBReiYbbeMy9jMzdn/V6/NL1YlEp2pn1VgyX7wETvKmUyhyVdN6H81cuZWYmZiq/BG
 XyY9LfPAMsfWSrc7FEYXlfwdrgeR09r1UBwNvwpc3GLvijdbS3f6dALb+UopJTng8sak=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dHrBuaqqm05uu0tnaLpYaN/AU0VcB2oCHTywBFcFPbY=; b=Y
 x8PbHTmpgJR0HdWjzHIQhKc9OvaDWCDoIS0KBIfABNmufNuCbVDI1t/QYU1FV8Jm7Lx0B/ijCoNYD
 T7A0efButn0FSQLoR61FYkT18qRl0+HUWEF2DNFYLMskuJ9MUi6cc5aUUyTG6HL+e7dHSgNRd1TmQ
 IkroyuEHowj0FAM0=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wNAl0-0004wo-1u for openvpn-devel@lists.sourceforge.net;
 Wed, 13 May 2026 14:40:20 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso3512308f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 13 May 2026 07:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1778683212; x=1779288012; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dHrBuaqqm05uu0tnaLpYaN/AU0VcB2oCHTywBFcFPbY=;
 b=GiUCQ31kr6NgCJ77boVJYUPA4v4Sbeqlk6LSXCjSm551paQ22T+yEojudk6z7LrzIZ
 NaEG7buqQEwoL6ZvxTXez6qnGLQQuxWMDNCw+aAO7QPiLJcb4OiEQKae2ozlaq0Z6Rtc
 Tczm8iUx0rXE99dKwdmzaff7ICGdM12nr9qgnQ60mqAmqn5Rb+ebXpO+85q+BMlNFXUn
 NojjdIi2s50Bie7qH7OeWuqNn/RqqQH2TkFDiPW9JWvooavmjXLjTaHIt03nqwrK8X3O
 VE5kilKE8Je7OheoOnV0lH7xTD9hy6i1DOH3m33EHFCgLEC6FTS8AQ+ZjzyIEkAmMw7/
 womw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778683212; x=1779288012;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dHrBuaqqm05uu0tnaLpYaN/AU0VcB2oCHTywBFcFPbY=;
 b=q1Mx7jzA8WBwXs1VRCdmgCrJWPtt34hhGmsGHcVYVsQEeOjs/qrcUloeS6Kqz7Fft8
 p/fBfjrYFWuz1Agy0C2XsjO70vVReC9KBuP7Udld48AJwKdoS4+GFhMdr9y1S4uLObp2
 0l6xQbAE3r6IJIsS/AbKxO5UEvCx4Cax4tKKbbtkbJQxdygo4k8Bpdrw8HknCmTxMmEt
 SbZtA0BFhWmdZ9W2feUsbEIbQ5U++dEqvqPxd4vlEX+4iEXvuXsdthDAlB9lrUclz9iB
 TdTgT3cBs90cTIYVJ6fa+JmurrOqXWaSfOjrsz4t3ZImhGYA9gU80ovZ3dL9XBIOmo8Q
 BTQA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ve3NQRwPRwLAvP+FIrf/OSOfnjdxSmoGwSz5z+zbSrWWd4ZQ5z72oqB7ipGk0On6TDX1TUHMB4pMYMBWK@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw5QGe2vWrpDq2HvznPN1woVDSEsf/YzWeRdP0aJFClkaqvZamo
 L9LExMeciPQXtkLKQXj++eMgdstI4w3h8rOnMTlAnrf1V4LVIQ8cTPBKs8TfisIsU294qin5XRg
 vrYcrVofvKcE6jlPaF3mywKNUF9P1xAw3sBDoUrlK/7nXR6izQ5620SRFxbQoDtX0uXQY
X-Gm-Gg: Acq92OEYFcZerxJMF/rU7YookaKod/gM3pVEBWufMDTs1bPoxCJbC1W2r6HF3Tx5s5g
 IDFtFAW9HP4Azomvzh24drIVtMmTYnA4Rn8wT9UTIVYGkF9c/AYtTHjLuYSSmuAe2pyurO2IYnm
 d7COhP5FLh9v682ogRaih8G3BFV9r6pfyp3lO4bzxEBVwacmmX5uGjHhWJoIh7rlC2DK961v9Zc
 fSoUbCZsaSgWzZOI6lcE2liHT7TO74pV9Mf5oz1psT1Wtz5nZNo9Kud/945K/61Vdk0wJxPVnl1
 nfAlH5idRpiX6xA9GFayQaUWq3HB/M3ecccqu62D0jvRnpStIkpniUhqvLRzDWbOFPqY7IBQ0aa
 E0mCQlVJKt+0XXZi1giqZQONGSAGuhcce6CQ3etj47+AFx2znNtHeyFC+9QlQcjbsVysha4aDpc
 /IYAsvQnqn9F5TZRGsPgc+7/NVLb34ZEp03sOIja3b0FpwyxAFrLskiddbqmzxHtGpId2gIH/8T
 rdEFSHDLjN6fyO1zTd7a23UWyRaiOUMoPxn0jGNxm3UnLcmQ9oehWns3kigNLlceH0TINo/IYpD
 C6lbXfmqNsarpg==
X-Received: by 2002:a05:600c:8705:b0:48e:7f1c:8776 with SMTP id
 5b1f17b1804b1-48fcea0d61emr52226805e9.25.1778683211647; 
 Wed, 13 May 2026 07:40:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fc8d68b14sm79486545e9.12.2026.05.13.07.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 07:40:11 -0700 (PDT)
From: "d12fk (Code Review)" <gerrit@openvpn.net>
X-Google-Original-From: "d12fk (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 13 May 2026 14:40:09 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I04e35928244e6ecda8c58285a812516662b50742
X-Gerrit-Change-Number: 1673
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1673?usp=email>
X-Gerrit-Commit: 6a9747b1346419b4ae6b14b9c262e98243e5105c
X-Gerrit-Comment-Date: Wed, 13 May 2026 14:40:09 +0000
In-Reply-To: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@gerrit.openvpn.net>
References: <gerrit.1778239616000.I04e35928244e6ecda8c58285a812516662b50742@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MjM5NjE2MDAwLkkwNGUzNTkyODI0NGU2ZWNkYThjNTgyODVhODEyNTE2NjYyYjUwNzQyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bacf5c50ab6672710830f03bc9c027e130f25c74-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wNAl0-0004wo-1u
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not use
 deprecated aliases on Windows
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
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2997025635028777641=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2997025635028777641==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PtOA4s4JNVU="; charset=UTF-8

--PtOA4s4JNVU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

d12fk has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1673?usp=3Demail )

Change subject: Do not use deprecat=
ed aliases on Windows
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E


Patch Set 2: Code-Review+2


-- 
To view, visit http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1673?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: mast=
er
Gerrit-Change-Id: I04e35928244e6ecda8c58285a812516662b50742
Gerrit-Chang=
e-Number: 1673
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: d12fk <heiko@openvpn=2Enet>
Gerrit-Reviewer: p=
laisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Comment-Date: Wed, 13 May 2026 14:40:09 +0000
Gerrit-HasComments: No
Gerri=
t-Has-Labels: Yes

--PtOA4s4JNVU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>Patch set 2:<span =
style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; padding:=
 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=3D"htt=
p://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673?usp=3Demail">View Change</a></p=
><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673?usp=3Demail">change 1673=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1673?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"displa=
y:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit=
-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I04e3=
5928244e6ecda8c58285a812516662b50742 </div>
<div style=3D"display:none"> Ge=
rrit-Change-Number: 1673 </div>
<div style=3D"display:none"> Gerrit-PatchSe=
t: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: d12fk &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esou=
rceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: pl=
aisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Wed, 13 May 2026 14:40:09 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<di=
v style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>
--PtOA4s4JNVU=--


--===============2997025635028777641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2997025635028777641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2997025635028777641==--

