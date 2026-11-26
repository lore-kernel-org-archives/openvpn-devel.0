Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A17606A31E
	for <openvpn-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Fsm0Eyyl;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Exr0se6T;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R6IPgqlZ;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=dou5L+YG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ru57wwUJmAmSvKjCNQzVr12p+FFCpxB0nhFTwkFI9DY=; b=Fsm0EyylZRZr8O93VtHdarxwOP
	jSgv5yWuU3ujrP7Gd1VvJ8oWp/3HPakgPObl+XWTB6dT6wfDxbjPZNDru7dytOlSZv/IvJ7lTerxa
	kLaINs/kxRmcTr+YHL1ZHdWWUBZBDwddrgp3oFaceYZTQSXumbzuE6UZe96LY7CmnNa4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xWZdK-000000007uf-1bVB;
	Thu, 26 Nov 2026 13:35:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xWZdJ-000000007uU-0D2N
 for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 13:35:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ff7v5lARAbsu/+dLn1GqsDDmqwFl5SbeOeSRM2cVsNQ=; b=Exr0se6Th/+XUDt63Hoypuqisc
 Po6y0/jCu/Vm2I2fZSGd3NiuPKgenBMTJnE4GHxmlGnH7IrL5DGGIEwFIpbXRTOMzb/clhOYN7aGu
 +a3kEU4O7DZYRlNdDE4jTFmIW+O9L5suEXJCzqznat5xA/0aAf6rGw14TIreFEh4Kn9I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ff7v5lARAbsu/+dLn1GqsDDmqwFl5SbeOeSRM2cVsNQ=; b=R6IPgqlZLyeJ//plZ4i0EzaETr
 d02EteykLCyV7W0hljWJII4usznlBwdWafICoaFmNAf20VckV4Hkzyz7tBbaqPPZWEX2IOr2r0kqY
 vUBsPJpBgrL9eZk3e37+qjod3glz+uYawO0eAz0W7+0AxsEO/LZrWu3tKjm+W8y8SyGQ=;
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xWZdG-000000003tj-07KY for openvpn-devel@lists.sourceforge.net;
 Thu, 26 Nov 2026 13:35:28 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so49798905e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 26 Nov 2026 05:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795700119; x=1796304919; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Ff7v5lARAbsu/+dLn1GqsDDmqwFl5SbeOeSRM2cVsNQ=;
 b=dou5L+YGuWicEYhkon/SJGgLSc1b2xOYLNP2DHjoAR/8D8TkF79ngyp/9rrCSqfvQv
 YVzRCgaxn0jDasdJodJfMx0634R8ng1Sy/fd7WcmkUYEbsPHxh+3wtGUUwlCYamqJ2bj
 g0GsokGo6ky3STS7N8jUN4WOm/coo3W9WD6xbIf7U3A1r5P2ya85Fypz56hYEiYUnQhX
 t4RKf6wMjhTWSllhDLEhSD9MPYRO/pM/7SpHTsHBEXWemA3jvwEi2lOs/Ib8dnzEpjn9
 wsHFNQte2fsZDJn1YdIcMuBk+Mwi0lrEUOeiYWV7XXLvZYkie8mNw+rva3TBW9JKbQvj
 fBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795700119; x=1796304919;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Ff7v5lARAbsu/+dLn1GqsDDmqwFl5SbeOeSRM2cVsNQ=;
 b=Y9AG0meaUWBxxiCQ+7bmDq83NypfONmY4TDXL9hYbxrOSfcIgBsqrcE7QK3Ynh3BIX
 fzTi4XbCMx/f9oMAmiffRcVPen+HcMXMFkyYoCs3H5GW9s4V03G+/01xj/wmHAY2SY1U
 LQ+/T4+/oWjJB9AMqT9EWsBng3UxgWNiuZqAMTP1pQzVhf5eDmEQyBFuKUZF3eNpynUU
 XBg7VuEx26tjnbBZWPtGLGEPityriqF0SIhuJTGbhXwJqAQf3OYlfvkhTEC/XihmHqCa
 nYCiJi/UvSUUvrpWf7hvVHgTegS1JoltOUTpLUu7+NBQSiWNlfEvF/SpHWlh153+6ZIp
 vJUw==
X-Forwarded-Encrypted: i=1;
 AL+hErGk+I+RzCrWBNstUtJCpY54o4eBEZBxgO+19RfJRXlUWt2HxoseTPTL+/17PcrwNiAb+4HOsc0OJ65QZuU/@lists.sourceforge.net
X-Gm-Message-State: APuU4Z873jgRxLmaldHnx13nZB0pIIFAlt2iCdh/dmQCNYYsbp5WF/CF
 dcgXIwSSEbBVY/H+q1shUHeyXTAw6R+mZsHljbQ6RjsvfxACrekv7wmwMxKWs4zuAyoptIw9h8O
 eTwsUoGx2m2NUCspLlwqkQP/2XNb3PK5ZY3FxWSBt5andXEmbh8BmmxftBTm+p7Z7N7Hm
X-Gm-Gg: AZFdTZcsixwfYRjBIInz7dmN0BadshHqH7M8MTptOVHWPBp5P5sth2v8Mu4Jih7KVRk
 tsMvWsiGBl/2jjoE1dtHAsfoAihddX5fSRx5AVhlodtM+LZNOmwwCm1vUK6/CZf5Rix02pst4XZ
 /4pbOAOMygjDzkvsSDqLPWcHN2MD+jilaZAqtwaBudk5KCMnlCFBS+fR4JwkFcDRI0QkPvAbVW9
 WsXwhWatUzMT7LPnKjxdTFwns+30k2aDHG/VpEE3yASJ5Q6P5vjcgesxJbOdkQiT61t08xCxeve
 EqKLugl09PkLR2RNBSuxQ2OCuTd2qF90cNcAWbiNaQNf1RTk8ZClhFyJF+iuSc4DmkdaVpL//3M
 PsIMkcQ7IIUTKnBQJy/HWnPfz1IiCDNs4qihhBQPXNyrupN+Q5S5L4dPEYhfA17qiWMJy/HLKQL
 aUtp0LOdeE44jir+8XHn/+T3SpbABVpfCPpePv0p6UK98Fo/4tSukL26njXtHork6kHoNbUFcim
 JEIM4Rwv7n2+IQDzlApO7F1n1OO7AYzYr24jUmrAsteDzGpCV14VAdH9MJrkNDREEPvoRlDdrk4
 Gmy/RfScsMkoxcyRf68vAsnintaPrnItaoFdKdBIO4dsGGn7omi0+2gjKfms854vofTmt6uwg6i
 s+LZFqjEKVOUvPm+VGg3vQZ+L7ERPpwDQ8JqfgC3exJw+Zh4XrteDx5Z6aCL43/yin0aU6SpxQd
 oRZ6YykmaCoP0GyeVGhXl/jsvtIXd0x6R7OVN4kQ==
X-Received: by 2002:a05:600c:4e0d:b0:4bb:69b2:d3b3 with SMTP id
 5b1f17b1804b1-4bb8881eea5mr430211685e9.27.1795700118290; 
 Thu, 26 Nov 2026 05:35:18 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb88402ce9sm494603445e9.0.2026.11.26.05.35.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 05:35:17 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 26 Nov 2026 13:35:16 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
X-Gerrit-Change-Number: 2355
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2355?usp=email>
X-Gerrit-Commit: 16ea2d6f7698f7600e5c918afef0d8ec37419077
X-Gerrit-Comment-Date: Thu, 26 Nov 2026 13:35:16 +0000
In-Reply-To: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
References: <gerrit.1795699206000.I1f775940c13cf989cf804bf637d4a63c3fe5aaaf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1Njk5MjA2MDAwLkkxZjc3NTk0MGMxM2NmOTg5Y2Y4MDRiZjYzN2Q0YTYzYzNmZTVhYWFmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c87490ea4549a83a56715ebb17e607a6c469e220-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xWZdG-000000003tj-07KY
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleaning up Windows
 error handling for signing conversion
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============4227409107883539203=="
X-Spam-Status: No, score=-2.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4227409107883539203==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4x/RKZ2gdE0="; charset=UTF-8

--4x/RKZ2gdE0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by Frank Lichtenheld=
=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail )

Change=
 subject: Cleaning up Windows error handling for signing conversion
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 1: Code-=
Review-1

(4 comments)

Commit Message:

https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/2355/comment/1793ab56_3eca5954?usp=3Demail :
PS1, Line 7: Cleaning=
 up Windows error handling for signing conversion
"sign conversion"?


File=
 include/openvpn-msg=2Eh:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355/=
comment/bc74bc9f_ad0122cb?usp=3Demail :
PS1, Line 160:     NETIO_STATUS err=
or_number;
FWIW, this header now doesn't compile on its own anymore, becaus=
e it does not include netioapi=2Eh=2E

Doesn't seem to matter for the in-tr=
ee build because other places it's used in include iphlpapi=2Eh first=2E


=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355/comment/0dd5a3fa_c1205cba?u=
sp=3Demail :
PS1, Line 160:     NETIO_STATUS error_number;
`error_number` s=
eems to be assigned a variety of types in the code (registry `LSTATUS` valu=
es and `ERROR_MESSAGE_DATA` to name a couple, probably others as well), not=
 just not `NETIO` results=2E

Using a plain DWORD here would also fix the s=
tandalone header build issue and be more neutral WRT all these different ty=
pes=2E


File src/openvpnserv/interactive=2Ec:

https://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/2355/comment/4e033c31_d37b0720?usp=3Demail :
PS1, Line 3077=
:         err =3D (DWORD)reg_err;
Why not just `err =3D (DWORD)SetDnsSearch=
Domains(=2E=2E=2E);`?



-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2355?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I1f775940c13cf989cf804bf637d4a63c3fe5aaaf
Gerrit-Change-Number: 2355
G=
errit-PatchSet: 1
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>
Gerrit-Comment-Date: Thu, 26 Nov 2026 13:35:16 +0000
Gerrit-HasC=
omments: Yes
Gerrit-Has-Labels: Yes

--4x/RKZ2gdE0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by Frank Lichtenheld=2E</p><p=
>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; marg=
in: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span></=
p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail=
">View Change</a></p><p>4 comments:</p><ul style=3D"list-style: none; paddi=
ng: 0;"><li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2355/comment/1793ab56_3eca5954?usp=3Demail">Patch Set #1=
, Line 7:</a> <code style=3D"font-family:monospace,monospace">Cleaning up W=
indows error handling for signing conversion</code></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">&quot;sign conversi=
on&quot;?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File in=
clude/openvpn-msg=2Eh:</p><ul style=3D"list-style: none; padding: 0;"><li s=
tyle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><=
a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355/comment/bc74bc9f_=
ad0122cb?usp=3Demail">Patch Set #1, Line 160:</a> <code style=3D"font-famil=
y:monospace,monospace">    NETIO_STATUS error_number;</code></p><p class=3D=
"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">FWIW, this=
 header now doesn&#39;t compile on its own anymore, because it does not inc=
lude netioapi=2Eh=2E</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Doesn&#39;t seem to matter for the in-tree build b=
ecause other places it&#39;s used in include iphlpapi=2Eh first=2E</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355/comment/0dd5=
a3fa_c1205cba?usp=3Demail">Patch Set #1, Line 160:</a> <code style=3D"font-=
family:monospace,monospace">    NETIO_STATUS error_number;</code></p><p cla=
ss=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">`erro=
r_number` seems to be assigned a variety of types in the code (registry `LS=
TATUS` values and `ERROR_MESSAGE_DATA` to name a couple, probably others as=
 well), not just not `NETIO` results=2E</p><p class=3D"blocks" style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">Using a plain DWORD here would =
also fix the standalone header build issue and be more neutral WRT all thes=
e different types=2E</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpnserv/interactive=2Ec:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/235=
5/comment/4e033c31_d37b0720?usp=3Demail">Patch Set #1, Line 3077:</a> <code=
 style=3D"font-family:monospace,monospace">        err =3D (DWORD)reg_err;<=
/code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Why not just `err =3D (DWORD)SetDnsSearchDomains(=2E=2E=2E);`?</=
p></li></ul></li></ul><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2355?usp=3Demail">change 2355</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2355?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project:=
 openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<=
div style=3D"display:none"> Gerrit-Change-Id: I1f775940c13cf989cf804bf637d4=
a63c3fe5aaaf </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2355=
 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"displ=
ay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 26 Nov 202=
6 13:35:16 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Ye=
s </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body=
></html>
--4x/RKZ2gdE0=--


--===============4227409107883539203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4227409107883539203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4227409107883539203==--

