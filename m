Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C21F606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Qspve+ou;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Cpy6Fur6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Toem5OIB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=O42JCVZ/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UKGIAyVjw1CRkMCIEbgFaIrHPataSdOysUfEsC/NMWQ=; b=Qspve+oukcNt4erBUX4/QY4x00
	zQxjRLxMXXuETdRiQfoLsFndS0aFfr0d2qMXgak2ZzmldwfmUubS5uEEiuWQhLKpJB0J05Z2ROc1o
	B6ej8FRHCUa78rXXgy2hH4FI0nmVsVuLmSD1Puqm4P9ho1dBmp+CRseOyZIuTsLF3s8Q=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOcql-000000007sT-3D2n;
	Wed, 04 Nov 2026 15:24:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOcqk-000000007sM-3CRe
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:24:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5IG3MCjOcIGXYWJJzHg/eAdrYHIm2WfdVophcSBtICw=; b=Cpy6Fur6NwCO0vgKe99UBD3Hie
 spNkKtErWI90GWleZYd9Ixl0OMY8YKqILkwgjeaGzdK94hXUTuoRInAMchUQbsuD22hAdxL6AdYpa
 AiHXwBdYniHxhwdwgIw+75crV3EwdbziEK+cpbdYrt+HTnhGpvbu4zRmL2ALcZkUfHeQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5IG3MCjOcIGXYWJJzHg/eAdrYHIm2WfdVophcSBtICw=; b=Toem5OIBFfMp+F8F8uNwAR8e8i
 FfXLevhqey+0PZ+zYLM3jdkeqmY35NBAgVeQlU2O9UaC+25FsAsaONCluf1/l+hHhwbMfowSvPlbc
 cXy5N4CEt9SArxVe0w0nGgpmB6BDsxlGEMjhfxfV10hqJqRKl/ijliuvRIs2sYs0EfeI=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOcqj-00000000787-3Roi for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 15:24:30 +0000
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso444985f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 07:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793805863; x=1794410663; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5IG3MCjOcIGXYWJJzHg/eAdrYHIm2WfdVophcSBtICw=;
 b=O42JCVZ/lQmw/7Bqm2SDCFEyNWgSGlJuG5owq1gq9fdz05M34qbwDXPGLnQ8XcemNF
 I03I6HXI3TSfEypRjn4YEjoQn+exYIK2ruyFgmqeKIUwPnxIhu67atdBn2SQN3Vq4K8g
 NFbCb9k0bvbGrU1MUKiN/CCbDJXmFjk7qGUinzPFosY6VNwR0P/MZHDscnLhB/i5/3G1
 TNUUuc0mKpMpVNzzLgTwKzoKHsyWp5pQgMHuylo29oOfT6UY3eNZPYqyksjFejfNxc4E
 dgTzoLZ5dMg6BNe3YgVpubPMRTn65wYsyVimih7CabFppMRgiEB5oErme9kHkXU/Hnkx
 unKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793805863; x=1794410663;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5IG3MCjOcIGXYWJJzHg/eAdrYHIm2WfdVophcSBtICw=;
 b=Qas32V6OPMCgn8r8R2eTYoefY2yyKtAeA7ahfON08n/cbfq4acNUbvK5QPrBgzuAk2
 xoR+AbC+sUWMWO+bFWyTUSSjPT4M6IKAJnkvnyDu+2hZdDNmcrso9g3fMb0K4LcFvR93
 X7Lo8Sw+bbHUcI0UpiaKzhx7BrigY86oo/rjwizcJbsRTCMyyNyOkwj81uuYNVFOCIvU
 FdfLBnxFouGm3XtS65MaTD27hUO8Ks4tedpXypjvWaKPoLhSfH94QbKT8OTAn4zXqsqM
 XdaI+FrWZY7ebhBRVwHiiv7OMFs5aL5AmkNuPwRR7FMivREELzD9flFNfJt8h8oZvZOw
 RenA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOjh7XByfq0cy9SEWXEkIAMvHS42IZJ774ZBWdQfG6XX/wt8p02XHAyXz6G4QsQCXYRNL9u0OadqOsVC0F@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/a+9QxqaKbKlAGfmOXPccf9UIm832jhREnMfioSnr4vBAmvrm/
 hwY5/GvVkdXfhFi+du8yse5N5F8kWfj+DKA8Avuu5D+JV/pvk9IGfcNYR21Ot7bd1gJQrQIimZ+
 295fLiz3KgG+M+hl1xY2hEDoNnh6OZj0y1EhvrvMZ5f9FExLWG9LbywzC145QguS+9vk4
X-Gm-Gg: AYBFou2MDve4mSDThvv1XulivKkJ7QRwHeiQLUtUtsRgZbr+uzJfyI1RoVwKA/zfO7w
 T6ZttQP7uEZQkkfRp0hxtfPYJV/qREKF5wshDb+ZWcq/mRVUCHb/NTZhinnz/xrsMng22FCw1GZ
 AgAC4ZgSW+3GVXHoLncQygYlWe/BKwUPq411bpPQEBmHXY+CNpB0/m1J52V/1mF/4Z/I/GcoUyH
 neyhD0/bmLQ8i8zhB8hPYTHoTGTsD14aZD7H9koQfa2yLivfSCMAsjjVgSdcQv/L32PocMfAzAN
 QIU9UGP9QtnhmM1JPxkBUXTmV8b0BkLZN5GxaYzJeRevPpynnLk7A8XSd6hevSUrVYUdUk8f59g
 OISlT/OVT13956KwgJJ/F72xxknwNrCWsme8HUPK2DX6DTM+0AecZmmmBuBJDX9E0TxDMIw/zOl
 43fbpRQvgi+rMTiSwg6Mb++goBu13kT1qx7dfwVTokFMtxm9NvUp7JxBzI7tuJkgVSncFL9PRqN
 3VaPdrSwlXzpgQDNNEdjzENzOwavPyLPOE5InvRBtoPmYr7MIrDC3h8mf2D8tqHQ/34Z/kBCYtO
 Wd3IRvJNSphEjG4l3fmvzDhYU0L0gBA1uVA+xCKWs1yyMlbiRzeBxPrDDpN9XRXS5TdmbviQv6v
 0Wwx2ImiIeQaiAo6DBHrufHlFOGk9zX00FHg4mloVXmsFcP39/zSCBMGzy6xDPhjGMNeh97wkgi
 e6kam/d+TLv8F10Q==
X-Received: by 2002:a05:6000:40dc:b0:48e:412:3829 with SMTP id
 ffacd0b85a97d-48e6e3071f9mr37800843f8f.15.1793805861988; 
 Wed, 04 Nov 2026 07:24:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fece99b33sm4210286f8f.23.2026.11.04.07.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 07:24:21 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 15:24:19 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: I24e5925a72aaede53ef9e863fe96fcd7363df402
X-Gerrit-Change-Number: 1915
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1915?usp=email>
X-Gerrit-Commit: 784196dabfe07410b20b9197bd46d58894aef69e
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 15:24:19 +0000
In-Reply-To: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
References: <gerrit.1789395512000.I24e5925a72aaede53ef9e863fe96fcd7363df402@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5Mzk1NTEyMDAwLkkyNGU1OTI1YTcyYWFlZGU1M2VmOWU4NjNmZTk2ZmNkNzM2M2RmNDAyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3699a192e7d7e39a22641a663977050e9f0d5d12-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOcqj-00000000787-3Roi
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Let an
 optional UDP socket give up on a failed bind
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8952641226013154349=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8952641226013154349==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="btkQn0y3PmE="; charset=UTF-8

--btkQn0y3PmE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Ralf Lici, R=C4=83zvan =
Cojocaru=2E

Lev Stipakov has posted comments on this change by Lev Stipako=
v=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail )

Chang=
e subject: socket: Let an optional UDP socket give up on a failed bind
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 11:

=
(4 comments)

File src/openvpn/socket=2Eh:

https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1915/comment/9779ec73_c167a611?usp=3Demail :
PS11, Line 343:  *=
 non-fatal level and checks the result=2E
> Then if you agree that `D_LOW` =
is not great in all cases, maybe drop a line about how log levels cha [=E2=
=80=A6]
Without the conditional above, the function doesn't vary the level =
=E2=80=94 it uses what the caller passes, which the existing doc already sa=
ys=2E


File src/openvpn/socket=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1915/comment/1ba5f4f0_659e43b3?usp=3Demail :
PS7, Line 965:          =
   print_sockaddr_ex(local->ai_addr, ":", PS_SHOW_PORT, &gc));
> nit: Shoul=
d this now print `cur->ai_addr` rather than `local->ai_addr`? `local` may p=
oint to an entr [=E2=80=A6]
This was in pre-existing code, but fixed=2E


F=
ile src/openvpn/socket=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/191=
5/comment/00884d33_585f7756?usp=3Demail :
PS11, Line 324:         && !socke=
t_bind(sd, bind_addr, af, "TCP/UDP", bind_ipv6_only, optional ? D_LOW : M_F=
ATAL))
> Would `M_WARN` be better than `D_LOW` here?
The caller already log=
s "no usable IPv6 socket, not probing IPv6 remotes" on failure, which has t=
he context this one lacks=2E  I'd rather raise that message in the server-p=
robe patch than warn here and explain it at debug level=2E


https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1915/comment/815e7277_f75938b2?usp=3Demail :
P=
S11, Line 588:         msg(msglevel, "%s: Socket bind failed: Addr to bind =
has no %s record", prefix,
> `msg((msglevel & M_FATAL) ? msglevel : D_LOW,`=
?
I'd rather socket_bind() log at the level it was given than override it i=
nternally=2E



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1915?usp=3Demail
To unsubscribe, or for help writing mail filters, visit=
 https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: c=
omment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I24e=
5925a72aaede53ef9e863fe96fcd7363df402
Gerrit-Change-Number: 1915
Gerrit-Pat=
chSet: 11
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewe=
r: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ra=
lf@mandelbit=2Ecom>
Gerrit-CC: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: R=C4=83zvan C=
ojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 15:24:19 +0000
Gerri=
t-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: Ralf Lici <ra=
lf@mandelbit=2Ecom>
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>

--btkQn0y3PmE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Ralf Lici, R=C4=83zvan Cojocaru=2E </p>=

<p>Lev Stipakov has posted comments on this change by Lev Stipakov=2E</p><=
p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail">V=
iew Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket=2Eh:</=
p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddi=
ng: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1915/comment/9779ec73_c167a611?usp=3Demail">Pa=
tch Set #11, Line 343:</a> <code style=3D"font-family:monospace,monospace">=
 * non-fatal level and checks the result=2E</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Then if =
you agree that `D_LOW` is not great in all cases, maybe drop a line about h=
ow log levels cha [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Without the conditional abov=
e, the function doesn&#39;t vary the level =E2=80=94 it uses what the calle=
r passes, which the existing doc already says=2E</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket=2Ec:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1915/comment/1ba5f4f0_659e43b3?usp=3Demail">Patch Set #7=
, Line 965:</a> <code style=3D"font-family:monospace,monospace">           =
 print_sockaddr_ex(local-&gt;ai_addr, &quot;:&quot;, PS_SHOW_PORT, &amp;gc)=
);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">nit: Should this now print `cur-&gt;ai_addr` rathe=
r than `local-&gt;ai_addr`? `local` may point to an entr [=E2=80=A6]</block=
quote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">This was in pre-existing code, but fixed=2E</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpn/socket=2Ec:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1915/comment/00884d33_585f7756?usp=3Demail">Patch Set=
 #11, Line 324:</a> <code style=3D"font-family:monospace,monospace">       =
 &amp;&amp; !socket_bind(sd, bind_addr, af, &quot;TCP/UDP&quot;, bind_ipv6_=
only, optional ? D_LOW : M_FATAL))</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Would `M_WARN` be =
better than `D_LOW` here?</blockquote></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">The caller already logs &quot;no=
 usable IPv6 socket, not probing IPv6 remotes&quot; on failure, which has t=
he context this one lacks=2E  I&#39;d rather raise that message in the serv=
er-probe patch than warn here and explain it at debug level=2E</p></li><li =
style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;">=
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915/comment/815e7277=
_f75938b2?usp=3Demail">Patch Set #11, Line 588:</a> <code style=3D"font-fam=
ily:monospace,monospace">        msg(msglevel, &quot;%s: Socket bind failed=
: Addr to bind has no %s record&quot;, prefix,</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">`msg((=
msglevel &amp; M_FATAL) ? msglevel : D_LOW,`?</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I&#39;d rath=
er socket_bind() log at the level it was given than override it internally=
=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1915?usp=3Demail">change 1915</a>=2E To unsubscribe=
, or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenv=
pn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=
=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1915?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: I24e5925a72aaede53ef9e=
863fe96fcd7363df402 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 1915 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div=
 style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Comment-Date: Wed, 04 Nov 2026 15:24:19 +0000 </div>
<div style=3D"display:=
none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-H=
as-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: Ralf=
 Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Comm=
ent-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
=

</body></html>
--btkQn0y3PmE=--


--===============8952641226013154349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8952641226013154349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8952641226013154349==--

