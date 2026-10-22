Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCC4606A31B
	for <openvpn-devel@archiver.kernel.org>; Thu, 22 Oct 2026 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=BxbVQEXn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hqm2s1Lb;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=l6Yfszwi;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QtncUO9e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6yIUalNebHELGlkD87RYsgY1XBXiPyAoiyFcrb44cuU=; b=BxbVQEXnsh7alM9iLqV2MIonlL
	R92BCSXQtUwp+GQq13Jl8HbcNDkSwo8RJpWbYPpEiz0ZN6B4M/cy+9dzHW2Ns+BvW1nuQpf9NIYdr
	h6WVTNIXdl25waebPl4xkMihJp6dbb7tbEejMB7ehRvOzyMQMyHNDEiQrR9Uq60ESTc4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJpwx-000000005Xv-3gKq;
	Thu, 22 Oct 2026 10:23:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xJpww-000000005Xn-1ldJ
 for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 10:23:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8xxyJpWK4ol5h/atbnjK2eO/Tzun0/uUE1lNjqpB4Po=; b=hqm2s1LbcsfPIMKP0+4Fk+tvL1
 H9wqq3Slvmvb1K5Z2UabKrttUwtPOx2mVUKVTTWfqSR9ir8G2lodULIpsn/zUITlhvRHbMYyqEaXq
 e1SQaj1NI0mZhSy2XXArByuP1XveF632dhRZmSHw43e0j3wEZWN7/ZBzcLeP8sGRVUHY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8xxyJpWK4ol5h/atbnjK2eO/Tzun0/uUE1lNjqpB4Po=; b=l6Yfszwi2sGvFJ4b7Lwb+PMMcb
 6SLmdXEJ5RLxXJo4xerdeDPKPuFrmbqYzs7h8AptIECucIFbTaLcHHX+LvVxuo+exhg+D9truQsYg
 FW5ONkz80oGxuuMquOg9pyEntM37efH++qsW/Kbuf0trkI4fH3G5BAIdj+aNaqI2VQKs=;
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJpwt-000000002j9-3DQE for openvpn-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 10:23:06 +0000
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a208d93758so4841475e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 03:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792664577; x=1793269377; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8xxyJpWK4ol5h/atbnjK2eO/Tzun0/uUE1lNjqpB4Po=;
 b=QtncUO9eRoIqNv16J+YEcpuwcMYyak2zXpFGWvAxM308K3UZaVs2CO0BSS1eSVKAMo
 cP1tEt7V1qMeaiu8/l6CMSdsLapQlXpPvW3HSM7GT55fOs3lhHvwIMya2MzC3Ci8yh61
 zzogi0P5OdYIDyASzU2FJ6YoxtmyowT03pTSCl/tHfe6o/6AoofmYTspY+xOgb/LR4Hv
 0G2TYcz9N5Phzb0vXiIwkEnkotIVrjaX+Fc4VAXYGBYT5K17UZOXjqkUNJSjwTLRO+7q
 Tx0M8ICfuZg+vZyE+5qeXyw/6tdv/+MGH4GJ8UOvlMO3DvYaZsCRCMdY7ArLwg5cN5mZ
 PrRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792664577; x=1793269377;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8xxyJpWK4ol5h/atbnjK2eO/Tzun0/uUE1lNjqpB4Po=;
 b=HSdnLhNoBZ1rmzqh31Bh6jvWBGrBSOGTpmawbfODhSK8ZcvH6bzH/coBxO8dkxWJG4
 0d5xeklNas2g2bLw8lr4UnkPY9rwSPNBiH+yicXMw59XNxNBibIZI8Y8MzGrEWys5SqT
 IHBv9lb01SMq8CG1pgflKKHqpZfDBpriyQ6ujqYbis7/1jphIYc6Lv4kDsLyes9gDiIu
 v8hRx4MAgA741WE8e7BNV5nG20rGZNeAnzpQG3tSPUJfJ+ucoGJooJdEwEqDaA6hct0U
 1RnaZdt526anXWCqG5XJcEFToWnqYPCCVKLf+eTjZWbyJSeVZqgiqMLKqW1NZJ74JVb3
 Z7bw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzr1TU/5PH+640Vy7WrYo/MaCuBMnqDlWrHeFHCADvP2DTi03rqgQxusvbzSKx9Z3jfyIIipY4HXtTQhqox@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLNUAR9POYYmF1xtIBgPYTICzQMvH4+zRL44+k+JR7WLeao0e0G
 snKWHYS68omV/7s7R8J5TxiDXm78X0qkwdtblq5BX+dx3XS4aDCqI/Ay8mJAshwh3MmpKYFJPt8
 0/A5MQVIuIFsZ13zwpqUjReG3pE9klI38S4fhF1DwW7Tc2RsEqhSr1kdxnzwB6QXIowYw
X-Gm-Gg: AYBFou1PGCzlr+dxRqzSO/iiWR9unNnFmzf5GbL9wNx1PzBLz+kgPX4tScqpLpIzDHh
 v7rCMCCKn/zKf4EmvBMvXJLsJ0MY11Z6QMMv05w1YKpY61hKJXAOR/VFqzSxrOQ6Y7dpHaFnM8W
 KN/5Hx+Ha7O/KNH8BAA1ZqSPclgLB8laJhaLFSo4o/QilE/aUdN2c6YNTo7ku2a38dbAxkpO/u4
 iwfyalTCFNncpMp8mzFRAKwNrwIlHdmkcVk3zohHqXICvyoWvkLUuB4JO2kx0gck30F9l5Xqnta
 noEqIspV5A11tfx3aJWjYjzcv5Mts1Hywzn1sDME945/Pd3yjE+uXEnu6ZvvMUzRXdK8JLXnItH
 XNca+Erhk8SihKJFFQW7j+UpSHO42LjssoT/HRibL0rh/jeysSOpf5BSJibpEE9LWGLKFvR6QUj
 JOoXWv97CXn23dmiqkc7X0GTJ2wJebjbGzcAWWRToqyweeq5ymwCDMbuT2vDILJQ1lK3ysRZfCX
 O/LxRI1bT80IkzCRojnEW9F71mRoone+Qjl9JCQTpSeT59CG5Da6mPHOqh/1YazJS3TE7bquLHI
 i0axNY+Uc/a1JFrYmG6+ISFoZIJvfyuS32DLsawYt3tLzW1TjTCmP9HlaeP4t27eZ993q4KIVxJ
 9irVwWYqc0m1MRTpZ5Tjuslf4X1TrJdjn+4FNbkXiKg==
X-Received: by 2002:a05:600c:3547:b0:4a1:e672:5721 with SMTP id
 5b1f17b1804b1-4a1fdd2f5ecmr100905415e9.13.1792664576838; 
 Thu, 22 Oct 2026 03:22:56 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a203a265afsm70412645e9.7.2026.10.22.03.22.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 03:22:56 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 22 Oct 2026 10:22:56 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I26fe14053446dbd215f947910565c20318c34627
X-Gerrit-Change-Number: 2027
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2027?usp=email>
X-Gerrit-Commit: 5e520ccb3df9e2f3eb79e2a47d62d014bce5b9b8
In-Reply-To: <gerrit.1792566915000.I26fe14053446dbd215f947910565c20318c34627@gerrit.openvpn.net>
References: <gerrit.1792566915000.I26fe14053446dbd215f947910565c20318c34627@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyNTY2OTE1MDAwLkkyNmZlMTQwNTM0NDZkYmQyMTVmOTQ3OTEwNTY1YzIwMzE4YzM0NjI3QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <eaf3b0fc60b833d1f55887128223e3b42efdbec2-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJpwt-000000002j9-3DQE
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Heiko Hund <heiko@openvpn.net>, Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1966643424116469727=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1966643424116469727==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5WqeHTeKx34="; charset=UTF-8

--5WqeHTeKx34=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/2027?usp=3Demail )

Change subject: interactive: null-terminate=
 iface=2Ename in address and route handlers
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

interactive: null-terminate iface=2Ename in=
 address and route handlers

HandleAddressMessage() and HandleRouteMessage(=
) pass the client supplied
interface name to InterfaceLuid() and strlen() w=
ithout making sure it is
null-terminated=2E A pipe client sending a message=
 with iface=2Eindex set to
TUN_ADAPTER_INDEX_INVALID and a 256 byte name wi=
thout a terminating NUL
makes the service read past the name into the remai=
nder of the on-stack
pipe_message_t and beyond=2E

This is hardening rather=
 than a fix for an exploitable bug: the trailing
bytes only ever reach Conv=
ertInterfaceAliasToLuid(), which fails on them,
and nothing is returned to =
the client beyond an error code=2E Terminate the
name anyway, like HandleDN=
SConfigMessage() and HandleDNSConfigNrptMessage()
already do=2E

Github: Op=
enVPN/openvpn#1130
Change-Id: I26fe14053446dbd215f947910565c20318c34627
Sig=
ned-off-by: Naveed Khan <dxbnaveed=2Ek@gmail=2Ecom>
Signed-off-by: Lev Stip=
akov <lev@openvpn=2Enet>
Acked-by: Heiko Hund <heiko@openvpn=2Enet>
Gerrit =
URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027
Message-Id: <202610211=
65735=2E11175-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg40085=2Ehtml
Signed-off-by: =
Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpnserv/interactive=2E=
c
1 file changed, 6 insertions(+), 0 deletions(-)




diff --git a/src/open=
vpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index ed163a4=2E=
=2Ed36e8d5 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnse=
rv/interactive=2Ec
@@ -575,6 +575,9 @@
     PMIB_UNICASTIPADDRESS_ROW addr_=
row;
     BOOL add =3D msg->header=2Etype =3D=3D msg_add_address;
 
+    /*=
 enforce null-termination of the interface name from client */
+    msg->if=
ace=2Ename[_countof(msg->iface=2Ename) - 1] =3D '\0';
+
     addr_row =3D m=
alloc(sizeof(*addr_row));
     if (addr_row =3D=3D NULL)
     {
@@ -653,6 +=
656,9 @@
     PMIB_IPFORWARD_ROW2 fwd_row;
     BOOL add =3D msg->header=2E=
type =3D=3D msg_add_route;
 
+    /* enforce null-termination of the interf=
ace name from client */
+    msg->iface=2Ename[_countof(msg->iface=2Ename) =
- 1] =3D '\0';
+
     fwd_row =3D malloc(sizeof(*fwd_row));
     if (fwd_ro=
w =3D=3D NULL)
     {

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/2027?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id=
: I26fe14053446dbd215f947910565c20318c34627
Gerrit-Change-Number: 2027
Gerr=
it-PatchSet: 2
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Re=
viewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Heiko Hu=
nd <heiko@openvpn=2Enet>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Eso=
urceforge=2Enet>

--5WqeHTeKx34=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2027?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">interactive: null-terminate iface=
=2Ename in address and route handlers<br><br>HandleAddressMessage() and Han=
dleRouteMessage() pass the client supplied<br>interface name to InterfaceLu=
id() and strlen() without making sure it is<br>null-terminated=2E A pipe cl=
ient sending a message with iface=2Eindex set to<br>TUN_ADAPTER_INDEX_INVAL=
ID and a 256 byte name without a terminating NUL<br>makes the service read =
past the name into the remainder of the on-stack<br>pipe_message_t and beyo=
nd=2E<br><br>This is hardening rather than a fix for an exploitable bug: th=
e trailing<br>bytes only ever reach ConvertInterfaceAliasToLuid(), which fa=
ils on them,<br>and nothing is returned to the client beyond an error code=
=2E Terminate the<br>name anyway, like HandleDNSConfigMessage() and HandleD=
NSConfigNrptMessage()<br>already do=2E<br><br>Github: OpenVPN/openvpn#1130<=
br>Change-Id: I26fe14053446dbd215f947910565c20318c34627<br>Signed-off-by: N=
aveed Khan &lt;dxbnaveed=2Ek@gmail=2Ecom&gt;<br>Signed-off-by: Lev Stipakov=
 &lt;lev@openvpn=2Enet&gt;<br>Acked-by: Heiko Hund &lt;heiko@openvpn=2Enet&=
gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027<br>Messa=
ge-Id: &lt;20261021165735=2E11175-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: htt=
ps://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40=
085=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<b=
r>---<br>M src/openvpnserv/interactive=2Ec<br>1 file changed, 6 insertions(=
+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactiv=
e=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index ed163a4=2E=2E=
d36e8d5 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</span>=
<br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -575,6 +=
575,9 @@</span><br><span>     PMIB_UNICASTIPADDRESS_ROW addr_row;</span><br=
><span>     BOOL add =3D msg-&gt;header=2Etype =3D=3D msg_add_address;</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 enforce null-termination of the interface name from client */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    msg-&gt;iface=2Ename[_counto=
f(msg-&gt;iface=2Ename) - 1] =3D &#39;\0&#39;;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     addr_row =3D malloc(sizeof=
(*addr_row));</span><br><span>     if (addr_row =3D=3D NULL)</span><br><spa=
n>     {</span><br><span>@@ -653,6 +656,9 @@</span><br><span>     PMIB_IPFO=
RWARD_ROW2 fwd_row;</span><br><span>     BOOL add =3D msg-&gt;header=2Etype=
 =3D=3D msg_add_route;</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* enforce null-termination of the interface name =
from client */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
sg-&gt;iface=2Ename[_countof(msg-&gt;iface=2Ename) - 1] =3D &#39;\0&#39;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 fwd_row =3D malloc(sizeof(*fwd_row));</span><br><span>     if (fwd_row =3D=
=3D NULL)</span><br><span>     {</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027?usp=3Demail">change 202=
7</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2027?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I26=
fe14053446dbd215f947910565c20318c34627 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 2027 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;l=
stipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Heiko Hund &lt;heiko@openvpn=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lis=
ts=2Esourceforge=2Enet&gt; </div>

</body></html>
--5WqeHTeKx34=--


--===============1966643424116469727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1966643424116469727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1966643424116469727==--

