Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C3606A31A
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cNmW/pRu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iSx5lyq9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Ygw8DglX;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=ZXLWEPV9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wP42210K3Pftq3iCvlFXsCyl0OcDJilb2lUN2p5H4nQ=; b=cNmW/pRuShFYagcJ7f3lHaY14X
	xQbuYdOpfEyPCs5cxPbz8pVPSOxR0gz79q5VGLiGnAPjHxbedNw8o87f7aRYr3CLc7ZTdxPzaGoQ/
	DMEfldiPA6nYD0cFsDEWLgOPdWVQAwWhhyDW66AA+2wLXbV7qSL2gx8Td9Z/7hYLwuCA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJpwu-000000002Rq-2OAk;
	Thu, 22 Oct 2026 10:23:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJpwt-000000002Rh-3wbv
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 10:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8EdRg0mcEYHI8gzdMI7R1QQejbDxuuzEOwcARRqf6qM=; b=iSx5lyq9Sf9LshhBnCG3cPGlPY
 idfEnyfB3dXHUIzpEMkSiNry86rxLmb5P+9ZorR3Yv2HmFxT9JYXC2PNuDPa+uYJoqg1oi0NCxY7G
 sP9433kZEKJsr70yk1GN7PMhXuZJgqou/5pat2oJjHmtGBjnmVoR8Q4kPY+a5lvOM2/0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8EdRg0mcEYHI8gzdMI7R1QQejbDxuuzEOwcARRqf6qM=; b=Ygw8DglX//enhysriK7lRWWV7y
 J+vyuARfc9M8d5fA2U7RamDCEbKk709ijzTt9Q/eooxZTvc41tDtiltqVJjyN2f2yUOiMGbaCJNMZ
 N9C5Aw3FCGwPgBC0o2cpfYpc7yp8+bO2TBsODCtmtEDEclLuk7FnQB6VWQ6tdTYd9pg8=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJpws-000000005Yy-3bYi for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 10:23:03 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a2074a66beso3834565e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792664576; x=1793269376; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8EdRg0mcEYHI8gzdMI7R1QQejbDxuuzEOwcARRqf6qM=;
 b=ZXLWEPV9pzJlDnw46UR/IUxIgiT3TWcHSIqkRRdwFyJfEPz+XEsOu0uiy1Ve9HZtNh
 tU8l2gnvdHNvesq6AwZQNjhrYxjFXEY1WRTm9yi2SXiERMSKObiZzZIR5EiMus706N6y
 bMWaF77AFcGuEH9jtWVRE8/JFCjnYo62/EibOlPsb2wquJ1mX9Vwtb+4w5JK74ZADMHi
 vSVIsyQ2/zoHi8+MtSrASpMOR4MDM70Z5ZN7dzj57xGqo1+WXrAmQ1hqZf7EaIFIdTpT
 O7iZNPknCuQtZfAcSF3eNAut7TXZW8ayakohcwfMZzn/u9D8xHR5gugXF4VkT0lvBzd6
 0DMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664576; x=1793269376;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8EdRg0mcEYHI8gzdMI7R1QQejbDxuuzEOwcARRqf6qM=;
 b=SERai+bDLYfuths/sI667sF+6Bw0ihacnzQf5/KSWfjCleCUDm5aG7IjgnhUUHGrW0
 ziTBr+L2wViSkrOS9QXepS898Ve2Jbd7nXS5pPTJAB3qKdcpXbVH0MbOKi0x0TTZEe2U
 pFfTm+zAzt2kUdAZKze/JG+hUxtcV+gIQumjaMmV1ywhaY6UZ2HlN5hW2TG564dc9pxF
 OxoUfjeM98GU5j6qmXAdH6slUapr93lmo/5nm2Y3loyAxj8MK3HHJiBrhCIJZI0kvfJ0
 wZVgsJWyJD5LQ/CqJkWCCJHOJ1pcR06IaAHE9fuSHhdTeDxS5pPqBrqso2GrpcMVsbnu
 Wvag==
X-Gm-Message-State: AFq9FYKjEq/9ykXYPfRV1s7nfw9XXMjfH/oDZspEDlG9YkJcBJQeFMN1
 voueosGrMSjPRzFDBZ6haHNUqINGCYh+d8KAYus6mgnmWmYcP1159k7GVuFjelhU/vUUQu6qFrX
 Izs5EfAIR5xgrCXIRRhAN0oRTsOf7qgPt694eqS0BfITx8mwFXJgIwanmFcMHd+xcP9ZQ
X-Gm-Gg: AYBFou3UzGhps/zbw80lYzWN1OfN08gMZAkDpV54sf/dIcjx5hQFToeIa2acPuuyNXp
 KU30U4XldUtePdSrv6dIVqAj2AiRRW6iZqbt1IisdlH59fkHDOOq0YWMz/u8hRwwWh0MXW9+A5s
 BSqMPNH7yzLplGfbaG78GFlpCu6UJ23eAh5UZ3DpN6+88EXn0qjrwnpTB7wP8kLWcgFdvsgCOYm
 aUVBSVeND9lcceyqeALLzlNI2oRr90YP6y2FBsvkp4olDCki6vd09lOjxz0p2ATjpqfA95c9q7M
 HM0xE2ZKfOwt4SX5YYvZaROw1hcHqQbPnwCqkf2ZvSg17pLsn2tEU5tj5nykZjBbauulKVi0qk4
 R3gIP1YpV3AT0Mp+j/ZzaXic9WSW/SXiom9vtFybYt21EKYP2KVGGoSuYk0hurvDIK3JLdhLUb+
 GILO/GUZP6VzzVtEKnRCRUgqgXOI6XtWsc2EggS0HuBKAFIDTWGjcQ20axupgsCE1AtNi7nJeS6
 6cYdMT6HYkyRSScBcY0Y8G9XD328oFPPIqyC/3w0hMaUqlh8Mjh/x3kkBJYA42vZkCtPikYN5Gw
 3/L2QXr+y0wiQ5l4Uwkp1yR5/VABTtICFWqIeE7y9LqDgG7mvMbxfkoPCEpUxyatTbJbVA+Mvm3
 zVVyT+B3IpTDv8sFx3QidBWObdRISxXSagPl4ImAwGQ==
X-Received: by 2002:a05:600c:3b22:b0:4a1:dbdc:b2f1 with SMTP id
 5b1f17b1804b1-4a1fdd141f5mr98186855e9.14.1792664576124; 
 Thu, 22 Oct 2026 03:22:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1fc0ad18esm79848685e9.0.2026.10.22.03.22.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:22:55 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 10:22:54 +0000
To: Lev Stipakov <lstipakov@gmail.com>, Heiko Hund <heiko@openvpn.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I26fe14053446dbd215f947910565c20318c34627
X-Gerrit-Change-Number: 2027
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2027?usp=email>
X-Gerrit-Commit: 5e520ccb3df9e2f3eb79e2a47d62d014bce5b9b8
In-Reply-To: <gerrit.1792566915000.I26fe14053446dbd215f947910565c20318c34627@gerrit.openvpn.net>
References: <gerrit.1792566915000.I26fe14053446dbd215f947910565c20318c34627@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTY2OTE1MDAwLkkyNmZlMTQwNTM0NDZkYmQyMTVmOTQ3OTEwNTY1YzIwMzE4YzM0NjI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eaf3b0fc60b833d1f55887128223e3b42efdbec2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJpws-000000005Yy-3bYi
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: interactive:
 null-terminate iface.name in address and route handlers
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
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, heiko@openvpn.net,
 openvpn-devel@lists.sourceforge.net, lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8369129542521313760=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============8369129542521313760==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RK1p4THL50I="; charset=UTF-8

--RK1p4THL50I=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#2) to the change originally cre=
ated by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+2 by Heiko Hund


Change subject: interactive: null-terminate iface=
=2Ename in address and route handlers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

interactive: null-terminate iface=2Ename in addre=
ss and route handlers

HandleAddressMessage() and HandleRouteMessage() pass=
 the client supplied
interface name to InterfaceLuid() and strlen() without=
 making sure it is
null-terminated=2E A pipe client sending a message with =
iface=2Eindex set to
TUN_ADAPTER_INDEX_INVALID and a 256 byte name without =
a terminating NUL
makes the service read past the name into the remainder o=
f the on-stack
pipe_message_t and beyond=2E

This is hardening rather than =
a fix for an exploitable bug: the trailing
bytes only ever reach ConvertInt=
erfaceAliasToLuid(), which fails on them,
and nothing is returned to the cl=
ient beyond an error code=2E Terminate the
name anyway, like HandleDNSConfi=
gMessage() and HandleDNSConfigNrptMessage()
already do=2E

Github: OpenVPN/=
openvpn#1130
Change-Id: I26fe14053446dbd215f947910565c20318c34627
Signed-of=
f-by: Naveed Khan <dxbnaveed=2Ek@gmail=2Ecom>
Signed-off-by: Lev Stipakov <=
lev@openvpn=2Enet>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit URL: h=
ttps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027
Message-Id: <20261021165735=
=2E11175-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/o=
penvpn-devel@lists=2Esourceforge=2Enet/msg40085=2Ehtml
Signed-off-by: Gert =
Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2Ec
1 f=
ile changed, 6 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/27/2027/2

diff --git a/src/openvpns=
erv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index ed163a4=2E=2Ed3=
6e8d5 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/in=
teractive=2Ec
@@ -575,6 +575,9 @@
     PMIB_UNICASTIPADDRESS_ROW addr_row;
=
     BOOL add =3D msg->header=2Etype =3D=3D msg_add_address;
 
+    /* enfo=
rce null-termination of the interface name from client */
+    msg->iface=
=2Ename[_countof(msg->iface=2Ename) - 1] =3D '\0';
+
     addr_row =3D mall=
oc(sizeof(*addr_row));
     if (addr_row =3D=3D NULL)
     {
@@ -653,6 +656=
,9 @@
     PMIB_IPFORWARD_ROW2 fwd_row;
     BOOL add =3D msg->header=2Etyp=
e =3D=3D msg_add_route;
 
+    /* enforce null-termination of the interface=
 name from client */
+    msg->iface=2Ename[_countof(msg->iface=2Ename) - 1=
] =3D '\0';
+
     fwd_row =3D malloc(sizeof(*fwd_row));
     if (fwd_row =
=3D=3D NULL)
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/2027?usp=3Demail
To unsubscribe, or for help writing mail filters, =
visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageTy=
pe: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change=
-Id: I26fe14053446dbd215f947910565c20318c34627
Gerrit-Change-Number: 2027
G=
errit-PatchSet: 2
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit=
-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko=
 Hund <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>

--RK1p4THL50I=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #2</strong> to the change originally created by Lev =
Stipakov=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/202=
7?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+2 by Heiko Hund</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">interactive: =
null-terminate iface=2Ename in address and route handlers<br><br>HandleAddr=
essMessage() and HandleRouteMessage() pass the client supplied<br>interface=
 name to InterfaceLuid() and strlen() without making sure it is<br>null-ter=
minated=2E A pipe client sending a message with iface=2Eindex set to<br>TUN=
_ADAPTER_INDEX_INVALID and a 256 byte name without a terminating NUL<br>mak=
es the service read past the name into the remainder of the on-stack<br>pip=
e_message_t and beyond=2E<br><br>This is hardening rather than a fix for an=
 exploitable bug: the trailing<br>bytes only ever reach ConvertInterfaceAli=
asToLuid(), which fails on them,<br>and nothing is returned to the client b=
eyond an error code=2E Terminate the<br>name anyway, like HandleDNSConfigMe=
ssage() and HandleDNSConfigNrptMessage()<br>already do=2E<br><br>Github: Op=
enVPN/openvpn#1130<br>Change-Id: I26fe14053446dbd215f947910565c20318c34627<=
br>Signed-off-by: Naveed Khan &lt;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>Signed-o=
ff-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Heiko Hund &lt;h=
eiko@openvpn=2Enet&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2027<br>Message-Id: &lt;20261021165735=2E11175-1-gert@greenie=2Emuc=
=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg40085=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@gre=
enie=2Emuc=2Ede&gt;<br>---<br>M src/openvpnserv/interactive=2Ec<br>1 file c=
hanged, 6 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/27/2027/2</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=
=2Ec</span><br><span>index ed163a4=2E=2Ed36e8d5 100644</span><br><span>--- =
a/src/openvpnserv/interactive=2Ec</span><br><span>+++ b/src/openvpnserv/int=
eractive=2Ec</span><br><span>@@ -575,6 +575,9 @@</span><br><span>     PMIB_=
UNICASTIPADDRESS_ROW addr_row;</span><br><span>     BOOL add =3D msg-&gt;he=
ader=2Etype =3D=3D msg_add_address;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* enforce null-termination of the in=
terface name from client */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg-&gt;iface=2Ename[_countof(msg-&gt;iface=2Ename) - 1] =3D &#=
39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     addr_row =3D malloc(sizeof(*addr_row));</span><br><span>     =
if (addr_row =3D=3D NULL)</span><br><span>     {</span><br><span>@@ -653,6 =
+656,9 @@</span><br><span>     PMIB_IPFORWARD_ROW2 fwd_row;</span><br><span=
>     BOOL add =3D msg-&gt;header=2Etype =3D=3D msg_add_route;</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* enforce=
 null-termination of the interface name from client */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    msg-&gt;iface=2Ename[_countof(msg-&g=
t;iface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     fwd_row =3D malloc(sizeof(*fwd_row=
));</span><br><span>     if (fwd_row =3D=3D NULL)</span><br><span>     {</s=
pan><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/2027?usp=3Demail">change 2027</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/sett=
ings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://sche=
ma=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2027?usp=3Demail"/><meta itemprop=3D"name" conten=
t=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Messag=
eType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: open=
vpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Id: I26fe14053446dbd215f947910565c2031=
8c34627 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 2027 </di=
v>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>=

<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: He=
iko Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>

</body></html>
--RK1p4THL50I=--


--===============8369129542521313760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8369129542521313760==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8369129542521313760==--

