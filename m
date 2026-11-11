Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DB0606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CFgm74tm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m1yztazP;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VrKvY+0i;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=X2L07lkA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=rNiNkrM1/qRO6PBgLvqIa988Hv08B4ZY5diTvy7LZ50=; b=CFgm74tmkA2BQd49lfWN19ZXCd
	i8aEW/9NGDhiE8ySnGBwKMqaF+6FcI9A/eJK3bIe12A4ZZalu+yQiQ0ICeBPjSH05fCExp/6voTKR
	lqGvlqt5EFLNa+wsRvUyHCEWmQXSqAJOYqq/88wjY8QO4wQ5OdbJfU9P/7wDopbyahoE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR5fx-0000000063T-14fr;
	Wed, 11 Nov 2026 10:35:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR5fe-0000000061N-1TOw
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:35:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8hLKIH1zpWDvRRzUJsGRKfKXsNwc/S095AhsqqQ55G0=; b=m1yztazPo93Ql0G/HM71R1U/QX
 xIaiiaCxD3ZWyyQclEomafdBEX+DrM4wAyy1QKoR4htL6DxyN9ryHYouPVI7tY3JgodOHfrMrDUaF
 GgvqAvTT2jF5bGKTWVwD8P9QZ5GnEEfY5YPUdrwpp3dzy1lKeZfEUaCEevAPyQ/AGUBA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8hLKIH1zpWDvRRzUJsGRKfKXsNwc/S095AhsqqQ55G0=; b=VrKvY+0iSJRgXZdSIh4QFlvSQ1
 5DMUSwWvzTlh3Ghw9I8x58554SXYJMX0rciWrcj2lY+2EPL2KuYAB+8DmJDQ9RkO/eMSNYD9MjCKq
 FT3E+MSJVoyiWNn73k4ca4STFAIGEphigOqKAwveTT+vorhtkBTHdWbmzyCDSmJ66QOc=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5fO-000000002Xo-1s9c for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:35:02 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a5177d78c7so25238575e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794393292; x=1794998092; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8hLKIH1zpWDvRRzUJsGRKfKXsNwc/S095AhsqqQ55G0=;
 b=X2L07lkA1lKtdZnO6cdhTaMukogPl7NiJxYRYTI/pqlVKJe/bgGbyStVYh2jUS98QC
 YPP+k8qZnNlVhOiA2vmSi/d3bW7nDVIdMQ7kCQSfQdl7R9l1VdmslBV8BXxxZwhOP2WF
 3Xk5mPgEVGQ2LRKa6Y2O0a9p8XvFj6ZoDAor06zpFcp4pVzjVilgUCwLtQdUNi/JNUgE
 LokW2zHkWYeFJsf3J+GIXHE1RFx4aL1caR3/gU2H3+RCyf1ShUGLkuChP9lTFK88OF8A
 t1rddWi1Yq056Ob1/mdIEFZe8NnvV2XNCxxZyr/gdHxufMeM14z/gGnIFOAGpm4dOpGi
 nAWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794393292; x=1794998092;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8hLKIH1zpWDvRRzUJsGRKfKXsNwc/S095AhsqqQ55G0=;
 b=OR1wBAq0GNPNZfo4czugEhdxmya0Qen2XUwsizV9yIpFFAhS0O2IsKAHKovLpvaVnW
 3khRFyFFiJ7eS1SNPGS+0Lh+w0fi3Y1WifDsHhwsNrWDHp2QXFGZa0qIiPaEWuv5aHDG
 CynvMJpRXb1u6W9IwUGqs8sdxNEDpI7SrvZdJ7bcLOhm/Zq5n5KHQGd4z64gcdGeAj62
 E6SoF0+QGbU82Uw+Pvo7DeYasAAU6ebXgGJV+Siymdgg1GzYU1RKnh4T1/YIxYoHcYUE
 ViFGpwwagx80QaRncyBUJc/JITbHlT8tot6tRbLfS5ftnVWWw2ZRL0yxKzFfqFT8sAaO
 IQdQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFcidPGebo0kFXrEVEGVgyl4yMXgvGFcCVfpEdG7Fn35aU0T1mXH2nJ/uoCZiqmKOIfkzJy9YzOxTtMF3Bu@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+CABRcxSV0ePyVtgYrDRWFgu9uQRBLq7jXovUSIkX4S0RkbU6I
 vvWnAFLzZRG7IP36zLYlo0Ll6uIp+USY/bPoQipvxDTX1SxIWBdzuBqcM1SV/cg8PwZcAbF56Ms
 xh0tw0eLDH7tvHSp4jk3fswhpTK/qf7c8JPpKGxapukOql0hgEZGwewnAtwA3lcgA7IDF
X-Gm-Gg: AYBFou2jftWvjtpmYDy6vCoZ/kvlUeSmk6BG7prP7qQkvieMVw8Eh5tSSplrpz+roLI
 WLOY1/yWXEO35LY/xNa1+MnHxdE5JqsCjITEqQelLrnwFSLKne0IfSRFg/Y5PlelxXaZ7GEeCNW
 bAY1UkAUFS6Scf25RtqLCmotFoTWQ6W7LJu3zEBzOIMCw7k8C5Jh+k3S4nDdYB8nbTd1i3kDff/
 jwldbGAs+mQZktrX6d+fqkhgy92mSmE0xlAsF7XlyX/exMxnj9OIxEHHg+MApbR3jvWyQMQdOEO
 eRjmSt8asAz/rjZ2Bl5VXpPXB/IX71xgn+ECLl2SMv96Q55DwUbz9olmUnuqp7b5vJGyDMj0x/N
 Ov8t7D8wieLO28exNBep238RamMfA8r6lPahLg9uCMlz1AJtwoIAMiT6UgEG1wa6TAozoLmZsNf
 JB80tiqrgP8gmTcciRVQDYHmuxNVzBgliT8cLNSXrAPjivP3tk9CMeoyxTnsYFd1QdhFWDYNbsd
 q7ULA3CahTxrcY24PbyFFgZqYoE/ro6ToYQ8vAFJtfXeLHziBO5gGsL+Pt6FFIkc28N+dg8KT2+
 JHDGnSyk7zxiclnYy+uGZgTA8bFT18w/Ky6ehMfue6GiRRDbsw4ARfmy93xZy9LTMMSMX38k9Db
 V/TTNPLtp+lgze6fqQ/zjLdwtJudBZisTiFsyvZCSoHf7hVKzrOSXkiP88EQUZLlqoqGm93NoH8
 jn3FqZvFoDZhNof4o=
X-Received: by 2002:a05:600c:6214:b0:4b5:d95c:2378 with SMTP id
 5b1f17b1804b1-4ba0939815cmr32980145e9.34.1794393291664; 
 Wed, 11 Nov 2026 02:34:51 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01fdac9csm199912135e9.0.2026.11.11.02.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:34:51 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 10:34:49 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
X-Gerrit-Change-Number: 2161
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2161?usp=email>
X-Gerrit-Commit: 193f1deedeb81851852f64a578c1e8518fd05343
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 10:34:49 +0000
In-Reply-To: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
References: <gerrit.1794301782000.I7ffae4da3b29521844a31d234fe6a9dd08954cf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAxNzgyMDAwLkk3ZmZhZTRkYTNiMjk1MjE4NDRhMzFkMjM0ZmU2YTlkZDA4OTU0Y2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a4c8762b57502efb8187af8a01e2fdc1db4ea1a4-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR5fO-000000002Xo-1s9c
Subject: [Openvpn-devel] [S] Change in openvpn[master]: openvpnserv: only
 remove search domains that were added
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4850733939676769695=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4850733939676769695==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Tgk+TL2gpZM="; charset=UTF-8

--Tgk+TL2gpZM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail )

Cha=
nge subject: openvpnserv: only remove search domains that were added
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2: Code-=
Review+2

(1 comment)

Patchset:

PS2: 
thanks!



-- 
To view, visit https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail
To unsubscribe, or f=
or help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I7ffae4da3b29521844a31d234fe6a9dd08954cf4
Ge=
rrit-Change-Number: 2161
Gerrit-PatchSet: 2
Gerrit-Owner: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Quartulli <antonio@man=
delbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026=
 10:34:49 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--Tgk+TL2gpZM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Dem=
ail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D=
"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px=
;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2161?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
thanks!</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail">change 2161</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2161?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7ffae4da3b29521844a=
31d234fe6a9dd08954cf4 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2161 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@ma=
ilbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Antoni=
o Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 11=
 Nov 2026 10:34:49 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComm=
ents: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>=


</body></html>
--Tgk+TL2gpZM=--


--===============4850733939676769695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4850733939676769695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4850733939676769695==--

