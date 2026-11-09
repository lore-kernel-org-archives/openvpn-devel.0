Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3FA606A325
	for <openvpn-devel@archiver.kernel.org>; Mon,  9 Nov 2026 15:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Jj1NZdRR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kA8TZbak;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=gJs1+ngu;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=UlDVtDBb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=V/BcnmBYOzQHOu2bKaqz0JK3tIcI0TDw8gIxTVTKdKU=; b=Jj1NZdRRVBBjooK6hIYh68NXjs
	WrjvLkDK+rEYZeYxEew9cXnvznJibroo4OSHJCW2/+eZvun2UhTiJOAuqQnpbBk0+zGVIQ8f0yMtu
	VYe5WaawRWkbC2NTX1f/JicbZac25LdD7SPUMrHNCHDzOvwDAMPSZkU/yS7nY9i8m5Ko=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xQRao-000000007Bk-2Spp;
	Mon, 09 Nov 2026 15:47:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xQRam-000000007Bc-2S8f
 for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:47:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vZ/EvzwAFjxEUwuKLRE4bOQhB08TzBk2jdGihUIcVV0=; b=kA8TZbak03kbAR6Sxw9p09rvTC
 b4rE6tSj2I9L0XVFNSG7TzlDDggBImy7DQheWcbmJFMVs6l+a6ljeCFOw18Ud5ymD/sU6E+GLFpp0
 vrcKzSym2VVxKCxnlL5+P0LDQ08mGw0qiBG8cuEK4BPc48ScQ/sNS35rinPP9pHqdcz8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vZ/EvzwAFjxEUwuKLRE4bOQhB08TzBk2jdGihUIcVV0=; b=gJs1+nguZQfLU0TxfKvyB09veZ
 7uFWDsugK4AyvJ5a5U6YG6atEsACbk020N6DBAXfrB4MTZoK1y38RQBNYSK+W9v3URmBP/nZ6z4a6
 52oq06Mu30x7j4SHULTze+9AqrBhKHkC69XG/YxWL4gMAa1Uybt4Vl2fIwtWlsIXzNTs=;
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xQRae-000000002YN-3QWJ for openvpn-devel@lists.sourceforge.net;
 Mon, 09 Nov 2026 15:47:32 +0000
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-492fcbfaa88so738554f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 09 Nov 2026 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794239238; x=1794844038; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vZ/EvzwAFjxEUwuKLRE4bOQhB08TzBk2jdGihUIcVV0=;
 b=UlDVtDBbUjIBuj7sw0m1NxA30FV8pjXspNwvBfubOPKPSxqs7MDFl/8AA1UXBB2nTL
 ZGgHt2MVHK0Lvv2xn7VAXiuUgCISJK6YZZjTh+RRTQmV0TF/ktHCh2Bu8SxQHT0bt218
 H0UsiN7M2+XvazdxkRWDI9YHJB9Ss6xyR+/OaYnQwiSZbtoiqLHG9ZzD9rTQJdxolOMF
 ocgJi2ubLhAS+pCBqVwYNuuGBupHuDrR8xxUHhHJ5WNJZQPxpBverYlMTZVlQHkt7zHP
 muPbmHza+R/m4GzDMC1Kf+cojG0Sjo/ifnZW2qz7mqt7YZdJ3m3+gTMYwXE1cDNy9uMK
 3Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794239238; x=1794844038;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vZ/EvzwAFjxEUwuKLRE4bOQhB08TzBk2jdGihUIcVV0=;
 b=e0u9GfefQUd7U/sLtcjlCyUQeif9S7CrwCKR2T1CfeWcCBhwJGCUyDUY7Nx5I4T/H2
 27rPi2aA/jPzgC1R7azKSRi9wgybX6l/fakthqgdrWOvWwjJdVbNrXU3Rh2jXEae4tDy
 MVp9Od/7TsWQWENLxJQbr4VqUDLezhhml3NN9Q0RC0wL1WUQvfyKZtgmDhtQJkTZTgU2
 OjnfBXimBLxpdfUDzfugBVNs/q/8wn5ktpR5rbO9urOfCXBtBBagV6XaccUOSDFAKfwy
 yM4sOatlTnK9GfdJE/3qyh2RXfbJlQaTaFpvN2h0lSzcD9V9Qm0uwdcSnnfLQxZxhQSu
 G3Wg==
X-Gm-Message-State: APuU4Z9krPaH6+sTNOFkvzkH1wHKr14iwu0cP/NKCh03yAa0Zoe8lH3G
 xkvTkJR689F8PUbuYlWUGn3bb2bP7jfTM9AJHpAJ2pa6P7x6QMeAz0muhUYD8OZND0p0y9XWfB7
 0demqt/xfc8uEiJsezVbIz1OWZhBy/ouYj8SrxjRqkUw0Qi1mslKFVeV3mSYRaU+j/UoR
X-Gm-Gg: AYBFou2kHi09O28qRydzBfZe4mRfUImhPi1Ndq8wT+t5kaWJAvHMEZuI9KbOtvtOaXQ
 Tz/MZQMR458jGpT2YrGYm6kL7hE30FYipGniN8oMqK3rctXhtBXEfyZykUgBskRwsAX1n5Qvxcz
 TwWOR/HXs87QnplhwR2zRsZx8dxkjGEXLdvY2+hcXJnCPA0KE0jP7iTFMtwgaWPktYcm37shhcV
 MensJ+dXOZhXSB3qUbWh3z95s42bUOBP2b4yAbCcvUwuQbIuLSkPuQMk/j1YxMVOS4gCgeDx4Rr
 8xmaPBQsI6uYTfXgy8TepkPJzzz2KaL8Cp01NlgIXm8t/4Xl5wZH81NFAHYITwp22pYkIubrgI3
 M9np3KetVykkmZoA/KixPNYsUNJ8Bmn9CKUCfUKmwEcn+JolYFvJsK18RcVvtMt1s7jKJDjNC9q
 0V6IhqQHEGQ5T5dEIw100Mzp/DoCSA38KCZi4U+PzwuqLMrefpFmtR6sDRVUJCu3JPBGtLfOokY
 jOkH/G7TaUQvo1KSMmBv2cJ1J9YrtJaxykc1ETX9Yo+kMdsydy/uedq6RG6rhcpoudACwmFpVh1
 EIYKLakeKNBg6I/sBZfk5e+TjoU70hkcL/exzrC2lrr4A+/fb/gGQoeg4R4TwM1H9anIGPvt5Ot
 CR+Vr9PIqRDED3N3shOoIab4hH4814i+v8yme9GCig8IIU/hBK/QE9K9Zo+szC23jVWade/xg84
 7By2gZUIeuyBlHaQ==
X-Received: by 2002:a05:6000:460f:b0:48d:f034:7fcd with SMTP id
 ffacd0b85a97d-49584690475mr8373867f8f.51.1794239236715; 
 Mon, 09 Nov 2026 07:47:16 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49596ea5008sm10832782f8f.26.2026.11.09.07.47.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 07:47:16 -0800 (PST)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 9 Nov 2026 15:47:13 +0000
To: Selva Nair <selva.nair@gmail.com>, Lev Stipakov <lstipakov@gmail.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
X-Gerrit-Change-Number: 2001
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2001?usp=email>
X-Gerrit-Commit: f1a053fdd74d6cb4a723614dbbed995c8f916c58
In-Reply-To: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
References: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMTI4Mzg3MDAwLkkwODllNWI3OTYwMGM1MzVlM2MwYzVkMWJiMTQzMTlhYzAzZjQxNDRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <e879609c8cddc7966d7bb1fb4fa9a5d2fe7bc1f3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xQRae-000000002YN-3QWJ
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: openvpnserv: add
 automatic service again
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
 selva.nair@gmail.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, lstipakov@gmail.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4433210539689819541=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4433210539689819541==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DCGr0wHRwnU="; charset=UTF-8

--DCGr0wHRwnU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Heik=
o Hund, Lev Stipakov, Selva Nair=2E

Hello Arne Schwabe, Frank Lichtenheld,=
 Lev Stipakov, Selva Nair, 

I'd like you to reexamine a change=2E Please v=
isit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail

to l=
ook at the new patch set (#4)=2E

The following approvals got outdated and =
were removed:
Code-Review-1 by Frank Lichtenheld


Change subject: openvpns=
erv: add automatic service again
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

openvpnserv: add automatic service again

The automatic=
 service, which starts all configs in the autostart config
directory, has b=
een provided by the =2ENET based openvpnserv2=2Eexe since
OpenVPN 2=2E4=2E =
Its original C implementation in openvpnserv=2Eexe was removed
from this re=
pository in 2021=2E Add it back, implemented in C, so that both
Windows ser=
vices are maintained in this repository=2E

Security related changes added:=

- before sending any data, verify that the named pipe is served by the
  i=
nteractive service process
- the exit event of each OpenVPN process has a r=
andom name and a DACL
  that only grants access to its owner, so it cannot =
be pre-created or
  signalled by other users
- the service checks that it i=
s run as the ovpn_service_user account in
  the registry settings, so that =
it and openvpn in turn is guaranteed to
  run with limited privileges

Robu=
stness:
- starting a config is retried until the service stops, with a dela=
y
  that doubles from 10 seconds up to 5 minutes for configs that keep
  fa=
iling, and is reset once a process ran for a minute
- an OpenVPN process th=
at may have been started by a failed attempt is
  signalled to exit, so it =
does not run unmonitored
- configs in subdirectories use their own director=
y as working
  directory; configs with the same file name as one found befo=
re are
  ignored, like in the GUI

Both services now run in their own proce=
ss, selected by the new
'-automatic' and '-interactive' options=2E This is =
needed since they need
to run with different accounts=2E '-install' takes a=
n optional service
name again=2E '-instance automatic' is not supported, si=
nce the service
cannot check the named pipe owner for instances=2E

Also ad=
d a few unit tests and some documentation=2E

Change-Id: I089e5b79600c535e3=
c0c5d1bb14319ac03f4144b
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=
=2Enet>
---
M Changes=2Emd
M doc/Makefile=2Eam
A doc/automatic-service-note=
s=2Erst
M src/openvpnserv/CMakeLists=2Etxt
M src/openvpnserv/Makefile=2Eam
=
A src/openvpnserv/automatic=2Ec
M src/openvpnserv/common=2Ec
M src/openvpns=
erv/interactive=2Ec
M src/openvpnserv/service=2Ec
M src/openvpnserv/service=
=2Eh
M tests/unit_tests/openvpnserv/Makefile=2Eam
A tests/unit_tests/openvp=
nserv/test_openvpnserv_automatic=2Ec
12 files changed, 1,652 insertions(+),=
 63 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn re=
fs/changes/01/2001/4

diff --git a/Changes=2Emd b/Changes=2Emd
index b5ae88=
1=2E=2E365b1ee 100644
--- a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,33=
 @@
   the characters mentioned above were already escaped=2E However, the =
behavior of
   Mbed TLS is slightly different from OpenSSL in that it also =
escapes "=3D"=2E
 
+* **Windows automatic service moved back into this repo=
sitory**
+
+  OpenVPNService, which starts all configs in the `config-auto`=
 directory at
+  boot time, is no longer provided by the =2ENET based `open=
vpnserv2=2Eexe`, but by
+  `openvpnserv=2Eexe`, like the interactive servic=
e is=2E It mostly works like the
+  service it was ported from, with these =
exceptions and additions:
+
+  * The service can no longer be run on the co=
mmand line, but exclusively as
+    a service through the Service Control M=
anager=2E
+  * The service refuses to start if it does not run as the accou=
nt
+    `NT SERVICE\OpenVPNService`=2E This is checked for security reasons=
: OpenVPN
+    runs under the same account, so its configs, scripts and plu=
gins would get
+    all privileges of a more privileged account as well=2E
=
+  * All service related logging is done via event log=2E The event source =
changed
+    from `OpenVpnService` to `openvpnserv`, same as for the intera=
ctive one=2E
+  * An OpenVPN process that cannot be started or exits is sta=
rted again,
+    first after 10 seconds, with the delay doubling up to 5 mi=
nutes for
+    processes that keep failing=2E
+  * Configs in subdirectorie=
s of `config-auto` use their own directory as
+    working directory=2E Of =
several configs with the same file name, only the
+    first one found is s=
tarted, like in the OpenVPN GUI=2E
+  * The automatic and the interactive s=
ervice now each run in a process of
+    their own, selected by the `-autom=
atic` and `-interactive` options of
+    `openvpnserv=2Eexe`=2E `-install` =
takes an optional service name=2E
+  * `-instance automatic` is not support=
ed on purpose=2E It cannot verify the
+    interactive service named pipe f=
or instances before connecting=2E
+
 ## Maintainer-visible changes
 
 - The=
 configure-time option `--enable-debug` is no longer  available
diff --git =
a/doc/Makefile=2Eam b/doc/Makefile=2Eam
index 5ca1c4d=2E=2Ebbd83cd 100644
-=
-- a/doc/Makefile=2Eam
+++ b/doc/Makefile=2Eam
@@ -55,6 +55,7 @@
 
 dist_no=
inst_DATA =3D \
 	android=2Etxt \
+	automatic-service-notes=2Erst \
 	inter=
active-service-notes=2Erst \
 	keying-material-exporter=2Etxt \
 	openvpn=
=2E8=2Erst \
diff --git a/doc/automatic-service-notes=2Erst b/doc/automatic=
-service-notes=2Erst
new file mode 100644
index 0000000=2E=2E4c1858c
--- /d=
ev/null
+++ b/doc/automatic-service-notes=2Erst
@@ -0,0 +1,151 @@
+OpenVPN =
Automatic Service Notes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+Introduction
+----------=
--
+
+OpenVPN Automatic Service, also known as "OpenVPNService", is a Windo=
ws system
+service which starts an OpenVPN process for each configuration f=
ile in the
+autostart configuration folder, ``config-auto`` by default=2E I=
t is meant for
+connections that should be up at all times, independent of =
any user being
+logged on=2E
+
+
+How It Works
+------------
+
+The Automat=
ic Service does not start OpenVPN itself, but uses the Interactive
+Service=
 to do it, the same way OpenVPN GUI does=2E See
+`interactive-service-notes=
=2Erst` for how the Interactive Service works=2E
+
+- On start, the service=
 searches the autostart configuration folder and its
+  subfolders, up to a=
 depth of 32, for files with the configuration file
+  extension=2E
+
+- Fo=
r each configuration file it connects to the Interactive Service named
+  p=
ipe ``\\=2E\pipe\openvpn\service`` and sends the startup data=2E Before sen=
ding
+  anything it checks that the pipe is served by the Interactive Servi=
ce
+  process, as registered with the Service Control Manager=2E
+
+- The I=
nteractive Service starts openvpn=2Eexe with the account of the
+  Automati=
c Service=2E It allows this account to use any options and
+  configuration=
 files in any folder, see `Service Account`_=2E
+
+- The folder of the conf=
iguration file is used as the working folder, so
+  relative paths in a con=
figuration file resolve relative to its folder=2E
+
+- openvpn=2Eexe is sta=
rted with these options::
+
+      --log <log file> --config <config file> =
--service <exit event> 0
+      --pull-filter ignore route-method
+
+  ``--=
log-append`` is used instead of ``--log`` if configured=2E The exit event
+=
  is created by the Automatic Service before each start=2E It has a random =
name
+  and only its owner, the service account, has access to it=2E
+
+- W=
hen the service stops, it signals the exit events, which makes the
+  OpenV=
PN processes exit=2E
+
+Configuration files are identified by their file na=
me, like in OpenVPN GUI=2E
+If there are several configuration files with t=
he same file name in
+different subfolders, only the first one found is sta=
rted and an error is
+logged for the others=2E Files in a folder are found =
before those in its
+subfolders=2E
+
+
+Restarting OpenVPN Processes
+-----=
-----------------------
+
+An OpenVPN process that exits, or that cannot be=
 started, is started again
+until the service stops=2E The first attempt is=
 made after 10 seconds=2E The
+delay doubles with each further failure, up =
to 5 minutes=2E It is reset to 10
+seconds once an OpenVPN process has run =
for at least a minute=2E
+
+This also covers the Interactive Service not be=
ing reachable, for example
+while it is restarted=2E The configurations are=
 started again with the next
+attempt after it is available again=2E
+
+
+S=
ervice Account
+---------------
+
+The Automatic Service runs with the virt=
ual service account
+``NT SERVICE\OpenVPNService``=2E The OpenVPN processes=
 it starts run with this
+account too, so configuration files and anything =
they reference, like keys
+and certificates, including those in the Windows=
 certificate store, must be
+readable by it=2E The log folder must be writa=
ble by it=2E
+
+The service refuses to start if it runs with any other acco=
unt=2E OpenVPN
+runs with the same account, so configuration files, scripts=
 and plugins
+would get all privileges of a more privileged account, like L=
ocalSystem, as
+well=2E The service is installed with its required privileg=
es reduced to
+``SeChangeNotifyPrivilege``, which also removes privileges s=
uch as
+``SeImpersonatePrivilege`` from the OpenVPN processes=2E
+
+The Int=
eractive Service lets the account ``NT SERVICE\<ovpn_service_user>``
+use a=
ny options, see `Configuration`_=2E The account the Automatic Service
+chec=
ks for is derived from the same registry value, so both always agree=2E
+
+=

+Configuration
+-------------
+
+The Automatic Service reads its settings =
from the
+``HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN`` registry key, like the In=
teractive
+Service=2E All the following registry values are of the ``REG_SZ=
`` type:
+
+``autostart_config_dir``
+   The autostart configuration folder=
=2E If this value does not exist or is
+   empty, no configurations are sta=
rted=2E The installer sets it to
+   ``install_dir "\config-auto"``=2E
+
+`=
`config_ext``
+   The configuration file extension, without a leading dot; =
defaults to
+   ``"ovpn"``=2E
+
+``log_dir``
+   The folder for the log fil=
es; defaults to ``install_dir "\log"``=2E The
+   installer sets it to ``%P=
rogramData%\OpenVPN\Log`` and makes it writable
+   for the service account=
=2E Each OpenVPN process logs to a file in this
+   folder, named like its =
configuration file, with the extension replaced by
+   ``=2Elog``=2E
+
+``l=
og_append``
+   ``"1"`` to append to existing log files, ``"0"`` (default) =
to truncate
+   them when an OpenVPN process is started=2E
+
+``ovpn_servic=
e_user``
+   The name of the service account, without the ``NT SERVICE\`` p=
refix;
+   defaults to ``"OpenVPNService"``=2E Used by the Interactive Serv=
ice to
+   authorize the Automatic Service and by the Automatic Service to =
check
+   its own account=2E
+
+The values ``exe_path`` and ``priority`` de=
scribed in
+`interactive-service-notes=2Erst` apply too, as the Interactive=
 Service starts
+the OpenVPN processes=2E
+
+The service writes its own mes=
sages to the Windows event log, using the
+``openvpnserv`` event source, th=
e same as the Interactive Service=2E
+
+
+Installation
+------------
+
+The=
 OpenVPN installer registers the service, whether or not the "OpenVPN
+Serv=
ice" feature is selected=2E Without the feature it is disabled, otherwise
+=
it is set to start automatically and started=2E Upgrades keep the start mod=
e
+and running state of the service=2E
+
+The services can also be register=
ed from an elevated command prompt::
+
+      openvpnserv=2Eexe -install [a=
utomatic|interactive]
+
+Without a name, both services are registered=2E A =
service that is registered
+already is left alone=2E The Automatic Service =
is registered with the
+``-automatic`` option, its account, the dependency =
on the Interactive Service
+and its reduced privileges=2E Both services run=
 in a process of their own,
+selected by the ``-automatic`` and ``-interact=
ive`` options=2E
+
+Unlike the Interactive Service, the Automatic Service d=
oes not support the
+``-instance`` option for side-by-side installations=2E=

diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src/openvpnserv/CMakeLists=
=2Etxt
index 35f1efe=2E=2Ef266ce6 100644
--- a/src/openvpnserv/CMakeLists=
=2Etxt
+++ b/src/openvpnserv/CMakeLists=2Etxt
@@ -35,6 +35,7 @@
 add_common=
_options(openvpnserv)
 target_sources(openvpnserv PRIVATE
     common=2Ec
+=
    automatic=2Ec
     interactive=2Ec
     service=2Ec service=2Eh
     va=
lidate=2Ec validate=2Eh
@@ -83,6 +84,7 @@
 if (BUILD_TESTING)
     set(unit=
_tests
         "test_openvpnserv"
+        "test_openvpnserv_automatic"
  =
   )
 
     foreach (test_name ${unit_tests})
@@ -105,4 +107,8 @@
         =
validate=2Ec
         =2E=2E/openvpn/wfp_block=2Ec =2E=2E/openvpn/wfp_block=
=2Eh
     )
+
+    target_sources(test_openvpnserv_automatic PRIVATE
+     =
   common=2Ec
+    )
 endif ()
diff --git a/src/openvpnserv/Makefile=2Eam b=
/src/openvpnserv/Makefile=2Eam
index 447fb10=2E=2Ed3ca665 100644
--- a/src/=
openvpnserv/Makefile=2Eam
+++ b/src/openvpnserv/Makefile=2Eam
@@ -35,6 +35,=
7 @@
 
 openvpnserv_SOURCES =3D \
         common=2Ec \
+	automatic=2Ec \
 =
	interactive=2Ec \
 	service=2Ec service=2Eh \
 	validate=2Ec validate=2Eh =
\
diff --git a/src/openvpnserv/automatic=2Ec b/src/openvpnserv/automatic=2E=
c
new file mode 100644
index 0000000=2E=2Ea113c78
--- /dev/null
+++ b/src/o=
penvpnserv/automatic=2Ec
@@ -0,0 +1,1020 @@
+/*
+ *  OpenVPN -- An applicat=
ion to securely tunnel IP networks
+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based
+ *             session authentication a=
nd key exchange,
+ *             packet encryption, packet authentication, =
and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2026- Open=
VPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you c=
an redistribute it and/or modify
+ *  it under the terms of the GNU General=
 Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Th=
e automatic service starts one OpenVPN process for each configuration
+ * f=
ile found in the autostart config directory and restarts them when they
+ *=
 exit unexpectedly=2E The OpenVPN processes are not started directly, but b=
y
+ * the interactive service, which this service talks to via its named pi=
pe=2E
+ */
+
+#include "service=2Eh"
+
+#include <handleapi=2Eh>
+#include =
<pathcch=2Eh>
+#include <rpc=2Eh>
+#include <sddl=2Eh>
+#include <stdio=2Eh=
>
+#include <stdlib=2Eh>
+
+/** Time we give the interactive service to acc=
ept our connection */
+#define ISERVICE_CONNECT_TIMEOUT 5000 /*ms*/
+
+/**
=
+ * Time we wait before an OpenVPN process is started again, after it exite=
d
+ * or could not be started=2E The delay doubles with each failed attempt=
=2E
+ */
+#define RESTART_DELAY_MIN 10000 /*ms*/
+
+/** Maximum time we wai=
t before an OpenVPN process is started again */
+#define RESTART_DELAY_MAX =
300000 /*ms*/
+
+/** Time after which a running OpenVPN process resets the =
delay to the minimum */
+#define STABLE_RUNTIME 60000 /*ms*/
+
+/** Maximum=
 size of the startup data sent to the interactive service */
+#define START=
UP_DATA_MAX 2048
+
+/** Maximum recursion depth when searching for configur=
ation files */
+#define MAX_RECURSION_DEPTH 32
+
+/** Name of the interacti=
ve service we talk to */
+#define ISERVICE_NAME _L(PACKAGE_NAME) L"ServiceI=
nteractive"
+
+/** The service cannot run without the interactive service, =
so we make it depend on it=2E */
+#define AUTOMATIC_SERVICE_DEPENDENCIES IS=
ERVICE_NAME L"\0\0"
+
+/** The service runs as its own virtual service acco=
unt, which the interactive service trusts */
+#define AUTOMATIC_SERVICE_ACC=
OUNT L"NT SERVICE\\" _L(PACKAGE_NAME) L"Service"
+
+/** The service needs n=
o privileges besides the one every process has */
+#define AUTOMATIC_SERVIC=
E_PRIVILEGES L"SeChangeNotifyPrivilege\0\0"
+
+openvpn_service_t automatic_=
service =3D { automatic,
+                                        _L(PACKAG=
E_NAME) L"Service",
+                                        _L(PACKAGE_NAM=
E) L" Automatic Service",
+                                        AUTOMATI=
C_SERVICE_DEPENDENCIES,
+                                        SERVICE_DE=
MAND_START,
+                                        L"-automatic",
+      =
                                  // cppcheck-suppress unknownMacro ; FP, _=
L after a string literal
+                                        AUTOMATIC=
_SERVICE_ACCOUNT,
+                                        AUTOMATIC_SERVIC=
E_PRIVILEGES };
+
+static SERVICE_STATUS_HANDLE service;
+static SERVICE_ST=
ATUS status =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS };
+static=
 HANDLE exit_event =3D NULL;
+
+static settings_t settings;
+
+/** One Open=
VPN connection, i=2Ee=2E one configuration file */
+typedef struct openvpn_=
process
+{
+    struct openvpn_process *next;
+    WCHAR working_dir[MAX_PA=
TH];
+    WCHAR config_file[MAX_PATH];
+    WCHAR log_file[MAX_PATH];
+    =
HANDLE process;
+    HANDLE exit_event;
+    HANDLE stop_event;
+    HANDLE=
 thread;
+    CRITICAL_SECTION cs;
+} openvpn_process_t;
+
+/** Linked list=
 of OpenVPN connections / configuration files */
+static openvpn_process_t =
*processes =3D NULL;
+
+/**
+ * Add the zero terminated string \p str to \p=
 buf=2E
+ *
+ * If successful, \p pos points to the character after the ter=
minating NUL=2E
+ *
+ * @param buf   string buffer to append to
+ * @param =
size  size of the buffer in wide characters
+ * @param[in,out] pos  positio=
n in the buffer in wide characters
+ * @param str   the string to append
+ =
*
+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+AddSta=
rtupData(PWSTR buf, size_t size, size_t *pos, PCWSTR str)
+{
+    size_t le=
n =3D wcslen(str) + 1;
+
+    if (*pos + len > size)
+    {
+        return=
 FALSE;
+    }
+
+    wmemcpy(buf + *pos, str, len);
+    *pos +=3D len;
+
=
+    return TRUE;
+}
+
+/**
+ * Get the process id of the interactive servi=
ce
+ *
+ * @return the process id, or 0 if the service is not running or on=
 error
+ */
+static DWORD
+GetInteractiveServicePid(void)
+{
+    DWORD pid=
 =3D 0;
+
+    SC_HANDLE scm =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNE=
CT);
+    if (!scm)
+    {
+        return 0;
+    }
+
+    SC_HANDLE svc =
=3D OpenService(scm, ISERVICE_NAME, SERVICE_QUERY_STATUS);
+    if (svc)
+ =
   {
+        SERVICE_STATUS_PROCESS ssp;
+        DWORD needed;
+        i=
f (QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, (LPBYTE)&ssp, sizeof(s=
sp), &needed)
+            && ssp=2EdwCurrentState =3D=3D SERVICE_RUNNING)
=
+        {
+            pid =3D ssp=2EdwProcessId;
+        }
+        Clos=
eServiceHandle(svc);
+    }
+
+    CloseServiceHandle(scm);
+    return pid=
;
+}
+
+/**
+ * Check that the server end of \p pipe is the interactive ser=
vice
+ *
+ * Makes sure we do not send data to, or can be impersonated by, =
a process
+ * which created a pipe with the interactive service's pipe name=
=2E
+ *
+ * @param pipe  the connected pipe handle
+ *
+ * @return BOOL to =
indicate whether the pipe server is the interactive service
+ */
+static BO=
OL
+IsInteractiveServicePipe(HANDLE pipe)
+{
+    ULONG server_pid;
+    if=
 (!GetNamedPipeServerProcessId(pipe, &server_pid))
+    {
+        return F=
ALSE;
+    }
+
+    DWORD iservice_pid =3D GetInteractiveServicePid();
+   =
 return iservice_pid !=3D 0 && server_pid =3D=3D iservice_pid;
+}
+
+/**
+ =
* Connect to the named pipe of the interactive service
+ *
+ * The connecti=
on is only returned if the pipe is served by the
+ * interactive service pr=
ocess=2E
+ *
+ * @param timeout  maximum time in ms to wait for the pipe to=
 become available
+ *
+ * @return pipe handle, or INVALID_HANDLE_VALUE on e=
rror
+ */
+static HANDLE
+ConnectToInteractiveService(DWORD timeout)
+{
+  =
  WCHAR pipe_name[256];
+    ULONGLONG deadline =3D GetTickCount64() + time=
out;
+
+    swprintf(pipe_name, _countof(pipe_name), L"\\\\=2E\\pipe\\" _L(=
PACKAGE) L"%ls\\service", service_instance);
+
+    while (TRUE)
+    {
+  =
      HANDLE pipe =3D CreateFile(pipe_name, GENERIC_READ | GENERIC_WRITE, 0=
, NULL, OPEN_EXISTING, 0, NULL);
+        if (pipe !=3D INVALID_HANDLE_VALU=
E)
+        {
+            DWORD mode =3D PIPE_READMODE_MESSAGE;
+         =
   if (!SetNamedPipeHandleState(pipe, &mode, NULL, NULL))
+            {
+ =
               CloseHandle(pipe);
+                return INVALID_HANDLE_VA=
LUE;
+            }
+            if (!IsInteractiveServicePipe(pipe))
+    =
        {
+                MsgToEventLog(M_ERR, L"Pipe %ls is not served by=
 the interactive service", pipe_name);
+                CloseHandle(pipe);
=
+                SetLastError(ERROR_ACCESS_DENIED);
+                return=
 INVALID_HANDLE_VALUE;
+            }
+            return pipe;
+        }
=
+
+        DWORD error =3D GetLastError();
+        ULONGLONG now =3D GetTi=
ckCount64();
+        if (now >=3D deadline)
+        {
+            SetLas=
tError(error);
+            return INVALID_HANDLE_VALUE;
+        }
+
+    =
    if (error =3D=3D ERROR_PIPE_BUSY)
+        {
+            /* All pipe i=
nstances are busy, wait for one to become available */
+            if (!Wa=
itNamedPipe(pipe_name, (DWORD)(deadline - now)))
+            {
+          =
      return INVALID_HANDLE_VALUE;
+            }
+        }
+        else =
if (error =3D=3D ERROR_FILE_NOT_FOUND)
+        {
+            /* The inter=
active service may not have created the pipe yet */
+            Sleep(50);=

+        }
+        else
+        {
+            SetLastError(error);
+   =
         return INVALID_HANDLE_VALUE;
+        }
+    }
+}
+
+/**
+ * Split=
 off the first line of \p str
+ *
+ * Lines end with "\\n" or "\\r\\n" in e=
rror responses of the interactive service=2E
+ *
+ * @param str  the string=
 to split, its first line is zero terminated in place
+ *
+ * @return the s=
tart of the next line, or NULL if there is none
+ */
+static PWSTR
+SplitLi=
ne(PWSTR str)
+{
+    PWSTR eol =3D wcschr(str, L'\n');
+    if (!eol)
+   =
 {
+        return NULL;
+    }
+
+    *eol =3D L'\0';
+    if (eol > str &=
& eol[-1] =3D=3D L'\r')
+    {
+        eol[-1] =3D L'\0';
+    }
+
+    re=
turn eol + 1;
+}
+
+/**
+ * Parse the response of the interactive service
+=
 *
+ * The response is a three line string, with the error code in the firs=
t,
+ * the process id in the second if OpenVPN was started successfully and=

+ * a message in the third line=2E
+ *
+ * @param response  the zero termi=
nated response, which is modified
+ * @param error     receives the error c=
ode returned by the service
+ * @param pid       receives the process id of=
 the OpenVPN process
+ *
+ * @return BOOL to indicate success or failure
+ =
*/
+static BOOL
+ParseInteractiveServiceResponse(PWSTR response, PDWORD err=
or, PDWORD pid)
+{
+    PWSTR pid_line =3D SplitLine(response);
+    if (!p=
id_line)
+    {
+        SetLastError(ERROR_INVALID_DATA);
+        return =
FALSE;
+    }
+    SplitLine(pid_line);
+
+    PWSTR end;
+    *error =3D w=
cstoul(response, &end, 16);
+    if (end =3D=3D response || *end !=3D L'\0'=
)
+    {
+        SetLastError(ERROR_INVALID_DATA);
+        return FALSE;
=
+    }
+
+    *pid =3D 0;
+    if (*error =3D=3D 0)
+    {
+        *pid =
=3D wcstoul(pid_line, &end, 16);
+        if (end =3D=3D pid_line || *end !=
=3D L'\0')
+        {
+            SetLastError(ERROR_INVALID_DATA);
+     =
       return FALSE;
+        }
+    }
+
+    return TRUE;
+}
+
+/**
+ * Re=
ad the response of the interactive service from the pipe
+ *
+ * @param pip=
e   the pipe to read the response from
+ * @param error  receives the error=
 code returned by the service
+ * @param pid    receives the process id of =
the OpenVPN process
+ *
+ * @return BOOL to indicate success or failure
+ *=
/
+static BOOL
+ReadInteractiveServiceResponse(HANDLE pipe, PDWORD error, P=
DWORD pid)
+{
+    WCHAR buf[1024];
+    DWORD bytes;
+
+    if (!ReadFile(=
pipe, buf, sizeof(buf) - sizeof(buf[0]), &bytes, NULL))
+    {
+        ret=
urn FALSE;
+    }
+
+    buf[bytes / sizeof(buf[0])] =3D L'\0';
+
+    retu=
rn ParseInteractiveServiceResponse(buf, error, pid);
+}
+
+/**
+ * Build th=
e path of the log file of a configuration file
+ *
+ * The log file is name=
d like the configuration file \p name, with its
+ * extension replaced by "=
=2Elog", and is placed in \p log_dir=2E
+ *
+ * @param log_file  buffer tha=
t receives the log file path
+ * @param size      size of the buffer in wid=
e characters
+ * @param log_dir   the directory the log file is placed in
+=
 * @param name      the file name of the configuration file
+ *
+ * @return=
 BOOL to indicate success or failure
+ */
+static BOOL
+GetLogFilePath(PWST=
R log_file, size_t size, PCWSTR log_dir, PCWSTR name)
+{
+    WCHAR log_nam=
e[MAX_PATH];
+    PCWSTR dot =3D wcsrchr(name, L'=2E');
+    int len =3D do=
t ? (int)(dot - name) : (int)(wcslen(name));
+
+    return swprintf(log_nam=
e, _countof(log_name), L"%=2E*ls=2Elog", len, name) >=3D 0
+           && P=
athCchCombine(log_file, size, log_dir, log_name) =3D=3D S_OK;
+}
+
+/**
+ *=
 Create the event used to signal an OpenVPN process to exit
+ *
+ * The nam=
e of the event is random, so others cannot create it in advance
+ * and kee=
p it under their control=2E Should the name exist already anyway,
+ * anoth=
er one is tried=2E Only the owner of the event has access to it=2E
+ * Open=
VPN runs with the same account as this service, so it can open the
+ * even=
t by its name=2E
+ *
+ * @param name  buffer that receives the name of the =
event
+ * @param size  size of the buffer in wide characters
+ *
+ * @retur=
n the event handle, or INVALID_HANDLE_VALUE on error
+ */
+static HANDLE
+C=
reateExitEvent(PWSTR name, size_t size)
+{
+    SECURITY_ATTRIBUTES sa =3D =
{ =2EnLength =3D sizeof(sa) };
+    HANDLE event =3D INVALID_HANDLE_VALUE;
=
+
+    if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(
+        =
    L"D:P(A;;GA;;;OW)", SDDL_REVISION_1, &sa=2ElpSecurityDescriptor, NULL))=

+    {
+        return event;
+    }
+
+    const int max_tries =3D 3;
+  =
  for (int tries =3D 0; tries < max_tries; tries++)
+    {
+        UUID uu=
id;
+        RPC_WSTR uuid_str;
+        if (UuidCreate(&uuid) !=3D RPC_S_O=
K || UuidToStringW(&uuid, &uuid_str) !=3D RPC_S_OK)
+        {
+           =
 break;
+        }
+        swprintf(name, size, _L(PACKAGE) L"_exit_%ls", =
(PWSTR)uuid_str);
+        RpcStringFreeW(&uuid_str);
+
+        event =3D =
CreateEvent(&sa, TRUE, FALSE, name);
+        if (event && GetLastError() !=
=3D ERROR_ALREADY_EXISTS)
+        {
+            break;
+        }
+      =
  CloseHandleEx(&event);
+    }
+    LocalFree(sa=2ElpSecurityDescriptor);
=
+
+    if (event =3D=3D INVALID_HANDLE_VALUE)
+    {
+        MsgToEventLog=
(M_ERR, L"Could not create exit event=2E");
+    }
+
+    return event;
+}
=
+
+/**
+ * Start an OpenVPN process for a configuration file
+ *
+ * Connec=
ts to the interactive service, sends the startup data and reads
+ * back th=
e process id of the started OpenVPN process=2E
+ *
+ * @param p  the proces=
s to start
+ *
+ * @return BOOL to indicate success or failure
+ */
+static=
 BOOL
+StartProcess(openvpn_process_t *p)
+{
+    WCHAR cmdline[STARTUP_DAT=
A_MAX];
+    WCHAR startup_data[STARTUP_DATA_MAX];
+    WCHAR exit_event_na=
me[MAX_PATH];
+    HANDLE pipe =3D INVALID_HANDLE_VALUE;
+    size_t pos =
=3D 0;
+    DWORD error, pid, written;
+    BOOL ret =3D FALSE;
+
+    /* e=
ach OpenVPN process gets a new exit event */
+    HANDLE event =3D CreateEx=
itEvent(exit_event_name, _countof(exit_event_name));
+    if (event =3D=3D =
INVALID_HANDLE_VALUE)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not c=
reate exit event for config %ls", p->config_file);
+        return FALSE;
+=
    }
+
+    const WCHAR *log_option =3D settings=2Eappend ? L"--log-append=
" : L"--log";
+    int n =3D swprintf(cmdline, _countof(cmdline),
+        =
             L"%ls \"%ls\" --config \"%ls\" --service \"%ls\" 0 --pull-filt=
er ignore route-method",
+                     log_option, p->log_file, p->=
config_file, exit_event_name);
+    if (n < 0)
+    {
+        MsgToEventLo=
g(M_ERR, L"Command line too long for config %ls", p->config_file);
+       =
 goto out;
+    }
+
+    /* working dir + \0 + options + \0 + password + \0=
 */
+    if (!AddStartupData(startup_data, _countof(startup_data), &pos, p-=
>working_dir)
+        || !AddStartupData(startup_data, _countof(startup_da=
ta), &pos, cmdline)
+        || !AddStartupData(startup_data, _countof(star=
tup_data), &pos, L""))
+    {
+        MsgToEventLog(M_ERR, L"Startup data =
too long for config %ls", p->config_file);
+        goto out;
+    }
+
+   =
 pipe =3D ConnectToInteractiveService(ISERVICE_CONNECT_TIMEOUT);
+    if (p=
ipe =3D=3D INVALID_HANDLE_VALUE)
+    {
+        MsgToEventLog(M_SYSERR, L"=
Could not connect to the interactive service");
+        goto out;
+    }
+=

+    if (!WriteFile(pipe, startup_data, (DWORD)(pos * sizeof(startup_data[=
0])), &written, NULL))
+    {
+        MsgToEventLog(M_SYSERR, L"Could not =
send startup data to interactive service");
+        goto out;
+    }
+
+  =
  if (!ReadInteractiveServiceResponse(pipe, &error, &pid))
+    {
+        =
MsgToEventLog(M_SYSERR, L"Could not read response from iservice");
+       =
 goto out;
+    }
+
+    if (error !=3D 0)
+    {
+        MsgToEventLog(M_=
ERR, L"Error starting openvpn process: %lu", error);
+        goto out;
+  =
  }
+
+    /*
+     * The interactive service restricts access to the OpenV=
PN process=2E It does
+     * not grant PROCESS_QUERY_LIMITED_INFORMATION, =
but PROCESS_QUERY_INFORMATION=2E
+     */
+    HANDLE process =3D OpenProce=
ss(SYNCHRONIZE | PROCESS_QUERY_INFORMATION, FALSE, pid);
+    if (!process)=

+    {
+        MsgToEventLog(M_SYSERR, L"Could not open OpenVPN process, =
PID %lu", pid);
+        goto out;
+    }
+
+    EnterCriticalSection(&p->c=
s);
+    CloseHandleEx(&p->process);
+    CloseHandleEx(&p->exit_event);
+ =
   p->process =3D process;
+    p->exit_event =3D event;
+    event =3D NUL=
L;
+    LeaveCriticalSection(&p->cs);
+
+    MsgToEventLog(M_INFO, L"Starte=
d openvpn process %lu for config %ls", pid, p->config_file);
+    ret =3D T=
RUE;
+
+out:
+    /*
+     * An OpenVPN process may have been started, even=
 if we could not get a
+     * handle of it or did not receive the response=
=2E Make sure it exits, as
+     * it would not be monitored nor stopped ot=
herwise=2E
+     */
+    if (!ret && event)
+    {
+        SetEvent(event)=
;
+    }
+    CloseHandleEx(&pipe);
+    CloseHandleEx(&event);
+    return=
 ret;
+}
+
+/**
+ * Signal an OpenVPN process to exit
+ *
+ * @param p  the=
 process to signal
+ */
+static void
+SignalProcess(openvpn_process_t *p)
+=
{
+    EnterCriticalSection(&p->cs);
+    if (p->process && WaitForSingleOb=
ject(p->process, 0) =3D=3D WAIT_TIMEOUT
+        && !SetEvent(p->exit_event=
))
+    {
+        DWORD pid =3D GetProcessId(p->process);
+        MsgToEv=
entLog(M_SYSERR, L"Error signalling PID %lu to exit", pid);
+    }
+    Lea=
veCriticalSection(&p->cs);
+}
+
+/**
+ * Run the OpenVPN process for a conf=
ig and restart it when it exits
+ *
+ * Starting the process is retried unt=
il the service stops=2E The delay
+ * between the attempts grows when a pro=
cess cannot be started or exits
+ * right away, so a broken config does not=
 keep the system busy=2E
+ *
+ * @param process  the process to run
+ */
+s=
tatic DWORD WINAPI
+MonitorProcess(LPVOID process)
+{
+    openvpn_process_=
t *p =3D process;
+    DWORD delay =3D RESTART_DELAY_MIN;
+
+    while (TRU=
E)
+    {
+        ULONGLONG started =3D GetTickCount64();
+        if (Sta=
rtProcess(p))
+        {
+            HANDLE handles[2];
+
+            Ent=
erCriticalSection(&p->cs);
+            handles[0] =3D p->stop_event;
+    =
        handles[1] =3D p->process;
+            DWORD pid =3D GetProcessId(=
p->process);
+            LeaveCriticalSection(&p->cs);
+
+            if (=
WaitForMultipleObjects(2, handles, FALSE, INFINITE) =3D=3D WAIT_OBJECT_0)
+=
            {
+                break;
+            }
+
+            MsgToEv=
entLog(M_INFO, L"OpenVPN process %lu for config %ls has exited", pid,
+    =
                      p->config_file);
+
+            /* a process that ran=
 for a while did not fail right away */
+            if (GetTickCount64() -=
 started >=3D STABLE_RUNTIME)
+            {
+                delay =3D RES=
TART_DELAY_MIN;
+            }
+        }
+
+        MsgToEventLog(M_INFO, =
L"Starting config %ls again in %lu sec", p->config_file,
+                 =
     delay / 1000);
+
+        if (WaitForSingleObject(p->stop_event, delay=
) =3D=3D WAIT_OBJECT_0)
+        {
+            break;
+        }
+
+      =
  delay =3D min(delay * 2, RESTART_DELAY_MAX);
+    }
+
+    return NO_ERRO=
R;
+}
+
+/**
+ * Find a process entry with a config file named \p name
+ *
=
+ * @param name  the file name of the config, without the path
+ *
+ * @ret=
urn the process entry, or NULL if there is none
+ */
+static openvpn_proces=
s_t *
+FindProcessByName(PCWSTR name)
+{
+    for (openvpn_process_t *p =3D=
 processes; p; p =3D p->next)
+    {
+        PCWSTR p_name =3D wcsrchr(p->=
config_file, L'\\');
+        p_name =3D p_name ? p_name + 1 : p->config_fi=
le;
+        if (_wcsicmp(p_name, name) =3D=3D 0)
+        {
+            r=
eturn p;
+        }
+    }
+    return NULL;
+}
+
+/**
+ * Create a process=
 entry for \p config_file and start the thread
+ * that runs the OpenVPN pr=
ocess for it=2E
+ *
+ * A config with the same file name as one that was fo=
und before is ignored,
+ * as both would use the same log file=2E This is i=
n line with how openvpn-gui
+ * handles duplicates=2E
+ *
+ * @param workin=
g_dir  the directory the config file is in
+ * @param config_file  path of =
the configuration file
+ */
+static void
+StartConfig(PCWSTR working_dir, P=
CWSTR config_file)
+{
+    PCWSTR name =3D wcsrchr(config_file, L'\\');
+  =
  name =3D name ? name + 1 : config_file;
+
+    openvpn_process_t *dup =3D=
 FindProcessByName(name);
+    if (dup)
+    {
+        MsgToEventLog(M_ERR=
, L"Config %ls has the same file name as %ls, ignoring it",
+              =
        config_file, dup->config_file);
+        return;
+    }
+
+    open=
vpn_process_t *p =3D calloc(1, sizeof(*p));
+    if (!p)
+    {
+        Ms=
gToEventLog(M_ERR, L"Out of memory starting openvpn for %ls", config_file);=

+        return;
+    }
+
+    if (!GetLogFilePath(p->log_file, _countof(p=
->log_file), settings=2Elog_dir, name))
+    {
+        MsgToEventLog(M_ERR=
, L"Error starting openvpn for %ls", config_file);
+        free(p);
+     =
   return;
+    }
+
+    p->stop_event =3D CreateEvent(NULL, TRUE, FALSE, N=
ULL);
+    if (!p->stop_event)
+    {
+        MsgToEventLog(M_SYSERR, L"Er=
ror starting openvpn for %ls", config_file);
+        free(p);
+        ret=
urn;
+    }
+
+    wcsncpy(p->working_dir, working_dir, _countof(p->working=
_dir) - 1);
+    wcsncpy(p->config_file, config_file, _countof(p->config_fi=
le) - 1);
+    InitializeCriticalSection(&p->cs);
+
+    p->next =3D proces=
ses;
+    processes =3D p;
+
+    p->thread =3D CreateThread(NULL, 0, Monit=
orProcess, p, 0, NULL);
+    if (!p->thread)
+    {
+        MsgToEventLog(=
M_SYSERR, L"Could not create monitoring thread for %ls", config_file);
+   =
 }
+}
+
+/**
+ * Recursively find configuration files in \p dir
+ * and run=
 OpenVPN for each of them=2E
+ *
+ * @param dir   the directory to search
+=
 * @param level the current recursion depth
+ */
+static void
+StartConfigs=
InDir(PCWSTR dir, DWORD level)
+{
+    WCHAR ext_pattern[_countof(settings=
=2Eext_string) + 2];
+    WCHAR pattern[MAX_PATH];
+    WCHAR path[MAX_PATH=
];
+    WIN32_FIND_DATA find_data;
+    HANDLE find;
+
+    if (level > MAX=
_RECURSION_DEPTH)
+    {
+        MsgToEventLog(M_INFO, L"Maximum recursion=
 depth reached=2E Ignoring config dir %ls", dir);
+        return;
+    }
+=

+    swprintf(ext_pattern, _countof(ext_pattern), L"*=2E%ls", settings=2Ee=
xt_string);
+
+    /* Run configs in dir */
+    if (PathCchCombine(pattern=
, _countof(pattern), dir, ext_pattern) =3D=3D S_OK)
+    {
+        find =
=3D FindFirstFile(pattern, &find_data);
+        if (find !=3D INVALID_HAND=
LE_VALUE)
+        {
+            do
+            {
+                BOOL d=
irectory =3D (find_data=2EdwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) !=3D=
 0;
+                if (!directory && PathCchCombine(path, _countof(path),=
 dir, find_data=2EcFileName) =3D=3D S_OK)
+                {
+             =
       StartConfig(dir, path);
+                }
+            } while (Fin=
dNextFile(find, &find_data));
+
+            FindClose(find);
+        }
+ =
   }
+
+    if (PathCchCombine(pattern, _countof(pattern), dir, L"*") !=3D =
S_OK)
+    {
+        return;
+    }
+
+    /* Try to recurse */
+    find =
=3D FindFirstFile(pattern, &find_data);
+    if (find !=3D INVALID_HANDLE_V=
ALUE)
+    {
+        do
+        {
+            if (find_data=2EdwFileAttr=
ibutes & FILE_ATTRIBUTE_DIRECTORY
+                && wcscmp(find_data=2EcF=
ileName, L"=2E") !=3D 0
+                && wcscmp(find_data=2EcFileName, L=
"=2E=2E") !=3D 0
+                && PathCchCombine(path, _countof(path), d=
ir, find_data=2EcFileName) =3D=3D S_OK)
+            {
+                Sta=
rtConfigsInDir(path, level + 1);
+            }
+        } while (FindNextF=
ile(find, &find_data));
+
+        FindClose(find);
+    }
+}
+
+/**
+ * St=
art an OpenVPN process for every config found in the autostart
+ * config d=
irectory=2E
+ *
+ * Having nothing to start is not an error=2E Like an auto=
start config
+ * directory without any config files in it, it leaves the se=
rvice running
+ * without any processes=2E
+ */
+static void
+StartAllProce=
sses(void)
+{
+    /* starting configs automatically is optional */
+    if=
 (settings=2Eautostart_config_dir[0] =3D=3D L'\0')
+    {
+        MsgToEve=
ntLog(M_INFO, L"No autostart config directory configured");
+        return=
;
+    }
+
+    DWORD attr =3D GetFileAttributes(settings=2Eautostart_confi=
g_dir);
+    if (attr =3D=3D INVALID_FILE_ATTRIBUTES || !(attr & FILE_ATTRI=
BUTE_DIRECTORY))
+    {
+        MsgToEventLog(M_ERR, L"Autostart config di=
rectory does not exist at %ls",
+                      settings=2Eautostart=
_config_dir);
+        return;
+    }
+
+    StartConfigsInDir(settings=2Ea=
utostart_config_dir, 0);
+
+    if (!processes)
+    {
+        MsgToEventL=
og(M_INFO, L"No configs found in %ls", settings=2Eautostart_config_dir);
+ =
   }
+}
+
+/**
+ * Stop all OpenVPN processes and wait for their monitoring=
 threads
+ */
+static void
+StopAllProcesses(void)
+{
+    for (openvpn_pro=
cess_t *p =3D processes; p; p =3D p->next)
+    {
+        SetEvent(p->stop=
_event);
+    }
+
+    for (openvpn_process_t *p =3D processes; p; p =3D p-=
>next)
+    {
+        if (p->thread)
+        {
+            WaitForSingle=
Object(p->thread, INFINITE);
+            CloseHandleEx(&p->thread);
+     =
   }
+    }
+
+    for (openvpn_process_t *p =3D processes; p; p =3D p->nex=
t)
+    {
+        SignalProcess(p);
+    }
+}
+
+/**
+ * Free the list of =
processes
+ */
+static void
+FreeAllProcesses(void)
+{
+    openvpn_process=
_t *p =3D processes;
+
+    while (p)
+    {
+        openvpn_process_t *ne=
xt =3D p->next;
+
+        CloseHandleEx(&p->process);
+        CloseHandle=
Ex(&p->exit_event);
+        CloseHandleEx(&p->stop_event);
+        Delete=
CriticalSection(&p->cs);
+        free(p);
+
+        p =3D next;
+    }
+
=
+    processes =3D NULL;
+}
+
+
+/**
+ * Check that the service runs under =
its virtual service account
+ *
+ * The interactive service lets NT SERVICE=
\\\<ovpn_service_user\> start OpenVPN
+ * with any options=2E Running as a =
more privileged account, like LocalSystem,
+ * would run all configs with t=
hese elevated privileges=2E So, rather refuse
+ * to run as any other accou=
nt, in case an admin is adventurous=2E
+ *
+ * @param s  the settings, with=
 the name of the service account
+ *
+ * @return BOOL to indicate whether w=
e run as the service account
+ */
+static BOOL
+IsRunningAsServiceAccount(c=
onst settings_t *s)
+{
+    BOOL ret =3D FALSE;
+
+    /*
+     * A TOKEN_U=
SER with room for the largest possible SID after it=2E The sid
+     * memb=
er alone is used for the SID of the account, as it is aligned=2E
+     */
+=
    struct
+    {
+        TOKEN_USER token_user;
+        BYTE sid[SECURIT=
Y_MAX_SID_SIZE];
+    } token_user_info, account_info;
+
+    WCHAR account=
[MAX_NAME];
+    DWORD sid_size =3D sizeof(account_info=2Esid);
+    WCHAR =
domain[MAX_NAME];
+    DWORD domain_size =3D _countof(domain);
+    SID_NAM=
E_USE use;
+
+    swprintf(account, _countof(account), L"NT SERVICE\\%ls", =
s->ovpn_service_user);
+    if (!LookupAccountName(NULL, account, account_i=
nfo=2Esid, &sid_size, domain, &domain_size, &use))
+    {
+        MsgToEve=
ntLog(M_SYSERR, L"Could not look up account %ls", account);
+        return=
 FALSE;
+    }
+
+    HANDLE token;
+    if (!OpenProcessToken(GetCurrentPr=
ocess(), TOKEN_QUERY, &token))
+    {
+        MsgToEventLog(M_SYSERR, L"Co=
uld not open process token");
+        return FALSE;
+    }
+
+    DWORD le=
n;
+    BOOL got_user =3D
+        GetTokenInformation(token, TokenUser, &t=
oken_user_info, sizeof(token_user_info), &len);
+    CloseHandle(token);
+ =
   if (!got_user)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not get t=
oken user");
+        return FALSE;
+    }
+
+    ret =3D EqualSid(token_us=
er_info=2Etoken_user=2EUser=2ESid, account_info=2Esid);
+    if (!ret)
+   =
 {
+        MsgToEventLog(M_ERR, L"Service must run as %ls, refusing to sta=
rt", account);
+    }
+
+    return ret;
+}
+
+
+static DWORD WINAPI
+Servi=
ceCtrlAutomatic(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
+{
+=
    SERVICE_STATUS *svc_status =3D ctx;
+    switch (ctrl_code)
+    {
+   =
     case SERVICE_CONTROL_STOP:
+            svc_status->dwCurrentState =3D=
 SERVICE_STOP_PENDING;
+            /* threads may be connecting to the int=
eractive service */
+            svc_status->dwWaitHint =3D ISERVICE_CONNEC=
T_TIMEOUT + 1000;
+            ReportStatusToSCMgr(service, svc_status);
+ =
           if (exit_event)
+            {
+                SetEvent(exit_ev=
ent);
+            }
+            return NO_ERROR;
+
+        case SERVICE_=
CONTROL_INTERROGATE:
+            return NO_ERROR;
+
+        default:
+   =
         return ERROR_CALL_NOT_IMPLEMENTED;
+    }
+}
+
+
+VOID WINAPI
+Ser=
viceStartAutomatic(DWORD dwArgc, LPWSTR *lpszArgv)
+{
+    DWORD error =3D =
NO_ERROR;
+
+    service =3D RegisterServiceCtrlHandlerEx(automatic_service=
=2Ename, ServiceCtrlAutomatic, &status);
+    if (!service)
+    {
+       =
 return;
+    }
+
+    status=2EdwCurrentState =3D SERVICE_START_PENDING;
+=
    status=2EdwServiceSpecificExitCode =3D NO_ERROR;
+    status=2EdwWin32E=
xitCode =3D NO_ERROR;
+    status=2EdwWaitHint =3D 3000;
+
+    if (!Report=
StatusToSCMgr(service, &status))
+    {
+        MsgToEventLog(M_ERR, L"Rep=
ortStatusToSCMgr SERVICE_START_PENDING failed");
+        goto finish;
+   =
 }
+
+    /*
+     * Create our exit event
+     * This event is initially =
created in the non-signaled state=2E It will
+     * transition to the sign=
aled state when we have received a terminate
+     * signal from the Servic=
e Control Manager=2E
+     */
+    exit_event =3D CreateEvent(NULL, TRUE, F=
ALSE, NULL);
+    if (!exit_event)
+    {
+        error =3D MsgToEventLog(=
M_SYSERR, L"CreateEvent for exit event failed");
+        goto finish;
+   =
 }
+
+    /* Read settings from registry */
+    error =3D GetOpenvpnSettin=
gs(&settings);
+    if (error !=3D ERROR_SUCCESS)
+    {
+        goto fini=
sh;
+    }
+
+    if (!IsRunningAsServiceAccount(&settings))
+    {
+      =
  error =3D ERROR_ACCESS_DENIED;
+        goto finish;
+    }
+
+    StartA=
llProcesses();
+
+    status=2EdwCurrentState =3D SERVICE_RUNNING;
+    sta=
tus=2EdwWaitHint =3D 0;
+    if (!ReportStatusToSCMgr(service, &status))
+ =
   {
+        MsgToEventLog(M_ERR, L"ReportStatusToSCMgr SERVICE_RUNNING fa=
iled");
+        goto finish;
+    }
+
+    if (WaitForSingleObject(exit_ev=
ent, INFINITE) !=3D WAIT_OBJECT_0)
+    {
+        MsgToEventLog(M_ERR, L"w=
ait for shutdown signal failed");
+    }
+
+finish:
+    StopAllProcesses()=
;
+    FreeAllProcesses();
+
+    CloseHandleEx(&exit_event);
+
+    status=
=2EdwCurrentState =3D SERVICE_STOPPED;
+    status=2EdwWin32ExitCode =3D er=
ror;
+    ReportStatusToSCMgr(service, &status);
+}
diff --git a/src/openvp=
nserv/common=2Ec b/src/openvpnserv/common=2Ec
index 671ddde=2E=2Ebd6a50f 10=
0644
--- a/src/openvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -=
116,6 +116,14 @@
         goto out;
     }
 
+    /* an empty autostart con=
fig dir means configs are not started automatically */
+    error =3D GetRe=
gString(key, L"autostart_config_dir", s->autostart_config_dir,
+           =
              sizeof(s->autostart_config_dir), L"");
+    if (error !=3D ER=
ROR_SUCCESS)
+    {
+        goto out;
+    }
+
     swprintf(default_value=
, _countof(default_value), L"%ls\\bin\\", install_path);
     error =3D Get=
RegString(key, L"bin_dir", s->bin_dir, sizeof(s->bin_dir), default_value);
=
     if (error !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s->bin_dir,=
 _countof(s->bin_dir)))
@@ -123,7 +131,7 @@
         goto out;
     }
 
-  =
  error =3D GetRegString(key, L"config_ext", s->ext_string, sizeof(s->ext_s=
tring), L"=2Eovpn");
+    error =3D GetRegString(key, L"config_ext", s->ext=
_string, sizeof(s->ext_string), L"ovpn");
     if (error !=3D ERROR_SUCCESS=
)
     {
         goto out;
@@ -292,6 +300,19 @@
     return error;
 }
 
+v=
oid
+CloseHandleEx(LPHANDLE handle)
+{
+    if (handle)
+    {
+        if =
(*handle && *handle !=3D INVALID_HANDLE_VALUE)
+        {
+            Clos=
eHandle(*handle);
+        }
+        *handle =3D INVALID_HANDLE_VALUE;
+  =
  }
+}
+
 wchar_t *
 utf8to16_size(const char *utf8, int size)
 {
diff --gi=
t a/src/openvpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index=
 81205d6=2E=2E9d0c402 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/sr=
c/openvpnserv/interactive=2Ec
@@ -49,7 +49,7 @@
 #define ERROR_MESSAGE_TYPE=
    0x20000003
 
 static SERVICE_STATUS_HANDLE service;
-static SERVICE_STA=
TUS status =3D { =2EdwServiceType =3D SERVICE_WIN32_SHARE_PROCESS };
+stati=
c SERVICE_STATUS status =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN_PROCES=
S };
 static HANDLE exit_event =3D NULL;
 static settings_t settings;
 stat=
ic HANDLE rdns_semaphore =3D NULL;
@@ -58,9 +58,14 @@
 #define TUN_IOCTL_RE=
GISTER_RINGS \
     CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DAT=
A | FILE_WRITE_DATA)
 
-openvpn_service_t interactive_service =3D { interac=
tive, _L(PACKAGE_NAME) L"ServiceInteractive",
+openvpn_service_t interactiv=
e_service =3D { interactive,
+                                          _L(=
PACKAGE_NAME) L"ServiceInteractive",
                                      =
     _L(PACKAGE_NAME) L" Interactive Service",
-                           =
               SERVICE_DEPENDENCIES, SERVICE_AUTO_START };
+               =
                           SERVICE_DEPENDENCIES,
+                         =
                 SERVICE_AUTO_START,
+                                     =
     L"-interactive",
+                                          NULL,
+   =
                                       NULL };
 
 
 typedef struct
@@ -172,=
18 +177,6 @@
     return data;
 }
 
-
-static HANDLE
-CloseHandleEx(LPHANDL=
E handle)
-{
-    if (handle && *handle && *handle !=3D INVALID_HANDLE_VALU=
E)
-    {
-        CloseHandle(*handle);
-        *handle =3D INVALID_HANDL=
E_VALUE;
-    }
-    return INVALID_HANDLE_VALUE;
-}
-
 static HANDLE
 Init=
Overlapped(LPOVERLAPPED overlapped)
 {
@@ -4107,13 +4100,6 @@
 }
 
 
-VOID =
WINAPI
-ServiceStartInteractiveOwn(DWORD dwArgc, LPWSTR *lpszArgv)
-{
-    =
status=2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS;
-    ServiceStartInte=
ractive(dwArgc, lpszArgv);
-}
-
 /**
  * Clean up remains of previous sessi=
ons in registry=2E These remains can
  * happen with unclean shutdowns or c=
rashes and would interfere with
diff --git a/src/openvpnserv/service=2Ec b/=
src/openvpnserv/service=2Ec
index 2913f63=2E=2E292816c 100644
--- a/src/ope=
nvpnserv/service=2Ec
+++ b/src/openvpnserv/service=2Ec
@@ -52,22 +52,52 @@
=
     return res;
 }
 
+/**
+ * Restrict a service to the privileges it actu=
ally needs
+ *
+ * Also gives the service its own SID, which is required fo=
r running it
+ * as a virtual service account=2E
+ *
+ * @param service    =
 handle of the service, with SERVICE_CHANGE_CONFIG access
+ * @param privil=
eges  double zero terminated list of privilege names
+ *
+ * @return BOOL t=
o indicate success or failure
+ */
+static BOOL
+SetServicePrivileges(SC_HA=
NDLE service, WCHAR *privileges)
+{
+    SERVICE_SID_INFO sid_info =3D { SE=
RVICE_SID_TYPE_UNRESTRICTED };
+    SERVICE_REQUIRED_PRIVILEGES_INFO priv_i=
nfo =3D { privileges };
+
+    return ChangeServiceConfig2(service, SERVICE=
_CONFIG_SERVICE_SID_INFO, &sid_info)
+           && ChangeServiceConfig2(se=
rvice, SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO, &priv_info);
+}
+
+/**
+ * =
Install the services
+ *
+ * A service that is installed already counts as =
success, so this can be
+ * run repeatedly, e=2Eg=2E by the MSI installer a=
fter an upgrade=2E
+ *
+ * @param type  the service to install, or _service=
_max for all of them
+ *
+ * @return the number of services that could not =
be installed
+ */
 static int
-CmdInstallServices(void)
+CmdInstallServices=
(openvpn_service_type type)
 {
     SC_HANDLE svc_ctl_mgr;
+    WCHAR exe_p=
ath[MAX_PATH];
     WCHAR path[512];
-    int i, ret =3D _service_max;
+   =
 int ret =3D 0;
 
-    if (GetModuleFileName(NULL, path + 1, _countof(path)=
 - 2) =3D=3D 0)
+    DWORD len =3D GetModuleFileName(NULL, exe_path, _count=
of(exe_path));
+    if (len =3D=3D 0 || len =3D=3D _countof(exe_path))
    =
 {
         wprintf(L"Unable to install service - %ls\n", GetLastErrorText(=
));
         return 1;
     }
 
-    path[0] =3D L'\"';
-    wcscat_s(path,=
 _countof(path), L"\"");
-
     svc_ctl_mgr =3D OpenSCManager(NULL, NULL, S=
C_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE);
     if (svc_ctl_mgr =3D=3D=
 NULL)
     {
@@ -75,22 +105,60 @@
         return 1;
     }
 
-    for (i =
=3D 0; i < _service_max; i++)
+    for (int i =3D 0; i < _service_max; i++)=

     {
-        SC_HANDLE service =3D CreateService(
-            svc_ctl_=
mgr, openvpn_service[i]=2Ename, openvpn_service[i]=2Edisplay_name,
-       =
     SERVICE_QUERY_STATUS, SERVICE_WIN32_SHARE_PROCESS, openvpn_service[i]=
=2Estart_type,
-            SERVICE_ERROR_NORMAL, path, NULL, NULL, openvpn=
_service[i]=2Edependencies, NULL, NULL);
-        if (service)
+        if =
(type !=3D _service_max && type !=3D (openvpn_service_type)i)
         {
- =
           wprintf(L"%ls installed=2E\n", openvpn_service[i]=2Edisplay_name=
);
-            CloseServiceHandle(service);
-            --ret;
+         =
   continue;
         }
-        else
+
+        openvpn_service_t *ovpn_sv=
c =3D &openvpn_service[i];
+
+        /* each service runs in its own proce=
ss, selected by the arguments */
+        swprintf(path, _countof(path), L"=
\"%ls\"%ls%ls", exe_path,
+                 ovpn_svc->arguments ? L" " : L"=
", ovpn_svc->arguments ? ovpn_svc->arguments : L"");
+
+        /*
+       =
  * A service that was just deleted stays marked for deletion until
+      =
   * all handles to it are closed, e=2Eg=2E by an open services=2Emsc=2E
+ =
        */
+        int tries =3D 10;
+        SC_HANDLE service;
+        =
while (!(service =3D CreateService(svc_ctl_mgr, ovpn_svc->name, ovpn_svc->d=
isplay_name,
+                                         SERVICE_QUERY_STATUS=
 | SERVICE_CHANGE_CONFIG | DELETE,
+                                       =
  SERVICE_WIN32_OWN_PROCESS, ovpn_svc->start_type,
+                       =
                  SERVICE_ERROR_NORMAL, path, NULL, NULL,
+                =
                         ovpn_svc->dependencies, ovpn_svc->account, NULL))
=
+               && GetLastError() =3D=3D ERROR_SERVICE_MARKED_FOR_DELETE &&=
 --tries)
         {
+            Sleep(1000);
+        }
+
+        if (!s=
ervice)
+        {
+            if (GetLastError() =3D=3D ERROR_SERVICE_EXI=
STS)
+            {
+                wprintf(L"%ls is installed already=2E\=
n", ovpn_svc->display_name);
+                continue;
+            }
    =
         wprintf(L"CreateService failed - %ls\n", GetLastErrorText());
+   =
         ++ret;
+            continue;
         }
+
+        if (ovpn_svc->=
required_privileges
+            && !SetServicePrivileges(service, ovpn_svc=
->required_privileges))
+        {
+            /* do not leave a service w=
ith too many privileges behind */
+            wprintf(L"Restricting privil=
eges failed - %ls\n", GetLastErrorText());
+            DeleteService(servi=
ce);
+            CloseServiceHandle(service);
+            ++ret;
+       =
     continue;
+        }
+
+        wprintf(L"%ls installed=2E\n", ovpn_sv=
c->display_name);
+        CloseServiceHandle(service);
     }
 
     Close=
ServiceHandle(svc_ctl_mgr);
@@ -140,7 +208,6 @@
 static int
 CmdRemoveServi=
ces(void)
 {
-    SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
     SERVI=
CE_STATUS status;
     int i, ret =3D _service_max;
@@ -155,12 +222,13 @@
 =
    for (i =3D 0; i < _service_max; i++)
     {
         openvpn_service_t =
*ovpn_svc =3D &openvpn_service[i];
-        service =3D
+        SC_HANDLE =
service =3D
             OpenService(svc_ctl_mgr, ovpn_svc->name, DELETE | =
SERVICE_STOP | SERVICE_QUERY_STATUS);
         if (service =3D=3D NULL)
   =
      {
+            /* the service may not be installed, continue with the=
 next one */
             wprintf(L"OpenService failed - %ls\n", GetLastErr=
orText());
-            goto out;
+            continue;
         }
 
     =
    /* try to stop the service */
@@ -206,7 +274,6 @@
         CloseService=
Handle(service);
     }
 
-out:
     CloseServiceHandle(svc_ctl_mgr);
     =
return ret;
 }
@@ -215,20 +282,21 @@
 int
 wmain(int argc, WCHAR *argv[])
 =
{
-    /*
-     * Interactive service (as a SERVICE_WIN32_SHARE_PROCESS)
- =
    * This is the default=2E
-     */
-    const SERVICE_TABLE_ENTRY dispat=
chTable_shared[] =3D {
-        { interactive_service=2Ename, ServiceStartI=
nteractive }, { NULL, NULL }
-    };
-
-    /* Interactive service only (as=
 a SERVICE_WIN32_OWN_PROCESS) */
-    const SERVICE_TABLE_ENTRY dispatchTab=
le_interactive[] =3D { { L"", ServiceStartInteractiveOwn },
+    /* Interac=
tive service (as a SERVICE_WIN32_OWN_PROCESS), this is the default */
+    =
const SERVICE_TABLE_ENTRY dispatchTable_interactive[] =3D { { L"", ServiceS=
tartInteractive },
                                                        =
       { NULL, NULL } };
 
-    const SERVICE_TABLE_ENTRY *dispatchTable =
=3D dispatchTable_shared;
+    /*
+     * Automatic service (as a SERVICE_W=
IN32_OWN_PROCESS)
+     * It has to run in a process of its own, as it runs=
 with an account
+     * that is less privileged than the one of the intera=
ctive service=2E
+     */
+    const SERVICE_TABLE_ENTRY dispatchTable_auto=
matic[] =3D { { L"", ServiceStartAutomatic },
+                            =
                                { NULL, NULL } };
 
+    const SERVICE_TABL=
E_ENTRY *dispatchTable =3D dispatchTable_interactive;
+
+    openvpn_servic=
e[automatic] =3D automatic_service;
     openvpn_service[interactive] =3D i=
nteractive_service;
 
     for (int i =3D 1; i < argc; i++)
@@ -237,7 +305,=
24 @@
         {
             if (_wcsicmp(L"install", argv[i] + 1) =3D=3D =
0)
             {
-                return CmdInstallServices();
+          =
      openvpn_service_type type =3D _service_max;
+                if (argc=
 > i + 1)
+                {
+                    if (_wcsicmp(L"automatic"=
, argv[i + 1]) =3D=3D 0)
+                    {
+                        ty=
pe =3D automatic;
+                    }
+                    else if (_wcs=
icmp(L"interactive", argv[i + 1]) =3D=3D 0)
+                    {
+       =
                 type =3D interactive;
+                    }
+            =
        else
+                    {
+                        wprintf(L"Unkn=
own service '%ls'\n", argv[i + 1]);
+                        return 1;
+   =
                 }
+                }
+                return CmdInstallSer=
vices(type);
             }
             else if (_wcsicmp(L"remove", argv[=
i] + 1) =3D=3D 0)
             {
@@ -245,7 +330,16 @@
             }
      =
       else if (_wcsicmp(L"start", argv[i] + 1) =3D=3D 0)
             {
- =
               return CmdStartService(interactive);
+                BOOL i=
s_auto =3D argc > i + 1 && _wcsicmp(L"automatic", argv[i + 1]) =3D=3D 0;
+ =
               return CmdStartService(is_auto ? automatic : interactive);
+=
            }
+            else if (_wcsicmp(L"automatic", argv[i] + 1) =3D=
=3D 0)
+            {
+                dispatchTable =3D dispatchTable_auto=
matic;
+            }
+            else if (_wcsicmp(L"interactive", argv[i=
] + 1) =3D=3D 0)
+            {
+                dispatchTable =3D dispatch=
Table_interactive;
             }
             else if (argc > i + 2 && _wc=
sicmp(L"instance", argv[i] + 1) =3D=3D 0)
             {
@@ -265,13 +359,21=
 @@
             }
             else
             {
-                wprint=
f(L"%ls -install        to install the interactive service\n", APPNAME);
  =
               wprintf(
-                    L"%ls -start [name]   to start=
 the service (name =3D \"interactive\") is optional\n",
+                  =
  L"%ls -install [name] to install services (name =3D \"automatic\" or \"in=
teractive\",\n"
+                    L"                            defaults=
 to both)\n",
                     APPNAME);
-                wprintf(L"%ls=
 -remove         to remove the service\n", APPNAME);
+                wprin=
tf(
+                    L"%ls -start [name]   to start a service (name =3D=
 \"automatic\" or \"interactive\",\n"
+                    L"              =
              defaults to \"interactive\")\n",
+                    APPNAME=
);
+                wprintf(L"%ls -remove         to remove the services\n"=
, APPNAME);
 
                 wprintf(L"\nService run-time parameters:\n")=
;
+                wprintf(L"-automatic\n"
+                        L"   Ru=
ns the automatic service=2E\n");
+                wprintf(L"-interactive\n"=

+                        L"   Runs the interactive service=2E This is the =
default=2E\n");
                 wprintf(L"-instance interactive <id>\n"
  =
                       L"   Runs the service as an alternate instance=2E\n"=

                         L"   The service settings will be loaded from\n"
=
diff --git a/src/openvpnserv/service=2Eh b/src/openvpnserv/service=2Eh
inde=
x c67d67f=2E=2E2c012d2 100644
--- a/src/openvpnserv/service=2Eh
+++ b/src/o=
penvpnserv/service=2Eh
@@ -47,6 +47,7 @@
 
 typedef enum
 {
+    automatic,=

     interactive,
     _service_max
 } openvpn_service_type;
@@ -58,6 +59,=
9 @@
     WCHAR *display_name;
     WCHAR *dependencies;
     DWORD start_t=
ype;
+    WCHAR *arguments;
+    WCHAR *account;
+    WCHAR *required_privi=
leges;
 } openvpn_service_t;
 
 #define MAX_NAME 256
@@ -65,6 +69,7 @@
 {
 =
    WCHAR exe_path[MAX_PATH];
     WCHAR config_dir[MAX_PATH];
+    WCHAR a=
utostart_config_dir[MAX_PATH];
     WCHAR bin_dir[MAX_PATH];
     WCHAR ext=
_string[16];
     WCHAR log_dir[MAX_PATH];
@@ -74,10 +79,11 @@
     BOOL ap=
pend;
 } settings_t;
 
+extern openvpn_service_t automatic_service;
 extern=
 openvpn_service_t interactive_service;
 extern LPCWSTR service_instance;
 =

-VOID WINAPI ServiceStartInteractiveOwn(DWORD argc, LPWSTR *argv);
+VOID W=
INAPI ServiceStartAutomatic(DWORD argc, LPWSTR *argv);
 
 VOID WINAPI Servi=
ceStartInteractive(DWORD argc, LPWSTR *argv);
 
@@ -90,6 +96,16 @@
 DWORD M=
sgToEventLog(DWORD flags, LPCWSTR lpszMsg, =2E=2E=2E);
 
 /**
+ * Close a h=
andle and invalidate it
+ *
+ * Nothing is done if the handle is invalid al=
ready, which makes it safe
+ * to call this function more than once for the=
 same handle=2E
+ *
+ * @param handle  pointer to the handle to be closed
+=
 */
+void CloseHandleEx(LPHANDLE handle);
+
+/**
  * Convert a UTF-8 string=
 to UTF-16
  *
  * The size parameter can be used to convert strings which =
contain inline NUL
diff --git a/tests/unit_tests/openvpnserv/Makefile=2Eam =
b/tests/unit_tests/openvpnserv/Makefile=2Eam
index 210c9e6=2E=2E07df5cc 100=
644
--- a/tests/unit_tests/openvpnserv/Makefile=2Eam
+++ b/tests/unit_tests=
/openvpnserv/Makefile=2Eam
@@ -3,16 +3,36 @@
 AM_TESTSUITE_SUMMARY_HEADER =
=3D ' for $(PACKAGE_STRING) service Unit-Tests'
 
 if WIN32
-test_binaries =
=3D openvpnserv_testdriver
+test_binaries =3D openvpnserv_testdriver openvp=
nserv_automatic_testdriver
 endif
 check_PROGRAMS =3D $(test_binaries)
 
-o=
penvpnserv_testdriver_CFLAGS  =3D -I$(top_srcdir)/include -I$(top_srcdir)/s=
rc/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpnserv @TEST=
_CFLAGS@
-openvpnserv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)=
/src/openvpn
+# build the tests like openvpnserv itself, see src/openvpnser=
v/Makefile=2Eam
+openvpnserv_test_cflags =3D \
+	-municode -D_UNICODE \
+	-=
UNTDDI_VERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10 \
+	-I$(top_srcdir)/incl=
ude -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat \
+	-I$(top_srcd=
ir)/src/openvpnserv -I$(top_builddir)/src/openvpnserv \
+	-I$(top_srcdir)/t=
ests/unit_tests/openvpn \
+	@TEST_CFLAGS@
+openvpnserv_test_ldflags =3D -mu=
nicode @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+openvpnserv_test_ldadd =
=3D \
+	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
+	-lshlwapi -=
lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch
+
+openvpnserv_testdriver_CFLA=
GS  =3D $(openvpnserv_test_cflags)
+openvpnserv_testdriver_LDFLAGS =3D $(op=
envpnserv_test_ldflags)
+openvpnserv_testdriver_LDADD   =3D $(openvpnserv_t=
est_ldadd)
 openvpnserv_testdriver_SOURCES =3D test_openvpnserv=2Ec \
 	$(t=
op_srcdir)/src/openvpnserv/common=2Ec \
 	$(top_srcdir)/src/openvpnserv/val=
idate=2Ec \
 	$(top_srcdir)/src//openvpn/wfp_block=2Ec \
 	$(top_srcdir)/sr=
c//openvpn/wfp_block=2Eh
 
+openvpnserv_automatic_testdriver_CFLAGS  =3D $(=
openvpnserv_test_cflags)
+openvpnserv_automatic_testdriver_LDFLAGS =3D $(op=
envpnserv_test_ldflags)
+openvpnserv_automatic_testdriver_LDADD   =3D $(ope=
nvpnserv_test_ldadd)
+openvpnserv_automatic_testdriver_SOURCES =3D test_ope=
nvpnserv_automatic=2Ec \
+	$(top_srcdir)/src/openvpnserv/common=2Ec
+
 buil=
d-tests-local: $(check_PROGRAMS)
diff --git a/tests/unit_tests/openvpnserv/=
test_openvpnserv_automatic=2Ec b/tests/unit_tests/openvpnserv/test_openvpns=
erv_automatic=2Ec
new file mode 100644
index 0000000=2E=2E7ccbd93
--- /dev/=
null
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec
@@ -=
0,0 +1,238 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netw=
orks
+ *             over a single UDP port, with support for SSL/TLS-based=

+ *             session authentication and key exchange,
+ *             p=
acket encryption, packet authentication, and
+ *             packet compres=
sion=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+=
 *  This program is free software; you can redistribute it and/or modify
+ =
*  it under the terms of the GNU General Public License as published by the=

+ *  Free Software Foundation, either version 2 of the License,
+ *  or (a=
t your option) any later version=2E
+ *
+ *  This program is distributed in=
 the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without ev=
en the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ =
*
+ *  You should have received a copy of the GNU General Public License al=
ong
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include=
 <setjmp=2Eh>
+#include <cmocka=2Eh>
+#include "test_common=2Eh"
+
+#includ=
e <winsock2=2Eh>
+#include <windows=2Eh>
+
+/*
+ * The automatic service ca=
nnot be linked together with the interactive one
+ * in a single test drive=
r, as both define the same static service state=2E
+ */
+#include "automati=
c=2Ec"
+
+BOOL
+ReportStatusToSCMgr(SERVICE_STATUS_HANDLE svc_handle, SERVI=
CE_STATUS *svc_status)
+{
+    return TRUE;
+}
+
+/**
+ * Parse a response =
like the one sent by the interactive service
+ *
+ * @param response  the r=
esponse string
+ * @param error     receives the error code of the response=

+ * @param pid       receives the process id of the response
+ *
+ * @retu=
rn the result of ParseInteractiveServiceResponse()
+ */
+static BOOL
+parse=
_response(PCWSTR response, PDWORD error, PDWORD pid)
+{
+    /* the respons=
e is modified while parsing, so pass a copy */
+    WCHAR buf[256];
+    as=
sert_true(wcslen(response) < _countof(buf));
+    wcscpy(buf, response);
+
=
+    return ParseInteractiveServiceResponse(buf, error, pid);
+}
+
+static =
void
+test_response_success(void **state)
+{
+    DWORD error =3D 0xdeadbee=
f;
+    DWORD pid =3D 0xdeadbeef;
+
+    assert_true(parse_response(L"0x000=
00000\n0x000004d2\nProcess ID", &error, &pid));
+    assert_int_equal(error=
, 0);
+    assert_int_equal(pid, 1234);
+}
+
+static void
+test_response_er=
ror(void **state)
+{
+    DWORD error =3D 0xdeadbeef;
+    DWORD pid =3D 0x=
deadbeef;
+
+    /*
+     * An error response carries the name of the faile=
d function in the
+     * second line, which must not be mistaken for a pro=
cess id=2E
+     */
+    assert_true(parse_response(L"0x0000007b\nCreatePro=
cessAsUser\nThe filename is invalid", &error,
+                            =
   &pid));
+    assert_int_equal(error, 0x7b);
+    assert_int_equal(pid, 0=
);
+}
+
+static void
+test_response_error_crlf(void **state)
+{
+    DWORD =
error =3D 0xdeadbeef;
+    DWORD pid =3D 0xdeadbeef;
+
+    /* error respon=
ses are built with FormatMessage(), which uses \r\n line breaks */
+    ass=
ert_true(parse_response(L"0x20000001\r\nYou have specified a config file lo=
cation\r\n", &error,
+                               &pid));
+    assert_in=
t_equal(error, 0x20000001);
+    assert_int_equal(pid, 0);
+}
+
+static voi=
d
+test_response_malformed(void **state)
+{
+    DWORD error, pid;
+
+    /=
* no line break at all */
+    assert_false(parse_response(L"0x00000000", &=
error, &pid));
+
+    /* neither line is a number */
+    assert_false(pars=
e_response(L"hello world\nnot a pid\nmessage", &error, &pid));
+
+    /* th=
e error code is a number with trailing garbage */
+    assert_false(parse_r=
esponse(L"0x00000000xyz\n0x000004d2\nProcess ID", &error, &pid));
+
+    /*=
 success response without a process id */
+    assert_false(parse_response(=
L"0x00000000\n", &error, &pid));
+
+    /* success response with an empty p=
rocess id line */
+    assert_false(parse_response(L"0x00000000\n\nProcess =
ID", &error, &pid));
+
+    /* the process id is a number with trailing gar=
bage */
+    assert_false(parse_response(L"0x00000000\n0x000004d2xyz\nProce=
ss ID", &error, &pid));
+
+    /* empty lines only */
+    assert_false(par=
se_response(L"\n\n", &error, &pid));
+}
+
+static void
+test_add_startup_da=
ta(void **state)
+{
+    WCHAR buf[32];
+    size_t pos =3D 0;
+
+    /* th=
e startup data is config dir + \0 + options + \0 + password + \0 */
+    as=
sert_true(AddStartupData(buf, _countof(buf), &pos, L"C:\\cfg"));
+    asser=
t_int_equal(pos, 7);
+
+    assert_true(AddStartupData(buf, _countof(buf), =
&pos, L"--log x"));
+    assert_int_equal(pos, 15);
+
+    /* the password =
is empty, but still terminated */
+    assert_true(AddStartupData(buf, _cou=
ntof(buf), &pos, L""));
+    assert_int_equal(pos, 16);
+
+    /* the field=
s are separated and terminated by zeros */
+    const WCHAR expected[] =3D =
L"C:\\cfg\0--log x\0";
+    assert_int_equal(pos, _countof(expected));
+   =
 assert_int_equal(wmemcmp(buf, expected, pos), 0);
+}
+
+static void
+test_=
add_startup_data_full(void **state)
+{
+    WCHAR buf[8];
+    size_t pos =
=3D 0;
+
+    wmemset(buf, L'#', _countof(buf));
+
+    /* a string that do=
es not fit is rejected without changing anything */
+    assert_false(AddSt=
artupData(buf, _countof(buf), &pos, L"12345678"));
+    assert_int_equal(po=
s, 0);
+    for (size_t i =3D 0; i < _countof(buf); i++)
+    {
+        as=
sert_int_equal(buf[i], L'#');
+    }
+
+    /* a string whose terminator en=
ds up as the last element still fits */
+    assert_true(AddStartupData(buf=
, _countof(buf), &pos, L"1234567"));
+    assert_int_equal(pos, _countof(bu=
f));
+
+    /* but leaves no room for another field, not even an empty one =
*/
+    assert_false(AddStartupData(buf, _countof(buf), &pos, L""));
+    a=
ssert_int_equal(pos, _countof(buf));
+}
+
+static void
+test_log_file_path(=
void **state)
+{
+    WCHAR path[MAX_PATH];
+    WCHAR name[MAX_PATH + 64];=

+
+    /* the extension is replaced by =2Elog */
+    assert_true(GetLogFi=
lePath(path, _countof(path), L"C:\\log\\", L"office=2Eovpn"));
+    assert_=
int_equal(wcscmp(path, L"C:\\log\\office=2Elog"), 0);
+
+    /* a missing b=
ackslash on the log dir is added */
+    assert_true(GetLogFilePath(path, _=
countof(path), L"C:\\log", L"office=2Eovpn"));
+    assert_int_equal(wcscmp=
(path, L"C:\\log\\office=2Elog"), 0);
+
+    /* only the last extension is =
replaced */
+    assert_true(GetLogFilePath(path, _countof(path), L"C:\\log=
\\", L"my=2Eoffice=2Eovpn"));
+    assert_int_equal(wcscmp(path, L"C:\\log\=
\my=2Eoffice=2Elog"), 0);
+
+    /* a name without an extension just gets o=
ne */
+    assert_true(GetLogFilePath(path, _countof(path), L"C:\\log\\", L=
"office"));
+    assert_int_equal(wcscmp(path, L"C:\\log\\office=2Elog"), 0=
);
+
+    /* a name that is nothing but an extension */
+    assert_true(Ge=
tLogFilePath(path, _countof(path), L"C:\\log\\", L"=2Eovpn"));
+    assert_=
int_equal(wcscmp(path, L"C:\\log\\=2Elog"), 0);
+
+    /* spaces are no pro=
blem */
+    assert_true(GetLogFilePath(path, _countof(path), L"C:\\my logs=
\\", L"my office=2Eovpn"));
+    assert_int_equal(wcscmp(path, L"C:\\my log=
s\\my office=2Elog"), 0);
+
+    /* a config file name that cannot fit the =
log file name is an error */
+    wmemset(name, L'a', _countof(name) - 1);
=
+    name[_countof(name) - 1] =3D L'\0';
+    assert_false(GetLogFilePath(p=
ath, _countof(path), L"C:\\log\\", name));
+
+    /* a log dir that does no=
t leave room for the name is an error */
+    assert_false(GetLogFilePath(p=
ath, 8, L"C:\\some\\very\\long\\log\\dir", L"office=2Eovpn"));
+}
+
+int
+w=
main(void)
+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest =
tests[] =3D {
+        cmocka_unit_test(test_response_success),
+        cm=
ocka_unit_test(test_response_error),
+        cmocka_unit_test(test_respons=
e_error_crlf),
+        cmocka_unit_test(test_response_malformed),
+       =
 cmocka_unit_test(test_add_startup_data),
+        cmocka_unit_test(test_ad=
d_startup_data_full),
+        cmocka_unit_test(test_log_file_path),
+    }=
;
+
+    int ret =3D cmocka_run_group_tests_name("openvpnserv automatic ser=
vice tests", tests, NULL, NULL);
+
+    return ret;
+}

-- 
To view, visit =
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail
To unsubscribe,=
 or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/set=
tings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
=
Gerrit-Branch: master
Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03=
f4144b
Gerrit-Change-Number: 2001
Gerrit-PatchSet: 4
Gerrit-Owner: Heiko Hu=
nd <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openv=
pn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ec=
om>
Gerrit-Reviewer: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: =
Selva Nair <selva=2Enair@gmail=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-dev=
el@lists=2Esourceforge=2Enet>
Gerrit-Attention: Selva Nair <selva=2Enair@gm=
ail=2Ecom>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-At=
tention: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
Gerrit-Attention: Arne S=
chwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <fr=
ank@lichtenheld=2Ecom>

--DCGr0wHRwnU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Heiko Hund, Lev Stip=
akov, Selva Nair=2E </p>
<p>Heiko Hund <strong>uploaded patch set #4</stron=
g> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/2001?usp=3Demail">View Change</a></p><p>The following approvals got o=
utdated and were removed:
Code-Review-1 by Frank Lichtenheld</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">openvpnserv: add automatic service again<br><br>The automatic service, =
which starts all configs in the autostart config<br>directory, has been pro=
vided by the =2ENET based openvpnserv2=2Eexe since<br>OpenVPN 2=2E4=2E Its =
original C implementation in openvpnserv=2Eexe was removed<br>from this rep=
ository in 2021=2E Add it back, implemented in C, so that both<br>Windows s=
ervices are maintained in this repository=2E<br><br>Security related change=
s added:<br>- before sending any data, verify that the named pipe is served=
 by the<br>  interactive service process<br>- the exit event of each OpenVP=
N process has a random name and a DACL<br>  that only grants access to its =
owner, so it cannot be pre-created or<br>  signalled by other users<br>- th=
e service checks that it is run as the ovpn_service_user account in<br>  th=
e registry settings, so that it and openvpn in turn is guaranteed to<br>  r=
un with limited privileges<br><br>Robustness:<br>- starting a config is ret=
ried until the service stops, with a delay<br>  that doubles from 10 second=
s up to 5 minutes for configs that keep<br>  failing, and is reset once a p=
rocess ran for a minute<br>- an OpenVPN process that may have been started =
by a failed attempt is<br>  signalled to exit, so it does not run unmonitor=
ed<br>- configs in subdirectories use their own directory as working<br>  d=
irectory; configs with the same file name as one found before are<br>  igno=
red, like in the GUI<br><br>Both services now run in their own process, sel=
ected by the new<br>&#39;-automatic&#39; and &#39;-interactive&#39; options=
=2E This is needed since they need<br>to run with different accounts=2E &#3=
9;-install&#39; takes an optional service<br>name again=2E &#39;-instance a=
utomatic&#39; is not supported, since the service<br>cannot check the named=
 pipe owner for instances=2E<br><br>Also add a few unit tests and some docu=
mentation=2E<br><br>Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b<br=
>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M=
 Changes=2Emd<br>M doc/Makefile=2Eam<br>A doc/automatic-service-notes=2Erst=
<br>M src/openvpnserv/CMakeLists=2Etxt<br>M src/openvpnserv/Makefile=2Eam<b=
r>A src/openvpnserv/automatic=2Ec<br>M src/openvpnserv/common=2Ec<br>M src/=
openvpnserv/interactive=2Ec<br>M src/openvpnserv/service=2Ec<br>M src/openv=
pnserv/service=2Eh<br>M tests/unit_tests/openvpnserv/Makefile=2Eam<br>A tes=
ts/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec<br>12 files change=
d, 1,652 insertions(+), 63 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/2001/4</pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>=
diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index b5ae881=2E=
=2E365b1ee 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/=
Changes=2Emd</span><br><span>@@ -23,6 +23,33 @@</span><br><span>   the char=
acters mentioned above were already escaped=2E However, the behavior of</sp=
an><br><span>   Mbed TLS is slightly different from OpenSSL in that it also=
 escapes &quot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+* **Windows automatic service moved back into thi=
s repository**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPNService, which =
starts all configs in the `config-auto` directory at</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  boot time, is no longer provided by the=
 =2ENET based `openvpnserv2=2Eexe`, but by</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  `openvpnserv=2Eexe`, like the interactive service =
is=2E It mostly works like the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  service it was ported from, with these exceptions and addition=
s:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  * The service can no longer be run=
 on the command line, but exclusively as</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    a service through the Service Control Manager=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * The service refus=
es to start if it does not run as the account</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    `NT SERVICE\OpenVPNService`=2E This is checke=
d for security reasons: OpenVPN</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    runs under the same account, so its configs, scripts and pl=
ugins would get</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
all privileges of a more privileged account as well=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  * All service related logging is done =
via event log=2E The event source changed</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    from `OpenVpnService` to `openvpnserv`, same as f=
or the interactive one=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+  * An OpenVPN process that cannot be started or exits is started aga=
in,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    first after =
10 seconds, with the delay doubling up to 5 minutes for</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    processes that keep failing=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Configs in subdirect=
ories of `config-auto` use their own directory as</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    working directory=2E Of several configs w=
ith the same file name, only the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    first one found is started, like in the OpenVPN GUI=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  * The automatic and t=
he interactive service now each run in a process of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    their own, selected by the `-automati=
c` and `-interactive` options of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    `openvpnserv=2Eexe`=2E `-install` takes an optional servic=
e name=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * `-inst=
ance automatic` is not supported on purpose=2E It cannot verify the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    interactive service nam=
ed pipe for instances before connecting=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> ## Maintainer-visible changes</spa=
n><br><span> </span><br><span> - The configure-time option `--enable-debug`=
 is no longer  available</span><br><span>diff --git a/doc/Makefile=2Eam b/d=
oc/Makefile=2Eam</span><br><span>index 5ca1c4d=2E=2Ebbd83cd 100644</span><b=
r><span>--- a/doc/Makefile=2Eam</span><br><span>+++ b/doc/Makefile=2Eam</sp=
an><br><span>@@ -55,6 +55,7 @@</span><br><span> </span><br><span> dist_noin=
st_DATA =3D \</span><br><span> 	android=2Etxt \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	automatic-service-notes=2Erst \</span><br><spa=
n> 	interactive-service-notes=2Erst \</span><br><span> 	keying-material-exp=
orter=2Etxt \</span><br><span> 	openvpn=2E8=2Erst \</span><br><span>diff --=
git a/doc/automatic-service-notes=2Erst b/doc/automatic-service-notes=2Erst=
</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E4c=
1858c</span><br><span>--- /dev/null</span><br><span>+++ b/doc/automatic-ser=
vice-notes=2Erst</span><br><span>@@ -0,0 +1,151 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+OpenVPN Automatic Service Notes</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+Introduction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-=
-----------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN Automatic Service, =
also known as &quot;OpenVPNService&quot;, is a Windows system</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+service which starts an OpenVPN p=
rocess for each configuration file in the</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+autostart configuration folder, ``config-auto`` by de=
fault=2E It is meant for</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+connections that should be up at all times, independent of any user be=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logged on=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+How It Works</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The Automatic Serv=
ice does not start OpenVPN itself, but uses the Interactive</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Service to do it, the same way Open=
VPN GUI does=2E See</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
`interactive-service-notes=2Erst` for how the Interactive Service works=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+- On start, the service searches the au=
tostart configuration folder and its</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  subfolders, up to a depth of 32, for files with the conf=
iguration file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ext=
ension=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+- For each configuration file=
 it connects to the Interactive Service named</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  pipe ``\\=2E\pipe\openvpn\service`` and sends t=
he startup data=2E Before sending</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  anything it checks that the pipe is served by the Interacti=
ve Service</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  process=
, as registered with the Service Control Manager=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+- The Interactive Service starts openvpn=2Eexe with the acco=
unt of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Automat=
ic Service=2E It allows this account to use any options and</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  configuration files in any folder=
, see `Service Account`_=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The folde=
r of the configuration file is used as the working folder, so</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  relative paths in a configurati=
on file resolve relative to its folder=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+- openvpn=2Eexe is started with these options::</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      --log &lt;log file&gt; --config &lt;config file&gt; --ser=
vice &lt;exit event&gt; 0</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      --pull-filter ignore route-method</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  ``--log-append`` is used instead of ``--log`` if configured=2E The=
 exit event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is cre=
ated by the Automatic Service before each start=2E It has a random name</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  and only its owner, t=
he service account, has access to it=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+- When the service stops, it signals the exit events, which makes the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN processes exit=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Configuration files are identified =
by their file name, like in OpenVPN GUI=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+If there are several configuration files with the sa=
me file name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+diff=
erent subfolders, only the first one found is started and an error is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+logged for the others=2E =
Files in a folder are found before those in its</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+subfolders=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Restarting OpenV=
PN Processes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-------=
---------------------</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+An OpenVPN proces=
s that exits, or that cannot be started, is started again</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+until the service stops=2E The first =
attempt is made after 10 seconds=2E The</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+delay doubles with each further failure, up to 5 minute=
s=2E It is reset to 10</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+seconds once an OpenVPN process has run for at least a minute=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+This also covers the Interactive Service not b=
eing reachable, for example</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+while it is restarted=2E The configurations are started again with =
the next</span><br><span style=3D"color: hsl(120, 100%, 40%);">+attempt aft=
er it is available again=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+Service Account</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+---------------</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+The Automatic Service runs with the virtual service accou=
nt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``NT SERVICE\Open=
VPNService``=2E The OpenVPN processes it starts run with this</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+account too, so configuration fil=
es and anything they reference, like keys</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+and certificates, including those in the Windows cert=
ificate store, must be</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+readable by it=2E The log folder must be writable by it=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+The service refuses to start if it runs with any oth=
er account=2E OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+runs with the same account, so configuration files, scripts and plugins</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+would get all privile=
ges of a more privileged account, like LocalSystem, as</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+well=2E The service is installed with it=
s required privileges reduced to</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+``SeChangeNotifyPrivilege``, which also removes privileges suc=
h as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``SeImpersonate=
Privilege`` from the OpenVPN processes=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+The Interactive Service lets the account ``NT SERVICE\&lt;ovpn_service_u=
ser&gt;``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+use any op=
tions, see `Configuration`_=2E The account the Automatic Service</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+checks for is derived from the=
 same registry value, so both always agree=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Configuratio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-------------</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+The Automatic Service reads its settings =
from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``HKEY_LOCA=
L_MACHINE\SOFTWARE\OpenVPN`` registry key, like the Interactive</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+Service=2E All the following re=
gistry values are of the ``REG_SZ`` type:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+``autostart_config_dir``</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+   The autostart configuration folder=2E If this value does not exi=
st or is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   empty, n=
o configurations are started=2E The installer sets it to</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+   ``install_dir &quot;\config-auto&qu=
ot;``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+``config_ext``</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+   The configuration file extension=
, without a leading dot; defaults to</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+   ``&quot;ovpn&quot;``=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+``log_dir``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
The folder for the log files; defaults to ``install_dir &quot;\log&quot;``=
=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   installer=
 sets it to ``%ProgramData%\OpenVPN\Log`` and makes it writable</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+   for the service account=2E E=
ach OpenVPN process logs to a file in this</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+   folder, named like its configuration file, with t=
he extension replaced by</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+   ``=2Elog``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``log_append``</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+   ``&quot;1&quot;`` t=
o append to existing log files, ``&quot;0&quot;`` (default) to truncate</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+   them when an OpenVPN=
 process is started=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``ovpn_service_u=
ser``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   The name of=
 the service account, without the ``NT SERVICE\`` prefix;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   defaults to ``&quot;OpenVPNService=
&quot;``=2E Used by the Interactive Service to</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   authorize the Automatic Service and by the Au=
tomatic Service to check</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+   its own account=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The values `=
`exe_path`` and ``priority`` described in</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+`interactive-service-notes=2Erst` apply too, as the I=
nteractive Service starts</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+the OpenVPN processes=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The serv=
ice writes its own messages to the Windows event log, using the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+``openvpnserv`` event source, t=
he same as the Interactive Service=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+Installation</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+------------</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+The OpenVPN installer registers the service, whether =
or not the &quot;OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+Service&quot; feature is selected=2E Without the feature it is disable=
d, otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+it is s=
et to start automatically and started=2E Upgrades keep the start mode</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+and running state of the =
service=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+The services can also be reg=
istered from an elevated command prompt::</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      openvpnserv=2Eexe -install [automatic|interactive]</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+Without a name, both services are registered=2E A serv=
ice that is registered</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+already is left alone=2E The Automatic Service is registered with the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+``-automatic`` option,=
 its account, the dependency on the Interactive Service</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+and its reduced privileges=2E Both serv=
ices run in a process of their own,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+selected by the ``-automatic`` and ``-interactive`` options=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Unlike the Interactive Service, the=
 Automatic Service does not support the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+``-instance`` option for side-by-side installations=2E<=
/span><br><span>diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src/openvpn=
serv/CMakeLists=2Etxt</span><br><span>index 35f1efe=2E=2Ef266ce6 100644</sp=
an><br><span>--- a/src/openvpnserv/CMakeLists=2Etxt</span><br><span>+++ b/s=
rc/openvpnserv/CMakeLists=2Etxt</span><br><span>@@ -35,6 +35,7 @@</span><br=
><span> add_common_options(openvpnserv)</span><br><span> target_sources(ope=
nvpnserv PRIVATE</span><br><span>     common=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    automatic=2Ec</span><br><span>     interac=
tive=2Ec</span><br><span>     service=2Ec service=2Eh</span><br><span>     =
validate=2Ec validate=2Eh</span><br><span>@@ -83,6 +84,7 @@</span><br><span=
> if (BUILD_TESTING)</span><br><span>     set(unit_tests</span><br><span>  =
       &quot;test_openvpnserv&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        &quot;test_openvpnserv_automatic&quot;</span><br><s=
pan>     )</span><br><span> </span><br><span>     foreach (test_name ${unit=
_tests})</span><br><span>@@ -105,4 +107,8 @@</span><br><span>         valid=
ate=2Ec</span><br><span>         =2E=2E/openvpn/wfp_block=2Ec =2E=2E/openvp=
n/wfp_block=2Eh</span><br><span>     )</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    target_sources(test_openvpnserv_automatic PRIVATE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        common=2Ec</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> endif ()</span><br=
><span>diff --git a/src/openvpnserv/Makefile=2Eam b/src/openvpnserv/Makefil=
e=2Eam</span><br><span>index 447fb10=2E=2Ed3ca665 100644</span><br><span>--=
- a/src/openvpnserv/Makefile=2Eam</span><br><span>+++ b/src/openvpnserv/Mak=
efile=2Eam</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span><br><s=
pan> openvpnserv_SOURCES =3D \</span><br><span>         common=2Ec \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	automatic=2Ec \</span><br=
><span> 	interactive=2Ec \</span><br><span> 	service=2Ec service=2Eh \</spa=
n><br><span> 	validate=2Ec validate=2Eh \</span><br><span>diff --git a/src/=
openvpnserv/automatic=2Ec b/src/openvpnserv/automatic=2Ec</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2Ea113c78</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpnserv/automatic=2Ec</span=
><br><span>@@ -0,0 +1,1020 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2026- OpenVPN Inc &lt;sales@openvpn=2Ene=
t&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwa=
re; you can redistribute it and/or modify</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Lice=
nse version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as=
 published by the Free Software Foundation=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is distributed in the hope that it will be useful=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT AN=
Y WARRANTY; without even the implied warranty of</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
The automatic service starts one OpenVPN process for each configuration</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * file found in the au=
tostart config directory and restarts them when they</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * exit unexpectedly=2E The OpenVPN proce=
sses are not started directly, but by</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * the interactive service, which this service talks to v=
ia its named pipe=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;service=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;handleapi=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;pathcch=2Eh&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;rpc=2Eh=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;sd=
dl=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Time we g=
ive the interactive service to accept our connection */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define ISERVICE_CONNECT_TIMEOUT 5000 /=
*ms*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Time we wait before an OpenVPN process is star=
ted again, after it exited</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * or could not be started=2E The delay doubles with each failed att=
empt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define RESTART_DELAY_MIN 10=
000 /*ms*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum time we wait bef=
ore an OpenVPN process is started again */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define RESTART_DELAY_MAX 300000 /*ms*/</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/** Time after which a running OpenVPN process rese=
ts the delay to the minimum */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define STABLE_RUNTIME 60000 /*ms*/</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/** Maximum size of the startup data sent to the interactive servic=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define STARTUP=
_DATA_MAX 2048</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum recursion de=
pth when searching for configuration files */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define MAX_RECURSION_DEPTH 32</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/** Name of the interactive service we talk to */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define ISERVICE_NAME _L(PA=
CKAGE_NAME) L&quot;ServiceInteractive&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/** The service cannot run without the interactive service, so we make=
 it depend on it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define AUTOMATIC_SERVICE_DEPENDENCIES ISERVICE_NAME L&quot;\0\0&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/** The service runs as its own virtual =
service account, which the interactive service trusts */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define AUTOMATIC_SERVICE_ACCOUNT L&qu=
ot;NT SERVICE\\&quot; _L(PACKAGE_NAME) L&quot;Service&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/** The service needs no privileges besides the one ev=
ery process has */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define AUTOMATIC_SERVICE_PRIVILEGES L&quot;SeChangeNotifyPrivilege\0\0&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+openvpn_service_t automatic_service =
=3D { automatic,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                     _L(PACKAGE_NAME) L&quot;Service&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
                     _L(PACKAGE_NAME) L&quot; Automatic Service&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                AUTOMATIC_SERVICE_DEPENDENCIES,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                        SERVICE=
_DEMAND_START,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                   L&quot;-automatic&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
     // cppcheck-suppress unknownMacro ; FP, _L after a string literal</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                AUTOMATIC_SERVICE_ACCOUNT,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                        AUTOMATIC_SE=
RVICE_PRIVILEGES };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static SERVICE_STAT=
US_HANDLE service;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic SERVICE_STATUS status =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN_PR=
OCESS };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static HAND=
LE exit_event =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static settings=
_t settings;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/** One OpenVPN connection=
, i=2Ee=2E one configuration file */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+typedef struct openvpn_process</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct openvpn_process *next;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    WCHAR working_dir[MAX_PATH];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    WCHAR config_file[MAX_PATH];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR log_file[MAX_PA=
TH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE proc=
ess;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE exit=
_event;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE s=
top_event;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDL=
E thread;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CRITIC=
AL_SECTION cs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} ope=
nvpn_process_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Linked list of Open=
VPN connections / configuration files */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static openvpn_process_t *processes =3D NULL;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Add the zero terminated string \p str to \p buf=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * If successful, \p pos points to the charact=
er after the terminating NUL=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram buf   string buffer to append to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param size  size of the buffer in wide characters</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param[in,out] pos  =
position in the buffer in wide characters</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param str   the string to append</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return BOOL to indicate success or failure</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+AddStartupData(PWSTR buf, size_t size, size_t *po=
s, PCWSTR str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =3D wcsl=
en(str) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*pos + len &gt; si=
ze)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    wmemcpy(buf + *pos, str, len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    *pos +=3D len;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Get the process id of the interactive servi=
ce</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return the process id, or 0 if=
 the service is not running or on error</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Get=
InteractiveServicePid(void)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD =
pid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    SC_HANDLE scm =3D OpenSC=
Manager(NULL, NULL, SC_MANAGER_CONNECT);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!scm)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SC_HANDLE svc =3D OpenService(=
scm, ISERVICE_NAME, SERVICE_QUERY_STATUS);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (svc)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        SERVICE_STATUS_PROCESS ssp;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        DWORD needed;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (QueryServiceStatusEx(svc, SC_STATUS_PROCESS=
_INFO, (LPBYTE)&amp;ssp, sizeof(ssp), &amp;needed)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &amp;&amp; ssp=2EdwCurrentState =
=3D=3D SERVICE_RUNNING)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      pid =3D ssp=2EdwProcessId;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        CloseServiceHandle(svc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CloseServiceH=
andle(scm);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Check that the server end of \p pipe is the interactive servic=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Makes sure we do not send data t=
o, or can be impersonated by, a process</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * which created a pipe with the interactive service&#3=
9;s pipe name=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pipe  the =
connected pipe handle</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL=
 to indicate whether the pipe server is the interactive service</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+IsInteractiveServicePipe(HANDLE pipe)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ULONG server_pid;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!GetNamedPipeServerProcessId(pipe, &amp;serve=
r_pid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    DWORD iservice_pid =3D GetInteractiveServicePid();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return iservice_pi=
d !=3D 0 &amp;&amp; server_pid =3D=3D iservice_pid;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Connect to the n=
amed pipe of the interactive service</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * The connection is only returned if the pipe is served by the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * interactive service process=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param timeout  maximum time i=
n ms to wait for the pipe to become available</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return pipe handle, or INVALID_HANDLE_VALUE on error</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static HANDLE</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ConnectToInteractiveService(DWORD timeout)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    WCHAR pipe_name[256];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ULONGLONG deadline =3D GetTickCount6=
4() + timeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(pipe_name, =
_countof(pipe_name), L&quot;\\\\=2E\\pipe\\&quot; _L(PACKAGE) L&quot;%ls\\s=
ervice&quot;, service_instance);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wh=
ile (TRUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        HANDLE pipe =3D=
 CreateFile(pipe_name, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXISTING=
, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (pipe !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            DWORD mode =3D PIPE_READMODE_MESSAGE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (!SetNamedPipeHandleStat=
e(pipe, &amp;mode, NULL, NULL))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                CloseHandle(pipe);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                return INVALID_HANDLE_VALUE;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (!IsInteractiveServi=
cePipe(pipe))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    MsgToEventLog(M_ERR, L&quot;Pipe %ls is not served by the interactive s=
ervice&quot;, pipe_name);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                CloseHandle(pipe);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                SetLastError(ERROR_ACCESS_DENIED);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                return =
INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return pipe;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD error =3D GetL=
astError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
ULONGLONG now =3D GetTickCount64();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (now &gt;=3D deadline)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            SetLastError(error);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return INVALID_HANDLE_VALUE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (error =3D=3D ERROR_PIPE_BUSY)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* All pipe instances are=
 busy, wait for one to become available */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if (!WaitNamedPipe(pipe_name, (DWORD)(de=
adline - now)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      return INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else if (error =3D=3D ERROR_FILE_NOT_FOUND)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* The interactive service may not have cr=
eated the pipe yet */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            Sleep(50);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            SetLastErr=
or(error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Split off the first line of \p str</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Lines end with &quot;\\n&quot; or &quot;\\r\\n&quot; in error=
 responses of the interactive service=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param str  the string to split, its first line is zero terminated i=
n place</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the start of the n=
ext line, or NULL if there is none</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic PWSTR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SplitLin=
e(PWSTR str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR eol =3D wcschr(=
str, L&#39;\n&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!eol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    *eol =3D L&#39;\0&#39;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (eol &gt; str &amp;&amp; eol[-1] =
=3D=3D L&#39;\r&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        eol[=
-1] =3D L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return eol + 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse=
 the response of the interactive service</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * The response is a three line string, with the error code in the firs=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the process id=
 in the second if OpenVPN was started successfully and</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * a message in the third line=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param response  the zero terminated r=
esponse, which is modified</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param error     receives the error code returned by the service<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pid       =
receives the process id of the OpenVPN process</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @return BOOL to indicate success or failure</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ParseInteractiveServiceResponse(PWSTR response, PDWORD error, =
PDWORD pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR pid_line =3D Spl=
itLine(response);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!pid_line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SetLastEr=
ror(ERROR_INVALID_DATA);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Spl=
itLine(pid_line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR end;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    *error =3D wcstoul(res=
ponse, &amp;end, 16);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (end =3D=3D response || *end !=3D L&#39;\0&#39;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        SetLastError(ERROR_INVALID_DATA);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    *pid =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (*error =3D=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        *pid =3D wcstoul(pid_line, &amp;end, 16);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (end =3D=3D pid_line || *end !=
=3D L&#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 SetLastError(ERROR_INVALID_DATA);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            return FALSE;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Read the response of the interactive service from the pipe</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param pipe   the pipe to read the response from=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param error  re=
ceives the error code returned by the service</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param pid    receives the process id of the O=
penVPN process</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to ind=
icate success or failure</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ReadInteractiveServ=
iceResponse(HANDLE pipe, PDWORD error, PDWORD pid)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    WCHAR buf[1024];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    DWORD bytes;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!ReadFile(pipe, buf, sizeof(buf) - sizeof(buf[0]), &amp;bytes, NULL))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf[bytes / sizeof(buf[0])] =3D L&#39;\0&#39;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return ParseInteractiveServiceResponse(buf, error, pid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Build the path of the log file of a configuration file</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * The log file is named like the configuration f=
ile \p name, with its</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * extension replaced by &quot;=2Elog&quot;, and is placed in \p log_dir=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param log_file  buffer that r=
eceives the log file path</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param size      size of the buffer in wide characters</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param log_dir   the directo=
ry the log file is placed in</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param name      the file name of the configuration file</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate success or fa=
ilure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+GetLogFilePath(PWSTR log_file, size_t =
size, PCWSTR log_dir, PCWSTR name)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 WCHAR log_name[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    PCWSTR dot =3D wcsrchr(name, L&#39;=2E&#39;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int len =3D dot ? (int)(dot - name=
) : (int)(wcslen(name));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return swp=
rintf(log_name, _countof(log_name), L&quot;%=2E*ls=2Elog&quot;, len, name) =
&gt;=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
 &amp;&amp; PathCchCombine(log_file, size, log_dir, log_name) =3D=3D S_OK;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Create the event used to signal an OpenVPN process to exit</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * The name of the event is random, so others ca=
nnot create it in advance</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * and keep it under their control=2E Should the name exist already a=
nyway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * another on=
e is tried=2E Only the owner of the event has access to it=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * OpenVPN runs with the same acc=
ount as this service, so it can open the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * event by its name=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param name  buffer that receives the name of the event</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  size of the =
buffer in wide characters</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
the event handle, or INVALID_HANDLE_VALUE on error</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static HANDLE</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+CreateExitEvent(PWSTR name, size_t size)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    SECURITY_ATTRIBUTES sa =3D { =2EnLength =3D sizeof(sa) };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE event =3D =
INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ConvertS=
tringSecurityDescriptorToSecurityDescriptorW(</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            L&quot;D:P(A;;GA;;;OW)&quot;, SDDL_RE=
VISION_1, &amp;sa=2ElpSecurityDescriptor, NULL))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        return event;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int ma=
x_tries =3D 3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
or (int tries =3D 0; tries &lt; max_tries; tries++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        UUID uuid;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        RPC_WSTR uuid_str;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (UuidCreate(&amp;uuid) !=3D RPC_S_OK |=
| UuidToStringW(&amp;uuid, &amp;uuid_str) !=3D RPC_S_OK)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        swprintf(name, size, _L(PACKAGE) L&quot;_exit_%ls&q=
uot;, (PWSTR)uuid_str);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        RpcStringFreeW(&amp;uuid_str);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        event =3D CreateEvent(&amp;sa, TRUE, FALSE, name);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (event &amp;&amp; Get=
LastError() !=3D ERROR_ALREADY_EXISTS)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      CloseHandleEx(&amp;event);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   LocalFree(sa=2ElpSecurityDescriptor);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (event =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        MsgToEventLog(M_ERR, L&quot;Could not create exit event=
=2E&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return event;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Start an OpenVPN=
 process for a configuration file</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Connects to the interactive service, sends the startup data and reads</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * back the process id of=
 the started OpenVPN process=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram p  the process to start</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn BOOL to indicate success or failure</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Start=
Process(openvpn_process_t *p)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHA=
R cmdline[STARTUP_DATA_MAX];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    WCHAR startup_data[STARTUP_DATA_MAX];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    WCHAR exit_event_name[MAX_PATH];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE pipe =3D INVALID=
_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
ize_t pos =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 DWORD error, pid, written;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    BOOL ret =3D FALSE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
each OpenVPN process gets a new exit event */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    HANDLE event =3D CreateExitEvent(exit_event_n=
ame, _countof(exit_event_name));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (event =3D=3D INVALID_HANDLE_VALUE)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could not crea=
te exit event for config %ls&quot;, p-&gt;config_file);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const WCHAR *log_option =3D settings=2Eappend ? L&quot;--log-appen=
d&quot; : L&quot;--log&quot;;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int n =3D swprintf(cmdline, _countof(cmdline),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     L&quot;%ls \&=
quot;%ls\&quot; --config \&quot;%ls\&quot; --service \&quot;%ls\&quot; 0 --=
pull-filter ignore route-method&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                     log_option, p-&gt;log_file, p-&gt;c=
onfig_file, exit_event_name);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (n &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  MsgToEventLog(M_ERR, L&quot;Command line too long for config %ls&quot;, p=
-&gt;config_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* working dir + \0 + options + =
\0 + password + \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!AddStartupData(startup_data, _countof(startup_data), &amp;pos, p=
-&gt;working_dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      || !AddStartupData(startup_data, _countof(startup_data), &amp;pos, cm=
dline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || !A=
ddStartupData(startup_data, _countof(startup_data), &amp;pos, L&quot;&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&=
quot;Startup data too long for config %ls&quot;, p-&gt;config_file);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    pipe =3D ConnectToInteractiveService(ISERVICE_CONNECT_TI=
MEOUT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pipe=
 =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    MsgToEventLog(M_SYSERR, L&quot;Could not connect to the interactive ser=
vice&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!WriteFile(pipe, startup_data, (D=
WORD)(pos * sizeof(startup_data[0])), &amp;written, NULL))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could not s=
end startup data to interactive service&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!ReadInteractiveServiceResponse(pipe, &amp;error, &amp;pid))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could no=
t read response from iservice&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error !=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR=
, L&quot;Error starting openvpn process: %lu&quot;, error);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * T=
he interactive service restricts access to the OpenVPN process=2E It does</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * not grant PROC=
ESS_QUERY_LIMITED_INFORMATION, but PROCESS_QUERY_INFORMATION=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    HANDLE process =3D OpenProcess(SYNCHR=
ONIZE | PROCESS_QUERY_INFORMATION, FALSE, pid);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!process)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could not open OpenVPN p=
rocess, PID %lu&quot;, pid);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    EnterCriticalSection(&=
amp;p-&gt;cs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    C=
loseHandleEx(&amp;p-&gt;process);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    CloseHandleEx(&amp;p-&gt;exit_event);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    p-&gt;process =3D process;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;exit_event =3D eve=
nt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    event =3D NU=
LL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    LeaveCritica=
lSection(&amp;p-&gt;cs);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    MsgToEvent=
Log(M_INFO, L&quot;Started openvpn process %lu for config %ls&quot;, pid, p=
-&gt;config_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ret =3D TRUE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+out:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * An OpenVPN process may have been started, e=
ven if we could not get a</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * handle of it or did not receive the response=2E Make sure it e=
xits, as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * it w=
ould not be monitored nor stopped otherwise=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!ret &amp;&amp; event)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        SetEvent(event);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    CloseHandleEx(&amp;pipe);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    CloseHandleEx(&amp;event);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Signal an OpenVPN process to e=
xit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param p  the process to signa=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SignalProcess(openvpn_process_t *p)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    EnterCriticalSection(&amp;p-&gt;cs);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (p-&gt;proces=
s &amp;&amp; WaitForSingleObject(p-&gt;process, 0) =3D=3D WAIT_TIMEOUT</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !SetE=
vent(p-&gt;exit_event))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DW=
ORD pid =3D GetProcessId(p-&gt;process);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Error signallin=
g PID %lu to exit&quot;, pid);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 LeaveCriticalSection(&amp;p-&gt;cs);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Run the OpenVPN process for a co=
nfig and restart it when it exits</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Starting the process is retried until the service stops=2E The delay</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * between the attempts gr=
ows when a process cannot be started or exits</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * right away, so a broken config does not keep t=
he system busy=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param process  =
the process to run</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static DWORD WINA=
PI</span><br><span style=3D"color: hsl(120, 100%, 40%);">+MonitorProcess(LP=
VOID process)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_process_t *p=
 =3D process;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DW=
ORD delay =3D RESTART_DELAY_MIN;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wh=
ile (TRUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ULONGLONG start=
ed =3D GetTickCount64();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (StartProcess(p))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            HANDLE handles[2];</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        EnterCriticalSection(&amp;p-&gt;cs);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            handles[0] =3D p-&gt;stop_event;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            handles[1] =
=3D p-&gt;process;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           DWORD pid =3D GetProcessId(p-&gt;process);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            LeaveCriticalSection(&amp;p-&=
gt;cs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            if (WaitForMultiple=
Objects(2, handles, FALSE, INFINITE) =3D=3D WAIT_OBJECT_0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            MsgToEventLog(M_INFO, L&quot;OpenVPN process %lu fo=
r config %ls has exited&quot;, pid,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                          p-&gt;config_file);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            /* a process that ran for a while did no=
t fail right away */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (GetTickCount64() - started &gt;=3D STABLE_RUNTIME)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                delay =3D RESTART=
_DELAY_MIN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_INFO, L&quot;Star=
ting config %ls again in %lu sec&quot;, p-&gt;config_file,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                      delay / 1000);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (WaitForSingleObject(p-&gt;=
stop_event, delay) =3D=3D WAIT_OBJECT_0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        delay =3D m=
in(delay * 2, RESTART_DELAY_MAX);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return NO_ERROR=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Find a process entry with a config file named \p name</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param name  the file name of the config, withou=
t the path</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the process ent=
ry, or NULL if there is none</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
openvpn_process_t *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
FindProcessByName(PCWSTR name)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (openvpn_process_t *p =3D processes; p; p =3D p-&gt;next)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        PCWSTR p_name =3D wcsrchr(p-&gt;config_fil=
e, L&#39;\\&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       p_name =3D p_name ? p_name + 1 : p-&gt;config_file;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (_wcsicmp(p_name, name) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return p=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Create a process en=
try for \p config_file and start the thread</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * that runs the OpenVPN process for it=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * A config with the same file name as one th=
at was found before is ignored,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * as both would use the same log file=2E This is in line with =
how openvpn-gui</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * h=
andles duplicates=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param workin=
g_dir  the directory the config file is in</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param config_file  path of the configuration fil=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+StartConfig(PCWSTR working_dir, PCWSTR co=
nfig_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    PCWSTR name =3D wcsrchr=
(config_file, L&#39;\\&#39;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    name =3D name ? name + 1 : config_file;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    openvpn_process_t *dup =3D FindProcessByName(name);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dup)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;Config %l=
s has the same file name as %ls, ignoring it&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      config_file, dup-&g=
t;config_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    openvpn_process_t *p =3D calloc(1, si=
zeof(*p));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&=
quot;Out of memory starting openvpn for %ls&quot;, config_file);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (!GetLogFilePath(p-&gt;log_file, _countof(p-&gt;log_file), s=
ettings=2Elog_dir, name))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
MsgToEventLog(M_ERR, L&quot;Error starting openvpn for %ls&quot;, config_fi=
le);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(p)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    p-&gt;stop_event =3D CreateEvent(NULL, TRUE, FALSE,=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!p-&=
gt;stop_event)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventL=
og(M_SYSERR, L&quot;Error starting openvpn for %ls&quot;, config_file);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(p);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    wcsncpy(p-&gt;working_dir, working_dir, _countof(p-&gt;work=
ing_dir) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
csncpy(p-&gt;config_file, config_file, _countof(p-&gt;config_file) - 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    InitializeCritical=
Section(&amp;p-&gt;cs);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;next =
=3D processes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
rocesses =3D p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;thread =3D Cr=
eateThread(NULL, 0, MonitorProcess, p, 0, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (!p-&gt;thread)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could not create=
 monitoring thread for %ls&quot;, config_file);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Recursively find configuration files=
 in \p dir</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and ru=
n OpenVPN for each of them=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am dir   the directory to search</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param level the current recursion depth</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+StartConfigsInDir(PCWSTR dir, DWORD level)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    WCHAR ext_pattern[_countof(settings=2Eext_string) + 2=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR pattern=
[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHA=
R path[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  WIN32_FIND_DATA find_data;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    HANDLE find;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (level=
 &gt; MAX_RECURSION_DEPTH)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 MsgToEventLog(M_INFO, L&quot;Maximum recursion depth reached=2E Ignoring c=
onfig dir %ls&quot;, dir);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(ext_pattern, _cou=
ntof(ext_pattern), L&quot;*=2E%ls&quot;, settings=2Eext_string);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Run configs in dir */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (PathCchCombine(pattern, _countof=
(pattern), dir, ext_pattern) =3D=3D S_OK)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        find =3D FindFirstFile(pattern, &amp;find_data);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (find !=3D INVALID_=
HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            do</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                BOOL direct=
ory =3D (find_data=2EdwFileAttributes &amp; FILE_ATTRIBUTE_DIRECTORY) !=3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
f (!directory &amp;&amp; PathCchCombine(path, _countof(path), dir, find_dat=
a=2EcFileName) =3D=3D S_OK)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    StartConfig(dir, path);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            } while (FindNextFile(find, &amp;fi=
nd_data));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            FindClose(find);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (PathCchCombine(pattern, _countof(pattern), dir, L&qu=
ot;*&quot;) !=3D S_OK)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Try to recurse */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    find =3D FindFirstFile(pattern, &amp;=
find_data);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
find !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (find_=
data=2EdwFileAttributes &amp; FILE_ATTRIBUTE_DIRECTORY</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; wcscmp(find_d=
ata=2EcFileName, L&quot;=2E&quot;) !=3D 0</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                &amp;&amp; wcscmp(find_data=2EcFileNa=
me, L&quot;=2E=2E&quot;) !=3D 0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                &amp;&amp; PathCchCombine(path, _countof(path),=
 dir, find_data=2EcFileName) =3D=3D S_OK)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                StartConfigsInDir(path, level + 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        } while (FindNextFile(fin=
d, &amp;find_data));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        FindClose(=
find);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * St=
art an OpenVPN process for every config found in the autostart</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * config directory=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Having nothing to start is not an error=2E =
Like an autostart config</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * directory without any config files in it, it leaves the service run=
ning</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * without any =
processes=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+StartAllProcesses(void)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* starting configs automatically is opti=
onal */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sett=
ings=2Eautostart_config_dir[0] =3D=3D L&#39;\0&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        MsgToEventLog(M_INFO, L&quot;No autostart confi=
g directory configured&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD attr =3D GetFile=
Attributes(settings=2Eautostart_config_dir);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (attr =3D=3D INVALID_FILE_ATTRIBUTES || !(a=
ttr &amp; FILE_ATTRIBUTE_DIRECTORY))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        MsgToEventLog(M_ERR, L&quot;Autostart config directory does not =
exist at %ls&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                      settings=2Eautostart_config_dir);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    StartConfigsInDir(settings=2Eautostart_config_dir, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!processes)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        MsgToEventLog(M_INFO, L&quot;No configs found in %ls&quot;, =
settings=2Eautostart_config_dir);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Stop all OpenVPN processes and wait for their moni=
toring threads</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+StopAllProcesses(void)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (openvpn_process_t *p =3D processes;=
 p; p =3D p-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SetE=
vent(p-&gt;stop_event);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    for (openvpn_process_t *p=
 =3D processes; p; p =3D p-&gt;next)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (p-&gt;thread)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           WaitForSingleObject(p-&gt;thread, INFINITE);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            CloseHandleEx(&amp;p-&gt;th=
read);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (openvpn_process_t *p =3D processes; p; p =3D p-=
&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        SignalProcess(p)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Free th=
e list of processes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+FreeAllProcesses(void)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    openvpn_process_t *p =3D processes;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    while (p)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        openvpn_process_t *next =3D p-&gt;next;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        CloseHandleEx(&amp;p-&gt;process);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        CloseHandleEx(&amp=
;p-&gt;exit_event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        CloseHandleEx(&amp;p-&gt;stop_event);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        DeleteCriticalSection(&amp;p-&gt;cs);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(p);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        p =3D next;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 processes =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Check that the service runs under its virtual service account</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * The interactive service lets NT SERVIC=
E\\\&lt;ovpn_service_user\&gt; start OpenVPN</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * with any options=2E Running as a more privilege=
d account, like LocalSystem,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * would run all configs with these elevated privileges=2E So, rat=
her refuse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to run=
 as any other account, in case an admin is adventurous=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param s  the settings, with the name of the servic=
e account</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate=
 whether we run as the service account</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+IsRun=
ningAsServiceAccount(const settings_t *s)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    BOOL ret =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * A TOKEN_USER with=
 room for the largest possible SID after it=2E The sid</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * member alone is used for the SID =
of the account, as it is aligned=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        TOKEN_USER =
token_user;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
BYTE sid[SECURITY_MAX_SID_SIZE];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    } token_user_info, account_info;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    WCHAR account[MAX_NAME];</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DWORD sid_size =3D sizeof(account_info=2Esid);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR domain[MAX_NAM=
E];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD domain=
_size =3D _countof(domain);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    SID_NAME_USE use;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swpri=
ntf(account, _countof(account), L&quot;NT SERVICE\\%ls&quot;, s-&gt;ovpn_se=
rvice_user);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(!LookupAccountName(NULL, account, account_info=2Esid, &amp;sid_size, domai=
n, &amp;domain_size, &amp;use))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      MsgToEventLog(M_SYSERR, L&quot;Could not look up account %ls&quot;, a=
ccount);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    HANDLE token;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!OpenProcessToken(GetCurrentProce=
ss(), TOKEN_QUERY, &amp;token))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      MsgToEventLog(M_SYSERR, L&quot;Could not open process token&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    DWORD len;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    BOOL got_user =3D</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        GetTokenInformation(token, TokenUser, &amp;toke=
n_user_info, sizeof(token_user_info), &amp;len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    CloseHandle(token);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!got_user)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could not get to=
ken user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ret =3D EqualSid(token_user_in=
fo=2Etoken_user=2EUser=2ESid, account_info=2Esid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (!ret)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        MsgToEventLog(M_ERR, L&quot;Service must run as %ls, ref=
using to start&quot;, account);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic DWORD WINAPI</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Serv=
iceCtrlAutomatic(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SERVICE_STATUS *svc_status =3D ctx;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (ctrl_code=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        case SERVICE_CONTROL_STO=
P:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            svc_s=
tatus-&gt;dwCurrentState =3D SERVICE_STOP_PENDING;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            /* threads may be connecting to =
the interactive service */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            svc_status-&gt;dwWaitHint =3D ISERVICE_CONNECT_TIMEOUT +=
 1000;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            R=
eportStatusToSCMgr(service, svc_status);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (exit_event)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                SetEvent(exit_event);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            return NO_ERROR;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        case SERVICE_CONTROL_INTERROGATE:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return NO_ERROR;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return ERROR_CALL_NOT_IMPLEME=
NTED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+VOID WINA=
PI</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ServiceStartAutom=
atic(DWORD dwArgc, LPWSTR *lpszArgv)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   DWORD error =3D NO_ERROR;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    servic=
e =3D RegisterServiceCtrlHandlerEx(automatic_service=2Ename, ServiceCtrlAut=
omatic, &amp;status);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!service)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    status=2EdwCurrentState =3D SERVICE_START_PENDI=
NG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status=2EdwS=
erviceSpecificExitCode =3D NO_ERROR;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    status=2EdwWin32ExitCode =3D NO_ERROR;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    status=2EdwWaitHint =3D 3000;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!ReportStatusToSCMgr(service, &a=
mp;status))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(=
M_ERR, L&quot;ReportStatusToSCMgr SERVICE_START_PENDING failed&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto finish;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * Create our exit event</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * This event is initially created in the non-signaled s=
tate=2E It will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * transition to the signaled state when we have received a terminate</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * signal from the Se=
rvice Control Manager=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exi=
t_event =3D CreateEvent(NULL, TRUE, FALSE, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!exit_event)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        error =3D MsgToEventLog(M_SYSERR, L&quot;CreateEve=
nt for exit event failed&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        goto finish;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Read setting=
s from registry */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   error =3D GetOpenvpnSettings(&amp;settings);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SUCCESS)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        goto finish;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!IsRunningAsServiceAccount(&amp;settings))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        error =3D ERROR_ACCESS_DENIED;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto finish;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    StartAllProcesses();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status=
=2EdwCurrentState =3D SERVICE_RUNNING;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    status=2EdwWaitHint =3D 0;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!ReportStatusToSCMgr(service, &amp;st=
atus))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR=
, L&quot;ReportStatusToSCMgr SERVICE_RUNNING failed&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        goto finish;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (WaitForSingleObject(exit_event, INFINITE) !=3D WAIT_OBJECT_=
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&=
quot;wait for shutdown signal failed&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+finish:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    StopAllProcesses=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    FreeAllProce=
sses();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    CloseHandleEx(&amp;exit_eve=
nt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    status=2EdwCurrentState =3D SE=
RVICE_STOPPED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
tatus=2EdwWin32ExitCode =3D error;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ReportStatusToSCMgr(service, &amp;status);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/sr=
c/openvpnserv/common=2Ec b/src/openvpnserv/common=2Ec</span><br><span>index=
 671ddde=2E=2Ebd6a50f 100644</span><br><span>--- a/src/openvpnserv/common=
=2Ec</span><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -1=
16,6 +116,14 @@</span><br><span>         goto out;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* an empty autostart config dir means configs are not started automatical=
ly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D =
GetRegString(key, L&quot;autostart_config_dir&quot;, s-&gt;autostart_config=
_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
           sizeof(s-&gt;autostart_config_dir), L&quot;&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SUCCESS=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span>     swprintf(default_value, _c=
ountof(default_value), L&quot;%ls\\bin\\&quot;, install_path);</span><br><s=
pan>     error =3D GetRegString(key, L&quot;bin_dir&quot;, s-&gt;bin_dir, s=
izeof(s-&gt;bin_dir), default_value);</span><br><span>     if (error !=3D E=
RROR_SUCCESS || !ensure_trailing_backslash(s-&gt;bin_dir, _countof(s-&gt;bi=
n_dir)))</span><br><span>@@ -123,7 +131,7 @@</span><br><span>         goto =
out;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    error =3D GetRegString(key, L&quot;config_ext&q=
uot;, s-&gt;ext_string, sizeof(s-&gt;ext_string), L&quot;=2Eovpn&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D GetRegSt=
ring(key, L&quot;config_ext&quot;, s-&gt;ext_string, sizeof(s-&gt;ext_strin=
g), L&quot;ovpn&quot;);</span><br><span>     if (error !=3D ERROR_SUCCESS)<=
/span><br><span>     {</span><br><span>         goto out;</span><br><span>@=
@ -292,6 +300,19 @@</span><br><span>     return error;</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CloseHandleEx(LPHA=
NDLE handle)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (handle)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (*handle &amp;&amp; *handle !=
=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        CloseHandle(*handle);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        *handle =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> wchar_t *</span><br><span> utf8to16_size(const char *utf8, int size=
)</span><br><span> {</span><br><span>diff --git a/src/openvpnserv/interacti=
ve=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index 81205d6=2E=
=2E9d0c402 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec</sp=
an><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -49,7=
 +49,7 @@</span><br><span> #define ERROR_MESSAGE_TYPE    0x20000003</span><=
br><span> </span><br><span> static SERVICE_STATUS_HANDLE service;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static SERVICE_STATUS status =
=3D { =2EdwServiceType =3D SERVICE_WIN32_SHARE_PROCESS };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static SERVICE_STATUS status =3D { =
=2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS };</span><br><span> static H=
ANDLE exit_event =3D NULL;</span><br><span> static settings_t settings;</sp=
an><br><span> static HANDLE rdns_semaphore =3D NULL;</span><br><span>@@ -58=
,9 +58,14 @@</span><br><span> #define TUN_IOCTL_REGISTER_RINGS \</span><br>=
<span>     CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_=
WRITE_DATA)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-openvpn_service_t interactive_service =3D { interactive, _L(PACKAGE=
_NAME) L&quot;ServiceInteractive&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+openvpn_service_t interactive_service =3D { interactive=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                        _L(PACKAGE_NAME) L&quot;ServiceInteractive&quot;,</=
span><br><span>                                           _L(PACKAGE_NAME) =
L&quot; Interactive Service&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                          SERVICE_DEPENDENCIES=
, SERVICE_AUTO_START };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                          SERVICE_DEPENDENCIES,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
               SERVICE_AUTO_START,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                          L&quot;-interactiv=
e&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                               NULL,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                          NULL };</span><b=
r><span> </span><br><span> </span><br><span> typedef struct</span><br><span=
>@@ -172,18 +177,6 @@</span><br><span>     return data;</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static HANDLE</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-CloseHandleEx(LPHANDLE handle)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (handle &amp;&amp; *handle &amp;&amp=
; *handle !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       CloseHandle(*handle);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        *handle =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    return INVALID_HANDLE_VALUE;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> static HANDLE</span><br><span> InitOverlapped(LPOVERLAP=
PED overlapped)</span><br><span> {</span><br><span>@@ -4107,13 +4100,6 @@</=
span><br><span> }</span><br><span> </span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-VOID WINAPI</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-ServiceStartInteractiveOwn(DWORD dwArgc, LPWSTR *lpsz=
Argv)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    status=2EdwServiceType =3D SERVI=
CE_WIN32_OWN_PROCESS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    ServiceStartInteractive(dwArgc, lpszArgv);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span> /**</span><br><span>  * Clean up remains of previous=
 sessions in registry=2E These remains can</span><br><span>  * happen with =
unclean shutdowns or crashes and would interfere with</span><br><span>diff =
--git a/src/openvpnserv/service=2Ec b/src/openvpnserv/service=2Ec</span><br=
><span>index 2913f63=2E=2E292816c 100644</span><br><span>--- a/src/openvpns=
erv/service=2Ec</span><br><span>+++ b/src/openvpnserv/service=2Ec</span><br=
><span>@@ -52,22 +52,52 @@</span><br><span>     return res;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Restrict a =
service to the privileges it actually needs</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Also gives the service its own SID, which is required for running=
 it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as a virtual =
service account=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param service =
    handle of the service, with SERVICE_CHANGE_CONFIG access</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param privileges  double zero =
terminated list of privilege names</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return BOOL to indicate success or failure</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+SetServicePrivileges(SC_HANDLE service, WCHAR *privileges)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SERVICE_SID_INFO sid_info =3D { SERVICE_SID_TYPE_=
UNRESTRICTED };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
SERVICE_REQUIRED_PRIVILEGES_INFO priv_info =3D { privileges };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return ChangeServiceConfig2(service, SERVICE_CO=
NFIG_SERVICE_SID_INFO, &amp;sid_info)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+           &amp;&amp; ChangeServiceConfig2(service, SERVI=
CE_CONFIG_REQUIRED_PRIVILEGES_INFO, &amp;priv_info);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Install the serv=
ices</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * A service that is installed a=
lready counts as success, so this can be</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * run repeatedly, e=2Eg=2E by the MSI installer after=
 an upgrade=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param type  the se=
rvice to install, or _service_max for all of them</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return the number of services that could not be installed<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span>=
 static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-CmdInstall=
Services(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CmdIn=
stallServices(openvpn_service_type type)</span><br><span> {</span><br><span=
>     SC_HANDLE svc_ctl_mgr;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    WCHAR exe_path[MAX_PATH];</span><br><span>     WCHAR path[512]=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i, ret =3D _=
service_max;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 ret =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (GetModuleFileName(NULL, path + 1, _countof(path) - 2) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD len=
 =3D GetModuleFileName(NULL, exe_path, _countof(exe_path));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (len =3D=3D 0 || len =3D=3D =
_countof(exe_path))</span><br><span>     {</span><br><span>         wprintf=
(L&quot;Unable to install service - %ls\n&quot;, GetLastErrorText());</span=
><br><span>         return 1;</span><br><span>     }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    path[0] =3D L&#39;\&qu=
ot;&#39;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    wcscat_s=
(path, _countof(path), L&quot;\&quot;&quot;);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span>     svc_ctl_mgr =3D OpenSCManager=
(NULL, NULL, SC_MANAGER_CONNECT | SC_MANAGER_CREATE_SERVICE);</span><br><sp=
an>     if (svc_ctl_mgr =3D=3D NULL)</span><br><span>     {</span><br><span=
>@@ -75,22 +105,60 @@</span><br><span>         return 1;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    for (i =3D 0; i &lt; _service_max; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; _service_max; i++)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       SC_HANDLE service =3D CreateService(</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            svc_ctl_mgr, openvpn_service[i]=2Ename, o=
penvpn_service[i]=2Edisplay_name,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            SERVICE_QUERY_STATUS, SERVICE_WIN32_SHARE_PROCESS, =
openvpn_service[i]=2Estart_type,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            SERVICE_ERROR_NORMAL, path, NULL, NULL, openvpn_serv=
ice[i]=2Edependencies, NULL, NULL);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (service)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (type !=3D _service_max &amp;&amp; type !=3D (ope=
nvpn_service_type)i)</span><br><span>         {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            wprintf(L&quot;%ls installed=2E\n&quo=
t;, openvpn_service[i]=2Edisplay_name);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            CloseServiceHandle(service);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            --ret;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span> =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        openvpn_service_t *ovpn_svc =
=3D &amp;openvpn_service[i];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 each service runs in its own process, selected by the arguments */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        swprintf(path, _cou=
ntof(path), L&quot;\&quot;%ls\&quot;%ls%ls&quot;, exe_path,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 ovpn_svc-&gt;argum=
ents ? L&quot; &quot; : L&quot;&quot;, ovpn_svc-&gt;arguments ? ovpn_svc-&g=
t;arguments : L&quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * A servi=
ce that was just deleted stays marked for deletion until</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * all handles to it are close=
d, e=2Eg=2E by an open services=2Emsc=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        int tries =3D 10;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        SC_HANDLE service;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        while (!(service =3D CreateService(svc_ct=
l_mgr, ovpn_svc-&gt;name, ovpn_svc-&gt;display_name,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
SERVICE_QUERY_STATUS | SERVICE_CHANGE_CONFIG | DELETE,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                        =
 SERVICE_WIN32_OWN_PROCESS, ovpn_svc-&gt;start_type,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
SERVICE_ERROR_NORMAL, path, NULL, NULL,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                         ovpn_svc-&gt;d=
ependencies, ovpn_svc-&gt;account, NULL))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+               &amp;&amp; GetLastError() =3D=3D ERROR=
_SERVICE_MARKED_FOR_DELETE &amp;&amp; --tries)</span><br><span>         {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            Sleep(100=
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (!service)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (GetLastError() =3D=3D ERROR_SERVICE=
_EXISTS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                w=
printf(L&quot;%ls is installed already=2E\n&quot;, ovpn_svc-&gt;display_nam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span>             wprintf(L&quot;CreateService failed - %ls\=
n&quot;, GetLastErrorText());</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            ++ret;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            continue;</span><br><span>         }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (ovpn_svc-&gt;required_privileges</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !SetServ=
icePrivileges(service, ovpn_svc-&gt;required_privileges))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* do not leave a service with too =
many privileges behind */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            wprintf(L&quot;Restricting privileges failed - %ls\n&quot=
;, GetLastErrorText());</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            DeleteService(service);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            CloseServiceHandle(service);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            ++ret;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        wprintf(L&quot;%ls installed=2E\n&quot;, ovpn_svc-&g=
t;display_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     CloseServiceHandle(service);</span><br><span>     }</span><br><span> <=
/span><br><span>     CloseServiceHandle(svc_ctl_mgr);</span><br><span>@@ -1=
40,7 +208,6 @@</span><br><span> static int</span><br><span> CmdRemoveServic=
es(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    SC_HANDLE service;</span><br><span>     SC_HANDLE svc_ctl_mgr;</s=
pan><br><span>     SERVICE_STATUS status;</span><br><span>     int i, ret =
=3D _service_max;</span><br><span>@@ -155,12 +222,13 @@</span><br><span>   =
  for (i =3D 0; i &lt; _service_max; i++)</span><br><span>     {</span><br>=
<span>         openvpn_service_t *ovpn_svc =3D &amp;openvpn_service[i];</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        service =3D</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        SC_HANDLE service=
 =3D</span><br><span>             OpenService(svc_ctl_mgr, ovpn_svc-&gt;nam=
e, DELETE | SERVICE_STOP | SERVICE_QUERY_STATUS);</span><br><span>         =
if (service =3D=3D NULL)</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /* the service may not be ins=
talled, continue with the next one */</span><br><span>             wprintf(=
L&quot;OpenService failed - %ls\n&quot;, GetLastErrorText());</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            goto out;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><=
span>         }</span><br><span> </span><br><span>         /* try to stop t=
he service */</span><br><span>@@ -206,7 +274,6 @@</span><br><span>         =
CloseServiceHandle(service);</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-out:</span><br><span>     C=
loseServiceHandle(svc_ctl_mgr);</span><br><span>     return ret;</span><br>=
<span> }</span><br><span>@@ -215,20 +282,21 @@</span><br><span> int</span><=
br><span> wmain(int argc, WCHAR *argv[])</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * Interactive service (as a SERVICE_WIN32_SHARE=
_PROCESS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * This =
is the default=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const SERVICE_=
TABLE_ENTRY dispatchTable_shared[] =3D {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        { interactive_service=2Ename, ServiceStartIntera=
ctive }, { NULL, NULL }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* Interactive service only (a=
s a SERVICE_WIN32_OWN_PROCESS) */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    const SERVICE_TABLE_ENTRY dispatchTable_interactive[] =3D {=
 { L&quot;&quot;, ServiceStartInteractiveOwn },</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Interactive service (as a SERVICE_WIN32_=
OWN_PROCESS), this is the default */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const SERVICE_TABLE_ENTRY dispatchTable_interactive[] =
=3D { { L&quot;&quot;, ServiceStartInteractive },</span><br><span>         =
                                                      { NULL, NULL } };</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st SERVICE_TABLE_ENTRY *dispatchTable =3D dispatchTable_shared;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * Automatic service (as a SERVICE_WIN32=
_OWN_PROCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 It has to run in a process of its own, as it runs with an account</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * that is less privileg=
ed than the one of the interactive service=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const SERVICE_TABLE_ENTRY dispatchTable_automatic[] =3D {=
 { L&quot;&quot;, ServiceStartAutomatic },</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                                    =
        { NULL, NULL } };</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const SERVICE_TABLE_ENTRY *dispatchTable =3D di=
spatchTable_interactive;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_se=
rvice[automatic] =3D automatic_service;</span><br><span>     openvpn_servic=
e[interactive] =3D interactive_service;</span><br><span> </span><br><span> =
    for (int i =3D 1; i &lt; argc; i++)</span><br><span>@@ -237,7 +305,24 @=
@</span><br><span>         {</span><br><span>             if (_wcsicmp(L&qu=
ot;install&quot;, argv[i] + 1) =3D=3D 0)</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                return Cm=
dInstallServices();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                openvpn_service_type type =3D _service_max;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                if (argc &gt; i + 1=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
if (_wcsicmp(L&quot;automatic&quot;, argv[i + 1]) =3D=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        type =3D =
automatic;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             else if (_wcsicmp(L&quot;interactive&quot;, argv[i + 1]) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             type =3D interactive;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        wprintf(L&quot;Unknown serv=
ice &#39;%ls&#39;\n&quot;, argv[i + 1]);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        return 1;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                return CmdInstallService=
s(type);</span><br><span>             }</span><br><span>             else i=
f (_wcsicmp(L&quot;remove&quot;, argv[i] + 1) =3D=3D 0)</span><br><span>   =
          {</span><br><span>@@ -245,7 +330,16 @@</span><br><span>          =
   }</span><br><span>             else if (_wcsicmp(L&quot;start&quot;, arg=
v[i] + 1) =3D=3D 0)</span><br><span>             {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                return CmdStartService(interac=
tive);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   BOOL is_auto =3D argc &gt; i + 1 &amp;&amp; _wcsicmp(L&quot;automatic&qu=
ot;, argv[i + 1]) =3D=3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                return CmdStartService(is_auto ? automatic : intera=
ctive);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else i=
f (_wcsicmp(L&quot;automatic&quot;, argv[i] + 1) =3D=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                dispatchTable =3D dispatc=
hTable_automatic;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else if (_wcsicmp(L&quot;interactive&quot;, argv[i] + 1) =3D=3D 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                dispatchTable =
=3D dispatchTable_interactive;</span><br><span>             }</span><br><sp=
an>             else if (argc &gt; i + 2 &amp;&amp; _wcsicmp(L&quot;instanc=
e&quot;, argv[i] + 1) =3D=3D 0)</span><br><span>             {</span><br><s=
pan>@@ -265,13 +359,21 @@</span><br><span>             }</span><br><span>  =
           else</span><br><span>             {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                wprintf(L&quot;%ls -install       =
 to install the interactive service\n&quot;, APPNAME);</span><br><span>    =
             wprintf(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    L&quot;%ls -start [name]   to start the service (name =
=3D \&quot;interactive\&quot;) is optional\n&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    L&quot;%ls -install [=
name] to install services (name =3D \&quot;automatic\&quot; or \&quot;inter=
active\&quot;,\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    L&quot;                            defaults to both)=
\n&quot;,</span><br><span>                     APPNAME);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                wprintf(L&quot;%ls -remo=
ve         to remove the service\n&quot;, APPNAME);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                wprintf(</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    L&quot;%ls -star=
t [name]   to start a service (name =3D \&quot;automatic\&quot; or \&quot;i=
nteractive\&quot;,\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    L&quot;                            defaults to \=
&quot;interactive\&quot;)\n&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    APPNAME);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                wprintf(L&quot;%ls -remove        =
 to remove the services\n&quot;, APPNAME);</span><br><span> </span><br><spa=
n>                 wprintf(L&quot;\nService run-time parameters:\n&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                wpri=
ntf(L&quot;-automatic\n&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        L&quot;   Runs the automatic service=2E\n=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     wprintf(L&quot;-interactive\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        L&quot;   Runs the interactive=
 service=2E This is the default=2E\n&quot;);</span><br><span>              =
   wprintf(L&quot;-instance interactive &lt;id&gt;\n&quot;</span><br><span>=
                         L&quot;   Runs the service as an alternate instanc=
e=2E\n&quot;</span><br><span>                         L&quot;   The service=
 settings will be loaded from\n&quot;</span><br><span>diff --git a/src/open=
vpnserv/service=2Eh b/src/openvpnserv/service=2Eh</span><br><span>index c67=
d67f=2E=2E2c012d2 100644</span><br><span>--- a/src/openvpnserv/service=2Eh<=
/span><br><span>+++ b/src/openvpnserv/service=2Eh</span><br><span>@@ -47,6 =
+47,7 @@</span><br><span> </span><br><span> typedef enum</span><br><span> {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    automatic,</spa=
n><br><span>     interactive,</span><br><span>     _service_max</span><br><=
span> } openvpn_service_type;</span><br><span>@@ -58,6 +59,9 @@</span><br><=
span>     WCHAR *display_name;</span><br><span>     WCHAR *dependencies;</s=
pan><br><span>     DWORD start_type;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    WCHAR *arguments;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    WCHAR *account;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    WCHAR *required_privileges;</span><br><span> } openv=
pn_service_t;</span><br><span> </span><br><span> #define MAX_NAME 256</span=
><br><span>@@ -65,6 +69,7 @@</span><br><span> {</span><br><span>     WCHAR =
exe_path[MAX_PATH];</span><br><span>     WCHAR config_dir[MAX_PATH];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR autostart_config=
_dir[MAX_PATH];</span><br><span>     WCHAR bin_dir[MAX_PATH];</span><br><sp=
an>     WCHAR ext_string[16];</span><br><span>     WCHAR log_dir[MAX_PATH];=
</span><br><span>@@ -74,10 +79,11 @@</span><br><span>     BOOL append;</spa=
n><br><span> } settings_t;</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+extern openvpn_service_t automatic_service;</span>=
<br><span> extern openvpn_service_t interactive_service;</span><br><span> e=
xtern LPCWSTR service_instance;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-VOID WINAPI ServiceStartInteractiveOwn(DWORD ar=
gc, LPWSTR *argv);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+V=
OID WINAPI ServiceStartAutomatic(DWORD argc, LPWSTR *argv);</span><br><span=
> </span><br><span> VOID WINAPI ServiceStartInteractive(DWORD argc, LPWSTR =
*argv);</span><br><span> </span><br><span>@@ -90,6 +96,16 @@</span><br><spa=
n> DWORD MsgToEventLog(DWORD flags, LPCWSTR lpszMsg, =2E=2E=2E);</span><br>=
<span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Close a handle and invalidate it</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Nothing is done if the handle is invalid already, which makes it=
 safe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to call thi=
s function more than once for the same handle=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param handle  pointer to the handle to be closed</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+void CloseHandleEx(LPHANDLE handle);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span>  * Convert a UTF-8 string t=
o UTF-16</span><br><span>  *</span><br><span>  * The size parameter can be =
used to convert strings which contain inline NUL</span><br><span>diff --git=
 a/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests/unit_tests/openvpnser=
v/Makefile=2Eam</span><br><span>index 210c9e6=2E=2E07df5cc 100644</span><br=
><span>--- a/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>+++=
 b/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>@@ -3,16 +3,3=
6 @@</span><br><span> AM_TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_S=
TRING) service Unit-Tests&#39;</span><br><span> </span><br><span> if WIN32<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_binaries =3D open=
vpnserv_testdriver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_binaries =3D openvpnserv_testdriver openvpnserv_automatic_testdriver</s=
pan><br><span> endif</span><br><span> check_PROGRAMS =3D $(test_binaries)</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-openv=
pnserv_testdriver_CFLAGS  =3D -I$(top_srcdir)/include -I$(top_srcdir)/src/o=
penvpn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpnserv @TEST_CFL=
AGS@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpnserv_testd=
river_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# build the tests like openvpnserv=
 itself, see src/openvpnserv/Makefile=2Eam</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+openvpnserv_test_cflags =3D \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-municode -D_UNICODE \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	-UNTDDI_VERSION -D_WIN32_WINNT=3D_WI=
N32_WINNT_WIN10 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-=
I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/comp=
at \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir=
)/src/openvpnserv -I$(top_builddir)/src/openvpnserv \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/tests/unit_tests/openvpn=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpnserv_test_ldfla=
gs =3D -municode @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+openvpnserv_test_ldadd =3D \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	-ladvapi32 -luserenv -lip=
hlpapi -lfwpuclnt -lrpcrt4 \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+openvpnserv_testdriver_CFLAGS  =3D $(openvpnserv=
_test_cflags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvp=
nserv_testdriver_LDFLAGS =3D $(openvpnserv_test_ldflags)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+openvpnserv_testdriver_LDADD   =3D $(o=
penvpnserv_test_ldadd)</span><br><span> openvpnserv_testdriver_SOURCES =3D =
test_openvpnserv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpnserv/comm=
on=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpnserv/validate=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src//openvpn/wfp_block=2Ec \</span><br><span> =
	$(top_srcdir)/src//openvpn/wfp_block=2Eh</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+openvpnserv_automatic_testdriver_CF=
LAGS  =3D $(openvpnserv_test_cflags)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+openvpnserv_automatic_testdriver_LDFLAGS =3D $(openvpnserv=
_test_ldflags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openv=
pnserv_automatic_testdriver_LDADD   =3D $(openvpnserv_test_ldadd)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+openvpnserv_automatic_testdri=
ver_SOURCES =3D test_openvpnserv_automatic=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpnserv/common=2Ec</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> build-=
tests-local: $(check_PROGRAMS)</span><br><span>diff --git a/tests/unit_test=
s/openvpnserv/test_openvpnserv_automatic=2Ec b/tests/unit_tests/openvpnserv=
/test_openvpnserv_automatic=2Ec</span><br><span>new file mode 100644</span>=
<br><span>index 0000000=2E=2E7ccbd93</span><br><span>--- /dev/null</span><b=
r><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec</=
span><br><span>@@ -0,0 +1,238 @@</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
OpenVPN -- An application to securely tunnel IP networks</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port,=
 with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             session authentication and key exchange,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encry=
ption, packet authentication, and</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             packet compression=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
as published by the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Free Software Foundation, either version 2 of the License,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  or (at your option) any late=
r version=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dist=
ributed in the hope that it will be useful,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License =
for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should ha=
ve received a copy of the GNU General Public License along</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &=
lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE=
_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2E=
h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;win=
sock2=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &lt;windows=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * The automatic service cannot b=
e linked together with the interactive one</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * in a single test driver, as both define the same =
static service state=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;automatic=2Ec&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+BOOL</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ReportStatusToSCMgr(SERVICE_STA=
TUS_HANDLE svc_handle, SERVICE_STATUS *svc_status)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Parse a response like the one sent by =
the interactive service</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param res=
ponse  the response string</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param error     receives the error code of the response</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pid       receives=
 the process id of the response</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn the result of ParseInteractiveServiceResponse()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+parse_response(PCWSTR response, PDWORD error, PDWORD pid)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* the response is modified while parsing=
, so pass a copy */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    WCHAR buf[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(wcslen(response) &lt; _countof(buf));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    wcscpy(buf, response);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ParseInteractiveServiceResponse(buf, error=
, pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_response_success(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    DWORD error =3D 0xdeadbeef;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    DWORD pid =3D 0xdeadbeef;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(parse_response(L&quot;0x00000000\n0x0000=
04d2\nProcess ID&quot;, &amp;error, &amp;pid));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(error, 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pid, 1234);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_response_error(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    DWORD error =3D 0xdeadbeef;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    DWORD pid =3D 0xdeadbeef;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 An error response carries the name of the failed function in the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * second line, which mus=
t not be mistaken for a process id=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(parse_response(L&quot;0x0000007b\nCreateProcessAsUser=
\nThe filename is invalid&quot;, &amp;error,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                               &amp;pid));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(error,=
 0x7b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(pid, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_response_error_crlf(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    DWORD error =3D 0xdeadbeef;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    DWORD pid =3D 0xdeadbeef;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* error responses are built with For=
matMessage(), which uses \r\n line breaks */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(parse_response(L&quot;0x20000001\r=
\nYou have specified a config file location\r\n&quot;, &amp;error,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
   &amp;pid));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(error, 0x20000001);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(pid, 0);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_response_malfo=
rmed(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD error, pi=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* no line break at all */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(parse_re=
sponse(L&quot;0x00000000&quot;, &amp;error, &amp;pid));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* neither line is a number */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(parse_response(L&quot;he=
llo world\nnot a pid\nmessage&quot;, &amp;error, &amp;pid));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* the error code is a number with trailing garba=
ge */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fal=
se(parse_response(L&quot;0x00000000xyz\n0x000004d2\nProcess ID&quot;, &amp;=
error, &amp;pid));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* success respo=
nse without a process id */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_false(parse_response(L&quot;0x00000000\n&quot;, &amp;err=
or, &amp;pid));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* success response=
 with an empty process id line */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(parse_response(L&quot;0x00000000\n\nProcess =
ID&quot;, &amp;error, &amp;pid));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* the process id is a number with trailing garbage */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(parse_response(L&quot;0x=
00000000\n0x000004d2xyz\nProcess ID&quot;, &amp;error, &amp;pid));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* empty lines only */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(parse_response(L&quot;\=
n\n&quot;, &amp;error, &amp;pid));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_add_startup_data(void **s=
tate)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    WCHAR buf[32];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    size_t pos =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* the startup data is config dir + \0 + optio=
ns + \0 + password + \0 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(AddStartupData(buf, _countof(buf), &amp;pos, L&quot;=
C:\\cfg&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(pos, 7);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(AddStartupData(buf, _countof(buf), &amp;pos, L&quot;--log x&quot;));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(p=
os, 15);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* the password is empty, =
but still terminated */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(AddStartupData(buf, _countof(buf), &amp;pos, L&quot;&qu=
ot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(pos, 16);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the fields are=
 separated and terminated by zeros */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const WCHAR expected[] =3D L&quot;C:\\cfg\0--log x\0&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(pos, _countof(expected));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(wmemcmp(buf, expected, pos), 0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_add_startup_data_full(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    WCHAR buf[8];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    size_t pos =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wmemset(b=
uf, L&#39;#&#39;, _countof(buf));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* a string that does not fit is rejected without changing anything */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(AddStart=
upData(buf, _countof(buf), &amp;pos, L&quot;12345678&quot;));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pos, 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0=
; i &lt; _countof(buf); i++)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   assert_int_equal(buf[i], L&#39;#&#39;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a s=
tring whose terminator ends up as the last element still fits */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(AddStartupData=
(buf, _countof(buf), &amp;pos, L&quot;1234567&quot;));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pos, _countof(buf))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* but leaves no room for another=
 field, not even an empty one */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_false(AddStartupData(buf, _countof(buf), &amp;pos, =
L&quot;&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(pos, _countof(buf));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_log_file_path(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR path[MAX_PATH];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR name[MAX_PATH +=
 64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* the extension is replaced =
by =2Elog */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(GetLogFilePath(path, _countof(path), L&quot;C:\\log\\&quot;, L&quo=
t;office=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\office=2Elog&quot;),=
 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* a missing backslash on the =
log dir is added */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(GetLogFilePath(path, _countof(path), L&quot;C:\\log&quot;, =
L&quot;office=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\office=2Elog&qu=
ot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* only the last extensio=
n is replaced */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(GetLogFilePath(path, _countof(path), L&quot;C:\\log\\&quot;, L=
&quot;my=2Eoffice=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\my=2Eoffice=
=2Elog&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a name withou=
t an extension just gets one */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(GetLogFilePath(path, _countof(path), L&quot;C:\=
\log\\&quot;, L&quot;office&quot;));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\office=
=2Elog&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a name that i=
s nothing but an extension */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(GetLogFilePath(path, _countof(path), L&quot;C:\\l=
og\\&quot;, L&quot;=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\=2Elog&qu=
ot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* spaces are no problem =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(G=
etLogFilePath(path, _countof(path), L&quot;C:\\my logs\\&quot;, L&quot;my o=
ffice=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(wcscmp(path, L&quot;C:\\my logs\\my office=2Elog&quo=
t;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* a config file name that=
 cannot fit the log file name is an error */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    wmemset(name, L&#39;a&#39;, _countof(name) - 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    name[_countof=
(name) - 1] =3D L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(GetLogFilePath(path, _countof(path), L&quot;C:\=
\log\\&quot;, name));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a log dir =
that does not leave room for the name is an error */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(GetLogFilePath(path, 8, =
L&quot;C:\\some\\very\\long\\log\\dir&quot;, L&quot;office=2Eovpn&quot;));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+wmain(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_se=
tup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_response_success),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_respons=
e_error),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_response_error_crlf),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_response_malformed),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_add_startup_data),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        cmocka_unit_test(test_add_startup_data_full),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_log_=
file_path),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int ret =3D cmocka_run_group_tests_n=
ame(&quot;openvpnserv automatic service tests&quot;, tests, NULL, NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br></pre><p>To view, visit <a href=
=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail">change 200=
1</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D=
"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><d=
iv itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itempr=
op=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div s=
tyle=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D=
"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none">=
 Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id=
: I089e5b79600c535e3c0c5d1bb14319ac03f4144b </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Number: 2001 </div>
<div style=3D"display:none"> Gerrit-=
PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &l=
t;heiko@ist=2Eeigentlich=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Lev Stip=
akov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Selva Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Selv=
a Nair &lt;selva=2Enair@gmail=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Heiko Hund &lt;heiko@ist=2Eeigentl=
ich=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Sc=
hwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div=
>

</body></html>
--DCGr0wHRwnU=--


--===============4433210539689819541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4433210539689819541==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4433210539689819541==--

