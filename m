Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19900606A331
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ThyPKR4k;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DiosPQFL;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YwJSti2B;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Mfg0RWe2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=Ul39oIjUDQPsj/rGjb3abDex9q33tGwj5HiIKVTKZWM=; b=ThyPKR4kEvyx7Tfs9WyezX/xXR
	vYxRDAul5A6tpK1JruTqIn+ALlD5e1/MlXcrm/imaDaSmQNXgDUO5vGRioFo/FlaHntanSfaXb2K7
	dSemrjS+T1h+6m5uJYAb+UoFifeo9KBrh1C+gyb/2dCQ7VJJlhJm/TnbHmeBm16/27Hw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQjOw-000000004G9-1E2u;
	Tue, 10 Nov 2026 10:48:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQjOv-000000004G3-2fqM
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 10:48:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AFxwCKNn+VK5ukqR17RO+X6ktuCox7vXuJManpD3+UI=; b=DiosPQFL0yLSMJLv5MKXFGgKK6
 JDQdBh0S5z1AvltYUtiYT0yWVc3fd0ccx3tGCO5KrijGI3NT61P82L8h35frsGgW7UJ/ZNP3Xfopu
 XtN6bXD545KxDTUtJ3AudF7sXq3cOXr3jxR56qX4qN8FkprKQs5wiyfQnpiCIrMLxZq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AFxwCKNn+VK5ukqR17RO+X6ktuCox7vXuJManpD3+UI=; b=YwJSti2BQX/1d0Vp6NYH1kn29W
 +Bw3zKETLPLtoBzeyIpoOT/D6HAorXPFvrmJcSCbr58qODZbJwvYMhiayLjAG1ObiVTRzW58fqKev
 BCtiZ2tiJOWZNLFxhO4UsELjlFGxttitJFZ4ossgkkNPtCb7FMffx/PO/M9uEdU/uf1E=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQjOt-000000003ZD-3ZcY for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 10:48:29 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a215e64962so21200385e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 02:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794307701; x=1794912501; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AFxwCKNn+VK5ukqR17RO+X6ktuCox7vXuJManpD3+UI=;
 b=Mfg0RWe2sEWyMroHLcdunpdveGRb6B5FbStI4KchMlx3RRdHYU5Q//V80N0hewW2+Z
 d9UTnKndyCeHqA5GCXY5nh4ntbkzTWCdAv9yMStVm1UALZO+qFtoEtGV40/kRY4mNb4U
 +EA2GL3eGzqKY7ZyhxDmIM1uEqqnpAYheKzwSHsg28GDIy88c9qEygA+gWHldi7PK2TH
 y/i2ZthVYiQfhcNMIBKUwl+T/oB9f/q7/U6VZRnnT1+laUT8mDIV3HB+vEHwNtKAsOYG
 DsU7M1M9Dn5LaqnKYlnGbPwbSZuEwuYWZfo04gLz6GBe/B1ckNFLvuTY9wDf8hB2Jpzl
 TCoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794307701; x=1794912501;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AFxwCKNn+VK5ukqR17RO+X6ktuCox7vXuJManpD3+UI=;
 b=C4+fNPLEBelbUoO/RRNRXNVWEYamC0Pa1msNZnCoXXBLEF+1MbI/Jrzbw3/HO7QCSS
 0XJNy/JB61j//IFW2ba6dIau6oP36xbgcvy9/9tyXO5vbpDSsipeNAis+zXOGpz8EICX
 F5BnFuwSceMLzWu0gfDoT1/TghveWpAndDWNf6BMclcSbBdJc7QhbawOp/fwzVCbM3o3
 5gr1XTmkqKbjpN97og3MTvKILtjs8TWNXDxaUgCbaOIcffnR3MoDuaMT9MxdTvQ1nQrS
 1cr2erXbsGJIUclZwRjWSMv0FCDZWo/cfkc/u38Y3Y3ydATx5sbW4dsdrvWu1Vu2p5JT
 POsA==
X-Gm-Message-State: APuU4Z/4o7uAKvOuF8mUCbrNxA2GwYzY39UeaADZU9dOaGtjlAeF/0CU
 AJ5TPnM2x2P4FhhTd/IkHUQwDiGQDXZzrqCVCEFafWVoY0GCHZ/XdG3c725qVdfC3Ajzc/RO3m2
 OrUG2bPqhwSW9YfTJTc6hjYh9qypz8mPkp++WSQ6lY1OgIZKoboYDxJ2c/ZQVXQSq1BaOkhT2kG
 R0/AG49w==
X-Gm-Gg: AYBFou3QT/dWcJztN2267ZhLQBGGMzxI1ZzGaiDcjA6F1vBOC8ZQPpt4TN1HztXg0EQ
 Pd2VPjLNsOaxn0efet7WQFokKI/S6fhyYDiXENG8Q9Dq0JJx0CFfkklFyZkTrij2p6pVn2aemKG
 N7uUq5gbtyStgVMR7/0XQTr4cr4BJx7eq8MdH8XcIGn2srYmkeIXb2cnbyI9h3hNSRkr1rfFwki
 1lmbOBSi+HPc32O0ZVVqsoEq7JaJyNZmfV0AGtmiABgOGV6nGSfofiFEQPuW0rWURAXM+uWyd7p
 bIVgu305tGNRcZzk/bqfAJi5AqSJ6CgkuATpPTXU4Sh+1hVMmbN36EtZgtBn9O7bGRvyJDRP1qY
 0Nor5pqHV7l35kw9RXsfmGnH8ZD3xFb2WuR0kWizieYKlpxdHknjt5a4zUdUHZo7BMEqJcFPP5t
 Gk5xwNx6DP5jE01ZCEZ8NqH4XhndYIBUPoROPdqwWHlokI1sKvre0tYma6dxQ/EB+4Wyz0TAsmG
 YXikKE8+6WUTTtyip8HiPR3Sp0tZhOAE5lpkJfPjP3Zsv5zxYQzmuuE6vniDpKToRKGHmZTrq+i
 GZiQGeCfEwHhsfxNY11v0zxL8DMekpjYKYjz0BLuR5NX/78VJyV/+3aqpfMhJDDB52CI8KmzeBY
 yGMI71jJP/M13MMDDxhbXBp5lEv650YOiH0eNF9RFvFwQaMZJAjZpvTqlVBo+1cXbYWkZ5575cS
 Vzgz992yhJBJgzmWw=
X-Received: by 2002:a05:600c:4e0d:b0:4b1:2026:6b41 with SMTP id
 5b1f17b1804b1-4ba023505d3mr38123165e9.30.1794307701087; 
 Tue, 10 Nov 2026 02:48:21 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba01feee1asm71820135e9.12.2026.11.10.02.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 02:48:20 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 10:48:20 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
X-Gerrit-Change-Number: 2163
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2163?usp=email>
X-Gerrit-Commit: 0f6899deddd6d9cf92cd27ed4feaa20ba7745a81
References: <gerrit.1794307698000.I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzA3Njk4MDAwLkk1YzUyY2M1YzNhYWFkMjFkMWMyMmYzNmY2NDUxMjM1MzAyZWE2YzRmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6665b117997037bfdb73f0bb5d4f399e0f9d1243-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQjOt-000000003ZD-3ZcY
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: sitnl: put the IPv6
 member first in inet_address_t
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
Content-Type: multipart/mixed; boundary="===============3912151068461248899=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3912151068461248899==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ltavrejRCkg="; charset=UTF-8

--ltavrejRCkg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2163?usp=3Demail

to review the following change=2E
=


Change subject: sitnl: put the IPv6 member first in inet_address_t
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

sitnl: put the IPv6=
 member first in inet_address_t

The inet_address_t locals are initialized =
with "=3D { 0 }", which only
initializes the first union member, the 4 byte=
 ipv4=2E GCC 15 and later
no longer clear the rest of the union for this, s=
o the IPv6 addresses
of these locals keep up to 12 bytes of stack garbage w=
hen the caller
passes no address=2E

net_route_v6_del() then sends a garbag=
e RTA_GATEWAY for routes without
a gateway, and the kernel refuses to delet=
e them=2E net_route_v6_best_gw()
looks up a garbage destination when asked =
for the default route=2E

With ipv6 first, "=3D { 0 }" clears the whole uni=
on=2E

Latent since c6542257 ("introduce sitnl: Simplified Interface To
Net=
Link")=2E

Change-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
Signed-off-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/networking_si=
tnl=2Ec
1 file changed, 6 insertions(+), 1 deletion(-)



  git pull ssh://=
gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2163/1

diff --git a/s=
rc/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index 97=
ff7bd=2E=2E157b784 100644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/=
openvpn/networking_sitnl=2Ec
@@ -84,13 +84,18 @@
 /**
  * Generic address d=
ata structure used to pass addresses and prefixes as
  * argument to AF fam=
ily agnostic functions
+ *
+ * ipv6 comes first, so that "=3D { 0 }" clears=
 the whole union; it only
+ * initializes the first member=2E
  */
 typedef=
 union
 {
-    in_addr_t ipv4;
     struct in6_addr ipv6;
+    in_addr_t ip=
v4;
 } inet_address_t;
 
+static_assert(sizeof(inet_address_t) =3D=3D sizeo=
f(struct in6_addr), "ipv6 must be the largest member");
+
 /**
  * Link sta=
te request message
  */

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2163?usp=3Demail
To unsubscribe, or for help writing mail filte=
rs, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Messa=
geType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I5c52cc5c3aaad21d1c22f36f6451235302ea6c4f
Gerrit-Change-Number: 2163=

Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eo=
rg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: o=
penvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>

--ltavrejRCkg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">sitnl: put the IPv6 member first in inet_address_t<br><=
br>The inet_address_t locals are initialized with &quot;=3D { 0 }&quot;, wh=
ich only<br>initializes the first union member, the 4 byte ipv4=2E GCC 15 a=
nd later<br>no longer clear the rest of the union for this, so the IPv6 add=
resses<br>of these locals keep up to 12 bytes of stack garbage when the cal=
ler<br>passes no address=2E<br><br>net_route_v6_del() then sends a garbage =
RTA_GATEWAY for routes without<br>a gateway, and the kernel refuses to dele=
te them=2E net_route_v6_best_gw()<br>looks up a garbage destination when as=
ked for the default route=2E<br><br>With ipv6 first, &quot;=3D { 0 }&quot; =
clears the whole union=2E<br><br>Latent since c6542257 (&quot;introduce sit=
nl: Simplified Interface To<br>NetLink&quot;)=2E<br><br>Change-Id: I5c52cc5=
c3aaad21d1c22f36f6451235302ea6c4f<br>Signed-off-by: Razvan Cojocaru &lt;raz=
vanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/networking_sitnl=2Ec<br>1 fi=
le changed, 6 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/63/2163/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_s=
itnl=2Ec</span><br><span>index 97ff7bd=2E=2E157b784 100644</span><br><span>=
--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/ne=
tworking_sitnl=2Ec</span><br><span>@@ -84,13 +84,18 @@</span><br><span> /**=
</span><br><span>  * Generic address data structure used to pass addresses =
and prefixes as</span><br><span>  * argument to AF family agnostic function=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * ipv6 comes first, so that &quot;=
=3D { 0 }&quot; clears the whole union; it only</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * initializes the first member=2E</span><br><s=
pan>  */</span><br><span> typedef union</span><br><span> {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    in_addr_t ipv4;</span><br><span>  =
   struct in6_addr ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    in_addr_t ipv4;</span><br><span> } inet_address_t;</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+static_assert(siz=
eof(inet_address_t) =3D=3D sizeof(struct in6_addr), &quot;ipv6 must be the =
largest member&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /**</span><br><span>  * Link state request message</sp=
an><br><span>  */</span><br></pre><p>To view, visit <a href=3D"https://gerr=
it=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail">change 2163</a>=2E To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope it=
emtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2163?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display=
:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> G=
errit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: m=
aster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5c52cc5c3aaad2=
1d1c22f36f6451235302ea6c4f </div>
<div style=3D"display:none"> Gerrit-Chang=
e-Number: 2163 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div=
>
<div style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razva=
nc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: A=
rne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwabe &l=
t;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ltavrejRCkg=--


--===============3912151068461248899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3912151068461248899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3912151068461248899==--

