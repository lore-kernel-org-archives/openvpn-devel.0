Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4402D606A32A
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ogy79/RS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=g4Y5dr6O;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=WsyfK6el;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Z11yzdAy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=plF5G5MNP15MvGoLaFBn0GxhvBfY8F5xb78+botDyWI=; b=Ogy79/RSVs9vesvlg9ARQ7RUqd
	5kKk/asSYCJ3+wPJ7efQrijh2jwabOZMg5q7AU6xizXy5tlAymvAvK9aP7wawMUWin+XEBb9Hcoi/
	8M6kUwY2sPZNSQeDoiS5KwfHKU5Ete4Adeit8B2AKG9ehGLnKI6SiCoIu3N25xyT03y8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTNKz-000000006lM-489I;
	Tue, 17 Nov 2026 17:51:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTNKw-000000006kY-38NG
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iralFpwKRl+ub6srZbKj13OGyw+jEHnohof0pNCtlXo=; b=g4Y5dr6ONj3ah8UDEchuhjOm6j
 ZM2b/U3TSoqWgKaVnCFiFLgwntZk6oEAJCdX1y2oK6LsQMgnnFlfiIOtHLnS7v0vJjT5lphlZPk2I
 3x/GOEIQnbh3WttT4Gw4H8SMSgrITwcSpj4zx6rvaKXJTXLO34KX/hqLMRX4smgNK/XM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iralFpwKRl+ub6srZbKj13OGyw+jEHnohof0pNCtlXo=; b=WsyfK6elquULdsZ5AtPyjGfOnD
 lAObtZ5hJmPSnsbMRoXe0i6k4H0K5S8HoV0WjBmtDM+4ZGjqnjvdSZuEh6toR+ayDCwLNsQ1Si1Ex
 Bv/8/Z7EHdT4o8ELbPVMljwne/yfIEj8wb+WDm0b1k6HZ2H22uAXS54kwOOky0K+xCqQ=;
Received: from mail-wm1-f53.google.com ([209.85.128.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTNKk-000000000Xh-1CcJ for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 17:51:07 +0000
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so1224965e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794937860; x=1795542660; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iralFpwKRl+ub6srZbKj13OGyw+jEHnohof0pNCtlXo=;
 b=Z11yzdAyMdAOXO5p4FyVjvdqhQGv7298ivxDtGLju85qeUv6MqR6RHV3rhWVORlIo5
 SB6xHVK20vMOTSCkTfbR24BmI09+7hMWI1z/WWmZQuMLP3YxTFJP5vID5clADEhu5N5n
 muxiKZ+eYHb5PjZ7A5BYovtvTfz/LifKLN3hBDHYcgtoCDssWZtRPwQIQ1a/vQH8O1zq
 ebEPHT0fKNafd88OzF1gLZ9O9HObO6aCC1uA3Z9hI5ACapyqSjVefX5rzGmZj+rO4/R2
 NBRLY+fBbgnuEW/E+sVL3RQx8Hh8r3iX2ZazthbvOwGMG+A8LfzLHEhWGNthzgTAvZYb
 eP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794937860; x=1795542660;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iralFpwKRl+ub6srZbKj13OGyw+jEHnohof0pNCtlXo=;
 b=TXrQhh0oGM8WrxwOIJoJaNzKJe5FZvSMTCc0jfHhGpgN/4dyjsIRtw6VoDiIyt7H83
 IN9hGTtU0hCygiKR6YHWgnzKBkCf77mj4UKIlxytvdgDItHDpbNtlN0UEvucScokOaDM
 +S0di3uhGH/U+ti5dZeDvmsx6CFfB0h26SAC5yfgcASmC4vzZQoVj779CPpJLI0Ul+E1
 6CafUBuEWNgQhmLkaMWDlL/JYMEavX1eIDYCnRJ5grN6nF28BZhV5kajqGvotaOZ/gR4
 zbp/sGu1mDz9M0oowxOrckWcHl036+8ifBFoKg73mjP9WbgtlXmeRgSdBJqCcmV6fIsS
 iMUA==
X-Forwarded-Encrypted: i=1;
 AL+hErHozlX2knkhTr4skaqVwNdFk/1nqoN4RkFzEpraCdvkOZXvnPHJBpSyvdtlSIeZp5MOq+wotfFNzPjoJUyr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/CAE+NSyVtRs/RgqBG4N6rkoCk1fe0ahFKONNkIYl4HMUkQJmS
 9M8lDYai0PXEJViR6+sRs9ROX0r3PXqyBI0ad0vS5LZHGsD6ALaUWJxbwUodhS8Apx/Q2mdOOZx
 C7W6hdiOHqCQjpiY7hjowcB7vKzPwL0li0H2xHlKW+Mfj1Cuqm9NbE8r75mznciaIebO5
X-Gm-Gg: AYBFou0zJKYBSqp/nCFePovR4ptiI+1Aubq6AkNWGKnm0M5EbMjSNA8dvV7V+2YTY0D
 wW6d6qF28XVOn/d7+zNzgB7ZjH/7YKBv1j6cSM4Bw4hLHIyzzmogXvl7n47T3jPgnP6mCX2/LiL
 CIKka95tlrtDA00Yz0706Ixx6+OSgbMzhOsfgnf7hyuwBFqh5qGOo2lk1T4UT3w/aNTyIdx1mkX
 D6tY0oUcPlpXPPc07IA2PtisbMkR+B4cF1moG9dHLQSnbPaME4G2E8Zzsc3Ye7qZ26vXIXWgvyH
 nzvIiUyAHVGIu05zZhl1legLDpTqoH8FeOl7IGwaGfCi2coDWbIan78Br3kMrTv0wmsEUuHb3j6
 P2SsjvKuDdafz8MytcfHm6rC4ya15iTP7qhzVSKpZ2dlqx/vUMZhGS9gcCPDkFl2ykNXnOCsse6
 pEnjSuKg081NbOvxwvtMofBbH5lxrpZD/MNny9BWA8NhSrt20SWxYa/Y8gb78D1JSaLacTq7S/C
 YN/CrNedDf+w2cRjTmQAp+fzbFpNH4tJADfUxIlnRGlS/K4rwJnGcQznmAVvZAWts4BaTY78/Q/
 Nq15BfpaiTG0PbBRM2vc1NjHW0iDmqIrnG35+ZkJpiCH13sK921CAWLArxxhH0kuD0hYBbfhj1d
 6I3NzVJFwmsF2CalEmJyFWrBnmnmz7vnQgLmaKaEGs65jC3DfvjMVAX3E2aa2YvjJ5vn4tMM/BJ
 N7YZTF3Spr6sRulDI=
X-Received: by 2002:a05:600d:3:b0:4a1:ddaa:571e with SMTP id
 5b1f17b1804b1-4bb55a50eacmr256018165e9.15.1794937859499; 
 Tue, 17 Nov 2026 09:50:59 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb784231basm82421215e9.11.2026.11.17.09.50.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 09:50:59 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 17:50:58 +0000
To: =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef
X-Gerrit-Change-Number: 2202
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2202?usp=email>
X-Gerrit-Commit: 18483720191ddd0420de73ca7454296977a28808
In-Reply-To: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
References: <gerrit.1794853507000.I388a52d19633d0604a1610fbfba31cfff7f518ef@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk0ODUzNTA3MDAwLkkzODhhNTJkMTk2MzNkMDYwNGExNjEwZmJmYmEzMWNmZmY3ZjUxOGVmQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <038a2a909e1955f7dae2ce3a5c0ad9ad42257cba-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTNKk-000000000Xh-1CcJ
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: mudp: drop unused
 addr parameter of do_pre_decrypt_check()
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
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6073896708001358431=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6073896708001358431==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mZlhd1lR/UE="; charset=UTF-8

--mZlhd1lR/UE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2202?usp=3Demail )

Change subject: mudp: drop unused addr para=
meter of do_pre_decrypt_check()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

mudp: drop unused addr parameter of do_pre_decrypt_chec=
k()

It was passed by value on every connection attempt and never read=2E

=
Change-Id: I388a52d19633d0604a1610fbfba31cfff7f518ef
Signed-off-by: Razvan =
Cojocaru <razvanc@mailbox=2Eorg>
Acked-by: Arne Schwabe <arne-openvpn@rfc25=
49=2Eorg>
Acked-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202
Message-Id: <2026111712340=
2=2E12520-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg41526=2Ehtml
Signed-off-by: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn/mudp=2Ec
1 file change=
d, 2 insertions(+), 2 deletions(-)




diff --git a/src/openvpn/mudp=2Ec b/=
src/openvpn/mudp=2Ec
index 217b299=2E=2E0e1e21d 100644
--- a/src/openvpn/mu=
dp=2Ec
+++ b/src/openvpn/mudp=2Ec
@@ -113,7 +113,7 @@
 /** Returns a verdic=
t if this packet should create a new session */
 static enum pre_decrypt_ve=
rdict
 do_pre_decrypt_check(struct multi_context *m, struct tls_pre_decrypt=
_state *state,
-                     struct mroute_addr addr, struct link_s=
ocket *sock)
+                     struct link_socket *sock)
 {
     ASSERT=
(m->top=2Ec2=2Etls_auth_standalone);
 
@@ -259,7 +259,7 @@
     struct tls_=
pre_decrypt_state state =3D { 0 };
     struct multi_instance *mi =3D NULL;=

 
-    enum pre_decrypt_verdict verdict =3D do_pre_decrypt_check(m, &state=
, *real, sock);
+    enum pre_decrypt_verdict verdict =3D do_pre_decrypt_ch=
eck(m, &state, sock);
 
     if (verdict !=3D PRE_DECRYPT_NO_ACTION)
     {=


-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3D=
email
To unsubscribe, or for help writing mail filters, visit https://gerri=
t=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-P=
roject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I388a52d19633d0604a=
1610fbfba31cfff7f518ef
Gerrit-Change-Number: 2202
Gerrit-PatchSet: 3
Gerrit=
-Owner: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Arne =
Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esour=
ceforge=2Enet>

--mZlhd1lR/UE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2202?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">mudp: drop unused addr parameter o=
f do_pre_decrypt_check()<br><br>It was passed by value on every connection =
attempt and never read=2E<br><br>Change-Id: I388a52d19633d0604a1610fbfba31c=
fff7f518ef<br>Signed-off-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<=
br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Acked-by: F=
rank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Gerrit URL: https://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/2202<br>Message-Id: &lt;20261117123402=2E12=
520-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg41526=2Ehtml<br>Signed-off-by: G=
ert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/mudp=2E=
c<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</span><br><span>index 2=
17b299=2E=2E0e1e21d 100644</span><br><span>--- a/src/openvpn/mudp=2Ec</span=
><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span>@@ -113,7 +113,7 @@</=
span><br><span> /** Returns a verdict if this packet should create a new se=
ssion */</span><br><span> static enum pre_decrypt_verdict</span><br><span> =
do_pre_decrypt_check(struct multi_context *m, struct tls_pre_decrypt_state =
*state,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
       struct mroute_addr addr, struct link_socket *sock)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     struct link_sock=
et *sock)</span><br><span> {</span><br><span>     ASSERT(m-&gt;top=2Ec2=2Et=
ls_auth_standalone);</span><br><span> </span><br><span>@@ -259,7 +259,7 @@<=
/span><br><span>     struct tls_pre_decrypt_state state =3D { 0 };</span><b=
r><span>     struct multi_instance *mi =3D NULL;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    enum pre_decrypt_verdict v=
erdict =3D do_pre_decrypt_check(m, &amp;state, *real, sock);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    enum pre_decrypt_verdict verdi=
ct =3D do_pre_decrypt_check(m, &amp;state, sock);</span><br><span> </span><=
br><span>     if (verdict !=3D PRE_DECRYPT_NO_ACTION)</span><br><span>     =
{</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/2202?usp=3Demail">change 2202</a>=2E To unsubscribe, or for =
help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/=
settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://=
schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/2202?usp=3Demail"/><meta itemprop=3D"name" co=
ntent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Me=
ssageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I388a52d19633d0604a1610fbfba31cfff7=
f518ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2202 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne=
-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Revie=
wer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D=
"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourcefo=
rge=2Enet&gt; </div>

</body></html>
--mZlhd1lR/UE=--


--===============6073896708001358431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6073896708001358431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6073896708001358431==--

