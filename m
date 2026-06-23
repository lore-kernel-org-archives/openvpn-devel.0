Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C50CDB46B
	for <openvpn-devel@archiver.kernel.org>; Tue, 23 Jun 2026 01:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a6Ctaxblc90uPeIeOHk91L6yXhTNVxPgG0/4SxuUjKQ=; b=A5cigNLZEwcpXs5z3FHyLyhtCx
	XXh7j9M+gHYoTxS2kMLxzYtXKVjboMIv8/PbthPo6gwf2g9GfVFfDMt1wNiyCYYEy8Nge9k5Gke6A
	P+Hpv9q4X07+fRct9kw/3eG2Hvu+ajIa382s5tIJafpGGmhLyqaDQnGWXjU11YPKr0aw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbqMg-0007Is-0t;
	Tue, 23 Jun 2026 01:55:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbqMM-0007Ic-CE
 for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 01:55:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=3TyjJcnagyperFxSEx5CcP/U3vTtEELq+LnuATEzM+4=; b=K5K6/F5wEMeACo2TtY5r0cuNb3
 Ij+pf7YeKkl5WlwXmNgMU77rKHELJ6s0g9VJKFGdByfuE7cH+6h9+lwMqMeUfFpU/XtRnCPFWNE6y
 eXOkY9HIZ/5jrHIp/YJfSnSBW1O7LZ+wkIm7sXHreb/36249yfBoIYEymuUuCsma1sk0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3TyjJcnagyperFxSEx5CcP/U3vTtEELq+LnuATEzM+4=; b=k
 Ie2+xY9RGPHhoKYk0gGciZkXNZFvpAtQfNXLHsa1P6aTIRSe4PrVrnpsGdAbC2sZwaZ91zuAzgDlX
 47ihyM36W05b3s0XoCichDfOwR9ObUbYTesQxhwm4DyIIWR+Kdu4gZDTev8t0rC2zggXsF0ItEpjU
 UXXY84o7f/UXbIfo=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbqMI-0002Ro-O3 for openvpn-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 01:55:31 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490cdae130cso24426695e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 18:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782179716; x=1782784516; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3TyjJcnagyperFxSEx5CcP/U3vTtEELq+LnuATEzM+4=;
 b=ZEKpSGeGVNSMAm6yR65Q7cp5DIOFJFULyjDtjRBBl6h+xtKGj0DDswXQsT3rvZD99O
 tmwFy0KUIgKX5vk7t8s3a8WGvtkhvwbEAh8thVi3ybtYISJFLzPHd+kWTc9qeW1owwOT
 LJ00Snyfb4ZJtE2TvihWcSoVMUWtNbyFJZFPctTfN0SGze16jnBZiAQEkVt4RW3B1j7O
 EDYNIpHD46Nxa22ZzE9lJFWh+Wj9kpQmYgmFHy3V/f0BgOICEvi2enkSHMMqLqH7VX1O
 Qdi05dtakb6QpX83Eb9wxaCPnUATuH/rEtqsOvZc8dCbruNtdggaVD3NfdV5ENis+FDY
 EIpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782179716; x=1782784516;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3TyjJcnagyperFxSEx5CcP/U3vTtEELq+LnuATEzM+4=;
 b=AbrdRT8RipJlaeFrD5+ptd4QUDdMARdVeGiSVBvic8DFpioUReTgpzBA5yuZKVAkuU
 EMYO2GkZl/JuWRXBjCFpB5FGoox63ycJFgTP5F96o+yRSaolXnpzaL4ksgxlfF0lgM4z
 tpT/Xy30MH/2wUNgQ8BatiTHDaMF6WaUp4ufxt5bx8o7dvinKYZLexwXXsrIFn74HR7s
 s9yVeSHflo4Fwb4cre5Sr1MgDn1dKTyvLNHovEWtjs7lcKneiXdFEArrSBfFv5xld1V+
 7wYfNdd6xBhQNuZUtQufQWzkGLPfMC47qEeSoLK/KmcNF3ge1vVnlLfHoYv09LC1Tw4F
 PLow==
X-Gm-Message-State: AOJu0YwpmznCbyz3SLvAu6eWa+Fwt/YTv2WKcZX+L+w3JknfLVEnat/7
 FjNUMZ9zlVBf34XHj4Pwxee04N5RVIpaaconHzVXxmWoF8Ew4tOoe4GTS//506oDYE8hHz8T0q1
 OQ6EmGvtQIMCagQKAVRYCutqL7U056Q/iz8pr5MvdNx4mYuQMMi/4daiiakNlZrF7Dxwl
X-Gm-Gg: AfdE7cliu4X3OcUJTnkzKlxZgYcm7Cyk0qc+EZODY+dPuhFZB5jKc6DG7Lbw3So6lxO
 ckkNO3lViQ7FDdPfXIji/bgRXzmP9LptPKm2OVVoM5UXwsi1U/TOvIh47FDLWs7VJSpI1Bod/tU
 ey2jJ/FIOcKCw2HfeuxIkubNOQ+R9BUKhgUFQ4sD3wXeZ5pvkC9jb+8tejrvIo22Fum1W/EvqEC
 DtyUlQi8FK641/b3J/0+zILSXX85T9y81Yym8fS7TI8hAn4UoET9V7FF3TEINk9saGrBubqvURC
 MmyEZV2o/ThuYhV+LIOT1Z3JwP2WxhQm06iwzy0GnS4E/fALEQF+Vr7Bg6swkV1PfP9AW4t5ZyT
 +mFXYVYMghiN8mFPJyt4nf8/I+vw3hvMiurBhDFnM+c7wZ+mfBWFLOhKDFJKIlKfzaZB8usi3/u
 0zm0TtkgUFsEnpVpjMLmAmLKwNE1dPwJYW4rEMTQ5Vn12tlQSwe/XMbDDNrT8O38LVfbItmFenj
 ysNwC+dr4HSRL4eRl325S7qx1a7Sf915X61MAfEUn/250gyX80dptC5aOFluh0/0vZ9USFdzWpz
 fy4nEobnRKxt1A==
X-Received: by 2002:a05:6000:5c4:b0:45e:e1a4:c4c3 with SMTP id
 ffacd0b85a97d-46adb490ee5mr808503f8f.15.1782179715262; 
 Mon, 22 Jun 2026 18:55:15 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4666cea9581sm29237741f8f.0.2026.06.22.18.55.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 18:55:14 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 23 Jun 2026 01:55:12 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 16
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 02829edd0828bd5af8934ffba182588901a03440
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <c0a223f7660b5765a7e74b8aae530a3e7beeed44-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbqMI-0002Ro-O3
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
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
From: "its_Giaan \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "its_Giaan \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6358060055669139296=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============6358060055669139296==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tdsyFSjHPkA="; charset=UTF-8

--tdsyFSjHPkA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos=2E=


Hello cron2, flichtenheld, plaisthos, 

I'd like you to reexamine a chang=
e=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=
=3Demail

to look at the new patch set (#16)=2E


Change subject: multipeer=
: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

multipeer: introduce asymmetric peer-id

In order to ac=
hieve a multipeer functionality, peers now
use separate IDs for sending (tx=
_peer_id) and receiving
(rx_peer_id)=2E

Each peer announces its own ID thr=
ough pushing peer-info
using 'ID=3D7f1' hex format so identification can st=
ill
happen even if IP/port changes=2E

In P2P mode, peer switch to using th=
e announced IDs after
mutual exchange=2E
In P2MP mode, clients always annou=
nce their ID, and servers
can optionally respond with their own to enable t=
he same
behavior=2E

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
S=
igned-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/op=
envpn/dco=2Ec
M src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/m=
ulti=2Ec
M src/openvpn/options=2Ec
M src/openvpn/push=2Ec
M src/openvpn/pus=
h_util=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn=
/ssl_ncp=2Ec
M src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
12 files=
 changed, 191 insertions(+), 47 deletions(-)


  git pull ssh://gerrit=2Eop=
envpn=2Enet:29418/openvpn refs/changes/89/1089/16

diff --git a/src/openvpn=
/dco=2Ec b/src/openvpn/dco=2Ec
index f5b7081=2E=2E901b9bd 100644
--- a/src/=
openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -528,14 +528,15 @@
         c-=
>c2=2Etls_multi->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_ne=
w_peer(&c->c1=2Etuntap->dco, multi->peer_id, sock->sd, NULL,
-             =
              proto_is_dgram(sock->info=2Eproto) ? remoteaddr : NULL, NULL,=
 NULL);
+    int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_=
id, sock->sd, NULL,
+                           proto_is_dgram(sock->info=
=2Eproto) ? remoteaddr : NULL,
+                           NULL, NULL);
   =
  if (ret < 0)
     {
         return ret;
     }
 
-    c->c2=2Etls_multi-=
>dco_peer_id =3D multi->peer_id;
+    c->c2=2Etls_multi->dco_peer_id =3D mu=
lti->rx_peer_id;
 
     return 0;
 }
@@ -610,7 +611,7 @@
 {
     struct con=
text *c =3D &mi->context;
 
-    int peer_id =3D c->c2=2Etls_multi->peer_id=
;
+    int peer_id =3D c->c2=2Etls_multi->rx_peer_id;
     struct sockaddr =
*remoteaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { =
0 };
     const socket_descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ =
-689,8 +690,7 @@
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined=
(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->v6=2E=
addr, addr->netbits,
-                                c->c2=2Etls_multi->pe=
er_id);
+        dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->v6=2Ea=
ddr, addr->netbits, c->c2=2Etls_multi->rx_peer_id);
 #else
         const s=
truct in6_addr *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
 =
        if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -706,8 +706,7 @@
     else =
if (addrtype =3D=3D MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_=
win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
-=
                                c->c2=2Etls_multi->peer_id);
+        dco_w=
in_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits, c-=
>c2=2Etls_multi->rx_peer_id);
 #else
         in_addr_t dest =3D htonl(addr=
->v4=2Eaddr);
         const in_addr_t *gateway =3D &mi->context=2Ec2=2Epus=
h_ifconfig_local;
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
=
index caaa769=2E=2E468c260 100644
--- a/src/openvpn/init=2Ec
+++ b/src/open=
vpn/init=2Ec
@@ -2209,7 +2209,7 @@
 
     if (o->use_peer_id)
     {
-     =
   buf_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out,=
 ", rx-peer-id: %u, tx-peer-id: %u", c->c2=2Etls_multi->rx_peer_id, c->c2=
=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2688,7 +2688,12 @@=

     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
        =
 c->c2=2Etls_multi->use_peer_id =3D true;
-        c->c2=2Etls_multi->peer_=
id =3D c->options=2Epeer_id;
+        c->c2=2Etls_multi->tx_peer_id =3D c->=
options=2Epeer_id;
+        if (!c->c2=2Etls_multi->use_asymmetric_peer_id)=

+        {
+            c->c2=2Etls_multi->rx_peer_id =3D c->options=2Epee=
r_id;
+            c->c2=2Etls_multi->tx_peer_id =3D c->options=2Epeer_id;
=
+        }
     }
 
     /* process (potentially) pushed options */
@@ -348=
5,6 +3490,10 @@
     if (c->c2=2Etls_multi)
     {
         tls_multi_init_=
finalize(c->c2=2Etls_multi, c->options=2Ece=2Etls_mtu);
+        if (c->c2=
=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
+        {
+            c->optio=
ns=2Euse_peer_id =3D true;
+        }
         ASSERT(c->c2=2Etls_multi->op=
t=2Eframe=2Ebuf=2Epayload_size <=3D c->c2=2Eframe=2Ebuf=2Epayload_size);
  =
       frame_print(&c->c2=2Etls_multi->opt=2Eframe, D_MTU_INFO, "Control Ch=
annel MTU parms");
 
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=
=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/openvpn/misc=2Ec
+++ b/src=
/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
         chomp(line);
      =
   if (validate_peer_info_line(line)
-            && (strncmp(line, "IV_", =
3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+            && (strncmp(=
line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0
+             =
   || strncmp(line, "ID", 2) =3D=3D 0))
         {
             msg(M_INFO,=
 "peer info: %s", line);
             env_set_add(es, line);
         }
   =
      else
         {
-            msg(M_WARN, "validation failed on peer_i=
nfo line received from client");
+            msg(M_WARN, "validation faile=
d on peer_info line received");
         }
     }
 }
diff --git a/src/openv=
pn/multi=2Ec b/src/openvpn/multi=2Ec
index a957fdf=2E=2Ee96d43c 100644
--- =
a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -430,7 +430,7 @@
   =
      if (mi->context=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
  =
           && dco_enabled(&mi->context=2Eoptions))
         {
-            =
buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=2Etls_multi->peer_id);
+=
            buf_printf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=2Etls_mul=
ti->rx_peer_id);
         }
         return BSTR(&out);
     }
@@ -598,9 +5=
98,9 @@
         }
 #endif
 
-        if (mi->context=2Ec2=2Etls_multi->pee=
r_id !=3D MAX_PEER_ID)
+        if (mi->context=2Ec2=2Etls_multi->rx_peer_i=
d !=3D MAX_PEER_ID)
         {
-            m->instances[mi->context=2Ec2=
=2Etls_multi->peer_id] =3D NULL;
+            m->instances[mi->context=2Ec2=
=2Etls_multi->rx_peer_id] =3D NULL;
 
             /* Adjust the max_peerid=
 as this might have been the highest
              * peer id instance */
@@=
 -908,8 +908,7 @@
 #else
                         sep,
 #endif
-           =
             sep,
-                        mi->context=2Ec2=2Etls_multi ? m=
i->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+                       =
 sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->rx_peer_=
id : MAX_PEER_ID,
                         sep, translate_cipher_name_to_op=
envpn(mi->context=2Eoptions=2Eciphername));
                 }
            =
     gc_free(&gc);
@@ -1727,6 +1726,7 @@
         tls_multi->use_peer_id =
=3D true;
         o->use_peer_id =3D true;
     }
+
     else if (dco_enab=
led(o))
     {
         msg(M_INFO, "Client does not support DATA_V2=2E Dat=
a channel offloading "
@@ -3121,12 +3121,12 @@
          * has, so we disal=
low it=2E This can happen if a DCO netlink notification
          * gets lo=
st and we miss a floating step=2E
          */
-        if (m1->peer_id =3D=
=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
       =
  {
             msg(M_WARN,
                 "disallowing peer %" PRIu32 "=
 (%s) from floating to "
                 "its own address (%s)",
-        =
        m1->peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
=
+                m1->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_mul=
ti, false),
                 mroute_addr_print(&mi->real, &gc));
          =
   goto done;
         }
@@ -3139,9 +3139,10 @@
     }
 
     msg(D_MULTI_M=
EDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        mi->context=
=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, f=
alse),
-        mroute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
-  =
      mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &gc));
+        mi->con=
text=2Ec2=2Etls_multi->rx_peer_id,
+        tls_common_name(mi->context=2Ec=
2=2Etls_multi, false),
+        mroute_addr_print(&mi->real, &gc),
+       =
 print_link_socket_actual(&m->top=2Ec2=2Efrom, &gc));
 
     /* remove old =
address from hash table before changing address */
     ASSERT(hash_remove(=
m->hash, &mi->real));
@@ -4086,7 +4087,7 @@
     {
         if (!m->instanc=
es[i])
         {
-            mi->context=2Ec2=2Etls_multi->peer_id =3D i;=

+            mi->context=2Ec2=2Etls_multi->rx_peer_id =3D i;
             =
m->instances[i] =3D mi;
             break;
         }
@@ -4095,11 +4096,11=
 @@
     /* should not really end up here, since multi_create_instance retu=
rns null
      * if amount of clients exceeds max_clients and this method w=
ould then
      * also not have been called */
-    ASSERT(mi->context=2Ec2=
=2Etls_multi->peer_id < m->max_clients);
+    ASSERT(mi->context=2Ec2=2Etls=
_multi->rx_peer_id < m->max_clients);
 
-    if (mi->context=2Ec2=2Etls_mul=
ti->peer_id > m->max_peerid)
+    if (mi->context=2Ec2=2Etls_multi->rx_peer=
_id > m->max_peerid)
     {
-        m->max_peerid =3D mi->context=2Ec2=2Et=
ls_multi->peer_id;
+        m->max_peerid =3D mi->context=2Ec2=2Etls_multi-=
>rx_peer_id;
     }
 }
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn=
/options=2Ec
index f414024=2E=2Eaededdf 100644
--- a/src/openvpn/options=2E=
c
+++ b/src/openvpn/options=2Ec
@@ -3887,6 +3887,7 @@
                     =
 "incompatible with each other=2E");
     }
 
+
     if (dco_enabled(o))
  =
   {
         /* check if any option should force disabling DCO */
diff --g=
it a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index e391147=2E=2Eee52638=
 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -661,9 +66=
1,10 @@
                         print_in_addr_t(c->c2=2Epush_ifconfig_remo=
te_netmask, 0, gc));
     }
 
-    if (tls_multi->use_peer_id)
+    if (!tl=
s_multi->use_asymmetric_peer_id)
     {
-        push_option_fmt(gc, push_l=
ist, M_USAGE, "peer-id %d", tls_multi->peer_id);
+        push_option_fmt(g=
c, push_list, M_USAGE, "peer-id %d",
+                        tls_multi->rx=
_peer_id);
     }
     /*
      * If server uses --auth-gen-token and we ha=
ve an auth token
diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_=
util=2Ec
index f57f54d=2E=2Ec927f26 100644
--- a/src/openvpn/push_util=2Ec
=
+++ b/src/openvpn/push_util=2Ec
@@ -188,7 +188,7 @@
         unsigned int p=
ermission_mask =3D pull_permission_mask(c);
         if (process_push_updat=
e(c, &o, permission_mask, &option_types_found, &tmp_msg, true) =3D=3D PUSH_=
MSG_ERROR)
         {
-            msg(M_WARN, "Failed to process push upda=
te message sent to client ID: %u", c->c2=2Etls_multi->peer_id);
+          =
  msg(M_WARN, "Failed to process push update message sent to client ID: %u"=
, c->c2=2Etls_multi->rx_peer_id);
         }
         e =3D e->next;
     }=

@@ -294,7 +294,7 @@
 
         if (!support_push_update(mi))
         {
- =
           msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported p=
eer with ID: %u", mi->context=2Ec2=2Etls_multi->peer_id);
+            msg(=
M_CLIENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u=
", mi->context=2Ec2=2Etls_multi->rx_peer_id);
             buffer_list_free=
(msgs);
             gc_free(&gc);
             return 0;
@@ -329,7 +329,7 =
@@
         /* Type is UPT_BROADCAST so we update every client */
         =
if (!send_single_push_update(m, curr_mi, msgs))
         {
-            msg=
(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi->context=2Ec2=
=2Etls_multi->peer_id);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has =
not been updated", curr_mi->context=2Ec2=2Etls_multi->rx_peer_id);
        =
     continue;
         }
         count++;
diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec
index 0998bd6=2E=2E044e852 100644
--- a/src/openvpn=
/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1168,7 +1168,10 @@
     /* get comma=
nd line derived options */
     ret->opt =3D *tls_options;
     ret->dco_pe=
er_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_p=
eer_id =3D false;
+    /* The rx_peer_id is also used to identify DCO clien=
ts */
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PE=
ER_ID;
 
     return ret;
 }
@@ -1181,6 +1184,24 @@
 
     tls_session_init=
(multi, &multi->session[TM_ACTIVE]);
     tls_session_init(multi, &multi->s=
ession[TM_INITIAL]);
+
+    if (!multi->opt=2Edco_enabled)
+    {
+        =
/* Calculate the asymmetric peer-id */
+        if (multi->rx_peer_id =3D=
=3D MAX_PEER_ID && multi->session[TM_INITIAL]=2Eopt->mode !=3D MODE_SERVER)=

+        {
+            uint8_t peerid[3];
+
+            if (rand_bytes(p=
eerid, sizeof(peerid)) !=3D 1)
+            {
+                msg(M_FATAL,=
 "rand_bytes() failed");
+            }
+
+            multi->rx_peer_id =
=3D ((uint32_t)peerid[0] << 16)
+                                | ((uint32=
_t)peerid[1] << 8)
+                                | (uint32_t)peerid[2];
=
+        }
+    }
 }
 
 /*
@@ -1858,6 +1879,25 @@
     return str;
 }
 
+st=
atic bool
+push_peer_info_peerid(struct buffer *out, struct tls_multi *mult=
i, struct tls_session *session)
+{
+    if (multi->rx_peer_id =3D=3D MAX_PE=
ER_ID || session->opt->dco_enabled)
+    {
+        /* No valid peer id or =
DCO is enabled=2E Cannot use this feature */
+        return true;
+    }
+=

+    /* In server mode we only add this when the client has announced its
=
+     * support for the feature */
+    if (session->opt->mode !=3D MODE_SE=
RVER || multi->use_asymmetric_peer_id)
+    {
+        return buf_printf(ou=
t, "ID=3D%x\n", multi->rx_peer_id);
+    }
+
+    return true;
+}
+
 /**
  =
* Prepares the IV_ and UV_ variables that are part of the
  * exchange to s=
ignal the peer's capabilities=2E The amount
@@ -1871,15 +1911,22 @@
  *
  *=
 @param buf       the buffer to write these variables to
  * @param session=
   the TLS session object
+ * @param multi     the TLS multi object
  * @re=
turn          true if no error was encountered
  */
 static bool
-push_peer=
_info(struct buffer *buf, struct tls_session *session)
+push_peer_info(stru=
ct buffer *buf, struct tls_multi *multi, struct tls_session *session)
 {
  =
   struct gc_arena gc =3D gc_new();
     bool ret =3D false;
     struct bu=
ffer out =3D alloc_buf_gc(512 * 3, &gc);
 
+    /* The asymmetric peer-id i=
s always written when enabled */
+    if (!push_peer_info_peerid(&out, mult=
i, session))
+    {
+        goto error;
+    }
+
     if (session->opt->pu=
sh_peer_info_detail > 1)
     {
         /* push version */
@@ -2027,7 +207=
4,9 @@
     }
     else
     {
-        if (!write_empty_string(buf)) /* no=
 peer info */
+        if (!(session->opt->mode =3D=3D MODE_SERVER && multi=
->use_asymmetric_peer_id
+                  ? write_string(buf, BSTR(&out),=
 -1)
+                  : write_empty_string(buf)))
         {
            =
 goto error;
         }
@@ -2156,7 +2205,7 @@
         }
     }
 
-    if (=
!push_peer_info(buf, session))
+    if (!push_peer_info(buf, multi, session=
))
     {
         goto error;
     }
@@ -2269,6 +2318,44 @@
     if (multi=
->peer_info)
     {
         output_peer_info_env(session->opt->es, multi->=
peer_info);
+        if (session->opt->mode =3D=3D MODE_SERVER)
+        {
=
+            if (!session->opt->dco_enabled)
+            {
+              =
  uint32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_info);
+     =
           if (peer_id !=3D MAX_PEER_ID)
+                {
+              =
      multi->tx_peer_id =3D peer_id;
+                    multi->use_asymme=
tric_peer_id =3D true;
+                    multi->use_peer_id =3D true;
+ =
               }
+                else
+                {
+                =
    /* Client has no asymmetric peer-id capability */
+                    =
multi->tx_peer_id =3D multi->rx_peer_id;
+                }
+            }
=
+            else
+            {
+                /* With DCO we don't need=
 the tx_peer_id atm */
+                multi->tx_peer_id =3D multi->rx_pee=
r_id;
+            }
+        }
+    }
+    else
+    {
+        free(multi=
->peer_info);
+        multi->peer_info =3D read_string_alloc(buf);
+    }
=
+    if (session->opt->mode =3D=3D MODE_POINT_TO_POINT && !session->opt->dc=
o_enabled)
+    {
+        uint32_t peer_id =3D extract_asymmetric_peer_id(=
multi->peer_info);
+        if (peer_id !=3D MAX_PEER_ID)
+        {
+     =
       multi->tx_peer_id =3D peer_id;
+            multi->use_asymmetric_pe=
er_id =3D true;
+            multi->use_peer_id =3D true;
+        }
     }=

 
     free(multi->remote_ciphername);
@@ -4005,8 +4092,8 @@
     msg(D_TL=
S_DEBUG, __func__);
 
     ASSERT(ks);
-
-    peer =3D htonl(((P_DATA_V2 <<=
 P_OPCODE_SHIFT) | ks->key_id) << 24 | (multi->peer_id & 0xFFFFFF));
+    p=
eer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
+         =
        | (multi->tx_peer_id & 0xFFFFFF));
     ASSERT(buf_write_prepend(bu=
f, &peer, 4));
 }
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/s=
sl_common=2Eh
index 6f310a5=2E=2E9a36fcf 100644
--- a/src/openvpn/ssl_commo=
n=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -697,8 +697,10 @@
 #define AUTH_T=
OKEN_VALID_EMPTYUSER (1 << 2)
 
     /* For P_DATA_V2 */
-    uint32_t peer=
_id;
+    uint32_t rx_peer_id;
+    uint32_t tx_peer_id;
     bool use_peer=
_id;
+    bool use_asymmetric_peer_id;
 
     char *remote_ciphername; /**<=
 cipher specified in peer's config file */
     bool remote_usescomp;    /*=
*< remote announced comp-lzo in OCC string */
diff --git a/src/openvpn/ssl_=
ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index 649665a=2E=2Ee860f6d 100644
--- a/s=
rc/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -406,6 +406,7 @@
 {=

     /* will return 0 if peer_info is null */
     const unsigned int iv_p=
roto_peer =3D extract_iv_proto(multi->peer_info);
+    const unsigned int t=
x_peer_id =3D extract_asymmetric_peer_id(multi->peer_info);
 
     /* The o=
ther peer does not support P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_N=
CP_P2P))
@@ -416,7 +417,11 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
  =
   {
         multi->use_peer_id =3D true;
-        multi->peer_id =3D 0x76=
706e; /* 'v' 'p' 'n' */
+        if (tx_peer_id =3D=3D MAX_PEER_ID)
+      =
  {
+            multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+       =
     multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        }
     }
 
=
     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -440,8 +445,16 @@
    =
 {
         session->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;=

 
-        if (multi->use_peer_id)
+        /* The asymmetric peer-id trum=
ps on the EKM generated ones */
+        if ((tx_peer_id !=3D MAX_PEER_ID) =
&& (!multi->opt=2Edco_enabled))
         {
+            multi->tx_peer_id =
=3D tx_peer_id;
+            multi->use_asymmetric_peer_id =3D true;
+     =
   }
+        else
+        {
+            multi->rx_peer_id =3D 0x76706e; =
/* 'v' 'p' 'n' */
+            multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' '=
n' */
             /* Using a non hardcoded peer-id makes a tiny bit harder=
 to
              * fingerprint packets and also gives each connection a un=
ique
              * peer-id that can be useful for NAT tracking etc=2E */
=
@@ -458,7 +471,8 @@
             }
             else
             {
-      =
          multi->peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[=
2];
+                multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] <=
< 8) + peerid[2];
+                multi->tx_peer_id =3D multi->rx_peer_id;=

             }
         }
     }
@@ -500,11 +514,13 @@
         common_cip=
her =3D BSTR(&out);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode N=
CP negotiation result: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %=
d, epoch=3D%d, cipher=3D%s",
-        (bool)(session->opt->crypto_flags & C=
O_USE_TLS_KEY_MATERIAL_EXPORT), multi->use_peer_id,
-        multi->peer_id=
, (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D=
_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                      =
   "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d=
, cipher=3D%s",
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY=
_MATERIAL_EXPORT),
+        multi->use_peer_id,
+        multi->rx_peer_id,=

+        multi->tx_peer_id,
+        (bool)(session->opt->crypto_flags & C=
O_EPOCH_DATA_KEY_FORMAT),
         common_cipher);
 
     gc_free(&gc);
dif=
f --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9e=
=2E=2E6561c48 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_u=
til=2Ec
@@ -24,7 +24,7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#include "op=
envpn=2Eh"
 #include "ssl_util=2Eh"
 
 char *
@@ -72,6 +72,24 @@
     retur=
n 0;
 }
 
+uint32_t
+extract_asymmetric_peer_id(const char *peer_info)
+{
+=
    const char *optstr =3D peer_info ? strstr(peer_info, "ID=3D") : NULL;
+=
    if (optstr)
+    {
+        uint32_t peer_id =3D 0;
+        int r =3D =
sscanf(optstr, "ID=3D%x", &peer_id);
+        {
+            if (r =3D=3D 1=
 && peer_id < MAX_PEER_ID)
+            {
+                return peer_id;
=
+            }
+        }
+    }
+    return MAX_PEER_ID;
+}
+
 const char =
*
 options_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
d=
iff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 2177d=
94=2E=2E1a69e6f 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl=
_util=2Eh
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(const char=
 *peer_info);
 
+
+/**
+ * Extracts the ID variable and returns its value o=
r
+ * MAX_PEER_ID if it cannot be extracted=2E
+ *
+ * @param peer_info    =
 peer info string to search for ID
+ */
+uint32_t extract_asymmetric_peer_i=
d(const char *peer_info);
+
 /**
  * Takes a locally produced OCC string fo=
r TLS server mode and modifies as
  * if the option comp-lzo was enabled=2E=
 This is to send a client in

-- 
To view, visit http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail f=
ilters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number:=
 1089
Gerrit-PatchSet: 16
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Eco=
m>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Att=
ention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichtenhel=
d <frank@lichtenheld=2Ecom>

--tdsyFSjHPkA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos=2E </p>
<p>its_Gia=
an <strong>uploaded patch set #16</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change=
</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">multipeer: introduce asymmetric peer-id<br><br>In ord=
er to achieve a multipeer functionality, peers now<br>use separate IDs for =
sending (tx_peer_id) and receiving<br>(rx_peer_id)=2E<br><br>Each peer anno=
unces its own ID through pushing peer-info<br>using &#39;ID=3D7f1&#39; hex =
format so identification can still<br>happen even if IP/port changes=2E<br>=
<br>In P2P mode, peer switch to using the announced IDs after<br>mutual exc=
hange=2E<br>In P2MP mode, clients always announce their ID, and servers<br>=
can optionally respond with their own to enable the same<br>behavior=2E<br>=
<br>Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Signed-off-by: =
Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/open=
vpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=2Ec<br>M src/op=
envpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/push=2Ec<br>M=
 src/openvpn/push_util=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_co=
mmon=2Eh<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M sr=
c/openvpn/ssl_util=2Eh<br>12 files changed, 191 insertions(+), 47 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/=
openvpn refs/changes/89/1089/16</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/=
src/openvpn/dco=2Ec</span><br><span>index f5b7081=2E=2E901b9bd 100644</span=
><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=
=2Ec</span><br><span>@@ -528,14 +528,15 @@</span><br><span>         c-&gt;c=
2=2Etls_multi-&gt;dco_peer_id =3D -1;</span><br><span>     }</span><br><spa=
n> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =
=3D dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;peer_id, sock-&g=
t;sd, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                 proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,=
 NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t ret =3D dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id=
, sock-&gt;sd, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           proto_is_dgram(sock-&gt;info=2Eproto) ? remotea=
ddr : NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                   NULL, NULL);</span><br><span>     if (ret &lt; 0)</span>=
<br><span>     {</span><br><span>         return ret;</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;peer_id;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco_=
peer_id =3D multi-&gt;rx_peer_id;</span><br><span> </span><br><span>     re=
turn 0;</span><br><span> }</span><br><span>@@ -610,7 +611,7 @@</span><br><s=
pan> {</span><br><span>     struct context *c =3D &amp;mi-&gt;context;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int =
peer_id =3D c-&gt;c2=2Etls_multi-&gt;peer_id;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_p=
eer_id;</span><br><span>     struct sockaddr *remoteaddr, *localaddr =3D NU=
LL;</span><br><span>     struct sockaddr_storage local =3D { 0 };</span><br=
><span>     const socket_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt=
;sd;</span><br><span>@@ -689,8 +690,7 @@</span><br><span>     if (addrtype =
=3D=3D MR_ADDR_IPV6)</span><br><span>     {</span><br><span> #if defined(_W=
IN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_=
add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&g=
t;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                     c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv6(&amp;c-=
&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits, c-&gt;c2=2Et=
ls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><span>         c=
onst struct in6_addr *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_=
ipv6_local;</span><br><span>         if (addr-&gt;type &amp; MR_ONLINK_DCO_=
ADDR)</span><br><span>@@ -706,8 +706,7 @@</span><br><span>     else if (add=
rtype =3D=3D MR_ADDR_IPV4)</span><br><span>     {</span><br><span> #if defi=
ned(_WIN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dc=
o_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, a=
ddr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                           c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv4(&=
amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-&gt;netbits, c-&gt;=
c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><span>    =
     in_addr_t dest =3D htonl(addr-&gt;v4=2Eaddr);</span><br><span>        =
 const in_addr_t *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_loca=
l;</span><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec=
</span><br><span>index caaa769=2E=2E468c260 100644</span><br><span>--- a/sr=
c/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><sp=
an>@@ -2209,7 +2209,7 @@</span><br><span> </span><br><span>     if (o-&gt;u=
se_peer_id)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        buf_printf(&amp;out, &quot;, peer-id: %d&quot;, o-&gt;=
peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bu=
f_printf(&amp;out, &quot;, rx-peer-id: %u, tx-peer-id: %u&quot;, c-&gt;c2=
=2Etls_multi-&gt;rx_peer_id, c-&gt;c2=2Etls_multi-&gt;tx_peer_id);</span><b=
r><span>     }</span><br><span> </span><br><span> #ifdef USE_COMP</span><br=
><span>@@ -2688,7 +2688,12 @@</span><br><span>     {</span><br><span>      =
   msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id set&quot;);</span><br><s=
pan>         c-&gt;c2=2Etls_multi-&gt;use_peer_id =3D true;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Etls_multi-&gt;peer=
_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&gt;options=
=2Epeer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (!c-&gt;c2=2Etls_multi-&gt;use_asymmetric_peer_id)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;rx_peer_id =3D=
 c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&gt;options=2Ep=
eer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span>     }</span><br><span> </span><br><span>     /* process (pot=
entially) pushed options */</span><br><span>@@ -3485,6 +3490,10 @@</span><b=
r><span>     if (c-&gt;c2=2Etls_multi)</span><br><span>     {</span><br><sp=
an>         tls_multi_init_finalize(c-&gt;c2=2Etls_multi, c-&gt;options=2Ec=
e=2Etls_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if (c-&gt;c2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            c-&gt;options=2Euse_peer_id =3D t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span>         ASSERT(c-&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Ebuf=2Epay=
load_size &lt;=3D c-&gt;c2=2Eframe=2Ebuf=2Epayload_size);</span><br><span> =
        frame_print(&amp;c-&gt;c2=2Etls_multi-&gt;opt=2Eframe, D_MTU_INFO, =
&quot;Control Channel MTU parms&quot;);</span><br><span> </span><br><span>d=
iff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>ind=
ex 10bfc35=2E=2Ea8c88c9 100644</span><br><span>--- a/src/openvpn/misc=2Ec</=
span><br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -765,14 +765,1=
5 @@</span><br><span>     {</span><br><span>         chomp(line);</span><br=
><span>         if (validate_peer_info_line(line)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            &amp;&amp; (strncmp(line, &quot;IV_=
&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (str=
ncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3=
) =3D=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       || strncmp(line, &quot;ID&quot;, 2) =3D=3D 0))</span><br><span>     =
    {</span><br><span>             msg(M_INFO, &quot;peer info: %s&quot;, l=
ine);</span><br><span>             env_set_add(es, line);</span><br><span> =
        }</span><br><span>         else</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;=
validation failed on peer_info line received from client&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;=
validation failed on peer_info line received&quot;);</span><br><span>      =
   }</span><br><span>     }</span><br><span> }</span><br><span>diff --git a=
/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index a957fd=
f=2E=2Ee96d43c 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br=
><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -430,7 +430,7 @@</spa=
n><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_d=
ebug_level(D_DCO_DEBUG)</span><br><span>             &amp;&amp; dco_enabled=
(&amp;mi-&gt;context=2Eoptions))</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quo=
t; peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&am=
p;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx=
_peer_id);</span><br><span>         }</span><br><span>         return BSTR(=
&amp;out);</span><br><span>     }</span><br><span>@@ -598,9 +598,9 @@</span=
><br><span>         }</span><br><span> #endif</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=
=2Etls_multi-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_p=
eer_id !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            m-&gt;instances[mi-&gt;context=
=2Ec2=2Etls_multi-&gt;peer_id] =3D NULL;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            m-&gt;instances[mi-&gt;context=2Ec2=2Etls_=
multi-&gt;rx_peer_id] =3D NULL;</span><br><span> </span><br><span>         =
    /* Adjust the max_peerid as this might have been the highest</span><br>=
<span>              * peer id instance */</span><br><span>@@ -908,8 +908,7 =
@@</span><br><span> #else</span><br><span>                         sep,</sp=
an><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                       sep,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                        mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;cont=
ext=2Ec2=2Etls_multi-&gt;peer_id : UINT32_MAX,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        sep, mi-&gt;context=2Ec2=
=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID=
,</span><br><span>                         sep, translate_cipher_name_to_op=
envpn(mi-&gt;context=2Eoptions=2Eciphername));</span><br><span>            =
     }</span><br><span>                 gc_free(&amp;gc);</span><br><span>@=
@ -1727,6 +1726,7 @@</span><br><span>         tls_multi-&gt;use_peer_id =3D=
 true;</span><br><span>         o-&gt;use_peer_id =3D true;</span><br><span=
>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span>     else if (dco_enabled(o))</span><br><span>     {</span><br><span> =
        msg(M_INFO, &quot;Client does not support DATA_V2=2E Data channel o=
ffloading &quot;</span><br><span>@@ -3121,12 +3121,12 @@</span><br><span>  =
        * has, so we disallow it=2E This can happen if a DCO netlink notifi=
cation</span><br><span>          * gets lost and we miss a floating step=2E=
</span><br><span>          */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (m1-&gt;peer_id =3D=3D m2-&gt;peer_id)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (m1-&gt;rx_peer_id =3D=3D =
m2-&gt;rx_peer_id)</span><br><span>         {</span><br><span>             =
msg(M_WARN,</span><br><span>                 &quot;disallowing peer %&quot;=
 PRIu32 &quot; (%s) from floating to &quot;</span><br><span>               =
  &quot;its own address (%s)&quot;,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                m1-&gt;peer_id, tls_common_name(mi-&gt;contex=
t=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                m1-&gt;rx_peer_id, tls_common_name(mi-&gt;context=
=2Ec2=2Etls_multi, false),</span><br><span>                 mroute_addr_pri=
nt(&amp;mi-&gt;real, &amp;gc));</span><br><span>             goto done;</sp=
an><br><span>         }</span><br><span>@@ -3139,9 +3139,10 @@</span><br><s=
pan>     }</span><br><span> </span><br><span>     msg(D_MULTI_MEDIUM, &quot=
;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec2=2Etls_m=
ulti-&gt;peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mroute_addr_pr=
int_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        mroute_addr_print_ex(&amp;real, MAP=
F_SHOW_FAMILY, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        tls_common_name(mi-&gt;co=
ntext=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        print_link_socket_act=
ual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc));</span><br><span> </span><br><spa=
n>     /* remove old address from hash table before changing address */</sp=
an><br><span>     ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real));</span>=
<br><span>@@ -4086,7 +4087,7 @@</span><br><span>     {</span><br><span>    =
     if (!m-&gt;instances[i])</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=2Etls_mu=
lti-&gt;peer_id =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id =3D i;</span>=
<br><span>             m-&gt;instances[i] =3D mi;</span><br><span>         =
    break;</span><br><span>         }</span><br><span>@@ -4095,11 +4096,11 =
@@</span><br><span>     /* should not really end up here, since multi_creat=
e_instance returns null</span><br><span>      * if amount of clients exceed=
s max_clients and this method would then</span><br><span>      * also not h=
ave been called */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 ASSERT(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id &lt; m-&gt;max_clients)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;=
context=2Ec2=2Etls_multi-&gt;rx_peer_id &lt; m-&gt;max_clients);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt=
;context=2Ec2=2Etls_multi-&gt;peer_id &gt; m-&gt;max_peerid)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Ec2=2Etls_=
multi-&gt;rx_peer_id &gt; m-&gt;max_peerid)</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;max_peerid =3D m=
i-&gt;context=2Ec2=2Etls_multi-&gt;peer_id;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2E=
tls_multi-&gt;rx_peer_id;</span><br><span>     }</span><br><span> }</span><=
br><span> </span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openv=
pn/options=2Ec</span><br><span>index f414024=2E=2Eaededdf 100644</span><br>=
<span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/optio=
ns=2Ec</span><br><span>@@ -3887,6 +3887,7 @@</span><br><span>              =
        &quot;incompatible with each other=2E&quot;);</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>     if (dco_enabled(o))</span><br><span>     {</span><br>=
<span>         /* check if any option should force disabling DCO */</span><=
br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br=
><span>index e391147=2E=2Eee52638 100644</span><br><span>--- a/src/openvpn/=
push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -661=
,9 +661,10 @@</span><br><span>                         print_in_addr_t(c-&g=
t;c2=2Epush_ifconfig_remote_netmask, 0, gc));</span><br><span>     }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tl=
s_multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!tls_multi-&gt;use_asymmetric_peer_id)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        push_option_fm=
t(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;peer_id);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_option_f=
mt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        tls_multi-&gt;rx_pee=
r_id);</span><br><span>     }</span><br><span>     /*</span><br><span>     =
 * If server uses --auth-gen-token and we have an auth token</span><br><spa=
n>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span>=
<br><span>index f57f54d=2E=2Ec927f26 100644</span><br><span>--- a/src/openv=
pn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br>=
<span>@@ -188,7 +188,7 @@</span><br><span>         unsigned int permission_=
mask =3D pull_permission_mask(c);</span><br><span>         if (process_push=
_update(c, &amp;o, permission_mask, &amp;option_types_found, &amp;tmp_msg, =
true) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Failed to p=
rocess push update message sent to client ID: %u&quot;, c-&gt;c2=2Etls_mult=
i-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_WARN, &quot;Failed to process push update message sent to cli=
ent ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span>   =
      }</span><br><span>         e =3D e-&gt;next;</span><br><span>     }</=
span><br><span>@@ -294,7 +294,7 @@</span><br><span> </span><br><span>      =
   if (!support_push_update(mi))</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;PUSH_=
UPDATE: not sending message to unsupported peer with ID: %u&quot;, mi-&gt;c=
ontext=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(M_CLIENT, &quot;PUSH_UPDATE: not sending =
message to unsupported peer with ID: %u&quot;, mi-&gt;context=2Ec2=2Etls_mu=
lti-&gt;rx_peer_id);</span><br><span>             buffer_list_free(msgs);</=
span><br><span>             gc_free(&amp;gc);</span><br><span>             =
return 0;</span><br><span>@@ -329,7 +329,7 @@</span><br><span>         /* T=
ype is UPT_BROADCAST so we update every client */</span><br><span>         =
if (!send_single_push_update(m, curr_mi, msgs))</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIE=
NT, &quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_CLIENT, &quot;ERROR: Peer ID: %u has not bee=
n updated&quot;, curr_mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</spa=
n><br><span>             continue;</span><br><span>         }</span><br><sp=
an>         count++;</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src=
/openvpn/ssl=2Ec</span><br><span>index 0998bd6=2E=2E044e852 100644</span><b=
r><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec=
</span><br><span>@@ -1168,7 +1168,10 @@</span><br><span>     /* get command=
 line derived options */</span><br><span>     ret-&gt;opt =3D *tls_options;=
</span><br><span>     ret-&gt;dco_peer_id =3D -1;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =3D MAX_PEER_ID;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;use_asymmetric_pee=
r_id =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* The rx_peer_id is also used to identify DCO clients */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;rx_peer_id =3D MAX_PEER_I=
D;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;tx_pe=
er_id =3D MAX_PEER_ID;</span><br><span> </span><br><span>     return ret;</=
span><br><span> }</span><br><span>@@ -1181,6 +1184,24 @@</span><br><span> <=
/span><br><span>     tls_session_init(multi, &amp;multi-&gt;session[TM_ACTI=
VE]);</span><br><span>     tls_session_init(multi, &amp;multi-&gt;session[T=
M_INITIAL]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=2Ed=
co_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Calculate t=
he asymmetric peer-id */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; multi-&=
gt;session[TM_INITIAL]=2Eopt-&gt;mode !=3D MODE_SERVER)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            uint8_t peerid[3];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (rand_bytes(peerid, sizeof(peerid)) !=3D 1=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_FA=
TAL, &quot;rand_bytes() failed&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      multi-&gt;rx_peer_id =3D ((uint32_t)peerid[0] &lt;&lt; 16)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
  | ((uint32_t)peerid[1] &lt;&lt; 8)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                | (uint32_t)peerid[2];</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><b=
r><span> </span><br><span> /*</span><br><span>@@ -1858,6 +1879,25 @@</span>=
<br><span>     return str;</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+push_peer_info_peerid(struct buffer *ou=
t, struct tls_multi *multi, struct tls_session *session)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || sessi=
on-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* No valid peer id or DCO is enabled=2E Cannot use this feature */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* In server mode we only add this when the client ha=
s announced its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * support for the feature */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (session-&gt;opt-&gt;mode !=3D MODE_SERVER || multi-&gt;us=
e_asymmetric_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn buf_printf(out, &quot;ID=3D%x\n&quot;, multi-&gt;rx_peer_id);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> /**</span><br><span>  * Prepares the IV_ and UV_ variables that ar=
e part of the</span><br><span>  * exchange to signal the peer&#39;s capabil=
ities=2E The amount</span><br><span>@@ -1871,15 +1911,22 @@</span><br><span=
>  *</span><br><span>  * @param buf       the buffer to write these variabl=
es to</span><br><span>  * @param session   the TLS session object</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi     the TLS m=
ulti object</span><br><span>  * @return          true if no error was encou=
ntered</span><br><span>  */</span><br><span> static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, struc=
t tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+push_peer_info(struct buffer *buf, struct tls_multi *multi, struct tls_=
session *session)</span><br><span> {</span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span>     bool ret =3D false;</span><br><span>  =
   struct buffer out =3D alloc_buf_gc(512 * 3, &amp;gc);</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The asymmetri=
c peer-id is always written when enabled */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!push_peer_info_peerid(&amp;out, multi, ses=
sion))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (session-&gt;opt=
-&gt;push_peer_info_detail &gt; 1)</span><br><span>     {</span><br><span> =
        /* push version */</span><br><span>@@ -2027,7 +2074,9 @@</span><br>=
<span>     }</span><br><span>     else</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (!write_empty_string(buf=
)) /* no peer info */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!(session-&gt;opt-&gt;mode =3D=3D MODE_SERVER &amp;&amp; mult=
i-&gt;use_asymmetric_peer_id</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                  ? write_string(buf, BSTR(&amp;out), -1)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                  : write_em=
pty_string(buf)))</span><br><span>         {</span><br><span>             g=
oto error;</span><br><span>         }</span><br><span>@@ -2156,7 +2205,7 @@=
</span><br><span>         }</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!push_peer_info(buf,=
 session))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
push_peer_info(buf, multi, session))</span><br><span>     {</span><br><span=
>         goto error;</span><br><span>     }</span><br><span>@@ -2269,6 +23=
18,44 @@</span><br><span>     if (multi-&gt;peer_info)</span><br><span>    =
 {</span><br><span>         output_peer_info_env(session-&gt;opt-&gt;es, mu=
lti-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!session-&gt;opt-&gt;dco_enabled=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                uint32_t=
 peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                if (peer_id !=3D =
MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           multi-&gt;tx_peer_id =3D peer_id;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    multi-&gt;use_asymmetric_peer_=
id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    /* Client has no asymmetric peer-=
id capability */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                /* With DCO we don&#39;t need t=
he tx_peer_id atm */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        fre=
e(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        multi-&gt;peer_info =3D read_string_alloc(buf);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt;mode =3D=3D MODE_POIN=
T_TO_POINT &amp;&amp; !session-&gt;opt-&gt;dco_enabled)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        uint32_t peer_id =3D extract_asymmetric_peer_=
id(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            multi-&gt;tx_peer_id =3D peer_id;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_asymmetric=
_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </=
span><br><span>     free(multi-&gt;remote_ciphername);</span><br><span>@@ -=
4005,8 +4092,8 @@</span><br><span>     msg(D_TLS_DEBUG, __func__);</span><b=
r><span> </span><br><span>     ASSERT(ks);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &l=
t;&lt; 24 | (multi-&gt;peer_id &amp; 0xFFFFFF));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCO=
DE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                 | (multi-&gt;tx_peer_id &amp; 0xFFFFFF)=
);</span><br><span>     ASSERT(buf_write_prepend(buf, &amp;peer, 4));</span=
><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/ss=
l_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 6f310a5=2E=
=2E9a36fcf 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -697,8 +697,10 =
@@</span><br><span> #define AUTH_TOKEN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span=
><br><span> </span><br><span>     /* For P_DATA_V2 */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t rx_peer_id;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    uint32_t tx_peer_id;</span><br><=
span>     bool use_peer_id;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    bool use_asymmetric_peer_id;</span><br><span> </span><br><span>=
     char *remote_ciphername; /**&lt; cipher specified in peer&#39;s config=
 file */</span><br><span>     bool remote_usescomp;    /**&lt; remote annou=
nced comp-lzo in OCC string */</span><br><span>diff --git a/src/openvpn/ssl=
_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index 649665a=2E=2Ee860f=
6d 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++=
 b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -406,6 +406,7 @@</span><br><s=
pan> {</span><br><span>     /* will return 0 if peer_info is null */</span>=
<br><span>     const unsigned int iv_proto_peer =3D extract_iv_proto(multi-=
&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const unsigned int tx_peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer=
_info);</span><br><span> </span><br><span>     /* The other peer does not s=
upport P2P NCP */</span><br><span>     if (!(iv_proto_peer &amp; IV_PROTO_N=
CP_P2P))</span><br><span>@@ -416,7 +417,11 @@</span><br><span>     if (iv_p=
roto_peer &amp; IV_PROTO_DATA_V2)</span><br><span>     {</span><br><span>  =
       multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        multi-&gt;peer_id =3D 0x76706e; /* &#39;v&#39; &#3=
9;p&#39; &#39;n&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (tx_peer_id =3D=3D MAX_PEER_ID)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#=
39; &#39;p&#39; &#39;n&#39; */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#=
39;p&#39; &#39;n&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span>     }</span><br><span> </span><br><span>   =
  if (iv_proto_peer &amp; IV_PROTO_CC_EXIT_NOTIFY)</span><br><span>@@ -440,=
8 +445,16 @@</span><br><span>     {</span><br><span>         session-&gt;op=
t-&gt;crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt;u=
se_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* The asymmetric peer-id trumps on the EKM generated ones */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if ((tx_peer_id !=3D MAX_=
PEER_ID) &amp;&amp; (!multi-&gt;opt=2Edco_enabled))</span><br><span>       =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            mult=
i-&gt;tx_peer_id =3D tx_peer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            multi-&gt;use_asymmetric_peer_id =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            multi-&gt;rx_peer_id =3D 0x76706e; /* &#39=
;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39=
; &#39;p&#39; &#39;n&#39; */</span><br><span>             /* Using a non ha=
rdcoded peer-id makes a tiny bit harder to</span><br><span>              * =
fingerprint packets and also gives each connection a unique</span><br><span=
>              * peer-id that can be useful for NAT tracking etc=2E */</spa=
n><br><span>@@ -458,7 +471,8 @@</span><br><span>             }</span><br><s=
pan>             else</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                multi-&gt;peer_id =3D (peer=
id[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;rx_peer_id =
=3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                multi-&gt;tx_=
peer_id =3D multi-&gt;rx_peer_id;</span><br><span>             }</span><br>=
<span>         }</span><br><span>     }</span><br><span>@@ -500,11 +514,13 =
@@</span><br><span>         common_cipher =3D BSTR(&amp;out);</span><br><sp=
an>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_TLS_DEBUG_LOW,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        &quot;P2P mode NCP negotiation result: &quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        &quot;TLS_export=3D%d, DAT=
A_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        (bool)(session-&gt;opt-&gt;crypto_f=
lags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT), multi-&gt;use_peer_id,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;peer_id, (bo=
ol)(session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, =
&quot;P2P mode NCP negotiation result: &quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                         &quot;TLS_export=3D%d, D=
ATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (bool)(sessio=
n-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;use_peer_id=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;=
rx_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
multi-&gt;tx_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_F=
ORMAT),</span><br><span>         common_cipher);</span><br><span> </span><b=
r><span>     gc_free(&amp;gc);</span><br><span>diff --git a/src/openvpn/ssl=
_util=2Ec b/src/openvpn/ssl_util=2Ec</span><br><span>index 71fbc9e=2E=2E656=
1c48 100644</span><br><span>--- a/src/openvpn/ssl_util=2Ec</span><br><span>=
+++ b/src/openvpn/ssl_util=2Ec</span><br><span>@@ -24,7 +24,7 @@</span><br>=
<span> #endif</span><br><span> </span><br><span> #include &quot;syshead=2Eh=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</=
span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span> </span><=
br><span> char *</span><br><span>@@ -72,6 +72,24 @@</span><br><span>     re=
turn 0;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+uint32_t</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+extract_asymmetric_peer_id(const char *peer_info)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const char *optstr =3D peer_info ? strstr(pee=
r_info, &quot;ID=3D&quot;) : NULL;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (optstr)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     uint32_t peer_id =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        int r =3D sscanf(optstr, &quot;ID=3D%x&quot;, &amp;peer_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (r =3D=3D 1 =
&amp;&amp; peer_id &lt; MAX_PEER_ID)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                return peer_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> con=
st char *</span><br><span> options_string_compat_lzo(const char *options, s=
truct gc_arena *gc)</span><br><span> {</span><br><span>diff --git a/src/ope=
nvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh</span><br><span>index 2177d94=
=2E=2E1a69e6f 100644</span><br><span>--- a/src/openvpn/ssl_util=2Eh</span><=
br><span>+++ b/src/openvpn/ssl_util=2Eh</span><br><span>@@ -53,6 +53,15 @@<=
/span><br><span>  */</span><br><span> unsigned int extract_iv_proto(const c=
har *peer_info);</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Extracts the ID v=
ariable and returns its value or</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * MAX_PEER_ID if it cannot be extracted=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param peer_info     peer info string to search for =
ID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+uint32_t extract_asymmetric_peer_=
id(const char *peer_info);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> /**</span><br><span>  * Takes a locally produced O=
CC string for TLS server mode and modifies as</span><br><span>  * if the op=
tion comp-lzo was enabled=2E This is to send a client in</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1089?usp=3Demail">change 1089</a>=2E To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/setti=
ngs?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schem=
a=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff=
639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"dis=
play:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emu=
c=2Ede&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhel=
d &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerri=
t-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhe=
ld=2Ecom&gt; </div>

</body></html>
--tdsyFSjHPkA=--


--===============6358060055669139296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6358060055669139296==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6358060055669139296==--

