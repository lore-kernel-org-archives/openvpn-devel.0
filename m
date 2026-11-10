Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C1D606A31C
	for <openvpn-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Q6Uf+8OJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RaRJSSCf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W1Qbppnq;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=cMqAewtX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=rbC67nuARsdFi7QbW00lIsJQGNU70XYBiF5ItCFPnl0=; b=Q6Uf+8OJTeOpxhI1OsCcjNcCLt
	DzuWTLdRDi7ONXRzYUnYWsYYKm7/ucuU0svNjcmilUE0xjREd97yugvCyTbYyXRptEdpLt4r3P9wE
	JUwt2Xnd/tvEuhAKBBjW+yuovIREmqn+yKZKAtvYfk2KVQKkzA023R1uMQ7ygwdNncjc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQheq-000000005Cb-2JAQ;
	Tue, 10 Nov 2026 08:56:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQhep-000000005CV-1DIm
 for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 08:56:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qayxhy2GcSt0f3yU9mNN0a8SiGmAtW2VpLwOfggOyHU=; b=RaRJSSCfuKlejGftBNGzdw+040
 +iEHUSl5SkR5daNOxeXcNTSxuak6WipA4KlpYJeqoz1txlHYjXV5lFODn4wVB7DJu8THEveqSUjpf
 HAwLJ08PJ8NkJO8zCEn1DQtJR5e+k8OMQzp5sbyKhe6P1S3TZwyIuDNBACGqZhmHfGH4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qayxhy2GcSt0f3yU9mNN0a8SiGmAtW2VpLwOfggOyHU=; b=W1QbppnqUyIyBCaCpWYCI/N/BO
 YevLyYuSw0SkNnsciNNOdmXUaXHN0haHGMf0EVGn5a9tRlhlYbB6FRXA9u60mXkwa8DthX47/455s
 9Rmkc6NpuUkbiubevn3R1dKtrRM0cunZam3WWQXlt97cHFVZng5HbFFN8aUHSqARiSWI=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQhen-000000008M6-3mra for openvpn-devel@lists.sourceforge.net;
 Tue, 10 Nov 2026 08:56:47 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2153c8525so13174335e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 10 Nov 2026 00:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794300999; x=1794905799; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Qayxhy2GcSt0f3yU9mNN0a8SiGmAtW2VpLwOfggOyHU=;
 b=cMqAewtX0kLd4nHt7KD/DZrDHGSzL1iwIOsYE053f0a1v1joz70UI6dseI2Vr8xq8r
 MwywfgK1t5aIL/eeRk6tuM/PhA6aFxJrapvzP90msPCgP7xSBUKhUlMTiNBW8emE9io2
 xxm/ikHcxdUZJY9lQb/rUQ+fX/TBah1QpZnEVppaf5OJLugC/1xLWZHgEcLp/97fRSTB
 xOOf5dVPYpHgbl2T2yRinYDJgK2ki4TJIjO2Ahz52VI5NfTn/sPSBSiyALn5nsfEsKNm
 BMWBnlt/weM3N/mkadfUT1z176/WfxP6m31QlwJtNAaLg/8yscfQvR/v09oAb804ChlP
 Y3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794300999; x=1794905799;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qayxhy2GcSt0f3yU9mNN0a8SiGmAtW2VpLwOfggOyHU=;
 b=j2bGe8qxOHkCGV8cH0uT7kIn2NVWHKlNqYsfl6eHF4UCRITzzntDvcInfJd8A5qyDU
 hvOaHnRWqEUFvvhZop3SudScpFK/J+bussAdrB1XwgBnj28xtDvpBkbBTFxMphUIft2J
 Ob8HLE0KK6c7LbQqYUf1JxrxWYBtTbdpmhHM+rSmrxZZdqcXR6yk4MnuvNT5qJ8/XmGw
 g0VxET9mMOJ+b2KV0yhJCeJW3y3JWvoulXeVK2zkP2nnIVJzMNG8yjrDkQf0/fjy5IAw
 JxPh+Jkr6AXXoSe3gOgp42v+VHowR2vScPT+2Ry7+KOyYnUcqwDCRZyaJ/lTj1M3JrE8
 B1Kg==
X-Gm-Message-State: APuU4Z/1cebMYnjRQR3XvPP3UcltNeHixM7rzw4FQRQrz+mamt98lHEi
 DbvmafKh1RGoR+ns4e+V+/QuWirforfIz9FxkI62JtmJ5pdyETPhQ9645bBM/r5/jMp4jY3rt9W
 gy4Zvfdqxn0nZfsVlbqOX0kl4hwNibG8wW1YlMyCF8P+el21xNU2ZWCCpcPKJ+Nwr+Lp4dJTASF
 AM01mDrg==
X-Gm-Gg: AYBFou3JH2QZfNH4zihk6Ha4CjdVncaGlrWLvg+9ATjo7Kz9spWSQq3wanTOK9XDH7q
 CPIwZ++3S4Eud8j97Ili2eGSTOw5J7YEpbWbr3tHA1SCTJxKrUh6pizwj3HnRPsefwPV4bcdvEp
 fT2HpcHwRonFqCl4JCFL5wrJGWer/hLtpFfgOBkfxcxs1fEReXaFgz45qEJvROZXaivpMS7RQKy
 K0KKqhrceHKx4jmypRZQpGjMKqGqGAMEfe5ZCQb8ZPCbUcgKDCFojDr5mMtYskbx7dEiucW0DKZ
 r6JXXKWUB0xesG+AJTe0cJH48LSbdiY4KlsMx6f9z4NdI1vHyBntjpt2Srec7WPYTwRla7qDS6d
 qDfm7FSQimslA+ktCppjBRLZnKLJLf9Wu1wSiOnt/paqX+K1gjBMIHZ4mehqmhYI9vIcZNB41w2
 ATXzBD++VWkgZ7W7WP5db1kFNJ7K4MadpAM50LgY6mjQMuzpqEwd768zLlURa0wFNJkUFQ6gHdM
 0RWlJ9+FzFyY1V8hS2QZyf0jI5/uE5v9K9wvc6LHFEFgX0JwfugPKn268+kfLrBj1wmHlBkxG7c
 lR57VcnWYmBy8jxynfPI+s7XRcNS74NfI6eDp+Ag00laHf0+nVB7tKzM2LpzMC2VG0xjx0CfwyS
 M6srStiYqjdiePF4LZ4J6zML43q5+5KwtVssYTNTepxZ6yrn8SSnWBbTzet3Q/2hOx19vQffKMn
 DbmYeoFnJuloqZT04=
X-Received: by 2002:a05:600c:3e88:b0:4a1:e6a9:4086 with SMTP id
 5b1f17b1804b1-4ba022c9b40mr29982325e9.0.1794300999192; 
 Tue, 10 Nov 2026 00:56:39 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ba02043149sm46695965e9.8.2026.11.10.00.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 00:56:38 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 10 Nov 2026 08:56:38 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
X-Gerrit-Change-Number: 2160
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2160?usp=email>
X-Gerrit-Commit: 54055b0dbb5834babd8a6f116c3602beb02dd10a
References: <gerrit.1794300996000.Idf378bb5af0b2b4e8d746e252159b756e96c37fb@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0MzAwOTk2MDAwLklkZjM3OGJiNWFmMGIyYjRlOGQ3NDZlMjUyMTU5Yjc1NmU5NmMzN2ZiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <775d2215a29eff1989f51941770b62701a1e7d72-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQhen-000000008M6-3mra
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: always
 free the domains in UndoDnsSearchDomains()
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
Content-Type: multipart/mixed; boundary="===============4625233672454534226=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4625233672454534226==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yfygkqiUelQ="; charset=UTF-8

--yfygkqiUelQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2160?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: always free the domains in UndoDnsSearchDoma=
ins()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpn=
serv: always free the domains in UndoDnsSearchDomains()

The domains string=
 was only freed when the search list key could be
opened=2E Free it uncondi=
tionally, as the caller frees the undo data
right after=2E

Broken since ae=
90cbad ("dns: support multiple domains without DHCP")=2E

Change-Id: Idf378=
bb5af0b2b4e8d746e252159b756e96c37fb
Signed-off-by: Razvan Cojocaru <razvanc=
@mailbox=2Eorg>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 3 ins=
ertions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/60/2160/1

diff --git a/src/openvpnserv/interactive=
=2Ec b/src/openvpnserv/interactive=2Ec
index 81205d6=2E=2E710a797 100644
--=
- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@=
@ -1754,10 +1754,10 @@
         RemoveDnsSearchDomains(dns_searchlist_key, =
undo_data->domains);
         RegCloseKey(dns_searchlist_key);
         App=
lyDnsSettings(gpol);
-
-        free(undo_data->domains);
-        undo_dat=
a->domains =3D NULL;
     }
+
+    free(undo_data->domains);
+    undo_data=
->domains =3D NULL;
 }
 
 /**

-- 
To view, visit https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2160?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerri=
t-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerr=
it-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb
Gerrit-Change-Numbe=
r: 2160
Gerrit-PatchSet: 1
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc@mail=
box=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerri=
t-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attent=
ion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--yfygkqiUelQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>R=C4=83zvan Cojocaru would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: always free the domains in UndoDnsSearchDo=
mains()<br><br>The domains string was only freed when the search list key c=
ould be<br>opened=2E Free it unconditionally, as the caller frees the undo =
data<br>right after=2E<br><br>Broken since ae90cbad (&quot;dns: support mul=
tiple domains without DHCP&quot;)=2E<br><br>Change-Id: Idf378bb5af0b2b4e8d7=
46e252159b756e96c37fb<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 3=
 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/60/2160/1</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec</sp=
an><br><span>index 81205d6=2E=2E710a797 100644</span><br><span>--- a/src/op=
envpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=
=2Ec</span><br><span>@@ -1754,10 +1754,10 @@</span><br><span>         Remov=
eDnsSearchDomains(dns_searchlist_key, undo_data-&gt;domains);</span><br><sp=
an>         RegCloseKey(dns_searchlist_key);</span><br><span>         Apply=
DnsSettings(gpol);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        free(undo_data-&=
gt;domains);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        u=
ndo_data-&gt;domains =3D NULL;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free(undo_data-&gt;domains);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    undo_data-&gt;domains =3D NULL;</span><br><=
span> }</span><br><span> </span><br><span> /**</span><br></pre><p>To view, =
visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2160?usp=3Demai=
l">change 2160</a>=2E To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings=
</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"=
><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
2160?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<d=
iv style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"dis=
play:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerri=
t-Change-Id: Idf378bb5af0b2b4e8d746e252159b756e96c37fb </div>
<div style=3D=
"display:none"> Gerrit-Change-Number: 2160 </div>
<div style=3D"display:non=
e"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: R=
=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-d=
evel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</bod=
y></html>
--yfygkqiUelQ=--


--===============4625233672454534226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4625233672454534226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4625233672454534226==--

