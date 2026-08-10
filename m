Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1A0C5AC82
	for <openvpn-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yJNut0UGDBDipZOCgfABeeosKNTlrnE9Ngm8Sn4yBes=; b=frNovX3U6Wk5R84sAHW4QL1nBZ
	Tc6HGHA0rM1oIg82DX0e8pdZQiosuza8phjC22cbJPGYOLr3EolJTL6Vs9R/5vbh4H308Kmiqwn/a
	wvZ8t8givufsUytjlh69FaeIOy28v4yIoEepRIyQ7Kzz6gtvqwBuA4dsSvw6BGiNUP3A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wtOjw-0008IT-HA;
	Mon, 10 Aug 2026 12:04:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wtOju-0008IM-EB
 for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:04:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=syrzkwAadX4w5bvn4BkWOXfAeQLGvwNUhBUov6Hzbgo=; b=QWbLVWMxBk4so0D9c+lelvDgim
 XGMBIvGvBqUrN7sEFTTrth0A+JW2QVVIZ6v/3ejn1FQRtjlzbheHLDdtCXCKnae+Yk4tkOPwQYi55
 AJOc6q71Rb5IdbOIi8yzwk4uFnpls9uPZbABEB/zP2HcGwEYg/oWAi/IGwI14KfXeWck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=syrzkwAadX4w5bvn4BkWOXfAeQLGvwNUhBUov6Hzbgo=; b=E
 L/logbPVw0S1pB7ru3Z0m4OaWl/J2QixDeSJUx5tHYL4wtP/6Bc66Zckw2DGzp3XbFDBFoINDB0g/
 socAQ4yhCv4puuJ6vm8eTEWw9YEGlgKfmZ6HjsuZqgNEY/PC+Wr29LToCugdU9FoDAjYwWULZLv2E
 NGBCwjj6CInaFyWA=;
Received: from mail-wm1-f42.google.com ([209.85.128.42])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtOju-0001VK-On for openvpn-devel@lists.sourceforge.net;
 Mon, 10 Aug 2026 12:04:23 +0000
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so16703335e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 10 Aug 2026 05:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786363453; x=1786968253; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=syrzkwAadX4w5bvn4BkWOXfAeQLGvwNUhBUov6Hzbgo=;
 b=LS2nUbeH6KTcktzwuSgRtTNm9NsLxBllqNrLeddSuzgZNpBo3EfXSPJgRZ7cjjfNI2
 03RKT8Tw5oBiuL1Vi3S1w9oiZ252pZe5AIXNBkAebiy9eSFF+l9bbck00MTo4mAN4UnY
 x7Yycpfji9kJRWEKkX+YaHC3bs2o7qlZ9sBw2ummWY0LKQrGAGNudR1fEu+VsyFVQ9zo
 igqAwRFr1GiGPWxNFqJv4uSM3kiYtgrhS6sL2skH2ZWixABj6SB4tOMCzM7Yr83rS4Qz
 R9KPbmYXzLMQywgilsQ00mkzYvD/LfodWLAzngQnKLurG8OEfDPscwC8rXCd3IKdWFx7
 HpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786363453; x=1786968253;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=syrzkwAadX4w5bvn4BkWOXfAeQLGvwNUhBUov6Hzbgo=;
 b=aEIJZ9w7vUeCPVQdqSWHLlnhBAHNCA20vt4bJffcfl4FmJBAV1N0kJ7a6BnHOds4XI
 G8MK/8aBFoXqb3wyNP0q8B9CN29/2ANwgrbkMhXbIoUf9iR/cPjS318riiaYjaec67C0
 lmKwOtLTWci8/7PHz7xjhQ85YGQuQaf9u+B6IGMTpmXTClvOfHoL0mhmfOFjNfsTYrkJ
 HhE1flo+bcrbmKh513M0q0L0CLWISVmm4VRJJmhsSK7AWqXwMiT087hDlLk+Xk89iOFN
 XZQUCKB5X7MCFd9Br37RvIWJGlKaxoshd7CDj6N5yCt/OXie4fDZrfursBU63X7q+2wo
 WKbQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+iZxciCPATR5o3WKlAib7bvsSkReViQOwrY+QQMFn/H26C1vPGNx5qDuGh5oca/MW4w6cIaeei1OFbVbb@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwXekGMvCnVMQlS3Pilltoar0x6B2UPzdm5ybPQRBUEmJ2aLz8j
 YNiCAdviY9+qhsK6pP7+PJQ/u5SK+bz7pLGIhKhGDaTC83Bj37fciHHaLPIaveHyexNX3xiBRF9
 rXfbLBPT64tyT78Lbhf4/ptnYavfSIn8sqITImo24m3ASQktg3qddNR/lcTJu7GlCG8c+
X-Gm-Gg: AR+sD135z6AEaA3G2NsYJzZiVkht8mLyCmgXI+GDaXdp+Dg+qkLQU7JRnNVSFVlIrqw
 PJ78xESEvoJdIFeNVxmFHUoxxtt86+s6Uv2SsMmgsGrftNhhDl20K0avYRzTUgBqcUdoN5/lgeV
 tR0OmOQKr48u4Ifggr+myRrHG/sLzPMJ7+9QohMkPRlqQKbC53kJFljwqqQ99ol3acSc4nP3goB
 HtCc8cFrIq18ReCHHyhmSIfxUSJ9jTblLgG4W9zDe8ZYXbnBx2AX6zSIRKpIyu6g91Rq0a1tHKN
 4TT61QUrMwaX63buGrJA4c36GpfkohznnKfvY6Y05CA4Rj0HjkVrkF2UMaO4rvO4M3wdQ8yu4Yi
 +I3NTh0h2X7TZ3rxDrf5dHvcYR9N1Q5NjXzeJnDqWZSQleY9G2fkH59AKqA2ZJ+ZlwO3ab1XSR7
 xw4JrIBnLPrTMfcZt80RmoCJYW8zqpfLUw94DE8kVoyXHgH5yvn4ojhrZCuaPHNA5oupxIFoBWM
 P/kI31U//uPP4ZF2FK9fOxDXOenK97Z90Jp5fh2uv54eJM6o0O9IAmYpRoq3CUbReQq670XsBqo
 5n3j3dRln5A1XCfd2wYejOx9f+6Q/VOnWHuUlWhIaaoBM7sCrq4I
X-Received: by 2002:a7b:cc0b:0:b0:496:cb48:5eb8 with SMTP id
 5b1f17b1804b1-49959e38ecamr299317705e9.15.1786363451393; 
 Mon, 10 Aug 2026 05:04:11 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021f9182sm35052822f8f.28.2026.08.10.05.04.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:04:09 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 10 Aug 2026 12:04:06 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I82a4e82ff876fab715e052de1903c65b835360b5
X-Gerrit-Change-Number: 1610
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1610?usp=email>
X-Gerrit-Commit: e6fd07d842db523bf0b0aeb8952b6b190dbf8188
X-Gerrit-Comment-Date: Mon, 10 Aug 2026 12:04:06 +0000
In-Reply-To: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
References: <gerrit.1775343746000.I82a4e82ff876fab715e052de1903c65b835360b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1MzQzNzQ2MDAwLkk4MmE0ZTgyZmY4NzZmYWI3MTVlMDUyZGUxOTAzYzY1YjgzNTM2MGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bf206d8001628d576ee2dd26d58b65be4a3f82c6-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wtOju-0001VK-On
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove various
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
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6617808140983693595=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6617808140983693595==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SVTMNIwbQwk="; charset=UTF-8

--SVTMNIwbQwk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

flichtenheld has posted=
 comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1610?usp=3Demail )

Change subject: Remove various unused func=
tions
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch =
Set 12:

(1 comment)

File src/openvpn/buffer=2Eh:

http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1610/comment/24f5b44d_2a60a31f?usp=3Demail :
PS12, Line =
818: {
> I understand that this might not be used but feels a bit weird to =
remove it nonetheless=2E
Yeah, there are some examples in here where we rem=
ove parts of an API that are not currently used but make sense to make the =
API complete and consistent=2E I don't have a strong opinion here=2E When y=
ou make a list of all removals that you think are dubious I could split the=
 patch=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
610?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
p://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I82a4e82f=
f876fab715e052de1903c65b835360b5
Gerrit-Change-Number: 1610
Gerrit-PatchSet=
: 12
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: =
plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-de=
vel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rf=
c2549=2Eorg>
Gerrit-Comment-Date: Mon, 10 Aug 2026 12:04:06 +0000
Gerrit-Ha=
sComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-o=
penvpn@rfc2549=2Eorg>

--SVTMNIwbQwk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p><a href=3D"http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1610?usp=3Demail">View Change</a></p><p>1 comment:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/buffer=2Eh:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610/com=
ment/24f5b44d_2a60a31f?usp=3Demail">Patch Set #12, Line 818:</a> <code styl=
e=3D"font-family:monospace,monospace">{</code></p><p><blockquote style=3D"b=
order-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I understand =
that this might not be used but feels a bit weird to remove it nonetheless=
=2E</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">Yeah, there are some examples in here where we remove =
parts of an API that are not currently used but make sense to make the API =
complete and consistent=2E I don&#39;t have a strong opinion here=2E When y=
ou make a list of all removals that you think are dubious I could split the=
 patch=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail">change 1610</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1610?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I82a4e82ff876fab715e05=
2de1903c65b835360b5 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1610 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: M=
on, 10 Aug 2026 12:04:06 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No <=
/div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-=
openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--SVTMNIwbQwk=--


--===============6617808140983693595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6617808140983693595==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6617808140983693595==--

