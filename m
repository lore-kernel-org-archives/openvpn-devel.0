Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E90606A31A
	for <openvpn-devel@archiver.kernel.org>; Mon, 26 Oct 2026 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KM/GsynS;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EzOqgC9X;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=a0hmd9Zr;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=QzFCXMUP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KJphvI6FgKRmi8xH2t1ti0BwtkaqmtmOrgxhMMyzV74=; b=KM/GsynSfSW0alxWSQLFzQKCLx
	gTtgq0uTb1SRSfBs5bY9Cqsb4UDiCgn8XL/IsD2efyLz6sxOYsiP7RpVfCz25JxCvBJhnvFIxXltr
	JhZ80L9aYl49Uon2PG7lH5lSkr7yEKpGUZd8zG5hk1PhAUr+joc0UpoX81ZOwS2h4edk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xLM8w-000000005gO-0nUa;
	Mon, 26 Oct 2026 14:57:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xLM8f-000000005g8-2N6a
 for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:57:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8hfW3UGkA2Utr6HIqcj2jRHf8sL2eBPUl4KrsrrTgvE=; b=EzOqgC9Xo9DnEleuQo3nrsgJk8
 ueGpOgkeRoJIoZdpgddygYqAZiPEwMop/Tds9oeDegWl+/7WtCcygtcteWR+rj/OyvHzIYswFk6Dw
 m8BVoLRHUcPX6r6asDS6/7C7IRODmnTGJym3lTrXZr0gFizE3sJqfJ/8DoeID7UHqFS8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8hfW3UGkA2Utr6HIqcj2jRHf8sL2eBPUl4KrsrrTgvE=; b=a0hmd9ZrOdG7F0iClk+5G8nNO/
 /MbsQBVnTCgQQsvxRaKH6qJUxBm9Dm43jZsfxMLAmAFOKuxgmjSnm+Rq56FfZN+rXRsoOQBED68Il
 DYPQ1ILT/sGIEDAQayigRiCNx+8pyHoBC5eDsm+PghgLz03usBoEkuhVT7DldZmXRERk=;
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLM8Y-0000000033I-37RL for openvpn-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 14:57:29 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a2d6d01ecbso14570745e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 26 Oct 2026 07:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793026636; x=1793631436; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8hfW3UGkA2Utr6HIqcj2jRHf8sL2eBPUl4KrsrrTgvE=;
 b=QzFCXMUPxEYZtPn0ppH9jgK03zO0EYWL5gnOu3/qpTGTItJUw3rlA5QpqiacxsbhUX
 Z3/nja+Btn1ui4qmH0ak9WD3WKAVKN5ew3MoGDToUJX0Tsbn2icaoLXKqf3kYJILXpxA
 QT30g0JTAkJ672fk3HUg835b/n02xq/zWg69fZ0w11HsaJ3LjavfPBtuASXp30FYw7qO
 e1yFXZjci/ETZvFRYWtetP06NOQ0lHjOkmnAYW0n2+gP/AIpTONQkaiKSsYqBU78Gd9N
 0aPRyLdmb3BwD7H8HpEW0biUjyKV6ifbopQFwPeYQKwT+7zpFn/kzhhtGiu5T+CQ91yH
 DbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793026636; x=1793631436;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8hfW3UGkA2Utr6HIqcj2jRHf8sL2eBPUl4KrsrrTgvE=;
 b=o2WPhaaxI2TaZlJ+uHkmNnldKuOoUG53iWbWMTxgBxKsHVV6zu2M5Ye6Qm5wrwexEf
 jzFxqpyHbfqBEUWUgyGs4gljGJ1oW4K5bdcTd70Ylc87ZKwGgzkbGsA3M6j0MOqXnxCE
 pLh6lTGmzDFBBaRJPbmXdPNoDm5VNR9Wu9Nmy4O9qTSndEko9YAnEQYnH5JZkaA+8ZwW
 RzuuTL3TZcJ3hTW7kbKQerWhf1tTAm0eVRLV+lghKpc/CcZ3+X3Fs+nmjNYBOTNFZYkj
 c9KiNFurD/zq6BH6SdvgZwJJR+1o5HlDL3yJD92G79ydef5l6jcXUEmIEyTdqQ82JBM3
 xPRQ==
X-Gm-Message-State: AFq9FYKnhPI7rMnWP85F1MyqYTyphUi8mzTcwECu9shKFo6ke/zGG7eq
 iKxOe2TKR+JgWlxEgATfjb1Ru66I5AibAKrIo/d5AE3P/dUc431aHW5Y4XkFW3SILbGrSmhwMiy
 vRfI0pYAKL/Qw/oWYC1kwjf/OHfxdXC1HCZ1qVMiJni09NrHMnwpirbYjWrf+ZOtxNLsT
X-Gm-Gg: AYBFou3PKYDOyFUPCvgxFooLDlWwkFswOK1BoPbgDOsjxY2A4IVtiIawRC29wgya0Lx
 QxQJq1F2EGgpzkqSNw689CD+JovJIlKCWMiibEnPsZH/+771d7ZHPkmuGRmUDp9sJEnv5c4yH0E
 rC8svjZEdmm3QuJfyUGq74cZzxxyqnaMq18HgmUIlk58PiM4LISqRqjMhvepkO/iL9a8zDN86/N
 1X9DL70L8A49JKEpg1sXiIx/VdHJ6N2YICwhIEA924AJFw3QwHvTPlq3jZ+ZsF5LXXqu4kvspSw
 cKrU7eTRiv0ywMKue+E0FVW9cNSh5DpHcpZoWcWs+bJ3fJuhaYrVHn5orJvAUWl74mPNo12z3VT
 6D+lh8ZUEnNvPTC12EuNFO2T4eZlwdW+GwvvuN8GLlcRVTDJGFUbkc+JURHHdbrje3xer2unkiB
 /Bs8KcUcTZVc/hb2Zu77dXWzTteK1rV++jm2O63F9Al9FoeLvfcYLIjJKFKF0QAuXA5ZpByvrLI
 bONBNGUlp7ueylB81bmUM8oCuUGFUsy3+MKdFPvxgMKDolf3bfDuQf8XR0mszqWEsUvTQmQAtve
 2c26+XxLZKqnRSPaFXq1d5f4Wy0OD77EU56RtpCldXgIm0dRY3KwudF/lNWqYRHWhrS4N8Cfi2T
 xQeCnSpvqSPeW+zylgyEmFykCUfZXX9mOAt86EI8AFw==
X-Received: by 2002:a05:600c:37c9:b0:4a6:7d6:821f with SMTP id
 5b1f17b1804b1-4a607d682dfmr63858415e9.29.1793026635038; 
 Mon, 26 Oct 2026 07:57:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm16877576f8f.14.2026.10.26.07.57.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 07:57:13 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 26 Oct 2026 14:57:08 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: dd33eed86d7714ebd42786612f184546042f1eb7
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <368280cb8c10a88d4b57496a230bba3eeae85cf6-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xLM8Y-0000000033I-37RL
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multi: assign
 clients from a named, tagged subnet-pool
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
Content-Type: multipart/mixed; boundary="===============3888969652504798093=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3888969652504798093==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LlOhQPPCW/0="; charset=UTF-8

--LlOhQPPCW/0=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Frank Lichtenheld, Gert Doering, 

I'd like you to reexa=
mine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1783?usp=3Demail

to look at the new patch set (#9)=2E


Change subject:=
 multi: assign clients from a named, tagged subnet-pool
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multi: assign clients from a na=
med, tagged subnet-pool

Add two server directives:

  subnet-pool <tag> <n=
etwork> <netmask> [<gateway> [<start> <end>]]
                             =
                         (main config)
  subnet-pool-tag <tag>             =
                  (per-client CCD)

so groups of clients can be given addre=
sses from subnets other than the
--server network (per-group firewall rules=
 under --topology subnet, and
thus DCO)=2E A client's subnet-pool-tag is re=
solved to its pool and served
a virtual IP from that subnet: a static --ifc=
onfig-push within it, or
the next free address from a dynamic per-group poo=
l shared by tag=2E The
dynamic pool spans the whole subnet unless a start-e=
nd range is given,
which leaves the rest of the subnet to static addresses =
(these are not
reserved in the pool)=2E Such a client is validated against =
its own subnet
instead of the global tunnel-network constraint and never fa=
lls back to
the global pool; a tag matching no configured pool is declined =
with
AUTH_FAILED=2E The tag is resolved again after every client-connect
ha=
ndler, so a script, plugin or management interface may override the
one set=
 by the CCD file=2E

The pools are checked when the config is loaded, as fo=
r --server: the
netmask must be contiguous and between /16 and /29, the gat=
eway a host
address inside the subnet, a range (if any) at least two host a=
ddresses
of the subnet, tags unique, and no pool may overlap another or the=

--server network=2E Every pool is created at startup, and its gateway is
r=
eserved so it is never handed out to a client=2E

The server routes each po=
ol's subnet into its tun device, as the device
is only configured with the =
--server network: without this the server
cannot reach its subnet-pool clie=
nts=2E This is a regular --route, so it
is installed before privileges are =
dropped and honours --route-table,
--route-metric and --route-noexec=2E Und=
er DCO on Linux and FreeBSD,
though, the kernel selects the peer by the rou=
te's next hop, so a route
via a gateway would deliver every packet for an u=
nassigned pool address
to the client owning that gateway address: there the=
 route is installed
on-link on the tun device instead (a new on_link route =
option flag), and
each client of the pool gets its own on-link host route o=
n connect (as
its address is outside the --ifconfig network), so such packe=
ts match
no peer=2E

While here, the tunnel-network constraint violation is=
 logged as a
WARNING instead of MULTI ERROR, as it does not fail the connec=
tion=2E

Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
GitHub: close=
s openvpn/OpenVPN#987
Signed-off-by: Antonio Quartulli <antonio@mandelbit=
=2Ecom>
---
M CMakeLists=2Etxt
M doc/man-sections/server-options=2Erst
M sr=
c/openvpn/multi=2Ec
M src/openvpn/multi=2Eh
M src/openvpn/options=2Ec
M src=
/openvpn/options=2Eh
M src/openvpn/options_util=2Ec
M src/openvpn/options_u=
til=2Eh
M src/openvpn/pool=2Ec
M src/openvpn/pool=2Eh
M src/openvpn/route=
=2Ec
M src/openvpn/route=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tes=
ts/unit_tests/openvpn/test_misc=2Ec
A tests/unit_tests/openvpn/test_subnet_=
pool=2Ec
A tests/unit_tests/openvpn/test_subnet_pool=2Eh
16 files changed, =
765 insertions(+), 17 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Ene=
t:29418/openvpn refs/changes/83/1783/9

diff --git a/CMakeLists=2Etxt b/CMa=
keLists=2Etxt
index 184a95a=2E=2E8325846 100644
--- a/CMakeLists=2Etxt
+++ =
b/CMakeLists=2Etxt
@@ -858,6 +858,7 @@
     target_sources(test_misc PRIVAT=
E
         tests/unit_tests/openvpn/mock_get_random=2Ec
         tests/unit=
_tests/openvpn/test_schedule=2Ec
+        tests/unit_tests/openvpn/test_sub=
net_pool=2Ec
         src/openvpn/options_util=2Ec
         src/openvpn/oti=
me=2Ec
         src/openvpn/ssl_util=2Ec
diff --git a/doc/man-sections/serv=
er-options=2Erst b/doc/man-sections/server-options=2Erst
index 9dfa6bd=2E=
=2E9434e5d 100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man=
-sections/server-options=2Erst
@@ -330,6 +330,48 @@
   by ``--ifconfig``, O=
penVPN will install a /32 host route for the ``local``
   IP address=2E
 
+=
--subnet-pool args
+  Define a named pool of addresses from a subnet differ=
ent from the
+  ``--server`` network, so groups of clients can be given IPs=
 from separate
+  subnets for per-group firewall rules under ``--topology s=
ubnet`` (and
+  therefore DCO)=2E This is a main-config directive and may b=
e repeated to
+  define several pools=2E
+
+  Valid syntax:
+  ::
+
+     s=
ubnet-pool tag network netmask [gateway [start end]]
+
+  ``tag`` is a name=
 a client refers to with ``--subnet-pool-tag``; ``gateway``
+  defaults to =
the first address of ``network``/``netmask`` and is never
+  assigned to a =
client=2E A client assigned to a pool receives (dynamically, or
+  via a st=
atic ``--ifconfig-push`` that must lie within the subnet) an address
+  fro=
m it, plus the matching netmask=2E
+
+  Dynamic addresses are taken from ``=
start`` to ``end`` (every host address
+  of the subnet by default)=2E Stat=
ic ``--ifconfig-push`` addresses are not
+  reserved in the pool: when mixi=
ng static and dynamic clients in one pool,
+  set ``start``/``end`` so that=
 the static addresses fall outside the range=2E
+
+  Requires ``--server`` =
with ``--dev tun`` and ``--topology subnet``=2E
+  ``netmask`` must be betw=
een /16 and /29 (as for ``--server``), ``gateway``
+  must be a host addres=
s inside the subnet, ``start`` and ``end`` host
+  addresses inside the sub=
net with ``start`` lower than ``end``, each ``tag``
+  may be defined only =
once and no pool may overlap another one or the
+  ``--server`` network=2E
=
+
+  The server routes each pool's subnet into the tun device, as it does f=
or
+  the ``--server`` network; no ``--route`` needs to be added for it=2E =
These
+  routes honour ``--route-table`` and ``--route-metric``=2E With DCO=
 on Linux
+  and FreeBSD the IPv4 route is installed on-link, without a gat=
eway, so its
+  ``route_gateway_{n}`` is not set for ``--route-up`` scripts=
=2E
+
+--subnet-pool-tag tag
+  Assign this client to the ``--subnet-pool``=
 named ``tag``=2E Must be
+  associated with a specific client instance via=
 ``--client-config-dir`` or
+  ``--client-connect``=2E Several clients may =
reference the same tag and are
+  then served from the same shared pool=2E
=
+
 --ifconfig-ipv6-push args
   for ``--client-config-dir`` per-client stat=
ic IPv6 interface
   configuration, see ``--client-config-dir`` and ``--ifc=
onfig-push`` for
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec=

index e302a81=2E=2Ee8d51da 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/op=
envpn/multi=2Ec
@@ -43,6 +43,7 @@
 #include "auth_token=2Eh"
 #include "rou=
te=2Eh"
 #include "sid_hash=2Eh"
+#include "options_util=2Eh"
 #include <in=
ttypes=2Eh>
 #include <string=2Eh>
 
@@ -54,6 +55,21 @@
 #include "dco=2Eh"=

 #include "reflect_filter=2Eh"
 
+/*
+ * Dynamic address pool serving the =
clients of one --subnet-pool tag=2E  Shared
+ * by every client that refere=
nces the tag, created at startup by
+ * multi_init()=2E
+ */
+struct subnet=
_pool
+{
+    struct subnet_pool *next;
+    const char *tag;
+    struct i=
fconfig_pool *pool;
+};
+
+static struct ifconfig_pool *multi_get_group_poo=
l(struct multi_context *m,
+                                               =
   const struct options *o, const char *tag);
+
 /*#define MULTI_DEBUG_EVEN=
T_LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -371,6 +387,13 @@
         }
 =
    }
 
+    /* create every --subnet-pool group up front rather than on fi=
rst use, so
+     * that its pool exists before any client of the group con=
nects */
+    for (const struct subnet_pool_def *d =3D t->options=2Esubnet_=
pools; d; d =3D d->next)
+    {
+        multi_get_group_pool(m, &t->option=
s, d->tag);
+    }
+
     /*
      * Help us keep track of routing table=2E=

      */
@@ -625,7 +648,8 @@
 
         schedule_remove_entry(m->schedule,=
 (struct schedule_entry *)mi);
 
-        ifconfig_pool_release(m->ifconfig=
_pool, mi->vaddr_handle, false);
+        ifconfig_pool_release(mi->vaddr_p=
ool ? mi->vaddr_pool : m->ifconfig_pool, mi->vaddr_handle,
+               =
               false);
 
         if (mi->did_iroutes)
         {
@@ -707,6=
 +731,14 @@
         schedule_free(m->schedule);
         mbuf_free(m->mbuf=
);
         ifconfig_pool_free(m->ifconfig_pool);
+        while (m->subnet=
_pools)
+        {
+            struct subnet_pool *sp =3D m->subnet_pools;=

+
+            m->subnet_pools =3D sp->next;
+            ifconfig_pool_fr=
ee(sp->pool);
+            free(sp);
+        }
         frequency_limit_fr=
ee(m->new_connection_limiter);
         initial_rate_limit_free(m->initial_=
rate_limiter);
         multi_reap_free(m->reaper);
@@ -1405,6 +1437,12 @@
=
     const struct options *o =3D &c->options;
     if (o->push_ifconfig_con=
straint_defined && c->c2=2Epush_ifconfig_defined)
     {
+        /* a subn=
et-pool client is validated against its own subnet */
+        if (o->subne=
t_pool_defined)
+        {
+            return (o->subnet_pool_netmask & c-=
>c2=2Epush_ifconfig_local)
+                   =3D=3D o->subnet_pool_networ=
k;
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
 serving the clients tagged with <tag>, creating it
+ * from the matching -=
-subnet-pool definition in <o> if it does not exist yet
+ * (which only hap=
pens when multi_init() creates every pool at startup)=2E
+ */
+static struc=
t ifconfig_pool *
+multi_get_group_pool(struct multi_context *m, const stru=
ct options *o, const char *tag)
+{
+    struct subnet_pool *sp;
+
+    for =
(sp =3D m->subnet_pools; sp; sp =3D sp->next)
+    {
+        if (!strcmp(s=
p->tag, tag))
+        {
+            return sp->pool;
+        }
+    }
+
=
+    const struct subnet_pool_def *d4 =3D subnet_pool_by_tag(o->subnet_pool=
s, tag);
+    ASSERT(d4);
+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool);
+  =
  sp->tag =3D d4->tag;
+    /* the configured dynamic range, or else every =
host address of the
+     * subnet, minus the gateway reserved below if it =
falls inside it */
+    const in_addr_t start =3D d4->pool_start ? d4->pool=
_start : d4->network + 1;
+    const in_addr_t end =3D d4->pool_end ? d4->p=
ool_end : (d4->network | ~d4->netmask) - 1;
+    sp->pool =3D ifconfig_pool=
_init(true, IFCONFIG_POOL_INDIV, start, end, o->duplicate_cn, false,
+     =
                             in6addr_any, 0);
+    ifconfig_pool_reserve_ip=
(sp->pool, d4->gateway);
+    sp->next =3D m->subnet_pools;
+    m->subnet_=
pools =3D sp;
+    return sp->pool;
+}
+
+/*
  * Select a virtual address f=
or a new client instance=2E
  * Use an --ifconfig-push directive, if given =
(static IP)=2E
  * Otherwise use an --ifconfig-pool address (dynamic IP)=2E=

@@ -1424,6 +1496,25 @@
 {
     struct gc_arena gc =3D gc_new();
 
+    /* =
resolve --subnet-pool-tag against the main-config --subnet-pool list (an
+ =
    * unknown tag is rejected with AUTH_FAILED in multi_connection_establis=
hed)=2E
+     * This runs again after every client-connect handler, and a l=
ater handler
+     * (script, plugin, management) may override the tag set =
by the CCD file,
+     * so always resolve the current tag=2E */
+    if (m=
i->context=2Eoptions=2Esubnet_pool_tag)
+    {
+        const struct subnet=
_pool_def *d =3D
+            subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_=
pools, mi->context=2Eoptions=2Esubnet_pool_tag);
+
+        mi->context=2Eo=
ptions=2Esubnet_pool_defined =3D d !=3D NULL;
+        if (d)
+        {
+ =
           mi->context=2Eoptions=2Esubnet_pool_network =3D d->network;
+   =
         mi->context=2Eoptions=2Esubnet_pool_netmask =3D d->netmask;
+     =
       mi->context=2Eoptions=2Esubnet_pool_gateway =3D d->gateway;
+       =
 }
+    }
+
     /*
      * If ifconfig addresses were set by dynamic confi=
g file,
      * release pool addresses, otherwise keep them=2E
@@ -1434,8 +=
1525,10 @@
          * release dynamic allocation */
         if (mi->vaddr=
_handle >=3D 0)
         {
-            ifconfig_pool_release(m->ifconfig_p=
ool, mi->vaddr_handle, true);
+            ifconfig_pool_release(mi->vaddr_=
pool ? mi->vaddr_pool : m->ifconfig_pool,
+                                =
  mi->vaddr_handle, true);
             mi->vaddr_handle =3D -1;
+         =
   mi->vaddr_pool =3D NULL;
         }
 
         mi->context=2Ec2=2Epush_i=
fconfig_defined =3D true;
@@ -1455,6 +1548,52 @@
                 "MULTI_sv=
a: WARNING: if --ifconfig-push is used for IPv4, automatic IPv6 assignment =
from --ifconfig-ipv6-pool does not work=2E  Use --ifconfig-ipv6-push for IP=
v6 then=2E");
         }
     }
+    else if (mi->context=2Eoptions=2Esubne=
t_pool_defined)
+    {
+        /* dynamic address from this client's --sub=
net-pool group */
+        struct ifconfig_pool *group =3D
+            mul=
ti_get_group_pool(m, &m->top=2Eoptions, mi->context=2Eoptions=2Esubnet_pool=
_tag);
+
+        /* the address may have been acquired before the tag was =
known (from
+         * the global pool) or for a tag that a later handler =
overrode: drop
+         * it so we serve this client from its current grou=
p */
+        if (mi->vaddr_handle >=3D 0 && mi->vaddr_pool !=3D group)
+  =
      {
+            ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool =
: m->ifconfig_pool,
+                                  mi->vaddr_handle, tr=
ue);
+            mi->vaddr_handle =3D -1;
+            mi->vaddr_pool =3D =
NULL;
+            /* both addresses of the dropped slot go back to its poo=
l */
+            mi->context=2Ec2=2Epush_ifconfig_defined =3D false;
+    =
        mi->context=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;
+        }=

+
+        if (mi->vaddr_handle < 0)
+        {
+            in_addr_t loc=
al =3D 0, remote =3D 0;
+            const char *cn =3D NULL;
+
+          =
  if (!mi->context=2Eoptions=2Eduplicate_cn)
+            {
+              =
  cn =3D tls_common_name(mi->context=2Ec2=2Etls_multi, true);
+            =
}
+
+            mi->vaddr_pool =3D group;
+            mi->vaddr_handle =
=3D ifconfig_pool_acquire(mi->vaddr_pool, &local, &remote, NULL, cn);
+    =
        if (mi->vaddr_handle >=3D 0)
+            {
+                mi->co=
ntext=2Ec2=2Epush_ifconfig_local =3D remote;
+                mi->context=
=2Ec2=2Epush_ifconfig_remote_netmask =3D
+                    mi->context=
=2Eoptions=2Esubnet_pool_netmask;
+                mi->context=2Ec2=2Epush_=
ifconfig_defined =3D true;
+            }
+            else
+            {
=
+                msg(D_MULTI_ERRORS, "MULTI: no free --subnet-pool addresse=
s are available for %s",
+                    multi_instance_string(mi, fal=
se, &gc));
+            }
+        }
+    }
     else if (m->ifconfig_pool =
&& mi->vaddr_handle < 0) /* otherwise, choose a pool address */
     {
    =
     in_addr_t local =3D 0, remote =3D 0;
@@ -2360,10 +2499,9 @@
         c=
onst char *ifconfig_constraint_netmask =3D
             print_in_addr_t(mi-=
>context=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, &gc);
 
-        =
/* JYFIXME -- this should cause the connection to fail */
         msg(D_MU=
LTI_ERRORS,
-            "MULTI ERROR: primary virtual IP for %s (%s) "
-  =
          "violates tunnel network/netmask constraint (%s/%s)",
+          =
  "WARNING: primary virtual IP for %s (%s) "
+            "violates tunnel =
network/netmask constraint (%s/%s) and may not work",
             multi_in=
stance_string(mi, false, &gc),
             print_in_addr_t(mi->context=2Ec=
2=2Epush_ifconfig_local, 0, &gc),
             ifconfig_constraint_network,=
 ifconfig_constraint_netmask);
@@ -2471,6 +2609,7 @@
 
     /* reset pool h=
andle to null */
     mi->vaddr_handle =3D -1;
+    mi->vaddr_pool =3D NULL=
;
 
     /* do --client-connect setenvs */
     multi_select_virtual_addr(m=
, mi);
@@ -2792,6 +2931,15 @@
         cc_succeeded =3D false;
     }
 
+  =
  if (mi->context=2Eoptions=2Esubnet_pool_tag
+        && !subnet_pool_by_t=
ag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_tag=
))
+    {
+        msg(D_MULTI_ERRORS, "MULTI: client has been rejected due=
 to unknown --subnet-pool-tag '%s'",
+            mi->context=2Eoptions=2Es=
ubnet_pool_tag);
+        auth_set_client_reason(mi->context=2Ec2=2Etls_mul=
ti, "unknown subnet-pool-tag");
+        cc_succeeded =3D false;
+    }
+
 =
    if (cc_succeeded)
     {
         multi_client_connect_late_setup(m, mi=
, *option_types_found);
diff --git a/src/openvpn/multi=2Eh b/src/openvpn/mu=
lti=2Eh
index 5db7147=2E=2E14f71dd 100644
--- a/src/openvpn/multi=2Eh
+++ b=
/src/openvpn/multi=2Eh
@@ -121,6 +121,8 @@
     struct mroute_addr real; /*=
*< External network address of the
                               *   remot=
e peer=2E */
     ifconfig_pool_handle vaddr_handle;
+    /* pool vaddr_han=
dle belongs to (NULL =3D the global one) */
+    struct ifconfig_pool *vadd=
r_pool;
     char msg_prefix[MULTI_PREFIX_MAX_LENGTH];
 
     /* queued out=
going data in Server/TCP mode */
@@ -190,6 +192,8 @@
                      =
                   *   instances=2E */
     struct multi_io *multi_io;     =
    /**< I/O state and events tracker */
     struct ifconfig_pool *ifconfi=
g_pool;
+    /* per-group --subnet-pool dynamic pools */
+    struct subnet=
_pool *subnet_pools;
     struct frequency_limit *new_connection_limiter;
 =
    struct initial_packet_rate_limit *initial_rate_limiter;
     struct mro=
ute_helper *route_helper;
diff --git a/src/openvpn/options=2Ec b/src/openvp=
n/options=2Ec
index 8e0c602=2E=2Eeb0bcfd 100644
--- a/src/openvpn/options=
=2Ec
+++ b/src/openvpn/options=2Ec
@@ -453,6 +453,12 @@
     "             =
     If seconds=3D0, file will be treated as read-only=2E\n"
     "--ifconf=
ig-ipv6-pool base-IP/bits : set aside an IPv6 network block\n"
     "      =
            to be dynamically allocated to connecting clients=2E\n"
+    "-=
-subnet-pool tag network netmask [gateway [start end]] : Define a named\n"
=
+    "                  pool of addresses outside the --server network, sel=
ected\n"
+    "                  per client with --subnet-pool-tag=2E start=
/end restrict the\n"
+    "                  dynamically assigned range=2E\=
n"
+    "--subnet-pool-tag tag : Assign this client to the --subnet-pool na=
med tag=2E\n"
+    "                  Only valid in a client-specific confi=
g file=2E\n"
     "--ifconfig-push local remote-netmask : Push an ifconfig =
option to remote,\n"
     "                  overrides --ifconfig-pool dyna=
mic allocation=2E\n"
     "                  Only valid in a client-specifi=
c config file=2E\n"
@@ -1899,6 +1905,20 @@
         {
             msg(M_US=
AGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6");
         }
+        if =
(options->subnet_pools)
+        {
+            if (!options->server_define=
d)
+            {
+                msg(M_USAGE, "--subnet-pool requires --s=
erver");
+            }
+            if (dev_type_enum(options->dev, option=
s->dev_type) !=3D DEV_TYPE_TUN
+                || options->topology !=3D T=
OP_SUBNET)
+            {
+                msg(M_USAGE, "--subnet-pool requ=
ires --dev tun and --topology subnet");
+            }
+            subnet_=
pools_check(options->subnet_pools, options->server_network,
+              =
                 options->server_netmask, M_USAGE);
+        }
         MUS=
T_BE_UNDEF(allow_recursive_routing, "allow-recursive-routing");
         if=
 (options->auth_user_pass_file)
         {
@@ -1965,6 +1985,7 @@
         M=
UST_BE_UNDEF(ifconfig_pool_defined, "ifconfig-pool");
         MUST_BE_UNDE=
F(ifconfig_pool_persist_filename, "ifconfig-pool-persist");
         MUST_B=
E_UNDEF(ifconfig_ipv6_pool_defined, "ifconfig-ipv6-pool");
+        MUST_BE=
_UNDEF(subnet_pools, "subnet-pool");
         MUST_BE_UNDEF(real_hash_size,=
 "hash-size");
         MUST_BE_UNDEF(virtual_hash_size, "hash-size");
    =
     MUST_BE_UNDEF(learn_address_script, "learn-address");
@@ -3097,6 +3118=
,28 @@
     }
 }
 
+/*
+ * The server's tun device is only configured with =
the --server network, so
+ * route each --subnet-pool network into it as we=
ll: without this the server
+ * could not reach its subnet-pool clients whe=
n the data channel runs in
+ * userspace=2E  Under DCO on Linux and FreeBSD=
 the routes are installed on-link,
+ * see subnet_pool_routes_onlink()=2E
+=
 */
+static void
+options_postprocess_subnet_pool_routes(struct options *o)=

+{
+    for (const struct subnet_pool_def *d =3D o->subnet_pools; d; d =3D=
 d->next)
+    {
+        struct route_option *ro;
+
+        rol_check_all=
oc(o);
+        ro =3D add_route_to_option_list(o->routes, print_in_addr_t(=
d->network, 0, &o->gc),
+                                      print_in_add=
r_t(d->netmask, 0, &o->gc), NULL, NULL,
+                                  =
    o->route_default_table_id);
+        ro->on_link =3D subnet_pool_routes=
_onlink(o);
+    }
+}
+
 static void
 options_postprocess_mutate(struct opt=
ions *o, struct env_set *es)
 {
@@ -3232,6 +3275,12 @@
         /* check if=
 any option should force disabling DCO */
         o->disable_dco =3D !dco_=
check_option(D_DCO, o) || !dco_check_startup_option(D_DCO, o);
     }
+
+  =
  if (o->mode =3D=3D MODE_SERVER)
+    {
+        /* how the pools are rout=
ed depends on the DCO decision above */
+        options_postprocess_subnet=
_pool_routes(o);
+    }
 #ifdef USE_COMP
     if (dco_enabled(o))
     {
@@=
 -6219,6 +6268,57 @@
             goto err;
         }
     }
+    else if =
(streq(p[0], "subnet-pool") && p[1] && p[2] && p[3] && (!p[5] || p[6]) && !=
p[7])
+    {
+        struct subnet_pool_def *sp;
+        in_addr_t networ=
k, netmask;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        network =
=3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2], 0, NULL, NULL);
+  =
      netmask =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, NULL, NULL);
+      =
  if (!network || !netmask)
+        {
+            msg(msglevel, "cannot p=
arse --subnet-pool addresses");
+            goto err;
+        }
+        =
ALLOC_OBJ_CLEAR_GC(sp, struct subnet_pool_def, &options->gc);
+        sp->=
tag =3D p[1];
+        sp->network =3D network & netmask;
+        sp->netm=
ask =3D netmask;
+        sp->gateway =3D (network & netmask) + 1;
+       =
 if (p[4])
+        {
+            bool ok =3D false;
+
+            sp->ga=
teway =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[4], 0, &ok, NULL)=
;
+            if (!ok)
+            {
+                msg(msglevel, "cann=
ot parse --subnet-pool gateway");
+                goto err;
+            }=

+        }
+        /* optional range of the dynamic pool, validated in
+ =
        * subnet_pools_check(); unset, it spans the whole subnet */
+      =
  if (p[5])
+        {
+            bool ok_start =3D false, ok_end =3D fal=
se;
+
+            sp->pool_start =3D getaddr(GETADDR_HOST_ORDER, p[5], 0, =
&ok_start, NULL);
+            sp->pool_end =3D getaddr(GETADDR_HOST_ORDER,=
 p[6], 0, &ok_end, NULL);
+            if (!ok_start || !ok_end)
+         =
   {
+                msg(msglevel, "cannot parse --subnet-pool range");
+ =
               goto err;
+            }
+        }
+        sp->next =3D op=
tions->subnet_pools;
+        options->subnet_pools =3D sp;
+    }
+    els=
e if (streq(p[0], "subnet-pool-tag") && p[1] && !p[2])
+    {
+        VERI=
FY_PERMISSION(OPT_P_INSTANCE);
+        options->subnet_pool_tag =3D p[1];
=
+    }
     else if (streq(p[0], "ifconfig-push-constraint") && p[1] && p[2=
] && !p[3])
     {
         in_addr_t network, netmask;
diff --git a/src/op=
envpn/options=2Eh b/src/openvpn/options=2Eh
index c58530a=2E=2E568bae6 1006=
44
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -252,6 +2=
52,21 @@
     struct verify_hash_list *next;
 };
 
+/* A named --subnet-poo=
l: a subnet clients can be assigned from, referenced
+ * from a CCD file by=
 its tag via --subnet-pool-tag=2E */
+struct subnet_pool_def
+{
+    struct=
 subnet_pool_def *next;
+    const char *tag;
+    in_addr_t network;
+    =
in_addr_t netmask;
+    in_addr_t gateway;
+    /* optional range of the dy=
namic pool (0/0: every host address of the
+     * subnet); addresses outsi=
de it are left for static --ifconfig-push */
+    in_addr_t pool_start;
+  =
  in_addr_t pool_end;
+};
+
 /* Command line options */
 struct options
 {
=
@@ -518,6 +533,12 @@
     bool push_ifconfig_constraint_defined;
     in_ad=
dr_t push_ifconfig_constraint_network;
     in_addr_t push_ifconfig_constra=
int_netmask;
+    struct subnet_pool_def *subnet_pools; /* named pools (ser=
ver config) */
+    const char *subnet_pool_tag;          /* which pool thi=
s client uses (CCD) */
+    bool subnet_pool_defined;             /* resolv=
ed from the tag at connect */
+    in_addr_t subnet_pool_network;
+    in_a=
ddr_t subnet_pool_netmask;
+    in_addr_t subnet_pool_gateway;
     bool pu=
sh_ifconfig_ipv4_blocked;           /* IPv4 */
     bool push_ifconfig_ipv6=
_defined;           /* IPv6 */
     struct in6_addr push_ifconfig_ipv6_loca=
l;  /* IPv6 */
@@ -979,4 +1000,23 @@
 #endif /* ENABLE_DCO */
 }
 
+/**
+ *=
 Whether the routes of the --subnet-pool networks are installed on-link on
=
+ * the DCO device rather than via a gateway=2E  With DCO on Linux and Free=
BSD the
+ * kernel selects the peer by a route's next hop, so a route via a=
 gateway
+ * would deliver every packet for an unassigned pool address to t=
he client
+ * owning that gateway address; on-link, such a packet matches n=
o peer, while
+ * each pool client gets its own on-link host route when it =
connects (see
+ * multi_learn_in_addr_t())=2E
+ */
+static inline bool
+sub=
net_pool_routes_onlink(const struct options *o)
+{
+#if defined(TARGET_LINU=
X) || defined(TARGET_FREEBSD)
+    return dco_enabled(o);
+#else
+    retur=
n false;
+#endif
+}
+
 #endif /* ifndef OPTIONS_H */
diff --git a/src/openv=
pn/options_util=2Ec b/src/openvpn/options_util=2Ec
index d25d85c=2E=2E862bf=
7c 100644
--- a/src/openvpn/options_util=2Ec
+++ b/src/openvpn/options_util=
=2Ec
@@ -30,6 +30,105 @@
 #include "options_util=2Eh"
 
 #include "push=2Eh=
"
+#include "pool=2Eh"
+
+const struct subnet_pool_def *
+subnet_pool_by_ta=
g(const struct subnet_pool_def *pools, const char *tag)
+{
+    for (const =
struct subnet_pool_def *d =3D pools; d; d =3D d->next)
+    {
+        if (=
!strcmp(d->tag, tag))
+        {
+            return d;
+        }
+    }
+=
    return NULL;
+}
+
+/* true if the two IPv4 subnets share at least one a=
ddress */
+static bool
+subnets_overlap(in_addr_t a, in_addr_t mask_a, in_a=
ddr_t b, in_addr_t mask_b)
+{
+    const in_addr_t mask =3D mask_a & mask_b=
;
+
+    return (a & mask) =3D=3D (b & mask);
+}
+
+bool
+subnet_pools_chec=
k(const struct subnet_pool_def *pools, in_addr_t server_network,
+         =
          in_addr_t server_netmask, msglvl_t msglevel)
+{
+    for (const s=
truct subnet_pool_def *d =3D pools; d; d =3D d->next)
+    {
+        const=
 in_addr_t host =3D ~d->netmask;
+        int netbits =3D 32;
+
+        /*=
 the netmask must be contiguous */
+        if (host & (host + 1))
+       =
 {
+            msg(msglevel, "--subnet-pool %s: invalid netmask", d->tag);=

+            return false;
+        }
+        for (in_addr_t h =3D host; =
h; h >>=3D 1)
+        {
+            netbits--;
+        }
+
+        /* s=
ame bounds as --server: the pool must hold at least 2 addresses
+         *=
 besides network, gateway and broadcast, and fit IFCONFIG_POOL_MAX */
+    =
    if (netbits < IFCONFIG_POOL_MIN_NETBITS || netbits > 29)
+        {
+  =
          msg(msglevel, "--subnet-pool %s: netmask must be between /%d and =
/29 (not /%d)",
+                d->tag, IFCONFIG_POOL_MIN_NETBITS, netbits=
);
+            return false;
+        }
+
+        if ((d->gateway & d->ne=
tmask) !=3D d->network || d->gateway =3D=3D d->network
+            || d->g=
ateway =3D=3D (d->network | host))
+        {
+            msg(msglevel, "-=
-subnet-pool %s: gateway must be a host address inside the subnet",
+      =
          d->tag);
+            return false;
+        }
+
+        /* an e=
xplicit dynamic range must be made of host addresses of the
+         * sub=
net and hold at least the 2 entries an ifconfig pool needs */
+        if (=
(d->pool_start || d->pool_end)
+            && ((d->pool_start & d->netmask=
) !=3D d->network
+                || (d->pool_end & d->netmask) !=3D d->ne=
twork || d->pool_start =3D=3D d->network
+                || d->pool_end =
=3D=3D (d->network | host) || d->pool_start >=3D d->pool_end))
+        {
+=
            msg(msglevel,
+                "--subnet-pool %s: range start a=
nd end must be host addresses inside the "
+                "subnet, with s=
tart lower than end",
+                d->tag);
+            return false;
=
+        }
+
+        if (server_netmask
+            && subnets_overlap(d-=
>network, d->netmask, server_network, server_netmask))
+        {
+        =
    msg(msglevel, "--subnet-pool %s: subnet overlaps the --server network",=
 d->tag);
+            return false;
+        }
+
+        for (const struc=
t subnet_pool_def *e =3D d->next; e; e =3D e->next)
+        {
+           =
 if (!strcmp(d->tag, e->tag))
+            {
+                msg(msglevel,=
 "--subnet-pool %s: tag defined more than once", d->tag);
+                =
return false;
+            }
+            if (subnets_overlap(d->network, d=
->netmask, e->network, e->netmask))
+            {
+                msg(msg=
level, "--subnet-pool %s and %s: subnets overlap", d->tag, e->tag);
+      =
          return false;
+            }
+        }
+    }
+
+    return true=
;
+}
 
 const char *
 parse_auth_failed_temp(struct options *o, const char =
*reason)
diff --git a/src/openvpn/options_util=2Eh b/src/openvpn/options_ut=
il=2Eh
index 5226a6f=2E=2Ef1e63e15 100644
--- a/src/openvpn/options_util=2E=
h
+++ b/src/openvpn/options_util=2Eh
@@ -28,6 +28,33 @@
 
 const char *pars=
e_auth_failed_temp(struct options *o, const char *reason);
 
+/**
+ * Look =
up a named --subnet-pool in a list of pool definitions=2E
+ *
+ * @param po=
ols  head of the --subnet-pool list (may be NULL)
+ * @param tag    the --s=
ubnet-pool-tag to match
+ * @return       the matching pool definition, or =
NULL if none matches
+ */
+const struct subnet_pool_def *subnet_pool_by_tag=
(const struct subnet_pool_def *pools,
+                                    =
             const char *tag);
+
+/**
+ * Validate the --subnet-pool defini=
tions: contiguous netmask between
+ * /IFCONFIG_POOL_MIN_NETBITS and /29, g=
ateway a host address inside its
+ * subnet, an explicit dynamic range made=
 of at least 2 host addresses of the
+ * subnet,
+ * unique tags, and no su=
bnet overlapping another pool or the --server
+ * network=2E
+ *
+ * @param=
 pools           head of the --subnet-pool list (may be NULL)
+ * @param se=
rver_network  the --server network (host order)
+ * @param server_netmask  =
the --server netmask, or 0 if there is none
+ * @param msglevel        leve=
l of the message logged on the first error
+ * @return                true =
if every definition is valid
+ */
+bool subnet_pools_check(const struct sub=
net_pool_def *pools, in_addr_t server_network,
+                        in_=
addr_t server_netmask, msglvl_t msglevel);
+
 
 /** Checks if the string is=
 a valid integer by checking if it can be
  *  converted to an integer */
d=
iff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec
index fff0e3f=2E=2E=
5c5b3fe 100644
--- a/src/openvpn/pool=2Ec
+++ b/src/openvpn/pool=2Ec
@@ -35=
1,7 +351,7 @@
 {
     bool ret =3D false;
 
-    if (pool && hand >=3D 0 &&=
 hand < pool->size)
+    if (pool && hand >=3D 0 && hand < pool->size && !p=
ool->list[hand]=2Ereserved)
     {
         ifconfig_pool_entry_free(&pool-=
>list[hand], hard);
         ret =3D true;
@@ -430,6 +430,22 @@
     return=
 ret;
 }
 
+bool
+ifconfig_pool_reserve_ip(struct ifconfig_pool *pool, cons=
t in_addr_t addr)
+{
+    const ifconfig_pool_handle h =3D ifconfig_pool_ip=
_base_to_handle(pool, addr);
+
+    if (h < 0)
+    {
+        return false=
;
+    }
+
+    ifconfig_pool_entry_free(&pool->list[h], true);
+    pool->=
list[h]=2Ein_use =3D true;
+    pool->list[h]=2Ereserved =3D true;
+    ret=
urn true;
+}
+
 static in_addr_t
 ifconfig_pool_handle_to_ip_base(const str=
uct ifconfig_pool *pool, ifconfig_pool_handle hand)
 {
@@ -477,6 +493,13 @@=

                   const bool fixed)
 {
     struct ifconfig_pool_entry *e=
 =3D &pool->list[h];
+
+    if (e->reserved)
+    {
+        msg(M_WARN, "p=
ool: ignoring persisted entry for CN=3D%s: its address is reserved", cn);
+=
        return;
+    }
+
     ifconfig_pool_entry_free(e, true);
     e->in=
_use =3D false;
     e->common_name =3D string_alloc(cn, NULL);
diff --git =
a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh
index e2d3f82=2E=2E497dcda 10=
0644
--- a/src/openvpn/pool=2Eh
+++ b/src/openvpn/pool=2Eh
@@ -43,6 +43,7 @=
@
     char *common_name;
     time_t last_release;
     bool fixed;
+    b=
ool reserved; /* never handed out, e=2Eg=2E a --subnet-pool gateway */
 };
=
 
 struct ifconfig_pool
@@ -86,6 +87,17 @@
 
 bool ifconfig_pool_release(st=
ruct ifconfig_pool *pool, ifconfig_pool_handle hand, const bool hard);
 
+/=
**
+ * Permanently reserve the pool slot holding \c addr, so that it is nev=
er
+ * handed out to a client nor taken over by a persisted entry (e=2Eg=2E=
 the
+ * gateway of a --subnet-pool)=2E
+ *
+ * @param pool  the pool
+ * @=
param addr  IPv4 address (host order) to reserve
+ * @return      true if \=
c addr lies in the pool and was reserved
+ */
+bool ifconfig_pool_reserve_i=
p(struct ifconfig_pool *pool, in_addr_t addr);
+
 struct ifconfig_pool_pers=
ist *ifconfig_pool_persist_init(const char *filename, int refresh_freq);
 
=
 void ifconfig_pool_persist_close(struct ifconfig_pool_persist *persist);
d=
iff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index 0bce966=2E=
=2Efecef7e 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@=
@ -408,6 +408,11 @@
         r->flags |=3D RT_METRIC_DEFINED;
     }
 
+   =
 if (ro->on_link)
+    {
+        r->flags |=3D RT_ON_LINK;
+    }
+
     r=
->flags |=3D RT_DEFINED;
 
     /* routing table id */
@@ -478,12 +483,12 @=
@
     return false;
 }
 
-void
+struct route_option *
 add_route_to_option=
_list(struct route_option_list *l, const char *network, const char *netmask=
,
                          const char *gateway, const char *metric, int ta=
ble_id)
 {
     struct route_option *ro;
-    ALLOC_OBJ_GC(ro, struct route=
_option, l->gc);
+    ALLOC_OBJ_CLEAR_GC(ro, struct route_option, l->gc);
 =
    ro->network =3D network;
     ro->netmask =3D netmask;
     ro->gateway=
 =3D gateway;
@@ -491,6 +496,7 @@
     ro->table_id =3D table_id;
     ro->=
next =3D l->routes;
     l->routes =3D ro;
+    return ro;
 }
 
 void
@@ -1=
322,7 +1328,11 @@
     {
         setenv_route_addr(es, "network", r->netwo=
rk, i);
         setenv_route_addr(es, "netmask", r->netmask, i);
-        =
setenv_route_addr(es, "gateway", r->gateway, i);
+        /* an on-link rou=
te has no gateway */
+        if (!(r->flags & RT_ON_LINK))
+        {
+   =
         setenv_route_addr(es, "gateway", r->gateway, i);
+        }
 
    =
     if (r->flags & RT_METRIC_DEFINED)
         {
@@ -1478,6 +1488,7 @@
 
 =
#if defined(TARGET_LINUX)
     const char *iface =3D NULL;
+    const in_ad=
dr_t *gateway =3D &r->gateway;
     int metric =3D -1;
 
     if (is_on_lin=
k(is_local_route, flags, rgi))
@@ -1485,6 +1496,12 @@
         iface =3D rg=
i->iface;
     }
 
+    if ((r->flags & RT_ON_LINK) && tt)
+    {
+        =
gateway =3D NULL;
+        iface =3D tt->actual_name;
+    }
+
     if (r->=
flags & RT_METRIC_DEFINED)
     {
         metric =3D r->metric;
@@ -1492,8=
 +1509,8 @@
 
 
     status =3D RTA_SUCCESS;
-    int ret =3D net_route_v4_=
add(ctx, &r->network, netmask_to_netbits2(r->netmask), &r->gateway,
-      =
                         iface, r->table_id, metric);
+    int ret =3D net_=
route_v4_add(ctx, &r->network, netmask_to_netbits2(r->netmask), gateway, if=
ace,
+                               r->table_id, metric);
     if (ret =3D=
=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE: Linux route add command fa=
iled because route exists");
@@ -1616,7 +1633,15 @@
     }
 #endif
 
-    a=
rgv_printf_cat(&argv, "-net %s %s %s", network, gateway, netmask);
+    if =
((r->flags & RT_ON_LINK) && tt)
+    {
+        argv_printf_cat(&argv, "-ne=
t %s/%d -iface %s", network, netmask_to_netbits2(r->netmask),
+            =
            tt->actual_name);
+    }
+    else
+    {
+        argv_printf_=
cat(&argv, "-net %s %s %s", network, gateway, netmask);
+    }
 
     /* FI=
XME -- add on-link support for FreeBSD */
 
@@ -2035,7 +2060,16 @@
        =
 metric =3D r->metric;
     }
 
-    if (net_route_v4_del(ctx, &r->network,=
 netmask_to_netbits2(r->netmask), &r->gateway, NULL,
+    const in_addr_t *=
gateway =3D &r->gateway;
+    const char *iface =3D NULL;
+
+    if ((r->fl=
ags & RT_ON_LINK) && tt)
+    {
+        gateway =3D NULL;
+        iface =
=3D tt->actual_name;
+    }
+
+    if (net_route_v4_del(ctx, &r->network, n=
etmask_to_netbits2(r->netmask), gateway, iface,
                          r=
->table_id, metric)
         < 0)
     {
@@ -2091,7 +2125,15 @@
 
 #elif de=
fined(TARGET_FREEBSD)
 
-    argv_printf(&argv, "%s delete -net %s %s %s", =
ROUTE_PATH, network, gateway, netmask);
+    if ((r->flags & RT_ON_LINK) &&=
 tt)
+    {
+        argv_printf(&argv, "%s delete -net %s/%d -iface %s", R=
OUTE_PATH, network,
+                    netmask_to_netbits2(r->netmask), t=
t->actual_name);
+    }
+    else
+    {
+        argv_printf(&argv, "%s de=
lete -net %s %s %s", ROUTE_PATH, network, gateway, netmask);
+    }
 
     =
argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, es, 0, "ERROR: F=
reeBSD route delete command failed");
diff --git a/src/openvpn/route=2Eh b/=
src/openvpn/route=2Eh
index 0d33d36=2E=2E7c5528f 100644
--- a/src/openvpn/r=
oute=2Eh
+++ b/src/openvpn/route=2Eh
@@ -80,6 +80,10 @@
     const char *ga=
teway;
     int table_id;
     const char *metric;
+    /* on Linux and Fre=
eBSD, install the route on-link on the tun device
+     * instead of via th=
e gateway (needed under DCO, where the kernel selects
+     * the peer by t=
he route's next hop) */
+    bool on_link;
 };
 
 /* redirect-gateway flags=
 */
@@ -120,6 +124,7 @@
 #define RT_DEFINED        (1u << 0)
 #define RT_AD=
DED          (1u << 1)
 #define RT_METRIC_DEFINED (1u << 2)
+#define RT_ON_=
LINK        (1u << 3) /* see struct route_option=2Eon_link */
     struct r=
oute_ipv4 *next;
     unsigned int flags;
     const struct route_option *o=
ption;
@@ -311,8 +316,9 @@
                const struct route_gateway_info =
*rgi, const struct env_set *es,
                openvpn_net_ctx_t *ctx);
 
=
-void add_route_to_option_list(struct route_option_list *l, const char *net=
work, const char *netmask,
-                              const char *gatew=
ay, const char *metric, int table_id);
+struct route_option *add_route_to_o=
ption_list(struct route_option_list *l, const char *network,
+             =
                                 const char *netmask, const char *gateway,
=
+                                              const char *metric, int tabl=
e_id);
 
 void add_route_ipv6_to_option_list(struct route_ipv6_option_list =
*l, const char *prefix,
                                    const char *gat=
eway, const char *metric, int table_id);
diff --git a/tests/unit_tests/open=
vpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 43a6743=2E=
=2E5f2a75b 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/=
unit_tests/openvpn/Makefile=2Eam
@@ -392,6 +392,7 @@
 
 misc_testdriver_SOU=
RCES =3D test_misc=2Ec \
 	test_schedule=2Ec test_schedule=2Eh \
+	test_sub=
net_pool=2Ec test_subnet_pool=2Eh \
 	mock_msg=2Ec test_common=2Eh  \
 	moc=
k_get_random=2Ec \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
diff --g=
it a/tests/unit_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test=
_misc=2Ec
index aea40f0=2E=2E06fd9aa 100644
--- a/tests/unit_tests/openvpn/=
test_misc=2Ec
+++ b/tests/unit_tests/openvpn/test_misc=2Ec
@@ -45,6 +45,7 @=
@
 #include "win32-util=2Eh"
 #endif
 #include "test_schedule=2Eh"
+#includ=
e "test_subnet_pool=2Eh"
 
 static void
 test_compat_lzo_string(void **stat=
e)
@@ -561,7 +562,12 @@
     cmocka_unit_test(test_list),
     cmocka_unit_=
test(test_atoi_variants),
     cmocka_unit_test(schedule_test),
-    cmocka=
_unit_test(test_sid_hash_list)
+    cmocka_unit_test(test_sid_hash_list),
+=
    cmocka_unit_test(test_subnet_pool_by_tag),
+    cmocka_unit_test(test_s=
ubnet_pools_check_netmask),
+    cmocka_unit_test(test_subnet_pools_check_g=
ateway),
+    cmocka_unit_test(test_subnet_pools_check_range),
+    cmocka_=
unit_test(test_subnet_pools_check_overlap),
 };
 
 int
diff --git a/tests/u=
nit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subn=
et_pool=2Ec
new file mode 100644
index 0000000=2E=2E10c0bc5
--- /dev/null
+=
++ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
@@ -0,0 +1,160 @@
+/*
+ =
*  OpenVPN -- An application to securely tunnel IP networks
+ *            =
 over a single UDP port, with support for SSL/TLS-based
+ *             ses=
sion authentication and key exchange,
+ *             packet encryption, pa=
cket authentication, and
+ *             packet compression=2E
+ *
+ *  Cop=
yright (C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is =
free software; you can redistribute it and/or modify
+ *  it under the term=
s of the GNU General Public License version 2
+ *  as published by the Free=
 Software Foundation=2E
+ *
+ *  This program is distributed in the hope th=
at it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the impli=
ed warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E =
 See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You s=
hould have received a copy of the GNU General Public License along
+ *  wit=
h this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+=
#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2E=
h"
+
+#include <stdlib=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+=

+#include "options=2Eh"
+#include "options_util=2Eh"
+#include "test_commo=
n=2Eh"
+#include "test_subnet_pool=2Eh"
+#include "mock_msg=2Eh"
+
+/* --su=
bnet-pool-tag resolves a client to its --subnet-pool; an unknown tag
+ * re=
turns NULL, which is what makes the server reject that client=2E */
+void
+=
test_subnet_pool_by_tag(void **state)
+{
+    struct subnet_pool_def c =3D =
{ =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetwork =3D 0x0a020300, =2Enetmas=
k =3D 0xffffff00, =2Egateway =3D 0x0a020301 };
+    struct subnet_pool_def =
b =3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Enetwork =3D 0x0a020200, =2Ene=
tmask =3D 0xffffff00, =2Egateway =3D 0x0a020201 };
+    struct subnet_pool_=
def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =2Enetwork =3D 0x0a020100, =
=2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020101 };
+
+    /* every con=
figured tag resolves to its own pool, wherever it sits */
+    assert_ptr_e=
qual(subnet_pool_by_tag(&a, "grpA"), &a);
+    assert_ptr_equal(subnet_pool=
_by_tag(&a, "grpB"), &b);
+    assert_ptr_equal(subnet_pool_by_tag(&a, "grp=
C"), &c);
+
+    /* and it carries that pool's subnet/gateway */
+    const=
 struct subnet_pool_def *r =3D subnet_pool_by_tag(&a, "grpB");
+    assert_=
int_equal(r->network, 0x0a020200);
+    assert_int_equal(r->netmask, 0xffff=
ff00);
+    assert_int_equal(r->gateway, 0x0a020201);
+
+    /* unknown tag=
 and empty list both miss */
+    assert_null(subnet_pool_by_tag(&a, "nope"=
));
+    assert_null(subnet_pool_by_tag(NULL, "grpA"));
+}
+
+/* a single p=
ool <net>/<mask> with gateway <gw>, checked against the
+ * 10=2E8=2E0=2E0/=
24 --server network */
+static bool
+check_one(in_addr_t net, in_addr_t mas=
k, in_addr_t gw)
+{
+    struct subnet_pool_def d =3D { =2Enext =3D NULL, =
=2Etag =3D "grp", =2Enetwork =3D net, =2Enetmask =3D mask, =2Egateway =3D g=
w };
+
+    return subnet_pools_check(&d, 0x0a080000, 0xffffff00, M_WARN);
=
+}
+
+/* --subnet-pool geometry: anything ifconfig_pool_init() cannot serve=
 must be
+ * refused when the config is checked, not when the first client =
connects */
+void
+test_subnet_pools_check_netmask(void **state)
+{
+    /*=
 the bounds of --server: /16 =2E=2E /29 */
+    assert_true(check_one(0x0a0=
90000, 0xffff0000, 0x0a090001));
+    assert_true(check_one(0x0a090000, 0xf=
fffff00, 0x0a090001));
+    assert_true(check_one(0x0a090000, 0xfffffff8, 0=
x0a090001));
+    /* /30, /31, /32: too few addresses for a pool */
+    as=
sert_false(check_one(0x0a090000, 0xfffffffc, 0x0a090001));
+    assert_fals=
e(check_one(0x0a090000, 0xfffffffe, 0x0a090001));
+    assert_false(check_o=
ne(0x0a090000, 0xffffffff, 0x0a090000));
+    /* /15: larger than IFCONFIG_=
POOL_MAX */
+    assert_false(check_one(0x0a080000, 0xfffe0000, 0x0a080001)=
);
+    /* non-contiguous netmask */
+    assert_false(check_one(0x0a000900=
, 0xff00ff00, 0x0a000901));
+}
+
+void
+test_subnet_pools_check_gateway(voi=
d **state)
+{
+    /* any host address of the subnet is fine, not only the =
first one */
+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a0900fe)=
);
+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a090080));
+    /*=
 network address, broadcast address, outside the subnet */
+    assert_fals=
e(check_one(0x0a090000, 0xffffff00, 0x0a090000));
+    assert_false(check_o=
ne(0x0a090000, 0xffffff00, 0x0a0900ff));
+    assert_false(check_one(0x0a09=
0000, 0xffffff00, 0x0a0a0001));
+}
+
+/* a 10=2E9=2E0=2E0/24 pool with dyna=
mic range <start>-<end> */
+static bool
+check_range(in_addr_t start, in_ad=
dr_t end)
+{
+    struct subnet_pool_def d =3D { =2Enext =3D NULL, =2Etag =
=3D "grp", =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway=
 =3D 0x0a090001, =2Epool_start =3D start, =2Epool_end =3D end };
+
+    ret=
urn subnet_pools_check(&d, 0x0a080000, 0xffffff00, M_WARN);
+}
+
+/* the op=
tional dynamic range: host addresses of the subnet, at least 2 */
+void
+te=
st_subnet_pools_check_range(void **state)
+{
+    /* unset: the whole subne=
t */
+    assert_true(check_range(0, 0));
+    /* a sub-range, the smallest=
 one, the whole host range */
+    assert_true(check_range(0x0a090064, 0x0a=
0900c8));
+    assert_true(check_range(0x0a090064, 0x0a090065));
+    asser=
t_true(check_range(0x0a090001, 0x0a0900fe));
+    /* a single address, or s=
tart past end */
+    assert_false(check_range(0x0a090064, 0x0a090064));
+ =
   assert_false(check_range(0x0a0900c8, 0x0a090064));
+    /* the network o=
r broadcast address */
+    assert_false(check_range(0x0a090000, 0x0a090064=
));
+    assert_false(check_range(0x0a090064, 0x0a0900ff));
+    /* outside=
 the subnet */
+    assert_false(check_range(0x0a090064, 0x0a0a0001));
+   =
 assert_false(check_range(0x0a080064, 0x0a090064));
+}
+
+void
+test_subnet=
_pools_check_overlap(void **state)
+{
+    struct subnet_pool_def b =3D { =
=2Enext =3D NULL, =2Etag =3D "grpB", =2Enetwork =3D 0x0a0a0000, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };
+    struct subnet_pool_def a =
=3D { =2Enext =3D &b, =2Etag =3D "grpA", =2Enetwork =3D 0x0a090000, =2Enetm=
ask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
+
+    /* disjoint pools, =
disjoint from --server */
+    assert_true(subnet_pools_check(&a, 0x0a08000=
0, 0xffffff00, M_WARN));
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
struct subnet_pool_def b16 =3D { =2Enext =3D NULL, =2Etag =3D "grpB", =2Ene=
twork =3D 0x0a090000, =2Enetmask =3D 0xffff0000, =2Egateway =3D 0x0a090101 =
};
+    struct subnet_pool_def a16 =3D { =2Enext =3D &b16, =2Etag =3D "grpA=
", =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0=
a090001 };
+    assert_false(subnet_pools_check(&a16, 0, 0, M_WARN));
+
+  =
  /* the same tag defined twice */
+    struct subnet_pool_def bdup =3D { =
=2Enext =3D NULL, =2Etag =3D "grpA", =2Enetwork =3D 0x0a0a0000, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };
+    struct subnet_pool_def ad=
up =3D { =2Enext =3D &bdup, =2Etag =3D "grpA", =2Enetwork =3D 0x0a090000, =
=2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
+    assert_false(s=
ubnet_pools_check(&adup, 0, 0, M_WARN));
+}
diff --git a/tests/unit_tests/o=
penvpn/test_subnet_pool=2Eh b/tests/unit_tests/openvpn/test_subnet_pool=2Eh=

new file mode 100644
index 0000000=2E=2E2a1f882
--- /dev/null
+++ b/tests/=
unit_tests/openvpn/test_subnet_pool=2Eh
@@ -0,0 +1,37 @@
+/*
+ *  OpenVPN -=
- An application to securely tunnel IP networks
+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based
+ *             session aut=
hentication and key exchange,
+ *             packet encryption, packet aut=
hentication, and
+ *             packet compression=2E
+ *
+ *  Copyright (=
C) 2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free sof=
tware; you can redistribute it and/or modify
+ *  it under the terms of the=
 GNU General Public License version 2
+ *  as published by the Free Softwar=
e Foundation=2E
+ *
+ *  This program is distributed in the hope that it wi=
ll be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=

+ *  GNU General Public License for more details=2E
+ *
+ *  You should ha=
ve received a copy of the GNU General Public License along
+ *  with this p=
rogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+#ifndef SU=
BNET_POOL_TEST_H
+#define SUBNET_POOL_TEST_H
+
+/* --subnet-pool tests, run=
 as part of misc_testdriver */
+
+void test_subnet_pool_by_tag(void **state=
);
+
+void test_subnet_pools_check_netmask(void **state);
+
+void test_subn=
et_pools_check_gateway(void **state);
+
+void test_subnet_pools_check_range=
(void **state);
+
+void test_subnet_pools_check_overlap(void **state);
+
+#=
endif

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?u=
sp=3Demail
To unsubscribe, or for help writing mail filters, visit https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1e7db95=
615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783
Gerrit-PatchSet=
: 9
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Ecom>
Gerrit-Review=
er: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichte=
nheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doering <gert@greenie=
=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2E=
net>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--LlOhQPPCW/0=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli <strong>uploaded patch set #9</strong> to this change=2E</p><p><a h=
ref=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">View Ch=
ange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">multi: assign clients from a named, tagged subnet=
-pool<br><br>Add two server directives:<br><br>  subnet-pool &lt;tag&gt; &l=
t;network&gt; &lt;netmask&gt; [&lt;gateway&gt; [&lt;start&gt; &lt;end&gt;]]=
<br>                                                      (main config)<br>=
  subnet-pool-tag &lt;tag&gt;                               (per-client CCD=
)<br><br>so groups of clients can be given addresses from subnets other tha=
n the<br>--server network (per-group firewall rules under --topology subnet=
, and<br>thus DCO)=2E A client&#39;s subnet-pool-tag is resolved to its poo=
l and served<br>a virtual IP from that subnet: a static --ifconfig-push wit=
hin it, or<br>the next free address from a dynamic per-group pool shared by=
 tag=2E The<br>dynamic pool spans the whole subnet unless a start-end range=
 is given,<br>which leaves the rest of the subnet to static addresses (thes=
e are not<br>reserved in the pool)=2E Such a client is validated against it=
s own subnet<br>instead of the global tunnel-network constraint and never f=
alls back to<br>the global pool; a tag matching no configured pool is decli=
ned with<br>AUTH_FAILED=2E The tag is resolved again after every client-con=
nect<br>handler, so a script, plugin or management interface may override t=
he<br>one set by the CCD file=2E<br><br>The pools are checked when the conf=
ig is loaded, as for --server: the<br>netmask must be contiguous and betwee=
n /16 and /29, the gateway a host<br>address inside the subnet, a range (if=
 any) at least two host addresses<br>of the subnet, tags unique, and no poo=
l may overlap another or the<br>--server network=2E Every pool is created a=
t startup, and its gateway is<br>reserved so it is never handed out to a cl=
ient=2E<br><br>The server routes each pool&#39;s subnet into its tun device=
, as the device<br>is only configured with the --server network: without th=
is the server<br>cannot reach its subnet-pool clients=2E This is a regular =
--route, so it<br>is installed before privileges are dropped and honours --=
route-table,<br>--route-metric and --route-noexec=2E Under DCO on Linux and=
 FreeBSD,<br>though, the kernel selects the peer by the route&#39;s next ho=
p, so a route<br>via a gateway would deliver every packet for an unassigned=
 pool address<br>to the client owning that gateway address: there the route=
 is installed<br>on-link on the tun device instead (a new on_link route opt=
ion flag), and<br>each client of the pool gets its own on-link host route o=
n connect (as<br>its address is outside the --ifconfig network), so such pa=
ckets match<br>no peer=2E<br><br>While here, the tunnel-network constraint =
violation is logged as a<br>WARNING instead of MULTI ERROR, as it does not =
fail the connection=2E<br><br>Change-Id: Ia1e7db95615d99ef9687de7c4e996dc80=
33e2631<br>GitHub: closes openvpn/OpenVPN#987<br>Signed-off-by: Antonio Qua=
rtulli &lt;antonio@mandelbit=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M do=
c/man-sections/server-options=2Erst<br>M src/openvpn/multi=2Ec<br>M src/ope=
nvpn/multi=2Eh<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br=
>M src/openvpn/options_util=2Ec<br>M src/openvpn/options_util=2Eh<br>M src/=
openvpn/pool=2Ec<br>M src/openvpn/pool=2Eh<br>M src/openvpn/route=2Ec<br>M =
src/openvpn/route=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>M test=
s/unit_tests/openvpn/test_misc=2Ec<br>A tests/unit_tests/openvpn/test_subne=
t_pool=2Ec<br>A tests/unit_tests/openvpn/test_subnet_pool=2Eh<br>16 files c=
hanged, 765 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1783/9</pre>=
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
ons/server-options=2Erst</span><br><span>index 9dfa6bd=2E=2E9434e5d 100644<=
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
et-pool tag network netmask [gateway [start end]]</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  ``tag`` is a name a client refers to with ``--subnet-pool-tag`=
`; ``gateway``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  def=
aults to the first address of ``network``/``netmask`` and is never</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  assigned to a client=2E A =
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
, each ``tag``</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  may=
 be defined only once and no pool may overlap another one or the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  ``--server`` network=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
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
pool-tag tag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Assig=
n this client to the ``--subnet-pool`` named ``tag``=2E Must be</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  associated with a specific cl=
ient instance via ``--client-config-dir`` or</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  ``--client-connect``=2E Several clients may refe=
rence the same tag and are</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  then served from the same shared pool=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> --ifconfig-ipv6-push args</=
span><br><span>   for ``--client-config-dir`` per-client static IPv6 interf=
ace</span><br><span>   configuration, see ``--client-config-dir`` and ``--i=
fconfig-push`` for</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src=
/openvpn/multi=2Ec</span><br><span>index e302a81=2E=2Ee8d51da 100644</span>=
<br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mul=
ti=2Ec</span><br><span>@@ -43,6 +43,7 @@</span><br><span> #include &quot;au=
th_token=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;</span><b=
r><span> #include &quot;sid_hash=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;</span><br><spa=
n> #include &lt;inttypes=2Eh&gt;</span><br><span> #include &lt;string=2Eh&g=
t;</span><br><span> </span><br><span>@@ -54,6 +55,21 @@</span><br><span> #i=
nclude &quot;dco=2Eh&quot;</span><br><span> #include &quot;reflect_filter=
=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Dynam=
ic address pool serving the clients of one --subnet-pool tag=2E  Shared</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by every client that=
 references the tag, created at startup by</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * multi_init()=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+struct subnet_pool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct su=
bnet_pool *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const char *tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct ifconfig_pool *pool;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static struct ifconfig_poo=
l *multi_get_group_pool(struct multi_context *m,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                              =
    const struct options *o, const char *tag);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> /*#define MULTI_DEBUG_EVENT_LO=
OP*/</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span=
><br><span>@@ -371,6 +387,13 @@</span><br><span>         }</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* create every --subnet-pool group up front rather than on first =
use, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * that =
its pool exists before any client of the group connects */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool_de=
f *d =3D t-&gt;options=2Esubnet_pools; d; d =3D d-&gt;next)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        multi_get_group_pool(m, &amp;t-&gt;option=
s, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   /*</span><br><span>      * Help us keep track of routing table=2E</span>=
<br><span>      */</span><br><span>@@ -625,7 +648,8 @@</span><br><span> </s=
pan><br><span>         schedule_remove_entry(m-&gt;schedule, (struct schedu=
le_entry *)mi);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        ifconfig_pool_release(m-&gt;ifconfig_pool, mi-&gt;vaddr=
_handle, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;if=
config_pool, mi-&gt;vaddr_handle,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                              false);</span><br><span> </span=
><br><span>         if (mi-&gt;did_iroutes)</span><br><span>         {</spa=
n><br><span>@@ -707,6 +731,14 @@</span><br><span>         schedule_free(m-&=
gt;schedule);</span><br><span>         mbuf_free(m-&gt;mbuf);</span><br><sp=
an>         ifconfig_pool_free(m-&gt;ifconfig_pool);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        while (m-&gt;subnet_pools)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            struct subnet_pool *sp =
=3D m-&gt;subnet_pools;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m-&=
gt;subnet_pools =3D sp-&gt;next;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            ifconfig_pool_free(sp-&gt;pool);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            free(sp);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         =
frequency_limit_free(m-&gt;new_connection_limiter);</span><br><span>       =
  initial_rate_limit_free(m-&gt;initial_rate_limiter);</span><br><span>    =
     multi_reap_free(m-&gt;reaper);</span><br><span>@@ -1405,6 +1437,12 @@<=
/span><br><span>     const struct options *o =3D &amp;c-&gt;options;</span>=
<br><span>     if (o-&gt;push_ifconfig_constraint_defined &amp;&amp; c-&gt;=
c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* a subnet-pool client is validated=
 against its own subnet */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (o-&gt;subnet_pool_defined)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            return (o-&gt;subnet_pool_netmask &amp; c-&gt;c=
2=2Epush_ifconfig_local)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                   =3D=3D o-&gt;subnet_pool_network;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         re=
turn (o-&gt;push_ifconfig_constraint_netmask &amp; c-&gt;c2=2Epush_ifconfig=
_local)</span><br><span>                =3D=3D o-&gt;push_ifconfig_constrai=
nt_network;</span><br><span>     }</span><br><span>@@ -1415,6 +1453,40 @@</=
span><br><span> }</span><br><span> </span><br><span> /*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * Return the dynamic pool serving the =
clients tagged with &lt;tag&gt;, creating it</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * from the matching --subnet-pool definition in &=
lt;o&gt; if it does not exist yet</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * (which only happens when multi_init() creates every pool a=
t startup)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static struct ifconfig=
_pool *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_get_gr=
oup_pool(struct multi_context *m, const struct options *o, const char *tag)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool *sp;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet_pools; sp; sp =3D s=
p-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!strcmp(sp=
-&gt;tag, tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct subnet_pool_def *d4 =3D subn=
et_pool_by_tag(o-&gt;subnet_pools, tag);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ASSERT(d4);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;tag =3D d4-&gt;tag;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the configured =
dynamic range, or else every host address of the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * subnet, minus the gateway reserved belo=
w if it falls inside it */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const in_addr_t start =3D d4-&gt;pool_start ? d4-&gt;pool_start =
: d4-&gt;network + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const in_addr_t end =3D d4-&gt;pool_end ? d4-&gt;pool_end : (d4-&gt;n=
etwork | ~d4-&gt;netmask) - 1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    sp-&gt;pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV=
, start, end, o-&gt;duplicate_cn, false,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                  in6addr_any, 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_reser=
ve_ip(sp-&gt;pool, d4-&gt;gateway);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    sp-&gt;next =3D m-&gt;subnet_pools;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    m-&gt;subnet_pools =3D sp;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return sp-&gt;pool;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span>  * Select a virtual address for a new cl=
ient instance=2E</span><br><span>  * Use an --ifconfig-push directive, if g=
iven (static IP)=2E</span><br><span>  * Otherwise use an --ifconfig-pool ad=
dress (dynamic IP)=2E</span><br><span>@@ -1424,6 +1496,25 @@</span><br><spa=
n> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* resolve --s=
ubnet-pool-tag against the main-config --subnet-pool list (an</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * unknown tag is rejected wi=
th AUTH_FAILED in multi_connection_established)=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * This runs again after every client-co=
nnect handler, and a later handler</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * (script, plugin, management) may override the tag set=
 by the CCD file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * so always resolve the current tag=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        const struct subnet_pool=
_def *d =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=
=2Eoptions=2Esubnet_pool_tag);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
mi-&gt;context=2Eoptions=2Esubnet_pool_defined =3D d !=3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (d)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_=
pool_network =3D d-&gt;network;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_netmask =3D =
d-&gt;netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi-&gt;context=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;gateway;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><span>     =
 * If ifconfig addresses were set by dynamic config file,</span><br><span> =
     * release pool addresses, otherwise keep them=2E</span><br><span>@@ -1=
434,8 +1525,10 @@</span><br><span>          * release dynamic allocation */=
</span><br><span>         if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   ifconfig_pool_release(m-&gt;ifconfig_pool, mi-&gt;vaddr_handle, true);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ifconfig_=
pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconfig_pool,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
             mi-&gt;vaddr_handle, true);</span><br><span>             mi-&g=
t;vaddr_handle =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            mi-&gt;vaddr_pool =3D NULL;</span><br><span>         }</span=
><br><span> </span><br><span>         mi-&gt;context=2Ec2=2Epush_ifconfig_d=
efined =3D true;</span><br><span>@@ -1455,6 +1548,52 @@</span><br><span>   =
              &quot;MULTI_sva: WARNING: if --ifconfig-push is used for IPv4=
, automatic IPv6 assignment from --ifconfig-ipv6-pool does not work=2E  Use=
 --ifconfig-ipv6-push for IPv6 then=2E&quot;);</span><br><span>         }</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else if (mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* dynamic address from this client&#3=
9;s --subnet-pool group */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct ifconfig_pool *group =3D</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            multi_get_group_pool(m, &amp;m-&gt;t=
op=2Eoptions, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* the address may have been acquired before th=
e tag was known (from</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+         * the global pool) or for a tag that a later handler overrode: d=
rop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * it so=
 we serve this client from its current group */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (mi-&gt;vaddr_handle &gt;=3D 0 &amp;=
&amp; mi-&gt;vaddr_pool !=3D group)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_po=
ol : m-&gt;ifconfig_pool,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                  mi-&gt;vaddr_handle, true);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_ha=
ndle =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     mi-&gt;vaddr_pool =3D NULL;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            /* both addresses of the dropped slot go back to i=
ts pool */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Epus=
h_ifconfig_ipv6_defined =3D false;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi=
-&gt;vaddr_handle &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        in_addr_t local =3D 0, remote =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            const char *cn =3D NULL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if (!mi-&gt;context=2Eoptions=2Eduplicat=
e_cn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                cn =
=3D tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            mi-&gt;vaddr_pool =3D group;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_handle =3D ifc=
onfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, NULL, cn);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (mi-&g=
t;vaddr_handle &gt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D remote;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                mi-&gt;co=
ntext=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Eoptions=2Esu=
bnet_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(D_MULTI_ERRORS, &quot=
;MULTI: no free --subnet-pool addresses are available for %s&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    multi_i=
nstance_string(mi, false, &amp;gc));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span>     else if (m-&gt;ifconfig_pool &amp;&amp; mi-&gt;=
vaddr_handle &lt; 0) /* otherwise, choose a pool address */</span><br><span=
>     {</span><br><span>         in_addr_t local =3D 0, remote =3D 0;</span=
><br><span>@@ -2360,10 +2499,9 @@</span><br><span>         const char *ifco=
nfig_constraint_netmask =3D</span><br><span>             print_in_addr_t(mi=
-&gt;context=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, &amp;gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 /* JYFIXME -- this should cause the connection to fail */</span><br><span>=
         msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            &quot;MULTI ERROR: primary virtual IP for %s (%s) &quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;vio=
lates tunnel network/netmask constraint (%s/%s)&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;WARNING: primary virtu=
al IP for %s (%s) &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;violates tunnel network/netmask constraint (%s/%s) a=
nd may not work&quot;,</span><br><span>             multi_instance_string(m=
i, false, &amp;gc),</span><br><span>             print_in_addr_t(mi-&gt;con=
text=2Ec2=2Epush_ifconfig_local, 0, &amp;gc),</span><br><span>             =
ifconfig_constraint_network, ifconfig_constraint_netmask);</span><br><span>=
@@ -2471,6 +2609,7 @@</span><br><span> </span><br><span>     /* reset pool =
handle to null */</span><br><span>     mi-&gt;vaddr_handle =3D -1;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;vaddr_pool =3D NU=
LL;</span><br><span> </span><br><span>     /* do --client-connect setenvs *=
/</span><br><span>     multi_select_virtual_addr(m, mi);</span><br><span>@@=
 -2792,6 +2931,15 @@</span><br><span>         cc_succeeded =3D false;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_tag</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; !subnet_p=
ool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=2Eoptions=2Es=
ubnet_pool_tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MUL=
TI_ERRORS, &quot;MULTI: client has been rejected due to unknown --subnet-po=
ol-tag &#39;%s&#39;&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        auth_set_client_reason(=
mi-&gt;context=2Ec2=2Etls_multi, &quot;unknown subnet-pool-tag&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        cc_succeeded =3D=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (=
cc_succeeded)</span><br><span>     {</span><br><span>         multi_client_=
connect_late_setup(m, mi, *option_types_found);</span><br><span>diff --git =
a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><span>index 5db71=
47=2E=2E14f71dd 100644</span><br><span>--- a/src/openvpn/multi=2Eh</span><b=
r><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -121,6 +121,8 @@</sp=
an><br><span>     struct mroute_addr real; /**&lt; External network address=
 of the</span><br><span>                               *   remote peer=2E *=
/</span><br><span>     ifconfig_pool_handle vaddr_handle;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* pool vaddr_handle belongs to (=
NULL =3D the global one) */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct ifconfig_pool *vaddr_pool;</span><br><span>     char msg=
_prefix[MULTI_PREFIX_MAX_LENGTH];</span><br><span> </span><br><span>     /*=
 queued outgoing data in Server/TCP mode */</span><br><span>@@ -190,6 +192,=
8 @@</span><br><span>                                         *   instances=
=2E */</span><br><span>     struct multi_io *multi_io;         /**&lt; I/O =
state and events tracker */</span><br><span>     struct ifconfig_pool *ifco=
nfig_pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* pe=
r-group --subnet-pool dynamic pools */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct subnet_pool *subnet_pools;</span><br><span>  =
   struct frequency_limit *new_connection_limiter;</span><br><span>     str=
uct initial_packet_rate_limit *initial_rate_limiter;</span><br><span>     s=
truct mroute_helper *route_helper;</span><br><span>diff --git a/src/openvpn=
/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8e0c602=2E=2Ee=
b0bcfd 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span=
>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -453,6 +453,12 @@</span><=
br><span>     &quot;                  If seconds=3D0, file will be treated =
as read-only=2E\n&quot;</span><br><span>     &quot;--ifconfig-ipv6-pool bas=
e-IP/bits : set aside an IPv6 network block\n&quot;</span><br><span>     &q=
uot;                  to be dynamically allocated to connecting clients=2E\=
n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--=
subnet-pool tag network netmask [gateway [start end]] : Define a named\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;      =
            pool of addresses outside the --server network, selected\n&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;        =
          per client with --subnet-pool-tag=2E start/end restrict the\n&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;       =
           dynamically assigned range=2E\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-tag tag : Assign this =
client to the --subnet-pool named tag=2E\n&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    &quot;                  Only valid in a cl=
ient-specific config file=2E\n&quot;</span><br><span>     &quot;--ifconfig-=
push local remote-netmask : Push an ifconfig option to remote,\n&quot;</spa=
n><br><span>     &quot;                  overrides --ifconfig-pool dynamic =
allocation=2E\n&quot;</span><br><span>     &quot;                  Only val=
id in a client-specific config file=2E\n&quot;</span><br><span>@@ -1899,6 +=
1905,20 @@</span><br><span>         {</span><br><span>             msg(M_US=
AGE, &quot;--ifconfig-ipv6-pool needs --ifconfig-ipv6&quot;);</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (options-&gt;subnet_pools)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (!options-&gt;server_defined)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                msg(M_USAGE, &quot;--subnet-pool requi=
res --server&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (dev_type_enum(options-&gt;dev, options-&gt;dev_type) !=3D DEV_TY=
PE_TUN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   || options-&gt;topology !=3D TOP_SUBNET)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                msg(M_USAGE, &quot;--subnet-pool requires=
 --dev tun and --topology subnet&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            subnet_pools_check(options-&gt;subnet_pools, opt=
ions-&gt;server_network,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                               options-&gt;server_netmask, M_USAGE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span>         MUST_BE_UNDEF(allow_recursive_routing, &quot;allow-recursive-=
routing&quot;);</span><br><span>         if (options-&gt;auth_user_pass_fil=
e)</span><br><span>         {</span><br><span>@@ -1965,6 +1985,7 @@</span><=
br><span>         MUST_BE_UNDEF(ifconfig_pool_defined, &quot;ifconfig-pool&=
quot;);</span><br><span>         MUST_BE_UNDEF(ifconfig_pool_persist_filena=
me, &quot;ifconfig-pool-persist&quot;);</span><br><span>         MUST_BE_UN=
DEF(ifconfig_ipv6_pool_defined, &quot;ifconfig-ipv6-pool&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        MUST_BE_UNDEF(subnet_p=
ools, &quot;subnet-pool&quot;);</span><br><span>         MUST_BE_UNDEF(real=
_hash_size, &quot;hash-size&quot;);</span><br><span>         MUST_BE_UNDEF(=
virtual_hash_size, &quot;hash-size&quot;);</span><br><span>         MUST_BE=
_UNDEF(learn_address_script, &quot;learn-address&quot;);</span><br><span>@@=
 -3097,6 +3118,28 @@</span><br><span>     }</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * The server&#39;s tun device =
is only configured with the --server network, so</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * route each --subnet-pool network into it as=
 well: without this the server</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * could not reach its subnet-pool clients when the data channel=
 runs in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * userspac=
e=2E  Under DCO on Linux and FreeBSD the routes are installed on-link,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * see subnet_pool_route=
s_onlink()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+options_postprocess_subnet_poo=
l_routes(struct options *o)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (c=
onst struct subnet_pool_def *d =3D o-&gt;subnet_pools; d; d =3D d-&gt;next)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        struct route_option *ro;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        rol_check_alloc(o);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ro =3D add_route_to_opt=
ion_list(o-&gt;routes, print_in_addr_t(d-&gt;network, 0, &amp;o-&gt;gc),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                print_in_addr_t(d-&gt;netmask, 0, &amp;o-&gt;gc), NULL, NUL=
L,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                     o-&gt;route_default_table_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        ro-&gt;on_link =3D subnet_pool_ro=
utes_onlink(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span>=
<br><span> options_postprocess_mutate(struct options *o, struct env_set *es=
)</span><br><span> {</span><br><span>@@ -3232,6 +3275,12 @@</span><br><span=
>         /* check if any option should force disabling DCO */</span><br><s=
pan>         o-&gt;disable_dco =3D !dco_check_option(D_DCO, o) || !dco_chec=
k_startup_option(D_DCO, o);</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (o-&gt;mode =3D=3D MODE_SERVER)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* how the pools are routed depends on the DCO dec=
ision above */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   options_postprocess_subnet_pool_routes(o);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span> #ifdef USE_COMP</span><br>=
<span>     if (dco_enabled(o))</span><br><span>     {</span><br><span>@@ -6=
219,6 +6268,57 @@</span><br><span>             goto err;</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (streq(p[0], &quot;subnet-pool&quot;) &amp;&amp; p[=
1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; (!p[5] || p[6]) &amp;&amp; !p=
[7])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        struct subnet_pool_de=
f *sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        in_ad=
dr_t network, netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_P=
ERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        network =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RESOLVE, p[2=
], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       netmask =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, NULL, NULL);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!network || !n=
etmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglev=
el, &quot;cannot parse --subnet-pool addresses&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR_GC(sp, struct subnet_poo=
l_def, &amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        sp-&gt;tag =3D p[1];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        sp-&gt;network =3D network &amp; netmask;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;netmask =3D =
netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-=
&gt;gateway =3D (network &amp; netmask) + 1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (p[4])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            bool ok =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            sp-&gt;gateway =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RE=
SOLVE, p[4], 0, &amp;ok, NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!ok)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                msg(msglevel, &quot;cannot parse --subnet-pool gatew=
ay&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* optional=
 range of the dynamic pool, validated in</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * subnet_pools_check(); unset, it spans the w=
hole subnet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bool =
ok_start =3D false, ok_end =3D false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           sp-&gt;pool_start =3D getaddr(GETADDR_HOST_ORDER, p[5], 0, &amp;=
ok_start, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         sp-&gt;pool_end =3D getaddr(GETADDR_HOST_ORDER, p[6], 0, &amp;ok_e=
nd, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (!ok_start || !ok_end)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                msg(msglevel, &quot;cannot parse --subnet-pool range&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;next =3D o=
ptions-&gt;subnet_pools;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        options-&gt;subnet_pools =3D sp;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (streq(p[0], &quot;subnet-pool-tag&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        V=
ERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        options-&gt;subnet_pool_tag =3D p[1];</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     else if =
(streq(p[0], &quot;ifconfig-push-constraint&quot;) &amp;&amp; p[1] &amp;&am=
p; p[2] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>         i=
n_addr_t network, netmask;</span><br><span>diff --git a/src/openvpn/options=
=2Eh b/src/openvpn/options=2Eh</span><br><span>index c58530a=2E=2E568bae6 1=
00644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>+++ b/s=
rc/openvpn/options=2Eh</span><br><span>@@ -252,6 +252,21 @@</span><br><span=
>     struct verify_hash_list *next;</span><br><span> };</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A named --subnet-=
pool: a subnet clients can be assigned from, referenced</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * from a CCD file by its tag via --sub=
net-pool-tag=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
truct subnet_pool_def</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subne=
t_pool_def *next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   in_addr_t network;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    in_addr_t netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    in_addr_t gateway;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* optional range of the dynamic pool (0/0: every host address =
of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * subnet=
); addresses outside it are left for static --ifconfig-push */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t pool_start;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t pool_end;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Command line optio=
ns */</span><br><span> struct options</span><br><span> {</span><br><span>@@=
 -518,6 +533,12 @@</span><br><span>     bool push_ifconfig_constraint_defin=
ed;</span><br><span>     in_addr_t push_ifconfig_constraint_network;</span>=
<br><span>     in_addr_t push_ifconfig_constraint_netmask;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def *subnet_p=
ools; /* named pools (server config) */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const char *subnet_pool_tag;          /* which pool=
 this client uses (CCD) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    bool subnet_pool_defined;             /* resolved from the tag a=
t connect */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_=
addr_t subnet_pool_network;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    in_addr_t subnet_pool_netmask;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    in_addr_t subnet_pool_gateway;</span><br><span> =
    bool push_ifconfig_ipv4_blocked;           /* IPv4 */</span><br><span> =
    bool push_ifconfig_ipv6_defined;           /* IPv6 */</span><br><span> =
    struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</span><br><span>@=
@ -979,4 +1000,23 @@</span><br><span> #endif /* ENABLE_DCO */</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Whether t=
he routes of the --subnet-pool networks are installed on-link on</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * the DCO device rather than =
via a gateway=2E  With DCO on Linux and FreeBSD the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * kernel selects the peer by a route&#39=
;s next hop, so a route via a gateway</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * would deliver every packet for an unassigned pool addr=
ess to the client</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 owning that gateway address; on-link, such a packet matches no peer, while=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * each pool client=
 gets its own on-link host route when it connects (see</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * multi_learn_in_addr_t())=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+subnet_pool_routes_onlink(const struct options=
 *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) || defi=
ned(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return dco_enabled(o);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef OPTIO=
NS_H */</span><br><span>diff --git a/src/openvpn/options_util=2Ec b/src/ope=
nvpn/options_util=2Ec</span><br><span>index d25d85c=2E=2E862bf7c 100644</sp=
an><br><span>--- a/src/openvpn/options_util=2Ec</span><br><span>+++ b/src/o=
penvpn/options_util=2Ec</span><br><span>@@ -30,6 +30,105 @@</span><br><span=
> #include &quot;options_util=2Eh&quot;</span><br><span> </span><br><span> =
#include &quot;push=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;pool=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+const struct subnet_pool_def *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+subnet_pool_by_tag(const struct subnet_pool_def *pools, const c=
har *tag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet=
_pool_def *d =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (!strcmp(d-&gt;tag, tag))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return d;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* true if the two IPv4 subnets share at lea=
st one address */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+subnets_ov=
erlap(in_addr_t a, in_addr_t mask_a, in_addr_t b, in_addr_t mask_b)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const in_addr_t mask =3D mask_a &amp; mas=
k_b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return (a &amp; mask) =3D=3D (=
b &amp; mask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+subnet_pools_check(const struct subnet_pool_def *pools, =
in_addr_t server_network,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                   in_addr_t server_netmask, msglvl_t msglevel)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet_pool_def *d =
=3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      const in_addr_t host =3D ~d-&gt;netmask;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        int netbits =3D 32;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* the netmask must be contiguous */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (host &amp; (host + 1))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &qu=
ot;--subnet-pool %s: invalid netmask&quot;, d-&gt;tag);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (in_addr_t h =3D host; h; h &=
gt;&gt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            netb=
its--;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* same bounds as --server: the p=
ool must hold at least 2 addresses</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+         * besides network, gateway and broadcast, and fit I=
FCONFIG_POOL_MAX */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (netbits &lt; IFCONFIG_POOL_MIN_NETBITS || netbits &gt; 29)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--=
subnet-pool %s: netmask must be between /%d and /29 (not /%d)&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                d-&gt;tag,=
 IFCONFIG_POOL_MIN_NETBITS, netbits);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if ((d-&gt;gateway &amp; d-&gt;netmask) !=3D d-&gt;network || d-&gt;gate=
way =3D=3D d-&gt;network</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            || d-&gt;gateway =3D=3D (d-&gt;network | host))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--subnet=
-pool %s: gateway must be a host address inside the subnet&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                d-&gt;tag);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* an explicit dynamic range must be=
 made of host addresses of the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * subnet and hold at least the 2 entries an ifconfig po=
ol needs */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if ((d-&gt;pool_start || d-&gt;pool_end)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &amp;&amp; ((d-&gt;pool_start &amp; d-&gt;=
netmask) !=3D d-&gt;network</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                || (d-&gt;pool_end &amp; d-&gt;netmask) !=3D d-&gt;=
network || d-&gt;pool_start =3D=3D d-&gt;network</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                || d-&gt;pool_end =3D=3D (d-&g=
t;network | host) || d-&gt;pool_start &gt;=3D d-&gt;pool_end))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                &quot;--subnet-pool=
 %s: range start and end must be host addresses inside the &quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;subnet,=
 with start lower than end&quot;,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                d-&gt;tag);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (server_netmask</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            &amp;&amp; subnets_overlap(d-&gt;network, d-&gt;netmask, =
server_network, server_netmask))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(msglevel, &quot;--subnet-pool %s: subnet overlaps the --=
server network&quot;, d-&gt;tag);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
or (const struct subnet_pool_def *e =3D d-&gt;next; e; e =3D e-&gt;next)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            if (!strcmp(d-&gt;ta=
g, e-&gt;tag))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     msg(msglevel, &quot;--subnet-pool %s: tag defined more than once&quot;=
, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (subnets_overlap(d-&gt;network, d-&gt;netmask, e-&gt;network, =
e-&gt;netmask))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      msg(msglevel, &quot;--subnet-pool %s and %s: subnets overlap&quot;, d=
-&gt;tag, e-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> con=
st char *</span><br><span> parse_auth_failed_temp(struct options *o, const =
char *reason)</span><br><span>diff --git a/src/openvpn/options_util=2Eh b/s=
rc/openvpn/options_util=2Eh</span><br><span>index 5226a6f=2E=2Ef1e63e15 100=
644</span><br><span>--- a/src/openvpn/options_util=2Eh</span><br><span>+++ =
b/src/openvpn/options_util=2Eh</span><br><span>@@ -28,6 +28,33 @@</span><br=
><span> </span><br><span> const char *parse_auth_failed_temp(struct options=
 *o, const char *reason);</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Look up a named --subnet-pool in a list of pool definitions=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param pools  head of the --subnet-=
pool list (may be NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param tag    the --subnet-pool-tag to match</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return       the matching pool defini=
tion, or NULL if none matches</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+const =
struct subnet_pool_def *subnet_pool_by_tag(const struct subnet_pool_def *po=
ols,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                                  const char *tag);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Validate the --subnet-pool definitions: contiguous netmask between</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * /IFCONFIG_POOL_MIN_NETB=
ITS and /29, gateway a host address inside its</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * subnet, an explicit dynamic range made of at =
least 2 host addresses of the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * subnet,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * unique tags, and no subnet overlapping another pool or the --server</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * network=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param pools           head of the --subnet=
-pool list (may be NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param server_network  the --server network (host order)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_netmask  the =
--server netmask, or 0 if there is none</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param msglevel        level of the message logged o=
n the first error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return                true if every definition is valid</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool subnet_pools_check(const struct subnet_pool_def =
*pools, in_addr_t server_network,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        in_addr_t server_netmask, msglvl_t ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> </span><br><span> /** Checks if the string is a valid integer by che=
cking if it can be</span><br><span>  *  converted to an integer */</span><b=
r><span>diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=2Ec</span><br>=
<span>index fff0e3f=2E=2E5c5b3fe 100644</span><br><span>--- a/src/openvpn/p=
ool=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec</span><br><span>@@ -351,=
7 +351,7 @@</span><br><span> {</span><br><span>     bool ret =3D false;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(pool &amp;&amp; hand &gt;=3D 0 &amp;&amp; hand &lt; pool-&gt;size)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pool &amp;&amp; han=
d &gt;=3D 0 &amp;&amp; hand &lt; pool-&gt;size &amp;&amp; !pool-&gt;list[ha=
nd]=2Ereserved)</span><br><span>     {</span><br><span>         ifconfig_po=
ol_entry_free(&amp;pool-&gt;list[hand], hard);</span><br><span>         ret=
 =3D true;</span><br><span>@@ -430,6 +430,22 @@</span><br><span>     return=
 ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ifconfig_pool_reserve_ip(struct ifconfig_pool *pool, const in_addr_=
t addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const ifconfig_pool_handle=
 h =3D ifconfig_pool_ip_base_to_handle(pool, addr);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (h &lt; 0)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_entry_free(&am=
p;pool-&gt;list[h], true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    pool-&gt;list[h]=2Ein_use =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ereserved =3D true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static in_addr_t</span><br><s=
pan> ifconfig_pool_handle_to_ip_base(const struct ifconfig_pool *pool, ifco=
nfig_pool_handle hand)</span><br><span> {</span><br><span>@@ -477,6 +493,13=
 @@</span><br><span>                   const bool fixed)</span><br><span> {=
</span><br><span>     struct ifconfig_pool_entry *e =3D &amp;pool-&gt;list[=
h];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (e-&gt;reserved)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;pool: ignoring pers=
isted entry for CN=3D%s: its address is reserved&quot;, cn);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     ifconfig_pool_entry_free(e, tr=
ue);</span><br><span>     e-&gt;in_use =3D false;</span><br><span>     e-&g=
t;common_name =3D string_alloc(cn, NULL);</span><br><span>diff --git a/src/=
openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>index e2d3f82=2E=2E=
497dcda 100644</span><br><span>--- a/src/openvpn/pool=2Eh</span><br><span>+=
++ b/src/openvpn/pool=2Eh</span><br><span>@@ -43,6 +43,7 @@</span><br><span=
>     char *common_name;</span><br><span>     time_t last_release;</span><b=
r><span>     bool fixed;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool reserved; /* never handed out, e=2Eg=2E a --subnet-pool gatew=
ay */</span><br><span> };</span><br><span> </span><br><span> struct ifconfi=
g_pool</span><br><span>@@ -86,6 +87,17 @@</span><br><span> </span><br><span=
> bool ifconfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_hand=
le hand, const bool hard);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Permanently reserve the pool slot holding \c addr, so that it i=
s never</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * handed ou=
t to a client nor taken over by a persisted entry (e=2Eg=2E the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * gateway of a --subnet-pool)=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param pool  the pool</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param addr  IPv4 address=
 (host order) to reserve</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return      true if \c addr lies in the pool and was reserved</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+bool ifconfig_pool_reserve_ip(struct ifc=
onfig_pool *pool, in_addr_t addr);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> struct ifconfig_pool_persist *ifconfig_poo=
l_persist_init(const char *filename, int refresh_freq);</span><br><span> </=
span><br><span> void ifconfig_pool_persist_close(struct ifconfig_pool_persi=
st *persist);</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/open=
vpn/route=2Ec</span><br><span>index 0bce966=2E=2Efecef7e 100644</span><br><=
span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2E=
c</span><br><span>@@ -408,6 +408,11 @@</span><br><span>         r-&gt;flags=
 |=3D RT_METRIC_DEFINED;</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (ro-&gt;on_link)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        r-&gt;flags |=3D RT_ON_LINK;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     r-&gt;flags |=
=3D RT_DEFINED;</span><br><span> </span><br><span>     /* routing table id =
*/</span><br><span>@@ -478,12 +483,12 @@</span><br><span>     return false;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct route_option *</span><br><span> add_route_to_option_list(struct rou=
te_option_list *l, const char *network, const char *netmask,</span><br><spa=
n>                          const char *gateway, const char *metric, int ta=
ble_id)</span><br><span> {</span><br><span>     struct route_option *ro;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ_GC(ro, str=
uct route_option, l-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ALLOC_OBJ_CLEAR_GC(ro, struct route_option, l-&gt;gc);</span><=
br><span>     ro-&gt;network =3D network;</span><br><span>     ro-&gt;netma=
sk =3D netmask;</span><br><span>     ro-&gt;gateway =3D gateway;</span><br>=
<span>@@ -491,6 +496,7 @@</span><br><span>     ro-&gt;table_id =3D table_id=
;</span><br><span>     ro-&gt;next =3D l-&gt;routes;</span><br><span>     l=
-&gt;routes =3D ro;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return ro;</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span>@@ -1322,7 +1328,11 @@</span><br><span>     {</span><br><spa=
n>         setenv_route_addr(es, &quot;network&quot;, r-&gt;network, i);</s=
pan><br><span>         setenv_route_addr(es, &quot;netmask&quot;, r-&gt;net=
mask, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sete=
nv_route_addr(es, &quot;gateway&quot;, r-&gt;gateway, i);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        /* an on-link route has no ga=
teway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!(r-&gt;flags &amp; RT_ON_LINK))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            setenv_route_addr(es, &quot;gateway&quot;, r-&gt;gateway, i=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span> </span><br><span>         if (r-&gt;flags &amp; RT_METRIC_DEFINED=
)</span><br><span>         {</span><br><span>@@ -1478,6 +1488,7 @@</span><b=
r><span> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>     c=
onst char *iface =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const in_addr_t *gateway =3D &amp;r-&gt;gateway;</span><br><span=
>     int metric =3D -1;</span><br><span> </span><br><span>     if (is_on_l=
ink(is_local_route, flags, rgi))</span><br><span>@@ -1485,6 +1496,12 @@</sp=
an><br><span>         iface =3D rgi-&gt;iface;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
((r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        gateway =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        iface =3D tt-&gt;actual_name;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span>     if (r-&gt;flags &amp; RT_METRI=
C_DEFINED)</span><br><span>     {</span><br><span>         metric =3D r-&gt=
;metric;</span><br><span>@@ -1492,8 +1509,8 @@</span><br><span> </span><br>=
<span> </span><br><span>     status =3D RTA_SUCCESS;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int ret =3D net_route_v4_add(ctx, &amp;=
r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &amp;r-&gt;gateway,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
     iface, r-&gt;table_id, metric);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int ret =3D net_route_v4_add(ctx, &amp;r-&gt;network, =
netmask_to_netbits2(r-&gt;netmask), gateway, iface,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                               r-&gt;tabl=
e_id, metric);</span><br><span>     if (ret =3D=3D -EEXIST)</span><br><span=
>     {</span><br><span>         msg(D_ROUTE, &quot;NOTE: Linux route add c=
ommand failed because route exists&quot;);</span><br><span>@@ -1616,7 +1633=
,15 @@</span><br><span>     }</span><br><span> #endif</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf_cat(&amp;=
argv, &quot;-net %s %s %s&quot;, network, gateway, netmask);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; RT_ON_L=
INK) &amp;&amp; tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_p=
rintf_cat(&amp;argv, &quot;-net %s/%d -iface %s&quot;, network, netmask_to_=
netbits2(r-&gt;netmask),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        tt-&gt;actual_name);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
rgv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netm=
ask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span> </span><br><span>     /* FIXME -- add on-link support for FreeBSD =
*/</span><br><span> </span><br><span>@@ -2035,7 +2060,16 @@</span><br><span=
>         metric =3D r-&gt;metric;</span><br><span>     }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (net_route_v4_=
del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &amp;r-&gt=
;gateway, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const in_addr_t *gateway =3D &amp;r-&gt;gateway;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char *iface =3D NULL;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        gateway =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        iface =3D tt-&gt;ac=
tual_name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (net_route_v4_del(ctx, &amp;r-&gt;=
network, netmask_to_netbits2(r-&gt;netmask), gateway, iface,</span><br><spa=
n>                          r-&gt;table_id, metric)</span><br><span>       =
  &lt; 0)</span><br><span>     {</span><br><span>@@ -2091,7 +2125,15 @@</sp=
an><br><span> </span><br><span> #elif defined(TARGET_FREEBSD)</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&=
amp;argv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway=
, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
(r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        argv_printf(&amp;argv, &quot;%s delete -net %s/%d -ifac=
e %s&quot;, ROUTE_PATH, network,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    netmask_to_netbits2(r-&gt;netmask), tt-&gt=
;actual_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s dele=
te -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><=
br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     openvpn_ex=
ecve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route delete command fail=
ed&quot;);</span><br><span>diff --git a/src/openvpn/route=2Eh b/src/openvpn=
/route=2Eh</span><br><span>index 0d33d36=2E=2E7c5528f 100644</span><br><spa=
n>--- a/src/openvpn/route=2Eh</span><br><span>+++ b/src/openvpn/route=2Eh</=
span><br><span>@@ -80,6 +80,10 @@</span><br><span>     const char *gateway;=
</span><br><span>     int table_id;</span><br><span>     const char *metric=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* on Linux an=
d FreeBSD, install the route on-link on the tun device</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * instead of via the gateway (neede=
d under DCO, where the kernel selects</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * the peer by the route&#39;s next hop) */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bool on_link;</span><br><=
span> };</span><br><span> </span><br><span> /* redirect-gateway flags */</s=
pan><br><span>@@ -120,6 +124,7 @@</span><br><span> #define RT_DEFINED      =
  (1u &lt;&lt; 0)</span><br><span> #define RT_ADDED          (1u &lt;&lt; 1=
)</span><br><span> #define RT_METRIC_DEFINED (1u &lt;&lt; 2)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define RT_ON_LINK        (1u &lt;=
&lt; 3) /* see struct route_option=2Eon_link */</span><br><span>     struct=
 route_ipv4 *next;</span><br><span>     unsigned int flags;</span><br><span=
>     const struct route_option *option;</span><br><span>@@ -311,8 +316,9 @=
@</span><br><span>                const struct route_gateway_info *rgi, con=
st struct env_set *es,</span><br><span>                openvpn_net_ctx_t *c=
tx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-void add_route_to_option_list(struct route_option_list *l, const char *net=
work, const char *netmask,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                              const char *gateway, const char *metric,=
 int table_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stru=
ct route_option *add_route_to_option_list(struct route_option_list *l, cons=
t char *network,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                           const char *netmask, const char =
*gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                    const char *metric, int table_id);</spa=
n><br><span> </span><br><span> void add_route_ipv6_to_option_list(struct ro=
ute_ipv6_option_list *l, const char *prefix,</span><br><span>              =
                      const char *gateway, const char *metric, int table_id=
);</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/te=
sts/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 43a6743=2E=2E5f2=
a75b 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</s=
pan><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>=
@@ -392,6 +392,7 @@</span><br><span> </span><br><span> misc_testdriver_SOUR=
CES =3D test_misc=2Ec \</span><br><span> 	test_schedule=2Ec test_schedule=
=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_subnet_=
pool=2Ec test_subnet_pool=2Eh \</span><br><span> 	mock_msg=2Ec test_common=
=2Eh  \</span><br><span> 	mock_get_random=2Ec \</span><br><span> 	$(top_src=
dir)/src/compat/compat-strlcpy=2Ec \</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/test_misc=2Ec b/tests/unit_tests/openvpn/test_misc=2Ec</spa=
n><br><span>index aea40f0=2E=2E06fd9aa 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_misc=2Ec</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_misc=2Ec</span><br><span>@@ -45,6 +45,7 @@</span><br><span> #inclu=
de &quot;win32-util=2Eh&quot;</span><br><span> #endif</span><br><span> #inc=
lude &quot;test_schedule=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;test_subnet_pool=2Eh&quot;</span><br><span> <=
/span><br><span> static void</span><br><span> test_compat_lzo_string(void *=
*state)</span><br><span>@@ -561,7 +562,12 @@</span><br><span>     cmocka_un=
it_test(test_list),</span><br><span>     cmocka_unit_test(test_atoi_variant=
s),</span><br><span>     cmocka_unit_test(schedule_test),</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    cmocka_unit_test(test_sid_hash_list=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_te=
st(test_sid_hash_list),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    cmocka_unit_test(test_subnet_pool_by_tag),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pools_check=
_netmask),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmock=
a_unit_test(test_subnet_pools_check_gateway),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pools_check_rang=
e),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_=
test(test_subnet_pools_check_overlap),</span><br><span> };</span><br><span>=
 </span><br><span> int</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_subnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E10c0bc5=
</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_subnet_pool=2Ec</span><br><span>@@ -0,0 +1,160 @@</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP ne=
tworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  over a single UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is free software; you can redistribute it and/or modify</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope t=
hat it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of=
 the GNU General Public License along</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=
=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;options=2Eh&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_=
common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;test_subnet_pool=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* --subnet-pool-tag resolves a client to its --subnet-pool;=
 an unknown tag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
eturns NULL, which is what makes the server reject that client=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_subnet_pool_by_tag(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def c =3D { =2Enex=
t =3D NULL, =2Etag =3D &quot;grpC&quot;, =2Enetwork =3D 0x0a020300, =2Enetm=
ask =3D 0xffffff00, =2Egateway =3D 0x0a020301 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct subnet_pool_def b =3D { =2Enext =3D=
 &amp;c, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a020200, =2Enetmask=
 =3D 0xffffff00, =2Egateway =3D 0x0a020201 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct subnet_pool_def a =3D { =2Enext =3D &a=
mp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a020100, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a020101 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* every configured tag resolves to its own pool, wherever it sit=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_=
equal(subnet_pool_by_tag(&amp;a, &quot;grpA&quot;), &amp;a);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool_b=
y_tag(&amp;a, &quot;grpB&quot;), &amp;b);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool_by_tag(&amp;a, &quot=
;grpC&quot;), &amp;c);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* and it ca=
rries that pool&#39;s subnet/gateway */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct subnet_pool_def *r =3D subnet_pool_by_=
tag(&amp;a, &quot;grpB&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(r-&gt;network, 0x0a020200);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r-&gt;netmask,=
 0xffffff00);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(r-&gt;gateway, 0x0a020201);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* unknown tag and empty list both miss */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_null(subnet_pool_by_tag(&amp;a, &=
quot;nope&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_null(subnet_pool_by_tag(NULL, &quot;grpA&quot;));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* a single pool &lt;net&gt;/&lt;mask&gt; with gateway &lt;gw&gt;, check=
ed against the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 10=
=2E8=2E0=2E0/24 --server network */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+check_one(in_addr_t net, in_addr_t mask, in_addr_t gw)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool_def d =3D { =2Enext =3D NUL=
L, =2Etag =3D &quot;grp&quot;, =2Enetwork =3D net, =2Enetmask =3D mask, =2E=
gateway =3D gw };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return subnet_poo=
ls_check(&amp;d, 0x0a080000, 0xffffff00, M_WARN);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* --su=
bnet-pool geometry: anything ifconfig_pool_init() cannot serve must be</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * refused when the conf=
ig is checked, not when the first client connects */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_subnet_pools_check_netmask(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* the bounds of --server: /16 =2E=2E /29 */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(che=
ck_one(0x0a090000, 0xffff0000, 0x0a090001));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xffffff00, =
0x0a090001));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(check_one(0x0a090000, 0xfffffff8, 0x0a090001));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* /30, /31, /32: too few address=
es for a pool */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(check_one(0x0a090000, 0xfffffffc, 0x0a090001));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a09=
0000, 0xfffffffe, 0x0a090001));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(check_one(0x0a090000, 0xffffffff, 0x0a090000))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /15: larger=
 than IFCONFIG_POOL_MAX */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(check_one(0x0a080000, 0xfffe0000, 0x0a080001));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* non-contiguous n=
etmask */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(check_one(0x0a000900, 0xff00ff00, 0x0a000901));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools=
_check_gateway(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* an=
y host address of the subnet is fine, not only the first one */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a0=
90000, 0xffffff00, 0x0a0900fe));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(check_one(0x0a090000, 0xffffff00, 0x0a090080))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* network add=
ress, broadcast address, outside the subnet */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000, 0xffffff0=
0, 0x0a090000));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0900ff));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a09=
0000, 0xffffff00, 0x0a0a0001));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* a 10=2E9=2E0=2E0/24 po=
ol with dynamic range &lt;start&gt;-&lt;end&gt; */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+check_range(in_addr_t start, in_addr_t end)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct subnet_pool_def d =3D { =2Enext =3D=
 NULL, =2Etag =3D &quot;grp&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a090001, =2Epool_start =3D start, =2Epool=
_end =3D end };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return subnet_pools=
_check(&amp;d, 0x0a080000, 0xffffff00, M_WARN);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the op=
tional dynamic range: host addresses of the subnet, at least 2 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+test_subnet_pools_check_range(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* unset: the whole subnet */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_ra=
nge(0, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a=
 sub-range, the smallest one, the whole host range */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_range(0x0a090064, 0=
x0a0900c8));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(check_range(0x0a090064, 0x0a090065));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(check_range(0x0a090001, 0x0a0900=
fe));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a singl=
e address, or start past end */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(check_range(0x0a090064, 0x0a090064));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_range=
(0x0a0900c8, 0x0a090064));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* the network or broadcast address */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(check_range(0x0a090000, 0x0a=
090064));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(check_range(0x0a090064, 0x0a0900ff));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* outside the subnet */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_range(0x0a090064, =
0x0a0a0001));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(check_range(0x0a080064, 0x0a090064));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools_check=
_overlap(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subn=
et_pool_def b =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpB&quot;, =2Enetwo=
rk =3D 0x0a0a0000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_po=
ol_def a =3D { =2Enext =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =
=3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* disjoint pools, disjoint from --se=
rver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(subnet_pools_check(&amp;a, 0x0a080000, 0xffffff00, M_WARN));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* a pool inside the --server network =2E=2E=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fa=
lse(subnet_pools_check(&amp;a, 0x0a090000, 0xffffff00, M_WARN));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* =2E=2E=2E or covering i=
t */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(subnet_pools_check(&amp;a, 0x0a0a0080, 0xffffff80, M_WARN));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* no --server network: only=
 the pools are checked against each other */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(subnet_pools_check(&amp;a, 0, 0, M=
_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* a /16 grpB containing g=
rpA */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct su=
bnet_pool_def b16 =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpB&quot;, =2En=
etwork =3D 0x0a090000, =2Enetmask =3D 0xffff0000, =2Egateway =3D 0x0a090101=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subne=
t_pool_def a16 =3D { =2Enext =3D &amp;b16, =2Etag =3D &quot;grpA&quot;, =2E=
network =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a09000=
1 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(subnet_pools_check(&amp;a16, 0, 0, M_WARN));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* the same tag defined twice */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool_def bdup =3D { =2Enext =3D =
NULL, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a0a0000, =2Enetmask =
=3D 0xffffff00, =2Egateway =3D 0x0a0a0001 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool_def adup =3D { =2Enext =3D =
&amp;bdup, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetma=
sk =3D 0xffffff00, =2Egateway =3D 0x0a090001 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(subnet_pools_check(&amp;adup, =
0, 0, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span>diff --git a/tests/unit_tests/openvpn/test_subnet_pool=2Eh b/=
tests/unit_tests/openvpn/test_subnet_pool=2Eh</span><br><span>new file mode=
 100644</span><br><span>index 0000000=2E=2E2a1f882</span><br><span>--- /dev=
/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Eh</=
span><br><span>@@ -0,0 +1,37 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  O=
penVPN -- An application to securely tunnel IP networks</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             session authentication and key exchange,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet en=
cryption, packet authentication, and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifndef SUBNET_POOL_TEST_H</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define SUBNET_POOL_TEST_=
H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* --subnet-pool tests, run as part o=
f misc_testdriver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_subnet_p=
ool_by_tag(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_sub=
net_pools_check_netmask(void **state);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void test_subnet_pools_check_gateway(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_subnet_pools_check_range(void **state);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void test_subnet_pools_check_overlap(void **state=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></pre><p>To view, v=
isit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail=
">change 1783</a>=2E To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings<=
/a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction">=
<link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
783?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1783 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Antonio Quartulli &lt;antonio@mandelbit=2Ecom&gt; </div>
<div style=3D"dis=
play:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &l=
t;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Re=
viewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Arne Schw=
abe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
=

</body></html>
--LlOhQPPCW/0=--


--===============3888969652504798093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3888969652504798093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3888969652504798093==--

