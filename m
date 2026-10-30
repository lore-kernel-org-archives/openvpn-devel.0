Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF25606A31F
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VvdIKaym;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BvdvWxnc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=T+A4Yk8+;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=B5Ci18kH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6mKR0YlexHDA+t07WtnjdnUfnIS3Qgat4PvOYCkCJBU=; b=VvdIKaymoee/8F0SDkJ3Kupa4P
	iANvUx+xvbIRfKezNDKnpwz9ZnBGwycLzjaqpoxZd94EqOFn2cK4rDtSs3dXpIIRxScmNdDN6mCf8
	kEYwMyTjOENsK09qeaT7Mp8aKcCZ14FbmJPvH6i3HooG6K9pLmcqyiMhctMehJrNRgPE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMjzi-000000006pN-4BRI;
	Fri, 30 Oct 2026 10:37:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMjzh-000000006pE-18U2
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 10:37:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EwnmCGmj6P+P3vzVQH//DGgUT5aSQvW1xtSDMymAjnE=; b=BvdvWxncCfARZYTBVXQTSC2DKR
 zc6m8uPC53nU2QCnZX7S3tMmYfuevFcyE7heA2ffflUZ6PmBdeTJKEo0boR4Fk+Q2QmyZ2HLZB51I
 bxgwmXCNmIIUWVkeZ0Em5a36rZpJ+WPBa9u9vmKivKfvmrwXcA2nhb3+jvjfSckhUOf4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EwnmCGmj6P+P3vzVQH//DGgUT5aSQvW1xtSDMymAjnE=; b=T+A4Yk8+A6RgEs7vkxD2hdEUlR
 S6CWffF1lJim6K8Qqpm/18hYLA2XhomyJkZ4BXqsKknLePLUY90eUu8d024Pa8y8i1zKLc5ZJ1udA
 g71jvh+qGTCjebJd02IKqy5p1d1Mi6WYEMpkEPENAq8loXALUGK9dkCudESixJPrIXi4=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMjzf-0000000067U-2AHl for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 10:37:57 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso4570005e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 03:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793356669; x=1793961469; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EwnmCGmj6P+P3vzVQH//DGgUT5aSQvW1xtSDMymAjnE=;
 b=B5Ci18kHl01x4wF7/ynqXhu2dWdRNizVJDR9bmwQElOvy8bqILufoiIGhmbDEMBoXO
 AAtHVaaW9BURubYXM/Fy85K4nnliAEgzb6DGUgJB2d3F4OE3XfHcb05hTCwXvbUTJq12
 uV5/Cro0zSdbkS8GNYU1vTBEIZT3Szu1MQg9f85aplTPBnQavrWZQrWIUFmbw6dXECZe
 QXav4HVbUdz/vRYpX/rrJiGLCsl0LDI2zR+fJeMtrQJ0DYbEgnsK3AYEB1cF//PRDkuw
 VmwLHg34+IEtD1nsujU4VGUsfcohHUjlb5lQ7LPotRslHxmD5ds6b8yZ8hirwGWVbDHC
 IMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793356669; x=1793961469;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EwnmCGmj6P+P3vzVQH//DGgUT5aSQvW1xtSDMymAjnE=;
 b=G1IjetNJE+plqFuqSBcivf5V/gJgX5+km9zwoHIx2QTBbjBPJxFda00xQLEjgrgsBV
 e8wyQuHVq15UXVwr0WIe7CmkkI8GY6MlunY2Z97PqayHTtwqMDNYlSrC0XL9Sj36NoWB
 VD9SGj5Nr6Z3CFhe3xg97dZTzdindaX/FlMYuFm+TOxSFoObHaPIyGxoE2hwfo8KDjU/
 v8rXGPj4YHXrf9cBx6F165WWhmmZN18pGkl66ypPcBXIuSsV5kgsy+09JHzP8H6ZxqPw
 Lyp8s86vdIaKygG9m9fx6Tnss7W/T6UzaS80Ct1wFY7CQutc3ofZFCMZtWsco1khF5ko
 t0Iw==
X-Gm-Message-State: AFq9FYICJQVQgMk0djIOKwtlHaXg6/86MJs8BQ1Llnq4DypZh1mqRuy0
 o8JVt05DTCO2QHDXgBSbU9C4WkFifyIY18zzwKO4gr6BHyVUhKoUG7g5rYOtTcHpDFqFdkV6F+c
 kO9Nzk4OgqHhrKMdI1OtktP/WH6VrTOnV6bUBMCw1sXYqYVTJx8RDV+TwPGAkV2ZLq7Fhevi7WG
 rlGKZ4Vw==
X-Gm-Gg: AYBFou0aITmjgAJ7rrYlaoPFG2wNmpO/y5/0XD/cQaNHnKq6kSyrnTku9ALk1kEXre+
 IA5/jwu7PBWCslRbmnEmLOqWZLAsoy32OSn49Z+V4zdNlRDAQLiwIYiMpUd+oYVdDDL779BNXZr
 hTmVUMKEqvFbxiFCb9BQQx0+g3Xeomugq/o7Vl3/HsU4SkQqeYTxGPG62hHgWbHQsPwnu5kq62n
 6UMnjTpJWSfGadvhnO5Oyj++zkjI3eJBtGX5e6LbPsJVvbmV4OTQY0MCzsRVm7Ffla4tCJhW53q
 9CgqpUSWyMdRKUZAZ81P41kV9NN3PQ2ZCIAs42/J8QhJpx5YUrcmRn/71WxvO83a81l3NcFBXqE
 i70gr/EeFW5XHlIn/0mTLkXp+yYcMwcLATX8qlgQiGAlISv/NDhSiXwPQaNQbZUl9NeMcd7znkt
 TIKnY9UmkayEQBScfl2s2qcY5E6nAMyXKT8XgEN4WnAx6ak6DeeNlcfkUAwQXLwpbJwFBPYd7Fb
 fAB5hJYKrj/cRyWbECxHzJo2wo6ifpi0ecdcc9GrX6vhaozS1ZJtjc8So3uIyujq5v0B798NPzP
 +Tt6cGvrpqNAAhbeNL26wU07dnzO7xKzjLkzabIAYKNmjGA78aP66h4zAtWadnc0H8EbL5mbJ+Q
 XXJyqazYNZ2qtyx8KHwUDZ+14AXtDX4BjPCYNat4c2QQmY1QZ78ChUhnA/yAlZ/9i0gC13ITTwz
 oF46mQpTFRZHC2ws0=
X-Received: by 2002:a05:600c:8b01:b0:4a2:74f:46c1 with SMTP id
 5b1f17b1804b1-4ac1737c682mr36935555e9.8.1793356668486; 
 Fri, 30 Oct 2026 03:37:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abea533a1esm35636515e9.1.2026.10.30.03.37.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 03:37:48 -0700 (PDT)
X-Google-Original-From: "Name of user not set (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 10:37:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09baff6e41acf4
X-Gerrit-Change-Number: 2037
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2037?usp=email>
X-Gerrit-Commit: 1e92a4fa3b9b79b02b111d1338c41c861ba475d4
X-Gerrit-Comment-Date: Fri, 30 Oct 2026 10:37:46 +0000
In-Reply-To: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
References: <gerrit.1793043747000.I695967524bb9e83887b8c07d0d09baff6e41acf4@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDQzNzQ3MDAwLkk2OTU5Njc1MjRiYjllODM4ODdiOGMwN2QwZDA5YmFmZjZlNDFhY2Y0QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <29b26916ec8d2c62389dd4fe8a4dfa80996bb292-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMjzf-0000000067U-2AHl
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add python scripts
 that demonstrate the ACC protocol
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Name of user not set \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "Name of user not set \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0664188149518877799=="
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0664188149518877799==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bjowglgjhu0="; charset=UTF-8

--bjowglgjhu0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Name of user not set=
 #1000061 has posted comments on this change by Arne Schwabe=2E ( https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail )

Change subject: Add p=
ython scripts that demonstrate the ACC protocol
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:

(9 comments)

File sample=
/management/acc_sysinfo_client_demo=2Epy:

https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2037/comment/412cb79a_3a2f35f7?usp=3Demail :
PS2, Line 84:      =
           addrs =3D [x[4][0] for x in socket=2Egetaddrinfo('google=2Ecom',=
 443)]
getaddrinfo is sync and it will block whole code, but maybe its not =
important for demo


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/commen=
t/d692af55_2380dac2?usp=3Demail :
PS2, Line 102:         if platform=2Esyst=
em() =3D=3D 'linux':
PyDev console: using IPython 8=2E39=2E0
Python 3=2E10=
=2E12 (main, Aug 31 2026, 10:18:17) [GCC 11=2E4=2E0] on linux

import platf=
orm
platform=2Esystem()
Out[3]: 'Linux'

It will be alwasy False


https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/9477fae1_d19b8c09?usp=3Dema=
il :
PS2, Line 123:         proc =3D await asyncio=2Esubprocess=2Ecreate_su=
bprocess_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)
Maybe we want to add =
timeout here?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/f7d=
993c6_478ee3d9?usp=3Demail :
PS2, Line 132:         print("=2E", end=3D"", =
flush=3DTrue)
Leftover?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/c=
omment/1816d935_417d4eb8?usp=3Demail :
PS2, Line 135:     print(f"Managemen=
t interface version: {management_version}")
Mix of print and logger


File =
sample/management/acc_sysinfo_server_demo=2Epy:

https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2037/comment/d245e612_a5ef3c68?usp=3Demail :
PS2, Line 3=
6: import base64
Unused import


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2037/comment/e96fe39f_1476743f?usp=3Demail :
PS2, Line 40: from pprint imp=
ort pformat
Unused import


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037=
/comment/dc4ba47e_04308cce?usp=3Demail :
PS2, Line 64:     def client_event=
_CONNECT(self, client, kid, env, extra):
Should we have here a method for r=
eautch client_event_REAUTH ?


https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2=
037/comment/56e858bd_12aeb4d1?usp=3Demail :
PS2, Line 94:             if ty=
pe(response[key]) =3D=3D str:
isinstance instead of type() ?



-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: I695967524bb9e83887b8c07d0d09=
baff6e41acf4
Gerrit-Change-Number: 2037
Gerrit-PatchSet: 2
Gerrit-Owner: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Name of user not set #10=
00061
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ge=
rrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Da=
te: Fri, 30 Oct 2026 10:37:46 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labe=
ls: No

--bjowglgjhu0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Name of user not set #1000061=
 has posted comments on this change by Arne Schwabe=2E</p><p><a href=3D"htt=
ps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">View Change</a></=
p><p>9 comments:</p><ul style=3D"list-style: none; padding: 0;"><li style=
=3D"margin: 0; padding: 0;"><p>File sample/management/acc_sysinfo_client_de=
mo=2Epy:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
s://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/412cb79a_3a2f35f7?usp=
=3Demail">Patch Set #2, Line 84:</a> <code style=3D"font-family:monospace,m=
onospace">                addrs =3D [x[4][0] for x in socket=2Egetaddrinfo(=
&#39;google=2Ecom&#39;, 443)]</code></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">getaddrinfo is sync and it will bl=
ock whole code, but maybe its not important for demo</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/d692af55_2380dac2?=
usp=3Demail">Patch Set #2, Line 102:</a> <code style=3D"font-family:monospa=
ce,monospace">        if platform=2Esystem() =3D=3D &#39;linux&#39;:</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">PyDev console: using IPython 8=2E39=2E0<br>Python 3=2E10=2E12 (main, A=
ug 31 2026, 10:18:17) [GCC 11=2E4=2E0] on linux</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">import platform<br>plat=
form=2Esystem()<br>Out[3]: &#39;Linux&#39;</p><p class=3D"blocks" style=3D"=
white-space: pre-wrap; word-wrap: break-word;">It will be alwasy False</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/=
9477fae1_d19b8c09?usp=3Demail">Patch Set #2, Line 123:</a> <code style=3D"f=
ont-family:monospace,monospace">        proc =3D await asyncio=2Esubprocess=
=2Ecreate_subprocess_exec(cmd, *args, stdout=3Dsubprocess=2EPIPE)</code></p=
><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Maybe we want to add timeout here?</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/f7d993c6_478ee3d9?usp=3Demail">Pa=
tch Set #2, Line 132:</a> <code style=3D"font-family:monospace,monospace"> =
       print(&quot;=2E&quot;, end=3D&quot;&quot;, flush=3DTrue)</code></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Leftover?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2037/comment/1816d935_417d4eb8?usp=3Demail">Patch Set #2, Line 135:</a> <c=
ode style=3D"font-family:monospace,monospace">    print(f&quot;Management i=
nterface version: {management_version}&quot;)</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">Mix of print and l=
ogger</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File sample=
/management/acc_sysinfo_server_demo=2Epy:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/203=
7/comment/d245e612_a5ef3c68?usp=3Demail">Patch Set #2, Line 36:</a> <code s=
tyle=3D"font-family:monospace,monospace">import base64</code></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Unused =
import</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/20=
37/comment/e96fe39f_1476743f?usp=3Demail">Patch Set #2, Line 40:</a> <code =
style=3D"font-family:monospace,monospace">from pprint import pformat</code>=
</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Unused import</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2037/comment/dc4ba47e_04308cce?usp=3Demail">Patch Set #2, Line 64=
:</a> <code style=3D"font-family:monospace,monospace">    def client_event_=
CONNECT(self, client, kid, env, extra):</code></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Should we have here a me=
thod for reautch client_event_REAUTH ?</p></li><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2037/comment/56e858bd_12aeb4d1?usp=3Demail">P=
atch Set #2, Line 94:</a> <code style=3D"font-family:monospace,monospace"> =
           if type(response[key]) =3D=3D str:</code></p><p class=3D"blocks"=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">isinstance instead=
 of type() ?</p></li></ul></li></ul><p>To view, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail">change 2037</a>=2E To un=
subscribe, or for help writing mail filters, visit <a href=3D"https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope i=
temtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" hre=
f=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2037?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"displa=
y:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I695967524bb9e83=
887b8c07d0d09baff6e41acf4 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 2037 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Name of use=
r not set #1000061 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-d=
evel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 30 Oct 2=
026 10:37:46 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: =
Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</bod=
y></html>
--bjowglgjhu0=--


--===============0664188149518877799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0664188149518877799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0664188149518877799==--

