Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CA34C9832F
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 07:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MJn23ogZpKbgvHxbrn3g4tYujhXNxi3FPCB0IddNY4k=; b=HoXlJX/ZEevRDXKI36zpO47R03
	VjHWS3oVRyrTHFz2mqJ3uLwGuA/hYLPMEMybvlbZq73t9uJTxCfkmCVMk98SAyiXIh4DZ/6SECFqu
	uzuM75wn1W6hyJ9gJGRui2KwHMNC2OJWDaw8BvZi0SXthBl/V/hU3wVvincBpaqwpafE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xB5l8-0000r4-19;
	Mon, 28 Sep 2026 07:26:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xB5kp-0000qk-31
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 07:26:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=BrM/bgoTveE3NtNnb3QUZfmdjL/uB73GJ23iwFqCobg=; b=RspEZTPOXE2QA1tKSPVMyXgt19
 6UvTdVt8L3nj1ySiFWAU7udCSO5D2nc1ytZet3nQGVnMz9Pc2E5jjeIjs4KGHmf+DCLKf/yI2p6q/
 0mVOE3M2SBt5P8EusBgg/O8ANAb/w5jqSfGgnnmxUQN1GyFeS1cehcYCZGNuYoGZhRVY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BrM/bgoTveE3NtNnb3QUZfmdjL/uB73GJ23iwFqCobg=; b=b
 fmO1t/hqISt/Dj4LKVpRavsjce53mmvXR34H7kLR+6af5CdpkLO3DiL2Im1UkjFOXDzwON40o+20C
 dNHRAdpe62fooOnlRUgNcdlGDLisTFHgF5bY3G0fUjXtn3J1A+BFPQTxItAwmnPEO/e0rf0pUqGyu
 1WUoJrsblDW2GxEM=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xB5kh-00052p-6V for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 07:26:21 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so13949595e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 00:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790580373; x=1791185173; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BrM/bgoTveE3NtNnb3QUZfmdjL/uB73GJ23iwFqCobg=;
 b=XfDjN81LLyFneWB/OJBbQharOYHz7zCfZeENH059hwt+uT2ZlCgwq/T3HbDdJSaa4m
 I2tYftZl+6N+PtGREi6GHUuV9jqxb2EyU5QPsZ0UTIInDnQrN9MM7UblFx6OsGEw6CBQ
 XBDZ7xuxU65j4nLKGNjWSWQ9Ar0Fn8ldSlEbzXvIWEH9X01H44SQadNcONNbjE6ALXBi
 DNI0B3RjtMG3+D5cFA+d6BtO1pSZ74nUeqlLLn0yV2onXYzH7JB56OhDe28ocFOJrIDz
 rLB9ULNa+jhju2PceiInmKP7yBAbHN/noxj+9XJYb5O8YaJbALVNBIEN/ZcFeVXaiJaH
 jNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790580373; x=1791185173;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BrM/bgoTveE3NtNnb3QUZfmdjL/uB73GJ23iwFqCobg=;
 b=MQUzU9CpyNmYK2xNSlddpSnDacGqS/XbqG5rmjlmwxhGuPih383nr+tztpKAnrj/SC
 ubTOwU5cnN6mkP87DYYpymK8PuvNqfD6Qrykgml+slalK01hofBZXQx6NC09wNFtt1Rf
 LtMqgIb/dEMaBobNRh9hDfuOhHb8jNEA8WKMgBcS10jcR9PZd0voUhufDClHtiTX5jid
 nd6A0LsSMa0c1jlFAJX6BCOv1G2HI83l5v7EsAIIN1GkA29yfUk9beQg4tnHVC1+kr0x
 1xFg1oxhLQbfcUWF58DxJaO3QLQmFeHSFfSsd50xYhgaLP3oJUePxpRQfZz6xWfiOZE4
 9hEg==
X-Gm-Message-State: AFuF++nf6YME/pM+4dbb4FzEt7xZ+GkSZR8qQHwrSjueKNvoTodsaRUG
 I3Vmj43bKiGY7MKybjaxk0+6prWpU0f9chsHRiyz3BSltR8xDttFhW62vLuWRRqaKuJzp3ab9MS
 KmsEv+chTVRPbuVZXArmHv1w3jWwFOOcfGiOF4h7J13YH60b8IvC+tKqgSoV5gUD+rPhcU/hi56
 n7CVszxQ==
X-Gm-Gg: AYBFou3AaSEyFYT22spg2qg9wvbx+Kgb1ANUbEPDbb9euDZCcVOVFOkOlm1aOkfx39F
 Z5wYnH8dCSUvtlGnXfhLPcbyJBk5WFw4ueKJ/tm0z2dsZsAxu/2O7m+1fkzHFBdpsK3+6Tp0tAq
 Wa+bIXB8LOFwa73Ljaw5G3l8U9ECgNHcEylJM+v7q3MyVR6UUYLBXWQlh+vFEtEY8n2SUBJ2UXj
 tRGFJOx7pZCctPFZ9e8WNEKLoZRJBCoB1ROckhbFG8QfXhMz8B2sB0xKs38RkpoGczfz5Y8pZ+C
 l9nP7R4U8yJ63RncNLBUWqljR4xsdOiSDzIpRwbqMDMSL5bVeINOzQfGW1jjxUrij8Xpd8laJyN
 2rVp/KDVsb3/p9sjefzXE4fn4B18wjpLNQKJxyQN/y4SxkN6/Me1TxHPZwp/URowktUb2JRIoeC
 W8+le6eeWxyBUly2TPjAoZOReQHt/dBNafQWcUEHucw3bYNY7TNz/zDW2dwKCOOrkAE9iy/Eic1
 wCY/IHlzukZTgkV018p4GEWONzf2lT9dD3GNKYU06DHhizXAjTBgyxzSjKCliS5UPBdjvNjdO0w
 AvCc62NXFYJ/lKiuyv0Rvk99btaBxuV+ZifxU4/w0LOCJk8pq/xpHsIQTOjE
X-Received: by 2002:a05:600c:4709:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-49ffbad2d61mr86675975e9.33.1790580372289; 
 Mon, 28 Sep 2026 00:26:12 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a007fd1a01sm17221385e9.0.2026.09.28.00.26.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 00:26:11 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 07:26:09 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
X-Gerrit-Change-Number: 1949
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1949?usp=email>
X-Gerrit-Commit: 5b7dd8356d402cce1f8a8b5005c43596a7ee4d12
In-Reply-To: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
References: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzA2NzE5MDAwLkkyZThmMTQ0OWZlNTRlN2Y2MjhlMmJkYjA0MmVlMmE1NjdmMjVlMDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <75dee0b6bd10bbc0f90bc494d59109e197163f94-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xB5kh-00052p-6V
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: add an
 end-to-end test for --route gateway keywords
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
From: "chugly \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: charlie.vigue@openvpn.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============8406213807836305247=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8406213807836305247==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hZoJgWBC+No="; charset=UTF-8

--hZoJgWBC+No=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: chugly, flichtenheld, plaisthos=2E

H=
ello flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Pleas=
e visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail

to=
 look at the new patch set (#2)=2E

The following approvals got outdated an=
d were removed:
Code-Review-1 by flichtenheld


Change subject: tests: add =
an end-to-end test for --route gateway keywords
=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: add an end-to-end test for --rout=
e gateway keywords

Nothing self-contained checks that a route openvpn says=
 it installed
actually reached the kernel with the gateway it reported=2E t=
_client=2Esh does
compare routes, but it needs a t_client=2Erc and reachabl=
e servers, so it
skips for contributors and in CI=2E

Run a TLS loopback pa=
ir inside a throwaway network namespace, ask the
client for a route via net=
_gateway, and check where it lands=2E route=2Ec
tracks two gateways, the sy=
stem default route and the route towards the
peer, and net_gateway is the f=
ormer=2E The peer here is on loopback, so the
two differ and the assertion =
can tell them apart: resolving from the wrong
one leaves the route with no =
gateway and the install fails outright=2E

The namespace also means the fix=
ed loopback ports cannot collide, so this
needs none of the retry-on-addres=
s-in-use handling t_cltsrv=2Esh has=2E

The part that does not depend on ho=
w the environment is isolated lives in
t_route_common=2Esh: starting the op=
envpn pair, waiting for the route to
appear, and comparing the gateway=2E  =
t_route=2Esh supplies the three hooks
that do depend on the platform, runni=
ng a command inside the namespace and
the two routing table queries=2E  The=
 comparison is against the gateway the
platform reports rather than the tex=
t of the routing table entry, because
every routing tool spells that entry =
differently=2E  A front end for a
system without network namespaces can the=
n reuse the whole driver=2E

Both files are POSIX sh=2E  Nothing here neede=
d bash, and with a /bin/sh
shebang the runtime skips below can do their job=
 on a platform without
bash rather than the script failing to start=2E

Ski=
ps rather than fails when it cannot run: not Linux, no iproute2, or no
way =
to get the privileges a namespace needs=2E Containers commonly disallow
nam=
espace creation, so this will skip there and run on VMs and bare metal=2E
R=
UN_SUDO is picked up from t_client=2Erc the same way t_net=2Esh does=2E

Ch=
ange-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
Signed-off-by: Charlie V=
igue <charlie=2Evigue@openvpn=2Ecom>
---
M tests/Makefile=2Eam
A tests/t_ro=
ute=2Esh
A tests/t_route_common=2Esh
3 files changed, 200 insertions(+), 1 =
deletion(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/49/1949/2

diff --git a/tests/Makefile=2Eam b/tests/Makefile=2Eam
ind=
ex 3907965=2E=2E5cfbf67e 100644
--- a/tests/Makefile=2Eam
+++ b/tests/Makef=
ile=2Eam
@@ -18,7 +18,7 @@
 SH_LOG_DRIVER =3D $(SHELL) $(top_srcdir)/forked=
-test-driver
 
 if !WIN32
-test_scripts =3D t_client=2Esh t_lpback=2Esh t_c=
ltsrv=2Esh t_server_null=2Esh
+test_scripts =3D t_client=2Esh t_lpback=2Esh=
 t_cltsrv=2Esh t_server_null=2Esh t_route=2Esh
 
 check_PROGRAMS =3D ntlm_s=
upport
 if HAVE_SITNL
@@ -35,6 +35,8 @@
 	t_cltsrv-down=2Esh \
 	t_lpback=
=2Esh \
 	t_net=2Esh \
+	t_route=2Esh \
+	t_route_common=2Esh \
 	t_server_=
null=2Esh \
 	t_server_null_client=2Esh \
 	t_server_null_server=2Esh \
dif=
f --git a/tests/t_route=2Esh b/tests/t_route=2Esh
new file mode 100755
inde=
x 0000000=2E=2E16ac293
--- /dev/null
+++ b/tests/t_route=2Esh
@@ -0,0 +1,12=
9 @@
+#!/bin/sh
+#
+# t_route=2Esh - check that --route installs a route wh=
ere it says it will
+#
+# The special gateway keywords (net_gateway, vpn_ga=
teway, remote_host) are
+# resolved in route=2Ec from data gathered off the=
 system routing table=2E The
+# unit tests cover the resolution itself; thi=
s checks that the answer
+# reaches the kernel=2E
+#
+# route=2Ec keeps two=
 gateways: the system default route, and the route
+# towards the peer=2E n=
et_gateway is the former=2E Here the peer is on
+# loopback, so the two are=
 necessarily different and an assertion on the
+# installed gateway tells t=
hem apart=2E
+#
+# This is the network namespace front end, so the host rou=
ting table is not
+# touched and the fixed loopback ports cannot collide wi=
th anything=2E The
+# part that drives openvpn and checks the result lives =
in
+# t_route_common=2Esh, so a front end for a platform without namespaces=
 can
+# reuse it=2E
+
+srcdir=3D"${srcdir:-=2E}"
+top_builddir=3D"${top_bui=
lddir:-=2E=2E}"
+top_srcdir=3D"${top_srcdir:-${srcdir}/=2E=2E}"
+openvpn=3D=
"${openvpn:-${top_builddir}/src/openvpn/openvpn}"
+
+# Namespace topology: =
one interface carrying a default route, which is
+# what net_gateway has to=
 resolve to=2E
+NS=3D"ovpnroute$$"
+TUN=3D"ovpnt$$"
+LAN_GW=3D"10=2E71=2E1=
=2E1"
+TARGET=3D"10=2E71=2E250=2E1" # what we ask to be routed via net_gate=
way
+VPN_LOCAL=3D"10=2E71=2E8=2E2"
+VPN_REMOTE=3D"10=2E71=2E8=2E1"
+
+# Nam=
espaces and dummy interfaces are Linux-only=2E A front end for another
+# p=
latform would set its own environment up and reuse t_route_common=2Esh=2E
+=
if [ "$(uname -s)" !=3D "Linux" ]; then
+    echo "$0: this front end runs =
only on Linux=2E SKIPPING TEST=2E"
+    exit 77
+fi
+
+if [ ! -x "${openvpn=
}" ]; then
+    echo "$0: no (executable) openvpn binary in current build t=
ree=2E FAIL=2E" >&2
+    exit 1
+fi
+
+if ! command -v ip >/dev/null 2>&1; =
then
+    echo "$0: no iproute2 'ip' command in \$PATH=2E SKIPPING TEST=2E"=
 >&2
+    exit 77
+fi
+
+# t_client=2Erc is read only for a RUN_SUDO defini=
tion, as t_net=2Esh does
+if [ -r "${top_builddir}"/t_client=2Erc ]; then
+=
    =2E "${top_builddir}"/t_client=2Erc
+elif [ -r "${srcdir}"/t_client=2Er=
c ]; then
+    =2E "${srcdir}"/t_client=2Erc
+fi
+
+if [ "$(id -u)" -ne 0 ]=
; then
+    if [ -z "$RUN_SUDO" ]; then
+        RUN_SUDO=3D"sudo"
+    fi
=
+else
+    RUN_SUDO=3D""
+fi
+
+# A namespace needs the same privileges the=
 rest of the test does, so use
+# it as the probe=2E
+if ! $RUN_SUDO ip net=
ns add "$NS"; then
+    echo "$0: cannot create a network namespace with '$=
RUN_SUDO'=2E" >&2
+    echo "$0: containers commonly disallow this=2E SKIPP=
ING TEST=2E" >&2
+    exit 77
+fi
+
+srv_pid=3D""
+clt_pid=3D""
+logdir=3D$=
(mktemp -d) || exit 1
+
+cleanup()
+{
+    [ -n "$clt_pid" ] && kill "$clt_=
pid"
+    [ -n "$srv_pid" ] && kill "$srv_pid"
+    wait
+    # deleting th=
e namespace takes every interface and route in it with it
+    $RUN_SUDO ip=
 netns del "$NS"
+    [ -n "$logdir" ] && rm -rf "$logdir"
+    return 0
+}=

+trap cleanup EXIT
+
+plat_exec()
+{
+    $RUN_SUDO ip netns exec "$NS" "$=
@"
+}
+
+plat_route_show()
+{
+    # absence is the expected state while po=
lling, so the error iproute2
+    # prints for an unreachable address is no=
ise rather than a diagnostic
+    plat_exec ip route show "$1" 2>/dev/null
=
+}
+
+plat_route_gateway()
+{
+    plat_route_show "$1" | sed -n 's/=2E*[[:=
space:]]via[[:space:]]\([^[:space:]]*\)=2E*/\1/p'
+}
+
+=2E "${srcdir}"/t_r=
oute_common=2Esh
+
+set -e
+plat_exec ip link set lo up
+plat_exec ip link =
add lan0 type dummy
+plat_exec ip link set lan0 up
+plat_exec ip addr add 1=
0=2E71=2E1=2E2/24 dev lan0
+plat_exec ip route add default via "$LAN_GW" de=
v lan0
+set +e
+
+route_start_pair
+
+if ! route_wait_for "$TARGET"; then
+=
    echo "$0: route to $TARGET was never installed=2E FAIL=2E" >&2
+    ech=
o "--- client log ---" >&2
+    cat "$logdir"/clt=2Elog >&2
+    exit 1
+fi=

+
+route_assert_gateway "$LAN_GW" || exit 1
+
+exit 0
diff --git a/tests/t=
_route_common=2Esh b/tests/t_route_common=2Esh
new file mode 100755
index 0=
000000=2E=2E3a1fdd0
--- /dev/null
+++ b/tests/t_route_common=2Esh
@@ -0,0 +=
1,68 @@
+#!/bin/sh
+#
+# t_route_common=2Esh - platform-independent part of=
 the --route gateway test
+#
+# Sourced by a front end that supplies the en=
vironment the test runs in and
+# the routing-table queries for the platfor=
m:
+#
+#   plat_exec CMD=2E=2E=2E          run CMD inside the test environm=
ent
+#   plat_route_show ADDR      print the routing table entry for ADDR, =
if any
+#   plat_route_gateway ADDR   print just the gateway of that entry,=
 if any
+#
+# The front end also sets openvpn, top_srcdir, logdir, TUN, TAR=
GET,
+# VPN_LOCAL and VPN_REMOTE before sourcing this file=2E
+#
+# Nothing=
 here knows how the environment is isolated or which tools report
+# the ro=
uting table, so a front end for a platform without network
+# namespaces ca=
n reuse all of it=2E
+
+# A TLS loopback pair, as t_cltsrv=2Esh uses=2E Opt=
ions after --config override
+# the config file, which is how the client ge=
ts a tun and a route=2E
+route_start_pair()
+{
+    plat_exec "${openvpn}" =
--cd "${top_srcdir}/sample" \
+        --config sample-config-files/loopbac=
k-server \
+        --verb 3 --ping-exit 60 >"$logdir"/srv=2Elog 2>&1 &
+  =
  srv_pid=3D$!
+
+    plat_exec "${openvpn}" --cd "${top_srcdir}/sample" \
=
+        --config sample-config-files/loopback-client \
+        --dev "$TU=
N" --dev-type tun \
+        --ifconfig "$VPN_LOCAL" "$VPN_REMOTE" \
+     =
   --route "$TARGET" 255=2E255=2E255=2E255 net_gateway \
+        --verb 4 =
--ping-exit 60 >"$logdir"/clt=2Elog 2>&1 &
+    clt_pid=3D$!
+}
+
+# Wait f=
or the route to show up rather than guessing at a sleep=2E  Sets
+# route_o=
ut to the entry that appeared=2E
+route_wait_for()
+{
+    i=3D0
+    route=
_out=3D""
+    while [ "$i" -lt 30 ]; do
+        route_out=3D$(plat_route_=
show "$1")
+        [ -n "$route_out" ] && return 0
+        i=3D$((i + 1))=

+        sleep 1
+    done
+    return 1
+}
+
+# net_gateway is the system=
 default gateway, not the route to the peer=2E
+# Compare the gateway the p=
latform reports rather than the text of the
+# entry, which is spelled diff=
erently by every routing tool=2E
+route_assert_gateway()
+{
+    _want=3D$1=

+    _got=3D$(plat_route_gateway "$TARGET")
+
+    if [ "$_got" =3D "$_wan=
t" ]; then
+        echo "$0: net_gateway resolved to $_want as expected"
+=
        return 0
+    fi
+
+    echo "$0: expected the route via the defaul=
t gateway $_want," >&2
+    echo "     got gateway '$_got' in: $route_out=
=2E FAIL=2E" >&2
+    return 1
+}

-- 
To view, visit http://gerrit=2Eopenv=
pn=2Enet/c/openvpn/+/1949?usp=3Demail
To unsubscribe, or for help writing m=
ail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
G=
errit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
Gerrit-Change-Nu=
mber: 1949
Gerrit-PatchSet: 2
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=
=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: chugly <charlie=2Evi=
gue@openvpn=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--hZoJgWBC+No=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: chugly, flichtenheld, plaisthos=2E </p>
<p>chugly <st=
rong>uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"http=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail">View Change</a></p>=
<p>The following approvals got outdated and were removed:
Code-Review-1 by =
flichtenheld</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">tests: add an end-to-end test for --route gat=
eway keywords<br><br>Nothing self-contained checks that a route openvpn say=
s it installed<br>actually reached the kernel with the gateway it reported=
=2E t_client=2Esh does<br>compare routes, but it needs a t_client=2Erc and =
reachable servers, so it<br>skips for contributors and in CI=2E<br><br>Run =
a TLS loopback pair inside a throwaway network namespace, ask the<br>client=
 for a route via net_gateway, and check where it lands=2E route=2Ec<br>trac=
ks two gateways, the system default route and the route towards the<br>peer=
, and net_gateway is the former=2E The peer here is on loopback, so the<br>=
two differ and the assertion can tell them apart: resolving from the wrong<=
br>one leaves the route with no gateway and the install fails outright=2E<b=
r><br>The namespace also means the fixed loopback ports cannot collide, so =
this<br>needs none of the retry-on-address-in-use handling t_cltsrv=2Esh ha=
s=2E<br><br>The part that does not depend on how the environment is isolate=
d lives in<br>t_route_common=2Esh: starting the openvpn pair, waiting for t=
he route to<br>appear, and comparing the gateway=2E  t_route=2Esh supplies =
the three hooks<br>that do depend on the platform, running a command inside=
 the namespace and<br>the two routing table queries=2E  The comparison is a=
gainst the gateway the<br>platform reports rather than the text of the rout=
ing table entry, because<br>every routing tool spells that entry differentl=
y=2E  A front end for a<br>system without network namespaces can then reuse=
 the whole driver=2E<br><br>Both files are POSIX sh=2E  Nothing here needed=
 bash, and with a /bin/sh<br>shebang the runtime skips below can do their j=
ob on a platform without<br>bash rather than the script failing to start=2E=
<br><br>Skips rather than fails when it cannot run: not Linux, no iproute2,=
 or no<br>way to get the privileges a namespace needs=2E Containers commonl=
y disallow<br>namespace creation, so this will skip there and run on VMs an=
d bare metal=2E<br>RUN_SUDO is picked up from t_client=2Erc the same way t_=
net=2Esh does=2E<br><br>Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02=
d<br>Signed-off-by: Charlie Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<br>=
---<br>M tests/Makefile=2Eam<br>A tests/t_route=2Esh<br>A tests/t_route_com=
mon=2Esh<br>3 files changed, 200 insertions(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/49/1949/2</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/tests/Makefile=2Eam b/tests/Makefile=2Ea=
m</span><br><span>index 3907965=2E=2E5cfbf67e 100644</span><br><span>--- a/=
tests/Makefile=2Eam</span><br><span>+++ b/tests/Makefile=2Eam</span><br><sp=
an>@@ -18,7 +18,7 @@</span><br><span> SH_LOG_DRIVER =3D $(SHELL) $(top_srcd=
ir)/forked-test-driver</span><br><span> </span><br><span> if !WIN32</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-test_scripts =3D t_client=2Es=
h t_lpback=2Esh t_cltsrv=2Esh t_server_null=2Esh</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_scripts =3D t_client=2Esh t_lpback=2Esh t=
_cltsrv=2Esh t_server_null=2Esh t_route=2Esh</span><br><span> </span><br><s=
pan> check_PROGRAMS =3D ntlm_support</span><br><span> if HAVE_SITNL</span><=
br><span>@@ -35,6 +35,8 @@</span><br><span> 	t_cltsrv-down=2Esh \</span><br=
><span> 	t_lpback=2Esh \</span><br><span> 	t_net=2Esh \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	t_route=2Esh \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	t_route_common=2Esh \</span><br><span> 	=
t_server_null=2Esh \</span><br><span> 	t_server_null_client=2Esh \</span><b=
r><span> 	t_server_null_server=2Esh \</span><br><span>diff --git a/tests/t_=
route=2Esh b/tests/t_route=2Esh</span><br><span>new file mode 100755</span>=
<br><span>index 0000000=2E=2E16ac293</span><br><span>--- /dev/null</span><b=
r><span>+++ b/tests/t_route=2Esh</span><br><span>@@ -0,0 +1,129 @@</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# t_route=2Esh - check that --route installs a route whe=
re it says it will</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The special gatew=
ay keywords (net_gateway, vpn_gateway, remote_host) are</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+# resolved in route=2Ec from data gathe=
red off the system routing table=2E The</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+# unit tests cover the resolution itself; this checks t=
hat the answer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# rea=
ches the kernel=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# route=2Ec keeps t=
wo gateways: the system default route, and the route</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# towards the peer=2E net_gateway is the =
former=2E Here the peer is on</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+# loopback, so the two are necessarily different and an assertion=
 on the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# installed =
gateway tells them apart=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# This is =
the network namespace front end, so the host routing table is not</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# touched and the fixed loopb=
ack ports cannot collide with anything=2E The</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# part that drives openvpn and checks the result =
lives in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# t_route_c=
ommon=2Esh, so a front end for a platform without namespaces can</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# reuse it=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+srcdir=3D&quot;${srcdir:-=2E}&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+top_builddir=3D&quot;${top_builddir:-=
=2E=2E}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+top_sr=
cdir=3D&quot;${top_srcdir:-${srcdir}/=2E=2E}&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+openvpn=3D&quot;${openvpn:-${top_builddir}/s=
rc/openvpn/openvpn}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Namespace t=
opology: one interface carrying a default route, which is</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+# what net_gateway has to resolve to=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+NS=3D&quot;ovpnr=
oute$$&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TUN=3D&=
quot;ovpnt$$&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+L=
AN_GW=3D&quot;10=2E71=2E1=2E1&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+TARGET=3D&quot;10=2E71=2E250=2E1&quot; # what we ask to be =
routed via net_gateway</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+VPN_LOCAL=3D&quot;10=2E71=2E8=2E2&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+VPN_REMOTE=3D&quot;10=2E71=2E8=2E1&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# Namespaces and dummy interfaces are Linux-only=
=2E A front end for another</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# platform would set its own environment up and reuse t_route_commo=
n=2Esh=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot=
;$(uname -s)&quot; !=3D &quot;Linux&quot; ]; then</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    echo &quot;$0: this front end runs only o=
n Linux=2E SKIPPING TEST=2E&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    exit 77</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+if [ ! -x &quot;${openvpn}&quo=
t; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo =
&quot;$0: no (executable) openvpn binary in current build tree=2E FAIL=2E&q=
uot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+if ! command -v ip &gt;/dev/null 2&gt;&amp;1; the=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0:=
 no iproute2 &#39;ip&#39; command in \$PATH=2E SKIPPING TEST=2E&quot; &gt;&=
amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 77</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# t_client=2Erc is read only for a RUN_SUDO definition, as=
 t_net=2Esh does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if =
[ -r &quot;${top_builddir}&quot;/t_client=2Erc ]; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    =2E &quot;${top_builddir}&quot;/t_cl=
ient=2Erc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+elif [ -r =
&quot;${srcdir}&quot;/t_client=2Erc ]; then</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    =2E &quot;${srcdir}&quot;/t_client=2Erc</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+if [ &quot;$(id -u)&quot; -ne 0 ]; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; then=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        RUN_SUDO=3D=
&quot;sudo&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    RUN_SUDO=3D&quot;&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# A namespace needs the same privileges the rest of the tes=
t does, so use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# it =
as the probe=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if !=
 $RUN_SUDO ip netns add &quot;$NS&quot;; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    echo &quot;$0: cannot create a network namesp=
ace with &#39;$RUN_SUDO&#39;=2E&quot; &gt;&amp;2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    echo &quot;$0: containers commonly disallo=
w this=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    exit 77</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+srv_pid=3D&quot;&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clt_pid=3D&quot;&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logdir=3D$(mkt=
emp -d) || exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+cleanup()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    [ -n &quot;$clt_pid&quot; ] &amp;&amp; kill &=
quot;$clt_pid&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    [ -n &quot;$srv_pid&quot; ] &amp;&amp; kill &quot;$srv_pid&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    wait</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    # deleting the namespace takes ev=
ery interface and route in it with it</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    $RUN_SUDO ip netns del &quot;$NS&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    [ -n &quot;$logdir&quot; ] &am=
p;&amp; rm -rf &quot;$logdir&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return 0</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+trap clean=
up EXIT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+plat_exec()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    $RUN_SUDO ip netns exec &quot;$NS&quot; &quot;$@&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+plat_route_show()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    # absence is the expected state while polling, so the error iproute2</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    # prints for an un=
reachable address is noise rather than a diagnostic</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    plat_exec ip route show &quot;$1&quot=
; 2&gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+plat_route_gateway()</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    plat_route_show &quot;$1&quot; | sed -n &#39;s/=2E*[[=
:space:]]via[[:space:]]\([^[:space:]]*\)=2E*/\1/p&#39;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
=2E &quot;${srcdir}&quot;/t_route_common=2Esh</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+set -e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+plat_e=
xec ip link set lo up</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+plat_exec ip link add lan0 type dummy</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+plat_exec ip link set lan0 up</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+plat_exec ip addr add 10=2E71=2E1=2E2/24 dev =
lan0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+plat_exec ip ro=
ute add default via &quot;$LAN_GW&quot; dev lan0</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+set +e</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rou=
te_start_pair</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if ! route_wait_for &quot=
;$TARGET&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    echo &quot;$0: route to $TARGET was never installed=2E FAIL=2E&quot; &=
gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &=
quot;--- client log ---&quot; &gt;&amp;2</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    cat &quot;$logdir&quot;/clt=2Elog &gt;&amp;2</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 1</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+route_assert_gateway &quot;$LAN_GW&quot; || exit 1</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+exit 0</span><br><span>diff --git a/tests/t_route_common=
=2Esh b/tests/t_route_common=2Esh</span><br><span>new file mode 100755</spa=
n><br><span>index 0000000=2E=2E3a1fdd0</span><br><span>--- /dev/null</span>=
<br><span>+++ b/tests/t_route_common=2Esh</span><br><span>@@ -0,0 +1,68 @@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# t_route_common=2Esh - platform-independent par=
t of the --route gateway test</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Source=
d by a front end that supplies the environment the test runs in and</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# the routing-table queries=
 for the platform:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   plat_exec CMD=
=2E=2E=2E          run CMD inside the test environment</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#   plat_route_show ADDR      print the =
routing table entry for ADDR, if any</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#   plat_route_gateway ADDR   print just the gateway of th=
at entry, if any</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# The front end also =
sets openvpn, top_srcdir, logdir, TUN, TARGET,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# VPN_LOCAL and VPN_REMOTE before sourcing this =
file=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# Nothing here knows how the e=
nvironment is isolated or which tools report</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# the routing table, so a front end for a platform=
 without network</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# n=
amespaces can reuse all of it=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# A TL=
S loopback pair, as t_cltsrv=2Esh uses=2E Options after --config override</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# the config file, wh=
ich is how the client gets a tun and a route=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+route_start_pair()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    plat_exec &quot;${openvpn}&quot; --cd &quot;${top_srcdir}/samp=
le&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        -=
-config sample-config-files/loopback-server \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        --verb 3 --ping-exit 60 &gt;&quot;$logdir=
&quot;/srv=2Elog 2&gt;&amp;1 &amp;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    srv_pid=3D$!</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pla=
t_exec &quot;${openvpn}&quot; --cd &quot;${top_srcdir}/sample&quot; \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        --config sample-c=
onfig-files/loopback-client \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        --dev &quot;$TUN&quot; --dev-type tun \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        --ifconfig &quot;$VPN_LOCAL&q=
uot; &quot;$VPN_REMOTE&quot; \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        --route &quot;$TARGET&quot; 255=2E255=2E255=2E255 net_ga=
teway \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --ve=
rb 4 --ping-exit 60 &gt;&quot;$logdir&quot;/clt=2Elog 2&gt;&amp;1 &amp;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    clt_pid=3D$!</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# Wait for the route to show up rather than guessing at a sleep=
=2E  Sets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# route_ou=
t to the entry that appeared=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+route_wait_for()</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=3D0=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_out=3D&qu=
ot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while =
[ &quot;$i&quot; -lt 30 ]; do</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        route_out=3D$(plat_route_show &quot;$1&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        [ -n &quot;$route_out&q=
uot; ] &amp;&amp; return 0</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        i=3D$((i + 1))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        sleep 1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    done</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# net_gateway is the system default gateway, not =
the route to the peer=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+# Compare the gateway the platform reports rather than the text of the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# entry, which is s=
pelled differently by every routing tool=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+route_assert_gateway()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    _want=3D$1</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    _got=3D$(plat_route_gateway &quot;$TARGET&quot;)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if [ &quot;$_got&quot; =3D &quot;$_want&quot; ]; then=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;=
$0: net_gateway resolved to $_want as expected&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return 0</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   echo &quot;$0: expected the route via the default gateway $_want,&quot; =
&gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo =
&quot;     got gateway &#39;$_got&#39; in: $route_out=2E FAIL=2E&quot; &gt;=
&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?u=
sp=3Demail">change 1949</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1949?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset =
</div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div sty=
le=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:non=
e"> Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d </div>
<div=
 style=3D"display:none"> Gerrit-Change-Number: 1949 </div>
<div style=3D"di=
splay:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-=
Owner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: chugly &lt;charlie=2Evigue@openvpn=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></htm=
l>
--hZoJgWBC+No=--


--===============8406213807836305247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8406213807836305247==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8406213807836305247==--

