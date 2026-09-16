Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57676C982C1
	for <openvpn-devel@archiver.kernel.org>; Wed, 16 Sep 2026 20:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=3ZfxSb7ShrgdJOgld1d4wrZL8tm6m2TVxekaVOQFOag=; b=P83DbeLY+9wwwK
	3GSuZrva9P5T7o30Y1Zmrhkz32cpxPy+UIpzelKvzloPu8POxH9fOYKM5OsNsTHx96+P+Ka5giRlk
	eW9KPAYWhxDFK1Moqd+e9E3tNDt2YDUV+H8MsZefg5ydzFsnDYcCJp5+1S67Fx/C83mOAfVioE+Jw
	wlk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x6wDT-0000cZ-Tt;
	Wed, 16 Sep 2026 20:26:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x6wDS-0000cS-Or
 for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:26:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:Date:From
 :Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TTtjWacPRN95uGK8Xt9IhAucI5DiftP12mzIYFz5jFk=; b=immI5ZlCPH//mAhTEfBCm4J6jO
 sKz+wULju9gAJjXbpNlHMkb3SWybqcBJoWASgntx3PvhOVtquTjkqEkP1LjOkHh3TykrxzcSbx6/r
 Ie3nvNd85RQV7nkSbkBdoSxPtxZj33KznUb0+PSXkEzUyHTJUMngk6FoiiicWUDZZKhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:Date:From:Sender:To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=TTtjWacPRN95uGK8Xt9IhAucI5DiftP12mzIYFz5jFk=; b=d
 2VH93N+z5aDxSEuVVdw+4AcaXLiNhxJ3Q8U5IL2VrGpj5VdTzgEkT5tU+vtUAA1Z0cgtbMbu7vtlo
 G80bvwH8jYu1lDowo6y8BkcWb7h3MlBD4IxD7HXcuLeXjDW6/Zp7ij78jJ+CiWcIATMxfgKrWgT0p
 d3PSX6/yiAexYZFc=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x6wDR-0007pq-Sd for openvpn-devel@lists.sourceforge.net;
 Wed, 16 Sep 2026 20:26:50 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b5so873675e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 16 Sep 2026 13:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1789590403; x=1790195203; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TTtjWacPRN95uGK8Xt9IhAucI5DiftP12mzIYFz5jFk=;
 b=VwTsHL/HZcdtwIVIO0IJqiW5psAkcU1LFqqzBaAvFosNDz7+27eUYfF7cyuBHIBDRr
 wIU9U9Fxu4mQHa92WcHEnsCaLJ2Aw4u81s8jmRZPE9gxP+aTw/Qn5q5K4bK/ZlHiri2O
 A8jZfDaXSPwLWiVccad/0SR50CZaATo4ATRR7o1Yzuj9zx4YqE443qZW5DzYQba/jnx2
 LgT3LfQjpJSs077XyGP3nNwS5wk1HynnljNcfoRGshuWaJip6eSTVmBvfLZp9TA/prmD
 ONouh6/OraBuaAjaQHqXV/JzYS1DrlCsXJeBPqnCos/ksAVu3ApXeA6uFoqetF2MgVh6
 3uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789590403; x=1790195203;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TTtjWacPRN95uGK8Xt9IhAucI5DiftP12mzIYFz5jFk=;
 b=Sp6odCEUdnNKgB0R36RSidz4bbjLr7yyTVIU+C24oG8XcMnYKOasYx9Tt3h2Dm9K6j
 3n6671gulCleFFnP0e+C56rXLzXlGPrFG9qMUrt4ZAiOMNFlwH8LbjfNqi8P7U8LcXqN
 9HRyItG8j5e9B19eBFd6zAmI8/ZUbrrAEo3pxYpxEw1nOT9ic5fespxWfVBdTyZP5UvW
 eja1Zi/LGs8QPZXmrgz3vxRmscuqJ7Tf+oY3TY/5OkC7/02zMMmskq+4pprr0xhSbPUI
 43i0Bps50aiig0aTfXT1Aw2sUugov0kKxgBu+BIGs4jRceg0Lak/ikpbtv5DiibjiqWS
 nXfg==
X-Gm-Message-State: AFuF++lgi+aqc0wTw7Qrs3gyiJo5AWZ1mlRh4m0VgRrXddLujXYepbgE
 eA1JR07RelSF7NaUgzEbOzANf0OBcPP6UiBK8/0E0F4uos2RgkHuuv6r/MqKCodGKHpEBBsrScV
 KRaWRpU4k+oNmDR17v8lCAJ/MadiN1ke/i/nj36MnHzt30HyKlofLJSiYk5Hncinj7myNRtwPR6
 e6LVEu2w==
X-Gm-Gg: AYBFou2x4AAoQ3PKEydFUzEptWUKEh838YvJeLNzktYwB5ad7BukO9Mxwj/AYwreRHz
 rmb0RBMXT8aztBjskltQXrfFHIbjd5p656gZG28zKxl2OtaUBZ9BAx/V0UIdoaDHI8Zh655DQq6
 u+DSR6SqnuVlIudwmFb9ooC0xQb1Vomlex2x0Uci5D5ALD2erqh2uJQC+KMuSJkj/qWo614JDr0
 lU+5PHkDcxcfa/V5zIVpMdh5I2DOoD7Pp5yQMoogcvD+mZl8ZjGZG9/FXoN4mamKZ/BwgAeToL4
 zRWQC+6Rj+MDh6VO+OUV6aCVPJ0MX9YE/KS5+C9FuHq/Jh62FszXed6GqcPHZuI66hKPRz9NgQh
 rTgbqgHm1dfRE3yBQERnIYB2zNM/qXKrRO8svd8ixdgn9zozPW2AJ8sAi1ezPWJgtI1P+Hpdq95
 UnoOKU/IQ7FmhZ8yNcMQK7rSJLRiuOr4/jvanNH19l9KcN6VYoHNdcD56uxdg98GxmN2I1D3dlZ
 WSExVMLi40AwqJYN9uw0x6oensyhIwEVPkIiohi+2h1hYkOnWZ7jFKOPd2IVnbqSl1lGdm4HQxK
 UGHt2HUGDtZ6jx2XfHopHYnOe7XoZG+1+QQdJL8bmuv3s24Q7ArEePM5IiUMoA==
X-Received: by 2002:a05:600c:46ce:b0:49c:dca4:94c with SMTP id
 5b1f17b1804b1-49eb7339895mr92647355e9.13.1789590402228; 
 Wed, 16 Sep 2026 13:26:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd22dddbsm16341265e9.11.2026.09.16.13.26.41
 for <openvpn-devel@lists.sourceforge.net>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 13:26:41 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 16 Sep 2026 20:26:41 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
X-Gerrit-Change-Number: 1919
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1919?usp=email>
X-Gerrit-Commit: b3a00b7062b771c60dfb37f94f2da087c53385e2
References: <gerrit.1789590400000.I6217c0541bff81eefa63a987db8904b2feda2546@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg5NTkwNDAwMDAwLkk2MjE3YzA1NDFiZmY4MWVlZmE2M2E5ODdkYjg5MDRiMmZlZGEyNTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <80d1676b7525698d0b6a700dae13f8fa4d50d9ab-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1x6wDR-0007pq-Sd
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document notify as
 auth pending method
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, openvpn-devel@lists.sourceforge.net
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2865424575695026422=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2865424575695026422==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TgfevEKw0b8="; charset=UTF-8

--TgfevEKw0b8=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review=2E ( http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1919?usp=3Demail )


Change subject: Document notify as =
auth pending method
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E

Document notify as auth pending method

This allows a server to sig=
nal a pending authentication that does
not require any action from the user=
 or client but can still take
a while to completely and enter the auth pend=
ing state=2E

Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546
Signed-o=
ff-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M doc/management-notes=2Etxt
1=
 file changed, 27 insertions(+), 0 deletions(-)



  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/19/1919/1

diff --git a/doc/man=
agement-notes=2Etxt b/doc/management-notes=2Etxt
index 1126468=2E=2E6cec49e=
 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@=
@ -794,6 +794,33 @@
 The client should return the response to the crtext ch=
allenge
 using the cr-response command=2E
 
+notify
+=3D=3D=3D=3D=3D=3D
+Th=
is is notification that there is some out-of-band authentication is
+happen=
 that is outside the control of the client=2E This might just a
+server sid=
e check that takes longer or another out-of-band authentication
+like requi=
ring to have to authorise the connection on a mobile phone app=2E
+
+    NO=
TIFY:<flags>:<notify_message>
+
+For the user this is
+
+<flags>: a series =
of optional, comma-separated flags=2E So far no flags have
+been defined ye=
t=2E
+
+<notify_message>: The message to show the user to inform them about=
 the
+ongoing authentication
+
+An example message for a message for a serv=
er that does some checks against
+well known list of blacklists could be
+
=
+    NOTIFY::Please wait while your IP is checked against multiple online a=
buse databases=2E
+
+to inform the user that there is a delay in the connec=
tion attempt=2E
+
+Since the notify pending auth is not requiring any actio=
n on the client side,
+this message is not negotiated but can just be sent =
as a gratuitous message=2E
+
 COMMAND -- client-deny  (OpenVPN 2=2E1 or hig=
her)
 -----------------------------------------------
 

-- 
To view, visit=
 http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Ger=
rit-Branch: master
Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2=
546
Gerrit-Change-Number: 1919
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--TgfevEKw0b8=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>=2E</p><p><a href=3D"http://ge=
rrit=2Eopenvpn=2Enet/c/openvpn/+/1919?usp=3Demail">View Change</a></p><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Document notify as auth pending method<br><br>This allows a server=
 to signal a pending authentication that does<br>not require any action fro=
m the user or client but can still take<br>a while to completely and enter =
the auth pending state=2E<br><br>Change-Id: I6217c0541bff81eefa63a987db8904=
b2feda2546<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---=
<br>M doc/management-notes=2Etxt<br>1 file changed, 27 insertions(+), 0 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:=
29418/openvpn refs/changes/19/1919/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/management-no=
tes=2Etxt b/doc/management-notes=2Etxt</span><br><span>index 1126468=2E=2E6=
cec49e 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><s=
pan>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -794,6 +794,33 @@</=
span><br><span> The client should return the response to the crtext challen=
ge</span><br><span> using the cr-response command=2E</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+notify</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+This is notification that there is som=
e out-of-band authentication is</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+happen that is outside the control of the client=2E This might =
just a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+server side c=
heck that takes longer or another out-of-band authentication</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+like requiring to have to authoris=
e the connection on a mobile phone app=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    NOTIFY:&lt;flags&gt;:&lt;notify_message&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+For the user this is</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+&lt;fl=
ags&gt;: a series of optional, comma-separated flags=2E So far no flags hav=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+been defined yet=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+&lt;notify_message&gt;: The message=
 to show the user to inform them about the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ongoing authentication</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+An example message for a message for a server that does some checks =
against</span><br><span style=3D"color: hsl(120, 100%, 40%);">+well known l=
ist of blacklists could be</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NOTIFY::=
Please wait while your IP is checked against multiple online abuse database=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+to inform the user that there is a=
 delay in the connection attempt=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Sin=
ce the notify pending auth is not requiring any action on the client side,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+this message is not =
negotiated but can just be sent as a gratuitous message=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- client-=
deny  (OpenVPN 2=2E1 or higher)</span><br><span> --------------------------=
---------------------</span><br><span> </span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1919?u=
sp=3Demail">change 1919</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1919?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I6217c0541bff81eefa63a987db8904b2feda2546 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1919 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--TgfevEKw0b8=--


--===============2865424575695026422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2865424575695026422==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2865424575695026422==--

