Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6E5606A32F
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Sz22vEQe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dzwIkG2d;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GRT85EwF;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ONsZMDXD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ueEnDioZagk5mxTLGJkIa1EzQW6cl9MvpTH5elYarq0=; b=Sz22vEQesDLCRuoi4OH+Zh2/hw
	tcavIYnx3RBXaAYIwyJ8apJT15FB+0cBtWa/OMkbNIRRONcQ9lbixla2xVu5IlFqe1Kct+8/CZmN1
	8zWWbQ1YgI2EOVJT06wGk6qbMaYtlh/MljmCjMKV2Zq6ConypajXeRmoS48qEPaelf1I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xThRj-000000000Yq-1zk7;
	Wed, 18 Nov 2026 15:19:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xThRh-000000000Yi-2r0o
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:19:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJZf+g3PfYRjQwL4pbqOCrWknHVI2d5C/DzQQYBlWXI=; b=dzwIkG2dezZSN9mwrwD7UIyYgD
 RLO/ywSuIZkVneEHaX45zDKy+zVG/9vOv3S/CYXQJ1diwt4G5UR5+FhJko1LVBh6n3eW75v1qzDIl
 ytoVviJ69ul4GlV6exgFOYnKsAi8m1keXXZ623TQ50uTK2mwmeZK4Z4+WNEqgSyyIaiU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QJZf+g3PfYRjQwL4pbqOCrWknHVI2d5C/DzQQYBlWXI=; b=GRT85EwFQB3SjSKQorzahqZI5h
 JzVpVFsvsty9jr03pFg5zcdMGXikwK4lSp8rpaFQhm/bPZtchfGPamWornmdVfxzRXhERdZMQOPOr
 Qbf4/GVNaDuXMb+mRrKk5RzQEcC73A3PEQ2yrn7gS/w3e0f9ibKfvMBpgHV8RDyhyzI4=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xThRg-000000002AZ-4BrM for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 15:19:37 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so11787315e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 07:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795015170; x=1795619970; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=QJZf+g3PfYRjQwL4pbqOCrWknHVI2d5C/DzQQYBlWXI=;
 b=ONsZMDXDXdJ0xOm5xj7sg4yQy1g4yFnx/rSh2B2gkw5/Vc8nnR24Cjg4mSeu1IrzXS
 0paB2Grmm2sX+G6S2olV+Mm4tvkjONTt+6Glr5cWTOduJjoqRTx2Vupg4OSUx/Zwnz/X
 PhH7BXB+t2G/mtU/U20fH0Q/yjoUV7Erf831+nPjqngczRZ4B8kzD45tv4dTlt7HdpSK
 g+tPVJ9cdxy7Yx81s6aCKfSeMASFBh5g1/tkHVlKv784uRZrKlrDHfDuyamF21gVjimf
 4H72UJCfMoVK+/lr7jpZjszVZi8s8uEN/KKxUv72I8u9W4QLR0A+vAw10SZFDthNrImL
 wZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015170; x=1795619970;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=QJZf+g3PfYRjQwL4pbqOCrWknHVI2d5C/DzQQYBlWXI=;
 b=DcP6uAus/skNuwvht0+/S5Ep1sMHRgJaCmaIM+7sHHIn3ag0xztd9gbg1UCeRiQjSF
 C3wohEarv7vBdn2/9sZujBspi5wq1ZeUqYSsPv4USWg4VBnj6zYFbD3gemc9qpVS1U5v
 x5TVgbHJR3KSe+gr21ZvzZfb/S3hcmiU1p72k5y3vDc1ZdspYkEEVW++JwyWhVw7+4Cf
 YkFUTmnDmgzWznRY0cT8R0A0Z8Sszz5mavDbt1bEiK1UrJCHFaj38po+m8D09+QiKV/O
 Hx6qBTcg0RO7pnzBn7ThxnXNZeXjYxJP7TkytohL5UR9/dHcZJSJxbsKlK4SPkLo2q80
 3QMg==
X-Forwarded-Encrypted: i=1;
 AL+hErHvw9plP1qf1vTibTvH3XvAT73vx8gTV1zZJC2DYsvE0loBKoUQRW7OdLKmHMBhRIMgEhZndZZDnPYItEC1@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+GqbH0H/ELvoAXtk30ty5NwCuNxrbPOBQdhUgipAYahHtI1RSo
 bX9nbQbZDON4p/t9GV3IdkhaRy7qIuyat98t9X+04p3mmQzKqE9HLbcew9G4WaHMPWwzIsZY6sP
 pQXTc/YRbvq2AYKQayD/YXcVAnJ58enQTw5ZgleM3xCk+w5328fGvxI4ZAN3OzpfZi4NHnEWkHe
 b59mqj5g==
X-Gm-Gg: AYBFou1KpZI+3PqKE/f7QctWIIYbb8U7Bc/dGLzjO5yv3CImPC2UIAMwz4j1M1nzt+D
 w1zly1X2gOrnTsaJueq7ej2QpcLLV8NP9UqAr4VkeHJ0+Q2+0J4RREAxEvPcOfryJUBCb9wYST2
 3u1G/fp3gkc6WoZu45iZp/0U82b+op9Mb9uuIcjW4NLazUZqCL6ogc4kl4uG35wz3MWRC4TEkKX
 Ks4KUyZa2fSfvg66TXrUSC0DT0V4FLeGRaRjzxrFHfDG1xFGQeBvUo0z3B/H+eW09bGB3maJgQG
 o8pk3tAyVqK7bwdADkFXenyT9heBR5doYhJYk/sWpQkvt4XRxmpcQa40BxOgQLlM9iPPi+1gFBS
 tvMXTpIcBerud8zXs1+RCQsQBHPoT5UGs65rMBd2w361/NqEHhgKw0d7sgVjjoF2bezBshETd6v
 Z6Wr5lly6J71zNs1+JcnM8TloQ09YJSFB2s+ShI98y91a84qQHAonnVevU7l83y+warycREttpq
 QuFqMmK/FkD1/IJuK71fUWy30di9oe89mieeDV/wS9Rm1XJMAHzWQr0bANfKWGVQLAoAarAGr5u
 88mzgzRrhwGSeaPGXDlLpJIwMKWM9hk/gt5gAGbxocxAFRO8TIO5hYtzUT2B+miAZJwR7wvBjC3
 lGqIRJIE0r55YzWiukbU+vfku0IZLDtqIdCXgCXY0ahmtqJvlNfa90gsJih5HekgLpM0HUsjCk9
 tV5+q/8agoeroP7cE=
X-Received: by 2002:a05:600c:b99:b0:4a1:7ec7:a479 with SMTP id
 5b1f17b1804b1-4bb7da47491mr52223415e9.33.1795015170242; 
 Wed, 18 Nov 2026 07:19:30 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d29c622sm76761845e9.3.2026.11.18.07.19.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 07:19:29 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 15:19:29 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
X-Gerrit-Change-Number: 2215
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2215?usp=email>
X-Gerrit-Commit: a3bfc9f8644faca79e584f82b239f2d7899f7727
X-Gerrit-Comment-Date: Wed, 18 Nov 2026 15:19:29 +0000
In-Reply-To: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
References: <gerrit.1794990657000.Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTkwNjU3MDAwLkljM2VmY2RiN2JjNGU2MGE4MWI5MjkyYWRmZTdmOGUyMmI4NmUyNzRhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8b438d6ba52d2b2cd81167e5c028e0e7024fdc41-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xThRg-000000002AZ-4BrM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket_util: check
 the address family in addrlist_match()
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
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============2125925113881628133=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2125925113881628133==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZjzJjTcOnoA="; charset=UTF-8

--ZjzJjTcOnoA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail )

Cha=
nge subject: socket_util: check the address family in addrlist_match()
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(=
1 comment)

File src/openvpn/socket_util=2Eh:

https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2215/comment/362b6867_7821396d?usp=3Demail :
PS1, Line 315: =
        switch (a1->addr=2Esa=2Esa_family)
> Would look much nicer like thi=
s? [=E2=80=A6]
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2215?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e274a
Gerrit-Change-Number: 2215
Ger=
rit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
=
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer:=
 Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-o=
penvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-Comment-Date: Wed, 18 Nov 2026 15:19:29 +0000
Gerrit-HasCom=
ments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>

--ZjzJjTcOnoA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215?usp=3Demail"=
>View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket_util=
=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2215/comment/362b6867_7821396d?usp=3Dem=
ail">Patch Set #1, Line 315:</a> <code style=3D"font-family:monospace,monos=
pace">        switch (a1-&gt;addr=2Esa=2Esa_family)</code></p><p><blockquot=
e style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">W=
ould look much nicer like this? [=E2=80=A6]</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><=
/ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2215?usp=3Demail">change 2215</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2215?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn =
</div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=
=3D"display:none"> Gerrit-Change-Id: Ic3efcdb7bc4e60a81b9292adfe7f8e22b86e2=
74a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2215 </div>
<=
div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display=
:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<=
div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Nov 2026 15:19:29 =
+0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<d=
iv style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"displ=
ay:none"> Comment-In-Reply-To: Frank Lichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>

</body></html>
--ZjzJjTcOnoA=--


--===============2125925113881628133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2125925113881628133==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2125925113881628133==--

