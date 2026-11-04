Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659A6606A326
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=CTE+YOGQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DR2BbVqx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K78mCUQw;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=TR8d4QvN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=q/PoWwvU8PhZCakaOU4sYL6/SpkyKKRnEeU8T3eUT0U=; b=CTE+YOGQ6Y4aWjR7RpdsPEk53u
	OBl1ttrz7N3g9bAEXwqacDEkQ3Z2e56XwR2FPxuRsbQGIlxoy2sh6cIyxA7cxTC37Of7c18OPjMij
	QNPhoX9sibjUYNUpBt1jVMQAu2lg0sL8ejUrnVaj9RgQd3IcbpQv5hllRM7BYAtGoUno=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOYqI-000000005uV-1zlJ;
	Wed, 04 Nov 2026 11:07:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOYqH-000000005uM-2Qtn
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:07:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lX0HGcVmsjpm79e+yCFdLzp1k9IMgC2q58CsE6X750M=; b=DR2BbVqxibhXK8Fj0pkiCY9LMW
 w1MXvJtlBfwP6c1kv/dPG1lNvBVxoE4IltuPXkzU2K9MNX9uNPkA0fpQI7I9Qdv6XW2QT4LXazRqL
 N4bwpGmF+QFHHoIgFDZgG3TtRS6Gee8XCy6OxJlAtcTdxsC7Guizw/Oa9fvSBkfVEFRs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lX0HGcVmsjpm79e+yCFdLzp1k9IMgC2q58CsE6X750M=; b=K78mCUQwqTR75ejS2ZhFio5JZW
 UQha6oSheEZmz+dPW2MEfJlDIRvf5nLpyCwF+EKc+wXp4XWlw+FPTpWKMCb082If4GZ1I5VsZg1c7
 fniIZDm+hu62zDICko3itsjTqdMeu763zJ0liMRmq3N34Fz8X3/l57e89cwSNbJdCZ60=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOYqG-000000006M6-3pqu for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 11:07:45 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso245865f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 04 Nov 2026 03:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793790458; x=1794395258; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=lX0HGcVmsjpm79e+yCFdLzp1k9IMgC2q58CsE6X750M=;
 b=TR8d4QvNAMvD45oU3lgr6JtpFX+V/8ngp6rymHdnf3aF4j59voWX6yjU9W01TzaX80
 MxJaaYaPrMlsR6lR43j0Y8kC+Nkxq699Pk8HlpKmh4EQTae4X54VeiWdlusysPypCYuX
 W6T2Js4lYQQhtVZ9NgE2yuDmci4N+AnDXu5gHq/gcgbRq9GO7w9n98p36APv2VtFJEw0
 alR7zEtGisUT0uZMQR3Wns/eg6ITHcH2uKYX/RtzDl32ksicwUBhVViE4gfDTXFh+2AY
 Xdg8WnxPBsmtJ71oeMRBjyv/aZAS/2NCcYvn2heE+ysH1RAb5x/4KAophjnSxX2Af0Xl
 +v1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793790458; x=1794395258;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=lX0HGcVmsjpm79e+yCFdLzp1k9IMgC2q58CsE6X750M=;
 b=rwbhzhYXRH1r+7ijn1mlEISW86X+8bN3jGavRfX6h8BdPyjuGc3vKxLXn1qUsHi/YL
 I6Dkn8TenVbKScSAELHnVw1gOjVbawPgCnujcjnP1bxZX880nOwICbNn/nVFay1KHGP+
 AuhVmXLwcXb/0a1b7OrpTG0jGLw5OIQabfLPYhXhzo9p3/wzj5Ka87e0tT9YmwaS/j3L
 rMZGFcS67AWZc6D30n7t15WjWw7YAySyVIY8jCbiTqwT7FdR81+G66IykKagOq06zOVS
 jY1BdFVG3HfE/II6VITl1gYNWs4KY1cp762LZg7foIye9rS+fnI9e+caWHwOIwTCkqfr
 85JA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwAsF0AGJEmCMkzepixYZHHh8ukP6GV4i8icuCXqM9VgChS6HsuguZ4qWPkKxb3G+1c5Uk/U+VlLR22DOHd@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+AAsGBEFjOvykt73aZQ7rjnLfX8zrg5xIBHNR/apMjlWbLLxkd
 EjcVt7L51nr8pXN3SGeu5v/RqcZwM2h4Dm+Xy45D5pn7+FMnxkD0PoiojwlOjBXIjdqxFedusvU
 BAHb0rFw1PyqaFpF/mi7fv6anmnnNMNp5YgynnCQU5PspVIA8z/oQH7ZeBNcOAWh6lAkJ
X-Gm-Gg: AYBFou1l5sz8BeopsIdvHkQ0HqtKD5qOu3IKM5foKPYghLE0Nwh3a4pMtyWGPi32mSN
 w9TBbSjfa35GtIGzXd5KSa33Lm5k7HYLVqR7tYXtNSbFoWhOmMxOkKXSCzGJrVAOTxlo85AndI2
 Z6uq+7zY6NjA+KIObzBAZjFbT8ngqTCjsXW6YyaxCvuR7pLGabMufcdga0iw9wQNhdzpOkwTmDi
 uLJY5VHesDMboA5kenJjDtDgDKVXhrOAHNiDQh+hj302YRq+uFqIejBXUHHkEaer8XOlAHIq76t
 ovh/0TL2JZJdmL8Z0XfxGWSvEcEjAtVgqiTF/gQiFVkcCfCjzNIl5fU+uysEuhxoYwHY6vfI6vB
 SyKzyMhxKaz9ewCDHQoJbQ3hn0SJLz7JQCur1/9XIakHLRvOghe9VRSrH1TXNHAbiHnF18n6c3j
 IORTZovzlIvrzGp5AezxRSjAum/ArL+olWOdMQ6fMYyvmk4SOf6+XKR7VlAxzzq/ha2hxVgUNyZ
 cFjqJgxNBTOBfA8tugvcMaN+r31a6UgSLn6dyvufXKXbJRoSkcTphywQOzX7Fk3TVLPjSzgqMcu
 knVs4n3pQqqzdJKdF893iLAMPTnev+/ZeB3XJS2wdOTzBgTYISrXa2vJXcjAjbyruvSAmOoXz4M
 f6fjx5Xau3GZKrOKQjLAJWBCT/I+ad2rKlepjg+yrFEyNVkbgYGKGKohjYyIdwQX7s/aR6Dh/3G
 AbgSQb/PNz6y2viQ==
X-Received: by 2002:a05:6000:2dc5:b0:48d:ef0e:b791 with SMTP id
 ffacd0b85a97d-48e6e52c720mr35124514f8f.54.1793790458007; 
 Wed, 04 Nov 2026 03:07:38 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda20567sm3550204f8f.51.2026.11.04.03.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 03:07:37 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 11:07:36 +0000
To: Marco Baffo <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da32763
X-Gerrit-Change-Number: 2063
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2063?usp=email>
X-Gerrit-Commit: 213806ce47126f4e8aed2137ed11cfabdf7f49de
X-Gerrit-Comment-Date: Wed, 4 Nov 2026 11:07:36 +0000
In-Reply-To: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
References: <gerrit.1793194671000.I24589d5158f67febd3c25af029944d3f1da32763@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMTk0NjcxMDAwLkkyNDU4OWQ1MTU4ZjY3ZmViZDNjMjVhZjAyOTk0NGQzZjFkYTMyNzYzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <51abda5461f4abe2dd0d7a6a916b6db225bafbc3-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOYqG-000000006M6-3pqu
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
Content-Type: multipart/mixed; boundary="===============6842850011708182844=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6842850011708182844==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UExdXwe9pS4="; charset=UTF-8

--UExdXwe9pS4=
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


Patch Set 1: Code-Review+2

(2=
 comments)

File src/openvpn/multi=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2063/comment/51e9b8d8_75527cea?usp=3Demail :
PS1, Line 4626: #endi=
f
We don't strictly need this `#ifdef` since we have stubs for non-Linux bu=
ilds, and `send_push_update()` already prevents the logic from getting here=
=2E

Doesn't hurt to keep it, just a nit note=2E


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2063/comment/ce08f7d8_7480a944?usp=3Demail :
PS1, Line 4=
628:     if (TUNNEL_TYPE(mi->context=2Ec1=2Etuntap) =3D=3D DEV_TYPE_TUN)
Is=
 it ever possible for this to not be true with DCO?



-- 
To view, visit h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail
To unsubscribe, =
or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerri=
t-Branch: master
Gerrit-Change-Id: I24589d5158f67febd3c25af029944d3f1da3276=
3
Gerrit-Change-Number: 2063
Gerrit-PatchSet: 1
Gerrit-Owner: Marco Baffo <=
marco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Marco Baffo <marco@mandelbit=2Ecom>
Gerrit-Attention: Arne Schwabe <ar=
ne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 04 Nov 2026 11:07:36 +0=
000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--UExdXwe9pS4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Marco Baffo=2E </p>
<p>R=C4=83zvan Cojo=
caru has posted comments on this change by Marco Baffo=2E</p><p>Patch set 1=
:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px; p=
adding: 4px;background-color: #d4ffd4;">Code-Review +2</span></p><p><a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">View Chang=
e</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"><li =
style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi=2Ec:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2063/comment/51e9b8d8_75527cea?usp=3Demail">Patch Set #1=
, Line 4626:</a> <code style=3D"font-family:monospace,monospace">#endif</co=
de></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break=
-word;">We don&#39;t strictly need this `#ifdef` since we have stubs for no=
n-Linux builds, and `send_push_update()` already prevents the logic from ge=
tting here=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Doesn&#39;t hurt to keep it, just a nit note=2E</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063/comment/ce08f=
7d8_7480a944?usp=3Demail">Patch Set #1, Line 4628:</a> <code style=3D"font-=
family:monospace,monospace">    if (TUNNEL_TYPE(mi-&gt;context=2Ec1=2Etunta=
p) =3D=3D DEV_TYPE_TUN)</code></p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Is it ever possible for this to not be t=
rue with DCO?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail">change 2063</a>=2E To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope =
itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2063?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displ=
ay:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I24589d5158f67f=
ebd3c25af029944d3f1da32763 </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2063 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: Marco Baffo &lt;marco@mandelbi=
t=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> G=
errit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Marco Baffo &lt;marco@mandelbit=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 04 Nov 2026 11=
:07:36 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </=
div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></h=
tml>
--UExdXwe9pS4=--


--===============6842850011708182844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6842850011708182844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6842850011708182844==--

