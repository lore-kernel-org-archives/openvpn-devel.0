Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FC99CC6B2D
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=By24FdUxHSGv8tnqnDqIjhfMGSn7VAuVe6Z+Im5ktNc=; b=ifG2tJuP0tfMco
	qcJHjLv8rC3HxpPQybhiQFUIq308qs77ekXz46Y6yNYvvvEGv9727/70ySQXdtiC9PZiVVIGylfWV
	BDzKN/41T8c6UVFr6V6cPEEzCa9+MNoG8tYZtyVGVikE+FzgdROdwxkQzxOSHSAQOHM9KfpkBzO0o
	teI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHaSx-0001Wr-Sc;
	Fri, 16 Oct 2026 05:26:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHaSt-0001Wj-Si
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:26:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9dU7QLReFvPYppj08WpT3ZzRq6FF/D7/K77pgDXX4CE=; b=A5WHcCGZMdLp0bYTtmWw+Sx6p4
 AWRVML72vztcShRtqqEuh1yAYqWjJ2BHJ6pdapYqBS2Cal+2YWnuznEDiB9HEDWfTUbzrTQIk8AGR
 +PQAIEce4aEAQ/6y6ZK/jHWkihs2yCtRJcDtryIdh9TdTp2/6ZK9BZDPKeBp7DcK15ww=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9dU7QLReFvPYppj08WpT3ZzRq6FF/D7/K77pgDXX4CE=; b=h
 SSBrINoKaj5Ap2cLfeiNxWLdrXWyKDsjpHcDHLa3Ze9Ur8H1qnvIdsOFHY8efV3Wp96bp87VjLmeU
 l/oywsAtpwxpHePdKop0ncDDzgI/rx/+7s+VadcglciBNk+LCUwOSmIjjNx4b6Je/9eVs6sRNaQa9
 hvNKBsRSvrtWtY4M=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHaSk-0003Ge-Tb for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:26:45 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso846983f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 22:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792128392; x=1792733192; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9dU7QLReFvPYppj08WpT3ZzRq6FF/D7/K77pgDXX4CE=;
 b=Ma8gL+7y9BtmfbrahugkoMmQYYzZcFAqkJ1bGkRVusQ4CiwDuPrS9hU7UHlJTgCQZe
 O8aQ4Txa9LPMeuKHdhPeFC7PUD5ghkQpRgfVh8f/2tC54wDs8Awf3qd/z2GA5I/otH0r
 rZVndPJE5G0TPceE/RVNiiO+QNykY1jpW63c6z2chkkjbOmYBs1YRXzrwftjjlqYW0As
 xpluwXQ/4L03En4NL3JcSuXuYPxB+sad9qV1fPWrseo9+KUiAWtg6IRtYRrcpiN4AG5S
 UEAz+PvGhKCjgravU58IIioe8M9DQRgot3g4X98tUbP8d8D5dyDq3/Ge4MTmh8hXVkgR
 DgDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792128392; x=1792733192;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9dU7QLReFvPYppj08WpT3ZzRq6FF/D7/K77pgDXX4CE=;
 b=D9TaGMp5BUuaPH5hABK7ROZYr937OfsFlBvBhz1N2iQp/QJuzYk9apg0922NwnnHXp
 jhTRy9FBh7gqk8ligwpU40+qgfKAnSccwZEpVfn2laR75HB49QaywcdSmcNfJFC43Ihk
 T/Wn3Rx3HIaUwBTIMZi2L0YaU5vpqMi2gQSzqDgl8tgHyfFHc9eo12yM0+uvjJzmAT2I
 E3qPS/ql1oxAHrEqqEmKWdi6V/GW9fjJULYj+9RR9WQJ4ehOP2DankCtG5fu/QfiTlMP
 CQD+qeIZbrQNMyZIUm/uuwYBLgOjqwPgCheZqVIDSZpbIstwHbrgRA4j/121dRbTGijw
 03nA==
X-Gm-Message-State: AFq9FYJi7rIJKnxBHCZMYEaF+QXyNurGHijhWlq8Y/GOkFazZs8YMYf2
 Zbs5zDaVJWWv+KWxPzV9DvIf1/GYiH2mKiuVFfiM5xcN8wDeYEtalXYV4FvgcBdYWxnBfQTSBAV
 ohDCLqVTkt3J/vXHopJ6dUGkw0+IrN+n3xcEhkPPRz0byWttBar2m2+g9MTyCRFwdqZ6oNrCUiN
 +AIq5s2Q==
X-Gm-Gg: AYBFou1Mdn9CjSuy+hVT2/T/Ua58vt5hc/mtdAuxaGSJKIhqIWxu0sgjNShWNgTt5+6
 +LZESxhuoBrQxwZVvhuyvMtBPUISoSeyGMD8J9ukqobEPfd/G47bH7jyQyW9rkeUXLFi+T58Q/L
 /7VgSzsHMR6DI8WhzwmrWKWt/0iOd8iOjjllUVEgxo2tX21SPfzhYdPP+m6EprAFDtQsX9yTyb+
 EQzUg55gm3lcjU0DCdyFuA6H5tZo6qqt/OPBDd3sS6oz/HTgR1NFTQvRn0db3IbjUaJV+3n/LKM
 goWe8fgBwxR2xul6L4bVCzaJ5RoEX+B4f3OnPpeeSeGeVUR78yUnx/BWF5gZHzAPplZieqYB8ak
 brmGrbgv27gFJy1BxJ0Xbrbpg6aI4dYuBnDTfGt3Q3Wl/47ikvF88m8o5R8rRcn88STpkf5RH+P
 7bvNRzsH2Py/BMOF43hIO0vn4JiycUFyoLBQoSxA7jfL8pf/Hw0d/8jxE6tTL8WMVucm0SwFikI
 0v/SdLKswmUPVK49dl5hKo01tYTOSJwTyXA6gthN6t3jEDI8Cq27baN37wPOvwSLDItSA7hr5aa
 g1V5GQ4e/P3suROTZXyWv25iHr9KXv764DxqwWAuRIgEECGVg8DH0T/ymRiR
X-Received: by 2002:a05:6000:29c3:b0:486:f907:ebec with SMTP id
 ffacd0b85a97d-48dba9d487dmr30362728f8f.31.1792128391292; 
 Thu, 15 Oct 2026 22:26:31 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd471a1fsm2240497f8f.3.2026.10.15.22.26.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 22:26:30 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 05:26:30 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
X-Gerrit-Change-Number: 2001
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2001?usp=email>
X-Gerrit-Commit: 7d670ace40e14f9ab055d21ade40342b4e757ad1
References: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMTI4Mzg3MDAwLkkwODllNWI3OTYwMGM1MzVlM2MwYzVkMWJiMTQzMTlhYzAzZjQxNDRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <82653810044675f5c94406c098fe38bddc34bac3-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHaSk-0003Ge-Tb
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
 openvpn-devel@lists.sourceforge.net
Cc: "Heiko Hund \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0901003272129421780=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0901003272129421780==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l4TOG7nVHvE="; charset=UTF-8

--l4TOG7nVHvE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2001?usp=3Demail

to review the following change=2E
=


Change subject: openvpnserv: add automatic service again
=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: add automatic s=
ervice again

The automatic service, which starts all configs in the autost=
art config
directory, was removed from openvpnserv=2Eexe in 2021 and replac=
ed by the
=2ENET based openvpnserv2=2Eexe=2E Add it back, implemented in C,=
 so that both
Windows services are maintained in this repository=2E

Securi=
ty related changes added:
- before sending any data, verify that the named =
pipe is served by the
  interactive service process
- the exit event of eac=
h OpenVPN process has a random name and a DACL
  that only grants access to=
 its owner, so it cannot be pre-created or
  signalled by other users
- the=
 service checks that it is run as the ovpn_service_user account in
  the re=
gistry settings, so that it and openvpn in turn is guaranteed to
  run with=
 limited privileges

Robustness:
- starting a config is retried until the s=
ervice stops, with a delay
  that doubles from 10 seconds up to 5 minutes f=
or configs that keep
  failing, and is reset once a process ran for a minut=
e
- an OpenVPN process that may have been started by a failed attempt is
  =
signalled to exit, so it does not run unmonitored
- configs in subdirectori=
es use their own directory as working
  directory; configs with the same fi=
le name as one found before are
  ignored, like in the GUI

Both services n=
ow run in their own process, selected by the new
'-automatic' and '-interac=
tive' options=2E This is needed since they need
to run with different accou=
nts=2E '-install' takes an optional service
name again=2E '-instance automa=
tic' is not supported, since the service
cannot check the named pipe owner =
for instances=2E

Also add a few unit tests and some documentation=2E

Chan=
ge-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
Signed-off-by: Heiko Hund =
<heiko@ist=2Eeigentlich=2Enet>
---
M Changes=2Emd
M doc/Makefile=2Eam
A doc=
/automatic-service-notes=2Erst
M src/openvpnserv/CMakeLists=2Etxt
M src/ope=
nvpnserv/Makefile=2Eam
A src/openvpnserv/automatic=2Ec
M src/openvpnserv/co=
mmon=2Ec
M src/openvpnserv/interactive=2Ec
M src/openvpnserv/service=2Ec
M =
src/openvpnserv/service=2Eh
M tests/unit_tests/openvpnserv/Makefile=2Eam
A =
tests/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec
12 files change=
d, 1,650 insertions(+), 64 deletions(-)



  git pull ssh://gerrit=2Eopenvp=
n=2Enet:29418/openvpn refs/changes/01/2001/1

diff --git a/Changes=2Emd b/C=
hanges=2Emd
index 5c3270b=2E=2E813ac33 100644
--- a/Changes=2Emd
+++ b/Chan=
ges=2Emd
@@ -23,6 +23,33 @@
   the characters mentioned above were already =
escaped=2E However, the behavior of
   Mbed TLS is slightly different from =
OpenSSL in that it also escapes "=3D"=2E
 
+* **Windows automatic service m=
oved back into this repository**
+
+  OpenVPNService, which starts all conf=
igs in the `config-auto` directory at
+  boot time, is no longer provided b=
y the =2ENET based `openvpnserv2=2Eexe`, but by
+  `openvpnserv=2Eexe`, lik=
e the interactive service is=2E It mostly works like the
+  service it was =
ported from, with these exceptions and additions:
+
+  * The service can no=
 longer be run on the command line, but exclusively as
+    a service throu=
gh the Service Control Manager=2E
+  * The service refuses to start if it d=
oes not run as the account
+    `NT SERVICE\OpenVPNService`=2E This is chec=
ked for security reasons: OpenVPN
+    runs under the same account, so its =
configs, scripts and plugins would get
+    all privileges of a more privil=
eged account as well=2E
+  * All service related logging is done via event =
log=2E The event source changed
+    from `OpenVpnService` to `openvpnserv`=
, same as for the interactive one=2E
+  * An OpenVPN process that cannot be=
 started or exits is started again,
+    first after 10 seconds, with the d=
elay doubling up to 5 minutes for
+    processes that keep failing=2E
+  * =
Configs in subdirectories of `config-auto` use their own directory as
+    =
working directory=2E Of several configs with the same file name, only the
+=
    first one found is started, like in the OpenVPN GUI=2E
+  * The automat=
ic and the interactive service now each run in a process of
+    their own,=
 selected by the `-automatic` and `-interactive` options of
+    `openvpnse=
rv=2Eexe`=2E `-install` takes an optional service name=2E
+  * `-instance a=
utomatic` is not supported on purpose=2E It cannot verify the
+    interact=
ive service named pipe for instances before connecting=2E
+
 ## Maintainer-=
visible changes
 
 - The configure-time option `--enable-debug` is no longe=
r  available
diff --git a/doc/Makefile=2Eam b/doc/Makefile=2Eam
index 5ca1c=
4d=2E=2Ebbd83cd 100644
--- a/doc/Makefile=2Eam
+++ b/doc/Makefile=2Eam
@@ -=
55,6 +55,7 @@
 
 dist_noinst_DATA =3D \
 	android=2Etxt \
+	automatic-servi=
ce-notes=2Erst \
 	interactive-service-notes=2Erst \
 	keying-material-expo=
rter=2Etxt \
 	openvpn=2E8=2Erst \
diff --git a/doc/automatic-service-notes=
=2Erst b/doc/automatic-service-notes=2Erst
new file mode 100644
index 00000=
00=2E=2E4c1858c
--- /dev/null
+++ b/doc/automatic-service-notes=2Erst
@@ -0=
,0 +1,151 @@
+OpenVPN Automatic Service Notes
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+Int=
roduction
+------------
+
+OpenVPN Automatic Service, also known as "OpenVP=
NService", is a Windows system
+service which starts an OpenVPN process for=
 each configuration file in the
+autostart configuration folder, ``config-a=
uto`` by default=2E It is meant for
+connections that should be up at all t=
imes, independent of any user being
+logged on=2E
+
+
+How It Works
+------=
------
+
+The Automatic Service does not start OpenVPN itself, but uses the=
 Interactive
+Service to do it, the same way OpenVPN GUI does=2E See
+`inte=
ractive-service-notes=2Erst` for how the Interactive Service works=2E
+
+- =
On start, the service searches the autostart configuration folder and its
+=
  subfolders, up to a depth of 32, for files with the configuration file
+ =
 extension=2E
+
+- For each configuration file it connects to the Interacti=
ve Service named
+  pipe ``\\=2E\pipe\openvpn\service`` and sends the start=
up data=2E Before sending
+  anything it checks that the pipe is served by =
the Interactive Service
+  process, as registered with the Service Control =
Manager=2E
+
+- The Interactive Service starts openvpn=2Eexe with the accou=
nt of the
+  Automatic Service=2E It allows this account to use any options=
 and
+  configuration files in any folder, see `Service Account`_=2E
+
+- T=
he folder of the configuration file is used as the working folder, so
+  re=
lative paths in a configuration file resolve relative to its folder=2E
+
+-=
 openvpn=2Eexe is started with these options::
+
+      --log <log file> --=
config <config file> --service <exit event> 0
+      --pull-filter ignore r=
oute-method
+
+  ``--log-append`` is used instead of ``--log`` if configure=
d=2E The exit event
+  is created by the Automatic Service before each star=
t=2E It has a random name
+  and only its owner, the service account, has a=
ccess to it=2E
+
+- When the service stops, it signals the exit events, whi=
ch makes the
+  OpenVPN processes exit=2E
+
+Configuration files are identi=
fied by their file name, like in OpenVPN GUI=2E
+If there are several confi=
guration files with the same file name in
+different subfolders, only the f=
irst one found is started and an error is
+logged for the others=2E Files i=
n a folder are found before those in its
+subfolders=2E
+
+
+Restarting Ope=
nVPN Processes
+----------------------------
+
+An OpenVPN process that exi=
ts, or that cannot be started, is started again
+until the service stops=2E=
 The first attempt is made after 10 seconds=2E The
+delay doubles with each=
 further failure, up to 5 minutes=2E It is reset to 10
+seconds once an Ope=
nVPN process has run for at least a minute=2E
+
+This also covers the Inter=
active Service not being reachable, for example
+while it is restarted=2E T=
he configurations are started again with the next
+attempt after it is avai=
lable again=2E
+
+
+Service Account
+---------------
+
+The Automatic Servi=
ce runs with the virtual service account
+``NT SERVICE\OpenVPNService``=2E =
The OpenVPN processes it starts run with this
+account too, so configuratio=
n files and anything they reference, like keys
+and certificates, including=
 those in the Windows certificate store, must be
+readable by it=2E The log=
 folder must be writable by it=2E
+
+The service refuses to start if it run=
s with any other account=2E OpenVPN
+runs with the same account, so configu=
ration files, scripts and plugins
+would get all privileges of a more privi=
leged account, like LocalSystem, as
+well=2E The service is installed with =
its required privileges reduced to
+``SeChangeNotifyPrivilege``, which also=
 removes privileges such as
+``SeImpersonatePrivilege`` from the OpenVPN pr=
ocesses=2E
+
+The Interactive Service lets the account ``NT SERVICE\<ovpn_s=
ervice_user>``
+use any options, see `Configuration`_=2E The account the Au=
tomatic Service
+checks for is derived from the same registry value, so bot=
h always agree=2E
+
+
+Configuration
+-------------
+
+The Automatic Servic=
e reads its settings from the
+``HKEY_LOCAL_MACHINE\SOFTWARE\OpenVPN`` regi=
stry key, like the Interactive
+Service=2E All the following registry value=
s are of the ``REG_SZ`` type:
+
+``autostart_config_dir``
+   The autostart=
 configuration folder=2E If this value does not exist or is
+   empty, no c=
onfigurations are started=2E The installer sets it to
+   ``install_dir "\c=
onfig-auto"``=2E
+
+``config_ext``
+   The configuration file extension, wi=
thout a leading dot; defaults to
+   ``"ovpn"``=2E
+
+``log_dir``
+   The f=
older for the log files; defaults to ``install_dir "\log"``=2E The
+   inst=
aller sets it to ``%ProgramData%\OpenVPN\Log`` and makes it writable
+   fo=
r the service account=2E Each OpenVPN process logs to a file in this
+   fo=
lder, named like its configuration file, with the extension replaced by
+  =
 ``=2Elog``=2E
+
+``log_append``
+   ``"1"`` to append to existing log file=
s, ``"0"`` (default) to truncate
+   them when an OpenVPN process is starte=
d=2E
+
+``ovpn_service_user``
+   The name of the service account, without =
the ``NT SERVICE\`` prefix;
+   defaults to ``"OpenVPNService"``=2E Used by=
 the Interactive Service to
+   authorize the Automatic Service and by the =
Automatic Service to check
+   its own account=2E
+
+The values ``exe_path`=
` and ``priority`` described in
+`interactive-service-notes=2Erst` apply to=
o, as the Interactive Service starts
+the OpenVPN processes=2E
+
+The servi=
ce writes its own messages to the Windows event log, using the
+``openvpnse=
rv`` event source, the same as the Interactive Service=2E
+
+
+Installation=

+------------
+
+The OpenVPN installer registers the service, whether or n=
ot the "OpenVPN
+Service" feature is selected=2E Without the feature it is =
disabled, otherwise
+it is set to start automatically and started=2E Upgrad=
es keep the start mode
+and running state of the service=2E
+
+The services=
 can also be registered from an elevated command prompt::
+
+      openvpns=
erv=2Eexe -install [automatic|interactive]
+
+Without a name, both services=
 are registered=2E A service that is registered
+already is left alone=2E T=
he Automatic Service is registered with the
+``-automatic`` option, its acc=
ount, the dependency on the Interactive Service
+and its reduced privileges=
=2E Both services run in a process of their own,
+selected by the ``-automa=
tic`` and ``-interactive`` options=2E
+
+Unlike the Interactive Service, th=
e Automatic Service does not support the
+``-instance`` option for side-by-=
side installations=2E
diff --git a/src/openvpnserv/CMakeLists=2Etxt b/src/o=
penvpnserv/CMakeLists=2Etxt
index 2cc4a93=2E=2Edbb7651 100644
--- a/src/ope=
nvpnserv/CMakeLists=2Etxt
+++ b/src/openvpnserv/CMakeLists=2Etxt
@@ -35,6 +=
35,7 @@
 add_common_options(openvpnserv)
 target_sources(openvpnserv PRIVAT=
E
     common=2Ec
+    automatic=2Ec
     interactive=2Ec
     service=2Ec =
service=2Eh
     validate=2Ec validate=2Eh
@@ -82,6 +83,7 @@
 if (BUILD_TES=
TING)
     set(unit_tests
         "test_openvpnserv"
+        "test_openvp=
nserv_automatic"
     )
 
     foreach (test_name ${unit_tests})
@@ -104,4 =
+106,8 @@
         validate=2Ec
         =2E=2E/openvpn/wfp_block=2Ec =2E=
=2E/openvpn/wfp_block=2Eh
     )
+
+    target_sources(test_openvpnserv_aut=
omatic PRIVATE
+        common=2Ec
+    )
 endif ()
diff --git a/src/openvp=
nserv/Makefile=2Eam b/src/openvpnserv/Makefile=2Eam
index 447fb10=2E=2Ed3ca=
665 100644
--- a/src/openvpnserv/Makefile=2Eam
+++ b/src/openvpnserv/Makefi=
le=2Eam
@@ -35,6 +35,7 @@
 
 openvpnserv_SOURCES =3D \
         common=2Ec =
\
+	automatic=2Ec \
 	interactive=2Ec \
 	service=2Ec service=2Eh \
 	valid=
ate=2Ec validate=2Eh \
diff --git a/src/openvpnserv/automatic=2Ec b/src/ope=
nvpnserv/automatic=2Ec
new file mode 100644
index 0000000=2E=2E54d17a0
--- =
/dev/null
+++ b/src/openvpnserv/automatic=2Ec
@@ -0,0 +1,1014 @@
+/*
+ *  O=
penVPN -- An application to securely tunnel IP networks
+ *             ove=
r a single TCP/UDP port, with support for SSL/TLS-based
+ *             ses=
sion authentication and key exchange,
+ *             packet encryption, pa=
cket authentication, and
+ *             packet compression=2E
+ *
+ *  Cop=
yright (C) 2026- OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is=
 free software; you can redistribute it and/or modify
+ *  it under the ter=
ms of the GNU General Public License version 2
+ *  as published by the Fre=
e Software Foundation=2E
+ *
+ *  This program is distributed in the hope t=
hat it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E=
  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You =
should have received a copy of the GNU General Public License along
+ *  wi=
th this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
=
+/*
+ * The automatic service starts one OpenVPN process for each configura=
tion
+ * file found in the autostart config directory and restarts them whe=
n they
+ * exit unexpectedly=2E The OpenVPN processes are not started direc=
tly, but by
+ * the interactive service, which this service talks to via it=
s named pipe=2E
+ */
+
+#include "service=2Eh"
+
+#include <handleapi=2Eh>
=
+#include <pathcch=2Eh>
+#include <rpc=2Eh>
+#include <sddl=2Eh>
+#include =
<stdio=2Eh>
+#include <stdlib=2Eh>
+
+/* Time we give the interactive servi=
ce to accept our connection */
+#define ISERVICE_CONNECT_TIMEOUT 5000 /*ms*=
/
+
+/*
+ * Time we wait before an OpenVPN process is started again, after =
it exited
+ * or could not be started=2E The delay doubles with each failed=
 attempt, up
+ * to the maximum=2E A process that ran for a while resets it=
 to the minimum=2E
+ */
+#define RESTART_DELAY_MIN 10000  /*ms*/
+#define R=
ESTART_DELAY_MAX 300000 /*ms*/
+#define STABLE_RUNTIME    60000  /*ms*/
+
+=
/* Maximum size of the startup data sent to the interactive service */
+#de=
fine STARTUP_DATA_MAX 2048
+
+/* Maximum recursion depth when searching for=
 configuration files */
+#define MAX_RECURSION_DEPTH 32
+
+/* Name of the i=
nteractive service we talk to */
+#define ISERVICE_NAME _L(PACKAGE_NAME) L"=
ServiceInteractive"
+
+/* The service cannot run without the interactive se=
rvice, so we make it depend on it=2E */
+#define AUTOMATIC_SERVICE_DEPENDEN=
CIES ISERVICE_NAME L"\0\0"
+
+/*
+ * The service runs as its own virtual se=
rvice account, which the interactive
+ * service trusts, and needs no privi=
leges besides the one every process has=2E
+ */
+#define AUTOMATIC_SERVICE_=
ACCOUNT    L"NT SERVICE\\" _L(PACKAGE_NAME) L"Service"
+#define AUTOMATIC_S=
ERVICE_PRIVILEGES L"SeChangeNotifyPrivilege\0\0"
+
+openvpn_service_t autom=
atic_service =3D { automatic,
+                                        _L(P=
ACKAGE_NAME) L"Service",
+                                        _L(PACKAG=
E_NAME) L" Automatic Service",
+                                        AUT=
OMATIC_SERVICE_DEPENDENCIES,
+                                        SERVI=
CE_DEMAND_START,
+                                        L"-automatic",
+ =
                                       // cppcheck-suppress unknownMacro ; =
FP, _L after a string literal
+                                        AUTO=
MATIC_SERVICE_ACCOUNT,
+                                        AUTOMATIC_S=
ERVICE_PRIVILEGES };
+
+static SERVICE_STATUS_HANDLE service;
+static SERVI=
CE_STATUS status =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS };
+s=
tatic HANDLE exit_event =3D NULL;
+
+static settings_t settings;
+
+/* One =
OpenVPN connection, i=2Ee=2E one configuration file */
+typedef struct open=
vpn_process
+{
+    struct openvpn_process *next;
+    WCHAR working_dir[MA=
X_PATH];
+    WCHAR config_file[MAX_PATH];
+    WCHAR log_file[MAX_PATH];
+=
    HANDLE process;
+    HANDLE exit_event;
+    HANDLE stop_event;
+    HA=
NDLE thread;
+    CRITICAL_SECTION cs;
+} openvpn_process_t;
+
+static open=
vpn_process_t *processes =3D NULL;
+
+/**
+ * Add a zero terminated string =
to a buffer=2E
+ *
+ * @param buf   string buffer to append to
+ * @param s=
ize  size of the buffer in wide characters
+ * @param pos   in/out position=
 in the buffer in wide characters
+ * @param str   the string to append
+ *=

+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+AddStar=
tupData(PWSTR buf, size_t size, size_t *pos, PCWSTR str)
+{
+    size_t len=
 =3D wcslen(str) + 1;
+
+    if (*pos + len > size)
+    {
+        return =
FALSE;
+    }
+
+    wmemcpy(buf + *pos, str, len);
+    *pos +=3D len;
+
+=
    return TRUE;
+}
+
+/**
+ * Get the process id of the interactive servic=
e
+ *
+ * @return the process id, or 0 if the service is not running or on =
error
+ */
+static DWORD
+GetInteractiveServicePid(void)
+{
+    DWORD pid =
=3D 0;
+
+    SC_HANDLE scm =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNEC=
T);
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
+ * Check that the server end of a pipe is the interactive serv=
ice
+ *
+ * Makes sure we do not send data to, or can be impersonated by, a=
 process
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
 off the first line of a string
+ *
+ * Lines end with "\n" or "\r\n" in er=
ror responses of the interactive service=2E
+ *
+ * @param str  the string =
to split, its first line is zero terminated in place
+ *
+ * @return the st=
art of the next line, or NULL if there is none
+ */
+static PWSTR
+SplitLin=
e(PWSTR str)
+{
+    PWSTR eol =3D wcschr(str, L'\n');
+    if (!eol)
+    =
{
+        return NULL;
+    }
+
+    *eol =3D L'\0';
+    if (eol > str &&=
 eol[-1] =3D=3D L'\r')
+    {
+        eol[-1] =3D L'\0';
+    }
+
+    ret=
urn eol + 1;
+}
+
+/**
+ * Parse the response of the interactive service
+ =
*
+ * The response is a three line string, with the error code in the first=
,
+ * the process id in the second if OpenVPN was started successfully and
=
+ * a message in the third line=2E
+ *
+ * @param response  the zero termin=
ated response, which is modified
+ * @param error     receives the error co=
de returned by the service
+ * @param pid       receives the process id of =
the OpenVPN process
+ *
+ * @return BOOL to indicate success or failure
+ *=
/
+static BOOL
+ParseInteractiveServiceResponse(PWSTR response, PDWORD erro=
r, PDWORD pid)
+{
+    PWSTR pid_line =3D SplitLine(response);
+    if (!pi=
d_line)
+    {
+        SetLastError(ERROR_INVALID_DATA);
+        return F=
ALSE;
+    }
+    SplitLine(pid_line);
+
+    PWSTR end;
+    *error =3D wc=
stoul(response, &end, 16);
+    if (end =3D=3D response || *end !=3D L'\0')=

+    {
+        SetLastError(ERROR_INVALID_DATA);
+        return FALSE;
+=
    }
+
+    *pid =3D 0;
+    if (*error =3D=3D 0)
+    {
+        *pid =3D=
 wcstoul(pid_line, &end, 16);
+        if (end =3D=3D pid_line || *end !=3D=
 L'\0')
+        {
+            SetLastError(ERROR_INVALID_DATA);
+        =
    return FALSE;
+        }
+    }
+
+    return TRUE;
+}
+
+/**
+ * Read =
the response of the interactive service from the pipe
+ *
+ * @param pipe  =
 the pipe to read the response from
+ * @param error  receives the error co=
de returned by the service
+ * @param pid    receives the process id of the=
 OpenVPN process
+ *
+ * @return BOOL to indicate success or failure
+ */
+=
static BOOL
+ReadInteractiveServiceResponse(HANDLE pipe, PDWORD error, PDWO=
RD pid)
+{
+    WCHAR buf[1024];
+    DWORD bytes;
+
+    if (!ReadFile(pip=
e, buf, sizeof(buf) - sizeof(buf[0]), &bytes, NULL))
+    {
+        return=
 FALSE;
+    }
+
+    buf[bytes / sizeof(buf[0])] =3D L'\0';
+
+    return =
ParseInteractiveServiceResponse(buf, error, pid);
+}
+
+/**
+ * Build the p=
ath of the log file of a configuration file
+ *
+ * The log file is named l=
ike the configuration file, with its extension
+ * replaced by "=2Elog", an=
d is placed in the log directory=2E
+ *
+ * @param log_file  buffer that re=
ceives the log file path
+ * @param size      size of the buffer in wide ch=
aracters
+ * @param log_dir   the directory the log file is placed in
+ * @=
param name      the file name of the configuration file
+ *
+ * @return BOO=
L to indicate success or failure
+ */
+static BOOL
+GetLogFilePath(PWSTR lo=
g_file, size_t size, PCWSTR log_dir, PCWSTR name)
+{
+    WCHAR log_name[MA=
X_PATH];
+    PCWSTR dot =3D wcsrchr(name, L'=2E');
+    int len =3D dot ? =
(int)(dot - name) : (int)(wcslen(name));
+
+    return swprintf(log_name, _=
countof(log_name), L"%=2E*ls=2Elog", len, name) >=3D 0
+           && PathC=
chCombine(log_file, size, log_dir, log_name) =3D=3D S_OK;
+}
+
+/**
+ * Cre=
ate the event used to signal an OpenVPN process to exit
+ *
+ * The name of=
 the event is random, so others cannot create it in advance
+ * and keep it=
 under their control=2E Should the name exist already anyway,
+ * another o=
ne is tried=2E Only the owner of the event has access to it=2E
+ * OpenVPN =
runs with the same account as this service, so it can open the
+ * event by=
 its name=2E
+ *
+ * @param name  buffer that receives the name of the even=
t
+ * @param size  size of the buffer in wide characters
+ *
+ * @return th=
e event handle, or INVALID_HANDLE_VALUE on error
+ */
+static HANDLE
+Creat=
eExitEvent(PWSTR name, size_t size)
+{
+    SECURITY_ATTRIBUTES sa =3D { =
=2EnLength =3D sizeof(sa) };
+    HANDLE event =3D INVALID_HANDLE_VALUE;
+
=
+    if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(
+          =
  L"D:P(A;;GA;;;OW)", SDDL_REVISION_1, &sa=2ElpSecurityDescriptor, NULL))
+=
    {
+        return event;
+    }
+
+    const int max_tries =3D 3;
+    =
for (int tries =3D 0; tries < max_tries; tries++)
+    {
+        UUID uuid=
;
+        RPC_WSTR uuid_str;
+        if (UuidCreate(&uuid) !=3D RPC_S_OK =
|| UuidToStringW(&uuid, &uuid_str) !=3D RPC_S_OK)
+        {
+            b=
reak;
+        }
+        swprintf(name, size, _L(PACKAGE) L"_exit_%ls", (P=
WSTR)uuid_str);
+        RpcStringFreeW(&uuid_str);
+
+        event =3D Cr=
eateEvent(&sa, TRUE, FALSE, name);
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
+ * Start a OpenVPN process for a configuration file
+ *
+ * Connect=
s to the interactive service, sends the startup data and reads
+ * back the=
 process id of the started OpenVPN process=2E
+ *
+ * @param p  the process=
 to start
+ *
+ * @return BOOL to indicate success or failure
+ */
+static =
BOOL
+StartProcess(openvpn_process_t *p)
+{
+    WCHAR cmdline[STARTUP_DATA=
_MAX];
+    WCHAR startup_data[STARTUP_DATA_MAX];
+    WCHAR exit_event_nam=
e[MAX_PATH];
+    HANDLE pipe =3D INVALID_HANDLE_VALUE;
+    size_t pos =3D=
 0;
+    DWORD error, pid, written;
+    BOOL ret =3D FALSE;
+
+    /* each=
 OpenVPN process gets a new exit event */
+    HANDLE event =3D CreateExitE=
vent(exit_event_name, _countof(exit_event_name));
+    if (!event)
+    {
+=
        MsgToEventLog(M_SYSERR, L"Could not create exit event for config %l=
s", p->config_file);
+        return FALSE;
+    }
+
+    const WCHAR *log_=
option =3D settings=2Eappend ? L"--log-append" : L"--log";
+    int n =3D s=
wprintf(cmdline, _countof(cmdline),
+                     L"%ls \"%ls\" --c=
onfig \"%ls\" --service \"%ls\" 0 --pull-filter ignore route-method",
+    =
                 log_option, p->log_file, p->config_file, exit_event_name);=

+    if (n < 0)
+    {
+        MsgToEventLog(M_ERR, L"Command line too lo=
ng for config %ls", p->config_file);
+        goto out;
+    }
+
+    /* wo=
rking dir + \0 + options + \0 + password + \0 */
+    if (!AddStartupData(s=
tartup_data, _countof(startup_data), &pos, p->working_dir)
+        || !Add=
StartupData(startup_data, _countof(startup_data), &pos, cmdline)
+        |=
| !AddStartupData(startup_data, _countof(startup_data), &pos, L""))
+    {
=
+        MsgToEventLog(M_ERR, L"Startup data too long for config %ls", p->c=
onfig_file);
+        goto out;
+    }
+
+    pipe =3D ConnectToInteractive=
Service(ISERVICE_CONNECT_TIMEOUT);
+    if (pipe =3D=3D INVALID_HANDLE_VALU=
E)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not connect to the inter=
active service");
+        goto out;
+    }
+
+    if (!WriteFile(pipe, sta=
rtup_data, (DWORD)(pos * sizeof(startup_data[0])), &written, NULL))
+    {
=
+        MsgToEventLog(M_SYSERR, L"Could not send startup data to interacti=
ve service");
+        goto out;
+    }
+
+    if (!ReadInteractiveServiceR=
esponse(pipe, &error, &pid))
+    {
+        MsgToEventLog(M_SYSERR, L"Coul=
d not read response from iservice");
+        goto out;
+    }
+
+    if (e=
rror !=3D 0)
+    {
+        MsgToEventLog(M_ERR, L"Error starting openvpn =
process: %lu", error);
+        goto out;
+    }
+
+    /*
+     * The inte=
ractive service restricts access to the OpenVPN process=2E It does
+     * =
not grant PROCESS_QUERY_LIMITED_INFORMATION, but PROCESS_QUERY_INFORMATION=
=2E
+     */
+    HANDLE process =3D OpenProcess(SYNCHRONIZE | PROCESS_QUER=
Y_INFORMATION, FALSE, pid);
+    if (!process)
+    {
+        MsgToEventLo=
g(M_SYSERR, L"Could not open OpenVPN process, PID %lu", pid);
+        goto=
 out;
+    }
+
+    EnterCriticalSection(&p->cs);
+    CloseHandleEx(&p->pr=
ocess);
+    CloseHandleEx(&p->exit_event);
+    p->process =3D process;
+ =
   p->exit_event =3D event;
+    event =3D NULL;
+    LeaveCriticalSection(=
&p->cs);
+
+    MsgToEventLog(M_INFO, L"Started openvpn process %lu for con=
fig %ls", pid, p->config_file);
+    ret =3D TRUE;
+
+out:
+    /*
+     * =
An OpenVPN process may have been started, even if we could not get a
+     =
* handle of it or did not receive the response=2E Make sure it exits, as
+ =
    * it would not be monitored nor stopped otherwise=2E
+     */
+    if (=
!ret && event)
+    {
+        SetEvent(event);
+    }
+    CloseHandleEx(&=
pipe);
+    CloseHandleEx(&event);
+    return ret;
+}
+
+/**
+ * Signal an=
 OpenVPN process to exit
+ *
+ * @param p  the process to signal
+ */
+stat=
ic void
+SignalProcess(openvpn_process_t *p)
+{
+    EnterCriticalSection(&=
p->cs);
+    if (p->process && WaitForSingleObject(p->process, 0) =3D=3D WA=
IT_TIMEOUT
+        && !SetEvent(p->exit_event))
+    {
+        DWORD pid =
=3D GetProcessId(p->process);
+        MsgToEventLog(M_SYSERR, L"Error sign=
alling PID %lu to exit", pid);
+    }
+    LeaveCriticalSection(&p->cs);
+}=

+
+/**
+ * Run the OpenVPN process for a config and restart it when it exi=
ts
+ *
+ * Starting the process is retried until the service stops=2E The d=
elay
+ * between the attempts grows when a process cannot be started or exi=
ts
+ * right away, so a broken config does not keep the system busy=2E
+ *
=
+ * @param process  the process to run
+ */
+static DWORD WINAPI
+MonitorPr=
ocess(LPVOID process)
+{
+    openvpn_process_t *p =3D process;
+    DWORD =
delay =3D RESTART_DELAY_MIN;
+
+    while (TRUE)
+    {
+        ULONGLONG =
started =3D GetTickCount64();
+        if (StartProcess(p))
+        {
+   =
         HANDLE handles[2];
+
+            EnterCriticalSection(&p->cs);
+ =
           handles[0] =3D p->stop_event;
+            handles[1] =3D p->pro=
cess;
+            DWORD pid =3D GetProcessId(p->process);
+            Lea=
veCriticalSection(&p->cs);
+
+            if (WaitForMultipleObjects(2, han=
dles, FALSE, INFINITE) =3D=3D WAIT_OBJECT_0)
+            {
+              =
  break;
+            }
+
+            MsgToEventLog(M_INFO, L"OpenVPN proc=
ess %lu for config %ls has exited", pid,
+                          p->conf=
ig_file);
+
+            /* a process that ran for a while did not fail rig=
ht away */
+            if (GetTickCount64() - started >=3D STABLE_RUNTIME)=

+            {
+                delay =3D RESTART_DELAY_MIN;
+            =
}
+        }
+
+        MsgToEventLog(M_INFO, L"Starting config %ls again i=
n %lu sec", p->config_file,
+                      delay / 1000);
+
+      =
  if (WaitForSingleObject(p->stop_event, delay) =3D=3D WAIT_OBJECT_0)
+    =
    {
+            break;
+        }
+
+        delay =3D min(delay * 2, RE=
START_DELAY_MAX);
+    }
+
+    return NO_ERROR;
+}
+
+/**
+ * Find a proce=
ss entry with a config file of the given name
+ *
+ * @param name  the file=
 name of the config, without the path
+ *
+ * @return the process entry, or=
 NULL if there is none
+ */
+static openvpn_process_t *
+FindProcessByName(=
PCWSTR name)
+{
+    for (openvpn_process_t *p =3D processes; p; p =3D p->n=
ext)
+    {
+        PCWSTR p_name =3D wcsrchr(p->config_file, L'\\');
+   =
     p_name =3D p_name ? p_name + 1 : p->config_file;
+        if (_wcsicmp=
(p_name, name) =3D=3D 0)
+        {
+            return p;
+        }
+    =
}
+    return NULL;
+}
+
+/**
+ * Create a process entry for a configuratio=
n file and start the thread
+ * that runs the OpenVPN process for it=2E
+ *=

+ * A config with the same file name as one that was found before is ignor=
ed,
+ * as both would use the same log file=2E This is in line with how ope=
nvpn-gui
+ * handles duplicates=2E
+ *
+ * @param working_dir  the director=
y the config file is in
+ * @param config_file  path of the configuration f=
ile
+ */
+static void
+StartConfig(PCWSTR working_dir, PCWSTR config_file)
=
+{
+    PCWSTR name =3D wcsrchr(config_file, L'\\');
+    name =3D name ? n=
ame + 1 : config_file;
+
+    openvpn_process_t *dup =3D FindProcessByName(=
name);
+    if (dup)
+    {
+        MsgToEventLog(M_ERR, L"Config %ls has =
the same file name as %ls, ignoring it",
+                      config_file=
, dup->config_file);
+        return;
+    }
+
+    openvpn_process_t *p =
=3D calloc(1, sizeof(*p));
+    if (!p)
+    {
+        MsgToEventLog(M_ERR=
, L"Out of memory starting openvpn for %ls", config_file);
+        return;=

+    }
+
+    if (!GetLogFilePath(p->log_file, _countof(p->log_file), sett=
ings=2Elog_dir, name))
+    {
+        MsgToEventLog(M_ERR, L"Error startin=
g openvpn for %ls", config_file);
+        free(p);
+        return;
+    }=

+
+    p->stop_event =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+    if (!p=
->stop_event)
+    {
+        MsgToEventLog(M_SYSERR, L"Error starting open=
vpn for %ls", config_file);
+        free(p);
+        return;
+    }
+
+  =
  wcsncpy(p->working_dir, working_dir, _countof(p->working_dir) - 1);
+    =
wcsncpy(p->config_file, config_file, _countof(p->config_file) - 1);
+    In=
itializeCriticalSection(&p->cs);
+
+    p->next =3D processes;
+    process=
es =3D p;
+
+    p->thread =3D CreateThread(NULL, 0, MonitorProcess, p, 0, =
NULL);
+    if (!p->thread)
+    {
+        MsgToEventLog(M_SYSERR, L"Could=
 not create monitoring thread for %ls", config_file);
+    }
+}
+
+/**
+ * =
Recursively find configuration files in a directory
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
+ * The interactive service lets NT SERVICE\<ovpn_servic=
e_user> start OpenVPN
+ * with any options=2E Running as a more privileged =
account, like LocalSystem,
+ * would run all with these elevated privileges=
=2E So, rather refuse to run
+ * as any other account, in case an admin is =
adventurous=2E
+ *
+ * @param s  the settings, with the name of the service=
 account
+ *
+ * @return BOOL to indicate whether we run as the service acc=
ount
+ */
+static BOOL
+IsRunningAsServiceAccount(const settings_t *s)
+{
+=
    BOOL ret =3D FALSE;
+
+    /*
+     * A TOKEN_USER with room for the la=
rgest possible SID after it=2E The sid
+     * member alone is used for the=
 SID of the account, as it is aligned=2E
+     */
+    struct
+    {
+     =
   TOKEN_USER token_user;
+        BYTE sid[SECURITY_MAX_SID_SIZE];
+    } =
token_user_info, account_info;
+
+    WCHAR account[MAX_NAME];
+    DWORD s=
id_size =3D sizeof(account_info=2Esid);
+    WCHAR domain[MAX_NAME];
+    D=
WORD domain_size =3D _countof(domain);
+    SID_NAME_USE use;
+
+    swprin=
tf(account, _countof(account), L"NT SERVICE\\%ls", s->ovpn_service_user);
+=
    if (!LookupAccountName(NULL, account, account_info=2Esid, &sid_size, do=
main, &domain_size, &use))
+    {
+        MsgToEventLog(M_SYSERR, L"Could =
not look up account %ls", account);
+        return FALSE;
+    }
+
+    HA=
NDLE token;
+    if (!OpenProcessToken(GetCurrentProcess(), TOKEN_QUERY, &t=
oken))
+    {
+        MsgToEventLog(M_SYSERR, L"Could not open process tok=
en");
+        return FALSE;
+    }
+
+    DWORD len;
+    BOOL got_user =
=3D
+        GetTokenInformation(token, TokenUser, &token_user_info, sizeof=
(token_user_info), &len);
+    CloseHandle(token);
+    if (!got_user)
+   =
 {
+        MsgToEventLog(M_SYSERR, L"Could not get token user");
+        =
return FALSE;
+    }
+
+    ret =3D EqualSid(token_user_info=2Etoken_user=
=2EUser=2ESid, account_info=2Esid);
+    if (!ret)
+    {
+        MsgToEve=
ntLog(M_ERR, L"Service must run as %ls, refusing to start", account);
+    =
}
+
+    return ret;
+}
+
+
+static DWORD WINAPI
+ServiceCtrlAutomatic(DWOR=
D ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
+{
+    SERVICE_STATUS *=
svc_status =3D ctx;
+    switch (ctrl_code)
+    {
+        case SERVICE_CO=
NTROL_STOP:
+            svc_status->dwCurrentState =3D SERVICE_STOP_PENDIN=
G;
+            /* threads may be connecting to the interactive service */
=
+            svc_status->dwWaitHint =3D ISERVICE_CONNECT_TIMEOUT + 1000;
+ =
           ReportStatusToSCMgr(service, svc_status);
+            if (exit_=
event)
+            {
+                SetEvent(exit_event);
+            }=

+            return NO_ERROR;
+
+        case SERVICE_CONTROL_INTERROGATE:=

+            return NO_ERROR;
+
+        default:
+            return ERRO=
R_CALL_NOT_IMPLEMENTED;
+    }
+}
+
+
+VOID WINAPI
+ServiceStartAutomatic(D=
WORD dwArgc, LPWSTR *lpszArgv)
+{
+    DWORD error =3D NO_ERROR;
+
+    ser=
vice =3D RegisterServiceCtrlHandlerEx(automatic_service=2Ename, ServiceCtrl=
Automatic, &status);
+    if (!service)
+    {
+        return;
+    }
+
+ =
   status=2EdwCurrentState =3D SERVICE_START_PENDING;
+    status=2EdwServi=
ceSpecificExitCode =3D NO_ERROR;
+    status=2EdwWin32ExitCode =3D NO_ERROR=
;
+    status=2EdwWaitHint =3D 3000;
+
+    if (!ReportStatusToSCMgr(servic=
e, &status))
+    {
+        MsgToEventLog(M_ERR, L"ReportStatusToSCMgr SER=
VICE_START_PENDING failed");
+        goto finish;
+    }
+
+    /*
+     *=
 Create our exit event
+     * This event is initially created in the non-s=
ignaled state=2E It will
+     * transition to the signaled state when we h=
ave received a terminate
+     * signal from the Service Control Manager=2E=

+     */
+    exit_event =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+    if=
 (!exit_event)
+    {
+        error =3D MsgToEventLog(M_SYSERR, L"CreateEv=
ent for exit event failed");
+        goto finish;
+    }
+
+    /* Read se=
ttings from registry */
+    error =3D GetOpenvpnSettings(&settings);
+    =
if (error !=3D ERROR_SUCCESS)
+    {
+        goto finish;
+    }
+
+    if=
 (!IsRunningAsServiceAccount(&settings))
+    {
+        error =3D ERROR_AC=
CESS_DENIED;
+        goto finish;
+    }
+
+    StartAllProcesses();
+
+  =
  status=2EdwCurrentState =3D SERVICE_RUNNING;
+    status=2EdwWaitHint =3D=
 0;
+    if (!ReportStatusToSCMgr(service, &status))
+    {
+        MsgToE=
ventLog(M_ERR, L"ReportStatusToSCMgr SERVICE_RUNNING failed");
+        got=
o finish;
+    }
+
+    if (WaitForSingleObject(exit_event, INFINITE) !=3D =
WAIT_OBJECT_0)
+    {
+        MsgToEventLog(M_ERR, L"wait for shutdown sig=
nal failed");
+    }
+
+finish:
+    StopAllProcesses();
+    FreeAllProces=
ses();
+
+    CloseHandleEx(&exit_event);
+
+    status=2EdwCurrentState =
=3D SERVICE_STOPPED;
+    status=2EdwWin32ExitCode =3D error;
+    ReportSt=
atusToSCMgr(service, &status);
+}
diff --git a/src/openvpnserv/common=2Ec b=
/src/openvpnserv/common=2Ec
index 7a23d41=2E=2E10a5207 100644
--- a/src/ope=
nvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -38,7 +38,7 @@
    =
 if (status =3D=3D ERROR_FILE_NOT_FOUND && default_value)
     {
         s=
ize_t len =3D size / sizeof(data[0]);
-        if (swprintf(data, len, defa=
ult_value))
+        if (swprintf(data, len, default_value) >=3D 0)
       =
  {
             status =3D ERROR_SUCCESS;
         }
@@ -116,6 +116,14 @@
=
         goto out;
     }
 
+    /* an empty autostart config dir means con=
figs are not started automatically */
+    error =3D GetRegString(key, L"au=
tostart_config_dir", s->autostart_config_dir,
+                         siz=
eof(s->autostart_config_dir), L"");
+    if (error !=3D ERROR_SUCCESS)
+   =
 {
+        goto out;
+    }
+
     swprintf(default_value, _countof(defaul=
t_value), L"%ls\\bin\\", install_path);
     error =3D GetRegString(key, L"=
bin_dir", s->bin_dir, sizeof(s->bin_dir), default_value);
     if (error !=
=3D ERROR_SUCCESS || !ensure_trailing_backslash(s->bin_dir, _countof(s->bin=
_dir)))
@@ -123,7 +131,7 @@
         goto out;
     }
 
-    error =3D GetR=
egString(key, L"config_ext", s->ext_string, sizeof(s->ext_string), L"=2Eovp=
n");
+    error =3D GetRegString(key, L"config_ext", s->ext_string, sizeof(=
s->ext_string), L"ovpn");
     if (error !=3D ERROR_SUCCESS)
     {
       =
  goto out;
@@ -292,6 +300,19 @@
     return error;
 }
 
+void
+CloseHandle=
Ex(LPHANDLE handle)
+{
+    if (handle)
+    {
+        if (*handle && *han=
dle !=3D INVALID_HANDLE_VALUE)
+        {
+            CloseHandle(*handle)=
;
+        }
+        *handle =3D INVALID_HANDLE_VALUE;
+    }
+}
+
 wchar_=
t *
 utf8to16_size(const char *utf8, int size)
 {
diff --git a/src/openvpns=
erv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index d8cf6e1=2E=2Ef9=
b0a73 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvpnserv/in=
teractive=2Ec
@@ -49,7 +49,7 @@
 #define ERROR_MESSAGE_TYPE    0x20000003
 =

 static SERVICE_STATUS_HANDLE service;
-static SERVICE_STATUS status =3D {=
 =2EdwServiceType =3D SERVICE_WIN32_SHARE_PROCESS };
+static SERVICE_STATUS=
 status =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS };
 static HAN=
DLE exit_event =3D NULL;
 static settings_t settings;
 static HANDLE rdns_s=
emaphore =3D NULL;
@@ -58,9 +58,14 @@
 #define TUN_IOCTL_REGISTER_RINGS \
 =
    CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE_WRITE_D=
ATA)
 
-openvpn_service_t interactive_service =3D { interactive, _L(PACKAGE=
_NAME) L"ServiceInteractive",
+openvpn_service_t interactive_service =3D { =
interactive,
+                                          _L(PACKAGE_NAME) L"=
ServiceInteractive",
                                           _L(PACKAGE_=
NAME) L" Interactive Service",
-                                          S=
ERVICE_DEPENDENCIES, SERVICE_AUTO_START };
+                               =
           SERVICE_DEPENDENCIES,
+                                         =
 SERVICE_AUTO_START,
+                                          L"-interact=
ive",
+                                          NULL,
+                   =
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
-  =
  if (handle && *handle && *handle !=3D INVALID_HANDLE_VALUE)
-    {
-     =
   CloseHandle(*handle);
-        *handle =3D INVALID_HANDLE_VALUE;
-    }
=
-    return INVALID_HANDLE_VALUE;
-}
-
 static HANDLE
 InitOverlapped(LPOVE=
RLAPPED overlapped)
 {
@@ -3910,13 +3903,6 @@
 }
 
 
-VOID WINAPI
-ServiceS=
tartInteractiveOwn(DWORD dwArgc, LPWSTR *lpszArgv)
-{
-    status=2EdwServi=
ceType =3D SERVICE_WIN32_OWN_PROCESS;
-    ServiceStartInteractive(dwArgc, =
lpszArgv);
-}
-
 /**
  * Clean up remains of previous sessions in registry=
=2E These remains can
  * happen with unclean shutdowns or crashes and woul=
d interfere with
diff --git a/src/openvpnserv/service=2Ec b/src/openvpnserv=
/service=2Ec
index 2913f63=2E=2E292816c 100644
--- a/src/openvpnserv/servic=
e=2Ec
+++ b/src/openvpnserv/service=2Ec
@@ -52,22 +52,52 @@
     return res=
;
 }
 
+/**
+ * Restrict a service to the privileges it actually needs
+ *
=
+ * Also gives the service its own SID, which is required for running it
+ =
* as a virtual service account=2E
+ *
+ * @param service     handle of the =
service, with SERVICE_CHANGE_CONFIG access
+ * @param privileges  double ze=
ro terminated list of privilege names
+ *
+ * @return BOOL to indicate succ=
ess or failure
+ */
+static BOOL
+SetServicePrivileges(SC_HANDLE service, W=
CHAR *privileges)
+{
+    SERVICE_SID_INFO sid_info =3D { SERVICE_SID_TYPE_=
UNRESTRICTED };
+    SERVICE_REQUIRED_PRIVILEGES_INFO priv_info =3D { privi=
leges };
+
+    return ChangeServiceConfig2(service, SERVICE_CONFIG_SERVICE=
_SID_INFO, &sid_info)
+           && ChangeServiceConfig2(service, SERVICE_=
CONFIG_REQUIRED_PRIVILEGES_INFO, &priv_info);
+}
+
+/**
+ * Install the ser=
vices
+ *
+ * A service that is installed already counts as success, so thi=
s can be
+ * run repeatedly, e=2Eg=2E by the MSI installer after an upgrade=
=2E
+ *
+ * @param type  the service to install, or _service_max for all of=
 them
+ *
+ * @return the number of services that could not be installed
+ =
*/
 static int
-CmdInstallServices(void)
+CmdInstallServices(openvpn_servic=
e_type type)
 {
     SC_HANDLE svc_ctl_mgr;
+    WCHAR exe_path[MAX_PATH];
=
     WCHAR path[512];
-    int i, ret =3D _service_max;
+    int ret =3D 0;=

 
-    if (GetModuleFileName(NULL, path + 1, _countof(path) - 2) =3D=3D 0)=

+    DWORD len =3D GetModuleFileName(NULL, exe_path, _countof(exe_path));
=
+    if (len =3D=3D 0 || len =3D=3D _countof(exe_path))
     {
         wpr=
intf(L"Unable to install service - %ls\n", GetLastErrorText());
         re=
turn 1;
     }
 
-    path[0] =3D L'\"';
-    wcscat_s(path, _countof(path)=
, L"\"");
-
     svc_ctl_mgr =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNE=
CT | SC_MANAGER_CREATE_SERVICE);
     if (svc_ctl_mgr =3D=3D NULL)
     {
@=
@ -75,22 +105,60 @@
         return 1;
     }
 
-    for (i =3D 0; i < _ser=
vice_max; i++)
+    for (int i =3D 0; i < _service_max; i++)
     {
-      =
  SC_HANDLE service =3D CreateService(
-            svc_ctl_mgr, openvpn_se=
rvice[i]=2Ename, openvpn_service[i]=2Edisplay_name,
-            SERVICE_QU=
ERY_STATUS, SERVICE_WIN32_SHARE_PROCESS, openvpn_service[i]=2Estart_type,
-=
            SERVICE_ERROR_NORMAL, path, NULL, NULL, openvpn_service[i]=2Ede=
pendencies, NULL, NULL);
-        if (service)
+        if (type !=3D _serv=
ice_max && type !=3D (openvpn_service_type)i)
         {
-            wprin=
tf(L"%ls installed=2E\n", openvpn_service[i]=2Edisplay_name);
-            =
CloseServiceHandle(service);
-            --ret;
+            continue;
   =
      }
-        else
+
+        openvpn_service_t *ovpn_svc =3D &openvpn_s=
ervice[i];
+
+        /* each service runs in its own process, selected by =
the arguments */
+        swprintf(path, _countof(path), L"\"%ls\"%ls%ls", =
exe_path,
+                 ovpn_svc->arguments ? L" " : L"", ovpn_svc->arg=
uments ? ovpn_svc->arguments : L"");
+
+        /*
+         * A service th=
at was just deleted stays marked for deletion until
+         * all handles=
 to it are closed, e=2Eg=2E by an open services=2Emsc=2E
+         */
+    =
    int tries =3D 10;
+        SC_HANDLE service;
+        while (!(service=
 =3D CreateService(svc_ctl_mgr, ovpn_svc->name, ovpn_svc->display_name,
+  =
                                       SERVICE_QUERY_STATUS | SERVICE_CHANG=
E_CONFIG | DELETE,
+                                         SERVICE_WIN32_=
OWN_PROCESS, ovpn_svc->start_type,
+                                       =
  SERVICE_ERROR_NORMAL, path, NULL, NULL,
+                                =
         ovpn_svc->dependencies, ovpn_svc->account, NULL))
+               =
&& GetLastError() =3D=3D ERROR_SERVICE_MARKED_FOR_DELETE && --tries)
      =
   {
+            Sleep(1000);
+        }
+
+        if (!service)
+       =
 {
+            if (GetLastError() =3D=3D ERROR_SERVICE_EXISTS)
+          =
  {
+                wprintf(L"%ls is installed already=2E\n", ovpn_svc->di=
splay_name);
+                continue;
+            }
             wprintf=
(L"CreateService failed - %ls\n", GetLastErrorText());
+            ++ret;
=
+            continue;
         }
+
+        if (ovpn_svc->required_privile=
ges
+            && !SetServicePrivileges(service, ovpn_svc->required_privi=
leges))
+        {
+            /* do not leave a service with too many pri=
vileges behind */
+            wprintf(L"Restricting privileges failed - %l=
s\n", GetLastErrorText());
+            DeleteService(service);
+          =
  CloseServiceHandle(service);
+            ++ret;
+            continue;
+=
        }
+
+        wprintf(L"%ls installed=2E\n", ovpn_svc->display_name)=
;
+        CloseServiceHandle(service);
     }
 
     CloseServiceHandle(sv=
c_ctl_mgr);
@@ -140,7 +208,6 @@
 static int
 CmdRemoveServices(void)
 {
-  =
  SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
     SERVICE_STATUS status=
;
     int i, ret =3D _service_max;
@@ -155,12 +222,13 @@
     for (i =3D 0=
; i < _service_max; i++)
     {
         openvpn_service_t *ovpn_svc =3D &o=
penvpn_service[i];
-        service =3D
+        SC_HANDLE service =3D
    =
         OpenService(svc_ctl_mgr, ovpn_svc->name, DELETE | SERVICE_STOP | S=
ERVICE_QUERY_STATUS);
         if (service =3D=3D NULL)
         {
+       =
     /* the service may not be installed, continue with the next one */
   =
          wprintf(L"OpenService failed - %ls\n", GetLastErrorText());
-    =
        goto out;
+            continue;
         }
 
         /* try to st=
op the service */
@@ -206,7 +274,6 @@
         CloseServiceHandle(service);=

     }
 
-out:
     CloseServiceHandle(svc_ctl_mgr);
     return ret;
 }
@=
@ -215,20 +282,21 @@
 int
 wmain(int argc, WCHAR *argv[])
 {
-    /*
-     =
* Interactive service (as a SERVICE_WIN32_SHARE_PROCESS)
-     * This is th=
e default=2E
-     */
-    const SERVICE_TABLE_ENTRY dispatchTable_shared[]=
 =3D {
-        { interactive_service=2Ename, ServiceStartInteractive }, { =
NULL, NULL }
-    };
-
-    /* Interactive service only (as a SERVICE_WIN32=
_OWN_PROCESS) */
-    const SERVICE_TABLE_ENTRY dispatchTable_interactive[]=
 =3D { { L"", ServiceStartInteractiveOwn },
+    /* Interactive service (as=
 a SERVICE_WIN32_OWN_PROCESS), this is the default */
+    const SERVICE_TA=
BLE_ENTRY dispatchTable_interactive[] =3D { { L"", ServiceStartInteractive =
},
                                                               { NULL, N=
ULL } };
 
-    const SERVICE_TABLE_ENTRY *dispatchTable =3D dispatchTable_=
shared;
+    /*
+     * Automatic service (as a SERVICE_WIN32_OWN_PROCESS)
=
+     * It has to run in a process of its own, as it runs with an account
+=
     * that is less privileged than the one of the interactive service=2E
+=
     */
+    const SERVICE_TABLE_ENTRY dispatchTable_automatic[] =3D { { L"=
", ServiceStartAutomatic },
+                                              =
              { NULL, NULL } };
 
+    const SERVICE_TABLE_ENTRY *dispatchT=
able =3D dispatchTable_interactive;
+
+    openvpn_service[automatic] =3D a=
utomatic_service;
     openvpn_service[interactive] =3D interactive_service=
;
 
     for (int i =3D 1; i < argc; i++)
@@ -237,7 +305,24 @@
         {
 =
            if (_wcsicmp(L"install", argv[i] + 1) =3D=3D 0)
             {
=
-                return CmdInstallServices();
+                openvpn_serv=
ice_type type =3D _service_max;
+                if (argc > i + 1)
+       =
         {
+                    if (_wcsicmp(L"automatic", argv[i + 1]) =3D=
=3D 0)
+                    {
+                        type =3D automatic;
=
+                    }
+                    else if (_wcsicmp(L"interactive=
", argv[i + 1]) =3D=3D 0)
+                    {
+                        t=
ype =3D interactive;
+                    }
+                    else
+    =
                {
+                        wprintf(L"Unknown service '%ls'\=
n", argv[i + 1]);
+                        return 1;
+                    }=

+                }
+                return CmdInstallServices(type);
     =
        }
             else if (_wcsicmp(L"remove", argv[i] + 1) =3D=3D 0)
=
             {
@@ -245,7 +330,16 @@
             }
             else if (_w=
csicmp(L"start", argv[i] + 1) =3D=3D 0)
             {
-                ret=
urn CmdStartService(interactive);
+                BOOL is_auto =3D argc > =
i + 1 && _wcsicmp(L"automatic", argv[i + 1]) =3D=3D 0;
+                ret=
urn CmdStartService(is_auto ? automatic : interactive);
+            }
+   =
         else if (_wcsicmp(L"automatic", argv[i] + 1) =3D=3D 0)
+          =
  {
+                dispatchTable =3D dispatchTable_automatic;
+          =
  }
+            else if (_wcsicmp(L"interactive", argv[i] + 1) =3D=3D 0)
+=
            {
+                dispatchTable =3D dispatchTable_interactive;=

             }
             else if (argc > i + 2 && _wcsicmp(L"instance",=
 argv[i] + 1) =3D=3D 0)
             {
@@ -265,13 +359,21 @@
             }=

             else
             {
-                wprintf(L"%ls -install  =
      to install the interactive service\n", APPNAME);
                 wpr=
intf(
-                    L"%ls -start [name]   to start the service (name=
 =3D \"interactive\") is optional\n",
+                    L"%ls -install [=
name] to install services (name =3D \"automatic\" or \"interactive\",\n"
+ =
                   L"                            defaults to both)\n",
    =
                 APPNAME);
-                wprintf(L"%ls -remove         t=
o remove the service\n", APPNAME);
+                wprintf(
+             =
       L"%ls -start [name]   to start a service (name =3D \"automatic\" or =
\"interactive\",\n"
+                    L"                            defa=
ults to \"interactive\")\n",
+                    APPNAME);
+              =
  wprintf(L"%ls -remove         to remove the services\n", APPNAME);
 
    =
             wprintf(L"\nService run-time parameters:\n");
+               =
 wprintf(L"-automatic\n"
+                        L"   Runs the automatic s=
ervice=2E\n");
+                wprintf(L"-interactive\n"
+                =
        L"   Runs the interactive service=2E This is the default=2E\n");
  =
               wprintf(L"-instance interactive <id>\n"
                    =
     L"   Runs the service as an alternate instance=2E\n"
                 =
        L"   The service settings will be loaded from\n"
diff --git a/src/o=
penvpnserv/service=2Eh b/src/openvpnserv/service=2Eh
index c67d67f=2E=2E2c0=
12d2 100644
--- a/src/openvpnserv/service=2Eh
+++ b/src/openvpnserv/service=
=2Eh
@@ -47,6 +47,7 @@
 
 typedef enum
 {
+    automatic,
     interactive,=

     _service_max
 } openvpn_service_type;
@@ -58,6 +59,9 @@
     WCHAR *d=
isplay_name;
     WCHAR *dependencies;
     DWORD start_type;
+    WCHAR *a=
rguments;
+    WCHAR *account;
+    WCHAR *required_privileges;
 } openvpn_=
service_t;
 
 #define MAX_NAME 256
@@ -65,6 +69,7 @@
 {
     WCHAR exe_path=
[MAX_PATH];
     WCHAR config_dir[MAX_PATH];
+    WCHAR autostart_config_di=
r[MAX_PATH];
     WCHAR bin_dir[MAX_PATH];
     WCHAR ext_string[16];
     =
WCHAR log_dir[MAX_PATH];
@@ -74,10 +79,11 @@
     BOOL append;
 } settings_=
t;
 
+extern openvpn_service_t automatic_service;
 extern openvpn_service_t=
 interactive_service;
 extern LPCWSTR service_instance;
 
-VOID WINAPI Serv=
iceStartInteractiveOwn(DWORD argc, LPWSTR *argv);
+VOID WINAPI ServiceStart=
Automatic(DWORD argc, LPWSTR *argv);
 
 VOID WINAPI ServiceStartInteractive=
(DWORD argc, LPWSTR *argv);
 
@@ -90,6 +96,16 @@
 DWORD MsgToEventLog(DWORD=
 flags, LPCWSTR lpszMsg, =2E=2E=2E);
 
 /**
+ * Close a handle and invalida=
te it
+ *
+ * Nothing is done if the handle is invalid already, which makes=
 it safe
+ * to call this function more than once for the same handle=2E
+ =
*
+ * @param handle  pointer to the handle to be closed
+ */
+void CloseHan=
dleEx(LPHANDLE handle);
+
+/**
  * Convert a UTF-8 string to UTF-16
  *
  *=
 The size parameter can be used to convert strings which contain inline NUL=

diff --git a/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests/unit_tests=
/openvpnserv/Makefile=2Eam
index 19de666=2E=2E2753ad2 100644
--- a/tests/un=
it_tests/openvpnserv/Makefile=2Eam
+++ b/tests/unit_tests/openvpnserv/Makef=
ile=2Eam
@@ -3,14 +3,34 @@
 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE=
_STRING) service Unit-Tests'
 
 if WIN32
-test_binaries =3D openvpnserv_tes=
tdriver
+test_binaries =3D openvpnserv_testdriver openvpnserv_automatic_tes=
tdriver
 endif
 check_PROGRAMS =3D $(test_binaries)
 
-openvpnserv_testdriv=
er_CFLAGS  =3D -I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_=
srcdir)/src/compat -I$(top_srcdir)/src/openvpnserv @TEST_CFLAGS@
-openvpnse=
rv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+# bui=
ld the tests like openvpnserv itself, see src/openvpnserv/Makefile=2Eam
+op=
envpnserv_test_cflags =3D \
+	-municode -D_UNICODE \
+	-UNTDDI_VERSION -D_W=
IN32_WINNT=3D_WIN32_WINNT_WIN10 \
+	-I$(top_srcdir)/include -I$(top_srcdir)=
/src/openvpn -I$(top_srcdir)/src/compat \
+	-I$(top_srcdir)/src/openvpnserv=
 -I$(top_builddir)/src/openvpnserv \
+	-I$(top_srcdir)/tests/unit_tests/ope=
nvpn \
+	@TEST_CFLAGS@
+openvpnserv_test_ldflags =3D -municode @TEST_LDFLAG=
S@ -L$(top_srcdir)/src/openvpn
+openvpnserv_test_ldadd =3D \
+	-ladvapi32 -=
luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
+	-lshlwapi -lnetapi32 -lws2_32 -=
lntdll -lole32 -lpathcch
+
+openvpnserv_testdriver_CFLAGS  =3D $(openvpnser=
v_test_cflags)
+openvpnserv_testdriver_LDFLAGS =3D $(openvpnserv_test_ldfla=
gs)
+openvpnserv_testdriver_LDADD   =3D $(openvpnserv_test_ldadd)
 openvpns=
erv_testdriver_SOURCES =3D test_openvpnserv=2Ec \
 	$(top_srcdir)/src/openv=
pnserv/common=2Ec \
 	$(top_srcdir)/src/openvpnserv/validate=2Ec \
 	$(top_=
srcdir)/src//openvpn/wfp_block=2Ec \
 	$(top_srcdir)/src//openvpn/wfp_block=
=2Eh
+
+openvpnserv_automatic_testdriver_CFLAGS  =3D $(openvpnserv_test_cfl=
ags)
+openvpnserv_automatic_testdriver_LDFLAGS =3D $(openvpnserv_test_ldfla=
gs)
+openvpnserv_automatic_testdriver_LDADD   =3D $(openvpnserv_test_ldadd)=

+openvpnserv_automatic_testdriver_SOURCES =3D test_openvpnserv_automatic=
=2Ec \
+	$(top_srcdir)/src/openvpnserv/common=2Ec
diff --git a/tests/unit_t=
ests/openvpnserv/test_openvpnserv_automatic=2Ec b/tests/unit_tests/openvpns=
erv/test_openvpnserv_automatic=2Ec
new file mode 100644
index 0000000=2E=2E=
881170b
--- /dev/null
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv_a=
utomatic=2Ec
@@ -0,0 +1,241 @@
+/*
+ *  OpenVPN -- An application to secure=
ly tunnel IP networks
+ *             over a single UDP port, with support =
for SSL/TLS-based
+ *             session authentication and key exchange,
=
+ *             packet encryption, packet authentication, and
+ *          =
   packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <sales@ope=
nvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute it=
 and/or modify
+ *  it under the terms of the GNU General Public License as=
 published by the
+ *  Free Software Foundation, either version 2 of the Li=
cense,
+ *  or (at your option) any later version=2E
+ *
+ *  This program =
is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for m=
ore details=2E
+ *
+ *  You should have received a copy of the GNU General =
Public License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#=
endif
+
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+#include "test_commo=
n=2Eh"
+
+#include <winsock2=2Eh>
+#include <windows=2Eh>
+
+/*
+ * The aut=
omatic service cannot be linked together with the interactive one
+ * in a =
single test driver, as both define the same static service state=2E
+ */
+#=
include "automatic=2Ec"
+
+BOOL
+ReportStatusToSCMgr(SERVICE_STATUS_HANDLE =
svc_handle, SERVICE_STATUS *svc_status)
+{
+    return TRUE;
+}
+
+/**
+ * =
Parse a response like the one sent by the interactive service
+ *
+ * @para=
m response  the response string
+ * @param error     receives the error cod=
e of the response
+ * @param pid       receives the process id of the respo=
nse
+ *
+ * @return the result of ParseInteractiveServiceResponse()
+ */
+s=
tatic BOOL
+parse_response(PCWSTR response, PDWORD error, PDWORD pid)
+{
+ =
   /* the response is modified while parsing, so pass a copy */
+    WCHAR =
buf[256];
+    assert_true(wcslen(response) < _countof(buf));
+    wcscpy(b=
uf, response);
+
+    return ParseInteractiveServiceResponse(buf, error, pi=
d);
+}
+
+static void
+test_response_success(void **state)
+{
+    DWORD er=
ror =3D 0xdeadbeef;
+    DWORD pid =3D 0xdeadbeef;
+
+    assert_true(parse=
_response(L"0x00000000\n0x000004d2\nProcess ID", &error, &pid));
+    asser=
t_int_equal(error, 0);
+    assert_int_equal(pid, 1234);
+}
+
+static void
=
+test_response_error(void **state)
+{
+    DWORD error =3D 0xdeadbeef;
+   =
 DWORD pid =3D 0xdeadbeef;
+
+    /*
+     * An error response carries the =
name of the failed function in the
+     * second line, which must not be m=
istaken for a process id=2E
+     */
+    assert_true(parse_response(L"0x00=
00007b\nCreateProcessAsUser\nThe filename is invalid", &error,
+           =
                    &pid));
+    assert_int_equal(error, 0x7b);
+    assert=
_int_equal(pid, 0);
+}
+
+static void
+test_response_error_crlf(void **stat=
e)
+{
+    DWORD error =3D 0xdeadbeef;
+    DWORD pid =3D 0xdeadbeef;
+
+  =
  /* error responses are built with FormatMessage(), which uses \r\n line b=
reaks */
+    assert_true(parse_response(L"0x20000001\r\nYou have specified=
 a config file location\r\n", &error,
+                               &pid)=
);
+    assert_int_equal(error, 0x20000001);
+    assert_int_equal(pid, 0);=

+}
+
+static void
+test_response_malformed(void **state)
+{
+    DWORD err=
or, pid;
+
+    /* no line break at all */
+    assert_false(parse_response=
(L"0x00000000", &error, &pid));
+
+    /* neither line is a number */
+    =
assert_false(parse_response(L"hello world\nnot a pid\nmessage", &error, &pi=
d));
+
+    /* the error code is a number with trailing garbage */
+    ass=
ert_false(parse_response(L"0x00000000xyz\n0x000004d2\nProcess ID", &error, =
&pid));
+
+    /* success response without a process id */
+    assert_fals=
e(parse_response(L"0x00000000\n", &error, &pid));
+
+    /* success respons=
e with an empty process id line */
+    assert_false(parse_response(L"0x000=
00000\n\nProcess ID", &error, &pid));
+
+    /* the process id is a number =
with trailing garbage */
+    assert_false(parse_response(L"0x00000000\n0x0=
00004d2xyz\nProcess ID", &error, &pid));
+
+    /* empty lines only */
+   =
 assert_false(parse_response(L"\n\n", &error, &pid));
+}
+
+static void
+te=
st_add_startup_data(void **state)
+{
+    WCHAR buf[32];
+    size_t pos =
=3D 0;
+
+    /* the startup data is config dir + \0 + options + \0 + passw=
ord + \0 */
+    assert_true(AddStartupData(buf, _countof(buf), &pos, L"C:\=
\cfg"));
+    assert_int_equal(pos, 7);
+
+    assert_true(AddStartupData(b=
uf, _countof(buf), &pos, L"--log x"));
+    assert_int_equal(pos, 15);
+
+ =
   /* the password is empty, but still terminated */
+    assert_true(AddSt=
artupData(buf, _countof(buf), &pos, L""));
+    assert_int_equal(pos, 16);
=
+
+    /* the fields are separated and terminated by zeros */
+    const WC=
HAR expected[] =3D L"C:\\cfg\0--log x\0";
+    assert_int_equal(pos, _count=
of(expected));
+    assert_int_equal(wmemcmp(buf, expected, pos), 0);
+}
+
=
+static void
+test_add_startup_data_full(void **state)
+{
+    WCHAR buf[8]=
;
+    size_t pos =3D 0;
+
+    wmemset(buf, L'#', _countof(buf));
+
+    /=
* a string that does not fit is rejected without changing anything */
+    =
assert_false(AddStartupData(buf, _countof(buf), &pos, L"12345678"));
+    a=
ssert_int_equal(pos, 0);
+    for (size_t i =3D 0; i < _countof(buf); i++)
=
+    {
+        assert_int_equal(buf[i], L'#');
+    }
+
+    /* a string w=
hose terminator ends up as the last element still fits */
+    assert_true(=
AddStartupData(buf, _countof(buf), &pos, L"1234567"));
+    assert_int_equa=
l(pos, _countof(buf));
+
+    /* but leaves no room for another field, not =
even an empty one */
+    assert_false(AddStartupData(buf, _countof(buf), &=
pos, L""));
+    assert_int_equal(pos, _countof(buf));
+}
+
+static void
+t=
est_log_file_path(void **state)
+{
+    WCHAR path[MAX_PATH];
+    WCHAR na=
me[MAX_PATH + 64];
+
+    /* the extension is replaced by =2Elog */
+    as=
sert_true(GetLogFilePath(path, _countof(path), L"C:\\log\\", L"office=2Eovp=
n"));
+    assert_int_equal(wcscmp(path, L"C:\\log\\office=2Elog"), 0);
+
+=
    /* a missing backslash on the log dir is added */
+    assert_true(GetL=
ogFilePath(path, _countof(path), L"C:\\log", L"office=2Eovpn"));
+    asser=
t_int_equal(wcscmp(path, L"C:\\log\\office=2Elog"), 0);
+
+    /* only the =
last extension is replaced */
+    assert_true(GetLogFilePath(path, _counto=
f(path), L"C:\\log\\", L"my=2Eoffice=2Eovpn"));
+    assert_int_equal(wcscm=
p(path, L"C:\\log\\my=2Eoffice=2Elog"), 0);
+
+    /* a name without an ext=
ension just gets one */
+    assert_true(GetLogFilePath(path, _countof(path=
), L"C:\\log\\", L"office"));
+    assert_int_equal(wcscmp(path, L"C:\\log\=
\office=2Elog"), 0);
+
+    /* a name that is nothing but an extension */
+=
    assert_true(GetLogFilePath(path, _countof(path), L"C:\\log\\", L"=2Eovp=
n"));
+    assert_int_equal(wcscmp(path, L"C:\\log\\=2Elog"), 0);
+
+    /*=
 spaces are no problem */
+    assert_true(GetLogFilePath(path, _countof(pa=
th), L"C:\\my logs\\", L"my office=2Eovpn"));
+    assert_int_equal(wcscmp(=
path, L"C:\\my logs\\my office=2Elog"), 0);
+
+    /* a config file name th=
at cannot fit the log file name is an error */
+    for (size_t i =3D 0; i =
< _countof(name) - 1; i++)
+    {
+        name[i] =3D L'a';
+    }
+    na=
me[_countof(name) - 1] =3D L'\0';
+    assert_false(GetLogFilePath(path, _c=
ountof(path), L"C:\\log\\", name));
+
+    /* a log dir that does not leave=
 room for the name is an error */
+    assert_false(GetLogFilePath(path, 8,=
 L"C:\\some\\very\\long\\log\\dir", L"office=2Eovpn"));
+}
+
+int
+wmain(vo=
id)
+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest tests[]=
 =3D {
+        cmocka_unit_test(test_response_success),
+        cmocka_un=
it_test(test_response_error),
+        cmocka_unit_test(test_response_error=
_crlf),
+        cmocka_unit_test(test_response_malformed),
+        cmocka=
_unit_test(test_add_startup_data),
+        cmocka_unit_test(test_add_start=
up_data_full),
+        cmocka_unit_test(test_log_file_path),
+    };
+
+  =
  int ret =3D cmocka_run_group_tests_name("openvpnserv automatic service te=
sts", tests, NULL, NULL);
+
+    return ret;
+}

-- 
To view, visit https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail
To unsubscribe, or for=
 help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?u=
sp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
Ge=
rrit-Change-Number: 2001
Gerrit-PatchSet: 1
Gerrit-Owner: Heiko Hund <heiko=
@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-A=
ttention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--l4TOG7nVHvE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund would like Arne Sc=
hwabe to <strong>review</strong> this change=2E
</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">openvpnserv: add automatic service again<br><br>The automatic ser=
vice, which starts all configs in the autostart config<br>directory, was re=
moved from openvpnserv=2Eexe in 2021 and replaced by the<br>=2ENET based op=
envpnserv2=2Eexe=2E Add it back, implemented in C, so that both<br>Windows =
services are maintained in this repository=2E<br><br>Security related chang=
es added:<br>- before sending any data, verify that the named pipe is serve=
d by the<br>  interactive service process<br>- the exit event of each OpenV=
PN process has a random name and a DACL<br>  that only grants access to its=
 owner, so it cannot be pre-created or<br>  signalled by other users<br>- t=
he service checks that it is run as the ovpn_service_user account in<br>  t=
he registry settings, so that it and openvpn in turn is guaranteed to<br>  =
run with limited privileges<br><br>Robustness:<br>- starting a config is re=
tried until the service stops, with a delay<br>  that doubles from 10 secon=
ds up to 5 minutes for configs that keep<br>  failing, and is reset once a =
process ran for a minute<br>- an OpenVPN process that may have been started=
 by a failed attempt is<br>  signalled to exit, so it does not run unmonito=
red<br>- configs in subdirectories use their own directory as working<br>  =
directory; configs with the same file name as one found before are<br>  ign=
ored, like in the GUI<br><br>Both services now run in their own process, se=
lected by the new<br>&#39;-automatic&#39; and &#39;-interactive&#39; option=
s=2E This is needed since they need<br>to run with different accounts=2E &#=
39;-install&#39; takes an optional service<br>name again=2E &#39;-instance =
automatic&#39; is not supported, since the service<br>cannot check the name=
d pipe owner for instances=2E<br><br>Also add a few unit tests and some doc=
umentation=2E<br><br>Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b<b=
r>Signed-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>=
M Changes=2Emd<br>M doc/Makefile=2Eam<br>A doc/automatic-service-notes=2Ers=
t<br>M src/openvpnserv/CMakeLists=2Etxt<br>M src/openvpnserv/Makefile=2Eam<=
br>A src/openvpnserv/automatic=2Ec<br>M src/openvpnserv/common=2Ec<br>M src=
/openvpnserv/interactive=2Ec<br>M src/openvpnserv/service=2Ec<br>M src/open=
vpnserv/service=2Eh<br>M tests/unit_tests/openvpnserv/Makefile=2Eam<br>A te=
sts/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec<br>12 files chang=
ed, 1,650 insertions(+), 64 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/2001/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 5c3270b=2E=
=2E813ac33 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/=
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
serv/CMakeLists=2Etxt</span><br><span>index 2cc4a93=2E=2Edbb7651 100644</sp=
an><br><span>--- a/src/openvpnserv/CMakeLists=2Etxt</span><br><span>+++ b/s=
rc/openvpnserv/CMakeLists=2Etxt</span><br><span>@@ -35,6 +35,7 @@</span><br=
><span> add_common_options(openvpnserv)</span><br><span> target_sources(ope=
nvpnserv PRIVATE</span><br><span>     common=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    automatic=2Ec</span><br><span>     interac=
tive=2Ec</span><br><span>     service=2Ec service=2Eh</span><br><span>     =
validate=2Ec validate=2Eh</span><br><span>@@ -82,6 +83,7 @@</span><br><span=
> if (BUILD_TESTING)</span><br><span>     set(unit_tests</span><br><span>  =
       &quot;test_openvpnserv&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        &quot;test_openvpnserv_automatic&quot;</span><br><s=
pan>     )</span><br><span> </span><br><span>     foreach (test_name ${unit=
_tests})</span><br><span>@@ -104,4 +106,8 @@</span><br><span>         valid=
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
ew file mode 100644</span><br><span>index 0000000=2E=2E54d17a0</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpnserv/automatic=2Ec</span=
><br><span>@@ -0,0 +1,1014 @@</span><br><span style=3D"color: hsl(120, 100%=
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
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * The automatic service starts one OpenVPN process for each configu=
ration</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * file found=
 in the autostart config directory and restarts them when they</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * exit unexpectedly=2E The Open=
VPN processes are not started directly, but by</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * the interactive service, which this service t=
alks to via its named pipe=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;service=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;handleapi=2Eh&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;pathcch=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;rpc=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &lt;sddl=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &lt;stdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* T=
ime we give the interactive service to accept our connection */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define ISERVICE_CONNECT_TIMEOU=
T 5000 /*ms*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Time we wait before an OpenVPN process=
 is started again, after it exited</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * or could not be started=2E The delay doubles with each fa=
iled attempt, up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
to the maximum=2E A process that ran for a while resets it to the minimum=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define RESTART_DELAY_MIN 10000 =
 /*ms*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define REST=
ART_DELAY_MAX 300000 /*ms*/</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define STABLE_RUNTIME    60000  /*ms*/</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Maximum size of the startup data sent to the interactive servic=
e */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define STARTUP=
_DATA_MAX 2048</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Maximum recursion dep=
th when searching for configuration files */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define MAX_RECURSION_DEPTH 32</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Name of the interactive service we talk to */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define ISERVICE_NAME _L(PACK=
AGE_NAME) L&quot;ServiceInteractive&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* The service cannot run without the interactive service, so we make it=
 depend on it=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define AUTOMATIC_SERVICE_DEPENDENCIES ISERVICE_NAME L&quot;\0\0&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * The service runs as its own virtual service account, wh=
ich the interactive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * service trusts, and needs no privileges besides the one every process ha=
s=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define AUTOMATIC_SERVICE_ACCOU=
NT    L&quot;NT SERVICE\\&quot; _L(PACKAGE_NAME) L&quot;Service&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define AUTOMATIC_SERVICE=
_PRIVILEGES L&quot;SeChangeNotifyPrivilege\0\0&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+openvpn_service_t automatic_service =3D { automatic,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
             _L(PACKAGE_NAME) L&quot;Service&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                        _=
L(PACKAGE_NAME) L&quot; Automatic Service&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                        AUTOMA=
TIC_SERVICE_DEPENDENCIES,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                        SERVICE_DEMAND_START,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
             L&quot;-automatic&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                        // cppcheck-suppr=
ess unknownMacro ; FP, _L after a string literal</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                        AUTOMA=
TIC_SERVICE_ACCOUNT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                        AUTOMATIC_SERVICE_PRIVILEGES };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static SERVICE_STATUS_HANDLE service;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static SERVICE_STATUS s=
tatus =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static HANDLE exit_event =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static settings_t settings;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* One OpenVPN connection, i=2Ee=2E one configur=
ation file */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typede=
f struct openvpn_process</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct op=
envpn_process *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    WCHAR working_dir[MAX_PATH];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    WCHAR config_file[MAX_PATH];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    WCHAR log_file[MAX_PATH];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    HANDLE process;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    HANDLE exit_event;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    HANDLE stop_event;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    HANDLE thread;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    CRITICAL_SECTION cs;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+} openvpn_process_t;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static openvpn_process_t *processes =3D NULL;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Add a zero terminated string to a buffer=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param buf   string buffer to append to</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param size  size o=
f the buffer in wide characters</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param pos   in/out position in the buffer in wide character=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param str   th=
e string to append</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to=
 indicate success or failure</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AddStartupData(=
PWSTR buf, size_t size, size_t *pos, PCWSTR str)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    size_t len =3D wcslen(str) + 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (*pos + len &gt; size)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    wmemcpy(buf + *pos, str=
, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *pos +=
=3D len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    return TRUE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Get the =
process id of the interactive service</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @return the process id, or 0 if the service is not running or on error<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static DWORD</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+GetInteractiveServicePid(void)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    DWORD pid =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    SC_HANDLE scm =3D OpenSCManager(NULL, NULL, SC_MANAGER_CONNECT=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!scm)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        return 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    SC_HANDLE svc =3D OpenService(scm, ISERVICE_NAME, SERVICE_QUERY_STAT=
US);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (svc)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        SERVICE_STATUS_PROCESS ssp;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        DWORD needed=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (QueryS=
erviceStatusEx(svc, SC_STATUS_PROCESS_INFO, (LPBYTE)&amp;ssp, sizeof(ssp), =
&amp;needed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &amp;&amp; ssp=2EdwCurrentState =3D=3D SERVICE_RUNNING)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            pid =3D ssp=2EdwProcessId;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        CloseServiceHandle(svc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    CloseServiceHandle(scm);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return pid;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Check that the server end=
 of a pipe is the interactive service</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Makes sure we do not send data to, or can be impersonated by, a process=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * which created a =
pipe with the interactive service&#39;s pipe name=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param pipe  the connected pipe handle</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return BOOL to indicate whether the pipe server i=
s the interactive service</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOO=
L</span><br><span style=3D"color: hsl(120, 100%, 40%);">+IsInteractiveServi=
cePipe(HANDLE pipe)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ULONG server_p=
id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!GetName=
dPipeServerProcessId(pipe, &amp;server_pid))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD iservice_p=
id =3D GetInteractiveServicePid();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return iservice_pid !=3D 0 &amp;&amp; server_pid =3D=3D =
iservice_pid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Connect to the named pipe of the interactive service</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * The connection is only returned if =
the pipe is served by the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * interactive service process=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @param timeout  maximum time in ms to wait for the pipe to become ava=
ilable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return pipe handle, or INV=
ALID_HANDLE_VALUE on error</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static HA=
NDLE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ConnectToIntera=
ctiveService(DWORD timeout)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR =
pipe_name[256];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ULONGLONG deadline =3D GetTickCount64() + timeout;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    swprintf(pipe_name, _countof(pipe_name), L&quot;\\\\=2E\\pi=
pe\\&quot; _L(PACKAGE) L&quot;%ls\\service&quot;, service_instance);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    while (TRUE)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        HANDLE pipe =3D CreateFile(pipe_name, GENERIC_READ | G=
ENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (pipe !=3D INVALID_HANDLE_VALUE)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            DWORD mode =3D PIPE_R=
EADMODE_MESSAGE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (!SetNamedPipeHandleState(pipe, &amp;mode, NULL, NULL))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                CloseHandle(pipe)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                re=
turn INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (!IsInteractiveServicePipe(pipe))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                MsgToEventLog(M_ERR, L&quot;Pipe %l=
s is not served by the interactive service&quot;, pipe_name);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                CloseHandle(pipe)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                Se=
tLastError(ERROR_ACCESS_DENIED);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                return INVALID_HANDLE_VALUE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return pipe;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        DWORD error =3D GetLastError();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        ULONGLONG now =3D GetTickCount64();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (now &gt;=
=3D deadline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            SetL=
astError(error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         return INVALID_HANDLE_VALUE;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(error =3D=3D ERROR_PIPE_BUSY)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* All pipe instances are busy, wait for one to become availab=
le */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (!WaitNamedPipe(pipe_name, (DWORD)(deadline - now)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                return INVALID_HANDLE_VALUE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        else if (error =3D=3D ERROR_FI=
LE_NOT_FOUND)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* T=
he interactive service may not have created the pipe yet */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            Sleep(50);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            SetLastError(error);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return INVALID_HANDLE_VALUE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Split off the first lin=
e of a string</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Lines end with &quot=
;\n&quot; or &quot;\r\n&quot; in error responses of the interactive service=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param str  the string to spli=
t, its first line is zero terminated in place</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @return the start of the next line, or NULL if there is none</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static PWSTR</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+SplitLine(PWSTR str)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    PWSTR eol =3D wcschr(str, L&#39;\n&#39;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!eol)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *eol =3D=
 L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (eol &gt; str &amp;&amp; eol[-1] =3D=3D L&#39;\r&#39;)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        eol[-1] =3D L&#39;\0&#39;;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return eol + 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Parse the response of the interactive servic=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * The response is a three line str=
ing, with the error code in the first,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * the process id in the second if OpenVPN was started s=
uccessfully and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a=
 message in the third line=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am response  the zero terminated response, which is modified</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param error     receives the e=
rror code returned by the service</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param pid       receives the process id of the OpenVPN pr=
ocess</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to indicate suc=
cess or failure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ParseInteractiveServiceRespo=
nse(PWSTR response, PDWORD error, PDWORD pid)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    PWSTR pid_line =3D SplitLine(response);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!pid_line)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        SetLastError(ERROR_INVALID_DATA);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SplitLine(pid_line);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    PWSTR end;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    *error =3D wcstoul(response, &amp;end, 16);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (end =3D=3D response || *end =
!=3D L&#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        SetLas=
tError(ERROR_INVALID_DATA);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    *pid =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (*error =3D=3D 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        *pid =3D wcstoul(pid_line, &=
amp;end, 16);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (end =3D=3D pid_line || *end !=3D L&#39;\0&#39;)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            SetLastError(ERROR_INVALID_DATA);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return FALSE;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return TRUE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Read the response of the interactive s=
ervice from the pipe</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pipe  =
 the pipe to read the response from</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @param error  receives the error code returned by the se=
rvice</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pid =
   receives the process id of the OpenVPN process</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return BOOL to indicate success or failure</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ReadInteractiveServiceResponse(HANDLE pipe, PDWORD error, P=
DWORD pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR buf[1024];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD bytes;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!ReadFile(pipe, buf, sizeof(buf) - sizeo=
f(buf[0]), &amp;bytes, NULL))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf[bytes / sizeof(buf[0])] =3D=
 L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ParseInterac=
tiveServiceResponse(buf, error, pid);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Build the path of the log file o=
f a configuration file</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The log fil=
e is named like the configuration file, with its extension</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * replaced by &quot;=2Elog&quot;, a=
nd is placed in the log directory=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param log_file  buffer that receives the log file path</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param size      size of the buff=
er in wide characters</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param log_dir   the directory the log file is placed in</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param name      the file name=
 of the configuration file</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return=
 BOOL to indicate success or failure</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+GetLogF=
ilePath(PWSTR log_file, size_t size, PCWSTR log_dir, PCWSTR name)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    WCHAR log_name[MAX_PATH];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    PCWSTR dot =3D wcsrchr(name, L&#3=
9;=2E&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 len =3D dot ? (int)(dot - name) : (int)(wcslen(name));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return swprintf(log_name, _countof(log_name), L&quot;%=
=2E*ls=2Elog&quot;, len, name) &gt;=3D 0</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+           &amp;&amp; PathCchCombine(log_file, size, l=
og_dir, log_name) =3D=3D S_OK;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Create the event used to signal an Ope=
nVPN process to exit</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The name of t=
he event is random, so others cannot create it in advance</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * and keep it under their control=2E=
 Should the name exist already anyway,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * another one is tried=2E Only the owner of the event h=
as access to it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* OpenVPN runs with the same account as this service, so it can open the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * event by its name=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param name  buffer that recei=
ves the name of the event</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param size  size of the buffer in wide characters</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return the event handle, or INVALID_HANDLE_VALUE=
 on error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static HANDLE</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+CreateExitEvent(PWSTR name, size=
_t size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SECURITY_ATTRIBUTES sa =
=3D { =2EnLength =3D sizeof(sa) };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    HANDLE event =3D INVALID_HANDLE_VALUE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!ConvertStringSecurityDescriptorToSecurityDescri=
ptorW(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            L=
&quot;D:P(A;;GA;;;OW)&quot;, SDDL_REVISION_1, &amp;sa=2ElpSecurityDescripto=
r, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        return event;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const int max_tries =3D 3;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (int tries =3D 0; tries &lt; max_tri=
es; tries++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        UUID uuid;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        RPC_WSTR uuid_=
str;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (Uui=
dCreate(&amp;uuid) !=3D RPC_S_OK || UuidToStringW(&amp;uuid, &amp;uuid_str)=
 !=3D RPC_S_OK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        swprintf(name, si=
ze, _L(PACKAGE) L&quot;_exit_%ls&quot;, (PWSTR)uuid_str);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        RpcStringFreeW(&amp;uuid_str)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        event =3D CreateEvent(&amp;sa=
, TRUE, FALSE, name);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (event &amp;&amp; GetLastError() !=3D ERROR_ALREADY_EXISTS)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        CloseHandleEx(&amp;event);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    LocalFree(sa=2ElpSecurityDescriptor)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (event =3D=3D INVALID_HANDLE_V=
ALUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR,=
 L&quot;Could not create exit event=2E&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn event;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Start a OpenVPN process for a configuration file</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Connects to the interactive service, sends =
the startup data and reads</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * back the process id of the started OpenVPN process=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param p  the process to start</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return BOOL to indicate success or failure</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static BOOL</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+StartProcess(openvpn_process_t *p)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    WCHAR cmdline[STARTUP_DATA_MAX];</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    WCHAR startup_data[STARTUP_DAT=
A_MAX];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR ex=
it_event_name[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    HANDLE pipe =3D INVALID_HANDLE_VALUE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size_t pos =3D 0;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    DWORD error, pid, written;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    BOOL ret =3D FALSE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* each OpenVPN process gets a new exit event =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE event =
=3D CreateExitEvent(exit_event_name, _countof(exit_event_name));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!event)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could not=
 create exit event for config %ls&quot;, p-&gt;config_file);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return FALSE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const WCHAR *log_option =3D settings=2Eappend ? L&quot;--log-=
append&quot; : L&quot;--log&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int n =3D swprintf(cmdline, _countof(cmdline),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                     L&quot;%=
ls \&quot;%ls\&quot; --config \&quot;%ls\&quot; --service \&quot;%ls\&quot;=
 0 --pull-filter ignore route-method&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                     log_option, p-&gt;log_file, p-=
&gt;config_file, exit_event_name);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (n &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       MsgToEventLog(M_ERR, L&quot;Command line too long for config %ls&quo=
t;, p-&gt;config_file);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* working dir + \0 + optio=
ns + \0 + password + \0 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (!AddStartupData(startup_data, _countof(startup_data), &amp;p=
os, p-&gt;working_dir)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        || !AddStartupData(startup_data, _countof(startup_data), &amp;po=
s, cmdline)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
|| !AddStartupData(startup_data, _countof(startup_data), &amp;pos, L&quot;&=
quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ER=
R, L&quot;Startup data too long for config %ls&quot;, p-&gt;config_file);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    pipe =3D ConnectToInteractiveService(ISERVICE_CONNEC=
T_TIMEOUT);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
pipe =3D=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        MsgToEventLog(M_SYSERR, L&quot;Could not connect to the interactive=
 service&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!WriteFile(pipe, startup_data,=
 (DWORD)(pos * sizeof(startup_data[0])), &amp;written, NULL))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could no=
t send startup data to interactive service&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!ReadInteractiveServiceResponse(pipe, &amp;error, &amp;pid))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could=
 not read response from iservice&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (error =
!=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ER=
R, L&quot;Error starting openvpn process: %lu&quot;, error);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
The interactive service restricts access to the OpenVPN process=2E It does<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * not grant PRO=
CESS_QUERY_LIMITED_INFORMATION, but PROCESS_QUERY_INFORMATION=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
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
;">+ * Find a process entry with a config file of the given name</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param name  the file name of the config, wi=
thout the path</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return the process=
 entry, or NULL if there is none</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic openvpn_process_t *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+FindProcessByName(PCWSTR name)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (openvpn_process_t *p =3D processes; p; p =3D p-&gt;next)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        PCWSTR p_name =3D wcsrchr(p-&gt;config=
_file, L&#39;\\&#39;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        p_name =3D p_name ? p_name + 1 : p-&gt;config_file;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (_wcsicmp(p_name, nam=
e) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Create a process=
 entry for a configuration file and start the thread</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * that runs the OpenVPN process for it=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * A config with the same file na=
me as one that was found before is ignored,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * as both would use the same log file=2E This is i=
n line with how openvpn-gui</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * handles duplicates=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param working_dir  the directory the config file is in</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param config_file  path of the confi=
guration file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+StartConfig(PCWSTR working_dir=
, PCWSTR config_file)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PCWSTR name =
=3D wcsrchr(config_file, L&#39;\\&#39;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    name =3D name ? name + 1 : config_file;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    openvpn_process_t *dup =3D FindProcessByName(=
name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dup)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quo=
t;Config %ls has the same file name as %ls, ignoring it&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                      config_fil=
e, dup-&gt;config_file);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    openvpn_process_t *p =3D cal=
loc(1, sizeof(*p));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(=
M_ERR, L&quot;Out of memory starting openvpn for %ls&quot;, config_file);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!GetLogFilePath(p-&gt;log_file, _countof(p-&gt;log=
_file), settings=2Elog_dir, name))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        MsgToEventLog(M_ERR, L&quot;Error starting openvpn for %ls&quot;, =
config_file);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  free(p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    p-&gt;stop_event =3D CreateEvent(NULL, TRU=
E, FALSE, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!p-&gt;stop_event)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Ms=
gToEventLog(M_SYSERR, L&quot;Error starting openvpn for %ls&quot;, config_f=
ile);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        free(p=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    wcsncpy(p-&gt;working_dir, working_dir, _countof(p=
-&gt;working_dir) - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    wcsncpy(p-&gt;config_file, config_file, _countof(p-&gt;config_file)=
 - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Initializ=
eCriticalSection(&amp;p-&gt;cs);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p-=
&gt;next =3D processes;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    processes =3D p;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;thre=
ad =3D CreateThread(NULL, 0, MonitorProcess, p, 0, NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!p-&gt;thread)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Could not=
 create monitoring thread for %ls&quot;, config_file);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Recursively find configuratio=
n files in a directory</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * and run OpenVPN for each of them=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param dir   the directory to search</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param level the current recursion depth</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+StartConfigsInDir(PCWSTR dir, DWORD level)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    WCHAR ext_pattern[_countof(settings=2Eex=
t_string) + 2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
WCHAR pattern[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    WCHAR path[MAX_PATH];</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    WIN32_FIND_DATA find_data;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    HANDLE find;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (level &gt; MAX_RECURSION_DEPTH)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        MsgToEventLog(M_INFO, L&quot;Maximum recursion depth reached=
=2E Ignoring config dir %ls&quot;, dir);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(ext=
_pattern, _countof(ext_pattern), L&quot;*=2E%ls&quot;, settings=2Eext_strin=
g);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* Run configs in dir */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (PathCchCombine(pat=
tern, _countof(pattern), dir, ext_pattern) =3D=3D S_OK)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        find =3D FindFirstFile(pattern, &amp;find_dat=
a);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (find=
 !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   BOOL directory =3D (find_data=2EdwFileAttributes &amp; FILE_ATTRIBUTE_DI=
RECTORY) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             if (!directory &amp;&amp; PathCchCombine(path, _countof(path),=
 dir, find_data=2EcFileName) =3D=3D S_OK)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    StartConfig(dir, path);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            } while (FindNextFile=
(find, &amp;find_data));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            Fi=
ndClose(find);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (PathCchCombine(pattern, _countof(pattern=
), dir, L&quot;*&quot;) !=3D S_OK)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Try to recurse */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    find =3D FindFirstFile(patt=
ern, &amp;find_data);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (find !=3D INVALID_HANDLE_VALUE)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        do</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (find_data=2EdwFileAttributes &amp; FILE_ATTRIBUTE_DIRECTORY</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; wcs=
cmp(find_data=2EcFileName, L&quot;=2E&quot;) !=3D 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; wcscmp(find_da=
ta=2EcFileName, L&quot;=2E=2E&quot;) !=3D 0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                &amp;&amp; PathCchCombine(path, _co=
untof(path), dir, find_data=2EcFileName) =3D=3D S_OK)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                StartConfigsInDir(path, level +=
 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        } while (Find=
NextFile(find, &amp;find_data));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  FindClose(find);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Start an OpenVPN process for every config found in the autostart<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * config directory=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Having nothing to start is not=
 an error=2E Like an autostart config</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * directory without any config files in it, it leaves th=
e service running</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 without any processes=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+StartAllProcesses(=
void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* starting configs automati=
cally is optional */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (settings=2Eautostart_config_dir[0] =3D=3D L&#39;\0&#39;)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_INFO, L&quot;No a=
utostart config directory configured&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD at=
tr =3D GetFileAttributes(settings=2Eautostart_config_dir);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (attr =3D=3D INVALID_FILE_ATT=
RIBUTES || !(attr &amp; FILE_ATTRIBUTE_DIRECTORY))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        MsgToEventLog(M_ERR, L&quot;Autostart config direc=
tory does not exist at %ls&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                      settings=2Eautostart_config_dir);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    StartConfigsInDir(settings=2Eautostart_config_dir, 0);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!processes)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        MsgToEventLog(M_INFO, L&quot;No configs found =
in %ls&quot;, settings=2Eautostart_config_dir);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Stop all OpenVPN processes and wait =
for their monitoring threads</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+StopAllProcesse=
s(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (openvpn_process_t *p =
=3D processes; p; p =3D p-&gt;next)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        SetEvent(p-&gt;stop_event);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (openvp=
n_process_t *p =3D processes; p; p =3D p-&gt;next)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (p-&gt;thread)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            WaitForSingleObject(p-&gt;thread, INFINITE);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            CloseHandleEx=
(&amp;p-&gt;thread);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (openvpn_process_t *p =3D process=
es; p; p =3D p-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        S=
ignalProcess(p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Free the list of processes</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+FreeAllPr=
ocesses(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_process_t *p=
 =3D processes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (p)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        openvpn_process_t *next =3D p-&gt=
;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        CloseHandleEx(&amp;p-&gt=
;process);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        C=
loseHandleEx(&amp;p-&gt;exit_event);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        CloseHandleEx(&amp;p-&gt;stop_event);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        DeleteCriticalSection(&a=
mp;p-&gt;cs);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  free(p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        p =3D next;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    processes =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Check that the service runs under its virtual serv=
ice account</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The interactive servic=
e lets NT SERVICE\&lt;ovpn_service_user&gt; start OpenVPN</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * with any options=2E Running as a m=
ore privileged account, like LocalSystem,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * would run all with these elevated privileges=2E So=
, rather refuse to run</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * as any other account, in case an admin is adventurous=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param s  the settings, with the name of the s=
ervice account</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return BOOL to ind=
icate whether we run as the service account</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static BOOL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
IsRunningAsServiceAccount(const settings_t *s)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    BOOL ret =3D FALSE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * A TOKEN_USER=
 with room for the largest possible SID after it=2E The sid</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * member alone is used for the=
 SID of the account, as it is aligned=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        TOKEN_=
USER token_user;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     BYTE sid[SECURITY_MAX_SID_SIZE];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    } token_user_info, account_info;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    WCHAR account[MAX_NAME];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    DWORD sid_size =3D sizeof(account_info=2Esid);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    WCHAR domain[MA=
X_NAME];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD d=
omain_size =3D _countof(domain);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    SID_NAME_USE use;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
swprintf(account, _countof(account), L&quot;NT SERVICE\\%ls&quot;, s-&gt;ov=
pn_service_user);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!LookupAccountName(NULL, account, account_info=2Esid, &amp;sid_size, =
domain, &amp;domain_size, &amp;use))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        MsgToEventLog(M_SYSERR, L&quot;Could not look up account %ls&quo=
t;, account);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    HANDLE token;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (!OpenProcessToken(GetCurrentPro=
cess(), TOKEN_QUERY, &amp;token))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        MsgToEventLog(M_SYSERR, L&quot;Could not open process token&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return FALS=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    DWORD len;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    BOOL got_user =3D</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        GetTokenInformation(token, TokenUser, &amp;to=
ken_user_info, sizeof(token_user_info), &amp;len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    CloseHandle(token);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (!got_user)</span><br><span style=
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
pan><br><span>index 0000000=2E=2E881170b</span><br><span>--- /dev/null</spa=
n><br><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv_automatic=
=2Ec</span><br><span>@@ -0,0 +1,241 @@</span><br><span style=3D"color: hsl(=
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
e=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; _countof=
(name) - 1; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        name[i] =
=3D L&#39;a&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    name[_counto=
f(name) - 1] =3D L&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(GetLogFilePath(path, _countof(path), L&quot;C:=
\\log\\&quot;, name));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a log dir=
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
tyle=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"d=
isplay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> G=
errit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: =
I089e5b79600c535e3c0c5d1bb14319ac03f4144b </div>
<div style=3D"display:none=
"> Gerrit-Change-Number: 2001 </div>
<div style=3D"display:none"> Gerrit-Pa=
tchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &lt;=
heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer=
: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--l4TOG7nVHvE=--


--===============0901003272129421780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0901003272129421780==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0901003272129421780==--

