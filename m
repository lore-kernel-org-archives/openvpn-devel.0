Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F001D606A320
	for <openvpn-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NeQhkQJA;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DulKdhLI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZxhW//tH;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Xm/yW+/g
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bvQoehU0+iH75MCgi4JBG3SBnmTyeVM7ZSEeqgtJwjU=; b=NeQhkQJAFL+LGrPL6AVZyq9Wzl
	HlrwnANcQxoGljmL0pzqWafrLvanfbiDdwNOJCRtDFyR6TGJOPGbH5pyExOkOE+ZQLqb/iptp2yD+
	G8+grKTMf0882qjZKteVVM1pMeD93i8BH8MpjjfK5jrM64dAXUo/CO6iSIXemQJCQdGw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xU5Bd-000000008Fv-0liP;
	Thu, 19 Nov 2026 16:40:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xU5BK-000000008FY-2gpV
 for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hYQ75RviqGOGvgskGkjdCERL8tRwB2FoCf+VzWOmXjs=; b=DulKdhLIWrbElnDHN8HcAwPVPu
 m3pbV9LFakIWV1iOGKKL35f4WcVcQPgq6mNRFppXeYpr90Q1Ts8AkLn/jb+7WeysF/OB5m0cWtC9f
 ZUT+WcHM1BzBMTrwsq5GQSvE8pNJqd1XtBK6ewjbdNkSrDdcXgUrmDqFzXSRE9JpsNyY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hYQ75RviqGOGvgskGkjdCERL8tRwB2FoCf+VzWOmXjs=; b=ZxhW//tHEBGIm76dD8ZOpQoQNh
 bQVuXMWI7j9EYFxxwAKjSfy5zPLc+3eZrlMTw5BbQ6kLbeLLS05obCU5ScGMaswZG0KRVQIgbpq5n
 tSN4uMU2Rlo4fDgOQ4hIhgDeu8B3AipHkhttEoyxo5b/X9ROub4/mXBRflbbAnBnl+fc=;
Received: from mail-wm1-f45.google.com ([209.85.128.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xU5B6-000000006XN-1JfR for openvpn-devel@lists.sourceforge.net;
 Thu, 19 Nov 2026 16:40:05 +0000
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4bb702a7548so21131315e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 19 Nov 2026 08:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795106398; x=1795711198; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=hYQ75RviqGOGvgskGkjdCERL8tRwB2FoCf+VzWOmXjs=;
 b=Xm/yW+/g8T0KjDvFhtNvXL84hlSrC1VCnkG0ObMJAFnpv14uSsuTaW+lWis8gj1vzo
 ySCjHHo3FGRj/TcrhgoCrUoA1vSkTo2YnqTN3wMISeArrJvkDfNTOxeDYtxXLtJJsNgC
 ZVwbFRqHG961st05xT58ufGlUp8xGWBhWetHoVE/i8rYNnYuHp0d8pQGV6/bJRHa7xHa
 YbChhKwshwIDwyl7kRlG6AEFLuYpHn30DaFIFS+azG8WwStMSubsIZEHT+6rMXrbSfPL
 D+hTSAZkiewSr0f6egTz4es78wLT7/tSO9PcZjLvarG8qs7wntAfhS1hty4bofOJQLrI
 RUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106398; x=1795711198;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=hYQ75RviqGOGvgskGkjdCERL8tRwB2FoCf+VzWOmXjs=;
 b=LnDs7CU1bfEhYpm/XT3tjGhpINpa0U+mYAMGmgnSahY+P3uN0Zo2phRbIspYwSTzxR
 85dsCO2Gi9mdfNZKJa4Xl2RQNBLzhOrGpqZGNVenxbNL5YUSN7cr2xYStXEl0vvZIsVh
 ISV+ar9/EMNLRAorRDWSBCiEBMILTv7jS4dhQWTH9ResX1E+0xO2qXHrkPTNx6nPj2qV
 j8/nhdrMuwaMMo8iwqh+wPl3RpaB2N9UqPjm1GNdowiEc9phnJ+IQP4G5wyxSLCReCET
 Imq37YDdPZC6wMeV++k/vEw/D7MHPZdhBqzgdtpNXfQZ4+Hou1O/r9J5CIzF4VP0zPIz
 IvPg==
X-Forwarded-Encrypted: i=1;
 AL+hErEflIzpRwcbNcdgKrb8ET4fcVDpw+AkjNPtA2hZaUEF2Uk8JGlQVQJsCAZFqNz2zd1WwcyUqOWQmS4OPu7w@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Hk/gk2aqKeP4o7QMYpy+DxYux36CXI/rdV/iRJCEe6T+zfg0f
 NLYvR8Wmeo+oimOyvZF4e2NcRqTnpxGmdQ2eECdD3KxwaMxrgNqiOQHIBb8F0hxgL1mgcRzxhjG
 24rpsDHwBToDzgcyf4M/dCJM+BKGUy6yypnvvdoRADIu0Goxgi8CQWFGs5J3O6cC5ctptRJ614b
 U94ErB4w==
X-Gm-Gg: AYBFou2BanxKqLq8SeFvwSv9Pm9daBkFHKBkyMMkDOXqOi0Lv07Ji8MN3CrALLuvBbh
 iAzEUaX2wKA9F6i0VyAAS3XrU8zPKaw3wbJC3A+8hAUFzLCRVwtY/FKAUWYk5k5gS9Yl+07M+lB
 IiRSMEuZe9oX1+YggSXF78z/cQXKKbY7ycKB9QAzMcpTlxcqReW2KwJRr5JJbq0EhsvVukKty6a
 e1afEM46sn7B/ztacEHV3AKP1WPLdZwsWRIA24hujhQ1LsJezuUjKr0DEWkF3Acc5aQ4Hll7rwO
 uvnjVKuya86Gs2uo5r0djGhCAqXdsJqskvK/TZ+MHdyu9U7Kxa4bd450Ye7OaJQjDM7WsztwleT
 sLZwdHmI/QstAXL3wXC6d6bvr/YcTqu0kIxVONRSLcBkC3SraH3fFpbYldbiZjYOPRVuRXEiOJ6
 dSJ4PUO0vvVZ24z87TNE4UHgMNY3vos+OqxYxP3SQLLhAqreEh7gM/89dGTBTfc3xmnqRcRgFpc
 f/kOhxyxzqy0vF83bjspgzoz8PG3XQneMo3RSUt+aUuoB1mxWKpPFErXHvuak3bOGzRkgdZsoc3
 bb9mPcQPfwYzktFb7hxtSYC0scnh322uyZbYVYNqzYMCow7QDt2uPwYXLHQjIWpqhufS1FDp3Yg
 tri1JXNVd4jss+qX2x3L5EaSDx5mJ/rJn82ljgKlpLL5+1LK+WxPEhzqyZMSwK2N9Iw6nQ5JU2W
 eqd3TN+I4ot/yw/Mo=
X-Received: by 2002:a05:600c:468b:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4bb8881b511mr998615e9.18.1795106397594; 
 Thu, 19 Nov 2026 08:39:57 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8526cbd0sm60279755e9.0.2026.11.19.08.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 08:39:57 -0800 (PST)
X-Google-Original-From: "Aravind O R (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 19 Nov 2026 16:39:56 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2
X-Gerrit-Change-Number: 2213
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2213?usp=email>
X-Gerrit-Commit: 28db47113dd19df5188c5f995d49c648e2c54c0a
X-Gerrit-Comment-Date: Thu, 19 Nov 2026 16:39:56 +0000
In-Reply-To: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
References: <gerrit.1794933726000.I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0OTMzNzI2MDAwLkk4ZmUyY2JlYWRkZTNiYWQyMTg1YzRjZWU4MjRlZDJmZTMwN2UyOWUyQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <26ef1e230915b8f7d7e517732e828c00a00db5c1-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xU5B6-000000006XN-1JfR
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure: add
 compiler and linker hardening flags
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Aravind O R \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: aravindor@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Aravind O R \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============9097512996425004939=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============9097512996425004939==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/091dGB6ffs="; charset=UTF-8

--/091dGB6ffs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Aravind O R has post=
ed comments on this change by Aravind O R=2E ( https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2213?usp=3Demail )

Change subject: configure: add compiler =
and linker hardening flags
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E


Patch Set 2:

Patch set 2:

* The selection rule is now in t=
he comment and the commit message: the guide's run-time protections that Fe=
dora and Arch apply to all their packages, and Debian with hardening=3D+all=
=2E The commit message lists the guide flags that are left out and why=2E A=
 correction to my reply on PS1: I wrote that these flags do not change what=
 correct C code does=2E That is not quite true (with FORTIFY, a printf with=
 %n from a writable format string aborts), so the rule is now only "what th=
e distributions already apply"=2E

* Adds -Wl,-z,noexecstack=2E It is the d=
efault for compiler output, but gold, and GNU ld as built by Debian and Ubu=
ntu (checked on Debian 11 and 12, Ubuntu 22=2E04 and 24=2E04), make the sta=
ck executable for an object without a =2Enote=2EGNU-stack section=2E

* Fix=
es a precedence bug in PS1: GCC 14 and later combine repeated -fcf-protecti=
on options instead of using the last one, so a user's -fcf-protection=3Dbra=
nch ended up as full=2E -fcf-protection and -mbranch-protection are now not=
 added when CC, CPPFLAGS or CFLAGS already set one=2E

* Corrects the FORTI=
FY notes: glibc 2=2E32 and older treat level 3 as 2=2E


-- 
To view, visit=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail
To unsubscribe=
, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/se=
ttings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e2=
9e2
Gerrit-Change-Number: 2213
Gerrit-PatchSet: 2
Gerrit-Owner: Aravind O R=
 <aravindor@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Thu, 19=
 Nov 2026 16:39:56 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: No

--/091dGB6ffs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Aravind O R has posted commen=
ts on this change by Aravind O R=2E</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Patch set 2:</p><ul class=3D"blocks=
"><li>The selection rule is now in the comment and the commit message: the =
guide&#39;s run-time protections that Fedora and Arch apply to all their pa=
ckages, and Debian with hardening=3D+all=2E The commit message lists the gu=
ide flags that are left out and why=2E A correction to my reply on PS1: I w=
rote that these flags do not change what correct C code does=2E That is not=
 quite true (with FORTIFY, a printf with %n from a writable format string a=
borts), so the rule is now only &quot;what the distributions already apply&=
quot;=2E</li></ul><ul class=3D"blocks"><li>Adds -Wl,-z,noexecstack=2E It is=
 the default for compiler output, but gold, and GNU ld as built by Debian a=
nd Ubuntu (checked on Debian 11 and 12, Ubuntu 22=2E04 and 24=2E04), make t=
he stack executable for an object without a =2Enote=2EGNU-stack section=2E<=
/li></ul><ul class=3D"blocks"><li>Fixes a precedence bug in PS1: GCC 14 and=
 later combine repeated -fcf-protection options instead of using the last o=
ne, so a user&#39;s -fcf-protection=3Dbranch ended up as full=2E -fcf-prote=
ction and -mbranch-protection are now not added when CC, CPPFLAGS or CFLAGS=
 already set one=2E</li></ul><ul class=3D"blocks"><li>Corrects the FORTIFY =
notes: glibc 2=2E32 and older treat level 3 as 2=2E</li><li></li></ul><p><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demail">View =
Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2213?usp=3Demai=
l">change 2213</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2213?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I8fe2cbeadde3bad2185c4cee824ed2fe307e29e2 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2213 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arav=
ind O R &lt;aravindor@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@licht=
enheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-dev=
el &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Nov 202=
6 16:39:56 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No=
 </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body><=
/html>
--/091dGB6ffs=--


--===============9097512996425004939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9097512996425004939==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============9097512996425004939==--

