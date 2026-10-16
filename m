Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBD3ECC6B38
	for <openvpn-devel@archiver.kernel.org>; Fri, 16 Oct 2026 06:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zuJHBFwfb9lNyt0VrJV30kJ8+O3c1lXn/j8NuWJtNv0=; b=hi8MZKx9vsvPFhYlpxWGtELYpC
	U1xuzGuFt3CKGH+7iJYbK3R993SDIFLZ0JKKz2MtMKrQLaD8zxArBK9oAW3yyEoVK23SX94LQO/lG
	xi46ZENErW7EMQEYjr5sK68XBwuBqAVpdlxo20hVk7T9vgQC+3pXTg1HWrE/LXVO1WXI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xHbmG-0002SA-GT;
	Fri, 16 Oct 2026 06:50:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xHbmF-0002S4-7h
 for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:50:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=A4tMUsBtpQLEj9LHT7EhekQ0Ll5l675e3RL263weF/I=; b=ObO+HxE9jPLmHxDl7jPk0f+/Or
 impDly+tFewEWqF9mJ6DDSNeAn7D7dfx/ubaxAA4/72mxuwExZ/aqqWuzk6wbG0VxHyWdRzzL/MGI
 Tnmensra7FGAPObC7qETi9HZ9GCvo+mJUoQiS9IhOYi5bhsKoYitzVex1SAR97hB7ZCk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=A4tMUsBtpQLEj9LHT7EhekQ0Ll5l675e3RL263weF/I=; b=R
 1JwkeTt36SDSwipA2iI2Urb2j+RAetzBwAXQ2Lvjz1o1vwj5I13rAt44Kz4mFzANtpgZsy1OCGh0V
 pN6Nye2UbuxVaxzOj7lSgBfInKfSmYqHdA/s+lZIC3rWldr0NC3OVpzqpvMCzEiRkE/q10aPJdGOi
 FkcvICbfyS4dd76Y=;
Received: from mail-wr1-f46.google.com ([209.85.221.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xHbm9-00053G-8e for openvpn-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 06:50:51 +0000
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so1127217f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 15 Oct 2026 23:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792133439; x=1792738239; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=A4tMUsBtpQLEj9LHT7EhekQ0Ll5l675e3RL263weF/I=;
 b=YFGNZ8IE7c2RdN0urKE+VfW6cwxoCTAmPDfpOz5z7mf0vcu2m1w8PBQQn8reA1JIDS
 DmXrQmv/9pO3Wz9mQin6LnOcvJB0Bo3gmzg70yZv0ah/YIGN09ZwmeSFqkSE3o2CQnzv
 tn1IwsqfGs+FJQ0uCbW6IFIQP77WIBlPpyTXQudlIMbEgafVNByO//Yyl4wXtPg8u3uf
 DpM4zAJiZbQmu5mp6iKOGmW1/R3QlZ6g8O0bewYZy+ph4i9/wH0rnb6qxVQhh82bXk1o
 xQkKfQkiXAiQktA8lxHVlupb4RMFTNxPodOwRG+2HL7DiayDz9DRYOBXUF2i7CSaFoqK
 Tk9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792133439; x=1792738239;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=A4tMUsBtpQLEj9LHT7EhekQ0Ll5l675e3RL263weF/I=;
 b=RdHO1vJIZTdbUtXWKJBb5UHbef1QZJmTXUBgQWuVkM0WbFaYJtEWMs04YYqcKC/Yse
 h/+ZUZ3nli8CVAHUlgNvWpwJAsnQW185U4EG6znoUgX6m91pYx+QACF2jqZayjau0BX7
 QMT3JtPTSmvq1KtoNapiZW5mTx56CzuCQ0Ec1uF45qNCSw54vDdVxqx6eP6jxndQUMgx
 AGj61/b9P4zEADDhEcYKDrBJNi0NggostYUadWyB5syUcrCMevwfb88ct4Z/PIxtfGL/
 o74oA44xb2AdJ94SedRjAgOOVLq87bVapGpbVA4ttxUEO9kg3UiLCIhLp3M97IgbFRI8
 cU7Q==
X-Gm-Message-State: AFq9FYKRrvs35hXbVC5ke9k30jcH2robE/iw6EnippzFNeNhujYHmySO
 P8Zop4yabDuXGYIz6oPJm+g6bggSdDZaJhkiVNSKrV9Pf77j3ZbVRXag5TkmLtSzg218xShawdv
 dCUybMHvxCTSBc4J+qo7BAZElu8ejosjKZ+Bm+Ggn4xQXnZJqfzZTQRIjYUv6J0NUpyd4
X-Gm-Gg: AYBFou3olLiZZt7RHZc49ZJ17sbAf0jMDjLaINIcOPoVswMlMFWbzf2Hw4KDPvyB7rv
 3q14FANphLVIB3hJMvT+UGYsbo/dF5kZtM8MqEjAiW4XmjxHmHIquK7IHr3PTgaG33/H421PVEz
 xtGtvJoD8SnQBc5f4CP6Vy7hwSt24+qfDV1vMdtxhbv/ojiUxayykFDln2akmvVzMNiIHJ7q+wc
 LJD1TzhYTX3LLn3EPeNzbDGo5UH2oHUPfTnSbRhk2UJVB3WwlBwd7y4LqQHJwM0s89kSqH6vJnC
 fL+rGlL6MkC5L2NUhpBryIknK5s791sn0CNtoXjBVRSiVZ7KQJ7KoeORs4C3iZ6hZiydSBMbBL1
 UVIoDOfMRQfM7nWao0u+vlfIeY+3GX84ZtdMOFQoTg+YtrdyUzquC0B8Lx1bLe9mAFZ23rLc7W7
 TbnLsHew7Cvf7XTRgJ8Cn0fF3XtyCf1wyriCQ/ZTBjjLuPPrEbKAioYuoQJgqJ4IUcO5WOTdFnI
 sZFYT8D1PgIrWHkgqXnbjiCGpf7uG/o1m3f18QF0gbE+Ae665k4z8RzzpzQoXKuXmO+8tj1Ztua
 HYk2b0Ny1R2NUosCa6+Yj+s3oykSHxKBvmSyNng7ppO44FMMziBkK7UuF0A3GuyowwIpf60=
X-Received: by 2002:a05:6000:1102:b0:487:27f9:844 with SMTP id
 ffacd0b85a97d-48dbaced672mr31757232f8f.57.1792133437637; 
 Thu, 15 Oct 2026 23:50:37 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4ecac3sm3339782f8f.27.2026.10.15.23.50.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 23:50:37 -0700 (PDT)
X-Google-Original-From: "Heiko Hund (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 16 Oct 2026 06:50:34 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
X-Gerrit-Change-Number: 2001
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2001?usp=email>
X-Gerrit-Commit: 1421419c2d3731d8d840acd085375c77d0c3914a
In-Reply-To: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
References: <gerrit.1792128387000.I089e5b79600c535e3c0c5d1bb14319ac03f4144b@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkyMTI4Mzg3MDAwLkkwODllNWI3OTYwMGM1MzVlM2MwYzVkMWJiMTQzMTlhYzAzZjQxNDRiQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a898b2a01f87044322767c15525b02ce86d1b5ba-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xHbm9-00053G-8e
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
Content-Type: multipart/mixed; boundary="===============2938186609555273459=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2938186609555273459==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ifdG6qFctOs="; charset=UTF-8

--ifdG6qFctOs=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/2001?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: openvpnserv: add automatic service again
=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

openvpnserv: add autom=
atic service again

The automatic service, which starts all configs in the =
autostart config
directory, has been provided by the =2ENET based openvpnse=
rv2=2Eexe since
OpenVPN 2=2E4=2E Its original C implementation in openvpnse=
rv=2Eexe was removed
from this repository in 2021=2E Add it back, implement=
ed in C, so that both
Windows services are maintained in this repository=2E=


Security related changes added:
- before sending any data, verify that th=
e named pipe is served by the
  interactive service process
- the exit even=
t of each OpenVPN process has a random name and a DACL
  that only grants a=
ccess to its owner, so it cannot be pre-created or
  signalled by other use=
rs
- the service checks that it is run as the ovpn_service_user account in
=
  the registry settings, so that it and openvpn in turn is guaranteed to
  =
run with limited privileges

Robustness:
- starting a config is retried unt=
il the service stops, with a delay
  that doubles from 10 seconds up to 5 m=
inutes for configs that keep
  failing, and is reset once a process ran for=
 a minute
- an OpenVPN process that may have been started by a failed attem=
pt is
  signalled to exit, so it does not run unmonitored
- configs in subd=
irectories use their own directory as working
  directory; configs with the=
 same file name as one found before are
  ignored, like in the GUI

Both se=
rvices now run in their own process, selected by the new
'-automatic' and '=
-interactive' options=2E This is needed since they need
to run with differe=
nt accounts=2E '-install' takes an optional service
name again=2E '-instanc=
e automatic' is not supported, since the service
cannot check the named pip=
e owner for instances=2E

Also add a few unit tests and some documentation=
=2E

Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b
Signed-off-by: He=
iko Hund <heiko@ist=2Eeigentlich=2Enet>
---
M Changes=2Emd
M doc/Makefile=
=2Eam
A doc/automatic-service-notes=2Erst
M src/openvpnserv/CMakeLists=2Etx=
t
M src/openvpnserv/Makefile=2Eam
A src/openvpnserv/automatic=2Ec
M src/ope=
nvpnserv/common=2Ec
M src/openvpnserv/interactive=2Ec
M src/openvpnserv/ser=
vice=2Ec
M src/openvpnserv/service=2Eh
M tests/unit_tests/openvpnserv/Makef=
ile=2Eam
A tests/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec
12 f=
iles changed, 1,650 insertions(+), 64 deletions(-)


  git pull ssh://gerri=
t=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/2001/2

diff --git a/Change=
s=2Emd b/Changes=2Emd
index 5c3270b=2E=2E813ac33 100644
--- a/Changes=2Emd
=
+++ b/Changes=2Emd
@@ -23,6 +23,33 @@
   the characters mentioned above wer=
e already escaped=2E However, the behavior of
   Mbed TLS is slightly diffe=
rent from OpenSSL in that it also escapes "=3D"=2E
 
+* **Windows automatic=
 service moved back into this repository**
+
+  OpenVPNService, which start=
s all configs in the `config-auto` directory at
+  boot time, is no longer =
provided by the =2ENET based `openvpnserv2=2Eexe`, but by
+  `openvpnserv=
=2Eexe`, like the interactive service is=2E It mostly works like the
+  ser=
vice it was ported from, with these exceptions and additions:
+
+  * The se=
rvice can no longer be run on the command line, but exclusively as
+    a s=
ervice through the Service Control Manager=2E
+  * The service refuses to s=
tart if it does not run as the account
+    `NT SERVICE\OpenVPNService`=2E =
This is checked for security reasons: OpenVPN
+    runs under the same acco=
unt, so its configs, scripts and plugins would get
+    all privileges of a=
 more privileged account as well=2E
+  * All service related logging is don=
e via event log=2E The event source changed
+    from `OpenVpnService` to `=
openvpnserv`, same as for the interactive one=2E
+  * An OpenVPN process th=
at cannot be started or exits is started again,
+    first after 10 seconds=
, with the delay doubling up to 5 minutes for
+    processes that keep fail=
ing=2E
+  * Configs in subdirectories of `config-auto` use their own direct=
ory as
+    working directory=2E Of several configs with the same file name=
, only the
+    first one found is started, like in the OpenVPN GUI=2E
+  *=
 The automatic and the interactive service now each run in a process of
+  =
  their own, selected by the `-automatic` and `-interactive` options of
+  =
  `openvpnserv=2Eexe`=2E `-install` takes an optional service name=2E
+  * =
`-instance automatic` is not supported on purpose=2E It cannot verify the
+=
    interactive service named pipe for instances before connecting=2E
+
 ##=
 Maintainer-visible changes
 
 - The configure-time option `--enable-debug`=
 is no longer  available
diff --git a/doc/Makefile=2Eam b/doc/Makefile=2Eam=

index 5ca1c4d=2E=2Ebbd83cd 100644
--- a/doc/Makefile=2Eam
+++ b/doc/Makefi=
le=2Eam
@@ -55,6 +55,7 @@
 
 dist_noinst_DATA =3D \
 	android=2Etxt \
+	aut=
omatic-service-notes=2Erst \
 	interactive-service-notes=2Erst \
 	keying-m=
aterial-exporter=2Etxt \
 	openvpn=2E8=2Erst \
diff --git a/doc/automatic-s=
ervice-notes=2Erst b/doc/automatic-service-notes=2Erst
new file mode 100644=

index 0000000=2E=2E4c1858c
--- /dev/null
+++ b/doc/automatic-service-notes=
=2Erst
@@ -0,0 +1,151 @@
+OpenVPN Automatic Service Notes
+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
+
+
+Introduction
+------------
+
+OpenVPN Automatic Service, also know=
n as "OpenVPNService", is a Windows system
+service which starts an OpenVPN=
 process for each configuration file in the
+autostart configuration folder=
, ``config-auto`` by default=2E It is meant for
+connections that should be=
 up at all times, independent of any user being
+logged on=2E
+
+
+How It W=
orks
+------------
+
+The Automatic Service does not start OpenVPN itself, =
but uses the Interactive
+Service to do it, the same way OpenVPN GUI does=
=2E See
+`interactive-service-notes=2Erst` for how the Interactive Service =
works=2E
+
+- On start, the service searches the autostart configuration fo=
lder and its
+  subfolders, up to a depth of 32, for files with the configu=
ration file
+  extension=2E
+
+- For each configuration file it connects to=
 the Interactive Service named
+  pipe ``\\=2E\pipe\openvpn\service`` and s=
ends the startup data=2E Before sending
+  anything it checks that the pipe=
 is served by the Interactive Service
+  process, as registered with the Se=
rvice Control Manager=2E
+
+- The Interactive Service starts openvpn=2Eexe =
with the account of the
+  Automatic Service=2E It allows this account to u=
se any options and
+  configuration files in any folder, see `Service Accou=
nt`_=2E
+
+- The folder of the configuration file is used as the working fo=
lder, so
+  relative paths in a configuration file resolve relative to its =
folder=2E
+
+- openvpn=2Eexe is started with these options::
+
+      --log=
 <log file> --config <config file> --service <exit event> 0
+      --pull-f=
ilter ignore route-method
+
+  ``--log-append`` is used instead of ``--log`=
` if configured=2E The exit event
+  is created by the Automatic Service be=
fore each start=2E It has a random name
+  and only its owner, the service =
account, has access to it=2E
+
+- When the service stops, it signals the ex=
it events, which makes the
+  OpenVPN processes exit=2E
+
+Configuration fi=
les are identified by their file name, like in OpenVPN GUI=2E
+If there are=
 several configuration files with the same file name in
+different subfolde=
rs, only the first one found is started and an error is
+logged for the oth=
ers=2E Files in a folder are found before those in its
+subfolders=2E
+
+
+=
Restarting OpenVPN Processes
+----------------------------
+
+An OpenVPN pr=
ocess that exits, or that cannot be started, is started again
+until the se=
rvice stops=2E The first attempt is made after 10 seconds=2E The
+delay dou=
bles with each further failure, up to 5 minutes=2E It is reset to 10
+secon=
ds once an OpenVPN process has run for at least a minute=2E
+
+This also co=
vers the Interactive Service not being reachable, for example
+while it is =
restarted=2E The configurations are started again with the next
+attempt af=
ter it is available again=2E
+
+
+Service Account
+---------------
+
+The A=
utomatic Service runs with the virtual service account
+``NT SERVICE\OpenVP=
NService``=2E The OpenVPN processes it starts run with this
+account too, s=
o configuration files and anything they reference, like keys
+and certifica=
tes, including those in the Windows certificate store, must be
+readable by=
 it=2E The log folder must be writable by it=2E
+
+The service refuses to s=
tart if it runs with any other account=2E OpenVPN
+runs with the same accou=
nt, so configuration files, scripts and plugins
+would get all privileges o=
f a more privileged account, like LocalSystem, as
+well=2E The service is i=
nstalled with its required privileges reduced to
+``SeChangeNotifyPrivilege=
``, which also removes privileges such as
+``SeImpersonatePrivilege`` from =
the OpenVPN processes=2E
+
+The Interactive Service lets the account ``NT S=
ERVICE\<ovpn_service_user>``
+use any options, see `Configuration`_=2E The =
account the Automatic Service
+checks for is derived from the same registry=
 value, so both always agree=2E
+
+
+Configuration
+-------------
+
+The Au=
tomatic Service reads its settings from the
+``HKEY_LOCAL_MACHINE\SOFTWARE\=
OpenVPN`` registry key, like the Interactive
+Service=2E All the following =
registry values are of the ``REG_SZ`` type:
+
+``autostart_config_dir``
+  =
 The autostart configuration folder=2E If this value does not exist or is
+=
   empty, no configurations are started=2E The installer sets it to
+   ``i=
nstall_dir "\config-auto"``=2E
+
+``config_ext``
+   The configuration file=
 extension, without a leading dot; defaults to
+   ``"ovpn"``=2E
+
+``log_d=
ir``
+   The folder for the log files; defaults to ``install_dir "\log"``=
=2E The
+   installer sets it to ``%ProgramData%\OpenVPN\Log`` and makes it=
 writable
+   for the service account=2E Each OpenVPN process logs to a fil=
e in this
+   folder, named like its configuration file, with the extension=
 replaced by
+   ``=2Elog``=2E
+
+``log_append``
+   ``"1"`` to append to e=
xisting log files, ``"0"`` (default) to truncate
+   them when an OpenVPN p=
rocess is started=2E
+
+``ovpn_service_user``
+   The name of the service a=
ccount, without the ``NT SERVICE\`` prefix;
+   defaults to ``"OpenVPNServi=
ce"``=2E Used by the Interactive Service to
+   authorize the Automatic Ser=
vice and by the Automatic Service to check
+   its own account=2E
+
+The va=
lues ``exe_path`` and ``priority`` described in
+`interactive-service-notes=
=2Erst` apply too, as the Interactive Service starts
+the OpenVPN processes=
=2E
+
+The service writes its own messages to the Windows event log, using =
the
+``openvpnserv`` event source, the same as the Interactive Service=2E
+=

+
+Installation
+------------
+
+The OpenVPN installer registers the servi=
ce, whether or not the "OpenVPN
+Service" feature is selected=2E Without th=
e feature it is disabled, otherwise
+it is set to start automatically and s=
tarted=2E Upgrades keep the start mode
+and running state of the service=2E=

+
+The services can also be registered from an elevated command prompt::
+=

+      openvpnserv=2Eexe -install [automatic|interactive]
+
+Without a nam=
e, both services are registered=2E A service that is registered
+already is=
 left alone=2E The Automatic Service is registered with the
+``-automatic``=
 option, its account, the dependency on the Interactive Service
+and its re=
duced privileges=2E Both services run in a process of their own,
+selected =
by the ``-automatic`` and ``-interactive`` options=2E
+
+Unlike the Interac=
tive Service, the Automatic Service does not support the
+``-instance`` opt=
ion for side-by-side installations=2E
diff --git a/src/openvpnserv/CMakeLis=
ts=2Etxt b/src/openvpnserv/CMakeLists=2Etxt
index 2cc4a93=2E=2Edbb7651 1006=
44
--- a/src/openvpnserv/CMakeLists=2Etxt
+++ b/src/openvpnserv/CMakeLists=
=2Etxt
@@ -35,6 +35,7 @@
 add_common_options(openvpnserv)
 target_sources(o=
penvpnserv PRIVATE
     common=2Ec
+    automatic=2Ec
     interactive=2Ec
=
     service=2Ec service=2Eh
     validate=2Ec validate=2Eh
@@ -82,6 +83,7 =
@@
 if (BUILD_TESTING)
     set(unit_tests
         "test_openvpnserv"
+   =
     "test_openvpnserv_automatic"
     )
 
     foreach (test_name ${unit_t=
ests})
@@ -104,4 +106,8 @@
         validate=2Ec
         =2E=2E/openvpn/wf=
p_block=2Ec =2E=2E/openvpn/wfp_block=2Eh
     )
+
+    target_sources(test_=
openvpnserv_automatic PRIVATE
+        common=2Ec
+    )
 endif ()
diff --g=
it a/src/openvpnserv/Makefile=2Eam b/src/openvpnserv/Makefile=2Eam
index 44=
7fb10=2E=2Ed3ca665 100644
--- a/src/openvpnserv/Makefile=2Eam
+++ b/src/ope=
nvpnserv/Makefile=2Eam
@@ -35,6 +35,7 @@
 
 openvpnserv_SOURCES =3D \
     =
    common=2Ec \
+	automatic=2Ec \
 	interactive=2Ec \
 	service=2Ec servic=
e=2Eh \
 	validate=2Ec validate=2Eh \
diff --git a/src/openvpnserv/automati=
c=2Ec b/src/openvpnserv/automatic=2Ec
new file mode 100644
index 0000000=2E=
=2E54d17a0
--- /dev/null
+++ b/src/openvpnserv/automatic=2Ec
@@ -0,0 +1,101=
4 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based
+ * =
            session authentication and key exchange,
+ *             packet=
 encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2026- OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ * =
 This program is free software; you can redistribute it and/or modify
+ *  =
it under the terms of the GNU General Public License version 2
+ *  as publ=
ished by the Free Software Foundation=2E
+ *
+ *  This program is distribut=
ed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTI=
CULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+/*
+ * The automatic service starts one OpenVPN process f=
or each configuration
+ * file found in the autostart config directory and =
restarts them when they
+ * exit unexpectedly=2E The OpenVPN processes are =
not started directly, but by
+ * the interactive service, which this servic=
e talks to via its named pipe=2E
+ */
+
+#include "service=2Eh"
+
+#include=
 <handleapi=2Eh>
+#include <pathcch=2Eh>
+#include <rpc=2Eh>
+#include <sdd=
l=2Eh>
+#include <stdio=2Eh>
+#include <stdlib=2Eh>
+
+/* Time we give the =
interactive service to accept our connection */
+#define ISERVICE_CONNECT_T=
IMEOUT 5000 /*ms*/
+
+/*
+ * Time we wait before an OpenVPN process is star=
ted again, after it exited
+ * or could not be started=2E The delay doubles=
 with each failed attempt, up
+ * to the maximum=2E A process that ran for =
a while resets it to the minimum=2E
+ */
+#define RESTART_DELAY_MIN 10000  =
/*ms*/
+#define RESTART_DELAY_MAX 300000 /*ms*/
+#define STABLE_RUNTIME    =
60000  /*ms*/
+
+/* Maximum size of the startup data sent to the interactiv=
e service */
+#define STARTUP_DATA_MAX 2048
+
+/* Maximum recursion depth w=
hen searching for configuration files */
+#define MAX_RECURSION_DEPTH 32
+
=
+/* Name of the interactive service we talk to */
+#define ISERVICE_NAME _L=
(PACKAGE_NAME) L"ServiceInteractive"
+
+/* The service cannot run without t=
he interactive service, so we make it depend on it=2E */
+#define AUTOMATIC=
_SERVICE_DEPENDENCIES ISERVICE_NAME L"\0\0"
+
+/*
+ * The service runs as i=
ts own virtual service account, which the interactive
+ * service trusts, a=
nd needs no privileges besides the one every process has=2E
+ */
+#define A=
UTOMATIC_SERVICE_ACCOUNT    L"NT SERVICE\\" _L(PACKAGE_NAME) L"Service"
+#d=
efine AUTOMATIC_SERVICE_PRIVILEGES L"SeChangeNotifyPrivilege\0\0"
+
+openvp=
n_service_t automatic_service =3D { automatic,
+                           =
             _L(PACKAGE_NAME) L"Service",
+                                =
        _L(PACKAGE_NAME) L" Automatic Service",
+                          =
              AUTOMATIC_SERVICE_DEPENDENCIES,
+                            =
            SERVICE_DEMAND_START,
+                                        =
L"-automatic",
+                                        // cppcheck-suppres=
s unknownMacro ; FP, _L after a string literal
+                           =
             AUTOMATIC_SERVICE_ACCOUNT,
+                                  =
      AUTOMATIC_SERVICE_PRIVILEGES };
+
+static SERVICE_STATUS_HANDLE servi=
ce;
+static SERVICE_STATUS status =3D { =2EdwServiceType =3D SERVICE_WIN32_=
OWN_PROCESS };
+static HANDLE exit_event =3D NULL;
+
+static settings_t set=
tings;
+
+/* One OpenVPN connection, i=2Ee=2E one configuration file */
+ty=
pedef struct openvpn_process
+{
+    struct openvpn_process *next;
+    WCH=
AR working_dir[MAX_PATH];
+    WCHAR config_file[MAX_PATH];
+    WCHAR log_=
file[MAX_PATH];
+    HANDLE process;
+    HANDLE exit_event;
+    HANDLE st=
op_event;
+    HANDLE thread;
+    CRITICAL_SECTION cs;
+} openvpn_process_=
t;
+
+static openvpn_process_t *processes =3D NULL;
+
+/**
+ * Add a zero t=
erminated string to a buffer=2E
+ *
+ * @param buf   string buffer to appen=
d to
+ * @param size  size of the buffer in wide characters
+ * @param pos =
  in/out position in the buffer in wide characters
+ * @param str   the str=
ing to append
+ *
+ * @return BOOL to indicate success or failure
+ */
+sta=
tic BOOL
+AddStartupData(PWSTR buf, size_t size, size_t *pos, PCWSTR str)
+=
{
+    size_t len =3D wcslen(str) + 1;
+
+    if (*pos + len > size)
+    {=

+        return FALSE;
+    }
+
+    wmemcpy(buf + *pos, str, len);
+    *=
pos +=3D len;
+
+    return TRUE;
+}
+
+/**
+ * Get the process id of the i=
nteractive service
+ *
+ * @return the process id, or 0 if the service is n=
ot running or on error
+ */
+static DWORD
+GetInteractiveServicePid(void)
+=
{
+    DWORD pid =3D 0;
+
+    SC_HANDLE scm =3D OpenSCManager(NULL, NULL, =
SC_MANAGER_CONNECT);
+    if (!scm)
+    {
+        return 0;
+    }
+
+   =
 SC_HANDLE svc =3D OpenService(scm, ISERVICE_NAME, SERVICE_QUERY_STATUS);
+=
    if (svc)
+    {
+        SERVICE_STATUS_PROCESS ssp;
+        DWORD nee=
ded;
+        if (QueryServiceStatusEx(svc, SC_STATUS_PROCESS_INFO, (LPBYTE=
)&ssp, sizeof(ssp), &needed)
+            && ssp=2EdwCurrentState =3D=3D SE=
RVICE_RUNNING)
+        {
+            pid =3D ssp=2EdwProcessId;
+        =
}
+        CloseServiceHandle(svc);
+    }
+
+    CloseServiceHandle(scm);
=
+    return pid;
+}
+
+/**
+ * Check that the server end of a pipe is the i=
nteractive service
+ *
+ * Makes sure we do not send data to, or can be imp=
ersonated by, a process
+ * which created a pipe with the interactive servi=
ce's pipe name=2E
+ *
+ * @param pipe  the connected pipe handle
+ *
+ * @r=
eturn BOOL to indicate whether the pipe server is the interactive service
+=
 */
+static BOOL
+IsInteractiveServicePipe(HANDLE pipe)
+{
+    ULONG serve=
r_pid;
+    if (!GetNamedPipeServerProcessId(pipe, &server_pid))
+    {
+  =
      return FALSE;
+    }
+
+    DWORD iservice_pid =3D GetInteractiveServ=
icePid();
+    return iservice_pid !=3D 0 && server_pid =3D=3D iservice_pid=
;
+}
+
+/**
+ * Connect to the named pipe of the interactive service
+ *
+ =
* The connection is only returned if the pipe is served by the
+ * interact=
ive service process=2E
+ *
+ * @param timeout  maximum time in ms to wait f=
or the pipe to become available
+ *
+ * @return pipe handle, or INVALID_HAN=
DLE_VALUE on error
+ */
+static HANDLE
+ConnectToInteractiveService(DWORD t=
imeout)
+{
+    WCHAR pipe_name[256];
+    ULONGLONG deadline =3D GetTickCo=
unt64() + timeout;
+
+    swprintf(pipe_name, _countof(pipe_name), L"\\\\=
=2E\\pipe\\" _L(PACKAGE) L"%ls\\service", service_instance);
+
+    while (=
TRUE)
+    {
+        HANDLE pipe =3D CreateFile(pipe_name, GENERIC_READ | =
GENERIC_WRITE, 0, NULL, OPEN_EXISTING, 0, NULL);
+        if (pipe !=3D INV=
ALID_HANDLE_VALUE)
+        {
+            DWORD mode =3D PIPE_READMODE_MES=
SAGE;
+            if (!SetNamedPipeHandleState(pipe, &mode, NULL, NULL))
+=
            {
+                CloseHandle(pipe);
+                return I=
NVALID_HANDLE_VALUE;
+            }
+            if (!IsInteractiveServiceP=
ipe(pipe))
+            {
+                MsgToEventLog(M_ERR, L"Pipe %ls =
is not served by the interactive service", pipe_name);
+                Clo=
seHandle(pipe);
+                SetLastError(ERROR_ACCESS_DENIED);
+      =
          return INVALID_HANDLE_VALUE;
+            }
+            return p=
ipe;
+        }
+
+        DWORD error =3D GetLastError();
+        ULONGLO=
NG now =3D GetTickCount64();
+        if (now >=3D deadline)
+        {
+  =
          SetLastError(error);
+            return INVALID_HANDLE_VALUE;
+ =
       }
+
+        if (error =3D=3D ERROR_PIPE_BUSY)
+        {
+         =
   /* All pipe instances are busy, wait for one to become available */
+   =
         if (!WaitNamedPipe(pipe_name, (DWORD)(deadline - now)))
+         =
   {
+                return INVALID_HANDLE_VALUE;
+            }
+        =
}
+        else if (error =3D=3D ERROR_FILE_NOT_FOUND)
+        {
+        =
    /* The interactive service may not have created the pipe yet */
+      =
      Sleep(50);
+        }
+        else
+        {
+            SetLastEr=
ror(error);
+            return INVALID_HANDLE_VALUE;
+        }
+    }
+}
=
+
+/**
+ * Split off the first line of a string
+ *
+ * Lines end with "\n"=
 or "\r\n" in error responses of the interactive service=2E
+ *
+ * @param =
str  the string to split, its first line is zero terminated in place
+ *
+ =
* @return the start of the next line, or NULL if there is none
+ */
+static=
 PWSTR
+SplitLine(PWSTR str)
+{
+    PWSTR eol =3D wcschr(str, L'\n');
+   =
 if (!eol)
+    {
+        return NULL;
+    }
+
+    *eol =3D L'\0';
+    =
if (eol > str && eol[-1] =3D=3D L'\r')
+    {
+        eol[-1] =3D L'\0';
+=
    }
+
+    return eol + 1;
+}
+
+/**
+ * Parse the response of the intera=
ctive service
+ *
+ * The response is a three line string, with the error c=
ode in the first,
+ * the process id in the second if OpenVPN was started s=
uccessfully and
+ * a message in the third line=2E
+ *
+ * @param response =
 the zero terminated response, which is modified
+ * @param error     recei=
ves the error code returned by the service
+ * @param pid       receives th=
e process id of the OpenVPN process
+ *
+ * @return BOOL to indicate succes=
s or failure
+ */
+static BOOL
+ParseInteractiveServiceResponse(PWSTR respo=
nse, PDWORD error, PDWORD pid)
+{
+    PWSTR pid_line =3D SplitLine(respons=
e);
+    if (!pid_line)
+    {
+        SetLastError(ERROR_INVALID_DATA);
+=
        return FALSE;
+    }
+    SplitLine(pid_line);
+
+    PWSTR end;
+ =
   *error =3D wcstoul(response, &end, 16);
+    if (end =3D=3D response || =
*end !=3D L'\0')
+    {
+        SetLastError(ERROR_INVALID_DATA);
+       =
 return FALSE;
+    }
+
+    *pid =3D 0;
+    if (*error =3D=3D 0)
+    {
+=
        *pid =3D wcstoul(pid_line, &end, 16);
+        if (end =3D=3D pid_l=
ine || *end !=3D L'\0')
+        {
+            SetLastError(ERROR_INVALID_=
DATA);
+            return FALSE;
+        }
+    }
+
+    return TRUE;
+}
=
+
+/**
+ * Read the response of the interactive service from the pipe
+ *
+=
 * @param pipe   the pipe to read the response from
+ * @param error  recei=
ves the error code returned by the service
+ * @param pid    receives the p=
rocess id of the OpenVPN process
+ *
+ * @return BOOL to indicate success o=
r failure
+ */
+static BOOL
+ReadInteractiveServiceResponse(HANDLE pipe, PD=
WORD error, PDWORD pid)
+{
+    WCHAR buf[1024];
+    DWORD bytes;
+
+    i=
f (!ReadFile(pipe, buf, sizeof(buf) - sizeof(buf[0]), &bytes, NULL))
+    {=

+        return FALSE;
+    }
+
+    buf[bytes / sizeof(buf[0])] =3D L'\0'=
;
+
+    return ParseInteractiveServiceResponse(buf, error, pid);
+}
+
+/**=

+ * Build the path of the log file of a configuration file
+ *
+ * The log=
 file is named like the configuration file, with its extension
+ * replaced=
 by "=2Elog", and is placed in the log directory=2E
+ *
+ * @param log_file=
  buffer that receives the log file path
+ * @param size      size of the b=
uffer in wide characters
+ * @param log_dir   the directory the log file is=
 placed in
+ * @param name      the file name of the configuration file
+ *=

+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+GetLogF=
ilePath(PWSTR log_file, size_t size, PCWSTR log_dir, PCWSTR name)
+{
+    W=
CHAR log_name[MAX_PATH];
+    PCWSTR dot =3D wcsrchr(name, L'=2E');
+    in=
t len =3D dot ? (int)(dot - name) : (int)(wcslen(name));
+
+    return swpr=
intf(log_name, _countof(log_name), L"%=2E*ls=2Elog", len, name) >=3D 0
+   =
        && PathCchCombine(log_file, size, log_dir, log_name) =3D=3D S_OK;
+=
}
+
+/**
+ * Create the event used to signal an OpenVPN process to exit
+ *=

+ * The name of the event is random, so others cannot create it in advance=

+ * and keep it under their control=2E Should the name exist already anywa=
y,
+ * another one is tried=2E Only the owner of the event has access to it=
=2E
+ * OpenVPN runs with the same account as this service, so it can open =
the
+ * event by its name=2E
+ *
+ * @param name  buffer that receives the =
name of the event
+ * @param size  size of the buffer in wide characters
+ =
*
+ * @return the event handle, or INVALID_HANDLE_VALUE on error
+ */
+stat=
ic HANDLE
+CreateExitEvent(PWSTR name, size_t size)
+{
+    SECURITY_ATTRIB=
UTES sa =3D { =2EnLength =3D sizeof(sa) };
+    HANDLE event =3D INVALID_HA=
NDLE_VALUE;
+
+    if (!ConvertStringSecurityDescriptorToSecurityDescriptor=
W(
+            L"D:P(A;;GA;;;OW)", SDDL_REVISION_1, &sa=2ElpSecurityDescri=
ptor, NULL))
+    {
+        return event;
+    }
+
+    const int max_trie=
s =3D 3;
+    for (int tries =3D 0; tries < max_tries; tries++)
+    {
+   =
     UUID uuid;
+        RPC_WSTR uuid_str;
+        if (UuidCreate(&uuid) =
!=3D RPC_S_OK || UuidToStringW(&uuid, &uuid_str) !=3D RPC_S_OK)
+        {
=
+            break;
+        }
+        swprintf(name, size, _L(PACKAGE) L"=
_exit_%ls", (PWSTR)uuid_str);
+        RpcStringFreeW(&uuid_str);
+
+      =
  event =3D CreateEvent(&sa, TRUE, FALSE, name);
+        if (event && GetL=
astError() !=3D ERROR_ALREADY_EXISTS)
+        {
+            break;
+     =
   }
+        CloseHandleEx(&event);
+    }
+    LocalFree(sa=2ElpSecurityD=
escriptor);
+
+    if (event =3D=3D INVALID_HANDLE_VALUE)
+    {
+        M=
sgToEventLog(M_ERR, L"Could not create exit event=2E");
+    }
+
+    retur=
n event;
+}
+
+/**
+ * Start a OpenVPN process for a configuration file
+ *=

+ * Connects to the interactive service, sends the startup data and reads
=
+ * back the process id of the started OpenVPN process=2E
+ *
+ * @param p =
 the process to start
+ *
+ * @return BOOL to indicate success or failure
+=
 */
+static BOOL
+StartProcess(openvpn_process_t *p)
+{
+    WCHAR cmdline[=
STARTUP_DATA_MAX];
+    WCHAR startup_data[STARTUP_DATA_MAX];
+    WCHAR ex=
it_event_name[MAX_PATH];
+    HANDLE pipe =3D INVALID_HANDLE_VALUE;
+    si=
ze_t pos =3D 0;
+    DWORD error, pid, written;
+    BOOL ret =3D FALSE;
+
=
+    /* each OpenVPN process gets a new exit event */
+    HANDLE event =3D=
 CreateExitEvent(exit_event_name, _countof(exit_event_name));
+    if (!eve=
nt)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not create exit event f=
or config %ls", p->config_file);
+        return FALSE;
+    }
+
+    const=
 WCHAR *log_option =3D settings=2Eappend ? L"--log-append" : L"--log";
+   =
 int n =3D swprintf(cmdline, _countof(cmdline),
+                     L"%ls=
 \"%ls\" --config \"%ls\" --service \"%ls\" 0 --pull-filter ignore route-me=
thod",
+                     log_option, p->log_file, p->config_file, exit_=
event_name);
+    if (n < 0)
+    {
+        MsgToEventLog(M_ERR, L"Command=
 line too long for config %ls", p->config_file);
+        goto out;
+    }
=
+
+    /* working dir + \0 + options + \0 + password + \0 */
+    if (!AddS=
tartupData(startup_data, _countof(startup_data), &pos, p->working_dir)
+   =
     || !AddStartupData(startup_data, _countof(startup_data), &pos, cmdline=
)
+        || !AddStartupData(startup_data, _countof(startup_data), &pos, L=
""))
+    {
+        MsgToEventLog(M_ERR, L"Startup data too long for confi=
g %ls", p->config_file);
+        goto out;
+    }
+
+    pipe =3D ConnectT=
oInteractiveService(ISERVICE_CONNECT_TIMEOUT);
+    if (pipe =3D=3D INVALID=
_HANDLE_VALUE)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not connect =
to the interactive service");
+        goto out;
+    }
+
+    if (!WriteFi=
le(pipe, startup_data, (DWORD)(pos * sizeof(startup_data[0])), &written, NU=
LL))
+    {
+        MsgToEventLog(M_SYSERR, L"Could not send startup data =
to interactive service");
+        goto out;
+    }
+
+    if (!ReadInterac=
tiveServiceResponse(pipe, &error, &pid))
+    {
+        MsgToEventLog(M_SY=
SERR, L"Could not read response from iservice");
+        goto out;
+    }
=
+
+    if (error !=3D 0)
+    {
+        MsgToEventLog(M_ERR, L"Error start=
ing openvpn process: %lu", error);
+        goto out;
+    }
+
+    /*
+   =
  * The interactive service restricts access to the OpenVPN process=2E It d=
oes
+     * not grant PROCESS_QUERY_LIMITED_INFORMATION, but PROCESS_QUERY_=
INFORMATION=2E
+     */
+    HANDLE process =3D OpenProcess(SYNCHRONIZE | P=
ROCESS_QUERY_INFORMATION, FALSE, pid);
+    if (!process)
+    {
+        M=
sgToEventLog(M_SYSERR, L"Could not open OpenVPN process, PID %lu", pid);
+ =
       goto out;
+    }
+
+    EnterCriticalSection(&p->cs);
+    CloseHand=
leEx(&p->process);
+    CloseHandleEx(&p->exit_event);
+    p->process =3D =
process;
+    p->exit_event =3D event;
+    event =3D NULL;
+    LeaveCriti=
calSection(&p->cs);
+
+    MsgToEventLog(M_INFO, L"Started openvpn process =
%lu for config %ls", pid, p->config_file);
+    ret =3D TRUE;
+
+out:
+    =
/*
+     * An OpenVPN process may have been started, even if we could not g=
et a
+     * handle of it or did not receive the response=2E Make sure it e=
xits, as
+     * it would not be monitored nor stopped otherwise=2E
+     *=
/
+    if (!ret && event)
+    {
+        SetEvent(event);
+    }
+    Clos=
eHandleEx(&pipe);
+    CloseHandleEx(&event);
+    return ret;
+}
+
+/**
+ =
* Signal an OpenVPN process to exit
+ *
+ * @param p  the process to signal=

+ */
+static void
+SignalProcess(openvpn_process_t *p)
+{
+    EnterCritic=
alSection(&p->cs);
+    if (p->process && WaitForSingleObject(p->process, 0=
) =3D=3D WAIT_TIMEOUT
+        && !SetEvent(p->exit_event))
+    {
+       =
 DWORD pid =3D GetProcessId(p->process);
+        MsgToEventLog(M_SYSERR, L=
"Error signalling PID %lu to exit", pid);
+    }
+    LeaveCriticalSection(=
&p->cs);
+}
+
+/**
+ * Run the OpenVPN process for a config and restart it =
when it exits
+ *
+ * Starting the process is retried until the service sto=
ps=2E The delay
+ * between the attempts grows when a process cannot be sta=
rted or exits
+ * right away, so a broken config does not keep the system b=
usy=2E
+ *
+ * @param process  the process to run
+ */
+static DWORD WINAPI=

+MonitorProcess(LPVOID process)
+{
+    openvpn_process_t *p =3D process;
=
+    DWORD delay =3D RESTART_DELAY_MIN;
+
+    while (TRUE)
+    {
+       =
 ULONGLONG started =3D GetTickCount64();
+        if (StartProcess(p))
+   =
     {
+            HANDLE handles[2];
+
+            EnterCriticalSection(=
&p->cs);
+            handles[0] =3D p->stop_event;
+            handles[1]=
 =3D p->process;
+            DWORD pid =3D GetProcessId(p->process);
+    =
        LeaveCriticalSection(&p->cs);
+
+            if (WaitForMultipleObj=
ects(2, handles, FALSE, INFINITE) =3D=3D WAIT_OBJECT_0)
+            {
+   =
             break;
+            }
+
+            MsgToEventLog(M_INFO, L"O=
penVPN process %lu for config %ls has exited", pid,
+                      =
    p->config_file);
+
+            /* a process that ran for a while did n=
ot fail right away */
+            if (GetTickCount64() - started >=3D STAB=
LE_RUNTIME)
+            {
+                delay =3D RESTART_DELAY_MIN;
+ =
           }
+        }
+
+        MsgToEventLog(M_INFO, L"Starting config =
%ls again in %lu sec", p->config_file,
+                      delay / 1000)=
;
+
+        if (WaitForSingleObject(p->stop_event, delay) =3D=3D WAIT_OBJE=
CT_0)
+        {
+            break;
+        }
+
+        delay =3D min(de=
lay * 2, RESTART_DELAY_MAX);
+    }
+
+    return NO_ERROR;
+}
+
+/**
+ * F=
ind a process entry with a config file of the given name
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
+ * Create a process entry for a c=
onfiguration file and start the thread
+ * that runs the OpenVPN process fo=
r it=2E
+ *
+ * A config with the same file name as one that was found befo=
re is ignored,
+ * as both would use the same log file=2E This is in line w=
ith how openvpn-gui
+ * handles duplicates=2E
+ *
+ * @param working_dir  t=
he directory the config file is in
+ * @param config_file  path of the conf=
iguration file
+ */
+static void
+StartConfig(PCWSTR working_dir, PCWSTR co=
nfig_file)
+{
+    PCWSTR name =3D wcsrchr(config_file, L'\\');
+    name =
=3D name ? name + 1 : config_file;
+
+    openvpn_process_t *dup =3D FindPr=
ocessByName(name);
+    if (dup)
+    {
+        MsgToEventLog(M_ERR, L"Con=
fig %ls has the same file name as %ls, ignoring it",
+                     =
 config_file, dup->config_file);
+        return;
+    }
+
+    openvpn_pro=
cess_t *p =3D calloc(1, sizeof(*p));
+    if (!p)
+    {
+        MsgToEven=
tLog(M_ERR, L"Out of memory starting openvpn for %ls", config_file);
+     =
   return;
+    }
+
+    if (!GetLogFilePath(p->log_file, _countof(p->log_f=
ile), settings=2Elog_dir, name))
+    {
+        MsgToEventLog(M_ERR, L"Err=
or starting openvpn for %ls", config_file);
+        free(p);
+        retu=
rn;
+    }
+
+    p->stop_event =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+=
    if (!p->stop_event)
+    {
+        MsgToEventLog(M_SYSERR, L"Error sta=
rting openvpn for %ls", config_file);
+        free(p);
+        return;
+ =
   }
+
+    wcsncpy(p->working_dir, working_dir, _countof(p->working_dir) -=
 1);
+    wcsncpy(p->config_file, config_file, _countof(p->config_file) - 1=
);
+    InitializeCriticalSection(&p->cs);
+
+    p->next =3D processes;
+ =
   processes =3D p;
+
+    p->thread =3D CreateThread(NULL, 0, MonitorProce=
ss, p, 0, NULL);
+    if (!p->thread)
+    {
+        MsgToEventLog(M_SYSER=
R, L"Could not create monitoring thread for %ls", config_file);
+    }
+}
+=

+/**
+ * Recursively find configuration files in a directory
+ * and run O=
penVPN for each of them=2E
+ *
+ * @param dir   the directory to search
+ *=
 @param level the current recursion depth
+ */
+static void
+StartConfigsIn=
Dir(PCWSTR dir, DWORD level)
+{
+    WCHAR ext_pattern[_countof(settings=2E=
ext_string) + 2];
+    WCHAR pattern[MAX_PATH];
+    WCHAR path[MAX_PATH];
=
+    WIN32_FIND_DATA find_data;
+    HANDLE find;
+
+    if (level > MAX_RE=
CURSION_DEPTH)
+    {
+        MsgToEventLog(M_INFO, L"Maximum recursion de=
pth reached=2E Ignoring config dir %ls", dir);
+        return;
+    }
+
+ =
   swprintf(ext_pattern, _countof(ext_pattern), L"*=2E%ls", settings=2Eext_=
string);
+
+    /* Run configs in dir */
+    if (PathCchCombine(pattern, _=
countof(pattern), dir, ext_pattern) =3D=3D S_OK)
+    {
+        find =3D F=
indFirstFile(pattern, &find_data);
+        if (find !=3D INVALID_HANDLE_VA=
LUE)
+        {
+            do
+            {
+                BOOL direct=
ory =3D (find_data=2EdwFileAttributes & FILE_ATTRIBUTE_DIRECTORY) !=3D 0;
+=
                if (!directory && PathCchCombine(path, _countof(path), dir,=
 find_data=2EcFileName) =3D=3D S_OK)
+                {
+                  =
  StartConfig(dir, path);
+                }
+            } while (FindNext=
File(find, &find_data));
+
+            FindClose(find);
+        }
+    }
=
+
+    if (PathCchCombine(pattern, _countof(pattern), dir, L"*") !=3D S_OK)=

+    {
+        return;
+    }
+
+    /* Try to recurse */
+    find =3D F=
indFirstFile(pattern, &find_data);
+    if (find !=3D INVALID_HANDLE_VALUE)=

+    {
+        do
+        {
+            if (find_data=2EdwFileAttribute=
s & FILE_ATTRIBUTE_DIRECTORY
+                && wcscmp(find_data=2EcFileNa=
me, L"=2E") !=3D 0
+                && wcscmp(find_data=2EcFileName, L"=2E=
=2E") !=3D 0
+                && PathCchCombine(path, _countof(path), dir, =
find_data=2EcFileName) =3D=3D S_OK)
+            {
+                StartCo=
nfigsInDir(path, level + 1);
+            }
+        } while (FindNextFile(=
find, &find_data));
+
+        FindClose(find);
+    }
+}
+
+/**
+ * Start =
an OpenVPN process for every config found in the autostart
+ * config direc=
tory=2E
+ *
+ * Having nothing to start is not an error=2E Like an autostar=
t config
+ * directory without any config files in it, it leaves the servic=
e running
+ * without any processes=2E
+ */
+static void
+StartAllProcesses=
(void)
+{
+    /* starting configs automatically is optional */
+    if (se=
ttings=2Eautostart_config_dir[0] =3D=3D L'\0')
+    {
+        MsgToEventLo=
g(M_INFO, L"No autostart config directory configured");
+        return;
+ =
   }
+
+    DWORD attr =3D GetFileAttributes(settings=2Eautostart_config_di=
r);
+    if (attr =3D=3D INVALID_FILE_ATTRIBUTES || !(attr & FILE_ATTRIBUTE=
_DIRECTORY))
+    {
+        MsgToEventLog(M_ERR, L"Autostart config direct=
ory does not exist at %ls",
+                      settings=2Eautostart_con=
fig_dir);
+        return;
+    }
+
+    StartConfigsInDir(settings=2Eautos=
tart_config_dir, 0);
+
+    if (!processes)
+    {
+        MsgToEventLog(M=
_INFO, L"No configs found in %ls", settings=2Eautostart_config_dir);
+    }=

+}
+
+/**
+ * Stop all OpenVPN processes and wait for their monitoring thr=
eads
+ */
+static void
+StopAllProcesses(void)
+{
+    for (openvpn_process=
_t *p =3D processes; p; p =3D p->next)
+    {
+        SetEvent(p->stop_eve=
nt);
+    }
+
+    for (openvpn_process_t *p =3D processes; p; p =3D p->nex=
t)
+    {
+        if (p->thread)
+        {
+            WaitForSingleObje=
ct(p->thread, INFINITE);
+            CloseHandleEx(&p->thread);
+        }=

+    }
+
+    for (openvpn_process_t *p =3D processes; p; p =3D p->next)
+=
    {
+        SignalProcess(p);
+    }
+}
+
+/**
+ * Free the list of proc=
esses
+ */
+static void
+FreeAllProcesses(void)
+{
+    openvpn_process_t *=
p =3D processes;
+
+    while (p)
+    {
+        openvpn_process_t *next =
=3D p->next;
+
+        CloseHandleEx(&p->process);
+        CloseHandleEx(=
&p->exit_event);
+        CloseHandleEx(&p->stop_event);
+        DeleteCri=
ticalSection(&p->cs);
+        free(p);
+
+        p =3D next;
+    }
+
+  =
  processes =3D NULL;
+}
+
+
+/**
+ * Check that the service runs under its=
 virtual service account
+ *
+ * The interactive service lets NT SERVICE\<o=
vpn_service_user> start OpenVPN
+ * with any options=2E Running as a more p=
rivileged account, like LocalSystem,
+ * would run all with these elevated =
privileges=2E So, rather refuse to run
+ * as any other account, in case an=
 admin is adventurous=2E
+ *
+ * @param s  the settings, with the name of t=
he service account
+ *
+ * @return BOOL to indicate whether we run as the s=
ervice account
+ */
+static BOOL
+IsRunningAsServiceAccount(const settings_=
t *s)
+{
+    BOOL ret =3D FALSE;
+
+    /*
+     * A TOKEN_USER with room =
for the largest possible SID after it=2E The sid
+     * member alone is us=
ed for the SID of the account, as it is aligned=2E
+     */
+    struct
+  =
  {
+        TOKEN_USER token_user;
+        BYTE sid[SECURITY_MAX_SID_SIZE=
];
+    } token_user_info, account_info;
+
+    WCHAR account[MAX_NAME];
+ =
   DWORD sid_size =3D sizeof(account_info=2Esid);
+    WCHAR domain[MAX_NAM=
E];
+    DWORD domain_size =3D _countof(domain);
+    SID_NAME_USE use;
+
+=
    swprintf(account, _countof(account), L"NT SERVICE\\%ls", s->ovpn_servic=
e_user);
+    if (!LookupAccountName(NULL, account, account_info=2Esid, &si=
d_size, domain, &domain_size, &use))
+    {
+        MsgToEventLog(M_SYSERR=
, L"Could not look up account %ls", account);
+        return FALSE;
+    }=

+
+    HANDLE token;
+    if (!OpenProcessToken(GetCurrentProcess(), TOKEN=
_QUERY, &token))
+    {
+        MsgToEventLog(M_SYSERR, L"Could not open p=
rocess token");
+        return FALSE;
+    }
+
+    DWORD len;
+    BOOL g=
ot_user =3D
+        GetTokenInformation(token, TokenUser, &token_user_info=
, sizeof(token_user_info), &len);
+    CloseHandle(token);
+    if (!got_us=
er)
+    {
+        MsgToEventLog(M_SYSERR, L"Could not get token user");
+=
        return FALSE;
+    }
+
+    ret =3D EqualSid(token_user_info=2Etoke=
n_user=2EUser=2ESid, account_info=2Esid);
+    if (!ret)
+    {
+        Ms=
gToEventLog(M_ERR, L"Service must run as %ls, refusing to start", account);=

+    }
+
+    return ret;
+}
+
+
+static DWORD WINAPI
+ServiceCtrlAutomati=
c(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
+{
+    SERVICE_ST=
ATUS *svc_status =3D ctx;
+    switch (ctrl_code)
+    {
+        case SERV=
ICE_CONTROL_STOP:
+            svc_status->dwCurrentState =3D SERVICE_STOP_=
PENDING;
+            /* threads may be connecting to the interactive servi=
ce */
+            svc_status->dwWaitHint =3D ISERVICE_CONNECT_TIMEOUT + 10=
00;
+            ReportStatusToSCMgr(service, svc_status);
+            if =
(exit_event)
+            {
+                SetEvent(exit_event);
+       =
     }
+            return NO_ERROR;
+
+        case SERVICE_CONTROL_INTERR=
OGATE:
+            return NO_ERROR;
+
+        default:
+            retur=
n ERROR_CALL_NOT_IMPLEMENTED;
+    }
+}
+
+
+VOID WINAPI
+ServiceStartAutom=
atic(DWORD dwArgc, LPWSTR *lpszArgv)
+{
+    DWORD error =3D NO_ERROR;
+
+ =
   service =3D RegisterServiceCtrlHandlerEx(automatic_service=2Ename, Servi=
ceCtrlAutomatic, &status);
+    if (!service)
+    {
+        return;
+    =
}
+
+    status=2EdwCurrentState =3D SERVICE_START_PENDING;
+    status=2Ed=
wServiceSpecificExitCode =3D NO_ERROR;
+    status=2EdwWin32ExitCode =3D NO=
_ERROR;
+    status=2EdwWaitHint =3D 3000;
+
+    if (!ReportStatusToSCMgr(=
service, &status))
+    {
+        MsgToEventLog(M_ERR, L"ReportStatusToSCM=
gr SERVICE_START_PENDING failed");
+        goto finish;
+    }
+
+    /*
+=
     * Create our exit event
+     * This event is initially created in the=
 non-signaled state=2E It will
+     * transition to the signaled state whe=
n we have received a terminate
+     * signal from the Service Control Mana=
ger=2E
+     */
+    exit_event =3D CreateEvent(NULL, TRUE, FALSE, NULL);
+=
    if (!exit_event)
+    {
+        error =3D MsgToEventLog(M_SYSERR, L"Cr=
eateEvent for exit event failed");
+        goto finish;
+    }
+
+    /* R=
ead settings from registry */
+    error =3D GetOpenvpnSettings(&settings);=

+    if (error !=3D ERROR_SUCCESS)
+    {
+        goto finish;
+    }
+
+=
    if (!IsRunningAsServiceAccount(&settings))
+    {
+        error =3D ER=
ROR_ACCESS_DENIED;
+        goto finish;
+    }
+
+    StartAllProcesses();=

+
+    status=2EdwCurrentState =3D SERVICE_RUNNING;
+    status=2EdwWaitHi=
nt =3D 0;
+    if (!ReportStatusToSCMgr(service, &status))
+    {
+        =
MsgToEventLog(M_ERR, L"ReportStatusToSCMgr SERVICE_RUNNING failed");
+     =
   goto finish;
+    }
+
+    if (WaitForSingleObject(exit_event, INFINITE)=
 !=3D WAIT_OBJECT_0)
+    {
+        MsgToEventLog(M_ERR, L"wait for shutdo=
wn signal failed");
+    }
+
+finish:
+    StopAllProcesses();
+    FreeAll=
Processes();
+
+    CloseHandleEx(&exit_event);
+
+    status=2EdwCurrentSt=
ate =3D SERVICE_STOPPED;
+    status=2EdwWin32ExitCode =3D error;
+    Repo=
rtStatusToSCMgr(service, &status);
+}
diff --git a/src/openvpnserv/common=
=2Ec b/src/openvpnserv/common=2Ec
index 7a23d41=2E=2E10a5207 100644
--- a/s=
rc/openvpnserv/common=2Ec
+++ b/src/openvpnserv/common=2Ec
@@ -38,7 +38,7 @=
@
     if (status =3D=3D ERROR_FILE_NOT_FOUND && default_value)
     {
    =
     size_t len =3D size / sizeof(data[0]);
-        if (swprintf(data, len=
, default_value))
+        if (swprintf(data, len, default_value) >=3D 0)
 =
        {
             status =3D ERROR_SUCCESS;
         }
@@ -116,6 +116,=
14 @@
         goto out;
     }
 
+    /* an empty autostart config dir mea=
ns configs are not started automatically */
+    error =3D GetRegString(key=
, L"autostart_config_dir", s->autostart_config_dir,
+                      =
   sizeof(s->autostart_config_dir), L"");
+    if (error !=3D ERROR_SUCCESS=
)
+    {
+        goto out;
+    }
+
     swprintf(default_value, _countof(=
default_value), L"%ls\\bin\\", install_path);
     error =3D GetRegString(k=
ey, L"bin_dir", s->bin_dir, sizeof(s->bin_dir), default_value);
     if (er=
ror !=3D ERROR_SUCCESS || !ensure_trailing_backslash(s->bin_dir, _countof(s=
->bin_dir)))
@@ -123,7 +131,7 @@
         goto out;
     }
 
-    error =3D=
 GetRegString(key, L"config_ext", s->ext_string, sizeof(s->ext_string), L"=
=2Eovpn");
+    error =3D GetRegString(key, L"config_ext", s->ext_string, s=
izeof(s->ext_string), L"ovpn");
     if (error !=3D ERROR_SUCCESS)
     {
 =
        goto out;
@@ -292,6 +300,19 @@
     return error;
 }
 
+void
+Close=
HandleEx(LPHANDLE handle)
+{
+    if (handle)
+    {
+        if (*handle &=
& *handle !=3D INVALID_HANDLE_VALUE)
+        {
+            CloseHandle(*h=
andle);
+        }
+        *handle =3D INVALID_HANDLE_VALUE;
+    }
+}
+
 =
wchar_t *
 utf8to16_size(const char *utf8, int size)
 {
diff --git a/src/op=
envpnserv/interactive=2Ec b/src/openvpnserv/interactive=2Ec
index d8cf6e1=
=2E=2Ef9b0a73 100644
--- a/src/openvpnserv/interactive=2Ec
+++ b/src/openvp=
nserv/interactive=2Ec
@@ -49,7 +49,7 @@
 #define ERROR_MESSAGE_TYPE    0x20=
000003
 
 static SERVICE_STATUS_HANDLE service;
-static SERVICE_STATUS stat=
us =3D { =2EdwServiceType =3D SERVICE_WIN32_SHARE_PROCESS };
+static SERVIC=
E_STATUS status =3D { =2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS };
 st=
atic HANDLE exit_event =3D NULL;
 static settings_t settings;
 static HANDL=
E rdns_semaphore =3D NULL;
@@ -58,9 +58,14 @@
 #define TUN_IOCTL_REGISTER_R=
INGS \
     CTL_CODE(51820U, 0x970U, METHOD_BUFFERED, FILE_READ_DATA | FILE=
_WRITE_DATA)
 
-openvpn_service_t interactive_service =3D { interactive, _L=
(PACKAGE_NAME) L"ServiceInteractive",
+openvpn_service_t interactive_servic=
e =3D { interactive,
+                                          _L(PACKAGE_=
NAME) L"ServiceInteractive",
                                           _L(=
PACKAGE_NAME) L" Interactive Service",
-                                   =
       SERVICE_DEPENDENCIES, SERVICE_AUTO_START };
+                       =
                   SERVICE_DEPENDENCIES,
+                                 =
         SERVICE_AUTO_START,
+                                          L"-=
interactive",
+                                          NULL,
+           =
                               NULL };
 
 
 typedef struct
@@ -172,18 +177,=
6 @@
     return data;
 }
 
-
-static HANDLE
-CloseHandleEx(LPHANDLE handle=
)
-{
-    if (handle && *handle && *handle !=3D INVALID_HANDLE_VALUE)
-    =
{
-        CloseHandle(*handle);
-        *handle =3D INVALID_HANDLE_VALUE;=

-    }
-    return INVALID_HANDLE_VALUE;
-}
-
 static HANDLE
 InitOverlapp=
ed(LPOVERLAPPED overlapped)
 {
@@ -3910,13 +3903,6 @@
 }
 
 
-VOID WINAPI
-=
ServiceStartInteractiveOwn(DWORD dwArgc, LPWSTR *lpszArgv)
-{
-    status=
=2EdwServiceType =3D SERVICE_WIN32_OWN_PROCESS;
-    ServiceStartInteractiv=
e(dwArgc, lpszArgv);
-}
-
 /**
  * Clean up remains of previous sessions in=
 registry=2E These remains can
  * happen with unclean shutdowns or crashes=
 and would interfere with
diff --git a/src/openvpnserv/service=2Ec b/src/op=
envpnserv/service=2Ec
index 2913f63=2E=2E292816c 100644
--- a/src/openvpnse=
rv/service=2Ec
+++ b/src/openvpnserv/service=2Ec
@@ -52,22 +52,52 @@
     r=
eturn res;
 }
 
+/**
+ * Restrict a service to the privileges it actually n=
eeds
+ *
+ * Also gives the service its own SID, which is required for runn=
ing it
+ * as a virtual service account=2E
+ *
+ * @param service     handl=
e of the service, with SERVICE_CHANGE_CONFIG access
+ * @param privileges  =
double zero terminated list of privilege names
+ *
+ * @return BOOL to indi=
cate success or failure
+ */
+static BOOL
+SetServicePrivileges(SC_HANDLE s=
ervice, WCHAR *privileges)
+{
+    SERVICE_SID_INFO sid_info =3D { SERVICE_=
SID_TYPE_UNRESTRICTED };
+    SERVICE_REQUIRED_PRIVILEGES_INFO priv_info =
=3D { privileges };
+
+    return ChangeServiceConfig2(service, SERVICE_CON=
FIG_SERVICE_SID_INFO, &sid_info)
+           && ChangeServiceConfig2(servic=
e, SERVICE_CONFIG_REQUIRED_PRIVILEGES_INFO, &priv_info);
+}
+
+/**
+ * Inst=
all the services
+ *
+ * A service that is installed already counts as succ=
ess, so this can be
+ * run repeatedly, e=2Eg=2E by the MSI installer after=
 an upgrade=2E
+ *
+ * @param type  the service to install, or _service_max=
 for all of them
+ *
+ * @return the number of services that could not be i=
nstalled
+ */
 static int
-CmdInstallServices(void)
+CmdInstallServices(ope=
nvpn_service_type type)
 {
     SC_HANDLE svc_ctl_mgr;
+    WCHAR exe_path[=
MAX_PATH];
     WCHAR path[512];
-    int i, ret =3D _service_max;
+    int=
 ret =3D 0;
 
-    if (GetModuleFileName(NULL, path + 1, _countof(path) - 2=
) =3D=3D 0)
+    DWORD len =3D GetModuleFileName(NULL, exe_path, _countof(e=
xe_path));
+    if (len =3D=3D 0 || len =3D=3D _countof(exe_path))
     {
 =
        wprintf(L"Unable to install service - %ls\n", GetLastErrorText());
=
         return 1;
     }
 
-    path[0] =3D L'\"';
-    wcscat_s(path, _co=
untof(path), L"\"");
-
     svc_ctl_mgr =3D OpenSCManager(NULL, NULL, SC_MA=
NAGER_CONNECT | SC_MANAGER_CREATE_SERVICE);
     if (svc_ctl_mgr =3D=3D NUL=
L)
     {
@@ -75,22 +105,60 @@
         return 1;
     }
 
-    for (i =3D =
0; i < _service_max; i++)
+    for (int i =3D 0; i < _service_max; i++)
   =
  {
-        SC_HANDLE service =3D CreateService(
-            svc_ctl_mgr,=
 openvpn_service[i]=2Ename, openvpn_service[i]=2Edisplay_name,
-           =
 SERVICE_QUERY_STATUS, SERVICE_WIN32_SHARE_PROCESS, openvpn_service[i]=2Est=
art_type,
-            SERVICE_ERROR_NORMAL, path, NULL, NULL, openvpn_serv=
ice[i]=2Edependencies, NULL, NULL);
-        if (service)
+        if (type=
 !=3D _service_max && type !=3D (openvpn_service_type)i)
         {
-      =
      wprintf(L"%ls installed=2E\n", openvpn_service[i]=2Edisplay_name);
- =
           CloseServiceHandle(service);
-            --ret;
+            co=
ntinue;
         }
-        else
+
+        openvpn_service_t *ovpn_svc =3D=
 &openvpn_service[i];
+
+        /* each service runs in its own process, s=
elected by the arguments */
+        swprintf(path, _countof(path), L"\"%ls=
\"%ls%ls", exe_path,
+                 ovpn_svc->arguments ? L" " : L"", ov=
pn_svc->arguments ? ovpn_svc->arguments : L"");
+
+        /*
+         * A=
 service that was just deleted stays marked for deletion until
+         * =
all handles to it are closed, e=2Eg=2E by an open services=2Emsc=2E
+      =
   */
+        int tries =3D 10;
+        SC_HANDLE service;
+        while=
 (!(service =3D CreateService(svc_ctl_mgr, ovpn_svc->name, ovpn_svc->displa=
y_name,
+                                         SERVICE_QUERY_STATUS | SE=
RVICE_CHANGE_CONFIG | DELETE,
+                                         SER=
VICE_WIN32_OWN_PROCESS, ovpn_svc->start_type,
+                            =
             SERVICE_ERROR_NORMAL, path, NULL, NULL,
+                     =
                    ovpn_svc->dependencies, ovpn_svc->account, NULL))
+    =
           && GetLastError() =3D=3D ERROR_SERVICE_MARKED_FOR_DELETE && --tr=
ies)
         {
+            Sleep(1000);
+        }
+
+        if (!servic=
e)
+        {
+            if (GetLastError() =3D=3D ERROR_SERVICE_EXISTS)
=
+            {
+                wprintf(L"%ls is installed already=2E\n", o=
vpn_svc->display_name);
+                continue;
+            }
         =
    wprintf(L"CreateService failed - %ls\n", GetLastErrorText());
+        =
    ++ret;
+            continue;
         }
+
+        if (ovpn_svc->requi=
red_privileges
+            && !SetServicePrivileges(service, ovpn_svc->req=
uired_privileges))
+        {
+            /* do not leave a service with t=
oo many privileges behind */
+            wprintf(L"Restricting privileges =
failed - %ls\n", GetLastErrorText());
+            DeleteService(service);
=
+            CloseServiceHandle(service);
+            ++ret;
+            =
continue;
+        }
+
+        wprintf(L"%ls installed=2E\n", ovpn_svc->di=
splay_name);
+        CloseServiceHandle(service);
     }
 
     CloseServi=
ceHandle(svc_ctl_mgr);
@@ -140,7 +208,6 @@
 static int
 CmdRemoveServices(v=
oid)
 {
-    SC_HANDLE service;
     SC_HANDLE svc_ctl_mgr;
     SERVICE_ST=
ATUS status;
     int i, ret =3D _service_max;
@@ -155,12 +222,13 @@
     f=
or (i =3D 0; i < _service_max; i++)
     {
         openvpn_service_t *ovpn=
_svc =3D &openvpn_service[i];
-        service =3D
+        SC_HANDLE servi=
ce =3D
             OpenService(svc_ctl_mgr, ovpn_svc->name, DELETE | SERVI=
CE_STOP | SERVICE_QUERY_STATUS);
         if (service =3D=3D NULL)
        =
 {
+            /* the service may not be installed, continue with the next=
 one */
             wprintf(L"OpenService failed - %ls\n", GetLastErrorTex=
t());
-            goto out;
+            continue;
         }
 
         /=
* try to stop the service */
@@ -206,7 +274,6 @@
         CloseServiceHandl=
e(service);
     }
 
-out:
     CloseServiceHandle(svc_ctl_mgr);
     retur=
n ret;
 }
@@ -215,20 +282,21 @@
 int
 wmain(int argc, WCHAR *argv[])
 {
-  =
  /*
-     * Interactive service (as a SERVICE_WIN32_SHARE_PROCESS)
-     *=
 This is the default=2E
-     */
-    const SERVICE_TABLE_ENTRY dispatchTab=
le_shared[] =3D {
-        { interactive_service=2Ename, ServiceStartIntera=
ctive }, { NULL, NULL }
-    };
-
-    /* Interactive service only (as a SE=
RVICE_WIN32_OWN_PROCESS) */
-    const SERVICE_TABLE_ENTRY dispatchTable_in=
teractive[] =3D { { L"", ServiceStartInteractiveOwn },
+    /* Interactive =
service (as a SERVICE_WIN32_OWN_PROCESS), this is the default */
+    const=
 SERVICE_TABLE_ENTRY dispatchTable_interactive[] =3D { { L"", ServiceStartI=
nteractive },
                                                             =
  { NULL, NULL } };
 
-    const SERVICE_TABLE_ENTRY *dispatchTable =3D dis=
patchTable_shared;
+    /*
+     * Automatic service (as a SERVICE_WIN32_OW=
N_PROCESS)
+     * It has to run in a process of its own, as it runs with a=
n account
+     * that is less privileged than the one of the interactive s=
ervice=2E
+     */
+    const SERVICE_TABLE_ENTRY dispatchTable_automatic[]=
 =3D { { L"", ServiceStartAutomatic },
+                                   =
                         { NULL, NULL } };
 
+    const SERVICE_TABLE_ENTRY=
 *dispatchTable =3D dispatchTable_interactive;
+
+    openvpn_service[autom=
atic] =3D automatic_service;
     openvpn_service[interactive] =3D interact=
ive_service;
 
     for (int i =3D 1; i < argc; i++)
@@ -237,7 +305,24 @@
 =
        {
             if (_wcsicmp(L"install", argv[i] + 1) =3D=3D 0)
    =
         {
-                return CmdInstallServices();
+                o=
penvpn_service_type type =3D _service_max;
+                if (argc > i + =
1)
+                {
+                    if (_wcsicmp(L"automatic", argv[=
i + 1]) =3D=3D 0)
+                    {
+                        type =3D =
automatic;
+                    }
+                    else if (_wcsicmp(L"=
interactive", argv[i + 1]) =3D=3D 0)
+                    {
+              =
          type =3D interactive;
+                    }
+                   =
 else
+                    {
+                        wprintf(L"Unknown ser=
vice '%ls'\n", argv[i + 1]);
+                        return 1;
+          =
          }
+                }
+                return CmdInstallServices(t=
ype);
             }
             else if (_wcsicmp(L"remove", argv[i] + 1)=
 =3D=3D 0)
             {
@@ -245,7 +330,16 @@
             }
             =
else if (_wcsicmp(L"start", argv[i] + 1) =3D=3D 0)
             {
-        =
        return CmdStartService(interactive);
+                BOOL is_auto =
=3D argc > i + 1 && _wcsicmp(L"automatic", argv[i + 1]) =3D=3D 0;
+        =
        return CmdStartService(is_auto ? automatic : interactive);
+       =
     }
+            else if (_wcsicmp(L"automatic", argv[i] + 1) =3D=3D 0)
=
+            {
+                dispatchTable =3D dispatchTable_automatic;
=
+            }
+            else if (_wcsicmp(L"interactive", argv[i] + 1) =
=3D=3D 0)
+            {
+                dispatchTable =3D dispatchTable_i=
nteractive;
             }
             else if (argc > i + 2 && _wcsicmp(L=
"instance", argv[i] + 1) =3D=3D 0)
             {
@@ -265,13 +359,21 @@
   =
          }
             else
             {
-                wprintf(L"%ls=
 -install        to install the interactive service\n", APPNAME);
         =
        wprintf(
-                    L"%ls -start [name]   to start the se=
rvice (name =3D \"interactive\") is optional\n",
+                    L"%ls=
 -install [name] to install services (name =3D \"automatic\" or \"interacti=
ve\",\n"
+                    L"                            defaults to bot=
h)\n",
                     APPNAME);
-                wprintf(L"%ls -remov=
e         to remove the service\n", APPNAME);
+                wprintf(
+  =
                  L"%ls -start [name]   to start a service (name =3D \"auto=
matic\" or \"interactive\",\n"
+                    L"                     =
       defaults to \"interactive\")\n",
+                    APPNAME);
+   =
             wprintf(L"%ls -remove         to remove the services\n", APPNA=
ME);
 
                 wprintf(L"\nService run-time parameters:\n");
+    =
            wprintf(L"-automatic\n"
+                        L"   Runs the =
automatic service=2E\n");
+                wprintf(L"-interactive\n"
+     =
                   L"   Runs the interactive service=2E This is the default=
=2E\n");
                 wprintf(L"-instance interactive <id>\n"
         =
                L"   Runs the service as an alternate instance=2E\n"
      =
                   L"   The service settings will be loaded from\n"
diff --=
git a/src/openvpnserv/service=2Eh b/src/openvpnserv/service=2Eh
index c67d6=
7f=2E=2E2c012d2 100644
--- a/src/openvpnserv/service=2Eh
+++ b/src/openvpns=
erv/service=2Eh
@@ -47,6 +47,7 @@
 
 typedef enum
 {
+    automatic,
     i=
nteractive,
     _service_max
 } openvpn_service_type;
@@ -58,6 +59,9 @@
  =
   WCHAR *display_name;
     WCHAR *dependencies;
     DWORD start_type;
+ =
   WCHAR *arguments;
+    WCHAR *account;
+    WCHAR *required_privileges;
=
 } openvpn_service_t;
 
 #define MAX_NAME 256
@@ -65,6 +69,7 @@
 {
     WCH=
AR exe_path[MAX_PATH];
     WCHAR config_dir[MAX_PATH];
+    WCHAR autostar=
t_config_dir[MAX_PATH];
     WCHAR bin_dir[MAX_PATH];
     WCHAR ext_string=
[16];
     WCHAR log_dir[MAX_PATH];
@@ -74,10 +79,11 @@
     BOOL append;
 =
} settings_t;
 
+extern openvpn_service_t automatic_service;
 extern openvp=
n_service_t interactive_service;
 extern LPCWSTR service_instance;
 
-VOID =
WINAPI ServiceStartInteractiveOwn(DWORD argc, LPWSTR *argv);
+VOID WINAPI S=
erviceStartAutomatic(DWORD argc, LPWSTR *argv);
 
 VOID WINAPI ServiceStart=
Interactive(DWORD argc, LPWSTR *argv);
 
@@ -90,6 +96,16 @@
 DWORD MsgToEve=
ntLog(DWORD flags, LPCWSTR lpszMsg, =2E=2E=2E);
 
 /**
+ * Close a handle a=
nd invalidate it
+ *
+ * Nothing is done if the handle is invalid already, =
which makes it safe
+ * to call this function more than once for the same h=
andle=2E
+ *
+ * @param handle  pointer to the handle to be closed
+ */
+vo=
id CloseHandleEx(LPHANDLE handle);
+
+/**
  * Convert a UTF-8 string to UTF=
-16
  *
  * The size parameter can be used to convert strings which contain=
 inline NUL
diff --git a/tests/unit_tests/openvpnserv/Makefile=2Eam b/tests=
/unit_tests/openvpnserv/Makefile=2Eam
index 19de666=2E=2E2753ad2 100644
---=
 a/tests/unit_tests/openvpnserv/Makefile=2Eam
+++ b/tests/unit_tests/openvp=
nserv/Makefile=2Eam
@@ -3,14 +3,34 @@
 AM_TESTSUITE_SUMMARY_HEADER =3D ' fo=
r $(PACKAGE_STRING) service Unit-Tests'
 
 if WIN32
-test_binaries =3D open=
vpnserv_testdriver
+test_binaries =3D openvpnserv_testdriver openvpnserv_au=
tomatic_testdriver
 endif
 check_PROGRAMS =3D $(test_binaries)
 
-openvpnse=
rv_testdriver_CFLAGS  =3D -I$(top_srcdir)/include -I$(top_srcdir)/src/openv=
pn -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpnserv @TEST_CFLAGS@=

-openvpnserv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/ope=
nvpn
+# build the tests like openvpnserv itself, see src/openvpnserv/Makefi=
le=2Eam
+openvpnserv_test_cflags =3D \
+	-municode -D_UNICODE \
+	-UNTDDI_V=
ERSION -D_WIN32_WINNT=3D_WIN32_WINNT_WIN10 \
+	-I$(top_srcdir)/include -I$(=
top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat \
+	-I$(top_srcdir)/src/=
openvpnserv -I$(top_builddir)/src/openvpnserv \
+	-I$(top_srcdir)/tests/uni=
t_tests/openvpn \
+	@TEST_CFLAGS@
+openvpnserv_test_ldflags =3D -municode @=
TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
+openvpnserv_test_ldadd =3D \
+	-=
ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
+	-lshlwapi -lnetapi32=
 -lws2_32 -lntdll -lole32 -lpathcch
+
+openvpnserv_testdriver_CFLAGS  =3D $=
(openvpnserv_test_cflags)
+openvpnserv_testdriver_LDFLAGS =3D $(openvpnserv=
_test_ldflags)
+openvpnserv_testdriver_LDADD   =3D $(openvpnserv_test_ldadd=
)
 openvpnserv_testdriver_SOURCES =3D test_openvpnserv=2Ec \
 	$(top_srcdir=
)/src/openvpnserv/common=2Ec \
 	$(top_srcdir)/src/openvpnserv/validate=2Ec=
 \
 	$(top_srcdir)/src//openvpn/wfp_block=2Ec \
 	$(top_srcdir)/src//openvp=
n/wfp_block=2Eh
+
+openvpnserv_automatic_testdriver_CFLAGS  =3D $(openvpnse=
rv_test_cflags)
+openvpnserv_automatic_testdriver_LDFLAGS =3D $(openvpnserv=
_test_ldflags)
+openvpnserv_automatic_testdriver_LDADD   =3D $(openvpnserv_=
test_ldadd)
+openvpnserv_automatic_testdriver_SOURCES =3D test_openvpnserv_=
automatic=2Ec \
+	$(top_srcdir)/src/openvpnserv/common=2Ec
diff --git a/tes=
ts/unit_tests/openvpnserv/test_openvpnserv_automatic=2Ec b/tests/unit_tests=
/openvpnserv/test_openvpnserv_automatic=2Ec
new file mode 100644
index 0000=
000=2E=2E881170b
--- /dev/null
+++ b/tests/unit_tests/openvpnserv/test_open=
vpnserv_automatic=2Ec
@@ -0,0 +1,241 @@
+/*
+ *  OpenVPN -- An application =
to securely tunnel IP networks
+ *             over a single UDP port, with=
 support for SSL/TLS-based
+ *             session authentication and key e=
xchange,
+ *             packet encryption, packet authentication, and
+ * =
            packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN Inc <=
sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redist=
ribute it and/or modify
+ *  it under the terms of the GNU General Public L=
icense as published by the
+ *  Free Software Foundation, either version 2 =
of the License,
+ *  or (at your option) any later version=2E
+ *
+ *  This=
 program is distributed in the hope that it will be useful,
+ *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lice=
nse for more details=2E
+ *
+ *  You should have received a copy of the GNU=
 General Public License along
+ *  with this program; if not, see <https://=
www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "confi=
g=2Eh"
+#endif
+
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+#include "t=
est_common=2Eh"
+
+#include <winsock2=2Eh>
+#include <windows=2Eh>
+
+/*
+ =
* The automatic service cannot be linked together with the interactive one
=
+ * in a single test driver, as both define the same static service state=
=2E
+ */
+#include "automatic=2Ec"
+
+BOOL
+ReportStatusToSCMgr(SERVICE_STA=
TUS_HANDLE svc_handle, SERVICE_STATUS *svc_status)
+{
+    return TRUE;
+}
=
+
+/**
+ * Parse a response like the one sent by the interactive service
+ =
*
+ * @param response  the response string
+ * @param error     receives th=
e error code of the response
+ * @param pid       receives the process id o=
f the response
+ *
+ * @return the result of ParseInteractiveServiceRespons=
e()
+ */
+static BOOL
+parse_response(PCWSTR response, PDWORD error, PDWORD=
 pid)
+{
+    /* the response is modified while parsing, so pass a copy */
=
+    WCHAR buf[256];
+    assert_true(wcslen(response) < _countof(buf));
+ =
   wcscpy(buf, response);
+
+    return ParseInteractiveServiceResponse(buf=
, error, pid);
+}
+
+static void
+test_response_success(void **state)
+{
+ =
   DWORD error =3D 0xdeadbeef;
+    DWORD pid =3D 0xdeadbeef;
+
+    assert=
_true(parse_response(L"0x00000000\n0x000004d2\nProcess ID", &error, &pid));=

+    assert_int_equal(error, 0);
+    assert_int_equal(pid, 1234);
+}
+
+s=
tatic void
+test_response_error(void **state)
+{
+    DWORD error =3D 0xdea=
dbeef;
+    DWORD pid =3D 0xdeadbeef;
+
+    /*
+     * An error response c=
arries the name of the failed function in the
+     * second line, which mu=
st not be mistaken for a process id=2E
+     */
+    assert_true(parse_resp=
onse(L"0x0000007b\nCreateProcessAsUser\nThe filename is invalid", &error,
+=
                               &pid));
+    assert_int_equal(error, 0x7b);
=
+    assert_int_equal(pid, 0);
+}
+
+static void
+test_response_error_crlf(=
void **state)
+{
+    DWORD error =3D 0xdeadbeef;
+    DWORD pid =3D 0xdead=
beef;
+
+    /* error responses are built with FormatMessage(), which uses =
\r\n line breaks */
+    assert_true(parse_response(L"0x20000001\r\nYou hav=
e specified a config file location\r\n", &error,
+                         =
      &pid));
+    assert_int_equal(error, 0x20000001);
+    assert_int_equ=
al(pid, 0);
+}
+
+static void
+test_response_malformed(void **state)
+{
+  =
  DWORD error, pid;
+
+    /* no line break at all */
+    assert_false(par=
se_response(L"0x00000000", &error, &pid));
+
+    /* neither line is a numb=
er */
+    assert_false(parse_response(L"hello world\nnot a pid\nmessage", =
&error, &pid));
+
+    /* the error code is a number with trailing garbage =
*/
+    assert_false(parse_response(L"0x00000000xyz\n0x000004d2\nProcess ID=
", &error, &pid));
+
+    /* success response without a process id */
+    =
assert_false(parse_response(L"0x00000000\n", &error, &pid));
+
+    /* succ=
ess response with an empty process id line */
+    assert_false(parse_respo=
nse(L"0x00000000\n\nProcess ID", &error, &pid));
+
+    /* the process id i=
s a number with trailing garbage */
+    assert_false(parse_response(L"0x00=
000000\n0x000004d2xyz\nProcess ID", &error, &pid));
+
+    /* empty lines o=
nly */
+    assert_false(parse_response(L"\n\n", &error, &pid));
+}
+
+stat=
ic void
+test_add_startup_data(void **state)
+{
+    WCHAR buf[32];
+    si=
ze_t pos =3D 0;
+
+    /* the startup data is config dir + \0 + options + \=
0 + password + \0 */
+    assert_true(AddStartupData(buf, _countof(buf), &p=
os, L"C:\\cfg"));
+    assert_int_equal(pos, 7);
+
+    assert_true(AddStar=
tupData(buf, _countof(buf), &pos, L"--log x"));
+    assert_int_equal(pos, =
15);
+
+    /* the password is empty, but still terminated */
+    assert_t=
rue(AddStartupData(buf, _countof(buf), &pos, L""));
+    assert_int_equal(p=
os, 16);
+
+    /* the fields are separated and terminated by zeros */
+   =
 const WCHAR expected[] =3D L"C:\\cfg\0--log x\0";
+    assert_int_equal(po=
s, _countof(expected));
+    assert_int_equal(wmemcmp(buf, expected, pos), =
0);
+}
+
+static void
+test_add_startup_data_full(void **state)
+{
+    WCH=
AR buf[8];
+    size_t pos =3D 0;
+
+    wmemset(buf, L'#', _countof(buf));=

+
+    /* a string that does not fit is rejected without changing anything=
 */
+    assert_false(AddStartupData(buf, _countof(buf), &pos, L"12345678")=
);
+    assert_int_equal(pos, 0);
+    for (size_t i =3D 0; i < _countof(bu=
f); i++)
+    {
+        assert_int_equal(buf[i], L'#');
+    }
+
+    /* a=
 string whose terminator ends up as the last element still fits */
+    ass=
ert_true(AddStartupData(buf, _countof(buf), &pos, L"1234567"));
+    assert=
_int_equal(pos, _countof(buf));
+
+    /* but leaves no room for another fi=
eld, not even an empty one */
+    assert_false(AddStartupData(buf, _counto=
f(buf), &pos, L""));
+    assert_int_equal(pos, _countof(buf));
+}
+
+stati=
c void
+test_log_file_path(void **state)
+{
+    WCHAR path[MAX_PATH];
+   =
 WCHAR name[MAX_PATH + 64];
+
+    /* the extension is replaced by =2Elog *=
/
+    assert_true(GetLogFilePath(path, _countof(path), L"C:\\log\\", L"off=
ice=2Eovpn"));
+    assert_int_equal(wcscmp(path, L"C:\\log\\office=2Elog")=
, 0);
+
+    /* a missing backslash on the log dir is added */
+    assert_=
true(GetLogFilePath(path, _countof(path), L"C:\\log", L"office=2Eovpn"));
+=
    assert_int_equal(wcscmp(path, L"C:\\log\\office=2Elog"), 0);
+
+    /* =
only the last extension is replaced */
+    assert_true(GetLogFilePath(path=
, _countof(path), L"C:\\log\\", L"my=2Eoffice=2Eovpn"));
+    assert_int_eq=
ual(wcscmp(path, L"C:\\log\\my=2Eoffice=2Elog"), 0);
+
+    /* a name witho=
ut an extension just gets one */
+    assert_true(GetLogFilePath(path, _cou=
ntof(path), L"C:\\log\\", L"office"));
+    assert_int_equal(wcscmp(path, L=
"C:\\log\\office=2Elog"), 0);
+
+    /* a name that is nothing but an exten=
sion */
+    assert_true(GetLogFilePath(path, _countof(path), L"C:\\log\\",=
 L"=2Eovpn"));
+    assert_int_equal(wcscmp(path, L"C:\\log\\=2Elog"), 0);
=
+
+    /* spaces are no problem */
+    assert_true(GetLogFilePath(path, _c=
ountof(path), L"C:\\my logs\\", L"my office=2Eovpn"));
+    assert_int_equa=
l(wcscmp(path, L"C:\\my logs\\my office=2Elog"), 0);
+
+    /* a config fil=
e name that cannot fit the log file name is an error */
+    for (size_t i =
=3D 0; i < _countof(name) - 1; i++)
+    {
+        name[i] =3D L'a';
+    =
}
+    name[_countof(name) - 1] =3D L'\0';
+    assert_false(GetLogFilePath=
(path, _countof(path), L"C:\\log\\", name));
+
+    /* a log dir that does =
not leave room for the name is an error */
+    assert_false(GetLogFilePath=
(path, 8, L"C:\\some\\very\\long\\log\\dir", L"office=2Eovpn"));
+}
+
+int
=
+wmain(void)
+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTes=
t tests[] =3D {
+        cmocka_unit_test(test_response_success),
+        =
cmocka_unit_test(test_response_error),
+        cmocka_unit_test(test_respo=
nse_error_crlf),
+        cmocka_unit_test(test_response_malformed),
+     =
   cmocka_unit_test(test_add_startup_data),
+        cmocka_unit_test(test_=
add_startup_data_full),
+        cmocka_unit_test(test_log_file_path),
+   =
 };
+
+    int ret =3D cmocka_run_group_tests_name("openvpnserv automatic s=
ervice tests", tests, NULL, NULL);
+
+    return ret;
+}

-- 
To view, visi=
t https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2001?usp=3Demail
To unsubscrib=
e, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/s=
ettings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvp=
n
Gerrit-Branch: master
Gerrit-Change-Id: I089e5b79600c535e3c0c5d1bb14319ac=
03f4144b
Gerrit-Change-Number: 2001
Gerrit-PatchSet: 2
Gerrit-Owner: Heiko =
Hund <heiko@openvpn=2Enet>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2=
549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Ene=
t>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--ifdG6qFctOs=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Heiko Hund <strong>uploaded p=
atch set #2</strong> to this change=2E</p><p><a href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/2001?usp=3Demail">View Change</a></p><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
openvpnserv: add automatic service again<br><br>The automatic service, whic=
h starts all configs in the autostart config<br>directory, has been provide=
d by the =2ENET based openvpnserv2=2Eexe since<br>OpenVPN 2=2E4=2E Its orig=
inal C implementation in openvpnserv=2Eexe was removed<br>from this reposit=
ory in 2021=2E Add it back, implemented in C, so that both<br>Windows servi=
ces are maintained in this repository=2E<br><br>Security related changes ad=
ded:<br>- before sending any data, verify that the named pipe is served by =
the<br>  interactive service process<br>- the exit event of each OpenVPN pr=
ocess has a random name and a DACL<br>  that only grants access to its owne=
r, so it cannot be pre-created or<br>  signalled by other users<br>- the se=
rvice checks that it is run as the ovpn_service_user account in<br>  the re=
gistry settings, so that it and openvpn in turn is guaranteed to<br>  run w=
ith limited privileges<br><br>Robustness:<br>- starting a config is retried=
 until the service stops, with a delay<br>  that doubles from 10 seconds up=
 to 5 minutes for configs that keep<br>  failing, and is reset once a proce=
ss ran for a minute<br>- an OpenVPN process that may have been started by a=
 failed attempt is<br>  signalled to exit, so it does not run unmonitored<b=
r>- configs in subdirectories use their own directory as working<br>  direc=
tory; configs with the same file name as one found before are<br>  ignored,=
 like in the GUI<br><br>Both services now run in their own process, selecte=
d by the new<br>&#39;-automatic&#39; and &#39;-interactive&#39; options=2E =
This is needed since they need<br>to run with different accounts=2E &#39;-i=
nstall&#39; takes an optional service<br>name again=2E &#39;-instance autom=
atic&#39; is not supported, since the service<br>cannot check the named pip=
e owner for instances=2E<br><br>Also add a few unit tests and some document=
ation=2E<br><br>Change-Id: I089e5b79600c535e3c0c5d1bb14319ac03f4144b<br>Sig=
ned-off-by: Heiko Hund &lt;heiko@ist=2Eeigentlich=2Enet&gt;<br>---<br>M Cha=
nges=2Emd<br>M doc/Makefile=2Eam<br>A doc/automatic-service-notes=2Erst<br>=
M src/openvpnserv/CMakeLists=2Etxt<br>M src/openvpnserv/Makefile=2Eam<br>A =
src/openvpnserv/automatic=2Ec<br>M src/openvpnserv/common=2Ec<br>M src/open=
vpnserv/interactive=2Ec<br>M src/openvpnserv/service=2Ec<br>M src/openvpnse=
rv/service=2Eh<br>M tests/unit_tests/openvpnserv/Makefile=2Eam<br>A tests/u=
nit_tests/openvpnserv/test_openvpnserv_automatic=2Ec<br>12 files changed, 1=
,650 insertions(+), 64 deletions(-)<br><br></pre><pre class=3D"blocks" styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/01/2001/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/Changes=2Emd b/Changes=2Emd</span><br><span>index 5c3270b=2E=2E813=
ac33 100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Change=
s=2Emd</span><br><span>@@ -23,6 +23,33 @@</span><br><span>   the characters=
 mentioned above were already escaped=2E However, the behavior of</span><br=
><span>   Mbed TLS is slightly different from OpenSSL in that it also escap=
es &quot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+* **Windows automatic service moved back into this repo=
sitory**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPNService, which starts=
 all configs in the `config-auto` directory at</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  boot time, is no longer provided by the =2ENET=
 based `openvpnserv2=2Eexe`, but by</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  `openvpnserv=2Eexe`, like the interactive service is=2E I=
t mostly works like the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  service it was ported from, with these exceptions and additions:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  * The service can no longer be run on t=
he command line, but exclusively as</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    a service through the Service Control Manager=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  * The service refuses to=
 start if it does not run as the account</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    `NT SERVICE\OpenVPNService`=2E This is checked for=
 security reasons: OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    runs under the same account, so its configs, scripts and plugins=
 would get</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    all p=
rivileges of a more privileged account as well=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  * All service related logging is done via e=
vent log=2E The event source changed</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    from `OpenVpnService` to `openvpnserv`, same as for th=
e interactive one=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  * An OpenVPN process that cannot be started or exits is started again,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    first after 10 se=
conds, with the delay doubling up to 5 minutes for</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    processes that keep failing=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  * Configs in subdirectories=
 of `config-auto` use their own directory as</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    working directory=2E Of several configs with t=
he same file name, only the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    first one found is started, like in the OpenVPN GUI=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  * The automatic and the in=
teractive service now each run in a process of</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    their own, selected by the `-automatic` and =
`-interactive` options of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    `openvpnserv=2Eexe`=2E `-install` takes an optional service name=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  * `-instance a=
utomatic` is not supported on purpose=2E It cannot verify the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    interactive service named pip=
e for instances before connecting=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> ## Maintainer-visible changes</span><br>=
<span> </span><br><span> - The configure-time option `--enable-debug` is no=
 longer  available</span><br><span>diff --git a/doc/Makefile=2Eam b/doc/Mak=
efile=2Eam</span><br><span>index 5ca1c4d=2E=2Ebbd83cd 100644</span><br><spa=
n>--- a/doc/Makefile=2Eam</span><br><span>+++ b/doc/Makefile=2Eam</span><br=
><span>@@ -55,6 +55,7 @@</span><br><span> </span><br><span> dist_noinst_DAT=
A =3D \</span><br><span> 	android=2Etxt \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	automatic-service-notes=2Erst \</span><br><span> 	in=
teractive-service-notes=2Erst \</span><br><span> 	keying-material-exporter=
=2Etxt \</span><br><span> 	openvpn=2E8=2Erst \</span><br><span>diff --git a=
/doc/automatic-service-notes=2Erst b/doc/automatic-service-notes=2Erst</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E4c1858c=
</span><br><span>--- /dev/null</span><br><span>+++ b/doc/automatic-service-=
notes=2Erst</span><br><span>@@ -0,0 +1,151 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+OpenVPN Automatic Service Notes</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Introduction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-------=
-----</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+OpenVPN Automatic Service, also k=
nown as &quot;OpenVPNService&quot;, is a Windows system</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+service which starts an OpenVPN process=
 for each configuration file in the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+autostart configuration folder, ``config-auto`` by default=
=2E It is meant for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
connections that should be up at all times, independent of any user being</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+logged on=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+How It Works</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+The Automatic Service do=
es not start OpenVPN itself, but uses the Interactive</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Service to do it, the same way OpenVPN GU=
I does=2E See</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`inter=
active-service-notes=2Erst` for how the Interactive Service works=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+- On start, the service searches the autostar=
t configuration folder and its</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  subfolders, up to a depth of 32, for files with the configurat=
ion file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  extension=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+- For each configuration file it co=
nnects to the Interactive Service named</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  pipe ``\\=2E\pipe\openvpn\service`` and sends the sta=
rtup data=2E Before sending</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  anything it checks that the pipe is served by the Interactive Ser=
vice</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  process, as r=
egistered with the Service Control Manager=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+- The Interactive Service starts openvpn=2Eexe with the account of t=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Automatic Servi=
ce=2E It allows this account to use any options and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  configuration files in any folder, see =
`Service Account`_=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- The folder of t=
he configuration file is used as the working folder, so</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  relative paths in a configuration fil=
e resolve relative to its folder=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- o=
penvpn=2Eexe is started with these options::</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      --log &lt;log file&gt; --config &lt;config file&gt; --service &=
lt;exit event&gt; 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      --pull-filter ignore route-method</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  ``--log-append`` is used instead of ``--log`` if configured=2E The exit =
event</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  is created b=
y the Automatic Service before each start=2E It has a random name</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  and only its owner, the ser=
vice account, has access to it=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Whe=
n the service stops, it signals the exit events, which makes the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN processes exit=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Configuration files are identified by the=
ir file name, like in OpenVPN GUI=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+If there are several configuration files with the same fil=
e name in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+different =
subfolders, only the first one found is started and an error is</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+logged for the others=2E Files =
in a folder are found before those in its</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+subfolders=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+Restarting OpenVPN Pro=
cesses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-------------=
---------------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+An OpenVPN process that=
 exits, or that cannot be started, is started again</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+until the service stops=2E The first atte=
mpt is made after 10 seconds=2E The</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+delay doubles with each further failure, up to 5 minutes=2E=
 It is reset to 10</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
econds once an OpenVPN process has run for at least a minute=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+This also covers the Interactive Service not being=
 reachable, for example</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+while it is restarted=2E The configurations are started again with the =
next</span><br><span style=3D"color: hsl(120, 100%, 40%);">+attempt after i=
t is available again=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+Service Account</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+---------------</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+The Automatic Service runs with the virtual service account<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+``NT SERVICE\OpenVPN=
Service``=2E The OpenVPN processes it starts run with this</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+account too, so configuration files =
and anything they reference, like keys</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+and certificates, including those in the Windows certifi=
cate store, must be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
readable by it=2E The log folder must be writable by it=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+The service refuses to start if it runs with any other =
account=2E OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
uns with the same account, so configuration files, scripts and plugins</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+would get all privileges=
 of a more privileged account, like LocalSystem, as</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+well=2E The service is installed with its=
 required privileges reduced to</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+``SeChangeNotifyPrivilege``, which also removes privileges such=
 as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``SeImpersonateP=
rivilege`` from the OpenVPN processes=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+The Interactive Service lets the account ``NT SERVICE\&lt;ovpn_service_us=
er&gt;``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+use any opt=
ions, see `Configuration`_=2E The account the Automatic Service</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+checks for is derived from the =
same registry value, so both always agree=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Configuration=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+-------------</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+The Automatic Service reads its settings fro=
m the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+``HKEY_LOCAL_M=
ACHINE\SOFTWARE\OpenVPN`` registry key, like the Interactive</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+Service=2E All the following regis=
try values are of the ``REG_SZ`` type:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
``autostart_config_dir``</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+   The autostart configuration folder=2E If this value does not exist =
or is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   empty, no c=
onfigurations are started=2E The installer sets it to</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   ``install_dir &quot;\config-auto&quot;=
``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+``config_ext``</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+   The configuration file extension, w=
ithout a leading dot; defaults to</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+   ``&quot;ovpn&quot;``=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+``log_dir``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   The=
 folder for the log files; defaults to ``install_dir &quot;\log&quot;``=2E =
The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   installer set=
s it to ``%ProgramData%\OpenVPN\Log`` and makes it writable</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+   for the service account=2E Each =
OpenVPN process logs to a file in this</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+   folder, named like its configuration file, with the e=
xtension replaced by</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+   ``=2Elog``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+``log_append``</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   ``&quot;1&quot;`` to ap=
pend to existing log files, ``&quot;0&quot;`` (default) to truncate</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+   them when an OpenVPN pro=
cess is started=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+``ovpn_service_user`=
`</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   The name of the=
 service account, without the ``NT SERVICE\`` prefix;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   defaults to ``&quot;OpenVPNService&quo=
t;``=2E Used by the Interactive Service to</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+   authorize the Automatic Service and by the Automa=
tic Service to check</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+   its own account=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The values ``exe=
_path`` and ``priority`` described in</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+`interactive-service-notes=2Erst` apply too, as the Inter=
active Service starts</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+the OpenVPN processes=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The service =
writes its own messages to the Windows event log, using the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+``openvpnserv`` event source, the s=
ame as the Interactive Service=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+Installation</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+------------</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+The OpenVPN installer registers the service, whether or n=
ot the &quot;OpenVPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+Service&quot; feature is selected=2E Without the feature it is disabled, o=
therwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+it is set t=
o start automatically and started=2E Upgrades keep the start mode</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+and running state of the serv=
ice=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+The services can also be registe=
red from an elevated command prompt::</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     openvpnserv=2Eexe -install [automatic|interactive]</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+Without a name, both services are registered=2E A service =
that is registered</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a=
lready is left alone=2E The Automatic Service is registered with the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+``-automatic`` option, its=
 account, the dependency on the Interactive Service</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+and its reduced privileges=2E Both servic=
es run in a process of their own,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+selected by the ``-automatic`` and ``-interactive`` options=
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
PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: Heiko Hund &l=
t;heiko@openvpn=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=
=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schwa=
be &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></html>
--ifdG6qFctOs=--


--===============2938186609555273459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2938186609555273459==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2938186609555273459==--

