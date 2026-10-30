Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A49606A31C
	for <openvpn-devel@archiver.kernel.org>; Fri, 30 Oct 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=da3+Dh1q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=R17oKSED;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=M7ycWRkr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IXzcHnuL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=T0lEn/+vcBAcZ3VTLQz8aPLtKTwyS2UDdPa4581AKLg=; b=da3+Dh1qbLngRMTppqLnq01ysu
	4j3iPdluRDpsEJCAl5cmqvId7n2SZx1neKDrpH/7+1y7ouaoTWX0oqDA5C4cOyfWPDD3Y5SLKhh6z
	8l63GibUBxoEnqehI96PPcd5KCMa31oaxRg4g3Vw+NUwtOZSTOe+5a6eSnFksyC4zFAo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xMrTZ-000000006ul-2Twi;
	Fri, 30 Oct 2026 18:37:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xMrTX-000000006ud-46Gm
 for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:37:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g1cPuyJEJhAUHt/jSfa7AUtsEh33dm4ufys2tGwzYTw=; b=R17oKSED2SUcz9oDM1LVbRPgy6
 RxV/JYJZAZii7UaVFxH6yGk9zEOfTEoDuXR14FIZWPkTuKjhpzho2yizQcdzsoKt521ytk+wbTY4y
 s0aZnJuRxnmyKVYXq0EnJsooT1OVqMKp8KfBcf7CsXSbjthMtRcrDFgMIip+IAAY800U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g1cPuyJEJhAUHt/jSfa7AUtsEh33dm4ufys2tGwzYTw=; b=M7ycWRkrCvf1hrI2pjDxjTYOwB
 MBrH0tr2jYPql7cdFkQj4JVPxUasD7UtRyuAD7CO0vuNwXiy4Xz/KsB8ApD+EtQvG+P9mS7Wp6wsA
 5ykuAQHtJqLYDc7wu6lmg29ALFIFkxp/pJwxsL1K5Z38PJvPTdOet9Wglcz36ASbSzl8=;
Received: from mail-wm1-f50.google.com ([209.85.128.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMrTX-000000001G2-0CKw for openvpn-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 18:37:15 +0000
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4ac95761c85so6145925e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 30 Oct 2026 11:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793385428; x=1793990228; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g1cPuyJEJhAUHt/jSfa7AUtsEh33dm4ufys2tGwzYTw=;
 b=IXzcHnuLkCNgetYfRA4RYmRBW0Xa8Z2rTVPZCrzfLLFiAwiHrJCd3lDbyNm5A6lN9d
 E+N0hd+mGliXnuUB2nyCvi38UDLq3gIbLz7Q6dDxQnaD+SV+DWuZpx/ptwsSRc9ZmIlC
 zm37lWzI0p9If6dyA9uP/z79s/41XG4Z8sGvjlW5Sv+v0GvFkCl30QMsCdp15Am1JqbM
 ShmmD/S6/Tln51k52X1RSqL/w6tdCg0Bb6yvOPxe8m3vVh34A9f5tI0KZXIcvYdYdlbk
 WCn/c/oqWX2kc71BKa0wAuyt9aqI8dyjq1ocKCuVQgTf4QdKS5Tkkz0hKtK6Lo11sZLZ
 bdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793385428; x=1793990228;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=g1cPuyJEJhAUHt/jSfa7AUtsEh33dm4ufys2tGwzYTw=;
 b=0WjTwWeZy0opAdopMxM+rlYWJq2rYTlDlAfdkjd5Q0w+o3oVozlUqq95r3o9acMMxP
 g6Ziqc53N1Vth9OJw2hb6yzV/fORmqYvzTMfE4DqN80RuPJicliA060oQf1IDSTCEnGm
 JG9jWnx8myCG6scf0wZ+p3Y0aFzZ09d5LQD3Rimbf5tPbDM8JDn21hqTHe8X09cg/f/Q
 jL/O6H+of3uJzlypi2kTHBZIUQc3n+B6FM4wx/ETh9dU85ExioTdoiRSbtrZICv1gydn
 N4FRiwt7a+Mj/uWyCp1K3EShx01Nw3Y7mH2G/dKfLIQ/hXYP8zOOSOH1zuArsmFq8lf3
 USuQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+WrslIw9IyrUqku1QHpa8Ke4TZZiHceJin3XJ1SDfOYQh8U4tw/aM20YhHBf/8C0Tk8JtGQ62OEHWuDk7@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKQTq0XEbiCr63yeyNqJ6hCUtE7JNH9hUmUjQyEDEm6RLKuJxMm
 yX/d+THuW1fKgRWspeon+yZ0JVDGfB7eEa8T0mPZ5BDl2RZSHIOGw9GSw1208RPfrS/dWSk80i/
 7vFwfxxPPzdghzIjZOJ7o8rGcvvidWvwOjEQs5F1RwkYobGhoPNm98QWxo5gaij2Qeyfa
X-Gm-Gg: AYBFou2dre6GO2Kon0+fcOyf7RZX2/s9Lg2GxyLLPJNPKvnp27g4N8/wc/Nf6u7HYSM
 VrClJXai7GJxbVJaBOE9qii3aef7Sdo4w+qBPSd50Gv/Z66KRaD+hvrULJfS8y6yVesfdO7Nf7l
 q8WrLF4iO4ZPfWEGSak9mCbZyZrEie6FBS7quFDRTerZaUWGMqkhgF9PWQeWlJ/aCHQNiF7TukG
 7eFtEDcPT5ajPtP3hkAf9jL3z5ILKaw8u3wTZtSHTHyCzYF0vQ/tXr11c6cCsq+s8wCcwsgIZ+e
 Gn8gK0nj9umDPfV7kF0yE3n28bI8MSjbDCBCX+N7lpD/p8/l1zSY4PUo9hKaiK06+bue7GzIPIa
 2/5oyfkvpGBetnQDezNQX6bkzTjkf9IcKOl7aspf4k0/4JuPp1a/lvPH+ZPwKOjoEYuA642DHjF
 qF7+XKLr1Pdod+jBrZMca3x+2njfeu2lY22MvL367fSwc7NZYxn2BxN1VvXI3cX4VsAVKhdogcT
 O+yq/v6dxwNXLagROjcZ97TDnJgO4/lz3VJYvdQGlUEmdv4u+CR9auM5ajEYeXT8cSaC2Aw0x6D
 4mrRGs2TJOV3CCHNClOYI+79e1qJRwm6UG/9AO7l8EPvRfwn0qlw9W+rw3ldKxGkx8xGiyDoNTq
 qKtMJ135/rjhobSiSIiSCX2jHOrJIOUJ/BwzX6Q6VZK1TlZ56icDZxsz/hfocglmUKY/hw7uOwr
 4dO1UpvwJefyXbjHA=
X-Received: by 2002:a05:600c:b8a:b0:4ab:c447:49df with SMTP id
 5b1f17b1804b1-4ac182dca8emr72355565e9.23.1793385428388; 
 Fri, 30 Oct 2026 11:37:08 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71bae25dsm3978049f8f.59.2026.10.30.11.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 11:37:08 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 30 Oct 2026 18:37:07 +0000
To: Gianmarco De Gregori <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e
X-Gerrit-Change-Number: 2044
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2044?usp=email>
X-Gerrit-Commit: 2f76edfe75953313a1af503ae85c68409ec840e5
In-Reply-To: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
References: <gerrit.1793094393000.I1abb10515665e1d6351689d2c2dd9d4aba8bb98e@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMDk0MzkzMDAwLkkxYWJiMTA1MTU2NjVlMWQ2MzUxNjg5ZDJjMmRkOWQ0YWJhOGJiOThlQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <054a0880e66ca52cdcffc38178a30b415fe59e4c-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMrTX-000000001G2-0CKw
Subject: [Openvpn-devel] [S] Change in openvpn[master]: multi_io: drop the
 read cases from multi_io_wait_lite()
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============6851127458810782451=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6851127458810782451==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yl4CBaujxG0="; charset=UTF-8

--Yl4CBaujxG0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2044?usp=3Demail )

Change subject: multi_io: drop the read cas=
es from multi_io_wait_lite()
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

multi_io: drop the read cases from multi_io_wait_lite()

m=
ulti_io_action() only polls before writes: reads are dispatched with
poll f=
alse, both from the event loop and when chaining a tun read
after a write=
=2E The TA_TUN_READ and TA_SOCKET_READ cases of
multi_io_wait_lite() are ne=
ver reached=2E

Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e
Signed=
-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Razvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/2044
Message-Id: <20261027124408=2E526-1-gert@greenie=2Emuc=2E=
de>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=
=2Enet/msg40196=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede=
>
---
M src/openvpn/multi_io=2Ec
1 file changed, 0 insertions(+), 12 deleti=
ons(-)




diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec=

index ac730b4=2E=2E56216d4 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src=
/openvpn/multi_io=2Ec
@@ -235,18 +235,6 @@
 
     switch (action)
     {
- =
       case TA_TUN_READ:
-            looking_for =3D TUN_READ;
-          =
  tun_input_pending =3D NULL;
-            io_wait(c, IOW_READ_TUN);
-     =
       break;
-
-        case TA_SOCKET_READ:
-            looking_for =3D =
SOCKET_READ;
-            tun_input_pending =3D NULL;
-            io_wait(=
c, IOW_READ_LINK);
-            break;
-
         case TA_TUN_WRITE:
      =
       looking_for =3D TUN_WRITE;
             tun_input_pending =3D NULL;
=

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2044?usp=3De=
mail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Pr=
oject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1abb10515665e1d6351=
689d2c2dd9d4aba8bb98e
Gerrit-Change-Number: 2044
Gerrit-PatchSet: 2
Gerrit-=
Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: R=C4=83zvan Cojoca=
ru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2E=
sourceforge=2Enet>

--Yl4CBaujxG0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2044?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">multi_io: drop the read cases from=
 multi_io_wait_lite()<br><br>multi_io_action() only polls before writes: re=
ads are dispatched with<br>poll false, both from the event loop and when ch=
aining a tun read<br>after a write=2E The TA_TUN_READ and TA_SOCKET_READ ca=
ses of<br>multi_io_wait_lite() are never reached=2E<br><br>Change-Id: I1abb=
10515665e1d6351689d2c2dd9d4aba8bb98e<br>Signed-off-by: Gianmarco De Gregori=
 &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc=
@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/2044<br>Message-Id: &lt;20261027124408=2E526-1-gert@greenie=2Emuc=2Ede&gt=
;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforg=
e=2Enet/msg40196=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Em=
uc=2Ede&gt;<br>---<br>M src/openvpn/multi_io=2Ec<br>1 file changed, 0 inser=
tions(+), 12 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/multi_i=
o=2Ec b/src/openvpn/multi_io=2Ec</span><br><span>index ac730b4=2E=2E56216d4=
 100644</span><br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ =
b/src/openvpn/multi_io=2Ec</span><br><span>@@ -235,18 +235,6 @@</span><br><=
span> </span><br><span>     switch (action)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        case TA_TUN_READ:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            looking_for =
=3D TUN_READ;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    tun_input_pending =3D NULL;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            io_wait(c, IOW_READ_TUN);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            break;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        case TA_SOCKET_READ:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            looking_for =3D SOCKET_READ;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            tun_input_pending =3D NULL;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            io_wait(c, IOW_RE=
AD_LINK);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
break;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n>         case TA_TUN_WRITE:</span><br><span>             looking_for =3D =
TUN_WRITE;</span><br><span>             tun_input_pending =3D NULL;</span><=
br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2044?usp=3Demail">change 2044</a>=2E To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?=
usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2E=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/2044?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType=
: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>=

<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Id: I1abb10515665e1d6351689d2c2dd9d4aba8bb98e </=
div>
<div style=3D"display:none"> Gerrit-Change-Number: 2044 </div>
<div st=
yle=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"=
> Gerrit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-open=
vpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: =
R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>

</body></html>
--Yl4CBaujxG0=--


--===============6851127458810782451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6851127458810782451==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6851127458810782451==--

