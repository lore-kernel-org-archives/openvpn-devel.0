Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AC606A88B
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XzmAEsLO;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FhFlBqjy;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SM6pnTvY;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gp3URZcJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=OkNOssx++XS7JTN8uHvTKuEWiZ9q12EAntiobgklv7k=; b=XzmAEsLOuADmxkAsvUB1YK/ZSC
	dB6f/GJq8rJtqvaP5aA15L+CJV+a+b1/80GxGaeoFHzP7zz3ZMklYET0q8K93Sj8PXVpznbR19NLB
	Huv4vD+RFIXk/Jhdibm7GzdBcZVJl4imgo01NdzEzh8zDZNfArEd9+pE/Rp9C0LaQo0s=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR5B2-000000001KU-1F7V;
	Wed, 11 Nov 2026 10:03:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR5Aj-000000001J3-1xHf
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yklNkqkwuwUrNFEArFBtgs56cnFvuYgz0anMWknx9h8=; b=FhFlBqjyi+UxVlpMscWF8IzB+d
 3whStWzm+jZd1H1zHr54i2TdLeKF3sHX0EZQC9Bxveeefpt2UbHeP99ZtKLdeIQ0P5ggBVeKxGfN+
 JM8biQzg6s2sArEmeAqiF5MuSR5Ilurhd9f6rM3s8Us/9s/TM/eqHa95OniaO9UQzFVs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yklNkqkwuwUrNFEArFBtgs56cnFvuYgz0anMWknx9h8=; b=SM6pnTvYNIsipw0pU4Chk2x4dR
 MQF0IAUYgySNb74S5htOlYG3bXacUF23vQkMIbSCb6WogMbzPUj2QpX812VqAAIteDxumWmhGp2rX
 WR8Myn9Mt/1tGTRWOnAAoumocDJlujNtbb0lx4eHwKFYc9z8y8aLEIIFY8WNPo38s0+c=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5Ae-000000001wk-3kIE for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:03:14 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so1603279f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794391386; x=1794996186; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=yklNkqkwuwUrNFEArFBtgs56cnFvuYgz0anMWknx9h8=;
 b=gp3URZcJQDe9wFNSNV2rOdnfI8AFTao0rhznCGYITqoyuDghU7PO/xjp3fydCOJim0
 jIcRzS9X6171bf0Q0ve3aVXN+cUYGnGYZKI9WJ6grrReAji7NxDO2xfITCqAKTcP7WkM
 CllOrr/cZuGgtq6+rzQeVBB0u/owGsJ/VjOESlIGI3gtIdycV7VccF2Nu47gsfTjgIdj
 qbWmErNGbd+R7vAfDtBGduhIplI+gxGRcFve4LERFBAK9gjM8YlvTm1zMD7lghNuygw3
 SGWn0oBq0f1+UIRvMs5Kepd9szqLvW7j85XgI46pghep8Z6gyxGhaXkWHt5pLzIE1PdJ
 E/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794391386; x=1794996186;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=yklNkqkwuwUrNFEArFBtgs56cnFvuYgz0anMWknx9h8=;
 b=KM5/ncqz779UxniWGZ6loOUExfQ/IexrKaHLkpnpDRgEmOCL3z65s2jtPf7XosnfPD
 qTbLKmfoW3922ZqnqDu9fj09hseY11eMwAlenaduWYwntNn4UGxZPSR/W7VxYWhMdLDU
 yoRtEUHLmTYrDkI15V0hIBxAaUbiDuqGflEOeakAuXLSNhmuj4Lc6kv9fODuqC0r8ScD
 SeJqbsE5H1BvRbYg1rJP/hXZ07JN7WcdMs5F+sLFG6VeWOybv8hEgmgeDHVBrZ3LWloP
 DQa2WnVrrZC8TEkSzKrO42KVj2MLzVTTd8FrT2zaxRfM6UOoT+Z9lQZNVSQWbdGZno+D
 BK6A==
X-Forwarded-Encrypted: i=1;
 AL+hErEJI1Ynlhctp7FxPxEhACjCEk7hnvqsv7z8YUQLcTCGPR6ivVcuPrXAGoIgryt4IMNBR461wvo62EcljXl6@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8CiBLA9gW7N7skNhw65AtH6gSjV1w7/dJxlRfPHmOPW38gcn0+
 rAomiP2r+Q5nKp1URWbmeMuhXIBhK4CQ9PzI8tchklwQxyFLsH++pQ2K1QxBQk6a9jDDBPnkFI+
 0aSnIdmZhI6GZ+D8PT6gy6bVGrQTzy1J91da9B3sR/Pj7e1HboHdYFiGffN1jlbnaLR1oij80Kk
 rnxdMcYQ==
X-Gm-Gg: AYBFou2mfzza/5nsWLzfx416vQjbmO/G7t2+KA/C/20sf9H2r+jinwU0pP6DsDmVjvb
 JX/ixF+MKDxMliqkwq82TML6ARxDaAuOPiItev53cOvqh7thW4ox/SxNjZZSZsvzTIJ5k/3Dybi
 jrrcKVpJcGcXIjrU+jeyvz+S6hph2HxaiT2eflKCx+9QcnS6KaQKi1JdjvvVvbF4A7qrIoLzN4Y
 rilKD0ZPnOhBTFvIkFlDCMVZ4qXeq30zp0IL8gK6DFS6nD0uMYSvoL/iCq4ZDEmNUEbkFWYYNRM
 EnAViJGYoU57DOW1VJ4/RAnfDxGKf9SsOqn5eaiaC6/mHrd3sKraizaW3jfXyunurm9zOAmgbU9
 Ezp7D1y6vH4jF9wD4IDJFQUcM74a+1DsXhnK7nyw9gUw1rpkm0jdQf5jIZCxwm/+phyoKkRBmhO
 PQqIsFUcrGg6ipRtquD9gryI36CbEnUED5h7ODLmII8RnfmfMY8dzEFEvawqXZ+bcmqDoKx0sB7
 o+l6MIbnLHKLL2tVnwO7S42iHNdb8YFB23slvQ4AdtwkyKjZGoVGuGpH2ap7OXboKoR2i5WNiUU
 vw6Ih5Nh0uTqp1sja0K7/MfLqrx80Ie2Hezd8TKEgBZHTZvxuaS+g8sISZ9uziD7G9TUNkbeBOF
 3/J6a4BUbGyXQxBMJhvT9XRan6GZQIOvUTW+JcPL6s9FOkmIrqBaRaGNEgEFkng04ZLLeuFF0MM
 SQaSB7MeOppNdAm0oZCOXqL5dpVaA/7sh/JwTc
X-Received: by 2002:a05:6000:2512:b0:48d:dc6f:219a with SMTP id
 ffacd0b85a97d-499c6405960mr2977278f8f.27.1794391385960; 
 Wed, 11 Nov 2026 02:03:05 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49944d646f9sm6112073f8f.32.2026.11.11.02.03.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:03:05 -0800 (PST)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 10:03:04 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: 3ac6ba619e4e2bebdc5f54b0e80b79f0dcdf225a
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 10:03:04 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <64136cb33cb7b8ee1c3dc13ba64f848e565ea1bc-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR5Ae-000000001wk-3kIE
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: accept
 a lone config file that passes validation
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
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4374342929716341273=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4374342929716341273==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ug5RdlxSk1U="; charset=UTF-8

--Ug5RdlxSk1U=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E=


Antonio Quartulli has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail )

Cha=
nge subject: openvpnserv: accept a lone config file that passes validation
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1:=


(2 comments)

Patchset:

PS1: 
Thanks! The missing `ret` assignment is a =
real bug, but making this branch return TRUE has two side effects:

1=2E A =
lone *option* now skips the whitelist: `--foo` is only checked as a path (`=
<config_dir>\--foo` passes), while openvpn=2Eexe parses it as an option=2E =
Please only take this branch for non-options (see inline)=2E

2=2E A lone c=
onfig file still doesn't work through the service: openvpn=2Eexe gets `open=
vpn --msg-channel <h> foo=2Eovpn`, so `foo=2Eovpn` is taken as an extra par=
ameter of `--msg-channel` and ignored (the "lone arg =3D config" rule only =
applies when argc =3D=3D 2)=2E Users would just see "You must define TUN/TA=
P device" instead of an empty error=2E

To actually support it, I'd suggest=
 building the command line as `openvpn --msg-channel <h> --config <arg>` wh=
en a single non-option is given, *before* validating, and dropping the spec=
ial case in ValidateOptions()=2E That way we keep validating exactly what o=
penvpn=2Eexe gets (see c139e82d)=2E

A small cmocka test for ValidateOption=
s() would be great too (lone `foo=2Eovpn`, lone `=2E=2E\evil=2Eovpn`, lone =
`--script-security`)=2E


File src/openvpnserv/interactive=2Ec:

https://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/2159/comment/e32fe0df_f64b4e5c?usp=3Demail=
 :
PS1, Line 402:     if (argc =3D=3D first + 1)
`if (argc =3D=3D first + 1=
 && !IsOption(argv[first]))` -- otherwise a lone `--option` is validated as=
 a config path instead of against the whitelist=2E



-- 
To view, visit ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail
To unsubscribe, o=
r for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit=
-Branch: master
Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf=

Gerrit-Change-Number: 2159
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Co=
jocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@=
rfc2549=2Eorg>
Gerrit-CC: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Sc=
hwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date: Wed, 11 Nov 2026 10=
:03:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--Ug5RdlxSk1U=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, R=C4=83zvan Cojocaru=2E </p>
<p>Antonio=
 Quartulli has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"=
>View Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2159?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Tha=
nks! The missing `ret` assignment is a real bug, but making this branch ret=
urn TRUE has two side effects:</p><p class=3D"blocks" style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">1=2E A lone *option* now skips the white=
list: `--foo` is only checked as a path (`&lt;config_dir&gt;\--foo` passes)=
, while openvpn=2Eexe parses it as an option=2E Please only take this branc=
h for non-options (see inline)=2E</p><p class=3D"blocks" style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">2=2E A lone config file still doesn&#=
39;t work through the service: openvpn=2Eexe gets `openvpn --msg-channel &l=
t;h&gt; foo=2Eovpn`, so `foo=2Eovpn` is taken as an extra parameter of `--m=
sg-channel` and ignored (the &quot;lone arg =3D config&quot; rule only appl=
ies when argc =3D=3D 2)=2E Users would just see &quot;You must define TUN/T=
AP device&quot; instead of an empty error=2E</p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">To actually support it, =
I&#39;d suggest building the command line as `openvpn --msg-channel &lt;h&g=
t; --config &lt;arg&gt;` when a single non-option is given, *before* valida=
ting, and dropping the special case in ValidateOptions()=2E That way we kee=
p validating exactly what openvpn=2Eexe gets (see c139e82d)=2E</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">A small=
 cmocka test for ValidateOptions() would be great too (lone `foo=2Eovpn`, l=
one `=2E=2E\evil=2Eovpn`, lone `--script-security`)=2E</p></li></ul></li><l=
i style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive=2Ec:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2159/comment/e32fe0df_f64b4e5c?usp=3Demail">=
Patch Set #1, Line 402:</a> <code style=3D"font-family:monospace,monospace"=
>    if (argc =3D=3D first + 1)</code></p><p class=3D"blocks" style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">`if (argc =3D=3D first + 1 &amp;=
&amp; !IsOption(argv[first]))` -- otherwise a lone `--option` is validated =
as a config path instead of against the whitelist=2E</p></li></ul></li></ul=
><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/21=
59?usp=3Demail">change 2159</a>=2E To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eor=
g/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: commen=
t </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2159 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Antonio Quartulli=
 &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<=
div style=3D"display:none"> Gerrit-Attention: R=C4=83zvan Cojocaru &lt;razv=
anc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 10:03:04 +0000 </div>
<div =
style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"displa=
y:none"> Gerrit-Has-Labels: No </div>

</body></html>
--Ug5RdlxSk1U=--


--===============4374342929716341273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4374342929716341273==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4374342929716341273==--

