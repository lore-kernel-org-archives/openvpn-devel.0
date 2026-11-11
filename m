Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84915606A326
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GnGPBqyi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JdAsl0IX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Sa1x5KEi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cueAMt28
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=LrxUer/MNpRZXf2O+NYLNjj6RrD/SzgN0cjQdIG//2M=; b=GnGPBqyiLvFy0Mj+RIH8pPb0u9
	DvA3iXCcH8+y787/I+l9GbSFD3z4fMJsNWDwqdbCNiCH/lam46Dw3gtTRrCdQ43RJiXFFExm5MspL
	u5noO0C9iPDDRya/tubtkvL+Uw/zoFRnyc9dbtHpzTcQsSHhH/3/Y0J1wl++kfahkfSo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR8aY-000000001RU-3J2N;
	Wed, 11 Nov 2026 13:42:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR8aX-000000001RO-1ask
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:42:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aFLzJ6Yx1ETWn1gJqvnoo2Ufavi7TO8BBhJ2vslsHnU=; b=JdAsl0IXGsrX5i5rvjOxaFizW0
 vWY3lVTDWyrdiAN98Rzx9oQiwyUIRMF9ARQkJmZPEd+LbF8fSAP333vwIU3Yt+6fPXbQXY+AjO5Hk
 mXaPxtrMWOAVMxpB0aw/MKi4PzucFhNBoq9c4FfTTjGuef3QoaqkpW3cw5DWcNdikxUQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aFLzJ6Yx1ETWn1gJqvnoo2Ufavi7TO8BBhJ2vslsHnU=; b=Sa1x5KEiU6Ou8ctpksnssqYuRy
 ZfRSjteixvr7s/UU8z7ktYgBmVT6bqNCdZu+oWzSoq18GDIaxqy8fzyW1RDFPXsrSIK0l3O31g3J6
 RrvwJHy2p0fKIfoOs7BYRauM8O3iIm8IA5MVXyNYSO5V36WjVYikJdNXm4ryms74q0VI=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR8aT-000000000oI-1QmM for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 13:42:09 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so18970585e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 05:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794404519; x=1795009319; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=aFLzJ6Yx1ETWn1gJqvnoo2Ufavi7TO8BBhJ2vslsHnU=;
 b=cueAMt282PCGCVbimV+Kq3Hr6Rpjxs47Ix+bLJjk0eicJfHafEj7VonaBQdfiCjMVj
 Urux9zJh9sX3AdiFD4tc7ct+OShVJpy1i6UA11Ec0T6rvq9tCIwBc3kM8Uy+sbTLsRjr
 RQTbCvNJ97fyHZXvq7F0diMNUInHgMNM/yk5g04/KA8X2kEWDXqStClJM/kpsG3VR924
 /UDP7iYzo95GypxLERTeiDzUZD1Ihti7yRqe6FNGQwYI/umi9jmqonotALcZqM/C2CqM
 F77F0YIM6e7tXr7SyNeF8Xs2SgyHJaq35UrltrjqMdO1L33OoX9fY4G7HAbp21xNhFEa
 r0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794404519; x=1795009319;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aFLzJ6Yx1ETWn1gJqvnoo2Ufavi7TO8BBhJ2vslsHnU=;
 b=XOk1F9rEI3ZpdjObfiWyxFA54NYeG887DuX7bwhfsjXK1jHmZBzDVAgAl7bhHRNjkK
 XMkP4HEbvNKLkUkPXZUUOKql9eq8mKk0zdObxNLYPYCsxd1kQ7+sfffDyMx85OhtRo5R
 yIcm+70WpPDk7EM3NQVMd8yMRPY1u+QUCo0h1J/BpRUOORHUqrTXaQVD1UP8fgfh02MN
 Skz/pnTy775ddE/r1rGPV+QdbUfWWEE3IdPKz9r+Ek2DRi9xBILI2ZdkccRp0mT7zrVr
 tdWMfo2RdOeaQZZX9+5M/+8VkxD8rBsHEQpvsZP1D/Dg9iJEnP9PGWH2sqI+ooBJ18tC
 QoqA==
X-Forwarded-Encrypted: i=1;
 AL+hErHmgSFiKst8L0Blo6hiJI2TU4HKtogxLY/EqPMtiiBNfNrIuFAVxPEpfiF6jwJg91sVoCOgJzog9ofw+Yef@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+6RVg+yv/RpoToCC373CWDV+asa3H6XkHUQKXBVtbc2WHLIs++
 Dh5lZ2SdY/wXjM6vfQ+LuTCnqisARhrXXPidZR6MI2gEUShXnaE3Hy+FnVXF340CuVNWnvyrCjw
 C4xh4URde3l+2EPwVpc9lgpA8y42xmMmlDthdorqhCuz6MbYmbh8nqzlojSLIGDfGNzQLgByT03
 FztxB7qw==
X-Gm-Gg: AYBFou1Wis7sIdxlcfF04lrO2uwAQEbwvo2zo4Gb4ur5xU9gCvbDWzqV045pgZuSKdJ
 OE2L68PTlRr0wc4KXt6Ej7QEW3L1nJLNc85JKYEAQMC2a90JRJC6Mn854mO7UR7iCPh5dBSX8fy
 XDsGTWjzfZoEHXGkaythGLyDi1O7lawz5pNPxhd1JDbfnxCy6COcP2T5cUJTUscwNW1q4TYUdLj
 0dyczA8M7x9katLSB97V3mCWX19SQAhNLYfQQTUbLy60P/g2Gr5Urs0Yl3ZPujU8jWNX6z44wjT
 jtmVy6dqy113zHEmhYXiA8Wkbq2GPJK4y0+4CeulTLGi8uFUNyh3HLpVAWQMmD62Z6BS7be+3hq
 vz9Ph9lMbZTMjF2mL89oxLAW2c7MOMQssCIEwDElMeYuNvRhx8TG2zmXHQ64KD2D3nt/po1VTkL
 QaA+Z3OHzu04aUlJAgt8HNtAKmdfL4nACYKxxG6GL/6TnZj0s2sUIadwgnHNdvVGztyk6ZDYpHO
 aCDA+TDBz3bgj7/p9vlb6hlNztPUYO+0mW6fwd0vVhk7nahPoF506Br5SL9ktXm0O7v7YqgONcp
 ihisYhSL6HM1IFFg3tXtZT0At36uqsUxk6J2H39fy/T/8iMfKw4qKRZSbmpVoIvym7dJvcDEdDH
 CdPbwp9ULy2I1C847xA4RZYAO/A6WVYiRTJc7ZmedzEdWH9K6/Vuo5z+cyiP+S9ScJgEdp+/IJp
 QsK0QuLv1I5oomMZTYOA9Dfqfg6xUENXyyLFLb
X-Received: by 2002:a05:600c:81c5:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4ba09375bffmr42159905e9.12.1794404518545; 
 Wed, 11 Nov 2026 05:41:58 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01ff3428sm162332115e9.15.2026.11.11.05.41.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 05:41:57 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 13:41:55 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e
X-Gerrit-Change-Number: 2108
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2108?usp=email>
X-Gerrit-Commit: 51425676a1171e901b3d515c34dc11fa4eeb3abe
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 13:41:55 +0000
In-Reply-To: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
References: <gerrit.1793709839000.I571e30bb22ec7bffc2c5fa04fdcd73b52ce47e5e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzA5ODM5MDAwLkk1NzFlMzBiYjIyZWM3YmZmYzJjNWZhMDRmZGNkNzNiNTJjZTQ3ZTVlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <762ea154b48e24421428521f5b8ed035c892e391-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR8aT-000000000oI-1QmM
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Silence remaining
 cppcheck warnings on macOS and FreeBSD
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4516799905919201486=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4516799905919201486==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0pyicOmgIN8="; charset=UTF-8

--0pyicOmgIN8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld=2E

Arne Schwabe ha=
s posted comments on this change by Arne Schwabe=2E ( https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2108?usp=3Demail )

Change subject: Silence remaining=
 cppcheck warnings on macOS and FreeBSD
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:

(5 comments)

File src/openvpn/=
route=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/comment/dab3f78=
1_ec4e21b2?usp=3Demail :
PS1, Line 3336:     const struct sockaddr *gate =
=3D NULL, *ifp =3D NULL, *sa;
> I would move at least the definition of sa =
down to the first use=2E
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2108/comment/8a870273_781e1522?usp=3Demail :
PS1, Line 3409:               =
  sa =3D (struct sockaddr *)cp;
> use the const also in the cast?
Done


ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/comment/2e37895e_e3b4604e?usp=
=3Demail :
PS1, Line 3428:     if (gate !=3D NULL)
> For gate we use !=3D N=
ULL and for ifp we use `if (ifp)`=2E Very inconsistent=2E
Done


https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2108/comment/96da2ca0_c669862f?usp=3Demail=
 :
PS1, Line 3431:         rgi->gateway=2Eaddr =3D ntohl(((struct sockaddr_=
in *)gate)->sin_addr=2Es_addr);
> since gate is only used once as a sockadd=
r_in, maybe it should be one directly?
Changed type of both ifp (replaced b=
y adl) and gate=2E


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/commen=
t/27c2c099_d217562a?usp=3Demail :
PS1, Line 3440:             const struct =
sockaddr_dl *adl =3D (struct sockaddr_dl *)ifp;
> also use the const in the=
 cast here? [=E2=80=A6]
Yes=2E remove ifp and directly assiging adl with a =
cast=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
08?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
s://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: commen=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I571e30bb=
22ec7bffc2c5fa04fdcd73b52ce47e5e
Gerrit-Change-Number: 2108
Gerrit-PatchSet=
: 1
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Frank Lichtenheld <=
frank@lichtenheld=2Ecom>
Gerrit-Comment-Date: Wed, 11 Nov 2026 13:41:55 +00=
00
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Frank=
 Lichtenheld <frank@lichtenheld=2Ecom>

--0pyicOmgIN8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld=2E </p>
<p>Arne Schwabe has posted =
comments on this change by Arne Schwabe=2E</p><p><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">View Change</a></p><p>5 comm=
ents:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/route=2Ec:</p><ul style=3D"list-style: n=
one; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2108/comment/dab3f781_ec4e21b2?usp=3Demail">Patch Set #1, Line 3336:</a> <=
code style=3D"font-family:monospace,monospace">    const struct sockaddr *g=
ate =3D NULL, *ifp =3D NULL, *sa;</code></p><p><blockquote style=3D"border-=
left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I would move at lea=
st the definition of sa down to the first use=2E</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/commen=
t/8a870273_781e1522?usp=3Demail">Patch Set #1, Line 3409:</a> <code style=
=3D"font-family:monospace,monospace">                sa =3D (struct sockadd=
r *)cp;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">use the const also in the cast?</blockquote><=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2108/comment/2e37895e_e3b4604e?usp=3Demail">Patch Set #1, Line 3428:</a> <c=
ode style=3D"font-family:monospace,monospace">    if (gate !=3D NULL)</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">For gate we use !=3D NULL and for ifp we use `if (ifp)`=2E=
 Very inconsistent=2E</blockquote></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0;=
 padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/comment/96da2ca0_c669862f?usp=3Dema=
il">Patch Set #1, Line 3431:</a> <code style=3D"font-family:monospace,monos=
pace">        rgi-&gt;gateway=2Eaddr =3D ntohl(((struct sockaddr_in *)gate)=
-&gt;sin_addr=2Es_addr);</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">since gate is only used once=
 as a sockaddr_in, maybe it should be one directly?</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Change=
d type of both ifp (replaced by adl) and gate=2E</p></li><li style=3D"margi=
n: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108/comment/27c2c099_d217562a?usp=
=3Demail">Patch Set #1, Line 3440:</a> <code style=3D"font-family:monospace=
,monospace">            const struct sockaddr_dl *adl =3D (struct sockaddr_=
dl *)ifp;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">also use the const in the cast here? [=E2=
=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Yes=2E remove ifp and directly assiging adl with a=
 cast=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail">change 2108</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2108?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit=
-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master=
 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I571e30bb22ec7bffc2c=
5fa04fdcd73b52ce47e5e </div>
<div style=3D"display:none"> Gerrit-Change-Num=
ber: 2108 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<di=
v style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lic=
htenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt=
;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Com=
ment-Date: Wed, 11 Nov 2026 13:41:55 +0000 </div>
<div style=3D"display:non=
e"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-=
Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--0pyicOmgIN8=--


--===============4516799905919201486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4516799905919201486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4516799905919201486==--

