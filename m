Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57AF9C79FA1
	for <openvpn-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uIXDqjdBcS3Bj2G6wOHXrQQNokw6xxQCPRfLfH4M8pg=; b=Qz6BTHyoRR7KSku4Ifhxq24DxB
	s1+Mw+VcEXxRqC8z6pgX9YsL1vilxhNxVUxWEzY42H2/4+cmyJWbM7LF5rSa43d8sxk4pzmoUhydD
	dXk7Pd0p4iIcpYypE2NzJEfLFpKeyyU4cckbhQHZa1uSZTgCodvHuwk9AeumSY6w7NiA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x3bDV-0001C3-DL;
	Mon, 07 Sep 2026 15:25:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x3bDU-0001Bu-3x
 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 15:25:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=FXcPH6KIvOK7825tAw2feqsgD4TZUJyKKwHkSQnEZD0=; b=Et42zH4Qw/N7rBDFyAsn18dk7A
 u7+FOChjFjJtk3qFUa9fjPFtO0jwNzVoh3YCnB8hJMBD1inY2SxpH0ydgpirdkz3zl70EI5QgtoWc
 vGxcn+cOphEF4NtZ3M4TtV79pU06mGY16N4Iiq1pZgnSBwytWcYV7qtkUJQOTwgBZKr4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FXcPH6KIvOK7825tAw2feqsgD4TZUJyKKwHkSQnEZD0=; b=W
 Wy9NqNoo5sKMttQu1dVskj1QU3ZrjfO4G+fMoY3uz/8jIhouqyb9acYl2KeUUvEhuKu0uoFpUA2n1
 OWwVBwdjCQ0hwd5i+3WufMsvRY0jncWwn7LtLPU+RHMuVDFWrb1tZg9x6I5ASUxHFR22HfNKwQjhT
 DutKNqm6C9mCGeRo=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3bDS-0004xV-V2 for openvpn-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 15:25:04 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49d0726ccc2so14138015e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1788794696; x=1789399496; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FXcPH6KIvOK7825tAw2feqsgD4TZUJyKKwHkSQnEZD0=;
 b=Bg/tiaRvwutqWBZ8szHj6ZAdHrlzKpU+CTBL2sq0tQSiZ/cKnalhPRaV1RITQclHPs
 +yNzKxOhAloCHBGJjtbcrH9W5DPXWPoDolPTgQhDw2qjtVKYyUpbBNsPRk0smBqfT1yx
 BqSdojOs9P0IBdS9Y6tl2RUKhDRSqMtr3uidyAnmV2bXGAAise53RhIwSjs/vYQK6haR
 kWdkRt91tv4DCmemha6tCug1g/4Lbm4AOMvJAXfi445RljYhGAy9exWfaHBo+yyS5FAI
 xn7oKNB2WufnDTYbT8fpt2VGXbCJFLy78gLkN/j8ajB6L1MOg7Lx5M5akBScKGm3hji1
 yWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788794696; x=1789399496;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FXcPH6KIvOK7825tAw2feqsgD4TZUJyKKwHkSQnEZD0=;
 b=W27UM7am0nCauoe+qy2pWnduvjfnijHiPERIPjkZdAOHyf4Pfe/faeXMIfUWGLqaEz
 ccGga3TA01bZ3GAsvgpMZeupIk2IVahR8RdBJFpmdRr/PrLWJ6x+RYJMnerjyNPZVdb0
 C6Hx6WtqAMNMgGwKkjQ/H+l2r9OmL7wapVOHB4Yu6eim1pDRS1KIIx2UqkXLzemNm0VZ
 tajCDJXwF1X9dAXeuVqQ6uvnacWJD4aj94W9Qt//YN7pbuNWjctln00rHDGsoIOEun/X
 jhKBbEvvHgj811HWTkozlNf+EPLDNQnVkrWEW4dHGLOWIdd4aCCVjT0fBviRuBKQSnfC
 8UYQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzvshwnhRAToD1JB2XJTqfn9EIPfgF4i5q1AmrofuB70FpwqjS7D8dJL8B9Gohn28WgOyJ5TCWcBagXaOba@lists.sourceforge.net
X-Gm-Message-State: AFuF++nPCebbbgnKkwfYBtDfLJzpP3PBy7eBtFB7svcM9w5wEPo8ViCl
 ezJfyFmyu3EYCZK7xXuEy+fLd5XeAOJoVbkIHAwtIcRRMFEpCvLDHUGoP9uEG7agt+wq6v9/XtM
 wKzY973eP2Tf9RwzjgRXmJhVkK0MokWzZSWgBs7AYOPM6rPM9hUuQDa21G+9apPAfs72H
X-Gm-Gg: AYBFou25zBm2T5QLPqX+Fq34vawOajE2GY+5mR4Ccx1Ab9zoTuHehTHcbNYnKuWraur
 fX8hsHXxi44P5rGjSe4aepQosUpdP/oZDTlzYUbPqgNUAXbIOGK0nCyZuLAXwcRPwYrXBL7Ll5s
 UsfRtlEvtZOLr6G4KyImvqGp2QPzpdDpJyRw1pWSceP31XEs59TlZqJmQSY6l749MHinKXY+Kr7
 LZ7jrWa34ZwC+Pt+y7HVjX51llvggqa5AZywJ5xp2/TIdgSnCq8rwa4pJwKV4yj6pocJour/TJ9
 +gT0rrIs2S2sr8KIIrZ7QBECMkq8K4hZfkfon3AknHw51yx6wS+UslFE+WM8g2L/q41WE7RryAY
 YJqULZNsHJrchG/r7TM4P8uoMRiwrr9RUfX90dhHEss4FBN/Mi1zIloouYCn8PQfuAX4/nWllEM
 w+W3ebTBdKUJJp3whQK5mDblcjyltDeK/T7ZJ8g+FEDK4ZyyJe3/JxgZURFlYobj6UtU0ZzWOVN
 qJam8/tp9oYCAa9RztlKcYV/OH5uB43QtykKL3E8SFB1fPliSdLPO/Xaezns0996aqS62SMPgFX
 X0KYjHliV+3gnsDfVn7Yfb+pMD2ofWOENkTUb+k51lBV295H9JE=
X-Received: by 2002:a05:600c:6290:b0:499:8174:9f39 with SMTP id
 5b1f17b1804b1-49cf7f3d239mr511898235e9.0.1788794696246; 
 Mon, 07 Sep 2026 08:24:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cffdb2c40sm187742785e9.1.2026.09.07.08.24.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:24:55 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 7 Sep 2026 15:24:54 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I65beb37a2d822333aa888de1baf11dfcb8490e90
X-Gerrit-Change-Number: 1868
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1868?usp=email>
X-Gerrit-Commit: dc8cc058476b674a71a87f51f25ced18221aaf09
X-Gerrit-Comment-Date: Mon, 7 Sep 2026 15:24:54 +0000
In-Reply-To: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
References: <gerrit.1787672720000.I65beb37a2d822333aa888de1baf11dfcb8490e90@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg3NjcyNzIwMDAwLkk2NWJlYjM3YTJkODIyMzMzYWE4ODhkZTFiYWYxMWRmY2I4NDkwZTkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3e163c5d75e706537379281bd3c1ddce22279fe3-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x3bDS-0004xV-V2
Subject: [Openvpn-devel] [S] Change in openvpn[master]: run-cppcheck.sh:
 Make it more configurable
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
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5621151877407482387=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5621151877407482387==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dp3qKk1mTj4="; charset=UTF-8

--Dp3qKk1mTj4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, razvanc=2E

flichtenheld h=
as posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1868?usp=3Demail )

Change subject: run-cppcheck=2Esh=
: Make it more configurable
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E


Patch Set 2:

(1 comment)

Commit Message:

http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1868/comment/d997661c_9cdd0828?usp=3Demail :
P=
S1, Line 10:   adjust to the verbosity of the Make run
> Maybe a misread of=
 the intent, but if we want the verbosity of the make run (as in, the way =
=2E [=E2=80=A6]
I didn't actually consider the interaction with =2E/configu=
re=2E I mainly wanted `make cppcheck V=3D1` to be verbose (same as it is fo=
r normal targets)=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1868?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageT=
ype: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I65beb37a2d822333aa888de1baf11dfcb8490e90
Gerrit-Change-Number: 1868
Gerr=
it-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-=
Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: razvanc <razvanc@mailbo=
x=2Eorg>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-At=
tention: razvanc <razvanc@mailbox=2Eorg>
Gerrit-Comment-Date: Mon, 07 Sep 2=
026 15:24:54 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In=
-Reply-To: razvanc <razvanc@mailbox=2Eorg>

--Dp3qKk1mTj4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, razvanc=2E </p>
<p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail">View Change</a></p><p>1 com=
ment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>Commit Message:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868/comment=
/d997661c_9cdd0828?usp=3Demail">Patch Set #1, Line 10:</a> <code style=3D"f=
ont-family:monospace,monospace">  adjust to the verbosity of the Make run</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">Maybe a misread of the intent, but if we want the verb=
osity of the make run (as in, the way =2E [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I di=
dn&#39;t actually consider the interaction with =2E/configure=2E I mainly w=
anted `make cppcheck V=3D1` to be verbose (same as it is for normal targets=
)=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1868?usp=3Demail">change 1868</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/1868?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I65beb37a2d822333aa888de1ba=
f11dfcb8490e90 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 18=
68 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: op=
envpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-CC: razvanc &lt;razvanc@mailbox=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ra=
zvanc &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Mon, 07 Sep 2026 15:24:54 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerr=
it-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: =
razvanc &lt;razvanc@mailbox=2Eorg&gt; </div>

</body></html>
--Dp3qKk1mTj4=--


--===============5621151877407482387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5621151877407482387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5621151877407482387==--

