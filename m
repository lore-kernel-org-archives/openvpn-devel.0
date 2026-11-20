Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB97606A320
	for <openvpn-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FEWvEyJ3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=lmyoP82J;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K6E5Gz+L;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=I1JVBHtp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=KhRpFfD153olpvvXqOE+Omsc9kzQMuOKR3+k3959KcQ=; b=FEWvEyJ3JHwKesZmOmN6M1Qwq2
	Czpk0ShfyJKULEPty0ugywLrz9pl2YQihThSWXrWz5aFQeH3cT30V0p0z93qX10uZgxV3+lT7IlTY
	G+1Njomya3dkBQ2+CKT58JfJtHcQv6XtxUo0yVBM7gbfegTQBP9GXg7dmjrXIC17nn+4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xUK08-000000007LD-1Kq5;
	Fri, 20 Nov 2026 08:29:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xUJzr-000000007Kx-0fP7
 for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZG8mYjREIChQFCgTohdAZNh1DJdH1ElsPKRMDoERdY=; b=lmyoP82JtTP02fg9KZOV/03+X0
 UYnnJT1T6u1geuduTvJVXn2NuMN+42iYQHPC0dEH0owzSSdWJVKQ53gEKdBmyqfPd16SJi1yq+Anu
 8z2HhzH1BTJlnBjXdEs3kUBrVRyRdTu/1q8VpKFgp0W4aHDleEwbyLM6d++Hx/8JHn9U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IZG8mYjREIChQFCgTohdAZNh1DJdH1ElsPKRMDoERdY=; b=K6E5Gz+Lfoz3fTg4JvbkTCvve1
 r2NLNZ/XrA0BJSAQNTLk1zVFqv3VY4rPR0oBzqPRZp3nOdZNieNJywC6+HGCd5hhCtC7f6X+fJpbM
 gjpyo/rfh3WPXcGyzvPG6EV+VAxi84LAcNootSASu6iozMqDIcuWdiT0JioxNPuAbZ3I=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUJzl-000000000PA-02dL for openvpn-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:29:25 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48e3b22e971so283348f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795163354; x=1795768154; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=IZG8mYjREIChQFCgTohdAZNh1DJdH1ElsPKRMDoERdY=;
 b=I1JVBHtp1zoETHSbqlqK7YHP9OT66geKVN67FMHAwmBJR6fnuplqz38R0VcFp03RPa
 rXOppMUyjm13D68yV46tHw6gggC9gKrQAwEeUhTLbwikJ3uHQbhuEl2MWgFBuRa1Dxdp
 ycjSqs/Tg4DSBarT646ZcnNAa5vDrFWEgWqzYpY4ExAT/jPE5AmIIx1L24aPvsRsPwgH
 rGtq1IdJtA4YUFmV1/LC5lRUbBnoFy+iALIM4nwuSbz2g7qjxtbteFmU+Xu3Iy3kfoJX
 7b4KYzdQIBe5itL/eu+mTbH+8lMyoSsNRP3R8ngoWDN1MME1ad+TcY7dS1gf5fmQaL8v
 865g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795163354; x=1795768154;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=IZG8mYjREIChQFCgTohdAZNh1DJdH1ElsPKRMDoERdY=;
 b=EkTqNsp3qveKb3GrIetfjmjwa/uRULjVlZO01mveKn1ugNcawfLqc+ZDywAK+WIklc
 vus3hH5qRWMlySlYSCRTRey68fP+KwhlADAaYDSKLsiBLd6nAFZAmbUwsHm1E9jbi9N3
 A9ILNJbXPkcXviHIH9QqTs7hKkHfIP5sFrXkmkzfCfqkQo81k4NBsC7rpIXdQOXv/9iL
 E4KN3iewOBecuFQjNw8MTNqCwrciJQD5r7K3LgA1dV8JRDEYzX9nP1xbfKj7rMeDKF4T
 99HzBwDPMSCifDo6M0ZTj+GSYVYxwRDtZP5BdUdbC0uNkINTxC60UDcbAHG/R4WJAvPv
 NUMg==
X-Gm-Message-State: APuU4Z9rP8XM7tPEc3aOnaLnOF4ifbFsznpZiI2qgP4aLxZewbE4aRjg
 EqwMl6AInxoiOo1RiAzqncxg51H0XBgK6eXAr208ZAV5sF0UA8ae8f/Pd/hPRx+10LHBiVnaBIb
 lKfTL/NqPcj5+LeHLCO+iH8pH437/ejpJkIbO2cTvs5WGUlSp2l/qd/VyAKvj30ApW8Nw
X-Gm-Gg: AZFdTZc6TtGEViMWqNruBo8/udz7sDQtHINqr8yiOvl4vYcp0qA0/OryK2KnsuMTlR7
 aC6kHoF70OD2A0dat8NX+O6cFUgFvTKy74+iBj/k5JAKfmtVZr2PWRiCsxlmQyvDCs9xNKFubIn
 PHpPjxN3dHLfbgiv7sEhs5wMlUHCtKpwTYrksAFeiwZzbcOaDE+fggVoF0gUx/59u/4cKL38eUt
 ySQnfNKAAp1WlNndCom5ZmFNdwdMf55hdjc8mXvOwqo6WmWA4l1R3+RsDBxMA4T0TV+uUhuvFcB
 R2i9jwtr5M507uRTl1HHN67VK2d/jjivOKNNNOx4RTxvyeuEMGDJnlo+Pmxt0mzxUEVDwhTAGGg
 xN+bS63FTl74RUJJVqO3YUZEsmF6ILjKIY0aVVff6pV9bxyHIZd2xXrDneQrNjZl/7bXA1+DLHZ
 X6JdQj82+Xy4rZIvIcuqB2qa6qQMb2xdgj+UobdIe3OJkEui6dKoWhbwOfSo7haEtBgLrdM5mPN
 BU37hOZIfetkFJ3dggiCcevvprYjEY9GhgfDfxzomdQM+mTlbRaqpQ612d+BzmX0IopESyYDgiy
 SzVOvBbxhhpKtsnh2IxY0LOmxFmPGY+vnmowQYaRihdcqwO82zUx3DHQeCNpjPfnAtZxi5jQZ1L
 4NjfG3nQXjF/p83iO4YON//zfmghSIbtWMaj0K0SfodfD/htoQmCSmXK6g06GK56vEVhddiVR25
 9vbRYl2ex10nNXla8=
X-Received: by 2002:adf:e008:0:20b0:48f:bba5:732e with SMTP id
 ffacd0b85a97d-4abb560e1c7mr2815318f8f.57.1795163353948; 
 Fri, 20 Nov 2026 00:29:13 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab69bf629dsm3832620f8f.9.2026.11.20.00.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 00:29:13 -0800 (PST)
X-Google-Original-From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?=
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 20 Nov 2026 08:29:10 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 3
X-Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
X-Gerrit-Change-Number: 2224
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/2224?usp=email>
X-Gerrit-Commit: 7ec8c790eacaff945c691563fad9882acb05f6d9
In-Reply-To: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
References: <gerrit.1795156301000.Icbfc6b64beea5e70f32449c5a63a08ad862597b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzk1MTU2MzAxMDAwLkljYmZjNmI2NGJlZWE1ZTcwZjMyNDQ5YzVhNjNhMDhhZDg2MjU5N2I5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4be3b1f9693b9e420d4018b6980ed74e92004a82-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xUJzl-000000000PA-02dL
Subject: [Openvpn-devel] [M] Change in openvpn[master]: networking: use
 NET_ROUTE_TABLE_DEFAULT (-1) for "no route table"
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= via Openvpn-devel
 <openvpn-devel@lists.sourceforge.net>
Reply-To: razvanc@mailbox.org, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, gert@greenie.muc.de
Cc: =?UTF-8?Q?R=C4=83zvan_Cojocaru_=28Code_Review=29?= <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7359296219201562905=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7359296219201562905==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uPJ9omVWeSE="; charset=UTF-8

--uPJ9omVWeSE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Gert Doering, R=C4=83zv=
an Cojocaru=2E

Hello Arne Schwabe, Gert Doering, 

I'd like you to reexami=
ne a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/2224?usp=3Demail

to look at the new patch set (#3)=2E

The following appr=
ovals got outdated and were removed:
Code-Review+2 by Gert Doering


Change=
 subject: networking: use NET_ROUTE_TABLE_DEFAULT (-1) for "no route table"=

=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

networking=
: use NET_ROUTE_TABLE_DEFAULT (-1) for "no route table"

Table 0 meant "def=
ault table" in the net_route_*() API=2E That is fine on
Linux, where table =
0 is RT_TABLE_UNSPEC, but on FreeBSD FIB 0 is a real
FIB, which could then =
not be selected from a process running in another
FIB=2E

Make the table ar=
gument an int, with NET_ROUTE_TABLE_DEFAULT (-1) for
the default table, and=
 default --route-table to it=2E An invalid
--route-table value is now an er=
ror, instead of table 0=2E sitnl maps -1
and 0 to the main table, as before=
=2E On FreeBSD, -fib is now passed only
for a set table; DCO iroutes no lon=
ger force FIB 0 but use the FIB of
the process=2E

Routes that route=2Ec cr=
eates internally get it too; block-local routes
passed an uninitialized tab=
le before=2E

Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
Signed-o=
ff-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
---
M src/openvpn/dco=2Ec
M =
src/openvpn/networking=2Eh
M src/openvpn/networking_freebsd=2Ec
M src/openv=
pn/networking_iproute2=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/openvpn=
/options=2Ec
M src/openvpn/route=2Ec
M tests/unit_tests/openvpn/test_networ=
king=2Ec
8 files changed, 74 insertions(+), 63 deletions(-)


  git pull ss=
h://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/24/2224/3

diff --git=
 a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index 236be93=2E=2Efdee465 100=
644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -721,7 +721,7 @@=

         }
 
         net_route_v6_add(&m->top=2Enet_ctx, &addr->v6=2Eaddr=
, addr->netbits,
-                         gateway, c->c1=2Etuntap->actual_=
name, 0,
+                         gateway, c->c1=2Etuntap->actual_name, NE=
T_ROUTE_TABLE_DEFAULT,
                          DCO_IROUTE_METRIC);
 #endi=
f
     }
@@ -739,7 +739,7 @@
         }
 
         net_route_v4_add(&m->top=
=2Enet_ctx, &dest, addr->netbits, gateway,
-                         c->c1=
=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
+                         c-=
>c1=2Etuntap->actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);
 #e=
ndif
     }
 #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD) =
|| defined(_WIN32) */
@@ -765,7 +765,7 @@
             dco_win_del_iroute_i=
pv4(&c->c1=2Etuntap->dco, htonl(ir->network), ir->netbits);
 #else
        =
     net_route_v4_del(net_ctx, &ir->network, ir->netbits,
-                =
             &c->c2=2Epush_ifconfig_local, c->c1=2Etuntap->actual_name, 0,
=
+                             &c->c2=2Epush_ifconfig_local, c->c1=2Etuntap-=
>actual_name, NET_ROUTE_TABLE_DEFAULT,
                              DCO_IR=
OUTE_METRIC);
 #endif
         }
@@ -779,7 +779,7 @@
         {
           =
  /* On windows we do not install these routes, so we also do not need to d=
elete them */
             net_route_v4_del(net_ctx, &ifconfig_local, 32, N=
ULL,
-                             c->c1=2Etuntap->actual_name, 0, DCO_IROU=
TE_METRIC);
+                             c->c1=2Etuntap->actual_name, NET_=
ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);
         }
 #endif
     }
@@ -792,=
7 +792,7 @@
             dco_win_del_iroute_ipv6(&c->c1=2Etuntap->dco, ir6-=
>network, ir6->netbits);
 #else
             net_route_v6_del(net_ctx, &ir6=
->network, ir6->netbits,
-                             &c->c2=2Epush_ifconf=
ig_ipv6_local, c->c1=2Etuntap->actual_name, 0,
+                           =
  &c->c2=2Epush_ifconfig_ipv6_local, c->c1=2Etuntap->actual_name, NET_ROUTE=
_TABLE_DEFAULT,
                              DCO_IROUTE_METRIC);
 #endif
 =
        }
@@ -805,7 +805,7 @@
         {
             /* On windows we do n=
ot install these routes, so we also do not need to delete them */
         =
    net_route_v6_del(net_ctx, dest, 128, NULL,
-                           =
  c->c1=2Etuntap->actual_name, 0, DCO_IROUTE_METRIC);
+                    =
         c->c1=2Etuntap->actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_M=
ETRIC);
         }
 #endif
     }
diff --git a/src/openvpn/networking=2Eh b=
/src/openvpn/networking=2Eh
index 7ad6e2e=2E=2Ef42ef4b 100644
--- a/src/ope=
nvpn/networking=2Eh
+++ b/src/openvpn/networking=2Eh
@@ -24,6 +24,9 @@
 
 #=
define IFACE_TYPE_LEN_MAX 64
 
+/** net_route_*() table: Linux main table, =
FreeBSD FIB of the process */
+#define NET_ROUTE_TABLE_DEFAULT -1
+
 struct=
 context;
 
 #ifdef ENABLE_SITNL
@@ -245,14 +248,13 @@
  * @param prefixlen=
 the length of the prefix of the destination
  * @param gw        the gatew=
ay for this route
  * @param iface     the interface for this route (can be=
 NULL)
- * @param table     the table to add this route to (if 0, will be a=
dded to the
- *                  main table)
+ * @param table     the table=
 to add this route to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the =
metric associated with the route
  *
  * @return          0 on success, a n=
egative error code otherwise
  */
 int net_route_v4_add(const openvpn_net_c=
tx_t *ctx, const in_addr_t *dst, int prefixlen,
-                     const=
 in_addr_t *gw, const openvpn_net_iface_t *iface, uint32_t table,
+        =
             const in_addr_t *gw, const openvpn_net_iface_t *iface, int tab=
le,
                      int metric);
 
 /**
@@ -263,14 +265,13 @@
  * @pa=
ram prefixlen the length of the prefix of the destination
  * @param gw    =
    the gateway for this route
  * @param iface     the interface for this =
route (can be NULL)
- * @param table     the table to add this route to (if=
 0, will be added to the
- *                  main table)
+ * @param table =
    the table to add this route to, or NET_ROUTE_TABLE_DEFAULT
  * @param m=
etric    the metric associated with the route
  *
  * @return          0 on=
 success, a negative error code otherwise
  */
 int net_route_v6_add(const =
openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-       =
              const struct in6_addr *gw, const openvpn_net_iface_t *iface, =
uint32_t table,
+                     const struct in6_addr *gw, const open=
vpn_net_iface_t *iface, int table,
                      int metric);
 
 /*=
*
@@ -281,14 +282,13 @@
  * @param prefixlen the length of the prefix of th=
e destination
  * @param gw        the gateway for this route
  * @param if=
ace     the interface for this route (can be NULL)
- * @param table     the=
 table to add this route to (if 0, will be added to the
- *                =
  main table)
+ * @param table     the table to add this route to, or NET_R=
OUTE_TABLE_DEFAULT
  * @param metric    the metric associated with the rout=
e
  *
  * @return          0 on success, a negative error code otherwise
  =
*/
 int net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst=
, int prefixlen,
-                     const in_addr_t *gw, const openvpn_n=
et_iface_t *iface, uint32_t table,
+                     const in_addr_t *g=
w, const openvpn_net_iface_t *iface, int table,
                      int m=
etric);
 
 /**
@@ -299,14 +299,13 @@
  * @param prefixlen the length of the=
 prefix of the destination
  * @param gw        the gateway for this route
=
  * @param iface     the interface for this route (can be NULL)
- * @param =
table     the table to add this route to (if 0, will be added to the
- *   =
               main table)
+ * @param table     the table to add this route=
 to, or NET_ROUTE_TABLE_DEFAULT
  * @param metric    the metric associated =
with the route
  *
  * @return          0 on success, a negative error code=
 otherwise
  */
 int net_route_v6_del(const openvpn_net_ctx_t *ctx, const s=
truct in6_addr *dst, int prefixlen,
-                     const struct in6_=
addr *gw, const openvpn_net_iface_t *iface, uint32_t table,
+              =
       const struct in6_addr *gw, const openvpn_net_iface_t *iface, int tab=
le,
                      int metric);
 
 #endif /* ENABLE_SITNL || ENABLE_=
IPROUTE || TARGET_FREEBSD */
diff --git a/src/openvpn/networking_freebsd=2E=
c b/src/openvpn/networking_freebsd=2Ec
index 88fd5c0=2E=2E8ba6326 100644
--=
- a/src/openvpn/networking_freebsd=2Ec
+++ b/src/openvpn/networking_freebsd=
=2Ec
@@ -10,7 +10,7 @@
 
 static int
 net_route_v4(const char *op, const in=
_addr_t *dst, int prefixlen, const in_addr_t *gw,
-             const char =
*iface, uint32_t table, int metric)
+             const char *iface, int ta=
ble, int metric)
 {
     char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];=

     in_addr_t _dst, _gw;
@@ -27,15 +27,20 @@
     if (gw)
     {
        =
 _gw =3D ntohl(*gw);
-        argv_printf(&argv, "%s %s -net %s/%d %s -fib =
%d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s %s -net %s/%d %s", ROU=
TE_PATH, op,
                     inet_ntop(AF_INET, &_dst, buf1, sizeof(bu=
f1)), prefixlen,
-                    inet_ntop(AF_INET, &_gw, buf2, sizeof=
(buf2)), table);
+                    inet_ntop(AF_INET, &_gw, buf2, sizeof=
(buf2)));
     }
     else
     {
-        argv_printf(&argv, "%s %s -net %=
s/%d -iface %s -fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s %s=
 -net %s/%d -iface %s", ROUTE_PATH, op,
                     inet_ntop(AF_I=
NET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                    iface, tab=
le);
+                    iface);
+    }
+    /* without -fib, route(8) use=
s the FIB of the process */
+    if (table >=3D 0)
+    {
+        argv_pri=
ntf_cat(&argv, "-fib %d", table);
     }
 
     argv_msg(M_INFO, &argv);
@@=
 -48,7 +53,7 @@
 
 static int
 net_route_v6(const char *op, const struct in=
6_addr *dst, int prefixlen, const struct in6_addr *gw,
-             const =
char *iface, uint32_t table, int metric)
+             const char *iface, i=
nt table, int metric)
 {
     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRS=
TRLEN];
     struct argv argv =3D argv_new();
@@ -61,15 +66,19 @@
      */
=
     if (gw)
     {
-        argv_printf(&argv, "%s -6 %s -net %s/%d %s -fi=
b %d", ROUTE_PATH, op,
+        argv_printf(&argv, "%s -6 %s -net %s/%d %s"=
, ROUTE_PATH, op,
                     inet_ntop(AF_INET6, dst, buf1, sizeo=
f(buf1)), prefixlen,
-                    inet_ntop(AF_INET6, gw, buf2, siz=
eof(buf2)), table);
+                    inet_ntop(AF_INET6, gw, buf2, size=
of(buf2)));
     }
     else
     {
-        argv_printf(&argv, "%s -6 %s -=
net %s/%d -iface %s -fib %d", ROUTE_PATH, op,
+        argv_printf(&argv, "=
%s -6 %s -net %s/%d -iface %s", ROUTE_PATH, op,
                     inet_n=
top(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                    ifa=
ce, table);
+                    iface);
+    }
+    if (table >=3D 0)
+   =
 {
+        argv_printf_cat(&argv, "-fib %d", table);
     }
 
 
@@ -83,28 =
+92,28 @@
 
 int
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_a=
ddr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const cha=
r *iface, uint32_t table, int metric)
+                 const char *iface, =
int table, int metric)
 {
     return net_route_v4("add", dst, prefixlen, g=
w, iface, table, metric);
 }
 
 int
 net_route_v6_add(const openvpn_net_ctx=
_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const=
 struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+     =
            const struct in6_addr *gw, const char *iface, int table, int me=
tric)
 {
     return net_route_v6("add", dst, prefixlen, gw, iface, table, =
metric);
 }
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in=
_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const c=
har *iface, uint32_t table, int metric)
+                 const char *iface=
, int table, int metric)
 {
     return net_route_v4("del", dst, prefixlen,=
 gw, iface, table, metric);
 }
 
 int
 net_route_v6_del(const openvpn_net_c=
tx_t *ctx, const struct in6_addr *dst, int prefixlen,
-                 con=
st struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+   =
              const struct in6_addr *gw, const char *iface, int table, int =
metric)
 {
     return net_route_v6("del", dst, prefixlen, gw, iface, table=
, metric);
 }
diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvp=
n/networking_iproute2=2Ec
index d987478=2E=2E6c4c8f4 100644
--- a/src/openv=
pn/networking_iproute2=2Ec
+++ b/src/openvpn/networking_iproute2=2Ec
@@ -24=
3,7 +243,7 @@
 
 int
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const =
in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-                 const=
 char *iface, uint32_t table, int metric)
+                 const char *ifa=
ce, int table, int metric)
 {
     struct argv argv =3D argv_new();
     co=
nst char *dst_str =3D print_in_addr_t(*dst, 0, &argv=2Egc);
@@ -281,7 +281,=
7 @@
 
 int
 net_route_v6_add(const openvpn_net_ctx_t *ctx, const struct in=
6_addr *dst, int prefixlen,
-                 const struct in6_addr *gw, co=
nst char *iface, uint32_t table, int metric)
+                 const struct=
 in6_addr *gw, const char *iface, int table, int metric)
 {
     struct arg=
v argv =3D argv_new();
     char *dst_str =3D (char *)print_in6_addr(*dst, =
0, &argv=2Egc);
@@ -314,7 +314,7 @@
 
 int
 net_route_v4_del(const openvpn_=
net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw,
-=
                 const char *iface, uint32_t table, int metric)
+          =
       const char *iface, int table, int metric)
 {
     struct argv argv =
=3D argv_new();
     const char *dst_str =3D print_in_addr_t(*dst, 0, &argv=
=2Egc);
@@ -340,7 +340,7 @@
 
 int
 net_route_v6_del(const openvpn_net_ctx_=
t *ctx, const struct in6_addr *dst, int prefixlen,
-                 const =
struct in6_addr *gw, const char *iface, uint32_t table, int metric)
+      =
           const struct in6_addr *gw, const char *iface, int table, int met=
ric)
 {
     struct argv argv =3D argv_new();
     char *dst_str =3D (char =
*)print_in6_addr(*dst, 0, &argv=2Egc);
diff --git a/src/openvpn/networking_=
sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec
index b7c0f58=2E=2Eaf4ed27 100=
644
--- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sit=
nl=2Ec
@@ -1115,14 +1115,11 @@
 
 static int
 sitnl_route_add(const char *i=
face, sa_family_t af_family, const void *dst, int prefixlen,
-             =
   const void *gw, uint32_t table, int metric)
+                const void =
*gw, int table, int metric)
 {
     enum rt_scope_t scope =3D RT_SCOPE_UNIV=
ERSE;
-
-    if (table =3D=3D 0)
-    {
-        table =3D RT_TABLE_MAIN;
-=
    }
+    /* table 0 is RT_TABLE_UNSPEC */
+    const uint32_t rt_table =
=3D table > 0 ? (uint32_t)table : RT_TABLE_MAIN;
 
     if (!gw && iface)
 =
    {
@@ -1130,12 +1127,12 @@
     }
 
     return sitnl_route_set(RTM_NEWR=
OUTE, NLM_F_CREATE, iface, af_family, dst, prefixlen, gw,
-                =
           table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
+              =
             rt_table, metric, scope, RTPROT_BOOT, RTN_UNICAST);
 }
 
 int
=
 net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int p=
refixlen, const in_addr_t *gw,
-                 const char *iface, uint32_=
t table, int metric)
+                 const char *iface, int table, int me=
tric)
 {
     const in_addr_t *dst_ptr =3D NULL, *gw_ptr =3D NULL;
     in_=
addr_t dst_be =3D 0, gw_be =3D 0;
@@ -1154,7 +1151,7 @@
         gw_ptr =3D=
 &gw_be;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metri=
c %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric=
 %d", __func__,
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_st=
r)), prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str))=
, np(iface), table, metric);
 
@@ -1163,7 +1160,7 @@
 
 int
 net_route_v6_a=
dd(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,=

-                 const struct in6_addr *gw, const char *iface, uint32_t t=
able, int metric)
+                 const struct in6_addr *gw, const char *=
iface, int table, int metric)
 {
     inet_address_t dst_v6;
     inet_addr=
ess_t gw_v6;
@@ -1183,7 +1180,7 @@
         gw_v6=2Eipv6 =3D *gw;
     }
 
=
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+=
    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
  =
       inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefi=
xlen,
         inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), =
np(iface), table, metric);
 
@@ -1192,20 +1189,18 @@
 
 static int
 sitnl_r=
oute_del(const char *iface, sa_family_t af_family, const inet_address_t *ds=
t, int prefixlen,
-                const inet_address_t *gw, uint32_t table=
, int metric)
+                const inet_address_t *gw, int table, int met=
ric)
 {
-    if (table =3D=3D 0)
-    {
-        table =3D RT_TABLE_MAIN;
-=
    }
+    /* table 0 is RT_TABLE_UNSPEC */
+    const uint32_t rt_table =
=3D table > 0 ? (uint32_t)table : RT_TABLE_MAIN;
 
-    return sitnl_route_=
set(RTM_DELROUTE, 0, iface, af_family, dst, prefixlen, gw, table, metric,
+=
    return sitnl_route_set(RTM_DELROUTE, 0, iface, af_family, dst, prefixle=
n, gw, rt_table, metric,
                            RT_SCOPE_NOWHERE, 0, 0=
);
 }
 
 int
 net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_=
t *dst, int prefixlen, const in_addr_t *gw,
-                 const char *i=
face, uint32_t table, int metric)
+                 const char *iface, int =
table, int metric)
 {
     inet_address_t dst_v4;
     inet_address_t gw_v4=
;
@@ -1225,7 +1220,7 @@
         gw_v4=2Eipv4 =3D htonl(*gw);
     }
 
-   =
 msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+    =
msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
      =
   inet_ntop(AF_INET, &dst_v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,=

         inet_ntop(AF_INET, &gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(ifa=
ce), table, metric);
 
@@ -1234,7 +1229,7 @@
 
 int
 net_route_v6_del(const=
 openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,
-      =
           const struct in6_addr *gw, const char *iface, uint32_t table, in=
t metric)
+                 const struct in6_addr *gw, const char *iface, i=
nt table, int metric)
 {
     inet_address_t dst_v6;
     inet_address_t gw=
_v6;
@@ -1254,7 +1249,7 @@
         gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg=
(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
+    msg(=
D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
         i=
net_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
  =
       inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface=
), table, metric);
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/opt=
ions=2Ec
index 947439d=2E=2Ee51ece7 100644
--- a/src/openvpn/options=2Ec
++=
+ b/src/openvpn/options=2Ec
@@ -831,7 +831,7 @@
     o->ce=2Emssfix =3D 0;
=
     o->ce=2Emssfix_default =3D true;
     o->ce=2Emssfix_encap =3D true;
-=
    o->route_default_table_id =3D 0;
+    o->route_default_table_id =3D NET=
_ROUTE_TABLE_DEFAULT;
     o->route_delay_window =3D 30;
     o->resolve_re=
try_seconds =3D RESOLV_RETRY_INFINITE;
     o->resolve_in_advance =3D false=
;
@@ -5297,7 +5297,11 @@
         msg(M_WARN, "NOTE: --route-table is suppo=
rted only on Linux when SITNL is built-in");
 #endif
         VERIFY_PERMIS=
SION(OPT_P_ROUTE_TABLE);
-        options->route_default_table_id =3D posit=
ive_atoi(p[1], msglevel);
+        if (!atoi_constrained(p[1], &options->ro=
ute_default_table_id, p[0], 0, INT_MAX,
+                              msgl=
evel))
+        {
+            goto err;
+        }
     }
     else if (st=
req(p[0], "route") && p[1] && !p[5])
     {
diff --git a/src/openvpn/route=
=2Ec b/src/openvpn/route=2Ec
index 9086529=2E=2E82cb7f0 100644
--- a/src/op=
envpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@@ -545,6 +545,7 @@
         /*=
 split a route into two smaller blocking routes, and direct them to target =
*/
         l2 =3D ((~gateway->netmask) + 1) >> 1;
         r1->flags =3D R=
T_DEFINED;
+        r1->table_id =3D NET_ROUTE_TABLE_DEFAULT;
         r1->=
gateway =3D target;
         r1->network =3D gateway->addr & gateway->netma=
sk;
         r1->netmask =3D ~(l2 - 1);
@@ -854,6 +855,7 @@
               =
  r6->gateway =3D rl6->rgi6=2Egateway=2Eaddr_ipv6;
             }
         =
    r6->metric =3D 1;
+            r6->table_id =3D NET_ROUTE_TABLE_DEFAULT=
;
 #ifdef _WIN32
             r6->adapter_index =3D rl6->rgi6=2Eadapter_ind=
ex;
 #else
@@ -883,6 +885,7 @@
     struct route_ipv4 r;
     CLEAR(r);
   =
  r=2Eflags =3D RT_DEFINED;
+    r=2Etable_id =3D NET_ROUTE_TABLE_DEFAULT;
=
     r=2Enetwork =3D network;
     r=2Enetmask =3D netmask;
     r=2Egatewa=
y =3D gateway;
@@ -897,6 +900,7 @@
     struct route_ipv4 r;
     CLEAR(r);=

     r=2Eflags =3D RT_DEFINED | RT_ADDED;
+    r=2Etable_id =3D NET_ROUTE_=
TABLE_DEFAULT;
     r=2Enetwork =3D network;
     r=2Enetmask =3D netmask;
=
     r=2Egateway =3D gateway;
diff --git a/tests/unit_tests/openvpn/test_ne=
tworking=2Ec b/tests/unit_tests/openvpn/test_networking=2Ec
index b580d32=
=2E=2E636adda 100644
--- a/tests/unit_tests/openvpn/test_networking=2Ec
+++=
 b/tests/unit_tests/openvpn/test_networking=2Ec
@@ -112,7 +112,7 @@
     }
=
     printf("\n");
 
-    return net_route_v4_add(NULL, &dst, prefixlen, NU=
LL, iface, 0, metric);
+    return net_route_v4_add(NULL, &dst, prefixlen, =
NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static int
@@ -148,7 +=
148,7 @@
     }
     printf("\n");
 
-    return net_route_v4_add(NULL, &ds=
t, prefixlen, &gw, iface, 0, metric);
+    return net_route_v4_add(NULL, &d=
st, prefixlen, &gw, iface, NET_ROUTE_TABLE_DEFAULT, metric);
 }
 
 static i=
nt
@@ -175,7 +175,7 @@
     }
     printf("\n");
 
-    return net_route_v6=
_add(NULL, &dst, prefixlen, NULL, iface, 0, metric);
+    return net_route_=
v6_add(NULL, &dst, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric)=
;
 }
 
 static int
@@ -208,7 +208,7 @@
     }
     printf("\n");
 
-    ret=
urn net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, 0, metric);
+    re=
turn net_route_v6_add(NULL, &dst, prefixlen, &gw, iface, NET_ROUTE_TABLE_DE=
FAULT, metric);
 }
 
 static void

-- 
To view, visit https://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/2224?usp=3Demail
To unsubscribe, or for help writing =
mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Ge=
rrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master=

Gerrit-Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9
Gerrit-Change-=
Number: 2224
Gerrit-PatchSet: 3
Gerrit-Owner: R=C4=83zvan Cojocaru <razvanc=
@mailbox=2Eorg>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
=
Gerrit-Reviewer: Gert Doering <gert@greenie=2Emuc=2Ede>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: R=C4=83zv=
an Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Arne Schwabe <arne-op=
envpn@rfc2549=2Eorg>
Gerrit-Attention: Gert Doering <gert@greenie=2Emuc=2Ed=
e>

--uPJ9omVWeSE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Gert Doering, R=C4=83zvan Cojocaru=2E <=
/p>
<p>R=C4=83zvan Cojocaru <strong>uploaded patch set #3</strong> to this =
change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by Gert Doering</p><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">networking: u=
se NET_ROUTE_TABLE_DEFAULT (-1) for &quot;no route table&quot;<br><br>Table=
 0 meant &quot;default table&quot; in the net_route_*() API=2E That is fine=
 on<br>Linux, where table 0 is RT_TABLE_UNSPEC, but on FreeBSD FIB 0 is a r=
eal<br>FIB, which could then not be selected from a process running in anot=
her<br>FIB=2E<br><br>Make the table argument an int, with NET_ROUTE_TABLE_D=
EFAULT (-1) for<br>the default table, and default --route-table to it=2E An=
 invalid<br>--route-table value is now an error, instead of table 0=2E sitn=
l maps -1<br>and 0 to the main table, as before=2E On FreeBSD, -fib is now =
passed only<br>for a set table; DCO iroutes no longer force FIB 0 but use t=
he FIB of<br>the process=2E<br><br>Routes that route=2Ec creates internally=
 get it too; block-local routes<br>passed an uninitialized table before=2E<=
br><br>Change-Id: Icbfc6b64beea5e70f32449c5a63a08ad862597b9<br>Signed-off-b=
y: Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>---<br>M src/openvpn/dc=
o=2Ec<br>M src/openvpn/networking=2Eh<br>M src/openvpn/networking_freebsd=
=2Ec<br>M src/openvpn/networking_iproute2=2Ec<br>M src/openvpn/networking_s=
itnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/route=2Ec<br>M tests=
/unit_tests/openvpn/test_networking=2Ec<br>8 files changed, 74 insertions(+=
), 63 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenv=
pn=2Enet:29418/openvpn refs/changes/24/2224/3</pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/open=
vpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 236be93=2E=2Efdee46=
5 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/sr=
c/openvpn/dco=2Ec</span><br><span>@@ -721,7 +721,7 @@</span><br><span>     =
    }</span><br><span> </span><br><span>         net_route_v6_add(&amp;m-&g=
t;top=2Enet_ctx, &amp;addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                         gateway, c-&=
gt;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                         gateway, c-&gt;c1=2Etuntap-&gt;actu=
al_name, NET_ROUTE_TABLE_DEFAULT,</span><br><span>                         =
 DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>     }</span><=
br><span>@@ -739,7 +739,7 @@</span><br><span>         }</span><br><span> </=
span><br><span>         net_route_v4_add(&amp;m-&gt;top=2Enet_ctx, &amp;des=
t, addr-&gt;netbits, gateway,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         c-&gt;c1=2Etuntap-&gt;actual_name, 0, DCO_=
IROUTE_METRIC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                     c-&gt;c1=2Etuntap-&gt;actual_name, NET_ROUTE_TABLE_DEF=
AULT, DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>     }</s=
pan><br><span> #endif /* if defined(TARGET_LINUX) || defined(TARGET_FREEBSD=
) || defined(_WIN32) */</span><br><span>@@ -765,7 +765,7 @@</span><br><span=
>             dco_win_del_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, htonl=
(ir-&gt;network), ir-&gt;netbits);</span><br><span> #else</span><br><span> =
            net_route_v4_del(net_ctx, &amp;ir-&gt;network, ir-&gt;netbits,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
       &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;actual_na=
me, 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                &amp;c-&gt;c2=2Epush_ifconfig_local, c-&gt;c1=2Etuntap-&gt;=
actual_name, NET_ROUTE_TABLE_DEFAULT,</span><br><span>                     =
         DCO_IROUTE_METRIC);</span><br><span> #endif</span><br><span>      =
   }</span><br><span>@@ -779,7 +779,7 @@</span><br><span>         {</span><=
br><span>             /* On windows we do not install these routes, so we a=
lso do not need to delete them */</span><br><span>             net_route_v4=
_del(net_ctx, &amp;ifconfig_local, 32, NULL,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                             c-&gt;c1=2Etuntap-&gt;a=
ctual_name, 0, DCO_IROUTE_METRIC);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                             c-&gt;c1=2Etuntap-&gt;actual_na=
me, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);</span><br><span>         }=
</span><br><span> #endif</span><br><span>     }</span><br><span>@@ -792,7 +=
792,7 @@</span><br><span>             dco_win_del_iroute_ipv6(&amp;c-&gt;c1=
=2Etuntap-&gt;dco, ir6-&gt;network, ir6-&gt;netbits);</span><br><span> #els=
e</span><br><span>             net_route_v6_del(net_ctx, &amp;ir6-&gt;netwo=
rk, ir6-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                            &amp;c-&gt;c2=2Epush_ifconfig_ipv6_local, c-&gt=
;c1=2Etuntap-&gt;actual_name, 0,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                             &amp;c-&gt;c2=2Epush_ifconfig_ipv=
6_local, c-&gt;c1=2Etuntap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT,</span>=
<br><span>                              DCO_IROUTE_METRIC);</span><br><span=
> #endif</span><br><span>         }</span><br><span>@@ -805,7 +805,7 @@</sp=
an><br><span>         {</span><br><span>             /* On windows we do no=
t install these routes, so we also do not need to delete them */</span><br>=
<span>             net_route_v6_del(net_ctx, dest, 128, NULL,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                             c-&gt;=
c1=2Etuntap-&gt;actual_name, 0, DCO_IROUTE_METRIC);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                             c-&gt;c1=2Et=
untap-&gt;actual_name, NET_ROUTE_TABLE_DEFAULT, DCO_IROUTE_METRIC);</span><=
br><span>         }</span><br><span> #endif</span><br><span>     }</span><b=
r><span>diff --git a/src/openvpn/networking=2Eh b/src/openvpn/networking=2E=
h</span><br><span>index 7ad6e2e=2E=2Ef42ef4b 100644</span><br><span>--- a/s=
rc/openvpn/networking=2Eh</span><br><span>+++ b/src/openvpn/networking=2Eh<=
/span><br><span>@@ -24,6 +24,9 @@</span><br><span> </span><br><span> #defin=
e IFACE_TYPE_LEN_MAX 64</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/** net_route_*() table: Linux main table, FreeBSD FI=
B of the process */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define NET_ROUTE_TABLE_DEFAULT -1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> struct context;</span><br><span> </span><b=
r><span> #ifdef ENABLE_SITNL</span><br><span>@@ -245,14 +248,13 @@</span><b=
r><span>  * @param prefixlen the length of the prefix of the destination</s=
pan><br><span>  * @param gw        the gateway for this route</span><br><sp=
an>  * @param iface     the interface for this route (can be NULL)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param table     the table =
to add this route to (if 0, will be added to the</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *                  main table)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param table     the table to add=
 this route to, or NET_ROUTE_TABLE_DEFAULT</span><br><span>  * @param metri=
c    the metric associated with the route</span><br><span>  *</span><br><sp=
an>  * @return          0 on success, a negative error code otherwise</span=
><br><span>  */</span><br><span> int net_route_v4_add(const openvpn_net_ctx=
_t *ctx, const in_addr_t *dst, int prefixlen,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                     const in_addr_t *gw, const ope=
nvpn_net_iface_t *iface, uint32_t table,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                     const in_addr_t *gw, const openvp=
n_net_iface_t *iface, int table,</span><br><span>                      int =
metric);</span><br><span> </span><br><span> /**</span><br><span>@@ -263,14 =
+265,13 @@</span><br><span>  * @param prefixlen the length of the prefix of=
 the destination</span><br><span>  * @param gw        the gateway for this =
route</span><br><span>  * @param iface     the interface for this route (ca=
n be NULL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param t=
able     the table to add this route to (if 0, will be added to the</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- *                  main tabl=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param table  =
   the table to add this route to, or NET_ROUTE_TABLE_DEFAULT</span><br><sp=
an>  * @param metric    the metric associated with the route</span><br><spa=
n>  *</span><br><span>  * @return          0 on success, a negative error c=
ode otherwise</span><br><span>  */</span><br><span> int net_route_v6_add(co=
nst openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                     const=
 struct in6_addr *gw, const openvpn_net_iface_t *iface, uint32_t table,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                     co=
nst struct in6_addr *gw, const openvpn_net_iface_t *iface, int table,</span=
><br><span>                      int metric);</span><br><span> </span><br><=
span> /**</span><br><span>@@ -281,14 +282,13 @@</span><br><span>  * @param =
prefixlen the length of the prefix of the destination</span><br><span>  * @=
param gw        the gateway for this route</span><br><span>  * @param iface=
     the interface for this route (can be NULL)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- * @param table     the table to add this route t=
o (if 0, will be added to the</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- *                  main table)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param table     the table to add this route to, or =
NET_ROUTE_TABLE_DEFAULT</span><br><span>  * @param metric    the metric ass=
ociated with the route</span><br><span>  *</span><br><span>  * @return     =
     0 on success, a negative error code otherwise</span><br><span>  */</sp=
an><br><span> int net_route_v4_del(const openvpn_net_ctx_t *ctx, const in_a=
ddr_t *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                     const in_addr_t *gw, const openvpn_net_iface_t *i=
face, uint32_t table,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     const in_addr_t *gw, const openvpn_net_iface_t *ifac=
e, int table,</span><br><span>                      int metric);</span><br>=
<span> </span><br><span> /**</span><br><span>@@ -299,14 +299,13 @@</span><b=
r><span>  * @param prefixlen the length of the prefix of the destination</s=
pan><br><span>  * @param gw        the gateway for this route</span><br><sp=
an>  * @param iface     the interface for this route (can be NULL)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * @param table     the table =
to add this route to (if 0, will be added to the</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *                  main table)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param table     the table to add=
 this route to, or NET_ROUTE_TABLE_DEFAULT</span><br><span>  * @param metri=
c    the metric associated with the route</span><br><span>  *</span><br><sp=
an>  * @return          0 on success, a negative error code otherwise</span=
><br><span>  */</span><br><span> int net_route_v6_del(const openvpn_net_ctx=
_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     const struct in6_addr =
*gw, const openvpn_net_iface_t *iface, uint32_t table,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                     const struct in6_ad=
dr *gw, const openvpn_net_iface_t *iface, int table,</span><br><span>      =
                int metric);</span><br><span> </span><br><span> #endif /* E=
NABLE_SITNL || ENABLE_IPROUTE || TARGET_FREEBSD */</span><br><span>diff --g=
it a/src/openvpn/networking_freebsd=2Ec b/src/openvpn/networking_freebsd=2E=
c</span><br><span>index 88fd5c0=2E=2E8ba6326 100644</span><br><span>--- a/s=
rc/openvpn/networking_freebsd=2Ec</span><br><span>+++ b/src/openvpn/network=
ing_freebsd=2Ec</span><br><span>@@ -10,7 +10,7 @@</span><br><span> </span><=
br><span> static int</span><br><span> net_route_v4(const char *op, const in=
_addr_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-             const char *iface, uint32_t table,=
 int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      const char *iface, int table, int metric)</span><br><span> {</span><b=
r><span>     char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];</span><br><=
span>     in_addr_t _dst, _gw;</span><br><span>@@ -27,15 +27,20 @@</span><b=
r><span>     if (gw)</span><br><span>     {</span><br><span>         _gw =
=3D ntohl(*gw);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s -fib %d&quot;, ROUTE_PAT=
H, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_=
printf(&amp;argv, &quot;%s %s -net %s/%d %s&quot;, ROUTE_PATH, op,</span><b=
r><span>                     inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf=
1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
              inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)), table);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ine=
t_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)));</span><br><span>     }</spa=
n><br><span>     else</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        argv_printf(&amp;argv, &quot;%s %s -net %s/%=
d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s %s -net %s/%=
d -iface %s&quot;, ROUTE_PATH, op,</span><br><span>                     ine=
t_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    iface, table);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ifa=
ce);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* without -fib, route(8)=
 uses the FIB of the process */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (table &gt;=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        argv_printf_cat(&amp;argv, &quot;-fib %d&quot;, table);</span><b=
r><span>     }</span><br><span> </span><br><span>     argv_msg(M_INFO, &amp=
;argv);</span><br><span>@@ -48,7 +53,7 @@</span><br><span> </span><br><span=
> static int</span><br><span> net_route_v6(const char *op, const struct in6=
_addr *dst, int prefixlen, const struct in6_addr *gw,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             const char *iface, uint32_t ta=
ble, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          const char *iface, int table, int metric)</span><br><span> {</spa=
n><br><span>     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];</span=
><br><span>     struct argv argv =3D argv_new();</span><br><span>@@ -61,15 =
+66,19 @@</span><br><span>      */</span><br><span>     if (gw)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ar=
gv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s -fib %d&quot;, ROUTE_PATH=
, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_p=
rintf(&amp;argv, &quot;%s -6 %s -net %s/%d %s&quot;, ROUTE_PATH, op,</span>=
<br><span>                     inet_ntop(AF_INET6, dst, buf1, sizeof(buf1))=
, prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    inet_ntop(A=
F_INET6, gw, buf2, sizeof(buf2)));</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d -iface %=
s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d -ifac=
e %s&quot;, ROUTE_PATH, op,</span><br><span>                     inet_ntop(=
AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    iface, table);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    iface);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (table &gt;=3D 0)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        argv_printf_cat(&amp;argv, &quot;-fib %d&q=
uot;, table);</span><br><span>     }</span><br><span> </span><br><span> </s=
pan><br><span>@@ -83,28 +92,28 @@</span><br><span> </span><br><span> int</s=
pan><br><span> net_route_v4_add(const openvpn_net_ctx_t *ctx, const in_addr=
_t *dst, int prefixlen, const in_addr_t *gw,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                 const char *iface, uint32_t table, =
int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         const char *iface, int table, int metric)</span><br><span> {</span=
><br><span>     return net_route_v4(&quot;add&quot;, dst, prefixlen, gw, if=
ace, table, metric);</span><br><span> }</span><br><span> </span><br><span> =
int</span><br><span> net_route_v6_add(const openvpn_net_ctx_t *ctx, const s=
truct in6_addr *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                 const struct in6_addr *gw, const char *iface=
, uint32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                 const struct in6_addr *gw, const char *iface, in=
t table, int metric)</span><br><span> {</span><br><span>     return net_rou=
te_v6(&quot;add&quot;, dst, prefixlen, gw, iface, table, metric);</span><br=
><span> }</span><br><span> </span><br><span> int</span><br><span> net_route=
_v4_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, =
const in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                const char *iface, uint32_t table, int metric)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                 const char *ifa=
ce, int table, int metric)</span><br><span> {</span><br><span>     return n=
et_route_v4(&quot;del&quot;, dst, prefixlen, gw, iface, table, metric);</sp=
an><br><span> }</span><br><span> </span><br><span> int</span><br><span> net=
_route_v6_del(const openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int=
 prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
       const struct in6_addr *gw, const char *iface, uint32_t table, int me=
tric)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   const struct in6_addr *gw, const char *iface, int table, int metric)</sp=
an><br><span> {</span><br><span>     return net_route_v6(&quot;del&quot;, d=
st, prefixlen, gw, iface, table, metric);</span><br><span> }</span><br><spa=
n>diff --git a/src/openvpn/networking_iproute2=2Ec b/src/openvpn/networking=
_iproute2=2Ec</span><br><span>index d987478=2E=2E6c4c8f4 100644</span><br><=
span>--- a/src/openvpn/networking_iproute2=2Ec</span><br><span>+++ b/src/op=
envpn/networking_iproute2=2Ec</span><br><span>@@ -243,7 +243,7 @@</span><br=
><span> </span><br><span> int</span><br><span> net_route_v4_add(const openv=
pn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *gw=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 con=
st char *iface, uint32_t table, int metric)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 const char *iface, int table, int =
metric)</span><br><span> {</span><br><span>     struct argv argv =3D argv_n=
ew();</span><br><span>     const char *dst_str =3D print_in_addr_t(*dst, 0,=
 &amp;argv=2Egc);</span><br><span>@@ -281,7 +281,7 @@</span><br><span> </sp=
an><br><span> int</span><br><span> net_route_v6_add(const openvpn_net_ctx_t=
 *ctx, const struct in6_addr *dst, int prefixlen,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                 const struct in6_addr *gw, con=
st char *iface, uint32_t table, int metric)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                 const struct in6_addr *gw, const c=
har *iface, int table, int metric)</span><br><span> {</span><br><span>     =
struct argv argv =3D argv_new();</span><br><span>     char *dst_str =3D (ch=
ar *)print_in6_addr(*dst, 0, &amp;argv=2Egc);</span><br><span>@@ -314,7 +31=
4,7 @@</span><br><span> </span><br><span> int</span><br><span> net_route_v4=
_del(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, con=
st in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
             const char *iface, uint32_t table, int metric)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 const char *iface,=
 int table, int metric)</span><br><span> {</span><br><span>     struct argv=
 argv =3D argv_new();</span><br><span>     const char *dst_str =3D print_in=
_addr_t(*dst, 0, &amp;argv=2Egc);</span><br><span>@@ -340,7 +340,7 @@</span=
><br><span> </span><br><span> int</span><br><span> net_route_v6_del(const o=
penvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                 const struct i=
n6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 const struct in6_a=
ddr *gw, const char *iface, int table, int metric)</span><br><span> {</span=
><br><span>     struct argv argv =3D argv_new();</span><br><span>     char =
*dst_str =3D (char *)print_in6_addr(*dst, 0, &amp;argv=2Egc);</span><br><sp=
an>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openvpn/networking_s=
itnl=2Ec</span><br><span>index b7c0f58=2E=2Eaf4ed27 100644</span><br><span>=
--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>+++ b/src/openvpn/ne=
tworking_sitnl=2Ec</span><br><span>@@ -1115,14 +1115,11 @@</span><br><span>=
 </span><br><span> static int</span><br><span> sitnl_route_add(const char *=
iface, sa_family_t af_family, const void *dst, int prefixlen,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                const void *gw, uin=
t32_t table, int metric)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                const void *gw, int table, int metric)</span><br><span=
> {</span><br><span>     enum rt_scope_t scope =3D RT_SCOPE_UNIVERSE;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (table =3D=3D 0)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        table =3D RT_TABLE_MAIN;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* table 0 is RT_TABLE_UNSPEC */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const uint32_t rt_table =3D table &gt; 0 ? (=
uint32_t)table : RT_TABLE_MAIN;</span><br><span> </span><br><span>     if (=
!gw &amp;&amp; iface)</span><br><span>     {</span><br><span>@@ -1130,12 +1=
127,12 @@</span><br><span>     }</span><br><span> </span><br><span>     ret=
urn sitnl_route_set(RTM_NEWROUTE, NLM_F_CREATE, iface, af_family, dst, pref=
ixlen, gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                table, metric, scope, RTPROT_BOOT, RTN_UNICAST);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           rt_=
table, metric, scope, RTPROT_BOOT, RTN_UNICAST);</span><br><span> }</span><=
br><span> </span><br><span> int</span><br><span> net_route_v4_add(const ope=
nvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const in_addr_t *=
gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 c=
onst char *iface, uint32_t table, int metric)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                 const char *iface, int table, in=
t metric)</span><br><span> {</span><br><span>     const in_addr_t *dst_ptr =
=3D NULL, *gw_ptr =3D NULL;</span><br><span>     in_addr_t dst_be =3D 0, gw=
_be =3D 0;</span><br><span>@@ -1154,7 +1151,7 @@</span><br><span>         g=
w_ptr =3D &amp;gw_be;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d v=
ia %s dev %s table %u metric %d&quot;, __func__,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s=
 table %d metric %d&quot;, __func__,</span><br><span>         inet_ntop(AF_=
INET, &amp;dst_be, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>  =
       inet_ntop(AF_INET, &amp;gw_be, gw_str, sizeof(gw_str)), np(iface), t=
able, metric);</span><br><span> </span><br><span>@@ -1163,7 +1160,7 @@</spa=
n><br><span> </span><br><span> int</span><br><span> net_route_v6_add(const =
openvpn_net_ctx_t *ctx, const struct in6_addr *dst, int prefixlen,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 const struct =
in6_addr *gw, const char *iface, uint32_t table, int metric)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 const struct in6_=
addr *gw, const char *iface, int table, int metric)</span><br><span> {</spa=
n><br><span>     inet_address_t dst_v6;</span><br><span>     inet_address_t=
 gw_v6;</span><br><span>@@ -1183,7 +1180,7 @@</span><br><span>         gw_v=
6=2Eipv6 =3D *gw;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %=
s dev %s table %u metric %d&quot;, __func__,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s tab=
le %d metric %d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET=
6, &amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><spa=
n>         inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), =
np(iface), table, metric);</span><br><span> </span><br><span>@@ -1192,20 +1=
189,18 @@</span><br><span> </span><br><span> static int</span><br><span> si=
tnl_route_del(const char *iface, sa_family_t af_family, const inet_address_=
t *dst, int prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                const inet_address_t *gw, uint32_t table, int metric)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                const in=
et_address_t *gw, int table, int metric)</span><br><span> {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (table =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        table =3D RT_TABLE_MAIN;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* table 0 is RT_TABLE_UNSPEC */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const uint32_t rt_table =3D table=
 &gt; 0 ? (uint32_t)table : RT_TABLE_MAIN;</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    return sitnl_route_set(RTM_DELRO=
UTE, 0, iface, af_family, dst, prefixlen, gw, table, metric,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return sitnl_route_set(RTM_DEL=
ROUTE, 0, iface, af_family, dst, prefixlen, gw, rt_table, metric,</span><br=
><span>                            RT_SCOPE_NOWHERE, 0, 0);</span><br><span=
> }</span><br><span> </span><br><span> int</span><br><span> net_route_v4_de=
l(const openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen, const =
in_addr_t *gw,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
          const char *iface, uint32_t table, int metric)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                 const char *iface, in=
t table, int metric)</span><br><span> {</span><br><span>     inet_address_t=
 dst_v4;</span><br><span>     inet_address_t gw_v4;</span><br><span>@@ -122=
5,7 +1220,7 @@</span><br><span>         gw_v4=2Eipv4 =3D htonl(*gw);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric=
 %d&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&quot;, _=
_func__,</span><br><span>         inet_ntop(AF_INET, &amp;dst_v4=2Eipv4, ds=
t_str, sizeof(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_I=
NET, &amp;gw_v4=2Eipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);=
</span><br><span> </span><br><span>@@ -1234,7 +1229,7 @@</span><br><span> <=
/span><br><span> int</span><br><span> net_route_v6_del(const openvpn_net_ct=
x_t *ctx, const struct in6_addr *dst, int prefixlen,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 const struct in6_addr *gw,=
 const char *iface, uint32_t table, int metric)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                 const struct in6_addr *gw, con=
st char *iface, int table, int metric)</span><br><span> {</span><br><span> =
    inet_address_t dst_v6;</span><br><span>     inet_address_t gw_v6;</span=
><br><span>@@ -1254,7 +1249,7 @@</span><br><span>         gw_v6=2Eipv6 =3D =
*gw;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s tabl=
e %u metric %d&quot;, __func__,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric =
%d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET6, &amp;dst_v=
6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>         in=
et_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), ta=
ble, metric);</span><br><span> </span><br><span>diff --git a/src/openvpn/op=
tions=2Ec b/src/openvpn/options=2Ec</span><br><span>index 947439d=2E=2Ee51e=
ce7 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>++=
+ b/src/openvpn/options=2Ec</span><br><span>@@ -831,7 +831,7 @@</span><br><=
span>     o-&gt;ce=2Emssfix =3D 0;</span><br><span>     o-&gt;ce=2Emssfix_d=
efault =3D true;</span><br><span>     o-&gt;ce=2Emssfix_encap =3D true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;route_default_t=
able_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
-&gt;route_default_table_id =3D NET_ROUTE_TABLE_DEFAULT;</span><br><span>  =
   o-&gt;route_delay_window =3D 30;</span><br><span>     o-&gt;resolve_retr=
y_seconds =3D RESOLV_RETRY_INFINITE;</span><br><span>     o-&gt;resolve_in_=
advance =3D false;</span><br><span>@@ -5297,7 +5297,11 @@</span><br><span> =
        msg(M_WARN, &quot;NOTE: --route-table is supported only on Linux wh=
en SITNL is built-in&quot;);</span><br><span> #endif</span><br><span>      =
   VERIFY_PERMISSION(OPT_P_ROUTE_TABLE);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        options-&gt;route_default_table_id =3D positive_=
atoi(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!atoi_constrained(p[1], &amp;options-&gt;route_default_table_=
id, p[0], 0, INT_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              msglevel))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        }</span><br><span>     }</span><br><span>     else i=
f (streq(p[0], &quot;route&quot;) &amp;&amp; p[1] &amp;&amp; !p[5])</span><=
br><span>     {</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/op=
envpn/route=2Ec</span><br><span>index 9086529=2E=2E82cb7f0 100644</span><br=
><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=
=2Ec</span><br><span>@@ -545,6 +545,7 @@</span><br><span>         /* split =
a route into two smaller blocking routes, and direct them to target */</spa=
n><br><span>         l2 =3D ((~gateway-&gt;netmask) + 1) &gt;&gt; 1;</span>=
<br><span>         r1-&gt;flags =3D RT_DEFINED;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        r1-&gt;table_id =3D NET_ROUTE_TABLE_DEF=
AULT;</span><br><span>         r1-&gt;gateway =3D target;</span><br><span> =
        r1-&gt;network =3D gateway-&gt;addr &amp; gateway-&gt;netmask;</spa=
n><br><span>         r1-&gt;netmask =3D ~(l2 - 1);</span><br><span>@@ -854,=
6 +855,7 @@</span><br><span>                 r6-&gt;gateway =3D rl6-&gt;rgi=
6=2Egateway=2Eaddr_ipv6;</span><br><span>             }</span><br><span>   =
          r6-&gt;metric =3D 1;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            r6-&gt;table_id =3D NET_ROUTE_TABLE_DEFAULT;</span><=
br><span> #ifdef _WIN32</span><br><span>             r6-&gt;adapter_index =
=3D rl6-&gt;rgi6=2Eadapter_index;</span><br><span> #else</span><br><span>@@=
 -883,6 +885,7 @@</span><br><span>     struct route_ipv4 r;</span><br><span=
>     CLEAR(r);</span><br><span>     r=2Eflags =3D RT_DEFINED;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    r=2Etable_id =3D NET_ROUTE_T=
ABLE_DEFAULT;</span><br><span>     r=2Enetwork =3D network;</span><br><span=
>     r=2Enetmask =3D netmask;</span><br><span>     r=2Egateway =3D gateway=
;</span><br><span>@@ -897,6 +900,7 @@</span><br><span>     struct route_ipv=
4 r;</span><br><span>     CLEAR(r);</span><br><span>     r=2Eflags =3D RT_D=
EFINED | RT_ADDED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   r=2Etable_id =3D NET_ROUTE_TABLE_DEFAULT;</span><br><span>     r=2Enetwo=
rk =3D network;</span><br><span>     r=2Enetmask =3D netmask;</span><br><sp=
an>     r=2Egateway =3D gateway;</span><br><span>diff --git a/tests/unit_te=
sts/openvpn/test_networking=2Ec b/tests/unit_tests/openvpn/test_networking=
=2Ec</span><br><span>index b580d32=2E=2E636adda 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_networking=2Ec</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_networking=2Ec</span><br><span>@@ -112,7 +112,7 @@<=
/span><br><span>     }</span><br><span>     printf(&quot;\n&quot;);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
net_route_v4_add(NULL, &amp;dst, prefixlen, NULL, iface, 0, metric);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return net_route_v4_ad=
d(NULL, &amp;dst, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric);=
</span><br><span> }</span><br><span> </span><br><span> static int</span><br=
><span>@@ -148,7 +148,7 @@</span><br><span>     }</span><br><span>     prin=
tf(&quot;\n&quot;);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return net_route_v4_add(NULL, &amp;dst, prefixlen, &amp=
;gw, iface, 0, metric);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return net_route_v4_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, =
NET_ROUTE_TABLE_DEFAULT, metric);</span><br><span> }</span><br><span> </spa=
n><br><span> static int</span><br><span>@@ -175,7 +175,7 @@</span><br><span=
>     }</span><br><span>     printf(&quot;\n&quot;);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return net_route_v6_ad=
d(NULL, &amp;dst, prefixlen, NULL, iface, 0, metric);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return net_route_v6_add(NULL, &amp;ds=
t, prefixlen, NULL, iface, NET_ROUTE_TABLE_DEFAULT, metric);</span><br><spa=
n> }</span><br><span> </span><br><span> static int</span><br><span>@@ -208,=
7 +208,7 @@</span><br><span>     }</span><br><span>     printf(&quot;\n&quo=
t;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, 0, =
metric);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
net_route_v6_add(NULL, &amp;dst, prefixlen, &amp;gw, iface, NET_ROUTE_TABLE=
_DEFAULT, metric);</span><br><span> }</span><br><span> </span><br><span> st=
atic void</span><br></pre><p>To view, visit <a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/2224?usp=3Demail">change 2224</a>=2E To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"https://gerrit=2Eopenvp=
n=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D=
"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemt=
ype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/2224?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> G=
errit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-P=
roject: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master <=
/div>
<div style=3D"display:none"> Gerrit-Change-Id: Icbfc6b64beea5e70f3244=
9c5a63a08ad862597b9 </div>
<div style=3D"display:none"> Gerrit-Change-Numbe=
r: 2224 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div =
style=3D"display:none"> Gerrit-Owner: R=C4=83zvan Cojocaru &lt;razvanc@mail=
box=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Arne Sch=
wabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2E=
sourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention:=
 R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Gert Doering &lt;=
gert@greenie=2Emuc=2Ede&gt; </div>

</body></html>
--uPJ9omVWeSE=--


--===============7359296219201562905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7359296219201562905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7359296219201562905==--

