Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BEAC9831E
	for <openvpn-devel@archiver.kernel.org>; Fri, 25 Sep 2026 03:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=xU2YmWNlOUpNiljPNZc99fIl5lTE9sEDqCoYPJvrX9k=; b=A+v8SuXTJsJs/q
	JdzxmAjDAjASuIObZRIOxULYgx3OXvvDWvZaR77lwzM227GPCrSr3pWEB2ETDQpOxBT4KIJyrTvHF
	e5NcBPm3kDn1iYrmZMn/TwU0jYD0ZFF+irvysGAxseCjqbuPHKxi/GbBSvL4afTfK+e3OUN9GZtUr
	37U=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9wZW-0002du-Nd;
	Fri, 25 Sep 2026 03:26:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9wZE-0002dZ-U9
 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 03:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CYxK5mqqNPDBgB8HNDnq7hJMPcJxAhz7OaM9ilkUxEE=; b=TsyXX769jVdbos93niQ2a7JM/K
 VNYRNb/NqB2tkhlHJnA6y0W7v6xiShP5JAGdxnxRQChgsu307FWqpmi28HMRGSLPwT3H22wpyyAM9
 fuB5JGg40j77HiOrhv1GcNkVUB+HqYdSlY77lqpYX2RhqOT+GtkAdbNz0BRkA5fs/ubA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CYxK5mqqNPDBgB8HNDnq7hJMPcJxAhz7OaM9ilkUxEE=; b=L
 0XcpkGE1PX0ZLXHhstyKPmDS3wM5HTRScyHVIiuzeOOpUy9LX4y5FvOaY7xTFkANHCZnHwwqLSgG9
 DsLClbrIZF8w8nHXV+sUDhdhs995Fu7dwx4en0RBSSEgPC2eeRWnTjtPWFehRfjJyx3HZ6QprtfuA
 fTDaWnrluqVLubgw=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9wZ0-0001nx-14 for openvpn-devel@lists.sourceforge.net;
 Fri, 25 Sep 2026 03:25:33 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d097b4939so2490475e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 24 Sep 2026 20:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790306723; x=1790911523; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CYxK5mqqNPDBgB8HNDnq7hJMPcJxAhz7OaM9ilkUxEE=;
 b=d5RrtOI0nW8RsEkIE0kk206Kerl2lwN53Lm8fQw1AGEZF4wgiQcDwGRrxfUj63IE2x
 7hQYiKgPbyP/i9Osl2tirAgq7nxeuqrTxo8hmgZCZNK7zHf1Qvjz2tDO7Ygt6gwbXODY
 ejg4pyIEW6JtP89Ed3uy2qtUsSJ652pOY553YlbISas6ovhsGy83y25cq6/o8SWmZzJy
 rUpVdeJt6rfbJGPWzZe8dCCBzkJH2w6EMuMfhLIn7AMkbiD18kP/MDu+47IdwukZcn9j
 QmTYKyS43M49644EKORIJddiSvHXdrW+02EumOfc+EVnWCky3ibADv0CW3v+A4h5BCrd
 9R2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790306723; x=1790911523;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CYxK5mqqNPDBgB8HNDnq7hJMPcJxAhz7OaM9ilkUxEE=;
 b=GHdQ0RdkIiRfC6M9Zr120PKbIxpCqqrikQ+l8zw8wkRecfSBLRTyoQeJPbc1IPmV19
 mcIuAhsHznUGRT8+GPs2j138EcOhOhSjKh9H4Ti+4BJuuej3a96QKr1RmuguJ6QugYJY
 VD5WFX+PZmSZ6RV7UY+5lCfWIEei0CsqqSCRUQUg0SzmsC73GRMlJ7/Kqn+2Px/9kIv+
 gceGPtPUTo94O56voejFoVhKZ74t6DDnJFAmMT6sIO0AqPq0iNQPpikcxG/VCd+w+vJi
 R6yX4pQwAbsngSmsq8xMfGoGJPpPUeAUAh1PTw8DBK4ntDpTizDhQhyAAK0hCo2xtjTt
 +leg==
X-Gm-Message-State: AFuF++lDXGPxHBI8PUx2EiuRZsWuuMtskwnPJehs9vy2fcglskzw7ZCV
 TNhHCD0NH5D+5VXFEkIlKX+fBlrfVsW8E8OG0GpU5VxbfpNm8A4KHewCmaHGrZHQLQ3Iy2eBAxL
 8fOs4G3gCGFhFsmoxtY3fSkeAQMkhRkUS+uo4EtN+vmiwON2KNsO6ASM4dpQWxh1JC3y7Gj/RkR
 w2sE757A==
X-Gm-Gg: AYBFou1Pm/+pBcO4mPj/luMPu3UDN0+u5+NI7m/pI/+KzYhFOa+72p0bW1xkAq/DtnU
 nX1NFasmlm3IALL4ZOoMS1EPq/tHERgOv/tYy2gpnIrnR2IRW9dtny4VHXyYsFMYB7fIyImrpII
 8IHprP0SEm3RnVd7DR0MHQtYHaC//Uz0Nr21cNb3HIAXWyxYLXx6niy0hr/zVeD+npUcmR5vdyr
 39Tk30AuWaPgP7B1v2yqQiCNXfXJNvlYLz3RAdf3uvk2U787jyi/JQN2cMYTHIymGGtTyhHur4/
 mFV37U0adfOMe9gBTnYvPeQrkzwJUD9lqcP32HjbDZHt3vVxSBwrqpXlkLBw3WuEa5Q6vKE9kar
 4adnicFL51Wi/a1wNYxuSRwFvOZACKX42n/+eUFv/Q+vgnhDTkAKDHgqwwkEeFOm5bCh/XGAYgx
 58J8oQHarfZTAvkC+vyTDX1VIH2xdk9Sqq6mfLAPJGZhp2KfwiL1piRRTfWkocSFsSBwkidUWX5
 dRL0a/WA+qNxyzTNAisBqamq4UqV+/hCjudoul/xjk3KIDHbLA8/3o5GSI1zZbLk7I6iBA/hwog
 xDG9hOa23zLbgd2SZUhO8ZDDJJP9SrBdZmSSIzWq5SjdsdE5W2EZkZrtmyNr
X-Received: by 2002:a05:6000:22ca:b0:487:af3:836 with SMTP id
 ffacd0b85a97d-48871764dd8mr8322165f8f.45.1790306722867; 
 Thu, 24 Sep 2026 20:25:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a30bcc4sm3753335f8f.1.2026.09.24.20.25.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 20:25:22 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 25 Sep 2026 03:25:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
X-Gerrit-Change-Number: 1949
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1949?usp=email>
X-Gerrit-Commit: 57e9b919136ba4e1dac9ff6ca0de201f644c057b
References: <gerrit.1790306719000.I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMzA2NzE5MDAwLkkyZThmMTQ0OWZlNTRlN2Y2MjhlMmJkYjA0MmVlMmE1NjdmMjVlMDJkQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <76e615eedd8a41ec86f6574dae5d5b12b3178701-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9wZ0-0001nx-14
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
 openvpn-devel@lists.sourceforge.net
Cc: "chugly \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1037315431735869268=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1037315431735869268==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vxCtPjOlP8E="; charset=UTF-8

--vxCtPjOlP8E=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1949?usp=3Demail

to review the following change=2E


Chang=
e subject: tests: add an end-to-end test for --route gateway keywords
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

tests: add an en=
d-to-end test for --route gateway keywords

Nothing self-contained checks t=
hat a route openvpn says it installed
actually reached the kernel with the =
gateway it reported=2E t_client=2Esh does
compare routes, but it needs a t_=
client=2Erc and reachable servers, so it
skips for contributors and in CI=
=2E

Run a TLS loopback pair inside a throwaway network namespace, ask the
=
client for a route via net_gateway, and check where it lands=2E route=2Ec
t=
racks two gateways, the system default route and the route towards the
peer=
, and net_gateway is the former=2E The peer here is on loopback, so the
two=
 differ and the assertion can tell them apart: resolving from the wrong
one=
 leaves the route with no gateway and the install fails outright=2E

The na=
mespace also means the fixed loopback ports cannot collide, so this
needs n=
one of the retry-on-address-in-use handling t_cltsrv=2Esh has=2E

Skips rat=
her than fails when it cannot run: not Linux, no iproute2, or no
way to get=
 the privileges a namespace needs=2E Containers commonly disallow
namespace=
 creation, so this will skip there and run on VMs and bare metal=2E
RUN_SUD=
O is picked up from t_client=2Erc the same way t_net=2Esh does=2E

Change-I=
d: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
Signed-off-by: Charlie Vigue <=
charlie=2Evigue@openvpn=2Ecom>
---
M tests/Makefile=2Eam
A tests/t_route=2E=
sh
2 files changed, 142 insertions(+), 1 deletion(-)



  git pull ssh://ge=
rrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/49/1949/1

diff --git a/tes=
ts/Makefile=2Eam b/tests/Makefile=2Eam
index 3907965=2E=2E559533e 100644
--=
- a/tests/Makefile=2Eam
+++ b/tests/Makefile=2Eam
@@ -18,7 +18,7 @@
 SH_LOG=
_DRIVER =3D $(SHELL) $(top_srcdir)/forked-test-driver
 
 if !WIN32
-test_sc=
ripts =3D t_client=2Esh t_lpback=2Esh t_cltsrv=2Esh t_server_null=2Esh
+tes=
t_scripts =3D t_client=2Esh t_lpback=2Esh t_cltsrv=2Esh t_server_null=2Esh =
t_route=2Esh
 
 check_PROGRAMS =3D ntlm_support
 if HAVE_SITNL
@@ -35,6 +35=
,7 @@
 	t_cltsrv-down=2Esh \
 	t_lpback=2Esh \
 	t_net=2Esh \
+	t_route=2Es=
h \
 	t_server_null=2Esh \
 	t_server_null_client=2Esh \
 	t_server_null_se=
rver=2Esh \
diff --git a/tests/t_route=2Esh b/tests/t_route=2Esh
new file m=
ode 100755
index 0000000=2E=2Ef3bac06
--- /dev/null
+++ b/tests/t_route=2Es=
h
@@ -0,0 +1,140 @@
+#!/usr/bin/env bash
+#
+# t_route=2Esh - check that --=
route installs a route where it says it will
+#
+# The special gateway keyw=
ords (net_gateway, vpn_gateway, remote_host) are
+# resolved in route=2Ec f=
rom data gathered off the system routing table=2E The
+# unit tests cover t=
he resolution itself; this checks that the answer
+# reaches the kernel=2E
=
+#
+# route=2Ec keeps two gateways: the system default route, and the route=

+# towards the peer=2E net_gateway is the former=2E Here the peer is on
+#=
 loopback, so the two are necessarily different and an assertion on the
+# =
installed gateway tells them apart=2E
+#
+# Everything runs in a throwaway =
network namespace, so the host routing
+# table is not touched and the fixe=
d loopback ports cannot collide with
+# anything=2E
+
+srcdir=3D"${srcdir:-=
=2E}"
+top_builddir=3D"${top_builddir:-=2E=2E}"
+top_srcdir=3D"${top_srcdir=
:-${srcdir}/=2E=2E}"
+openvpn=3D"${openvpn:-${top_builddir}/src/openvpn/ope=
nvpn}"
+
+# Namespace topology: one interface carrying a default route, whi=
ch is
+# what net_gateway has to resolve to=2E
+NS=3D"ovpnroute$$"
+TUN=3D"=
ovpnt$$"
+LAN_GW=3D"10=2E71=2E1=2E1"
+TARGET=3D"10=2E71=2E250=2E1"       # =
what we ask to be routed via net_gateway
+VPN_LOCAL=3D"10=2E71=2E8=2E2"
+VP=
N_REMOTE=3D"10=2E71=2E8=2E1"
+
+# netlink, dummy interfaces and namespaces =
are all Linux-only=2E The rest of
+# this script would not even parse the s=
ame elsewhere=2E
+if [ "$(uname -s)" !=3D "Linux" ]; then
+    echo "$0: th=
is test runs only on Linux=2E SKIPPING TEST=2E"
+    exit 77
+fi
+
+if [ ! =
-x "${openvpn}" ]; then
+    echo "$0: no (executable) openvpn binary in cu=
rrent build tree=2E FAIL=2E" >&2
+    exit 1
+fi
+
+if ! command -v ip >/de=
v/null 2>&1; then
+    echo "$0: no iproute2 'ip' command in \$PATH=2E SKIP=
PING TEST=2E" >&2
+    exit 77
+fi
+
+# t_client=2Erc is read only for a RU=
N_SUDO definition, as t_net=2Esh does
+if [ -r "${top_builddir}"/t_client=
=2Erc ]; then
+    =2E "${top_builddir}"/t_client=2Erc
+elif [ -r "${srcdir=
}"/t_client=2Erc ]; then
+    =2E "${srcdir}"/t_client=2Erc
+fi
+
+if [ "$(=
id -u)" -ne 0 ]; then
+    if [ -z "$RUN_SUDO" ]; then
+        RUN_SUDO=3D=
"sudo"
+    fi
+else
+    RUN_SUDO=3D""
+fi
+
+# A namespace needs the same=
 privileges the rest of the test does, so use
+# it as the probe=2E
+if ! $=
RUN_SUDO ip netns add "$NS" >/dev/null 2>&1; then
+    echo "$0: cannot cre=
ate a network namespace with '$RUN_SUDO'=2E" >&2
+    echo "$0: containers =
commonly disallow this=2E SKIPPING TEST=2E" >&2
+    exit 77
+fi
+
+srv_pid=
=3D""
+clt_pid=3D""
+logdir=3D$(mktemp -d) || exit 1
+
+cleanup()
+{
+    [=
 -n "$clt_pid" ] && kill "$clt_pid" 2>/dev/null
+    [ -n "$srv_pid" ] && k=
ill "$srv_pid" 2>/dev/null
+    wait 2>/dev/null
+    # deleting the namesp=
ace takes every interface and route in it with it
+    $RUN_SUDO ip netns d=
el "$NS" 2>/dev/null
+    [ -n "$logdir" ] && rm -rf "$logdir"
+}
+trap cle=
anup EXIT
+
+nsexec() { $RUN_SUDO ip netns exec "$NS" "$@"; }
+
+set -e
+ns=
exec ip link set lo up
+nsexec ip link add lan0 type dummy
+nsexec ip link =
set lan0 up
+nsexec ip addr add 10=2E71=2E1=2E2/24 dev lan0
+nsexec ip rout=
e add default via "$LAN_GW" dev lan0
+set +e
+
+# A TLS loopback pair, as t=
_cltsrv=2Esh uses=2E Options after --config override
+# the config file, wh=
ich is how the client gets a tun and a route=2E
+nsexec "${openvpn}" --cd "=
${top_srcdir}/sample" \
+    --config sample-config-files/loopback-server \=

+    --verb 3 --ping-exit 60 >"$logdir"/srv=2Elog 2>&1 &
+srv_pid=3D$!
+
+=
nsexec "${openvpn}" --cd "${top_srcdir}/sample" \
+    --config sample-conf=
ig-files/loopback-client \
+    --dev "$TUN" --dev-type tun \
+    --ifconf=
ig "$VPN_LOCAL" "$VPN_REMOTE" \
+    --route "$TARGET" 255=2E255=2E255=2E25=
5 net_gateway \
+    --verb 4 --ping-exit 60 >"$logdir"/clt=2Elog 2>&1 &
+c=
lt_pid=3D$!
+
+# Wait for the route to show up rather than guessing at a sl=
eep
+route_out=3D""
+for _ in $(seq 1 30); do
+    route_out=3D$(nsexec ip =
route show "$TARGET" 2>/dev/null)
+    [ -n "$route_out" ] && break
+    sl=
eep 1
+done
+
+if [ -z "$route_out" ]; then
+    echo "$0: route to $TARGET=
 was never installed=2E FAIL=2E" >&2
+    echo "--- client log ---" >&2
+  =
  cat "$logdir"/clt=2Elog >&2
+    exit 1
+fi
+
+# net_gateway is the syste=
m default gateway, not the route to the peer
+case "$route_out" in
+    *"v=
ia $LAN_GW"*)
+        echo "$0: net_gateway resolved to $LAN_GW as expecte=
d"
+        ;;
+    *)
+        echo "$0: expected the route via the defaul=
t gateway $LAN_GW," >&2
+        echo "     got: $route_out=2E FAIL=2E" >&2=

+        exit 1
+        ;;
+esac
+
+exit 0

-- 
To view, visit http://ger=
rit=2Eopenvpn=2Enet/c/openvpn/+/1949?usp=3Demail
To unsubscribe, or for hel=
p writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch:=
 master
Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d
Gerrit-=
Change-Number: 1949
Gerrit-PatchSet: 1
Gerrit-Owner: chugly <charlie=2Evigu=
e@openvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Ge=
rrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Att=
ention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--vxCtPjOlP8E=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>chugly would like plaisthos to <=
strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1949?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">t=
ests: add an end-to-end test for --route gateway keywords<br><br>Nothing se=
lf-contained checks that a route openvpn says it installed<br>actually reac=
hed the kernel with the gateway it reported=2E t_client=2Esh does<br>compar=
e routes, but it needs a t_client=2Erc and reachable servers, so it<br>skip=
s for contributors and in CI=2E<br><br>Run a TLS loopback pair inside a thr=
owaway network namespace, ask the<br>client for a route via net_gateway, an=
d check where it lands=2E route=2Ec<br>tracks two gateways, the system defa=
ult route and the route towards the<br>peer, and net_gateway is the former=
=2E The peer here is on loopback, so the<br>two differ and the assertion ca=
n tell them apart: resolving from the wrong<br>one leaves the route with no=
 gateway and the install fails outright=2E<br><br>The namespace also means =
the fixed loopback ports cannot collide, so this<br>needs none of the retry=
-on-address-in-use handling t_cltsrv=2Esh has=2E<br><br>Skips rather than f=
ails when it cannot run: not Linux, no iproute2, or no<br>way to get the pr=
ivileges a namespace needs=2E Containers commonly disallow<br>namespace cre=
ation, so this will skip there and run on VMs and bare metal=2E<br>RUN_SUDO=
 is picked up from t_client=2Erc the same way t_net=2Esh does=2E<br><br>Cha=
nge-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d<br>Signed-off-by: Charlie=
 Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<br>---<br>M tests/Makefile=2Ea=
m<br>A tests/t_route=2Esh<br>2 files changed, 142 insertions(+), 1 deletion=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/49/1949/1</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/tests/Makefile=2Eam b/t=
ests/Makefile=2Eam</span><br><span>index 3907965=2E=2E559533e 100644</span>=
<br><span>--- a/tests/Makefile=2Eam</span><br><span>+++ b/tests/Makefile=2E=
am</span><br><span>@@ -18,7 +18,7 @@</span><br><span> SH_LOG_DRIVER =3D $(S=
HELL) $(top_srcdir)/forked-test-driver</span><br><span> </span><br><span> i=
f !WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_scripts =
=3D t_client=2Esh t_lpback=2Esh t_cltsrv=2Esh t_server_null=2Esh</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_scripts =3D t_client=2Esh=
 t_lpback=2Esh t_cltsrv=2Esh t_server_null=2Esh t_route=2Esh</span><br><spa=
n> </span><br><span> check_PROGRAMS =3D ntlm_support</span><br><span> if HA=
VE_SITNL</span><br><span>@@ -35,6 +35,7 @@</span><br><span> 	t_cltsrv-down=
=2Esh \</span><br><span> 	t_lpback=2Esh \</span><br><span> 	t_net=2Esh \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	t_route=2Esh \</span>=
<br><span> 	t_server_null=2Esh \</span><br><span> 	t_server_null_client=2Es=
h \</span><br><span> 	t_server_null_server=2Esh \</span><br><span>diff --gi=
t a/tests/t_route=2Esh b/tests/t_route=2Esh</span><br><span>new file mode 1=
00755</span><br><span>index 0000000=2E=2Ef3bac06</span><br><span>--- /dev/n=
ull</span><br><span>+++ b/tests/t_route=2Esh</span><br><span>@@ -0,0 +1,140=
 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/usr/bin/env b=
ash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+# t_route=2Esh - check that --rout=
e installs a route where it says it will</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# The special gateway keywords (net_gateway, vpn_gateway, remote_host) a=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# resolved in rou=
te=2Ec from data gathered off the system routing table=2E The</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# unit tests cover the resolution=
 itself; this checks that the answer</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# reaches the kernel=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# route=2Ec keeps two gateways: the system default route, and the route<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+# towards the peer=
=2E net_gateway is the former=2E Here the peer is on</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# loopback, so the two are necessarily di=
fferent and an assertion on the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+# installed gateway tells them apart=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Everything runs in a throwaway network namespace, so the =
host routing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# table=
 is not touched and the fixed loopback ports cannot collide with</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# anything=2E</span><br><span =
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
, 100%, 40%);">+TARGET=3D&quot;10=2E71=2E250=2E1&quot;       # what we ask =
to be routed via net_gateway</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+VPN_LOCAL=3D&quot;10=2E71=2E8=2E2&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+VPN_REMOTE=3D&quot;10=2E71=2E8=2E1&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# netlink, dummy interfaces and namespaces a=
re all Linux-only=2E The rest of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# this script would not even parse the same elsewhere=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &quot;$(uname -s)&qu=
ot; !=3D &quot;Linux&quot; ]; then</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    echo &quot;$0: this test runs only on Linux=2E SKIPPING =
TEST=2E&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ex=
it 77</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+if [ ! -x &quot;${openvpn}&quot; ]; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0: no (execut=
able) openvpn binary in current build tree=2E FAIL=2E&quot; &gt;&amp;2</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    exit 1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+if ! command -v ip &gt;/dev/null 2&gt;&amp;1; then</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0: no iproute2 &#39;ip=
&#39; command in \$PATH=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    exit 77</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# =
t_client=2Erc is read only for a RUN_SUDO definition, as t_net=2Esh does</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -r &quot;${top_bu=
ilddir}&quot;/t_client=2Erc ]; then</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    =2E &quot;${top_builddir}&quot;/t_client=2Erc</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+elif [ -r &quot;${srcdir}&quo=
t;/t_client=2Erc ]; then</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    =2E &quot;${srcdir}&quot;/t_client=2Erc</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ &q=
uot;$(id -u)&quot; -ne 0 ]; then</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if [ -z &quot;$RUN_SUDO&quot; ]; then</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        RUN_SUDO=3D&quot;sudo&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    RUN_SUDO=3D&quot;&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# A n=
amespace needs the same privileges the rest of the test does, so use</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# it as the probe=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if ! $RUN_SUDO ip netns a=
dd &quot;$NS&quot; &gt;/dev/null 2&gt;&amp;1; then</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    echo &quot;$0: cannot create a network n=
amespace with &#39;$RUN_SUDO&#39;=2E&quot; &gt;&amp;2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    echo &quot;$0: containers commonly di=
sallow this=2E SKIPPING TEST=2E&quot; &gt;&amp;2</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    exit 77</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+srv_pid=3D&quot=
;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clt_pid=3D&q=
uot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+logdir=3D=
$(mktemp -d) || exit 1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cleanup()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    [ -n &quot;$clt_pid&quot; ] &amp;&amp; k=
ill &quot;$clt_pid&quot; 2&gt;/dev/null</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    [ -n &quot;$srv_pid&quot; ] &amp;&amp; kill &quot;$=
srv_pid&quot; 2&gt;/dev/null</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    wait 2&gt;/dev/null</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    # deleting the namespace takes every interface and route i=
n it with it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    $RU=
N_SUDO ip netns del &quot;$NS&quot; 2&gt;/dev/null</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    [ -n &quot;$logdir&quot; ] &amp;&amp; rm=
 -rf &quot;$logdir&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+trap cleanup =
EXIT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+nsexec() { $RUN_SUDO ip netns exec=
 &quot;$NS&quot; &quot;$@&quot;; }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set =
-e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nsexec ip link se=
t lo up</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nsexec ip li=
nk add lan0 type dummy</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+nsexec ip link set lan0 up</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+nsexec ip addr add 10=2E71=2E1=2E2/24 dev lan0</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+nsexec ip route add default via &quot;=
$LAN_GW&quot; dev lan0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+set +e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# A TLS loopback pair, as t_c=
ltsrv=2Esh uses=2E Options after --config override</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# the config file, which is how the client g=
ets a tun and a route=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+nsexec &quot;${openvpn}&quot; --cd &quot;${top_srcdir}/sample&quot; \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    --config sample-=
config-files/loopback-server \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    --verb 3 --ping-exit 60 &gt;&quot;$logdir&quot;/srv=2Elog 2&=
gt;&amp;1 &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+srv_=
pid=3D$!</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+nsexec &quot;${openvpn}&quot; =
--cd &quot;${top_srcdir}/sample&quot; \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    --config sample-config-files/loopback-client \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    --dev &quot;$TUN&quo=
t; --dev-type tun \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    --ifconfig &quot;$VPN_LOCAL&quot; &quot;$VPN_REMOTE&quot; \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    --route &quot;$TARGET&quot;=
 255=2E255=2E255=2E255 net_gateway \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    --verb 4 --ping-exit 60 &gt;&quot;$logdir&quot;/clt=2E=
log 2&gt;&amp;1 &amp;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+clt_pid=3D$!</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+# Wait for the route to =
show up rather than guessing at a sleep</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+route_out=3D&quot;&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+for _ in $(seq 1 30); do</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    route_out=3D$(nsexec ip route show &quot;=
$TARGET&quot; 2&gt;/dev/null)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    [ -n &quot;$route_out&quot; ] &amp;&amp; break</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    sleep 1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+done</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
if [ -z &quot;$route_out&quot; ]; then</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    echo &quot;$0: route to $TARGET was never installed=
=2E FAIL=2E&quot; &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    echo &quot;--- client log ---&quot; &gt;&amp;2</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    cat &quot;$logdir&quot;/clt=2El=
og &gt;&amp;2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ex=
it 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+# net_gateway is the system default gateway, not th=
e route to the peer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
case &quot;$route_out&quot; in</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    *&quot;via $LAN_GW&quot;*)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        echo &quot;$0: net_gateway resolved to $LAN_G=
W as expected&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;$0:=
 expected the route via the default gateway $LAN_GW,&quot; &gt;&amp;2</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        echo &quot;     g=
ot: $route_out=2E FAIL=2E&quot; &gt;&amp;2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ;;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+esac</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+exit 0</span><br></pre><p=
>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1949?u=
sp=3Demail">change 1949</a>=2E To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1949?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I2e8f1449fe54e7f628e2bdb042ee2a567f25e02d </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1949 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Ow=
ner: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </=
div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-deve=
l@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-=
Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--vxCtPjOlP8E=--


--===============1037315431735869268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1037315431735869268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1037315431735869268==--

