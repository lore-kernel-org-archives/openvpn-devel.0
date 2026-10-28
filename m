Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6B5606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 28 Oct 2026 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=fjMsV/DH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MW+SX4ra;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=L+5zZT9e;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Fr9Jztji
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=CipobivzuQGjZnaQkEsUJ/+2f4QwUc+GY/2ObnFqeoA=; b=fjMsV/DHEIyfBqGv9wqqX6fGgW
	f9Mi/vZnjzH8FHLArAAzRoXR+BMI43FCi1317qBHHO6rKahIHgIjr9/e+Gqn+5yEJ6YCVw+N7hYXf
	aHBwX8cdgXDw0HQMcSkNscWWpcMcI8oyeMm74AkO9rzdDKx9UkNS1QvBtJ1dMlPQpA8s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xM8Zd-000000004o7-49V3;
	Wed, 28 Oct 2026 18:40:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xM8Zc-000000004o0-1XC9
 for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:40:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GjHNCkODdmby4GvfwlujvnsZbDbKm7fFAlIFxXb9lcU=; b=MW+SX4raXq/daLFj7a1z7ReGyI
 h77knUQk96omqiBO8c7vvtlalDJlrQwF+lENSwGVZjsVHY3zgIMCmWmKMO5Fl8E2njlemd2M4HUtr
 zNsnvaOjfdltSsaHnoGczbnq38riODoylKGhhWKHNCDBwuwrqHOZ0+QHzinSZjb0VSlk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GjHNCkODdmby4GvfwlujvnsZbDbKm7fFAlIFxXb9lcU=; b=L+5zZT9eA7iFTNwYFGnxGg2mCC
 f96h1WrGE/2T5kZeynKbwPbAXI0qKGffcUQsiSZNcnbOzpNOddmvmef8zvJLQFDOuwb77aIGFDlv/
 HRvDgUopfCDUwIMaCOi+v4aR8ri2l637opw3qj5UClXC0H2lDCtI7cnPOCv5/0myXAP4=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM8Za-0000000015H-0eDR for openvpn-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 18:40:32 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso856842f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 11:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793212823; x=1793817623; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=GjHNCkODdmby4GvfwlujvnsZbDbKm7fFAlIFxXb9lcU=;
 b=Fr9JztjicWdb+ftsaulJqztVUKyZRUPJXat1+JTYeyLwQUXyU61cSdagDdD1I/uXAK
 CGOgVBYO5tLcOiVaKaa6E/+ySdyEwuxg52mDJacyxXL727LuhwERbdRiNUP/mVqnL3mq
 Dp0im82gNkSLgo8IW/c3TxLYDjr62oOiJDMszYWvfuUId/7+4LaXZTrIwUZ3rkE0hyB5
 Hz5/MYyTIPbsLpptPsEfAn0gbosmHMaaiKJ4zNmgowiCRB13z5ofAv8bKjVm0ApnjEtg
 1/v8xWJxX8LT9f8t1oRM4Iuc/PHgqSq9j3FYIfCTT6NxwppD36PAoSjownGe3RuZou/n
 Ef9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793212823; x=1793817623;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=GjHNCkODdmby4GvfwlujvnsZbDbKm7fFAlIFxXb9lcU=;
 b=ZHunbGq3aEL5PIp/ukBNTa2nDCdyVZEYE9uV3v+Yk+XRGsnQK6sYI/JpD4/IzMyuZ+
 TGfQAqYSpSsc42o5YmzxxUW6GrrWoEmKhNPo4q+8aMHiCAL+6wLd1ziRgj9Ds9I2aLsV
 XcJ8xodJvyiCKakte0EK0zu0K65oPKeh4TDSb5uMwpfWWb5SD4EaMdKjNbmApDs0tpqo
 FZRaL1LmjiTe8kZhHsWmUEEDm6PlQIoPDTP9aIA9Qh1BTMeew6kqzXt10IkBDrEr3eiO
 mAxf5/YG0Sj19RRrm04IXA4bWVn/2QV1Nw6FA6S+Ll5+wAU5yVm/OeDH7NmiKmk2/lwR
 Ms3w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwvE+gtZ4XMktsgupF0jb9TQ9vwFyStr6RRwcPv/PxWT7FJv0QV3rdtO6H/RnUmzMfkNZfgnQFnQ6R2TpD@lists.sourceforge.net
X-Gm-Message-State: AFq9FYIPpiiZnkXSyvNzPN9OU2TRtgDbukOKsBvY4jgtpW00Y7VcEgin
 npGUcXwFUff1QfShyTGpkGIBBwNKJckl/j8vESuEjvKlECMf7iwRUGNjFzAnfVvolsl9Y57/Wxu
 65UiyIresdO4khr9WSBrX0XKHd01/5wqRtgvI7ee5ghoNDkQKYJMfwaoZ19u2cLwqlm2EAXHJuv
 QoF8Ju6A==
X-Gm-Gg: AYBFou2ZtqxMrQ05o7A/sx24IqaU9gLPF3br0Pdgq57jlahGa/1PBNPCZhWKkNMfrU8
 Y1tYSKHi8sV5E/khg5414p7VooehDsdjq24OrkAGguo1Z0iJBc6hcMX95008lEa2VaTZwROWLMM
 4feNGdQIbJGAWnCI1EGid/5XkZDKTVQvFmne4+vCpXm7DVciSjquXdLNvQYAJYxaH149s5Hm0Eq
 v2+t0GqAhQvFVfrDP0G92ICp0veyfNYjM58sG441BG4IrkPAYupb/iB3oMIB+kpM4HSxOhIfK1q
 ZVZfOAQZgDDYnzz0m5kOnZGb1K8bdulV73NCPcWTmvZGN2kqIZlQr6934mRbMJb9d0zh9u4O1bq
 Uxf5fiORhi1iM4WRxyS31E4g4b/mJS+HnF4TN1nsW5eBc1RngkhjVhWkSkLWV4oWxwDdO+3xlqD
 GYVM3QBu+5m/bvW9jzD9hOBRUSmruI2mo6SAmxLgrm27valnjywxEr/LvVQFoDSirYZEhMJ2SZ9
 /ejzdZS8h+kAtOfEkCZhPkHOt+10XIPKlFb38YwzUhb1BqX+ilwVMgiI+SOXY+pxkb1cFT7n+xQ
 ZzB/fg1DGMLVw+eMIKWYw3Su37LTF4VSwAQW2U0vpI/HjDSlJlpFqPivGjY5ylU5oiper6xqPK2
 cbVZQyB7WrvLgrCawYQJVSaVSfu05Uvtm61/PoIcn5r2QLIvK/LK3reV8eP0uA9IJZUvsufPAAZ
 jUuidorRn8pTgqUDo=
X-Received: by 2002:a5d:43c3:0:b0:48e:37e:470f with SMTP id
 ffacd0b85a97d-48e5d30ed01mr6294697f8f.51.1793212823110; 
 Wed, 28 Oct 2026 11:40:23 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e4806e208sm24267896f8f.40.2026.10.28.11.40.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 11:40:22 -0700 (PDT)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 28 Oct 2026 18:40:19 +0000
To: Max Fillinger <max@max-fillinger.net>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
X-Gerrit-Change-Number: 2029
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2029?usp=email>
X-Gerrit-Commit: 8b3cb6f6ef5d5f8c53dfd77d723ca99118732f1b
X-Gerrit-Comment-Date: Wed, 28 Oct 2026 18:40:19 +0000
In-Reply-To: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
References: <gerrit.1792688397000.I5ebc0d04c501d00dd35e8e23cd25d6696d95d719@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNjg4Mzk3MDAwLkk1ZWJjMGQwNGM1MDFkMDBkZDM1ZThlMjNjZDI1ZDY2OTZkOTVkNzE5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <51a7f3be05284d4d7bf325edd95b7089f0cc8e1c-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM8Za-0000000015H-0eDR
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Remove Mbed TLS 3
 compatibility
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1772923757522462761=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1772923757522462761==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CG0dn/U/ESc="; charset=UTF-8

--CG0dn/U/ESc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Max =
Fillinger=2E

R=C4=83zvan Cojocaru has posted comments on this change by Ma=
x Fillinger=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demai=
l )

Change subject: Remove Mbed TLS 3 compatibility
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 3: Code-Review-1

(4 co=
mments)

Patchset:

PS2: 
> I added a line that it is removed now, but you =
said deprecated instead of removed - should I add a d [=E2=80=A6]
Adding a =
deprecation warning might be nice=2E I wouldn't hold the patch hostage with=
out it though=2E


File src/openvpn/ssl_mbedtls=2Eh:

https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2029/comment/ca91b7df_26213f57?usp=3Demail :
PS3, Lin=
e 85: };
I think we need to delete this too=2E


https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2029/comment/9832cc90_86bf6f14?usp=3Demail :
PS3, Line 1=
06:     struct external_context external_key;  /**< External key context */=

This can be deleted now as well=2E


File src/openvpn/ssl_mbedtls=2Ec:

ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029/comment/d1bf1ed2_b9a323f9?usp=
=3Demail :
PS2, Line 156:     return mbed_ok(mbedtls_ssl_export_keying_mate=
rial(ctx, ekm, ekm_size, label, label_size,
> I was thinking about that, bu=
t Mbed TLS is very modular and there are lots of configurations that wo [=
=E2=80=A6]
If failing the build is accepted OpenVPN 2 custom, then that's O=
K=2E

I just thought that at least for new code it might be easier for deve=
lopers to see the error upfront at `configure`/`cmake` time, rather than ha=
ving the build fail=2E

But, again, if current practice is to just let the =
builds fail in these cases then that's fine=2E



-- 
To view, visit https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3Demail
To unsubscribe, or fo=
r help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Bra=
nch: master
Gerrit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719
Ger=
rit-Change-Number: 2029
Gerrit-PatchSet: 3
Gerrit-Owner: Max Fillinger <max=
@max-fillinger=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Max Filli=
nger <max@max-fillinger=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn=
@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Comment-Date: Wed, 28 Oct 2026 18:40:19 +0000
Gerrit-HasComments:=
 Yes
Gerrit-Has-Labels: Yes
Comment-In-Reply-To: Max Fillinger <max@max-fil=
linger=2Enet>
Comment-In-Reply-To: R=C4=83zvan Cojocaru <razvanc@mailbox=2E=
org>

--CG0dn/U/ESc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Max Fillinger=2E </p=
>
<p>R=C4=83zvan Cojocaru has posted comments on this change by Max Filling=
er=2E</p><p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-=
block; margin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review =
-1</span></p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?=
usp=3Demail">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2029?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:<=
/a> </p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">I added a line that it is removed now, but you said dep=
recated instead of removed - should I add a d [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Adding a deprecation warning might be nice=2E I wouldn&#39;t hold the patch=
 hostage without it though=2E</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/ssl_mbedtls=2Eh:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2029/comment/ca91b7df_26213f57?usp=3Demail">Patch Set #3, Line 85:</a> =
<code style=3D"font-family:monospace,monospace">};</code></p><p class=3D"bl=
ocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I think we ne=
ed to delete this too=2E</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2029/comment/9832cc90_86bf6f14?usp=3Demail">Patch Set #3, L=
ine 106:</a> <code style=3D"font-family:monospace,monospace">    struct ext=
ernal_context external_key;  /**&lt; External key context */</code></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Thi=
s can be deleted now as well=2E</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/ssl_mbedtls=2Ec:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2029/comment/d1bf1ed2_b9a323f9?usp=3Demail">Patch Set #2, Line 156:</a>=
 <code style=3D"font-family:monospace,monospace">    return mbed_ok(mbedtls=
_ssl_export_keying_material(ctx, ekm, ekm_size, label, label_size,</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">I was thinking about that, but Mbed TLS is very modular and t=
here are lots of configurations that wo [=E2=80=A6]</blockquote></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">If fai=
ling the build is accepted OpenVPN 2 custom, then that&#39;s OK=2E</p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">I ju=
st thought that at least for new code it might be easier for developers to =
see the error upfront at `configure`/`cmake` time, rather than having the b=
uild fail=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">But, again, if current practice is to just let the builds =
fail in these cases then that&#39;s fine=2E</p></li></ul></li></ul><p>To vi=
ew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2029?usp=3D=
email">change 2029</a>=2E To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">sett=
ings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAct=
ion"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/2029?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I5ebc0d04c501d00dd35e8e23cd25d6696d95d719 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2029 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Max Fillinger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Max Fil=
linger &lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@li=
chtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date=
: Wed, 28 Oct 2026 18:40:19 +0000 </div>
<div style=3D"display:none"> Gerri=
t-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Y=
es </div>
<div style=3D"display:none"> Comment-In-Reply-To: Max Fillinger &=
lt;max@max-fillinger=2Enet&gt; </div>
<div style=3D"display:none"> Comment-=
In-Reply-To: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>

</b=
ody></html>
--CG0dn/U/ESc=--


--===============1772923757522462761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1772923757522462761==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1772923757522462761==--

