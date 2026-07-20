Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED711C44520
	for <openvpn-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gx3Am3fu5j1lkbsdCe7HYmbwatGCyyu4Jci299jFMhw=; b=SkCIozxBKzsktKtz8flOvJKdeU
	h1Vk/WNL0Ko21oI9Q07uKbd71++VhRp9nMt6KYiGpNEizsbM+tqgvUWKfbalAGRJ73AeBFGWx4LmY
	V4nknwm/dGJJpealsqJTsEX82bKLJCdIiFuSpFiA4VXdVuXfW/9dAizNKl59EPg4ffAQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wlmfS-000276-4h;
	Mon, 20 Jul 2026 12:00:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wlmfQ-000270-VR
 for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 12:00:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=AYv5PPxZXQ7XshmhDt0AmthfoqjI5Li3S6Y+dOW8S0Q=; b=YYlr7SdcZ7NKAPgi4tz0NGVSpW
 Npu3O5dru+2vs6vE7YFiF10ylcqxPOrDchxVxr4SYsbGOFMzTZAvxYH0BQdwSWUdHqN47EFJ4YJ0s
 ptw57kbsIePowA2h2vgbv67xQjUcSjmH3VftYaDjd97O6iRusvWpqcKGJZ6YbgELd8TM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=AYv5PPxZXQ7XshmhDt0AmthfoqjI5Li3S6Y+dOW8S0Q=; b=A
 tLSQ+nfcKWZGjqq2S/MiTwhs8HlXxWh2bDst+ioUpiQsU3pGcEs/jo1haK4nbGKDX9RH2a+dnWjzr
 uMPe/ie060hIHjGeg/2yNc7xbc5fDodumi93gQ7ieEEG4+GcZDxk7k9Y1lTpA6ZVuWy7QG1z1fZoR
 Ha5FrOXkG1/6bn0M=;
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wlmfO-0007Fj-1i for openvpn-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 12:00:17 +0000
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so9139756f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 20 Jul 2026 05:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1784548807; x=1785153607; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=AYv5PPxZXQ7XshmhDt0AmthfoqjI5Li3S6Y+dOW8S0Q=;
 b=A9sIX6hcCot+pQWs7paoo0Zlf+qKIVIijRibHVq7Ib8I5lzfntUa5dC6hW15y6g1aH
 Omg9wZNoR5/oTfEQtrkegUMFdi+GWJaMCGFjAyx27EnVyUv0Y1qgO+MIEgVOekyKoY1B
 N4vKlMpLcPIbIIgafjbNAsxw2Ue2S0LGnOCrjvK/diz/jG9HbQPkz82UbTSZ07AqeWt/
 z7XK1TRQiIbb7ZmMdiNphNhitPAe2vWZ5/GGLacoTmoQFeYZl206TUaFDw7BHAzRVyKt
 uTEt8slT3dQSYaf14wN+SnajYECZGE70CVagVYBd0uaxYmI/rVeKKTyV06kovOSnoTB9
 q43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784548807; x=1785153607;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=AYv5PPxZXQ7XshmhDt0AmthfoqjI5Li3S6Y+dOW8S0Q=;
 b=Qg9NLg6p+6KZ0+xIn/McbKsPn94PTZ8mFlCeqGQDL9LlVmWwuwPVZvVU7eVCtG5Hr/
 ed9oR7B+gMwj5apoVa+0ZVlWaSUaNkXquwHUITqZGJpRGve6UqueTVJCDkFD3j+BWVgS
 rBR4IQqKrbXk2pIZ19AScYixkD6pIQLskXhuPBWiLfn5yf6JfxjUE0tIbHuuPQPCOEDK
 bdd8/aWQ3ihy8Tq9Oha4jQXrPbndjAvy6NSEE67/ertC40nvAsirfnWhXmUbmAu+hUSv
 XSKh8U6Ua5RiZnN9RtTvTKGFFnmYRYvyVrigJvdCK3vGSUhtVj1OqoH9b6urm8hCgGAJ
 LniQ==
X-Gm-Message-State: AOJu0Yxt/ObYdjiuhRZ0ex0rMd5iSWZhIs7nSLt5X5/sr3OA0L3P9LMD
 tcoTNBYcJG61sRViuMfgoXPu84P/xKySiXtUiEMdUzbmOLbyNZQFHuoDhhJjeRFqYK1em4ixEqh
 DqHwdGfpVvr490tFxQQIPQ5SehIkJtef9/QdHyBNs82mxT8LVhmITEJu2kV7D8Hr/xgJo
X-Gm-Gg: AR+sD11nQ+s1/dtgIgCZC3pLP7Kk5GrJt5JSInbxGOidk3j7ZruJxo6gLh0bkUd8wAj
 eD8+9V+wUT2hR7xtppOmvPa/yeIFHy/t/3tZwB5mIRdw/OVx+bxC5fKKEh4bMwiFpgIv3MtQaYX
 FZPNmvO2DaU76JbDr2ehXVE2f6pi9KlKOPbuT/h6APcpQfr3dSWbFG2ZzIUspg//fbylnlS1bE0
 kKov2klMG2CVhDiaqu1KSy7xIl7gAMKJixYwk+gdjXWLMSp06D9LitLxKkCfqftbK1fjLH32uvB
 qbrrRbqoYtsvvTa4XYRNqKQjf30HpYYPuZFWbpjBZVoyX5BiAWMolDFl0qIEOyDsoAyvY3QwXAN
 hPgbZiN1X45Rd+KWr1+5hHaGQDqjhQVdVzG/MFMClqi0Jr0TegK/9sbZd3pXuFByXvh3TP9I0P7
 eMOa/2wC4QhD/ARLOcQKfDafscQYXGcwhKC+jqTg+AF44W06SC34xzqUMb1w/25J5d0XN8RKPHc
 iRda3WdnIgvPzgDifXJtIIsix3/oM7q5859TULVz5pNMYNgfIpmN54EucwUSoj1kH/mP/JUIvW3
 3+M=
X-Received: by 2002:a05:6000:2312:b0:47f:6f96:7f9c with SMTP id
 ffacd0b85a97d-47f6f9680bbmr9000106f8f.24.1784548805471; 
 Mon, 20 Jul 2026 05:00:05 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f63eeece9sm28083692f8f.37.2026.07.20.05.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 05:00:04 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 20 Jul 2026 12:00:01 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 5738669616b166a39c7b91d031672c8e7fabb5c8
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6e4e4da53fd1bb5e1371c80c636b42fa17e6b54f-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wlmfO-0007Fj-1i
Subject: [Openvpn-devel] [L] Change in openvpn[master]: multipeer: introduce
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
Content-Type: multipart/mixed; boundary="===============8013834623661507036=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8013834623661507036==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SPpwj3VSwgo="; charset=UTF-8

--SPpwj3VSwgo=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos=2E=


Hello cron2, flichtenheld, plaisthos, 

I'd like you to reexamine a chang=
e=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=
=3Demail

to look at the new patch set (#19)=2E

The following approvals go=
t outdated and were removed:
Code-Review+2 by plaisthos


Change subject: m=
ultipeer: introduce asymmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

multipeer: introduce asymmetric peer-id

In order=
 to achieve a multipeer functionality, peers now
use separate IDs for sendi=
ng (tx_peer_id) and receiving
(rx_peer_id)=2E

Each peer announces its own =
ID through pushing peer-info
using 'ID=3D7f1' hex format so identification =
can still
happen even if IP/port changes=2E

In P2P mode, peer switch to us=
ing the announced IDs after
mutual exchange=2E
In P2MP mode, clients always=
 announce their ID, and servers
can optionally respond with their own to en=
able the same
behavior=2E

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff63=
9bf9
Signed-off-by: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M =
src/openvpn/dco=2Ec
M src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
M src/ope=
nvpn/multi=2Ec
M src/openvpn/push=2Ec
M src/openvpn/push_util=2Ec
M src/ope=
nvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_ncp=2Ec
M src/o=
penvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
11 files changed, 199 insert=
ions(+), 53 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/op=
envpn refs/changes/89/1089/19

diff --git a/src/openvpn/dco=2Ec b/src/openv=
pn/dco=2Ec
index e944547=2E=2Ec722311 100644
--- a/src/openvpn/dco=2Ec
+++ =
b/src/openvpn/dco=2Ec
@@ -528,14 +528,15 @@
         c->c2=2Etls_multi->dco=
_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1=2Etunt=
ap->dco, multi->peer_id, sock->sd, NULL,
-                           proto_=
is_dgram(sock->info=2Eproto) ? remoteaddr : NULL, NULL, NULL);
+    int ret=
 =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id, sock->sd, NULL,
=
+                           proto_is_dgram(sock->info=2Eproto) ? remoteaddr=
 : NULL,
+                           NULL, NULL);
     if (ret < 0)
     {
=
         return ret;
     }
 
-    c->c2=2Etls_multi->dco_peer_id =3D multi=
->peer_id;
+    c->c2=2Etls_multi->dco_peer_id =3D multi->rx_peer_id;
 
   =
  return 0;
 }
@@ -610,7 +611,7 @@
 {
     struct context *c =3D &mi->conte=
xt;
 
-    int peer_id =3D c->c2=2Etls_multi->peer_id;
+    int peer_id =3D=
 c->c2=2Etls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, *localadd=
r =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     const socket=
_descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ -690,7 +691,7 @@
     =
{
 #if defined(_WIN32)
         dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dc=
o, addr->v6=2Eaddr, addr->netbits,
-                                c->c2=
=2Etls_multi->peer_id);
+                                c->c2=2Etls_multi-=
>rx_peer_id);
 #else
         const struct in6_addr *gateway =3D &mi->conte=
xt=2Ec2=2Epush_ifconfig_ipv6_local;
         if (addr->type & MR_ONLINK_DCO=
_ADDR)
@@ -707,7 +708,7 @@
     {
 #if defined(_WIN32)
         dco_win_add=
_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
-       =
                         c->c2=2Etls_multi->peer_id);
+                    =
            c->c2=2Etls_multi->rx_peer_id);
 #else
         in_addr_t dest =
=3D htonl(addr->v4=2Eaddr);
         const in_addr_t *gateway =3D &mi->cont=
ext=2Ec2=2Epush_ifconfig_local;
diff --git a/src/openvpn/init=2Ec b/src/ope=
nvpn/init=2Ec
index caaa769=2E=2Ea941f69 100644
--- a/src/openvpn/init=2Ec
=
+++ b/src/openvpn/init=2Ec
@@ -2209,7 +2209,7 @@
 
     if (o->use_peer_id)=

     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+        bu=
f_printf(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2=2Etls_multi->rx_pe=
er_id, c->c2=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2688,7=
 +2688,11 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set=
");
         c->c2=2Etls_multi->use_peer_id =3D true;
-        c->c2=2Etls_=
multi->peer_id =3D c->options=2Epeer_id;
+        c->c2=2Etls_multi->tx_pee=
r_id =3D c->options=2Epeer_id;
+        if (!c->c2=2Etls_multi->use_asymmet=
ric_peer_id)
+        {
+            c->c2=2Etls_multi->rx_peer_id =3D c->o=
ptions=2Epeer_id;
+        }
     }
 
     /* process (potentially) pushed =
options */
@@ -3485,6 +3489,10 @@
     if (c->c2=2Etls_multi)
     {
      =
   tls_multi_init_finalize(c->c2=2Etls_multi, c->options=2Ece=2Etls_mtu);
+=
        if (c->c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
+        {
+   =
         c->options=2Euse_peer_id =3D true;
+        }
         ASSERT(c->c=
2=2Etls_multi->opt=2Eframe=2Ebuf=2Epayload_size <=3D c->c2=2Eframe=2Ebuf=2E=
payload_size);
         frame_print(&c->c2=2Etls_multi->opt=2Eframe, D_MTU_=
INFO, "Control Channel MTU parms");
 
diff --git a/src/openvpn/misc=2Ec b/s=
rc/openvpn/misc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/openvpn/mis=
c=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
         chom=
p(line);
         if (validate_peer_info_line(line)
-            && (strncm=
p(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+         =
   && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0=

+                || strncmp(line, "ID", 2) =3D=3D 0))
         {
         =
    msg(M_INFO, "peer info: %s", line);
             env_set_add(es, line);=

         }
         else
         {
-            msg(M_WARN, "validation f=
ailed on peer_info line received from client");
+            msg(M_WARN, "v=
alidation failed on peer_info line received");
         }
     }
 }
diff --=
git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index fe2badb=2E=2Ef823=
f5b 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -430,=
7 +430,7 @@
         if (mi->context=2Ec2=2Etls_multi && check_debug_level(=
D_DCO_DEBUG)
             && dco_enabled(&mi->context=2Eoptions))
         =
{
-            buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=2Etls_mul=
ti->peer_id);
+            buf_printf(&out, " rx-peer-id=3D%d", mi->context=
=2Ec2=2Etls_multi->rx_peer_id);
         }
         return BSTR(&out);
    =
 }
@@ -598,9 +598,9 @@
         }
 #endif
 
-        if (mi->context=2Ec2=
=2Etls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context=2Ec2=2Etls=
_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->instances[m=
i->context=2Ec2=2Etls_multi->peer_id] =3D NULL;
+            m->instances[m=
i->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
 
             /* Adjust=
 the max_peerid as this might have been the highest
              * peer id=
 instance */
@@ -908,8 +908,7 @@
 #else
                         sep,
 #end=
if
-                        sep,
-                        mi->context=2Ec2=
=2Etls_multi ? mi->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+       =
                 sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls=
_multi->rx_peer_id : MAX_PEER_ID,
                         sep, translate_c=
ipher_name_to_openvpn(mi->context=2Eoptions=2Eciphername));
               =
  }
                 gc_free(&gc);
@@ -3121,12 +3120,12 @@
          * has,=
 so we disallow it=2E This can happen if a DCO netlink notification
       =
   * gets lost and we miss a floating step=2E
          */
-        if (m1-=
>peer_id =3D=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->rx_peer=
_id)
         {
             msg(M_WARN,
                 "disallowing peer=
 %" PRIu32 " (%s) from floating to "
                 "its own address (%s)=
",
-                m1->peer_id, tls_common_name(mi->context=2Ec2=2Etls_mul=
ti, false),
+                m1->rx_peer_id, tls_common_name(mi->context=2E=
c2=2Etls_multi, false),
                 mroute_addr_print(&mi->real, &gc))=
;
             goto done;
         }
@@ -3139,7 +3138,8 @@
     }
 
     ms=
g(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-        m=
i->context=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->context=2Ec2=2Etl=
s_multi, false),
+        mi->context=2Ec2=2Etls_multi->rx_peer_id,
+      =
  tls_common_name(mi->context=2Ec2=2Etls_multi, false),
         mroute_add=
r_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
         mroute_addr_print_ex=
(&real, MAPF_SHOW_FAMILY, &gc));
 
@@ -4099,7 +4099,7 @@
     {
         if=
 (!m->instances[i])
         {
-            mi->context=2Ec2=2Etls_multi->p=
eer_id =3D i;
+            mi->context=2Ec2=2Etls_multi->rx_peer_id =3D i;
=
             m->instances[i] =3D mi;
             break;
         }
@@ -410=
8,11 +4108,11 @@
     /* should not really end up here, since multi_create_=
instance returns null
      * if amount of clients exceeds max_clients and =
this method would then
      * also not have been called */
-    ASSERT(mi-=
>context=2Ec2=2Etls_multi->peer_id < m->max_clients);
+    ASSERT(mi->conte=
xt=2Ec2=2Etls_multi->rx_peer_id < m->max_clients);
 
-    if (mi->context=
=2Ec2=2Etls_multi->peer_id > m->max_peerid)
+    if (mi->context=2Ec2=2Etls=
_multi->rx_peer_id > m->max_peerid)
     {
-        m->max_peerid =3D mi->c=
ontext=2Ec2=2Etls_multi->peer_id;
+        m->max_peerid =3D mi->context=2E=
c2=2Etls_multi->rx_peer_id;
     }
 }
 
diff --git a/src/openvpn/push=2Ec b=
/src/openvpn/push=2Ec
index e391147=2E=2E33da98f 100644
--- a/src/openvpn/p=
ush=2Ec
+++ b/src/openvpn/push=2Ec
@@ -661,9 +661,9 @@
                    =
     print_in_addr_t(c->c2=2Epush_ifconfig_remote_netmask, 0, gc));
     }
=
 
-    if (tls_multi->use_peer_id)
+    if (!tls_multi->use_asymmetric_peer=
_id)
     {
-        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", =
tls_multi->peer_id);
+        push_option_fmt(gc, push_list, M_USAGE, "peer=
-id %d", tls_multi->rx_peer_id);
     }
     /*
      * If server uses --au=
th-gen-token and we have an auth token
diff --git a/src/openvpn/push_util=
=2Ec b/src/openvpn/push_util=2Ec
index f57f54d=2E=2Ec927f26 100644
--- a/sr=
c/openvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -188,7 +188,7 @@=

         unsigned int permission_mask =3D pull_permission_mask(c);
       =
  if (process_push_update(c, &o, permission_mask, &option_types_found, &tmp=
_msg, true) =3D=3D PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Fai=
led to process push update message sent to client ID: %u", c->c2=2Etls_mult=
i->peer_id);
+            msg(M_WARN, "Failed to process push update messag=
e sent to client ID: %u", c->c2=2Etls_multi->rx_peer_id);
         }
      =
   e =3D e->next;
     }
@@ -294,7 +294,7 @@
 
         if (!support_push_u=
pdate(mi))
         {
-            msg(M_CLIENT, "PUSH_UPDATE: not sending =
message to unsupported peer with ID: %u", mi->context=2Ec2=2Etls_multi->pee=
r_id);
+            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsu=
pported peer with ID: %u", mi->context=2Ec2=2Etls_multi->rx_peer_id);
     =
        buffer_list_free(msgs);
             gc_free(&gc);
             ret=
urn 0;
@@ -329,7 +329,7 @@
         /* Type is UPT_BROADCAST so we update e=
very client */
         if (!send_single_push_update(m, curr_mi, msgs))
   =
      {
-            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated=
", curr_mi->context=2Ec2=2Etls_multi->peer_id);
+            msg(M_CLIENT, =
"ERROR: Peer ID: %u has not been updated", curr_mi->context=2Ec2=2Etls_mult=
i->rx_peer_id);
             continue;
         }
         count++;
diff --=
git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 60df7ce=2E=2E3ec50b5 =
100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1168,7 +1168=
,10 @@
     /* get command line derived options */
     ret->opt =3D *tls_o=
ptions;
     ret->dco_peer_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+ =
   ret->use_asymmetric_peer_id =3D false;
+    /* The rx_peer_id is also us=
ed to identify DCO clients */
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    re=
t->tx_peer_id =3D MAX_PEER_ID;
 
     return ret;
 }
@@ -1181,6 +1184,24 @@=

 
     tls_session_init(multi, &multi->session[TM_ACTIVE]);
     tls_sessi=
on_init(multi, &multi->session[TM_INITIAL]);
+
+    if (!multi->opt=2Edco_e=
nabled)
+    {
+        /* Calculate the asymmetric peer-id */
+        if =
(multi->rx_peer_id =3D=3D MAX_PEER_ID && multi->session[TM_INITIAL]=2Eopt->=
mode !=3D MODE_SERVER)
+        {
+            uint8_t peerid[3];
+
+      =
      if (rand_bytes(peerid, sizeof(peerid)) !=3D 1)
+            {
+      =
          msg(M_FATAL, "rand_bytes() failed");
+            }
+
+          =
  multi->rx_peer_id =3D ((uint32_t)peerid[0] << 16)
+                      =
          | ((uint32_t)peerid[1] << 8)
+                                | (=
uint32_t)peerid[2];
+        }
+    }
 }
 
 /*
@@ -1858,6 +1879,25 @@
     =
return str;
 }
 
+static bool
+push_peer_info_peerid(struct buffer *out, st=
ruct tls_multi *multi, struct tls_session *session)
+{
+    if (multi->rx_p=
eer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
+    {
+        /* =
No valid peer id or DCO is enabled=2E Cannot use this feature */
+        r=
eturn true;
+    }
+
+    /* In server mode we only add this when the clien=
t has announced its
+     * support for the feature */
+    if (session->op=
t->mode !=3D MODE_SERVER || multi->use_asymmetric_peer_id)
+    {
+        =
return buf_printf(out, "ID=3D%x\n", multi->rx_peer_id);
+    }
+
+    retur=
n true;
+}
+
 /**
  * Prepares the IV_ and UV_ variables that are part of t=
he
  * exchange to signal the peer's capabilities=2E The amount
@@ -1871,15=
 +1911,22 @@
  *
  * @param buf       the buffer to write these variables t=
o
  * @param session   the TLS session object
+ * @param multi     the TLS =
multi object
  * @return          true if no error was encountered
  */
 st=
atic bool
-push_peer_info(struct buffer *buf, struct tls_session *session)
=
+push_peer_info(struct buffer *buf, struct tls_multi *multi, struct tls_ses=
sion *session)
 {
     struct gc_arena gc =3D gc_new();
     bool ret =3D f=
alse;
     struct buffer out =3D alloc_buf_gc(512 * 3, &gc);
 
+    /* The =
asymmetric peer-id is always written when enabled */
+    if (!push_peer_in=
fo_peerid(&out, multi, session))
+    {
+        goto error;
+    }
+
     =
if (session->opt->push_peer_info_detail > 1)
     {
         /* push versio=
n */
@@ -2027,9 +2074,19 @@
     }
     else
     {
-        if (!write_emp=
ty_string(buf)) /* no peer info */
+        if (session->opt->mode =3D=3D M=
ODE_SERVER && multi->use_asymmetric_peer_id)
         {
-            goto e=
rror;
+            if (!write_string(buf, BSTR(&out), -1))
+            {
+=
                goto error;
+            }
+        }
+        else
+      =
  {
+            if (!write_empty_string(buf))
+            {
+            =
    goto error;
+            }
         }
     }
     ret =3D true;
@@ -215=
6,7 +2213,7 @@
         }
     }
 
-    if (!push_peer_info(buf, session))
=
+    if (!push_peer_info(buf, multi, session))
     {
         goto error;
=
     }
@@ -2269,6 +2326,39 @@
     if (multi->peer_info)
     {
         ou=
tput_peer_info_env(session->opt->es, multi->peer_info);
+        if (sessio=
n->opt->mode =3D=3D MODE_SERVER)
+        {
+            if (!session->opt-=
>dco_enabled)
+            {
+                uint32_t peer_id =3D extract_=
asymmetric_peer_id(multi->peer_info);
+                if (peer_id !=3D MAX=
_PEER_ID)
+                {
+                    multi->tx_peer_id =3D pee=
r_id;
+                    multi->use_asymmetric_peer_id =3D true;
+       =
             multi->use_peer_id =3D true;
+                }
+             =
   else
+                {
+                    /* Client has no asymmetric=
 peer-id capability */
+                    multi->tx_peer_id =3D multi->rx=
_peer_id;
+                }
+            }
+            else
+            =
{
+                /* With DCO we don't need the tx_peer_id atm */
+       =
         multi->tx_peer_id =3D multi->rx_peer_id;
+            }
+        }=

+        if (session->opt->mode =3D=3D MODE_POINT_TO_POINT && !session->op=
t->dco_enabled)
+        {
+            uint32_t peer_id =3D extract_asymme=
tric_peer_id(multi->peer_info);
+            if (peer_id !=3D MAX_PEER_ID)
=
+            {
+                multi->tx_peer_id =3D peer_id;
+           =
     multi->use_asymmetric_peer_id =3D true;
+                multi->use_pe=
er_id =3D true;
+            }
+        }
     }
 
     free(multi->remote_=
ciphername);
@@ -4016,8 +4106,8 @@
     msg(D_TLS_DEBUG, __func__);
 
     =
ASSERT(ks);
-
-    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_=
id) << 24 | (multi->peer_id & 0xFFFFFF));
+    peer =3D htonl(((P_DATA_V2 <=
< P_OPCODE_SHIFT) | ks->key_id) << 24
+                 | (multi->tx_peer_i=
d & 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &peer, 4));
 }
 
diff --=
git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9c90242=
=2E=2Ef6392f9 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl=
_common=2Eh
@@ -696,8 +696,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (1 << =
2)
 
     /* For P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_peer_=
id;
+    uint32_t tx_peer_id;
     bool use_peer_id;
+    bool use_asymmetr=
ic_peer_id;
 
     char *remote_ciphername; /**< cipher specified in peer's=
 config file */
     bool remote_usescomp;    /**< remote announced comp-lz=
o in OCC string */
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_n=
cp=2Ec
index baf5a95=2E=2Eb450de8 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ =
b/src/openvpn/ssl_ncp=2Ec
@@ -408,6 +408,7 @@
 {
     /* will return 0 if p=
eer_info is null */
     const unsigned int iv_proto_peer =3D extract_iv_pr=
oto(multi->peer_info);
+    const unsigned int tx_peer_id =3D extract_asymm=
etric_peer_id(multi->peer_info);
 
     /* The other peer does not support =
P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -418,7 +419,6 @=
@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_pee=
r_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
    =
 }
 
     if (iv_proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -441,27 +441,42 @=
@
     if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
         session=
->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
+    }
 
-        =
if (multi->use_peer_id)
+    if (multi->use_peer_id)
+    {
+        /* The=
 asymmetric peer-id trumps on the EKM generated ones */
+        if ((iv_pr=
oto_peer & IV_PROTO_TLS_KEY_EXPORT)
+            && (tx_peer_id !=3D MAX_PE=
ER_ID) && !multi->opt=2Edco_enabled)
         {
+            multi->tx_peer=
_id =3D tx_peer_id;
+            multi->use_asymmetric_peer_id =3D true;
+ =
       }
+        else
+        {
+            uint8_t peerid[3];
         =
    /* Using a non hardcoded peer-id makes a tiny bit harder to
           =
   * fingerprint packets and also gives each connection a unique
          =
    * peer-id that can be useful for NAT tracking etc=2E */
-
-            =
uint8_t peerid[3];
-            if (!key_state_export_keying_material(sessi=
on, EXPORT_P2P_PEERID_LABEL,
-                                             =
     strlen(EXPORT_P2P_PEERID_LABEL), &peerid, 3))
+            if ((iv_pro=
to_peer & IV_PROTO_TLS_KEY_EXPORT)
+                && key_state_export_key=
ing_material(session, EXPORT_P2P_PEERID_LABEL,
+                           =
                         strlen(EXPORT_P2P_PEERID_LABEL), &peerid, 3))
    =
         {
-                /* Non DCO setup might still work but also this=
 should never
-                 * happen or very likely the TLS encryption =
key exporter will
-                 * also fail */
-                msg(M_N=
ONFATAL, "TLS key export for P2P peer id failed=2E "
-                     =
           "Continuing anyway, expect problems");
+                multi->r=
x_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
           =
  }
             else
             {
-                multi->peer_id =3D (p=
eerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+                if (iv_pro=
to_peer & IV_PROTO_TLS_KEY_EXPORT)
+                {
+                    =
/* Non DCO setup might still work but also this should never
+             =
        * happen or very likely the TLS encryption key exporter will
+     =
                * also fail */
+                    msg(M_NONFATAL, "TLS ke=
y export for P2P peer id failed=2E "
+                                    "=
Continuing anyway, expect problems");
+                }
+                m=
ulti->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
             }
+          =
  multi->tx_peer_id =3D multi->rx_peer_id;
         }
     }
     if (iv_pr=
oto_peer & IV_PROTO_DYN_TLS_CRYPT)
@@ -502,11 +517,13 @@
         common_ci=
pher =3D BSTR(&out);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode =
NCP negotiation result: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id =
%d, epoch=3D%d, cipher=3D%s",
-        (bool)(session->opt->crypto_flags & =
CO_USE_TLS_KEY_MATERIAL_EXPORT), multi->use_peer_id,
-        multi->peer_i=
d, (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(=
D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                     =
    "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%=
d, cipher=3D%s",
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KE=
Y_MATERIAL_EXPORT),
+        multi->use_peer_id,
+        multi->rx_peer_id=
,
+        multi->tx_peer_id,
+        (bool)(session->opt->crypto_flags & =
CO_EPOCH_DATA_KEY_FORMAT),
         common_cipher);
 
     gc_free(&gc);
di=
ff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9=
e=2E=2E6561c48 100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_=
util=2Ec
@@ -24,7 +24,7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#include "o=
penvpn=2Eh"
 #include "ssl_util=2Eh"
 
 char *
@@ -72,6 +72,24 @@
     retu=
rn 0;
 }
 
+uint32_t
+extract_asymmetric_peer_id(const char *peer_info)
+{
=
+    const char *optstr =3D peer_info ? strstr(peer_info, "ID=3D") : NULL;
=
+    if (optstr)
+    {
+        uint32_t peer_id =3D 0;
+        int r =3D=
 sscanf(optstr, "ID=3D%x", &peer_id);
+        {
+            if (r =3D=3D =
1 && peer_id < MAX_PEER_ID)
+            {
+                return peer_id;=

+            }
+        }
+    }
+    return MAX_PEER_ID;
+}
+
 const char=
 *
 options_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
=
diff --git a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 2177=
d94=2E=2E1a69e6f 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ss=
l_util=2Eh
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(const cha=
r *peer_info);
 
+
+/**
+ * Extracts the ID variable and returns its value =
or
+ * MAX_PEER_ID if it cannot be extracted=2E
+ *
+ * @param peer_info   =
  peer info string to search for ID
+ */
+uint32_t extract_asymmetric_peer_=
id(const char *peer_info);
+
 /**
  * Takes a locally produced OCC string f=
or TLS server mode and modifies as
  * if the option comp-lzo was enabled=
=2E This is to send a client in

-- 
To view, visit http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mai=
l filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit=
-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Ger=
rit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Numb=
er: 1089
Gerrit-PatchSet: 19
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=
=2Ecom>
Gerrit-Reviewer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: f=
lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-open=
vpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourcefo=
rge=2Enet>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichten=
held <frank@lichtenheld=2Ecom>

--SPpwj3VSwgo=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos=2E </p>
<p>its_Gia=
an <strong>uploaded patch set #19</strong> to this change=2E</p><p><a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change=
</a></p><p>The following approvals got outdated and were removed:
Code-Revi=
ew+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">multipeer: introduce asymmetric peer-id<=
br><br>In order to achieve a multipeer functionality, peers now<br>use sepa=
rate IDs for sending (tx_peer_id) and receiving<br>(rx_peer_id)=2E<br><br>E=
ach peer announces its own ID through pushing peer-info<br>using &#39;ID=3D=
7f1&#39; hex format so identification can still<br>happen even if IP/port c=
hanges=2E<br><br>In P2P mode, peer switch to using the announced IDs after<=
br>mutual exchange=2E<br>In P2MP mode, clients always announce their ID, an=
d servers<br>can optionally respond with their own to enable the same<br>be=
havior=2E<br><br>Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Si=
gned-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<=
br>M src/openvpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=2E=
c<br>M src/openvpn/multi=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvpn/pus=
h_util=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M sr=
c/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_ut=
il=2Eh<br>11 files changed, 199 insertions(+), 53 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/cha=
nges/89/1089/19</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=
=2Ec</span><br><span>index e944547=2E=2Ec722311 100644</span><br><span>--- =
a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><=
span>@@ -528,14 +528,15 @@</span><br><span>         c-&gt;c2=2Etls_multi-&g=
t;dco_peer_id =3D -1;</span><br><span>     }</span><br><span> #endif</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_peer=
(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
 proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL, NULL, NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_ne=
w_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, N=
ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
            proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
   NULL, NULL);</span><br><span>     if (ret &lt; 0)</span><br><span>     {=
</span><br><span>         return ret;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Etls=
_multi-&gt;dco_peer_id =3D multi-&gt;peer_id;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D mult=
i-&gt;rx_peer_id;</span><br><span> </span><br><span>     return 0;</span><b=
r><span> }</span><br><span>@@ -610,7 +611,7 @@</span><br><span> {</span><br=
><span>     struct context *c =3D &amp;mi-&gt;context;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-&g=
t;c2=2Etls_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><b=
r><span>     struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><s=
pan>     struct sockaddr_storage local =3D { 0 };</span><br><span>     cons=
t socket_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br><=
span>@@ -690,7 +691,7 @@</span><br><span>     {</span><br><span> #if define=
d(_WIN32)</span><br><span>         dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2E=
tuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                c-&gt;c2=2E=
tls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</=
span><br><span> #else</span><br><span>         const struct in6_addr *gatew=
ay =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span=
>         if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@@ -7=
07,7 +708,7 @@</span><br><span>     {</span><br><span> #if defined(_WIN32)<=
/span><br><span>         dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt=
;dco, addr-&gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_multi-=
&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                          c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><=
span> #else</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4=
=2Eaddr);</span><br><span>         const in_addr_t *gateway =3D &amp;mi-&gt=
;context=2Ec2=2Epush_ifconfig_local;</span><br><span>diff --git a/src/openv=
pn/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index caaa769=2E=2Ea941f=
69 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/=
src/openvpn/init=2Ec</span><br><span>@@ -2209,7 +2209,7 @@</span><br><span>=
 </span><br><span>     if (o-&gt;use_peer_id)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out,=
 &quot;, peer-id: %d&quot;, o-&gt;peer_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;, rx-peer-id: %u=
, tx-peer-id: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id, c-&gt;c2=2Etls=
_multi-&gt;tx_peer_id);</span><br><span>     }</span><br><span> </span><br>=
<span> #ifdef USE_COMP</span><br><span>@@ -2688,7 +2688,11 @@</span><br><sp=
an>     {</span><br><span>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: =
peer-id set&quot;);</span><br><span>         c-&gt;c2=2Etls_multi-&gt;use_p=
eer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   c-&gt;c2=2Etls_multi-&gt;peer_id =3D c-&gt;options=2Epeer_id;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_multi-&=
gt;tx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!c-&gt;c2=2Etls_multi-&gt;use_asymmetric=
_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=
=2Etls_multi-&gt;rx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span=
><br><span> </span><br><span>     /* process (potentially) pushed options *=
/</span><br><span>@@ -3485,6 +3489,10 @@</span><br><span>     if (c-&gt;c2=
=2Etls_multi)</span><br><span>     {</span><br><span>         tls_multi_ini=
t_finalize(c-&gt;c2=2Etls_multi, c-&gt;options=2Ece=2Etls_mtu);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c2=2Etls_mult=
i-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            c-&gt;options=2Euse_peer_id =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>         ASSER=
T(c-&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Ebuf=2Epayload_size &lt;=3D c-&gt;c=
2=2Eframe=2Ebuf=2Epayload_size);</span><br><span>         frame_print(&amp;=
c-&gt;c2=2Etls_multi-&gt;opt=2Eframe, D_MTU_INFO, &quot;Control Channel MTU=
 parms&quot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/m=
isc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index 10bfc35=2E=2Ea8c88c9 1=
00644</span><br><span>--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/=
openvpn/misc=2Ec</span><br><span>@@ -765,14 +765,15 @@</span><br><span>    =
 {</span><br><span>         chomp(line);</span><br><span>         if (valid=
ate_peer_info_line(line)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || st=
rncmp(line, &quot;UV_&quot;, 3) =3D=3D 0))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &amp;&amp; (strncmp(line, &quot;IV_&quot=
;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                || strncmp(line, &=
quot;ID&quot;, 2) =3D=3D 0))</span><br><span>         {</span><br><span>   =
          msg(M_INFO, &quot;peer info: %s&quot;, line);</span><br><span>   =
          env_set_add(es, line);</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(M_WARN, &quot;validation failed on peer=
_info line received from client&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            msg(M_WARN, &quot;validation failed on peer=
_info line received&quot;);</span><br><span>         }</span><br><span>    =
 }</span><br><span> }</span><br><span>diff --git a/src/openvpn/multi=2Ec b/=
src/openvpn/multi=2Ec</span><br><span>index fe2badb=2E=2Ef823f5b 100644</sp=
an><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/=
multi=2Ec</span><br><span>@@ -430,7 +430,7 @@</span><br><span>         if (=
mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</=
span><br><span>             &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eop=
tions))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            buf_printf(&amp;out, &quot; peer-id=3D%d&quot;, mi=
-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            buf_printf(&amp;out, &quot; rx-peer-id=
=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><sp=
an>         }</span><br><span>         return BSTR(&amp;out);</span><br><sp=
an>     }</span><br><span>@@ -598,9 +598,9 @@</span><br><span>         }</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id !=
=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id=
] =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NUL=
L;</span><br><span> </span><br><span>             /* Adjust the max_peerid =
as this might have been the highest</span><br><span>              * peer id=
 instance */</span><br><span>@@ -908,8 +908,7 @@</span><br><span> #else</sp=
an><br><span>                         sep,</span><br><span> #endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                        sep,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
 mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;peer=
_id : UINT32_MAX,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      sep, mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=
=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID,</span><br><span>           =
              sep, translate_cipher_name_to_openvpn(mi-&gt;context=2Eoption=
s=2Eciphername));</span><br><span>                 }</span><br><span>      =
           gc_free(&amp;gc);</span><br><span>@@ -3121,12 +3120,12 @@</span>=
<br><span>          * has, so we disallow it=2E This can happen if a DCO ne=
tlink notification</span><br><span>          * gets lost and we miss a floa=
ting step=2E</span><br><span>          */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (m1-&gt;peer_id =3D=3D m2-&gt;peer_id)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (m1-&gt;rx_pee=
r_id =3D=3D m2-&gt;rx_peer_id)</span><br><span>         {</span><br><span> =
            msg(M_WARN,</span><br><span>                 &quot;disallowing =
peer %&quot; PRIu32 &quot; (%s) from floating to &quot;</span><br><span>   =
              &quot;its own address (%s)&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                m1-&gt;peer_id, tls_common_name(m=
i-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                m1-&gt;rx_peer_id, tls_common_name(mi-&=
gt;context=2Ec2=2Etls_multi, false),</span><br><span>                 mrout=
e_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span>             goto=
 done;</span><br><span>         }</span><br><span>@@ -3139,7 +3138,8 @@</sp=
an><br><span>     }</span><br><span> </span><br><span>     msg(D_MULTI_MEDI=
UM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec=
2=2Etls_multi-&gt;peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi,=
 false),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-=
&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        tls_common_name(mi-&gt;context=2Ec2=2Etls_=
multi, false),</span><br><span>         mroute_addr_print_ex(&amp;mi-&gt;re=
al, MAPF_SHOW_FAMILY, &amp;gc),</span><br><span>         mroute_addr_print_=
ex(&amp;real, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span> </span><br><spa=
n>@@ -4099,7 +4099,7 @@</span><br><span>     {</span><br><span>         if =
(!m-&gt;instances[i])</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=2Etls_multi-&gt;=
peer_id =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id =3D i;</span><br><spa=
n>             m-&gt;instances[i] =3D mi;</span><br><span>             brea=
k;</span><br><span>         }</span><br><span>@@ -4108,11 +4108,11 @@</span=
><br><span>     /* should not really end up here, since multi_create_instan=
ce returns null</span><br><span>      * if amount of clients exceeds max_cl=
ients and this method would then</span><br><span>      * also not have been=
 called */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id &lt; m-&gt;max_clients);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(mi-&gt;context=
=2Ec2=2Etls_multi-&gt;rx_peer_id &lt; m-&gt;max_clients);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;peer_id &gt; m-&gt;max_peerid)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (mi-&gt;context=2Ec2=2Etls_multi-&=
gt;rx_peer_id &gt; m-&gt;max_peerid)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        m-&gt;max_peerid =3D mi-&gt;c=
ontext=2Ec2=2Etls_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2Etls_mul=
ti-&gt;rx_peer_id;</span><br><span>     }</span><br><span> }</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2E=
c</span><br><span>index e391147=2E=2E33da98f 100644</span><br><span>--- a/s=
rc/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><s=
pan>@@ -661,9 +661,9 @@</span><br><span>                         print_in_a=
ddr_t(c-&gt;c2=2Epush_ifconfig_remote_netmask, 0, gc));</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (tls_multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!tls_multi-&gt;use_asymmetric_peer_id)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        push=
_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;p=
eer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pus=
h_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;=
rx_peer_id);</span><br><span>     }</span><br><span>     /*</span><br><span=
>      * If server uses --auth-gen-token and we have an auth token</span><b=
r><span>diff --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec<=
/span><br><span>index f57f54d=2E=2Ec927f26 100644</span><br><span>--- a/src=
/openvpn/push_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</spa=
n><br><span>@@ -188,7 +188,7 @@</span><br><span>         unsigned int permi=
ssion_mask =3D pull_permission_mask(c);</span><br><span>         if (proces=
s_push_update(c, &amp;o, permission_mask, &amp;option_types_found, &amp;tmp=
_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Faile=
d to process push update message sent to client ID: %u&quot;, c-&gt;c2=2Etl=
s_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_WARN, &quot;Failed to process push update message sent =
to client ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><sp=
an>         }</span><br><span>         e =3D e-&gt;next;</span><br><span>  =
   }</span><br><span>@@ -294,7 +294,7 @@</span><br><span> </span><br><span>=
         if (!support_push_update(mi))</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot=
;PUSH_UPDATE: not sending message to unsupported peer with ID: %u&quot;, mi=
-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;PUSH_UPDATE: not se=
nding message to unsupported peer with ID: %u&quot;, mi-&gt;context=2Ec2=2E=
tls_multi-&gt;rx_peer_id);</span><br><span>             buffer_list_free(ms=
gs);</span><br><span>             gc_free(&amp;gc);</span><br><span>       =
      return 0;</span><br><span>@@ -329,7 +329,7 @@</span><br><span>       =
  /* Type is UPT_BROADCAST so we update every client */</span><br><span>   =
      if (!send_single_push_update(m, curr_mi, msgs))</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
M_CLIENT, &quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;=
context=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(M_CLIENT, &quot;ERROR: Peer ID: %u has n=
ot been updated&quot;, curr_mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id)=
;</span><br><span>             continue;</span><br><span>         }</span><=
br><span>         count++;</span><br><span>diff --git a/src/openvpn/ssl=2Ec=
 b/src/openvpn/ssl=2Ec</span><br><span>index 60df7ce=2E=2E3ec50b5 100644</s=
pan><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/s=
sl=2Ec</span><br><span>@@ -1168,7 +1168,10 @@</span><br><span>     /* get c=
ommand line derived options */</span><br><span>     ret-&gt;opt =3D *tls_op=
tions;</span><br><span>     ret-&gt;dco_peer_id =3D -1;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =3D MAX_PEER_ID;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;use_asymmetr=
ic_peer_id =3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* The rx_peer_id is also used to identify DCO clients */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;rx_peer_id =3D MAX_=
PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt=
;tx_peer_id =3D MAX_PEER_ID;</span><br><span> </span><br><span>     return =
ret;</span><br><span> }</span><br><span>@@ -1181,6 +1184,24 @@</span><br><s=
pan> </span><br><span>     tls_session_init(multi, &amp;multi-&gt;session[T=
M_ACTIVE]);</span><br><span>     tls_session_init(multi, &amp;multi-&gt;ses=
sion[TM_INITIAL]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;o=
pt=2Edco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Calcu=
late the asymmetric peer-id */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; m=
ulti-&gt;session[TM_INITIAL]=2Eopt-&gt;mode !=3D MODE_SERVER)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            uint8_t peerid[3];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            if (rand_bytes(peerid, sizeof(peerid)=
) !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
msg(M_FATAL, &quot;rand_bytes() failed&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            multi-&gt;rx_peer_id =3D ((uint32_t)peerid[0] &lt;&lt; 16)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
          | ((uint32_t)peerid[1] &lt;&lt; 8)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                | (uint32_t)peerid=
[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }<=
/span><br><span> </span><br><span> /*</span><br><span>@@ -1858,6 +1879,25 @=
@</span><br><span>     return str;</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+push_peer_info_peerid(struct bu=
ffer *out, struct tls_multi *multi, struct tls_session *session)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID =
|| session-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* No valid peer id or DCO is enabled=2E Cannot use this feature =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* In server mode we only add this when the c=
lient has announced its</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * support for the feature */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (session-&gt;opt-&gt;mode !=3D MODE_SERVER || mult=
i-&gt;use_asymmetric_peer_id)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return buf_printf(out, &quot;ID=3D%x\n&quot;, multi-&gt;rx_peer_id);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> /**</span><br><span>  * Prepares the IV_ and UV_ variables=
 that are part of the</span><br><span>  * exchange to signal the peer&#39;s=
 capabilities=2E The amount</span><br><span>@@ -1871,15 +1911,22 @@</span><=
br><span>  *</span><br><span>  * @param buf       the buffer to write these=
 variables to</span><br><span>  * @param session   the TLS session object</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi     t=
he TLS multi object</span><br><span>  * @return          true if no error w=
as encountered</span><br><span>  */</span><br><span> static bool</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *bu=
f, struct tls_session *session)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+push_peer_info(struct buffer *buf, struct tls_multi *multi, str=
uct tls_session *session)</span><br><span> {</span><br><span>     struct gc=
_arena gc =3D gc_new();</span><br><span>     bool ret =3D false;</span><br>=
<span>     struct buffer out =3D alloc_buf_gc(512 * 3, &amp;gc);</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The a=
symmetric peer-id is always written when enabled */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_info_peerid(&amp;out, =
multi, session))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto erro=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (sessi=
on-&gt;opt-&gt;push_peer_info_detail &gt; 1)</span><br><span>     {</span><=
br><span>         /* push version */</span><br><span>@@ -2027,9 +2074,19 @@=
</span><br><span>     }</span><br><span>     else</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!write_empty=
_string(buf)) /* no peer info */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (session-&gt;opt-&gt;mode =3D=3D MODE_SERVER &amp;&=
amp; multi-&gt;use_asymmetric_peer_id)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            goto error;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!write_stri=
ng(buf, BSTR(&amp;out), -1))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                goto error;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!write=
_empty_string(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          goto error;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            }</span><br><span>         }</span><br><span>     }</span><br=
><span>     ret =3D true;</span><br><span>@@ -2156,7 +2213,7 @@</span><br><=
span>         }</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (!push_peer_info(buf, session))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_in=
fo(buf, multi, session))</span><br><span>     {</span><br><span>         go=
to error;</span><br><span>     }</span><br><span>@@ -2269,6 +2326,39 @@</sp=
an><br><span>     if (multi-&gt;peer_info)</span><br><span>     {</span><br=
><span>         output_peer_info_env(session-&gt;opt-&gt;es, multi-&gt;peer=
_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
session-&gt;opt-&gt;mode =3D=3D MODE_SERVER)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            if (!session-&gt;opt-&gt;dco_enabled)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                uint32_t peer_id =3D=
 extract_asymmetric_peer_id(multi-&gt;peer_info);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                if (peer_id !=3D MAX_PEER_ID)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
ulti-&gt;tx_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    multi-&gt;use_asymmetric_peer_id =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    /* Client has no asymmetric peer-id capabilit=
y */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                /* With DCO we don&#39;t need the tx_pee=
r_id atm */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (session-&gt;opt-&gt;mode =3D=3D MODE_POINT_T=
O_POINT &amp;&amp; !session-&gt;opt-&gt;dco_enabled)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            uint32_t peer_id =3D extract_asymmetric=
_peer_id(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (peer_id !=3D MAX_PEER_ID)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                multi-&gt;tx_peer_id =3D peer_i=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                m=
ulti-&gt;use_asymmetric_peer_id =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                multi-&gt;use_peer_id =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
}</span><br><span> </span><br><span>     free(multi-&gt;remote_ciphername);=
</span><br><span>@@ -4016,8 +4106,8 @@</span><br><span>     msg(D_TLS_DEBUG=
, __func__);</span><br><span> </span><br><span>     ASSERT(ks);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT=
) | ks-&gt;key_id) &lt;&lt; 24 | (multi-&gt;peer_id &amp; 0xFFFFFF));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    peer =3D htonl(((P_DA=
TA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                 | (multi-&gt;tx_pe=
er_id &amp; 0xFFFFFF));</span><br><span>     ASSERT(buf_write_prepend(buf, =
&amp;peer, 4));</span><br><span> }</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><s=
pan>index 9c90242=2E=2Ef6392f9 100644</span><br><span>--- a/src/openvpn/ssl=
_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><spa=
n>@@ -696,8 +696,10 @@</span><br><span> #define AUTH_TOKEN_VALID_EMPTYUSER =
(1 &lt;&lt; 2)</span><br><span> </span><br><span>     /* For P_DATA_V2 */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint32_t peer_id;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t rx_peer_=
id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t tx_=
peer_id;</span><br><span>     bool use_peer_id;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    bool use_asymmetric_peer_id;</span><br><spa=
n> </span><br><span>     char *remote_ciphername; /**&lt; cipher specified =
in peer&#39;s config file */</span><br><span>     bool remote_usescomp;    =
/**&lt; remote announced comp-lzo in OCC string */</span><br><span>diff --g=
it a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>inde=
x baf5a95=2E=2Eb450de8 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec=
</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -408,6 +4=
08,7 @@</span><br><span> {</span><br><span>     /* will return 0 if peer_in=
fo is null */</span><br><span>     const unsigned int iv_proto_peer =3D ext=
ract_iv_proto(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    const unsigned int tx_peer_id =3D extract_asymmetric_pe=
er_id(multi-&gt;peer_info);</span><br><span> </span><br><span>     /* The o=
ther peer does not support P2P NCP */</span><br><span>     if (!(iv_proto_p=
eer &amp; IV_PROTO_NCP_P2P))</span><br><span>@@ -418,7 +419,6 @@</span><br>=
<span>     if (iv_proto_peer &amp; IV_PROTO_DATA_V2)</span><br><span>     {=
</span><br><span>         multi-&gt;use_peer_id =3D true;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        multi-&gt;peer_id =3D 0x76706e;=
 /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span>     }</span><br=
><span> </span><br><span>     if (iv_proto_peer &amp; IV_PROTO_CC_EXIT_NOTI=
FY)</span><br><span>@@ -441,27 +441,42 @@</span><br><span>     if (iv_proto=
_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span>     {</span><br><span=
>         session-&gt;opt-&gt;crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXP=
ORT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m=
ulti-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (multi-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* The asymmetric peer-id trumps on the EKM generated ones */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((iv_proto_peer=
 &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &amp;&amp; (tx_peer_id !=3D MAX_PEER_ID) &amp;&amp;=
 !multi-&gt;opt=2Edco_enabled)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D =
tx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            uint8_t peerid[3];</span><br><span>             /* Using a non =
hardcoded peer-id makes a tiny bit harder to</span><br><span>              =
* fingerprint packets and also gives each connection a unique</span><br><sp=
an>              * peer-id that can be useful for NAT tracking etc=2E */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            uint8_t peerid[3];</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            if (!key_state_export_=
keying_material(session, EXPORT_P2P_PEERID_LABEL,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                                               =
   strlen(EXPORT_P2P_PEERID_LABEL), &amp;peerid, 3))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if ((iv_proto_peer &amp; IV_P=
ROTO_TLS_KEY_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                &amp;&amp; key_state_export_keying_material(session, EXPOR=
T_P2P_PEERID_LABEL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                                    strlen(EXPORT_P2P_PEERI=
D_LABEL), &amp;peerid, 3))</span><br><span>             {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                /* Non DCO setup might =
still work but also this should never</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                 * happen or very likely the TLS encryption=
 key exporter will</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
              * also fail */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                msg(M_NONFATAL, &quot;TLS key export for P2P peer id=
 failed=2E &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                            &quot;Continuing anyway, expect problems&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                mu=
lti-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + p=
eerid[2];</span><br><span>             }</span><br><span>             else<=
/span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                multi-&gt;peer_id =3D (peerid[0] &lt;&lt; 16) + (p=
eerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPO=
RT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  /* Non DCO setup might still work but also this should never</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     * happen or=
 very likely the TLS encryption key exporter will</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                     * also fail */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_NON=
FATAL, &quot;TLS key export for P2P peer id failed=2E &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
  &quot;Continuing anyway, expect problems&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                multi-&gt;rx_peer_id =3D 0x767=
06e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */</span><br><span>            =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi=
-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span>         }</span>=
<br><span>     }</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_DYN_=
TLS_CRYPT)</span><br><span>@@ -502,11 +517,13 @@</span><br><span>         c=
ommon_cipher =3D BSTR(&amp;out);</span><br><span>     }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_TLS_DEBUG_LOW=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot;P2P mo=
de NCP negotiation result: &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=
=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MA=
TERIAL_EXPORT), multi-&gt;use_peer_id,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        multi-&gt;peer_id, (bool)(session-&gt;opt-&gt;cryp=
to_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiati=
on result: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, =
tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flags &=
amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        multi-&gt;use_peer_id,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        multi-&gt;rx_peer_id,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;tx_peer_id,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&gt=
;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span>    =
     common_cipher);</span><br><span> </span><br><span>     gc_free(&amp;gc=
);</span><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_=
util=2Ec</span><br><span>index 71fbc9e=2E=2E6561c48 100644</span><br><span>=
--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=
=2Ec</span><br><span>@@ -24,7 +24,7 @@</span><br><span> #endif</span><br><s=
pan> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span> #include &=
quot;ssl_util=2Eh&quot;</span><br><span> </span><br><span> char *</span><br=
><span>@@ -72,6 +72,24 @@</span><br><span>     return 0;</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
int32_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extract_asym=
metric_peer_id(const char *peer_info)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const char *optstr =3D peer_info ? strstr(peer_info, &quot;ID=3D&quot;)=
 : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt=
str)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uint32_t peer_id =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int r =3D=
 sscanf(optstr, &quot;ID=3D%x&quot;, &amp;peer_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (r =3D=3D 1 &amp;&amp; peer_id &lt; =
MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   return peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return MAX_PEER_ID;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br><spa=
n> options_string_compat_lzo(const char *options, struct gc_arena *gc)</spa=
n><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_util=2Eh b/src/=
openvpn/ssl_util=2Eh</span><br><span>index 2177d94=2E=2E1a69e6f 100644</spa=
n><br><span>--- a/src/openvpn/ssl_util=2Eh</span><br><span>+++ b/src/openvp=
n/ssl_util=2Eh</span><br><span>@@ -53,6 +53,15 @@</span><br><span>  */</spa=
n><br><span> unsigned int extract_iv_proto(const char *peer_info);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Extracts the ID variable and returns its v=
alue or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * MAX_PEER_=
ID if it cannot be extracted=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram peer_info     peer info string to search for ID</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+uint32_t extract_asymmetric_peer_id(const char *peer_info=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 /**</span><br><span>  * Takes a locally produced OCC string for TLS server=
 mode and modifies as</span><br><span>  * if the option comp-lzo was enable=
d=2E This is to send a client in</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Dem=
ail">change 1089</a>=2E To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">setting=
s</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><d=
iv itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
=
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"d=
isplay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Ger=
rit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=
=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:=
none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:none"> Gerrit-Owner=
: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &=
lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerri=
t-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
=
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@r=
fc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_=
Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</b=
ody></html>
--SPpwj3VSwgo=--


--===============8013834623661507036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8013834623661507036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8013834623661507036==--

