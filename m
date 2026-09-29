Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF8CCA5FA1
	for <openvpn-devel@archiver.kernel.org>; Tue, 29 Sep 2026 01:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Y10WuuPTXR1r2zaTNn4Dv0l0CqRo6JpTOm1R6GhbyQ=; b=hVQSWNP89OWs99N8oauttxPGhA
	7//67Woc0mSOXXYFGWK3y/rn57e/Jv6KbCPgGeDGDBLKg4+9/zwqpWC+9aO8I+0Pl6Oo/W00gHOnY
	6pjXp432qJokqH1gwPw5Q7tSBt5ebkVQD6f1pWQHsgOk36FhNeSQhWzrpvj+jXZ4L8Aw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBN6a-00069y-GQ;
	Tue, 29 Sep 2026 01:58:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBN6Z-00069j-HD
 for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 01:58:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=biMWXyW93hCHLch8cFpVd6+0NGvbpxUnW8AQf4sSNbg=; b=VEDbBZczNSI496vvF0lGktc+ih
 EoSf181kbU4pfatBCrjc3MNf6LoF/ZOGjXX13cBJibRdVwQNczUN9kaPSWM+U5xog3iCd/ynSt3w4
 s4fKEoE4k17va5Pf98Q+qCovh37AkjBHW4JUTAb6rrBelP06HrDRoh2lkyRv79T73XNQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=biMWXyW93hCHLch8cFpVd6+0NGvbpxUnW8AQf4sSNbg=; b=Y
 tSMFkjnySKho55E9O9TgpI5nZQ/dkWGKt7Jy4MmHKCfVmhRtE4ACNcGOeE8fbWCrOnFEN7n1DovnC
 bpaApO4Dgg/3WtJEb/DbrWU2Wkn9W1zafSa9g1hEbgV27k/X/+ysM0ihOr58XDhtxrogT8a3eKAKz
 2/3/eqIzLGjbRkb0=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBN6U-00039G-FS for openvpn-devel@lists.sourceforge.net;
 Tue, 29 Sep 2026 01:58:00 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-486e1a044c5so3056416f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 18:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790647072; x=1791251872; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=biMWXyW93hCHLch8cFpVd6+0NGvbpxUnW8AQf4sSNbg=;
 b=eKFS/vVbGS+kOroOpYRw3LfAHEkq8sFWXk2x5tuTnQvXQFYUwTuvf6f/sGWCZ6HvKM
 AYLNG40kplBsEd8ybuOJ38QgoCwnXBnIZCGAkxkopfUq7CaqqwvSHqTB2T5laUr1fmr6
 zQb+9pnBIB9hY1dYz4VG2XFpn963Gy5mZFAZr4WDp1wNZMsWUacglWG5ENQq/VZFO6cC
 O51AA610Y2mYjX7cOIR1OOweV2q+5bCSjrNKdoUA4H7RwXei+3lyPBVELxHnl9WiLuDI
 U7aBPuT06Tasq8v2ZGvWItExLEcgrVrbGyTOzu3DGwe6uy/HZEccVNuVBkLkvS6tY2uy
 2z6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790647072; x=1791251872;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=biMWXyW93hCHLch8cFpVd6+0NGvbpxUnW8AQf4sSNbg=;
 b=V1p+7jNiMJgdtW1XrS0IMvzRu8cZJq6szZQ6VQS8DrG8qx8aCzNhe4jW6q0hmULUKQ
 D+OfQ4VbEEC46kQM/Er/4SPL7tSTikaZmOGLSM5Xnfk9ED5M8h79CydyuI48GrWkb6Gy
 o8o528r2OAORYXO2vsEnb7vTMlbg2WJ2kwyj3B8qz4oHZ1Hb2Q8BgrIuRp2g9bVGhLZj
 ZHKuD5+7tNs6uP41yZ5UcFoc0/U7LXdKmczzFHjBt7RQOozFv/uqbE3hLsw+RcBguQxW
 dJ43iWxOg9Y7prmpWrlfOLqmu4pWqu5TtH7U2I0Lnobk4J22JrsynlIb5Mtba+TFF4Hq
 WLlw==
X-Gm-Message-State: AFq9FYK+RbUUXEhJ/sjcCjOhLTD0uctxrDpTp+ciVhC+E9jBb3SZLcHX
 51phx9xlIKeiViUQ7uSE+YU7GUrks2qX1O90/4Q3kx00NzUMKo7h9FSZSobsvkjasGNHSAWllMi
 HzWEIOKpg6eMyyUJxB9JhG02Jy3uLt6gPAo1zCHBGY/ArIAzI+QoKH29uTPXxE5RHwGd+r+7Roa
 ULLYnXxA==
X-Gm-Gg: AYBFou0F/pD09aof3kgYtRrX0iwUdhHMHjO62iz8TaRYJApEhEX75GTRX09XrPkPimf
 RlaDkPeYaDTKoPZFllIJ+8ZomUlaaJV5VTc/TuE9RJsONZhkmP8YDxyHnYOkHUdAM3sbPqkXgUQ
 3f+SxHW2V4lAGa0vSg/T4ndWEaEQLTK0LaerlquoDs2VkisW+X+SfdrIGUKBVhZkAZTNydV1+XI
 d8qqxRLsAbOpPCTskU97YsG/vVjAe9TjI1U5rXYW6cJM+XpA6pyP+5XfL1y6WDi+Tjsv+VgYgcX
 8dAaxTd2d80tsiV8H4sHwjjZULCdFmpBL0i5I31Q/s9dz06aeIbO1RXVBla35QpO6V2iuhgvEV+
 4ixPM0ErlEI1ACds8pyvrd/YPd75hiVzMGqghmtRkG2KBjtZ2cPv5bQEzA1JjOa1W51mXoUi0AM
 THcjCJ9yCgw0P/cMq6eLPdi1AopOaMdQu92sUJ2UdnPy00ONCzsHGcttrivi5wdHhOIMRhr/d8o
 RlFfhWZF56WnRjy8+3jEkdupChEEofBszL8DFgjjGsIOco32rALEaRTem4ZtJVo74ehT4aL3VB7
 07tyzwDqqUfcIjewr2NZ0HTve9D2qPw0bsSAw4K8NE8V6UA3t50m5KsA3CR78Q==
X-Received: by 2002:a05:6000:420d:b0:487:14b6:b1be with SMTP id
 ffacd0b85a97d-4887172e3ffmr29639382f8f.25.1790647071675; 
 Mon, 28 Sep 2026 18:57:51 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af1e2929bsm2699771f8f.14.2026.09.28.18.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 18:57:50 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 29 Sep 2026 01:57:48 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
X-Gerrit-Change-Number: 1949
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1949?usp=email>
X-Gerrit-Commit: 1d4de58aa6dd1e086e4bf715e30fbfc9feb5c723
In-Reply-To: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
References: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzA2NzE5MDAwLkkyZThmMTQ0OWZlNTRlN2Y2MjhlMmJkYjA0MmVlMmE1NjdmMjVlMDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <1424533e0966d115e3e293260868dc806a49a241-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBN6U-00039G-FS
Subject: [Openvpn-devel] [L] Change in openvpn[master]: tests: add an
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
Content-Type: multipart/mixed; boundary="===============2321284001361951275=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2321284001361951275==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uiDNie/52zI="; charset=UTF-8

--uiDNie/52zI=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos=2E

Hello fli=
chtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please visit
=

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail

to look at=
 the new patch set (#3)=2E


Change subject: tests: add an end-to-end test =
for --route gateway keywords
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E

tests: add an end-to-end test for --route gateway keywords=


Nothing self-contained checks that a route openvpn says it installed
actu=
ally reached the kernel with the gateway it reported=2E t_client=2Esh does
=
compare routes, but it needs a t_client=2Erc and reachable servers, so it
s=
kips for contributors and in CI=2E

Run a TLS loopback pair inside a throwa=
way network namespace, ask the
client for a route via net_gateway, and chec=
k where it lands=2E route=2Ec
tracks two gateways, the system default route=
 and the route towards the
peer, and net_gateway is the former=2E The peer =
here is on loopback, so the
two differ and the assertion can tell them apar=
t: resolving from the wrong
one leaves the route with no gateway and the in=
stall fails outright=2E

The namespace also means the fixed loopback ports =
cannot collide, so this
needs none of the retry-on-address-in-use handling =
t_cltsrv=2Esh has=2E

The part that does not depend on how the environment =
is isolated lives in
t_route_common=2Esh: starting the openvpn pair, waitin=
g for the tunnel and
then the route, and comparing the gateway=2E  t_route=
=2Esh supplies the hooks
that do depend on the platform, running a command =
inside the namespace and
the routing table queries=2E  The comparison is ag=
ainst the gateway the
platform reports rather than the text of the routing =
table entry, because
every routing tool spells that entry differently=2E  A=
 front end for a
system without network namespaces can then reuse the whole=
 driver=2E

Nothing can be concluded about a route until the tunnel carryin=
g it
exists, so the tun device is waited for separately and /dev/net/tun is=

checked up front=2E  An environment that cannot open a tunnel skips; only =
a
tunnel that comes up without the route, or with the wrong gateway, is a
f=
ailure=2E  Both paths print the client and server logs together with the
ad=
dresses and routes, so a failing run says why=2E

Both files are POSIX sh=
=2E  Nothing here needed bash, and with a /bin/sh
shebang the runtime skips=
 below can do their job on a platform without
bash rather than the script f=
ailing to start=2E

Skips rather than fails when it cannot run: not Linux, =
no iproute2, no
tun device, or no way to get the privileges a namespace nee=
ds=2E Containers
commonly disallow namespace creation, so this will skip th=
ere and run on
VMs and bare metal=2E RUN_SUDO is picked up from t_client=2E=
rc the same way
t_net=2Esh does=2E

Change-Id: I2e8f1449fe54e7f628e2bdb042e=
e2a567f25e02d
Signed-off-by: Charlie Vigue <charlie=2Evigue@openvpn=2Ecom>
=
---
M tests/Makefile=2Eam
A tests/t_route=2Esh
A tests/t_route_common=2Esh
=
3 files changed, 261 insertions(+), 1 deletion(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1949/3

diff --git a/tests/M=
akefile=2Eam b/tests/Makefile=2Eam
index 3907965=2E=2E5cfbf67e 100644
--- a=
/tests/Makefile=2Eam
+++ b/tests/Makefile=2Eam
@@ -18,7 +18,7 @@
 SH_LOG_DR=
IVER =3D $(SHELL) $(top_srcdir)/forked-test-driver
 
 if !WIN32
-test_scrip=
ts =3D t_client=2Esh t_lpback=2Esh t_cltsrv=2Esh t_server_null=2Esh
+test_s=
cripts =3D t_client=2Esh t_lpback=2Esh t_cltsrv=2Esh t_server_null=2Esh t_r=
oute=2Esh
 
 check_PROGRAMS =3D ntlm_support
 if HAVE_SITNL
@@ -35,6 +35,8 =
@@
 	t_cltsrv-down=2Esh \
 	t_lpback=2Esh \
 	t_net=2Esh \
+	t_route=2Esh \=

+	t_route_common=2Esh \
 	t_server_null=2Esh \
 	t_server_null_client=2Esh=
 \
 	t_server_null_server=2Esh \
diff --git a/tests/t_route=2Esh b/tests/t_=
route=2Esh
new file mode 100755
index 0000000=2E=2Edcab81d
--- /dev/null
++=
+ b/tests/t_route=2Esh
@@ -0,0 +1,161 @@
+#!/bin/sh
+#
+# t_route=2Esh - ch=
eck that --route installs a route where it says it will
+#
+# The special g=
ateway keywords (net_gateway, vpn_gateway, remote_host) are
+# resolved in =
route=2Ec from data gathered off the system routing table=2E The
+# unit te=
sts cover the resolution itself; this checks that the answer
+# reaches the=
 kernel=2E
+#
+# route=2Ec keeps two gateways: the system default route, an=
d the route
+# towards the peer=2E net_gateway is the former=2E Here the pe=
er is on
+# loopback, so the two are necessarily different and an assertion=
 on the
+# installed gateway tells them apart=2E
+#
+# This is the network =
namespace front end, so the host routing table is not
+# touched and the fi=
xed loopback ports cannot collide with anything=2E The
+# part that drives =
openvpn and checks the result lives in
+# t_route_common=2Esh, so a front e=
nd for a platform without namespaces can
+# reuse it=2E
+
+srcdir=3D"${srcd=
ir:-=2E}"
+top_builddir=3D"${top_builddir:-=2E=2E}"
+top_srcdir=3D"${top_sr=
cdir:-${srcdir}/=2E=2E}"
+openvpn=3D"${openvpn:-${top_builddir}/src/openvpn=
/openvpn}"
+
+# Namespace topology: one interface carrying a default route,=
 which is
+# what net_gateway has to resolve to=2E
+NS=3D"ovpnroute$$"
+TUN=
=3D"ovpnt$$"
+LAN_GW=3D"10=2E71=2E1=2E1"
+TARGET=3D"10=2E71=2E250=2E1" # wh=
at we ask to be routed via net_gateway
+VPN_LOCAL=3D"10=2E71=2E8=2E2"
+VPN_=
REMOTE=3D"10=2E71=2E8=2E1"
+
+# Namespaces and dummy interfaces are Linux-o=
nly=2E A front end for another
+# platform would set its own environment up=
 and reuse t_route_common=2Esh=2E
+if [ "$(uname -s)" !=3D "Linux" ]; then
=
+    echo "$0: this front end runs only on Linux=2E SKIPPING TEST=2E"
+    =
exit 77
+fi
+
+if [ ! -x "${openvpn}" ]; then
+    echo "$0: no (executable=
) openvpn binary in current build tree=2E FAIL=2E" >&2
+    exit 1
+fi
+
+i=
f ! command -v ip >/dev/null 2>&1; then
+    echo "$0: no iproute2 'ip' com=
mand in \$PATH=2E SKIPPING TEST=2E" >&2
+    exit 77
+fi
+
+# /dev is not n=
amespaced, so this is the same device the client will open=2E
+if [ ! -c /d=
ev/net/tun ]; then
+    echo "$0: no /dev/net/tun, cannot open a tunnel=2E =
SKIPPING TEST=2E" >&2
+    exit 77
+fi
+
+# t_client=2Erc is read only for =
a RUN_SUDO definition, as t_net=2Esh does
+if [ -r "${top_builddir}"/t_clie=
nt=2Erc ]; then
+    =2E "${top_builddir}"/t_client=2Erc
+elif [ -r "${srcd=
ir}"/t_client=2Erc ]; then
+    =2E "${srcdir}"/t_client=2Erc
+fi
+
+if [ "=
$(id -u)" -ne 0 ]; then
+    if [ -z "$RUN_SUDO" ]; then
+        RUN_SUDO=
=3D"sudo"
+    fi
+else
+    RUN_SUDO=3D""
+fi
+
+# A namespace needs the s=
ame privileges the rest of the test does, so use
+# it as the probe=2E
+if =
! $RUN_SUDO ip netns add "$NS"; then
+    echo "$0: cannot create a network=
 namespace with '$RUN_SUDO'=2E" >&2
+    echo "$0: containers commonly disa=
llow this=2E SKIPPING TEST=2E" >&2
+    exit 77
+fi
+
+srv_pid=3D""
+clt_pi=
d=3D""
+logdir=3D$(mktemp -d) || exit 1
+
+cleanup()
+{
+    # kill -0 is a=
 liveness probe, not an action: its failure is the answer
+    # rather tha=
n an error worth printing=2E The kill itself stays unguarded=2E
+    [ -n "=
$clt_pid" ] && kill -0 "$clt_pid" 2>/dev/null && kill "$clt_pid"
+    [ -n =
"$srv_pid" ] && kill -0 "$srv_pid" 2>/dev/null && kill "$srv_pid"
+    wait=

+    # deleting the namespace takes every interface and route in it with i=
t
+    $RUN_SUDO ip netns del "$NS"
+    [ -n "$logdir" ] && rm -rf "$logdi=
r"
+    return 0
+}
+trap cleanup EXIT
+
+plat_exec()
+{
+    $RUN_SUDO ip =
netns exec "$NS" "$@"
+}
+
+plat_have_tun()
+{
+    plat_exec ip link show =
"$1" >/dev/null 2>&1
+}
+
+plat_dump_state()
+{
+    plat_exec ip -o addr s=
how
+    plat_exec ip route show
+}
+
+plat_route_show()
+{
+    # absence =
is the expected state while polling, so the error iproute2
+    # prints fo=
r an unreachable address is noise rather than a diagnostic
+    plat_exec i=
p route show "$1" 2>/dev/null
+}
+
+plat_route_gateway()
+{
+    plat_route=
_show "$1" | sed -n 's/=2E*[[:space:]]via[[:space:]]\([^[:space:]]*\)=2E*/\=
1/p'
+}
+
+=2E "${srcdir}"/t_route_common=2Esh
+
+set -e
+plat_exec ip link=
 set lo up
+plat_exec ip link add lan0 type dummy
+plat_exec ip link set la=
n0 up
+plat_exec ip addr add 10=2E71=2E1=2E2/24 dev lan0
+plat_exec ip rout=
e add default via "$LAN_GW" dev lan0
+set +e
+
+route_start_pair
+
+# A tun=
nel that never comes up means this environment cannot run the test,
+# whic=
h is a skip=2E Only once it is up does the routing assertion mean
+# anythi=
ng, and a failure from there on is a real one=2E
+if ! route_wait_tun "$TUN=
"; then
+    echo "$0: tunnel device $TUN never appeared=2E" >&2
+    route=
_dump_diag
+    echo "$0: cannot establish a tunnel here=2E SKIPPING TEST=
=2E" >&2
+    exit 77
+fi
+
+if ! route_wait_for "$TARGET"; then
+    echo =
"$0: $TUN is up but the route to $TARGET was never installed=2E" >&2
+    r=
oute_dump_diag
+    echo "$0: FAIL=2E" >&2
+    exit 1
+fi
+
+if ! route_as=
sert_gateway "$LAN_GW"; then
+    route_dump_diag
+    exit 1
+fi
+
+exit 0=

diff --git a/tests/t_route_common=2Esh b/tests/t_route_common=2Esh
new fil=
e mode 100755
index 0000000=2E=2E19c92ae
--- /dev/null
+++ b/tests/t_route_=
common=2Esh
@@ -0,0 +1,97 @@
+#!/bin/sh
+#
+# t_route_common=2Esh - platfor=
m-independent part of the --route gateway test
+#
+# Sourced by a front end=
 that supplies the environment the test runs in and
+# the routing-table qu=
eries for the platform:
+#
+#   plat_exec CMD=2E=2E=2E          run CMD ins=
ide the test environment
+#   plat_have_tun IFACE       succeed if IFACE ex=
ists in that environment
+#   plat_route_show ADDR      print the routing t=
able entry for ADDR, if any
+#   plat_route_gateway ADDR   print just the g=
ateway of that entry, if any
+#   plat_dump_state           print addresses=
 and routes, for diagnostics
+#
+# The front end also sets openvpn, top_src=
dir, logdir, TUN, TARGET,
+# VPN_LOCAL and VPN_REMOTE before sourcing this =
file=2E
+#
+# Nothing here knows how the environment is isolated or which t=
ools report
+# the routing table, so a front end for a platform without net=
work
+# namespaces can reuse all of it=2E
+
+# A TLS loopback pair, as t_cl=
tsrv=2Esh uses=2E Options after --config override
+# the config file, which=
 is how the client gets a tun and a route=2E
+route_start_pair()
+{
+    pl=
at_exec "${openvpn}" --cd "${top_srcdir}/sample" \
+        --config sample=
-config-files/loopback-server \
+        --verb 3 --ping-exit 60 >"$logdir"=
/srv=2Elog 2>&1 &
+    srv_pid=3D$!
+
+    plat_exec "${openvpn}" --cd "${t=
op_srcdir}/sample" \
+        --config sample-config-files/loopback-client =
\
+        --dev "$TUN" --dev-type tun \
+        --ifconfig "$VPN_LOCAL" "=
$VPN_REMOTE" \
+        --route "$TARGET" 255=2E255=2E255=2E255 net_gateway=
 \
+        --verb 4 --ping-exit 60 >"$logdir"/clt=2Elog 2>&1 &
+    clt_pi=
d=3D$!
+}
+
+# Wait for the tunnel itself=2E  Nothing can be concluded abou=
t routes until
+# the tun interface exists, so this is checked separately: =
an environment
+# that cannot open a tunnel is a skip, whereas a tunnel tha=
t is up without
+# the route is a real failure=2E  Gives up early if the cl=
ient has died=2E
+route_wait_tun()
+{
+    i=3D0
+    while [ "$i" -lt 60 ]=
; do
+        plat_have_tun "$1" && return 0
+        kill -0 "$clt_pid" 2>=
/dev/null || return 1
+        i=3D$((i + 1))
+        sleep 1
+    done
+ =
   return 1
+}
+
+# Everything a failing run needs, printed to stderr so it=
 reaches the CI log=2E
+route_dump_diag()
+{
+    echo "--- client log ---"=
 >&2
+    cat "$logdir"/clt=2Elog >&2 2>/dev/null
+    echo "--- server log=
 ---" >&2
+    cat "$logdir"/srv=2Elog >&2 2>/dev/null
+    echo "--- addre=
sses and routes ---" >&2
+    plat_dump_state >&2 2>/dev/null
+}
+
+# Wait =
for the route to show up rather than guessing at a sleep=2E  Sets
+# route_=
out to the entry that appeared=2E
+route_wait_for()
+{
+    i=3D0
+    rout=
e_out=3D""
+    while [ "$i" -lt 30 ]; do
+        route_out=3D$(plat_route=
_show "$1")
+        [ -n "$route_out" ] && return 0
+        i=3D$((i + 1)=
)
+        sleep 1
+    done
+    return 1
+}
+
+# net_gateway is the syste=
m default gateway, not the route to the peer=2E
+# Compare the gateway the =
platform reports rather than the text of the
+# entry, which is spelled dif=
ferently by every routing tool=2E
+route_assert_gateway()
+{
+    _want=3D$=
1
+    _got=3D$(plat_route_gateway "$TARGET")
+
+    if [ "$_got" =3D "$_wa=
nt" ]; then
+        echo "$0: net_gateway resolved to $_want as expected"
=
+        return 0
+    fi
+
+    echo "$0: expected the route via the defau=
lt gateway $_want," >&2
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
Gerrit-PatchSet: 3
Gerrit-Owner: chugly <charlie=2Evigue@openvpn=
=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revi=
ewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <open=
vpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichtenheld=2Ecom>=


--uiDNie/52zI=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos=2E </p>
<p>chugly <strong>upl=
oaded patch set #3</strong> to this change=2E</p><p><a href=3D"http://gerri=
t=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail">View Change</a></p><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">tests: add an end-to-end test for --route gateway keywords<br><br>Not=
hing self-contained checks that a route openvpn says it installed<br>actual=
ly reached the kernel with the gateway it reported=2E t_client=2Esh does<br=
>compare routes, but it needs a t_client=2Erc and reachable servers, so it<=
br>skips for contributors and in CI=2E<br><br>Run a TLS loopback pair insid=
e a throwaway network namespace, ask the<br>client for a route via net_gate=
way, and check where it lands=2E route=2Ec<br>tracks two gateways, the syst=
em default route and the route towards the<br>peer, and net_gateway is the =
former=2E The peer here is on loopback, so the<br>two differ and the assert=
ion can tell them apart: resolving from the wrong<br>one leaves the route w=
ith no gateway and the install fails outright=2E<br><br>The namespace also =
means the fixed loopback ports cannot collide, so this<br>needs none of the=
 retry-on-address-in-use handling t_cltsrv=2Esh has=2E<br><br>The part that=
 does not depend on how the environment is isolated lives in<br>t_route_com=
mon=2Esh: starting the openvpn pair, waiting for the tunnel and<br>then the=
 route, and comparing the gateway=2E  t_route=2Esh supplies the hooks<br>th=
at do depend on the platform, running a command inside the namespace and<br=
>the routing table queries=2E  The comparison is against the gateway the<br=
>platform reports rather than the text of the routing table entry, because<=
br>every routing tool spells that entry differently=2E  A front end for a<b=
r>system without network namespaces can then reuse the whole driver=2E<br><=
br>Nothing can be concluded about a route until the tunnel carrying it<br>e=
xists, so the tun device is waited for separately and /dev/net/tun is<br>ch=
ecked up front=2E  An environment that cannot open a tunnel skips; only a<b=
r>tunnel that comes up without the route, or with the wrong gateway, is a<b=
r>failure=2E  Both paths print the client and server logs together with the=
<br>addresses and routes, so a failing run says why=2E<br><br>Both files ar=
e POSIX sh=2E  Nothing here needed bash, and with a /bin/sh<br>shebang the =
runtime skips below can do their job on a platform without<br>bash rather t=
han the script failing to start=2E<br><br>Skips rather than fails when it c=
annot run: not Linux, no iproute2, no<br>tun device, or no way to get the p=
rivileges a namespace needs=2E Containers<br>commonly disallow namespace cr=
eation, so this will skip there and run on<br>VMs and bare metal=2E RUN_SUD=
O is picked up from t_client=2Erc the same way<br>t_net=2Esh does=2E<br><br=
>Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d<br>Signed-off-by: Cha=
rlie Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<br>---<br>M tests/Makefile=
=2Eam<br>A tests/t_route=2Esh<br>A tests/t_route_common=2Esh<br>3 files cha=
nged, 261 insertions(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1949/3</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/tests/Makefile=2Eam b/tests/Makefile=2Eam</span><br><span>index=
 3907965=2E=2E5cfbf67e 100644</span><br><span>--- a/tests/Makefile=2Eam</sp=
an><br><span>+++ b/tests/Makefile=2Eam</span><br><span>@@ -18,7 +18,7 @@</s=
pan><br><span> SH_LOG_DRIVER =3D $(SHELL) $(top_srcdir)/forked-test-driver<=
/span><br><span> </span><br><span> if !WIN32</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-test_scripts =3D t_client=2Esh t_lpback=2Esh t_cltsr=
v=2Esh t_server_null=2Esh</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_scripts =3D t_client=2Esh t_lpback=2Esh t_cltsrv=2Esh t_server_n=
ull=2Esh t_route=2Esh</span><br><span> </span><br><span> check_PROGRAMS =3D=
 ntlm_support</span><br><span> if HAVE_SITNL</span><br><span>@@ -35,6 +35,8=
 @@</span><br><span> 	t_cltsrv-down=2Esh \</span><br><span> 	t_lpback=2Esh =
\</span><br><span> 	t_net=2Esh \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	t_route=2Esh \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	t_route_common=2Esh \</span><br><span> 	t_server_null=2Esh \</spa=
n><br><span> 	t_server_null_client=2Esh \</span><br><span> 	t_server_null_s=
erver=2Esh \</span><br><span>diff --git a/tests/t_route=2Esh b/tests/t_rout=
e=2Esh</span><br><span>new file mode 100755</span><br><span>index 0000000=
=2E=2Edcab81d</span><br><span>--- /dev/null</span><br><span>+++ b/tests/t_r=
oute=2Esh</span><br><span>@@ -0,0 +1,161 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# t_=
route=2Esh - check that --route installs a route where it says it will</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# The special gateway keywords (net_gatew=
ay, vpn_gateway, remote_host) are</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# resolved in route=2Ec from data gathered off the system rou=
ting table=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
unit tests cover the resolution itself; this checks that the answer</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# reaches the kernel=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# route=2Ec keeps two gateways: the syste=
m default route, and the route</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# towards the peer=2E net_gateway is the former=2E Here the peer=
 is on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# loopback, s=
o the two are necessarily different and an assertion on the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+# installed gateway tells them apar=
t=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# This is the network namespace f=
ront end, so the host routing table is not</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# touched and the fixed loopback ports cannot collid=
e with anything=2E The</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# part that drives openvpn and checks the result lives in</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# t_route_common=2Esh, so a front =
end for a platform without namespaces can</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+# reuse it=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+src=
dir=3D&quot;${srcdir:-=2E}&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+top_builddir=3D&quot;${top_builddir:-=2E=2E}&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+top_srcdir=3D&quot;${top_srcdir=
:-${srcdir}/=2E=2E}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+openvpn=3D&quot;${openvpn:-${top_builddir}/src/openvpn/openvpn}&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# Namespace topology: one interface ca=
rrying a default route, which is</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# what net_gateway has to resolve to=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+NS=3D&quot;ovpnroute$$&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+TUN=3D&quot;ovpnt$$&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+LAN_GW=3D&quot;10=2E71=2E1=
=2E1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TARGET=3D=
&quot;10=2E71=2E250=2E1&quot; # what we ask to be routed via net_gateway</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+VPN_LOCAL=3D&quot;10=
=2E71=2E8=2E2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
VPN_REMOTE=3D&quot;10=2E71=2E8=2E1&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# Namespaces and dummy interfaces are Linux-only=2E A front end for anoth=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# platform would =
set its own environment up and reuse t_route_common=2Esh=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$(uname -s)&quot; !=3D &=
quot;Linux&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    echo &quot;$0: this front end runs only on Linux=2E SKIPPING TEST=
=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 7=
7</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+if [ ! -x &quot;${openvpn}&quot; ]; then</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0: no (executable=
) openvpn binary in current build tree=2E FAIL=2E&quot; &gt;&amp;2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    exit 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+if ! command -v ip &gt;/dev/null 2&gt;&amp;1; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0: no iproute2 &#39;ip&#3=
9; command in \$PATH=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    exit 77</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# /dev=
 is not namespaced, so this is the same device the client will open=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ ! -c /dev/net/tun ]=
; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quo=
t;$0: no /dev/net/tun, cannot open a tunnel=2E SKIPPING TEST=2E&quot; &gt;&=
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
r: hsl(120, 100%, 40%);">+    # kill -0 is a liveness probe, not an action:=
 its failure is the answer</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    # rather than an error worth printing=2E The kill itself stays u=
nguarded=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    [ -n=
 &quot;$clt_pid&quot; ] &amp;&amp; kill -0 &quot;$clt_pid&quot; 2&gt;/dev/n=
ull &amp;&amp; kill &quot;$clt_pid&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    [ -n &quot;$srv_pid&quot; ] &amp;&amp; kill -0 &qu=
ot;$srv_pid&quot; 2&gt;/dev/null &amp;&amp; kill &quot;$srv_pid&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    wait</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    # deleting the namespace takes e=
very interface and route in it with it</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    $RUN_SUDO ip netns del &quot;$NS&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    [ -n &quot;$logdir&quot; ] &a=
mp;&amp; rm -rf &quot;$logdir&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return 0</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+trap clea=
nup EXIT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+plat_exec()</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    $RUN_SUDO ip netns exec &quot;$NS&quot; &quot;$@&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+plat_have_tun()</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   plat_exec ip link show &quot;$1&quot; &gt;/dev/null 2&gt;&amp;1</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+plat_dump_state()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    plat_e=
xec ip -o addr show</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    plat_exec ip route show</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+plat_route_show()</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    # absence is the expected state while polling=
, so the error iproute2</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    # prints for an unreachable address is noise rather than a diagnost=
ic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    plat_exec ip =
route show &quot;$1&quot; 2&gt;/dev/null</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+plat_route_gatew=
ay()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    plat_route_show &quot;$1&quot=
; | sed -n &#39;s/=2E*[[:space:]]via[[:space:]]\([^[:space:]]*\)=2E*/\1/p&#=
39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+=2E &quot;${srcdir}&quot;/t_route_common=2Esh</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+set -e</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+plat_exec ip link set lo up</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+plat_exec ip link add lan0 type dummy</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+plat_exec ip link set lan0 up</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+plat_exec ip addr add 1=
0=2E71=2E1=2E2/24 dev lan0</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+plat_exec ip route add default via &quot;$LAN_GW&quot; dev lan0</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+set +e</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+route_start_pair</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# A=
 tunnel that never comes up means this environment cannot run the test,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+# which is a skip=2E On=
ly once it is up does the routing assertion mean</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# anything, and a failure from there on is a r=
eal one=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if ! rout=
e_wait_tun &quot;$TUN&quot;; then</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    echo &quot;$0: tunnel device $TUN never appeared=2E&quot;=
 &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rout=
e_dump_diag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo=
 &quot;$0: cannot establish a tunnel here=2E SKIPPING TEST=2E&quot; &gt;&am=
p;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 77</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+if ! route_wait_for &quot;$TARGET&quot;; then</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0: $TUN is up but =
the route to $TARGET was never installed=2E&quot; &gt;&amp;2</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    route_dump_diag</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0: FAIL=2E&quot; &=
gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 1=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+if ! route_assert_gateway &quot;$LAN_GW&quot;; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_dump_diag</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 1</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+exit 0</span><br><span>diff --git a/tests/t_route_common=2Esh b/test=
s/t_route_common=2Esh</span><br><span>new file mode 100755</span><br><span>=
index 0000000=2E=2E19c92ae</span><br><span>--- /dev/null</span><br><span>++=
+ b/tests/t_route_common=2Esh</span><br><span>@@ -0,0 +1,97 @@</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#!/bin/sh</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# t_route_common=2Esh - platform-independent part of the --=
route gateway test</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Sourced by a fron=
t end that supplies the environment the test runs in and</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# the routing-table queries for the pl=
atform:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#   plat_exec CMD=2E=2E=2E    =
      run CMD inside the test environment</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#   plat_have_tun IFACE       succeed if IFACE exists=
 in that environment</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#   plat_route_show ADDR      print the routing table entry for ADDR, if a=
ny</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#   plat_route_ga=
teway ADDR   print just the gateway of that entry, if any</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#   plat_dump_state           print a=
ddresses and routes, for diagnostics</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 The front end also sets openvpn, top_srcdir, logdir, TUN, TARGET,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# VPN_LOCAL and VPN_REMOTE b=
efore sourcing this file=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Nothing =
here knows how the environment is isolated or which tools report</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# the routing table, so a fron=
t end for a platform without network</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# namespaces can reuse all of it=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# A TLS loopback pair, as t_cltsrv=2Esh uses=2E Options afte=
r --config override</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# the config file, which is how the client gets a tun and a route=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+route_start_pair()</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    plat_exec &quot;${openvpn}&quot; --cd &qu=
ot;${top_srcdir}/sample&quot; \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        --config sample-config-files/loopback-server \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        --verb 3 --ping-exit=
 60 &gt;&quot;$logdir&quot;/srv=2Elog 2&gt;&amp;1 &amp;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    srv_pid=3D$!</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    plat_exec &quot;${openvpn}&quot; --cd &quot;${top_srcdir=
}/sample&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     --config sample-config-files/loopback-client \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        --dev &quot;$TUN&quot; --dev-type=
 tun \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        --ifc=
onfig &quot;$VPN_LOCAL&quot; &quot;$VPN_REMOTE&quot; \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        --route &quot;$TARGET&quot; 255=
=2E255=2E255=2E255 net_gateway \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        --verb 4 --ping-exit 60 &gt;&quot;$logdir&quot;/clt=2E=
log 2&gt;&amp;1 &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    clt_pid=3D$!</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# Wait for the tunnel itself=2E  Nothi=
ng can be concluded about routes until</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+# the tun interface exists, so this is checked separatel=
y: an environment</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
that cannot open a tunnel is a skip, whereas a tunnel that is up without</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# the route is a real =
failure=2E  Gives up early if the client has died=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+route_wait_tun()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    i=3D0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    while [ &quot;$i&quot; -lt 60 ]; do</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        plat_have_tun &quot;$1&quot; &amp;&amp; retu=
rn 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        kill -0=
 &quot;$clt_pid&quot; 2&gt;/dev/null || return 1</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        i=3D$((i + 1))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sleep 1</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return 1</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# Everything a failing ru=
n needs, printed to stderr so it reaches the CI log=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+route_dump_diag()</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    echo &quot;--- client log ---&quot; &gt;&amp;2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    cat &quot;$logdir&quot;/=
clt=2Elog &gt;&amp;2 2&gt;/dev/null</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    echo &quot;--- server log ---&quot; &gt;&amp;2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    cat &quot;$logdir&quot;/=
srv=2Elog &gt;&amp;2 2&gt;/dev/null</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    echo &quot;--- addresses and routes ---&quot; &gt;&amp;=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    plat_dump_stat=
e &gt;&amp;2 2&gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# Wait for the route to show =
up rather than guessing at a sleep=2E  Sets</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# route_out to the entry that appeared=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+route_wait_for()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    i=3D0</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    route_out=3D&quot;&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    while [ &quot;$i&quot; -lt 30 ]; do</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        route_out=3D$(plat_rout=
e_show &quot;$1&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        [ -n &quot;$route_out&quot; ] &amp;&amp; return 0</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        i=3D$((i + 1))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        sleep 1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    done</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return 1</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# net_gateway i=
s the system default gateway, not the route to the peer=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+# Compare the gateway the platform r=
eports rather than the text of the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# entry, which is spelled differently by every routing tool=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_assert_gat=
eway()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    _want=3D$1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    _got=3D$(plat_route_gateway &quo=
t;$TARGET&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ &quot;$_got&q=
uot; =3D &quot;$_want&quot; ]; then</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        echo &quot;$0: net_gateway resolved to $_want as ex=
pected&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0: expected the route via=
 the default gateway $_want,&quot; &gt;&amp;2</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    echo &quot;     got gateway &#39;$_got&#39; i=
n: $route_out=2E FAIL=2E&quot; &gt;&amp;2</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return 1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br></pre><p>To view, visit <a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail">change 1949</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit=2Eo=
penvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemty=
pe=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none=
"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerr=
it-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: mast=
er </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2e8f1449fe54e7f62=
8e2bdb042ee2a567f25e02d </div>
<div style=3D"display:none"> Gerrit-Change-N=
umber: 1949 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<=
div style=3D"display:none"> Gerrit-Owner: chugly &lt;charlie=2Evigue@openvp=
n=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</=
body></html>
--uiDNie/52zI=--


--===============2321284001361951275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2321284001361951275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2321284001361951275==--

