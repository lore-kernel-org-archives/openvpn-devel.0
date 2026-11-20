Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8138606A33E
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Dcey+MVV;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=d7ldK2nI;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=E9jp3Yj9;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=L9M+zvV5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=58hry6xHr1sKYnGAlkFr09UDajV/p3lmh/Mrk/TtSu4=; b=Dcey+MVVcA0QKFyuIgCWZFKl7b
	6wZKK9u6qC2/V1CWVbUmrWZvlFjJVr7nEElL+s2W4aeHwvaMbx/3uUef+ZiYukjUZwiuTjqqkx5KT
	w9cq39DZxGPUhRv4C+oEGnHkV7i6MvO3UPLNt8m39lCCK5HL+2ucHguQ7cbUdbHs5SBk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUVZG-000000002cV-0YAa;
	Fri, 20 Nov 2026 20:50:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUVZF-000000002cO-0qWL
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 20:50:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oSkvOPf+lscLKx7FPrRd4z0dsDMq1oLbG/cvUlLl2kg=; b=d7ldK2nIeiDx+iG51ko7obSG50
 wQoywF6gjVz1Ezko4SpSwVmgiAqIDvpLGu9R2sdji7ua0M4xCxN6/WxFdLJmNpUwPqS2zob6rTEzl
 9EMt+p+jHd++X/v+O9P4ZTWvA56GUkWctaLJKirOnnKSQcXfdFs4jz+EgTyDiH+5sAu0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oSkvOPf+lscLKx7FPrRd4z0dsDMq1oLbG/cvUlLl2kg=; b=E9jp3Yj9B8XHxl9f5wASbnkTh4
 01y/hGWm5kViDVVSlxqQPEj8qyAOIxVzApO/2oEXFrxY1tQiwmQ+dQHxUQsm8Ub+yrBnAD6ymb/va
 YY+1t66pst5kru31XpaGjIQAi2cQgCuPrHBYZ4qLNx1dnrJwHzc90IVqr8exvXwX6ivs=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUVZD-000000003dg-3Jrl for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 20:50:45 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4a3e706b5dfso938727f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 12:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795207837; x=1795812637; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oSkvOPf+lscLKx7FPrRd4z0dsDMq1oLbG/cvUlLl2kg=;
 b=L9M+zvV5LV9pg+F0ayj6eOR6wkLsPbQo93fIPznbOzVmfBs2Fpsr6Up3Q+ZR153vVZ
 T48NuVQF8xWUPQ3/iI0C2J/Up9rneGtVsKk+VcvqdQom+jGYoR7qxX6TWpDiQvD2Phje
 3bPkF65X4UYjycs67ifvD8FWuOuU2WFoOoBaAwAAbHwJstAlXwyAGOzcKLqlJvd0NpEj
 u4CeD65TW+hLOiBytCyTFiY3MZ/gJGVr0nsnJCL3R/jlBz9WFJLU5dzxH6kHNmHmYg7/
 LanXbnfaVL5gldKGKEW4+BtUd5enRZj08A+mlbFgZzgxU0DjiIorpyiHGwQbvwWrRzRO
 Ci2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795207837; x=1795812637;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oSkvOPf+lscLKx7FPrRd4z0dsDMq1oLbG/cvUlLl2kg=;
 b=XiEZCUVh/40eaK8F/AkYDN9AYfR1/REHt0X5BLlggQNOvpU39AvD9O07PrzUjnye7c
 VwBLxsWsyhluq8urN3dkBITKsxRFa6zaX7xVvH4ZVAMoKu0yk7+QsbnhVowLu/YJVtZz
 gMhxBIV45i3P47i3mW9V329O+6ITAcVTPQ0EXflWYjA1Oq+axTnaI55OoAPyiLEZ7wuM
 acin9w70ivqvidhPjcOJVskdblD40gS1PovAbpo88Fxrgza6wkDtSCliQl03bNRwO8M8
 5Z8kKvo7RtAk54xVyBCmkQVqaRAORgL9XzFnllmReXyBK9C7XUIkvvERpeaeiZH/CtaN
 fquA==
X-Gm-Message-State: APuU4Z+DDS8pS4eSr+Sb9gq5YfyKl5IT8tHbAVI9PG7RgI6Fn3DDPaxM
 l8UImTP/xGJxbRu3ptt/PSLj5ydgDHj9PflJ3W32ReoHrZGmyYuWgd3phtekop3YNLlzdQ8Skpw
 Gh1wARUXaUESj1DFO3nQ5L9x2TQSJG1fTSTRIgKxMFNwZYwTEUiiZwGNXOeF/1kLsoaP6
X-Gm-Gg: AZFdTZdPkGIq29YB9XM98eisN4NLZ4W9VN/YQbswnc6D5YKI1mzQKeKfkbrrZ3EnbVl
 /KQIkB9dDA7vxKe6chu6604zfzOc6mu9nHvGI+15GWiBZi34lm+bq7M/yKmegIG1LTfBTagBPKP
 cFMGu87+Lr0IhHug/opEMimmZrZqELQ6ubfGYOm51yX5ytwmuZyPDJxBRYEN8tVNJjuG2sMcUPT
 W/6yMD8/emwe9lJscOvgBOUtiBYDZqGQibVkn0p5hblIE1/fTu952dMZOv7H6c3qlKisbZBwFxm
 zgLBVMR2YkxJQlaQBcSN19BiCQjGVLL4c7QMaKNAtykY3ARV8UhQN2HS+B1X3TQYJEG0yhP6WYo
 t/bIz1S3bfstcvIUkYlEOWZw7zXfmsXwVcHG143KxqtWX/csDdqBLW//qlTbbV5PaJYxobthFC/
 SpJwRyZFWXD0YvuAazaA4B66EI3G1v2HjxuE9fT/bAcgwvSDc8G13r8Z07578mvjYyfLDXI4FrT
 ZajE8s1+Gh0jNsXIHV1CvcAG7f5OQ8cfMquIfwDn7j23FTo/jeXNB6wdRTNGAX0OSHwHYL01Dyz
 R0o5yrmrtiKWpjhNHsUf6LIssGcEJqmUG5BYpQDNqVrNHyl82xUi3xXPGhYcvJaJAwYI0RQG5Cl
 VL33X3fBgTQkhkP5fooMZH1o93g0BmWgAqDj30IQuUyt/KBRekV0y/QIus8VM9xyTYAdgNzUh1U
 qwXWwb+yBIOEFzR3o=
X-Received: by 2002:a05:6000:184a:b0:48d:fd4d:7fbe with SMTP id
 ffacd0b85a97d-4abad6a42f2mr8640792f8f.2.1795207836907; 
 Fri, 20 Nov 2026 12:50:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf630esm7701269f8f.16.2026.11.20.12.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 12:50:36 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 20:50:36 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I1249834b1899461bc8f01e848bea95e30decf60c
X-Gerrit-Change-Number: 2236
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2236?usp=email>
X-Gerrit-Commit: fe68bc4c2db29c9b98dbebafe6e1b1c7bc9c28bc
References: <gerrit.1795207834000.I1249834b1899461bc8f01e848bea95e30decf60c@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MjA3ODM0MDAwLkkxMjQ5ODM0YjE4OTk0NjFiYzhmMDFlODQ4YmVhOTVlMzBkZWNmNjBjQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <128092d0817a7863aa00819e78c5ea6c0d1e921a-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUVZD-000000003dg-3Jrl
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: openvpnserv: zero
 name server bufs with ZeroMemory
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@ist.eigentlich.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8063778295008677551=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8063778295008677551==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sCbrvouBnng="; charset=UTF-8

--sCbrvouBnng=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2236?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: zero name server bufs with ZeroMemory
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: zero n=
ame server bufs with ZeroMemory

The buffers in GetItfDnsServersV4/V6() are=
 NUL terminated at their
start and their end at the start of the functions=
=2E For better
readability use ZeroMemory() here=2E

Change-Id: I1249834b18=
99461bc8f01e848bea95e30decf60c
Signed-off-by: Heiko Hund <heiko@ist=2Eeigen=
tlich=2Enet>
---
M src/openvpnserv/interactive=2Ec
1 file changed, 2 insert=
ions(+), 4 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/36/2236/1

diff --git a/src/openvpnserv/interactive=2Ec =
b/src/openvpnserv/interactive=2Ec
index 7ea88a1=2E=2E6c290ef 100644
--- a/s=
rc/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/interactive=2Ec
@@ -21=
77,8 +2177,7 @@
 static LSTATUS
 GetItfDnsServersV4(HKEY itf_key, PSTR addr=
s, PDWORD size)
 {
-    addrs[0] =3D '\0';
-    addrs[*size - 1] =3D '\0';
=
+    ZeroMemory(addrs, *size);
 
     LSTATUS err;
     DWORD s =3D *size;
=
@@ -2224,8 +2223,7 @@
 static LSTATUS
 GetItfDnsServersV6(HKEY itf_key, PST=
R addrs, PDWORD size)
 {
-    addrs[0] =3D '\0';
-    addrs[*size - 1] =3D =
'\0';
+    ZeroMemory(addrs, *size);
 
     LSTATUS err;
     DWORD s =3D *=
size;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1249834b18=
99461bc8f01e848bea95e30decf60c
Gerrit-Change-Number: 2236
Gerrit-PatchSet: =
1
Gerrit-Owner: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-open=
vpn@rfc2549=2Eorg>

--sCbrvouBnng=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: zero name server bufs with ZeroMemory<br><br>The buf=
fers in GetItfDnsServersV4/V6() are NUL terminated at their<br>start and th=
eir end at the start of the functions=2E For better<br>readability use Zero=
Memory() here=2E<br><br>Change-Id: I1249834b1899461bc8f01e848bea95e30decf60=
c<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<=
br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 2 insertions(+), 4 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2En=
et:29418/openvpn refs/changes/36/2236/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnser=
v/interactive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 7=
ea88a1=2E=2E6c290ef 100644</span><br><span>--- a/src/openvpnserv/interactiv=
e=2Ec</span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span=
>@@ -2177,8 +2177,7 @@</span><br><span> static LSTATUS</span><br><span> Get=
ItfDnsServersV4(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    addrs[0] =3D &#39;\=
0&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    addrs[*siz=
e - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ZeroMemory(addrs, *size);</span><br><span> </span><br><span>     L=
STATUS err;</span><br><span>     DWORD s =3D *size;</span><br><span>@@ -222=
4,8 +2223,7 @@</span><br><span> static LSTATUS</span><br><span> GetItfDnsSe=
rversV6(HKEY itf_key, PSTR addrs, PDWORD size)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    addrs[0] =3D &#39;\0&#39;;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    addrs[*size - 1] =
=3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ZeroMemory(addrs, *size);</span><br><span> </span><br><span>     LSTATUS =
err;</span><br><span>     DWORD s =3D *size;</span><br></pre><p>To view, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2236?usp=3Demail"=
>change 2236</a>=2E To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</=
a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><=
link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/22=
36?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I1249834b1899461bc8f01e848bea95e30decf60c </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2236 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heik=
o Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--sCbrvouBnng=--


--===============8063778295008677551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8063778295008677551==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8063778295008677551==--

