Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB2DC98304
	for <openvpn-devel@archiver.kernel.org>; Thu, 24 Sep 2026 01:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=2TWTHsBSBQoNDTT3aLx7q4879J+XhJCb2kSJ1PDS2Js=; b=nJh8p3GpHsjj0p
	jlIN5/PLdggNtEA9ReLcyb5ZxXCQ78qJhSjqSzz+zpciAbXgThrh0n3oeo0UvYy0JuMWXY/VyZWke
	0dSY90uEUuZYcyCHp1v2hwE1Jhb3d5x91VPhZsBqu4OqYb1uhdw4NPMt6J+14vKUPEz5w7L8gzdcc
	lf4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1x9Xyy-0001eo-Lt;
	Thu, 24 Sep 2026 01:10:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1x9Xyw-0001ei-Ew
 for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:10:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1wD0BJxGwyZKAY/Wvu7wFAcykiSFRb80+fJH1CK2nfg=; b=K74YR6eK4ZZBPyYqbSoWoGhMwa
 vJbDEGzFf4reAaiFALOPG24ch6ItEz4yCj/V01fWRsm9SCxcTtznnvKifcSR5H7K+NbzmNH2a2jnv
 WGLKAkrF1P6aRwSGHFOxSKt254DjZdxulpet9yD4JvhAelRbLs9+r9EOEkx9yYG3ktpc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1wD0BJxGwyZKAY/Wvu7wFAcykiSFRb80+fJH1CK2nfg=; b=G
 ETEDpTSqFCNpLtX7bLLIWGp1VOYM5zV15VuqyAJ5JoD7LAWbK5e675KEicaVScJqg57f3kTrDxGMl
 xoY3FyiQTkxuXfc2VbkHN8OLOQY70P2YQLGsRa7ohk7fBLfcXZ8QLkYUqKlUUsVLxQnJtOaVldThd
 gVkfJTez0NqSdfjI=;
Received: from mail-wr2-f35.google.com ([74.125.225.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9Xyr-0007qY-IH for openvpn-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 01:10:35 +0000
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4858bc96fabso1294554f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 18:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790212227; x=1790817027; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1wD0BJxGwyZKAY/Wvu7wFAcykiSFRb80+fJH1CK2nfg=;
 b=b/O6itWXbVD+J0PnoaEyWq8dyQSEHUeW13Bps9ja/KBbMIk7DDiYpNUdVnfpA72vvm
 2E1UxpCL3S41CwzggfgalPztGaS9qT+sLxYrH37O3jwYZl3PGW/O28C7YOCa2vJYjVza
 6YY2t1+LWo/HF43uHp8GsjaRdlpYItZ9jXgEv0dWFgS2lzxyv3WxWX3g1+qYCFNvHGqO
 NEZvhY1F+TKhKYbOuDrz1ZXGK/Dbxh9uenxtS2a+jEF7U3hM7sPfAEnma89v9KjwKDvv
 McEnBz+YaY5acSz0dSJ73qzmjIz82lSHdqGBAjuD8aKxkla+WAyW1bW0L49EZfe9COTD
 APCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790212227; x=1790817027;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1wD0BJxGwyZKAY/Wvu7wFAcykiSFRb80+fJH1CK2nfg=;
 b=d0bIYF0TLgdjuMbsD7wB+YpRJqeCD1L/+vmUtyaP4HQMfboutxVZiuNKLGkkThdhlA
 l7A2CxCRnMjzpbvgBWU0uMCbYCJacD7G46nR7Xxnf/L9/kcAy3pknNzHO4k3tpKOoSgO
 IDNk3kYkTrUREkhqotiLwVkoryoQpVoP7T571WZrzo2HUV+wOVH8tpbOY3NPnIc3djSB
 iBodyYOjo2G5WkYA0E1iHlftQBe080BEdjeHIldcx2w4nBqHy01h5Av3Mc2Zbe7jzHhm
 PbBFwToiF8HcRw62QTtHuRX4oy8v45C1UmbiMaS910frwudb3bBA/TNPTnvC6E8lkn+k
 udpg==
X-Gm-Message-State: AFuF++kChKjOiGmi1G84hTFpS7zQ173Y+h+c0Ab8wdbyHbc/9Z0YEKcv
 J5Oetm6p6unzxA7z3seRUucbSB2ZX0x19nvjqliwA3sUuixz/FRUNsQX6R3pe+V07Uazo5AwzTu
 IsHqubZiKgU64TlRZ7sTYRSLHwbV6M3kPCa6Qo7wVkuqQD+GkrPJC7s+PC/PcEEfW4iDfLya1EU
 e4MpVebA==
X-Gm-Gg: AYBFou2wTC7YshWFEmmQrWWwgNHUIRwmbvCKt2Xv4XBgTRxxNEQ8gBVj/3Mjo9PxLq6
 FPJKTbGhqYlth/TmnNyXIJ+qdQv5WVsvgX1EI82htILnX1Kp+D2GedlQgavebbQj/tDN3FwLVOG
 ivhkSIuDp7cs+F+ZzPOSqExIY/oC1sWzHhhuNIlsB/wllUnzaAHggnpIFPK6n6SIul6v3tFO0En
 n819WRFffojkSElhN7H4bMFWeTp1hpKXDBp1bUeD0jWyM6wUlZ/AlQt2KcciA659dxmI6VNeZlt
 Lk4Ul0LaYX96YfQ99RI6tRfodbuXtR60QizQpQ3kxVhDHBt2+8dQwauHAN9xlDXNA+KldwEjpFx
 RXreuH+1aVO2iTjsxtFzztWVNNkjjnKaYunRzRb6d6xWBNoBLkZqAYhRqSwry/6X+Afhoygfg0c
 /esTR3s2nGOVx+AJixEwHi07LwHlzykBiVoZUDYwgGt13A7sSVKkf5umtN1GW1Vd2vbd1YkZeYP
 DilziGkpeJFm4hXjxJPudH3x+m74dtUW5Pkb/P9oGDBeeTvkud3e6TMB4A5kWJvIi9vy6f8/UM/
 aXHuLlaSt5ukgfT2K2FbFLWljCSdyYxQ6hJNvZypbjJ0yUDhH07j3kedqLqJ
X-Received: by 2002:a05:6000:98c:b0:488:6548:ff9d with SMTP id
 ffacd0b85a97d-48872abc6eemr592892f8f.37.1790212226832; 
 Wed, 23 Sep 2026 18:10:26 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4886848646dsm9643874f8f.10.2026.09.23.18.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 18:10:26 -0700 (PDT)
X-Google-Original-From: "chugly (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 24 Sep 2026 01:10:25 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690
X-Gerrit-Change-Number: 1947
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1947?usp=email>
X-Gerrit-Commit: a3cbadf262ff60a37a073fc3ae0c50fb9cc7b509
References: <gerrit.1790212215000.I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwMjEyMjE1MDAwLkk5ZTQ1YzBlZGJkMmNiMjM3ZjI3ZTM0OWYyZjlkN2Q5YjhkODI2NjkwQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <283f750a9dc2b0dd0a74a6352ca925c0a1638995-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1x9Xyr-0007qY-IH
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route: implement
 net_gateway_ipv6 for --route-ipv6
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
Content-Type: multipart/mixed; boundary="===============1495976974794351590=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1495976974794351590==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0Xr5l/tTGRE="; charset=UTF-8

--0Xr5l/tTGRE=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1947?usp=3Demail

to review the following change=2E


Chang=
e subject: route: implement net_gateway_ipv6 for --route-ipv6
=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

route: implement net_gate=
way_ipv6 for --route-ipv6

--route has been able to name the system default=
 gateway symbolically for
a long time: get_special_addr() resolves net_gate=
way, vpn_gateway and
remote_host=2E  --route-ipv6 never gained the equivale=
nt, so the usual IPv4
idiom for keeping specific traffic off the tunnel has=
 no IPv6 counterpart=2E

The failure is silent and points the wrong way=2E =
 init_route_ipv6() hands
the gateway parameter straight to inet_pton(), whi=
ch rejects
"net_gateway_ipv6" with a warning and leaves the gateway unset=
=2E
add_route_ipv6() then falls back to device =3D tt->actual_name, so a ro=
ute
meant to bypass the tunnel is installed through it instead -- the exact=

opposite of what was asked for=2E

Resolve the name from rl6->ngi6, which =
init_route_ipv6_list() already
fills with the system default gateway and ex=
ports to scripts under this
very name, and pin the route to that gateway's =
interface so it leaves the
host the same way the corresponding IPv4 route d=
oes=2E  Note this is ngi6
and not rgi6: the latter is the route towards the=
 VPN server, which only
coincides with the default gateway on a singly-home=
d host=2E  An on-link
gateway is not a next hop, so only the interface is s=
et in that case=2E

Cover the three outcomes in route_testdriver: a resolve=
d gateway, one
the system could not supply, and an on-link gateway where on=
ly the
interface is wanted=2E

This revives the patch originally submitted =
in 2021 for Trac #1161=2E

Github: OpenVPN/openvpn#1015
Change-Id: I9e45c0e=
dbd2cb237f27e349f2f9d7d9b8d826690
Signed-off-by: Fran=C3=A7ois Kooman <fkoo=
man@tuxed=2Enet>
Signed-off-by: Charlie Vigue <charlie=2Evigue@openvpn=2Eco=
m>
---
M src/openvpn/options=2Ec
M src/openvpn/route=2Ec
M src/openvpn/rout=
e=2Eh
M tests/unit_tests/openvpn/test_route=2Ec
4 files changed, 183 insert=
ions(+), 3 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/47/1947/1

diff --git a/src/openvpn/options=2Ec b/src/op=
envpn/options=2Ec
index e899fa6=2E=2E0badd88 100644
--- a/src/openvpn/optio=
ns=2Ec
+++ b/src/openvpn/options=2Ec
@@ -4661,7 +4661,7 @@
             msg=
(msglevel, "route-ipv6 parameter network/IP '%s' must be a valid address", =
p[1]);
             return false;
         }
-        if (p[2] && !ipv6_add=
r_safe(p[2]))
+        if (p[2] && !ipv6_addr_safe(p[2]) && !ipv6_get_speci=
al_addr(NULL, p[2], NULL, NULL))
         {
             msg(msglevel, "rou=
te-ipv6 parameter gateway '%s' must be a valid address", p[2]);
           =
  return false;
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
=
index 8ea745d=2E=2E23e7e7a 100644
--- a/src/openvpn/route=2Ec
+++ b/src/ope=
nvpn/route=2Ec
@@ -297,6 +297,65 @@
     return false;
 }
 
+/**
+ * Resolv=
e the special IPv6 gateway name "net_gateway_ipv6"=2E
+ *
+ * The IPv6 coun=
terpart of get_special_addr(), which handles the IPv4 names=2E
+ * There is=
 currently only one special IPv6 name=2E
+ *
+ * @param rl        route lis=
t carrying the system default gateway in ngi6
+ *                  (not rgi=
6, which is the route towards the VPN server), or
+ *                  NULL=
 to merely test whether @p string names a special
+ *                  addr=
ess (used when validating options, where no route
+ *                  list=
 exists yet)
+ * @param string    the --route-ipv6 gateway parameter to exa=
mine
+ * @param out       receives the resolved gateway; only written when =
@p rl is
+ *                  given and the system gateway is known
+ * @pa=
ram status    set to false if @p string names a special address that
+ *   =
               could not be resolved, so the caller can reject the route;
+=
 *                  set to true otherwise=2E May be NULL=2E
+ *
+ * @return=
 true if @p string is a special address name, in which case the
+ *        =
 caller must not parse it as a literal address; false otherwise=2E
+ */
+bo=
ol
+ipv6_get_special_addr(const struct route_ipv6_list *rl, const char *str=
ing, struct in6_addr *out,
+                      bool *status)
+{
+    if =
(status)
+    {
+        *status =3D true;
+    }
+
+    if (strcmp(string,=
 "net_gateway_ipv6") !=3D 0)
+    {
+        return false;
+    }
+
+    if=
 (rl)
+    {
+        if (rl->ngi6=2Eflags & RGI_ADDR_DEFINED)
+        {
+=
            /* an on-link gateway is not a next hop, the interface is
+    =
         * enough -- leave *out unspecified in that case */
+            if=
 (!(rl->ngi6=2Eflags & RGI_ON_LINK))
+            {
+                *out =
=3D rl->ngi6=2Egateway=2Eaddr_ipv6;
+            }
+        }
+        else=

+        {
+            msg(M_INFO, PACKAGE_NAME " ROUTE: net_gateway_ipv6=
 undefined -- unable to get default "
+                                    =
 "gateway from system");
+            if (status)
+            {
+         =
       *status =3D false;
+            }
+        }
+    }
+    return true=
;
+}
+
 bool
 is_special_addr(const char *addr_str)
 {
@@ -435,7 +494,7 @@
=
 
 static bool
 init_route_ipv6(struct route_ipv6 *r6, const struct route_i=
pv6_option *r6o,
-                const struct route_ipv6_list *rl6)
+     =
           struct route_ipv6_list *rl6)
 {
     CLEAR(*r6);
 
@@ -447,7 +50=
6,26 @@
     /* gateway */
     if (is_route_parm_defined(r6o->gateway))
  =
   {
-        if (inet_pton(AF_INET6, r6o->gateway, &r6->gateway) !=3D 1)
+=
        bool status =3D true;
+
+        if (ipv6_get_special_addr(rl6, r6o=
->gateway, &r6->gateway, &status))
+        {
+            if (!status)
+  =
          {
+                goto fail;
+            }
+            /* the =
route has to leave via the interface the system gateway
+             * is =
on, otherwise it would be sent down the tunnel */
+            if (rl6->ngi=
6=2Eflags & RGI_IFACE_DEFINED)
+            {
+#ifdef _WIN32
+             =
   r6->adapter_index =3D rl6->ngi6=2Eadapter_index;
+#else
+               =
 r6->iface =3D rl6->ngi6=2Eiface;
+#endif
+            }
+        }
+      =
  else if (inet_pton(AF_INET6, r6o->gateway, &r6->gateway) !=3D 1)
        =
 {
             msg(M_WARN, PACKAGE_NAME "ROUTE6: cannot parse gateway spec=
 '%s'", r6o->gateway);
         }
diff --git a/src/openvpn/route=2Eh b/src/=
openvpn/route=2Eh
index 88107e9=2E=2E90e3ad2 100644
--- a/src/openvpn/route=
=2Eh
+++ b/src/openvpn/route=2Eh
@@ -345,6 +345,8 @@
 void setenv_routes_ip=
v6(struct env_set *es, const struct route_ipv6_list *rl6);
 
 bool is_speci=
al_addr(const char *addr_str);
+bool ipv6_get_special_addr(const struct rou=
te_ipv6_list *rl, const char *string,
+                           struct in=
6_addr *out, bool *status);
 
 /**
  * @brief Retrieves the best gateway fo=
r a given destination based on the routing table=2E
diff --git a/tests/unit=
_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=2Ec
ind=
ex db039c1=2E=2Ebfcccb8 100644
--- a/tests/unit_tests/openvpn/test_route=2E=
c
+++ b/tests/unit_tests/openvpn/test_route=2Ec
@@ -31,6 +31,10 @@
 #includ=
e "route=2Eh"
 #include "networking=2Eh"
 
+/* the system default IPv6 gate=
way, and the route towards the peer */
+#define NET_GATEWAY6  "2001:db8:1::=
1"
+#define PEER_GATEWAY6 "2001:db8:2::1"
+
 /* Stubs for functions route=
=2Ec references but that no test here reaches=2E
  * They assert rather tha=
n return quietly, so a test straying onto one
  * fails loudly instead of s=
ilently doing nothing=2E
@@ -210,11 +214,107 @@
     assert_clear_host_bits=
("2001:db8::1", 0, "::");
 }
 
+/* Set up a route list where the system def=
ault gateway (ngi6) and the
+ * route towards the peer (rgi6) are different=
, so a test can tell which
+ * one an answer came from=2E
+ */
+static void=

+init_test_route_ipv6_list(struct route_ipv6_list *rl6, unsigned int ngi6_=
flags)
+{
+    CLEAR(*rl6);
+
+    assert_int_equal(inet_pton(AF_INET6, NET=
_GATEWAY6, &rl6->ngi6=2Egateway=2Eaddr_ipv6), 1);
+    rl6->ngi6=2Eflags =
=3D ngi6_flags;
+
+    assert_int_equal(inet_pton(AF_INET6, PEER_GATEWAY6, =
&rl6->rgi6=2Egateway=2Eaddr_ipv6), 1);
+    rl6->rgi6=2Eflags =3D RGI_ADDR_=
DEFINED;
+}
+
+static void
+test_ipv6_get_special_addr_resolves(void **stat=
e)
+{
+    struct route_ipv6_list rl6;
+    struct in6_addr out, expect;
+ =
   bool status =3D false;
+
+    init_test_route_ipv6_list(&rl6, RGI_ADDR_D=
EFINED);
+    CLEAR(out);
+
+    assert_true(ipv6_get_special_addr(&rl6, "n=
et_gateway_ipv6", &out, &status));
+    assert_true(status);
+
+    /* the =
system default gateway, not the route towards the peer */
+    assert_int_e=
qual(inet_pton(AF_INET6, NET_GATEWAY6, &expect), 1);
+    assert_memory_equ=
al(&out, &expect, sizeof(out));
+}
+
+static void
+test_ipv6_get_special_ad=
dr_not_special(void **state)
+{
+    struct route_ipv6_list rl6;
+    struc=
t in6_addr out;
+    bool status =3D false;
+
+    init_test_route_ipv6_lis=
t(&rl6, RGI_ADDR_DEFINED);
+    CLEAR(out);
+
+    assert_false(ipv6_get_sp=
ecial_addr(&rl6, "2001:db8::1", &out, &status));
+    assert_true(IN6_IS_AD=
DR_UNSPECIFIED(&out));
+
+    /* the IPv4 names are not IPv6 names */
+    =
assert_false(ipv6_get_special_addr(&rl6, "net_gateway", &out, &status));
+
=
+    /* a caller with no route list only learns whether the name is special=
 */
+    assert_true(ipv6_get_special_addr(NULL, "net_gateway_ipv6", NULL, =
NULL));
+    assert_false(ipv6_get_special_addr(NULL, "2001:db8::1", NULL, =
NULL));
+}
+
+static void
+test_ipv6_get_special_addr_undefined(void **stat=
e)
+{
+    struct route_ipv6_list rl6;
+    struct in6_addr out;
+    bool =
status =3D true;
+
+    /* no IPv6 default gateway on this system */
+    i=
nit_test_route_ipv6_list(&rl6, 0);
+    CLEAR(out);
+
+    /* still a speci=
al name, but one that could not be resolved, so the
+     * caller must rej=
ect the route rather than install it via the tunnel
+     */
+    assert_tr=
ue(ipv6_get_special_addr(&rl6, "net_gateway_ipv6", &out, &status));
+    as=
sert_false(status);
+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&out));
+}
+
+=
static void
+test_ipv6_get_special_addr_on_link(void **state)
+{
+    struc=
t route_ipv6_list rl6;
+    struct in6_addr out;
+    bool status =3D false=
;
+
+    init_test_route_ipv6_list(&rl6, RGI_ADDR_DEFINED | RGI_ON_LINK);
+=
    CLEAR(out);
+
+    /* an on-link gateway is not a next hop: the name re=
solves, but no
+     * gateway address is handed back
+     */
+    assert_=
true(ipv6_get_special_addr(&rl6, "net_gateway_ipv6", &out, &status));
+    =
assert_true(status);
+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&out));
+}
+
=
 const struct CMUnitTest route_tests[] =3D {
     cmocka_unit_test(test_is_=
special_addr),
     cmocka_unit_test(test_netmask_to_netbits),
     cmocka_=
unit_test(test_netmask_to_netbits2),
     cmocka_unit_test(test_route_ipv6_=
clear_host_bits),
+    cmocka_unit_test(test_ipv6_get_special_addr_resolves=
),
+    cmocka_unit_test(test_ipv6_get_special_addr_not_special),
+    cmoc=
ka_unit_test(test_ipv6_get_special_addr_undefined),
+    cmocka_unit_test(t=
est_ipv6_get_special_addr_on_link),
 };
 
 int

-- 
To view, visit http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690
Gerr=
it-Change-Number: 1947
Gerrit-PatchSet: 1
Gerrit-Owner: chugly <charlie=2Ev=
igue@openvpn=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>

--0Xr5l/tTGRE=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>chugly would like plaisthos to <=
strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1947?usp=3Demail">View Change</a></p><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">r=
oute: implement net_gateway_ipv6 for --route-ipv6<br><br>--route has been a=
ble to name the system default gateway symbolically for<br>a long time: get=
_special_addr() resolves net_gateway, vpn_gateway and<br>remote_host=2E  --=
route-ipv6 never gained the equivalent, so the usual IPv4<br>idiom for keep=
ing specific traffic off the tunnel has no IPv6 counterpart=2E<br><br>The f=
ailure is silent and points the wrong way=2E  init_route_ipv6() hands<br>th=
e gateway parameter straight to inet_pton(), which rejects<br>&quot;net_gat=
eway_ipv6&quot; with a warning and leaves the gateway unset=2E<br>add_route=
_ipv6() then falls back to device =3D tt-&gt;actual_name, so a route<br>mea=
nt to bypass the tunnel is installed through it instead -- the exact<br>opp=
osite of what was asked for=2E<br><br>Resolve the name from rl6-&gt;ngi6, w=
hich init_route_ipv6_list() already<br>fills with the system default gatewa=
y and exports to scripts under this<br>very name, and pin the route to that=
 gateway&#39;s interface so it leaves the<br>host the same way the correspo=
nding IPv4 route does=2E  Note this is ngi6<br>and not rgi6: the latter is =
the route towards the VPN server, which only<br>coincides with the default =
gateway on a singly-homed host=2E  An on-link<br>gateway is not a next hop,=
 so only the interface is set in that case=2E<br><br>Cover the three outcom=
es in route_testdriver: a resolved gateway, one<br>the system could not sup=
ply, and an on-link gateway where only the<br>interface is wanted=2E<br><br=
>This revives the patch originally submitted in 2021 for Trac #1161=2E<br><=
br>Github: OpenVPN/openvpn#1015<br>Change-Id: I9e45c0edbd2cb237f27e349f2f9d=
7d9b8d826690<br>Signed-off-by: Fran=C3=A7ois Kooman &lt;fkooman@tuxed=2Enet=
&gt;<br>Signed-off-by: Charlie Vigue &lt;charlie=2Evigue@openvpn=2Ecom&gt;<=
br>---<br>M src/openvpn/options=2Ec<br>M src/openvpn/route=2Ec<br>M src/ope=
nvpn/route=2Eh<br>M tests/unit_tests/openvpn/test_route=2Ec<br>4 files chan=
ged, 183 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/47/1947/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><sp=
an>index e899fa6=2E=2E0badd88 100644</span><br><span>--- a/src/openvpn/opti=
ons=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -4=
661,7 +4661,7 @@</span><br><span>             msg(msglevel, &quot;route-ipv=
6 parameter network/IP &#39;%s&#39; must be a valid address&quot;, p[1]);</=
span><br><span>             return false;</span><br><span>         }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p[2] &amp;&amp; =
!ipv6_addr_safe(p[2]))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (p[2] &amp;&amp; !ipv6_addr_safe(p[2]) &amp;&amp; !ipv6_get_s=
pecial_addr(NULL, p[2], NULL, NULL))</span><br><span>         {</span><br><=
span>             msg(msglevel, &quot;route-ipv6 parameter gateway &#39;%s&=
#39; must be a valid address&quot;, p[2]);</span><br><span>             ret=
urn false;</span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn=
/route=2Ec</span><br><span>index 8ea745d=2E=2E23e7e7a 100644</span><br><spa=
n>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</=
span><br><span>@@ -297,6 +297,65 @@</span><br><span>     return false;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Resolve the special IPv6 gateway name &quot;net_gateway_ipv6&quot;=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * The IPv6 counterpart of get_special_ad=
dr(), which handles the IPv4 names=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * There is currently only one special IPv6 name=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param rl        route list carrying t=
he system default gateway in ngi6</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *                  (not rgi6, which is the route towards the=
 VPN server), or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
                 NULL to merely test whether @p string names a special</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                  addr=
ess (used when validating options, where no route</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *                  list exists yet)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param string    the --ro=
ute-ipv6 gateway parameter to examine</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param out       receives the resolved gateway; only w=
ritten when @p rl is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *                  given and the system gateway is known</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param status    set to false if =
@p string names a special address that</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *                  could not be resolved, so the caller=
 can reject the route;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *                  set to true otherwise=2E May be NULL=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return true if @p string is a special address=
 name, in which case the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *         caller must not parse it as a literal address; false otherw=
ise=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ipv6_get_special_addr(const struct route_ipv=
6_list *rl, const char *string, struct in6_addr *out,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                      bool *status)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (status)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        *status =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (str=
cmp(string, &quot;net_gateway_ipv6&quot;) !=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rl)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (rl-&gt;ngi6=2Eflags &amp;=
 RGI_ADDR_DEFINED)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 /* an on-link gateway is not a next hop, the interface is</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+             * enough -- leave *out =
unspecified in that case */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (!(rl-&gt;ngi6=2Eflags &amp; RGI_ON_LINK))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                *out =3D rl-&gt;ngi=
6=2Egateway=2Eaddr_ipv6;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, PACK=
AGE_NAME &quot; ROUTE: net_gateway_ipv6 undefined -- unable to get default =
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                        &quot;gateway from system&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (status)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                *status =3D false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> bool</span><br><span> is_special_addr(const char *addr_st=
r)</span><br><span> {</span><br><span>@@ -435,7 +494,7 @@</span><br><span> =
</span><br><span> static bool</span><br><span> init_route_ipv6(struct route=
_ipv6 *r6, const struct route_ipv6_option *r6o,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                const struct route_ipv6_list *rl6=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                st=
ruct route_ipv6_list *rl6)</span><br><span> {</span><br><span>     CLEAR(*r=
6);</span><br><span> </span><br><span>@@ -447,7 +506,26 @@</span><br><span>=
     /* gateway */</span><br><span>     if (is_route_parm_defined(r6o-&gt;g=
ateway))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (inet_pton(AF_INET6, r6o-&gt;gateway, &amp;r6-&gt;gate=
way) !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 bool status =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ipv6=
_get_special_addr(rl6, r6o-&gt;gateway, &amp;r6-&gt;gateway, &amp;status))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            if (!status)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                goto fail;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* the route has t=
o leave via the interface the system gateway</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             * is on, otherwise it would be sent d=
own the tunnel */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (rl6-&gt;ngi6=2Eflags &amp; RGI_IFACE_DEFINED)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                r6-&gt;adapter_index =3D rl6-&g=
t;ngi6=2Eadapter_index;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      r6-&gt;iface =3D rl6-&gt;ngi6=2Eiface;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else if (inet_pton(AF_INET6, r6o-&gt;gateway, &amp;r6-&gt;gateway) !=3D=
 1)</span><br><span>         {</span><br><span>             msg(M_WARN, PAC=
KAGE_NAME &quot;ROUTE6: cannot parse gateway spec &#39;%s&#39;&quot;, r6o-&=
gt;gateway);</span><br><span>         }</span><br><span>diff --git a/src/op=
envpn/route=2Eh b/src/openvpn/route=2Eh</span><br><span>index 88107e9=2E=2E=
90e3ad2 100644</span><br><span>--- a/src/openvpn/route=2Eh</span><br><span>=
+++ b/src/openvpn/route=2Eh</span><br><span>@@ -345,6 +345,8 @@</span><br><=
span> void setenv_routes_ipv6(struct env_set *es, const struct route_ipv6_l=
ist *rl6);</span><br><span> </span><br><span> bool is_special_addr(const ch=
ar *addr_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool =
ipv6_get_special_addr(const struct route_ipv6_list *rl, const char *string,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
        struct in6_addr *out, bool *status);</span><br><span> </span><br><s=
pan> /**</span><br><span>  * @brief Retrieves the best gateway for a given =
destination based on the routing table=2E</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_route=2Ec b/tests/unit_tests/openvpn/test_route=
=2Ec</span><br><span>index db039c1=2E=2Ebfcccb8 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_route=2Ec</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_route=2Ec</span><br><span>@@ -31,6 +31,10 @@</span><br><=
span> #include &quot;route=2Eh&quot;</span><br><span> #include &quot;networ=
king=2Eh&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* the system default IPv6 gateway, and the route towards the =
peer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define NET_=
GATEWAY6  &quot;2001:db8:1::1&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define PEER_GATEWAY6 &quot;2001:db8:2::1&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* Stubs for =
functions route=2Ec references but that no test here reaches=2E</span><br><=
span>  * They assert rather than return quietly, so a test straying onto on=
e</span><br><span>  * fails loudly instead of silently doing nothing=2E</sp=
an><br><span>@@ -210,11 +214,107 @@</span><br><span>     assert_clear_host_=
bits(&quot;2001:db8::1&quot;, 0, &quot;::&quot;);</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Set u=
p a route list where the system default gateway (ngi6) and the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * route towards the peer (rgi6)=
 are different, so a test can tell which</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * one an answer came from=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+init_test_route_ipv6_list(struct route_ipv6_list *rl6, unsigned int =
ngi6_flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(*rl6);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6, NET_GAT=
EWAY6, &amp;rl6-&gt;ngi6=2Egateway=2Eaddr_ipv6), 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    rl6-&gt;ngi6=2Eflags =3D ngi6_flags;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6=
, PEER_GATEWAY6, &amp;rl6-&gt;rgi6=2Egateway=2Eaddr_ipv6), 1);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    rl6-&gt;rgi6=2Eflags =3D RGI=
_ADDR_DEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_ipv6_get_special_addr_resolves(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct route_ipv6_list rl6;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr out, =
expect;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool sta=
tus =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_test_route_ipv6=
_list(&amp;rl6, RGI_ADDR_DEFINED);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(out);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(ipv6_get_special_addr(&amp;rl6, &quot;net_gateway_ipv6&quot;, &amp;=
out, &amp;status));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(status);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the sys=
tem default gateway, not the route towards the peer */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(inet_pton(AF_INET6,=
 NET_GATEWAY6, &amp;expect), 1);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_memory_equal(&amp;out, &amp;expect, sizeof(out));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_ipv6_get_special_addr_not_special(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct route_ipv6_list rl6;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr out;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    bool status =3D false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    init_test_route_ipv6_list(&amp;rl6, RGI_AD=
DR_DEFINED);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLE=
AR(out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ipv6_get_spec=
ial_addr(&amp;rl6, &quot;2001:db8::1&quot;, &amp;out, &amp;status));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(IN6_IS_ADD=
R_UNSPECIFIED(&amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the IP=
v4 names are not IPv6 names */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(ipv6_get_special_addr(&amp;rl6, &quot;net_gatew=
ay&quot;, &amp;out, &amp;status));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* a caller with no route list only learns whether the name is special */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ipv6_=
get_special_addr(NULL, &quot;net_gateway_ipv6&quot;, NULL, NULL));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ipv6_get_sp=
ecial_addr(NULL, &quot;2001:db8::1&quot;, NULL, NULL));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ipv6=
_get_special_addr_undefined(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct route_ipv6_list rl6;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct in6_addr out;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool status =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* no IPv6 default gateway on this system */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    init_test_route_ipv6_list(&amp;rl6=
, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(out)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* still a special name, but one =
that could not be resolved, so the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * caller must reject the route rather than install it v=
ia the tunnel</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ip=
v6_get_special_addr(&amp;rl6, &quot;net_gateway_ipv6&quot;, &amp;out, &amp;=
status));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_false(status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(IN6_IS_ADDR_UNSPECIFIED(&amp;out));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ipv6_get_spe=
cial_addr_on_link(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct route_ipv6_list rl6;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct in6_addr out;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bool status =3D false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   init_test_route_ipv6_list(&amp;rl6, RGI_ADDR_DEFINED | RGI_ON_LINK);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(out);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* an on-link gateway is not a next hop: t=
he name resolves, but no</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * gateway address is handed back</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(ipv6_get_special_addr(&amp;rl6, &quot;net_gatewa=
y_ipv6&quot;, &amp;out, &amp;status));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(status);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(IN6_IS_ADDR_UNSPECIFIED(&amp;out));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnit=
Test route_tests[] =3D {</span><br><span>     cmocka_unit_test(test_is_spec=
ial_addr),</span><br><span>     cmocka_unit_test(test_netmask_to_netbits),<=
/span><br><span>     cmocka_unit_test(test_netmask_to_netbits2),</span><br>=
<span>     cmocka_unit_test(test_route_ipv6_clear_host_bits),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_ipv6_ge=
t_special_addr_resolves),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    cmocka_unit_test(test_ipv6_get_special_addr_not_special),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_i=
pv6_get_special_addr_undefined),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    cmocka_unit_test(test_ipv6_get_special_addr_on_link),</spa=
n><br><span> };</span><br><span> </span><br><span> int</span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1947?usp=
=3Demail">change 1947</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1947?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </di=
v>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I9e45c0edbd2cb237f27e349f2f9d7d9b8d826690 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1947 </div>
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
--0Xr5l/tTGRE=--


--===============1495976974794351590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1495976974794351590==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1495976974794351590==--

