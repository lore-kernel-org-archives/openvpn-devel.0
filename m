Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79090CCA462
	for <openvpn-devel@archiver.kernel.org>; Sat, 17 Oct 2026 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pIj6+7k0F9CegiBtPMpCq/PuXHOynHi/VpDVYR7uTY8=; b=DsKuaxbT7t5f6Cd9skLGKLpJSs
	QVCCmYZH2Faq3ef3I6AQDh4FWJZlNOM76ArHHQ1moRL9LsadHMjO8MtKn7BI1yna3WpbVzykhr6SH
	yqi1B43wst0vaNfxx9lfnwq6Svk8wiFSy1T3UsciXEztjOH/qDxy76S9uJQV7MaklWJ0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xI04W-0004j4-2g;
	Sat, 17 Oct 2026 08:47:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xI04N-0004f5-Lu
 for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 08:47:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=uQJHWeMZKTSmHaLmyuiFtiBBdf0DcmnRYSTnBoYhLfY=; b=a28jSas39ON5PrsaeZoRHxxVS4
 6BwP2wP2jGzdN6Cfqwhi22xJ7i5gaFdEdIEayCHFF1/KCoW0Au2TXxrbBQsT48DSgk+odm/f2jeSH
 nPD0oO+C0z9k2vI9gPnOrO/ev1pKLCBEAJFiznFiddzuVLwV7i5UOtBYMOi7sHlInuOM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uQJHWeMZKTSmHaLmyuiFtiBBdf0DcmnRYSTnBoYhLfY=; b=d
 RxvjjmfOUN4cmxgNGkoCInN3vN1TD1BO8VAWLS9FX+GMNQKFM/PlXC2tbL3Uu/lPz3CBBkcendqow
 QTRzmt0CY5cadOy6SAlpsO5gYd3dXC7Hk9x3xDX7U2kSIJLF5StWnuIjvuiFM0YFor9mTWChe0f6j
 7nvmwOc3QSFq6eLM=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xI04E-00057A-2L for openvpn-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 08:47:09 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a02667ccebso5102335e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792226815; x=1792831615; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=uQJHWeMZKTSmHaLmyuiFtiBBdf0DcmnRYSTnBoYhLfY=;
 b=WdlL2fstaTrFxcKYVSgHaSZ66/bml1eodzOVD8XSE8v5gwac7TF9ZVoq2iboyzKCgk
 sr7xy3CcI5YUvxp2BNq9BBeimi3GCx76G3zIoEP03oDfVFsVqG/f2/duTWc8BcqGQDtL
 s+6LK8Na59x0GWMSFcfdP0zY+qeWjiVtX40iv76mRy0DEBs2DG6X/ZBodtpGdBrG6Fyf
 TYLjUXRkXL9Ov/zfN0bB0tfydC8ycwEzDJligpeIAP66j2XzYh0z+hsjuzuzvPVV5i+y
 FA0CI67+IxkTNTtudWnDU8n34e0YHaVs3maGh2PizNpw5uTv/6jAD4VBBYJWkQ0wT+nv
 Bhag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792226815; x=1792831615;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=uQJHWeMZKTSmHaLmyuiFtiBBdf0DcmnRYSTnBoYhLfY=;
 b=c2beBwmhcLvLJFvBOdvyST1aafDOvDjyTHkRbk4QVfV7Ba7Emkk2KGegaAF2fH9X/c
 9kQ+Q15QaP6LouY/ye7oLtgS8a2C+vN9ulc8BuifN5ybgLtr1ieyR+cvdZlgNy245GPq
 XUl4y5k1qgj4SUsVTTx39WjdCer/3TCRHV+L6ncJeq8JzQ/RG/m8fCHbcdVYkfngSaXw
 yV4eKF1+0sXewWVTfIzQqiu+vR5npF4IMHSKogny+Lt2HG1D48gHu/XgxuGriZ18UtJC
 4JMOt0WWDm9QIzruV8HcqAeERuE+3kcfVSn3RR3K0ju3kljzJbR/+11UH8ND6b6FqVUl
 eufA==
X-Gm-Message-State: AFq9FYI5qPHVgfd6pF/ZDLUA9ITJlL1jTxcnTRUNlZIHYYGDFd7BZI6K
 82EtKrtgf0f+vtkuseMnLliBxCq3PW3ewjIMAYRAjT+s9wu/g43m+1HqgzA+VMEBaFEiocXBlMm
 ks7PFT1lQNm6DtE+Pem9lcGvSPiROqR+3Cu7nLxfJ2PiSNgvEjcV1aWid8qtkDQs2Snvt
X-Gm-Gg: AYBFou3+UbxH8f+tv8S8buSTmOzsJuPWKM/2APDf8D9PGdLqrIHlaejTgNxjw9aJ8yq
 B/ZCaOjW3i9VOqwRRlguDsrrdUWZA8gV29GVeJbj2hRmOGxcrjSFMq8DlAJT6ydIMnLrVtO5qV8
 yio3QuislcMd6eXWxOW5TBo7szHLGEntV17n7M/oE+bVEZI0fMYf6hzWu/TIuOlTsf9jlUbJTLt
 j8V2jM2Wy3xgC52X1BeUiO+sTEqi5BQSonRuWsRJFEuwMc+U/fq4ew+4nHceDmnGvWXjKKCB29Y
 FxVQuOC9GVzRFwDXluWKw/Bf3QzOOaBa98igSfjiFo1TGyNGgpcHQgs0bZsa5ezpBvBafKfJLeD
 drtNXc2zCxk4HAvvTWHXsiN2vDAiQiNwdU/otlAqJZlieO2GBEgm7NZ9yMcU0oLMingcxNG81L4
 fhf+KQ3DMM/Bxr/BESAMSMM0j25RDmX7gknZZ179/h+ZKNBAIgcnMo6GM/FMydJyKarxzEddtA/
 NcgugJ+5QYaTrpdRksz4DIKyTn/w+XExI6Nfd3A99KUM+B0Kk9Tm/n749kZtqomHq7NIe/o85fb
 HA7+N0bA3Htd4TjDxsEcweguy1Qa75JHvX6vIJDgc4e6bmwPqhhmmaBOGcI/
X-Received: by 2002:a05:600c:8708:b0:4a1:dbe7:705a with SMTP id
 5b1f17b1804b1-4a1dbe77320mr15318385e9.35.1792226814334; 
 Sat, 17 Oct 2026 01:46:54 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd9b8ebdsm241507925e9.10.2026.10.17.01.46.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 01:46:53 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 17 Oct 2026 08:46:51 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
X-Gerrit-Change-Number: 2001
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2001?usp=email>
X-Gerrit-Commit: 1896422807ad9616e71c8e8e99c921312cd21b25
In-Reply-To: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
References: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMTI4Mzg3MDAwLkkwODllNWI3OTYwMGM1MzVlM2MwYzVkMWJiMTQzMTlhYzAzZjQxNDRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0c6ab6003d09a9d603aeb44d994543ba7c6ba490-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xI04E-00057A-2L
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: openvpnserv: add
 automatic service again
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
From: "Heiko Hund \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: heiko@openvpn.net, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3019907310900100903=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3019907310900100903==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XOzTF0y9p88="; charset=UTF-8

--XOzTF0y9p88=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, 

I'd like you to reexamine a change=2E Please visit

  =
  https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail

to look at t=
he new patch set (#3)=2E


Change subject: openvpnserv: add automatic servi=
ce again
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

open=
vpnserv: add automatic service again

The automatic service, which starts a=
ll configs in the autostart config
directory, has been provided by the =2EN=
ET based openvpnserv2=2Eexe since
OpenVPN 2=2E4=2E Its original C implement=
ation in openvpnserv=2Eexe was removed
from this repository in 2021=2E Add =
it back, implemented in C, so that both
Windows services are maintained in =
this repository=2E

Security related changes added:
- before sending any da=
ta, verify that the named pipe is served by the
  interactive service proce=
ss
- the exit event of each OpenVPN process has a random name and a DACL
  =
that only grants access to its owner, so it cannot be pre-created or
  sign=
alled by other users
- the service checks that it is run as the ovpn_servic=
e_user account in
  the registry settings, so that it and openvpn in turn i=
s guaranteed to
  run with limited privileges

Robustness:
- starting a con=
fig is retried until the service stops, with a delay
  that doubles from 10=
 seconds up to 5 minutes for configs that keep
  failing, and is reset once=
 a process ran for a minute
- an OpenVPN process that may have been started=
 by a failed attempt is
  signalled to exit, so it does not run unmonitored=

- configs in subdirectories use their own directory as working
  directory=
; configs with the same file name as one found before are
  ignored, like i=
n the GUI

Both services now run in their own process, selected by the new
=
'-automatic' and '-interactive' options=2E This is needed since they need
t=
o run with different accounts=2E '-install' takes an optional service
name =
again=2E '-instance automatic' is not supported, since the service
cannot c=
heck the named pipe owner for instances=2E

Also add a few unit tests and s=
ome documentation=2E

Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
=
Signed-off-by: Heiko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M Changes=2Emd=

M doc/Makefile=2Eam
A doc/automatic-service-notes=2Erst
M src/openvpnserv/=
CMakeLists=2Etxt
M src/openvpnserv/Makefile=2Eam
A src/openvpnserv/automati=
c=2Ec
M src/openvpnserv/common=2Ec
M src/openvpnserv/interactive=2Ec
M src/=
openvpnserv/service=2Ec
M src/openvpnserv/service=2Eh
M tests/unit_tests/op=
envpnserv/Makefile=2Eam
A tests/unit_tests/openvpnserv/test_openvpnserv_aut=
omatic=2Ec
12 files changed, 1,653 insertions(+), 64 deletions(-)


  git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/2001/3

diff=
 --git a/Changes=2Emd b/Changes=2Emd
index 5c3270b=2E=2E813ac33 100644
--- =
a/Changes=2Emd
+++ b/Changes=2Emd
@@ -23,6 +23,33 @@
   the characters ment=
ioned above were already escaped=2E However, the behavior of
   Mbed TLS is=
 slightly different from OpenSSL in that it also escapes "=3D"=2E
 
+* **Wi=
ndows automatic service moved back into this repository**
+
+  OpenVPNServi=
ce, which starts all configs in the `config-auto` directory at
+  boot time=
, is no longer provided by the =2ENET based `openvpnserv2=2Eexe`, but by
+ =
 `openvpnserv=2Eexe`, like the interactive service is=2E It mostly works li=
ke the
+  service it was ported from, with these exceptions and additions:
=
+
+  * The service can no longer be run on the command line, but exclusivel=
y as
+    a service through the Service Control Manager=2E
+  * The service=
 refuses to start if it does not run as the account
+    `NT SERVICE\OpenVP=
NService`=2E This is checked for security reasons: OpenVPN
+    runs under =
the same account, so its configs, scripts and plugins would get
+    all pr=
ivileges of a more privileged account as well=2E
+  * All service related l=
ogging is done via event log=2E The event source changed
+    from `OpenVpn=
Service` to `openvpnserv`, same as for the interactive one=2E
+  * An OpenV=
PN process that cannot be started or exits is started again,
+    first aft=
er 10 seconds, with the delay doubling up to 5 minutes for
+    processes t=
hat keep failing=2E
+  * Configs in subdirectories of `config-auto` use the=
ir own directory as
+    working directory=2E Of several configs with the s=
ame file name, only the
+    first one found is started, like in the OpenVP=
N GUI=2E
+  * The automatic and the interactive service now each run in a p=
rocess of
+    their own, selected by the `-automatic` and `-interactive` o=
ptions of
+    `openvpnserv=2Eexe`=2E `-install` takes an optional service =
name=2E
+  * `-instance automatic` is not supported on purpose=2E It cannot=
 verify the
+    interactive service named pipe for instances before connec=
ting=2E
+
 ## Maintainer-visible changes
 
 - The configure-time option `--=
enable-debug` is no longer  available
diff --git a/doc/Makefile=2Eam b/doc/=
Makefile=2Eam
index 5ca1c4d=2E=2Ebbd83cd 100644
--- a/doc/Makefile=2Eam
+++=
 b/doc/Makefile=2Eam
@@ -55,6 +55,7 @@
 
 dist_noinst_DATA =3D \
 	android=
=2Etxt \
+	automatic-service-notes=2Erst \
 	interactive-service-notes=2Ers=
t \
 	keying-material-exporter=2Etxt \
 	openvpn=2E8=2Erst \
diff --git a/d=
oc/automatic-service-notes=2Erst b/doc/automatic-service-notes=2Erst
new fi=
le mode 100644
index 0000000=2E=2E4c1858c
--- /dev/null
+++ b/doc/automatic=
-service-notes=2Erst
@@ -0,0 +1,151 @@
+OpenVPN Automatic Service Notes
+=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
+
+
+Introduction
+------------
+
+OpenVPN Automatic Ser=
vice, also known as "OpenVPNService", is a Windows system
+service which st=
arts an OpenVPN process for each configuration file in the
+autostart confi=
guration folder, ``config-auto`` by default=2E It is meant for
+connections=
 that should be up at all times, independent of any user being
+logged on=
=2E
+
+
+How It Works
+------------
+
+The Automatic Service does not start=
 OpenVPN itself, but uses the Interactive
+Service to do it, the same way O=
penVPN GUI does=2E See
+`interactive-service-notes=2Erst` for how the Inter=
active Service works=2E
+
+- On start, the service searches the autostart c=
onfiguration folder and its
+  subfolders, up to a depth of 32, for files w=
ith the configuration file
+  extension=2E
+
+- For each configuration file=
 it connects to the Interactive Service named
+  pipe ``\\=2E\pipe\openvpn\=
service`` and sends the startup data=2E Before sending
+  anything it check=
s that the pipe is served by the Interactive Service
+  process, as registe=
red with the Service Control Manager=2E
+
+- The Interactive Service starts=
 openvpn=2Eexe with the account of the
+  Automatic Service=2E It allows th=
is account to use any options and
+  configuration files in any folder, see=
 `Service Account`_=2E
+
+- The folder of the configuration file is used as=
 the working folder, so
+  relative paths in a configuration file resolve r=
elative to its folder=2E
+
+- openvpn=2Eexe is started with these options::=

+
+      --log <log file> --config <config file> --service <exit event> 0
=
+      --pull-filter ignore route-method
+
+  ``--log-append`` is used inst=
ead of ``--log`` if configured=2E The exit event
+  is created by the Autom=
atic Service before each start=2E It has a random name
+  and only its owne=
r, the service account, has access to it=2E
+
+- When the service stops, it=
 signals the exit events, which makes the
+  OpenVPN processes exit=2E
+
+C=
onfiguration files are identified by their file name, like in OpenVPN GUI=
=2E
+If there are several configuration files with the same file name in
+d=
ifferent subfolders, only the first one found is started and an error is
+l=
ogged for the others=2E Files in a folder are found before those in its
+su=
bfolders=2E
+
+
+Restarting OpenVPN Processes
+----------------------------=

+
+An OpenVPN process that exits, or that cannot be started, is started ag=
ain
+until the service stops=2E The first attempt is made after 10 seconds=
=2E The
+delay doubles with each further failure, up to 5 minutes=2E It is =
reset to 10
+seconds once an OpenVPN process has run for at least a minute=
=2E
+
+This also covers the Interactive Service not being reachable, for ex=
ample
+while it is restarted=2E The configurations are started again with t=
he next
+attempt after it is available again=2E
+
+
+Service Account
+-----=
----------
+
+The Automatic Service runs with the virtual service account
+=
``NT SERVICE\OpenVPNService``=2E The OpenVPN processes it starts run with t=
his
+account too, so configuration files and anything they reference, like =
keys
+and certificates, including those in the Windows certificate store, m=
ust be
+readable by it=2E The log folder must be writable by it=2E
+
+The s=
ervice refuses to start if it runs with any other account=2E OpenVPN
+runs =
with the same account, so configuration files, scripts and plugins
+would g=
et all privileges of a more privileged account, like LocalSystem, as
+well=
=2E The service is installed with its required privileges reduced to
+``SeC=
hangeNotifyPrivilege``, which also removes privileges such as
+``SeImperson=
atePrivilege`` from the OpenVPN processes=2E
+
+The Interactive Service let=
s the account ``NT SERVICE\<ovpn_service_user>``
+use any options, see `Con=
figuration`_=2E The account the Automatic Service
+checks for is derived fr=
om the same registry value, so both always agree=2E
+
+
+Configuration
+---=
----------
+
+The Automatic Service reads its settings from the
+``HKEY_LOC=
AL_MACHINE\SOFTWARE\OpenVPN`` registry key, like the Interactive
+Service=
=2E All the following registry values are of the ``REG_SZ`` type:
+
+``auto=
start_config_dir``
+   The autostart configuration folder=2E If this value =
does not exist or is
+   empty, no configurations are started=2E The instal=
ler sets it to
+   ``install_dir "\config-auto"``=2E
+
+``config_ext``
+   =
The configuration file extension, without a leading dot; defaults to
+   ``=
"ovpn"``=2E
+
+``log_dir``
+   The folder for the log files; defaults to ``=
install_dir "\log"``=2E The
+   installer sets it to ``%ProgramData%\OpenVP=
N\Log`` and makes it writable
+   for the service account=2E Each OpenVPN p=
rocess logs to a file in this
+   folder, named like its configuration file=
, with the extension replaced by
+   ``=2Elog``=2E
+
+``log_append``
+   ``=
"1"`` to append to existing log files, ``"0"`` (default) to truncate
+   th=
em when an OpenVPN process is started=2E
+
+``ovpn_service_user``
+   The n=
ame of the service account, without the ``NT SERVICE\`` prefix;
+   default=
s to ``"OpenVPNService"``=2E Used by the Interactive Service to
+   authori=
ze the Automatic Service and by the Automatic Service to check
+   its own =
account=2E
+
+The values ``exe_path`` and ``priority`` described in
+`inter=
active-service-notes=2Erst` apply too, as the Interactive Service starts
+t=
he OpenVPN processes=2E
+
+The service writes its own messages to the Windo=
ws event log, using the
+``openvpnserv`` event source, the same as the Inte=
ractive Service=2E
+
+
+Installation
+------------
+
+The OpenVPN installer=
 registers the service, whether or not the "OpenVPN
+Service" feature is se=
lected=2E Without the feature it is disabled, otherwise
+it is set to start=
 automatically and started=2E Upgrades keep the start mode
+and running sta=
te of the service=2E
+
+The services can also be registered from an elevate=
d command prompt::
+
+      openvpnserv=2Eexe -install [automatic|interacti=
ve]
+
+Without a name, both services are registered=2E A service that is re=
gistered
+already is left alone=2E The Automatic Service is registered with=
 the
+``-automatic`` option, its account, the dependency on the Interactive=
 Service
+and its reduced privileges=2E Both services run in a process of t=
heir own,
+selected by the ``-automatic`` and ``-interactive`` options=2E
+=

+Unlike the Interactive Service, the Automatic Service does not support th=
e
+``-instance`` option for side-by-side installations=2E
diff --git a/src/=
openvpnserv/CMakeLists=2Etxt b/src/openvpnserv/CMakeLists=2Etxt
index 2cc4a=
93=2E=2Edbb7651 100644
--- a/src/openvpnserv/CMakeLists=2Etxt
+++ b/src/ope=
nvpnserv/CMakeLists=2Etxt
@@ -35,6 +35,7 @@
 add_common_options(openvpnserv=
)
 target_sources(openvpnserv PRIVATE
     common=2Ec
+    automatic=2Ec
  =
   interactive=2Ec
     service=2Ec service=2Eh
     validate=2Ec validate=
=2Eh
@@ -82,6 +83,7 @@
 if (BUILD_TESTING)
     set(unit_tests
         "te=
st_openvpnserv"
+        "test_openvpnserv_automatic"
     )
 
     foreach=
 (test_name ${unit_tests})
@@ -104,4 +106,8 @@
         validate=2Ec
      =
   =2E=2E/openvpn/wfp_block=2Ec =2E=2E/openvpn/wfp_block=2Eh
     )
+
+    =
target_sources(test_openvpnserv_automatic PRIVATE
+        common=2Ec
+    =
)
 endif ()
diff --git a/src/openvpnserv/Makefile=2Eam b/src/openvpnserv/Ma=
kefile=2Eam
index 447fb10=2E=2Ed3ca665 100644
--- a/src/openvpnserv/Makefil=
e=2Eam
+++ b/src/openvpnserv/Makefile=2Eam
@@ -35,6 +35,7 @@
 
 openvpnserv=
_SOURCES =3D \
         common=2Ec \
+	automatic=2Ec \
 	interactive=2Ec \
=
 	service=2Ec service=2Eh \
 	validate=2Ec validate=2Eh \
diff --git a/src/=
openvpnserv/automatic=2Ec b/src/openvpnserv/automatic=2Ec
new file mode 100=
644
index 0000000=2E=2E4ad4202
--- /dev/null
+++ b/src/openvpnserv/automati=
c=2Ec
@@ -0,0 +1,1020 @@
+/*
+ *  OpenVPN -- An application to securely tun=
nel IP networks
+ *             over a single TCP/UDP port, with support fo=
r SSL/TLS-based
+ *             session authentication and key exchange,
+ =
*             packet encryption, packet authentication, and
+ *            =
 packet compression=2E
+ *
+ *  Copyright (C) 2026- OpenVPN Inc <sales@open=
vpn=2Enet>
+ *
+ *  This program is free software; you can redistribute it =
and/or modify
+ *  it under the terms of the GNU General Public License ver=
sion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This p=
rogram is distributed in the hope that it will be useful,
+ *  but WITHOUT =
ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or =
FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Licens=
e for more details=2E
+ *
+ *  You should have received a copy of the GNU G=
eneral Public License along
+ *  with this program; if not, see <https://ww=
w=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * The automatic service=
 starts one OpenVPN process for each configuration
+ * file found in the au=
tostart config directory and restarts them when they
+ * exit unexpectedly=
=2E The OpenVPN processes are not started directly, but by
+ * the interact=
ive service, which this service talks to via its named pipe=2E
+ */
+
+#inc=
lude "service=2Eh"
+
+#include <handleapi=2Eh>
+#include <pathcch=2Eh>
+#in=
clude <rpc=2Eh>
+#include <sddl=2Eh>
+#include <stdio=2Eh>
+#include <stdli=
b=2Eh>
+
+/** Time we give the interactive service to accept our connection=
 */
+#define ISERVICE_CONNECT_TIMEOUT 5000 /*ms*/
+
+/**
+ * Time we wait b=
efore an OpenVPN process is started again, after it exited
+ * or could not=
 be started=2E The delay doubles with each failed attempt=2E
+ */
+#define =
RESTART_DELAY_MIN 10000 /*ms*/
+
+/** Maximum time we wait before an OpenVP=
N process is started again */
+#define RESTART_DELAY_MAX 300000 /*ms*/
+
+/=
** Time after which a running OpenVPN process resets the delay to the minim=
um */
+#define STABLE_RUNTIME 60000 /*ms*/
+
+/** Maximum size of the start=
up data sent to the interactive service */
+#define STARTUP_DATA_MAX 2048
+=

+/** Maximum recursion depth when searching for configuration files */
+#d=
efine MAX_RECURSION_DEPTH 32
+
+/** Name of the interactive service we talk=
 to */
+#define ISERVICE_NAME _L(PACKAGE_NAME) L"ServiceInteractive"
+
+/**=
 The service cannot run without the interactive service, so we make it depe=
nd on it=2E */
+#define AUTOMATIC_SERVICE_DEPENDENCIES ISERVICE_NAME L"\0\0=
"
+
+/** The service runs as its own virtual service account, which the int=
eractive service trusts */
+#define AUTOMATIC_SERVICE_ACCOUNT L"NT SERVICE\=
\" _L(PACKAGE_NAME) L"Service"
+
+/** The service needs no privileges besid=
es the one every process has */
+#define AUTOMATIC_SERVICE_PRIVILEGES L"SeC=
hangeNotifyPrivilege\0\0"
+
+openvpn_service_t automatic_service =3D { auto=
matic,
+                                        _L(PACKAGE_NAME) L"Service"=
,
+                                        _L(PACKAGE_NAME) L" Automatic Se=
rvice",
+                                        AUTOMATIC_SERVICE_DEPENDEN=
CIES,
+                                        SERVICE_DEMAND_START,
+     =
                                   L"-automatic",
+                        =
                // cppcheck-suppress unknownMacro ; FP, _L after a string l=
iteral
+                                        AUTOMATIC_SERVICE_ACCOUNT,
=
+                                        AUTOMATIC_SERVICE_PRIVILEGES };
+
=
+static SERVICE_STATUS_HANDLE service;
+static SERVICE_STATUS status =3D { =
=2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS };
+static HANDLE exit_event=
 =3D NULL;
+
+static settings_t settings;
+
+/** One OpenVPN connection, i=
=2Ee=2E one configuration file */
+typedef struct openvpn_process
+{
+    s=
truct openvpn_process *next;
+    WCHAR working_dir[MAX_PATH];
+    WCHAR c=
onfig_file[MAX_PATH];
+    WCHAR log_file[MAX_PATH];
+    HANDLE process;
+=
    HANDLE exit_event;
+    HANDLE stop_event;
+    HANDLE thread;
+    CRI=
TICAL_SECTION cs;
+} openvpn_process_t;
+
+/** Linked list of OpenVPN conne=
ctions / configuration files */
+static openvpn_process_t *processes =3D NU=
LL;
+
+/**
+ * Add the zero terminated string \p str to \p buf=2E
+ *
+ * I=
f successful, \p pos points to the character after the terminating NUL=2E
+=
 *
+ * @param buf   string buffer to append to
+ * @param size  size of the=
 buffer in wide characters
+ * @param pos   [in,out] position in the buffer=
 in wide characters
+ * @param str   the string to append
+ *
+ * @return B=
OOL to indicate success or failure
+ */
+static BOOL
+AddStartupData(PWSTR =
buf, size_t size, size_t *pos, PCWSTR str)
+{
+    size_t len =3D wcslen(st=
r) + 1;
+
+    if (*pos + len > size)
+    {
+        return FALSE;
+    }
=
+
+    wmemcpy(buf + *pos, str, len);
+    *pos +=3D len;
+
+    return TRU=
E;
+}
+
+/**
+ * Get the process id of the interactive service
+ *
+ * @ret=
urn the process id, or 0 if the service is not running or on error
+ */
+st=
atic DWORD
+GetInteractiveServicePid(void)
+{
+    DWORD pid =3D 0;
+
+    =
SC_HANDLE scm =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);
+    if (!=
scm)
+    {
+        return 0;
+    }
+
+    SC_HANDLE svc =3D OpenService(=
scm, ISERVICE_NAME, SERVICE_QUERY_STATUS);
+    if (svc)
+    {
+        SE=
RVICE_STATUS_PROCESS ssp;
+        DWORD needed;
+        if (QueryServiceS=
tatusEx(svc, SC_STATUS_PROCESS_INFO, (LPBYTE)&ssp, sizeof(ssp), &needed)
+ =
           && ssp=2EdwCurrentState =3D=3D SERVICE_RUNNING)
+        {
+    =
        pid =3D ssp=2EdwProcessId;
+        }
+        CloseServiceHandle(s=
vc);
+    }
+
+    CloseServiceHandle(scm);
+    return pid;
+}
+
+/**
+ * =
Check that the server end of \p pipe is the interactive service
+ *
+ * Mak=
es sure we do not send data to, or can be impersonated by, a process
+ * wh=
ich created a pipe with the interactive service's pipe name=2E
+ *
+ * @par=
am pipe  the connected pipe handle
+ *
+ * @return BOOL to indicate whether=
 the pipe server is the interactive service
+ */
+static BOOL
+IsInteractiv=
eServicePipe(HANDLE pipe)
+{
+    ULONG server_pid;
+    if (!GetNamedPipeS=
erverProcessId(pipe, &server_pid))
+    {
+        return FALSE;
+    }
+
+=
    DWORD iservice_pid =3D GetInteractiveServicePid();
+    return iservice=
_pid !=3D 0 && server_pid =3D=3D iservice_pid;
+}
+
+/**
+ * Connect to the=
 named pipe of the interactive service
+ *
+ * The connection is only retur=
ned if the pipe is served by the
+ * interactive service process=2E
+ *
+ *=
 @param timeout  maximum time in ms to wait for the pipe to become availabl=
e
+ *
+ * @return pipe handle, or INVALID_HANDLE_VALUE on error
+ */
+stati=
c HANDLE
+ConnectToInteractiveService(DWORD timeout)
+{
+    WCHAR pipe_nam=
e[256];
+    ULONGLONG deadline =3D GetTickCount64() + timeout;
+
+    swpr=
intf(pipe_name, _countof(pipe_name), L"\\\\=2E\\pipe\\" _L(PACKAGE) L"%ls\\=
service", service_instance);
+
+    while (TRUE)
+    {
+        HANDLE pip=
e =3D CreateFile(pipe_name, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXI=
STING, 0, NULL);
+        if (pipe !=3D INVALID_HANDLE_VALUE)
+        {
+ =
           DWORD mode =3D PIPE_READMODE_MESSAGE;
+            if (!SetNamed=
PipeHandleState(pipe, &mode, NULL, NULL))
+            {
+                C=
loseHandle(pipe);
+                return INVALID_HANDLE_VALUE;
+          =
  }
+            if (!IsInteractiveServicePipe(pipe))
+            {
+     =
           MsgToEventLog(M_ERR, L"Pipe %ls is not served by the interactive=
 service", pipe_name);
+                CloseHandle(pipe);
+               =
 SetLastError(ERROR_ACCESS_DENIED);
+                return INVALID_HANDLE_=
VALUE;
+            }
+            return pipe;
+        }
+
+        DWORD=
 error =3D GetLastError();
+        ULONGLONG now =3D GetTickCount64();
+  =
      if (now >=3D deadline)
+        {
+            SetLastError(error);
+=
            return INVALID_HANDLE_VALUE;
+        }
+
+        if (error =
=3D=3D ERROR_PIPE_BUSY)
+        {
+            /* All pipe instances are b=
usy, wait for one to become available */
+            if (!WaitNamedPipe(pi=
pe_name, (DWORD)(deadline - now)))
+            {
+                return I=
NVALID_HANDLE_VALUE;
+            }
+        }
+        else if (error =3D=
=3D ERROR_FILE_NOT_FOUND)
+        {
+            /* The interactive servic=
e may not have created the pipe yet */
+            Sleep(50);
+        }
+=
        else
+        {
+            SetLastError(error);
+            retu=
rn INVALID_HANDLE_VALUE;
+        }
+    }
+}
+
+/**
+ * Split off the firs=
t line of \p str
+ *
+ * Lines end with "\\n" or "\\r\\n" in error response=
s of the interactive service=2E
+ *
+ * @param str  the string to split, it=
s first line is zero terminated in place
+ *
+ * @return the start of the n=
ext line, or NULL if there is none
+ */
+static PWSTR
+SplitLine(PWSTR str)=

+{
+    PWSTR eol =3D wcschr(str, L'\n');
+    if (!eol)
+    {
+        r=
eturn NULL;
+    }
+
+    *eol =3D L'\0';
+    if (eol > str && eol[-1] =3D=
=3D L'\r')
+    {
+        eol[-1] =3D L'\0';
+    }
+
+    return eol + 1;=

+}
+
+/**
+ * Parse the response of the interactive service
+ *
+ * The re=
sponse is a three line string, with the error code in the first,
+ * the pr=
ocess id in the second if OpenVPN was started successfully and
+ * a messag=
e in the third line=2E
+ *
+ * @param response  the zero terminated respons=
e, which is modified
+ * @param error     receives the error code returned =
by the service
+ * @param pid       receives the process id of the OpenVPN =
process
+ *
+ * @return BOOL to indicate success or failure
+ */
+static BO=
OL
+ParseInteractiveServiceResponse(PWSTR response, PDWORD error, PDWORD pi=
d)
+{
+    PWSTR pid_line =3D SplitLine(response);
+    if (!pid_line)
+   =
 {
+        SetLastError(ERROR_INVALID_DATA);
+        return FALSE;
+    }=

+    SplitLine(pid_line);
+
+    PWSTR end;
+    *error =3D wcstoul(respon=
se, &end, 16);
+    if (end =3D=3D response || *end !=3D L'\0')
+    {
+   =
     SetLastError(ERROR_INVALID_DATA);
+        return FALSE;
+    }
+
+   =
 *pid =3D 0;
+    if (*error =3D=3D 0)
+    {
+        *pid =3D wcstoul(pid=
_line, &end, 16);
+        if (end =3D=3D pid_line || *end !=3D L'\0')
+   =
     {
+            SetLastError(ERROR_INVALID_DATA);
+            return F=
ALSE;
+        }
+    }
+
+    return TRUE;
+}
+
+/**
+ * Read the response=
 of the interactive service from the pipe
+ *
+ * @param pipe   the pipe to=
 read the response from
+ * @param error  receives the error code returned =
by the service
+ * @param pid    receives the process id of the OpenVPN pro=
cess
+ *
+ * @return BOOL to indicate success or failure
+ */
+static BOOL
=
+ReadInteractiveServiceResponse(HANDLE pipe, PDWORD error, PDWORD pid)
+{
+=
    WCHAR buf[1024];
+    DWORD bytes;
+
+    if (!ReadFile(pipe, buf, size=
of(buf) - sizeof(buf[0]), &bytes, NULL))
+    {
+        return FALSE;
+   =
 }
+
+    buf[bytes / sizeof(buf[0])] =3D L'\0';
+
+    return ParseInterac=
tiveServiceResponse(buf, error, pid);
+}
+
+/**
+ * Build the path of the l=
og file of a configuration file
+ *
+ * The log file is named like the conf=
iguration file \p name, with its
+ * extension replaced by "=2Elog", and is=
 placed in \p log_dir=2E
+ *
+ * @param log_file  buffer that receives the =
log file path
+ * @param size      size of the buffer in wide characters
+ =
* @param log_dir   the directory the log file is placed in
+ * @param name =
     the file name of the configuration file
+ *
+ * @return BOOL to indica=
te success or failure
+ */
+static BOOL
+GetLogFilePath(PWSTR log_file, siz=
e_t size, PCWSTR log_dir, PCWSTR name)
+{
+    WCHAR log_name[MAX_PATH];
+ =
   PCWSTR dot =3D wcsrchr(name, L'=2E');
+    int len =3D dot ? (int)(dot -=
 name) : (int)(wcslen(name));
+
+    return swprintf(log_name, _countof(log=
_name), L"%=2E*ls=2Elog", len, name) >=3D 0
+           && PathCchCombine(l=
og_file, size, log_dir, log_name) =3D=3D S_OK;
+}
+
+/**
+ * Create the eve=
nt used to signal an OpenVPN process to exit
+ *
+ * The name of the event =
is random, so others cannot create it in advance
+ * and keep it under thei=
r control=2E Should the name exist already anyway,
+ * another one is tried=
=2E Only the owner of the event has access to it=2E
+ * OpenVPN runs with t=
he same account as this service, so it can open the
+ * event by its name=
=2E
+ *
+ * @param name  buffer that receives the name of the event
+ * @pa=
ram size  size of the buffer in wide characters
+ *
+ * @return the event h=
andle, or INVALID_HANDLE_VALUE on error
+ */
+static HANDLE
+CreateExitEven=
t(PWSTR name, size_t size)
+{
+    SECURITY_ATTRIBUTES sa =3D { =2EnLength =
=3D sizeof(sa) };
+    HANDLE event =3D INVALID_HANDLE_VALUE;
+
+    if (!C=
onvertStringSecurityDescriptorToSecurityDescriptorW(
+            L"D:P(A;;=
GA;;;OW)", SDDL_REVISION_1, &sa=2ElpSecurityDescriptor, NULL))
+    {
+    =
    return event;
+    }
+
+    const int max_tries =3D 3;
+    for (int tr=
ies =3D 0; tries < max_tries; tries++)
+    {
+        UUID uuid;
+        =
RPC_WSTR uuid_str;
+        if (UuidCreate(&uuid) !=3D RPC_S_OK || UuidToSt=
ringW(&uuid, &uuid_str) !=3D RPC_S_OK)
+        {
+            break;
+    =
    }
+        swprintf(name, size, _L(PACKAGE) L"_exit_%ls", (PWSTR)uuid_s=
tr);
+        RpcStringFreeW(&uuid_str);
+
+        event =3D CreateEvent(&=
sa, TRUE, FALSE, name);
+        if (event && GetLastError() !=3D ERROR_ALR=
EADY_EXISTS)
+        {
+            break;
+        }
+        CloseHandle=
Ex(&event);
+    }
+    LocalFree(sa=2ElpSecurityDescriptor);
+
+    if (ev=
ent =3D=3D INVALID_HANDLE_VALUE)
+    {
+        MsgToEventLog(M_ERR, L"Cou=
ld not create exit event=2E");
+    }
+
+    return event;
+}
+
+/**
+ * St=
art an OpenVPN process for a configuration file
+ *
+ * Connects to the int=
eractive service, sends the startup data and reads
+ * back the process id =
of the started OpenVPN process=2E
+ *
+ * @param p  the process to start
+ =
*
+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+StartP=
rocess(openvpn_process_t *p)
+{
+    WCHAR cmdline[STARTUP_DATA_MAX];
+    =
WCHAR startup_data[STARTUP_DATA_MAX];
+    WCHAR exit_event_name[MAX_PATH];=

+    HANDLE pipe =3D INVALID_HANDLE_VALUE;
+    size_t pos =3D 0;
+    DWO=
RD error, pid, written;
+    BOOL ret =3D FALSE;
+
+    /* each OpenVPN pro=
cess gets a new exit event */
+    HANDLE event =3D CreateExitEvent(exit_ev=
ent_name, _countof(exit_event_name));
+    if (event =3D=3D INVALID_HANDLE_=
VALUE)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not create exit even=
t for config %ls", p->config_file);
+        return FALSE;
+    }
+
+    co=
nst WCHAR *log_option =3D settings=2Eappend ? L"--log-append" : L"--log";
+=
    int n =3D swprintf(cmdline, _countof(cmdline),
+                     L"=
%ls \"%ls\" --config \"%ls\" --service \"%ls\" 0 --pull-filter ignore route=
-method",
+                     log_option, p->log_file, p->config_file, ex=
it_event_name);
+    if (n < 0)
+    {
+        MsgToEventLog(M_ERR, L"Comm=
and line too long for config %ls", p->config_file);
+        goto out;
+   =
 }
+
+    /* working dir + \0 + options + \0 + password + \0 */
+    if (!A=
ddStartupData(startup_data, _countof(startup_data), &pos, p->working_dir)
+=
        || !AddStartupData(startup_data, _countof(startup_data), &pos, cmdl=
ine)
+        || !AddStartupData(startup_data, _countof(startup_data), &pos=
, L""))
+    {
+        MsgToEventLog(M_ERR, L"Startup data too long for co=
nfig %ls", p->config_file);
+        goto out;
+    }
+
+    pipe =3D Conne=
ctToInteractiveService(ISERVICE_CONNECT_TIMEOUT);
+    if (pipe =3D=3D INVA=
LID_HANDLE_VALUE)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not conne=
ct to the interactive service");
+        goto out;
+    }
+
+    if (!Writ=
eFile(pipe, startup_data, (DWORD)(pos * sizeof(startup_data[0])), &written,=
 NULL))
+    {
+        MsgToEventLog(M_SYSERR, L"Could not send startup da=
ta to interactive service");
+        goto out;
+    }
+
+    if (!ReadInte=
ractiveServiceResponse(pipe, &error, &pid))
+    {
+        MsgToEventLog(M=
_SYSERR, L"Could not read response from iservice");
+        goto out;
+   =
 }
+
+    if (error !=3D 0)
+    {
+        MsgToEventLog(M_ERR, L"Error st=
arting openvpn process: %lu", error);
+        goto out;
+    }
+
+    /*
+=
     * The interactive service restricts access to the OpenVPN process=2E I=
t does
+     * not grant PROCESS_QUERY_LIMITED_INFORMATION, but PROCESS_QUE=
RY_INFORMATION=2E
+     */
+    HANDLE process =3D OpenProcess(SYNCHRONIZE =
| PROCESS_QUERY_INFORMATION, FALSE, pid);
+    if (!process)
+    {
+      =
  MsgToEventLog(M_SYSERR, L"Could not open OpenVPN process, PID %lu", pid);=

+        goto out;
+    }
+
+    EnterCriticalSection(&p->cs);
+    CloseH=
andleEx(&p->process);
+    CloseHandleEx(&p->exit_event);
+    p->process =
=3D process;
+    p->exit_event =3D event;
+    event =3D NULL;
+    LeaveC=
riticalSection(&p->cs);
+
+    MsgToEventLog(M_INFO, L"Started openvpn proc=
ess %lu for config %ls", pid, p->config_file);
+    ret =3D TRUE;
+
+out:
+=
    /*
+     * An OpenVPN process may have been started, even if we could n=
ot get a
+     * handle of it or did not receive the response=2E Make sure =
it exits, as
+     * it would not be monitored nor stopped otherwise=2E
+  =
   */
+    if (!ret && event)
+    {
+        SetEvent(event);
+    }
+    =
CloseHandleEx(&pipe);
+    CloseHandleEx(&event);
+    return ret;
+}
+
+/*=
*
+ * Signal an OpenVPN process to exit
+ *
+ * @param p  the process to si=
gnal
+ */
+static void
+SignalProcess(openvpn_process_t *p)
+{
+    EnterCr=
iticalSection(&p->cs);
+    if (p->process && WaitForSingleObject(p->proces=
s, 0) =3D=3D WAIT_TIMEOUT
+        && !SetEvent(p->exit_event))
+    {
+   =
     DWORD pid =3D GetProcessId(p->process);
+        MsgToEventLog(M_SYSER=
R, L"Error signalling PID %lu to exit", pid);
+    }
+    LeaveCriticalSect=
ion(&p->cs);
+}
+
+/**
+ * Run the OpenVPN process for a config and restart=
 it when it exits
+ *
+ * Starting the process is retried until the service=
 stops=2E The delay
+ * between the attempts grows when a process cannot be=
 started or exits
+ * right away, so a broken config does not keep the syst=
em busy=2E
+ *
+ * @param process  the process to run
+ */
+static DWORD WI=
NAPI
+MonitorProcess(LPVOID process)
+{
+    openvpn_process_t *p =3D proce=
ss;
+    DWORD delay =3D RESTART_DELAY_MIN;
+
+    while (TRUE)
+    {
+   =
     ULONGLONG started =3D GetTickCount64();
+        if (StartProcess(p))
=
+        {
+            HANDLE handles[2];
+
+            EnterCriticalSect=
ion(&p->cs);
+            handles[0] =3D p->stop_event;
+            handle=
s[1] =3D p->process;
+            DWORD pid =3D GetProcessId(p->process);
+=
            LeaveCriticalSection(&p->cs);
+
+            if (WaitForMultipl=
eObjects(2, handles, FALSE, INFINITE) =3D=3D WAIT_OBJECT_0)
+            {
=
+                break;
+            }
+
+            MsgToEventLog(M_INFO,=
 L"OpenVPN process %lu for config %ls has exited", pid,
+                  =
        p->config_file);
+
+            /* a process that ran for a while d=
id not fail right away */
+            if (GetTickCount64() - started >=3D =
STABLE_RUNTIME)
+            {
+                delay =3D RESTART_DELAY_MIN=
;
+            }
+        }
+
+        MsgToEventLog(M_INFO, L"Starting con=
fig %ls again in %lu sec", p->config_file,
+                      delay / 1=
000);
+
+        if (WaitForSingleObject(p->stop_event, delay) =3D=3D WAIT_=
OBJECT_0)
+        {
+            break;
+        }
+
+        delay =3D mi=
n(delay * 2, RESTART_DELAY_MAX);
+    }
+
+    return NO_ERROR;
+}
+
+/**
+=
 * Find a process entry with a config file named \p name
+ *
+ * @param nam=
e  the file name of the config, without the path
+ *
+ * @return the proces=
s entry, or NULL if there is none
+ */
+static openvpn_process_t *
+FindPro=
cessByName(PCWSTR name)
+{
+    for (openvpn_process_t *p =3D processes; p;=
 p =3D p->next)
+    {
+        PCWSTR p_name =3D wcsrchr(p->config_file, L=
'\\');
+        p_name =3D p_name ? p_name + 1 : p->config_file;
+        i=
f (_wcsicmp(p_name, name) =3D=3D 0)
+        {
+            return p;
+    =
    }
+    }
+    return NULL;
+}
+
+/**
+ * Create a process entry for \p =
config_file and start the thread
+ * that runs the OpenVPN process for it=
=2E
+ *
+ * A config with the same file name as one that was found before i=
s ignored,
+ * as both would use the same log file=2E This is in line with =
how openvpn-gui
+ * handles duplicates=2E
+ *
+ * @param working_dir  the d=
irectory the config file is in
+ * @param config_file  path of the configur=
ation file
+ */
+static void
+StartConfig(PCWSTR working_dir, PCWSTR config=
_file)
+{
+    PCWSTR name =3D wcsrchr(config_file, L'\\');
+    name =3D n=
ame ? name + 1 : config_file;
+
+    openvpn_process_t *dup =3D FindProcess=
ByName(name);
+    if (dup)
+    {
+        MsgToEventLog(M_ERR, L"Config %=
ls has the same file name as %ls, ignoring it",
+                      conf=
ig_file, dup->config_file);
+        return;
+    }
+
+    openvpn_process_=
t *p =3D calloc(1, sizeof(*p));
+    if (!p)
+    {
+        MsgToEventLog(=
M_ERR, L"Out of memory starting openvpn for %ls", config_file);
+        re=
turn;
+    }
+
+    if (!GetLogFilePath(p->log_file, _countof(p->log_file),=
 settings=2Elog_dir, name))
+    {
+        MsgToEventLog(M_ERR, L"Error st=
arting openvpn for %ls", config_file);
+        free(p);
+        return;
+=
    }
+
+    p->stop_event =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+    i=
f (!p->stop_event)
+    {
+        MsgToEventLog(M_SYSERR, L"Error starting=
 openvpn for %ls", config_file);
+        free(p);
+        return;
+    }
=
+
+    wcsncpy(p->working_dir, working_dir, _countof(p->working_dir) - 1);
=
+    wcsncpy(p->config_file, config_file, _countof(p->config_file) - 1);
+ =
   InitializeCriticalSection(&p->cs);
+
+    p->next =3D processes;
+    pr=
ocesses =3D p;
+
+    p->thread =3D CreateThread(NULL, 0, MonitorProcess, p=
, 0, NULL);
+    if (!p->thread)
+    {
+        MsgToEventLog(M_SYSERR, L"=
Could not create monitoring thread for %ls", config_file);
+    }
+}
+
+/**=

+ * Recursively find configuration files in \p dir
+ * and run OpenVPN for=
 each of them=2E
+ *
+ * @param dir   the directory to search
+ * @param le=
vel the current recursion depth
+ */
+static void
+StartConfigsInDir(PCWSTR=
 dir, DWORD level)
+{
+    WCHAR ext_pattern[_countof(settings=2Eext_string=
) + 2];
+    WCHAR pattern[MAX_PATH];
+    WCHAR path[MAX_PATH];
+    WIN32=
_FIND_DATA find_data;
+    HANDLE find;
+
+    if (level > MAX_RECURSION_DE=
PTH)
+    {
+        MsgToEventLog(M_INFO, L"Maximum recursion depth reache=
d=2E Ignoring config dir %ls", dir);
+        return;
+    }
+
+    swprint=
f(ext_pattern, _countof(ext_pattern), L"*=2E%ls", settings=2Eext_string);
+=

+    /* Run configs in dir */
+    if (PathCchCombine(pattern, _countof(pa=
ttern), dir, ext_pattern) =3D=3D S_OK)
+    {
+        find =3D FindFirstFi=
le(pattern, &find_data);
+        if (find !=3D INVALID_HANDLE_VALUE)
+    =
    {
+            do
+            {
+                BOOL directory =3D (f=
ind_data=2EdwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) !=3D 0;
+          =
      if (!directory && PathCchCombine(path, _countof(path), dir, find_data=
=2EcFileName) =3D=3D S_OK)
+                {
+                    StartCon=
fig(dir, path);
+                }
+            } while (FindNextFile(find,=
 &find_data));
+
+            FindClose(find);
+        }
+    }
+
+    if =
(PathCchCombine(pattern, _countof(pattern), dir, L"*") !=3D S_OK)
+    {
+ =
       return;
+    }
+
+    /* Try to recurse */
+    find =3D FindFirstFi=
le(pattern, &find_data);
+    if (find !=3D INVALID_HANDLE_VALUE)
+    {
+ =
       do
+        {
+            if (find_data=2EdwFileAttributes & FILE_A=
TTRIBUTE_DIRECTORY
+                && wcscmp(find_data=2EcFileName, L"=2E"=
) !=3D 0
+                && wcscmp(find_data=2EcFileName, L"=2E=2E") !=3D =
0
+                && PathCchCombine(path, _countof(path), dir, find_data=
=2EcFileName) =3D=3D S_OK)
+            {
+                StartConfigsInDi=
r(path, level + 1);
+            }
+        } while (FindNextFile(find, &fi=
nd_data));
+
+        FindClose(find);
+    }
+}
+
+/**
+ * Start an OpenVP=
N process for every config found in the autostart
+ * config directory=2E
+=
 *
+ * Having nothing to start is not an error=2E Like an autostart config
=
+ * directory without any config files in it, it leaves the service running=

+ * without any processes=2E
+ */
+static void
+StartAllProcesses(void)
+{=

+    /* starting configs automatically is optional */
+    if (settings=2E=
autostart_config_dir[0] =3D=3D L'\0')
+    {
+        MsgToEventLog(M_INFO,=
 L"No autostart config directory configured");
+        return;
+    }
+
+ =
   DWORD attr =3D GetFileAttributes(settings=2Eautostart_config_dir);
+    =
if (attr =3D=3D INVALID_FILE_ATTRIBUTES || !(attr & FILE_ATTRIBUTE_DIRECTOR=
Y))
+    {
+        MsgToEventLog(M_ERR, L"Autostart config directory does =
not exist at %ls",
+                      settings=2Eautostart_config_dir);=

+        return;
+    }
+
+    StartConfigsInDir(settings=2Eautostart_conf=
ig_dir, 0);
+
+    if (!processes)
+    {
+        MsgToEventLog(M_INFO, L"=
No configs found in %ls", settings=2Eautostart_config_dir);
+    }
+}
+
+/*=
*
+ * Stop all OpenVPN processes and wait for their monitoring threads
+ */=

+static void
+StopAllProcesses(void)
+{
+    for (openvpn_process_t *p =3D=
 processes; p; p =3D p->next)
+    {
+        SetEvent(p->stop_event);
+   =
 }
+
+    for (openvpn_process_t *p =3D processes; p; p =3D p->next)
+    {=

+        if (p->thread)
+        {
+            WaitForSingleObject(p->thr=
ead, INFINITE);
+            CloseHandleEx(&p->thread);
+        }
+    }
+=

+    for (openvpn_process_t *p =3D processes; p; p =3D p->next)
+    {
+  =
      SignalProcess(p);
+    }
+}
+
+/**
+ * Free the list of processes
+ *=
/
+static void
+FreeAllProcesses(void)
+{
+    openvpn_process_t *p =3D pro=
cesses;
+
+    while (p)
+    {
+        openvpn_process_t *next =3D p->nex=
t;
+
+        CloseHandleEx(&p->process);
+        CloseHandleEx(&p->exit_e=
vent);
+        CloseHandleEx(&p->stop_event);
+        DeleteCriticalSecti=
on(&p->cs);
+        free(p);
+
+        p =3D next;
+    }
+
+    processe=
s =3D NULL;
+}
+
+
+/**
+ * Check that the service runs under its virtual s=
ervice account
+ *
+ * The interactive service lets NT SERVICE\\<ovpn_servi=
ce_user> start OpenVPN
+ * with any options=2E Running as a more privileged=
 account, like LocalSystem,
+ * would run all configs with these elevated p=
rivileges=2E So, rather refuse
+ * to run as any other account, in case an =
admin is adventurous=2E
+ *
+ * @param s  the settings, with the name of th=
e service account
+ *
+ * @return BOOL to indicate whether we run as the se=
rvice account
+ */
+static BOOL
+IsRunningAsServiceAccount(const settings_t=
 *s)
+{
+    BOOL ret =3D FALSE;
+
+    /*
+     * A TOKEN_USER with room f=
or the largest possible SID after it=2E The sid
+     * member alone is use=
d for the SID of the account, as it is aligned=2E
+     */
+    struct
+   =
 {
+        TOKEN_USER token_user;
+        BYTE sid[SECURITY_MAX_SID_SIZE]=
;
+    } token_user_info, account_info;
+
+    WCHAR account[MAX_NAME];
+  =
  DWORD sid_size =3D sizeof(account_info=2Esid);
+    WCHAR domain[MAX_NAME=
];
+    DWORD domain_size =3D _countof(domain);
+    SID_NAME_USE use;
+
+ =
   swprintf(account, _countof(account), L"NT SERVICE\\%ls", s->ovpn_service=
_user);
+    if (!LookupAccountName(NULL, account, account_info=2Esid, &sid=
_size, domain, &domain_size, &use))
+    {
+        MsgToEventLog(M_SYSERR,=
 L"Could not look up account %ls", account);
+        return FALSE;
+    }
=
+
+    HANDLE token;
+    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_=
QUERY, &token))
+    {
+        MsgToEventLog(M_SYSERR, L"Could not open pr=
ocess token");
+        return FALSE;
+    }
+
+    DWORD len;
+    BOOL go=
t_user =3D
+        GetTokenInformation(token, TokenUser, &token_user_info,=
 sizeof(token_user_info), &len);
+    CloseHandle(token);
+    if (!got_use=
r)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not get token user");
+ =
       return FALSE;
+    }
+
+    ret =3D EqualSid(token_user_info=2Etoken=
_user=2EUser=2ESid, account_info=2Esid);
+    if (!ret)
+    {
+        Msg=
ToEventLog(M_ERR, L"Service must run as %ls, refusing to start", account);
=
+    }
+
+    return ret;
+}
+
+
+static DWORD WINAPI
+ServiceCtrlAutomatic=
(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
+{
+    SERVICE_STA=
TUS *svc_status =3D ctx;
+    switch (ctrl_code)
+    {
+        case SERVI=
CE_CONTROL_STOP:
+            svc_status->dwCurrentState =3D SERVICE_STOP_P=
ENDING;
+            /* threads may be connecting to the interactive servic=
e */
+            svc_status->dwWaitHint =3D ISERVICE_CONNECT_TIMEOUT + 100=
0;
+            ReportStatusToSCMgr(service, svc_status);
+            if (=
exit_event)
+            {
+                SetEvent(exit_event);
+        =
    }
+            return NO_ERROR;
+
+        case SERVICE_CONTROL_INTERRO=
GATE:
+            return NO_ERROR;
+
+        default:
+            return=
 ERROR_CALL_NOT_IMPLEMENTED;
+    }
+}
+
+
+VOID WINAPI
+ServiceStartAutoma=
tic(DWORD dwArgc, LPWSTR *lpszArgv)
+{
+    DWORD error =3D NO_ERROR;
+
+  =
  service =3D RegisterServiceCtrlHandlerEx(automatic_service=2Ename, Servic=
eCtrlAutomatic, &status);
+    if (!service)
+    {
+        return;
+    }=

+
+    status=2EdwCurrentState =3D SERVICE_START_PENDING;
+    status=2Edw=
ServiceSpecificExitCode =3D NO_ERROR;
+    status=2EdwWin32ExitCode =3D NO_=
ERROR;
+    status=2EdwWaitHint =3D 3000;
+
+    if (!ReportStatusToSCMgr(s=
ervice, &status))
+    {
+        MsgToEventLog(M_ERR, L"ReportStatusToSCMg=
r SERVICE_START_PENDING failed");
+        goto finish;
+    }
+
+    /*
+ =
    * Create our exit event
+     * This event is initially created in the =
non-signaled state=2E It will
+     * transition to the signaled state when=
 we have received a terminate
+     * signal from the Service Control Manag=
er=2E
+     */
+    exit_event =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+ =
   if (!exit_event)
+    {
+        error =3D MsgToEventLog(M_SYSERR, L"Cre=
ateEvent for exit event failed");
+        goto finish;
+    }
+
+    /* Re=
ad settings from registry */
+    error =3D GetOpenvpnSettings(&settings);
=
+    if (error !=3D ERROR_SUCCESS)
+    {
+        goto finish;
+    }
+
+ =
   if (!IsRunningAsServiceAccount(&settings))
+    {
+        error =3D ERR=
OR_ACCESS_DENIED;
+        goto finish;
+    }
+
+    StartAllProcesses();
=
+
+    status=2EdwCurrentState =3D SERVICE_RUNNING;
+    status=2EdwWaitHin=
t =3D 0;
+    if (!ReportStatusToSCMgr(service, &status))
+    {
+        M=
sgToEventLog(M_ERR, L"ReportStatusToSCMgr SERVICE_RUNNING failed");
+      =
  goto finish;
+    }
+
+    if (WaitForSingleObject(exit_event, INFINITE) =
!=3D WAIT_OBJECT_0)
+    {
+        MsgToEventLog(M_ERR, L"wait for shutdow=
n signal failed");
+    }
+
+finish:
+    StopAllProcesses();
+    FreeAllP=
rocesses();
+
+    CloseHandleEx(&exit_event);
+
+    status=2EdwCurrentSta=
te =3D SERVICE_STOPPED;
+    status=2EdwWin32ExitCode =3D error;
+    Repor=
tStatusToSCMgr(service, &status);
+}
diff --git a/src/openvpnserv/common=2E=
c b/src/openvpnserv/common=2Ec
index 7a23d41=2E=2E10a5207 100644
--- a/src/=
openvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -38,7 +38,7 @@
 =
    if (status =3D=3D ERROR_FILE_NOT_FOUND && default_value)
     {
       =
  size_t len =3D size / sizeof(data[0]);
-        if (swprintf(data, len, d=
efault_value))
+        if (swprintf(data, len, default_value) >=3D 0)
    =
     {
             status =3D ERROR_SUCCESS;
         }
@@ -116,6 +116,14 =
@@
         goto out;
     }
 
+    /* an empty autostart config dir means =
configs are not started automatically */
+    error =3D GetRegString(key, L=
"autostart_config_dir", s->autostart_config_dir,
+                         =
sizeof(s->autostart_config_dir), L"");
+    if (error !=3D ERROR_SUCCESS)
+=
    {
+        goto out;
+    }
+
     swprintf(default_value, _countof(def=
ault_value), L"%ls\\bin\\", install_path);
     error =3D GetRegString(key,=
 L"bin_dir", s->bin_dir, sizeof(s->bin_dir), default_value);
     if (error=
 !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s->bin_dir, _countof(s->b=
in_dir)))
@@ -123,7 +131,7 @@
         goto out;
     }
 
-    error =3D Ge=
tRegString(key, L"config_ext", s->ext_string, sizeof(s->ext_string), L"=2Eo=
vpn");
+    error =3D GetRegString(key, L"config_ext", s->ext_string, sizeo=
f(s->ext_string), L"ovpn");
     if (error !=3D ERROR_SUCCESS)
     {
     =
    goto out;
@@ -292,6 +300,19 @@
     return error;
 }
 
+void
+CloseHand=
leEx(LPHANDLE handle)
+{
+    if (handle)
+    {
+        if (*handle && *h=
andle !=3D INVALID_HANDLE_VALUE)
+        {
+            CloseHandle(*handl=
e);
+        }
+        *handle =3D INVALID_HANDLE_VALUE;
+    }
+}
+
 wcha=
r_t *
 utf8to16_size(const char *utf8, int size)
 {
diff --git a/src/openvp=
nserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index d8cf6e1=2E=2E=
f9b0a73 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/=
interactive=2Ec
@@ -49,7 +49,7 @@
 #define ERROR_MESSAGE_TYPE    0x20000003=

 
 static SERVICE_STATUS_HANDLE service;
-static SERVICE_STATUS status =3D=
 { =2EdwServiceType =3D SERVICE_WIN32_SHARE_PROCESS };
+static SERVICE_STAT=
US status =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS };
 static H=
ANDLE exit_event =3D NULL;
 static settings_t settings;
 static HANDLE rdns=
_semaphore =3D NULL;
@@ -58,9 +58,14 @@
 #define TUN_IOCTL_REGISTER_RINGS \=

     CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE=
_DATA)
 
-openvpn_service_t interactive_service =3D { interactive, _L(PACKA=
GE_NAME) L"ServiceInteractive",
+openvpn_service_t interactive_service =3D =
{ interactive,
+                                          _L(PACKAGE_NAME) =
L"ServiceInteractive",
                                           _L(PACKAG=
E_NAME) L" Interactive Service",
-                                         =
 SERVICE_DEPENDENCIES, SERVICE_AUTO_START };
+                             =
             SERVICE_DEPENDENCIES,
+                                       =
   SERVICE_AUTO_START,
+                                          L"-intera=
ctive",
+                                          NULL,
+                 =
                         NULL };
 
 
 typedef struct
@@ -172,18 +177,6 @@
 =
    return data;
 }
 
-
-static HANDLE
-CloseHandleEx(LPHANDLE handle)
-{
-=
    if (handle && *handle && *handle !=3D INVALID_HANDLE_VALUE)
-    {
-   =
     CloseHandle(*handle);
-        *handle =3D INVALID_HANDLE_VALUE;
-    =
}
-    return INVALID_HANDLE_VALUE;
-}
-
 static HANDLE
 InitOverlapped(LPO=
VERLAPPED overlapped)
 {
@@ -3910,13 +3903,6 @@
 }
 
 
-VOID WINAPI
-Servic=
eStartInteractiveOwn(DWORD dwArgc, LPWSTR *lpszArgv)
-{
-    status=2EdwSer=
viceType =3D SERVICE_WIN32_OWN_PROCESS;
-    ServiceStartInteractive(dwArgc=
, lpszArgv);
-}
-
 /**
  * Clean up remains of previous sessions in registr=
y=2E These remains can
  * happen with unclean shutdowns or crashes and wou=
ld interfere with
diff --git a/src/openvpnserv/service=2Ec b/src/openvpnser=
v/service=2Ec
index 2913f63=2E=2E292816c 100644
--- a/src/openvpnserv/servi=
ce=2Ec
+++ b/src/openvpnserv/service=2Ec
@@ -52,22 +52,52 @@
     return re=
s;
 }
 
+/**
+ * Restrict a service to the privileges it actually needs
+ *=

+ * Also gives the service its own SID, which is required for running it
+=
 * as a virtual service account=2E
+ *
+ * @param service     handle of the=
 service, with SERVICE_CHANGE_CONFIG access
+ * @param privileges  double z=
ero terminated list of privilege names
+ *
+ * @return BOOL to indicate suc=
cess or failure
+ */
+static BOOL
+SetServicePrivileges(SC_HANDLE service, =
WCHAR *privileges)
+{
+    SERVICE_SID_INFO sid_info =3D { SERVICE_SID_TYPE=
_UNRESTRICTED };
+    SERVICE_REQUIRED_PRIVILEGES_INFO priv_info =3D { priv=
ileges };
+
+    return ChangeServiceConfig2(service, SERVICE_CONFIG_SERVIC=
E_SID_INFO, &sid_info)
+           && ChangeServiceConfig2(service, SERVICE=
_CONFIG_REQUIRED_PRIVILEGES_INFO, &priv_info);
+}
+
+/**
+ * Install the se=
rvices
+ *
+ * A service that is installed already counts as success, so th=
is can be
+ * run repeatedly, e=2Eg=2E by the MSI installer after an upgrad=
e=2E
+ *
+ * @param type  the service to install, or _service_max for all o=
f them
+ *
+ * @return the number of services that could not be installed
+=
 */
 static int
-CmdInstallServices(void)
+CmdInstallServices(openvpn_servi=
ce_type type)
 {
     SC_HANDLE svc_ctl_mgr;
+    WCHAR exe_path[MAX_PATH];=

     WCHAR path[512];
-    int i, ret =3D _service_max;
+    int ret =3D 0=
;
 
-    if (GetModuleFileName(NULL, path + 1, _countof(path) - 2) =3D=3D 0=
)
+    DWORD len =3D GetModuleFileName(NULL, exe_path, _countof(exe_path));=

+    if (len =3D=3D 0 || len =3D=3D _countof(exe_path))
     {
         wp=
rintf(L"Unable to install service - %ls\n", GetLastErrorText());
         r=
eturn 1;
     }
 
-    path[0] =3D L'\"';
-    wcscat_s(path, _countof(path=
), L"\"");
-
     svc_ctl_mgr =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONN=
ECT | SC_MANAGER_CREATE_SERVICE);
     if (svc_ctl_mgr =3D=3D NULL)
     {
=
@@ -75,22 +105,60 @@
         return 1;
     }
 
-    for (i =3D 0; i < _se=
rvice_max; i++)
+    for (int i =3D 0; i < _service_max; i++)
     {
-     =
   SC_HANDLE service =3D CreateService(
-            svc_ctl_mgr, openvpn_s=
ervice[i]=2Ename, openvpn_service[i]=2Edisplay_name,
-            SERVICE_Q=
UERY_STATUS, SERVICE_WIN32_SHARE_PROCESS, openvpn_service[i]=2Estart_type,
=
-            SERVICE_ERROR_NORMAL, path, NULL, NULL, openvpn_service[i]=2Ed=
ependencies, NULL, NULL);
-        if (service)
+        if (type !=3D _ser=
vice_max && type !=3D (openvpn_service_type)i)
         {
-            wpri=
ntf(L"%ls installed=2E\n", openvpn_service[i]=2Edisplay_name);
-           =
 CloseServiceHandle(service);
-            --ret;
+            continue;
  =
       }
-        else
+
+        openvpn_service_t *ovpn_svc =3D &openvpn_=
service[i];
+
+        /* each service runs in its own process, selected by=
 the arguments */
+        swprintf(path, _countof(path), L"\"%ls\"%ls%ls",=
 exe_path,
+                 ovpn_svc->arguments ? L" " : L"", ovpn_svc->ar=
guments ? ovpn_svc->arguments : L"");
+
+        /*
+         * A service t=
hat was just deleted stays marked for deletion until
+         * all handle=
s to it are closed, e=2Eg=2E by an open services=2Emsc=2E
+         */
+   =
     int tries =3D 10;
+        SC_HANDLE service;
+        while (!(servic=
e =3D CreateService(svc_ctl_mgr, ovpn_svc->name, ovpn_svc->display_name,
+ =
                                        SERVICE_QUERY_STATUS | SERVICE_CHAN=
GE_CONFIG | DELETE,
+                                         SERVICE_WIN32=
_OWN_PROCESS, ovpn_svc->start_type,
+                                      =
   SERVICE_ERROR_NORMAL, path, NULL, NULL,
+                               =
          ovpn_svc->dependencies, ovpn_svc->account, NULL))
+              =
 && GetLastError() =3D=3D ERROR_SERVICE_MARKED_FOR_DELETE && --tries)
     =
    {
+            Sleep(1000);
+        }
+
+        if (!service)
+      =
  {
+            if (GetLastError() =3D=3D ERROR_SERVICE_EXISTS)
+         =
   {
+                wprintf(L"%ls is installed already=2E\n", ovpn_svc->d=
isplay_name);
+                continue;
+            }
             wprint=
f(L"CreateService failed - %ls\n", GetLastErrorText());
+            ++ret;=

+            continue;
         }
+
+        if (ovpn_svc->required_privil=
eges
+            && !SetServicePrivileges(service, ovpn_svc->required_priv=
ileges))
+        {
+            /* do not leave a service with too many pr=
ivileges behind */
+            wprintf(L"Restricting privileges failed - %=
ls\n", GetLastErrorText());
+            DeleteService(service);
+         =
   CloseServiceHandle(service);
+            ++ret;
+            continue;
=
+        }
+
+        wprintf(L"%ls installed=2E\n", ovpn_svc->display_name=
);
+        CloseServiceHandle(service);
     }
 
     CloseServiceHandle(s=
vc_ctl_mgr);
@@ -140,7 +208,6 @@
 static int
 CmdRemoveServices(void)
 {
- =
   SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
     SERVICE_STATUS statu=
s;
     int i, ret =3D _service_max;
@@ -155,12 +222,13 @@
     for (i =3D =
0; i < _service_max; i++)
     {
         openvpn_service_t *ovpn_svc =3D &=
openvpn_service[i];
-        service =3D
+        SC_HANDLE service =3D
   =
          OpenService(svc_ctl_mgr, ovpn_svc->name, DELETE | SERVICE_STOP | =
SERVICE_QUERY_STATUS);
         if (service =3D=3D NULL)
         {
+      =
      /* the service may not be installed, continue with the next one */
  =
           wprintf(L"OpenService failed - %ls\n", GetLastErrorText());
-   =
         goto out;
+            continue;
         }
 
         /* try to s=
top the service */
@@ -206,7 +274,6 @@
         CloseServiceHandle(service)=
;
     }
 
-out:
     CloseServiceHandle(svc_ctl_mgr);
     return ret;
 }
=
@@ -215,20 +282,21 @@
 int
 wmain(int argc, WCHAR *argv[])
 {
-    /*
-    =
 * Interactive service (as a SERVICE_WIN32_SHARE_PROCESS)
-     * This is t=
he default=2E
-     */
-    const SERVICE_TABLE_ENTRY dispatchTable_shared[=
] =3D {
-        { interactive_service=2Ename, ServiceStartInteractive }, {=
 NULL, NULL }
-    };
-
-    /* Interactive service only (as a SERVICE_WIN3=
2_OWN_PROCESS) */
-    const SERVICE_TABLE_ENTRY dispatchTable_interactive[=
] =3D { { L"", ServiceStartInteractiveOwn },
+    /* Interactive service (a=
s a SERVICE_WIN32_OWN_PROCESS), this is the default */
+    const SERVICE_T=
ABLE_ENTRY dispatchTable_interactive[] =3D { { L"", ServiceStartInteractive=
 },
                                                               { NULL, =
NULL } };
 
-    const SERVICE_TABLE_ENTRY *dispatchTable =3D dispatchTable=
_shared;
+    /*
+     * Automatic service (as a SERVICE_WIN32_OWN_PROCESS)=

+     * It has to run in a process of its own, as it runs with an account
=
+     * that is less privileged than the one of the interactive service=2E
=
+     */
+    const SERVICE_TABLE_ENTRY dispatchTable_automatic[] =3D { { L=
"", ServiceStartAutomatic },
+                                             =
               { NULL, NULL } };
 
+    const SERVICE_TABLE_ENTRY *dispatch=
Table =3D dispatchTable_interactive;
+
+    openvpn_service[automatic] =3D =
automatic_service;
     openvpn_service[interactive] =3D interactive_servic=
e;
 
     for (int i =3D 1; i < argc; i++)
@@ -237,7 +305,24 @@
         {
=
             if (_wcsicmp(L"install", argv[i] + 1) =3D=3D 0)
             {=

-                return CmdInstallServices();
+                openvpn_ser=
vice_type type =3D _service_max;
+                if (argc > i + 1)
+      =
          {
+                    if (_wcsicmp(L"automatic", argv[i + 1]) =
=3D=3D 0)
+                    {
+                        type =3D automati=
c;
+                    }
+                    else if (_wcsicmp(L"interact=
ive", argv[i + 1]) =3D=3D 0)
+                    {
+                      =
  type =3D interactive;
+                    }
+                    else
+ =
                   {
+                        wprintf(L"Unknown service '%l=
s'\n", argv[i + 1]);
+                        return 1;
+                  =
  }
+                }
+                return CmdInstallServices(type);
  =
           }
             else if (_wcsicmp(L"remove", argv[i] + 1) =3D=3D =
0)
             {
@@ -245,7 +330,16 @@
             }
             else if =
(_wcsicmp(L"start", argv[i] + 1) =3D=3D 0)
             {
-                =
return CmdStartService(interactive);
+                BOOL is_auto =3D argc=
 > i + 1 && _wcsicmp(L"automatic", argv[i + 1]) =3D=3D 0;
+                =
return CmdStartService(is_auto ? automatic : interactive);
+            }
+=
            else if (_wcsicmp(L"automatic", argv[i] + 1) =3D=3D 0)
+       =
     {
+                dispatchTable =3D dispatchTable_automatic;
+       =
     }
+            else if (_wcsicmp(L"interactive", argv[i] + 1) =3D=3D 0=
)
+            {
+                dispatchTable =3D dispatchTable_interacti=
ve;
             }
             else if (argc > i + 2 && _wcsicmp(L"instanc=
e", argv[i] + 1) =3D=3D 0)
             {
@@ -265,13 +359,21 @@
           =
  }
             else
             {
-                wprintf(L"%ls -instal=
l        to install the interactive service\n", APPNAME);
                 =
wprintf(
-                    L"%ls -start [name]   to start the service (n=
ame =3D \"interactive\") is optional\n",
+                    L"%ls -instal=
l [name] to install services (name =3D \"automatic\" or \"interactive\",\n"=

+                    L"                            defaults to both)\n",
 =
                    APPNAME);
-                wprintf(L"%ls -remove       =
  to remove the service\n", APPNAME);
+                wprintf(
+          =
          L"%ls -start [name]   to start a service (name =3D \"automatic\" =
or \"interactive\",\n"
+                    L"                            d=
efaults to \"interactive\")\n",
+                    APPNAME);
+           =
     wprintf(L"%ls -remove         to remove the services\n", APPNAME);
 
 =
                wprintf(L"\nService run-time parameters:\n");
+            =
    wprintf(L"-automatic\n"
+                        L"   Runs the automati=
c service=2E\n");
+                wprintf(L"-interactive\n"
+             =
           L"   Runs the interactive service=2E This is the default=2E\n");=

                 wprintf(L"-instance interactive <id>\n"
                 =
        L"   Runs the service as an alternate instance=2E\n"
              =
           L"   The service settings will be loaded from\n"
diff --git a/sr=
c/openvpnserv/service=2Eh b/src/openvpnserv/service=2Eh
index c67d67f=2E=2E=
2c012d2 100644
--- a/src/openvpnserv/service=2Eh
+++ b/src/openvpnserv/serv=
ice=2Eh
@@ -47,6 +47,7 @@
 
 typedef enum
 {
+    automatic,
     interacti=
ve,
     _service_max
 } openvpn_service_type;
@@ -58,6 +59,9 @@
     WCHAR=
 *display_name;
     WCHAR *dependencies;
     DWORD start_type;
+    WCHAR=
 *arguments;
+    WCHAR *account;
+    WCHAR *required_privileges;
 } openv=
pn_service_t;
 
 #define MAX_NAME 256
@@ -65,6 +69,7 @@
 {
     WCHAR exe_p=
ath[MAX_PATH];
     WCHAR config_dir[MAX_PATH];
+    WCHAR autostart_config=
_dir[MAX_PATH];
     WCHAR bin_dir[MAX_PATH];
     WCHAR ext_string[16];
  =
   WCHAR log_dir[MAX_PATH];
@@ -74,10 +79,11 @@
     BOOL append;
 } settin=
gs_t;
 
+extern openvpn_service_t automatic_service;
 extern openvpn_servic=
e_t interactive_service;
 extern LPCWSTR service_instance;
 
-VOID WINAPI S=
erviceStartInteractiveOwn(DWORD argc, LPWSTR *argv);
+VOID WINAPI ServiceSt=
artAutomatic(DWORD argc, LPWSTR *argv);
 
 VOID WINAPI ServiceStartInteract=
ive(DWORD argc, LPWSTR *argv);
 
@@ -90,6 +96,16 @@
 DWORD MsgToEventLog(DW=
ORD flags, LPCWSTR lpszMsg, =2E=2E=2E);
 
 /**
+ * Close a handle and inval=
idate it
+ *
+ * Nothing is done if the handle is invalid already, which ma=
kes it safe
+ * to call this function more than once for the same handle=2E=

+ *
+ * @param handle  pointer to the handle to be closed
+ */
+void Close=
HandleEx(LPHANDLE handle);
+
+/**
  * Convert a UTF-8 string to UTF-16
  *
=
  * The size parameter can be used to convert strings which contain inline =
NUL
diff --git a/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests/unit_te=
sts/openvpnserv/Makefile=2Eam
index 19de666=2E=2E2753ad2 100644
--- a/tests=
/unit_tests/openvpnserv/Makefile=2Eam
+++ b/tests/unit_tests/openvpnserv/Ma=
kefile=2Eam
@@ -3,14 +3,34 @@
 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACK=
AGE_STRING) service Unit-Tests'
 
 if WIN32
-test_binaries =3D openvpnserv_=
testdriver
+test_binaries =3D openvpnserv_testdriver openvpnserv_automatic_=
testdriver
 endif
 check_PROGRAMS =3D $(test_binaries)
 
-openvpnserv_testd=
river_CFLAGS  =3D -I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(t=
op_srcdir)/src/compat -I$(top_srcdir)/src/openvpnserv @TEST_CFLAGS@
-openvp=
nserv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+# =
build the tests like openvpnserv itself, see src/openvpnserv/Makefile=2Eam
=
+openvpnserv_test_cflags =3D \
+	-municode -D_UNICODE \
+	-UNTDDI_VERSION -=
D_WIN32_WINNT=3D_WIN32_WINNT_WIN10 \
+	-I$(top_srcdir)/include -I$(top_srcd=
ir)/src/openvpn -I$(top_srcdir)/src/compat \
+	-I$(top_srcdir)/src/openvpns=
erv -I$(top_builddir)/src/openvpnserv \
+	-I$(top_srcdir)/tests/unit_tests/=
openvpn \
+	@TEST_CFLAGS@
+openvpnserv_test_ldflags =3D -municode @TEST_LDF=
LAGS@ -L$(top_srcdir)/src/openvpn
+openvpnserv_test_ldadd =3D \
+	-ladvapi3=
2 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
+	-lshlwapi -lnetapi32 -lws2_3=
2 -lntdll -lole32 -lpathcch
+
+openvpnserv_testdriver_CFLAGS  =3D $(openvpn=
serv_test_cflags)
+openvpnserv_testdriver_LDFLAGS =3D $(openvpnserv_test_ld=
flags)
+openvpnserv_testdriver_LDADD   =3D $(openvpnserv_test_ldadd)
 openv=
pnserv_testdriver_SOURCES =3D test_openvpnserv=2Ec \
 	$(top_srcdir)/src/op=
envpnserv/common=2Ec \
 	$(top_srcdir)/src/openvpnserv/validate=2Ec \
 	$(t=
op_srcdir)/src//openvpn/wfp_block=2Ec \
 	$(top_srcdir)/src//openvpn/wfp_bl=
ock=2Eh
+
+openvpnserv_automatic_testdriver_CFLAGS  =3D $(openvpnserv_test_=
cflags)
+openvpnserv_automatic_testdriver_LDFLAGS =3D $(openvpnserv_test_ld=
flags)
+openvpnserv_automatic_testdriver_LDADD   =3D $(openvpnserv_test_lda=
dd)
+openvpnserv_automatic_testdriver_SOURCES =3D test_openvpnserv_automati=
c=2Ec \
+	$(top_srcdir)/src/openvpnserv/common=2Ec
diff --git a/tests/unit_=
tests/openvpnserv/test_openvpnserv_automatic=2Ec b/tests/unit_tests/openvpn=
serv/test_openvpnserv_automatic=2Ec
new file mode 100644
index 0000000=2E=
=2E7ccbd93
--- /dev/null
+++ b/tests/unit_tests/openvpnserv/test_openvpnser=
v_automatic=2Ec
@@ -0,0 +1,238 @@
+/*
+ *  OpenVPN -- An application to sec=
urely tunnel IP networks
+ *             over a single UDP port, with suppo=
rt for SSL/TLS-based
+ *             session authentication and key exchang=
e,
+ *             packet encryption, packet authentication, and
+ *       =
      packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@=
openvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute=
 it and/or modify
+ *  it under the terms of the GNU General Public License=
 as published by the
+ *  Free Software Foundation, either version 2 of the=
 License,
+ *  or (at your option) any later version=2E
+ *
+ *  This progr=
am is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY =
WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITN=
ESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License fo=
r more details=2E
+ *
+ *  You should have received a copy of the GNU Gener=
al Public License along
+ *  with this program; if not, see <https://www=2E=
gnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"=

+#endif
+
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+#include "test_co=
mmon=2Eh"
+
+#include <winsock2=2Eh>
+#include <windows=2Eh>
+
+/*
+ * The =
automatic service cannot be linked together with the interactive one
+ * in=
 a single test driver, as both define the same static service state=2E
+ */=

+#include "automatic=2Ec"
+
+BOOL
+ReportStatusToSCMgr(SERVICE_STATUS_HAND=
LE svc_handle, SERVICE_STATUS *svc_status)
+{
+    return TRUE;
+}
+
+/**
+=
 * Parse a response like the one sent by the interactive service
+ *
+ * @p=
aram response  the response string
+ * @param error     receives the error =
code of the response
+ * @param pid       receives the process id of the re=
sponse
+ *
+ * @return the result of ParseInteractiveServiceResponse()
+ */=

+static BOOL
+parse_response(PCWSTR response, PDWORD error, PDWORD pid)
+{=

+    /* the response is modified while parsing, so pass a copy */
+    WCH=
AR buf[256];
+    assert_true(wcslen(response) < _countof(buf));
+    wcscp=
y(buf, response);
+
+    return ParseInteractiveServiceResponse(buf, error,=
 pid);
+}
+
+static void
+test_response_success(void **state)
+{
+    DWORD=
 error =3D 0xdeadbeef;
+    DWORD pid =3D 0xdeadbeef;
+
+    assert_true(pa=
rse_response(L"0x00000000\n0x000004d2\nProcess ID", &error, &pid));
+    as=
sert_int_equal(error, 0);
+    assert_int_equal(pid, 1234);
+}
+
+static vo=
id
+test_response_error(void **state)
+{
+    DWORD error =3D 0xdeadbeef;
+=
    DWORD pid =3D 0xdeadbeef;
+
+    /*
+     * An error response carries t=
he name of the failed function in the
+     * second line, which must not b=
e mistaken for a process id=2E
+     */
+    assert_true(parse_response(L"0=
x0000007b\nCreateProcessAsUser\nThe filename is invalid", &error,
+        =
                       &pid));
+    assert_int_equal(error, 0x7b);
+    ass=
ert_int_equal(pid, 0);
+}
+
+static void
+test_response_error_crlf(void **s=
tate)
+{
+    DWORD error =3D 0xdeadbeef;
+    DWORD pid =3D 0xdeadbeef;
+
=
+    /* error responses are built with FormatMessage(), which uses \r\n lin=
e breaks */
+    assert_true(parse_response(L"0x20000001\r\nYou have specif=
ied a config file location\r\n", &error,
+                               &p=
id));
+    assert_int_equal(error, 0x20000001);
+    assert_int_equal(pid, =
0);
+}
+
+static void
+test_response_malformed(void **state)
+{
+    DWORD =
error, pid;
+
+    /* no line break at all */
+    assert_false(parse_respo=
nse(L"0x00000000", &error, &pid));
+
+    /* neither line is a number */
+ =
   assert_false(parse_response(L"hello world\nnot a pid\nmessage", &error, =
&pid));
+
+    /* the error code is a number with trailing garbage */
+    =
assert_false(parse_response(L"0x00000000xyz\n0x000004d2\nProcess ID", &erro=
r, &pid));
+
+    /* success response without a process id */
+    assert_f=
alse(parse_response(L"0x00000000\n", &error, &pid));
+
+    /* success resp=
onse with an empty process id line */
+    assert_false(parse_response(L"0x=
00000000\n\nProcess ID", &error, &pid));
+
+    /* the process id is a numb=
er with trailing garbage */
+    assert_false(parse_response(L"0x00000000\n=
0x000004d2xyz\nProcess ID", &error, &pid));
+
+    /* empty lines only */
+=
    assert_false(parse_response(L"\n\n", &error, &pid));
+}
+
+static void
=
+test_add_startup_data(void **state)
+{
+    WCHAR buf[32];
+    size_t pos=
 =3D 0;
+
+    /* the startup data is config dir + \0 + options + \0 + pass=
word + \0 */
+    assert_true(AddStartupData(buf, _countof(buf), &pos, L"C:=
\\cfg"));
+    assert_int_equal(pos, 7);
+
+    assert_true(AddStartupData(=
buf, _countof(buf), &pos, L"--log x"));
+    assert_int_equal(pos, 15);
+
+=
    /* the password is empty, but still terminated */
+    assert_true(AddS=
tartupData(buf, _countof(buf), &pos, L""));
+    assert_int_equal(pos, 16);=

+
+    /* the fields are separated and terminated by zeros */
+    const W=
CHAR expected[] =3D L"C:\\cfg\0--log x\0";
+    assert_int_equal(pos, _coun=
tof(expected));
+    assert_int_equal(wmemcmp(buf, expected, pos), 0);
+}
+=

+static void
+test_add_startup_data_full(void **state)
+{
+    WCHAR buf[8=
];
+    size_t pos =3D 0;
+
+    wmemset(buf, L'#', _countof(buf));
+
+    =
/* a string that does not fit is rejected without changing anything */
+   =
 assert_false(AddStartupData(buf, _countof(buf), &pos, L"12345678"));
+    =
assert_int_equal(pos, 0);
+    for (size_t i =3D 0; i < _countof(buf); i++)=

+    {
+        assert_int_equal(buf[i], L'#');
+    }
+
+    /* a string =
whose terminator ends up as the last element still fits */
+    assert_true=
(AddStartupData(buf, _countof(buf), &pos, L"1234567"));
+    assert_int_equ=
al(pos, _countof(buf));
+
+    /* but leaves no room for another field, not=
 even an empty one */
+    assert_false(AddStartupData(buf, _countof(buf), =
&pos, L""));
+    assert_int_equal(pos, _countof(buf));
+}
+
+static void
+=
test_log_file_path(void **state)
+{
+    WCHAR path[MAX_PATH];
+    WCHAR n=
ame[MAX_PATH + 64];
+
+    /* the extension is replaced by =2Elog */
+    a=
ssert_true(GetLogFilePath(path, _countof(path), L"C:\\log\\", L"office=2Eov=
pn"));
+    assert_int_equal(wcscmp(path, L"C:\\log\\office=2Elog"), 0);
+
=
+    /* a missing backslash on the log dir is added */
+    assert_true(Get=
LogFilePath(path, _countof(path), L"C:\\log", L"office=2Eovpn"));
+    asse=
rt_int_equal(wcscmp(path, L"C:\\log\\office=2Elog"), 0);
+
+    /* only the=
 last extension is replaced */
+    assert_true(GetLogFilePath(path, _count=
of(path), L"C:\\log\\", L"my=2Eoffice=2Eovpn"));
+    assert_int_equal(wcsc=
mp(path, L"C:\\log\\my=2Eoffice=2Elog"), 0);
+
+    /* a name without an ex=
tension just gets one */
+    assert_true(GetLogFilePath(path, _countof(pat=
h), L"C:\\log\\", L"office"));
+    assert_int_equal(wcscmp(path, L"C:\\log=
\\office=2Elog"), 0);
+
+    /* a name that is nothing but an extension */
=
+    assert_true(GetLogFilePath(path, _countof(path), L"C:\\log\\", L"=2Eov=
pn"));
+    assert_int_equal(wcscmp(path, L"C:\\log\\=2Elog"), 0);
+
+    /=
* spaces are no problem */
+    assert_true(GetLogFilePath(path, _countof(p=
ath), L"C:\\my logs\\", L"my office=2Eovpn"));
+    assert_int_equal(wcscmp=
(path, L"C:\\my logs\\my office=2Elog"), 0);
+
+    /* a config file name t=
hat cannot fit the log file name is an error */
+    wmemset(name, L'a', _c=
ountof(name) - 1);
+    name[_countof(name) - 1] =3D L'\0';
+    assert_fal=
se(GetLogFilePath(path, _countof(path), L"C:\\log\\", name));
+
+    /* a l=
og dir that does not leave room for the name is an error */
+    assert_fal=
se(GetLogFilePath(path, 8, L"C:\\some\\very\\long\\log\\dir", L"office=2Eov=
pn"));
+}
+
+int
+wmain(void)
+{
+    openvpn_unit_test_setup();
+    const=
 struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_response_su=
ccess),
+        cmocka_unit_test(test_response_error),
+        cmocka_uni=
t_test(test_response_error_crlf),
+        cmocka_unit_test(test_response_m=
alformed),
+        cmocka_unit_test(test_add_startup_data),
+        cmock=
a_unit_test(test_add_startup_data_full),
+        cmocka_unit_test(test_log=
_file_path),
+    };
+
+    int ret =3D cmocka_run_group_tests_name("openvp=
nserv automatic service tests", tests, NULL, NULL);
+
+    return ret;
+}

=
-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Dem=
ail
To unsubscribe, or for help writing mail filters, visit https://gerrit=
=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerr=
it-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I089e5b79600c53=
5e3c0c5d1bb14319ac03f4144b
Gerrit-Change-Number: 2001
Gerrit-PatchSet: 3
Ge=
rrit-Owner: Heiko Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe =
<arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Frank Lichtenheld <frank@lichtenhel=
d=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>=

Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attenti=
on: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--XOzTF0y9p88=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Heiko Hund=
 <strong>uploaded patch set #3</strong> to this change=2E</p><p><a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail">View Change</a=
></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">openvpnserv: add automatic service again<br><br>The auto=
matic service, which starts all configs in the autostart config<br>director=
y, has been provided by the =2ENET based openvpnserv2=2Eexe since<br>OpenVP=
N 2=2E4=2E Its original C implementation in openvpnserv=2Eexe was removed<b=
r>from this repository in 2021=2E Add it back, implemented in C, so that bo=
th<br>Windows services are maintained in this repository=2E<br><br>Security=
 related changes added:<br>- before sending any data, verify that the named=
 pipe is served by the<br>  interactive service process<br>- the exit event=
 of each OpenVPN process has a random name and a DACL<br>  that only grants=
 access to its owner, so it cannot be pre-created or<br>  signalled by othe=
r users<br>- the service checks that it is run as the ovpn_service_user acc=
ount in<br>  the registry settings, so that it and openvpn in turn is guara=
nteed to<br>  run with limited privileges<br><br>Robustness:<br>- starting =
a config is retried until the service stops, with a delay<br>  that doubles=
 from 10 seconds up to 5 minutes for configs that keep<br>  failing, and is=
 reset once a process ran for a minute<br>- an OpenVPN process that may hav=
e been started by a failed attempt is<br>  signalled to exit, so it does no=
t run unmonitored<br>- configs in subdirectories use their own directory as=
 working<br>  directory; configs with the same file name as one found befor=
e are<br>  ignored, like in the GUI<br><br>Both services now run in their o=
wn process, selected by the new<br>&#39;-automatic&#39; and &#39;-interacti=
ve&#39; options=2E This is needed since they need<br>to run with different =
accounts=2E &#39;-install&#39; takes an optional service<br>name again=2E &=
#39;-instance automatic&#39; is not supported, since the service<br>cannot =
check the named pipe owner for instances=2E<br><br>Also add a few unit test=
s and some documentation=2E<br><br>Change-Id: I089e5b79600c535e3c0c5d1bb143=
19ac03f4144b<br>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&=
gt;<br>---<br>M Changes=2Emd<br>M doc/Makefile=2Eam<br>A doc/automatic-serv=
ice-notes=2Erst<br>M src/openvpnserv/CMakeLists=2Etxt<br>M src/openvpnserv/=
Makefile=2Eam<br>A src/openvpnserv/automatic=2Ec<br>M src/openvpnserv/commo=
n=2Ec<br>M src/openvpnserv/interactive=2Ec<br>M src/openvpnserv/service=2Ec=
<br>M src/openvpnserv/service=2Eh<br>M tests/unit_tests/openvpnserv/Makefil=
e=2Eam<br>A tests/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec<br>=
12 files changed, 1,653 insertions(+), 64 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/=
2001/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>ind=
ex 5c3270b=2E=2E813ac33 100644</span><br><span>--- a/Changes=2Emd</span><br=
><span>+++ b/Changes=2Emd</span><br><span>@@ -23,6 +23,33 @@</span><br><spa=
n>   the characters mentioned above were already escaped=2E However, the be=
havior of</span><br><span>   Mbed TLS is slightly different from OpenSSL in=
 that it also escapes &quot;=3D&quot;=2E</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+* **Windows automatic service moved =
back into this repository**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPNSe=
rvice, which starts all configs in the `config-auto` directory at</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  boot time, is no longer pro=
vided by the =2ENET based `openvpnserv2=2Eexe`, but by</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  `openvpnserv=2Eexe`, like the interact=
ive service is=2E It mostly works like the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  service it was ported from, with these exceptions =
and additions:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  * The service can no l=
onger be run on the command line, but exclusively as</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    a service through the Service Control=
 Manager=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * The =
service refuses to start if it does not run as the account</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    `NT SERVICE\OpenVPNService`=2E T=
his is checked for security reasons: OpenVPN</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    runs under the same account, so its configs, s=
cripts and plugins would get</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    all privileges of a more privileged account as well=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  * All service related log=
ging is done via event log=2E The event source changed</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    from `OpenVpnService` to `openvpnser=
v`, same as for the interactive one=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  * An OpenVPN process that cannot be started or exits i=
s started again,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 first after 10 seconds, with the delay doubling up to 5 minutes for</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    processes that keep fa=
iling=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * Configs=
 in subdirectories of `config-auto` use their own directory as</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    working directory=2E Of seve=
ral configs with the same file name, only the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    first one found is started, like in the OpenV=
PN GUI=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * The au=
tomatic and the interactive service now each run in a process of</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    their own, selected by the=
 `-automatic` and `-interactive` options of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    `openvpnserv=2Eexe`=2E `-install` takes an opti=
onal service name=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  * `-instance automatic` is not supported on purpose=2E It cannot verify =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    interactive =
service named pipe for instances before connecting=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## Maintainer-visible c=
hanges</span><br><span> </span><br><span> - The configure-time option `--en=
able-debug` is no longer  available</span><br><span>diff --git a/doc/Makefi=
le=2Eam b/doc/Makefile=2Eam</span><br><span>index 5ca1c4d=2E=2Ebbd83cd 1006=
44</span><br><span>--- a/doc/Makefile=2Eam</span><br><span>+++ b/doc/Makefi=
le=2Eam</span><br><span>@@ -55,6 +55,7 @@</span><br><span> </span><br><span=
> dist_noinst_DATA =3D \</span><br><span> 	android=2Etxt \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	automatic-service-notes=2Erst \</sp=
an><br><span> 	interactive-service-notes=2Erst \</span><br><span> 	keying-m=
aterial-exporter=2Etxt \</span><br><span> 	openvpn=2E8=2Erst \</span><br><s=
pan>diff --git a/doc/automatic-service-notes=2Erst b/doc/automatic-service-=
notes=2Erst</span><br><span>new file mode 100644</span><br><span>index 0000=
000=2E=2E4c1858c</span><br><span>--- /dev/null</span><br><span>+++ b/doc/au=
tomatic-service-notes=2Erst</span><br><span>@@ -0,0 +1,151 @@</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+OpenVPN Automatic Service Notes</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+Introduction</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN Automatic =
Service, also known as &quot;OpenVPNService&quot;, is a Windows system</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+service which starts an =
OpenVPN process for each configuration file in the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+autostart configuration folder, ``config-aut=
o`` by default=2E It is meant for</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+connections that should be up at all times, independent of an=
y user being</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logged =
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+How It Works</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+------------</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The Automa=
tic Service does not start OpenVPN itself, but uses the Interactive</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+Service to do it, the same =
way OpenVPN GUI does=2E See</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+`interactive-service-notes=2Erst` for how the Interactive Service w=
orks=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+- On start, the service searche=
s the autostart configuration folder and its</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  subfolders, up to a depth of 32, for files with =
the configuration file</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  extension=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+- For each configurat=
ion file it connects to the Interactive Service named</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  pipe ``\\=2E\pipe\openvpn\service`` and=
 sends the startup data=2E Before sending</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  anything it checks that the pipe is served by the I=
nteractive Service</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 process, as registered with the Service Control Manager=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+- The Interactive Service starts openvpn=2Eexe with th=
e account of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  A=
utomatic Service=2E It allows this account to use any options and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  configuration files in any =
folder, see `Service Account`_=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The=
 folder of the configuration file is used as the working folder, so</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  relative paths in a confi=
guration file resolve relative to its folder=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+- openvpn=2Eexe is started with these options::</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      --log &lt;log file&gt; --config &lt;config file&gt;=
 --service &lt;exit event&gt; 0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      --pull-filter ignore route-method</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  ``--log-append`` is used instead of ``--log`` if configure=
d=2E The exit event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  is created by the Automatic Service before each start=2E It has a random =
name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and only its =
owner, the service account, has access to it=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+- When the service stops, it signals the exit events, which makes =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN proces=
ses exit=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+Configuration files are ide=
ntified by their file name, like in OpenVPN GUI=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+If there are several configuration files wit=
h the same file name in</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+different subfolders, only the first one found is started and an error =
is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logged for the ot=
hers=2E Files in a folder are found before those in its</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+subfolders=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Restarti=
ng OpenVPN Processes</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+----------------------------</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+An OpenVP=
N process that exits, or that cannot be started, is started again</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+until the service stops=2E Th=
e first attempt is made after 10 seconds=2E The</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+delay doubles with each further failure, up to =
5 minutes=2E It is reset to 10</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+seconds once an OpenVPN process has run for at least a minute=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+This also covers the Interactive Servi=
ce not being reachable, for example</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+while it is restarted=2E The configurations are started aga=
in with the next</span><br><span style=3D"color: hsl(120, 100%, 40%);">+att=
empt after it is available again=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+Service Account</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+---------------</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+The Automatic Service runs with the virtual servi=
ce account</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``NT SERV=
ICE\OpenVPNService``=2E The OpenVPN processes it starts run with this</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+account too, so configura=
tion files and anything they reference, like keys</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+and certificates, including those in the Wind=
ows certificate store, must be</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+readable by it=2E The log folder must be writable by it=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+The service refuses to start if it runs with=
 any other account=2E OpenVPN</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+runs with the same account, so configuration files, scripts and p=
lugins</span><br><span style=3D"color: hsl(120, 100%, 40%);">+would get all=
 privileges of a more privileged account, like LocalSystem, as</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+well=2E The service is installed=
 with its required privileges reduced to</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+``SeChangeNotifyPrivilege``, which also removes privil=
eges such as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``SeImp=
ersonatePrivilege`` from the OpenVPN processes=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+The Interactive Service lets the account ``NT SERVICE\&lt;ovpn_s=
ervice_user&gt;``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+us=
e any options, see `Configuration`_=2E The account the Automatic Service</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+checks for is derived =
from the same registry value, so both always agree=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Conf=
iguration</span><br><span style=3D"color: hsl(120, 100%, 40%);">+----------=
---</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+The Automatic Service reads its set=
tings from the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``HKE=
Y_LOCAL_MACHINE\SOFTWARE\OpenVPN`` registry key, like the Interactive</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+Service=2E All the follow=
ing registry values are of the ``REG_SZ`` type:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+``autostart_config_dir``</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+   The autostart configuration folder=2E If this value does n=
ot exist or is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   em=
pty, no configurations are started=2E The installer sets it to</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+   ``install_dir &quot;\config-a=
uto&quot;``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+``config_ext``</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   The configuration file ext=
ension, without a leading dot; defaults to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+   ``&quot;ovpn&quot;``=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+``log_dir``</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+   The folder for the log files; defaults to ``install_dir &quot;\log&qu=
ot;``=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   inst=
aller sets it to ``%ProgramData%\OpenVPN\Log`` and makes it writable</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   for the service account=
=2E Each OpenVPN process logs to a file in this</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+   folder, named like its configuration file, w=
ith the extension replaced by</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   ``=2Elog``=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``log_append=
``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ``&quot;1&quot=
;`` to append to existing log files, ``&quot;0&quot;`` (default) to truncat=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   them when an Op=
enVPN process is started=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``ovpn_serv=
ice_user``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   The na=
me of the service account, without the ``NT SERVICE\`` prefix;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+   defaults to ``&quot;OpenVPNSe=
rvice&quot;``=2E Used by the Interactive Service to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   authorize the Automatic Service and by=
 the Automatic Service to check</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   its own account=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The v=
alues ``exe_path`` and ``priority`` described in</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+`interactive-service-notes=2Erst` apply too, a=
s the Interactive Service starts</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+the OpenVPN processes=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+T=
he service writes its own messages to the Windows event log, using the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+``openvpnserv`` event so=
urce, the same as the Interactive Service=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Installation<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+------------</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+The OpenVPN installer registers the service, w=
hether or not the &quot;OpenVPN</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+Service&quot; feature is selected=2E Without the feature it is =
disabled, otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
it is set to start automatically and started=2E Upgrades keep the start mod=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+and running state =
of the service=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+The services can also=
 be registered from an elevated command prompt::</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      openvpnserv=2Eexe -install [automatic|interactive]</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+Without a name, both services are registered=2E=
 A service that is registered</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+already is left alone=2E The Automatic Service is registered with=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``-automatic`` =
option, its account, the dependency on the Interactive Service</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+and its reduced privileges=2E Bo=
th services run in a process of their own,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+selected by the ``-automatic`` and ``-interactive`` =
options=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+Unlike the Interactive Servi=
ce, the Automatic Service does not support the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+``-instance`` option for side-by-side installati=
ons=2E</span><br><span>diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src/=
openvpnserv/CMakeLists=2Etxt</span><br><span>index 2cc4a93=2E=2Edbb7651 100=
644</span><br><span>--- a/src/openvpnserv/CMakeLists=2Etxt</span><br><span>=
+++ b/src/openvpnserv/CMakeLists=2Etxt</span><br><span>@@ -35,6 +35,7 @@</s=
pan><br><span> add_common_options(openvpnserv)</span><br><span> target_sour=
ces(openvpnserv PRIVATE</span><br><span>     common=2Ec</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    automatic=2Ec</span><br><span>     =
interactive=2Ec</span><br><span>     service=2Ec service=2Eh</span><br><spa=
n>     validate=2Ec validate=2Eh</span><br><span>@@ -82,6 +83,7 @@</span><b=
r><span> if (BUILD_TESTING)</span><br><span>     set(unit_tests</span><br><=
span>         &quot;test_openvpnserv&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        &quot;test_openvpnserv_automatic&quot;</span=
><br><span>     )</span><br><span> </span><br><span>     foreach (test_name=
 ${unit_tests})</span><br><span>@@ -104,4 +106,8 @@</span><br><span>       =
  validate=2Ec</span><br><span>         =2E=2E/openvpn/wfp_block=2Ec =2E=2E=
/openvpn/wfp_block=2Eh</span><br><span>     )</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    target_sources(test_openvpnserv_automatic PRIVATE</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        common=2Ec</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> endif ()</sp=
an><br><span>diff --git a/src/openvpnserv/Makefile=2Eam b/src/openvpnserv/M=
akefile=2Eam</span><br><span>index 447fb10=2E=2Ed3ca665 100644</span><br><s=
pan>--- a/src/openvpnserv/Makefile=2Eam</span><br><span>+++ b/src/openvpnse=
rv/Makefile=2Eam</span><br><span>@@ -35,6 +35,7 @@</span><br><span> </span>=
<br><span> openvpnserv_SOURCES =3D \</span><br><span>         common=2Ec \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	automatic=2Ec \</sp=
an><br><span> 	interactive=2Ec \</span><br><span> 	service=2Ec service=2Eh =
\</span><br><span> 	validate=2Ec validate=2Eh \</span><br><span>diff --git =
a/src/openvpnserv/automatic=2Ec b/src/openvpnserv/automatic=2Ec</span><br><=
span>new file mode 100644</span><br><span>index 0000000=2E=2E4ad4202</span>=
<br><span>--- /dev/null</span><br><span>+++ b/src/openvpnserv/automatic=2Ec=
</span><br><span>@@ -0,0 +1,1020 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  OpenVPN -- An application to securely tunnel IP networks</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UD=
P port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             session authentication and key exchange,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packe=
t encryption, packet authentication, and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet compression=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  Copyright (C) 2026- OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * The automatic service starts one OpenVPN process for each configuration<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * file found in the=
 autostart config directory and restarts them when they</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * exit unexpectedly=2E The OpenVPN pro=
cesses are not started directly, but by</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * the interactive service, which this service talks to=
 via its named pipe=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;service=2Eh&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;handleapi=2Eh&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;pathcch=2Eh&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;rpc=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;sddl=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Time =
we give the interactive service to accept our connection */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define ISERVICE_CONNECT_TIMEOUT 50=
00 /*ms*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Time we wait before an OpenVPN process is =
started again, after it exited</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * or could not be started=2E The delay doubles with each failed=
 attempt=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RESTART_DELAY_MI=
N 10000 /*ms*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum time we wait=
 before an OpenVPN process is started again */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define RESTART_DELAY_MAX 300000 /*ms*/</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/** Time after which a running OpenVPN process =
resets the delay to the minimum */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define STABLE_RUNTIME 60000 /*ms*/</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/** Maximum size of the startup data sent to the interactive se=
rvice */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define STA=
RTUP_DATA_MAX 2048</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Maximum recursio=
n depth when searching for configuration files */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define MAX_RECURSION_DEPTH 32</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/** Name of the interactive service we talk to */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define ISERVICE_NAME _=
L(PACKAGE_NAME) L&quot;ServiceInteractive&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/** The service cannot run without the interactive service, so we =
make it depend on it=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define AUTOMATIC_SERVICE_DEPENDENCIES ISERVICE_NAME L&quot;\0\0&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/** The service runs as its own virt=
ual service account, which the interactive service trusts */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define AUTOMATIC_SERVICE_ACCOUNT =
L&quot;NT SERVICE\\&quot; _L(PACKAGE_NAME) L&quot;Service&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/** The service needs no privileges besides the on=
e every process has */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define AUTOMATIC_SERVICE_PRIVILEGES L&quot;SeChangeNotifyPrivilege\0\0&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+openvpn_service_t automatic_servi=
ce =3D { automatic,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                        _L(PACKAGE_NAME) L&quot;Service&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                        _L(PACKAGE_NAME) L&quot; Automatic Service&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                   AUTOMATIC_SERVICE_DEPENDENCIES,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                        SERV=
ICE_DEMAND_START,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                      L&quot;-automatic&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
        // cppcheck-suppress unknownMacro ; FP, _L after a string literal</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
                   AUTOMATIC_SERVICE_ACCOUNT,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                                        AUTOMATIC=
_SERVICE_PRIVILEGES };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static SERVICE_S=
TATUS_HANDLE service;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static SERVICE_STATUS status =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN=
_PROCESS };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static H=
ANDLE exit_event =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static setti=
ngs_t settings;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/** One OpenVPN connect=
ion, i=2Ee=2E one configuration file */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+typedef struct openvpn_process</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct openvpn_process *next;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    WCHAR working_dir[MAX_PATH];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    WCHAR config_file[MAX_PATH];</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR log_file[MAX=
_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE p=
rocess;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE e=
xit_event;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDL=
E stop_event;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HA=
NDLE thread;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CRI=
TICAL_SECTION cs;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} =
openvpn_process_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Linked list of O=
penVPN connections / configuration files */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static openvpn_process_t *processes =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * Add the zero terminated string \p str to \p buf=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * If successful, \p pos points to the ch=
aracter after the terminating NUL=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param buf   string buffer to append to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param size  size of the buffer in wide character=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pos   [i=
n,out] position in the buffer in wide characters</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param str   the string to append</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return BOOL to indicate success or failure=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+AddStartupData(PWSTR buf, size_t size, si=
ze_t *pos, PCWSTR str)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t len =
=3D wcslen(str) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*pos + len=
 &gt; size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    wmemcpy(buf + *pos, str, len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    *pos +=3D len;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Get the process id of the interactiv=
e service</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the process id, =
or 0 if the service is not running or on error</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static DWORD</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+GetInteractiveServicePid(void)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 DWORD pid =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SC_HANDLE scm =3D=
 OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!scm)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    SC_HANDLE svc =3D OpenS=
ervice(scm, ISERVICE_NAME, SERVICE_QUERY_STATUS);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (svc)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        SERVICE_STATUS_PROCESS ssp;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        DWORD needed;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (QueryServiceStatusEx(svc, SC_STATUS_=
PROCESS_INFO, (LPBYTE)&amp;ssp, sizeof(ssp), &amp;needed)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; ssp=2EdwCurren=
tState =3D=3D SERVICE_RUNNING)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            pid =3D ssp=2EdwProcessId;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        CloseServiceHandle(svc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CloseS=
erviceHandle(scm);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Check that the server end of \p pipe is the interactiv=
e service</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * Makes sure we do not sen=
d data to, or can be impersonated by, a process</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * which created a pipe with the interactive se=
rvice&#39;s pipe name=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pi=
pe  the connected pipe handle</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn BOOL to indicate whether the pipe server is the interactive service</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+IsInteractiveServicePipe(HANDLE pipe)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ULONG server_pid;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!GetNamedPipeServerProcessId(pipe, &a=
mp;server_pid))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return FAL=
SE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    DWORD iservice_pid =3D GetInteractiveServiceP=
id();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ise=
rvice_pid !=3D 0 &amp;&amp; server_pid =3D=3D iservice_pid;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Connect to=
 the named pipe of the interactive service</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * The connection is only returned if the pipe is served by the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * interactive service pr=
ocess=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param timeout  maximum t=
ime in ms to wait for the pipe to become available</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @return pipe handle, or INVALID_HANDLE_VALUE on error</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static HANDLE</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ConnectToInteractiveService(DWORD timeout)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    WCHAR pipe_name[256];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ULONGLONG deadline =3D GetTickC=
ount64() + timeout;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(pipe_n=
ame, _countof(pipe_name), L&quot;\\\\=2E\\pipe\\&quot; _L(PACKAGE) L&quot;%=
ls\\service&quot;, service_instance);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   while (TRUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        HANDLE pip=
e =3D CreateFile(pipe_name, GENERIC_READ | GENERIC_WRITE, 0, NULL, OPEN_EXI=
STING, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (pipe !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            DWORD mode =3D PIPE_READMODE_MESSAGE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            if (!SetNamedPipeHandl=
eState(pipe, &amp;mode, NULL, NULL))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                CloseHandle(pipe);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                return INVALID_HANDLE_VALUE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (!IsInteractive=
ServicePipe(pipe))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         MsgToEventLog(M_ERR, L&quot;Pipe %ls is not served by the interact=
ive service&quot;, pipe_name);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                CloseHandle(pipe);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                SetLastError(ERROR_ACCESS_DENIED)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                re=
turn INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            return pipe;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD error =3D=
 GetLastError();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ULONGLONG now =3D GetTickCount64();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (now &gt;=3D deadline)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            SetLastError(error);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return INVALID_HANDLE_VAL=
UE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (error =3D=3D ERROR_PIPE_BUSY)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* All pipe instances=
 are busy, wait for one to become available */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!WaitNamedPipe(pipe_name, (DWORD=
)(deadline - now)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          return INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        else if (error =3D=3D ERROR_FILE_NOT_FOUND)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            /* The interactive service may not hav=
e created the pipe yet */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            Sleep(50);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            SetLas=
tError(error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Split off the first line of \p str</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * Lines end with &quot;\\n&quot; or &quot;\\r\\n&quot; in=
 error responses of the interactive service=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param str  the string to split, its first line is zero termin=
ated in place</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the start of=
 the next line, or NULL if there is none</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static PWSTR</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Sp=
litLine(PWSTR str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR eol =3D w=
cschr(str, L&#39;\n&#39;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!eol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    *eol =3D L&#39;\0&#39;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (eol &gt; str &amp;&amp; eol[-=
1] =3D=3D L&#39;\r&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
ol[-1] =3D L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return eol + 1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Pa=
rse the response of the interactive service</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * The response is a three line string, with the error code in the f=
irst,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the process=
 id in the second if OpenVPN was started successfully and</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * a message in the third line=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param response  the zero terminated =
response, which is modified</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param error     receives the error code returned by the service=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pid      =
 receives the process id of the OpenVPN process</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @return BOOL to indicate success or failure</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ParseInteractiveServiceResponse(PWSTR response, PDWORD error,=
 PDWORD pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR pid_line =3D Sp=
litLine(response);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (!pid_line)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SetLastE=
rror(ERROR_INVALID_DATA);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Sp=
litLine(pid_line);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PWSTR end;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    *error =3D wcstoul(re=
sponse, &amp;end, 16);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (end =3D=3D response || *end !=3D L&#39;\0&#39;)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        SetLastError(ERROR_INVALID_DATA);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    *pid =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (*error =3D=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        *pid =3D wcstoul(pid_line, &amp;end, 16);</span><br><span style=
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
E\\&lt;ovpn_service_user&gt; start OpenVPN</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * with any options=2E Running as a more privileged =
account, like LocalSystem,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * would run all configs with these elevated privileges=2E So, rathe=
r refuse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to run a=
s any other account, in case an admin is adventurous=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param s  the settings, with the name of the service =
account</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate w=
hether we run as the service account</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+IsRunni=
ngAsServiceAccount(const settings_t *s)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    BOOL ret =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * A TOKEN_USER with r=
oom for the largest possible SID after it=2E The sid</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * member alone is used for the SID o=
f the account, as it is aligned=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        TOKEN_USER t=
oken_user;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        B=
YTE sid[SECURITY_MAX_SID_SIZE];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    } token_user_info, account_info;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    WCHAR account[MAX_NAME];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    DWORD sid_size =3D sizeof(account_info=2Esid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR domain[MAX_NAME=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD domain_=
size =3D _countof(domain);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    SID_NAME_USE use;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprin=
tf(account, _countof(account), L&quot;NT SERVICE\\%ls&quot;, s-&gt;ovpn_ser=
vice_user);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!LookupAccountName(NULL, account, account_info=2Esid, &amp;sid_size, domain=
, &amp;domain_size, &amp;use))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     MsgToEventLog(M_SYSERR, L&quot;Could not look up account %ls&quot;, ac=
count);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
 7a23d41=2E=2E10a5207 100644</span><br><span>--- a/src/openvpnserv/common=
=2Ec</span><br><span>+++ b/src/openvpnserv/common=2Ec</span><br><span>@@ -3=
8,7 +38,7 @@</span><br><span>     if (status =3D=3D ERROR_FILE_NOT_FOUND &a=
mp;&amp; default_value)</span><br><span>     {</span><br><span>         siz=
e_t len =3D size / sizeof(data[0]);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (swprintf(data, len, default_value))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (swprintf(data, len, d=
efault_value) &gt;=3D 0)</span><br><span>         {</span><br><span>       =
      status =3D ERROR_SUCCESS;</span><br><span>         }</span><br><span>=
@@ -116,6 +116,14 @@</span><br><span>         goto out;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* an empty autostart config dir means configs are not started automa=
tically */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error=
 =3D GetRegString(key, L&quot;autostart_config_dir&quot;, s-&gt;autostart_c=
onfig_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                sizeof(s-&gt;autostart_config_dir), L&quot;&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error !=3D ERROR_SU=
CCESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     swprintf(default_va=
lue, _countof(default_value), L&quot;%ls\\bin\\&quot;, install_path);</span=
><br><span>     error =3D GetRegString(key, L&quot;bin_dir&quot;, s-&gt;bin=
_dir, sizeof(s-&gt;bin_dir), default_value);</span><br><span>     if (error=
 !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s-&gt;bin_dir, _countof(s=
-&gt;bin_dir)))</span><br><span>@@ -123,7 +131,7 @@</span><br><span>       =
  goto out;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    error =3D GetRegString(key, L&quot;conf=
ig_ext&quot;, s-&gt;ext_string, sizeof(s-&gt;ext_string), L&quot;=2Eovpn&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    error =3D =
GetRegString(key, L&quot;config_ext&quot;, s-&gt;ext_string, sizeof(s-&gt;e=
xt_string), L&quot;ovpn&quot;);</span><br><span>     if (error !=3D ERROR_S=
UCCESS)</span><br><span>     {</span><br><span>         goto out;</span><br=
><span>@@ -292,6 +300,19 @@</span><br><span>     return error;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CloseHandl=
eEx(LPHANDLE handle)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (handle)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (*handle &amp;&amp; *han=
dle !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            CloseHandle(*handle);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        *handle =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> wchar_t *</span><br><span> utf8to16_size(const char *utf8, int=
 size)</span><br><span> {</span><br><span>diff --git a/src/openvpnserv/inte=
ractive=2Ec b/src/openvpnserv/interactive=2Ec</span><br><span>index d8cf6e1=
=2E=2Ef9b0a73 100644</span><br><span>--- a/src/openvpnserv/interactive=2Ec<=
/span><br><span>+++ b/src/openvpnserv/interactive=2Ec</span><br><span>@@ -4=
9,7 +49,7 @@</span><br><span> #define ERROR_MESSAGE_TYPE    0x20000003</spa=
n><br><span> </span><br><span> static SERVICE_STATUS_HANDLE service;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static SERVICE_STATUS status=
 =3D { =2EdwServiceType =3D SERVICE_WIN32_SHARE_PROCESS };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static SERVICE_STATUS status =3D { =
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
PED overlapped)</span><br><span> {</span><br><span>@@ -3910,13 +3903,6 @@</=
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
v/Makefile=2Eam</span><br><span>index 19de666=2E=2E2753ad2 100644</span><br=
><span>--- a/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>+++=
 b/tests/unit_tests/openvpnserv/Makefile=2Eam</span><br><span>@@ -3,14 +3,3=
4 @@</span><br><span> AM_TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_S=
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
	$(top_srcdir)/src//openvpn/wfp_block=2Eh</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+openvpnserv_automatic_testdriver_CFLAGS  =3D $(openvpnserv_test_cflags)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpnserv_automati=
c_testdriver_LDFLAGS =3D $(openvpnserv_test_ldflags)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+openvpnserv_automatic_testdriver_LDADD   =
=3D $(openvpnserv_test_ldadd)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+openvpnserv_automatic_testdriver_SOURCES =3D test_openvpnserv_aut=
omatic=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpnserv/common=2Ec</span><br><span>diff --git a/tests/unit_=
tests/openvpnserv/test_openvpnserv_automatic=2Ec b/tests/unit_tests/openvpn=
serv/test_openvpnserv_automatic=2Ec</span><br><span>new file mode 100644</s=
pan><br><span>index 0000000=2E=2E7ccbd93</span><br><span>--- /dev/null</spa=
n><br><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv_automatic=
=2Ec</span><br><span>@@ -0,0 +1,238 @@</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP=
 port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             session authentication and key exchange,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet=
 encryption, packet authentication, and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet compression=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2E=
net&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free soft=
ware; you can redistribute it and/or modify</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Li=
cense as published by the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  Free Software Foundation, either version 2 of the License,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  or (at your option) an=
y later version=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program i=
s distributed in the hope that it will be useful,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even th=
e implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Li=
cense for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You sho=
uld have received a copy of the GNU General Public License along</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not,=
 see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifde=
f HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmo=
cka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;winsock2=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;windows=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * The automatic service ca=
nnot be linked together with the interactive one</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * in a single test driver, as both define the=
 same static service state=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;automatic=2Ec&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+BOOL</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ReportStatusToSCMgr(SERVI=
CE_STATUS_HANDLE svc_handle, SERVICE_STATUS *svc_status)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Parse a response like the one sent=
 by the interactive service</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param=
 response  the response string</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param error     receives the error code of the response</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pid       rece=
ives the process id of the response</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return the result of ParseInteractiveServiceResponse()</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+parse_response(PCWSTR response, PDWORD error, PDWORD pid)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* the response is modified while par=
sing, so pass a copy */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    WCHAR buf[256];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(wcslen(response) &lt; _countof(buf));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    wcscpy(buf, response);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return ParseInteractiveServiceResponse(buf, e=
rror, pid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_response_success(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DWORD error =3D 0xdeadbeef;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DWORD pid =3D 0xdeadbeef;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(parse_response(L&quot;0x00000000\n=
0x000004d2\nProcess ID&quot;, &amp;error, &amp;pid));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(error, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pid, 123=
4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_response_error(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    DWORD error =3D 0xdeadbeef;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    DWORD pid =3D 0xdeadbeef;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * An error response carries the name of the failed function in the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * second line, w=
hich must not be mistaken for a process id=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(parse_response(L&quot;0x0000007b\nCreateProce=
ssAsUser\nThe filename is invalid&quot;, &amp;error,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                               &amp;pid))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(error, 0x7b);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(pid, 0);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_response_error_crlf(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    DWORD error =3D 0xdeadbeef;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD pid =3D 0xdeadb=
eef;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* error responses are built w=
ith FormatMessage(), which uses \r\n line breaks */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(parse_response(L&quot;0x2=
0000001\r\nYou have specified a config file location\r\n&quot;, &amp;error,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
            &amp;pid));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(error, 0x20000001);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(pid, 0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_respo=
nse_malformed(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD =
error, pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no line break at all=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false=
(parse_response(L&quot;0x00000000&quot;, &amp;error, &amp;pid));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* neither line is a number */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(parse_response(L&=
quot;hello world\nnot a pid\nmessage&quot;, &amp;error, &amp;pid));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* the error code is a number with trailin=
g garbage */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(parse_response(L&quot;0x00000000xyz\n0x000004d2\nProcess ID&quot;=
, &amp;error, &amp;pid));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* succes=
s response without a process id */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_false(parse_response(L&quot;0x00000000\n&quot;, &=
amp;error, &amp;pid));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* success r=
esponse with an empty process id line */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(parse_response(L&quot;0x00000000\n\nP=
rocess ID&quot;, &amp;error, &amp;pid));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* the process id is a number with trailing garbage */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(parse_response(L&=
quot;0x00000000\n0x000004d2xyz\nProcess ID&quot;, &amp;error, &amp;pid));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* empty lines only */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(parse_response(L=
&quot;\n\n&quot;, &amp;error, &amp;pid));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_add_startup_data(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR buf[32];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t pos =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* the startup data is config dir + \=
0 + options + \0 + password + \0 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(AddStartupData(buf, _countof(buf), &amp;pos=
, L&quot;C:\\cfg&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(pos, 7);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(AddStartupData(buf, _countof(buf), &amp;pos, L&quot;--log x&qu=
ot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(pos, 15);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the password i=
s empty, but still terminated */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(AddStartupData(buf, _countof(buf), &amp;pos, L=
&quot;&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(pos, 16);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the f=
ields are separated and terminated by zeros */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const WCHAR expected[] =3D L&quot;C:\\cfg\0-=
-log x\0&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(pos, _countof(expected));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(wmemcmp(buf, expected, pos), 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_add_startup_data_full(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    WCHAR buf[8];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    size_t pos =3D 0;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 wmemset(buf, L&#39;#&#39;, _countof(buf));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* a string that does not fit is rejected without changing anythin=
g */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(AddStartupData(buf, _countof(buf), &amp;pos, L&quot;12345678&quot;));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(po=
s, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size=
_t i =3D 0; i &lt; _countof(buf); i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        assert_int_equal(buf[i], L&#39;#&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* a string whose terminator ends up as the last element still fits */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(Add=
StartupData(buf, _countof(buf), &amp;pos, L&quot;1234567&quot;));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(pos, _co=
untof(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* but leaves no room =
for another field, not even an empty one */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(AddStartupData(buf, _countof(buf),=
 &amp;pos, L&quot;&quot;));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(pos, _countof(buf));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_log_file_p=
ath(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR path[MAX_P=
ATH];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR name=
[MAX_PATH + 64];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the extension i=
s replaced by =2Elog */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(GetLogFilePath(path, _countof(path), L&quot;C:\\log\\&q=
uot;, L&quot;office=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\office=2E=
log&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a missing backsl=
ash on the log dir is added */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(GetLogFilePath(path, _countof(path), L&quot;C:\\=
log&quot;, L&quot;office=2Eovpn&quot;));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\offi=
ce=2Elog&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* only the la=
st extension is replaced */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(GetLogFilePath(path, _countof(path), L&quot;C:\\log=
\\&quot;, L&quot;my=2Eoffice=2Eovpn&quot;));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\=
my=2Eoffice=2Elog&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a =
name without an extension just gets one */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(GetLogFilePath(path, _countof(path),=
 L&quot;C:\\log\\&quot;, L&quot;office&quot;));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\lo=
g\\office=2Elog&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a na=
me that is nothing but an extension */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(GetLogFilePath(path, _countof(path), L&q=
uot;C:\\log\\&quot;, L&quot;=2Eovpn&quot;));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\log\\=
=2Elog&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* spaces are no=
 problem */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(GetLogFilePath(path, _countof(path), L&quot;C:\\my logs\\&quot;, L&=
quot;my office=2Eovpn&quot;));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(wcscmp(path, L&quot;C:\\my logs\\my office=
=2Elog&quot;), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a config file=
 name that cannot fit the log file name is an error */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    wmemset(name, L&#39;a&#39;, _countof=
(name) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    nam=
e[_countof(name) - 1] =3D L&#39;\0&#39;;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(GetLogFilePath(path, _countof(path), =
L&quot;C:\\log\\&quot;, name));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
a log dir that does not leave room for the name is an error */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(GetLogFilePath(=
path, 8, L&quot;C:\\some\\very\\long\\log\\dir&quot;, L&quot;office=2Eovpn&=
quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+wmain(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_uni=
t_test_setup();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const struct CMUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_response_success),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_response_error),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_response_error_crlf),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_response_malfo=
rmed),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmock=
a_unit_test(test_add_startup_data),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_add_startup_data_full),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(=
test_log_file_path),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D cmocka_run_grou=
p_tests_name(&quot;openvpnserv automatic service tests&quot;, tests, NULL, =
NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br></pre><p>To view, visit =
<a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail">cha=
nge 2001</a>=2E To unsubscribe, or for help writing mail filters, visit <a =
href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 2001 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: Heik=
o Hund &lt;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-CC: Frank Lichtenheld &lt;frank@lichtenheld=2E=
com&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;op=
envpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none=
"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=

<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank=
@lichtenheld=2Ecom&gt; </div>

</body></html>
--XOzTF0y9p88=--


--===============3019907310900100903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3019907310900100903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3019907310900100903==--

