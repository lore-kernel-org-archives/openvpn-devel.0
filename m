Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466F7606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 05:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BYzjuAAT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HU+kO2z5;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XrEtf6pm;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=WoSa1MFm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=MF0L0/V00Us94Zf1G3dWt2g7P1I2CYrOcQ99rCv9fek=; b=BYzjuAATS0xu+WySA6X8wHbcog
	p6dnwA6jsTyfOXMYKen0uxtePL97qpnt/vkmMkUOQREo2eOlPZ8yyM4SlfKCl1PmT/ef07CSAK7/D
	eyOsML7dScosVLAK7pk3GYwn8oJn6nHmhVfJg2RTOjuNq6/9tXeJd3l05hzMZVG3gWAw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOqFY-000000007PU-35ws;
	Thu, 05 Nov 2026 05:43:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOqFX-000000007PO-1xLr
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 05:42:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SGSya5jxL4qRrfH8jQnEAO2/rDLkAjhfGYhAawX42qA=; b=HU+kO2z5bwNuxbboRVHNYOZqV9
 ROa3ia0+hI4UBssjNoEva5OCtYeBhpvCEQ9VX9etghw6rrAxSc3mwyUuPsQaaL8Wg5Zh1u/bKh3ab
 nHllV90Nao/KfdFhl/hUgK93AOkM9hYwsTwDfSN83BeR31hPQqd9iYhy9y5ZF1mLz37w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SGSya5jxL4qRrfH8jQnEAO2/rDLkAjhfGYhAawX42qA=; b=XrEtf6pmeLFw0toNAmYXVQiGDI
 ZHndFWCXVMxQMYEYLj+Gv0md8hqHGAxkpWOPRO5Czl3wfipuQtO9swysx8gk3gwsDRpmgKx/sbfD7
 QXlpFPZefBkAmnaC0gaIiBKC05l+hpgVNpVoC7gXMDeixb2vC9F5OX40tirD+rirPbPk=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOqFW-000000005hs-3YXG for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 05:42:59 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso975744f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 21:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793857372; x=1794462172; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=SGSya5jxL4qRrfH8jQnEAO2/rDLkAjhfGYhAawX42qA=;
 b=WoSa1MFmsDX3hfqPTqPqQ9AsQbGRHWE9tE+k7uwGUVmm0+qYS5yBn3vKOXKroZWOBO
 USXTkxk/Au3C5gXF2qa4Uec36QGM8tu9fV9QWeuXMvkyRgl4brLPIWt08C1Bb7aRBZbo
 bvheaOlzDR1jKDMxCs+Kv2c+UuvY2NBlaUdRzQ4rChjHjr+3heNawEdqivH0QNxdJn4z
 oqABQhZ1Fq18CCQur1U+fSvJOaE48+CGG4Y98Dv1vqeFD7DHm7msGd2Z/mwKUlhEV94u
 cq434fg5NbL1sjYFe953JzOSbNm8Nzi4BgAEXD0SMOmLZsDKL3nvIS+g9dnHsYZRjDpZ
 O4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793857372; x=1794462172;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=SGSya5jxL4qRrfH8jQnEAO2/rDLkAjhfGYhAawX42qA=;
 b=cJWQc+71BwYgbHtWtt78HLGb8RcVmaK13U8HEonV4RT8Swu3mfHhAe45iyfkyFotOq
 aTGdPC1k3RjxC4GASm56mifPrDoB/bitrv2gL7f+VNlfitU2JNDIwAaHEaRU+Z9MgcN0
 jFEQ3L/b+JG/RB6PjSOp/txZlmaOH3ORUnh/RjfTPw/0YapjdPu44dPoiwJfWhAqAL+P
 LFuycJjSAZNz2rDsml6A/KepQqc/L2X1Mi9zDGQMDtrYx0+vQFW4hFAo5RLehKl5QiZi
 sntmfnX2DvRDugmqDp8i+gEuf3m1/H+/31PeLxtc6epWQzZ1DQPz2AU0GuTMmDE45M0W
 Lz6w==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5Mdi2eijxKtBaTW0M4EOuN9+qTzFzkr1+NoLVpjcq8CPlFwdRFixPAwDetEoNUNoxhkzuap4py2hC72dQ@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+5frgJ9w9B3K0dTPzkix9M68zGcG36vdjNT95E0yBgelrBa+F/
 /ARsmEZZufcCes/JTB0FRX+A0jaHd+KVG0HSW41Jet1D5R4ppsm9+6SMPXz0X7fIRdjA9ya2Pat
 nNXNLnnwLtg2Z9ikcxmDusdBJ/1EHhafoSP8llZ1beqrhERILQ0Nx25fQRpfsQVmqoHov
X-Gm-Gg: AYBFou1i13BBUw0iKM7zu+HRGM6xxxVIOlm9YhPNeAoAKGwr+HDxaxU8wRPYeM6D2jv
 TAfFN4GKOQiMzUA1fTku+uG75wUXUyf9ZSrcm2C79E7TWQX8iHDGRMEiVZ+AxO0uouqJ+TVAEop
 4QI5u6KkjoxNam9e60RmSkC9siKIfE/l9iAfHkQqZ5YW2MbHfc81lNX8DR+gYO5sJD0eAmZ+bML
 hAk/T/hXWaSRrM0voWo9SmKvUzJlDOaxNnycfHsGv+aLZN4+d3UJlV2l87abra4o5UX2g8R4/jS
 +Yduh4mqReJUB3UBQePotghiSryK3PmFKyVehXwYn5S8ttEJ60556e0kCFBA15ryiVxLfeLixai
 T8d23nZeHRSPK94PK4QVjitLsxY9jjidjCELAeqvCHfgpAGhG9IejP2yFLITtaiyvPq3Pkij/EQ
 EhYhpxH8HwMDj1XcUx4dZZKT7taLwKI2JaAADW0DNUfPbEZdwN5bETOdh2dmh1QOz4/FGETx0Cn
 H5kVRNJ4ZsNFSWCfeznT/NJIX7xgfItsCNibM7wvfSfqUxYPruHAPwEZff7KxfCYRxMWJ1Pca1E
 HIMa3RnuVdKaIqNmkES4Jmv+3nejL/2Cov1u6gFLiDyTw8sXo19rV3V1r6kiTnGUHuS+5CM104c
 /vpmxYbDXQUFTh7Gz17DZ0CanLLqtKLQioNOI/KWhVbPZdvrm97Nf9ypW4KrteAxwEUEL3dqim1
 /CgxZnCR70ZRwxig==
X-Received: by 2002:a05:600c:4e41:b0:4a6:42cc:bf6c with SMTP id
 5b1f17b1804b1-4ac16acfbd0mr367421055e9.7.1793857372204; 
 Wed, 04 Nov 2026 21:42:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56f02386bsm34873995e9.7.2026.11.04.21.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 21:42:51 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 05:42:50 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
X-Gerrit-Change-Number: 2063
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2063?usp=email>
X-Gerrit-Commit: 3b2ce51dcb04b48f6d9e43af9318d73ed1cd7c09
X-Gerrit-Comment-Date: Thu, 5 Nov 2026 05:42:50 +0000
In-Reply-To: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkyNDU4OWQ1MTU4ZjY3ZmViZDNjMjVhZjAyOTk0NGQzZjFkYTMyNzYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c7b533c592ae4a817afc48a2739b17c63674c4b0-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOqFW-000000005hs-3YXG
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE: enable
 Linux DCO address and iroute updates
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7996968916571202328=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7996968916571202328==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YWISR4wxsw0="; charset=UTF-8

--YWISR4wxsw0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Marco Baffo=2E

R=C4=83=
zvan Cojocaru has posted comments on this change by Marco Baffo=2E ( https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail )

Change subject: PU=
SH_UPDATE: enable Linux DCO address and iroute updates
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review+2


-=
- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Dema=
il
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24589d5158f67febd3=
c25af029944d3f1da32763
Gerrit-Change-Number: 2063
Gerrit-PatchSet: 3
Gerrit=
-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 05=
 Nov 2026 05:42:50 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--YWISR4wxsw0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 3=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">View Chang=
e</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">ch=
ange 2063</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div sty=
le=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:n=
one"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Chan=
ge-Id: I24589d5158f67febd3c25af029944d3f1da32763 </div>
<div style=3D"displ=
ay:none"> Gerrit-Change-Number: 2063 </div>
<div style=3D"display:none"> Ge=
rrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Marco Ba=
ffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel =
&lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-Attention: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openv=
pn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Dat=
e: Thu, 05 Nov 2026 05:42:50 +0000 </div>
<div style=3D"display:none"> Gerr=
it-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>

</body></html>
--YWISR4wxsw0=--


--===============7996968916571202328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7996968916571202328==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7996968916571202328==--

