Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C16CD98F2
	for <openvpn-devel@archiver.kernel.org>; Mon, 22 Jun 2026 13:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KFlyv1ZDsHL1jIqnU33ZUiwi+nRS6QZYoAelPumCQOA=; b=FuomAlwXVjdvf62PVMYSEI/pbP
	xqelTHVkmt+joDm06LuHyroQsH40pYS3gg9srFje1AUQVUYad9Ns/Pyz9ieQCvRfhbOgbuZCHNkx4
	fiZ3/jglcA8VlEqKiKsdXSow5omP3WIS45aon5CEp5Lg2h6iotHsUtBn33Vyz380ev7k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wbecf-0004qr-8s;
	Mon, 22 Jun 2026 13:23:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wbecc-0004qj-RI
 for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=hTbDg3aII4NE27Lwfx7xoIT2Hnpa1S39xq5zCR+19xU=; b=hmAE14Po4+778mmQ+zx2nq8fY7
 xD7VcN4ZSuKNIJ3uiLOTMyxX05LL/RqK8vciLLMGsxqmN3zxD5m0TlKrWvmLv1CYp5QXyGLh4bbUt
 Zqd9DT8A9821QLuY6iOEJjUwiVRGTSak+PWE36hbzimpxIbvtPeOZxp2WC7GJh5MIKHg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hTbDg3aII4NE27Lwfx7xoIT2Hnpa1S39xq5zCR+19xU=; b=R
 prGhFKipyUTLpQ4koFuUca48KlMRrkmfCWg8sI1HxwqJ5OM5SDMMZhSr0SK6FL1Re5ZTg/uAP7sJr
 63sGNtMc8kUarMpUr90XEmDolBk/k5Dmx/7Hc9v6FA1CTfUgf906cA5Jxz6tsMsAdHQ05F8+Moyvs
 8vj4SRpKsqfm173I=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wbecZ-0000Ys-Fz for openvpn-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 13:23:31 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45eeba68948so3328012f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 22 Jun 2026 06:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1782134601; x=1782739401; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hTbDg3aII4NE27Lwfx7xoIT2Hnpa1S39xq5zCR+19xU=;
 b=ENrrnEJbVlkSHsuerboksyun9wA4BrLA/wZYdJf5XTHDfaea8epEc5uBic5p35oAKh
 X5uqo0p4XB3gKCbT4NQbpjsC+GrnfXdxP2WovV9OlCos5nWvK9NMPgyv4FFacmLfr7GW
 5205hJoYYgPV232qy8djg6BaSFC/wfTmckaxZSLYceplHzUnJLFxGuNQhzTEyrC2L+F4
 D183UeRzOfeQMC5GDBsvi2zQnPloR9gzRDESR317KE1QS4j61vj0Ydr+ZEdWx9jA5mip
 fQzFPWKbgECPVpMlBiuTQ4/NZMcNTVOMmaN+NVUO6Y9I5i5uS+W75wp7tHT2EQPZGgau
 n9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782134601; x=1782739401;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hTbDg3aII4NE27Lwfx7xoIT2Hnpa1S39xq5zCR+19xU=;
 b=fPgW1Ra1/T9obvjTnixYO+tgk85+hpgPLV+4IAnNZXH+U2XqnegaK1wX/387fTj9zm
 FaUrvGchQcKvxNyfVREww4muDn+IGacwhKdc0RjfFq/g/2tZwmWi7OGhMJJFxsMHwTSH
 /gjBQGDZ7WWSs6MmG7CinVXTij9WYzXb1NDXBP7El9Fu9M7QLay020qzpd/Pn0zPND1r
 Gp+doI5eW8WGcBltWGZtlByxzqzeHr+pexQrYoN0Fyz0yjmuUoc0W8B9Gy/CZBxtUZZ9
 cJYC7QtrSAixNq26qs5FIOD5hJW4HjX4Ei6pCsxjUXM/5jGf8ZKdKD7YImV0qfMBqWIf
 OYfA==
X-Gm-Message-State: AOJu0YwqpNNzVqcpT8KkULLf7l8dSu8FMJyfjq8Mv9o+6DHEua82l5UP
 yP9EhveJABO/PfD1W2LtzjxMP3EW0aBNMvLbBnX92EgW7r+9BBdImiBCe34w8gzDIZfPXfDEwRU
 gQXGfMLhTCXe2dczBp/qiDL/rNuUbq4sNkp1wMpOfad+ZgFuvr07+y2Wjs5p3LYLBYNwsC+p9Df
 LEsjwEFg==
X-Gm-Gg: AfdE7clE2temIqW6Z0TCIeY1RaywumhTc9yFkYmRjkSpgKSsrEL/LKSX5Qpqr7bMAfD
 89xDmwfbfZHnnfGRra4Pjt1yrS3fiPBf7kcXIqNahkvczOLyLLkgSwcnPCz4zhSW0ewsXfoTk/Y
 bMNgm7cs3MBI1ACOAM0auoBEbQz0nwGviqSTT1meOFtAWQGEt2ZMzQAmBpmmKobI+IL+Ev9Pbtw
 +0Jk4oCr42e4XCcYfmC2Vz6em+c9V1fcM0IvBXFULcxvaXmlKo2wj1R+vhAnKy5X/hqMDr5xaoc
 tMK7Cf3NX51J/qN7WLyq5j2p0M90aem8Gl1JFIBd5oK4tvkKydPEzn3F7kp0eReMbQUJy+USE4F
 JcD5WnkYADp/yfO+9me6ZyP29kd2Uw0D2Nk7i1AKm9Uyl8gPEXtot5lqk31ie4x/Hdogx80cGhY
 w4uQuMeNBx8FGcWxks8oshne3aEIteHeRuHz3/drDnWg7jmSNVVedH0Ww9bo0XwHbBChZklH44K
 SbeSvAloqOwysOsWIn9PuV/nSV0J7fuhvWaOr9r16zLfUSr7uI8ZeEgwzYNYmxSNAe89vDAzOwQ
 8DqJ0s3BSm/ECw==
X-Received: by 2002:a05:600c:1d1e:b0:492:4ca9:a46d with SMTP id
 5b1f17b1804b1-4924ca9a4e8mr142446035e9.5.1782134599892; 
 Mon, 22 Jun 2026 06:23:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49249207dabsm365834875e9.0.2026.06.22.06.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 06:23:19 -0700 (PDT)
X-Google-Original-From: "plaisthos (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 22 Jun 2026 13:23:08 +0000
To: its_Giaan <gianmarco@mandelbit.com>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 13
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 646ca2458dfd3e25ce754f86512fe48ef2142b5b
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <03b0a0706deece9cdeb42a5780460ef60b7e6efa-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wbecZ-0000Ys-Fz
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
From: "plaisthos \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, gianmarco@mandelbit.com,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 gert@greenie.muc.de
Cc: "plaisthos \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0390602556381259304=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0390602556381259304==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WG6bdERn/UQ="; charset=UTF-8

--WG6bdERn/UQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos=2E=


plaisthos has uploaded a new patch set (#13) to the change originally cre=
ated by its_Giaan=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=
=3Demail )

The following approvals got outdated and were removed:
Code-Rev=
iew+2 by plaisthos


Change subject: multipeer: introduce asymmetric peer-i=
d
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multipeer:=
 introduce asymmetric peer-id

In order to achieve a multipeer functionalit=
y, peers now
use separate IDs for sending (tx_peer_id) and receiving
(rx_pe=
er_id)=2E

Each peer announces its own ID through pushing peer-info
using '=
ID=3D7f1' hex format so identification can still
happen even if IP/port cha=
nges=2E

In P2P mode, peer switch to using the announced IDs after
mutual e=
xchange=2E
In P2MP mode, clients always announce their ID, and servers
can =
optionally respond with their own to enable the same
behavior=2E

Change-Id=
: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: Gianmarco De Gre=
gori <gianmarco@mandelbit=2Ecom>
Signed-off-by: Arne Schwabe <arne@rfc2549=
=2Eorg>
---
M src/openvpn/dco=2Ec
M src/openvpn/init=2Ec
M src/openvpn/misc=
=2Ec
M src/openvpn/multi=2Ec
M src/openvpn/options=2Ec
M src/openvpn/push=
=2Ec
M src/openvpn/push_util=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_co=
mmon=2Eh
M src/openvpn/ssl_ncp=2Ec
M src/openvpn/ssl_util=2Ec
M src/openvpn=
/ssl_util=2Eh
12 files changed, 184 insertions(+), 47 deletions(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1089/13

di=
ff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec
index f5b7081=2E=2E901=
b9bd 100644
--- a/src/openvpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -528,14 =
+528,15 @@
         c->c2=2Etls_multi->dco_peer_id =3D -1;
     }
 #endif
-=
    int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->peer_id, sock->sd=
, NULL,
-                           proto_is_dgram(sock->info=2Eproto) ? re=
moteaddr : NULL, NULL, NULL);
+    int ret =3D dco_new_peer(&c->c1=2Etuntap=
->dco, multi->rx_peer_id, sock->sd, NULL,
+                           proto=
_is_dgram(sock->info=2Eproto) ? remoteaddr : NULL,
+                       =
    NULL, NULL);
     if (ret < 0)
     {
         return ret;
     }
 
-  =
  c->c2=2Etls_multi->dco_peer_id =3D multi->peer_id;
+    c->c2=2Etls_multi=
->dco_peer_id =3D multi->rx_peer_id;
 
     return 0;
 }
@@ -610,7 +611,7 @=
@
 {
     struct context *c =3D &mi->context;
 
-    int peer_id =3D c->c2=
=2Etls_multi->peer_id;
+    int peer_id =3D c->c2=2Etls_multi->rx_peer_id;
=
     struct sockaddr *remoteaddr, *localaddr =3D NULL;
     struct sockaddr=
_storage local =3D { 0 };
     const socket_descriptor_t sd =3D c->c2=2Elin=
k_sockets[0]->sd;
@@ -689,8 +690,7 @@
     if (addrtype =3D=3D MR_ADDR_IPV6=
)
     {
 #if defined(_WIN32)
-        dco_win_add_iroute_ipv6(&c->c1=2Etun=
tap->dco, addr->v6=2Eaddr, addr->netbits,
-                                =
c->c2=2Etls_multi->peer_id);
+        dco_win_add_iroute_ipv6(&c->c1=2Etunt=
ap->dco, addr->v6=2Eaddr, addr->netbits, c->c2=2Etls_multi->rx_peer_id);
 #=
else
         const struct in6_addr *gateway =3D &mi->context=2Ec2=2Epush_i=
fconfig_ipv6_local;
         if (addr->type & MR_ONLINK_DCO_ADDR)
@@ -706,8=
 +706,7 @@
     else if (addrtype =3D=3D MR_ADDR_IPV4)
     {
 #if defined(=
_WIN32)
-        dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Ea=
ddr, addr->netbits,
-                                c->c2=2Etls_multi->pee=
r_id);
+        dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Ead=
dr, addr->netbits, c->c2=2Etls_multi->rx_peer_id);
 #else
         in_addr_=
t dest =3D htonl(addr->v4=2Eaddr);
         const in_addr_t *gateway =3D &m=
i->context=2Ec2=2Epush_ifconfig_local;
diff --git a/src/openvpn/init=2Ec b/=
src/openvpn/init=2Ec
index caaa769=2E=2E468c260 100644
--- a/src/openvpn/in=
it=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2209,7 +2209,7 @@
 
     if (o->use_p=
eer_id)
     {
-        buf_printf(&out, ", peer-id: %d", o->peer_id);
+   =
     buf_printf(&out, ", rx-peer-id: %u, tx-peer-id: %u", c->c2=2Etls_multi=
->rx_peer_id, c->c2=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ =
-2688,7 +2688,12 @@
     {
         msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer=
-id set");
         c->c2=2Etls_multi->use_peer_id =3D true;
-        c->c2=
=2Etls_multi->peer_id =3D c->options=2Epeer_id;
+        c->c2=2Etls_multi-=
>tx_peer_id =3D c->options=2Epeer_id;
+        if (!c->c2=2Etls_multi->use_=
asymmetric_peer_id)
+        {
+            c->c2=2Etls_multi->rx_peer_id =
=3D c->options=2Epeer_id;
+            c->c2=2Etls_multi->tx_peer_id =3D c-=
>options=2Epeer_id;
+        }
     }
 
     /* process (potentially) pushe=
d options */
@@ -3485,6 +3490,10 @@
     if (c->c2=2Etls_multi)
     {
    =
     tls_multi_init_finalize(c->c2=2Etls_multi, c->options=2Ece=2Etls_mtu);=

+        if (c->c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
+        {
+ =
           c->options=2Euse_peer_id =3D true;
+        }
         ASSERT(c-=
>c2=2Etls_multi->opt=2Eframe=2Ebuf=2Epayload_size <=3D c->c2=2Eframe=2Ebuf=
=2Epayload_size);
         frame_print(&c->c2=2Etls_multi->opt=2Eframe, D_M=
TU_INFO, "Control Channel MTU parms");
 
diff --git a/src/openvpn/misc=2Ec =
b/src/openvpn/misc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/openvpn/=
misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
         c=
homp(line);
         if (validate_peer_info_line(line)
-            && (str=
ncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
+      =
      && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=
=3D 0
+                || strncmp(line, "ID", 2) =3D=3D 0))
         {
    =
         msg(M_INFO, "peer info: %s", line);
             env_set_add(es, l=
ine);
         }
         else
         {
-            msg(M_WARN, "validat=
ion failed on peer_info line received from client");
+            msg(M_WAR=
N, "validation failed on peer_info line received");
         }
     }
 }
di=
ff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a957fdf=2E=
=2Ee96d43c 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@=
@ -430,7 +430,7 @@
         if (mi->context=2Ec2=2Etls_multi && check_debug=
_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context=2Eoptions))
  =
       {
-            buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=2E=
tls_multi->peer_id);
+            buf_printf(&out, " rx-peer-id=3D%d", mi->=
context=2Ec2=2Etls_multi->rx_peer_id);
         }
         return BSTR(&out=
);
     }
@@ -598,9 +598,9 @@
         }
 #endif
 
-        if (mi->context=
=2Ec2=2Etls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context=2Ec2=
=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->insta=
nces[mi->context=2Ec2=2Etls_multi->peer_id] =3D NULL;
+            m->insta=
nces[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
 
             /* =
Adjust the max_peerid as this might have been the highest
              * p=
eer id instance */
@@ -908,8 +908,7 @@
 #else
                         sep,=

 #endif
-                        sep,
-                        mi->context=
=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+  =
                      sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=
=2Etls_multi->rx_peer_id : MAX_PEER_ID,
                         sep, trans=
late_cipher_name_to_openvpn(mi->context=2Eoptions=2Eciphername));
         =
        }
                 gc_free(&gc);
@@ -1727,6 +1726,7 @@
         tls=
_multi->use_peer_id =3D true;
         o->use_peer_id =3D true;
     }
+
  =
   else if (dco_enabled(o))
     {
         msg(M_INFO, "Client does not su=
pport DATA_V2=2E Data channel offloading "
@@ -3121,12 +3121,12 @@
        =
  * has, so we disallow it=2E This can happen if a DCO netlink notification=

          * gets lost and we miss a floating step=2E
          */
-       =
 if (m1->peer_id =3D=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2-=
>rx_peer_id)
         {
             msg(M_WARN,
                 "disallow=
ing peer %" PRIu32 " (%s) from floating to "
                 "its own addr=
ess (%s)",
-                m1->peer_id, tls_common_name(mi->context=2Ec2=
=2Etls_multi, false),
+                m1->rx_peer_id, tls_common_name(mi->=
context=2Ec2=2Etls_multi, false),
                 mroute_addr_print(&mi->r=
eal, &gc));
             goto done;
         }
@@ -3139,9 +3139,10 @@
     =
}
 
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",=

-        mi->context=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->contex=
t=2Ec2=2Etls_multi, false),
-        mroute_addr_print_ex(&mi->real, MAPF_S=
HOW_FAMILY, &gc),
-        mroute_addr_print_ex(&real, MAPF_SHOW_FAMILY, &g=
c));
+        mi->context=2Ec2=2Etls_multi->rx_peer_id,
+        tls_common=
_name(mi->context=2Ec2=2Etls_multi, false),
+        mroute_addr_print(&mi-=
>real, &gc),
+        print_link_socket_actual(&m->top=2Ec2=2Efrom, &gc));
=
 
     /* remove old address from hash table before changing address */
   =
  ASSERT(hash_remove(m->hash, &mi->real));
@@ -4086,7 +4087,7 @@
     {
   =
      if (!m->instances[i])
         {
-            mi->context=2Ec2=2Etls_=
multi->peer_id =3D i;
+            mi->context=2Ec2=2Etls_multi->rx_peer_id=
 =3D i;
             m->instances[i] =3D mi;
             break;
         }=

@@ -4095,11 +4096,11 @@
     /* should not really end up here, since multi=
_create_instance returns null
      * if amount of clients exceeds max_clie=
nts and this method would then
      * also not have been called */
-    AS=
SERT(mi->context=2Ec2=2Etls_multi->peer_id < m->max_clients);
+    ASSERT(m=
i->context=2Ec2=2Etls_multi->rx_peer_id < m->max_clients);
 
-    if (mi->c=
ontext=2Ec2=2Etls_multi->peer_id > m->max_peerid)
+    if (mi->context=2Ec2=
=2Etls_multi->rx_peer_id > m->max_peerid)
     {
-        m->max_peerid =3D=
 mi->context=2Ec2=2Etls_multi->peer_id;
+        m->max_peerid =3D mi->cont=
ext=2Ec2=2Etls_multi->rx_peer_id;
     }
 }
 
diff --git a/src/openvpn/opti=
ons=2Ec b/src/openvpn/options=2Ec
index 8012192=2E=2Ed83029f 100644
--- a/s=
rc/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ -3876,6 +3876,7 @@
=
                      "incompatible with each other=2E");
     }
 
+
     i=
f (dco_enabled(o))
     {
         /* check if any option should force disa=
bling DCO */
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index=
 e391147=2E=2Eee52638 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/p=
ush=2Ec
@@ -661,9 +661,10 @@
                         print_in_addr_t(c->c2=
=2Epush_ifconfig_remote_netmask, 0, gc));
     }
 
-    if (tls_multi->use_=
peer_id)
+    if (!tls_multi->use_asymmetric_peer_id)
     {
-        push_=
option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_multi->peer_id);
+    =
    push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",
+                =
        tls_multi->rx_peer_id);
     }
     /*
      * If server uses --aut=
h-gen-token and we have an auth token
diff --git a/src/openvpn/push_util=2E=
c b/src/openvpn/push_util=2Ec
index f57f54d=2E=2Ec927f26 100644
--- a/src/o=
penvpn/push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -188,7 +188,7 @@
  =
       unsigned int permission_mask =3D pull_permission_mask(c);
         i=
f (process_push_update(c, &o, permission_mask, &option_types_found, &tmp_ms=
g, true) =3D=3D PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed=
 to process push update message sent to client ID: %u", c->c2=2Etls_multi->=
peer_id);
+            msg(M_WARN, "Failed to process push update message s=
ent to client ID: %u", c->c2=2Etls_multi->rx_peer_id);
         }
         =
e =3D e->next;
     }
@@ -294,7 +294,7 @@
 
         if (!support_push_upda=
te(mi))
         {
-            msg(M_CLIENT, "PUSH_UPDATE: not sending mes=
sage to unsupported peer with ID: %u", mi->context=2Ec2=2Etls_multi->peer_i=
d);
+            msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsuppo=
rted peer with ID: %u", mi->context=2Ec2=2Etls_multi->rx_peer_id);
        =
     buffer_list_free(msgs);
             gc_free(&gc);
             return=
 0;
@@ -329,7 +329,7 @@
         /* Type is UPT_BROADCAST so we update ever=
y client */
         if (!send_single_push_update(m, curr_mi, msgs))
      =
   {
-            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", =
curr_mi->context=2Ec2=2Etls_multi->peer_id);
+            msg(M_CLIENT, "ER=
ROR: Peer ID: %u has not been updated", curr_mi->context=2Ec2=2Etls_multi->=
rx_peer_id);
             continue;
         }
         count++;
diff --git=
 a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 479d2a5=2E=2E5f3c09f 100=
644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1168,7 +1168,10=
 @@
     /* get command line derived options */
     ret->opt =3D *tls_opti=
ons;
     ret->dco_peer_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    =
ret->use_asymmetric_peer_id =3D false;
+    /* The rx_peer_id is also used =
to identify DCO clients */
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->=
tx_peer_id =3D MAX_PEER_ID;
 
     return ret;
 }
@@ -1181,6 +1184,17 @@
 
=
     tls_session_init(multi, &multi->session[TM_ACTIVE]);
     tls_session_=
init(multi, &multi->session[TM_INITIAL]);
+
+    if (!multi->opt=2Edco_enab=
led)
+    {
+        /* Calculate the asymmetric peer-id */
+        if (mu=
lti->rx_peer_id =3D=3D MAX_PEER_ID && multi->session[TM_INITIAL]=2Eopt->mod=
e !=3D MODE_SERVER)
+        {
+            uint8_t peerid[3];
+           =
 ASSERT(rand_bytes(peerid, sizeof(peerid)));
+            multi->rx_peer_id=
 =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+        }
+    }
 }=

 
 /*
@@ -1858,6 +1872,25 @@
     return str;
 }
 
+static bool
+push_peer=
_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls_sessio=
n *session)
+{
+    if (multi->rx_peer_id =3D=3D MAX_PEER_ID || session->op=
t->dco_enabled)
+    {
+        /* No valid peer id or DCO is enabled=2E Ca=
nnot use this feature */
+        return true;
+    }
+
+    /* In server m=
ode we only add this when the client has announced its
+     * support for =
the feature */
+    if (session->opt->mode !=3D MODE_SERVER || multi->use_a=
symmetric_peer_id)
+    {
+        return buf_printf(out, "ID=3D%x\n", mult=
i->rx_peer_id);
+    }
+
+    return true;
+}
+
 /**
  * Prepares the IV_ a=
nd UV_ variables that are part of the
  * exchange to signal the peer's cap=
abilities=2E The amount
@@ -1871,15 +1904,22 @@
  *
  * @param buf       th=
e buffer to write these variables to
  * @param session   the TLS session o=
bject
+ * @param multi     the TLS multi object
  * @return          true i=
f no error was encountered
  */
 static bool
-push_peer_info(struct buffer =
*buf, struct tls_session *session)
+push_peer_info(struct buffer *buf, stru=
ct tls_multi *multi, struct tls_session *session)
 {
     struct gc_arena g=
c =3D gc_new();
     bool ret =3D false;
     struct buffer out =3D alloc_b=
uf_gc(512 * 3, &gc);
 
+    /* The asymmetric peer-id is always written whe=
n enabled */
+    if (!push_peer_info_peerid(&out, multi, session))
+    {
=
+        goto error;
+    }
+
     if (session->opt->push_peer_info_detail =
> 1)
     {
         /* push version */
@@ -2025,7 +2065,9 @@
     }
     e=
lse
     {
-        if (!write_empty_string(buf)) /* no peer info */
+     =
   if (!(session->opt->mode =3D=3D MODE_SERVER && multi->use_asymmetric_pee=
r_id
+                  ? write_string(buf, BSTR(&out), -1)
+              =
    : write_empty_string(buf)))
         {
             goto error;
       =
  }
@@ -2154,7 +2196,7 @@
         }
     }
 
-    if (!push_peer_info(buf,=
 session))
+    if (!push_peer_info(buf, multi, session))
     {
         g=
oto error;
     }
@@ -2267,6 +2309,44 @@
     if (multi->peer_info)
     {
=
         output_peer_info_env(session->opt->es, multi->peer_info);
+       =
 if (session->opt->mode =3D=3D MODE_SERVER)
+        {
+            if (!se=
ssion->opt->dco_enabled)
+            {
+                uint32_t peer_id =
=3D extract_asymmetric_peer_id(multi->peer_info);
+                if (peer=
_id !=3D MAX_PEER_ID)
+                {
+                    multi->tx_pee=
r_id =3D peer_id;
+                    multi->use_asymmetric_peer_id =3D tr=
ue;
+                    multi->use_peer_id =3D true;
+                }
+ =
               else
+                {
+                    /* Client has n=
o asymmetric peer-id capability */
+                    multi->tx_peer_id =
=3D multi->rx_peer_id;
+                }
+            }
+            else
=
+            {
+                /* With DCO we don't need the tx_peer_id at=
m */
+                multi->tx_peer_id =3D multi->rx_peer_id;
+           =
 }
+        }
+    }
+    else
+    {
+        free(multi->peer_info);
+   =
     multi->peer_info =3D read_string_alloc(buf);
+    }
+    if (session->=
opt->mode =3D=3D MODE_POINT_TO_POINT && !session->opt->dco_enabled)
+    {
=
+        uint32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_info);=

+        if (peer_id !=3D MAX_PEER_ID)
+        {
+            multi->tx_p=
eer_id =3D peer_id;
+            multi->use_asymmetric_peer_id =3D true;
+ =
           multi->use_peer_id =3D true;
+        }
     }
 
     free(multi=
->remote_ciphername);
@@ -4003,8 +4083,8 @@
     msg(D_TLS_DEBUG, __func__)=
;
 
     ASSERT(ks);
-
-    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) |=
 ks->key_id) << 24 | (multi->peer_id & 0xFFFFFF));
+    peer =3D htonl(((P_=
DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
+                 | (multi->=
tx_peer_id & 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &peer, 4));
 }
=
 
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
inde=
x 6f310a5=2E=2E9a36fcf 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/op=
envpn/ssl_common=2Eh
@@ -697,8 +697,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUS=
ER (1 << 2)
 
     /* For P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t=
 rx_peer_id;
+    uint32_t tx_peer_id;
     bool use_peer_id;
+    bool use=
_asymmetric_peer_id;
 
     char *remote_ciphername; /**< cipher specified =
in peer's config file */
     bool remote_usescomp;    /**< remote announce=
d comp-lzo in OCC string */
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/open=
vpn/ssl_ncp=2Ec
index 649665a=2E=2Ee860f6d 100644
--- a/src/openvpn/ssl_ncp=
=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -406,6 +406,7 @@
 {
     /* will retu=
rn 0 if peer_info is null */
     const unsigned int iv_proto_peer =3D extr=
act_iv_proto(multi->peer_info);
+    const unsigned int tx_peer_id =3D extr=
act_asymmetric_peer_id(multi->peer_info);
 
     /* The other peer does not=
 support P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -416,7=
 +417,11 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         mult=
i->use_peer_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' '=
n' */
+        if (tx_peer_id =3D=3D MAX_PEER_ID)
+        {
+            m=
ulti->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+            multi->tx_pee=
r_id =3D 0x76706e; /* 'v' 'p' 'n' */
+        }
     }
 
     if (iv_proto_=
peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -440,8 +445,16 @@
     {
         sessio=
n->opt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
 
-        if (mu=
lti->use_peer_id)
+        /* The asymmetric peer-id trumps on the EKM gene=
rated ones */
+        if ((tx_peer_id !=3D MAX_PEER_ID) && (!multi->opt=2E=
dco_enabled))
         {
+            multi->tx_peer_id =3D tx_peer_id;
+  =
          multi->use_asymmetric_peer_id =3D true;
+        }
+        else
=
+        {
+            multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+=
            multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
             =
/* Using a non hardcoded peer-id makes a tiny bit harder to
              *=
 fingerprint packets and also gives each connection a unique
              =
* peer-id that can be useful for NAT tracking etc=2E */
@@ -458,7 +471,8 @@=

             }
             else
             {
-                multi->pe=
er_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+              =
  multi->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+=
                multi->tx_peer_id =3D multi->rx_peer_id;
             }
   =
      }
     }
@@ -500,11 +514,13 @@
         common_cipher =3D BSTR(&out);=

     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation resu=
lt: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, ciph=
er=3D%s",
-        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATER=
IAL_EXPORT), multi->use_peer_id,
-        multi->peer_id, (bool)(session->o=
pt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, "P2=
P mode NCP negotiation result: "
+                         "TLS_export=3D%d=
, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s",
+  =
      (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
=
+        multi->use_peer_id,
+        multi->rx_peer_id,
+        multi->tx=
_peer_id,
+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FO=
RMAT),
         common_cipher);
 
     gc_free(&gc);
diff --git a/src/openv=
pn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9e=2E=2E6561c48 10064=
4
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -24,7 +2=
4,7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#include "openvpn=2Eh"
 #includ=
e "ssl_util=2Eh"
 
 char *
@@ -72,6 +72,24 @@
     return 0;
 }
 
+uint32_t=

+extract_asymmetric_peer_id(const char *peer_info)
+{
+    const char *opt=
str =3D peer_info ? strstr(peer_info, "ID=3D") : NULL;
+    if (optstr)
+  =
  {
+        uint32_t peer_id =3D 0;
+        int r =3D sscanf(optstr, "ID=
=3D%x", &peer_id);
+        {
+            if (r =3D=3D 1 && peer_id < MAX_=
PEER_ID)
+            {
+                return peer_id;
+            }
+  =
      }
+    }
+    return MAX_PEER_ID;
+}
+
 const char *
 options_string_=
compat_lzo(const char *options, struct gc_arena *gc)
 {
diff --git a/src/op=
envpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 2177d94=2E=2E1a69e6f 10=
0644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
@@ -53,6=
 +53,15 @@
  */
 unsigned int extract_iv_proto(const char *peer_info);
 
+
=
+/**
+ * Extracts the ID variable and returns its value or
+ * MAX_PEER_ID =
if it cannot be extracted=2E
+ *
+ * @param peer_info     peer info string =
to search for ID
+ */
+uint32_t extract_asymmetric_peer_id(const char *peer=
_info);
+
 /**
  * Takes a locally produced OCC string for TLS server mode =
and modifies as
  * if the option comp-lzo was enabled=2E This is to send a=
 client in

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/10=
89?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13e=
e90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-Patch=
Set: 13
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer=
: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lich=
tenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerr=
it-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atten=
tion: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: its_Giaan <g=
ianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichtenheld <frank@lichtenheld=
=2Ecom>

--WG6bdERn/UQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan, plaisthos=2E </p>
<p>plaisth=
os <strong>uploaded patch set #13</strong> to the change originally created=
 by its_Giaan=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1089?usp=3Demail">View Change</a></p><p>The following approvals got outdat=
ed and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">multipeer:=
 introduce asymmetric peer-id<br><br>In order to achieve a multipeer functi=
onality, peers now<br>use separate IDs for sending (tx_peer_id) and receivi=
ng<br>(rx_peer_id)=2E<br><br>Each peer announces its own ID through pushing=
 peer-info<br>using &#39;ID=3D7f1&#39; hex format so identification can sti=
ll<br>happen even if IP/port changes=2E<br><br>In P2P mode, peer switch to =
using the announced IDs after<br>mutual exchange=2E<br>In P2MP mode, client=
s always announce their ID, and servers<br>can optionally respond with thei=
r own to enable the same<br>behavior=2E<br><br>Change-Id: I0a13ee90b6706acf=
20eabcee3bab3f2dff639bf9<br>Signed-off-by: Gianmarco De Gregori &lt;gianmar=
co@mandelbit=2Ecom&gt;<br>Signed-off-by: Arne Schwabe &lt;arne@rfc2549=2Eor=
g&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/init=2Ec<br>M src/op=
envpn/misc=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/options=2Ec<br>M=
 src/openvpn/push=2Ec<br>M src/openvpn/push_util=2Ec<br>M src/openvpn/ssl=
=2Ec<br>M src/openvpn/ssl_common=2Eh<br>M src/openvpn/ssl_ncp=2Ec<br>M src/=
openvpn/ssl_util=2Ec<br>M src/openvpn/ssl_util=2Eh<br>12 files changed, 184=
 insertions(+), 47 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/89/1089/13</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index f5b70=
81=2E=2E901b9bd 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br>=
<span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -528,14 +528,15 @@</span=
><br><span>         c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D -1;</span><br>=
<span>     }</span><br><span> #endif</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int ret =3D dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco,=
 multi-&gt;peer_id, sock-&gt;sd, NULL,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                           proto_is_dgram(sock-&gt;info=2E=
proto) ? remoteaddr : NULL, NULL, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    int ret =3D dco_new_peer(&amp;c-&gt;c1=2Etuntap-&g=
t;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                           proto_is_dgram(sock-=
&gt;info=2Eproto) ? remoteaddr : NULL,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                           NULL, NULL);</span><br><span>=
     if (ret &lt; 0)</span><br><span>     {</span><br><span>         return=
 ret;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi=
-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c-=
&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;rx_peer_id;</span><br><spa=
n> </span><br><span>     return 0;</span><br><span> }</span><br><span>@@ -6=
10,7 +611,7 @@</span><br><span> {</span><br><span>     struct context *c =
=3D &amp;mi-&gt;context;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;peer_id;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int peer_id =3D =
c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><span>     struct sockaddr *=
remoteaddr, *localaddr =3D NULL;</span><br><span>     struct sockaddr_stora=
ge local =3D { 0 };</span><br><span>     const socket_descriptor_t sd =3D c=
-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br><span>@@ -689,8 +690,7 @@</span=
><br><span>     if (addrtype =3D=3D MR_ADDR_IPV6)</span><br><span>     {</s=
pan><br><span> #if defined(_WIN32)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco=
, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                                c-&gt;c2=2Etls_multi-&gt;=
peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dc=
o_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, a=
ddr-&gt;netbits, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #el=
se</span><br><span>         const struct in6_addr *gateway =3D &amp;mi-&gt;=
context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>         if (addr-=
&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@@ -706,8 +706,7 @@</spa=
n><br><span>     else if (addrtype =3D=3D MR_ADDR_IPV4)</span><br><span>   =
  {</span><br><span> #if defined(_WIN32)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&=
gt;dco, addr-&gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_mult=
i-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Ea=
ddr, addr-&gt;netbits, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><spa=
n> #else</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4=2Ead=
dr);</span><br><span>         const in_addr_t *gateway =3D &amp;mi-&gt;cont=
ext=2Ec2=2Epush_ifconfig_local;</span><br><span>diff --git a/src/openvpn/in=
it=2Ec b/src/openvpn/init=2Ec</span><br><span>index caaa769=2E=2E468c260 10=
0644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/o=
penvpn/init=2Ec</span><br><span>@@ -2209,7 +2209,7 @@</span><br><span> </sp=
an><br><span>     if (o-&gt;use_peer_id)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;out, &quo=
t;, peer-id: %d&quot;, o-&gt;peer_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        buf_printf(&amp;out, &quot;, rx-peer-id: %u, tx-=
peer-id: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id, c-&gt;c2=2Etls_mult=
i-&gt;tx_peer_id);</span><br><span>     }</span><br><span> </span><br><span=
> #ifdef USE_COMP</span><br><span>@@ -2688,7 +2688,12 @@</span><br><span>  =
   {</span><br><span>         msg(D_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-=
id set&quot;);</span><br><span>         c-&gt;c2=2Etls_multi-&gt;use_peer_i=
d =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-=
&gt;c2=2Etls_multi-&gt;peer_id =3D c-&gt;options=2Epeer_id;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_multi-&gt;tx=
_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!c-&gt;c2=2Etls_multi-&gt;use_asymmetric_peer=
_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etl=
s_multi-&gt;rx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;tx_p=
eer_id =3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </span><b=
r><span>     /* process (potentially) pushed options */</span><br><span>@@ =
-3485,6 +3490,10 @@</span><br><span>     if (c-&gt;c2=2Etls_multi)</span><b=
r><span>     {</span><br><span>         tls_multi_init_finalize(c-&gt;c2=2E=
tls_multi, c-&gt;options=2Ece=2Etls_mtu);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (c-&gt;c2=2Etls_multi-&gt;rx_peer_id !=3D =
MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt=
;options=2Euse_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span>         ASSERT(c-&gt;c2=2Etls_multi=
-&gt;opt=2Eframe=2Ebuf=2Epayload_size &lt;=3D c-&gt;c2=2Eframe=2Ebuf=2Epayl=
oad_size);</span><br><span>         frame_print(&amp;c-&gt;c2=2Etls_multi-&=
gt;opt=2Eframe, D_MTU_INFO, &quot;Control Channel MTU parms&quot;);</span><=
br><span> </span><br><span>diff --git a/src/openvpn/misc=2Ec b/src/openvpn/=
misc=2Ec</span><br><span>index 10bfc35=2E=2Ea8c88c9 100644</span><br><span>=
--- a/src/openvpn/misc=2Ec</span><br><span>+++ b/src/openvpn/misc=2Ec</span=
><br><span>@@ -765,14 +765,15 @@</span><br><span>     {</span><br><span>   =
      chomp(line);</span><br><span>         if (validate_peer_info_line(lin=
e)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&a=
mp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&=
quot;, 3) =3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &amp;&amp; (strncmp(line, &quot;IV_&quot;, 3) =3D=3D 0 || strn=
cmp(line, &quot;UV_&quot;, 3) =3D=3D 0</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                || strncmp(line, &quot;ID&quot;, 2) =3D=
=3D 0))</span><br><span>         {</span><br><span>             msg(M_INFO,=
 &quot;peer info: %s&quot;, line);</span><br><span>             env_set_add=
(es, line);</span><br><span>         }</span><br><span>         else</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(M_WARN, &quot;validation failed on peer_info line received f=
rom client&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_WARN, &quot;validation failed on peer_info line received&q=
uot;);</span><br><span>         }</span><br><span>     }</span><br><span> }=
</span><br><span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec=
</span><br><span>index a957fdf=2E=2Ee96d43c 100644</span><br><span>--- a/sr=
c/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><=
span>@@ -430,7 +430,7 @@</span><br><span>         if (mi-&gt;context=2Ec2=
=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span>    =
         &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      buf_printf(&amp;out, &quot; peer-id=3D%d&quot;, mi-&gt;context=2Ec2=
=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&g=
t;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         }</spa=
n><br><span>         return BSTR(&amp;out);</span><br><span>     }</span><b=
r><span>@@ -598,9 +598,9 @@</span><br><span>         }</span><br><span> #en=
dif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id !=3D MAX_PEER_ID)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (mi-&gt;co=
ntext=2Ec2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m-=
&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id] =3D NULL;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            m-&gt;instance=
s[mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id] =3D NULL;</span><br><span=
> </span><br><span>             /* Adjust the max_peerid as this might have=
 been the highest</span><br><span>              * peer id instance */</span=
><br><span>@@ -908,8 +908,7 @@</span><br><span> #else</span><br><span>     =
                    sep,</span><br><span> #endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        sep,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        mi-&gt;context=2E=
c2=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id : UINT32_MAX,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    sep, mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=2Etls_multi-=
&gt;rx_peer_id : MAX_PEER_ID,</span><br><span>                         sep,=
 translate_cipher_name_to_openvpn(mi-&gt;context=2Eoptions=2Eciphername));<=
/span><br><span>                 }</span><br><span>                 gc_free=
(&amp;gc);</span><br><span>@@ -1727,6 +1726,7 @@</span><br><span>         t=
ls_multi-&gt;use_peer_id =3D true;</span><br><span>         o-&gt;use_peer_=
id =3D true;</span><br><span>     }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     else if (dco_enabled(o))</span><br><s=
pan>     {</span><br><span>         msg(M_INFO, &quot;Client does not suppo=
rt DATA_V2=2E Data channel offloading &quot;</span><br><span>@@ -3121,12 +3=
121,12 @@</span><br><span>          * has, so we disallow it=2E This can ha=
ppen if a DCO netlink notification</span><br><span>          * gets lost an=
d we miss a floating step=2E</span><br><span>          */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (m1-&gt;peer_id =3D=3D m2-&g=
t;peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><span>         {</=
span><br><span>             msg(M_WARN,</span><br><span>                 &q=
uot;disallowing peer %&quot; PRIu32 &quot; (%s) from floating to &quot;</sp=
an><br><span>                 &quot;its own address (%s)&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                m1-&gt;peer_id, t=
ls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                m1-&gt;rx_peer_id, tls_=
common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span>      =
           mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</span><br><span> =
            goto done;</span><br><span>         }</span><br><span>@@ -3139,=
9 +3139,10 @@</span><br><span>     }</span><br><span> </span><br><span>    =
 msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s) floated from %s =
to %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
i-&gt;context=2Ec2=2Etls_multi-&gt;peer_id, tls_common_name(mi-&gt;context=
=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        mroute_addr_print_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;=
gc),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mroute_ad=
dr_print_ex(&amp;real, MAPF_SHOW_FAMILY, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;context=2Ec2=2Etls_multi-&=
gt;rx_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        mroute_addr_print(&amp;mi-&=
gt;real, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       print_link_socket_actual(&amp;m-&gt;top=2Ec2=2Efrom, &amp;gc));</spa=
n><br><span> </span><br><span>     /* remove old address from hash table be=
fore changing address */</span><br><span>     ASSERT(hash_remove(m-&gt;hash=
, &amp;mi-&gt;real));</span><br><span>@@ -4086,7 +4087,7 @@</span><br><span=
>     {</span><br><span>         if (!m-&gt;instances[i])</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id =3D i;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Etls_multi-=
&gt;rx_peer_id =3D i;</span><br><span>             m-&gt;instances[i] =3D m=
i;</span><br><span>             break;</span><br><span>         }</span><br=
><span>@@ -4095,11 +4096,11 @@</span><br><span>     /* should not really en=
d up here, since multi_create_instance returns null</span><br><span>      *=
 if amount of clients exceeds max_clients and this method would then</span>=
<br><span>      * also not have been called */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ASSERT(mi-&gt;context=2Ec2=2Etls_multi-&gt;pee=
r_id &lt; m-&gt;max_clients);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id &lt; m-=
&gt;max_clients);</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id &gt; m-&g=
t;max_peerid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id &gt; m-&gt;max_peerid)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;max_peeri=
d =3D mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id;</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index 8012192=2E=
=2Ed83029f 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><=
span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -3876,6 +3876,7 @@</s=
pan><br><span>                      &quot;incompatible with each other=2E&q=
uot;);</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     if (dco_enabled(o))</span=
><br><span>     {</span><br><span>         /* check if any option should fo=
rce disabling DCO */</span><br><span>diff --git a/src/openvpn/push=2Ec b/sr=
c/openvpn/push=2Ec</span><br><span>index e391147=2E=2Eee52638 100644</span>=
<br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/src/openvpn/push=
=2Ec</span><br><span>@@ -661,9 +661,10 @@</span><br><span>                 =
        print_in_addr_t(c-&gt;c2=2Epush_ifconfig_remote_netmask, 0, gc));</=
span><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (tls_multi-&gt;use_peer_id)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!tls_multi-&gt;use_asymmetric_pee=
r_id)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        push_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quo=
t;, tls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        push_option_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         tls_multi-&gt;rx_peer_id);</span><br><span>     }</span><br><span>=
     /*</span><br><span>      * If server uses --auth-gen-token and we have=
 an auth token</span><br><span>diff --git a/src/openvpn/push_util=2Ec b/src=
/openvpn/push_util=2Ec</span><br><span>index f57f54d=2E=2Ec927f26 100644</s=
pan><br><span>--- a/src/openvpn/push_util=2Ec</span><br><span>+++ b/src/ope=
nvpn/push_util=2Ec</span><br><span>@@ -188,7 +188,7 @@</span><br><span>    =
     unsigned int permission_mask =3D pull_permission_mask(c);</span><br><s=
pan>         if (process_push_update(c, &amp;o, permission_mask, &amp;optio=
n_types_found, &amp;tmp_msg, true) =3D=3D PUSH_MSG_ERROR)</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
msg(M_WARN, &quot;Failed to process push update message sent to client ID: =
%u&quot;, c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;Failed to process pu=
sh update message sent to client ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_=
peer_id);</span><br><span>         }</span><br><span>         e =3D e-&gt;n=
ext;</span><br><span>     }</span><br><span>@@ -294,7 +294,7 @@</span><br><=
span> </span><br><span>         if (!support_push_update(mi))</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(M_CLIENT, &quot;PUSH_UPDATE: not sending message to unsupported pee=
r with ID: %u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &q=
uot;PUSH_UPDATE: not sending message to unsupported peer with ID: %u&quot;,=
 mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         =
    buffer_list_free(msgs);</span><br><span>             gc_free(&amp;gc);<=
/span><br><span>             return 0;</span><br><span>@@ -329,7 +329,7 @@<=
/span><br><span>         /* Type is UPT_BROADCAST so we update every client=
 */</span><br><span>         if (!send_single_push_update(m, curr_mi, msgs)=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            msg(M_CLIENT, &quot;ERROR: Peer ID: %u has not been upda=
ted&quot;, curr_mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            msg(M_CLIENT, &quot;E=
RROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;context=2Ec2=2Etl=
s_multi-&gt;rx_peer_id);</span><br><span>             continue;</span><br><=
span>         }</span><br><span>         count++;</span><br><span>diff --gi=
t a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 479d2a5=
=2E=2E5f3c09f 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><s=
pan>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -1168,7 +1168,10 @@</span>=
<br><span>     /* get command line derived options */</span><br><span>     =
ret-&gt;opt =3D *tls_options;</span><br><span>     ret-&gt;dco_peer_id =3D =
-1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret-&gt;peer_i=
d =3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ret-&gt;use_asymmetric_peer_id =3D false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* The rx_peer_id is also used to identify DCO=
 clients */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-=
&gt;rx_peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ret-&gt;tx_peer_id =3D MAX_PEER_ID;</span><br><span> </span=
><br><span>     return ret;</span><br><span> }</span><br><span>@@ -1181,6 +=
1184,17 @@</span><br><span> </span><br><span>     tls_session_init(multi, &=
amp;multi-&gt;session[TM_ACTIVE]);</span><br><span>     tls_session_init(mu=
lti, &amp;multi-&gt;session[TM_INITIAL]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!multi-&gt;opt=2Edco_enabled)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* Calculate the asymmetric peer-id */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (multi-&gt;rx_peer_id =3D=3D M=
AX_PEER_ID &amp;&amp; multi-&gt;session[TM_INITIAL]=2Eopt-&gt;mode !=3D MOD=
E_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t =
peerid[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   ASSERT(rand_bytes(peerid, sizeof(peerid)));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            multi-&gt;rx_peer_id =3D (peerid[0] =
&lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span><br><=
span> /*</span><br><span>@@ -1858,6 +1872,25 @@</span><br><span>     return=
 str;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+push_peer_info_peerid(struct buffer *out, struct tls_multi *=
multi, struct tls_session *session)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_en=
abled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* No valid peer id=
 or DCO is enabled=2E Cannot use this feature */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* In server mode we only add this when the client has announced its</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * support for the fe=
ature */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ses=
sion-&gt;opt-&gt;mode !=3D MODE_SERVER || multi-&gt;use_asymmetric_peer_id)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        return buf_printf(out, &q=
uot;ID=3D%x\n&quot;, multi-&gt;rx_peer_id);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><b=
r><span>  * Prepares the IV_ and UV_ variables that are part of the</span><=
br><span>  * exchange to signal the peer&#39;s capabilities=2E The amount</=
span><br><span>@@ -1871,15 +1904,22 @@</span><br><span>  *</span><br><span>=
  * @param buf       the buffer to write these variables to</span><br><span=
>  * @param session   the TLS session object</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param multi     the TLS multi object</span><br=
><span>  * @return          true if no error was encountered</span><br><spa=
n>  */</span><br><span> static bool</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-push_peer_info(struct buffer *buf, struct tls_session *sessio=
n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+push_peer_info(st=
ruct buffer *buf, struct tls_multi *multi, struct tls_session *session)</sp=
an><br><span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span>     bool ret =3D false;</span><br><span>     struct buffer out =
=3D alloc_buf_gc(512 * 3, &amp;gc);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* The asymmetric peer-id is always w=
ritten when enabled */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!push_peer_info_peerid(&amp;out, multi, session))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        goto error;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     if (session-&gt;opt-&gt;push_peer_info_d=
etail &gt; 1)</span><br><span>     {</span><br><span>         /* push versi=
on */</span><br><span>@@ -2025,7 +2065,9 @@</span><br><span>     }</span><b=
r><span>     else</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (!write_empty_string(buf)) /* no peer info */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(sessi=
on-&gt;opt-&gt;mode =3D=3D MODE_SERVER &amp;&amp; multi-&gt;use_asymmetric_=
peer_id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
      ? write_string(buf, BSTR(&amp;out), -1)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                  : write_empty_string(buf)))</sp=
an><br><span>         {</span><br><span>             goto error;</span><br>=
<span>         }</span><br><span>@@ -2154,7 +2196,7 @@</span><br><span>    =
     }</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!push_peer_info(buf, session))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!push_peer_info(buf, m=
ulti, session))</span><br><span>     {</span><br><span>         goto error;=
</span><br><span>     }</span><br><span>@@ -2267,6 +2309,44 @@</span><br><s=
pan>     if (multi-&gt;peer_info)</span><br><span>     {</span><br><span>  =
       output_peer_info_env(session-&gt;opt-&gt;es, multi-&gt;peer_info);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (session-&=
gt;opt-&gt;mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (!session-&gt;opt-&gt;dco_enabled)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                uint32_t peer_id =3D extract_=
asymmetric_peer_id(multi-&gt;peer_info);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                if (peer_id !=3D MAX_PEER_ID)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    multi-&gt;=
tx_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    multi-&gt;use_asymmetric_peer_id =3D true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    multi-&g=
t;use_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                else</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    /* Client has no asymmetric peer-id capability */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    mult=
i-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                /* With DCO we don&#39;t need the tx_peer_id atm */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                multi=
-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        free(multi-&gt;peer_info)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;=
peer_info =3D read_string_alloc(buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (session-&gt;opt-&gt;mode =3D=3D MODE_POINT_TO_POINT &amp;&amp; =
!session-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uint32_t peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_=
id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   multi-&gt;tx_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            multi-&gt;use_asymmetric_peer_id =3D true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;u=
se_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span>     }</span><br><span> </span><br><span>     fr=
ee(multi-&gt;remote_ciphername);</span><br><span>@@ -4003,8 +4083,8 @@</spa=
n><br><span>     msg(D_TLS_DEBUG, __func__);</span><br><span> </span><br><s=
pan>     ASSERT(ks);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    peer =3D htonl(((P=
_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt; 24 | (multi-&gt=
;peer_id &amp; 0xFFFFFF));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key=
_id) &lt;&lt; 24</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              | (multi-&gt;tx_peer_id &amp; 0xFFFFFF));</span><br><span>   =
  ASSERT(buf_write_prepend(buf, &amp;peer, 4));</span><br><span> }</span><b=
r><span> </span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/ope=
nvpn/ssl_common=2Eh</span><br><span>index 6f310a5=2E=2E9a36fcf 100644</span=
><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openv=
pn/ssl_common=2Eh</span><br><span>@@ -697,8 +697,10 @@</span><br><span> #de=
fine AUTH_TOKEN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><span> </span><br>=
<span>     /* For P_DATA_V2 */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    uint32_t peer_id;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint32_t rx_peer_id;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    uint32_t tx_peer_id;</span><br><span>     bool use_peer=
_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool use_as=
ymmetric_peer_id;</span><br><span> </span><br><span>     char *remote_ciphe=
rname; /**&lt; cipher specified in peer&#39;s config file */</span><br><spa=
n>     bool remote_usescomp;    /**&lt; remote announced comp-lzo in OCC st=
ring */</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/=
ssl_ncp=2Ec</span><br><span>index 649665a=2E=2Ee860f6d 100644</span><br><sp=
an>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=
=2Ec</span><br><span>@@ -406,6 +406,7 @@</span><br><span> {</span><br><span=
>     /* will return 0 if peer_info is null */</span><br><span>     const u=
nsigned int iv_proto_peer =3D extract_iv_proto(multi-&gt;peer_info);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned int tx_=
peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</span><br><spa=
n> </span><br><span>     /* The other peer does not support P2P NCP */</spa=
n><br><span>     if (!(iv_proto_peer &amp; IV_PROTO_NCP_P2P))</span><br><sp=
an>@@ -416,7 +417,11 @@</span><br><span>     if (iv_proto_peer &amp; IV_PRO=
TO_DATA_V2)</span><br><span>     {</span><br><span>         multi-&gt;use_p=
eer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   multi-&gt;peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tx_pee=
r_id =3D=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n=
&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span>     }</span><br><span> </span><br><span>     if (iv_proto_peer &a=
mp; IV_PROTO_CC_EXIT_NOTIFY)</span><br><span>@@ -440,8 +445,16 @@</span><br=
><span>     {</span><br><span>         session-&gt;opt-&gt;crypto_flags |=
=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt;use_peer_id)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* The asymmetric pe=
er-id trumps on the EKM generated ones */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if ((tx_peer_id !=3D MAX_PEER_ID) &amp;&amp; =
(!multi-&gt;opt=2Edco_enabled))</span><br><span>         {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D=
 tx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; =
&#39;n&#39; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       multi-&gt;tx_peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#39; &#39;n=
&#39; */</span><br><span>             /* Using a non hardcoded peer-id make=
s a tiny bit harder to</span><br><span>              * fingerprint packets =
and also gives each connection a unique</span><br><span>              * pee=
r-id that can be useful for NAT tracking etc=2E */</span><br><span>@@ -458,=
7 +471,8 @@</span><br><span>             }</span><br><span>             els=
e</span><br><span>             {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                multi-&gt;peer_id =3D (peerid[0] &lt;&lt; 16) + =
(peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt=
; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                multi-&gt;tx_peer_id =3D multi-&gt;=
rx_peer_id;</span><br><span>             }</span><br><span>         }</span=
><br><span>     }</span><br><span>@@ -500,11 +514,13 @@</span><br><span>   =
      common_cipher =3D BSTR(&amp;out);</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_TLS_DE=
BUG_LOW,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &quot=
;P2P mode NCP negotiation result: &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        &quot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d,=
 epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_=
KEY_MATERIAL_EXPORT), multi-&gt;use_peer_id,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        multi-&gt;peer_id, (bool)(session-&gt;opt-&g=
t;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP neg=
otiation result: &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                         &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-i=
d %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto=
_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        multi-&gt;use_peer_id,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;rx_peer_id,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;tx_peer_id=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        (bool)(ses=
sion-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><s=
pan>         common_cipher);</span><br><span> </span><br><span>     gc_free=
(&amp;gc);</span><br><span>diff --git a/src/openvpn/ssl_util=2Ec b/src/open=
vpn/ssl_util=2Ec</span><br><span>index 71fbc9e=2E=2E6561c48 100644</span><b=
r><span>--- a/src/openvpn/ssl_util=2Ec</span><br><span>+++ b/src/openvpn/ss=
l_util=2Ec</span><br><span>@@ -24,7 +24,7 @@</span><br><span> #endif</span>=
<br><span> </span><br><span> #include &quot;syshead=2Eh&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;openvpn=2Eh&quot;</span><br><span> #inc=
lude &quot;ssl_util=2Eh&quot;</span><br><span> </span><br><span> char *</sp=
an><br><span>@@ -72,6 +72,24 @@</span><br><span>     return 0;</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+uint32_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+extrac=
t_asymmetric_peer_id(const char *peer_info)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char *optstr =3D peer_info ? strstr(peer_info, &quot;ID=3D&=
quot;) : NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (optstr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint32_t peer_i=
d =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int=
 r =3D sscanf(optstr, &quot;ID=3D%x&quot;, &amp;peer_id);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (r =3D=3D 1 &amp;&amp; peer_id &=
lt; MAX_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       return peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return MAX_PEER_ID;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const char *</span><br>=
<span> options_string_compat_lzo(const char *options, struct gc_arena *gc)<=
/span><br><span> {</span><br><span>diff --git a/src/openvpn/ssl_util=2Eh b/=
src/openvpn/ssl_util=2Eh</span><br><span>index 2177d94=2E=2E1a69e6f 100644<=
/span><br><span>--- a/src/openvpn/ssl_util=2Eh</span><br><span>+++ b/src/op=
envpn/ssl_util=2Eh</span><br><span>@@ -53,6 +53,15 @@</span><br><span>  */<=
/span><br><span> unsigned int extract_iv_proto(const char *peer_info);</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Extracts the ID variable and returns i=
ts value or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * MAX_P=
EER_ID if it cannot be extracted=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param peer_info     peer info string to search for ID</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+uint32_t extract_asymmetric_peer_id(const char *peer_i=
nfo);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> /**</span><br><span>  * Takes a locally produced OCC string for TLS ser=
ver mode and modifies as</span><br><span>  * if the option comp-lzo was ena=
bled=2E This is to send a client in</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=
=3Demail">change 1089</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-O=
wner: its_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"disp=
lay:none"> Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenh=
eld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaistho=
s &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Ge=
rrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvp=
n@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: i=
ts_Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

=
</body></html>
--WG6bdERn/UQ=--


--===============0390602556381259304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0390602556381259304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0390602556381259304==--

