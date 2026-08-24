Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94514C5DF9B
	for <openvpn-devel@archiver.kernel.org>; Mon, 24 Aug 2026 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=utarTMzNHxgeXTVLRoTq4uXYoG9w8T6ET7L1e3GOX1Q=; b=kwLw6ee1dY4Yutx6m8Mi0ZwxQa
	SeEl4FSySMwpKc4r7eFgfs6iOxmG7oFVM0aIOp0O545HEWzkheqneH6yLWQ98p5M9MqO1tNQHf5Kc
	qX/2mBcR1jTrChCZzBozXmhko0bS1WD1EmpaSRB0rdFRLwC/orcd1vvOiSRor4OL2nQ4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wyV1k-0004Jz-46;
	Mon, 24 Aug 2026 13:47:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wyV1T-0004IZ-GE
 for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:47:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=oHZGodj16uFq9lmqQOOFhZlleqO6Yd/yLSWEiHBQzOw=; b=TgCo4N//mJ7XkTHkGVdzUwBOdk
 ltz6r4O6fF4QXaK07F/rnTFg5xrH7YLUvyKuatMdI6zSV16YHnxtIlZfOgYBSC/G1IcZipwpND0kx
 pJu4Y+YQyx1wff4B4MBHNED/oed+Owm9jzeOY/rzHmi3RSGAS8Iv4hBzbns/m5UJRrg0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oHZGodj16uFq9lmqQOOFhZlleqO6Yd/yLSWEiHBQzOw=; b=Y
 wBEDTWaBFjDudo85oYNi0xYt2hI6KzqS3kf5XQNQt7Kqc+sw44L+zTYBEUmNtNA/NejuuO9f/Qh/i
 LC6/uyFFY5jyX7tj7ROiVFVD2049HPlw2N8IRMDK0Rg/RmDiA4q7Rencu5iM2LKlCvMdRE0aVLBN7
 L2atFNb7+TGTGfws=;
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyV1L-0000aG-VT for openvpn-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 13:47:29 +0000
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6a051904222so4251364a12.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 24 Aug 2026 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1787579241; x=1788184041; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=oHZGodj16uFq9lmqQOOFhZlleqO6Yd/yLSWEiHBQzOw=;
 b=PySQgiP/3PMAW6B6oTLnAmsXC41c72bfh1bipH0XurfmLfugzogzJ6P9qnWgPi4iy3
 UFFY5xfQU9Z5nBeV+7AllknIJJSJFNdN6pTeoZpWbWtXRngX5s6OkG8oCL/ZmcdtHjko
 z+/1058PBQ4DBhRV5vCz4bbdliizpQnVFQBdn3KZajJqYGbi58QMAwgCBVRvwiBH/Fri
 /lgceuZuQe9LuXrrPEhFZ/b49IsdeuR8v94llqZo8klzKoEQkXk8MYITL20svWIhbdlm
 5X0oMVOaBjmqXTzrEy7Kx0J45SzchByXzWa2+0ARb5lMYeAeB2qL83oCu71z15WAmO3M
 TOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787579241; x=1788184041;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=oHZGodj16uFq9lmqQOOFhZlleqO6Yd/yLSWEiHBQzOw=;
 b=gLqIyg1EcYF7ZeBwOcjOKiwAY1TZtDga0ePg+PbYuHzFm1vCDTh+fExLqUlHO1irK7
 s65Q4SZDZ2rdGk35b6Ydjf/XLcYDkz8ClCJN9Fau9DP9KQ4sdKvLzp4JVzwQIrTwSHmZ
 xbZBvmAF/6IB4lRyGINguDvJ0Yhx99kz4pPB8feXzsbw/xr67Y1wTuDtjWJhkuBk/cOV
 BqGPBjX8Sxj02cQF+ENtgFoI63bnzPr+dYK3es+ofOV6mGms+Nr214Fkbr4p0mXAEu7P
 ro5mKFDxVwp1Huo5zGU8X2qG49yq74joN28FIuIQZKJSDF2SbHQRkXah3TOVjKct7lbb
 BQUw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHjz90z92oPXrOW+jbWgA2wgwwA+hM1h+Xy3RoVujRO2VEBINBQN72m5jtgWZCQUWVLoWFB1HgjmwuxIVI@lists.sourceforge.net
X-Gm-Message-State: AFuF++l2+yxWmk+zkdV+C4P+oG5iFx1Qr4kR9d47F+0WSkLVTjp6ECc1
 s7j5jO0Ne30mEBUwa+7EWARH+qaNAL5t78vprB+2KvhoBf71LYfpZ7VvaotxObQ8ZIjlPcoBWEO
 80/auLirfjliJQmBGgck/VzyU8GGIXhlSfndNFTZzB4jS7sJcD+SeTjHdogWph69XlixH
X-Gm-Gg: AR+sD11Vimr1q5P7bvuD2RRjq8H84ZmxP5K7QMx51xuYwDqgHYWTf0qLyMDurAAtMZ5
 WBqVIhhIRPJ/DVsSxr2XavNhKvmxnCajGsXcGWYiCmE0LYE21rQYdRkRjfqa5ux/82sA/IObWMh
 3OkPyHbUUuDO++maDM8aAccrTid+GDqdegX6kjgX7+CGIUGMRxKB+w84oaqB/MnKRTzqO9tsa9C
 cZQ+CPA7lSkNZEfOqnnKWJdB6d9J6CCUjLjFe65bihRK8jeUnbJnBjuBPB6eZYRVVVBpNNQawQm
 jegomdE8Vn+h1Lsv8kMdbAmCSjk9DNvK8PfQN5TQCj/dEjz3bBruXkBxGd01Aa+Wa+mNkGCYIug
 PphtlXdq91yitGUNK5Dt/xxKZCWxmZYEV50pP3JIn7Naln5cPuMkPBJHVpcTDUeZ7lFbadpfB56
 RTLBz0lHrexEcwPqBwWif3PRnsLT/Kt66zX1wQhBN14VopqrfVm1GN+FTO+YebqJG+4wKB9B6++
 z0TJJgzsyNEepSyIfZd0dd2yubL9ohQuJ8p6FLpnSHrVqi9iyfRl+kfSuNeOLu28fpLCBWZKVGD
 vso0pOExqGpHvCi86asCQgJyP64cojwxZroCXGhMTK+at550HhE=
X-Received: by 2002:a05:6402:5d5:b0:6a1:c4f:3153 with SMTP id
 4fb4d7f45d1cf-6a42f13bea1mr33705264a12.2.1787579241331; 
 Mon, 24 Aug 2026 06:47:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e001305sm9435232a12.4.2026.08.24.06.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 06:47:20 -0700 (PDT)
X-Google-Original-From: "razvanc (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 24 Aug 2026 13:47:16 +0000
To: flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 14
X-Gerrit-Change-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f
X-Gerrit-Change-Number: 1661
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1661?usp=email>
X-Gerrit-Commit: 2e8ab4a160cd75b457dd12cf21fd6caa09367078
X-Gerrit-Comment-Date: Mon, 24 Aug 2026 13:47:16 +0000
In-Reply-To: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
References: <gerrit.1778013601000.I2b71dae37ebe63c26a66761f877b25d326ed140f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc4MDEzNjAxMDAwLkkyYjcxZGFlMzdlYmU2M2MyNmE2Njc2MWY4NzdiMjVkMzI2ZWQxNDBmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e6dfeee0ae4a5982c6766faf7ddaba6a191ed7aa-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wyV1L-0000aG-VT
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove instances of
 constVariable/constVariablePointer cppcheck warnings
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 lstipakov@gmail.com
Cc: "razvanc \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5072549850897004344=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============5072549850897004344==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="PMLwr/DDzpQ="; charset=UTF-8

--PMLwr/DDzpQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa=2E

ra=
zvanc has posted comments on this change by flichtenheld=2E ( http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail )

Change subject: Remove ins=
tances of constVariable/constVariablePointer cppcheck warnings
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 14: Code-Revie=
w+2


-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit http://ger=
rit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerri=
t-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2b71dae37ebe63c=
26a66761f877b25d326ed140f
Gerrit-Change-Number: 1661
Gerrit-PatchSet: 14
Ge=
rrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisth=
os <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: razvanc <razvanc@mailbox=
=2Eorg>
Gerrit-Reviewer: stipa <lstipakov@gmail=2Ecom>
Gerrit-CC: openvpn-d=
evel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2Ecom>
Gerrit-Comment-D=
ate: Mon, 24 Aug 2026 13:47:16 +0000
Gerrit-HasComments: No
Gerrit-Has-Labe=
ls: Yes

--PMLwr/DDzpQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa=2E </p>
<p>Patch set 1=
4:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; =
padding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a hre=
f=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=3Demail">cha=
nge 1661</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E=
</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1661?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<=
div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=
=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:non=
e"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change=
-Id: I2b71dae37ebe63c26a66761f877b25d326ed140f </div>
<div style=3D"display=
:none"> Gerrit-Change-Number: 1661 </div>
<div style=3D"display:none"> Gerr=
it-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenh=
eld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: razvanc &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@gm=
ail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@l=
ichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: =
stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-Comment-Date: Mon, 24 Aug 2026 13:47:16 +0000 </div>
<div style=3D"disp=
lay:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerri=
t-Has-Labels: Yes </div>

</body></html>
--PMLwr/DDzpQ=--


--===============5072549850897004344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5072549850897004344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5072549850897004344==--

