Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131DDCA5FCE
	for <openvpn-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iNcYk5MALAhshxDGMPCnAGu8IMJsl7nJvKG6terNEx8=; b=CUu+KLFpE72zQaiYOUYxIvur3u
	uOsT8UIlX1sOlU8ETXG3/UrZFega3IS07f6bj2F6SINWfc12oDIb35TNT7qnGEPrKQ7t5Mjl/uOVv
	RiUStou8xFStcq5C/hCNNgBzdLdMrAy/0DjlumyxaXIr/O69ALFSH+vtc3WiaB5ilCu4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDfaZ-0004Am-TV;
	Mon, 05 Oct 2026 10:06:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDfaY-0004Ag-P3
 for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 10:06:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cBI3zu8oEciK4w7at1tcv0VV3TQL67jD+1vXu3YKwiM=; b=TqzKzpaaf0vfW0uiWw0NWNm9tr
 PrJ6blgA0/g6pNwQYCqgnxLbfp9XuKVvoKqErZwpMfNbEKpusjHT+ISrqsnLNc/ZpFu/ToEetSYaG
 51Lw9Lg/ijK2fzP056XZIhC6BWTgQHtwiSpdMLC78ORZx8ftmZhP8SDHVwtf/PVeHSCI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cBI3zu8oEciK4w7at1tcv0VV3TQL67jD+1vXu3YKwiM=; b=R
 6lLhu/mjRr9kmNSe9E5oUjiNOmAEsSiiNE4yVptT49F5wyXF+TGYaOomNSMRHUB4CdSFU3sBwK6af
 1e1RB9RCMidlW+Fa3oXj2l5SkXjWkZEGd+ioDrvoYBi28r8jp1/rJOimSxbRoWaItorUwtgt9saSh
 X8MIVAZlPdIkW5c0=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDfaX-0004OH-BZ for openvpn-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 10:06:30 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48af9f88c95so518179f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 03:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791194783; x=1791799583; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=cBI3zu8oEciK4w7at1tcv0VV3TQL67jD+1vXu3YKwiM=;
 b=PQtirR1L+Ymq17lFJUjeM1Z2bDVoLR0pUQsgLbwLlf9vFnJX/+N1zFrFU0ALOBYIHJ
 hmvP943+EbhxbOYrw5S7eEhh3kjyrcXkA26klj/KLZsurJKdh+Nmfc9lTGn6IcqYLzoC
 Ee6JudkbW5lqoGjiJxEna58jGJ3HXtiVT+TCVcPL6Wq7GuJk2YRcjUGD0KFHaiBC6A8A
 B8PVWDgSLgb3y984N2yP/YtY6YnWMOuKo4HbT9c4lT0AJftMdz24UPAkfXsnhRSw2DR0
 lSEGJqYs76m2llph2UdXP92m20b9J8u5hiaj6ycncd5jt/wcNehsyXSbbgzm5uu81O2V
 sXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791194783; x=1791799583;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=cBI3zu8oEciK4w7at1tcv0VV3TQL67jD+1vXu3YKwiM=;
 b=L9sKB+RNi9OTKErFP+f9iUR9BXWDSyWv+Bda1lCcmrr1HUIe+ONIsZsDWxCJWEx0n1
 xlvYfZBUFd0PJnllvBq9O9ZJS2FfiB3neWW8hK1L1JEFkED03da47W4lb5R8EcJ7GHWa
 T0vaVuywPV6V4IFKERNpaxGjzBIjhXqhZsk2lQ7ucVNOhRFkgVWfAQbmTIp0Rgrng0B6
 gCxFQN7xTdHAcjrLn2upxtsCrQU//xsY6FmkaXVcyIRchxyed+LC2fa4yZSwF0MwIZkV
 FX5T0zcdArKsn8K0OoBjI19GxsflAVcZuBw8HOmI0yKfw07smCXH2LX1JVBZqcarlSHl
 /T9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBytcZkm17auBCGc0hc6FenGDZ54Qr0rZomLb2D6Lcf+FohF/aoIEaVr2PoSP5u3zbuPZZR5ZIE04b4MMAyA@lists.sourceforge.net
X-Gm-Message-State: AFuF++mTH/D7LYWZGLe7z0HHwLRJJgStMy1AGzpw4NiZlmDFwW88DWFb
 +EiTiAH30FiJolqCN2Oy0srWBOl1VuU2aqaUbJQKQMl1uoWyO8VqJ5jTgdhEKNG48WyL1jtbLuL
 iGcF6fT0wSMLgMeecBLhJ/16YRMzJDPtkZw40cRl5ReOdaUuEzGOdyTjhHCGSoeCVkWff
X-Gm-Gg: AYBFou23YwVPFeR+axx9Ek5yiECWzh7DK1eL6KMAx6JvMSyHpbfhXqEBKEbjH0/VqmE
 5NL6qOOEKex1dy0+lzA4ZGPT9Pa8NwkrWKsovWZJBTU1CSWfEA8KDeXIVYIjT7lVFdkpy3xCQEV
 4Pugj3Lwq/eKOjHaBdSOqwTXKoE3SAnb6pazkOD+Et5RxTIYQA7IHGrz5UcBC/xz6NOrEq0jba0
 zywX9fSb7hShVefvrjgODcenVt627Tv7PbooMeOrAReO1k5A0tfgNMmGWlzZnx2xRlba1F2q7HL
 x61V8P6T0a/KYt23o3O1znHZT/6phfJAbJTOf5H6bsanGWe7I2KXULfq9lq4c0RPeDa/XJMir48
 kzDiiXRMwKjHJHmUSPzZRWDCxNZKvQV5cafYV0RorEBuT76shJu8c4nZFWnP6ucF9kJSt4Ucxqh
 84NYwH+8JEqfbiUY0ygig2Gaj+83tBUyMtQQtW/KKyboHqxsKGwwKFm/ZS96UJ/ubOysPZozJ/M
 dAHG1s3DJPWtcTkmmz73HggA0f8aiNRa8+osT3daQaZ3bEcDd41mIic2+J/Ltak2RhGvzPgHAzm
 8JPwtKovtr6+11eWOVx7DwbKqOEXlukBWllilEptNZVDEuKhnKlN4ktpaLMoZMw0vMbaD/A=
X-Received: by 2002:a05:600c:4515:b0:4a1:71bd:c929 with SMTP id
 5b1f17b1804b1-4a171bdc95emr46395655e9.4.1791194782492; 
 Mon, 05 Oct 2026 03:06:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a02773ba02sm328561715e9.12.2026.10.05.03.06.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:06:22 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 5 Oct 2026 10:06:20 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b91d1e54
X-Gerrit-Change-Number: 1962
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1962?usp=email>
X-Gerrit-Commit: 40a2f1f4b5d59defe28d8e9b091f4580c4e3114a
X-Gerrit-Comment-Date: Mon, 5 Oct 2026 10:06:20 +0000
In-Reply-To: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
References: <gerrit.1790611935000.I165c632da6a837d0cca55bee4c2cc390b91d1e54@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjExOTM1MDAwLkkxNjVjNjMyZGE2YTgzN2QwY2NhNTViZWU0YzJjYzM5MGI5MWQxZTU0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3cbc2456920393629452071d8de1a60ecd8978a4-EmailReviewComments-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDfaX-0004OH-BZ
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop
 IOW_MBUF
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
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8478586927366766913=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8478586927366766913==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jcdjveE3Hbw="; charset=UTF-8

--jcdjveE3Hbw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Gianmarco De Gregori, plaisthos=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Gianmarco De Greg=
ori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail )

Cha=
nge subject: multi_io: drop IOW_MBUF
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(1 comment)

File src/openvpn/mult=
i_io=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/3a601c8b=
_ee0360d0?usp=3Demail :
PS1, Line 568:         while (!IS_SIG(&m->top) && (=
mi =3D mbuf_peek(m->mbuf)) !=3D NULL)
> Both correct and worth splitting: [=
=E2=80=A6]
Is the server always exiting or restarting on signals? For `SIGU=
SR2`, for example, if I'm reading the code correctly, it does not exit=2E

=
But yes, the problem is pre-existing, but probably unliley to matter all th=
at much, and we can probably continue to live with it=2E



-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I165c632da6a837d0cca55bee4c2cc390b9=
1d1e54
Gerrit-Change-Number: 1962
Gerrit-PatchSet: 1
Gerrit-Owner: Gianmarc=
o De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: R=C4=83zvan Cojoc=
aru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention:=
 Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Comment-Date: Mon,=
 05 Oct 2026 10:06:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
C=
omment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Comment-In=
-Reply-To: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>

--jcdjveE3Hbw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Gianmarco De Gregori, plaisthos=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Gianmarco De Gregori=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi_io=2Ec=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1962/comment/3a601c8b_ee0360d0?usp=3Demail"=
>Patch Set #1, Line 568:</a> <code style=3D"font-family:monospace,monospace=
">        while (!IS_SIG(&amp;m-&gt;top) &amp;&amp; (mi =3D mbuf_peek(m-&gt=
;mbuf)) !=3D NULL)</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">Both correct and worth splitting: =
[=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Is the server always exiting or restarting on =
signals? For `SIGUSR2`, for example, if I&#39;m reading the code correctly,=
 it does not exit=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">But yes, the problem is pre-existing, but probably=
 unliley to matter all that much, and we can probably continue to live with=
 it=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail">change 1962</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1962?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I165c632da6a837d0cca=
55bee4c2cc390b91d1e54 </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 1962 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@=
mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Gianmarco De Gregori &lt;gianmarco@man=
delbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: M=
on, 05 Oct 2026 10:06:20 +0000 </div>
<div style=3D"display:none"> Gerrit-H=
asComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No <=
/div>
<div style=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocar=
u &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Comment=
-In-Reply-To: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>=


</body></html>
--jcdjveE3Hbw=--


--===============8478586927366766913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8478586927366766913==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8478586927366766913==--

