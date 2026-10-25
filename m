Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A9A606A31B
	for <openvpn-devel@archiver.kernel.org>; Sun, 25 Oct 2026 23:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y8mKfrsC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=U9fZdQh9;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DjjUS4DB;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=fTOj3d4L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=8nxQ9HIdqIH34a1LoKdfz17gLCKOwesvTdpfFkk+EeU=; b=Y8mKfrsCZohPpwDa4tDowNiEDm
	B4+1E+++n8LGV2MlSiVqq/UB/sK5A5Ni51nR2WtTynQS5IL1DgKD+D/FuEMub0ykqop08Ka0MSglR
	uSWjpsANKN1HDQ7zPOnmNkz1p+/OBNPp4hFTr/WDHYnODD6s9xLVr1yN/X3a8ZXh+sAY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xL7Lw-0000000038Q-3qFR;
	Sun, 25 Oct 2026 23:10:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xL7Lv-0000000038I-1KWM
 for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 23:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K1VKzSTK3GskjOEUVPRl8E+5jeKmKYSOvlTjoE/Krso=; b=U9fZdQh9rwHFIN6ZNYdzKZYTnT
 Ivl8GbPxnaMxv+ckIh7VpRkPbxzLIAlyT0gMqjzs1VETCc4NVqHDXutqyJAUqvYWbwzpWw+d/WzpA
 AS251TptzXw1dHSChFmVPdOW4mU3eeyury98tsVBxLu/DT+gOcC6zotIw4UFqT9lKimQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=K1VKzSTK3GskjOEUVPRl8E+5jeKmKYSOvlTjoE/Krso=; b=DjjUS4DB+z4Q3s2954XTkgRW7k
 enfeJdggIcYQzkWveCLpHJPIJabiCpnWkTSoB9fykyzMl4DE1BIh3jSNJizyaZVJxfmRmowMeRySO
 Fmqhb/HquXF+vlOb2AaDFg6Og9aMj7mlbekd91pKOTmxZghn335tGx5PiaDwPHCjkt3E=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL7Lo-000000004nK-2qRz for openvpn-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 23:10:11 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a549cd7fd2so5243515e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 16:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792969798; x=1793574598; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K1VKzSTK3GskjOEUVPRl8E+5jeKmKYSOvlTjoE/Krso=;
 b=fTOj3d4Lj2j7MaeW77a9Ia6xry+OMZ/lE/9UcfwBAEC0HSE3TJJTTJv0yM2dHXiaq6
 +BQ4XY8jBr540YUZg9XdgZmEiypUvUtcHKKzcz9//oSr/nkGRikBtWG11iyhtx44XbnV
 5ljRI5MKQuxKIl4A+f1FVpIpebn3C6lBmmCGOsiv7aYK7T5Jq3N6ymrItbaqeIajY5tY
 uhbRyrv+wzNpV4hNNaZ3ONVAZbuD4iWm1/qWccpwu2Sw0RCNg49qLHyJShppNG9CG635
 tCbWxYRGm1oUfRON1VBYmOpD00+AGCX6fThXq3JrOL59Y1SYGA4UdaD1BTmNxnSvpyTD
 tGOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792969798; x=1793574598;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K1VKzSTK3GskjOEUVPRl8E+5jeKmKYSOvlTjoE/Krso=;
 b=gmE+hUGEWa7MtdH61+XBmYohZ5wtPyDhgpqPNlJnJvWKyozuIOgD6Dir+nPrJyoYRw
 hxYXvcf9rIFK3GmwfRwPI/GeJLUtvhLRhvCFMIvpRZIZW7fQ8r7ql76UtuvL6GwTWT/j
 jIs85EGyYozf6Zz2BI07CNFbGnX2L4Yqj76H9WSrbRt5U0x1ZDP+McokuuHVBrhjKVvK
 5hudBYGDPx28pzVOxFmSFv68lhgMZsxeUWsDzkXaJxXmO/f9QU+bdjPzwNlYUkunWhzb
 8V2613O6ZzynQ4uAXClTuP9Q7QlhPFBdVRDFkPkmfkvX0JloASjFYBfYixWr25rqnwyf
 m+ew==
X-Gm-Message-State: AFq9FYKissRBftODfneECGyJZA9WZBtasDziM2BmWgDYRVWw/qGV66aw
 jaRJdDrunbHCt772UXAmntOiiNvIfuSXBVzcsq6vFjl+ruY2r5ilaSzW2f2aTLWJ9uIEa68dBPm
 mIgXL/j2R+3ZDylTCsR4JT3sUBSvkDxQrwnFNjEkPc0J8DqnZzifIfKOG0OHGboTLu3V7
X-Gm-Gg: AYBFou0DWkhlQJ9N1c9CZobmZZFD7OQBZVjCmdOrrC3lzIc+SwsDVR2scSiAsr7/Zji
 Fb/y7AN/EPG5Ep15OENuwJ4bxKFIQErXq+0GJe0SLMbsnC0ok1lbKos++PKOUKaRRpneJll+O9N
 hM9ge6LwF0hJn+cGGNOSjgGp3Ue0UPWCfdIUXZwmM0jTVjxBZOlCrtY47XjIvr8XGpNvxq9j5S/
 eh7Vedy4zraJ0cN5TQnmW2PG0AVJCVjBlQl6v1vEgQl1IeuhRZ0nzJcOsTDtQvWn8LdoRjV19yz
 nl+Lu5oLNnPWrIGOkMnUkpuuK6EGOpSuYLBcTzUrFtK4zT3CE10/nNd7D3xlpX1npEguvoxSbwO
 2jVeFPdaqnx9dwBmMwC9cmBdTAN5dPEwqLFueyvCqulpn6ImXYTG74HShrs8fKj8g77aAzdcAWL
 oqGTk80ijiIM/1eRXhFz7dYGYAHaxMiRQAVYlC8kWqtvNd3+qsnhlQtFGzTH/VXIWsW3sECeZNA
 tgOxcQsU3N8QJuqEUq/2oM93Nm4hzSJEX7z96DgTF2MAZzKXOdIFn3lYuvbnTf+D2GieYkkkjWQ
 NixbUCIqTuczIAjwdR3K26oAoaBwQi4emeVfqq1xp1jF6+gWFSRZOu5BzMWCWKXSkHwILOJy4RA
 B0n26+BXwT4r49V6mWy65suEYj6XPFGcavirRknRfFEJw7v6D2bfJbsPzVJtLLTo=
X-Received: by 2002:a05:600c:630f:b0:4a1:efbe:529c with SMTP id
 5b1f17b1804b1-4a35ae9e071mr101224515e9.12.1792969797459; 
 Sun, 25 Oct 2026 16:09:57 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a04ad39sm406002975e9.1.2026.10.25.16.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 16:09:56 -0700 (PDT)
X-Google-Original-From: "Antonio Quartulli (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 25 Oct 2026 23:09:46 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 8
X-Gerrit-Change-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
X-Gerrit-Change-Number: 1783
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1783?usp=email>
X-Gerrit-Commit: b3c3dcb6b4f5a77a24615227dd188f8600969ae5
In-Reply-To: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
References: <gerrit.1784067448000.Ia1e7db95615d99ef9687de7c4e996dc8033e2631@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzg0MDY3NDQ4MDAwLklhMWU3ZGI5NTYxNWQ5OWVmOTY4N2RlN2M0ZTk5NmRjODAzM2UyNjMxQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <a19e2e1806879cda3e57218f8b6a90a9c1b2fb13-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xL7Lo-000000004nK-2qRz
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
Content-Type: multipart/mixed; boundary="===============6536080923940353056=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6536080923940353056==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H2lZLn+eeoA="; charset=UTF-8

--H2lZLn+eeoA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld=2E

H=
ello Arne Schwabe, Frank Lichtenheld, Gert Doering, 

I'd like you to reexa=
mine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1783?usp=3Demail

to look at the new patch set (#8)=2E


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
A tes=
ts/unit_tests/openvpn/test_subnet_pool=2Ec
14 files changed, 753 insertions=
(+), 16 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/83/1783/8

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
=
index 184a95a=2E=2E26bb9ca 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=
=2Etxt
@@ -696,6 +696,7 @@
         "test_provider"
         "test_socket"
=
         "test_ssl"
+        "test_subnet_pool"
         "test_user_pass"
 =
        "test_push_update_msg"
         )
@@ -870,6 +871,11 @@
         src=
/openvpn/session_id=2Ec
     )
 
+    target_sources(test_subnet_pool PRIVA=
TE
+        tests/unit_tests/openvpn/mock_get_random=2Ec
+        src/openv=
pn/options_util=2Ec
+        )
+
     target_sources(test_ncp PRIVATE
     =
    src/openvpn/crypto_epoch=2Ec
         src/openvpn/crypto_mbedtls=2Ec
di=
ff --git a/doc/man-sections/server-options=2Erst b/doc/man-sections/server-=
options=2Erst
index 9dfa6bd=2E=2E9434e5d 100644
--- a/doc/man-sections/serv=
er-options=2Erst
+++ b/doc/man-sections/server-options=2Erst
@@ -330,6 +330=
,48 @@
   by ``--ifconfig``, OpenVPN will install a /32 host route for the =
``local``
   IP address=2E
 
+--subnet-pool args
+  Define a named pool of =
addresses from a subnet different from the
+  ``--server`` network, so grou=
ps of clients can be given IPs from separate
+  subnets for per-group firew=
all rules under ``--topology subnet`` (and
+  therefore DCO)=2E This is a m=
ain-config directive and may be repeated to
+  define several pools=2E
+
+ =
 Valid syntax:
+  ::
+
+     subnet-pool tag network netmask [gateway [star=
t end]]
+
+  ``tag`` is a name a client refers to with ``--subnet-pool-tag`=
`; ``gateway``
+  defaults to the first address of ``network``/``netmask`` =
and is never
+  assigned to a client=2E A client assigned to a pool receive=
s (dynamically, or
+  via a static ``--ifconfig-push`` that must lie within=
 the subnet) an address
+  from it, plus the matching netmask=2E
+
+  Dynam=
ic addresses are taken from ``start`` to ``end`` (every host address
+  of =
the subnet by default)=2E Static ``--ifconfig-push`` addresses are not
+  r=
eserved in the pool: when mixing static and dynamic clients in one pool,
+ =
 set ``start``/``end`` so that the static addresses fall outside the range=
=2E
+
+  Requires ``--server`` with ``--dev tun`` and ``--topology subnet``=
=2E
+  ``netmask`` must be between /16 and /29 (as for ``--server``), ``gat=
eway``
+  must be a host address inside the subnet, ``start`` and ``end`` h=
ost
+  addresses inside the subnet with ``start`` lower than ``end``, each =
``tag``
+  may be defined only once and no pool may overlap another one or =
the
+  ``--server`` network=2E
+
+  The server routes each pool's subnet in=
to the tun device, as it does for
+  the ``--server`` network; no ``--route=
`` needs to be added for it=2E These
+  routes honour ``--route-table`` and=
 ``--route-metric``=2E With DCO on Linux
+  and FreeBSD the IPv4 route is i=
nstalled on-link, without a gateway, so its
+  ``route_gateway_{n}`` is not=
 set for ``--route-up`` scripts=2E
+
+--subnet-pool-tag tag
+  Assign this =
client to the ``--subnet-pool`` named ``tag``=2E Must be
+  associated with=
 a specific client instance via ``--client-config-dir`` or
+  ``--client-co=
nnect``=2E Several clients may reference the same tag and are
+  then serve=
d from the same shared pool=2E
+
 --ifconfig-ipv6-push args
   for ``--clie=
nt-config-dir`` per-client static IPv6 interface
   configuration, see ``--=
client-config-dir`` and ``--ifconfig-push`` for
diff --git a/src/openvpn/mu=
lti=2Ec b/src/openvpn/multi=2Ec
index e302a81=2E=2Ee8d51da 100644
--- a/src=
/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -43,6 +43,7 @@
 #include =
"auth_token=2Eh"
 #include "route=2Eh"
 #include "sid_hash=2Eh"
+#include "=
options_util=2Eh"
 #include <inttypes=2Eh>
 #include <string=2Eh>
 
@@ -54,=
6 +55,21 @@
 #include "dco=2Eh"
 #include "reflect_filter=2Eh"
 
+/*
+ * Dy=
namic address pool serving the clients of one --subnet-pool tag=2E  Shared
=
+ * by every client that references the tag, created at startup by
+ * mult=
i_init()=2E
+ */
+struct subnet_pool
+{
+    struct subnet_pool *next;
+   =
 const char *tag;
+    struct ifconfig_pool *pool;
+};
+
+static struct ifc=
onfig_pool *multi_get_group_pool(struct multi_context *m,
+                =
                                  const struct options *o, const char *tag)=
;
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@=
 -371,6 +387,13 @@
         }
     }
 
+    /* create every --subnet-pool g=
roup up front rather than on first use, so
+     * that its pool exists bef=
ore any client of the group connects */
+    for (const struct subnet_pool_=
def *d =3D t->options=2Esubnet_pools; d; d =3D d->next)
+    {
+        mul=
ti_get_group_pool(m, &t->options, d->tag);
+    }
+
     /*
      * Help us=
 keep track of routing table=2E
      */
@@ -625,7 +648,8 @@
 
         sch=
edule_remove_entry(m->schedule, (struct schedule_entry *)mi);
 
-        if=
config_pool_release(m->ifconfig_pool, mi->vaddr_handle, false);
+        if=
config_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool, mi-=
>vaddr_handle,
+                              false);
 
         if (mi->di=
d_iroutes)
         {
@@ -707,6 +731,14 @@
         schedule_free(m->schedu=
le);
         mbuf_free(m->mbuf);
         ifconfig_pool_free(m->ifconfig_p=
ool);
+        while (m->subnet_pools)
+        {
+            struct subne=
t_pool *sp =3D m->subnet_pools;
+
+            m->subnet_pools =3D sp->next=
;
+            ifconfig_pool_free(sp->pool);
+            free(sp);
+      =
  }
         frequency_limit_free(m->new_connection_limiter);
         init=
ial_rate_limit_free(m->initial_rate_limiter);
         multi_reap_free(m->r=
eaper);
@@ -1405,6 +1437,12 @@
     const struct options *o =3D &c->options=
;
     if (o->push_ifconfig_constraint_defined && c->c2=2Epush_ifconfig_def=
ined)
     {
+        /* a subnet-pool client is validated against its own =
subnet */
+        if (o->subnet_pool_defined)
+        {
+            retu=
rn (o->subnet_pool_netmask & c->c2=2Epush_ifconfig_local)
+                =
   =3D=3D o->subnet_pool_network;
+        }
         return (o->push_ifcon=
fig_constraint_netmask & c->c2=2Epush_ifconfig_local)
                =3D=
=3D o->push_ifconfig_constraint_network;
     }
@@ -1415,6 +1453,40 @@
 }
 =

 /*
+ * Return the dynamic pool serving the clients tagged with <tag>, cre=
ating it
+ * from the matching --subnet-pool definition in <o> if it does n=
ot exist yet
+ * (which only happens when multi_init() creates every pool a=
t startup)=2E
+ */
+static struct ifconfig_pool *
+multi_get_group_pool(str=
uct multi_context *m, const struct options *o, const char *tag)
+{
+    str=
uct subnet_pool *sp;
+
+    for (sp =3D m->subnet_pools; sp; sp =3D sp->nex=
t)
+    {
+        if (!strcmp(sp->tag, tag))
+        {
+            retur=
n sp->pool;
+        }
+    }
+
+    const struct subnet_pool_def *d4 =3D s=
ubnet_pool_by_tag(o->subnet_pools, tag);
+    ASSERT(d4);
+    ALLOC_OBJ_CL=
EAR(sp, struct subnet_pool);
+    sp->tag =3D d4->tag;
+    /* the configur=
ed dynamic range, or else every host address of the
+     * subnet, minus t=
he gateway reserved below if it falls inside it */
+    const in_addr_t sta=
rt =3D d4->pool_start ? d4->pool_start : d4->network + 1;
+    const in_add=
r_t end =3D d4->pool_end ? d4->pool_end : (d4->network | ~d4->netmask) - 1;=

+    sp->pool =3D ifconfig_pool_init(true, IFCONFIG_POOL_INDIV, start, end=
, o->duplicate_cn, false,
+                                  in6addr_any, 0=
);
+    ifconfig_pool_reserve_ip(sp->pool, d4->gateway);
+    sp->next =3D =
m->subnet_pools;
+    m->subnet_pools =3D sp;
+    return sp->pool;
+}
+
+/=
*
  * Select a virtual address for a new client instance=2E
  * Use an --if=
config-push directive, if given (static IP)=2E
  * Otherwise use an --ifcon=
fig-pool address (dynamic IP)=2E
@@ -1424,6 +1496,25 @@
 {
     struct gc_a=
rena gc =3D gc_new();
 
+    /* resolve --subnet-pool-tag against the main-=
config --subnet-pool list (an
+     * unknown tag is rejected with AUTH_FAI=
LED in multi_connection_established)=2E
+     * This runs again after every=
 client-connect handler, and a later handler
+     * (script, plugin, manag=
ement) may override the tag set by the CCD file,
+     * so always resolve =
the current tag=2E */
+    if (mi->context=2Eoptions=2Esubnet_pool_tag)
+  =
  {
+        const struct subnet_pool_def *d =3D
+            subnet_pool_b=
y_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=2Eoptions=2Esubnet_pool_=
tag);
+
+        mi->context=2Eoptions=2Esubnet_pool_defined =3D d !=3D NUL=
L;
+        if (d)
+        {
+            mi->context=2Eoptions=2Esubnet_p=
ool_network =3D d->network;
+            mi->context=2Eoptions=2Esubnet_poo=
l_netmask =3D d->netmask;
+            mi->context=2Eoptions=2Esubnet_pool_=
gateway =3D d->gateway;
+        }
+    }
+
     /*
      * If ifconfig add=
resses were set by dynamic config file,
      * release pool addresses, oth=
erwise keep them=2E
@@ -1434,8 +1525,10 @@
          * release dynamic allo=
cation */
         if (mi->vaddr_handle >=3D 0)
         {
-            ifc=
onfig_pool_release(m->ifconfig_pool, mi->vaddr_handle, true);
+            =
ifconfig_pool_release(mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
+=
                                  mi->vaddr_handle, true);
             mi-=
>vaddr_handle =3D -1;
+            mi->vaddr_pool =3D NULL;
         }
 
  =
       mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
@@ -1455,6 +1548,=
52 @@
                 "MULTI_sva: WARNING: if --ifconfig-push is used for =
IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool does not work=2E =
 Use --ifconfig-ipv6-push for IPv6 then=2E");
         }
     }
+    else i=
f (mi->context=2Eoptions=2Esubnet_pool_defined)
+    {
+        /* dynamic =
address from this client's --subnet-pool group */
+        struct ifconfig_=
pool *group =3D
+            multi_get_group_pool(m, &m->top=2Eoptions, mi-=
>context=2Eoptions=2Esubnet_pool_tag);
+
+        /* the address may have b=
een acquired before the tag was known (from
+         * the global pool) or=
 for a tag that a later handler overrode: drop
+         * it so we serve t=
his client from its current group */
+        if (mi->vaddr_handle >=3D 0 &=
& mi->vaddr_pool !=3D group)
+        {
+            ifconfig_pool_release(=
mi->vaddr_pool ? mi->vaddr_pool : m->ifconfig_pool,
+                      =
            mi->vaddr_handle, true);
+            mi->vaddr_handle =3D -1;
=
+            mi->vaddr_pool =3D NULL;
+            /* both addresses of the=
 dropped slot go back to its pool */
+            mi->context=2Ec2=2Epush_i=
fconfig_defined =3D false;
+            mi->context=2Ec2=2Epush_ifconfig_ip=
v6_defined =3D false;
+        }
+
+        if (mi->vaddr_handle < 0)
+    =
    {
+            in_addr_t local =3D 0, remote =3D 0;
+            const =
char *cn =3D NULL;
+
+            if (!mi->context=2Eoptions=2Eduplicate_cn=
)
+            {
+                cn =3D tls_common_name(mi->context=2Ec2=
=2Etls_multi, true);
+            }
+
+            mi->vaddr_pool =3D group=
;
+            mi->vaddr_handle =3D ifconfig_pool_acquire(mi->vaddr_pool, &=
local, &remote, NULL, cn);
+            if (mi->vaddr_handle >=3D 0)
+     =
       {
+                mi->context=2Ec2=2Epush_ifconfig_local =3D remote=
;
+                mi->context=2Ec2=2Epush_ifconfig_remote_netmask =3D
+   =
                 mi->context=2Eoptions=2Esubnet_pool_netmask;
+            =
    mi->context=2Ec2=2Epush_ifconfig_defined =3D true;
+            }
+    =
        else
+            {
+                msg(D_MULTI_ERRORS, "MULTI: no=
 free --subnet-pool addresses are available for %s",
+                    m=
ulti_instance_string(mi, false, &gc));
+            }
+        }
+    }
   =
  else if (m->ifconfig_pool && mi->vaddr_handle < 0) /* otherwise, choose a=
 pool address */
     {
         in_addr_t local =3D 0, remote =3D 0;
@@ -2=
360,10 +2499,9 @@
         const char *ifconfig_constraint_netmask =3D
    =
         print_in_addr_t(mi->context=2Eoptions=2Epush_ifconfig_constraint_n=
etmask, 0, &gc);
 
-        /* JYFIXME -- this should cause the connection =
to fail */
         msg(D_MULTI_ERRORS,
-            "MULTI ERROR: primary =
virtual IP for %s (%s) "
-            "violates tunnel network/netmask cons=
traint (%s/%s)",
+            "WARNING: primary virtual IP for %s (%s) "
+ =
           "violates tunnel network/netmask constraint (%s/%s) and may not =
work",
             multi_instance_string(mi, false, &gc),
             pri=
nt_in_addr_t(mi->context=2Ec2=2Epush_ifconfig_local, 0, &gc),
             =
ifconfig_constraint_network, ifconfig_constraint_netmask);
@@ -2471,6 +2609=
,7 @@
 
     /* reset pool handle to null */
     mi->vaddr_handle =3D -1;
=
+    mi->vaddr_pool =3D NULL;
 
     /* do --client-connect setenvs */
    =
 multi_select_virtual_addr(m, mi);
@@ -2792,6 +2931,15 @@
         cc_succe=
eded =3D false;
     }
 
+    if (mi->context=2Eoptions=2Esubnet_pool_tag
+=
        && !subnet_pool_by_tag(m->top=2Eoptions=2Esubnet_pools, mi->context=
=2Eoptions=2Esubnet_pool_tag))
+    {
+        msg(D_MULTI_ERRORS, "MULTI: =
client has been rejected due to unknown --subnet-pool-tag '%s'",
+         =
   mi->context=2Eoptions=2Esubnet_pool_tag);
+        auth_set_client_reaso=
n(mi->context=2Ec2=2Etls_multi, "unknown subnet-pool-tag");
+        cc_suc=
ceeded =3D false;
+    }
+
     if (cc_succeeded)
     {
         multi_cli=
ent_connect_late_setup(m, mi, *option_types_found);
diff --git a/src/openvp=
n/multi=2Eh b/src/openvpn/multi=2Eh
index 5db7147=2E=2E14f71dd 100644
--- a=
/src/openvpn/multi=2Eh
+++ b/src/openvpn/multi=2Eh
@@ -121,6 +121,8 @@
    =
 struct mroute_addr real; /**< External network address of the
            =
                   *   remote peer=2E */
     ifconfig_pool_handle vaddr_ha=
ndle;
+    /* pool vaddr_handle belongs to (NULL =3D the global one) */
+  =
  struct ifconfig_pool *vaddr_pool;
     char msg_prefix[MULTI_PREFIX_MAX_L=
ENGTH];
 
     /* queued outgoing data in Server/TCP mode */
@@ -190,6 +192=
,8 @@
                                         *   instances=2E */
     str=
uct multi_io *multi_io;         /**< I/O state and events tracker */
     s=
truct ifconfig_pool *ifconfig_pool;
+    /* per-group --subnet-pool dynamic=
 pools */
+    struct subnet_pool *subnet_pools;
     struct frequency_limi=
t *new_connection_limiter;
     struct initial_packet_rate_limit *initial_r=
ate_limiter;
     struct mroute_helper *route_helper;
diff --git a/src/open=
vpn/options=2Ec b/src/openvpn/options=2Ec
index 8e0c602=2E=2Eeb0bcfd 100644=

--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -453,6 +453=
,12 @@
     "                  If seconds=3D0, file will be treated as read=
-only=2E\n"
     "--ifconfig-ipv6-pool base-IP/bits : set aside an IPv6 net=
work block\n"
     "                  to be dynamically allocated to connec=
ting clients=2E\n"
+    "--subnet-pool tag network netmask [gateway [start =
end]] : Define a named\n"
+    "                  pool of addresses outside=
 the --server network, selected\n"
+    "                  per client with =
--subnet-pool-tag=2E start/end restrict the\n"
+    "                  dyna=
mically assigned range=2E\n"
+    "--subnet-pool-tag tag : Assign this clie=
nt to the --subnet-pool named tag=2E\n"
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
+        sp->tag =3D p[1];
+        sp->network =3D network & n=
etmask;
+        sp->netmask =3D netmask;
+        sp->gateway =3D (network=
 & netmask) + 1;
+        if (p[4])
+        {
+            bool ok =3D fal=
se;
+
+            sp->gateway =3D getaddr(GETADDR_HOST_ORDER | GETADDR_RES=
OLVE, p[4], 0, &ok, NULL);
+            if (!ok)
+            {
+          =
      msg(msglevel, "cannot parse --subnet-pool gateway");
+               =
 goto err;
+            }
+        }
+        /* optional range of the dyna=
mic pool, validated in
+         * subnet_pools_check(); unset, it spans th=
e whole subnet */
+        if (p[5])
+        {
+            bool ok_start =
=3D false, ok_end =3D false;
+
+            sp->pool_start =3D getaddr(GETA=
DDR_HOST_ORDER, p[5], 0, &ok_start, NULL);
+            sp->pool_end =3D ge=
taddr(GETADDR_HOST_ORDER, p[6], 0, &ok_end, NULL);
+            if (!ok_sta=
rt || !ok_end)
+            {
+                msg(msglevel, "cannot parse =
--subnet-pool range");
+                goto err;
+            }
+        }=

+        sp->next =3D options->subnet_pools;
+        options->subnet_pool=
s =3D sp;
+    }
+    else if (streq(p[0], "subnet-pool-tag") && p[1] && !p=
[2])
+    {
+        VERIFY_PERMISSION(OPT_P_INSTANCE);
+        options->s=
ubnet_pool_tag =3D p[1];
+    }
     else if (streq(p[0], "ifconfig-push-co=
nstraint") && p[1] && p[2] && !p[3])
     {
         in_addr_t network, net=
mask;
diff --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh
index =
c58530a=2E=2E568bae6 100644
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn=
/options=2Eh
@@ -252,6 +252,21 @@
     struct verify_hash_list *next;
 };
 =

+/* A named --subnet-pool: a subnet clients can be assigned from, referenc=
ed
+ * from a CCD file by its tag via --subnet-pool-tag=2E */
+struct subne=
t_pool_def
+{
+    struct subnet_pool_def *next;
+    const char *tag;
+   =
 in_addr_t network;
+    in_addr_t netmask;
+    in_addr_t gateway;
+    /*=
 optional range of the dynamic pool (0/0: every host address of the
+     *=
 subnet); addresses outside it are left for static --ifconfig-push */
+    =
in_addr_t pool_start;
+    in_addr_t pool_end;
+};
+
 /* Command line optio=
ns */
 struct options
 {
@@ -518,6 +533,12 @@
     bool push_ifconfig_const=
raint_defined;
     in_addr_t push_ifconfig_constraint_network;
     in_add=
r_t push_ifconfig_constraint_netmask;
+    struct subnet_pool_def *subnet_p=
ools; /* named pools (server config) */
+    const char *subnet_pool_tag;  =
        /* which pool this client uses (CCD) */
+    bool subnet_pool_defin=
ed;             /* resolved from the tag at connect */
+    in_addr_t subne=
t_pool_network;
+    in_addr_t subnet_pool_netmask;
+    in_addr_t subnet_p=
ool_gateway;
     bool push_ifconfig_ipv4_blocked;           /* IPv4 */
   =
  bool push_ifconfig_ipv6_defined;           /* IPv6 */
     struct in6_add=
r push_ifconfig_ipv6_local;  /* IPv6 */
@@ -979,4 +1000,23 @@
 #endif /* EN=
ABLE_DCO */
 }
 
+/**
+ * Whether the routes of the --subnet-pool networks =
are installed on-link on
+ * the DCO device rather than via a gateway=2E  W=
ith DCO on Linux and FreeBSD the
+ * kernel selects the peer by a route's n=
ext hop, so a route via a gateway
+ * would deliver every packet for an una=
ssigned pool address to the client
+ * owning that gateway address; on-link=
, such a packet matches no peer, while
+ * each pool client gets its own on=
-link host route when it connects (see
+ * multi_learn_in_addr_t())=2E
+ */=

+static inline bool
+subnet_pool_routes_onlink(const struct options *o)
+{=

+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    return dco_enab=
led(o);
+#else
+    return false;
+#endif
+}
+
 #endif /* ifndef OPTIONS_H =
*/
diff --git a/src/openvpn/options_util=2Ec b/src/openvpn/options_util=2Ec=

index d25d85c=2E=2E862bf7c 100644
--- a/src/openvpn/options_util=2Ec
+++ b=
/src/openvpn/options_util=2Ec
@@ -30,6 +30,105 @@
 #include "options_util=
=2Eh"
 
 #include "push=2Eh"
+#include "pool=2Eh"
+
+const struct subnet_po=
ol_def *
+subnet_pool_by_tag(const struct subnet_pool_def *pools, const cha=
r *tag)
+{
+    for (const struct subnet_pool_def *d =3D pools; d; d =3D d-=
>next)
+    {
+        if (!strcmp(d->tag, tag))
+        {
+            re=
turn d;
+        }
+    }
+    return NULL;
+}
+
+/* true if the two IPv4 s=
ubnets share at least one address */
+static bool
+subnets_overlap(in_addr_=
t a, in_addr_t mask_a, in_addr_t b, in_addr_t mask_b)
+{
+    const in_addr=
_t mask =3D mask_a & mask_b;
+
+    return (a & mask) =3D=3D (b & mask);
+}=

+
+bool
+subnet_pools_check(const struct subnet_pool_def *pools, in_addr_t=
 server_network,
+                   in_addr_t server_netmask, msglvl_t msg=
level)
+{
+    for (const struct subnet_pool_def *d =3D pools; d; d =3D d->=
next)
+    {
+        const in_addr_t host =3D ~d->netmask;
+        int ne=
tbits =3D 32;
+
+        /* the netmask must be contiguous */
+        if (=
host & (host + 1))
+        {
+            msg(msglevel, "--subnet-pool %s:=
 invalid netmask", d->tag);
+            return false;
+        }
+        =
for (in_addr_t h =3D host; h; h >>=3D 1)
+        {
+            netbits--;=

+        }
+
+        /* same bounds as --server: the pool must hold at le=
ast 2 addresses
+         * besides network, gateway and broadcast, and fit=
 IFCONFIG_POOL_MAX */
+        if (netbits < IFCONFIG_POOL_MIN_NETBITS || n=
etbits > 29)
+        {
+            msg(msglevel, "--subnet-pool %s: netma=
sk must be between /%d and /29 (not /%d)",
+                d->tag, IFCONFI=
G_POOL_MIN_NETBITS, netbits);
+            return false;
+        }
+
+    =
    if ((d->gateway & d->netmask) !=3D d->network || d->gateway =3D=3D d->n=
etwork
+            || d->gateway =3D=3D (d->network | host))
+        {
+ =
           msg(msglevel, "--subnet-pool %s: gateway must be a host address =
inside the subnet",
+                d->tag);
+            return false;
+ =
       }
+
+        /* an explicit dynamic range must be made of host addre=
sses of the
+         * subnet and hold at least the 2 entries an ifconfig =
pool needs */
+        if ((d->pool_start || d->pool_end)
+            && (=
(d->pool_start & d->netmask) !=3D d->network
+                || (d->pool_e=
nd & d->netmask) !=3D d->network || d->pool_start =3D=3D d->network
+      =
          || d->pool_end =3D=3D (d->network | host) || d->pool_start >=3D d=
->pool_end))
+        {
+            msg(msglevel,
+                "--subn=
et-pool %s: range start and end must be host addresses inside the "
+      =
          "subnet, with start lower than end",
+                d->tag);
+ =
           return false;
+        }
+
+        if (server_netmask
+        =
    && subnets_overlap(d->network, d->netmask, server_network, server_netma=
sk))
+        {
+            msg(msglevel, "--subnet-pool %s: subnet overla=
ps the --server network", d->tag);
+            return false;
+        }
+
=
+        for (const struct subnet_pool_def *e =3D d->next; e; e =3D e->next=
)
+        {
+            if (!strcmp(d->tag, e->tag))
+            {
+    =
            msg(msglevel, "--subnet-pool %s: tag defined more than once", d=
->tag);
+                return false;
+            }
+            if (subn=
ets_overlap(d->network, d->netmask, e->network, e->netmask))
+            {=

+                msg(msglevel, "--subnet-pool %s and %s: subnets overlap",=
 d->tag, e->tag);
+                return false;
+            }
+        }
=
+    }
+
+    return true;
+}
 
 const char *
 parse_auth_failed_temp(struc=
t options *o, const char *reason)
diff --git a/src/openvpn/options_util=2Eh=
 b/src/openvpn/options_util=2Eh
index 5226a6f=2E=2Ef1e63e15 100644
--- a/sr=
c/openvpn/options_util=2Eh
+++ b/src/openvpn/options_util=2Eh
@@ -28,6 +28,=
33 @@
 
 const char *parse_auth_failed_temp(struct options *o, const char *=
reason);
 
+/**
+ * Look up a named --subnet-pool in a list of pool definit=
ions=2E
+ *
+ * @param pools  head of the --subnet-pool list (may be NULL)
=
+ * @param tag    the --subnet-pool-tag to match
+ * @return       the matc=
hing pool definition, or NULL if none matches
+ */
+const struct subnet_poo=
l_def *subnet_pool_by_tag(const struct subnet_pool_def *pools,
+           =
                                      const char *tag);
+
+/**
+ * Validate=
 the --subnet-pool definitions: contiguous netmask between
+ * /IFCONFIG_PO=
OL_MIN_NETBITS and /29, gateway a host address inside its
+ * subnet, an ex=
plicit dynamic range made of at least 2 host addresses of the
+ * subnet,
+=
 * unique tags, and no subnet overlapping another pool or the --server
+ * =
network=2E
+ *
+ * @param pools           head of the --subnet-pool list (m=
ay be NULL)
+ * @param server_network  the --server network (host order)
+ =
* @param server_netmask  the --server netmask, or 0 if there is none
+ * @p=
aram msglevel        level of the message logged on the first error
+ * @re=
turn                true if every definition is valid
+ */
+bool subnet_poo=
ls_check(const struct subnet_pool_def *pools, in_addr_t server_network,
+  =
                      in_addr_t server_netmask, msglvl_t msglevel);
+
 
 /*=
* Checks if the string is a valid integer by checking if it can be
  *  con=
verted to an integer */
diff --git a/src/openvpn/pool=2Ec b/src/openvpn/poo=
l=2Ec
index fff0e3f=2E=2E5c5b3fe 100644
--- a/src/openvpn/pool=2Ec
+++ b/sr=
c/openvpn/pool=2Ec
@@ -351,7 +351,7 @@
 {
     bool ret =3D false;
 
-    i=
f (pool && hand >=3D 0 && hand < pool->size)
+    if (pool && hand >=3D 0 &=
& hand < pool->size && !pool->list[hand]=2Ereserved)
     {
         ifconf=
ig_pool_entry_free(&pool->list[hand], hard);
         ret =3D true;
@@ -430=
,6 +430,22 @@
     return ret;
 }
 
+bool
+ifconfig_pool_reserve_ip(struct =
ifconfig_pool *pool, const in_addr_t addr)
+{
+    const ifconfig_pool_hand=
le h =3D ifconfig_pool_ip_base_to_handle(pool, addr);
+
+    if (h < 0)
+  =
  {
+        return false;
+    }
+
+    ifconfig_pool_entry_free(&pool->li=
st[h], true);
+    pool->list[h]=2Ein_use =3D true;
+    pool->list[h]=2Ere=
served =3D true;
+    return true;
+}
+
 static in_addr_t
 ifconfig_pool_ha=
ndle_to_ip_base(const struct ifconfig_pool *pool, ifconfig_pool_handle hand=
)
 {
@@ -477,6 +493,13 @@
                   const bool fixed)
 {
     stru=
ct ifconfig_pool_entry *e =3D &pool->list[h];
+
+    if (e->reserved)
+    =
{
+        msg(M_WARN, "pool: ignoring persisted entry for CN=3D%s: its add=
ress is reserved", cn);
+        return;
+    }
+
     ifconfig_pool_entry_=
free(e, true);
     e->in_use =3D false;
     e->common_name =3D string_all=
oc(cn, NULL);
diff --git a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh
inde=
x e2d3f82=2E=2E497dcda 100644
--- a/src/openvpn/pool=2Eh
+++ b/src/openvpn/=
pool=2Eh
@@ -43,6 +43,7 @@
     char *common_name;
     time_t last_release=
;
     bool fixed;
+    bool reserved; /* never handed out, e=2Eg=2E a --su=
bnet-pool gateway */
 };
 
 struct ifconfig_pool
@@ -86,6 +87,17 @@
 
 bool=
 ifconfig_pool_release(struct ifconfig_pool *pool, ifconfig_pool_handle han=
d, const bool hard);
 
+/**
+ * Permanently reserve the pool slot holding \=
c addr, so that it is never
+ * handed out to a client nor taken over by a =
persisted entry (e=2Eg=2E the
+ * gateway of a --subnet-pool)=2E
+ *
+ * @p=
aram pool  the pool
+ * @param addr  IPv4 address (host order) to reserve
+=
 * @return      true if \c addr lies in the pool and was reserved
+ */
+boo=
l ifconfig_pool_reserve_ip(struct ifconfig_pool *pool, in_addr_t addr);
+
 =
struct ifconfig_pool_persist *ifconfig_pool_persist_init(const char *filena=
me, int refresh_freq);
 
 void ifconfig_pool_persist_close(struct ifconfig_=
pool_persist *persist);
diff --git a/src/openvpn/route=2Ec b/src/openvpn/ro=
ute=2Ec
index 0bce966=2E=2Efecef7e 100644
--- a/src/openvpn/route=2Ec
+++ b=
/src/openvpn/route=2Ec
@@ -408,6 +408,11 @@
         r->flags |=3D RT_METRI=
C_DEFINED;
     }
 
+    if (ro->on_link)
+    {
+        r->flags |=3D RT_=
ON_LINK;
+    }
+
     r->flags |=3D RT_DEFINED;
 
     /* routing table id=
 */
@@ -478,12 +483,12 @@
     return false;
 }
 
-void
+struct route_optio=
n *
 add_route_to_option_list(struct route_option_list *l, const char *netw=
ork, const char *netmask,
                          const char *gateway, co=
nst char *metric, int table_id)
 {
     struct route_option *ro;
-    ALLOC=
_OBJ_GC(ro, struct route_option, l->gc);
+    ALLOC_OBJ_CLEAR_GC(ro, struct=
 route_option, l->gc);
     ro->network =3D network;
     ro->netmask =3D n=
etmask;
     ro->gateway =3D gateway;
@@ -491,6 +496,7 @@
     ro->table_id=
 =3D table_id;
     ro->next =3D l->routes;
     l->routes =3D ro;
+    ret=
urn ro;
 }
 
 void
@@ -1322,7 +1328,11 @@
     {
         setenv_route_addr=
(es, "network", r->network, i);
         setenv_route_addr(es, "netmask", r=
->netmask, i);
-        setenv_route_addr(es, "gateway", r->gateway, i);
+ =
       /* an on-link route has no gateway */
+        if (!(r->flags & RT_O=
N_LINK))
+        {
+            setenv_route_addr(es, "gateway", r->gatewa=
y, i);
+        }
 
         if (r->flags & RT_METRIC_DEFINED)
         {
@=
@ -1478,6 +1488,7 @@
 
 #if defined(TARGET_LINUX)
     const char *iface =
=3D NULL;
+    const in_addr_t *gateway =3D &r->gateway;
     int metric =
=3D -1;
 
     if (is_on_link(is_local_route, flags, rgi))
@@ -1485,6 +1496=
,12 @@
         iface =3D rgi->iface;
     }
 
+    if ((r->flags & RT_ON_L=
INK) && tt)
+    {
+        gateway =3D NULL;
+        iface =3D tt->actual=
_name;
+    }
+
     if (r->flags & RT_METRIC_DEFINED)
     {
         metr=
ic =3D r->metric;
@@ -1492,8 +1509,8 @@
 
 
     status =3D RTA_SUCCESS;
- =
   int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbits2(r->ne=
tmask), &r->gateway,
-                               iface, r->table_id, me=
tric);
+    int ret =3D net_route_v4_add(ctx, &r->network, netmask_to_netbi=
ts2(r->netmask), gateway, iface,
+                               r->table_i=
d, metric);
     if (ret =3D=3D -EEXIST)
     {
         msg(D_ROUTE, "NOTE=
: Linux route add command failed because route exists");
@@ -1616,7 +1633,1=
5 @@
     }
 #endif
 
-    argv_printf_cat(&argv, "-net %s %s %s", network,=
 gateway, netmask);
+    if ((r->flags & RT_ON_LINK) && tt)
+    {
+       =
 argv_printf_cat(&argv, "-net %s/%d -iface %s", network, netmask_to_netbits=
2(r->netmask),
+                        tt->actual_name);
+    }
+    else
=
+    {
+        argv_printf_cat(&argv, "-net %s %s %s", network, gateway, n=
etmask);
+    }
 
     /* FIXME -- add on-link support for FreeBSD */
 
@@ =
-2035,7 +2060,16 @@
         metric =3D r->metric;
     }
 
-    if (net_ro=
ute_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask), &r->gateway, =
NULL,
+    const in_addr_t *gateway =3D &r->gateway;
+    const char *iface=
 =3D NULL;
+
+    if ((r->flags & RT_ON_LINK) && tt)
+    {
+        gatewa=
y =3D NULL;
+        iface =3D tt->actual_name;
+    }
+
+    if (net_route=
_v4_del(ctx, &r->network, netmask_to_netbits2(r->netmask), gateway, iface,
=
                          r->table_id, metric)
         < 0)
     {
@@ -209=
1,7 +2125,15 @@
 
 #elif defined(TARGET_FREEBSD)
 
-    argv_printf(&argv, =
"%s delete -net %s %s %s", ROUTE_PATH, network, gateway, netmask);
+    if =
((r->flags & RT_ON_LINK) && tt)
+    {
+        argv_printf(&argv, "%s dele=
te -net %s/%d -iface %s", ROUTE_PATH, network,
+                    netmask=
_to_netbits2(r->netmask), tt->actual_name);
+    }
+    else
+    {
+      =
  argv_printf(&argv, "%s delete -net %s %s %s", ROUTE_PATH, network, gatewa=
y, netmask);
+    }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_ch=
eck(&argv, es, 0, "ERROR: FreeBSD route delete command failed");
diff --git=
 a/src/openvpn/route=2Eh b/src/openvpn/route=2Eh
index 0d33d36=2E=2E7c5528f=
 100644
--- a/src/openvpn/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -80,6 +8=
0,10 @@
     const char *gateway;
     int table_id;
     const char *metri=
c;
+    /* on Linux and FreeBSD, install the route on-link on the tun devic=
e
+     * instead of via the gateway (needed under DCO, where the kernel se=
lects
+     * the peer by the route's next hop) */
+    bool on_link;
 };
 =

 /* redirect-gateway flags */
@@ -120,6 +124,7 @@
 #define RT_DEFINED     =
   (1u << 0)
 #define RT_ADDED          (1u << 1)
 #define RT_METRIC_DEFINE=
D (1u << 2)
+#define RT_ON_LINK        (1u << 3) /* see struct route_option=
=2Eon_link */
     struct route_ipv4 *next;
     unsigned int flags;
     c=
onst struct route_option *option;
@@ -311,8 +316,9 @@
                const=
 struct route_gateway_info *rgi, const struct env_set *es,
                =
openvpn_net_ctx_t *ctx);
 
-void add_route_to_option_list(struct route_opti=
on_list *l, const char *network, const char *netmask,
-                    =
          const char *gateway, const char *metric, int table_id);
+struct r=
oute_option *add_route_to_option_list(struct route_option_list *l, const ch=
ar *network,
+                                              const char *net=
mask, const char *gateway,
+                                              c=
onst char *metric, int table_id);
 
 void add_route_ipv6_to_option_list(str=
uct route_ipv6_option_list *l, const char *prefix,
                        =
            const char *gateway, const char *metric, int table_id);
diff --=
git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Mak=
efile=2Eam
index 43a6743=2E=2Eea4c395 100644
--- a/tests/unit_tests/openvpn=
/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -21,6 +21,7 =
@@
 	push_update_msg_testdriver \
 	socket_testdriver \
 	ssl_testdriver \
=
+	subnet_pool_testdriver \
 	user_pass_testdriver
 
 if HAVE_LD_WRAP_SUPPOR=
T
@@ -384,6 +385,19 @@
 	$(top_srcdir)/src/openvpn/platform=2Ec \
 	$(top_s=
rcdir)/src/openvpn/mbuf=2Ec
 
+subnet_pool_testdriver_CFLAGS  =3D \
+	-I$(t=
op_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \=

+	@TEST_CFLAGS@
+
+subnet_pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+su=
bnet_pool_testdriver_SOURCES =3D test_subnet_pool=2Ec \
+	mock_msg=2Ec test=
_common=2Eh \
+	mock_get_random=2Ec \
+	$(top_srcdir)/src/openvpn/buffer=2E=
c \
+	$(top_srcdir)/src/openvpn/options_util=2Ec \
+	$(top_srcdir)/src/open=
vpn/platform=2Ec
+
 misc_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include=
 -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	-DSOURCEDIR=3D\=
"$(top_srcdir)\" @TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_s=
ubnet_pool=2Ec b/tests/unit_tests/openvpn/test_subnet_pool=2Ec
new file mod=
e 100644
index 0000000=2E=2E4022233
--- /dev/null
+++ b/tests/unit_tests/op=
envpn/test_subnet_pool=2Ec
@@ -0,0 +1,174 @@
+/*
+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks
+ *             over a single UDP port,=
 with support for SSL/TLS-based
+ *             session authentication and =
key exchange,
+ *             packet encryption, packet authentication, and=

+ *             packet compression=2E
+ *
+ *  Copyright (C) 2026 OpenVPN =
Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can r=
edistribute it and/or modify
+ *  it under the terms of the GNU General Pub=
lic License version 2
+ *  as published by the Free Software Foundation=2E
=
+ *
+ *  This program is distributed in the hope that it will be useful,
+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Genera=
l Public License for more details=2E
+ *
+ *  You should have received a co=
py of the GNU General Public License along
+ *  with this program; if not, =
see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#i=
nclude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdlib=
=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "options=2E=
h"
+#include "options_util=2Eh"
+#include "test_common=2Eh"
+#include "mock=
_msg=2Eh"
+
+/* --subnet-pool-tag resolves a client to its --subnet-pool; a=
n unknown tag
+ * returns NULL, which is what makes the server reject that =
client=2E */
+static void
+test_subnet_pool_by_tag(void **state)
+{
+    st=
ruct subnet_pool_def c =3D { =2Enext =3D NULL, =2Etag =3D "grpC", =2Enetwor=
k =3D 0x0a020300, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020301 };
+=
    struct subnet_pool_def b =3D { =2Enext =3D &c, =2Etag =3D "grpB", =2Ene=
twork =3D 0x0a020200, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020201 =
};
+    struct subnet_pool_def a =3D { =2Enext =3D &b, =2Etag =3D "grpA", =
=2Enetwork =3D 0x0a020100, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a02=
0101 };
+
+    /* every configured tag resolves to its own pool, wherever i=
t sits */
+    assert_ptr_equal(subnet_pool_by_tag(&a, "grpA"), &a);
+    a=
ssert_ptr_equal(subnet_pool_by_tag(&a, "grpB"), &b);
+    assert_ptr_equal(=
subnet_pool_by_tag(&a, "grpC"), &c);
+
+    /* and it carries that pool's s=
ubnet/gateway */
+    const struct subnet_pool_def *r =3D subnet_pool_by_ta=
g(&a, "grpB");
+    assert_int_equal(r->network, 0x0a020200);
+    assert_i=
nt_equal(r->netmask, 0xffffff00);
+    assert_int_equal(r->gateway, 0x0a020=
201);
+
+    /* unknown tag and empty list both miss */
+    assert_null(su=
bnet_pool_by_tag(&a, "nope"));
+    assert_null(subnet_pool_by_tag(NULL, "g=
rpA"));
+}
+
+/* a single pool <net>/<mask> with gateway <gw>, checked agai=
nst the
+ * 10=2E8=2E0=2E0/24 --server network */
+static bool
+check_one(i=
n_addr_t net, in_addr_t mask, in_addr_t gw)
+{
+    struct subnet_pool_def =
d =3D { =2Enext =3D NULL, =2Etag =3D "grp", =2Enetwork =3D net, =2Enetmask =
=3D mask, =2Egateway =3D gw };
+
+    return subnet_pools_check(&d, 0x0a080=
000, 0xffffff00, M_WARN);
+}
+
+/* --subnet-pool geometry: anything ifconfi=
g_pool_init() cannot serve must be
+ * refused when the config is checked, =
not when the first client connects */
+static void
+test_subnet_pools_check=
_netmask(void **state)
+{
+    /* the bounds of --server: /16 =2E=2E /29 */=

+    assert_true(check_one(0x0a090000, 0xffff0000, 0x0a090001));
+    asse=
rt_true(check_one(0x0a090000, 0xffffff00, 0x0a090001));
+    assert_true(ch=
eck_one(0x0a090000, 0xfffffff8, 0x0a090001));
+    /* /30, /31, /32: too fe=
w addresses for a pool */
+    assert_false(check_one(0x0a090000, 0xfffffff=
c, 0x0a090001));
+    assert_false(check_one(0x0a090000, 0xfffffffe, 0x0a09=
0001));
+    assert_false(check_one(0x0a090000, 0xffffffff, 0x0a090000));
+=
    /* /15: larger than IFCONFIG_POOL_MAX */
+    assert_false(check_one(0x=
0a080000, 0xfffe0000, 0x0a080001));
+    /* non-contiguous netmask */
+    =
assert_false(check_one(0x0a000900, 0xff00ff00, 0x0a000901));
+}
+
+static v=
oid
+test_subnet_pools_check_gateway(void **state)
+{
+    /* any host addr=
ess of the subnet is fine, not only the first one */
+    assert_true(check=
_one(0x0a090000, 0xffffff00, 0x0a0900fe));
+    assert_true(check_one(0x0a0=
90000, 0xffffff00, 0x0a090080));
+    /* network address, broadcast address=
, outside the subnet */
+    assert_false(check_one(0x0a090000, 0xffffff00,=
 0x0a090000));
+    assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0900=
ff));
+    assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0a0001));
+}
=
+
+/* a 10=2E9=2E0=2E0/24 pool with dynamic range <start>-<end> */
+static =
bool
+check_range(in_addr_t start, in_addr_t end)
+{
+    struct subnet_poo=
l_def d =3D { =2Enext =3D NULL, =2Etag =3D "grp", =2Enetwork =3D 0x0a090000=
, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001, =2Epool_start =3D s=
tart, =2Epool_end =3D end };
+
+    return subnet_pools_check(&d, 0x0a08000=
0, 0xffffff00, M_WARN);
+}
+
+/* the optional dynamic range: host addresses=
 of the subnet, at least 2 */
+static void
+test_subnet_pools_check_range(v=
oid **state)
+{
+    /* unset: the whole subnet */
+    assert_true(check_r=
ange(0, 0));
+    /* a sub-range, the smallest one, the whole host range */=

+    assert_true(check_range(0x0a090064, 0x0a0900c8));
+    assert_true(ch=
eck_range(0x0a090064, 0x0a090065));
+    assert_true(check_range(0x0a090001=
, 0x0a0900fe));
+    /* a single address, or start past end */
+    assert_=
false(check_range(0x0a090064, 0x0a090064));
+    assert_false(check_range(0=
x0a0900c8, 0x0a090064));
+    /* the network or broadcast address */
+    a=
ssert_false(check_range(0x0a090000, 0x0a090064));
+    assert_false(check_r=
ange(0x0a090064, 0x0a0900ff));
+    /* outside the subnet */
+    assert_fa=
lse(check_range(0x0a090064, 0x0a0a0001));
+    assert_false(check_range(0x0=
a080064, 0x0a090064));
+}
+
+static void
+test_subnet_pools_check_overlap(v=
oid **state)
+{
+    struct subnet_pool_def b =3D { =2Enext =3D NULL, =2Eta=
g =3D "grpB", =2Enetwork =3D 0x0a0a0000, =2Enetmask =3D 0xffffff00, =2Egate=
way =3D 0x0a0a0001 };
+    struct subnet_pool_def a =3D { =2Enext =3D &b, =
=2Etag =3D "grpA", =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =
=2Egateway =3D 0x0a090001 };
+
+    /* disjoint pools, disjoint from --serv=
er */
+    assert_true(subnet_pools_check(&a, 0x0a080000, 0xffffff00, M_WAR=
N));
+
+    /* a pool inside the --server network =2E=2E=2E */
+    assert_=
false(subnet_pools_check(&a, 0x0a090000, 0xffffff00, M_WARN));
+    /* =2E=
=2E=2E or covering it */
+    assert_false(subnet_pools_check(&a, 0x0a0a008=
0, 0xffffff80, M_WARN));
+    /* no --server network: only the pools are ch=
ecked against each other */
+    assert_true(subnet_pools_check(&a, 0, 0, M=
_WARN));
+
+    /* a /16 grpB containing grpA */
+    struct subnet_pool_de=
f b16 =3D { =2Enext =3D NULL, =2Etag =3D "grpB", =2Enetwork =3D 0x0a090000,=
 =2Enetmask =3D 0xffff0000, =2Egateway =3D 0x0a090101 };
+    struct subnet=
_pool_def a16 =3D { =2Enext =3D &b16, =2Etag =3D "grpA", =2Enetwork =3D 0x0=
a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001 };
+    asser=
t_false(subnet_pools_check(&a16, 0, 0, M_WARN));
+
+    /* the same tag def=
ined twice */
+    struct subnet_pool_def bdup =3D { =2Enext =3D NULL, =2Et=
ag =3D "grpA", =2Enetwork =3D 0x0a0a0000, =2Enetmask =3D 0xffffff00, =2Egat=
eway =3D 0x0a0a0001 };
+    struct subnet_pool_def adup =3D { =2Enext =3D &=
bdup, =2Etag =3D "grpA", =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff=
00, =2Egateway =3D 0x0a090001 };
+    assert_false(subnet_pools_check(&adup=
, 0, 0, M_WARN));
+}
+
+const struct CMUnitTest subnet_pool_tests[] =3D {
+=
    cmocka_unit_test(test_subnet_pool_by_tag),
+    cmocka_unit_test(test_s=
ubnet_pools_check_netmask),
+    cmocka_unit_test(test_subnet_pools_check_g=
ateway),
+    cmocka_unit_test(test_subnet_pools_check_range),
+    cmocka_=
unit_test(test_subnet_pools_check_overlap),
+};
+
+int
+main(void)
+{
+    =
openvpn_unit_test_setup();
+    return cmocka_run_group_tests(subnet_pool_t=
ests, NULL, NULL);
+}

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1783?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: Ia1e7db95615d99ef9687de7c4e996dc8033e2631
Gerrit-Change-Number: 1783=

Gerrit-PatchSet: 8
Gerrit-Owner: Antonio Quartulli <antonio@mandelbit=2Eco=
m>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Gert Doeri=
ng <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=
=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=
=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--H2lZLn+eeoA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld=2E </p>
<p>Antonio Qu=
artulli <strong>uploaded patch set #8</strong> to this change=2E</p><p><a h=
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
src/openvpn/route=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A test=
s/unit_tests/openvpn/test_subnet_pool=2Ec<br>14 files changed, 753 insertio=
ns(+), 16 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eo=
penvpn=2Enet:29418/openvpn refs/changes/83/1783/8</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMak=
eLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 184a95a=2E=2E26bb9ca =
100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLi=
sts=2Etxt</span><br><span>@@ -696,6 +696,7 @@</span><br><span>         &quo=
t;test_provider&quot;</span><br><span>         &quot;test_socket&quot;</spa=
n><br><span>         &quot;test_ssl&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        &quot;test_subnet_pool&quot;</span><br><span>=
         &quot;test_user_pass&quot;</span><br><span>         &quot;test_pus=
h_update_msg&quot;</span><br><span>         )</span><br><span>@@ -870,6 +87=
1,11 @@</span><br><span>         src/openvpn/session_id=2Ec</span><br><span=
>     )</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    target_sources(test_subnet_pool PRIVATE</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get_ran=
dom=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/=
openvpn/options_util=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span>     target_sources(test_ncp PRIVATE</span><br><span>         s=
rc/openvpn/crypto_epoch=2Ec</span><br><span>         src/openvpn/crypto_mbe=
dtls=2Ec</span><br><span>diff --git a/doc/man-sections/server-options=2Erst=
 b/doc/man-sections/server-options=2Erst</span><br><span>index 9dfa6bd=2E=
=2E9434e5d 100644</span><br><span>--- a/doc/man-sections/server-options=2Er=
st</span><br><span>+++ b/doc/man-sections/server-options=2Erst</span><br><s=
pan>@@ -330,6 +330,48 @@</span><br><span>   by ``--ifconfig``, OpenVPN will=
 install a /32 host route for the ``local``</span><br><span>   IP address=
=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+--subnet-pool args</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+  Define a named pool of addresses from a subnet different from the</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--server`` network, so=
 groups of clients can be given IPs from separate</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  subnets for per-group firewall rules under =
``--topology subnet`` (and</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  therefore DCO)=2E This is a main-config directive and may be repea=
ted to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  define seve=
ral pools=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+  Valid syntax:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     subnet-pool tag network netmask [gateway [start end]]</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+  ``tag`` is a name a client refers to with =
``--subnet-pool-tag``; ``gateway``</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  defaults to the first address of ``network``/``netmask`` a=
nd is never</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  assign=
ed to a client=2E A client assigned to a pool receives (dynamically, or</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  via a static ``--ifco=
nfig-push`` that must lie within the subnet) an address</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  from it, plus the matching netmask=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  Dynamic addresses are taken from ``s=
tart`` to ``end`` (every host address</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+  of the subnet by default)=2E Static ``--ifconfig-push``=
 addresses are not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 reserved in the pool: when mixing static and dynamic clients in one pool,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+  set ``start``/``en=
d`` so that the static addresses fall outside the range=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  Requires ``--server`` with ``--dev tun`` and ``--topo=
logy subnet``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  `=
`netmask`` must be between /16 and /29 (as for ``--server``), ``gateway``</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  must be a host addr=
ess inside the subnet, ``start`` and ``end`` host</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+  addresses inside the subnet with ``start`` =
lower than ``end``, each ``tag``</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  may be defined only once and no pool may overlap another one=
 or the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``--server=
`` network=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  The server routes each =
pool&#39;s subnet into the tun device, as it does for</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  the ``--server`` network; no ``--route`=
` needs to be added for it=2E These</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+  routes honour ``--route-table`` and ``--route-metric``=2E=
 With DCO on Linux</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 and FreeBSD the IPv4 route is installed on-link, without a gateway, so its=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``route_gateway_{=
n}`` is not set for ``--route-up`` scripts=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+--subnet-pool-tag tag</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+  Assign this client to the ``--subnet-pool`` named ``tag``=2E Mus=
t be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  associated wi=
th a specific client instance via ``--client-config-dir`` or</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  ``--client-connect``=2E Several =
clients may reference the same tag and are</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  then served from the same shared pool=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> --ifconfig-=
ipv6-push args</span><br><span>   for ``--client-config-dir`` per-client st=
atic IPv6 interface</span><br><span>   configuration, see ``--client-config=
-dir`` and ``--ifconfig-push`` for</span><br><span>diff --git a/src/openvpn=
/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index e302a81=2E=2Ee8d51=
da 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b=
/src/openvpn/multi=2Ec</span><br><span>@@ -43,6 +43,7 @@</span><br><span> #=
include &quot;auth_token=2Eh&quot;</span><br><span> #include &quot;route=2E=
h&quot;</span><br><span> #include &quot;sid_hash=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_util=2Eh&quot=
;</span><br><span> #include &lt;inttypes=2Eh&gt;</span><br><span> #include =
&lt;string=2Eh&gt;</span><br><span> </span><br><span>@@ -54,6 +55,21 @@</sp=
an><br><span> #include &quot;dco=2Eh&quot;</span><br><span> #include &quot;=
reflect_filter=2Eh&quot;</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Dynamic address pool serving the clients of one --subnet-pool tag=
=2E  Shared</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * by ev=
ery client that references the tag, created at startup by</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * multi_init()=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+struct subnet_pool</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct subnet_pool *next;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const char *tag;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct ifconfig_pool *pool;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static stru=
ct ifconfig_pool *multi_get_group_pool(struct multi_context *m,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
                   const struct options *o, const char *tag);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*#define MULTI=
_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_E=
VENT_LOOP</span><br><span>@@ -371,6 +387,13 @@</span><br><span>         }</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* create every --subnet-pool group up front rather=
 than on first use, so</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * that its pool exists before any client of the group connects */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct=
 subnet_pool_def *d =3D t-&gt;options=2Esubnet_pools; d; d =3D d-&gt;next)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        multi_get_group_pool(m, &a=
mp;t-&gt;options, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>     /*</span><br><span>      * Help us keep track of routing =
table=2E</span><br><span>      */</span><br><span>@@ -625,7 +648,8 @@</span=
><br><span> </span><br><span>         schedule_remove_entry(m-&gt;schedule,=
 (struct schedule_entry *)mi);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        ifconfig_pool_release(m-&gt;ifconfig_poo=
l, mi-&gt;vaddr_handle, false);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_=
pool : m-&gt;ifconfig_pool, mi-&gt;vaddr_handle,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                              false);</span><b=
r><span> </span><br><span>         if (mi-&gt;did_iroutes)</span><br><span>=
         {</span><br><span>@@ -707,6 +731,14 @@</span><br><span>         sc=
hedule_free(m-&gt;schedule);</span><br><span>         mbuf_free(m-&gt;mbuf)=
;</span><br><span>         ifconfig_pool_free(m-&gt;ifconfig_pool);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        while (m-&gt;subnet=
_pools)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct sub=
net_pool *sp =3D m-&gt;subnet_pools;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          m-&gt;subnet_pools =3D sp-&gt;next;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            ifconfig_pool_free(sp-&gt;pool);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            free(sp);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan>         frequency_limit_free(m-&gt;new_connection_limiter);</span><br>=
<span>         initial_rate_limit_free(m-&gt;initial_rate_limiter);</span><=
br><span>         multi_reap_free(m-&gt;reaper);</span><br><span>@@ -1405,6=
 +1437,12 @@</span><br><span>     const struct options *o =3D &amp;c-&gt;op=
tions;</span><br><span>     if (o-&gt;push_ifconfig_constraint_defined &amp=
;&amp; c-&gt;c2=2Epush_ifconfig_defined)</span><br><span>     {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* a subnet-pool client=
 is validated against its own subnet */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (o-&gt;subnet_pool_defined)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return (o-&gt;subnet_pool_netmask =
&amp; c-&gt;c2=2Epush_ifconfig_local)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   =3D=3D o-&gt;subnet_pool_network;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n>         return (o-&gt;push_ifconfig_constraint_netmask &amp; c-&gt;c2=2E=
push_ifconfig_local)</span><br><span>                =3D=3D o-&gt;push_ifco=
nfig_constraint_network;</span><br><span>     }</span><br><span>@@ -1415,6 =
+1453,40 @@</span><br><span> }</span><br><span> </span><br><span> /*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Return the dynamic pool=
 serving the clients tagged with &lt;tag&gt;, creating it</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * from the matching --subnet-pool de=
finition in &lt;o&gt; if it does not exist yet</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * (which only happens when multi_init() creates=
 every pool at startup)=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static st=
ruct ifconfig_pool *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+multi_get_group_pool(struct multi_context *m, const struct options *o, con=
st char *tag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool *=
sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    for (sp =3D m-&gt;subnet_pools;=
 sp; sp =3D sp-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!strcmp(sp-&gt;tag, tag))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           return sp-&gt;pool;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_pool_def=
 *d4 =3D subnet_pool_by_tag(o-&gt;subnet_pools, tag);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(d4);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(sp, struct subnet_pool);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sp-&gt;tag =3D d=
4-&gt;tag;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* th=
e configured dynamic range, or else every host address of the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * subnet, minus the gateway =
reserved below if it falls inside it */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const in_addr_t start =3D d4-&gt;pool_start ? d4-&g=
t;pool_start : d4-&gt;network + 1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const in_addr_t end =3D d4-&gt;pool_end ? d4-&gt;pool_en=
d : (d4-&gt;network | ~d4-&gt;netmask) - 1;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    sp-&gt;pool =3D ifconfig_pool_init(true, IFCONF=
IG_POOL_INDIV, start, end, o-&gt;duplicate_cn, false,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                  in6addr=
_any, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconf=
ig_pool_reserve_ip(sp-&gt;pool, d4-&gt;gateway);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    sp-&gt;next =3D m-&gt;subnet_pools;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;subnet_pools =3D=
 sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sp-&=
gt;pool;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span>  * Select a virtual address =
for a new client instance=2E</span><br><span>  * Use an --ifconfig-push dir=
ective, if given (static IP)=2E</span><br><span>  * Otherwise use an --ifco=
nfig-pool address (dynamic IP)=2E</span><br><span>@@ -1424,6 +1496,25 @@</s=
pan><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 resolve --subnet-pool-tag against the main-config --subnet-pool list (an</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * unknown tag is=
 rejected with AUTH_FAILED in multi_connection_established)=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * This runs again after eve=
ry client-connect handler, and a later handler</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * (script, plugin, management) may override=
 the tag set by the CCD file,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * so always resolve the current tag=2E */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esub=
net_pool_tag)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct=
 subnet_pool_def *d =3D</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&=
gt;context=2Eoptions=2Esubnet_pool_tag);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        mi-&gt;context=2Eoptions=2Esubnet_pool_defined =3D d !=3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (d)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=
=2Esubnet_pool_network =3D d-&gt;network;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_ne=
tmask =3D d-&gt;netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_gateway =3D d-&gt;g=
ateway;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><=
span>      * If ifconfig addresses were set by dynamic config file,</span><=
br><span>      * release pool addresses, otherwise keep them=2E</span><br><=
span>@@ -1434,8 +1525,10 @@</span><br><span>          * release dynamic all=
ocation */</span><br><span>         if (mi-&gt;vaddr_handle &gt;=3D 0)</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            ifconfig_pool_release(m-&gt;ifconfig_pool, mi-&gt;vaddr_handle=
, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&gt;vaddr_pool : m-&gt;ifconf=
ig_pool,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                       mi-&gt;vaddr_handle, true);</span><br><span>        =
     mi-&gt;vaddr_handle =3D -1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            mi-&gt;vaddr_pool =3D NULL;</span><br><span>      =
   }</span><br><span> </span><br><span>         mi-&gt;context=2Ec2=2Epush_=
ifconfig_defined =3D true;</span><br><span>@@ -1455,6 +1548,52 @@</span><br=
><span>                 &quot;MULTI_sva: WARNING: if --ifconfig-push is use=
d for IPv4, automatic IPv6 assignment from --ifconfig-ipv6-pool does not wo=
rk=2E  Use --ifconfig-ipv6-push for IPv6 then=2E&quot;);</span><br><span>  =
       }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    else if (mi-&gt;context=2Eoptions=2Esubnet_pool_defined)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* dynamic address from this=
 client&#39;s --subnet-pool group */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        struct ifconfig_pool *group =3D</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            multi_get_group_pool(m, &a=
mp;m-&gt;top=2Eoptions, mi-&gt;context=2Eoptions=2Esubnet_pool_tag);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* the address may have been acquired=
 before the tag was known (from</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+         * the global pool) or for a tag that a later handler o=
verrode: drop</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
   * it so we serve this client from its current group */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;vaddr_handle &gt;=
=3D 0 &amp;&amp; mi-&gt;vaddr_pool !=3D group)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            ifconfig_pool_release(mi-&gt;vaddr_pool ? mi-&=
gt;vaddr_pool : m-&gt;ifconfig_pool,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                  mi-&gt;vaddr_handle, tru=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&=
gt;vaddr_handle =3D -1;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            mi-&gt;vaddr_pool =3D NULL;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* both addresses of the dropped slot g=
o back to its pool */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;context=
=2Ec2=2Epush_ifconfig_ipv6_defined =3D false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (mi-&gt;vaddr_handle &lt; 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            in_addr_t local =3D 0, remote =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            const char *cn =3D NULL;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!mi-&gt;context=2Eoptions=
=2Eduplicate_cn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       cn =3D tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, true);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_pool =3D group;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            mi-&gt;vaddr_hand=
le =3D ifconfig_pool_acquire(mi-&gt;vaddr_pool, &amp;local, &amp;remote, NU=
LL, cn);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (mi-&gt;vaddr_handle &gt;=3D 0)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_local =3D rem=
ote;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 mi-&gt;context=2Ec2=2Epush_ifconfig_remote_netmask =3D</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    mi-&gt;context=2Eop=
tions=2Esubnet_pool_netmask;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                mi-&gt;context=2Ec2=2Epush_ifconfig_defined =3D tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                msg(D_MULTI_ERR=
ORS, &quot;MULTI: no free --subnet-pool addresses are available for %s&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   multi_instance_string(mi, false, &amp;gc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span>     else if (m-&gt;ifconfig_pool &amp;&am=
p; mi-&gt;vaddr_handle &lt; 0) /* otherwise, choose a pool address */</span=
><br><span>     {</span><br><span>         in_addr_t local =3D 0, remote =
=3D 0;</span><br><span>@@ -2360,10 +2499,9 @@</span><br><span>         cons=
t char *ifconfig_constraint_netmask =3D</span><br><span>             print_=
in_addr_t(mi-&gt;context=2Eoptions=2Epush_ifconfig_constraint_netmask, 0, &=
amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /* JYFIXME -- this should cause the connection to fail */</spa=
n><br><span>         msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            &quot;MULTI ERROR: primary virtual IP for %s=
 (%s) &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   &quot;violates tunnel network/netmask constraint (%s/%s)&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;WARNING: p=
rimary virtual IP for %s (%s) &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;violates tunnel network/netmask constrai=
nt (%s/%s) and may not work&quot;,</span><br><span>             multi_insta=
nce_string(mi, false, &amp;gc),</span><br><span>             print_in_addr_=
t(mi-&gt;context=2Ec2=2Epush_ifconfig_local, 0, &amp;gc),</span><br><span> =
            ifconfig_constraint_network, ifconfig_constraint_netmask);</spa=
n><br><span>@@ -2471,6 +2609,7 @@</span><br><span> </span><br><span>     /*=
 reset pool handle to null */</span><br><span>     mi-&gt;vaddr_handle =3D =
-1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;vaddr=
_pool =3D NULL;</span><br><span> </span><br><span>     /* do --client-conne=
ct setenvs */</span><br><span>     multi_select_virtual_addr(m, mi);</span>=
<br><span>@@ -2792,6 +2931,15 @@</span><br><span>         cc_succeeded =3D =
false;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Eoptions=2Esubnet_pool_=
tag</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&am=
p; !subnet_pool_by_tag(m-&gt;top=2Eoptions=2Esubnet_pools, mi-&gt;context=
=2Eoptions=2Esubnet_pool_tag))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(D_MULTI_ERRORS, &quot;MULTI: client has been rejected due to unkno=
wn --subnet-pool-tag &#39;%s&#39;&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mi-&gt;context=2Eoptions=2Esubnet_pool_tag=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        auth_set_=
client_reason(mi-&gt;context=2Ec2=2Etls_multi, &quot;unknown subnet-pool-ta=
g&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cc=
_succeeded =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     if (cc_succeeded)</span><br><span>     {</span><br><span>        =
 multi_client_connect_late_setup(m, mi, *option_types_found);</span><br><sp=
an>diff --git a/src/openvpn/multi=2Eh b/src/openvpn/multi=2Eh</span><br><sp=
an>index 5db7147=2E=2E14f71dd 100644</span><br><span>--- a/src/openvpn/mult=
i=2Eh</span><br><span>+++ b/src/openvpn/multi=2Eh</span><br><span>@@ -121,6=
 +121,8 @@</span><br><span>     struct mroute_addr real; /**&lt; External n=
etwork address of the</span><br><span>                               *   re=
mote peer=2E */</span><br><span>     ifconfig_pool_handle vaddr_handle;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* pool vaddr_handl=
e belongs to (NULL =3D the global one) */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct ifconfig_pool *vaddr_pool;</span><br><span=
>     char msg_prefix[MULTI_PREFIX_MAX_LENGTH];</span><br><span> </span><br=
><span>     /* queued outgoing data in Server/TCP mode */</span><br><span>@=
@ -190,6 +192,8 @@</span><br><span>                                        =
 *   instances=2E */</span><br><span>     struct multi_io *multi_io;       =
  /**&lt; I/O state and events tracker */</span><br><span>     struct ifcon=
fig_pool *ifconfig_pool;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* per-group --subnet-pool dynamic pools */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool *subnet_pools;</sp=
an><br><span>     struct frequency_limit *new_connection_limiter;</span><br=
><span>     struct initial_packet_rate_limit *initial_rate_limiter;</span><=
br><span>     struct mroute_helper *route_helper;</span><br><span>diff --gi=
t a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index=
 8e0c602=2E=2Eeb0bcfd 100644</span><br><span>--- a/src/openvpn/options=2Ec<=
/span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -453,6 +45=
3,12 @@</span><br><span>     &quot;                  If seconds=3D0, file w=
ill be treated as read-only=2E\n&quot;</span><br><span>     &quot;--ifconfi=
g-ipv6-pool base-IP/bits : set aside an IPv6 network block\n&quot;</span><b=
r><span>     &quot;                  to be dynamically allocated to connect=
ing clients=2E\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    &quot;--subnet-pool tag network netmask [gateway [start end]] : Defi=
ne a named\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   &quot;                  pool of addresses outside the --server network, =
selected\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 &quot;                  per client with --subnet-pool-tag=2E start/end res=
trict the\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &quot;                  dynamically assigned range=2E\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;--subnet-pool-tag tag=
 : Assign this client to the --subnet-pool named tag=2E\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    &quot;                  Onl=
y valid in a client-specific config file=2E\n&quot;</span><br><span>     &q=
uot;--ifconfig-push local remote-netmask : Push an ifconfig option to remot=
e,\n&quot;</span><br><span>     &quot;                  overrides --ifconfi=
g-pool dynamic allocation=2E\n&quot;</span><br><span>     &quot;           =
       Only valid in a client-specific config file=2E\n&quot;</span><br><sp=
an>@@ -1899,6 +1905,20 @@</span><br><span>         {</span><br><span>      =
       msg(M_USAGE, &quot;--ifconfig-ipv6-pool needs --ifconfig-ipv6&quot;)=
;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (options-&gt;subnet_pools)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (!options-&gt;server_defined)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                msg(M_USAGE, &quot;--su=
bnet-pool requires --server&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            if (dev_type_enum(options-&gt;dev, options-&gt;dev_ty=
pe) !=3D DEV_TYPE_TUN</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                || options-&gt;topology !=3D TOP_SUBNET)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(M_USAGE, &quot;--subn=
et-pool requires --dev tun and --topology subnet&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            subnet_pools_check(options-&gt;s=
ubnet_pools, options-&gt;server_network,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                               options-&gt;server_netm=
ask, M_USAGE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>         MUST_BE_UNDEF(allow_recursive_routing, &quot;=
allow-recursive-routing&quot;);</span><br><span>         if (options-&gt;au=
th_user_pass_file)</span><br><span>         {</span><br><span>@@ -1965,6 +1=
985,7 @@</span><br><span>         MUST_BE_UNDEF(ifconfig_pool_defined, &quo=
t;ifconfig-pool&quot;);</span><br><span>         MUST_BE_UNDEF(ifconfig_poo=
l_persist_filename, &quot;ifconfig-pool-persist&quot;);</span><br><span>   =
      MUST_BE_UNDEF(ifconfig_ipv6_pool_defined, &quot;ifconfig-ipv6-pool&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MUST_B=
E_UNDEF(subnet_pools, &quot;subnet-pool&quot;);</span><br><span>         MU=
ST_BE_UNDEF(real_hash_size, &quot;hash-size&quot;);</span><br><span>       =
  MUST_BE_UNDEF(virtual_hash_size, &quot;hash-size&quot;);</span><br><span>=
         MUST_BE_UNDEF(learn_address_script, &quot;learn-address&quot;);</s=
pan><br><span>@@ -3097,6 +3118,28 @@</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The server&#=
39;s tun device is only configured with the --server network, so</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * route each --subnet-pool ne=
twork into it as well: without this the server</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * could not reach its subnet-pool clients when =
the data channel runs in</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * userspace=2E  Under DCO on Linux and FreeBSD the routes are install=
ed on-link,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * see s=
ubnet_pool_routes_onlink()=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+options_postpr=
ocess_subnet_pool_routes(struct options *o)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    for (const struct subnet_pool_def *d =3D o-&gt;subnet_pools; d; d=
 =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ro=
ute_option *ro;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        rol_check_alloc=
(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ro =3D =
add_route_to_option_list(o-&gt;routes, print_in_addr_t(d-&gt;network, 0, &a=
mp;o-&gt;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                print_in_addr_t(d-&gt;netmask, 0, &amp;o-&g=
t;gc), NULL, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                     o-&gt;route_default_table_id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ro-&gt;on_link =3D =
subnet_pool_routes_onlink(o);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stat=
ic void</span><br><span> options_postprocess_mutate(struct options *o, stru=
ct env_set *es)</span><br><span> {</span><br><span>@@ -3232,6 +3275,12 @@</=
span><br><span>         /* check if any option should force disabling DCO *=
/</span><br><span>         o-&gt;disable_dco =3D !dco_check_option(D_DCO, o=
) || !dco_check_startup_option(D_DCO, o);</span><br><span>     }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (o-&gt;mode =3D=3D MODE_SERVER)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* how the pools are routed depends =
on the DCO decision above */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options_postprocess_subnet_pool_routes(o);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #ifdef USE_C=
OMP</span><br><span>     if (dco_enabled(o))</span><br><span>     {</span><=
br><span>@@ -6219,6 +6268,57 @@</span><br><span>             goto err;</spa=
n><br><span>         }</span><br><span>     }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;subnet-pool&quot;)=
 &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; (!p[5] || p[6])=
 &amp;&amp; !p[7])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
subnet_pool_def *sp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        in_addr_t network, netmask;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        network =3D getaddr(GETADDR_HOST_ORDER | GETADD=
R_RESOLVE, p[2], 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        netmask =3D getaddr(GETADDR_HOST_ORDER, p[3], 0, NULL,=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!network || !netmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    msg(msglevel, &quot;cannot parse --subnet-pool addresses&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ALLOC_OBJ_CLEAR_GC(sp, str=
uct subnet_pool_def, &amp;options-&gt;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        sp-&gt;tag =3D p[1];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        sp-&gt;network =3D network &amp; =
netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sp-=
&gt;netmask =3D netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        sp-&gt;gateway =3D (network &amp; netmask) + 1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (p[4])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            bool ok =3D false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            sp-&gt;gateway =3D getaddr(GETADDR_HOST_OR=
DER | GETADDR_RESOLVE, p[4], 0, &amp;ok, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (!ok)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                msg(msglevel, &quot;cannot parse --s=
ubnet-pool gateway&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* optional range of the dynamic pool, validated in</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * subnet_pools_check(); unset=
, it spans the whole subnet */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (p[5])</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           bool ok_start =3D false, ok_end =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            sp-&gt;pool_start =3D getaddr(GETADDR_HOST_ORDER=
, p[5], 0, &amp;ok_start, NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            sp-&gt;pool_end =3D getaddr(GETADDR_HOST_ORDER, p[=
6], 0, &amp;ok_end, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (!ok_start || !ok_end)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                msg(msglevel, &quot;cannot parse --subne=
t-pool range&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                goto err;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
p-&gt;next =3D options-&gt;subnet_pools;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        options-&gt;subnet_pools =3D sp;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;subnet-pool-tag&=
quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        VERIFY_PERMISSION(OPT_P_INSTANCE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        options-&gt;subnet_pool_tag =3D p[1];=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an>     else if (streq(p[0], &quot;ifconfig-push-constraint&quot;) &amp;&am=
p; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</span><br>=
<span>         in_addr_t network, netmask;</span><br><span>diff --git a/src=
/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>index c58530=
a=2E=2E568bae6 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><=
br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -252,6 +252,21 @@=
</span><br><span>     struct verify_hash_list *next;</span><br><span> };</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A=
 named --subnet-pool: a subnet clients can be assigned from, referenced</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from a CCD file by i=
ts tag via --subnet-pool-tag=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+struct subnet_pool_def</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct subnet_pool_def *next;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    const char *tag;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    in_addr_t network;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    in_addr_t netmask;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    in_addr_t gateway;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* optional range of the dynamic pool (0/0: eve=
ry host address of the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * subnet); addresses outside it are left for static --ifconfig-push=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t po=
ol_start;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_add=
r_t pool_end;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Co=
mmand line options */</span><br><span> struct options</span><br><span> {</s=
pan><br><span>@@ -518,6 +533,12 @@</span><br><span>     bool push_ifconfig_=
constraint_defined;</span><br><span>     in_addr_t push_ifconfig_constraint=
_network;</span><br><span>     in_addr_t push_ifconfig_constraint_netmask;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_po=
ol_def *subnet_pools; /* named pools (server config) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const char *subnet_pool_tag;       =
   /* which pool this client uses (CCD) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool subnet_pool_defined;             /* resolve=
d from the tag at connect */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    in_addr_t subnet_pool_network;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    in_addr_t subnet_pool_netmask;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t subnet_pool_gateway;</=
span><br><span>     bool push_ifconfig_ipv4_blocked;           /* IPv4 */</=
span><br><span>     bool push_ifconfig_ipv6_defined;           /* IPv6 */</=
span><br><span>     struct in6_addr push_ifconfig_ipv6_local;  /* IPv6 */</=
span><br><span>@@ -979,4 +1000,23 @@</span><br><span> #endif /* ENABLE_DCO =
*/</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Whether the routes of the --subnet-pool networks are installed on-li=
nk on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the DCO dev=
ice rather than via a gateway=2E  With DCO on Linux and FreeBSD the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * kernel selects the peer =
by a route&#39;s next hop, so a route via a gateway</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * would deliver every packet for an unas=
signed pool address to the client</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * owning that gateway address; on-link, such a packet matche=
s no peer, while</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
each pool client gets its own on-link host route when it connects (see</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * multi_learn_in_addr_t=
())=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+subnet_pool_routes_onlink(cons=
t struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGE=
T_LINUX) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return dco_enabled(o);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif=
 /* ifndef OPTIONS_H */</span><br><span>diff --git a/src/openvpn/options_ut=
il=2Ec b/src/openvpn/options_util=2Ec</span><br><span>index d25d85c=2E=2E86=
2bf7c 100644</span><br><span>--- a/src/openvpn/options_util=2Ec</span><br><=
span>+++ b/src/openvpn/options_util=2Ec</span><br><span>@@ -30,6 +30,105 @@=
</span><br><span> #include &quot;options_util=2Eh&quot;</span><br><span> </=
span><br><span> #include &quot;push=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;pool=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+const struct subnet_pool_def *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+subnet_pool_by_tag(const struct subnet_pool_def=
 *pools, const char *tag)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (con=
st struct subnet_pool_def *d =3D pools; d; d =3D d-&gt;next)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (!strcmp(d-&gt;tag, tag))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return d;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return NULL;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* true if the two IPv4 subn=
ets share at least one address */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+subnets_overlap(in_addr_t a, in_addr_t mask_a, in_addr_t b, in_addr_t=
 mask_b)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const in_addr_t mask =3D =
mask_a &amp; mask_b;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (a &amp=
; mask) =3D=3D (b &amp; mask);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+subnet_pools_check(const struct subnet_po=
ol_def *pools, in_addr_t server_network,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                   in_addr_t server_netmask, msglvl_t =
msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct subnet=
_pool_def *d =3D pools; d; d =3D d-&gt;next)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const in_addr_t host =3D ~d-&gt;netmask;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        int netbits =3D 32;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* the netmask must be contiguous */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (host &amp=
; (host + 1))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
msglevel, &quot;--subnet-pool %s: invalid netmask&quot;, d-&gt;tag);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        for (in_addr_t h =3D h=
ost; h; h &gt;&gt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       netbits--;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* same bounds as --ser=
ver: the pool must hold at least 2 addresses</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+         * besides network, gateway and broadcast,=
 and fit IFCONFIG_POOL_MAX */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (netbits &lt; IFCONFIG_POOL_MIN_NETBITS || netbits &gt=
; 29)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel=
, &quot;--subnet-pool %s: netmask must be between /%d and /29 (not /%d)&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
d-&gt;tag, IFCONFIG_POOL_MIN_NETBITS, netbits);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if ((d-&gt;gateway &amp; d-&gt;netmask) !=3D d-&gt;network || =
d-&gt;gateway =3D=3D d-&gt;network</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            || d-&gt;gateway =3D=3D (d-&gt;network | host))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quo=
t;--subnet-pool %s: gateway must be a host address inside the subnet&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                d-&=
gt;tag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        /* an explicit dynamic ran=
ge must be made of host addresses of the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+         * subnet and hold at least the 2 entries an i=
fconfig pool needs */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if ((d-&gt;pool_start || d-&gt;pool_end)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &amp;&amp; ((d-&gt;pool_start &a=
mp; d-&gt;netmask) !=3D d-&gt;network</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                || (d-&gt;pool_end &amp; d-&gt;netmask) !=
=3D d-&gt;network || d-&gt;pool_start =3D=3D d-&gt;network</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                || d-&gt;pool_end =
=3D=3D (d-&gt;network | host) || d-&gt;pool_start &gt;=3D d-&gt;pool_end))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;--=
subnet-pool %s: range start and end must be host addresses inside the &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                &q=
uot;subnet, with start lower than end&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                d-&gt;tag);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (server_netmask</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &amp;&amp; subnets_overlap(d-&gt;network, d-&=
gt;netmask, server_network, server_netmask))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            msg(msglevel, &quot;--subnet-pool %s: subnet ove=
rlaps the --server network&quot;, d-&gt;tag);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        for (const struct subnet_pool_def *e =3D d-&gt;next; e; e =3D =
e-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!s=
trcmp(d-&gt;tag, e-&gt;tag))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                msg(msglevel, &quot;--subnet-pool %s: tag defined more t=
han once&quot;, d-&gt;tag);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (subnets_overlap(d-&gt;network, d-&gt;netmask, e=
-&gt;network, e-&gt;netmask))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                msg(msglevel, &quot;--subnet-pool %s and %s: subnets ov=
erlap&quot;, d-&gt;tag, e-&gt;tag);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span>=
<br><span> const char *</span><br><span> parse_auth_failed_temp(struct opti=
ons *o, const char *reason)</span><br><span>diff --git a/src/openvpn/option=
s_util=2Eh b/src/openvpn/options_util=2Eh</span><br><span>index 5226a6f=2E=
=2Ef1e63e15 100644</span><br><span>--- a/src/openvpn/options_util=2Eh</span=
><br><span>+++ b/src/openvpn/options_util=2Eh</span><br><span>@@ -28,6 +28,=
33 @@</span><br><span> </span><br><span> const char *parse_auth_failed_temp=
(struct options *o, const char *reason);</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Look up a named --subnet-pool in a list of pool d=
efinitions=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pools  head o=
f the --subnet-pool list (may be NULL)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param tag    the --subnet-pool-tag to match</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @return       the matchin=
g pool definition, or NULL if none matches</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+const struct subnet_pool_def *subnet_pool_by_tag(const struct subnet=
_pool_def *pools,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                               const char *tag);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Validate the --subnet-pool definitions: contiguous netmask bet=
ween</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * /IFCONFIG_PO=
OL_MIN_NETBITS and /29, gateway a host address inside its</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * subnet, an explicit dynamic range =
made of at least 2 host addresses of the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * subnet,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * unique tags, and no subnet overlapping another pool or the -=
-server</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * network=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param pools           head of=
 the --subnet-pool list (may be NULL)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param server_network  the --server network (host orde=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param server_=
netmask  the --server netmask, or 0 if there is none</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel        level of the me=
ssage logged on the first error</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @return                true if every definition is valid</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool subnet_pools_check(const struct su=
bnet_pool_def *pools, in_addr_t server_network,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        in_addr_t server_netmas=
k, msglvl_t msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> </span><br><span> /** Checks if the string is a valid =
integer by checking if it can be</span><br><span>  *  converted to an integ=
er */</span><br><span>diff --git a/src/openvpn/pool=2Ec b/src/openvpn/pool=
=2Ec</span><br><span>index fff0e3f=2E=2E5c5b3fe 100644</span><br><span>--- =
a/src/openvpn/pool=2Ec</span><br><span>+++ b/src/openvpn/pool=2Ec</span><br=
><span>@@ -351,7 +351,7 @@</span><br><span> {</span><br><span>     bool ret=
 =3D false;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (pool &amp;&amp; hand &gt;=3D 0 &amp;&amp; hand &lt; pool-&g=
t;size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pool=
 &amp;&amp; hand &gt;=3D 0 &amp;&amp; hand &lt; pool-&gt;size &amp;&amp; !p=
ool-&gt;list[hand]=2Ereserved)</span><br><span>     {</span><br><span>     =
    ifconfig_pool_entry_free(&amp;pool-&gt;list[hand], hard);</span><br><sp=
an>         ret =3D true;</span><br><span>@@ -430,6 +430,22 @@</span><br><s=
pan>     return ret;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ifconfig_pool_reserve_ip(struct ifconfig_pool *pool,=
 const in_addr_t addr)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ifcon=
fig_pool_handle h =3D ifconfig_pool_ip_base_to_handle(pool, addr);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (h &lt; 0)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ifconfig_pool_e=
ntry_free(&amp;pool-&gt;list[h], true);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    pool-&gt;list[h]=2Ein_use =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    pool-&gt;list[h]=2Ereserved =3D=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static in_addr_t=
</span><br><span> ifconfig_pool_handle_to_ip_base(const struct ifconfig_poo=
l *pool, ifconfig_pool_handle hand)</span><br><span> {</span><br><span>@@ -=
477,6 +493,13 @@</span><br><span>                   const bool fixed)</span=
><br><span> {</span><br><span>     struct ifconfig_pool_entry *e =3D &amp;p=
ool-&gt;list[h];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (e-&gt;reserved=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;pool: =
ignoring persisted entry for CN=3D%s: its address is reserved&quot;, cn);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ifconfig_pool_ent=
ry_free(e, true);</span><br><span>     e-&gt;in_use =3D false;</span><br><s=
pan>     e-&gt;common_name =3D string_alloc(cn, NULL);</span><br><span>diff=
 --git a/src/openvpn/pool=2Eh b/src/openvpn/pool=2Eh</span><br><span>index =
e2d3f82=2E=2E497dcda 100644</span><br><span>--- a/src/openvpn/pool=2Eh</spa=
n><br><span>+++ b/src/openvpn/pool=2Eh</span><br><span>@@ -43,6 +43,7 @@</s=
pan><br><span>     char *common_name;</span><br><span>     time_t last_rele=
ase;</span><br><span>     bool fixed;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool reserved; /* never handed out, e=2Eg=2E a --subn=
et-pool gateway */</span><br><span> };</span><br><span> </span><br><span> s=
truct ifconfig_pool</span><br><span>@@ -86,6 +87,17 @@</span><br><span> </s=
pan><br><span> bool ifconfig_pool_release(struct ifconfig_pool *pool, ifcon=
fig_pool_handle hand, const bool hard);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Permanently reserve the pool slot holding \c addr,=
 so that it is never</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * handed out to a client nor taken over by a persisted entry (e=2Eg=2E th=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * gateway of a --=
subnet-pool)=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param pool  the p=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param addr  =
IPv4 address (host order) to reserve</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return      true if \c addr lies in the pool and was r=
eserved</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+bool ifconfig_pool_reserve_i=
p(struct ifconfig_pool *pool, in_addr_t addr);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> struct ifconfig_pool_persist *=
ifconfig_pool_persist_init(const char *filename, int refresh_freq);</span><=
br><span> </span><br><span> void ifconfig_pool_persist_close(struct ifconfi=
g_pool_persist *persist);</span><br><span>diff --git a/src/openvpn/route=2E=
c b/src/openvpn/route=2Ec</span><br><span>index 0bce966=2E=2Efecef7e 100644=
</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/open=
vpn/route=2Ec</span><br><span>@@ -408,6 +408,11 @@</span><br><span>        =
 r-&gt;flags |=3D RT_METRIC_DEFINED;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ro-&gt;on=
_link)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        r-&gt;flags |=3D RT=
_ON_LINK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     r-=
&gt;flags |=3D RT_DEFINED;</span><br><span> </span><br><span>     /* routin=
g table id */</span><br><span>@@ -478,12 +483,12 @@</span><br><span>     re=
turn false;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct route_option *</span><br><span> add_route_to_option_list=
(struct route_option_list *l, const char *network, const char *netmask,</sp=
an><br><span>                          const char *gateway, const char *met=
ric, int table_id)</span><br><span> {</span><br><span>     struct route_opt=
ion *ro;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ=
_GC(ro, struct route_option, l-&gt;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(ro, struct route_option, l-&gt;g=
c);</span><br><span>     ro-&gt;network =3D network;</span><br><span>     r=
o-&gt;netmask =3D netmask;</span><br><span>     ro-&gt;gateway =3D gateway;=
</span><br><span>@@ -491,6 +496,7 @@</span><br><span>     ro-&gt;table_id =
=3D table_id;</span><br><span>     ro-&gt;next =3D l-&gt;routes;</span><br>=
<span>     l-&gt;routes =3D ro;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ro;</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span>@@ -1322,7 +1328,11 @@</span><br><span>     {</s=
pan><br><span>         setenv_route_addr(es, &quot;network&quot;, r-&gt;net=
work, i);</span><br><span>         setenv_route_addr(es, &quot;netmask&quot=
;, r-&gt;netmask, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        setenv_route_addr(es, &quot;gateway&quot;, r-&gt;gateway, i);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* an on-link rou=
te has no gateway */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!(r-&gt;flags &amp; RT_ON_LINK))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            setenv_route_addr(es, &quot;gateway&quot;, r-&g=
t;gateway, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span> </span><br><span>         if (r-&gt;flags &amp; RT_ME=
TRIC_DEFINED)</span><br><span>         {</span><br><span>@@ -1478,6 +1488,7=
 @@</span><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><br>=
<span>     const char *iface =3D NULL;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const in_addr_t *gateway =3D &amp;r-&gt;gateway;</sp=
an><br><span>     int metric =3D -1;</span><br><span> </span><br><span>    =
 if (is_on_link(is_local_route, flags, rgi))</span><br><span>@@ -1485,6 +14=
96,12 @@</span><br><span>         iface =3D rgi-&gt;iface;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        gateway =3D NULL;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        iface =3D tt-&gt;actual_name;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (r-&gt;flags &a=
mp; RT_METRIC_DEFINED)</span><br><span>     {</span><br><span>         metr=
ic =3D r-&gt;metric;</span><br><span>@@ -1492,8 +1509,8 @@</span><br><span>=
 </span><br><span> </span><br><span>     status =3D RTA_SUCCESS;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D net_route_v4_add=
(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &amp;r-&gt;ga=
teway,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
                iface, r-&gt;table_id, metric);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int ret =3D net_route_v4_add(ctx, &amp;r-&g=
t;network, netmask_to_netbits2(r-&gt;netmask), gateway, iface,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                               r=
-&gt;table_id, metric);</span><br><span>     if (ret =3D=3D -EEXIST)</span>=
<br><span>     {</span><br><span>         msg(D_ROUTE, &quot;NOTE: Linux ro=
ute add command failed because route exists&quot;);</span><br><span>@@ -161=
6,7 +1633,15 @@</span><br><span>     }</span><br><span> #endif</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf_=
cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gateway, netmask);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp=
; RT_ON_LINK) &amp;&amp; tt)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   argv_printf_cat(&amp;argv, &quot;-net %s/%d -iface %s&quot;, network, ne=
tmask_to_netbits2(r-&gt;netmask),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        tt-&gt;actual_name);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        argv_printf_cat(&amp;argv, &quot;-net %s %s %s&quot;, network, gate=
way, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span> </span><br><span>     /* FIXME -- add on-link support for=
 FreeBSD */</span><br><span> </span><br><span>@@ -2035,7 +2060,16 @@</span>=
<br><span>         metric =3D r-&gt;metric;</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (net_=
route_v4_del(ctx, &amp;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), &=
amp;r-&gt;gateway, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const in_addr_t *gateway =3D &amp;r-&gt;gateway;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *iface =3D NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;=
&amp; tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        gateway =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        iface =3D =
tt-&gt;actual_name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (net_route_v4_del(ctx, &am=
p;r-&gt;network, netmask_to_netbits2(r-&gt;netmask), gateway, iface,</span>=
<br><span>                          r-&gt;table_id, metric)</span><br><span=
>         &lt; 0)</span><br><span>     {</span><br><span>@@ -2091,7 +2125,1=
5 @@</span><br><span> </span><br><span> #elif defined(TARGET_FREEBSD)</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_=
printf(&amp;argv, &quot;%s delete -net %s %s %s&quot;, ROUTE_PATH, network,=
 gateway, netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if ((r-&gt;flags &amp; RT_ON_LINK) &amp;&amp; tt)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s delete -net %s/=
%d -iface %s&quot;, ROUTE_PATH, network,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    netmask_to_netbits2(r-&gt;netmask)=
, tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot=
;%s delete -net %s %s %s&quot;, ROUTE_PATH, network, gateway, netmask);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> =
</span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><span>     op=
envpn_execve_check(&amp;argv, es, 0, &quot;ERROR: FreeBSD route delete comm=
and failed&quot;);</span><br><span>diff --git a/src/openvpn/route=2Eh b/src=
/openvpn/route=2Eh</span><br><span>index 0d33d36=2E=2E7c5528f 100644</span>=
<br><span>--- a/src/openvpn/route=2Eh</span><br><span>+++ b/src/openvpn/rou=
te=2Eh</span><br><span>@@ -80,6 +80,10 @@</span><br><span>     const char *=
gateway;</span><br><span>     int table_id;</span><br><span>     const char=
 *metric;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* on =
Linux and FreeBSD, install the route on-link on the tun device</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * instead of via the gatewa=
y (needed under DCO, where the kernel selects</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * the peer by the route&#39;s next hop) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool on_link;</sp=
an><br><span> };</span><br><span> </span><br><span> /* redirect-gateway fla=
gs */</span><br><span>@@ -120,6 +124,7 @@</span><br><span> #define RT_DEFIN=
ED        (1u &lt;&lt; 0)</span><br><span> #define RT_ADDED          (1u &l=
t;&lt; 1)</span><br><span> #define RT_METRIC_DEFINED (1u &lt;&lt; 2)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define RT_ON_LINK        =
(1u &lt;&lt; 3) /* see struct route_option=2Eon_link */</span><br><span>   =
  struct route_ipv4 *next;</span><br><span>     unsigned int flags;</span><=
br><span>     const struct route_option *option;</span><br><span>@@ -311,8 =
+316,9 @@</span><br><span>                const struct route_gateway_info *=
rgi, const struct env_set *es,</span><br><span>                openvpn_net_=
ctx_t *ctx);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-void add_route_to_option_list(struct route_option_list *l, const c=
har *network, const char *netmask,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                              const char *gateway, const char =
*metric, int table_id);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+struct route_option *add_route_to_option_list(struct route_option_list =
*l, const char *network,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                              const char *netmask, con=
st char *gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                                            const char *metric, int table_i=
d);</span><br><span> </span><br><span> void add_route_ipv6_to_option_list(s=
truct route_ipv6_option_list *l, const char *prefix,</span><br><span>      =
                              const char *gateway, const char *metric, int =
table_id);</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefile=
=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index 43a674=
3=2E=2Eea4c395 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefi=
le=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span>=
<br><span>@@ -21,6 +21,7 @@</span><br><span> 	push_update_msg_testdriver \<=
/span><br><span> 	socket_testdriver \</span><br><span> 	ssl_testdriver \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	subnet_pool_testdrive=
r \</span><br><span> 	user_pass_testdriver</span><br><span> </span><br><spa=
n> if HAVE_LD_WRAP_SUPPORT</span><br><span>@@ -384,6 +385,19 @@</span><br><=
span> 	$(top_srcdir)/src/openvpn/platform=2Ec \</span><br><span> 	$(top_src=
dir)/src/openvpn/mbuf=2Ec</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+subnet_pool_testdriver_CFLAGS  =3D \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_s=
rcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+subnet_pool_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+subnet_pool_testdriver_SOURCES =3D test_subnet_pool=2Ec \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec test_com=
mon=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_=
random=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	$(top_srcdir)/src/openvpn/options_util=2Ec \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> misc_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include =
-I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	=
-DSOURCEDIR=3D\&quot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_subnet_pool=2Ec b/tests/unit_tests/=
openvpn/test_subnet_pool=2Ec</span><br><span>new file mode 100644</span><br=
><span>index 0000000=2E=2E4022233</span><br><span>--- /dev/null</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_subnet_pool=2Ec</span><br><span>@@=
 -0,0 +1,174 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An app=
lication to securely tunnel IP networks</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             over a single UDP port, with support for=
 SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          session authentication and key exchange,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet aut=
hentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            packet compression=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  This program is free software; you can redistrib=
ute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  it under the terms of the GNU General Public License version 2</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Fre=
e Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pro=
gram is distributed in the hope that it will be useful,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without e=
ven the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pub=
lic License for more details=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Y=
ou should have received a copy of the GNU General Public License along</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; i=
f not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sys=
head=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=2Eh&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;set=
jmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;opti=
ons=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;options_util=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;mock_msg=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* --subnet-pool-tag resolves a client to its --sub=
net-pool; an unknown tag</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * returns NULL, which is what makes the server reject that client=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pool_by_tag(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_de=
f c =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpC&quot;, =2Enetwork =3D 0x0=
a020300, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020301 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def b =
=3D { =2Enext =3D &amp;c, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a0=
20200, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020201 };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def a =3D=
 { =2Enext =3D &amp;b, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a0201=
00, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a020101 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* every configured tag resolves to its own pool, =
wherever it sits */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_ptr_equal(subnet_pool_by_tag(&amp;a, &quot;grpA&quot;), &amp;a);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equa=
l(subnet_pool_by_tag(&amp;a, &quot;grpB&quot;), &amp;b);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(subnet_pool_by_ta=
g(&amp;a, &quot;grpC&quot;), &amp;c);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* and it carries that pool&#39;s subnet/gateway */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const struct subnet_pool_def *r =3D =
subnet_pool_by_tag(&amp;a, &quot;grpB&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(r-&gt;network, 0x0a020200);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(r-&gt;netmask, 0xffffff00);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(r-&gt;gateway, 0x0a020201);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* unknown tag and empty list both miss */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(subnet_pool_b=
y_tag(&amp;a, &quot;nope&quot;));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_null(subnet_pool_by_tag(NULL, &quot;grpA&quot;));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* a single pool &lt;net&gt;/&lt;mask&gt; with gateway &l=
t;gw&gt;, checked against the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * 10=2E8=2E0=2E0/24 --server network */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+check_one(in_addr_t net, in_addr_t mask, in_addr_t g=
w)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct subnet_pool_def d =3D { =
=2Enext =3D NULL, =2Etag =3D &quot;grp&quot;, =2Enetwork =3D net, =2Enetmas=
k =3D mask, =2Egateway =3D gw };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn subnet_pools_check(&amp;d, 0x0a080000, 0xffffff00, M_WARN);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* --subnet-pool geometry: anything ifconfig_pool_init() cannot ser=
ve must be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * refuse=
d when the config is checked, not when the first client connects */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+test_subnet_pools_check_netmask(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the bounds of --serv=
er: /16 =2E=2E /29 */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(check_one(0x0a090000, 0xffff0000, 0x0a090001));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0=
a090000, 0xffffff00, 0x0a090001));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(check_one(0x0a090000, 0xfffffff8, 0x0a090001=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* /30, /31,=
 /32: too few addresses for a pool */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_false(check_one(0x0a090000, 0xfffffffc, 0x0a09=
0001));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_f=
alse(check_one(0x0a090000, 0xfffffffe, 0x0a090001));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000, 0x=
ffffffff, 0x0a090000));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* /15: larger than IFCONFIG_POOL_MAX */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a080000, 0xfffe0=
000, 0x0a080001));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* non-contiguous netmask */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(check_one(0x0a000900, 0xff00ff00, 0x0a000901))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_subnet_pools_check_gateway(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* any host address of the subnet is fine, not only=
 the first one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(check_one(0x0a090000, 0xffffff00, 0x0a0900fe));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(check_one(0x0a090=
000, 0xffffff00, 0x0a090080));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* network address, broadcast address, outside the subnet */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ch=
eck_one(0x0a090000, 0xffffff00, 0x0a090000));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_false(check_one(0x0a090000, 0xffffff00=
, 0x0a0900ff));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(check_one(0x0a090000, 0xffffff00, 0x0a0a0001));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* a 10=2E9=2E0=2E0/24 pool with dynamic range &lt;start&gt;-&lt;end&gt=
; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+check_range(in_addr_t s=
tart, in_addr_t end)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct subnet=
_pool_def d =3D { =2Enext =3D NULL, =2Etag =3D &quot;grp&quot;, =2Enetwork =
=3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a090001, =2Epo=
ol_start =3D start, =2Epool_end =3D end };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return subnet_pools_check(&amp;d, 0x0a080000, 0xffffff00, M_WARN);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* the optional dynamic range: host addresses of the subn=
et, at least 2 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_subne=
t_pools_check_range(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* unset: the whole subnet */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_true(check_range(0, 0));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* a sub-range, the smallest one, the whole h=
ost range */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(check_range(0x0a090064, 0x0a0900c8));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(check_range(0x0a090064, 0x0a0900=
65));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(check_range(0x0a090001, 0x0a0900fe));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* a single address, or start past end */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(check_range(=
0x0a090064, 0x0a090064));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(check_range(0x0a0900c8, 0x0a090064));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* the network or broadcast ad=
dress */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
false(check_range(0x0a090000, 0x0a090064));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(check_range(0x0a090064, 0x0a0900ff=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* outside t=
he subnet */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_false(check_range(0x0a090064, 0x0a0a0001));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(check_range(0x0a080064, 0x0a09=
0064));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_subnet_pools_check_overlap(void **state)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct subnet_pool_def b =3D { =2Enext =3D NU=
LL, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a0a0000, =2Enetmask =3D =
0xffffff00, =2Egateway =3D 0x0a0a0001 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct subnet_pool_def a =3D { =2Enext =3D &amp;b,=
 =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xf=
fffff00, =2Egateway =3D 0x0a090001 };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* disjoint pools, disjoint from --server */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(subnet_pools_check(&amp;a, 0x0a=
080000, 0xffffff00, M_WARN));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* a =
pool inside the --server network =2E=2E=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_false(subnet_pools_check(&amp;a, 0x0a0=
90000, 0xffffff00, M_WARN));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* =2E=2E=2E or covering it */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(subnet_pools_check(&amp;a, 0x0a0a0=
080, 0xffffff80, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* no --server network: only the pools are checked against each =
other */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(subnet_pools_check(&amp;a, 0, 0, M_WARN));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* a /16 grpB containing grpA */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct subnet_pool_def b16 =3D { =2Enext =3D =
NULL, =2Etag =3D &quot;grpB&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask =
=3D 0xffff0000, =2Egateway =3D 0x0a090101 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct subnet_pool_def a16 =3D { =2Enext =3D &=
amp;b16, =2Etag =3D &quot;grpA&quot;, =2Enetwork =3D 0x0a090000, =2Enetmask=
 =3D 0xffffff00, =2Egateway =3D 0x0a090001 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_false(subnet_pools_check(&amp;a16, 0, =
0, M_WARN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the same tag define=
d twice */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t subnet_pool_def bdup =3D { =2Enext =3D NULL, =2Etag =3D &quot;grpA&quot;,=
 =2Enetwork =3D 0x0a0a0000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x0a0=
a0001 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
subnet_pool_def adup =3D { =2Enext =3D &amp;bdup, =2Etag =3D &quot;grpA&quo=
t;, =2Enetwork =3D 0x0a090000, =2Enetmask =3D 0xffffff00, =2Egateway =3D 0x=
0a090001 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_false(subnet_pools_check(&amp;adup, 0, 0, M_WARN));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nst struct CMUnitTest subnet_pool_tests[] =3D {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_subnet_pool_by_tag),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test=
(test_subnet_pools_check_netmask),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    cmocka_unit_test(test_subnet_pools_check_gateway),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test=
_subnet_pools_check_range),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    cmocka_unit_test(test_subnet_pools_check_overlap),</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    openvpn_unit_test_setup();</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_gro=
up_tests(subnet_pool_tests, NULL, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br></pre><p>To view, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail">change 1783</a>=2E To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscop=
e itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1783?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"dis=
play:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:no=
ne"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Bra=
nch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1e7db95=
615d99ef9687de7c4e996dc8033e2631 </div>
<div style=3D"display:none"> Gerrit=
-Change-Number: 1783 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8=
 </div>
<div style=3D"display:none"> Gerrit-Owner: Antonio Quartulli &lt;an=
tonio@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Review=
er: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-CC: =
openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank L=
ichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--H2lZLn+eeoA=--


--===============6536080923940353056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6536080923940353056==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6536080923940353056==--

