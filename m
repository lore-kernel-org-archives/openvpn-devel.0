Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE75C5CFEB
	for <openvpn-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:59:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DCVvs/wtIHhp5MsIpSSVVHqhbkpTA3WXoL8JxtXy1r4=; b=Smlc+k4oS9eWBDCOT0A0myA2KO
	3KP1CpMo1rHg3ofR8w9WWGRKG9hsd51e+AK2bF68dhvQnfK+uTbqg/TfswluELKPMX64yBcRMoEYX
	TGmBBu1ldduBVzm/ziQkwwDCThWCbwfE/1k0OjLuQjOK6BVkgqjwHcNYBhE6/Z2XbewE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wuV1V-0002mU-7G;
	Thu, 13 Aug 2026 12:59:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wuV1P-0002lP-EX
 for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 12:59:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=sc218jjok48j+e+nZUNNn0Sz1A3itctAOCKqxHkSpv8=; b=Bkz2++A421gU5uOhycCgd3+oPl
 jX2glCyKqXjP6Sa+W2IZOdt9luBFoaCEW98XPllvGMTofsA80yBPLen2bba5bXpQAtuIvE0N0Stg3
 bhnSk7Zp0YnkgfaMb4sheRoEJZc2eROdqDowV7hSsbplUEk1egnQx5W0H1DEeu5ZALq0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sc218jjok48j+e+nZUNNn0Sz1A3itctAOCKqxHkSpv8=; b=g
 q4DY/O33xdsETrXRAtkPe2yz3Ikzr1XFgfhluXRT6BkTHIyX963HXOkJpNN6UA0SqGR5dUvL3ov1A
 SkDMxiHE/oeR3e1fpUwCeid6KOhl1x2wwxfkXtkik9ZmGaCW+xFMokDKSYjsBg3t/3yGuKqx10LsO
 MDZqAoukLUr5vwRI=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuV1P-0006TJ-IG for openvpn-devel@lists.sourceforge.net;
 Thu, 13 Aug 2026 12:59:00 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-47fd66a094eso804146f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 13 Aug 2026 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786625933; x=1787230733; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=sc218jjok48j+e+nZUNNn0Sz1A3itctAOCKqxHkSpv8=;
 b=JVVp4Gj+OST0Rzm0oJleiCkc8Ykk9XZ4pbUeh+zPtIrEvJw24vsodVkMy71ySxjSrT
 pbeKVn/vtcvISQnrTKLQraxpK16ajB4qf6pNueHfSZ3cWhPm2AgGgTEGye+g1cchnBLQ
 p/CyzFzMxTSiUsjdeVcCu1kjkvvswrVHCT4Qjn+8GFV3U5hb7JaZbb8pMjHqhfSMO3vS
 SWCbZW0QOboGwM9lfNBOQ1vySmkYhc7zHEUTl2LNpbUUQ/9O6OZKmeyMrZZq/CMLRYnB
 R1B9Amk46MGCxGVt6ae7CQ8MtELlEyXrVleIy2u6YmAr81v2PHWBplfnxpf8lCAD3d1O
 /2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786625933; x=1787230733;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=sc218jjok48j+e+nZUNNn0Sz1A3itctAOCKqxHkSpv8=;
 b=ZlcACOYyqLEG2FmGADwxpsEiaRwm2+Gny7kuyAhMVrp9kd3zFeDDgeL3MtXG1fvnTg
 Tm/HMVNt5HI+VwreW4jvLWyFsC+0g0FJQSpLfOTAijrNkzX0Ejzs7UhW0LsphP5kahht
 SqeOfBS6HKUfUeXdTH2bZRkNaxmYtZ+qNysObVD9RvMCFvuFt2dq2MdS0WR9xUD4Cvn9
 kzhMQFZOHWLvpeCl1+cCXZ/80FF+LeaEVzZd99d1XYZK6pCMJzzJxWRrjFQi6/jM2rAi
 VDru8Ch1Fb09M671o3Qx/z8HRA7uB/rqe/4tvpz68rPtLVhiaE6rCme7xscNbTIvgQv1
 /2DQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHcw51cgLP727H7XnwtJNFFFoYmbFvGeus1pDJZdjN8MJHwXyEkFOzt0QG8VKgOEDfijZmipxKYMtak8EO@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwHRvdjK99WNP2CPj/4N84Hd2YC0C8gWkvPQA9S3ZmLs6bbbt7E
 7dGJuKaSagYYoBAlrwNET4ccRx4weNXjMWQTKhoReJohLVxKbOpQPcjFIaND3wmzwzeEuEmL6eh
 wmDxeAqOnFZHS7JBtMQm9ZpLfUBlD++CJRHwXdTe8w7Ooq57tPNK/1juLD4/XiBezmNOqIc8ja0
 adwAhHDQ==
X-Gm-Gg: AR+sD12G0CGcUF+ZP/cjzUDdOfkM+Cke+2Dm6t6S/2DhMZnXmYcI/YyOROB7Bun7Dx4
 hM1sHE3vmWN/DkcorCA9Y+HHiAjCIBa4xPCS95c7Qjr0Ll06ETWW0m5dQmWmAl3Tz1VyGcprFxl
 +UAHuWDBBchuDCLWVNLEYp+xjp/DocgjbJPY5dGv33uIkoHdcE4yu2yzTmJAysd9wgtKEhht5fi
 8olM0PPO5G7PkQ+qzvL5rsCUUDR83pZRr7GCqvnfsT4PLOQGJcCxYvtvTWidugK3qXssgLR3vJG
 j6jJE9fEnPm9rtpOtwPRoFwQiDsR2mfbsacchU0aT0TpPI6BxUJaypWjwTtE/ufnMnQVug7mOrp
 1ER/PbVY+W+hyFsGsvssRWc58zDCy8+i/+z1huUQEULNUFMXREZOw+won6RAFn/fOz6C3JDIUc1
 sTZFQlHXzJypYAGz8e5J1UPSH7TtU5nmjsr4Aqgz5BJmqXtjSk9lf6AtHV4m2fI6EpRmw+R4BA4
 cJ3izRPZ35mf8eOqtBsoMRpRRkmCYR/Bu8dkHGMmiRQ/lKLe1q7QDBGtphq8g+ytHFC4FT5ROq5
 if1UYe81AAop9E5DpEPSDsIdQMupN0OCL3MY9UkwN2skfiiL9dbqoSEY7gVi7A==
X-Received: by 2002:adf:fd4f:0:b0:47f:86d5:d1d7 with SMTP id
 ffacd0b85a97d-48159c912c8mr7698915f8f.6.1786625932804; 
 Thu, 13 Aug 2026 05:58:52 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815a5612b8sm5234077f8f.1.2026.08.13.05.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 05:58:52 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 13 Aug 2026 12:58:49 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
X-Gerrit-Change-Number: 1617
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1617?usp=email>
X-Gerrit-Commit: 5f440cfa6725af843e25a622588fc010486667a4
X-Gerrit-Comment-Date: Thu, 13 Aug 2026 12:58:49 +0000
In-Reply-To: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
References: <gerrit.1775421558000.Id0caa497c4ff1ad8743cb23f332f003b2d3393ed@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc1NDIxNTU4MDAwLklkMGNhYTQ5N2M0ZmYxYWQ4NzQzY2IyM2YzMzJmMDAzYjJkMzM5M2VkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <783f36aafc384045a1cc0bf6e1b2a1b2d08dea70-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wuV1P-0006TJ-IG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 useless assignments
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6896769330061406117=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6896769330061406117==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vRb1MAIdBS4="; charset=UTF-8

--vRb1MAIdBS4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

stipa has=
 posted comments on this change by flichtenheld=2E ( http://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1617?usp=3Demail )

Change subject: Remove various usel=
ess assignments
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E


Patch Set 11:

(1 comment)

File src/openvpn/console_builtin=2Ec:

ht=
tp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617/comment/ed7d4c69_3b98ea0a?usp=
=3Demail :
PS11, Line 203:     msg(M_FATAL, "Sorry, but I can't get console=
 input on this OS (%s)", prompt);
this loses return=2E M_FATAL means exit, =
but won't we get a compiler warning on the platforms which are not WIN32 an=
d don't have termios? The fix would be moving "return red" in the end of fu=
nction above #endif=2E



-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1617?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messag=
eType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-=
Id: Id0caa497c4ff1ad8743cb23f332f003b2d3393ed
Gerrit-Change-Number: 1617
Ge=
rrit-PatchSet: 11
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerr=
it-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-deve=
l <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC: stipa <lstipakov@gma=
il=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-A=
ttention: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Thu, =
13 Aug 2026 12:58:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--vRb1MAIdBS4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p><a href=3D"http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">View Change</a></p><p>=
1 comment:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/console_builtin=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1617/comment/ed7d4c69_3b98ea0a?usp=3Demail">Patch Set #1=
1, Line 203:</a> <code style=3D"font-family:monospace,monospace">    msg(M_=
FATAL, &quot;Sorry, but I can&#39;t get console input on this OS (%s)&quot;=
, prompt);</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">this loses return=2E M_FATAL means exit, but won&#39;=
t we get a compiler warning on the platforms which are not WIN32 and don&#3=
9;t have termios? The fix would be moving &quot;return red&quot; in the end=
 of function above #endif=2E</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3Demail">change 16=
17</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p>=
<div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1617?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div =
style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"di=
splay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ge=
rrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I=
d0caa497c4ff1ad8743cb23f332f003b2d3393ed </div>
<div style=3D"display:none"=
> Gerrit-Change-Number: 1617 </div>
<div style=3D"display:none"> Gerrit-Pat=
chSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipa=
kov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: p=
laisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 13 Aug 2026 12:58:49=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<=
div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>
--vRb1MAIdBS4=--


--===============6896769330061406117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6896769330061406117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6896769330061406117==--

