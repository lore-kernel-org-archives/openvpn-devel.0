Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF52606A31E
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=NfFoWPoK;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=OIB8FO1k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l1+vf8ya;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DANBOA1u
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VV/UNWiEW0v+z5+OL7PYJo26KPfQyMyJHChoVlZ5s+8=; b=NfFoWPoKJORg1E4dasirTlTy8K
	k7LtbaOVdZqxUczhNSKMiZ0MiXy8l0/sqJz/ywkpjgd7fqN0T3NGdY5JnO4L9g/dLoGj/jbySZzlI
	J5uD7vjfV0yiFoFcbfOnKZAhI765GxnBD3dyaGnjR5JAE+doI0OL5cYrW+S457HKWdU0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVmq4-000000003HW-2eiF;
	Tue, 24 Nov 2026 09:29:24 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVmq3-000000003GJ-00wh
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 09:29:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WGv1PBvIF5vn8McAOAov5soyAiptFEfnuVBCvTh6org=; b=OIB8FO1kUtR2qwoeZh+fTYqcRR
 jygq1AUejGH4R16434zCDdR2+nb/i73vtytBunL4nrNmqfyWuTMHtZdgh+rzWzWDh4lB1+eT3r7+2
 iRMIa6t/nSUqOD1JGHWcBB4lQRqoYVk6Q3AcKRfOCcnD7RNzPkOqurSXMQ/ijy21/Gf4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WGv1PBvIF5vn8McAOAov5soyAiptFEfnuVBCvTh6org=; b=l1+vf8yaJCbr5XjTAaUZMd0FoN
 7JyCwFhVd/4fEp5PIhiB2PdoagSLjjBd/QQwXNt4L/8PqweijeApf4fNlL1kBTWSE4CoG813ylCHf
 UTVw3pY2MjgUL0jk+zyBXpxw9bSvMrHQw84/1wIF1PUxMJPOKlFErGdW01JsKsAoALSQ=;
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVmpz-000000005Wy-3ILp for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 09:29:22 +0000
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so39130805e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 01:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795512553; x=1796117353; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WGv1PBvIF5vn8McAOAov5soyAiptFEfnuVBCvTh6org=;
 b=DANBOA1udFdK6BDeeoDDNHzrYkWjaptvXunlFlm1SUCfI6K9eSkmsE1YYg69BxDtAr
 /KWUtJFi4t5PN0bGNH/5UoeLPL/hriIDmodDDm5BIoUJtYWZPrPqaU94NH0ohaJ3Psn6
 KagRyMs4IHAiTp2pDoDZ1y/WOQkyzsR9BsEShyizqEaz/zYFcSTNM99xcj3fLZbCCagS
 HEiTQpnVAO3ppVsEyM3K0jBOhs/wkUvVqf/3o/ZbKO1U4BxW3NRBkKT4TySlNP4HWVj/
 RYf64U8ItIw0KDiz4ROQBe0+cCafWP4n1XKC6ojhnl2ivGAE3uW6uXT6c8iblA136bwA
 tMpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795512553; x=1796117353;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=WGv1PBvIF5vn8McAOAov5soyAiptFEfnuVBCvTh6org=;
 b=J6SAMDdNtKpE4wuxC3Df/v03VOFUjPPyomnRxvNUgFyra/p+d7wAM+QxPMarPIYcka
 yPTgy0UGF5df/5Sr67p6vczJmqvENxfw2ANxGh0ddDSEN4jgckPS+yovWxCTqGWBip19
 TBbRER/kfKPc3H2tP5iRNEr9KTtJo1ZeeBBqzojr1JGc2t0wmV/aZFU30pgEpfKY4Dln
 g22aDZ8VgdimniCEPEOmqbNKWNnqURqGdaFjVRVPIHtLIjZx1HDHqtgSWrl404/sDkoE
 hvBYT+lP12cwyHHuT5CVT1qjz3tFSmJ3ycuIDVsKOBVGl03rom3kIJNiG6hTPHRxK46S
 qmcw==
X-Forwarded-Encrypted: i=1;
 AL+hErFY2i1trbGzBw0Q4EtPtqBX4tnOcr0qMOZMHnv/d2ADOUZ9vA9Bj2o3RCv6e2foEDayuIW2ecs8lN5hWTcw@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8FtDDOZwG1Wu7m0b0xMv80BL1/9x4ODqtzGTzqH0zpwERkliB5
 L8Gp21ULjv75TEZk0Vg4vRCfYOKBapGN+whl4olQ5pDFl3hXewJvlh+ncKSuq3IHUTnwei5W1sj
 tjGeuRlCSYEDGw7WkKtTQIXURfwFDHSW51fAp0crvig/sUFFD97ylENuG1wouyfGMf8AOBy68m5
 pEKSV77A==
X-Gm-Gg: AZFdTZcon5nU2etX0vR9xLLmjqp2KpctkUebdiJqDc0Ngwk+qGH5/IAdEFQoOEqjyDQ
 7XWm0nQZwYKFBVZEjY3PsJRSBmR9Ds4jq2vLIk+RJ8eaICdVajdj4xeercrLjqLSWJII9NR5uYY
 9isdLGMJJANmAyNJ3U57tUO1+lokTIw9rfUeisLE3LrTWGxGsOoowC/IYOTMHy7+8OuSOw1aYk3
 KHFCBvaPmPSBulIj+b38g+8pmCHSRvJ4an4I+lcsIucvICqN9QJ1K9b6laQk4/YP6NWPSla/iC/
 ucC5ex3OgKs54yLuUeXqLtjEZwaNRqOzEs0IuLk+Py8z9nHvWc+LLM/zqRqiHs/pp25jKsgci99
 0UHNCeHUhbsOUpfjFuDm5WkwdFUGHEYBg5ai7bCMHKhjYTO94TabVS6oIbGXb2+tP1pFX1zQitS
 kN4daQ4IPvp19tvV40cwkM8PY62NDkG7DTPkPGq3vOH9PPkgZr3unLnjhXBiHKM1x/XXoaGIEpw
 eiIosnESZpNspwztFHgOUjIXsIsC3+j8OgV98wMFkdDg+2WTHc5jcPupk5Vxy0NgZv2tC+Hp5o7
 MYdDqLhQ2yRMxihspcG1jZ7Zy2gETYcD5AKtCU0hX5W6g7a0TL9k5+QX63kxsYgFOibkcvaJuRL
 08z4En5lCdkvxEYJBxdGhBR7SpPY9lWefymrApLz+kH6WW7Xlwo+XElez0fzC7r1pEJeFkO9XgH
 54kFGmmplVLZiebyA=
X-Received: by 2002:a05:600c:8b11:b0:4a1:df52:3e36 with SMTP id
 5b1f17b1804b1-4bb8881d194mr294421925e9.27.1795512552953; 
 Tue, 24 Nov 2026 01:29:12 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4b1ed8b6a05sm10701425f8f.43.2026.11.24.01.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 01:29:12 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 09:29:11 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
X-Gerrit-Change-Number: 1981
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1981?usp=email>
X-Gerrit-Commit: 483a821e6827a0e029e41394b7e635de2b9773af
X-Gerrit-Comment-Date: Tue, 24 Nov 2026 09:29:11 +0000
In-Reply-To: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
References: <gerrit.1791286452000.I0051effe7f0636e30557d9ce92c50c458002f9e6@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkkwMDUxZWZmZTdmMDYzNmUzMDU1N2Q5Y2U5MmM1MGM0NTgwMDJmOWU2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <ea8ae7ab014dce850a056cbc02233ba766668408-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xVmpz-000000005Wy-3ILp
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: detect local
 kernel capabilities through netlink policies
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 ralf@mandelbit.com
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7519228091383449511=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7519228091383449511==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="falX1/2twGc="; charset=UTF-8

--falX1/2twGc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gianmarco De Gregori, R=
alf Lici=2E

Antonio Quartulli has posted comments on this change by Gianma=
rco De Gregori=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3De=
mail )

Change subject: dco: detect local kernel capabilities through netli=
nk policies
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


=
Patch Set 3:

(1 comment)

File src/openvpn/dco_linux=2Ec:

https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/040cfd1e_2e3040f0?usp=3Demail :
P=
S2, Line 113: /* one row per capability; a row on a command of its own cost=
s one more dump */
> I went for the full dump approach during early stages =
but then @antonio@mandelbit=2E [=E2=80=A6]
as discussed=2E let's go back to=
 the full dump so we avoid any ambiguity=2E



-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch=
: master
Gerrit-Change-Id: I0051effe7f0636e30557d9ce92c50c458002f9e6
Gerrit=
-Change-Number: 1981
Gerrit-PatchSet: 3
Gerrit-Owner: Gianmarco De Gregori =
<gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc=
2549=2Eorg>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: An=
tonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelb=
it=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-Attention: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Commen=
t-Date: Tue, 24 Nov 2026 09:29:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-=
Labels: No
Comment-In-Reply-To: Ralf Lici <ralf@mandelbit=2Ecom>
Comment-In=
-Reply-To: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>

--falX1/2twGc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gianmarco De Gregori, Ralf Lici=2E </p>=

<p>Antonio Quartulli has posted comments on this change by Gianmarco De Gr=
egori=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?u=
sp=3Demail">View Change</a></p><p>1 comment:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/d=
co_linux=2Ec:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981/comment/040cfd1e_2e3040f0?=
usp=3Demail">Patch Set #2, Line 113:</a> <code style=3D"font-family:monospa=
ce,monospace">/* one row per capability; a row on a command of its own cost=
s one more dump */</code></p><p><blockquote style=3D"border-left: 1px solid=
 #aaa; margin: 10px 0; padding: 0 10px;">I went for the full dump approach =
during early stages but then @antonio@mandelbit=2E [=E2=80=A6]</blockquote>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">as discussed=2E let&#39;s go back to the full dump so we avoid any amb=
iguity=2E</p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail">change 1981</a>=2E To unsub=
scribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1981?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ger=
rit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mas=
ter </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0051effe7f0636e3=
0557d9ce92c50c458002f9e6 </div>
<div style=3D"display:none"> Gerrit-Change-=
Number: 1981 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
=
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &lt;gianmar=
co@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-CC: Antonio Quartulli &lt;antonio@mandelb=
it=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &=
lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gian=
marco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Comment-Date: Tue, 24 Nov 2026 09:29:11 +0000 </div>
<di=
v style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"disp=
lay:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Commen=
t-In-Reply-To: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"=
display:none"> Comment-In-Reply-To: Gianmarco De Gregori &lt;gianmarco@mand=
elbit=2Ecom&gt; </div>

</body></html>
--falX1/2twGc=--


--===============7519228091383449511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7519228091383449511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7519228091383449511==--

