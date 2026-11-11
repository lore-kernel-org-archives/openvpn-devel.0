Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D06F606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=WfEl9iqQ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=goTJJbso;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=giVeq+3M;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=JaKq42FK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=O5eXumc9wWem/DMxJaHrDH/bg2I8u4SpWz3tb/PZD+w=; b=WfEl9iqQMfxnlDlVrs6gxn4eN/
	XX2u0Ljvy/FurLHAqwIEaqF1+bry0sygAuAWDlAxQ3r6jYAHHDs7qZwVs7dR3XXl1ZNDDOWhAVDwt
	7zRqYhZ3rcXl1vLYINgjWG9naYd5Ukuz5RZhdzE1plxiW9U+N77os7Se+++IyM4gl57A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR2V6-000000003s7-2eFG;
	Wed, 11 Nov 2026 07:12:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR2V5-000000003rv-1mpW
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 07:12:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j0RWZWtsQJ2vr2maLpfTvsYX+xZDjgkYXTCab5GuTkA=; b=goTJJbsoNwfSqkt+YBKadQtgEQ
 VdXWk9sGSmHh075HKYfPgV+VxJgMo6sPjsGYuQF0F2k0JCN6WZ2IlD28PGzui6HzfNrvyN+8tq5ny
 ZRf0JQzeZQV+dMxyB7lUjdy4uHGpWvshwzYcrEc+RIh5mrvKnwfc0YvcFgis1uaPq3S0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=j0RWZWtsQJ2vr2maLpfTvsYX+xZDjgkYXTCab5GuTkA=; b=giVeq+3MLF6dYVZd18gQcbYjxt
 0ZL/zCZdwGP8SvQlDNeDY82FQBfZGQVlOAmbX0OPRZz9KS/S8Ktx6VzlELjRqy+5hFQ7TMU+5ctUo
 k+upmmiEPMAlR7dUyn0HnCuCbN3kzklerZzlwVc/VDqNEoYxOEIm8VRBDCbWq2IhmTZw=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR2V4-0000000031B-0j3L for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 07:12:07 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-491846221ffso1992390f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 23:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794381119; x=1794985919; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=j0RWZWtsQJ2vr2maLpfTvsYX+xZDjgkYXTCab5GuTkA=;
 b=JaKq42FKlwkB5BMwq8lZ7LoDXQxLWOQ5ZKFSn+XS7LzAshzsc1dzAl3rzaj0DRTlgk
 lr1WMPdJh8bEsIMA8M7XG/uszfpmYrnvJ5wbAK0Sa1POuD+562TgMoGfL1ux8uVonluJ
 I0pTPhBQ3fVkxhxbfyIzG65OciI9e7lNozd/ukgVKt9DRStZqYIZUxpmaZv+TcrydzF5
 io8rRMPLzacQGMzj7GBj7O0gg5D1AE/TiG7ZkBgF2szlseh1SijTX4s1K6l0I3m8AYRc
 DzAVkr1z90nyRp5Jyg7UL+JVrLJJOJLEoU5xTahofaKytKcg2IIYd+KFOJzrkHGNfyvC
 m7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794381119; x=1794985919;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=j0RWZWtsQJ2vr2maLpfTvsYX+xZDjgkYXTCab5GuTkA=;
 b=n8kkiVBEgmhgNP8UaNVEMt3BgEC6fzzpEZiQ5XdYhDXvt4I9Ijjys6LNNspL5HDcWt
 zVzGm/rIQmcDfDIY6tzp8+yB/CPWO8oN4/M3RJvKPwDD91v3vNEiuIQIt0KeF6MwFZ2m
 SYgwN7i5D/JYtE0MY18DLMpKGp9rM5zWai7jYqu/l+YL+1nAseLsbOSinmqvrUkwOqhl
 STT57RVGYzbJryY2xCrAnIZaVc7fOxmkvAzD/q2Du5VAF078fs6acgA4FLIbsfgErKMN
 TVGKpJDXlViNpYBUYXofKmcAJ5FuMlTYv3+7HtxXAjmre0OgdaI+dby69A9NIcX7XF5i
 iGwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGS0sXcl7DZxkH35i47PpI3l8tkTebYcVGQkdr7jyhI9fKPQ8VV+r5w9+4Iy7Q9Caa+OkgkhvQ0kP+/HMQT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9UriMSSDSJy4XshHtNuKvWPFsOF0mWd0cxvrKACdgdIAexmm3M
 x5I8H30n3VZaSDV9QuEfV4AAeWmestRLL0iSZVuYfOyHknZ4+38loxgs7chBCD56xYj4LY/oxii
 xxSuJPlBpClkUH8it6ehk9zgwsXjntpsj621AWo7WJV/ETJAa5P8jdIHFU9fi2tBqe2p/a/ex/P
 BJ1fC39Q==
X-Gm-Gg: AYBFou0qB1ZSq4o6dCDTgYdps09ETtR7atZudLHzkYGRVgm+OIX+ZbYhDYMBidtOiMx
 VWfYOuwCf6Cewt/GXGbdAOUZ6uVYJ8idvUKBFMoLke3ChsQH0JLups1Beu1vPn//PW6rOMMZymh
 QruIVd82Lgr4bFou1m3khuGHI6Ibdcgibga03vlJITNi4AuXAf00jLET4nH/CX7KsJrINh1iGbh
 FJbTT4wzsdWW6wGsfbmacXSBxdPBfQpd7en92Bz/BQ9YLjIIemfVzmU+oE9Mp0esvVummPKFPDv
 OwsDFY0GsudsArn3T3WY6q8eTh1CdH5IDphK6If/f2hxk25UrvJcA6yZGfjrtGSwRfzM06KPkEn
 TnveKo0mKaqkhlSLnuWoc23EIRMLtS6bukMUoOOnbEbVJ7U7rccTpthCH1e9MZZhZmD2AGUkZpP
 rIBkSdKXJzaYoRdt4hu4jb0MMczChasvzzYnVGbn0PzT1zE7TAy4kT4Tz2sQCO/e6vrlrmpVi9e
 3dtlIhILpFWdLeuYuJYi3+sxH4EI/fnIRpmTWtLSpRMdIYdKK/b59T0GM1opjVXrosaokeo6xGq
 6oHvUbttyY5sHI+QsKTsXdZKEQyLQaOjxC+sXcIJKa1c8NzrgjR9rlPyDwUJjjpskLZCpWnyrd4
 oKPkI+kOa3maDNUXlmC80ELfBGSOhYPskzcr4TAilxn01Lzg9FGi6pmfZvvpIEsKQfItRtS41A3
 kH0Z6byPKYp75Ppv39
X-Received: by 2002:a05:6000:2c0b:b0:498:42e3:3f6f with SMTP id
 ffacd0b85a97d-499c38bcf11mr2208336f8f.5.1794381119391; 
 Tue, 10 Nov 2026 23:11:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498365cbbe5sm10158654f8f.42.2026.11.10.23.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 23:11:59 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 07:11:57 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225
X-Gerrit-Change-Number: 2170
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2170?usp=email>
X-Gerrit-Commit: 829177950a079c191414f6f94c18db76c6e2b33b
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 07:11:57 +0000
In-Reply-To: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
References: <gerrit.1794340380000.I5ab959e7101cf801ac93e5185855e75db0fb6225@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzQwMzgwMDAwLkk1YWI5NTllNzEwMWNmODAxYWM5M2U1MTg1ODU1ZTc1ZGIwZmI2MjI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <b8259e12961beb4a124b17e6125caf0c614afbf8-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR2V4-0000000031B-0j3L
Subject: [Openvpn-devel] [M] Change in openvpn[master]: DragonFly: bring
 things back into a working state
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
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============0156107341085582721=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0156107341085582721==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QYshQcgWytM="; charset=UTF-8

--QYshQcgWytM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering=2E

R=C4=
=83zvan Cojocaru has posted comments on this change by Gert Doering=2E ( ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail )

Change subject=
: DragonFly: bring things back into a working state
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-Review-1

(5 co=
mments)

Patchset:

PS1: 
The `clang-format` filter doesn't pass for this p=
atch=2E


File src/openvpn/tun=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/2170/comment/a7bb5511_9bb3d058?usp=3Demail :
PS1, Line 2900:  *    the=
 first free device, ask with devname(3) what you got, and
This says "ask wi=
th devname" but the code uses `fdevname()`=2E


https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2170/comment/99e687a7_8bbb6dc0?usp=3Demail :
PS1, Line 2911=
:     if (strcmp(dev, "tap") =3D=3D 0 || strcmp(dev, "tun") =3D=3D 0)
`if (=
!dev_node && (strcmp(dev, "tap") =3D=3D 0 || strcmp(dev, "tun") =3D=3D 0))`=
?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170/comment/e529fc41_03291e=
67?usp=3Demail :
PS1, Line 2918:             msg(M_FATAL, "Cannot allocate =
DragonFly TUN/TAP %s dynamically", tunname);
Would this be better as `M_ERR=
` (so we can also get `strerror(errno)`)?


https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2170/comment/23ab84c9_9f5e251a?usp=3Demail :
PS1, Line 2924:   =
          msg(M_FATAL, "Cannot query DragonFly TUN/TAP device name");
Would=
 `M_ERR` fit better here (to get the system error as well)?



-- 
To view,=
 visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail
To unsub=
scribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75=
db0fb6225
Gerrit-Change-Number: 2170
Gerrit-PatchSet: 1
Gerrit-Owner: Gert =
Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: =
Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-Comment-Date: Wed, 11 Nov 202=
6 07:11:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--QYshQcgWytM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering=2E </p>
<p>R=C4=83zvan Coj=
ocaru has posted comments on this change by Gert Doering=2E</p><p>Patch set=
 1:<span style=3D"border-radius: 3px; display: inline-block; margin: 0 2px;=
 padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></p><p><a hr=
ef=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=3Demail">View Cha=
nge</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2170?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">The `clang-=
format` filter doesn&#39;t pass for this patch=2E</p></li></ul></li><li sty=
le=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun=2Ec:</p><ul style=3D"=
list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;=
"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/2170/comment/a7bb5511_9bb3d058?usp=3Demail">Patch Set #1, Lin=
e 2900:</a> <code style=3D"font-family:monospace,monospace"> *    the first=
 free device, ask with devname(3) what you got, and</code></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This says &q=
uot;ask with devname&quot; but the code uses `fdevname()`=2E</p></li><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170/comment/99e687a7_8=
bbb6dc0?usp=3Demail">Patch Set #1, Line 2911:</a> <code style=3D"font-famil=
y:monospace,monospace">    if (strcmp(dev, &quot;tap&quot;) =3D=3D 0 || str=
cmp(dev, &quot;tun&quot;) =3D=3D 0)</code></p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">`if (!dev_node &amp;&amp; (s=
trcmp(dev, &quot;tap&quot;) =3D=3D 0 || strcmp(dev, &quot;tun&quot;) =3D=3D=
 0))`?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
70/comment/e529fc41_03291e67?usp=3Demail">Patch Set #1, Line 2918:</a> <cod=
e style=3D"font-family:monospace,monospace">            msg(M_FATAL, &quot;=
Cannot allocate DragonFly TUN/TAP %s dynamically&quot;, tunname);</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Would this be better as `M_ERR` (so we can also get `strerror(errno)`)?</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170/comme=
nt/23ab84c9_9f5e251a?usp=3Demail">Patch Set #1, Line 2924:</a> <code style=
=3D"font-family:monospace,monospace">            msg(M_FATAL, &quot;Cannot =
query DragonFly TUN/TAP device name&quot;);</code></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Would `M_ERR` fit be=
tter here (to get the system error as well)?</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2170?usp=
=3Demail">change 2170</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2170?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I5ab959e7101cf801ac93e5185855e75db0fb6225 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2170 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru =
&lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert =
Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none">=
 Gerrit-Comment-Date: Wed, 11 Nov 2026 07:11:57 +0000 </div>
<div style=3D"=
display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> =
Gerrit-Has-Labels: Yes </div>

</body></html>
--QYshQcgWytM=--


--===============0156107341085582721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0156107341085582721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0156107341085582721==--

