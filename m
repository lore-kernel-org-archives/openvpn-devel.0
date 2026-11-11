Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4685A606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=D2Qb/0Lz;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=WMUTj/lD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kdOrGp95;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Os2dNBVf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NAY0RWcTCWvNP9TaE6vKbQXdgXBr1Ejqayb6cBndjWY=; b=D2Qb/0Lzb1vyFTj0OYM1rPtC3/
	ezmqW6rqKo3yprej1HKM+vlSb9m6WJmbCsLbAKj9RRUwxUNKyhfTXzcObPBsp1wY99pkWxtoAG/6D
	qnRuCogyl6b+u2qHXPbNnGCWaWmgv1UztGJr3vbbRWfFmQQqXxm5X5VpsuTJ5lYBcUlE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR5q2-000000005hJ-2ZIe;
	Wed, 11 Nov 2026 10:45:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR5q1-000000005h1-0QjO
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:45:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c2KPXh1V5hprO6uqN8nTSLoysZVuVxFQ2VXACxSD6us=; b=WMUTj/lDD+sGWuXq19wYgtBHan
 MCyFFWJTwx1PiEHypt8fYHbhGholhIf+Dbyp8DKeruDcQGpdZ+FpASvL62+oLUv6NZj8+yKUlqrLA
 iqohK8pq2/rviEOk8WN5BtO4jEYQQZQr3mA9kPmKjEcX38raPBJA8WlvBCQjBGiAEWCQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=c2KPXh1V5hprO6uqN8nTSLoysZVuVxFQ2VXACxSD6us=; b=kdOrGp95ktGUVM8TWUmB3phS3A
 pXVbwj69mwK147kAFGPXb1N4Y2q9T6wsNQd65gPLTGzEODlLkxqJRQkhdJHMOBHxyjt/lGzZ/IWKT
 ilVpIy+Q/92z5Kx3LAGMKiz57EJeH/fhmvheYia9pZ0zKSdlrG4T+f8PQCyHy9+pnBT0=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR5pt-000000004r5-3vNr for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 10:45:51 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-49465892f7bso2191333f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 02:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794393943; x=1794998743; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=c2KPXh1V5hprO6uqN8nTSLoysZVuVxFQ2VXACxSD6us=;
 b=Os2dNBVf/hi65ofCGPIr97RjmCU3wQ+njvkE/vnR+TyDu0AY4KvESF6gJEcpepQhXT
 jVO/hZHKmq33yxMjITvktnltFFp68huQEzTrClBgaD3RduI+D5ihLtklT/x4e6Et5zdT
 cp4Nq3txm/ZqnwkjZPYJZsI45aVyfDSL5vK0MBS48cVyPdcYhs8iDWJaK4wSkpGHVpRE
 Ksb4bvIZ5t2wpNzVbLwDOX20E85ivChvWwAy8GUbNQg1ndSgBUM9B2uFwEYf5G59sPKY
 S38/7BjDNKOHwenNzhHPUtLVifZEuchYfLur71SAb6niatzCkWtb3Uwdz2syQ1crEugS
 Khpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794393943; x=1794998743;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c2KPXh1V5hprO6uqN8nTSLoysZVuVxFQ2VXACxSD6us=;
 b=Wu5O2xmzmjjBfqjd6ZGm4zWnIZTrSya/ClTzPOZkN/8FeVPKDMbDO0TSJw+eF7UN3m
 0cN9TaTcQYNDZIlx3Ot2LB8+BV4lCrOBu/QfvpekJMal3X/xz+w4jfvPKgydW9Uj4ioY
 RDCe3OYO22Jjeet3/Qsnu97C/A2lGK3PtzCNsODvJ0xABKdEkfM/y4zn+qnPqDI3FaHj
 5IuZ+Av1WhDLmgs9TStvgjmTdV1AgsHcMMDdVllFAT1+vDoO56tyzfpECSJDM3A4bYQf
 pjcyaBoy8reCu6yM9ZxnmDzvKypm5cOUQHFBPKVC23ogkFFVCe6r5SD+RfwnoKQduKXw
 QLOA==
X-Forwarded-Encrypted: i=1;
 AL+hErFV4T5/cFvX19ts2rUvLYVKDduLj7kJQi/6Wt8mX56REUSI3Pn5D3YSVuC5dWEfn6S4/Tfc3Cjk6THzFyxv@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+VxbVx3r6VGee3I3Cnn4Fhu1yXKa4Xvp+Ji+LfOkLhKMcqdL4p
 Z27W3IN1x/dAPys94ZY1LUuyqo/HEoXAsItQtZ1vUBD0hV5djxhZKdVtYmxc+JjJ2SkIvUfrZBG
 mLgCoJSzuSvrEl21qYvatfvynrwU/yUxvwc6MnogKbXxjOMnRFC/kl5fe7cDCrBS+1hvg
X-Gm-Gg: AYBFou0XHcUTHa4mUtjMt1hmgdmgZidf9RdnDuDCIKcpkvP4bXJMwbwq2987zufXxTi
 GIYtE76eI4y63P0Ot0QfuqJYqvONKIqizeLduAuYP4J2r/Yq2XBam6FbGvlYq9cFnSo243lXsiW
 B84uhx+r4xRYrl5P/43n7rEgbR12KR/BDIu5pX343snRfBrBMio4gpFMkh5p06gy7BuQPjPLW7v
 cqM6I3wcXrKfdaEnWx+MhYqmw4T09eGwfjORd5V7hGGR+6TXO8k21QW7GIKgTXBXoDG81hRIVJl
 8hjVwPDuljmZTZTl0a+gKxYp/zkU38n6hTVGnWAigWbozMHXST9zKr1WTbzDuaXAZ1d85Iwgnx8
 qtjEogi+6VBmypqhCZtcPADWL2anjUztpf+k3Kr+ZAtsNmsaPbYW1n78NGIuthWLIxBbNkiRb+z
 /est5mDepaq7MvhIhhq/XwLHHJxqS4j1JyuU2BC3Zrpf+qMILSve34yvF+qPDdzz2sAupl5C8bP
 sjTouEVqyL4KNCQ4O/0RvE1gROlfo6JEGBThXDAuhVNKOIqcyWclHOwIZbQAxDRIFyzpdd6P95H
 qC1N+hp42a12Zj4XacNh7nTxUBPuZvTkRXty8Ip1stJYEbxsPHQeFsCIrywbKUUr6nxHhiuD1fX
 4wHJO7MsYp1kIHjOzK9HYb3K22SgcAjkSMw3HfMOY0+PYYROePY1a4yduK3aqzIwxXCSpSsqJ9Z
 SQ+5qwOSaH45Mn3pD1
X-Received: by 2002:a05:6000:2c04:b0:48d:ba3b:af36 with SMTP id
 ffacd0b85a97d-499c7082a20mr3454325f8f.37.1794393943173; 
 Wed, 11 Nov 2026 02:45:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3fd2sm10987198f8f.52.2026.11.11.02.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 02:45:42 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 10:45:41 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: comment
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf
X-Gerrit-Change-Number: 2159
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2159?usp=email>
X-Gerrit-Commit: f4af39057c64d44f868638c8bf1f5614b184bbd2
X-Gerrit-Comment-Date: Wed, 11 Nov 2026 10:45:41 +0000
In-Reply-To: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
References: <gerrit.1794300772000.I57469ca50c551ad475510690ecfa2d5e7cf9cfcf@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwNzcyMDAwLkk1NzQ2OWNhNTBjNTUxYWQ0NzU1MTA2OTBlY2ZhMmQ1ZTdjZjljZmNmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <50b4a3792cf9246b74ece266a654cb521425f09a-EmailReviewComments-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xR5pt-000000004r5-3vNr
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv: pass a
 lone config file to openvpn with --config
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
 openvpn-devel@lists.sourceforge.net, antonio@mandelbit.com
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3717472204634001200=="
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	MAILING_LIST_MULTI,MISSING_HEADERS,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3717472204634001200==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0COYJDLZgSI="; charset=UTF-8

--0COYJDLZgSI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Antonio Quartulli, Arne Schwabe=2E

R=
=C4=83zvan Cojocaru has posted comments on this change by R=C4=83zvan Cojoc=
aru=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail )

Cha=
nge subject: openvpnserv: pass a lone config file to openvpn with --config
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E


Patch Set 2:=


(3 comments)

Patchset:

PS1: 
> Thanks! The missing `ret` assignment is =
a real bug, but making this branch return TRUE has two side  [=E2=80=A6]
Do=
ne


Patchset:

PS2: 
OK, mingw in Wine it is then=2E =F0=9F=99=82


File s=
rc/openvpnserv/interactive=2Ec:

https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2159/comment/47ff4979_7e6e70b7?usp=3Demail :
PS1, Line 402:     if (argc =
=3D=3D first + 1)
> `if (argc =3D=3D first + 1 && !IsOption(argv[first]))` =
-- otherwise a lone `--option` is validated as a  [=E2=80=A6]
Done



-- 
T=
o view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail
T=
o unsubscribe, or for help writing mail filters, visit https://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I57469ca50c551ad475510690=
ecfa2d5e7cf9cfcf
Gerrit-Change-Number: 2159
Gerrit-PatchSet: 2
Gerrit-Owner=
: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Antonio Qua=
rtulli <antonio@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerr=
it-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Comment-Date=
: Wed, 11 Nov 2026 10:45:41 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels=
: No
Comment-In-Reply-To: Antonio Quartulli <antonio@mandelbit=2Ecom>

--0COYJDLZgSI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Antonio Quartulli, Arne Schwabe=2E </p>
<p>R=C4=83zva=
n Cojocaru has posted comments on this change by R=C4=83zvan Cojocaru=2E</p=
><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=3Demail"=
>View Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; paddin=
g: 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2159?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">Thanks! The missing `ret` assignment is a real bug, but making this=
 branch return TRUE has two side  [=E2=80=A6]</blockquote></p><p class=3D"b=
locks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2159?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> <=
/p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">OK, mingw in Wine it is then=2E =F0=9F=99=82</p></li></ul></li><li styl=
e=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive=2Ec:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/2159/comment/47ff4979_7e6e70b7?usp=3Demail">Patch =
Set #1, Line 402:</a> <code style=3D"font-family:monospace,monospace">    i=
f (argc =3D=3D first + 1)</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">`if (argc =3D=3D first + 1 =
&amp;&amp; !IsOption(argv[first]))` -- otherwise a lone `--option` is valid=
ated as a  [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To v=
iew, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2159?usp=
=3Demail">change 2159</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">s=
ettings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/View=
Action"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/2159?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I57469ca50c551ad475510690ecfa2d5e7cf9cfcf </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 2159 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Antonio Quartulli &lt;antonio@mandelbit=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Antonio Quartulli &lt;ant=
onio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Comment-Date: Wed, 11 Nov 2026 10:45:41 +0000 </div>
<d=
iv style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"dis=
play:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comme=
nt-In-Reply-To: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>

<=
/body></html>
--0COYJDLZgSI=--


--===============3717472204634001200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3717472204634001200==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3717472204634001200==--

