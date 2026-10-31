Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BF606A321
	for <openvpn-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dJUb78QJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=eCgJmzpi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Y3rgMVZj;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=XQoD9MzD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VrYT3CsCxfW9TXSd6KWMYtxd+mX8Kjrn+VdVygTGE6A=; b=dJUb78QJwggx2tWLecYFNSmOI3
	c27A9qt1ZNWXvy8XvB9XO4BYtY1CqRIYS0bWKPEbMSulj2YuF3IbFH+QcNQL8ZX+3gqkcLWgWhftR
	VHkFMrc1uKRJVBskO4ZXYPBy9JkEcOyA/VtziSzrvyrTpgNDLvVo2/8fYvxrlxAr+1uA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNBsp-000000001Ek-3DGQ;
	Sat, 31 Oct 2026 16:24:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNBsn-000000001ER-2zKn
 for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0rZ/6sU4O8onqzulisVRTm0Awi1E7njUET9Lo8bUtx8=; b=eCgJmzpiAnnwLY/1WS9uCDDAxs
 XaU5PjoOtSm4+HOUxxT3HTL34j5EfurRJc5Pt5ufyrxreMAqfwnMnvvWYK2dk0UQdiunA8aPbTKBx
 LTmGvdI40+IW0E1LmP7+b5vpXQpJwQweKcFLK6dznPEDpOCq4mWZPJbjWQwebd3aWNa8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0rZ/6sU4O8onqzulisVRTm0Awi1E7njUET9Lo8bUtx8=; b=Y3rgMVZjfaXdrz0XOj67fIsEnK
 7xdMRbQh+Am9wPFPBZsDx6s/zyQ2ObVhMB+bqdAXYGETZJc7m04Q1X08Kvwh7Q/IkMvm6iK2FEgR2
 Mrfhoj9XcgBxGQyWBalRf8qMjaSALoxpMgtCpuCfEu2LBlQvo7mgJITcY2ctMx+6h36o=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNBsY-000000006nl-2sjp for openvpn-devel@lists.sourceforge.net;
 Sat, 31 Oct 2026 16:24:27 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e6eb21a8fso661729f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 31 Oct 2026 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793463860; x=1794068660; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=0rZ/6sU4O8onqzulisVRTm0Awi1E7njUET9Lo8bUtx8=;
 b=XQoD9MzDEiSSCrXjEw1bnWZyMofB90X8Lkqm1fm964LoBz691dgG3jswHxIyFUQkHZ
 FP3hL4KaGvpYQzk+c+PzGeRl8QNup9zpK0NpDVSoMVBIj83Yf0yb4ehI8WYrlGzmuzGj
 4t0P4S/8GdsnHOfE2YjKDeU1d3BSzt6vwpujqYNjBL6Bm3V23iWyICWUB55IZhkGt7V8
 9gC8LyHC72uN5PL9FhV0fsYnNfypUTJVicgDRvWuPt5zkbabOqRzXO8cNeSJQXkmlvmN
 RWJoi+MRH3ozPOgbWYnoDf9d6ekw0YapZaE3wnY7mUBesg+bT3z4xTcQUbGrVinUTswG
 WmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463860; x=1794068660;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=0rZ/6sU4O8onqzulisVRTm0Awi1E7njUET9Lo8bUtx8=;
 b=lFWpHous4i2CzGBfuiKJ6AnczQNBuYYby91xOO/XPta99srdpHt9IqpjqPPUNxQLZW
 jNX8MwS5nCRYMxSsEDnQfuSy1Z6MCef834wm+O6QjenOl6TZRyfQUCf7l5/1GgrO0rHw
 FWyqHbstNXbmO8E8gYoOj4l4AD+FJRzI8qCciMTjdBVmeG2rzeGvKbHRRQeRp7Jmd07/
 FIIPu6yQg/ZdjmBloBb3im/BrFZ/ygVJLnBveD5AGeCmjjw3p0F8RU1t2OZAl280940b
 jKQpJsZ/5qlYuMVQsFtWOPxESyLc+w2d1H4SDYzk++jeyoKhj9Va9jbb4EGjzRT6UZY6
 sDbg==
X-Gm-Message-State: AFq9FYKTYA1QAT4wCuvyZxaRGphknE2I8+tH4ODF4FxPScQ3p8VZgC15
 USxk2EAWPZA8XsZOF36mdMXKVrSMgH4DxIS3p9jDRM5z/PVxPaz5J2h79kai9R7q/oU+PjBxN4Q
 AOP9sB/SXSDu/up2KSbSOpxFc9iGH1eAo0UJObarZsKAiLIkS4Gt2MgWGYkwPwOCfnM0d
X-Gm-Gg: AYBFou1ArVoW2t4nKj+2jkoGw0SrxcYtRyiMDZ6ZCjQAiUC9n2pl4BkDOocZX6QDAqF
 PcmvT+1tTabTgRaTNn6GOwDknKh+Flo0P5O8lbA5m00Wrg2Z24ON70lCZkyNV/a8xzEfh6LyX8N
 wjxj89H3nrcTsK1sC1YCfgHR3wl9TgsRYaflyUcdvHJdBS1FyYnqNqbItOdQBsuIt9lAKo+uBbo
 g2sB4MSkl6XXSwo+qk8wvTU9lPibKVV/5SdV6yd/bJH7ksv1lv8iGhFCIp6Ge3rPyassiQ3a4TS
 1yTXUmEOjC7bAi/ekCfkd/L/8HYMrKMxgfP5xs0RtbdZunXRAkKbiDvgTnUvldkaRdPPhhWEKmJ
 tAGA9MkCMGH54Myshfgp2UvINWrRyXTlb+Bl8ky8WnN2UHqFwD2KgZzyjd2ecmjd8HFA2my3OLG
 I/+Ca4wdHnA/SyaVyOuCvrG7q88MiB1Tfs9qGJzeFjucqUrePVqTTe1UG+MWHfSuAPDjS+GFiPz
 Xpg0oLWZ8q+BRSPGqXoOKSzhG93dxfSYiMQLX/7QfkrEMC5n03f+nC1I7kohZPjLQ617wAk88UG
 FRg0b4BjnFxeiNPjlUVm89oxTsi5EC0sO6I7AM7hxDVgZn9do5lA+T2oSGqWl4ylezRENHS/ty0
 WDatwM3r2s5x7PJgdJYvdDKktYhAoF68GOhdKWB0+Rj/cY/UEwBhobLYEPcSuiIwdoqQR/uy3/2
 rzm8PX21s521MDnQDd
X-Received: by 2002:a05:6000:22c8:b0:48e:f07:160e with SMTP id
 ffacd0b85a97d-48e6e305c3bmr13483704f8f.38.1793463860037; 
 Sat, 31 Oct 2026 09:24:20 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71a4d4f9sm9654142f8f.2.2026.10.31.09.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:24:19 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 31 Oct 2026 16:24:18 +0000
To: Selva Nair <selva.nair@gmail.com>, Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I464672facb34de83930eddc4e86826d3b1cd3edd
X-Gerrit-Change-Number: 2068
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2068?usp=email>
X-Gerrit-Commit: 0975c6e707fe742aaddf02049d70942bb04676a0
In-Reply-To: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
References: <gerrit.1793212962000.I464672facb34de83930eddc4e86826d3b1cd3edd@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLkk0NjQ2NzJmYWNiMzRkZTgzOTMwZWRkYzRlODY4MjZkM2IxY2QzZWRkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <3d2463fb310c3603cc53e74d36b7715287038141-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNBsY-000000006nl-2sjp
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix numbering of
 examples in management-notes.txt
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, selva.nair@gmail.com,
 openvpn-devel@lists.sourceforge.net
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2478185618546632748=="
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2478185618546632748==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9GDiWegQbhA="; charset=UTF-8

--9GDiWegQbhA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Selva Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by Arne Schwabe


Change subject: Fix numbering of examples in manage=
ment-notes=2Etxt
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

Fix numbering of examples in management-notes=2Etxt

Change-Id: I46467=
2facb34de83930eddc4e86826d3b1cd3edd
Signed-off-by: Selva Nair <selva=2Enair=
@gmail=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit UR=
L: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068
Message-Id: <20261028201=
609=2E13684-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Eco=
m/openvpn-devel@lists=2Esourceforge=2Enet/msg40270=2Ehtml
Signed-off-by: Ge=
rt Doering <gert@greenie=2Emuc=2Ede>
---
M doc/management-notes=2Etxt
1 fil=
e changed, 7 insertions(+), 7 deletions(-)


  git pull ssh://gerrit=2Eopen=
vpn=2Enet:29418/openvpn refs/changes/68/2068/2

diff --git a/doc/management=
-notes=2Etxt b/doc/management-notes=2Etxt
index a28a1a8=2E=2Eeac91a4 100644=

--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@@ -345,=
29 +345,29 @@
   The PASSWORD real-time message type can also be used to
  =
 indicate password or other types of authentication failure:
 
-  Example 3=
: The private key password is incorrect and OpenVPN
+  Example 4: The priva=
te key password is incorrect and OpenVPN
   is exiting:
 
     >PASSWORD:Ve=
rification Failed: 'Private Key'
 
-  Example 4: The --auth-user-pass usern=
ame/password failed,
+  Example 5: The --auth-user-pass username/password f=
ailed,
   and OpenVPN will exit with a fatal error if '--auth-retry none'
 =
  (which is the default) is in effect:
 
     >PASSWORD:Verification Failed=
: 'Auth'
 
-  Example 5: The --auth-user-pass username/password failed,
+  =
Example 6: The --auth-user-pass username/password failed,
   and the server=
 provided a custom client-reason-text string
   using the client-deny serve=
r-side management interface command=2E
 
     >PASSWORD:Verification Failed=
: 'custom server-generated string'
 
-  Example 6: If server pushes --auth-=
token to the client, the OpenVPN
+  Example 7: If server pushes --auth-toke=
n to the client, the OpenVPN
   will produce a real-time PASSWORD message:
=
 
     >PASSWORD:Auth-Token:foobar
 
-  Example 7: Static challenge/respons=
e:
+  Example 8: Static challenge/response:
 
     >PASSWORD:Need 'Auth' us=
ername/password SC:1,Please enter token PIN
 
@@ -378,7 +378,7 @@
   format=
ted as described in the Challenge/Response Protocol section
   below=2E
 
-=
  Example 8: Dynamic challenge/response:
+  Example 9: Dynamic challenge/re=
sponse:
 
     >PASSWORD:Verification Failed: ['CRV1:R,E:Om01u7Fh4LrGBS7uh0=
SWmzwabUiGiW6l:Y3Ix:Please enter token PIN']
 
@@ -395,7 +395,7 @@
   in th=
e Challenge/Response Protocol section below
 
 See the "Challenge/Response =
Protocol" section below for more details
-about examples 7 and 8, including=
 how the management interface client
+about examples 8 and 9, including how=
 the management interface client
 should respond=2E
 
 COMMAND -- forget-pa=
sswords

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068=
?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https:=
//gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatch=
set
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I464672=
facb34de83930eddc4e86826d3b1cd3edd
Gerrit-Change-Number: 2068
Gerrit-PatchS=
et: 2
Gerrit-Owner: Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-Reviewer: =
Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn=
-devel@lists=2Esourceforge=2Enet>

--9GDiWegQbhA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Selv=
a Nair=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Arne Schwabe</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">Fix numbering=
 of examples in management-notes=2Etxt<br><br>Change-Id: I464672facb34de839=
30eddc4e86826d3b1cd3edd<br>Signed-off-by: Selva Nair &lt;selva=2Enair@gmail=
=2Ecom&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>=
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2068<br>Message-Id: =
&lt;20261028201609=2E13684-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40270=2Eh=
tml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<b=
r>M doc/management-notes=2Etxt<br>1 file changed, 7 insertions(+), 7 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/68/2068/2</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/doc/management-notes=
=2Etxt b/doc/management-notes=2Etxt</span><br><span>index a28a1a8=2E=2Eeac9=
1a4 100644</span><br><span>--- a/doc/management-notes=2Etxt</span><br><span=
>+++ b/doc/management-notes=2Etxt</span><br><span>@@ -345,29 +345,29 @@</sp=
an><br><span>   The PASSWORD real-time message type can also be used to</sp=
an><br><span>   indicate password or other types of authentication failure:=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  E=
xample 3: The private key password is incorrect and OpenVPN</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Example 4: The private key passwo=
rd is incorrect and OpenVPN</span><br><span>   is exiting:</span><br><span>=
 </span><br><span>     &gt;PASSWORD:Verification Failed: &#39;Private Key&#=
39;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
  Example 4: The --auth-user-pass username/password failed,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  Example 5: The --auth-user-pass u=
sername/password failed,</span><br><span>   and OpenVPN will exit with a fa=
tal error if &#39;--auth-retry none&#39;</span><br><span>   (which is the d=
efault) is in effect:</span><br><span> </span><br><span>     &gt;PASSWORD:V=
erification Failed: &#39;Auth&#39;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  Example 5: The --auth-user-pass username/=
password failed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  E=
xample 6: The --auth-user-pass username/password failed,</span><br><span>  =
 and the server provided a custom client-reason-text string</span><br><span=
>   using the client-deny server-side management interface command=2E</span=
><br><span> </span><br><span>     &gt;PASSWORD:Verification Failed: &#39;cu=
stom server-generated string&#39;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  Example 6: If server pushes --auth-token =
to the client, the OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  Example 7: If server pushes --auth-token to the client, the OpenVP=
N</span><br><span>   will produce a real-time PASSWORD message:</span><br><=
span> </span><br><span>     &gt;PASSWORD:Auth-Token:foobar</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Example 7: Static =
challenge/response:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  Example 8: Static challenge/response:</span><br><span> </span><br><span> =
    &gt;PASSWORD:Need &#39;Auth&#39; username/password SC:1,Please enter to=
ken PIN</span><br><span> </span><br><span>@@ -378,7 +378,7 @@</span><br><sp=
an>   formatted as described in the Challenge/Response Protocol section</sp=
an><br><span>   below=2E</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  Example 8: Dynamic challenge/response:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  Example 9: Dynamic challenge/re=
sponse:</span><br><span> </span><br><span>     &gt;PASSWORD:Verification Fa=
iled: [&#39;CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter tok=
en PIN&#39;]</span><br><span> </span><br><span>@@ -395,7 +395,7 @@</span><b=
r><span>   in the Challenge/Response Protocol section below</span><br><span=
> </span><br><span> See the &quot;Challenge/Response Protocol&quot; section=
 below for more details</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-about examples 7 and 8, including how the management interface client</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+about examples 8 and 9,=
 including how the management interface client</span><br><span> should resp=
ond=2E</span><br><span> </span><br><span> COMMAND -- forget-passwords</span=
><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2068?usp=3Demail">change 2068</a>=2E To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/setting=
s?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2068?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I464672facb34de83930eddc4e86826d3b1=
cd3edd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2068 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-=
devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html=
>
--9GDiWegQbhA=--


--===============2478185618546632748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2478185618546632748==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2478185618546632748==--

