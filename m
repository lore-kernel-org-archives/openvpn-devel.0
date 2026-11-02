Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A74606A324
	for <openvpn-devel@archiver.kernel.org>; Mon,  2 Nov 2026 10:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LnJSPlSU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GTKUTHE7;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=h7yUw9YI;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=N2bmvaT3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Mq4OEsGbG5NKm9PaneXHk9U91VhNUGN/Ipb4A4xwFPM=; b=LnJSPlSUhxJTeERQe7eD/eDKHE
	z4idhcarBMG1tkaGbVFT3pDN83x/910szv6ShI9Q4iNzHjKcKK0QMSXLoZ6mxiYAnvBuGscC7oweR
	nSBgPC0Hlv+VDLrWQCsUsIkTd3i79erHp6owcc1OBk4sBPmLldVzdIN1a8PwBt8yOYMs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xNpGE-000000002Ai-3vOz;
	Mon, 02 Nov 2026 10:27:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xNpFw-000000002AR-2hVP
 for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:27:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eICloTGKz8ZnXpKLfOJjs8tSGgso1SmZ7yN+TQq/FH4=; b=GTKUTHE7Dkz0BGJ3lh0qm6KzIn
 47g1eCKbRn1VJhBhwEhVHoFvTw20e93N5cIH8g/n9el6d7EJZszKkJtduH9i/se7+PGLNAkFxF9Mv
 T3dOmByu88355et59u4Vv11MJML3cbURmeUKokZUb4v9GYd0CaDJHSgqhGKj2yf67s9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eICloTGKz8ZnXpKLfOJjs8tSGgso1SmZ7yN+TQq/FH4=; b=h7yUw9YIel2/HttcxLaA2ajgFs
 U+Sgsru4gxHZxdi3UEAulCYyV9+cticFqV5mzaxPCxv+lB9YLIBklJFElJhI1MVrxnWnA92swXpXA
 LyHj25e0OHlFIHrhSW17KMgUpy1pP7gucvuqEsFN1JC70+WRUjp3B5p/Otz7MC5ExGJs=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNpFt-000000003F6-2lha for openvpn-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 10:27:12 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48e10a70540so1542062f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 02:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793615223; x=1794220023; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=eICloTGKz8ZnXpKLfOJjs8tSGgso1SmZ7yN+TQq/FH4=;
 b=N2bmvaT3jqatcIDLqOrmri8raYYjZRgfG8Q8Yf+TdmSgDPgadAm8a61SKgLEO8b95s
 cUtSnqw6MxuiwqtVzrTECJfMB1gTYe8b8jBEfRhYXA1WTbVjCa1QhvqO3C1p+l+WDdeS
 ZJSxpVnD9MYEjpFu41VbMlGPDTrsAUbdgbw1qxBAdqTB3JPe5WoCsEJC/hIX+WaD6Ic4
 hl6AG4+8uTncq7i2i8CEOxXrSJHq0U4BvzUjh+fKPfDpxXz4NOR9fM3d0U27sqdnKlNN
 4o/IoPeVrn8o58PtkVfDsCCDeq26HpEbA+TyLu6Sndt//OBnrgScQ0EkesbGYYdCoSmr
 w0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793615223; x=1794220023;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=eICloTGKz8ZnXpKLfOJjs8tSGgso1SmZ7yN+TQq/FH4=;
 b=lI2pzubnxtkr0VwU0r/yUT4Xe7X16mEJf9+ra2K0hixQhPXnCzhamjKJRaPLdjoaJl
 ziFDdsMdnquScNJKGnDyaKZJd+jS69ECcZd7FKJhYtF/vOmoEVP1nsvMzLKuuWtOgEox
 LncG1v+HgV9g+sq+I3e9ZeWDrLG0KEwWyUsCFyFdG+rDT7mP9mhdwHtdA/KzsEZZIVi7
 bJHPMVhfVfJ3KdWs9wmhUguvIq63NwyOU54niHQplUKqeNgXR146SbAjheROXTDroW2e
 1a8CSfgoUh6BeSz8ptnmpEX2KxOQbhPm8gVcV9o34B/+wdGLPewkZ1srTLbdFCntlA+7
 3PCw==
X-Gm-Message-State: AFq9FYJYdA660kOig5kdrbGWO21+v1zglioyvPHgMhu58g2Y9rFHitFh
 WohxD/nJa3buNDwZI3i+THUldvU1W4rZfEl7pv527Bq9Sh38hk2wdQ+9xELaJE52t/LSfOeH+LG
 b2Dp5Zf3okeqt7tQah8oRERW8AFl6UNfuqaeLwmLCbMvuaOFIJq/ugP4rmgMEJI4SeV1w
X-Gm-Gg: AYBFou2vH+s0QUjGnEq/5v87jtf30l6rtZnLYw0BP++Yqs8bVyB2NBtomwgdqfMdRKc
 OKH8hdlE2wstMsNzkdGMITTdULekR0LrjAPYsG5yEyn4n6P7BiQM6ZQP2rcR2JZrlQgfvQd+4uc
 scc14leHJXT+pvkvJyeIIHBTMGdt2F+LymauMUIb72lQE7dFUrIaexfuFp7rCSZH7b2+4390hxD
 PKUXrL3zKjTGOM3IePYtaIVgUWauDCBctPww+malmW82fzDH0oeAhCadOy8aTwxM2mh5xrma2MX
 Ix2Po3iOwTZZa0W4rFmgzyeIqs9jFIhfNrpiMKmueZTVDVJSeb+HGq/icGZ+Nd0BBTK97wOL6Ci
 u9I9vpwO4g0ATiv09tnz1QDvkBYbblG1ObXrruTVvB1KzAYkJwaaVMdLGdTJ0H1NFNp21aopC03
 Ma81Xo9w2+3/0bColwpEG4ARUI2GWc7k5GkSmGay/tAgzzmVEIQOE+yD97pMDxlWIrPdDaFzL5o
 T5l//YaEp1xC6SVvTRjGc3Nc1Rrlry+svF+XjQE2ADviItiB0cOBQlUI0Nmz6NPX+bmHCKfVqsc
 JzsOQZf4mz3jjmZixbP6NoVl7FNek4jkmTst0XBxTAl7kjoBgMZEa4kmMK9x4YS617klP+5nCl/
 QK5kDLMrKZIfLKkZgajV1a7gJ3uTBl3QQBrMmAvgRKlcF6tNMJBYfL8DjSEvIdozFYHG4PcAUjI
 ULdKnTUgEIor/2mw==
X-Received: by 2002:a05:600c:83c3:b0:4a9:18f4:925e with SMTP id
 5b1f17b1804b1-4ac174711afmr212525145e9.18.1793615222815; 
 Mon, 02 Nov 2026 02:27:02 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4ac09ad5ff8sm185179565e9.4.2026.11.02.02.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 02:27:01 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 2 Nov 2026 10:27:00 +0000
To: Selva Nair <selva.nair@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 5
X-Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
X-Gerrit-Change-Number: 2069
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2069?usp=email>
X-Gerrit-Commit: 648cbaff36797e4187775494c091b75b3538b147
In-Reply-To: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
References: <gerrit.1793212962000.Iac23d5141a8c29e239d0f2aeea497d3a002e609b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkzMjEyOTYyMDAwLklhYzIzZDUxNDFhOGMyOWUyMzlkMGYyYWVlYTQ5N2QzYTAwMmU2MDliQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6af9fa9749885db5fdf19412cd104e674d3e8921-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xNpFt-000000003F6-2lha
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Optionally indicate
 username in >PASSWORD '<UP_TYPE>' prompts
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
 razvanc@mailbox.org, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2151061197014005837=="
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============2151061197014005837==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4fFFj64DA/Y="; charset=UTF-8

--4fFFj64DA/Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#5) to the change originally cre=
ated by Selva Nair=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by R=C4=83zvan Cojocaru


Change subject: Optionally indicate usernam=
e in >PASSWORD '<UP_TYPE>' prompts
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E

Optionally indicate username in >PASSWORD '<UP_TYPE>=
' prompts

When username is included in the config file as inlined or
read =
from a file, indicate it as a preferred-username in
>PASSWORD Need '<UP_TYP=
E>' username/password prompts where
'<UP_TYPE>' could be 'Auth', 'HTTP Prox=
y' or 'SOCKS Proxy'=2E
The prompt is appended with "UN:<user64>" where <use=
r64> is
the pre-defined username, base64 encoded=2E

This is treated as a h=
int, not an enforced value=2E The management
client still responds with bot=
h username and password obtained
from the user=2E Whether the management cl=
ient allows the
user to input a different username is left to the client
im=
plementation=2E

The documentation in management-notes is slightly edited t=
o add
that 'Auth', 'HTTP Proxy', 'SOCKS Proxy' are possible types of
userna=
me/password prompts=2E

Only clients that announce version >=3D6 are prompt=
ed this way=2E

This helps to fix user reports on OpenVPN-GUI not respectin=
g username
set in the config file=2E

Change-Id: Iac23d5141a8c29e239d0f2aee=
a497d3a002e609b
Signed-off-by: Selva Nair <selva=2Enair@gmail=2Ecom>
Acked-=
by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL: https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2069
Message-Id: <20261030213936=2E1001-1-gert@gree=
nie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=
=2Esourceforge=2Enet/msg40351=2Ehtml
Signed-off-by: Gert Doering <gert@gree=
nie=2Emuc=2Ede>
---
M doc/management-notes=2Etxt
M src/openvpn/manage=2Ec
2=
 files changed, 57 insertions(+), 0 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/2069/5

diff --git a/doc/man=
agement-notes=2Etxt b/doc/management-notes=2Etxt
index eac91a4=2E=2Eb9b367f=
 100644
--- a/doc/management-notes=2Etxt
+++ b/doc/management-notes=2Etxt
@=
@ -304,6 +304,9 @@
     username "Auth" foo
     password "Auth" bar
 
+  T=
he same format is used for HTTP and SOCKS proxy username and password
+  wi=
th 'Auth' replaced by 'HTTP Proxy' and 'SOCKS Proxy' respectively=2E
+
   E=
xample 3:
 
     >PASSWORD:Need 'Auth' username
@@ -394,6 +397,31 @@
   res=
ponse along with the username and password formatted as described
   in the=
 Challenge/Response Protocol section below
 
+  Example 10:
+
+    >PASSWOR=
D:Need '<UP_TYPE>' username/password UN:<user-base64>
+    >PASSWORD:Need '=
Auth' username/password UN:<user-base64> SC:1,Please enter token PIN
+
+  w=
here <UP_TYPE> is any supported type that requires username and password=2E=

+  (see Example 2)=2E
+
+  These work exactly as Examples 2 and 8, respect=
ively, with the following
+  difference=2E The prompt has an additional wor=
d "UN:<user-base64>" where
+  <user-base64> is the base64 encoded form of a=
 pre-defined username=2E This
+  may be a username inlined in the config fi=
le or read from an external
+  user-pass file=2E
+
+  The management client=
 is expected to show the base64 decoded value to
+  the user=2E Whether the=
 user can change this username or not is left to
+  the client implementati=
on=2E
+
+  The response from the management client should follow the same f=
ormat
+  as in example 2 or example 8, as applicable=2E
+
+  This prompt is=
 shown only if the management-client announces a
+  version >=3D 6=2E Older=
 clients will see the prompt shown in Example 2
+  or 8=2E
+
 See the "Chal=
lenge/Response Protocol" section below for more details
 about examples 8 a=
nd 9, including how the management interface client
 should respond=2E
@@ -=
530,6 +558,7 @@
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
  =
   >PASSWORD:Need 'Auth' username -- version 4 or greater
     multiline pa=
ssword from client -- version 5 or greater
+    preferred username in >PASS=
WORD prompt -- version 6 or greater
 
 COMMAND -- auth-retry
 -------------=
--------
@@ -1454,6 +1483,12 @@
 used, the management interface will send:
=
 
   >PASSWORD:Need 'Auth' username/password SC:<flag>,<TEXT>
+  or
+  >PAS=
SWORD:Need 'Auth' username/password UN:<user64> SC:<flag>,<TEXT>
+
+  The s=
econd form is used only if the client version is >=3D6, and a
+  preferred =
username is available=2E See also Example 10 in the section
+  titled "COMM=
AND -- password and username"
 
   flag: an integer whose least significant=
 bit is the ECHO flag and
         the next significant bit is the FORMAT f=
lag=2E
@@ -1463,6 +1498,7 @@
         as described below=2E Thus flag could=
 take values 0, 1, 2, or 3=2E
   TEXT: challenge text that should be shown =
to the user to
       facilitate their response
+  user64: Preferred userna=
me, if available, base64 encoded=2E
 
 For example:
 
diff --git a/src/open=
vpn/manage=2Ec b/src/openvpn/manage=2Ec
index 0fc9ee2=2E=2E65e2881 100644
-=
-- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=2Ec
@@ -71,6 +71,7 @@
=
     MCV_PKSIGN_ALG =3D 3,
     MCV_USERNAME_ONLY =3D 4,
     MCV_MULTILINE=
_PASSWORD =3D 5,
+    MCV_PREFERRED_USERNAME =3D 6,
 };
 
 struct managemen=
t *management; /* GLOBAL */
@@ -3670,6 +3671,26 @@
             buf_printf(=
&alert_msg, " MSG:%s", up->username);
         }
 
+        if (up_query_mo=
de =3D=3D UP_QUERY_USER_PASS
+            && (man->connection=2Eclient_vers=
ion >=3D MCV_PREFERRED_USERNAME)
+            && up->username[0])
+        =
{
+            /*
+             * The buffer up is prefilled with username =
from auth-file or inline=2E
+             * Indicate it in the prompt as ba=
se64 encoded=2E
+             */
+            char *user64 =3D NULL;
+     =
       if (openvpn_base64_encode(up->username, (int)strlen(up->username), &=
user64) !=3D -1)
+            {
+                buf_printf(&alert_msg, " U=
N:%s", user64);
+            }
+            else
+            {
+          =
      msg(M_NONFATAL, "ERROR: could not base64-encode username");
+        =
    }
+            free(user64);
+        }
+
         if (sc)
         {
 =
            buf_printf(&alert_msg, " SC:%d,%s",

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-=
Branch: master
Gerrit-Change-Id: Iac23d5141a8c29e239d0f2aeea497d3a002e609b
=
Gerrit-Change-Number: 2069
Gerrit-PatchSet: 5
Gerrit-Owner: Selva Nair <sel=
va=2Enair@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit=
-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>

--4fFFj64DA/Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #5</strong> to the change originally created by Selv=
a Nair=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Optio=
nally indicate username in &gt;PASSWORD &#39;&lt;UP_TYPE&gt;&#39; prompts<b=
r><br>When username is included in the config file as inlined or<br>read fr=
om a file, indicate it as a preferred-username in<br>&gt;PASSWORD Need &#39=
;&lt;UP_TYPE&gt;&#39; username/password prompts where<br>&#39;&lt;UP_TYPE&g=
t;&#39; could be &#39;Auth&#39;, &#39;HTTP Proxy&#39; or &#39;SOCKS Proxy&#=
39;=2E<br>The prompt is appended with &quot;UN:&lt;user64&gt;&quot; where &=
lt;user64&gt; is<br>the pre-defined username, base64 encoded=2E<br><br>This=
 is treated as a hint, not an enforced value=2E The management<br>client st=
ill responds with both username and password obtained<br>from the user=2E W=
hether the management client allows the<br>user to input a different userna=
me is left to the client<br>implementation=2E<br><br>The documentation in m=
anagement-notes is slightly edited to add<br>that &#39;Auth&#39;, &#39;HTTP=
 Proxy&#39;, &#39;SOCKS Proxy&#39; are possible types of<br>username/passwo=
rd prompts=2E<br><br>Only clients that announce version &gt;=3D6 are prompt=
ed this way=2E<br><br>This helps to fix user reports on OpenVPN-GUI not res=
pecting username<br>set in the config file=2E<br><br>Change-Id: Iac23d5141a=
8c29e239d0f2aeea497d3a002e609b<br>Signed-off-by: Selva Nair &lt;selva=2Enai=
r@gmail=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt=
;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069<br>Message=
-Id: &lt;20261030213936=2E1001-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https:=
//www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg40351=
=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>-=
--<br>M doc/management-notes=2Etxt<br>M src/openvpn/manage=2Ec<br>2 files c=
hanged, 57 insertions(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/69/2069/5</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/doc/management-notes=2Etxt b/doc/management-notes=2Etxt</span=
><br><span>index eac91a4=2E=2Eb9b367f 100644</span><br><span>--- a/doc/mana=
gement-notes=2Etxt</span><br><span>+++ b/doc/management-notes=2Etxt</span><=
br><span>@@ -304,6 +304,9 @@</span><br><span>     username &quot;Auth&quot;=
 foo</span><br><span>     password &quot;Auth&quot; bar</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The same format is =
used for HTTP and SOCKS proxy username and password</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  with &#39;Auth&#39; replaced by &#39;HT=
TP Proxy&#39; and &#39;SOCKS Proxy&#39; respectively=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   Example 3:</span><b=
r><span> </span><br><span>     &gt;PASSWORD:Need &#39;Auth&#39; username</s=
pan><br><span>@@ -394,6 +397,31 @@</span><br><span>   response along with t=
he username and password formatted as described</span><br><span>   in the C=
hallenge/Response Protocol section below</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Example 10:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    &gt;PASSWORD:Need &#39;&lt;UP_TYPE&gt;&#39; username/pas=
sword UN:&lt;user-base64&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    &gt;PASSWORD:Need &#39;Auth&#39; username/password UN:&lt;user=
-base64&gt; SC:1,Please enter token PIN</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  where &lt;UP_TYPE&gt; is any supported type that requires username and p=
assword=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (see Ex=
ample 2)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  These work exactly as Exa=
mples 2 and 8, respectively, with the following</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  difference=2E The prompt has an additional wo=
rd &quot;UN:&lt;user-base64&gt;&quot; where</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  &lt;user-base64&gt; is the base64 encoded form of=
 a pre-defined username=2E This</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  may be a username inlined in the config file or read from an =
external</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  user-pass=
 file=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  The management client is exp=
ected to show the base64 decoded value to</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  the user=2E Whether the user can change this userna=
me or not is left to</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  the client implementation=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The r=
esponse from the management client should follow the same format</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  as in example 2 or example 8=
, as applicable=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This prompt is sho=
wn only if the management-client announces a</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  version &gt;=3D 6=2E Older clients will see the =
prompt shown in Example 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  or 8=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> See the &quot;Challenge/Response Protocol&quot; section below=
 for more details</span><br><span> about examples 8 and 9, including how th=
e management interface client</span><br><span> should respond=2E</span><br>=
<span>@@ -530,6 +558,7 @@</span><br><span>     &gt;PK_SIGN:[base64],[alg]  =
   -- version 3 or greater</span><br><span>     &gt;PASSWORD:Need &#39;Auth=
&#39; username -- version 4 or greater</span><br><span>     multiline passw=
ord from client -- version 5 or greater</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    preferred username in &gt;PASSWORD prompt -- versio=
n 6 or greater</span><br><span> </span><br><span> COMMAND -- auth-retry</sp=
an><br><span> ---------------------</span><br><span>@@ -1454,6 +1483,12 @@<=
/span><br><span> used, the management interface will send:</span><br><span>=
 </span><br><span>   &gt;PASSWORD:Need &#39;Auth&#39; username/password SC:=
&lt;flag&gt;,&lt;TEXT&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  &gt;PAS=
SWORD:Need &#39;Auth&#39; username/password UN:&lt;user64&gt; SC:&lt;flag&g=
t;,&lt;TEXT&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  The second form is us=
ed only if the client version is &gt;=3D6, and a</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  preferred username is available=2E See also =
Example 10 in the section</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  titled &quot;COMMAND -- password and username&quot;</span><br><span=
> </span><br><span>   flag: an integer whose least significant bit is the E=
CHO flag and</span><br><span>         the next significant bit is the FORMA=
T flag=2E</span><br><span>@@ -1463,6 +1498,7 @@</span><br><span>         as=
 described below=2E Thus flag could take values 0, 1, 2, or 3=2E</span><br>=
<span>   TEXT: challenge text that should be shown to the user to</span><br=
><span>       facilitate their response</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  user64: Preferred username, if available, base64 enco=
ded=2E</span><br><span> </span><br><span> For example:</span><br><span> </s=
pan><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec<=
/span><br><span>index 0fc9ee2=2E=2E65e2881 100644</span><br><span>--- a/src=
/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br>=
<span>@@ -71,6 +71,7 @@</span><br><span>     MCV_PKSIGN_ALG =3D 3,</span><b=
r><span>     MCV_USERNAME_ONLY =3D 4,</span><br><span>     MCV_MULTILINE_PA=
SSWORD =3D 5,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MC=
V_PREFERRED_USERNAME =3D 6,</span><br><span> };</span><br><span> </span><br=
><span> struct management *management; /* GLOBAL */</span><br><span>@@ -367=
0,6 +3671,26 @@</span><br><span>             buf_printf(&amp;alert_msg, &qu=
ot; MSG:%s&quot;, up-&gt;username);</span><br><span>         }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (up=
_query_mode =3D=3D UP_QUERY_USER_PASS</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &amp;&amp; (man-&gt;connection=2Eclient_versi=
on &gt;=3D MCV_PREFERRED_USERNAME)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &amp;&amp; up-&gt;username[0])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             * The buffer up is prefilled with usern=
ame from auth-file or inline=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             * Indicate it in the prompt as base64 encoded=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            char *user64 =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (openvpn_base64_encode(up-&gt;username, (int)strlen(up-&gt;username), =
&amp;user64) !=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            buf_printf(&amp;alert_msg, &quot; UN:%s&quot;, user64);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(M_NONFATAL, &quot;ERR=
OR: could not base64-encode username&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            free(user64);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span>         if (sc)</span><br><span>         {=
</span><br><span>             buf_printf(&amp;alert_msg, &quot; SC:%d,%s&qu=
ot;,</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/2069?usp=3Demail">change 2069</a>=2E To unsubscribe, or =
for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2E=
net/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"htt=
p://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/2069?usp=3Demail"/><meta itemprop=3D"nam=
e" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerr=
it-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Proj=
ect: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </di=
v>
<div style=3D"display:none"> Gerrit-Change-Id: Iac23d5141a8c29e239d0f2ae=
ea497d3a002e609b </div>
<div style=3D"display:none"> Gerrit-Change-Number: =
2069 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div sty=
le=3D"display:none"> Gerrit-Owner: Selva Nair &lt;selva=2Enair@gmail=2Ecom&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;a=
rne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &l=
t;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--4fFFj64DA/Y=--


--===============2151061197014005837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2151061197014005837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2151061197014005837==--

