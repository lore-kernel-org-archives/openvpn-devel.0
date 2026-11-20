Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A351B606A326
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=D+Acp6YS;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bo3o2upf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YJ3bgir0;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=hVEkd9zl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Unsubscribe-Post:List-Owner;
	bh=v7WQ/R3W2qLh4TdDmeGgILU+h2ThXwcn9tO9dYZBUY8=; b=D+Acp6YSr5+Sbb7f+qqEgF62Cz
	nJ6he4C7TWAZc+G6GAYnyqxAUpYEQSq7tu8ESgLDR4mMwrqwoPFyMvvMLWREJGq08yJUZ8e94QIe7
	giM2DNNAbKX44WTBCUUQ4B/YwfXq0LrvLtk8Wj5qqSkYG97mmyvbXcDdUTyH1dthAMxM=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUM4M-00000000146-2eqR;
	Fri, 20 Nov 2026 10:42:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUM4A-0000000013q-3IKI
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:42:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T+UKM6sY1mP8LuzQ682+kVREVwjxWr+2fV9uVZk5aIA=; b=bo3o2upfRnebyLkwoB5p4LBBin
 pluDT6s5vcr8aai7tu0GGt7QHOurdamvlXRhMktY6weRylp+VwBwDRQoEnDhHDClWMwBmuR55DnEf
 A7fKrZ+OCpsqkEITYEMX/YxF9yBVnkAUDSVvvpXGYq7ga/UYCAjk/ntflroXJYCIrnik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=T+UKM6sY1mP8LuzQ682+kVREVwjxWr+2fV9uVZk5aIA=; b=YJ3bgir0KXLxWqS/SqBzepJvmW
 EUj24he5jVAdTPMN2QDNbXVbxzV2ZBo34Wg8754GxVP2NX6JO+dQCHM6DBrdTtSbWSS2/+Jv2w/1u
 jQfJPdIydvGyMNuKD5CCKqPTMn11kPdg2HdBGSF2xYhdQDajufaHTDhCvYCVuuFxfAKM=;
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUM47-0000000043T-3I5P for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 10:42:02 +0000
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4a7b8abe209so499792f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 02:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795171313; x=1795776113; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=T+UKM6sY1mP8LuzQ682+kVREVwjxWr+2fV9uVZk5aIA=;
 b=hVEkd9zlMmftyQ52NKhHbKetkZR33MPjkkHBC1nPxacZr9rXJNLdpesYLatnH9H5Zn
 T5plAMIaLq7u+gL7A8tmra5chixmRkso9rkZqbj7hXxsMJPYPdd1dHqobu6/OHopvz/j
 Tu5VLKehn2ZFS7O+wrHLlCRpY3wLSkqlIyloZeoCMlObqdwS82hMexA8qJXKvkcx9Jk3
 8+/xA9d/hVJT8XdJCWvlbtESqzQVxh3/74kbQXCyrzJykFshK8PK5TJrT2ln7qmIYkXD
 qzDhOgVzAh5wrDpdrL6wEC4B/pef7fDAR794sn52/kqbfG/QeknnRHvT4F2hHDFjlvWu
 jqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795171313; x=1795776113;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=T+UKM6sY1mP8LuzQ682+kVREVwjxWr+2fV9uVZk5aIA=;
 b=gr6n0BxeiuN2YDd9ETFaRaawx8WHelI2nIwkGDXsyJT9F8WP8G/9I/qd6mSUxZnadd
 BcPD4hpfma554roP6wXsQ3vKxhmB+Ec6zRpUwI8lQ9DVyz6Ee1jNuIqhm1H2huASws+p
 RaAzu/+XSOaspaJJad/6VtE4gRcIWmL5JQxzNKiTv+7/PveFv42KfptXfsGuWdNX+CBj
 n8VCSHXGIJ3mjdSeOnOnYYFWr4WqUpOKVaN9/PTP+gxqSeJTm49fOJ9dE7VRm+rOv5MG
 uJw1S6qDBNF67j0F3/+2r/vYTe+0hf7OIAoC30YOZubM2hbOoYzNlvt7By2OctdbjgTk
 O+8g==
X-Gm-Message-State: APuU4Z+E7aNjPkYmxL1SgEpPTUaYlAiEvEdtjz7mNQwX3uNzDERBtpdg
 TFwlbvPcSiE2QQKjVaXfc0mlBW9XIsGqhtV83CZeV6ILQqAy27IUG/PQIbk9rw4rNsFS0cwaoO7
 /Eaef5pe0XTVR2F4WfHVw6vyobMJG9npho0jguzT7xj93j474+wUbla/Nyb3h/xP90GVdCQTo7/
 RhDrHCbQ==
X-Gm-Gg: AZFdTZcpCJPO5abJZaaLTqtz4XZaP4XR6vLLgi4mFL+IFpXoHfpx8QBZO9gTvYE3mpW
 w2L2P8LYirQzwz2SVvJQuzLnIE23exj4aOK6S2V9SvWJTVg20bmIgTys9dPB78Nb7m7Oo6fobVh
 W8hWx/3b+Xc9dSFZmBD7/0y4k84TyyjnvhqGJDPRJAXl2aYLEjhEDIvcbt+womLLXM5csS8T4uG
 wQfip9Aiq3SIfjbUlPa5OXS3HcAu7cEJbf93ofiNmKKS22hq0rnm7hlnyXWuXPVuaOjjL7iETA8
 7KZnTYrWdqjM0Sil/eheArSg0hwoYVFMXU1Ol/jumcG13nrY1HhcQ8Q7bXor0lSawk7jJEV+LFI
 ZryR7ZGX6ZOZqRFo9y9YcTGIMBV6BQajqEll1qMNhUEm6TytTd4KzWRO1we4tI+VjMYmJT6x5i4
 /+O7LwZ7XuigvwNJyj1MWkCI9ckmbP5j1Tw4xkoydG4iMh6Bza6MxPSaP3F4RKTiEzDmgLkkII5
 4mx7VUjbpU1T8lQ4ciWYczW7Rq4i0Lsse/+DjFaahhIIjYt92S0rSyi9hVJjzOuThnxbahS57Ut
 yXBvvsF4CGZEB+CQyd/+R3tL6OIP8JO8slX1mtfoGvOkErT/e5xohDhZTVMWdblxgbcVNPeMigN
 UNctTlgzuS/ueq3OCtXRYKeZAIFGN3XqcgeHqAC8O2JenSGBruEYSjMsia49UHZ7tb4uRTRlRG7
 lptXElmD0H9zoFkDt8
X-Received: by 2002:a05:6000:4b08:b0:48e:88e2:fe6a with SMTP id
 ffacd0b85a97d-4abb514640fmr5034798f8f.49.1795171312786; 
 Fri, 20 Nov 2026 02:41:52 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6b110d56sm4770519f8f.40.2026.11.20.02.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 02:41:52 -0800 (PST)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 10:41:52 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Iebd0a97029c53e210641adecd754e31444c5b398
X-Gerrit-Change-Number: 2226
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2226?usp=email>
X-Gerrit-Commit: 23cd90383646d4b286bdafbb67979d74fca1a83c
References: <gerrit.1795171307000.Iebd0a97029c53e210641adecd754e31444c5b398@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTcxMzA3MDAwLkllYmQwYTk3MDI5YzUzZTIxMDY0MWFkZWNkNzU0ZTMxNDQ0YzViMzk4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72582d160029a39e18d19988fc5730b560c42b36-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUM47-0000000043T-3I5P
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Keep MPTCP subflows
 out of the tunnel
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3377341054541227118=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============3377341054541227118==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wW5Vdvq46YY="; charset=UTF-8

--wW5Vdvq46YY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2226?usp=3Demail

to review the following change=2E
=


Change subject: Keep MPTCP subflows out of the tunnel
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Keep MPTCP subflows out of the =
tunnel

With --mptcp, a subflow towards an address announced by the server
=
(MPTCP ADD_ADDR) follows the routing table like any other connection=2E
Whe=
n that address is covered by routes into the tunnel, e=2Eg=2E with
--redire=
ct-gateway, which only excludes the --remote address, the
subflow is routed=
 into the tunnel it belongs to=2E The server drops its
packets because of t=
heir source address, so whenever MPTCP schedules
data on that subflow, the =
whole connection stalls until the subflow's
retransmission timeout expires,=
 and the timeout doubles every time=2E

Such subflows are established right=
 after the connection, while with
--pull the routes are added only at the e=
nd of the handshake=2E When the
route lists are initialized, the peers repo=
rted by MPTCP_SUBFLOW_ADDRS
are routed like the --remote address, so the su=
bflows never enter the
tunnel=2E Addresses announced after that are not cov=
ered=2E

Change-Id: Iebd0a97029c53e210641adecd754e31444c5b398
Signed-off-by=
: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M CMakeLists=2Etxt
M=
 config=2Eh=2Ecmake=2Ein
M configure=2Eac
M doc/man-sections/link-options=
=2Erst
M src/openvpn/init=2Ec
M src/openvpn/route=2Ec
M src/openvpn/route=
=2Eh
M tests/unit_tests/openvpn/test_route=2Ec
8 files changed, 301 inserti=
ons(+), 29 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/26/2226/1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2E=
txt
index 50b2d68=2E=2Ef57b678 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLis=
ts=2Etxt
@@ -222,6 +222,7 @@
 if (HAVE_SYS_EPOLL_H)
     check_symbol_exist=
s(epoll_create sys/epoll=2Eh HAVE_EPOLL_CREATE)
 endif()
+check_include_fil=
es(linux/mptcp=2Eh HAVE_LINUX_MPTCP_H)
 check_include_files(syslog=2Eh HAVE=
_SYSLOG_H)
 if (HAVE_SYSLOG_H)
     check_symbol_exists(openlog syslog=2Eh =
HAVE_OPENLOG)
diff --git a/config=2Eh=2Ecmake=2Ein b/config=2Eh=2Ecmake=2Ei=
n
index f7818cf=2E=2E45e0da9 100644
--- a/config=2Eh=2Ecmake=2Ein
+++ b/con=
fig=2Eh=2Ecmake=2Ein
@@ -285,6 +285,9 @@
 /* Define to 1 if you have the <s=
ys/epoll=2Eh> header file=2E */
 #cmakedefine HAVE_SYS_EPOLL_H
 
+/* Define=
 to 1 if you have the <linux/mptcp=2Eh> header file=2E */
+#cmakedefine HAV=
E_LINUX_MPTCP_H
+
 /* Define to 1 if you have the <sys/inotify=2Eh> header =
file=2E */
 #cmakedefine HAVE_SYS_INOTIFY_H
 
diff --git a/configure=2Eac b=
/configure=2Eac
index 585c3bd=2E=2E239ba3d 100644
--- a/configure=2Eac
+++ =
b/configure=2Eac
@@ -458,6 +458,7 @@
 	syslog=2Eh pwd=2Eh grp=2Eh \
 	sys/s=
ockio=2Eh sys/uio=2Eh \
 	poll=2Eh sys/epoll=2Eh err=2Eh \
+	linux/mptcp=2E=
h \
 ])
 
 SOCKET_INCLUDES=3D"
diff --git a/doc/man-sections/link-options=
=2Erst b/doc/man-sections/link-options=2Erst
index ffc8fdd=2E=2Ea8fd8ab 100=
644
--- a/doc/man-sections/link-options=2Erst
+++ b/doc/man-sections/link-o=
ptions=2Erst
@@ -156,6 +156,12 @@
   kernel (``ip mptcp endpoint``); withou=
t them the connection uses a
   single subflow=2E
 
+  With ``--pull`` (imp=
lied by ``--client``), addresses announced by the
+  server (MPTCP ADD_ADDR=
) before the routes are added are routed like the
+  ``--remote`` address=
=2E An address announced later has to be excluded from
+  the tunnel manual=
ly, e=2Eg=2E with
+  ``--route address 255=2E255=2E255=2E255 net_gateway``=
=2E
+
   This option is only supported on Linux=2E If an MPTCP socket canno=
t be
   created, OpenVPN logs a warning and falls back to plain TCP=2E ``--=
mptcp``
   disables data channel offload, and ``--mtu-disc`` has no effect =
on MPTCP
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index e10=
52c5=2E=2Ebed78ed 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=
=2Ec
@@ -58,6 +58,10 @@
 #include "resolve=2Eh"
 #include "acc=2Eh"
 
+#if =
defined(TARGET_LINUX) && defined(HAVE_LINUX_MPTCP_H)
+#include <linux/mptcp=
=2Eh>
+#endif
+
 #include "memdbg=2Eh"
 
 
@@ -1698,6 +1702,61 @@
     c->c=
1=2Etuntap_owned =3D true;
 }
 
+#if defined(TARGET_LINUX) && !defined(TARG=
ET_ANDROID) && defined(MPTCP_SUBFLOW_ADDRS)
+static void
+do_init_mptcp_sub=
flow_routes(struct context *c)
+{
+    const struct link_socket *sock =3D c=
->c2=2Elink_sockets[0];
+    if (!(sock->sockflags & SF_MPTCP))
+    {
+   =
     return;
+    }
+
+    struct mptcp_subflow_data hdr =3D {
+        =2E=
size_subflow_data =3D sizeof(hdr),
+        =2Esize_user =3D sizeof(struct =
mptcp_subflow_addrs),
+    };
+    socklen_t len =3D sizeof(hdr);
+    if (=
getsockopt(sock->sd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &hdr, &len) !=3D 0
+  =
      || hdr=2Esize_user !=3D sizeof(struct mptcp_subflow_addrs) || hdr=2En=
um_subflows =3D=3D 0)
+    {
+        return;
+    }
+
+    struct
+    {
+=
        struct mptcp_subflow_data d;
+        struct mptcp_subflow_addrs a[=
];
+    } *sf;
+    struct gc_arena gc =3D gc_new();
+    const size_t size=
 =3D sizeof(*sf) + hdr=2Enum_subflows * sizeof(sf->a[0]);
+    sf =3D gc_ma=
lloc(size, true, &gc);
+    sf->d=2Esize_subflow_data =3D sizeof(sf->d);
+ =
   sf->d=2Esize_user =3D sizeof(sf->a[0]);
+    len =3D (socklen_t)size;
+ =
   if (getsockopt(sock->sd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, sf, &len) =3D=
=3D 0
+        && len >=3D sizeof(sf->d))
+    {
+        const size_t n =
=3D (len - sizeof(sf->d)) / sizeof(sf->a[0]);
+        for (size_t i =3D 0;=
 i < n; i++)
+        {
+            const struct mptcp_subflow_addrs *a =
=3D &sf->a[i];
+            if (a->sin_remote=2Esin_family =3D=3D AF_INET &=
& c->c1=2Eroute_list)
+            {
+                route_list_add_extra_=
remote(c->c1=2Eroute_list,
+                                            nto=
hl(a->sin_remote=2Esin_addr=2Es_addr));
+            }
+            else if=
 (a->sin6_remote=2Esin6_family =3D=3D AF_INET6 && c->c1=2Eroute_ipv6_list)
=
+            {
+                route_ipv6_list_add_extra_remote(c->c1=2Ero=
ute_ipv6_list,
+                                                 &a->sin6_r=
emote=2Esin6_addr);
+            }
+        }
+    }
+    gc_free(&gc);
+}
=
+#endif
+
 /*
  * Open tun/tap device, ifconfig, call up script, etc=2E
  *=
/
@@ -1854,6 +1913,9 @@
             do_init_route_ipv6_list(&c->options, c=
->c1=2Eroute_ipv6_list,
                                     &c->c2=2Elink_=
sockets[0]->info, c->c2=2Ees, &c->net_ctx);
         }
+#if defined(TARGET_=
LINUX) && !defined(TARGET_ANDROID) && defined(MPTCP_SUBFLOW_ADDRS)
+       =
 do_init_mptcp_subflow_routes(c);
+#endif
 
         /* do ifconfig */
    =
     if (!ifconfig_noexec_enabled(c) && ifconfig_order(c->c1=2Etuntap) =3D=
=3D IFCONFIG_BEFORE_TUN_OPEN)
diff --git a/src/openvpn/route=2Ec b/src/open=
vpn/route=2Ec
index 9086529=2E=2Ebdea368 100644
--- a/src/openvpn/route=2Ec=

+++ b/src/openvpn/route=2Ec
@@ -741,6 +741,37 @@
     return false;
 }
 
+=
static bool
+add_remote_host_route_ipv6(struct route_ipv6_list *rl6, const =
struct in6_addr *host)
+{
+    if ((rl6->rgi6=2Eflags & (RGI_ADDR_DEFINED |=
 RGI_IFACE_DEFINED))
+        !=3D (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED))
=
+    {
+        return false;
+    }
+
+    struct route_ipv6 *r6;
+    ALL=
OC_OBJ_CLEAR_GC(r6, struct route_ipv6, &rl6->gc);
+
+    r6->network =3D *h=
ost;
+    r6->netbits =3D 128;
+    if (!(rl6->rgi6=2Eflags & RGI_ON_LINK))=

+    {
+        r6->gateway =3D rl6->rgi6=2Egateway=2Eaddr_ipv6;
+    }
+ =
   r6->metric =3D 1;
+#ifdef _WIN32
+    r6->adapter_index =3D rl6->rgi6=2E=
adapter_index;
+#else
+    r6->iface =3D rl6->rgi6=2Eiface;
+#endif
+    r6=
->flags =3D RT_DEFINED | RT_METRIC_DEFINED;
+
+    r6->next =3D rl6->routes=
_ipv6;
+    rl6->routes_ipv6 =3D r6;
+    return true;
+}
+
 bool
 init_rou=
te_ipv6_list(struct route_ipv6_list *rl6, const struct route_ipv6_option_li=
st *opt6,
                      const char *remote_endpoint, int default_me=
tric,
@@ -839,36 +870,10 @@
     }
 
     /* add VPN server host route if n=
eeded */
-    if (need_remote_ipv6_route)
+    if (need_remote_ipv6_route &=
& !add_remote_host_route_ipv6(rl6, remote_host_ipv6))
     {
-        if ((=
rl6->rgi6=2Eflags & (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED))
-            =
=3D=3D (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED))
-        {
-            stru=
ct route_ipv6 *r6;
-            ALLOC_OBJ_CLEAR_GC(r6, struct route_ipv6, &=
rl6->gc);
-
-            r6->network =3D *remote_host_ipv6;
-            r6=
->netbits =3D 128;
-            if (!(rl6->rgi6=2Eflags & RGI_ON_LINK))
-  =
          {
-                r6->gateway =3D rl6->rgi6=2Egateway=2Eaddr_ipv=
6;
-            }
-            r6->metric =3D 1;
-#ifdef _WIN32
-          =
  r6->adapter_index =3D rl6->rgi6=2Eadapter_index;
-#else
-            r6->=
iface =3D rl6->rgi6=2Eiface;
-#endif
-            r6->flags =3D RT_DEFINED =
| RT_METRIC_DEFINED;
-
-            r6->next =3D rl6->routes_ipv6;
-       =
     rl6->routes_ipv6 =3D r6;
-        }
-        else
-        {
-        =
    msg(M_WARN,
-                "ROUTE6: IPv6 route overlaps with IPv6 rem=
ote address, but could not determine IPv6 gateway address + interface, expe=
ct failure\n");
-        }
+        msg(M_WARN,
+            "ROUTE6: IPv6 =
route overlaps with IPv6 remote address, but could not determine IPv6 gatew=
ay address + interface, expect failure\n");
     }
 
     gc_free(&gc);
@@ =
-939,6 +944,65 @@
     }
 }
 
+#if defined(TARGET_LINUX) && !defined(TARGET=
_ANDROID)
+void
+route_list_add_extra_remote(struct route_list *rl, in_addr=
_t host)
+{
+    if (!(rl->flags & RG_ENABLE)
+        || ((rl->spec=2Eflag=
s & RTSA_REMOTE_HOST) && host =3D=3D rl->spec=2Eremote_host)
+        || te=
st_local_addr(host, &rl->rgi) =3D=3D TLA_LOCAL)
+    {
+        return;
+  =
  }
+
+    struct gc_arena gc =3D gc_new();
+    if (add_bypass_address(&rl=
->spec=2Ebypass, host))
+    {
+        msg(M_INFO, "ROUTE: %s is routed li=
ke the remote host", print_in_addr_t(host, 0, &gc));
+    }
+    else
+    =
{
+        msg(M_WARN, "ROUTE: no room for bypass route to %s", print_in_ad=
dr_t(host, 0, &gc));
+    }
+    gc_free(&gc);
+}
+
+void
+route_ipv6_list_=
add_extra_remote(struct route_ipv6_list *rl6, const struct in6_addr *host)
=
+{
+    if ((rl6->spec_flags & RTSA_REMOTE_HOST) && IN6_ARE_ADDR_EQUAL(host=
, &rl6->remote_host_ipv6))
+    {
+        return;
+    }
+
+    bool overl=
ap =3D false;
+    for (const struct route_ipv6 *r6 =3D rl6->routes_ipv6; r=
6; r6 =3D r6->next)
+    {
+        if (r6->netbits =3D=3D 128 && IN6_ARE_A=
DDR_EQUAL(&r6->network, host))
+        {
+            return;
+        }
+=
        overlap =3D overlap || ipv6_net_contains_host(&r6->network, r6->net=
bits, host);
+    }
+    if (!overlap)
+    {
+        return;
+    }
+
+  =
  struct gc_arena gc =3D gc_new();
+    if (add_remote_host_route_ipv6(rl6,=
 host))
+    {
+        msg(M_INFO, "ROUTE6: %s is routed like the remote h=
ost", print_in6_addr(*host, 0, &gc));
+    }
+    else
+    {
+        msg(=
M_WARN, "ROUTE6: could not determine IPv6 gateway address + interface for %=
s",
+            print_in6_addr(*host, 0, &gc));
+    }
+    gc_free(&gc);
=
+}
+#endif /* if defined(TARGET_LINUX) && !defined(TARGET_ANDROID) */
+
 st=
atic bool
 redirect_default_route_to_vpn(struct route_list *rl, const struc=
t tuntap *tt, unsigned int flags,
                               const stru=
ct env_set *es, openvpn_net_ctx_t *ctx)
diff --git a/src/openvpn/route=2Eh =
b/src/openvpn/route=2Eh
index 0d33d36=2E=2E4e585c8 100644
--- a/src/openvpn=
/route=2Eh
+++ b/src/openvpn/route=2Eh
@@ -311,6 +311,19 @@
               =
 const struct route_gateway_info *rgi, const struct env_set *es,
          =
      openvpn_net_ctx_t *ctx);
 
+#if defined(TARGET_LINUX) && !defined(TAR=
GET_ANDROID)
+/**
+ * Route @p host like the remote host: via the original =
default gateway when
+ * it would otherwise be routed into the tunnel=2E
+ =
*/
+void route_list_add_extra_remote(struct route_list *rl, in_addr_t host)=
;
+
+/**
+ * IPv6 counterpart of route_list_add_extra_remote()=2E
+ */
+voi=
d route_ipv6_list_add_extra_remote(struct route_ipv6_list *rl6, const struc=
t in6_addr *host);
+#endif
+
 void add_route_to_option_list(struct route_op=
tion_list *l, const char *network, const char *netmask,
                   =
            const char *gateway, const char *metric, int table_id);
 
diff =
--git a/tests/unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/=
test_route=2Ec
index 3cfee9b=2E=2E8a0ebea 100644
--- a/tests/unit_tests/ope=
nvpn/test_route=2Ec
+++ b/tests/unit_tests/openvpn/test_route=2Ec
@@ -166,1=
1 +166,133 @@
     assert_clear_host_bits("2001:db8::1", 0, "::");
 }
 
+#i=
f defined(TARGET_LINUX) && !defined(TARGET_ANDROID)
+static in_addr_t
+ip4(=
const char *s)
+{
+    in_addr_t a;
+    assert_int_equal(inet_pton(AF_INET=
, s, &a), 1);
+    return ntohl(a);
+}
+
+static void
+test_route_list_add_=
extra_remote(void **state)
+{
+    struct route_list rl;
+    CLEAR(rl);
+ =
   rl=2Eflags =3D RG_ENABLE;
+    rl=2Espec=2Eflags =3D RTSA_REMOTE_HOST;
+=
    rl=2Espec=2Eremote_host =3D ip4("192=2E0=2E2=2E1");
+    rl=2Ergi=2Efla=
gs =3D RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED | RGI_IFACE_DEFINED;
+    rl=
=2Ergi=2Egateway=2Eaddr =3D ip4("10=2E0=2E1=2E1");
+    rl=2Ergi=2Egateway=
=2Enetmask =3D ip4("255=2E255=2E255=2E0");
+
+    /* the remote host and on=
-link addresses are skipped */
+    route_list_add_extra_remote(&rl, ip4("1=
92=2E0=2E2=2E1"));
+    route_list_add_extra_remote(&rl, ip4("10=2E0=2E1=2E=
7"));
+    assert_int_equal(rl=2Espec=2Ebypass=2En_bypass, 0);
+
+    /* ad=
ded once */
+    route_list_add_extra_remote(&rl, ip4("198=2E51=2E100=2E1")=
);
+    route_list_add_extra_remote(&rl, ip4("198=2E51=2E100=2E1"));
+    a=
ssert_int_equal(rl=2Espec=2Ebypass=2En_bypass, 1);
+    assert_int_equal(rl=
=2Espec=2Ebypass=2Ebypass[0], ip4("198=2E51=2E100=2E1"));
+
+    /* full by=
pass list */
+    for (in_addr_t a =3D ip4("198=2E51=2E100=2E2"); rl=2Espec=
=2Ebypass=2En_bypass < N_ROUTE_BYPASS; a++)
+    {
+        route_list_add_=
extra_remote(&rl, a);
+    }
+    route_list_add_extra_remote(&rl, ip4("198=
=2E51=2E100=2E100"));
+    assert_int_equal(rl=2Espec=2Ebypass=2En_bypass, =
N_ROUTE_BYPASS);
+    assert_int_not_equal(rl=2Espec=2Ebypass=2Ebypass[N_RO=
UTE_BYPASS - 1], ip4("198=2E51=2E100=2E100"));
+
+    /* nothing without --=
redirect-gateway */
+    CLEAR(rl=2Espec=2Ebypass);
+    rl=2Eflags =3D 0;
=
+    route_list_add_extra_remote(&rl, ip4("198=2E51=2E100=2E1"));
+    asse=
rt_int_equal(rl=2Espec=2Ebypass=2En_bypass, 0);
+}
+
+static void
+add_test=
_route_ipv6(struct route_ipv6_list *rl6, const char *network, unsigned int =
netbits)
+{
+    struct route_ipv6 *r6;
+    ALLOC_OBJ_CLEAR_GC(r6, struct =
route_ipv6, &rl6->gc);
+    assert_int_equal(inet_pton(AF_INET6, network, &=
r6->network), 1);
+    r6->netbits =3D netbits;
+    r6->next =3D rl6->rout=
es_ipv6;
+    rl6->routes_ipv6 =3D r6;
+}
+
+static int
+count_routes_ipv6(=
const struct route_ipv6_list *rl6)
+{
+    int n =3D 0;
+    for (const str=
uct route_ipv6 *r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
+    {
+     =
   n++;
+    }
+    return n;
+}
+
+static void
+test_route_ipv6_list_add_e=
xtra_remote(void **state)
+{
+    struct route_ipv6_list rl6;
+    struct i=
n6_addr host, gateway;
+
+    CLEAR(rl6);
+    rl6=2Egc =3D gc_new();
+    =
rl6=2Espec_flags =3D RTSA_REMOTE_HOST;
+    assert_int_equal(inet_pton(AF_I=
NET6, "2001:db8:1::1", &rl6=2Eremote_host_ipv6), 1);
+    rl6=2Ergi6=2Eflag=
s =3D RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;
+    assert_int_equal(inet_pton=
(AF_INET6, "fd00:1::1", &gateway), 1);
+    rl6=2Ergi6=2Egateway=2Eaddr_ipv=
6 =3D gateway;
+    strlcpy(rl6=2Ergi6=2Eiface, "eth0", sizeof(rl6=2Ergi6=
=2Eiface));
+    add_test_route_ipv6(&rl6, "2000::", 3);
+
+    /* the remo=
te host is skipped */
+    route_ipv6_list_add_extra_remote(&rl6, &rl6=2Ere=
mote_host_ipv6);
+    assert_int_equal(count_routes_ipv6(&rl6), 1);
+
+    =
/* not routed into the tunnel */
+    assert_int_equal(inet_pton(AF_INET6, =
"fd00:2::1", &host), 1);
+    route_ipv6_list_add_extra_remote(&rl6, &host)=
;
+    assert_int_equal(count_routes_ipv6(&rl6), 1);
+
+    /* added once, =
as a host route via the original gateway */
+    assert_int_equal(inet_pton=
(AF_INET6, "2001:db8:2::1", &host), 1);
+    route_ipv6_list_add_extra_remo=
te(&rl6, &host);
+    route_ipv6_list_add_extra_remote(&rl6, &host);
+    a=
ssert_int_equal(count_routes_ipv6(&rl6), 2);
+
+    const struct route_ipv6=
 *r6 =3D rl6=2Eroutes_ipv6;
+    assert_memory_equal(&r6->network, &host, s=
izeof(host));
+    assert_int_equal(r6->netbits, 128);
+    assert_memory_e=
qual(&r6->gateway, &gateway, sizeof(gateway));
+    assert_string_equal(r6-=
>iface, "eth0");
+    assert_int_equal(r6->flags, RT_DEFINED | RT_METRIC_DE=
FINED);
+
+    /* nothing without the original gateway */
+    rl6=2Ergi6=
=2Eflags =3D 0;
+    assert_int_equal(inet_pton(AF_INET6, "2001:db8:3::1", =
&host), 1);
+    route_ipv6_list_add_extra_remote(&rl6, &host);
+    assert=
_int_equal(count_routes_ipv6(&rl6), 2);
+
+    gc_free(&rl6=2Egc);
+}
+#end=
if
+
 static const struct CMUnitTest route_test_list[] =3D {
     cmocka_un=
it_test(test_is_special_addr),
     cmocka_unit_test(test_netmask_to_netbit=
s),
     cmocka_unit_test(test_netmask_to_netbits2),
     cmocka_unit_test(=
test_route_ipv6_clear_host_bits),
+#if defined(TARGET_LINUX) && !defined(TA=
RGET_ANDROID)
+    cmocka_unit_test(test_route_list_add_extra_remote),
+   =
 cmocka_unit_test(test_route_ipv6_list_add_extra_remote),
+#endif
 };
 
 in=
t

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2226?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newchange
Ge=
rrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iebd0a97029c5=
3e210641adecd754e31444c5b398
Gerrit-Change-Number: 2226
Gerrit-PatchSet: 1
=
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Revie=
wer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <op=
envpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>

--wW5Vdvq46YY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2226?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">Keep MPTCP subflows out of the tunnel<br><br>With --mpt=
cp, a subflow towards an address announced by the server<br>(MPTCP ADD_ADDR=
) follows the routing table like any other connection=2E<br>When that addre=
ss is covered by routes into the tunnel, e=2Eg=2E with<br>--redirect-gatewa=
y, which only excludes the --remote address, the<br>subflow is routed into =
the tunnel it belongs to=2E The server drops its<br>packets because of thei=
r source address, so whenever MPTCP schedules<br>data on that subflow, the =
whole connection stalls until the subflow&#39;s<br>retransmission timeout e=
xpires, and the timeout doubles every time=2E<br><br>Such subflows are esta=
blished right after the connection, while with<br>--pull the routes are add=
ed only at the end of the handshake=2E When the<br>route lists are initiali=
zed, the peers reported by MPTCP_SUBFLOW_ADDRS<br>are routed like the --rem=
ote address, so the subflows never enter the<br>tunnel=2E Addresses announc=
ed after that are not covered=2E<br><br>Change-Id: Iebd0a97029c53e210641ade=
cd754e31444c5b398<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mand=
elbit=2Ecom&gt;<br>---<br>M CMakeLists=2Etxt<br>M config=2Eh=2Ecmake=2Ein<b=
r>M configure=2Eac<br>M doc/man-sections/link-options=2Erst<br>M src/openvp=
n/init=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/route=2Eh<br>M tests=
/unit_tests/openvpn/test_route=2Ec<br>8 files changed, 301 insertions(+), 2=
9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/26/2226/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 50b2d68=2E=2Ef57b678 100644=
</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2E=
txt</span><br><span>@@ -222,6 +222,7 @@</span><br><span> if (HAVE_SYS_EPOLL=
_H)</span><br><span>     check_symbol_exists(epoll_create sys/epoll=2Eh HAV=
E_EPOLL_CREATE)</span><br><span> endif()</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+check_include_files(linux/mptcp=2Eh HAVE_LINUX_MPTCP_H=
)</span><br><span> check_include_files(syslog=2Eh HAVE_SYSLOG_H)</span><br>=
<span> if (HAVE_SYSLOG_H)</span><br><span>     check_symbol_exists(openlog =
syslog=2Eh HAVE_OPENLOG)</span><br><span>diff --git a/config=2Eh=2Ecmake=2E=
in b/config=2Eh=2Ecmake=2Ein</span><br><span>index f7818cf=2E=2E45e0da9 100=
644</span><br><span>--- a/config=2Eh=2Ecmake=2Ein</span><br><span>+++ b/con=
fig=2Eh=2Ecmake=2Ein</span><br><span>@@ -285,6 +285,9 @@</span><br><span> /=
* Define to 1 if you have the &lt;sys/epoll=2Eh&gt; header file=2E */</span=
><br><span> #cmakedefine HAVE_SYS_EPOLL_H</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* Define to 1 if you have the &lt;=
linux/mptcp=2Eh&gt; header file=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#cmakedefine HAVE_LINUX_MPTCP_H</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> /* Define to 1 if you have =
the &lt;sys/inotify=2Eh&gt; header file=2E */</span><br><span> #cmakedefine=
 HAVE_SYS_INOTIFY_H</span><br><span> </span><br><span>diff --git a/configur=
e=2Eac b/configure=2Eac</span><br><span>index 585c3bd=2E=2E239ba3d 100644</=
span><br><span>--- a/configure=2Eac</span><br><span>+++ b/configure=2Eac</s=
pan><br><span>@@ -458,6 +458,7 @@</span><br><span> 	syslog=2Eh pwd=2Eh grp=
=2Eh \</span><br><span> 	sys/sockio=2Eh sys/uio=2Eh \</span><br><span> 	pol=
l=2Eh sys/epoll=2Eh err=2Eh \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	linux/mptcp=2Eh \</span><br><span> ])</span><br><span> </span><b=
r><span> SOCKET_INCLUDES=3D&quot;</span><br><span>diff --git a/doc/man-sect=
ions/link-options=2Erst b/doc/man-sections/link-options=2Erst</span><br><sp=
an>index ffc8fdd=2E=2Ea8fd8ab 100644</span><br><span>--- a/doc/man-sections=
/link-options=2Erst</span><br><span>+++ b/doc/man-sections/link-options=2Er=
st</span><br><span>@@ -156,6 +156,12 @@</span><br><span>   kernel (``ip mpt=
cp endpoint``); without them the connection uses a</span><br><span>   singl=
e subflow=2E</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  With ``--pull`` (implied by ``--client``), addresses announced=
 by the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  server (MP=
TCP ADD_ADDR) before the routes are added are routed like the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+  ``--remote`` address=2E An addr=
ess announced later has to be excluded from</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+  the tunnel manually, e=2Eg=2E with</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  ``--route address 255=2E255=2E25=
5=2E255 net_gateway``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>   This option is only supported on Linux=2E If an MP=
TCP socket cannot be</span><br><span>   created, OpenVPN logs a warning and=
 falls back to plain TCP=2E ``--mptcp``</span><br><span>   disables data ch=
annel offload, and ``--mtu-disc`` has no effect on MPTCP</span><br><span>di=
ff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>inde=
x e1052c5=2E=2Ebed78ed 100644</span><br><span>--- a/src/openvpn/init=2Ec</s=
pan><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ -58,6 +58,10 @@=
</span><br><span> #include &quot;resolve=2Eh&quot;</span><br><span> #includ=
e &quot;acc=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; defined(HAVE_LINUX=
_MPTCP_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;linux/mptcp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> #include &quot;memdbg=2Eh&quot;</span><br><span> </span><br><span> =
</span><br><span>@@ -1698,6 +1702,61 @@</span><br><span>     c-&gt;c1=2Etun=
tap_owned =3D true;</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; !=
defined(TARGET_ANDROID) &amp;&amp; defined(MPTCP_SUBFLOW_ADDRS)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+do_init_mptcp_subflow_routes(struct con=
text *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct link_socket =
*sock =3D c-&gt;c2=2Elink_sockets[0];</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (!(sock-&gt;sockflags &amp; SF_MPTCP))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct mptcp_subflow_data hdr =3D {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        =2Esize_subflow_data =3D sizeof(hdr),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        =2Esize_user =3D sizeof(stru=
ct mptcp_subflow_addrs),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sock=
len_t len =3D sizeof(hdr);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (getsockopt(sock-&gt;sd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, &amp=
;hdr, &amp;len) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        || hdr=2Esize_user !=3D sizeof(struct mptcp_subflow_addrs) || hd=
r=2Enum_subflows =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct mptcp_subflow_data d;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct mptcp_subflow_addrs a[];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    } *sf;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t size =
=3D sizeof(*sf) + hdr=2Enum_subflows * sizeof(sf-&gt;a[0]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    sf =3D gc_malloc(size, true, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sf-&gt;d=
=2Esize_subflow_data =3D sizeof(sf-&gt;d);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    sf-&gt;d=2Esize_user =3D sizeof(sf-&gt;a[0]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    len =3D (socklen_t=
)size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (getso=
ckopt(sock-&gt;sd, SOL_MPTCP, MPTCP_SUBFLOW_ADDRS, sf, &amp;len) =3D=3D 0</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; le=
n &gt;=3D sizeof(sf-&gt;d))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  const size_t n =3D (len - sizeof(sf-&gt;d)) / sizeof(sf-&gt;a[0]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        for (size_t i =3D =
0; i &lt; n; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
const struct mptcp_subflow_addrs *a =3D &amp;sf-&gt;a[i];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (a-&gt;sin_remote=2Esi=
n_family =3D=3D AF_INET &amp;&amp; c-&gt;c1=2Eroute_list)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                route_list_add_extra_remo=
te(c-&gt;c1=2Eroute_list,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                            ntohl(a-&gt;sin_remote=2E=
sin_addr=2Es_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       else if (a-&gt;sin6_remote=2Esin6_family =3D=3D AF_INET6 &amp;&amp; =
c-&gt;c1=2Eroute_ipv6_list)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                route_ipv6_list_add_extra_remote(c-&gt;c1=2Eroute_ipv6_li=
st,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                                 &amp;a-&gt;sin6_remote=2Esin6_addr);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /*</span><br><span>  * Open tun/tap device, ifconfig, call up scri=
pt, etc=2E</span><br><span>  */</span><br><span>@@ -1854,6 +1913,9 @@</span=
><br><span>             do_init_route_ipv6_list(&amp;c-&gt;options, c-&gt;c=
1=2Eroute_ipv6_list,</span><br><span>                                     &=
amp;c-&gt;c2=2Elink_sockets[0]-&gt;info, c-&gt;c2=2Ees, &amp;c-&gt;net_ctx)=
;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(TARGET_LINUX) &amp;&amp; !defined(TARGET_ANDROID) &amp=
;&amp; defined(MPTCP_SUBFLOW_ADDRS)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        do_init_mptcp_subflow_routes(c);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><sp=
an>         /* do ifconfig */</span><br><span>         if (!ifconfig_noexec=
_enabled(c) &amp;&amp; ifconfig_order(c-&gt;c1=2Etuntap) =3D=3D IFCONFIG_BE=
FORE_TUN_OPEN)</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/ope=
nvpn/route=2Ec</span><br><span>index 9086529=2E=2Ebdea368 100644</span><br>=
<span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -741,6 +741,37 @@</span><br><span>     return false=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+add_remote_host_route_ipv6(struct route_ipv6_list *rl6, const st=
ruct in6_addr *host)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((rl6-&gt;=
rgi6=2Eflags &amp; (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        !=3D (RGI_ADDR_DEFINED | RGI=
_IFACE_DEFINED))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct route_ipv6 *r6;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(r6, struct route_i=
pv6, &amp;rl6-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;netwo=
rk =3D *host;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r6=
-&gt;netbits =3D 128;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (!(rl6-&gt;rgi6=2Eflags &amp; RGI_ON_LINK))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        r6-&gt;gateway =3D rl6-&gt;rgi6=2Egateway=2Eadd=
r_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;metric =3D 1;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    r6-&gt;adapter_index =
=3D rl6-&gt;rgi6=2Eadapter_index;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    r6-&gt;iface =3D rl6-&gt;rgi6=2Eiface;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    r6-&gt;flags =3D RT_DEFINED | RT_METRIC_DEFINED;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    r6-&gt;next =3D rl6-&gt;routes_ipv6;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    rl6-&gt;routes_ipv6 =3D r6=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span>=
 init_route_ipv6_list(struct route_ipv6_list *rl6, const struct route_ipv6_=
option_list *opt6,</span><br><span>                      const char *remote=
_endpoint, int default_metric,</span><br><span>@@ -839,36 +870,10 @@</span>=
<br><span>     }</span><br><span> </span><br><span>     /* add VPN server h=
ost route if needed */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (need_remote_ipv6_route)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (need_remote_ipv6_route &amp;&amp; !add_remote_host_rou=
te_ipv6(rl6, remote_host_ipv6))</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if ((rl6-&gt;rgi6=2Eflags &amp; (R=
GI_ADDR_DEFINED | RGI_IFACE_DEFINED))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            =3D=3D (RGI_ADDR_DEFINED | RGI_IFACE_DEFINED))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            struct route_ipv6 *r6;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ALLOC_OBJ=
_CLEAR_GC(r6, struct route_ipv6, &amp;rl6-&gt;gc);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            r6-&gt;network =3D *remote_host_ipv6;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            r6-&gt;netbits =3D 128;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (!(rl6-&gt=
;rgi6=2Eflags &amp; RGI_ON_LINK))</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                r6-&gt;gateway =3D rl6-&gt;rgi6=2Egateway=2Eaddr_ipv6;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            r6-&gt;metric =3D =
1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            r6-&gt;adapter_=
index =3D rl6-&gt;rgi6=2Eadapter_index;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            r6-&gt;iface =3D rl6-&gt;rgi6=2Eiface;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            r6-&gt;flags =3D RT_DEFINED | RT_METRIC_DEFINE=
D;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            r6-&gt;next =3D rl6-&gt;rout=
es_ipv6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            r=
l6-&gt;routes_ipv6 =3D r6;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;ROUT=
E6: IPv6 route overlaps with IPv6 remote address, but could not determine I=
Pv6 gateway address + interface, expect failure\n&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_WARN,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &quot;ROUTE6: IPv6 route overlaps wit=
h IPv6 remote address, but could not determine IPv6 gateway address + inter=
face, expect failure\n&quot;);</span><br><span>     }</span><br><span> </sp=
an><br><span>     gc_free(&amp;gc);</span><br><span>@@ -939,6 +944,65 @@</s=
pan><br><span>     }</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; =
!defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_list=
_add_extra_remote(struct route_list *rl, in_addr_t host)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!(rl-&gt;flags &amp; RG_ENABLE)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        || ((rl-&gt;spec=2Eflags &am=
p; RTSA_REMOTE_HOST) &amp;&amp; host =3D=3D rl-&gt;spec=2Eremote_host)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        || test_local_ad=
dr(host, &amp;rl-&gt;rgi) =3D=3D TLA_LOCAL)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ad=
d_bypass_address(&amp;rl-&gt;spec=2Ebypass, host))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(M_INFO, &quot;ROUTE: %s is routed like the rem=
ote host&quot;, print_in_addr_t(host, 0, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_WARN, &quot;ROUTE: no room for bypass route to %s&quot;, print_in_=
addr_t(host, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_=
free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+route_ipv6_list_add_extra_remote(struct route_ipv6_list =
*rl6, const struct in6_addr *host)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if ((rl6-&gt;spec_flags &amp; RTSA_REMOTE_HOST) &amp;&amp; IN6_ARE_ADDR_EQ=
UAL(host, &amp;rl6-&gt;remote_host_ipv6))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    bool overlap =3D false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const struct=
 route_ipv6 *r6 =3D rl6-&gt;routes_ipv6; r6; r6 =3D r6-&gt;next)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (r6-&gt;netbits =3D=3D 128 &amp;&=
amp; IN6_ARE_ADDR_EQUAL(&amp;r6-&gt;network, host))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        overlap =3D overlap || ipv6_net_contains_host(&amp;r6=
-&gt;network, r6-&gt;netbits, host);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!overlap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (add_remote_host_route_ipv=
6(rl6, host))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, =
&quot;ROUTE6: %s is routed like the remote host&quot;, print_in6_addr(*host=
, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;ROUTE6: could n=
ot determine IPv6 gateway address + interface for %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            print_in6_addr(*host, 0=
, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(TARGET_LINUX) &a=
mp;&amp; !defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> static bool</span><br><span> redirect_de=
fault_route_to_vpn(struct route_list *rl, const struct tuntap *tt, unsigned=
 int flags,</span><br><span>                               const struct env=
_set *es, openvpn_net_ctx_t *ctx)</span><br><span>diff --git a/src/openvpn/=
route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 0d33d36=2E=2E4e585c=
8 100644</span><br><span>--- a/src/openvpn/route=2Eh</span><br><span>+++ b/=
src/openvpn/route=2Eh</span><br><span>@@ -311,6 +311,19 @@</span><br><span>=
                const struct route_gateway_info *rgi, const struct env_set =
*es,</span><br><span>                openvpn_net_ctx_t *ctx);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TAR=
GET_LINUX) &amp;&amp; !defined(TARGET_ANDROID)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Route @p host like the remote host: via the original default =
gateway when</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * it w=
ould otherwise be routed into the tunnel=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+void route_list_add_extra_remote(struct route_list *rl, in_addr_t h=
ost);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * IPv6 counterpart of route_list_add_extra_remot=
e()=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void route_ipv6_list_add_extr=
a_remote(struct route_ipv6_list *rl6, const struct in6_addr *host);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> void add_route_to_opti=
on_list(struct route_option_list *l, const char *network, const char *netma=
sk,</span><br><span>                               const char *gateway, con=
st char *metric, int table_id);</span><br><span> </span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test=
_route=2Ec</span><br><span>index 3cfee9b=2E=2E8a0ebea 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/test_route=2Ec</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_route=2Ec</span><br><span>@@ -166,11 +166,133 @@</=
span><br><span>     assert_clear_host_bits(&quot;2001:db8::1&quot;, 0, &quo=
t;::&quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; !defined=
(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic in_addr_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ip4(co=
nst char *s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t a;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pt=
on(AF_INET, s, &amp;a), 1);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return ntohl(a);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_route_list_add_extra_remote(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct route_list rl;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(rl);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    rl=2Eflags =3D RG_ENAB=
LE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rl=2Espec=2E=
flags =3D RTSA_REMOTE_HOST;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    rl=2Espec=2Eremote_host =3D ip4(&quot;192=2E0=2E2=2E1&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rl=2Ergi=2Eflags =
=3D RGI_ADDR_DEFINED | RGI_NETMASK_DEFINED | RGI_IFACE_DEFINED;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    rl=2Ergi=2Egateway=2Eaddr =
=3D ip4(&quot;10=2E0=2E1=2E1&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    rl=2Ergi=2Egateway=2Enetmask =3D ip4(&quot;255=2E255=
=2E255=2E0&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the remote ho=
st and on-link addresses are skipped */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    route_list_add_extra_remote(&amp;rl, ip4(&quot;192=
=2E0=2E2=2E1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    route_list_add_extra_remote(&amp;rl, ip4(&quot;10=2E0=2E1=2E7&quot;))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(rl=2Espec=2Ebypass=2En_bypass, 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* added once */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    route_list_add_extra_remote(&amp;rl, ip4(&quot;198=2E51=2E100=2E1&quot;=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_list_a=
dd_extra_remote(&amp;rl, ip4(&quot;198=2E51=2E100=2E1&quot;));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(rl=2Espec=
=2Ebypass=2En_bypass, 1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(rl=2Espec=2Ebypass=2Ebypass[0], ip4(&quot;198=2E=
51=2E100=2E1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* full bypas=
s list */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (i=
n_addr_t a =3D ip4(&quot;198=2E51=2E100=2E2&quot;); rl=2Espec=2Ebypass=2En_=
bypass &lt; N_ROUTE_BYPASS; a++)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       route_list_add_extra_remote(&amp;rl, a);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    route_list_add_extra_remote(&amp;rl, ip4(&quot;198=2E51=
=2E100=2E100&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(rl=2Espec=2Ebypass=2En_bypass, N_ROUTE_BYPASS);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_not_equal=
(rl=2Espec=2Ebypass=2Ebypass[N_ROUTE_BYPASS - 1], ip4(&quot;198=2E51=2E100=
=2E100&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* nothing without =
--redirect-gateway */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    CLEAR(rl=2Espec=2Ebypass);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    rl=2Eflags =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    route_list_add_extra_remote(&amp;rl, ip4(&quot;198=2E51=
=2E100=2E1&quot;));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(rl=2Espec=2Ebypass=2En_bypass, 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_test_=
route_ipv6(struct route_ipv6_list *rl6, const char *network, unsigned int n=
etbits)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6 *r6;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR_GC(=
r6, struct route_ipv6, &amp;rl6-&gt;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, network, &amp=
;r6-&gt;network), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    r6-&gt;netbits =3D netbits;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    r6-&gt;next =3D rl6-&gt;routes_ipv6;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    rl6-&gt;routes_ipv6 =3D r6;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+count_routes_ipv6(const struct route_ipv6_list *rl6)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int n =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (const struct route_ipv6 *r6 =3D rl6-&gt;routes_ipv6; =
r6; r6 =3D r6-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        n+=
+;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return n;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ro=
ute_ipv6_list_add_extra_remote(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct route_ipv6_list rl6;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct in6_addr host, gateway;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(rl6);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    rl6=2Egc =3D gc_new();</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    rl6=2Espec_flags =3D RTSA_REMOTE_HOST;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_=
INET6, &quot;2001:db8:1::1&quot;, &amp;rl6=2Eremote_host_ipv6), 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    rl6=2Ergi6=2Eflags =3D =
RGI_ADDR_DEFINED | RGI_IFACE_DEFINED;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, &quot;fd00:1::1&=
quot;, &amp;gateway), 1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    rl6=2Ergi6=2Egateway=2Eaddr_ipv6 =3D gateway;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    strlcpy(rl6=2Ergi6=2Eiface, &quot;e=
th0&quot;, sizeof(rl6=2Ergi6=2Eiface));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    add_test_route_ipv6(&amp;rl6, &quot;2000::&quot;, 3=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* the remote host is skipped */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_ipv6_list=
_add_extra_remote(&amp;rl6, &amp;rl6=2Eremote_host_ipv6);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(count_routes_ipv=
6(&amp;rl6), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* not routed into=
 the tunnel */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(inet_pton(AF_INET6, &quot;fd00:2::1&quot;, &amp;host), 1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    route_ipv6_list_=
add_extra_remote(&amp;rl6, &amp;host);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(count_routes_ipv6(&amp;rl6), 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* added once, as a host route via th=
e original gateway */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(inet_pton(AF_INET6, &quot;2001:db8:2::1&quot;, &amp;=
host), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    route=
_ipv6_list_add_extra_remote(&amp;rl6, &amp;host);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    route_ipv6_list_add_extra_remote(&amp;rl6=
, &amp;host);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(count_routes_ipv6(&amp;rl6), 2);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const struct route_ipv6 *r6 =3D rl6=2Eroutes_ipv6;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(&amp;r6=
-&gt;network, &amp;host, sizeof(host));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(r6-&gt;netbits, 128);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(&amp;r6-=
&gt;gateway, &amp;gateway, sizeof(gateway));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(r6-&gt;iface, &quot;eth0&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(r6-&gt;flags, RT_DEFINED | RT_METRIC_DEFINED);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* nothing without the original gateway */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    rl6=2Ergi6=2Eflags =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(i=
net_pton(AF_INET6, &quot;2001:db8:3::1&quot;, &amp;host), 1);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    route_ipv6_list_add_extra_rem=
ote(&amp;rl6, &amp;host);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(count_routes_ipv6(&amp;rl6), 2);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;rl6=2Egc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> static const struct CMUnitTest route_test_list[] =3D {</spa=
n><br><span>     cmocka_unit_test(test_is_special_addr),</span><br><span>  =
   cmocka_unit_test(test_netmask_to_netbits),</span><br><span>     cmocka_u=
nit_test(test_netmask_to_netbits2),</span><br><span>     cmocka_unit_test(t=
est_route_ipv6_clear_host_bits),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(TARGET_LINUX) &amp;&amp; !defined(TARGET_ANDROID)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test=
(test_route_list_add_extra_remote),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    cmocka_unit_test(test_route_ipv6_list_add_extra_remote)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span> };</span><br><span> </span><br><span> int</span><br></pre><p>To view,=
 visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2226?usp=3Dema=
il">change 2226</a>=2E To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2226?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<=
div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"di=
splay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerr=
it-Change-Id: Iebd0a97029c53e210641adecd754e31444c5b398 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 2226 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner:=
 Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </d=
iv>

</body></html>
--wW5Vdvq46YY=--


--===============3377341054541227118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3377341054541227118==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3377341054541227118==--

