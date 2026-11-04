Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5C9606D82D
	for <openvpn-devel@archiver.kernel.org>; Wed,  4 Nov 2026 07:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BOkQ7pqw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BD/2T7Pp;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=A8PyMhzE;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Nbtqld6G
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Sqdw6BlK0L65v5E5d3S5Czzvn3Q4GhmUFVPy7SALfbI=; b=BOkQ7pqw8MTn43xllDGl+rU/L4
	p7y6NOqGJdMUL2McuMzN/4dK869fSQmhxjf2aUOXksfEgNKTRcDko5sEaoCdnPRv7/nBy2E8KxY5p
	hH4d6iv2kVUJY++L8yBCt0mFcbMh7c/G4/azImpWdtvrEDVDgmg3mOmaUOI2WNP56Cr4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOVF5-0000000008L-0Cs6;
	Wed, 04 Nov 2026 07:17:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOVEm-0000000007i-32A8
 for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:16:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lzaXXzG9IZMBB1WDJjLxZWnvVES7RX1cLDM8iRWA1Ng=; b=BD/2T7PpdixeTsJQJMxWMM/TzI
 5OpR76/PHWrOP7gCmeDLk4HFWtwZc1MNw54gId/wQvEjEzOXJoKyb5o5W/ephm2k2BRKBYoG3JJ22
 Axvt0lUUcKAX/VvBn/t48qfiyGW/qVgHINfo7AyctqZRhCIPLeJZduW6xC4GKPiQh4Pg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lzaXXzG9IZMBB1WDJjLxZWnvVES7RX1cLDM8iRWA1Ng=; b=A8PyMhzE5Qb3SC+c9FbxR54fbY
 016PqVWjaBs1Kn3obGQ1K2iPNBR+f3SZIy6f8FxkuDTbtMcfok1RlEgHiR/jW07vjM3Ss/fwesjoW
 bw1R+QsOfZt0mhPFe6ffQzC8J/gC85zV08lAh2SFiEzWZqZXSA1w+ADb0K0LF06kp3RI=;
Received: from mail-wm1-f54.google.com ([209.85.128.54])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOVEe-000000005pq-49Oy for openvpn-devel@lists.sourceforge.net;
 Wed, 04 Nov 2026 07:16:42 +0000
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5087a5348so2329265e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 03 Nov 2026 23:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793776594; x=1794381394; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lzaXXzG9IZMBB1WDJjLxZWnvVES7RX1cLDM8iRWA1Ng=;
 b=Nbtqld6G3zbz3E4oViF5IYpNNoUs2aU1C4XjxE/3CXf2duynpA8MkTNsssjGdU6pZ5
 d4wFF/C9ULHP+/9pFgqZE1VIo8W+iVEZcIMSzXoZ2J/CuQ02hj9vpMuk0gn49QeU6OBa
 M8XzLNto2SazEXROD3P4BslCCDNOVo/3uvJDBoCLKsX9AwBCSTQm6vkt+v+jd5CybImU
 mfcoJZ9q0JbVMMX1Dy8YmMgbF+8V0HaFVcEHLU6r5chIUbu4k0mD+xf3sLI7/27gjid9
 MeCPzjsNN1CG2qUdp8dvp0sDgZOqMAKx6/KtUBFRfCW4GP0UnwzgXrsW56EqH7fezGZN
 YQuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793776594; x=1794381394;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lzaXXzG9IZMBB1WDJjLxZWnvVES7RX1cLDM8iRWA1Ng=;
 b=1pUC7uX7ynt25DWuStrBz7FFww7N1ZBERwOs71bwIStUx4quxyq9Z8aircyTFHM5jV
 lp5WaZShTKJN1tg2iQus08S2jIE7CFfcOnnmO0bLXDbhX3ZHI4ENNjtYtWCiTVWB0bd5
 IhoU4/9a7kKgoAjlR/GZW3luKGrDyJBkrV3jDo9VCnKeN3aZqKJty5weZD6HLrBwiMs7
 IrQhUPILSfJiSJfJkOVh4PiEh2qkVHrLC3laEbOu0eskffd2b4QTxR98+NFg+VZgu6kX
 Zm+xjbB+NJecHvintxTRguE204OO1OZpqes7YDNXPP6FeGZ/rAD7SAWjSs4zDqgErGzN
 +SJQ==
X-Gm-Message-State: APuU4Z/eKXk1cUuT2mSchT0b8zd+Lh96S//KuAenUHH4SVJINrkkx8r8
 SyIOi7H0SHIzDsC7wsbopbX8Ft1QJwZvWalwm8HUMmqa/FIl6hMM4XxluA5gRQJ2SqZTl+47rDs
 64rony6dVrAXPJRrLgcpY07d1mwpJaxn7on3s/EQAhRpJxZo9LThhACTAkaGi9Hvao0DJhwBFln
 sWrPsb7Q==
X-Gm-Gg: AYBFou0gDXuA0Fb1MSaqPU+LMl8yQ9lw2P+3YNZHS6Y/mLEyM0cLlzJfpOBEPXDUyR8
 ese8E57ft1O5Nsk8wIil7fgdax/8JilHqX4kEqTFOEzHQcRel1Zav/znofrfiChOVTSCQvgJbDm
 xR0JGtMnLYvs2svCIKOYejH5aKp826/zH+zHQRw3WuGGn9ctz3x8svI5AqeBpTptUZMiWYdmb5L
 N8I8LMRg5H4qyMjEWfGKplAZ6kF6M7ddG+f6fqPEUpZO0bIfeUz/IBUJTAcsWhEGm3dsqEmZgDu
 sDX4J2mApTKo1eNKGNKZAT19dlhsvYp4u3X89vEn3sZheHVv0Tya11osRyUrZSR7LHwng5C4h4T
 k9nP87iqiK6idmwBrTqePaoalcSuXioMulb3/UoSGXhqm11RwUbFkoZAsY4jSgwhjzpvA1E7aGL
 qW3DLqeCc4RQKG1UAFzZDWtXzTx0eqsGV+WXqprD9UKZ3YPbWwjz5xqRqzMkLM5BXnyfGntoeKF
 /UPGTG+XokWq++zUCXU0cukw+tsCTHd9NBv3polwv1LrRidDE47riX0xWKYiflqzM5evYe+Ay9T
 Wx1uIHoiekmjh51FrWO4EEX6OOflU6rzB74E2neODWyp0Bi9Qe34XyhOAT8Cqg0A1lwL+6H0uhc
 sDFrUb/YnHvzqdwnzpoCDVDO02raK68r4ANMUAtkIpXuim7wooZexEfyzpMBIpxuEyC5VzKMK9n
 A6EtqHKGc3ULG9oA==
X-Received: by 2002:a05:600c:5249:b0:4a7:7f3f:6f8e with SMTP id
 5b1f17b1804b1-4ac1228b5bfmr346690835e9.0.1793776594214; 
 Tue, 03 Nov 2026 23:16:34 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b2ab010a66sm161467435e9.13.2026.11.03.23.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 23:16:33 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 4 Nov 2026 07:16:33 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
X-Gerrit-Change-Number: 2118
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2118?usp=email>
X-Gerrit-Commit: c15ec8f549542ccdcee1f4eae0afd5076c77bb24
References: <gerrit.1793776591000.I04c128a934e9a2e767394dbe82427df2ee886178@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzNzc2NTkxMDAwLkkwNGMxMjhhOTM0ZTlhMmU3NjczOTRkYmU4MjQyN2RmMmVlODg2MTc4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <f8e5ca63189127fc7247499a3f63dee1f1a4ac61-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOVEe-000000005pq-49Oy
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify: drop
 dead retval in verify_user_pass_management()
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
Content-Type: multipart/mixed; boundary="===============6393152210510019106=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6393152210510019106==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="q4eKFVoza38="; charset=UTF-8

--q4eKFVoza38=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2118?usp=3Demail

to review the following change=2E
=


Change subject: ssl_verify: drop dead retval in verify_user_pass_manageme=
nt()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

ssl_ver=
ify: drop dead retval in verify_user_pass_management()

The function has no=
 failure path since a4eeef17 ("Add function for
common env setting of verif=
y user/pass calls") moved the username
check out of it=2E Return KMDA_SUCCE=
SS directly=2E

Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
Signed=
-off-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/ssl_veri=
fy=2Ec
1 file changed, 1 insertion(+), 4 deletions(-)



  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/2118/1

diff --git a/sr=
c/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verify=2Ec
index 0cdec1e=2E=2E24=
23c30 100644
--- a/src/openvpn/ssl_verify=2Ec
+++ b/src/openvpn/ssl_verify=
=2Ec
@@ -1532,7 +1532,6 @@
 static int
 verify_user_pass_management(struct =
tls_session *session, const struct user_pass *up)
 {
-    int retval =3D KM=
DA_ERROR;
     const struct key_state *ks =3D &session->key[KS_PRIMARY]; /*=
 primary key */
 
     /* set username/password in private env space */
@@ =
-1546,9 +1545,7 @@
 
     setenv_del(session->opt->es, "password");
 
-    =
retval =3D KMDA_SUCCESS;
-
-    return retval;
+    return KMDA_SUCCESS;
 }=

 #endif /* ifdef ENABLE_MANAGEMENT */
 

-- 
To view, visit https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail
To unsubscribe, or for help w=
riting mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dem=
ail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: m=
aster
Gerrit-Change-Id: I04c128a934e9a2e767394dbe82427df2ee886178
Gerrit-Ch=
ange-Number: 2118
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <ra=
zvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Ger=
rit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--q4eKFVoza38=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">ssl_verify: drop dead retval in verify_user_pass_manage=
ment()<br><br>The function has no failure path since a4eeef17 (&quot;Add fu=
nction for<br>common env setting of verify user/pass calls&quot;) moved the=
 username<br>check out of it=2E Return KMDA_SUCCESS directly=2E<br><br>Chan=
ge-Id: I04c128a934e9a2e767394dbe82427df2ee886178<br>Signed-off-by: Razvan C=
ojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/ssl_verify=2E=
c<br>1 file changed, 1 insertion(+), 4 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/18/211=
8/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/ssl_verify=2Ec b/src/openvpn/ssl_verif=
y=2Ec</span><br><span>index 0cdec1e=2E=2E2423c30 100644</span><br><span>---=
 a/src/openvpn/ssl_verify=2Ec</span><br><span>+++ b/src/openvpn/ssl_verify=
=2Ec</span><br><span>@@ -1532,7 +1532,6 @@</span><br><span> static int</spa=
n><br><span> verify_user_pass_management(struct tls_session *session, const=
 struct user_pass *up)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int retval =3D KMDA_ERROR;</span><br><span>     con=
st struct key_state *ks =3D &amp;session-&gt;key[KS_PRIMARY]; /* primary ke=
y */</span><br><span> </span><br><span>     /* set username/password in pri=
vate env space */</span><br><span>@@ -1546,9 +1545,7 @@</span><br><span> </=
span><br><span>     setenv_del(session-&gt;opt-&gt;es, &quot;password&quot;=
);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   retval =3D KMDA_SUCCESS;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return retv=
al;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return KMDA_=
SUCCESS;</span><br><span> }</span><br><span> #endif /* ifdef ENABLE_MANAGEM=
ENT */</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/2118?usp=3Demail">change 2118</a>=2E To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"=
http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemty=
pe=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https:=
//gerrit=2Eopenvpn=2Enet/c/openvpn/+/2118?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Ge=
rrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: I04c128a934e9a2e767394dbe=
82427df2ee886178 </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2118 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwab=
e &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--q4eKFVoza38=--


--===============6393152210510019106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6393152210510019106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6393152210510019106==--

