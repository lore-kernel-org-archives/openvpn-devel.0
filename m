Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71062606A33D
	for <openvpn-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=GWttJNuk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=B9lsjKMZ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R8dP2e6A;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=DddjPGSQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=HAMec9Fe1WI/BoQTgNi96oBjjymCQKm61j0pu1LkPYk=; b=GWttJNukZahyQZVLbtdEgOwvlW
	8M1hLCndgz3ngkIkeQpcHLQosBqb+3fw7bCs0KXFOmqpS9CBjpUep9A8mI2KO6Y4X6VF/BPBZ3qTK
	Gkl96uD8yWdPLaWGyS/wHOF0tE3WbQ5g9KT13LVOTKyX1x9DmcEHMYQ7nmCd7dL0oTn4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xR3S7-00000000126-3Deq;
	Wed, 11 Nov 2026 08:13:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xR3S6-0000000011z-0mKZ
 for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:13:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fiwaet3WrwOhb88IUXRAzckWeV3nARwesLQO1LrYSqM=; b=B9lsjKMZ7D+aRFHz3l1x5rQbx2
 WpzvK7KjfVp0ELXJ5l0iWNp1xPKswCRiVlPjGQD11A2SFqmQicTPkowffwc1QqLDH5HLwTbfd1pYy
 kgpgAK7WFyGNBQvDoPzDM0xo4e9fVL+P/gV0ybYwM2gK5iQ1aL5ioN65mInhqU5yy4Cw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fiwaet3WrwOhb88IUXRAzckWeV3nARwesLQO1LrYSqM=; b=R8dP2e6AAyvvSUfuFAdbLkjPev
 rgYnLvkAVMIwnnbthuBYkn/JzNCjUDCS0mnCa5L3pVy1zE2wur304AJ5sYdBV2zoiVyAAme/tdOGW
 glcAbVoLrL/gF6hhmwj5MsKo+NKad90BuLonawm4P3xxXlB8nYERx2Bxxmwu8bcAkTEY=;
Received: from mail-wr1-f50.google.com ([209.85.221.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xR3S3-000000006Vy-1eGP for openvpn-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:13:06 +0000
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-490585eddfcso2251907f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 11 Nov 2026 00:13:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794384777; x=1794989577; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fiwaet3WrwOhb88IUXRAzckWeV3nARwesLQO1LrYSqM=;
 b=DddjPGSQnchLSjMfrE1UL47Br8pmY4TFnmsVHTuqg/NGTYhAKzdGfsuNwwiEDZipzT
 AQa5Ul/VqQDPg+HCoaoMaBnZz3+NO3T9LOjQDEPEy8zA9btzwpMzzIzDIfzGkCEIMciy
 oAOrYRcHWR1AtNZ+veO1oDSJbeZqI4nzLgjfZPACpJ30javVGLib8KKvwARyNWemZiYW
 Yr/0CN1N//94QXLYQWHFEXU5NpiFOu/QfYQkLHPbt8eKeuCoTFdvQnVH8hvMHFHyHxei
 V3kSHS51f6VoPmnnjKz2uB1zdC4mMUPOx9xGI2GRA2g6G9CAOq0S0Mpx2wkGuvhsXbgn
 XMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794384777; x=1794989577;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fiwaet3WrwOhb88IUXRAzckWeV3nARwesLQO1LrYSqM=;
 b=re0DkkEHHIlv9vePmnTy/HO/rLXHGPISmq7/ukqzzoQofbO91uruXLlEmEqw1ExAOI
 ZSHDPm2XBwPvhrMv0Oxzyp/PnAqPVokuJrq5ADDA18wQMffTOFdfq+logA+tRuPV3R8K
 GALUBRIc8WT6PAfROBu4fEdYPAbZTCfrEJMYLUd8q17vhs67MB+y0bYo3eLkJ+GRzZlE
 Gcwy34m/zWUNmcHRRcDAM0iTAZLKe0bJfjQB4QaherwibWGS1kOpsb11/cE314668C3D
 QDJl+i6XtwOSfdMEkxvygivMeqcTl5V7h+8UenWU0oX6hes7FD4BJa432UE7qCu85Ram
 nNxg==
X-Gm-Message-State: APuU4Z92m2L/cW7Iq0n6yCgbHFtsHZ32/tEDlArGF/jyeEYk93tZqHBt
 HymsSiRWbHeUVZ97Vf/iH9LuMJjRFwffxmjQeKt5umLwK5Eay201bvzRUMp0nFsZoF1ud3jM1B/
 EcRdfP19dpIwpVHHAgPs/e4UeJhv1AkSbXhT2Y0vXCY5blZXBcGLLsoNyqrYkeXcbs0zQQzhcNd
 /BV7IJuw==
X-Gm-Gg: AYBFou1D7BAmFqQ1j4s4mZ9KdIxv+6if33305+uk0JgBhC/5nt2/oAujmqGe8pARAZi
 ZL5Kctx0VmoapynpcaNnRfPbGau2fPRsRQbYmEYh+adRzN0+KVFUGhKMNJXmNE8ATBV+tcRdIY8
 2O725havBrRk0Wq1AjAxPWvcxwK5FptCQgMiKAykc6qbBnWmEtcjaydnuWvYveyRJbDOHgQa4P3
 SerGqQvGwLPYPofw3tJsI9NfjbDqNWy3qPVbDNuMvNVgT5ttyGrNRW0H1a7PneW+CxC0ZaWUmyT
 bTw4/rZj0TGNxaMPVTKKPgIw+7BBNpu7ZcK+X+6xj7x3UnyABN9Oq9+Ju4fu50kMd/dCCXD/vFu
 qxXepF0Ds8EloqC3g1sRMrSDG22VRZReQqUxlmTRnQ1WYe9CnewpbZ6f9kylrJcnynli5v/6uM+
 0nH7I3dYNEeqUYYwOgJQhx8eNUbHhTbxpOH4DJQY/QfLs3sxCHV4WZ1IZXokSC+GVwkH3I2iN+m
 jl2uV5wMJWl0KMvIxn75dJ5Jbe1ykcJcss5MBWihitomvQ40d8quedCxX71dnLz2lW+t2wVMh8w
 MBy3UalKoHLPKPU0xzwxVOtzd6d6ADnuSFIUKmv0TB8j6nZOR38MIil3c0gTTgi1WGu4WKuXBvz
 IIN33k0jjN+SE8kmCn5pmPX7GhLYodirLSHG+zkG2TWmJXMkPH+gTBCmMWp0SB9F2Lx+VcTYLX+
 vHmilfjjDtmMMo678jmTbp2B443mnemo/0r6lC
X-Received: by 2002:a05:6000:25f6:b0:48d:f1b3:c02e with SMTP id
 ffacd0b85a97d-499c7082519mr2376664f8f.25.1794384776562; 
 Wed, 11 Nov 2026 00:12:56 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-498369a3f4esm10415071f8f.53.2026.11.11.00.12.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 00:12:56 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 11 Nov 2026 08:12:55 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8
X-Gerrit-Change-Number: 2171
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2171?usp=email>
X-Gerrit-Commit: 2fb1c6db2baabc706c18413fa078d7af5a05cf81
References: <gerrit.1794384773000.I1295d911c993a02397565e26cece0f0861a2e5f8@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0Mzg0NzczMDAwLkkxMjk1ZDkxMWM5OTNhMDIzOTc1NjVlMjZjZWNlMGYwODYxYTJlNWY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f0b5b60964f44a29915359cf56523e846c677dfc-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xR3S3-000000006Vy-1eGP
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: init: free
 actual_name when replacing the Android tuntap
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
 openvpn-devel@lists.sourceforge.net
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0599089687363294271=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============0599089687363294271==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i3BBcfcz1s0="; charset=UTF-8

--i3BBcfcz1s0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2171?usp=3Demail

to review the following change=2E
=


Change subject: init: free actual_name when replacing the Android tuntap
=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

init: free ac=
tual_name when replacing the Android tuntap

With --persist-tun, do_open_tu=
n() frees the old tuntap struct but
not its actual_name, leaking it on ever=
y reconnect=2E

Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/init=2Ec=

1 file changed, 1 insertion(+), 0 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/2171/1

diff --git a/src/ope=
nvpn/init=2Ec b/src/openvpn/init=2Ec
index 3bc4de4=2E=2E6664a4d 100644
--- =
a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -1845,6 +1845,7 @@
   =
      if (c->c1=2Etuntap)
         {
             oldtunfd =3D c->c1=2Etunt=
ap->fd;
+            free(c->c1=2Etuntap->actual_name);
             free(c=
->c1=2Etuntap);
             c->c1=2Etuntap =3D NULL;
             c->c1=2E=
tuntap_owned =3D false;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2171?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I1295d911c993a02397565e26cece0f0861a2e5f8
Gerrit-Change-Number: 2171=

Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>

--i3BBcfcz1s0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">init: free actual_name when replacing the Android tunta=
p<br><br>With --persist-tun, do_open_tun() frees the old tuntap struct but<=
br>not its actual_name, leaking it on every reconnect=2E<br><br>Change-Id: =
I1295d911c993a02397565e26cece0f0861a2e5f8<br>Signed-off-by: Razvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/init=2Ec<br>1 file c=
hanged, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/71/2171/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>ind=
ex 3bc4de4=2E=2E6664a4d 100644</span><br><span>--- a/src/openvpn/init=2Ec</=
span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -1845,6 +1845,=
7 @@</span><br><span>         if (c-&gt;c1=2Etuntap)</span><br><span>      =
   {</span><br><span>             oldtunfd =3D c-&gt;c1=2Etuntap-&gt;fd;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(c-&gt=
;c1=2Etuntap-&gt;actual_name);</span><br><span>             free(c-&gt;c1=
=2Etuntap);</span><br><span>             c-&gt;c1=2Etuntap =3D NULL;</span>=
<br><span>             c-&gt;c1=2Etuntap_owned =3D false;</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2171=
?usp=3Demail">change 2171</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2171?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchang=
e </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div s=
tyle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:n=
one"> Gerrit-Change-Id: I1295d911c993a02397565e26cece0f0861a2e5f8 </div>
<d=
iv style=3D"display:none"> Gerrit-Change-Number: 2171 </div>
<div style=3D"=
display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerri=
t-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div sty=
le=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--i3BBcfcz1s0=--


--===============0599089687363294271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0599089687363294271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0599089687363294271==--

