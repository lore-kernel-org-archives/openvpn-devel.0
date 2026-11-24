Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FB3606A327
	for <openvpn-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=DPPCTkz6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=VoJ2+U4b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G8lUIVyX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=SKby8th3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:Date:Sender:To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=iyXmbLDeeZ+O/8yTFtIFbXKuGh7x9XOUjJeNVZ4U3LI=; b=DPPCTkz6yt/+K7ZwjAwsGVFZx+
	lRUyc99xA2CRPD236U1PuSRD1hzn0opTOG0vuTqJlgBxT9gSDQXTRySUp1kpkQcuUCRoV7wbVN+13
	EjZAeCL8ioFXS5zaISDiLFDELRhmc/Q1Rrw9tgh/FRHfu+u8R8Yh2Wsqiv0MWsN/Ifjg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xVrSV-000000004c4-1O0S;
	Tue, 24 Nov 2026 14:25:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xVrST-000000004bx-2XEU
 for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:25:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:Date:From:Sender:To:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fv+AWrCz7r32+GPIbXb7OPjDknfvIupjOb/6uT5+LsA=; b=VoJ2+U4bJ86j1ur5AlB1XIVB7F
 TuBqRiSMfpCoZTpZc2ZJUxh0QQBosQm5JtQB+nX/h0QussWmTrIe8dDa9RgsYnYhCkKl0+wpHTueF
 5t5WP+DaGKYp/mF5tnrkZsQ3SJr4J5AyDAsNf9zoDRXXvIOSnk2Df++48IPRy2PEu5vk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:Date:From:Sender:
 To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fv+AWrCz7r32+GPIbXb7OPjDknfvIupjOb/6uT5+LsA=; b=G8lUIVyXBXucmPR4tbpi2orw5f
 36sMWJ8ToOmnZNrzxxV1hL0uqrmdsJ0eZAoqgynjTPgr9+b3GyVXxL57Fy2dtEkN7t+u2t9YdqjAQ
 zd9lI7AJ4bX74HE1dDnNQuZ5TQg24OvDQuBpc7+1olYQ1qc0R/DHe33kLFDzCl0Yj330=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xVrSS-000000003g1-14mH for openvpn-devel@lists.sourceforge.net;
 Tue, 24 Nov 2026 14:25:21 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so3244165f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 24 Nov 2026 06:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795530314; x=1796135114; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=fv+AWrCz7r32+GPIbXb7OPjDknfvIupjOb/6uT5+LsA=;
 b=SKby8th3ZH4qLKpRNot9uKBkf+5nu0vfkGRbI/b18JP56TPF45bCYC2Q3cNPyKzIjP
 OwNwOTMT0M5oUdFrx3VUocd8FPVC+Fw2+uHY2goV18YDWxBEdpPv/rDsP6nm3Y86OmxV
 iYSeM7um1SIPDhq6Ta4TNJG7MT8fVi1/gZmC1m8R3LLSDPyk9Tctwf1Smi1q/TaN3uTj
 iFSfKpMWNi747l/+lkytz2iIvU+j2f+xJUFurXY92QpUqfG/D+8nyRvyrypbXmIxT5ka
 vS4UpQ7zXi5EF+nJkxERioPwJmf9xVFk0oFtl6ZGoK0tElkFcE7t1wTSoGfDgvJrMM0f
 VAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795530314; x=1796135114;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:date:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fv+AWrCz7r32+GPIbXb7OPjDknfvIupjOb/6uT5+LsA=;
 b=cryRaqUOh1XfDlqpUXN3C+lq3ZMZ+d6bhFpQD/m8qKZ0N3ecb8JP8LOG573MSbPULK
 RSsgW442/nZeGTkdx1nT9xN7/xT5fL9xisafsjEo313QJoPVOS28xmFUDA+jYuLDNOkU
 /v7sGLlaHa2xl+coBSKfli0Gxy5AEtJN57JrsDtvUH+KLcf+7cTXTdge6iBpxygRYX6d
 QhcwUEYWSKNBqnOkVdbO/5Gc8FYkyV9QX4FXDejgXRtBrOufMS4AdYHvkraaoRFlFIvV
 mhg4tFvsZOU+qBWacgBP4lTCZAUBglQT04mqiKBYT23DQet4LhaB39s+esohoHF/ISFY
 JtZg==
X-Forwarded-Encrypted: i=1;
 AL+hErGcsj81X7i3+p1SvkFK6tV0b2mUCx1Ze7IZIY8C9nl4viJtyWS/sob5bSKd6gFllaVqnqsxvuFyKHnE2m+G@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9SEPoQEQZV7Km9J7GOZWqsj1IeTwD9jJM+ukD0qcamux9Vd/JW
 mrD1jgmlL2aKt7z5y7GjhNfhWiShBp0wOx7dBaMIV560PpsD2wtPVTOMVPtM0pLAI5k2xju4ApA
 cbVCx/LqCsLF/adJMlaoYycwnpoqzSMvOjCd2E2/OEQSmjNizAayh4DUSnaEDo30l5QVqvJKqGM
 oefNMuwg==
X-Gm-Gg: AZFdTZeYwV/415JIPYsu3EyjATRBJ8gbw/OoEtMHvQ/AlKdUem0g357tC+XhFE6k8rg
 /W4PFYp6JIemqEs5GI2dgac5N+Zyaj4ntSm22ZJVgO8z48axbJOAlw7m6Fc5EKX1yXZBylDlb20
 J0k7ucD6FrHK2PwTAU80FA+6NnDB6EsfZy2NlI06KqownYMsPlM5te9PH0Hori0kigUDreZQVKx
 u3DY3h4mIlO+gE2DJN//UGjl8nzFyYLEjnBY79dnQtyC/JSgycgD10UOBJHv6p7Rr7eCrcayn5X
 Po4jjKN+CrWK3mOtiIiMuQSskc8n7fANPtnNrvw5HkO5kTfrh6S4qFQFY03MMr9oF+uULyOli3w
 SejqD/O09NwH3A9cPKfW8eqEKAoe16M3lSwb3IuBXaxyLSh18X7xZEPTN74PHc0hO87mgOrzvLq
 hzkE8APGgggH/lNJrkYcUhx8yewEqnRieWIMcefR/Bo1X9SeUx+04qxlngQAv+2208ys+X3lsIQ
 qszOk2A7srQJ/P86rMS6uAbljsttZpXhBZq2nt3AieZ0z5/hNfjbBUYmqgCj09PXMjm8Ylb6YQJ
 kNzYRb7Z2YlCKNLzZ3FzxaAWtvk85zYbSPEMuy5tFZcnsDp5jdsQzxLq82t6SUErRxAcDXJt0Ok
 tDAKhOYKSLSg+WQ55WwCS7xZ/QOLbLI1n/LCpg3kmDkPihbtJMlW3/3iXaRuhWQj8pk8oLl6LiO
 o9j4ZAKv8ajUVcpINRc6MNY5VwhG1W5xVvUvZv
X-Received: by 2002:a05:6000:184b:b0:4a7:9630:7b36 with SMTP id
 ffacd0b85a97d-4abb3f15ddbmr31015311f8f.21.1795530313537; 
 Tue, 24 Nov 2026 06:25:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6bb98b4dsm29088471f8f.53.2026.11.24.06.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 06:25:13 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 24 Nov 2026 14:25:12 +0000
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I4571033af79092d85657b176044497245faf5e39
X-Gerrit-Change-Number: 2219
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2219?usp=email>
X-Gerrit-Commit: d159055ede16e322548e46d154523e2fc31ccf74
In-Reply-To: <gerrit.1795023922000.I4571033af79092d85657b176044497245faf5e39@gerrit.openvpn.net>
References: <gerrit.1795023922000.I4571033af79092d85657b176044497245faf5e39@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MDIzOTIyMDAwLkk0NTcxMDMzYWY3OTA5MmQ4NTY1N2IxNzYwNDQ0OTcyNDVmYWY1ZTM5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <bdc6d0399834d50e76dad4f83eec8a9e9d9cd380-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 2.0 (++)
X-Headers-End: 1xVrSS-000000003g1-14mH
Subject: [Openvpn-devel] [S] Change in openvpn[master]: options: let the
 interactive service add routes again
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, heiko@ist.eigentlich.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7693107638009592847=="
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MISSING_HEADERS,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7693107638009592847==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iABOTR4tviE="; charset=UTF-8

--iABOTR4tviE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2219?usp=3Demail )

Change subject: options: let the interactiv=
e service add routes again
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E

options: let the interactive service add routes again

Since =
c139e82d the service puts --msg-channel in front of the user
options, a --r=
oute-method from the config overrides the service
route method implicitly s=
et by --msg-channel, and adding routes
in turn fails without admin rights=
=2E

Force the service route method in postprocessing when --msg-channel is=

used, independent of the option order=2E

Github: OpenVPN/openvpn#1151
Cha=
nge-Id: I4571033af79092d85657b176044497245faf5e39
Signed-off-by: Heiko Hund=
 <heiko@ist=2Eeigentlich=2Enet>
Acked-by: Razvan Cojocaru <razvanc@mailbox=
=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219
Message=
-Id: <20261118181613=2E2865-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Em=
ail-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41648=2Ehtml
S=
igned-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M doc/man-sections=
/windows-options=2Erst
M src/openvpn/options=2Ec
2 files changed, 12 insert=
ions(+), 0 deletions(-)




diff --git a/doc/man-sections/windows-options=
=2Erst b/doc/man-sections/windows-options=2Erst
index 8d7dcbb=2E=2E87c7008 =
100644
--- a/doc/man-sections/windows-options=2Erst
+++ b/doc/man-sections/=
windows-options=2Erst
@@ -179,6 +179,10 @@
   :code:`exe`
         Call the=
 route=2Eexe shell command=2E
 
+  When OpenVPN is started by the interacti=
ve service, the service adds
+  the routes and a ``--route-method`` given i=
n the configuration is
+  ignored=2E
+
 --service args
   Should be used wh=
en OpenVPN is being automatically executed by another
   program in such a =
context that no interaction with the user via display
diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec
index 2068393=2E=2E1a8604e 100644=

--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -2494,6 +24=
94,14 @@
         options->ifconfig_noexec =3D false;
     }
 
+    /* the =
service adds the routes, --route-method must not override it */
+    if (op=
tions->msg_channel && options->route_method !=3D ROUTE_METHOD_SERVICE)
+   =
 {
+        msg(M_WARN, "WARNING: ignoring --route-method, routes are added=
 by the interactive service");
+        options->route_method =3D ROUTE_MET=
HOD_SERVICE;
+    }
+
+    /* this depends on options->route_method, which =
is set above */
     remap_redirect_gateway_flags(options);
 
     /*

-- 
=
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit https://gerrit=2Eop=
envpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4571033af79092d85657b176=
044497245faf5e39
Gerrit-Change-Number: 2219
Gerrit-PatchSet: 2
Gerrit-Owner=
: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@=
mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>

--iABOTR4tviE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2219?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">options: let the interactive servi=
ce add routes again<br><br>Since c139e82d the service puts --msg-channel in=
 front of the user<br>options, a --route-method from the config overrides t=
he service<br>route method implicitly set by --msg-channel, and adding rout=
es<br>in turn fails without admin rights=2E<br><br>Force the service route =
method in postprocessing when --msg-channel is<br>used, independent of the =
option order=2E<br><br>Github: OpenVPN/openvpn#1151<br>Change-Id: I4571033a=
f79092d85657b176044497245faf5e39<br>Signed-off-by: Heiko Hund &lt;heiko@ist=
=2Eeigentlich=2Enet&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2E=
org&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219<br>M=
essage-Id: &lt;20261118181613=2E2865-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: =
https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/ms=
g41648=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt=
;<br>---<br>M doc/man-sections/windows-options=2Erst<br>M src/openvpn/optio=
ns=2Ec<br>2 files changed, 12 insertions(+), 0 deletions(-)<br><br></pre>
<=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/doc/man-sections/windows-options=2Erst b/doc/man-sections/wi=
ndows-options=2Erst</span><br><span>index 8d7dcbb=2E=2E87c7008 100644</span=
><br><span>--- a/doc/man-sections/windows-options=2Erst</span><br><span>+++=
 b/doc/man-sections/windows-options=2Erst</span><br><span>@@ -179,6 +179,10=
 @@</span><br><span>   :code:`exe`</span><br><span>         Call the route=
=2Eexe shell command=2E</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  When OpenVPN is started by the interactive service,=
 the service adds</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
the routes and a ``--route-method`` given in the configuration is</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  ignored=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --service args</sp=
an><br><span>   Should be used when OpenVPN is being automatically executed=
 by another</span><br><span>   program in such a context that no interactio=
n with the user via display</span><br><span>diff --git a/src/openvpn/option=
s=2Ec b/src/openvpn/options=2Ec</span><br><span>index 2068393=2E=2E1a8604e =
100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/=
src/openvpn/options=2Ec</span><br><span>@@ -2494,6 +2494,14 @@</span><br><s=
pan>         options-&gt;ifconfig_noexec =3D false;</span><br><span>     }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* the service adds the routes, --route-method must not override it */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (options-&gt;ms=
g_channel &amp;&amp; options-&gt;route_method !=3D ROUTE_METHOD_SERVICE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WARNING: i=
gnoring --route-method, routes are added by the interactive service&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt=
;route_method =3D ROUTE_METHOD_SERVICE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* this d=
epends on options-&gt;route_method, which is set above */</span><br><span> =
    remap_redirect_gateway_flags(options);</span><br><span> </span><br><spa=
n>     /*</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2219?usp=3Demail">change 2219</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2219?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Projec=
t: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>=

<div style=3D"display:none"> Gerrit-Change-Id: I4571033af79092d85657b17604=
4497245faf5e39 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 22=
19 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=
=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Ene=
t&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt=
;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Eso=
urceforge=2Enet&gt; </div>

</body></html>
--iABOTR4tviE=--


--===============7693107638009592847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7693107638009592847==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7693107638009592847==--

