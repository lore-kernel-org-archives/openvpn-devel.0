Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0A606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=M/M1sXcO;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X/KxP8fd;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DH51/faz;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=gP+GWhEg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=mwmY0r94QEsiVxtvkFdiitJ0hHuOyriyE2StyJ4qGUc=; b=M/M1sXcOIufPh3TakRrN8fyolU
	ANPADaqOSB00SbFqlutEIJ/PpS/CXiPtZ4jjmpoBIWbr+J1cnrEdiZTYvFAvW6tEJr6b7F9vR5de9
	4SqBRP+TZ1jxBu0Z6S08GM/JFFHOJXCx4s2wU5ccNLn8uLEkK51xdyPIDHS8DX4jzV4g=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLMSr-000000007nY-2XOy;
	Mon, 26 Oct 2026 15:18:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLMSp-000000007nP-1B8p
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:18:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BS1Ou7VGCu3sYR/l0RHXkl/qR1l1ytOsCjB3imdX+oo=; b=X/KxP8fdsZmRPQ9zIF6yfX4CLK
 JCsdDFW3HuJSP+eoV98QzxVpodZJaDZ+n4VcOmBBJoOyw5dk83khtUqs++0YqsEaxC2oq+L1XxQXu
 edZhsCW4g3ofzInbd2bsb/dC3xYqcCmO8DQDkblFrBkCR8z+UGBle51hgcLi+0VhZxFU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BS1Ou7VGCu3sYR/l0RHXkl/qR1l1ytOsCjB3imdX+oo=; b=DH51/fazzRNLrLArfGLjeeqPAT
 kmS9Wg8N/olQOmmN65hlpS8+EBU2ee60wi9SJAY+sOxvyyuA5bbcC+HV8B5K8XZFfg78bRa80r8nV
 wUIKgKUHkLGZ2YNtcuMTgP6zs7OK2XWZX9Iy6v3aCd3Dv0iQh2XhC6EocC9pxpB7ZFLI=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLMSf-000000003cn-1bEv for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 15:18:19 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so44185e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 08:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793027883; x=1793632683; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=BS1Ou7VGCu3sYR/l0RHXkl/qR1l1ytOsCjB3imdX+oo=;
 b=gP+GWhEgVqyu9tlWWnICVern2kMQiY9tZ3SalxLJMSaaapnPXqZx409BRltvw6xlk2
 1YTTBjEbbkCEHb7LvWY/R9Xt95m2LaWj9fVnH46m6BUs8shTxaatwv4bTnYPLcOozV92
 ZfjEG67uh9/6ObFtr2+TxU9fLoUBolYb2i0R6VZ6PbJ3+y17Qz+U+qUId1yAQR2ZQOTl
 TZXjU3v0HeQOgfmWhFxvfALWkmD0ZctytyWw5MUti5Q8VoopFH2ZEP3pFgzjvIofZruU
 z9kbdoWlKgmDU+VfUiuwmBBL8/uJsJzHvUWa8vYSFcPq8n09ME2Gc5H+thMGd+fXORBF
 d2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793027883; x=1793632683;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=BS1Ou7VGCu3sYR/l0RHXkl/qR1l1ytOsCjB3imdX+oo=;
 b=Fp5iVj51qIrzcePqZQaeKGAl1dh4jnsm+Ju/H3Gu2MaazAFI1GcEH8HqOVPq63Nw4e
 F0G5U/ZYnEoTPH/kzUS71oZVdmpAi48ZJRIkN6MkUOFmaQMPvDzmQVoWtJkdi1m6CINJ
 0t1X83k3JbPYCV51IiywR9suAbQYKxxsnggCr+efetmqJVRPpp/Mu/WFUzBl9XtjLE0j
 FogpWW52ol2egNZCUC+Y34skdeG2OIX/xFKzIz+KVcgrrAZ9fMMkXEP1rc/sAmid8hC4
 rlLIkTjsqtAfhrAk/FZKPok/fR/6R9T1IXEKBc0HQPYnd0xo8Chc/odh01y+KxxJHTsT
 jGQA==
X-Gm-Message-State: AFq9FYKaNt/PO3QGRiLrhNIuSxipq/sqXYsr3er6rwLUBcXrmeQuXfuj
 wtUQ2ARf6BrzR4SP8T1PIzL38r5jSckhL3Y0+Z3UKPMCU3KzQl1w28xSCBilIHWqFoUUX0gAMsW
 piggmdO8oWjVEu2JZ7Wbcu+acVWrYQqP/l0QiT4qtiIOn3WMfnZCj42z1xokQWbBN7BNtwKQuaz
 PTVoIK5A==
X-Gm-Gg: AYBFou0m/NQg+xIqcu3ON58knT+9irFrpdaCDtWkwjEgvxvCWTq05bxnnZ00NaVTc1/
 379qWWylyQf9/P5+w6QhZUHguzehbld999Qjml3ypVjq/xdLcFRLBJ5WOwe91dSiW2bMskmGZWp
 c682MJRAf7lOub+RP9haWwlyTpWHzoWMYWI6kwC2SC5z2F/2GNF203Lbsa5pUdM+wp/YGh8Pd3a
 3p3KguKIhnGHMTZz172C6izzOJyPGbBG8j+zAHVyylce9ul2UA5JtH8aI5Mf7+9P/yP1n1ufEky
 ERBizGz5esw5DzqLcL30+rYLGhcjSUVNzaeVhDdP/2dzNdhuqJHfppvX45M8jS/0PUwKiLwgNLC
 rS5w0O67CmllmwhWhof3P/Kd5FKTtAahAVXgAUyx0vHiSrQsYATX8GUvpUzkAIyPlB15hasmRv9
 aijeFmA+bFjmuJekawzadeUyx1HvVpOij5VFdV++r6Tt5ZBtNmBBov1LQmUKRCxLah8Wsx4Egpc
 ZXOFA+uyt3YPnPd6EEnXtaCG3nY3RwpFmjy8QNWjBoWctFnHdqo49f1o2y43Cfxy0U2EsK8wBro
 fjNVHxy19RDIG+PUSKkkw9lHX0WIXP7Elqt9tWrzlBAa9nAFOsuUdz8xiZ+HM/t8Obr+UuzQY7s
 kGw4gUYuc/Coyyl6LwFOZtOv/EaHiqPRZ0iOzO/HX+A==
X-Received: by 2002:a05:600c:c490:b0:4a1:c6f5:2450 with SMTP id
 5b1f17b1804b1-4a35aeb0eedmr142241715e9.17.1793027882116; 
 Mon, 26 Oct 2026 08:18:02 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0bdd59sm129125945e9.4.2026.10.26.08.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 08:18:01 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 15:17:56 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 11
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: f4c5a1f3167797600c27038c812faf967865b689
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <d69979604b1b0e5403520997b41448eb89f849c2-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLMSf-000000003cn-1bEv
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
 clients from a named subnet-pool
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Antonio Quartulli \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: antonio@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "Antonio Quartulli \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4334526602308741465=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4334526602308741465==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="J148vkwa6e4="; charset=UTF-8

--J148vkwa6e4=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Frank Lichtenheld, Gert Doering, 

I'd like you to reexa=
mine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1783?usp=3Demail

to look at the new patch set (#11)=2E


Change subject=
: multi: assign clients from a named subnet-pool
=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: assign clients from a named su=
bnet-pool

Add two server directives:

  subnet-pool <name> <network> <netm=
ask> [<gateway> [<start> <end>]]
                                          =
            (main config)
  subnet-pool-name <name>                        =
     (per-client CCD)

so groups of clients can be given addresses from sub=
nets other than the
--server network (per-group firewall rules under --topo=
logy subnet, and
thus DCO)=2E A client's subnet-pool-name is resolved to it=
s pool and served
a virtual IP from that subnet: a static --ifconfig-push w=
ithin it, or
the next free address from a dynamic per-group pool shared by =
name=2E The
dynamic pool spans the whole subnet unless a start-end range is=
 given,
which leaves the rest of the subnet to static addresses (these are =
not
reserved in the pool)=2E Such a client is validated against its own sub=
net
instead of the global tunnel-network constraint and never falls back to=

the global pool; a name matching no configured pool is declined with
AUTH_=
FAILED=2E The name is resolved again after every client-connect
handler, so=
 a script, plugin or management interface may override the
one set by the C=
CD file=2E

The pools are checked when the config is loaded, as for --serve=
r: the
netmask must be contiguous and between /16 and /29, the gateway a ho=
st
address inside the subnet, a range (if any) at least two host addresses
=
of the subnet, names unique, and no pool may overlap another or the
--serve=
r network=2E Every pool is created at startup, and its gateway is
reserved =
so it is never handed out to a client=2E

The server routes each pool's sub=
net into its tun device, as the device
is only configured with the --server=
 network: without this the server
cannot reach its subnet-pool clients=2E T=
his is a regular --route, so it
is installed before privileges are dropped =
and honours --route-table,
--route-metric and --route-noexec=2E Under DCO o=
n Linux and FreeBSD,
though, the kernel selects the peer by the route's nex=
t hop, so a route
via a gateway would deliver every packet for an unassigne=
d pool address
to the client owning that gateway address: there the route i=
s installed
on-link on the tun device instead (a new on_link route option f=
lag), and
each client of the pool gets its own on-link host route on connec=
t (as
its address is outside the --ifconfig network), so such packets match=

no peer=2E

While here, the tunnel-network constraint violation is logged =
as a
WARNING instead of MULTI ERROR, as it does not fail the connection=2E
=

Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
GitHub: closes openvp=
n/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mandelbit=2Ecom>
--=
-
M CMakeLists=2Etxt
M doc/man-sections/server-options=2Erst
M src/openvpn/=
multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src/openvpn/o=
ptions=2Eh
M src/openvpn/options_util=2Ec
M src/openvpn/options_util=2Eh
M =
src/openvpn/pool=2Ec
M src/openvpn/pool=2Eh
M src/openvpn/route=2Ec
M src/o=
penvpn/route=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_test=
s/openvpn/test_misc=2Ec
A tests/unit_tests/openvpn/test_subnet_pool=2Ec
A t=
ests/unit_tests/openvpn/test_subnet_pool=2Eh
16 files changed, 765 insertio=
ns(+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/open=
vpn refs/changes/83/1783/11

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Et=
xt
index 184a95a=2E=2E8325846 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeList=
s=2Etxt
@@ -858,6 +858,7 @@
     target_sources(test_misc PRIVATE
         =
tests/unit_tests/openvpn/mock_get_random=2Ec
         tests/unit_tests/open=
vpn/test_schedule=2Ec
+        tests/unit_tests/openvpn/test_subnet_pool=2E=
c
         src/openvpn/options_util=2Ec
         src/openvpn/otime=2Ec
    =
     src/openvpn/ssl_util=2Ec
diff --git a/doc/man-sections/server-options=
=2Erst b/doc/man-sections/server-options=2Erst
index 9dfa6bd=2E=2Eb9ed47a 1=
00644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sections/se=
rver-options=2Erst
@@ -330,6 +330,48 @@
   by ``--ifconfig``, OpenVPN will =
install a /32 host route for the ``local``
   IP address=2E
 
+--subnet-poo=
l args
+  Define a named pool of addresses from a subnet different from the=

+  ``--server`` network, so groups of clients can be given IPs from separa=
te
+  subnets for per-group firewall rules under ``--topology subnet`` (and=

+  therefore DCO)=2E This is a main-config directive and may be repeated t=
o
+  define several pools=2E
+
+  Valid syntax:
+  ::
+
+     subnet-pool n=
ame network netmask [gateway [start end]]
+
+  ``name`` is what a client re=
fers to with ``--subnet-pool-name``; ``gateway``
+  defaults to the first a=
ddress of ``network``/``netmask`` and is never
+  assigned to a client=2E A=
 client assigned to a pool receives (dynamically, or
+  via a static ``--if=
config-push`` that must lie within the subnet) an address
+  from it, plus =
the matching netmask=2E
+
+  Dynamic addresses are taken from ``start`` to =
``end`` (every host address
+  of the subnet by default)=2E Static ``--ifco=
nfig-push`` addresses are not
+  reserved in the pool: when mixing static a=
nd dynamic clients in one pool,
+  set ``start``/``end`` so that the static=
 addresses fall outside the range=2E
+
+  Requires ``--server`` with ``--de=
v tun`` and ``--topology subnet``=2E
+  ``netmask`` must be between /16 and=
 /29 (as for ``--server``), ``gateway``
+  must be a host address inside th=
e subnet, ``start`` and ``end`` host
+  addresses inside the subnet with ``=
start`` lower than ``end``, each ``name``
+  may be defined only once and n=
o pool may overlap another one or the
+  ``--server`` network=2E
+
+  The s=
erver routes each pool's subnet into the tun device, as it does for
+  the =
``--server`` network; no ``--route`` needs to be added for it=2E These
+  r=
outes honour ``--route-table`` and ``--route-metric``=2E With DCO on Linux
=
+  and FreeBSD the IPv4 route is installed on-link, without a gateway, so i=
ts
+  ``route_gateway_{n}`` is not set for ``--route-up`` scripts=2E
+
+--s=
ubnet-pool-name name
+  Assign this client to the ``--subnet-pool`` named `=
`name``=2E Must be
+  associated with a specific client instance via ``--cl=
ient-config-dir`` or
+  ``--client-connect``=2E Several clients may referen=
ce the same name and are
+  then served from the same shared pool=2E
+
 --i=
fconfig-ipv6-push args
   for ``--client-config-dir`` per-client static IPv=
6 interface
   configuration, see ``--client-config-dir`` and ``--ifconfig-=
push`` for
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index=
 e302a81=2E=2E5a832b0 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/=
multi=2Ec
@@ -43,6 +43,7 @@
 #include "auth_token=2Eh"
 #include "route=2Eh=
"
 #include "sid_hash=2Eh"
+#include "options_util=2Eh"
 #include <inttypes=
=2Eh>
 #include <string=2Eh>
 
@@ -54,6 +55,21 @@
 #include "dco=2Eh"
 #inc=
lude "reflect_filter=2Eh"
 
+/*
+ * Dynamic address pool serving the client=
s of one --subnet-pool name=2E  Shared
+ * by every client that references =
the name, created at startup by
+ * multi_init()=2E
+ */
+struct subnet_poo=
l
+{
+    struct subnet_pool *next;
+    const char *name;
+    struct ifco=
nfig_pool *pool;
+};
+
+static struct ifconfig_pool *multi_get_group_pool(s=
truct multi_context *m,
+                                                  =
const struct options *o, const char *name);
+
 /*#define MULTI_DEBUG_EVENT_=
LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -371,6 +387,13 @@
         }
   =
  }
 
+    /* create every --subnet-pool group up front rather than on firs=
t use, so
+     * that its pool exists before any client of the group conne=
cts */
+    for (const struct subnet_pool_def *d =3D t->options=2Esubnet_po=
ols; d; d =3D d->next)
+    {
+        multi_get_group_pool(m, &t->options,=
 d->name);
+    }
+
     /*
      * Help us keep track of routing table=2E
=
      */
@@ -625,7 +648,8 @@
 
         schedule_remove_entry(m->schedule, =
(struct schedule_entry *)mi);
 
-        ifconfig_pool_release(m->ifconfig_=
pool, mi->vaddr_handle, false);
+        ifconfig_pool_release(mi->vaddr_po=
ol ? mi->vaddr_pool : m->ifconfig_pool, mi->vaddr_handle,
+                =
              false);
 
         if (mi->did_iroutes)
         {
@@ -707,6 =
+731,14 @@
         schedule_free(m->schedule);
         mbuf_free(m->mbuf)=
;
         ifconfig_pool_free(m->ifconfig_pool);
+        while (m->subnet_=
pools)
+        {
+            struct subnet_pool *sp =3D m->subnet_pools;
=
+
+            m->subnet_pools =3D sp->next;
+            ifconfig_pool_fre=
e(sp->pool);
+            free(sp);
+        }
         frequency_limit_fre=
e(m->new_connection_limiter);
         initial_rate_limit_free(m->initial_r=
ate_limiter);
         multi_reap_free(m->reaper);
@@ -1405,6 +1437,12 @@
 =
    const struct options *o =3D &c->options;
     if (o->push_ifconfig_cons=
traint_defined && c->c2=2Epush_ifconfig_defined)
     {
+        /* a subne=
t-pool client is validated against its own subnet */
+        if (o->subnet=
_pool_defined)
+        {
+            return (o->subnet_pool_netmask & c->=
c2=2Epush_ifconfig_local)
+                   =3D=3D o->subnet_pool_network=
;
+        }
         return (o->push_ifconfig_constraint_netmask & c->c2=
=2Epush_ifconfig_local)
                =3D=3D o->push_ifconfig_constraint_=
network;
     }
@@ -1415,6 +1453,40 @@
 }
 
 /*
+ * Return the dynamic pool=
 serving the clients assigned to <name>, creating it
+ * from the matching =
--subnet-pool definition in <o> if it does not exist yet
+ * (which only ha=
ppens when multi_init() creates every pool at startup)=2E
+ */
+static stru=
ct ifconfig_pool *
+multi_get_group_pool(struct multi_context *m, const str=
uct options *o, const char *name)
+{
+    struct subnet_pool *sp;
+
+    fo=
r (sp =3D m->subnet_pools; sp; sp =3D sp->next)
+    {
+        if (!strcmp=
(sp->name, name))
+        {
+            return sp->pool;
+        }
+    =
}
+
+    const struct subnet_pool_def *d4 =3D subnet_pool_by_name(o->subnet=
_pools, name);
+    ASSERT(d4);
+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool=
);
+    sp->name =3D d4->name;
+    /* the configured dynamic range, or els=
e every host address of the
+     * subnet, minus the gateway reserved belo=
w if it falls inside it */
+    const in_addr_t start =3D d4->pool_start ? =
d4->pool_start : d4->network + 1;
+    const in_addr_t end =3D d4->pool_end=
 ? d4->pool_end : (d4->network | ~d4->netmask) - 1;
+    sp->pool =3D ifcon=
fig_pool_init(true, IFCONFIG_POOL_INDIV, start, end, o->duplicate_cn, false=
,
+                                  in6addr_any, 0);
+    ifconfig_pool_re=
serve_ip(sp->pool, d4->gateway);
+    sp->next =3D m->subnet_pools;
+    m-=
>subnet_pools =3D sp;
+    return sp->pool;
+}
+
+/*
  * Select a virtual a=
ddress for a new client instance=2E
  * Use an --ifconfig-push directive, i=
f given (static IP)=2E
  * Otherwise use an --ifconfig-pool address (dynami=
c IP)=2E
@@ -1424,6 +1496,25 @@
 {
     struct gc_arena gc =3D gc_new();
 
=
+    /* resolve --subnet-pool-name against the main-config --subnet-pool li=
st (an
+     * unknown name is rejected with AUTH_FAILED in multi_connectio=
n_established)=2E
+     * This runs again after every client-connect handle=
r, and a later handler
+     * (script, plugin, management) may override th=
e name set by the CCD file,
+     * so always resolve the current name=2E *=
/
+    if (mi->context=2Eoptions=2Esubnet_pool_name)
+    {
+        const =
struct subnet_pool_def *d =3D
+            subnet_pool_by_name(m->top=2Eopt=
ions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_name);
+
+        =
mi->context=2Eoptions=2Esubnet_pool_defined =3D d !=3D NULL;
+        if (d=
)
+        {
+            mi->context=2Eoptions=2Esubnet_pool_network =3D d=
->network;
+            mi->context=2Eoptions=2Esubnet_pool_netmask =3D d->=
netmask;
+            mi->context=2Eoptions=2Esubnet_pool_gateway =3D d->ga=
teway;
+        }
+    }
+
     /*
      * If ifconfig addresses were set b=
y dynamic config file,
      * release pool addresses, otherwise keep them=
=2E
@@ -1434,8 +1525,10 @@
          * release dynamic allocation */
      =
   if (mi->vaddr_handle >=3D 0)
         {
-            ifconfig_pool_relea=
se(m->ifconfig_pool, mi->vaddr_handle, true);
+            ifconfig_pool_re=
lease(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
+                =
                  mi->vaddr_handle, true);
             mi->vaddr_handle =
=3D -1;
+            mi->vaddr_pool =3D NULL;
         }
 
         mi->con=
text=2Ec2=2Epush_ifconfig_defined =3D true;
@@ -1455,6 +1548,52 @@
        =
         "MULTI_sva: WARNING: if --ifconfig-push is used for IPv4, automati=
c IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  Use --ifconfi=
g-ipv6-push for IPv6 then=2E");
         }
     }
+    else if (mi->context=
=2Eoptions=2Esubnet_pool_defined)
+    {
+        /* dynamic address from t=
his client's --subnet-pool group */
+        struct ifconfig_pool *group =
=3D
+            multi_get_group_pool(m, &m->top=2Eoptions, mi->context=2Eo=
ptions=2Esubnet_pool_name);
+
+        /* the address may have been acquire=
d before the name was known (from
+         * the global pool) or for a nam=
e that a later handler overrode: drop
+         * it so we serve this clien=
t from its current group */
+        if (mi->vaddr_handle >=3D 0 && mi->vad=
dr_pool !=3D group)
+        {
+            ifconfig_pool_release(mi->vaddr=
_pool ? mi->vaddr_pool : m->ifconfig_pool,
+                               =
   mi->vaddr_handle, true);
+            mi->vaddr_handle =3D -1;
+        =
    mi->vaddr_pool =3D NULL;
+            /* both addresses of the dropped =
slot go back to its pool */
+            mi->context=2Ec2=2Epush_ifconfig_d=
efined =3D false;
+            mi->context=2Ec2=2Epush_ifconfig_ipv6_define=
d =3D false;
+        }
+
+        if (mi->vaddr_handle < 0)
+        {
+  =
          in_addr_t local =3D 0, remote =3D 0;
+            const char *cn =
=3D NULL;
+
+            if (!mi->context=2Eoptions=2Eduplicate_cn)
+      =
      {
+                cn =3D tls_common_name(mi->context=2Ec2=2Etls_mult=
i, true);
+            }
+
+            mi->vaddr_pool =3D group;
+        =
    mi->vaddr_handle =3D ifconfig_pool_acquire(mi->vaddr_pool, &local, &rem=
ote, NULL, cn);
+            if (mi->vaddr_handle >=3D 0)
+            {
+ =
               mi->context=2Ec2=2Epush_ifconfig_local =3D remote;
+        =
        mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
+              =
      mi->context=2Eoptions=2Esubnet_pool_netmask;
+                mi->con=
text=2Ec2=2Epush_ifconfig_defined =3D true;
+            }
+            els=
e
+            {
+                msg(D_MULTI_ERRORS, "MULTI: no free --sub=
net-pool addresses are available for %s",
+                    multi_instan=
ce_string(mi, false, &gc));
+            }
+        }
+    }
     else if (=
m->ifconfig_pool && mi->vaddr_handle < 0) /* otherwise, choose a pool addre=
ss */
     {
         in_addr_t local =3D 0, remote =3D 0;
@@ -2360,10 +249=
9,9 @@
         const char *ifconfig_constraint_netmask =3D
             pr=
int_in_addr_t(mi->context=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, =
&gc);
 
-        /* JYFIXME -- this should cause the connection to fail */
=
         msg(D_MULTI_ERRORS,
-            "MULTI ERROR: primary virtual IP =
for %s (%s) "
-            "violates tunnel network/netmask constraint (%s/=
%s)",
+            "WARNING: primary virtual IP for %s (%s) "
+            =
"violates tunnel network/netmask constraint (%s/%s) and may not work",
    =
         multi_instance_string(mi, false, &gc),
             print_in_addr_=
t(mi->context=2Ec2=2Epush_ifconfig_local, 0, &gc),
             ifconfig_co=
nstraint_network, ifconfig_constraint_netmask);
@@ -2471,6 +2609,7 @@
 
   =
  /* reset pool handle to null */
     mi->vaddr_handle =3D -1;
+    mi->va=
ddr_pool =3D NULL;
 
     /* do --client-connect setenvs */
     multi_sele=
ct_virtual_addr(m, mi);
@@ -2792,6 +2931,15 @@
         cc_succeeded =3D fa=
lse;
     }
 
+    if (mi->context=2Eoptions=2Esubnet_pool_name
+        &&=
 !subnet_pool_by_name(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoption=
s=2Esubnet_pool_name))
+    {
+        msg(D_MULTI_ERRORS, "MULTI: client h=
as been rejected due to unknown --subnet-pool-name '%s'",
+            mi->=
context=2Eoptions=2Esubnet_pool_name);
+        auth_set_client_reason(mi->=
context=2Ec2=2Etls_multi, "unknown subnet-pool-name");
+        cc_succeede=
d =3D false;
+    }
+
     if (cc_succeeded)
     {
         multi_client_c=
onnect_late_setup(m, mi, *option_types_found);
diff --git a/src/openvpn/mul=
ti=2Eh b/src/openvpn/multi=2Eh
index 5db7147=2E=2E14f71dd 100644
--- a/src/=
openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -121,6 +121,8 @@
     stru=
ct mroute_addr real; /**< External network address of the
                 =
              *   remote peer=2E */
     ifconfig_pool_handle vaddr_handle;=

+    /* pool vaddr_handle belongs to (NULL =3D the global one) */
+    str=
uct ifconfig_pool *vaddr_pool;
     char msg_prefix[MULTI_PREFIX_MAX_LENGTH=
];
 
     /* queued outgoing data in Server/TCP mode */
@@ -190,6 +192,8 @@=

                                         *   instances=2E */
     struct m=
ulti_io *multi_io;         /**< I/O state and events tracker */
     struct=
 ifconfig_pool *ifconfig_pool;
+    /* per-group --subnet-pool dynamic pool=
s */
+    struct subnet_pool *subnet_pools;
     struct frequency_limit *ne=
w_connection_limiter;
     struct initial_packet_rate_limit *initial_rate_l=
imiter;
     struct mroute_helper *route_helper;
diff --git a/src/openvpn/o=
ptions=2Ec b/src/openvpn/options=2Ec
index 8e0c602=2E=2Ecae6a28 100644
--- =
a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -453,6 +453,12 @=
@
     "                  If seconds=3D0, file will be treated as read-only=
=2E\n"
     "--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network =
block\n"
     "                  to be dynamically allocated to connecting =
clients=2E\n"
+    "--subnet-pool name network netmask [gateway [start end]=
] : Define a named\n"
+    "                  pool of addresses outside the=
 --server network, selected\n"
+    "                  per client with --su=
bnet-pool-name=2E start/end restrict the\n"
+    "                  dynamic=
ally assigned range=2E\n"
+    "--subnet-pool-name name : Assign this clien=
t to the --subnet-pool named name=2E\n"
+    "                  Only valid =
in a client-specific config file=2E\n"
     "--ifconfig-push local remote-n=
etmask : Push an ifconfig option to remote,\n"
     "                  over=
rides --ifconfig-pool dynamic allocation=2E\n"
     "                  Only=
 valid in a client-specific config file=2E\n"
@@ -1899,6 +1905,20 @@
      =
   {
             msg(M_USAGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6"=
);
         }
+        if (options->subnet_pools)
+        {
+            i=
f (!options->server_defined)
+            {
+                msg(M_USAGE, "=
--subnet-pool requires --server");
+            }
+            if (dev_type=
_enum(options->dev, options->dev_type) !=3D DEV_TYPE_TUN
+                |=
| options->topology !=3D TOP_SUBNET)
+            {
+                msg(M_=
USAGE, "--subnet-pool requires --dev tun and --topology subnet");
+        =
    }
+            subnet_pools_check(options->subnet_pools, options->serve=
r_network,
+                               options->server_netmask, M_USAGE=
);
+        }
         MUST_BE_UNDEF(allow_recursive_routing, "allow-recurs=
ive-routing");
         if (options->auth_user_pass_file)
         {
@@ -19=
65,6 +1985,7 @@
         MUST_BE_UNDEF(ifconfig_pool_defined, "ifconfig-poo=
l");
         MUST_BE_UNDEF(ifconfig_pool_persist_filename, "ifconfig-pool-=
persist");
         MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, "ifconfig-ipv=
6-pool");
+        MUST_BE_UNDEF(subnet_pools, "subnet-pool");
         MUS=
T_BE_UNDEF(real_hash_size, "hash-size");
         MUST_BE_UNDEF(virtual_has=
h_size, "hash-size");
         MUST_BE_UNDEF(learn_address_script, "learn-a=
ddress");
@@ -3097,6 +3118,28 @@
     }
 }
 
+/*
+ * The server's tun devic=
e is only configured with the --server network, so
+ * route each --subnet-=
pool network into it as well: without this the server
+ * could not reach i=
ts subnet-pool clients when the data channel runs in
+ * userspace=2E  Unde=
r DCO on Linux and FreeBSD the routes are installed on-link,
+ * see subnet=
_pool_routes_onlink()=2E
+ */
+static void
+options_postprocess_subnet_pool=
_routes(struct options *o)
+{
+    for (const struct subnet_pool_def *d =3D=
 o->subnet_pools; d; d =3D d->next)
+    {
+        struct route_option *ro=
;
+
+        rol_check_alloc(o);
+        ro =3D add_route_to_option_list(o=
->routes, print_in_addr_t(d->network, 0, &o->gc),
+                        =
              print_in_addr_t(d->netmask, 0, &o->gc), NULL, NULL,
+        =
                              o->route_default_table_id);
+        ro->on_l=
ink =3D subnet_pool_routes_onlink(o);
+    }
+}
+
 static void
 options_pos=
tprocess_mutate(struct options *o, struct env_set *es)
 {
@@ -3232,6 +3275,=
12 @@
         /* check if any option should force disabling DCO */
       =
  o->disable_dco =3D !dco_check_option(D_DCO, o) || !dco_check_startup_opti=
on(D_DCO, o);
     }
+
+    if (o->mode =3D=3D MODE_SERVER)
+    {
+       =
 /* how the pools are routed depends on the DCO decision above */
+        =
options_postprocess_subnet_pool_routes(o);
+    }
 #ifdef USE_COMP
     if =
(dco_enabled(o))
     {
@@ -6219,6 +6268,57 @@
             goto err;
     =
    }
     }
+    else if (streq(p[0], "subnet-pool") && p[1] && p[2] && p[=
3] && (!p[5] || p[6]) && !p[7])
+    {
+        struct subnet_pool_def *sp;=

+        in_addr_t network, netmask;
+
+        VERIFY_PERMISSION(OPT_P_GE=
NERAL);
+        network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, =
p[2], 0, NULL, NULL);
+        netmask =3D getaddr(GETADDR_HOST_ORDER, p[3]=
, 0, NULL, NULL);
+        if (!network || !netmask)
+        {
+          =
  msg(msglevel, "cannot parse --subnet-pool addresses");
+            goto =
err;
+        }
+        ALLOC_OBJ_CLEAR_GC(sp, struct subnet_pool_def, &op=
tions->gc);
+        sp->name =3D p[1];
+        sp->network =3D network & =
netmask;
+        sp->netmask =3D netmask;
+        sp->gateway =3D (networ=
k & netmask) + 1;
+        if (p[4])
+        {
+            bool ok =3D fa=
lse;
+
+            sp->gateway =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RE=
SOLVE, p[4], 0, &ok, NULL);
+            if (!ok)
+            {
+         =
       msg(msglevel, "cannot parse --subnet-pool gateway");
+              =
  goto err;
+            }
+        }
+        /* optional range of the dyn=
amic pool, validated in
+         * subnet_pools_check(); unset, it spans t=
he whole subnet */
+        if (p[5])
+        {
+            bool ok_start=
 =3D false, ok_end =3D false;
+
+            sp->pool_start =3D getaddr(GET=
ADDR_HOST_ORDER, p[5], 0, &ok_start, NULL);
+            sp->pool_end =3D g=
etaddr(GETADDR_HOST_ORDER, p[6], 0, &ok_end, NULL);
+            if (!ok_st=
art || !ok_end)
+            {
+                msg(msglevel, "cannot parse=
 --subnet-pool range");
+                goto err;
+            }
+        =
}
+        sp->next =3D options->subnet_pools;
+        options->subnet_poo=
ls =3D sp;
+    }
+    else if (streq(p[0], "subnet-pool-name") && p[1] && =
!p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_INSTANCE);
+        options-=
>subnet_pool_name =3D p[1];
+    }
     else if (streq(p[0], "ifconfig-push=
-constraint") && p[1] && p[2] && !p[3])
     {
         in_addr_t network, =
netmask;
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
ind=
ex c58530a=2E=2Efcfb9e2 100644
--- a/src/openvpn/options=2Eh
+++ b/src/open=
vpn/options=2Eh
@@ -252,6 +252,21 @@
     struct verify_hash_list *next;
 }=
;
 
+/* A named --subnet-pool: a subnet clients can be assigned from, refer=
enced
+ * from a CCD file by its name via --subnet-pool-name=2E */
+struct =
subnet_pool_def
+{
+    struct subnet_pool_def *next;
+    const char *name=
;
+    in_addr_t network;
+    in_addr_t netmask;
+    in_addr_t gateway;
+=
    /* optional range of the dynamic pool (0/0: every host address of the
+=
     * subnet); addresses outside it are left for static --ifconfig-push */=

+    in_addr_t pool_start;
+    in_addr_t pool_end;
+};
+
 /* Command line=
 options */
 struct options
 {
@@ -518,6 +533,12 @@
     bool push_ifconfig=
_constraint_defined;
     in_addr_t push_ifconfig_constraint_network;
     =
in_addr_t push_ifconfig_constraint_netmask;
+    struct subnet_pool_def *su=
bnet_pools; /* named pools (server config) */
+    const char *subnet_pool_=
name;         /* which pool this client uses (CCD) */
+    bool subnet_pool=
_defined;             /* resolved from the name at connect */
+    in_addr_=
t subnet_pool_network;
+    in_addr_t subnet_pool_netmask;
+    in_addr_t s=
ubnet_pool_gateway;
     bool push_ifconfig_ipv4_blocked;           /* IPv4=
 */
     bool push_ifconfig_ipv6_defined;           /* IPv6 */
     struct =
in6_addr push_ifconfig_ipv6_local;  /* IPv6 */
@@ -979,4 +1000,23 @@
 #endi=
f /* ENABLE_DCO */
 }
 
+/**
+ * Whether the routes of the --subnet-pool ne=
tworks are installed on-link on
+ * the DCO device rather than via a gatewa=
y=2E  With DCO on Linux and FreeBSD the
+ * kernel selects the peer by a ro=
ute's next hop, so a route via a gateway
+ * would deliver every packet for=
 an unassigned pool address to the client
+ * owning that gateway address; =
on-link, such a packet matches no peer, while
+ * each pool client gets its=
 own on-link host route when it connects (see
+ * multi_learn_in_addr_t())=
=2E
+ */
+static inline bool
+subnet_pool_routes_onlink(const struct option=
s *o)
+{
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    return =
dco_enabled(o);
+#else
+    return false;
+#endif
+}
+
 #endif /* ifndef OP=
TIONS_H */
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_=
util=2Ec
index d25d85c=2E=2Ebb52fe7 100644
--- a/src/openvpn/options_util=
=2Ec
+++ b/src/openvpn/options_util=2Ec
@@ -30,6 +30,105 @@
 #include "opti=
ons_util=2Eh"
 
 #include "push=2Eh"
+#include "pool=2Eh"
+
+const struct s=
ubnet_pool_def *
+subnet_pool_by_name(const struct subnet_pool_def *pools, =
const char *name)
+{
+    for (const struct subnet_pool_def *d =3D pools; d=
; d =3D d->next)
+    {
+        if (!strcmp(d->name, name))
+        {
+  =
          return d;
+        }
+    }
+    return NULL;
+}
+
+/* true if th=
e two IPv4 subnets share at least one address */
+static bool
+subnets_over=
lap(in_addr_t a, in_addr_t mask_a, in_addr_t b, in_addr_t mask_b)
+{
+    c=
onst in_addr_t mask =3D mask_a & mask_b;
+
+    return (a & mask) =3D=3D (b=
 & mask);
+}
+
+bool
+subnet_pools_check(const struct subnet_pool_def *pool=
s, in_addr_t server_network,
+                   in_addr_t server_netmask, =
msglvl_t msglevel)
+{
+    for (const struct subnet_pool_def *d =3D pools; =
d; d =3D d->next)
+    {
+        const in_addr_t host =3D ~d->netmask;
+  =
      int netbits =3D 32;
+
+        /* the netmask must be contiguous */
+=
        if (host & (host + 1))
+        {
+            msg(msglevel, "--sub=
net-pool %s: invalid netmask", d->name);
+            return false;
+      =
  }
+        for (in_addr_t h =3D host; h; h >>=3D 1)
+        {
+         =
   netbits--;
+        }
+
+        /* same bounds as --server: the pool mu=
st hold at least 2 addresses
+         * besides network, gateway and broad=
cast, and fit IFCONFIG_POOL_MAX */
+        if (netbits < IFCONFIG_POOL_MIN=
_NETBITS || netbits > 29)
+        {
+            msg(msglevel, "--subnet-p=
ool %s: netmask must be between /%d and /29 (not /%d)",
+                d-=
>name, IFCONFIG_POOL_MIN_NETBITS, netbits);
+            return false;
+   =
     }
+
+        if ((d->gateway & d->netmask) !=3D d->network || d->gatew=
ay =3D=3D d->network
+            || d->gateway =3D=3D (d->network | host))=

+        {
+            msg(msglevel, "--subnet-pool %s: gateway must be a=
 host address inside the subnet",
+                d->name);
+            r=
eturn false;
+        }
+
+        /* an explicit dynamic range must be mad=
e of host addresses of the
+         * subnet and hold at least the 2 entri=
es an ifconfig pool needs */
+        if ((d->pool_start || d->pool_end)
+ =
           && ((d->pool_start & d->netmask) !=3D d->network
+              =
  || (d->pool_end & d->netmask) !=3D d->network || d->pool_start =3D=3D d->=
network
+                || d->pool_end =3D=3D (d->network | host) || d->po=
ol_start >=3D d->pool_end))
+        {
+            msg(msglevel,
+        =
        "--subnet-pool %s: range start and end must be host addresses insid=
e the "
+                "subnet, with start lower than end",
+            =
    d->name);
+            return false;
+        }
+
+        if (server_n=
etmask
+            && subnets_overlap(d->network, d->netmask, server_netwo=
rk, server_netmask))
+        {
+            msg(msglevel, "--subnet-pool %=
s: subnet overlaps the --server network", d->name);
+            return fal=
se;
+        }
+
+        for (const struct subnet_pool_def *e =3D d->next;=
 e; e =3D e->next)
+        {
+            if (!strcmp(d->name, e->name))
+=
            {
+                msg(msglevel, "--subnet-pool %s: name define=
d more than once", d->name);
+                return false;
+            }
=
+            if (subnets_overlap(d->network, d->netmask, e->network, e->net=
mask))
+            {
+                msg(msglevel, "--subnet-pool %s and =
%s: subnets overlap", d->name, e->name);
+                return false;
+  =
          }
+        }
+    }
+
+    return true;
+}
 
 const char *
 parse=
_auth_failed_temp(struct options *o, const char *reason)
diff --git a/src/o=
penvpn/options_util=2Eh b/src/openvpn/options_util=2Eh
index 5226a6f=2E=2E5=
fa4735 100644
--- a/src/openvpn/options_util=2Eh
+++ b/src/openvpn/options_=
util=2Eh
@@ -28,6 +28,33 @@
 
 const char *parse_auth_failed_temp(struct op=
tions *o, const char *reason);
 
+/**
+ * Look up a named --subnet-pool in =
a list of pool definitions=2E
+ *
+ * @param pools  head of the --subnet-po=
ol list (may be NULL)
+ * @param name    the --subnet-pool-name to match
+ =
* @return       the matching pool definition, or NULL if none matches
+ */
=
+const struct subnet_pool_def *subnet_pool_by_name(const struct subnet_pool=
_def *pools,
+                                                  const char =
*name);
+
+/**
+ * Validate the --subnet-pool definitions: contiguous netma=
sk between
+ * /IFCONFIG_POOL_MIN_NETBITS and /29, gateway a host address i=
nside its
+ * subnet, an explicit dynamic range made of at least 2 host add=
resses of the
+ * subnet,
+ * unique names, and no subnet overlapping anoth=
er pool or the --server
+ * network=2E
+ *
+ * @param pools           head =
of the --subnet-pool list (may be NULL)
+ * @param server_network  the --se=
rver network (host order)
+ * @param server_netmask  the --server netmask, =
or 0 if there is none
+ * @param msglevel        level of the message logge=
d on the first error
+ * @return                true if every definition is=
 valid
+ */
+bool subnet_pools_check(const struct subnet_pool_def *pools, i=
n_addr_t server_network,
+                        in_addr_t server_netmask,=
 msglvl_t msglevel);
+
 
 /** Checks if the string is a valid integer by ch=
ecking if it can be
  *  converted to an integer */
diff --git a/src/openvp=
n/pool=2Ec b/src/openvpn/pool=2Ec
index fff0e3f=2E=2E5c5b3fe 100644
--- a/s=
rc/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -351,7 +351,7 @@
 {
     =
bool ret =3D false;
 
-    if (pool && hand >=3D 0 && hand < pool->size)
+ =
   if (pool && hand >=3D 0 && hand < pool->size && !pool->list[hand]=2Erese=
rved)
     {
         ifconfig_pool_entry_free(&pool->list[hand], hard);
  =
       ret =3D true;
@@ -430,6 +430,22 @@
     return ret;
 }
 
+bool
+ifco=
nfig_pool_reserve_ip(struct ifconfig_pool *pool, const in_addr_t addr)
+{
+=
    const ifconfig_pool_handle h =3D ifconfig_pool_ip_base_to_handle(pool, =
addr);
+
+    if (h < 0)
+    {
+        return false;
+    }
+
+    ifconf=
ig_pool_entry_free(&pool->list[h], true);
+    pool->list[h]=2Ein_use =3D t=
rue;
+    pool->list[h]=2Ereserved =3D true;
+    return true;
+}
+
 static=
 in_addr_t
 ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *poo=
l, ifconfig_pool_handle hand)
 {
@@ -477,6 +493,13 @@
                   co=
nst bool fixed)
 {
     struct ifconfig_pool_entry *e =3D &pool->list[h];
+=

+    if (e->reserved)
+    {
+        msg(M_WARN, "pool: ignoring persiste=
d entry for CN=3D%s: its address is reserved", cn);
+        return;
+    }=

+
     ifconfig_pool_entry_free(e, true);
     e->in_use =3D false;
     e=
->common_name =3D string_alloc(cn, NULL);
diff --git a/src/openvpn/pool=2Eh=
 b/src/openvpn/pool=2Eh
index e2d3f82=2E=2E497dcda 100644
--- a/src/openvpn=
/pool=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -43,6 +43,7 @@
     char *common_na=
me;
     time_t last_release;
     bool fixed;
+    bool reserved; /* never=
 handed out, e=2Eg=2E a --subnet-pool gateway */
 };
 
 struct ifconfig_poo=
l
@@ -86,6 +87,17 @@
 
 bool ifconfig_pool_release(struct ifconfig_pool *po=
ol, ifconfig_pool_handle hand, const bool hard);
 
+/**
+ * Permanently res=
erve the pool slot holding \c addr, so that it is never
+ * handed out to a=
 client nor taken over by a persisted entry (e=2Eg=2E the
+ * gateway of a =
--subnet-pool)=2E
+ *
+ * @param pool  the pool
+ * @param addr  IPv4 addre=
ss (host order) to reserve
+ * @return      true if \c addr lies in the poo=
l and was reserved
+ */
+bool ifconfig_pool_reserve_ip(struct ifconfig_pool=
 *pool, in_addr_t addr);
+
 struct ifconfig_pool_persist *ifconfig_pool_per=
sist_init(const char *filename, int refresh_freq);
 
 void ifconfig_pool_pe=
rsist_close(struct ifconfig_pool_persist *persist);
diff --git a/src/openvp=
n/route=2Ec b/src/openvpn/route=2Ec
index 0bce966=2E=2Efecef7e 100644
--- a=
/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -408,6 +408,11 @@
   =
      r->flags |=3D RT_METRIC_DEFINED;
     }
 
+    if (ro->on_link)
+    =
{
+        r->flags |=3D RT_ON_LINK;
+    }
+
     r->flags |=3D RT_DEFINED=
;
 
     /* routing table id */
@@ -478,12 +483,12 @@
     return false;
 }=

 
-void
+struct route_option *
 add_route_to_option_list(struct route_opti=
on_list *l, const char *network, const char *netmask,
                     =
     const char *gateway, const char *metric, int table_id)
 {
     struct =
route_option *ro;
-    ALLOC_OBJ_GC(ro, struct route_option, l->gc);
+    A=
LLOC_OBJ_CLEAR_GC(ro, struct route_option, l->gc);
     ro->network =3D net=
work;
     ro->netmask =3D netmask;
     ro->gateway =3D gateway;
@@ -491,6=
 +496,7 @@
     ro->table_id =3D table_id;
     ro->next =3D l->routes;
   =
  l->routes =3D ro;
+    return ro;
 }
 
 void
@@ -1322,7 +1328,11 @@
     =
{
         setenv_route_addr(es, "network", r->network, i);
         setenv=
_route_addr(es, "netmask", r->netmask, i);
-        setenv_route_addr(es, "=
gateway", r->gateway, i);
+        /* an on-link route has no gateway */
+ =
       if (!(r->flags & RT_ON_LINK))
+        {
+            setenv_route_a=
ddr(es, "gateway", r->gateway, i);
+        }
 
         if (r->flags & RT_=
METRIC_DEFINED)
         {
@@ -1478,6 +1488,7 @@
 
 #if defined(TARGET_LINU=
X)
     const char *iface =3D NULL;
+    const in_addr_t *gateway =3D &r->g=
ateway;
     int metric =3D -1;
 
     if (is_on_link(is_local_route, flags=
, rgi))
@@ -1485,6 +1496,12 @@
         iface =3D rgi->iface;
     }
 
+   =
 if ((r->flags & RT_ON_LINK) && tt)
+    {
+        gateway =3D NULL;
+    =
    iface =3D tt->actual_name;
+    }
+
     if (r->flags & RT_METRIC_DEFIN=
ED)
     {
         metric =3D r->metric;
@@ -1492,8 +1509,8 @@
 
 
     st=
atus =3D RTA_SUCCESS;
-    int ret =3D net_route_v4_add(ctx, &r->network, n=
etmask_to_netbits2(r->netmask), &r->gateway,
-                             =
  iface, r->table_id, metric);
+    int ret =3D net_route_v4_add(ctx, &r->n=
etwork, netmask_to_netbits2(r->netmask), gateway, iface,
+                 =
              r->table_id, metric);
     if (ret =3D=3D -EEXIST)
     {
   =
      msg(D_ROUTE, "NOTE: Linux route add command failed because route exis=
ts");
@@ -1616,7 +1633,15 @@
     }
 #endif
 
-    argv_printf_cat(&argv, "=
-net %s %s %s", network, gateway, netmask);
+    if ((r->flags & RT_ON_LINK=
) && tt)
+    {
+        argv_printf_cat(&argv, "-net %s/%d -iface %s", net=
work, netmask_to_netbits2(r->netmask),
+                        tt->actual_=
name);
+    }
+    else
+    {
+        argv_printf_cat(&argv, "-net %s %s =
%s", network, gateway, netmask);
+    }
 
     /* FIXME -- add on-link supp=
ort for FreeBSD */
 
@@ -2035,7 +2060,16 @@
         metric =3D r->metric;
=
     }
 
-    if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r-=
>netmask), &r->gateway, NULL,
+    const in_addr_t *gateway =3D &r->gateway=
;
+    const char *iface =3D NULL;
+
+    if ((r->flags & RT_ON_LINK) && tt=
)
+    {
+        gateway =3D NULL;
+        iface =3D tt->actual_name;
+  =
  }
+
+    if (net_route_v4_del(ctx, &r->network, netmask_to_netbits2(r->ne=
tmask), gateway, iface,
                          r->table_id, metric)
    =
     < 0)
     {
@@ -2091,7 +2125,15 @@
 
 #elif defined(TARGET_FREEBSD)
 
=
-    argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gat=
eway, netmask);
+    if ((r->flags & RT_ON_LINK) && tt)
+    {
+        arg=
v_printf(&argv, "%s delete -net %s/%d -iface %s", ROUTE_PATH, network,
+   =
                 netmask_to_netbits2(r->netmask), tt->actual_name);
+    }
=
+    else
+    {
+        argv_printf(&argv, "%s delete -net %s %s %s", ROU=
TE_PATH, network, gateway, netmask);
+    }
 
     argv_msg(D_ROUTE, &argv)=
;
     openvpn_execve_check(&argv, es, 0, "ERROR: FreeBSD route delete comm=
and failed");
diff --git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh
in=
dex 0d33d36=2E=2E7c5528f 100644
--- a/src/openvpn/route=2Eh
+++ b/src/openv=
pn/route=2Eh
@@ -80,6 +80,10 @@
     const char *gateway;
     int table_id=
;
     const char *metric;
+    /* on Linux and FreeBSD, install the route =
on-link on the tun device
+     * instead of via the gateway (needed under =
DCO, where the kernel selects
+     * the peer by the route's next hop) */
=
+    bool on_link;
 };
 
 /* redirect-gateway flags */
@@ -120,6 +124,7 @@
=
 #define RT_DEFINED        (1u << 0)
 #define RT_ADDED          (1u << 1)
 =
#define RT_METRIC_DEFINED (1u << 2)
+#define RT_ON_LINK        (1u << 3) /*=
 see struct route_option=2Eon_link */
     struct route_ipv4 *next;
     un=
signed int flags;
     const struct route_option *option;
@@ -311,8 +316,9 =
@@
                const struct route_gateway_info *rgi, const struct env_s=
et *es,
                openvpn_net_ctx_t *ctx);
 
-void add_route_to_optio=
n_list(struct route_option_list *l, const char *network, const char *netmas=
k,
-                              const char *gateway, const char *metric, =
int table_id);
+struct route_option *add_route_to_option_list(struct route_=
option_list *l, const char *network,
+                                     =
         const char *netmask, const char *gateway,
+                       =
                       const char *metric, int table_id);
 
 void add_route=
_ipv6_to_option_list(struct route_ipv6_option_list *l, const char *prefix,
=
                                    const char *gateway, const char *metric=
, int table_id);
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/test=
s/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=2E5f2a75b 100644
--- a/=
tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makef=
ile=2Eam
@@ -392,6 +392,7 @@
 
 misc_testdriver_SOURCES =3D test_misc=2Ec \=

 	test_schedule=2Ec test_schedule=2Eh \
+	test_subnet_pool=2Ec test_subnet=
_pool=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	mock_get_random=2Ec \
 	$(t=
op_srcdir)/src/compat/compat-strlcpy=2Ec \
diff --git a/tests/unit_tests/op=
envpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec
index aea40f0=
=2E=2E191ab2b 100644
--- a/tests/unit_tests/openvpn/test_misc=2Ec
+++ b/tes=
ts/unit_tests/openvpn/test_misc=2Ec
@@ -45,6 +45,7 @@
 #include "win32-util=
=2Eh"
 #endif
 #include "test_schedule=2Eh"
+#include "test_subnet_pool=2Eh=
"
 
 static void
 test_compat_lzo_string(void **state)
@@ -561,7 +562,12 @@=

     cmocka_unit_test(test_list),
     cmocka_unit_test(test_atoi_variants=
),
     cmocka_unit_test(schedule_test),
-    cmocka_unit_test(test_sid_has=
h_list)
+    cmocka_unit_test(test_sid_hash_list),
+    cmocka_unit_test(te=
st_subnet_pool_by_name),
+    cmocka_unit_test(test_subnet_pools_check_netm=
ask),
+    cmocka_unit_test(test_subnet_pools_check_gateway),
+    cmocka_u=
nit_test(test_subnet_pools_check_range),
+    cmocka_unit_test(test_subnet_=
pools_check_overlap),
 };
 
 int
diff --git a/tests/unit_tests/openvpn/test=
_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
new file m=
ode 100644
index 0000000=2E=2E7f40b74
--- /dev/null
+++ b/tests/unit_tests/=
openvpn/test_subnet_pool=2Ec
@@ -0,0 +1,160 @@
+/*
+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks
+ *             over a single UDP por=
t, with support for SSL/TLS-based
+ *             session authentication an=
d key exchange,
+ *             packet encryption, packet authentication, a=
nd
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVP=
N Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can=
 redistribute it and/or modify
+ *  it under the terms of the GNU General P=
ublic License version 2
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
+#ifdef HAVE_CONFIG_H=

+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdl=
ib=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "options=
=2Eh"
+#include "options_util=2Eh"
+#include "test_common=2Eh"
+#include "t=
est_subnet_pool=2Eh"
+#include "mock_msg=2Eh"
+
+/* --subnet-pool-name reso=
lves a client to its --subnet-pool; an unknown name
+ * returns NULL, which=
 is what makes the server reject that client=2E */
+void
+test_subnet_pool_=
by_name(void **state)
+{
+    struct subnet_pool_def c =3D { =2Enext =3D NU=
LL, =2Ename =3D "grpC", =2Enetwork =3D 0x0a020300, =2Enetmask =3D 0xffffff0=
0, =2Egateway =3D 0x0a020301 };
+    struct subnet_pool_def b =3D { =2Enext=
 =3D &c, =2Ename =3D "grpB", =2Enetwork =3D 0x0a020200, =2Enetmask =3D 0xff=
ffff00, =2Egateway =3D 0x0a020201 };
+    struct subnet_pool_def a =3D { =
=2Enext =3D &b, =2Ename =3D "grpA", =2Enetwork =3D 0x0a020100, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a020101 };
+
+    /* every configured nam=
e resolves to its own pool, wherever it sits */
+    assert_ptr_equal(subne=
t_pool_by_name(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_pool_by_name(=
&a, "grpB"), &b);
+    assert_ptr_equal(subnet_pool_by_name(&a, "grpC"), &c=
);
+
+    /* and it carries that pool's subnet/gateway */
+    const struct=
 subnet_pool_def *r =3D subnet_pool_by_name(&a, "grpB");
+    assert_int_eq=
ual(r->network, 0x0a020200);
+    assert_int_equal(r->netmask, 0xffffff00);=

+    assert_int_equal(r->gateway, 0x0a020201);
+
+    /* unknown name and =
empty list both miss */
+    assert_null(subnet_pool_by_name(&a, "nope"));
=
+    assert_null(subnet_pool_by_name(NULL, "grpA"));
+}
+
+/* a single pool=
 <net>/<mask> with gateway <gw>, checked against the
+ * 10=2E8=2E0=2E0/24 =
--server network */
+static bool
+check_one(in_addr_t net, in_addr_t mask, =
in_addr_t gw)
+{
+    struct subnet_pool_def d =3D { =2Enext =3D NULL, =2En=
ame =3D "grp", =2Enetwork =3D net, =2Enetmask =3D mask, =2Egateway =3D gw }=
;
+
+    return subnet_pools_check(&d, 0x0a080000, 0xffffff00, M_WARN);
+}
=
+
+/* --subnet-pool geometry: anything ifconfig_pool_init() cannot serve mu=
st be
+ * refused when the config is checked, not when the first client con=
nects */
+void
+test_subnet_pools_check_netmask(void **state)
+{
+    /* th=
e bounds of --server: /16 =2E=2E /29 */
+    assert_true(check_one(0x0a0900=
00, 0xffff0000, 0x0a090001));
+    assert_true(check_one(0x0a090000, 0xffff=
ff00, 0x0a090001));
+    assert_true(check_one(0x0a090000, 0xfffffff8, 0x0a=
090001));
+    /* /30, /31, /32: too few addresses for a pool */
+    asser=
t_false(check_one(0x0a090000, 0xfffffffc, 0x0a090001));
+    assert_false(c=
heck_one(0x0a090000, 0xfffffffe, 0x0a090001));
+    assert_false(check_one(=
0x0a090000, 0xffffffff, 0x0a090000));
+    /* /15: larger than IFCONFIG_POO=
L_MAX */
+    assert_false(check_one(0x0a080000, 0xfffe0000, 0x0a080001));
=
+    /* non-contiguous netmask */
+    assert_false(check_one(0x0a000900, 0=
xff00ff00, 0x0a000901));
+}
+
+void
+test_subnet_pools_check_gateway(void *=
*state)
+{
+    /* any host address of the subnet is fine, not only the fir=
st one */
+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a0900fe));
=
+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a090080));
+    /* ne=
twork address, broadcast address, outside the subnet */
+    assert_false(c=
heck_one(0x0a090000, 0xffffff00, 0x0a090000));
+    assert_false(check_one(=
0x0a090000, 0xffffff00, 0x0a0900ff));
+    assert_false(check_one(0x0a09000=
0, 0xffffff00, 0x0a0a0001));
+}
+
+/* a 10=2E9=2E0=2E0/24 pool with dynamic=
 range <start>-<end> */
+static bool
+check_range(in_addr_t start, in_addr_=
t end)
+{
+    struct subnet_pool_def d =3D { =2Enext =3D NULL, =2Ename =3D=
 "grp", =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =
=3D 0x0a090001, =2Epool_start =3D start, =2Epool_end =3D end };
+
+    retu=
rn subnet_pools_check(&d, 0x0a080000, 0xffffff00, M_WARN);
+}
+
+/* the opt=
ional dynamic range: host addresses of the subnet, at least 2 */
+void
+tes=
t_subnet_pools_check_range(void **state)
+{
+    /* unset: the whole subnet=
 */
+    assert_true(check_range(0, 0));
+    /* a sub-range, the smallest =
one, the whole host range */
+    assert_true(check_range(0x0a090064, 0x0a0=
900c8));
+    assert_true(check_range(0x0a090064, 0x0a090065));
+    assert=
_true(check_range(0x0a090001, 0x0a0900fe));
+    /* a single address, or st=
art past end */
+    assert_false(check_range(0x0a090064, 0x0a090064));
+  =
  assert_false(check_range(0x0a0900c8, 0x0a090064));
+    /* the network or=
 broadcast address */
+    assert_false(check_range(0x0a090000, 0x0a090064)=
);
+    assert_false(check_range(0x0a090064, 0x0a0900ff));
+    /* outside =
the subnet */
+    assert_false(check_range(0x0a090064, 0x0a0a0001));
+    =
assert_false(check_range(0x0a080064, 0x0a090064));
+}
+
+void
+test_subnet_=
pools_check_overlap(void **state)
+{
+    struct subnet_pool_def b =3D { =
=2Enext =3D NULL, =2Ename =3D "grpB", =2Enetwork =3D 0x0a0a0000, =2Enetmask=
 =3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };
+    struct subnet_pool_def a=
 =3D { =2Enext =3D &b, =2Ename =3D "grpA", =2Enetwork =3D 0x0a090000, =2Ene=
tmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
+
+    /* disjoint pools=
, disjoint from --server */
+    assert_true(subnet_pools_check(&a, 0x0a080=
000, 0xffffff00, M_WARN));
+
+    /* a pool inside the --server network =2E=
=2E=2E */
+    assert_false(subnet_pools_check(&a, 0x0a090000, 0xffffff00, =
M_WARN));
+    /* =2E=2E=2E or covering it */
+    assert_false(subnet_pool=
s_check(&a, 0x0a0a0080, 0xffffff80, M_WARN));
+    /* no --server network: =
only the pools are checked against each other */
+    assert_true(subnet_po=
ols_check(&a, 0, 0, M_WARN));
+
+    /* a /16 grpB containing grpA */
+    =
struct subnet_pool_def b16 =3D { =2Enext =3D NULL, =2Ename =3D "grpB", =2En=
etwork =3D 0x0a090000, =2Enetmask =3D 0xffff0000, =2Egateway =3D 0x0a090101=
 };
+    struct subnet_pool_def a16 =3D { =2Enext =3D &b16, =2Ename =3D "gr=
pA", =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0=
x0a090001 };
+    assert_false(subnet_pools_check(&a16, 0, 0, M_WARN));
+
+=
    /* the same name defined twice */
+    struct subnet_pool_def bdup =3D =
{ =2Enext =3D NULL, =2Ename =3D "grpA", =2Enetwork =3D 0x0a0a0000, =2Enetma=
sk =3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };
+    struct subnet_pool_def=
 adup =3D { =2Enext =3D &bdup, =2Ename =3D "grpA", =2Enetwork =3D 0x0a09000=
0, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
+    assert_fals=
e(subnet_pools_check(&adup, 0, 0, M_WARN));
+}
diff --git a/tests/unit_test=
s/openvpn/test_subnet_pool=2Eh b/tests/unit_tests/openvpn/test_subnet_pool=
=2Eh
new file mode 100644
index 0000000=2E=2E07ba374
--- /dev/null
+++ b/te=
sts/unit_tests/openvpn/test_subnet_pool=2Eh
@@ -0,0 +1,37 @@
+/*
+ *  OpenV=
PN -- An application to securely tunnel IP networks
+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based
+ *             session=
 authentication and key exchange,
+ *             packet encryption, packet=
 authentication, and
+ *             packet compression=2E
+ *
+ *  Copyrig=
ht (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free=
 software; you can redistribute it and/or modify
+ *  it under the terms of=
 the GNU General Public License version 2
+ *  as published by the Free Sof=
tware Foundation=2E
+ *
+ *  This program is distributed in the hope that i=
t will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied w=
arranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See=
 the
+ *  GNU General Public License for more details=2E
+ *
+ *  You shoul=
d have received a copy of the GNU General Public License along
+ *  with th=
is program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifnde=
f SUBNET_POOL_TEST_H
+#define SUBNET_POOL_TEST_H
+
+/* --subnet-pool tests,=
 run as part of misc_testdriver */
+
+void test_subnet_pool_by_name(void **=
state);
+
+void test_subnet_pools_check_netmask(void **state);
+
+void test=
_subnet_pools_check_gateway(void **state);
+
+void test_subnet_pools_check_=
range(void **state);
+
+void test_subnet_pools_check_overlap(void **state);=

+
+#endif

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
783?usp=3Demail
To unsubscribe, or for help writing mail filters, visit htt=
ps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpa=
tchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e=
7db95615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-Pat=
chSet: 11
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-=
Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank =
Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@g=
reenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--J148vkwa6e4=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli <strong>uploaded patch set #11</strong> to this change=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">multi: assign clients from a named subnet-pool<b=
r><br>Add two server directives:<br><br>  subnet-pool &lt;name&gt; &lt;netw=
ork&gt; &lt;netmask&gt; [&lt;gateway&gt; [&lt;start&gt; &lt;end&gt;]]<br>  =
                                                    (main config)<br>  subn=
et-pool-name &lt;name&gt;                             (per-client CCD)<br><=
br>so groups of clients can be given addresses from subnets other than the<=
br>--server network (per-group firewall rules under --topology subnet, and<=
br>thus DCO)=2E A client&#39;s subnet-pool-name is resolved to its pool and=
 served<br>a virtual IP from that subnet: a static --ifconfig-push within i=
t, or<br>the next free address from a dynamic per-group pool shared by name=
=2E The<br>dynamic pool spans the whole subnet unless a start-end range is =
given,<br>which leaves the rest of the subnet to static addresses (these ar=
e not<br>reserved in the pool)=2E Such a client is validated against its ow=
n subnet<br>instead of the global tunnel-network constraint and never falls=
 back to<br>the global pool; a name matching no configured pool is declined=
 with<br>AUTH_FAILED=2E The name is resolved again after every client-conne=
ct<br>handler, so a script, plugin or management interface may override the=
<br>one set by the CCD file=2E<br><br>The pools are checked when the config=
 is loaded, as for --server: the<br>netmask must be contiguous and between =
/16 and /29, the gateway a host<br>address inside the subnet, a range (if a=
ny) at least two host addresses<br>of the subnet, names unique, and no pool=
 may overlap another or the<br>--server network=2E Every pool is created at=
 startup, and its gateway is<br>reserved so it is never handed out to a cli=
ent=2E<br><br>The server routes each pool&#39;s subnet into its tun device,=
 as the device<br>is only configured with the --server network: without thi=
s the server<br>cannot reach its subnet-pool clients=2E This is a regular -=
-route, so it<br>is installed before privileges are dropped and honours --r=
oute-table,<br>--route-metric and --route-noexec=2E Under DCO on Linux and =
FreeBSD,<br>though, the kernel selects the peer by the route&#39;s next hop=
, so a route<br>via a gateway would deliver every packet for an unassigned =
pool address<br>to the client owning that gateway address: there the route =
is installed<br>on-link on the tun device instead (a new on_link route opti=
on flag), and<br>each client of the pool gets its own on-link host route on=
 connect (as<br>its address is outside the --ifconfig network), so such pac=
kets match<br>no peer=2E<br><br>While here, the tunnel-network constraint v=
iolation is logged as a<br>WARNING instead of MULTI ERROR, as it does not f=
ail the connection=2E<br><br>Change-Id: Ia1e7db95615d99ef9687de7c4e996dc803=
3e2631<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio Quar=
tulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M doc=
/man-sections/server-options=2Erst<br>M src/openvpn/multi=2Ec<br>M src/open=
vpn/multi=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>=
M src/openvpn/options_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M src/o=
penvpn/pool=2Ec<br>M src/openvpn/pool=2Eh<br>M src/openvpn/route=2Ec<br>M s=
rc/openvpn/route=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests=
/unit_tests/openvpn/test_misc=2Ec<br>A tests/unit_tests/openvpn/test_subnet=
_pool=2Ec<br>A tests/unit_tests/openvpn/test_subnet_pool=2Eh<br>16 files ch=
anged, 765 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1783/11</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 1=
84a95a=2E=2E8325846 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br=
><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -858,6 +858,7 @@</span><br=
><span>     target_sources(test_misc PRIVATE</span><br><span>         tests=
/unit_tests/openvpn/mock_get_random=2Ec</span><br><span>         tests/unit=
_tests/openvpn/test_schedule=2Ec</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><b=
r><span>         src/openvpn/options_util=2Ec</span><br><span>         src/=
openvpn/otime=2Ec</span><br><span>         src/openvpn/ssl_util=2Ec</span><=
br><span>diff --git a/doc/man-sections/server-options=2Erst b/doc/man-secti=
ons/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2Eb9ed47a 100644<=
/span><br><span>--- a/doc/man-sections/server-options=2Erst</span><br><span=
>+++ b/doc/man-sections/server-options=2Erst</span><br><span>@@ -330,6 +330=
,48 @@</span><br><span>   by ``--ifconfig``, OpenVPN will install a /32 hos=
t route for the ``local``</span><br><span>   IP address=2E</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+--subnet-pool args=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Define a named po=
ol of addresses from a subnet different from the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  ``--server`` network, so groups of clients c=
an be given IPs from separate</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  subnets for per-group firewall rules under ``--topology subnet`=
` (and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  therefore D=
CO)=2E This is a main-config directive and may be repeated to</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  define several pools=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  Valid syntax:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     subn=
et-pool name network netmask [gateway [start end]]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  ``name`` is what a client refers to with ``--subnet-pool-name=
``; ``gateway``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  de=
faults to the first address of ``network``/``netmask`` and is never</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  assigned to a client=2E A=
 client assigned to a pool receives (dynamically, or</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  via a static ``--ifconfig-push`` that m=
ust lie within the subnet) an address</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  from it, plus the matching netmask=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  Dynamic addresses are taken from ``start`` to ``end`` =
(every host address</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  of the subnet by default)=2E Static ``--ifconfig-push`` addresses are not=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  reserved in the p=
ool: when mixing static and dynamic clients in one pool,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  set ``start``/``end`` so that the st=
atic addresses fall outside the range=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  Requires ``--server`` with ``--dev tun`` and ``--topology subnet``=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``netmask`` must be=
 between /16 and /29 (as for ``--server``), ``gateway``</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  must be a host address inside the sub=
net, ``start`` and ``end`` host</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  addresses inside the subnet with ``start`` lower than ``end``=
, each ``name``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ma=
y be defined only once and no pool may overlap another one or the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  ``--server`` network=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  The server routes each pool&#39;s subne=
t into the tun device, as it does for</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  the ``--server`` network; no ``--route`` needs to be ad=
ded for it=2E These</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  routes honour ``--route-table`` and ``--route-metric``=2E With DCO on Lin=
ux</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  and FreeBSD the=
 IPv4 route is installed on-link, without a gateway, so its</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  ``route_gateway_{n}`` is not set =
for ``--route-up`` scripts=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--subnet-=
pool-name name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Ass=
ign this client to the ``--subnet-pool`` named ``name``=2E Must be</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  associated with a specific=
 client instance via ``--client-config-dir`` or</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+  ``--client-connect``=2E Several clients may r=
eference the same name and are</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  then served from the same shared pool=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ifconfig-ipv6-push ar=
gs</span><br><span>   for ``--client-config-dir`` per-client static IPv6 in=
terface</span><br><span>   configuration, see ``--client-config-dir`` and `=
`--ifconfig-push`` for</span><br><span>diff --git a/src/openvpn/multi=2Ec b=
/src/openvpn/multi=2Ec</span><br><span>index e302a81=2E=2E5a832b0 100644</s=
pan><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn=
/multi=2Ec</span><br><span>@@ -43,6 +43,7 @@</span><br><span> #include &quo=
t;auth_token=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;</spa=
n><br><span> #include &quot;sid_hash=2Eh&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br>=
<span> #include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;string=
=2Eh&gt;</span><br><span> </span><br><span>@@ -54,6 +55,21 @@</span><br><sp=
an> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_fi=
lter=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * D=
ynamic address pool serving the clients of one --subnet-pool name=2E  Share=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by every client=
 that references the name, created at startup by</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * multi_init()=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct subnet_pool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct subnet_pool *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const char *name;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct ifconfig_pool *pool;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct ifcon=
fig_pool *multi_get_group_pool(struct multi_context *m,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                       =
           const struct options *o, const char *name);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*#define MULTI_DEBUG_=
EVENT_LOOP*/</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LO=
OP</span><br><span>@@ -371,6 +387,13 @@</span><br><span>         }</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* create every --subnet-pool group up front rather than o=
n first use, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * that its pool exists before any client of the group connects */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet=
_pool_def *d =3D t-&gt;options=2Esubnet_pools; d; d =3D d-&gt;next)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        multi_get_group_pool(m, &amp;t-&g=
t;options, d-&gt;name);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     /*</span><br><span>      * Help us keep track of routing table=
=2E</span><br><span>      */</span><br><span>@@ -625,7 +648,8 @@</span><br>=
<span> </span><br><span>         schedule_remove_entry(m-&gt;schedule, (str=
uct schedule_entry *)mi);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ifconfig_pool_release(m-&gt;ifconfig_pool, mi=
-&gt;vaddr_handle, false);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool =
: m-&gt;ifconfig_pool, mi-&gt;vaddr_handle,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                              false);</span><br><sp=
an> </span><br><span>         if (mi-&gt;did_iroutes)</span><br><span>     =
    {</span><br><span>@@ -707,6 +731,14 @@</span><br><span>         schedul=
e_free(m-&gt;schedule);</span><br><span>         mbuf_free(m-&gt;mbuf);</sp=
an><br><span>         ifconfig_pool_free(m-&gt;ifconfig_pool);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        while (m-&gt;subnet_pool=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            struct subnet_p=
ool *sp =3D m-&gt;subnet_pools;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     m-&gt;subnet_pools =3D sp-&gt;next;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            ifconfig_pool_free(sp-&gt;pool);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            free(sp);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> =
        frequency_limit_free(m-&gt;new_connection_limiter);</span><br><span=
>         initial_rate_limit_free(m-&gt;initial_rate_limiter);</span><br><s=
pan>         multi_reap_free(m-&gt;reaper);</span><br><span>@@ -1405,6 +143=
7,12 @@</span><br><span>     const struct options *o =3D &amp;c-&gt;options=
;</span><br><span>     if (o-&gt;push_ifconfig_constraint_defined &amp;&amp=
; c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* a subnet-pool client is v=
alidated against its own subnet */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (o-&gt;subnet_pool_defined)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return (o-&gt;subnet_pool_netmask &amp;=
 c-&gt;c2=2Epush_ifconfig_local)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                   =3D=3D o-&gt;subnet_pool_network;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>   =
      return (o-&gt;push_ifconfig_constraint_netmask &amp; c-&gt;c2=2Epush_=
ifconfig_local)</span><br><span>                =3D=3D o-&gt;push_ifconfig_=
constraint_network;</span><br><span>     }</span><br><span>@@ -1415,6 +1453=
,40 @@</span><br><span> }</span><br><span> </span><br><span> /*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Return the dynamic pool serv=
ing the clients assigned to &lt;name&gt;, creating it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * from the matching --subnet-pool defini=
tion in &lt;o&gt; if it does not exist yet</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * (which only happens when multi_init() creates eve=
ry pool at startup)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct=
 ifconfig_pool *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mul=
ti_get_group_pool(struct multi_context *m, const struct options *o, const c=
har *name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool *sp;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet_pools; sp=
; sp =3D sp-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!strcmp(sp-&gt;name, name))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_pool_def =
*d4 =3D subnet_pool_by_name(o-&gt;subnet_pools, name);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ASSERT(d4);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;name =3D=
 d4-&gt;name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 the configured dynamic range, or else every host address of the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * subnet, minus the gatew=
ay reserved below if it falls inside it */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const in_addr_t start =3D d4-&gt;pool_start ? d4=
-&gt;pool_start : d4-&gt;network + 1;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const in_addr_t end =3D d4-&gt;pool_end ? d4-&gt;pool=
_end : (d4-&gt;network | ~d4-&gt;netmask) - 1;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    sp-&gt;pool =3D ifconfig_pool_init(true, IFC=
ONFIG_POOL_INDIV, start, end, o-&gt;duplicate_cn, false,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                  in6a=
ddr_any, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifc=
onfig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;next =3D m-&gt;subnet_pools;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;subnet_pool=
s =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Select a virtual a=
ddress for a new client instance=2E</span><br><span>  * Use an --ifconfig-p=
ush directive, if given (static IP)=2E</span><br><span>  * Otherwise use an=
 --ifconfig-pool address (dynamic IP)=2E</span><br><span>@@ -1424,6 +1496,2=
5 @@</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new(=
);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* resolve --subnet-pool-name against the main-config --subnet-pool li=
st (an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * unknow=
n name is rejected with AUTH_FAILED in multi_connection_established)=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * This runs again =
after every client-connect handler, and a later handler</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     * (script, plugin, management) may=
 override the name set by the CCD file,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * so always resolve the current name=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eop=
tions=2Esubnet_pool_name)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const struct subnet_pool_def *d =3D</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            subnet_pool_by_name(m-&gt;top=2Eoptions=2Esubne=
t_pools, mi-&gt;context=2Eoptions=2Esubnet_pool_name);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        mi-&gt;context=2Eoptions=2Esubnet_pool_defined =3D =
d !=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;con=
text=2Eoptions=2Esubnet_pool_network =3D d-&gt;network;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2E=
subnet_pool_netmask =3D d-&gt;netmask;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_gatew=
ay =3D d-&gt;gateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     =
/*</span><br><span>      * If ifconfig addresses were set by dynamic config=
 file,</span><br><span>      * release pool addresses, otherwise keep them=
=2E</span><br><span>@@ -1434,8 +1525,10 @@</span><br><span>          * rele=
ase dynamic allocation */</span><br><span>         if (mi-&gt;vaddr_handle =
&gt;=3D 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            ifconfig_pool_release(m-&gt;ifconfig_pool, mi-&=
gt;vaddr_handle, true);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool=
 : m-&gt;ifconfig_pool,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                  mi-&gt;vaddr_handle, true);</span><br=
><span>             mi-&gt;vaddr_handle =3D -1;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =3D NULL;</span><=
br><span>         }</span><br><span> </span><br><span>         mi-&gt;conte=
xt=2Ec2=2Epush_ifconfig_defined =3D true;</span><br><span>@@ -1455,6 +1548,=
52 @@</span><br><span>                 &quot;MULTI_sva: WARNING: if --ifcon=
fig-push is used for IPv4, automatic IPv6 assignment from --ifconfig-ipv6-p=
ool does not work=2E  Use --ifconfig-ipv6-push for IPv6 then=2E&quot;);</sp=
an><br><span>         }</span><br><span>     }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    else if (mi-&gt;context=2Eoptions=2Esubnet_p=
ool_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* dynamic ad=
dress from this client&#39;s --subnet-pool group */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct ifconfig_pool *group =3D</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_get=
_group_pool(m, &amp;m-&gt;top=2Eoptions, mi-&gt;context=2Eoptions=2Esubnet_=
pool_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* the address may =
have been acquired before the name was known (from</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+         * the global pool) or for a name th=
at a later handler overrode: drop</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+         * it so we serve this client from its current group =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&g=
t;vaddr_handle &gt;=3D 0 &amp;&amp; mi-&gt;vaddr_pool !=3D group)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            ifconfig_pool_release(mi-&g=
t;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                  mi-&g=
t;vaddr_handle, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            mi-&gt;vaddr_handle =3D -1;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            /* both addresses of=
 the dropped slot go back to its pool */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Epush_ifconfig_define=
d =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (mi-&gt;vaddr_handle &lt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            in_addr_t local =3D 0, remote =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            const ch=
ar *cn =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!mi-&g=
t;context=2Eoptions=2Eduplicate_cn)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                cn =3D tls_common_name(mi-&gt;context=2Ec2=2Etls_=
multi, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =
=3D group;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mi-&gt;vaddr_handle =3D ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;lo=
cal, &amp;remote, NULL, cn);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epush_if=
config_local =3D remote;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 mi-&gt;context=2Eoptions=2Esubnet_pool_netmask;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                mi-&gt;context=2Ec2=2Epush_ifc=
onfig_defined =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     msg(D_MULTI_ERRORS, &quot;MULTI: no free --subnet-pool addresses are a=
vailable for %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    multi_instance_string(mi, false, &amp;gc));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if (m-&gt;if=
config_pool &amp;&amp; mi-&gt;vaddr_handle &lt; 0) /* otherwise, choose a p=
ool address */</span><br><span>     {</span><br><span>         in_addr_t lo=
cal =3D 0, remote =3D 0;</span><br><span>@@ -2360,10 +2499,9 @@</span><br><=
span>         const char *ifconfig_constraint_netmask =3D</span><br><span> =
            print_in_addr_t(mi-&gt;context=2Eoptions=2Epush_ifconfig_constr=
aint_netmask, 0, &amp;gc);</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        /* JYFIXME -- this should cause the connecti=
on to fail */</span><br><span>         msg(D_MULTI_ERRORS,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            &quot;MULTI ERROR: primary=
 virtual IP for %s (%s) &quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            &quot;violates tunnel network/netmask constraint (%s/%=
s)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  &quot;WARNING: primary virtual IP for %s (%s) &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;violates tunnel networ=
k/netmask constraint (%s/%s) and may not work&quot;,</span><br><span>      =
       multi_instance_string(mi, false, &amp;gc),</span><br><span>         =
    print_in_addr_t(mi-&gt;context=2Ec2=2Epush_ifconfig_local, 0, &amp;gc),=
</span><br><span>             ifconfig_constraint_network, ifconfig_constra=
int_netmask);</span><br><span>@@ -2471,6 +2609,7 @@</span><br><span> </span=
><br><span>     /* reset pool handle to null */</span><br><span>     mi-&gt=
;vaddr_handle =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    mi-&gt;vaddr_pool =3D NULL;</span><br><span> </span><br><span>     /*=
 do --client-connect setenvs */</span><br><span>     multi_select_virtual_a=
ddr(m, mi);</span><br><span>@@ -2792,6 +2931,15 @@</span><br><span>        =
 cc_succeeded =3D false;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eopti=
ons=2Esubnet_pool_name</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &amp;&amp; !subnet_pool_by_name(m-&gt;top=2Eoptions=2Esubnet_poo=
ls, mi-&gt;context=2Eoptions=2Esubnet_pool_name))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        msg(D_MULTI_ERRORS, &quot;MULTI: client has been re=
jected due to unknown --subnet-pool-name &#39;%s&#39;&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptio=
ns=2Esubnet_pool_name);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        auth_set_client_reason(mi-&gt;context=2Ec2=2Etls_multi, &quot;u=
nknown subnet-pool-name&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        cc_succeeded =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     if (cc_succeeded)</span><br><span>     {</s=
pan><br><span>         multi_client_connect_late_setup(m, mi, *option_types=
_found);</span><br><span>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/m=
ulti=2Eh</span><br><span>index 5db7147=2E=2E14f71dd 100644</span><br><span>=
--- a/src/openvpn/multi=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</sp=
an><br><span>@@ -121,6 +121,8 @@</span><br><span>     struct mroute_addr re=
al; /**&lt; External network address of the</span><br><span>               =
                *   remote peer=2E */</span><br><span>     ifconfig_pool_ha=
ndle vaddr_handle;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* pool vaddr_handle belongs to (NULL =3D the global one) */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct ifconfig_pool *vaddr=
_pool;</span><br><span>     char msg_prefix[MULTI_PREFIX_MAX_LENGTH];</span=
><br><span> </span><br><span>     /* queued outgoing data in Server/TCP mod=
e */</span><br><span>@@ -190,6 +192,8 @@</span><br><span>                  =
                       *   instances=2E */</span><br><span>     struct mult=
i_io *multi_io;         /**&lt; I/O state and events tracker */</span><br><=
span>     struct ifconfig_pool *ifconfig_pool;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* per-group --subnet-pool dynamic pools */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_po=
ol *subnet_pools;</span><br><span>     struct frequency_limit *new_connecti=
on_limiter;</span><br><span>     struct initial_packet_rate_limit *initial_=
rate_limiter;</span><br><span>     struct mroute_helper *route_helper;</spa=
n><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec<=
/span><br><span>index 8e0c602=2E=2Ecae6a28 100644</span><br><span>--- a/src=
/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><b=
r><span>@@ -453,6 +453,12 @@</span><br><span>     &quot;                  I=
f seconds=3D0, file will be treated as read-only=2E\n&quot;</span><br><span=
>     &quot;--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 network b=
lock\n&quot;</span><br><span>     &quot;                  to be dynamically=
 allocated to connecting clients=2E\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &quot;--subnet-pool name network netmask [gatew=
ay [start end]] : Define a named\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;                  pool of addresses outside =
the --server network, selected\n&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    &quot;                  per client with --subnet-poo=
l-name=2E start/end restrict the\n&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &quot;                  dynamically assigned range=
=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quo=
t;--subnet-pool-name name : Assign this client to the --subnet-pool named n=
ame=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &=
quot;                  Only valid in a client-specific config file=2E\n&quo=
t;</span><br><span>     &quot;--ifconfig-push local remote-netmask : Push a=
n ifconfig option to remote,\n&quot;</span><br><span>     &quot;           =
       overrides --ifconfig-pool dynamic allocation=2E\n&quot;</span><br><s=
pan>     &quot;                  Only valid in a client-specific config fil=
e=2E\n&quot;</span><br><span>@@ -1899,6 +1905,20 @@</span><br><span>       =
  {</span><br><span>             msg(M_USAGE, &quot;--ifconfig-ipv6-pool ne=
eds --ifconfig-ipv6&quot;);</span><br><span>         }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (options-&gt;subnet_pools)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (!options-&gt;ser=
ver_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   msg(M_USAGE, &quot;--subnet-pool requires --server&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            if (dev_type_enum(options-&=
gt;dev, options-&gt;dev_type) !=3D DEV_TYPE_TUN</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                || options-&gt;topology !=3D TO=
P_SUBNET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
msg(M_USAGE, &quot;--subnet-pool requires --dev tun and --topology subnet&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            subnet_=
pools_check(options-&gt;subnet_pools, options-&gt;server_network,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
  options-&gt;server_netmask, M_USAGE);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span>         MUST_BE_UNDEF(allow_=
recursive_routing, &quot;allow-recursive-routing&quot;);</span><br><span>  =
       if (options-&gt;auth_user_pass_file)</span><br><span>         {</spa=
n><br><span>@@ -1965,6 +1985,7 @@</span><br><span>         MUST_BE_UNDEF(if=
config_pool_defined, &quot;ifconfig-pool&quot;);</span><br><span>         M=
UST_BE_UNDEF(ifconfig_pool_persist_filename, &quot;ifconfig-pool-persist&qu=
ot;);</span><br><span>         MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, &q=
uot;ifconfig-ipv6-pool&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        MUST_BE_UNDEF(subnet_pools, &quot;subnet-pool&quot;);</s=
pan><br><span>         MUST_BE_UNDEF(real_hash_size, &quot;hash-size&quot;)=
;</span><br><span>         MUST_BE_UNDEF(virtual_hash_size, &quot;hash-size=
&quot;);</span><br><span>         MUST_BE_UNDEF(learn_address_script, &quot=
;learn-address&quot;);</span><br><span>@@ -3097,6 +3118,28 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * The server&#39;s tun device is only configured with the --serv=
er network, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ro=
ute each --subnet-pool network into it as well: without this the server</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * could not reach its =
subnet-pool clients when the data channel runs in</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * userspace=2E  Under DCO on Linux and FreeB=
SD the routes are installed on-link,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * see subnet_pool_routes_onlink()=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+options_postprocess_subnet_pool_routes(struct options *o)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool_def *d =3D=
 o-&gt;subnet_pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct route_option *ro;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        rol_check_alloc(o);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ro =3D add_route_to_option_list(o-&gt;routes, print_in_ad=
dr_t(d-&gt;network, 0, &amp;o-&gt;gc),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                                      print_in_addr_t(d-=
&gt;netmask, 0, &amp;o-&gt;gc), NULL, NULL,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                      o-&gt;route_d=
efault_table_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ro-&gt;on_link =3D subnet_pool_routes_onlink(o);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> static void</span><br><span> options_postprocess_mutat=
e(struct options *o, struct env_set *es)</span><br><span> {</span><br><span=
>@@ -3232,6 +3275,12 @@</span><br><span>         /* check if any option sho=
uld force disabling DCO */</span><br><span>         o-&gt;disable_dco =3D !=
dco_check_option(D_DCO, o) || !dco_check_startup_option(D_DCO, o);</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;mode =3D=
=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* how th=
e pools are routed depends on the DCO decision above */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        options_postprocess_subnet_pool=
_routes(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> #ifdef USE_COMP</span><br><span>     if (dco_enabled(o))</sp=
an><br><span>     {</span><br><span>@@ -6219,6 +6268,57 @@</span><br><span>=
             goto err;</span><br><span>         }</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0=
], &quot;subnet-pool&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3]=
 &amp;&amp; (!p[5] || p[6]) &amp;&amp; !p[7])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        struct subnet_pool_def *sp;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        in_addr_t network, netmask;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        network =3D getaddr(=
GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        netmask =3D getaddr(GETADDR=
_HOST_ORDER, p[3], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!network || !netmask)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(msglevel, &quot;cannot parse --subnet-po=
ol addresses&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 ALLOC_OBJ_CLEAR_GC(sp, struct subnet_pool_def, &amp;options-&gt;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;name =3D p=
[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;=
network =3D network &amp; netmask;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        sp-&gt;netmask =3D netmask;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        sp-&gt;gateway =3D (network &amp; ne=
tmask) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bool ok =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            sp-&gt;gateway =
=3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, &amp;ok, NULL);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!ok)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msgle=
vel, &quot;cannot parse --subnet-pool gateway&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                goto err;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        /* optional range of the dynamic pool, vali=
dated in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
subnet_pools_check(); unset, it spans the whole subnet */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (p[5])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            bool ok_start =3D false, ok_end =3D f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            sp-&gt;pool_start =3D=
 getaddr(GETADDR_HOST_ORDER, p[5], 0, &amp;ok_start, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            sp-&gt;pool_end =3D get=
addr(GETADDR_HOST_ORDER, p[6], 0, &amp;ok_end, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!ok_start || !ok_end)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel,=
 &quot;cannot parse --subnet-pool range&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        sp-&gt;next =3D options-&gt;subnet_pools;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;subnet_=
pools =3D sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p=
[0], &quot;subnet-pool-name&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERMISSION(OPT_P_INSTANCE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&=
gt;subnet_pool_name =3D p[1];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;ifconfig-pu=
sh-constraint&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</spa=
n><br><span>     {</span><br><span>         in_addr_t network, netmask;</sp=
an><br><span>diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh=
</span><br><span>index c58530a=2E=2Efcfb9e2 100644</span><br><span>--- a/sr=
c/openvpn/options=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><=
br><span>@@ -252,6 +252,21 @@</span><br><span>     struct verify_hash_list =
*next;</span><br><span> };</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* A named --subnet-pool: a subnet clients can be =
assigned from, referenced</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * from a CCD file by its name via --subnet-pool-name=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+struct subnet_pool_def</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def *next;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const char *name;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t network;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t netmask;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t gateway;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* optional ran=
ge of the dynamic pool (0/0: every host address of the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * subnet); addresses outside it are=
 left for static --ifconfig-push */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    in_addr_t pool_start;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    in_addr_t pool_end;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> /* Command line options */</span><br><span> stru=
ct options</span><br><span> {</span><br><span>@@ -518,6 +533,12 @@</span><b=
r><span>     bool push_ifconfig_constraint_defined;</span><br><span>     in=
_addr_t push_ifconfig_constraint_network;</span><br><span>     in_addr_t pu=
sh_ifconfig_constraint_netmask;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct subnet_pool_def *subnet_pools; /* named pools (serve=
r config) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st char *subnet_pool_name;         /* which pool this client uses (CCD) */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool subnet_pool=
_defined;             /* resolved from the name at connect */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t subnet_pool_network=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t subn=
et_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 in_addr_t subnet_pool_gateway;</span><br><span>     bool push_ifconfig_ipv=
4_blocked;           /* IPv4 */</span><br><span>     bool push_ifconfig_ipv=
6_defined;           /* IPv6 */</span><br><span>     struct in6_addr push_i=
fconfig_ipv6_local;  /* IPv6 */</span><br><span>@@ -979,4 +1000,23 @@</span=
><br><span> #endif /* ENABLE_DCO */</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Whether the routes of the --subnet-=
pool networks are installed on-link on</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * the DCO device rather than via a gateway=2E  With DCO=
 on Linux and FreeBSD the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * kernel selects the peer by a route&#39;s next hop, so a route via =
a gateway</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * would d=
eliver every packet for an unassigned pool address to the client</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * owning that gateway address=
; on-link, such a packet matches no peer, while</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * each pool client gets its own on-link host r=
oute when it connects (see</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * multi_learn_in_addr_t())=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+subnet_pool_routes_onlink(const struct options *o)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return dco_enabled(o);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> #endif /* ifndef OPTIONS_H */</span><br><span>di=
ff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec</spa=
n><br><span>index d25d85c=2E=2Ebb52fe7 100644</span><br><span>--- a/src/ope=
nvpn/options_util=2Ec</span><br><span>+++ b/src/openvpn/options_util=2Ec</s=
pan><br><span>@@ -30,6 +30,105 @@</span><br><span> #include &quot;options_u=
til=2Eh&quot;</span><br><span> </span><br><span> #include &quot;push=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;p=
ool=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool_=
def *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_by=
_name(const struct subnet_pool_def *pools, const char *name)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    for (const struct subnet_pool_def *d =3D pools; =
d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
strcmp(d-&gt;name, name))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* true if the two IPv4 subnets share at least one address */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+subnets_overlap(in_addr_t a, in_=
addr_t mask_a, in_addr_t b, in_addr_t mask_b)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const in_addr_t mask =3D mask_a &amp; mask_b;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return (a &amp; mask) =3D=3D (b &amp; mask);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subn=
et_pools_check(const struct subnet_pool_def *pools, in_addr_t server_networ=
k,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
  in_addr_t server_netmask, msglvl_t msglevel)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    for (const struct subnet_pool_def *d =3D pools; d; d =3D d-&gt=
;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const in_addr_t hos=
t =3D ~d-&gt;netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        int netbits =3D 32;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* the netmask must be contiguous */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (host &amp; (host + 1))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool %s: inva=
lid netmask&quot;, d-&gt;name);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        for (in_addr_t h =3D host; h; h &gt;&gt;=3D 1)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            netbits--;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* same bounds as --server: the pool must hold at least 2 a=
ddresses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
besides network, gateway and broadcast, and fit IFCONFIG_POOL_MAX */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (netbits &lt; I=
FCONFIG_POOL_MIN_NETBITS || netbits &gt; 29)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool %s: netmask mu=
st be between /%d and /29 (not /%d)&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                d-&gt;name, IFCONFIG_POOL_MIN_NETBIT=
S, netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if ((d-&gt;gateway &am=
p; d-&gt;netmask) !=3D d-&gt;network || d-&gt;gateway =3D=3D d-&gt;network<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            || d-&gt=
;gateway =3D=3D (d-&gt;network | host))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(msglevel, &quot;--subnet-pool %s: gateway must be=
 a host address inside the subnet&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                d-&gt;name);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* an explicit dynamic range must be made of host addresses =
of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * su=
bnet and hold at least the 2 entries an ifconfig pool needs */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if ((d-&gt;pool_start ||=
 d-&gt;pool_end)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &amp;&amp; ((d-&gt;pool_start &amp; d-&gt;netmask) !=3D d-&gt;netw=
ork</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
|| (d-&gt;pool_end &amp; d-&gt;netmask) !=3D d-&gt;network || d-&gt;pool_st=
art =3D=3D d-&gt;network</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                || d-&gt;pool_end =3D=3D (d-&gt;network | host) || d-&=
gt;pool_start &gt;=3D d-&gt;pool_end))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            msg(msglevel,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                &quot;--subnet-pool %s: range start and end =
must be host addresses inside the &quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                &quot;subnet, with start lower than en=
d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     d-&gt;name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (server_netmas=
k</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&=
amp; subnets_overlap(d-&gt;network, d-&gt;netmask, server_network, server_n=
etmask))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgle=
vel, &quot;--subnet-pool %s: subnet overlaps the --server network&quot;, d-=
&gt;name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        for (const struct subnet=
_pool_def *e =3D d-&gt;next; e; e =3D e-&gt;next)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (!strcmp(d-&gt;name, e-&gt;name))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &q=
uot;--subnet-pool %s: name defined more than once&quot;, d-&gt;name);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (subne=
ts_overlap(d-&gt;network, d-&gt;netmask, e-&gt;network, e-&gt;netmask))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel,=
 &quot;--subnet-pool %s and %s: subnets overlap&quot;, d-&gt;name, e-&gt;na=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span> </span><br><span> const char *</span><=
br><span> parse_auth_failed_temp(struct options *o, const char *reason)</sp=
an><br><span>diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/option=
s_util=2Eh</span><br><span>index 5226a6f=2E=2E5fa4735 100644</span><br><spa=
n>--- a/src/openvpn/options_util=2Eh</span><br><span>+++ b/src/openvpn/opti=
ons_util=2Eh</span><br><span>@@ -28,6 +28,33 @@</span><br><span> </span><br=
><span> const char *parse_auth_failed_temp(struct options *o, const char *r=
eason);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Look up=
 a named --subnet-pool in a list of pool definitions=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param pools  head of the --subnet-pool list (may be =
NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param name=
    the --subnet-pool-name to match</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @return       the matching pool definition, or NULL if n=
one matches</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+const struct subnet_pool=
_def *subnet_pool_by_name(const struct subnet_pool_def *pools,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
                  const char *name);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Validate the --=
subnet-pool definitions: contiguous netmask between</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * /IFCONFIG_POOL_MIN_NETBITS and /29, ga=
teway a host address inside its</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * subnet, an explicit dynamic range made of at least 2 host ad=
dresses of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * su=
bnet,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * unique name=
s, and no subnet overlapping another pool or the --server</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * network=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param pools           head of the --subnet-pool list (=
may be NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am server_network  the --server network (host order)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param server_netmask  the --server ne=
tmask, or 0 if there is none</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param msglevel        level of the message logged on the first=
 error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return   =
             true if every definition is valid</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool subnet_pools_check(const struct subnet_pool_def *pools, in_=
addr_t server_network,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        in_addr_t server_netmask, msglvl_t msglevel);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </sp=
an><br><span> /** Checks if the string is a valid integer by checking if it=
 can be</span><br><span>  *  converted to an integer */</span><br><span>dif=
f --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br><span>index=
 fff0e3f=2E=2E5c5b3fe 100644</span><br><span>--- a/src/openvpn/pool=2Ec</sp=
an><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -351,7 +351,7 @@=
</span><br><span> {</span><br><span>     bool ret =3D false;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (pool &amp;=
&amp; hand &gt;=3D 0 &amp;&amp; hand &lt; pool-&gt;size)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (pool &amp;&amp; hand &gt;=3D 0=
 &amp;&amp; hand &lt; pool-&gt;size &amp;&amp; !pool-&gt;list[hand]=2Ereser=
ved)</span><br><span>     {</span><br><span>         ifconfig_pool_entry_fr=
ee(&amp;pool-&gt;list[hand], hard);</span><br><span>         ret =3D true;<=
/span><br><span>@@ -430,6 +430,22 @@</span><br><span>     return ret;</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifc=
onfig_pool_reserve_ip(struct ifconfig_pool *pool, const in_addr_t addr)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const ifconfig_pool_handle h =3D ifco=
nfig_pool_ip_base_to_handle(pool, addr);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (h &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ifconfig_pool_entry_free(&amp;pool-&gt;li=
st[h], true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    po=
ol-&gt;list[h]=2Ein_use =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    pool-&gt;list[h]=2Ereserved =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> static in_addr_t</span><br><span> ifconfi=
g_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifconfig_pool_ha=
ndle hand)</span><br><span> {</span><br><span>@@ -477,6 +493,13 @@</span><b=
r><span>                   const bool fixed)</span><br><span> {</span><br><=
span>     struct ifconfig_pool_entry *e =3D &amp;pool-&gt;list[h];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (e-&gt;reserved)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_WARN, &quot;pool: ignoring persisted entr=
y for CN=3D%s: its address is reserved&quot;, cn);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     ifconfig_pool_entry_free(e, true);</span=
><br><span>     e-&gt;in_use =3D false;</span><br><span>     e-&gt;common_n=
ame =3D string_alloc(cn, NULL);</span><br><span>diff --git a/src/openvpn/po=
ol=2Eh b/src/openvpn/pool=2Eh</span><br><span>index e2d3f82=2E=2E497dcda 10=
0644</span><br><span>--- a/src/openvpn/pool=2Eh</span><br><span>+++ b/src/o=
penvpn/pool=2Eh</span><br><span>@@ -43,6 +43,7 @@</span><br><span>     char=
 *common_name;</span><br><span>     time_t last_release;</span><br><span>  =
   bool fixed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
ool reserved; /* never handed out, e=2Eg=2E a --subnet-pool gateway */</spa=
n><br><span> };</span><br><span> </span><br><span> struct ifconfig_pool</sp=
an><br><span>@@ -86,6 +87,17 @@</span><br><span> </span><br><span> bool ifc=
onfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_handle hand, c=
onst bool hard);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Permanently reserve the pool slot holding \c addr, so that it is never</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * handed out to a cli=
ent nor taken over by a persisted entry (e=2Eg=2E the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * gateway of a --subnet-pool)=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param pool  the pool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param addr  IPv4 address (host orde=
r) to reserve</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn      true if \c addr lies in the pool and was reserved</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool ifconfig_pool_reserve_ip(struct ifconfig_pool =
*pool, in_addr_t addr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> struct ifconfig_pool_persist *ifconfig_pool_persist_i=
nit(const char *filename, int refresh_freq);</span><br><span> </span><br><s=
pan> void ifconfig_pool_persist_close(struct ifconfig_pool_persist *persist=
);</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index 0bce966=2E=2Efecef7e 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -408,6 +408,11 @@</span><br><span>         r-&gt;flags |=3D RT_=
METRIC_DEFINED;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (ro-&gt;on_link)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        r-&gt;flags |=3D RT_ON_LINK;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>     r-&gt;flags |=3D RT_DEF=
INED;</span><br><span> </span><br><span>     /* routing table id */</span><=
br><span>@@ -478,12 +483,12 @@</span><br><span>     return false;</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ro=
ute_option *</span><br><span> add_route_to_option_list(struct route_option_=
list *l, const char *network, const char *netmask,</span><br><span>        =
                  const char *gateway, const char *metric, int table_id)</s=
pan><br><span> {</span><br><span>     struct route_option *ro;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_GC(ro, struct route_=
option, l-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ALLOC_OBJ_CLEAR_GC(ro, struct route_option, l-&gt;gc);</span><br><span> =
    ro-&gt;network =3D network;</span><br><span>     ro-&gt;netmask =3D net=
mask;</span><br><span>     ro-&gt;gateway =3D gateway;</span><br><span>@@ -=
491,6 +496,7 @@</span><br><span>     ro-&gt;table_id =3D table_id;</span><b=
r><span>     ro-&gt;next =3D l-&gt;routes;</span><br><span>     l-&gt;route=
s =3D ro;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 ro;</span><br><span> }</span><br><span> </span><br><span> void</span><br><=
span>@@ -1322,7 +1328,11 @@</span><br><span>     {</span><br><span>        =
 setenv_route_addr(es, &quot;network&quot;, r-&gt;network, i);</span><br><s=
pan>         setenv_route_addr(es, &quot;netmask&quot;, r-&gt;netmask, i);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        setenv_route_a=
ddr(es, &quot;gateway&quot;, r-&gt;gateway, i);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        /* an on-link route has no gateway */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(r-&gt;f=
lags &amp; RT_ON_LINK))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      setenv_route_addr(es, &quot;gateway&quot;, r-&gt;gateway, i);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> =
</span><br><span>         if (r-&gt;flags &amp; RT_METRIC_DEFINED)</span><b=
r><span>         {</span><br><span>@@ -1478,6 +1488,7 @@</span><br><span> <=
/span><br><span> #if defined(TARGET_LINUX)</span><br><span>     const char =
*iface =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const in_addr_t *gateway =3D &amp;r-&gt;gateway;</span><br><span>     int =
metric =3D -1;</span><br><span> </span><br><span>     if (is_on_link(is_loc=
al_route, flags, rgi))</span><br><span>@@ -1485,6 +1496,12 @@</span><br><sp=
an>         iface =3D rgi-&gt;iface;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;fl=
ags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        gateway =3D NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        iface =3D tt-&gt;actual_name;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     if (r-&gt;flags &amp; RT_METRIC_DEFINED)=
</span><br><span>     {</span><br><span>         metric =3D r-&gt;metric;</=
span><br><span>@@ -1492,8 +1509,8 @@</span><br><span> </span><br><span> </s=
pan><br><span>     status =3D RTA_SUCCESS;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int ret =3D net_route_v4_add(ctx, &amp;r-&gt;netwo=
rk, netmask_to_netbits2(r-&gt;netmask), &amp;r-&gt;gateway,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                               iface,=
 r-&gt;table_id, metric);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, netmask_to_=
netbits2(r-&gt;netmask), gateway, iface,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                               r-&gt;table_id, metric)=
;</span><br><span>     if (ret =3D=3D -EEXIST)</span><br><span>     {</span=
><br><span>         msg(D_ROUTE, &quot;NOTE: Linux route add command failed=
 because route exists&quot;);</span><br><span>@@ -1616,7 +1633,15 @@</span>=
<br><span>     }</span><br><span> #endif</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    argv_printf_cat(&amp;argv, &quot;-=
net %s %s %s&quot;, network, gateway, netmask);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&am=
p; tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_cat(&am=
p;argv, &quot;-net %s/%d -iface %s&quot;, network, netmask_to_netbits2(r-&g=
t;netmask),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                tt-&gt;actual_name);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf_ca=
t(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netmask);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </sp=
an><br><span>     /* FIXME -- add on-link support for FreeBSD */</span><br>=
<span> </span><br><span>@@ -2035,7 +2060,16 @@</span><br><span>         met=
ric =3D r-&gt;metric;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (net_route_v4_del(ctx, &amp=
;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &amp;r-&gt;gateway, NUL=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const in_addr=
_t *gateway =3D &amp;r-&gt;gateway;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const char *iface =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        gateway =3D NULL;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        iface =3D tt-&gt;actual_name;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (net_route_v4_del(ctx, &amp;r-&gt;network, netma=
sk_to_netbits2(r-&gt;netmask), gateway, iface,</span><br><span>            =
              r-&gt;table_id, metric)</span><br><span>         &lt; 0)</spa=
n><br><span>     {</span><br><span>@@ -2091,7 +2125,15 @@</span><br><span> =
</span><br><span> #elif defined(TARGET_FREEBSD)</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quo=
t;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &=
amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      argv_printf(&amp;argv, &quot;%s delete -net %s/%d -iface %s&quot;, RO=
UTE_PATH, network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   netmask_to_netbits2(r-&gt;netmask), tt-&gt;actual_name);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s delete -net %s %s =
%s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     =
argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_execve_check(&am=
p;argv, es, 0, &quot;ERROR: FreeBSD route delete command failed&quot;);</sp=
an><br><span>diff --git a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh</sp=
an><br><span>index 0d33d36=2E=2E7c5528f 100644</span><br><span>--- a/src/op=
envpn/route=2Eh</span><br><span>+++ b/src/openvpn/route=2Eh</span><br><span=
>@@ -80,6 +80,10 @@</span><br><span>     const char *gateway;</span><br><sp=
an>     int table_id;</span><br><span>     const char *metric;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* on Linux and FreeBSD, ins=
tall the route on-link on the tun device</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * instead of via the gateway (needed under DCO, w=
here the kernel selects</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * the peer by the route&#39;s next hop) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    bool on_link;</span><br><span> };</sp=
an><br><span> </span><br><span> /* redirect-gateway flags */</span><br><spa=
n>@@ -120,6 +124,7 @@</span><br><span> #define RT_DEFINED        (1u &lt;&l=
t; 0)</span><br><span> #define RT_ADDED          (1u &lt;&lt; 1)</span><br>=
<span> #define RT_METRIC_DEFINED (1u &lt;&lt; 2)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define RT_ON_LINK        (1u &lt;&lt; 3) /* s=
ee struct route_option=2Eon_link */</span><br><span>     struct route_ipv4 =
*next;</span><br><span>     unsigned int flags;</span><br><span>     const =
struct route_option *option;</span><br><span>@@ -311,8 +316,9 @@</span><br>=
<span>                const struct route_gateway_info *rgi, const struct en=
v_set *es,</span><br><span>                openvpn_net_ctx_t *ctx);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void add_ro=
ute_to_option_list(struct route_option_list *l, const char *network, const =
char *netmask,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                       const char *gateway, const char *metric, int table_i=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct route_opt=
ion *add_route_to_option_list(struct route_option_list *l, const char *netw=
ork,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                               const char *netmask, const char *gateway,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                        const char *metric, int table_id);</span><br><span>=
 </span><br><span> void add_route_ipv6_to_option_list(struct route_ipv6_opt=
ion_list *l, const char *prefix,</span><br><span>                          =
          const char *gateway, const char *metric, int table_id);</span><br=
><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tes=
ts/openvpn/Makefile=2Eam</span><br><span>index 43a6743=2E=2E5f2a75b 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -392,6 +3=
92,7 @@</span><br><span> </span><br><span> misc_testdriver_SOURCES =3D test=
_misc=2Ec \</span><br><span> 	test_schedule=2Ec test_schedule=2Eh \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	test_subnet_pool=2Ec test_=
subnet_pool=2Eh \</span><br><span> 	mock_msg=2Ec test_common=2Eh  \</span><=
br><span> 	mock_get_random=2Ec \</span><br><span> 	$(top_srcdir)/src/compat=
/compat-strlcpy=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn=
/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</span><br><span>ind=
ex aea40f0=2E=2E191ab2b 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_misc=
=2Ec</span><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;win3=
2-util=2Eh&quot;</span><br><span> #endif</span><br><span> #include &quot;te=
st_schedule=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;test_subnet_pool=2Eh&quot;</span><br><span> </span><br><sp=
an> static void</span><br><span> test_compat_lzo_string(void **state)</span=
><br><span>@@ -561,7 +562,12 @@</span><br><span>     cmocka_unit_test(test_=
list),</span><br><span>     cmocka_unit_test(test_atoi_variants),</span><br=
><span>     cmocka_unit_test(schedule_test),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    cmocka_unit_test(test_sid_hash_list)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_sid_h=
ash_list),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmock=
a_unit_test(test_subnet_pool_by_name),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pools_check_netmask),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(=
test_subnet_pools_check_gateway),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    cmocka_unit_test(test_subnet_pools_check_range),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_su=
bnet_pools_check_overlap),</span><br><span> };</span><br><span> </span><br>=
<span> int</span><br><span>diff --git a/tests/unit_tests/openvpn/test_subne=
t_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>=
new file mode 100644</span><br><span>index 0000000=2E=2E7f40b74</span><br><=
span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_subn=
et_pool=2Ec</span><br><span>@@ -0,0 +1,160 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sin=
gle UDP port, with support for SSL/TLS-based</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             session authentication and key exch=
ange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet encryption, packet authentication, and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@ope=
nvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fr=
ee software; you can redistribute it and/or modify</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pu=
blic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  as published by the Free Software Foundation=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  This program is distributed in the hope that it will =
be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A =
PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  GNU General Public License for more details=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gen=
eral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licens=
es/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;test_subnet_pool=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* --subnet-pool-name resolves a client to its --subnet-pool; an unkno=
wn name</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * returns N=
ULL, which is what makes the server reject that client=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_subnet_pool_by_name(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct subnet_pool_def c =3D { =2Enext =3D N=
ULL, =2Ename =3D &quot;grpC&quot;, =2Enetwork =3D 0x0a020300, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a020301 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool_def b =3D { =2Enext =3D &am=
p;c, =2Ename =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a020200, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a020201 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool_def a =3D { =2Enext =3D &am=
p;b, =2Ename =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a020100, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a020101 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* every configured name resolves to its own pool, wherever it si=
ts */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr=
_equal(subnet_pool_by_name(&amp;a, &quot;grpA&quot;), &amp;a);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool=
_by_name(&amp;a, &quot;grpB&quot;), &amp;b);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool_by_name(&amp;a, &=
quot;grpC&quot;), &amp;c);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* and i=
t carries that pool&#39;s subnet/gateway */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const struct subnet_pool_def *r =3D subnet_pool=
_by_name(&amp;a, &quot;grpB&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(r-&gt;network, 0x0a020200);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r-&gt;net=
mask, 0xffffff00);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(r-&gt;gateway, 0x0a020201);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* unknown name and empty list both miss */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_null(subnet_pool_by_name(&a=
mp;a, &quot;nope&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_null(subnet_pool_by_name(NULL, &quot;grpA&quot;));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* a single pool &lt;net&gt;/&lt;mask&gt; with gateway &lt;gw&gt=
;, checked against the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * 10=2E8=2E0=2E0/24 --server network */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+check_one(in_addr_t net, in_addr_t mask, in_addr_t gw)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def d =3D { =2Enex=
t =3D NULL, =2Ename =3D &quot;grp&quot;, =2Enetwork =3D net, =2Enetmask =3D=
 mask, =2Egateway =3D gw };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
subnet_pools_check(&amp;d, 0x0a080000, 0xffffff00, M_WARN);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* --subnet-pool geometry: anything ifconfig_pool_init() cannot serve mu=
st be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * refused whe=
n the config is checked, not when the first client connects */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+test_subnet_pools_check_netmask(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* the bounds of --server: /16 =2E=
=2E /29 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(check_one(0x0a090000, 0xffff0000, 0x0a090001));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0x=
ffffff00, 0x0a090001));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(check_one(0x0a090000, 0xfffffff8, 0x0a090001));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /30, /31, /32: too f=
ew addresses for a pool */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(check_one(0x0a090000, 0xfffffffc, 0x0a090001));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_=
one(0x0a090000, 0xfffffffe, 0x0a090001));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000, 0xffffffff, 0x=
0a090000));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /=
15: larger than IFCONFIG_POOL_MAX */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_false(check_one(0x0a080000, 0xfffe0000, 0x0a080=
001));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-co=
ntiguous netmask */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(check_one(0x0a000900, 0xff00ff00, 0x0a000901));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_su=
bnet_pools_check_gateway(void **state)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* any host address of the subnet is fine, not only the first one */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check=
_one(0x0a090000, 0xffffff00, 0x0a0900fe));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xffffff00, 0x=
0a090080));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* n=
etwork address, broadcast address, outside the subnet */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000,=
 0xffffff00, 0x0a090000));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0900ff));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_=
one(0x0a090000, 0xffffff00, 0x0a0a0001));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a 10=2E9=2E0=
=2E0/24 pool with dynamic range &lt;start&gt;-&lt;end&gt; */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_range(in_addr_t start, in_addr_t en=
d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def d =3D { =
=2Enext =3D NULL, =2Ename =3D &quot;grp&quot;, =2Enetwork =3D 0x0a090000, =
=2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001, =2Epool_start =3D sta=
rt, =2Epool_end =3D end };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return s=
ubnet_pools_check(&amp;d, 0x0a080000, 0xffffff00, M_WARN);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* the optional dynamic range: host addresses of the subnet, at least 2 *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools_check_range(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* unset: the whole sub=
net */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(check_range(0, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* a sub-range, the smallest one, the whole host range */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_range(0x=
0a090064, 0x0a0900c8));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(check_range(0x0a090064, 0x0a090065));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_range(0x0a09000=
1, 0x0a0900fe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* a single address, or start past end */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(check_range(0x0a090064, 0x0a090064)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(=
check_range(0x0a0900c8, 0x0a090064));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* the network or broadcast address */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_range(0x0a0=
90000, 0x0a090064));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(check_range(0x0a090064, 0x0a0900ff));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* outside the subnet */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_range(0=
x0a090064, 0x0a0a0001));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(check_range(0x0a080064, 0x0a090064));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_=
pools_check_overlap(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct subnet_pool_def b =3D { =2Enext =3D NULL, =2Ename =3D &quot;grpB&quo=
t;, =2Enetwork =3D 0x0a0a0000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x=
0a0a0001 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct subnet_pool_def a =3D { =2Enext =3D &amp;b, =2Ename =3D &quot;grpA&quot;=
, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a=
090001 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* disjoint pools, disjoi=
nt from --server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(subnet_pools_check(&amp;a, 0x0a080000, 0xffffff00, M_WARN))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* a pool inside the --server net=
work =2E=2E=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(subnet_pools_check(&amp;a, 0x0a090000, 0xffffff00, M_WARN));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E or=
 covering it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(subnet_pools_check(&amp;a, 0x0a0a0080, 0xffffff80, M_WARN));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* no --server ne=
twork: only the pools are checked against each other */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(subnet_pools_check(&amp=
;a, 0, 0, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a /16 grpB c=
ontaining grpA */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct subnet_pool_def b16 =3D { =2Enext =3D NULL, =2Ename =3D &quot;grpB=
&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffff0000, =2Egateway =
=3D 0x0a090101 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct subnet_pool_def a16 =3D { =2Enext =3D &amp;b16, =2Ename =3D &quot;=
grpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egatewa=
y =3D 0x0a090001 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_false(subnet_pools_check(&amp;a16, 0, 0, M_WARN));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* the same name defined twice */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def bdup =
=3D { =2Enext =3D NULL, =2Ename =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a0a=
0000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def adup =
=3D { =2Enext =3D &amp;bdup, =2Ename =3D &quot;grpA&quot;, =2Enetwork =3D 0=
x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(subnet_pool=
s_check(&amp;adup, 0, 0, M_WARN));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_subnet_pool=2Eh b/tests/unit_tests/openvpn/test_subnet_pool=2Eh</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E07ba374</span=
><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_subnet_pool=2Eh</span><br><span>@@ -0,0 +1,37 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over =
a single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is free software; you can redistribute it and/or modify</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU G=
eneral Public License version 2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that=
 it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef SUBNET_P=
OOL_TEST_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S=
UBNET_POOL_TEST_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* --subnet-pool test=
s, run as part of misc_testdriver */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id test_subnet_pool_by_name(void **state);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void test_subnet_pools_check_netmask(void **state);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void test_subnet_pools_check_gateway(void **state);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void test_subnet_pools_check_range(void **sta=
te);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+void test_subnet_pools_check_overl=
ap(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></pr=
e><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
783?usp=3Demail">change 1783</a>=2E To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3De=
mail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eo=
rg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Ene=
t/c/openvpn/+/1783?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpa=
tchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<=
div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"disp=
lay:none"> Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631 </di=
v>
<div style=3D"display:none"> Gerrit-Change-Number: 1783 </div>
<div styl=
e=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none">=
 Gerrit-Owner: Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank =
Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:no=
ne"> Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<=
div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@list=
s=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attent=
ion: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ec=
om&gt; </div>

</body></html>
--J148vkwa6e4=--


--===============4334526602308741465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4334526602308741465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4334526602308741465==--

