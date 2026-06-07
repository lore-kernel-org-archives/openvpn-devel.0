Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E665CD8C89
	for <openvpn-devel@archiver.kernel.org>; Sun,  7 Jun 2026 16:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nGpcNFWHba/ngIEN2G/suVvAmxJXC1FRLSk6Qxfkdzs=; b=muPOymscoX3zDKqk1WwqpDrz9+
	UOmUMqYKBfe1PKg9yURPOSNcw8yQXDlVSDB3131ekfmCiN5D1M3nXF+c4n6lKTOqAZeBgR3slkjUx
	iyvkHeTfdgmeHBNkfJMc0Xx6yIdcpjlaY6CxIlEslLBZ3KrKs554RcAbKNt+TVhWzX5g=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWGhm-00030h-8s;
	Sun, 07 Jun 2026 16:50:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWGhk-00030Z-FZ
 for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 16:50:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=Ur1zN9ktESqC1jA9OOR1ydCPaPwtx3AQgstlwSkaf6Y=; b=Xr/Z4CnSZBQ6Plptjm2fDp1bnC
 ttL+D/89tgfucpZP+RAB0KHrYdbH0/ccbEGfBjmum5xerxPDXQVjwMBfkhcaCExDmN2tPnxhUit6H
 RHQ57EptcQGbQG3ika1RAwECBBGy6sPZgW+RiC7T00Y7NGUqccW4Pda/LHZn0UyfhRUo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ur1zN9ktESqC1jA9OOR1ydCPaPwtx3AQgstlwSkaf6Y=; b=E
 e1W+1Xki1dRFARp3xUx+mvj+LTKAhTazXNHMJM+5cX/oDxtlIGKQlTl7VG6QxrPX5G4w/A4xpAx0y
 rtAoNO6M/+g50ecGKAnt30mf8BdMppnVae8lB+D4FOX42nBGnqfQtXXBoUfuWqSTdLu2GNxs9lG30
 bzqqlyYhBWtQzBRg=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWGhg-0008VT-Sh for openvpn-devel@lists.sourceforge.net;
 Sun, 07 Jun 2026 16:50:29 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45ee5cdbd28so2636726f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 07 Jun 2026 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1780851018; x=1781455818; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ur1zN9ktESqC1jA9OOR1ydCPaPwtx3AQgstlwSkaf6Y=;
 b=UjnQajDZLOe0YZp9ialoXBFqMrECTdoZIMhIV6SiInNw4ICJ3ZWrri3DYe0UwrIcqJ
 cApXNP7Vq0Hm/Ve28wykTG6N0xCY1SpB6iOWQ5p03CL2z8EhASdWJTtR8N7tZrWE/pEq
 t/qtTkJ2fcz+n570ODFkPM17UbQPqVW0wyEuTSAPQU32nLh5E63q4SujxOlqAGNd47HI
 tSGfc1Giz3OYPmt6aoF2DMPk2+AOCH1Bap85XX6KCJpl5/BfwIScqqrhGEyGLWfb3Ri1
 SYas7frG563K9cOZYN85ihhc3pL9TpAgc9+bbjNZl9zPHFtoefa9oSURI+7Vs1yVrQjY
 mUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780851018; x=1781455818;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ur1zN9ktESqC1jA9OOR1ydCPaPwtx3AQgstlwSkaf6Y=;
 b=ePE+c4LLSHQGw43DXbqd65OMFKorHVuaKD8o6lfPzsANY/bGE8Q3uiADXcK/2E5S/W
 bsMx8pKTtMNCaXYB06uOv+++TQ40X6PB5BeUa7NhkFc987LXA/7CSEnQNgb7BjqTp7le
 9ou3S1WdjNiwRIWq5NoNlSH/U/Fvw4ekqgmMNdUQ+GtQ7A4aH/qF2UkhTexMhlWPlmu9
 27+8SfyU7NQmonvi//oZoMsTf1CrKbVwKTT8ZxA4NkKFPq1cc7R9XNAHghxo/0gwHscU
 ZqfrkGbpcQMRvjl5mThdefktgoD3cqNh7219+D6/WjE19ccSodoVO+bYdmOtCD4zJ3Am
 8IrA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PH2jQsLKH9AFjUeT8d51YOpuZVarZPOSdXfD/qkSX3mD7BWd/2BqLOF9aEL5iVTZHjT9hCrG/CMKjSoQ0@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwsucU5yDnemotj9ATqFMSjxkw+S87vfE7YAMkylm1Zfv+I/ESm
 5TM3RPvUQna0ixRJCdXe+Ag8h7ZZz9rxtLoNV82BMNzfiX/wEfyprHbdH6TxUq4iX5GRZUdaWMd
 TkotzrReHXLmJ0UsI870dbicEssTBExdBhJ/wG1rxynBa7AVN+ey5CZxLVBxra1MX5xna0iIlbo
 vS35xyDw==
X-Gm-Gg: Acq92OFgXQHwUScWaLaM2xXdPyAPnbobE3LTCrT2alHVRbGK4pP/n/qtyifzeMTMLhN
 HfNHgg6k+1nRNhZ1GA+WcMk6q+Y3WVHoT5m+xv4YI2pxS4oiyjsXcRXczIJCqbcA+RZDUZqE4V0
 HMh+K4qB9w8hOi0NSQkHM/AtPY39tNCxlXC9EqcJRJ/GQfRvT2Xsi1lTxfiP6CubquKXqV0NzyW
 5Tk0VFCrGUSRKryK7Oep12WJyMirUWzndcnaryCwfiOcYR7QC2wcFzHZFJpF0d9NRTJgW7lxwzF
 lyNTi0rmjDQ5F0kH+LAJbe12ORMNk+hkEicNeGge0pFzqZRalRVvBaPnw5+CjmwBUQYtleSxYpK
 qIqURgQeWE05kWWAyFLf1TAQ7YP+TJK3QkVnrSZOGijEwF9oESCVPqql16hDHuNOWaloFLehauT
 sTU0cEU6j9YrsBnnk4dzHfrnTMS8fcb4kAp7m6Rnz6L5GX/Xz57ktKIlK5A7EhUlqd6MhugQChD
 B2n2vns12LtScS0JvyT/ZqpN7qcVTz972rLt8tuGN3qlEx4izGzy1SS0s/GxpChGNrvQk8d6/hY
 vPPV0uhiwRkla48rmu5Kcune
X-Received: by 2002:a05:6000:4312:b0:460:395c:7404 with SMTP id
 ffacd0b85a97d-460395c7421mr14511573f8f.20.1780851017669; 
 Sun, 07 Jun 2026 09:50:17 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35fb24sm47119202f8f.34.2026.06.07.09.50.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 09:50:16 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 7 Jun 2026 16:50:16 +0000
To: mrbff <marco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5
X-Gerrit-Change-Number: 1705
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1705?usp=email>
X-Gerrit-Commit: d66de4e0a461c8cc5fff5a00ec14b41dd27fc365
In-Reply-To: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
References: <gerrit.1779896625000.Ib56fb53ec1c0c30c9aecbd0ca440de2affad04b5@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzc5ODk2NjI1MDAwLkliNTZmYjUzZWMxYzBjMzBjOWFlY2JkMGNhNDQwZGUyYWZmYWQwNGI1QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <086581ab05f09eb919831af5e1c7f940487b5c3b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWGhg-0008VT-Sh
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: allow
 passing KEEPALIVE_TIMEOUT without KEEPALIVE_INTERVAL
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, marco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============7006591744686189908=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7006591744686189908==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/C+YZGJ7SKk="; charset=UTF-8

--/C+YZGJ7SKk=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1705?usp=3Demail )

Change subject: dco_linux: allow passing KEEPALIVE_=
TIMEOUT without KEEPALIVE_INTERVAL
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

dco_linux: allow passing KEEPALIVE_TIMEOUT without K=
EEPALIVE_INTERVAL

Depends on: https://github=2Ecom/OpenVPN/ovpn-net-next/c=
ommit/67f453e3146a646ef5f811e5a85c610537d80521

Closes: https://github=2Eco=
m/OpenVPN/openvpn/issues/911

Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de2af=
fad04b5
Signed-off-by: Marco Baffo <marco@mandelbit=2Ecom>
Acked-by: Gert D=
oering <gert@greenie=2Emuc=2Ede>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet=
/c/openvpn/+/1705
Message-Id: <20260605181053=2E3774-1-gert@greenie=2Emuc=
=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourcefo=
rge=2Enet/msg37070=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=
=2Ede>
---
M src/openvpn/ssl=2Ec
1 file changed, 3 insertions(+), 3 deletio=
ns(-)




diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index d332=
359c=2E=2E0998bd6 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2E=
c
@@ -1623,9 +1623,9 @@
 
     if (dco_enabled(options))
     {
-        /*=
 dco_set_peer() must be called if either keepalive or
-         * mssfix ar=
e set to update in-kernel config */
-        if (options->ping_send_timeout=
 || frame->mss_fix)
+        /* dco_set_peer() must be called if either kee=
palive, ping, ping-restart,
+         * ping-exit or mssfix are set to upda=
te in-kernel config */
+        if (options->ping_send_timeout || options->=
ping_rec_timeout || frame->mss_fix)
         {
             int ret =3D dco=
_set_peer(dco, multi->dco_peer_id, options->ping_send_timeout,
            =
                        options->ping_rec_timeout, frame->mss_fix);

-- 
To=
 view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail
To =
unsubscribe, or for help writing mail filters, visit http://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: op=
envpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440=
de2affad04b5
Gerrit-Change-Number: 1705
Gerrit-PatchSet: 2
Gerrit-Owner: mr=
bff <marco@mandelbit=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede=
>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvp=
n-devel <openvpn-devel@lists=2Esourceforge=2Enet>

--/C+YZGJ7SKk=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1705?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">dco_linux: allow passing KEEPALIVE_TIMEOUT=
 without KEEPALIVE_INTERVAL<br><br>Depends on: https://github=2Ecom/OpenVPN=
/ovpn-net-next/commit/67f453e3146a646ef5f811e5a85c610537d80521<br><br>Close=
s: https://github=2Ecom/OpenVPN/openvpn/issues/911<br><br>Change-Id: Ib56fb=
53ec1c0c30c9aecbd0ca440de2affad04b5<br>Signed-off-by: Marco Baffo &lt;marco=
@mandelbit=2Ecom&gt;<br>Acked-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1705<br>Messa=
ge-Id: &lt;20260605181053=2E3774-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: http=
s://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg370=
70=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br=
>---<br>M src/openvpn/ssl=2Ec<br>1 file changed, 3 insertions(+), 3 deletio=
ns(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec</span><br><span>index d332359c=2E=2E0998bd6 100644</span><br><span>---=
 a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br>=
<span>@@ -1623,9 +1623,9 @@</span><br><span> </span><br><span>     if (dco_=
enabled(options))</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* dco_set_peer() must be called if either keepa=
live or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * mss=
fix are set to update in-kernel config */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (options-&gt;ping_send_timeout || frame-&gt;=
mss_fix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
dco_set_peer() must be called if either keepalive, ping, ping-restart,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+         * ping-exit or =
mssfix are set to update in-kernel config */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (options-&gt;ping_send_timeout || optio=
ns-&gt;ping_rec_timeout || frame-&gt;mss_fix)</span><br><span>         {</s=
pan><br><span>             int ret =3D dco_set_peer(dco, multi-&gt;dco_peer=
_id, options-&gt;ping_send_timeout,</span><br><span>                       =
             options-&gt;ping_rec_timeout, frame-&gt;mss_fix);</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1705?usp=3Demail">change 1705</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2En=
et/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http=
://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1705?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerri=
t-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: o=
penvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<di=
v style=3D"display:none"> Gerrit-Change-Id: Ib56fb53ec1c0c30c9aecbd0ca440de=
2affad04b5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1705 <=
/div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"=
display:none"> Gerrit-Owner: mrbff &lt;marco@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ed=
e&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</bo=
dy></html>
--/C+YZGJ7SKk=--


--===============7006591744686189908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7006591744686189908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7006591744686189908==--

