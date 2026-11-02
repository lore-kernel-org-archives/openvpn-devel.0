Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B91C606A32D
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HBgZjOun;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Y/2JW72e;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cCwkMukZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=VExNTGix
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OOyymg6cFYvr7Nk1ceIBDLZ1aKcsTHMfo6rpqROF+sI=; b=HBgZjOun6Q8PyMMt+2sKWFGuKN
	+lsdt5CzbSiR695z0UTyF+HiDhB9Rkxpt5rQSfRz83yIyS88lOisl4rzPZxnt5MmTmG3a/g9X+IS1
	luczih5uC+P8YBHfRhbhqKp36i+SZJ7pZ3uSvJ9kaconZY9r2qdcPLyRq4CeANF5u8B4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNrGD-000000002rg-3y2g;
	Mon, 02 Nov 2026 12:35:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNrFw-000000002rN-1G4A
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=etZUw46fSiWocIlZXWhwSPTDOoLFaMLjF9Eyh8zIkMk=; b=Y/2JW72eYs2ZAQlJVxu2Yo5ipx
 yMukTcN057KfvopSB4WzptnO8/X+ltf6oiNTiW+gEYsacFa1rONbGxx0MvyygCaOMMTX22XPjAYaL
 146T6KQF0Wx4snL88jpxWt9W/2FR3kinpB0LJZmpl1pqYSKgPRqBM+q6Mhg79JZWX98o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=etZUw46fSiWocIlZXWhwSPTDOoLFaMLjF9Eyh8zIkMk=; b=cCwkMukZYkBuTYtp0doXdXDVZn
 0+2Y2KMSmvXqVfbqd4cJY/ogkkbUY0pUicm/6gmd4VLGjWDqrJPQ1IcqXvFLLyD1chZ4AG8clJbj/
 W6e0NaJJmHO++NdgaN24qBgGfGNLvtP7znUz5gZEYtFiAmwgi2Emlg9WhtOqP0jS/xZo=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNrFu-000000006uN-2H6M for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 12:35:19 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so22238365e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 04:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793622912; x=1794227712; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=etZUw46fSiWocIlZXWhwSPTDOoLFaMLjF9Eyh8zIkMk=;
 b=VExNTGixcQuWqvIuQwkFoFQ8Dl/QT2F2zIPR8NWoS47GBERyzhwAcFgvTpEQppbieD
 Bxqh0Cob7K58iT7mH1+FMB2iLzY4QvXmyUcYRGOiOLbxJZYSC298wYEeKN4QbLqMmXbq
 GAzuig6DIea4OpjaJJUHdGLleBUhlVzg36a+kKIksP5PtvyTZYp+EXFUrvIxyWW5UJaR
 Uq+R+MoP8tcfGUe5DDDD8/65SRvSRop+dZGWDtcaWrbCX/FlabtO9UjqemWlaVYdtZ90
 YFW3bf51rfcww9Ubrm+gULRWzJEnOKiwY6PEnNwcOGCClijNKAMu3rlAOR+FVFFMD9/T
 6VmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793622912; x=1794227712;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=etZUw46fSiWocIlZXWhwSPTDOoLFaMLjF9Eyh8zIkMk=;
 b=zCI0C4RUnwIxhpq5AwIpQqJ2zonnsUJrz0kTaBk+xMp9pRpPIjXy2Bzwi008vgMBWj
 5J20pctQGE9c2fLK8Q6Q3rJ/3dSEl9EtI97IgMnxjfke4eCNtTNwOy57ukV70INIFups
 5RlGpSGi5Bq6f47RfP3FYS0sSCgFIBx8wSMkckgJPzMCdBfdAC5N08kTmlSNugAiE2F3
 XOHn8NZ3kv3GAdh05NlsbMC1uyb7CxKN3H65SgCjRXI2qMJk0vC+ktsUQjirHSd2Pcvz
 LkmrW/Wjez4gz6wn79li3BbwbyREGkAb62JRNs0bF/tv0MOuUZDum+OouTYXCFcr5/qV
 k8Vw==
X-Gm-Message-State: AFq9FYJ8rmwjjSoGzRZdcEOuUcnntjshnfM4jUr3v/D8qujvfSjTdLy2
 CnO8/YYLqXFUSxuOiDZolLNICjmSE9Gy5BUU1fVfztEGf4D0AAZ0qnafsfXKPdk63cojuCSUy40
 SCYsFq5Ao1XHlrd/Sa4o/+wo/g6S6HJUb1I+JzF6GfZMDhaK8Eg1j+qSWbXiUDcjuJJiS
X-Gm-Gg: AYBFou3cGlr3rFL3puLf6aQM0MDFOintwmdSXNTm2fyDUN11yxRHX8ecI1cbY7LHmqv
 bGHc3VvKxE1M6MGg1b7S6sxzUMfu7wxaIvjV3K9J3OjcdP9QbUD0rhBwC6Zkbe5EiLA50zBACRU
 MplilJD+THOp3n6BLU6qJ1ULNoJPWTTWfGtVJIFBRo2IaRXxbwIAA7z+X5Zvs+9sxyuzAiohZ7+
 Jgzylbv7894PI/9LhvVvFXJfrFVDy65KRbYAXzUh1N4vL8HmOggZ5p53of/zVohHEDZLY5DhERp
 UJvImaSQnTQnCQWk2IH/IlBZrX85gN/QkksSHPlCMNAhzdoO1dEnHExHtjQwm1rczZ7u9Mr6wpM
 PFT2wUvCbDOd0NEBwtkAmqDCY4Imm3qHDeyi30IPfmQp1p8JdHynE5XczhrGm6hN+rlEK73rntq
 +i1jGKb8XBWF5tAPtwtbTYQM41kZdmalQUFWT7xG9weAXSMz2Hq/gjrGY0+LFmDR+oXCgXAwZaD
 5yhdPqj0fackpEa5N/Ub+LXWNLCO1DP0cCLjCmcUOV3NP+UEqnuBU8HYzvhpvN4YSvKWXTbrIqK
 KXhTa3mP+ISk2YL8dAqgCQMFJZHjwKQaA2Xfl5cxPnrIuQ95zimCJ/nhsyW+p8VcS7vIsv+APmR
 Ko5KHxqGSdc59D7QEEpVEyhReNV9ADCEH1ug5X9H8SYskG7vQyYF+Z/k3WCgKRZ3+4nysxJBbOK
 RUTtgCdN0tkHWChQ==
X-Received: by 2002:a05:600c:a00d:b0:4a1:83f0:7c91 with SMTP id
 5b1f17b1804b1-4ac185bc336mr218685405e9.18.1793622911827; 
 Mon, 02 Nov 2026 04:35:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b7246fsm20161897f8f.19.2026.11.02.04.35.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 04:35:11 -0800 (PST)
X-Google-Original-From: "Frank Lichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 12:35:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Icadbee50a3af55f0f2069f6d6f1ccc746180f368
X-Gerrit-Change-Number: 2081
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2081?usp=email>
X-Gerrit-Commit: 68fd83945956945d64655703fdb33041757f812d
X-Gerrit-Comment-Date: Mon, 2 Nov 2026 12:35:10 +0000
In-Reply-To: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
References: <gerrit.1793618230000.Icadbee50a3af55f0f2069f6d6f1ccc746180f368@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNjE4MjMwMDAwLkljYWRiZWU1MGEzYWY1NWYwZjIwNjlmNmQ2ZjFjY2M3NDYxODBmMzY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <839dc97273a74ab22db211fe4cfc206a8478a961-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNrFu-000000006uN-2H6M
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 --secret
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Frank Lichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Frank Lichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3325963418404519418=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3325963418404519418==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JftjabLC+js="; charset=UTF-8

--JftjabLC+js=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Frank Lichtenheld ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2081?usp=3Demail )

Change subject: Remove support fo=
r --secret
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 2: Code-Review-1

(2 comments)

Patchset:

PS2: 
There is one men=
tion of `--secret` in options_string=2Eh which should be removed as well


=
File tests/unit_tests/openvpn/test_crypto=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2081/comment/08cacf2d_60252549?usp=3Demail :
PS2, Line 311:=
     assert_int_equal(linkmtu, 1405);
This test seems to be redundant now?
=



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icadbee50a3af55=
f0f2069f6d6f1ccc746180f368
Gerrit-Change-Number: 2081
Gerrit-PatchSet: 2
Ge=
rrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Fran=
k Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-d=
evel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Mon, 02 Nov 2026 12:35:10 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: Yes

--JftjabLC+js=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Frank Lichtenheld has posted =
comments on this change by Arne Schwabe=2E</p><p>Patch set 2:<span style=3D=
"border-radius: 3px; display: inline-block; margin: 0 2px; padding: 4px;bac=
kground-color: #ffd4d4;">Code-Review -1</span></p><p><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">View Change</a></p><p>2 c=
omments:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?tab=3Dcom=
ments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">There is one mention of `--se=
cret` in options_string=2Eh which should be removed as well</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File tests/unit_tests/openvpn/te=
st_crypto=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081/comment/08cacf2d_602525=
49?usp=3Demail">Patch Set #2, Line 311:</a> <code style=3D"font-family:mono=
space,monospace">    assert_int_equal(linkmtu, 1405);</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This test =
seems to be redundant now?</p></li></ul></li></ul><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Demail">change 208=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2081?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"dis=
play:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Ger=
rit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic=
adbee50a3af55f0f2069f6d6f1ccc746180f368 </div>
<div style=3D"display:none">=
 Gerrit-Change-Number: 2081 </div>
<div style=3D"display:none"> Gerrit-Patc=
hSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esour=
ceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arn=
e Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Comment-Date: Mon, 02 Nov 2026 12:35:10 +0000 </div>
<div styl=
e=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:no=
ne"> Gerrit-Has-Labels: Yes </div>

</body></html>
--JftjabLC+js=--


--===============3325963418404519418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3325963418404519418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3325963418404519418==--

