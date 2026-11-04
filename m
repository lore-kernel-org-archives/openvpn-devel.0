Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB22606A332
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lt5p4u7D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=V25Q6+2D;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=cMV42UYx;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=N1cCPfNX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4f2AzGSMrXEyV0WqcQLpUEE7BZ6Icpb9j9IUQpkwUGc=; b=lt5p4u7DhmTLj+LdkfEvfXkhGo
	rW27/D/R+ZDNZh2xnFT8e7Ygk2aUKuw8ML2pGI4wanBFQlRR1mIYfghZ74GxQB5HOwzQavyCTeSio
	383o0iUf4ssUd2kc+BoE42WU4UiG69WI5IwO6EwVEKFEig3nLQ7xBb2gjRASJDa3Hqr8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOdiJ-000000003Mi-04ce;
	Wed, 04 Nov 2026 16:19:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOdiH-000000003Mc-1ZIG
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:19:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dih532IGPlpEWW6izR2ShUMKgEwqyOWbFn0cnX715Kg=; b=V25Q6+2DbYFiI4oU2fwEE3dIuq
 SvM3ka/SJLndvbSJQ4/StNoN5XYdkUGxzAPe/TPAspz8TwCQPnpKaTONGLOgNYUm/z/1g1Fss8vcq
 xH59cLF1fDSxtAw7ysuQeyLC36fQmQ7WVGHBwTY02CYGjX4/41lIPiD18TW3p+QOjdIE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dih532IGPlpEWW6izR2ShUMKgEwqyOWbFn0cnX715Kg=; b=cMV42UYxe7FTICGDGtud2QuIxn
 s3p4h2q5o4lTtxhwS2MojNf9Sgg4wFu4XLXF7eU+ROdDfUvVjxoYbPS4Y9PxTaJeGUfGlNZl9Nd6U
 p5Ca/NxYZ7lo3BQw5LsijJJpgAp8LRl5X3/6AnEV29jL17WOeWuRwitS8Engr6BWDIzs=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOdiG-0000000068E-2dh9 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 16:19:49 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a5036bbac7so5669785e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 08:19:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793809182; x=1794413982; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dih532IGPlpEWW6izR2ShUMKgEwqyOWbFn0cnX715Kg=;
 b=N1cCPfNX3d5vifCtKlOPj9wfrja3mbtb/2UjRd7eMTvzr/KYm+6iebx5olBiZ8j6Mb
 3jiyKam1FBmnndC+OXZEcVmqhBqf6s0OfDIKEB70fX0R+9Ddhcl0qgKJTP3hcOGG0KBq
 pxfgDvRNnp/tyBqJ1Qx4U48mdOK56e8T3myk2HzMhKLJG3SXKc2fpYLidXrTR48oQZ4v
 +IikkWw125dErnMp5PREGzNw5QltjOCe3OqsTrW6/q/jD6N4qkI+ZQQlIoRPAe2MyfkC
 MlJeJozn8dKtq1zirxVK7cNcHE2Y1oyIvpZ5aLMI+4cFlbLS2DHb5qX7dSgK9tSaM7uf
 pq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793809182; x=1794413982;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Dih532IGPlpEWW6izR2ShUMKgEwqyOWbFn0cnX715Kg=;
 b=yQGvwju+OarIQ6fo3PEiIbM21X3QyCD3OWPz+USDP/lsUYfRoqX+snb05jroHfmw1T
 jX7JpB8uzZHbnmXO1qfS6+vNoLuazFOjZX4ItmHUH/hKMLjN9cWCc8C8iOGbz1jQgDiF
 +kFe03M6udTyAMZmxQgtw9wiubBQab7W+qxi6O4gqdLsdk9y0hnm4Lr7kesssdiJEaIO
 GxEOjYLqXVE2qtG1Diu53Q97Sn1+JyaMslcVT9jfu5j7zJdaTI6epUT/K1Cn8lptF1Hx
 cvwBxhDMhtyRnO2G9BgS/n9k4hYqiHG8jP+WN/+IgLbZVGGSG1zCe2v5aMjbr5fBJDix
 fDAA==
X-Forwarded-Encrypted: i=1;
 AKwUvByGL0dgSqJo+TlCt2olQSs5HImwuY705iC3D0xgSXDy2Cn1nVS9BjhvWuSgNwjxVLKITsJ/xwVYJ36Mhxb0@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+ssIDwahwUaK8ZAhE5lp98c07LV4shcq5fbuwEAaHAbpkfGL/W
 BK2aHy10GTIhU2yVITzwSrZPYXarGTKlFwSY9W957QWqFToZqeSw1VsA/+4SbSTKzSU3eofc46j
 8VZDibcGUrnS/icFXZ1VcR82fsWfY4EmpeRZlCo8TIa4AnQvxCaBu9X3EImBqvCvztE+x
X-Gm-Gg: AYBFou0eDX1VNqEfb3dQlE+mWZ2mudN+KQ/gFyCDr443bJBsRiJfuUnFPwbAYxt/JYT
 npKdkyQSwNYp3pZHd9EF9jydE5Y8ZTRX5zR1GBskU1JzGjnnNE9Ntr4DAhMLBGoOyM/nVTIt2S9
 KGOGszU2I1WJ8ksP+t63i7CerqgrhmjE3VuYuKlCf1RqamibZadP8c2wo+jOurXLRZwfQaft/qY
 fN/XeGuh2dATQqoSYWLwW5GNzBLb/WuZ2c50xNTQ/jETtVApA9RL0Ydwcrz33Jkn19Lx49IyM7B
 MQz93xMHjyTDucSUFB1ZAPX0kGl+P59oFHhD10eJj9a3WNZ9ucL2UF7c1ey3kSeHxdQJrfAid6V
 lUXFlMidThSD+rk3Mi9D3O0RCcMrlKCmXsro0SRJpW6VmpQqRtiWM8HvXWpZEIKqVDj07q2XYRB
 NWkyFavP6Ft8rg4xoe2C5vIK7UmyPl9ahQrIR62quQ6ZFKsnI3XemC0zbIdxMkRYCL+eus0j8j1
 hAa8HkPzFUn0uy1tA/w+QGE918LJOO1+9BhGPOE5i/i+3VaAyjqLTYa7rsyd7R1Oh1AFKyKPP+I
 1n/wdMUe/hT/yMofuzQTIJcNTBo0SZGRa+aesiXtL6C0fkQeTUZQLKgeL4RVwfxqOHefeb0zbhX
 HnF2ftVFVILkmK3lfAU8OzAY4R5bnKhGzk29e7RNZ7W0N0EHrhqC2lglgyozsZR6+2x2Gbl1zRD
 mAlWFtqC788G2kMGjrer7+R2zrQz/5Ex6fBRY=
X-Received: by 2002:a05:600c:8b55:b0:4a1:f736:79f3 with SMTP id
 5b1f17b1804b1-4ac17ffb30fmr365463635e9.5.1793809181933; 
 Wed, 04 Nov 2026 08:19:41 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2aa481a45sm138015595e9.7.2026.11.04.08.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:19:41 -0800 (PST)
X-Google-Original-From: "Marco Baffo (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 16:19:40 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
X-Gerrit-Change-Number: 2063
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2063?usp=email>
X-Gerrit-Commit: 213806ce47126f4e8aed2137ed11cfabdf7f49de
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 16:19:40 +0000
In-Reply-To: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkyNDU4OWQ1MTU4ZjY3ZmViZDNjMjVhZjAyOTk0NGQzZjFkYTMyNzYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <027d45fa11fe0ade6700f3c1542f0e78c1a2ec2e-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xOdiG-0000000068E-2dh9
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
From: "Marco Baffo \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: marco@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Marco Baffo \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============5356662351813671773=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============5356662351813671773==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KVwQDnJFpUo="; charset=UTF-8

--KVwQDnJFpUo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Marco Baffo has post=
ed comments on this change by Marco Baffo=2E ( https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2063?usp=3Demail )

Change subject: PUSH_UPDATE: enable Linu=
x DCO address and iroute updates
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E


Patch Set 1:

(2 comments)

File src/openvpn/multi=2Ec=
:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063/comment/296a7b09_1f565e5=
2?usp=3Demail :
PS1, Line 4626: #endif
> We don't strictly need this `#ifde=
f` since we have stubs for non-Linux builds, and `send_push_update [=E2=80=
=A6]
Done


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063/comment/0584c77=
7_efa56376?usp=3Demail :
PS1, Line 4628:     if (TUNNEL_TYPE(mi->context=2E=
c1=2Etuntap) =3D=3D DEV_TYPE_TUN)
> Is it ever possible for this to not be =
true with DCO?
Done



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2063?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: I24589d5158f67febd3c25af029944d3f1da32763
Gerrit-Change-Number: 2063
Ger=
rit-PatchSet: 1
Gerrit-Owner: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83z=
van Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-deve=
l@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 16:19:40 +0000
Gerrit-H=
asComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: R=C4=83zvan Cojo=
caru <razvanc@mailbox=2Eorg>

--KVwQDnJFpUo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Marco Baffo has posted commen=
ts on this change by Marco Baffo=2E</p><p><a href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2063?usp=3Demail">View Change</a></p><p>2 comments:</p=
><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/multi=2Ec:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063/co=
mment/296a7b09_1f565e52?usp=3Demail">Patch Set #1, Line 4626:</a> <code sty=
le=3D"font-family:monospace,monospace">#endif</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">We don&=
#39;t strictly need this `#ifdef` since we have stubs for non-Linux builds,=
 and `send_push_update [=E2=80=A6]</blockquote></p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063/comment/0584c777_efa5=
6376?usp=3Demail">Patch Set #1, Line 4628:</a> <code style=3D"font-family:m=
onospace,monospace">    if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etuntap) =3D=
=3D DEV_TYPE_TUN)</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">Is it ever possible for this to not=
 be true with DCO?</blockquote></p><p class=3D"blocks" style=3D"white-space=
: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Dema=
il">change 2063</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2063?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<di=
v style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"disp=
lay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit=
-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763 </div>
<div style=3D"=
display:none"> Gerrit-Change-Number: 2063 </div>
<div style=3D"display:none=
"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Mar=
co Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2=
026 16:19:40 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div s=
tyle=3D"display:none"> Comment-In-Reply-To: R=C4=83zvan Cojocaru &lt;razvan=
c@mailbox=2Eorg&gt; </div>

</body></html>
--KVwQDnJFpUo=--


--===============5356662351813671773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5356662351813671773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============5356662351813671773==--

