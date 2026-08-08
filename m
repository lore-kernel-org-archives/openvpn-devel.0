Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED9DC5AC67
	for <openvpn-devel@archiver.kernel.org>; Sat,  8 Aug 2026 15:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bq0gEcOS60D/N2B1CRf3BW9N4fnA4GAPMwvHHiGBU+Q=; b=WYCOPLhuYzimD4couw1Or+SuKg
	zT6Q0qBhozmz/QTxNDF0DP4hlG6t4f7PnmAnvZ8yQqmLit3S7emJlW0tY33oIBooTbkB+BZw6LIHU
	q9oUNYkgS0N0P2Nbes9QKWwUHVHuiHk7IEaCrqqLspni37cmYYHl4LFREXG1B9qebNZU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wsjDc-0007yL-68;
	Sat, 08 Aug 2026 15:44:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wsjDa-0007yA-O5
 for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=LPgCSWjKLZ5qKtCYH9MmcyFm+Txb7ytJNqBReSQlDms=; b=EWVDCOFSmKOEAj/LtkfBu8vaXC
 7G/pQemnFbBiPFRbU1QLQi9mBqVdFqPaZ3jUHmSWKJ+Rbe7p8WcBhiWJYnURE7oV+2nuDRDS5uX6h
 2r0g5AHfrXvVxApQQXt9prBy8/8RERzjLrC91zjnAV2pDHkdaHScJg+n57CLfGxwxsk4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LPgCSWjKLZ5qKtCYH9MmcyFm+Txb7ytJNqBReSQlDms=; b=j
 +3qd1PEqaC6MgMf/27PjJatmPq1vbn7B90qmcYguw9t14hS7dGZaw0BC3W09YxVObVgSy9hyFn6Xy
 B6Jb/rUdb7kZTpyQ0PyC9542B66RiedBk1CxvA6IFBzSdYknugPbcP1HQbSd+W7UsgN78CnMacFbD
 ZGVqC8WtlISVx/80=;
Received: from mail-wm1-f44.google.com ([209.85.128.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wsjDX-0004Yz-TK for openvpn-devel@lists.sourceforge.net;
 Sat, 08 Aug 2026 15:44:12 +0000
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so2925585e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Sat, 08 Aug 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1786203842; x=1786808642; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LPgCSWjKLZ5qKtCYH9MmcyFm+Txb7ytJNqBReSQlDms=;
 b=IvgnIISWfZ4wQbdCM5hErbdaO4zkag/Ea/sOedpDaXCqlxHlasqT1DYwOsHqr17gGN
 maYmzYUwBQ555n0kqDQohAv8PmgI8OqScIG+8uDJO2szs09IkPreAgCPnl3DB6gW105i
 Irwj4OHsrZpj5xgtRZkQAJxP/9k84gkgLN7JuPVpdv84Qb10U5Xsij/dayTg0J5NA5kY
 C3mxgSY6vzrj5PGS9UEj8kBfX6beQLMrIMOfqKcwswZ43nBqucjrtZBZlL5UyRC9L4VM
 a3A3gCXQXKJH7zLXV1dE9DpAkFCCNHtpExXCZyyU1wXFfwsJ1/7syyO1i++IwpWU/8gq
 1Uaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786203842; x=1786808642;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=LPgCSWjKLZ5qKtCYH9MmcyFm+Txb7ytJNqBReSQlDms=;
 b=iCAT9YrmXq/MPpeC4WAF38br4ZF0COPhadaK8rMvpRzs4R6eMyV4YFWIWWV4cMf7QG
 UXno4NarYMlmV6jkKFUzi3kR3oomRvGFSy9JHPvyFsJIviELO+5yHlKMvdt/Jnyk3Rnf
 v8A/jfR4kY22SwtRvKlijuOap746r7I4gCvdh7bkdSIZartvXePNrinqc+fn3VdzpBQa
 KGVkdkyrr7xdrUlLiqIoOVmN+w1xF51ENLF3mVO0BPJ1TOXxksINMuNkGA2OGdfhN+L3
 Vr6wFYV09tCzxFA06SGQdhWMFePzUSASHtsHLpXXYrvTbz1gI5xf7oIVN/J4gXIFuzPP
 6IFg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUiB6ENvwOTYaob3+CtaR7ly9unGPrtuTTUvrRLqXTVRNcl+6nhJ9G7yumOx1UToVeEyEXi5lh8XokFc9n@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyIpDUB3rV5d+4L2Oj4H3pMpWPgzggI7iBClm+fYbBy+oKpUBTL
 PX9q68619XPd9wA97DFDtld5mInbl52kGI+hi3dGpxeTNkEQPb845se7/n6pIIq+9/NPbLs6rEZ
 47zc99zApM14QG5U1fEPKG718DqvWrf+7rD92gBd/7RJ+PRRIRlPv3Ctk/LeVfhWDsz0N
X-Gm-Gg: AR+sD11+O9UB1g0Y8LbBpu8BfswsSizcj91Bu3NLM1jT420phK/XBm7K1pj1M9Cg/3w
 rGlE25C42vaFBkb1uw56ZCGzbgw8F7ROpqQRsIOfEWYK86Q+ImUhG5QG4MVK0XxbvE1qhiyAWIW
 0swtoOY4BBSwmyKtHEjz7+NvkBFEeJ/qEtzVIV5KfDsMFnxQK6im2adciy6skP1y5wQruB7E2yb
 AvpLvW3y5yDsrLY6iZbIb0VkzsfJU1h8RFZq560H8px0M51rJJ/AyC2hHaylzlj8WJMIDVU3hav
 9uF5Be8BGU/7ktcvq6ExLbGPaVPlTX+z0Xh58ytmi+0SUsA7sDcVg9mlxhyBos6OGOWKqGOuNLu
 ozDuMaZxJoaAPQ4mZS/K89j/Td2OfPQfMeEJ1rN137puGCtADGoNMW8nbEfTQoewoLF4djcQGov
 1n/ZkC296LGElRCKuEAnDA/ePhJfaKp3GqBROHLxX8plVWbtekeyccSQvU9XJneo80JcHdlMG9C
 83CA3CwLevLbTxOlENabN5faLt+eAFlk5J5XQDKvs7lHylFyBPERjXxNydatwAfccGu+aBgZ7+g
 /dyS3A1WqKpmSs1BgZaDM2KL93S2x6Lvq4WPcMaiQp7ItUjwvp0MPqWFQSwHVw==
X-Received: by 2002:a05:600c:4e93:b0:499:49f3:77b1 with SMTP id
 5b1f17b1804b1-4996193f165mr100029475e9.3.1786203841445; 
 Sat, 08 Aug 2026 08:44:01 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995ea2e038sm125252645e9.14.2026.08.08.08.44.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 08:44:01 -0700 (PDT)
X-Google-Original-From: "cron2 (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sat, 8 Aug 2026 15:44:00 +0000
To: its_Giaan <gianmarco@mandelbit.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 30
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: fc2d2f2458df63b59e93052d26a112e4fb158049
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7ecfc0f3f8b115bc706ac8d09538fd2fceaf5bcd-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wsjDX-0004Yz-TK
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
From: "cron2 \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org,
 gianmarco@mandelbit.com, openvpn-devel@lists.sourceforge.net,
 frank@lichtenheld.com, antonio@mandelbit.com
Cc: "cron2 \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============3730947256412554091=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3730947256412554091==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sHnoxS0tVAU="; charset=UTF-8

--sHnoxS0tVAU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change=2E ( http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1089?usp=3Demail )

Change subject: multipeer: introduce asymmetric pee=
r-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

multipe=
er: introduce asymmetric peer-id

In order to achieve a multipeer functiona=
lity, peers now
use separate IDs for sending (tx_peer_id) and receiving
(rx=
_peer_id)=2E

Each peer announces its own ID through pushing peer-info
usin=
g 'ID=3D7f1' hex format so identification can still
happen even if IP/port =
changes=2E

In P2P mode, peer switch to using the announced IDs after
mutua=
l exchange=2E
In P2MP mode, clients always announce their ID, and servers
c=
an optionally respond with their own to enable the same
behavior=2E

Change=
-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: Gianmarco De =
Gregori <gianmarco@mandelbit=2Ecom>
Acked-by: Arne Schwabe <arne-openvpn@rf=
c2549=2Eorg>
Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089
Me=
ssage-Id: <20260728122355=2E2566-1-gert@greenie=2Emuc=2Ede>
URL: https://ww=
w=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg37944=2Eh=
tml
Signed-off-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M src/openvpn=
/dco=2Ec
M src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=
=2Ec
M src/openvpn/options=2Eh
M src/openvpn/push=2Ec
M src/openvpn/push_ut=
il=2Ec
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl=
_ncp=2Ec
M src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
12 files cha=
nged, 168 insertions(+), 54 deletions(-)




diff --git a/src/openvpn/dco=
=2Ec b/src/openvpn/dco=2Ec
index 2584368=2E=2Ece73701 100644
--- a/src/open=
vpn/dco=2Ec
+++ b/src/openvpn/dco=2Ec
@@ -544,14 +544,15 @@
         c->c2=
=2Etls_multi->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_p=
eer(&c->c1=2Etuntap->dco, multi->peer_id, sock->sd, NULL,
-                =
           proto_is_dgram(sock->info=2Eproto) ? remoteaddr : NULL, NULL, NU=
LL);
+    int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id,=
 sock->sd, NULL,
+                           proto_is_dgram(sock->info=2Epr=
oto) ? remoteaddr : NULL,
+                           NULL, NULL);
     if =
(ret < 0)
     {
         return ret;
     }
 
-    c->c2=2Etls_multi->dco_=
peer_id =3D multi->peer_id;
+    c->c2=2Etls_multi->dco_peer_id =3D multi->=
rx_peer_id;
 
     return 0;
 }
@@ -626,7 +627,7 @@
 {
     struct context =
*c =3D &mi->context;
 
-    int peer_id =3D c->c2=2Etls_multi->peer_id;
+  =
  int peer_id =3D c->c2=2Etls_multi->rx_peer_id;
     struct sockaddr *remo=
teaddr, *localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
=
     const socket_descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ -706,=
7 +707,7 @@
     {
 #if defined(_WIN32)
         dco_win_add_iroute_ipv6(&c=
->c1=2Etuntap->dco, addr->v6=2Eaddr, addr->netbits,
-                      =
          c->c2=2Etls_multi->peer_id);
+                                c->=
c2=2Etls_multi->rx_peer_id);
 #else
         const struct in6_addr *gateway=
 =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
         if (addr->type =
& MR_ONLINK_DCO_ADDR)
@@ -723,7 +724,7 @@
     {
 #if defined(_WIN32)
     =
    dco_win_add_iroute_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->ne=
tbits,
-                                c->c2=2Etls_multi->peer_id);
+     =
                           c->c2=2Etls_multi->rx_peer_id);
 #else
         =
in_addr_t dest =3D htonl(addr->v4=2Eaddr);
         const in_addr_t *gatewa=
y =3D &mi->context=2Ec2=2Epush_ifconfig_local;
diff --git a/src/openvpn/ini=
t=2Ec b/src/openvpn/init=2Ec
index 0236886=2E=2E906a83c 100644
--- a/src/op=
envpn/init=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2203,9 +2203,10 @@
          =
          md_kt_name(o->authname));
     }
 
-    if (o->use_peer_id)
+    =
if (c->c2=2Etls_multi && c->c2=2Etls_multi->use_peer_id)
     {
-        bu=
f_printf(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", r=
x-peer-id: %u, tx-peer-id: %u", c->c2=2Etls_multi->rx_peer_id,
+           =
        c->c2=2Etls_multi->tx_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2322,=
6 +2323,11 @@
     }
 #endif
 
+    /* The peer-id can also be negotiated w=
ithout being pushed, so sync the
+     * option before the frame is recalcu=
lated: it decides whether the
+     * DATA_V2 header is accounted for */
+ =
   c->options=2Euse_peer_id =3D c->c2=2Etls_multi->use_peer_id;
+
     stru=
ct tls_session *session =3D &c->c2=2Etls_multi->session[TM_ACTIVE];
     if=
 (!tls_session_update_crypto_params(c->c2=2Etls_multi, session, &c->options=
, &c->c2=2Eframe,
                                           frame_fragment=
, get_link_socket_info(c),
@@ -2675,7 +2681,8 @@
     {
         msg(D_PUSH=
_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2=2Etls_multi->use_pee=
r_id =3D true;
-        c->c2=2Etls_multi->peer_id =3D c->options=2Epeer_id=
;
+        c->c2=2Etls_multi->tx_peer_id =3D c->options=2Epeer_id;
+       =
 c->c2=2Etls_multi->rx_peer_id =3D c->options=2Epeer_id;
     }
 
     /* p=
rocess (potentially) pushed options */
@@ -2702,7 +2709,7 @@
     /* Ensure=
 that for epoch data format is only enabled if also data v2
      * is enab=
led */
     bool epoch_data =3D c->options=2Eimported_protocol_flags & CO_E=
POCH_DATA_KEY_FORMAT;
-    bool datav2_enabled =3D c->options=2Euse_peer_id=
 && c->options=2Epeer_id < MAX_PEER_ID;
+    bool datav2_enabled =3D c->c2=
=2Etls_multi->use_peer_id && c->c2=2Etls_multi->tx_peer_id < MAX_PEER_ID;
 =

     if (epoch_data && !datav2_enabled)
     {
diff --git a/src/openvpn/mi=
sc=2Ec b/src/openvpn/misc=2Ec
index 10bfc35=2E=2Ea8c88c9 100644
--- a/src/o=
penvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec
@@ -765,14 +765,15 @@
     {
   =
      chomp(line);
         if (validate_peer_info_line(line)
-            =
&& (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0))
=
+            && (strncmp(line, "IV_", 3) =3D=3D 0 || strncmp(line, "UV_", 3=
) =3D=3D 0
+                || strncmp(line, "ID", 2) =3D=3D 0))
         {=

             msg(M_INFO, "peer info: %s", line);
             env_set_add(=
es, line);
         }
         else
         {
-            msg(M_WARN, "va=
lidation failed on peer_info line received from client");
+            msg(=
M_WARN, "validation failed on peer_info line received");
         }
     }
=
 }
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
index a4e9c1c=
=2E=2Ecfa2ad8 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/openvpn/multi=2E=
c
@@ -430,7 +430,7 @@
         if (mi->context=2Ec2=2Etls_multi && check_de=
bug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context=2Eoptions))=

         {
-            buf_printf(&out, " peer-id=3D%d", mi->context=2Ec2=
=2Etls_multi->peer_id);
+            buf_printf(&out, " rx-peer-id=3D%d", m=
i->context=2Ec2=2Etls_multi->rx_peer_id);
         }
         return BSTR(&=
out);
     }
@@ -598,9 +598,9 @@
         }
 #endif
 
-        if (mi->cont=
ext=2Ec2=2Etls_multi->peer_id !=3D MAX_PEER_ID)
+        if (mi->context=2E=
c2=2Etls_multi->rx_peer_id !=3D MAX_PEER_ID)
         {
-            m->ins=
tances[mi->context=2Ec2=2Etls_multi->peer_id] =3D NULL;
+            m->ins=
tances[mi->context=2Ec2=2Etls_multi->rx_peer_id] =3D NULL;
 
             /=
* Adjust the max_peerid as this might have been the highest
              *=
 peer id instance */
@@ -908,8 +908,7 @@
 #else
                         se=
p,
 #endif
-                        sep,
-                        mi->conte=
xt=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->peer_id : UINT32_MAX,
+=
                        sep, mi->context=2Ec2=2Etls_multi ? mi->context=2Ec=
2=2Etls_multi->rx_peer_id : MAX_PEER_ID,
                         sep, tran=
slate_cipher_name_to_openvpn(mi->context=2Eoptions=2Eciphername));
        =
         }
                 gc_free(&gc);
@@ -3121,12 +3120,12 @@
         =
 * has, so we disallow it=2E This can happen if a DCO netlink notification
=
          * gets lost and we miss a floating step=2E
          */
-        =
if (m1->peer_id =3D=3D m2->peer_id)
+        if (m1->rx_peer_id =3D=3D m2->=
rx_peer_id)
         {
             msg(M_WARN,
                 "disallowi=
ng peer %" PRIu32 " (%s) from floating to "
                 "its own addre=
ss (%s)",
-                m1->peer_id, tls_common_name(mi->context=2Ec2=2E=
tls_multi, false),
+                m1->rx_peer_id, tls_common_name(mi->con=
text=2Ec2=2Etls_multi, false),
                 mroute_addr_print(&mi->real=
, &gc));
             goto done;
         }
@@ -3139,7 +3138,8 @@
     }
 
=
     msg(D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
-  =
      mi->context=2Ec2=2Etls_multi->peer_id, tls_common_name(mi->context=2E=
c2=2Etls_multi, false),
+        mi->context=2Ec2=2Etls_multi->rx_peer_id,
=
+        tls_common_name(mi->context=2Ec2=2Etls_multi, false),
         mro=
ute_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
         mroute_addr_p=
rint_ex(&real, MAPF_SHOW_FAMILY, &gc));
 
@@ -4099,7 +4099,7 @@
     {
    =
     if (!m->instances[i])
         {
-            mi->context=2Ec2=2Etls_m=
ulti->peer_id =3D i;
+            mi->context=2Ec2=2Etls_multi->rx_peer_id =
=3D i;
             m->instances[i] =3D mi;
             break;
         }
=
@@ -4108,11 +4108,11 @@
     /* should not really end up here, since multi_=
create_instance returns null
      * if amount of clients exceeds max_clien=
ts and this method would then
      * also not have been called */
-    ASS=
ERT(mi->context=2Ec2=2Etls_multi->peer_id < m->max_clients);
+    ASSERT(mi=
->context=2Ec2=2Etls_multi->rx_peer_id < m->max_clients);
 
-    if (mi->co=
ntext=2Ec2=2Etls_multi->peer_id > m->max_peerid)
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
ons=2Eh b/src/openvpn/options=2Eh
index 2f7fe30=2E=2E30a146f 100644
--- a/s=
rc/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -697,6 +697,9 @@
  =
   enum tun_driver_type windows_driver;
 #endif
 
+    /** Whether the data=
 channel uses the DATA_V2 header (peer-id)=2E
+     *  Mirror of tls_multi-=
>use_peer_id, needed by the MTU/frame calculation
+     *  which only has a=
ccess to struct options=2E */
     bool use_peer_id;
     uint32_t peer_id;=

 
diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec
index e391147=
=2E=2E633c007d 100644
--- a/src/openvpn/push=2Ec
+++ b/src/openvpn/push=2Ec=

@@ -661,9 +661,9 @@
                         print_in_addr_t(c->c2=2Epush_=
ifconfig_remote_netmask, 0, gc));
     }
 
-    if (tls_multi->use_peer_id)=

+    if (tls_multi->use_peer_id && !tls_multi->use_asymmetric_peer_id)
   =
  {
-        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d", tls_mult=
i->peer_id);
+        push_option_fmt(gc, push_list, M_USAGE, "peer-id %d",=
 tls_multi->rx_peer_id);
     }
     /*
      * If server uses --auth-gen-t=
oken and we have an auth token
diff --git a/src/openvpn/push_util=2Ec b/src=
/openvpn/push_util=2Ec
index f57f54d=2E=2Ec927f26 100644
--- a/src/openvpn/=
push_util=2Ec
+++ b/src/openvpn/push_util=2Ec
@@ -188,7 +188,7 @@
         =
unsigned int permission_mask =3D pull_permission_mask(c);
         if (proc=
ess_push_update(c, &o, permission_mask, &option_types_found, &tmp_msg, true=
) =3D=3D PUSH_MSG_ERROR)
         {
-            msg(M_WARN, "Failed to pro=
cess push update message sent to client ID: %u", c->c2=2Etls_multi->peer_id=
);
+            msg(M_WARN, "Failed to process push update message sent to =
client ID: %u", c->c2=2Etls_multi->rx_peer_id);
         }
         e =3D e=
->next;
     }
@@ -294,7 +294,7 @@
 
         if (!support_push_update(mi))=

         {
-            msg(M_CLIENT, "PUSH_UPDATE: not sending message to=
 unsupported peer with ID: %u", mi->context=2Ec2=2Etls_multi->peer_id);
+  =
          msg(M_CLIENT, "PUSH_UPDATE: not sending message to unsupported pe=
er with ID: %u", mi->context=2Ec2=2Etls_multi->rx_peer_id);
             bu=
ffer_list_free(msgs);
             gc_free(&gc);
             return 0;
@@ =
-329,7 +329,7 @@
         /* Type is UPT_BROADCAST so we update every clien=
t */
         if (!send_single_push_update(m, curr_mi, msgs))
         {
- =
           msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", curr_mi=
->context=2Ec2=2Etls_multi->peer_id);
+            msg(M_CLIENT, "ERROR: Pe=
er ID: %u has not been updated", curr_mi->context=2Ec2=2Etls_multi->rx_peer=
_id);
             continue;
         }
         count++;
diff --git a/src/=
openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index ccd8264=2E=2Ed5100af 100644
---=
 a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -1168,7 +1168,10 @@
   =
  /* get command line derived options */
     ret->opt =3D *tls_options;
  =
   ret->dco_peer_id =3D -1;
-    ret->peer_id =3D MAX_PEER_ID;
+    ret->us=
e_asymmetric_peer_id =3D false;
+    /* The rx_peer_id is also used to iden=
tify DCO clients */
+    ret->rx_peer_id =3D MAX_PEER_ID;
+    ret->tx_peer=
_id =3D MAX_PEER_ID;
 
     return ret;
 }
@@ -1181,6 +1184,15 @@
 
     tl=
s_session_init(multi, &multi->session[TM_ACTIVE]);
     tls_session_init(mu=
lti, &multi->session[TM_INITIAL]);
+
+    if (!multi->opt=2Edco_enabled)
+ =
   {
+        /* Calculate the asymmetric peer-id */
+        if (multi->rx=
_peer_id =3D=3D MAX_PEER_ID && multi->session[TM_INITIAL]=2Eopt->mode !=3D =
MODE_SERVER)
+        {
+            multi->rx_peer_id =3D (uint32_t)(get_r=
andom() % (MAX_PEER_ID - 1));
+        }
+    }
 }
 
 /*
@@ -1858,6 +1870,2=
5 @@
     return str;
 }
 
+static bool
+push_peer_info_peerid(struct buffe=
r *out, struct tls_multi *multi, struct tls_session *session)
+{
+    if (m=
ulti->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
+    {
+ =
       /* No valid peer id or DCO is enabled=2E Cannot use this feature */
=
+        return true;
+    }
+
+    /* In server mode we only add this when=
 the client has announced its
+     * support for the feature */
+    if (s=
ession->opt->mode !=3D MODE_SERVER || multi->use_asymmetric_peer_id)
+    {=

+        return buf_printf(out, "ID=3D%x\n", multi->rx_peer_id);
+    }
+
=
+    return true;
+}
+
 /**
  * Prepares the IV_ and UV_ variables that are=
 part of the
  * exchange to signal the peer's capabilities=2E The amount
@=
@ -1871,15 +1902,22 @@
  *
  * @param buf       the buffer to write these v=
ariables to
  * @param session   the TLS session object
+ * @param multi   =
  the TLS multi object
  * @return          true if no error was encountere=
d
  */
 static bool
-push_peer_info(struct buffer *buf, struct tls_session =
*session)
+push_peer_info(struct buffer *buf, struct tls_multi *multi, stru=
ct tls_session *session)
 {
     struct gc_arena gc =3D gc_new();
     bool=
 ret =3D false;
     struct buffer out =3D alloc_buf_gc(512 * 3, &gc);
 
+ =
   /* The asymmetric peer-id is always written when enabled */
+    if (!pu=
sh_peer_info_peerid(&out, multi, session))
+    {
+        goto error;
+   =
 }
+
     if (session->opt->push_peer_info_detail > 1)
     {
         /* p=
ush version */
@@ -2019,7 +2057,11 @@
                 }
             }
   =
      }
+    }
 
+    /* write peer info string if there is anything in it,=
 empty string otherwise */
+    if (BLEN(&out) > 0)
+    {
         if (!wr=
ite_string(buf, BSTR(&out), -1))
         {
             goto error;
@@ -20=
27,7 +2069,7 @@
     }
     else
     {
-        if (!write_empty_string(bu=
f)) /* no peer info */
+        if (!write_empty_string(buf))
         {
  =
           goto error;
         }
@@ -2156,7 +2198,7 @@
         }
     }
 =

-    if (!push_peer_info(buf, session))
+    if (!push_peer_info(buf, mult=
i, session))
     {
         goto error;
     }
@@ -2269,6 +2311,19 @@
    =
 if (multi->peer_info)
     {
         output_peer_info_env(session->opt->e=
s, multi->peer_info);
+        uint32_t peer_id =3D extract_asymmetric_peer=
_id(multi->peer_info);
+        if (peer_id !=3D MAX_PEER_ID && !session->o=
pt->dco_enabled)
+        {
+            multi->tx_peer_id =3D peer_id;
+  =
          multi->use_asymmetric_peer_id =3D true;
+            multi->use_p=
eer_id =3D true;
+        }
+        else
+        {
+            /* Peer h=
as no support for asymmetric peer-id, and DCO currently
+             * can=
 only handle symmetric peer IDs */
+            multi->tx_peer_id =3D multi=
->rx_peer_id;
+        }
     }
 
     free(multi->remote_ciphername);
@@ -=
4030,8 +4085,8 @@
     msg(D_TLS_DEBUG, __func__);
 
     ASSERT(ks);
-
-  =
  peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24 | (mult=
i->peer_id & 0xFFFFFF));
+    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT)=
 | ks->key_id) << 24
+                 | (multi->tx_peer_id & 0xFFFFFF));
 =
    ASSERT(buf_write_prepend(buf, &peer, 4));
 }
 
diff --git a/src/openvpn=
/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 9c90242=2E=2Ef6392f9 100=
644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -6=
96,8 +696,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (1 << 2)
 
     /* For =
P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_peer_id;
+    uint32_t=
 tx_peer_id;
     bool use_peer_id;
+    bool use_asymmetric_peer_id;
 
   =
  char *remote_ciphername; /**< cipher specified in peer's config file */
 =
    bool remote_usescomp;    /**< remote announced comp-lzo in OCC string *=
/
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index baf5=
a95=2E=2Eb450de8 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl=
_ncp=2Ec
@@ -408,6 +408,7 @@
 {
     /* will return 0 if peer_info is null =
*/
     const unsigned int iv_proto_peer =3D extract_iv_proto(multi->peer_i=
nfo);
+    const unsigned int tx_peer_id =3D extract_asymmetric_peer_id(mul=
ti->peer_info);
 
     /* The other peer does not support P2P NCP */
     i=
f (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -418,7 +419,6 @@
     if (iv_pro=
to_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id =3D true;
- =
       multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
     }
 
     if (iv_=
proto_peer & IV_PROTO_CC_EXIT_NOTIFY)
@@ -441,27 +441,42 @@
     if (iv_pro=
to_peer & IV_PROTO_TLS_KEY_EXPORT)
     {
         session->opt->crypto_fla=
gs |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
+    }
 
-        if (multi->use_pe=
er_id)
+    if (multi->use_peer_id)
+    {
+        /* The asymmetric peer-=
id trumps on the EKM generated ones */
+        if ((iv_proto_peer & IV_PRO=
TO_TLS_KEY_EXPORT)
+            && (tx_peer_id !=3D MAX_PEER_ID) && !multi-=
>opt=2Edco_enabled)
         {
+            multi->tx_peer_id =3D tx_peer_i=
d;
+            multi->use_asymmetric_peer_id =3D true;
+        }
+       =
 else
+        {
+            uint8_t peerid[3];
             /* Using a no=
n hardcoded peer-id makes a tiny bit harder to
              * fingerprint =
packets and also gives each connection a unique
              * peer-id tha=
t can be useful for NAT tracking etc=2E */
-
-            uint8_t peerid[3]=
;
-            if (!key_state_export_keying_material(session, EXPORT_P2P_PE=
ERID_LABEL,
-                                                  strlen(EXPOR=
T_P2P_PEERID_LABEL), &peerid, 3))
+            if ((iv_proto_peer & IV_PROT=
O_TLS_KEY_EXPORT)
+                && key_state_export_keying_material(sess=
ion, EXPORT_P2P_PEERID_LABEL,
+                                            =
        strlen(EXPORT_P2P_PEERID_LABEL), &peerid, 3))
             {
-     =
           /* Non DCO setup might still work but also this should never
-  =
               * happen or very likely the TLS encryption key exporter will=

-                 * also fail */
-                msg(M_NONFATAL, "TLS key=
 export for P2P peer id failed=2E "
-                                "Conti=
nuing anyway, expect problems");
+                multi->rx_peer_id =3D (pe=
erid[0] << 16) + (peerid[1] << 8) + peerid[2];
             }
             =
else
             {
-                multi->peer_id =3D (peerid[0] << 16) +=
 (peerid[1] << 8) + peerid[2];
+                if (iv_proto_peer & IV_PROT=
O_TLS_KEY_EXPORT)
+                {
+                    /* Non DCO setup =
might still work but also this should never
+                     * happen =
or very likely the TLS encryption key exporter will
+                     *=
 also fail */
+                    msg(M_NONFATAL, "TLS key export for P2P =
peer id failed=2E "
+                                    "Continuing anyway=
, expect problems");
+                }
+                multi->rx_peer_id =
=3D 0x76706e; /* 'v' 'p' 'n' */
             }
+            multi->tx_peer_=
id =3D multi->rx_peer_id;
         }
     }
     if (iv_proto_peer & IV_PRO=
TO_DYN_TLS_CRYPT)
@@ -502,11 +517,13 @@
         common_cipher =3D BSTR(&ou=
t);
     }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation r=
esult: "
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, c=
ipher=3D%s",
-        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MA=
TERIAL_EXPORT), multi->use_peer_id,
-        multi->peer_id, (bool)(session=
->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, =
"P2P mode NCP negotiation result: "
+                         "TLS_export=
=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s"=
,
+        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPO=
RT),
+        multi->use_peer_id,
+        multi->rx_peer_id,
+        mult=
i->tx_peer_id,
+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_K=
EY_FORMAT),
         common_cipher);
 
     gc_free(&gc);
diff --git a/src/=
openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9e=2E=2E2f01f8a =
100644
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -24=
,7 +24,7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#include "openvpn=2Eh"
 #i=
nclude "ssl_util=2Eh"
 
 char *
@@ -72,6 +72,25 @@
     return 0;
 }
 
+uin=
t32_t
+extract_asymmetric_peer_id(const char *peer_info)
+{
+    for (const=
 char *p =3D peer_info; p && (p =3D strstr(p, "ID=3D")); p +=3D 3)
+    {
+=
        /* only accept "ID=3D" at the start of a line, so it does not match=

+         * substrings like "UV_ID=3D" or "GUID=3D" */
+        if (p =3D=
=3D peer_info || p[-1] =3D=3D '\n')
+        {
+            uint32_t peer_i=
d =3D 0;
+            if (sscanf(p, "ID=3D%x", &peer_id) =3D=3D 1 && peer_i=
d < MAX_PEER_ID)
+            {
+                return peer_id;
+         =
   }
+        }
+    }
+    return MAX_PEER_ID;
+}
+
 const char *
 options=
_string_compat_lzo(const char *options, struct gc_arena *gc)
 {
diff --git =
a/src/openvpn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 2177d94=2E=2E1a=
69e6f 100644
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
=
@@ -53,6 +53,15 @@
  */
 unsigned int extract_iv_proto(const char *peer_inf=
o);
 
+
+/**
+ * Extracts the ID variable and returns its value or
+ * MAX_=
PEER_ID if it cannot be extracted=2E
+ *
+ * @param peer_info     peer info=
 string to search for ID
+ */
+uint32_t extract_asymmetric_peer_id(const ch=
ar *peer_info);
+
 /**
  * Takes a locally produced OCC string for TLS serv=
er mode and modifies as
  * if the option comp-lzo was enabled=2E This is t=
o send a client in

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType:=
 merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a=
13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-Pa=
tchSet: 30
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Revie=
wer: cron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-CC=
: ordex <antonio@mandelbit=2Ecom>

--sHnoxS0tVAU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change=2E</p><p><a href=3D"http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1089?usp=3Demail">View Change</a></p><div style=3D"white-spa=
ce:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">multipeer: introduce asymmetric peer-id<br=
><br>In order to achieve a multipeer functionality, peers now<br>use separa=
te IDs for sending (tx_peer_id) and receiving<br>(rx_peer_id)=2E<br><br>Eac=
h peer announces its own ID through pushing peer-info<br>using &#39;ID=3D7f=
1&#39; hex format so identification can still<br>happen even if IP/port cha=
nges=2E<br><br>In P2P mode, peer switch to using the announced IDs after<br=
>mutual exchange=2E<br>In P2MP mode, clients always announce their ID, and =
servers<br>can optionally respond with their own to enable the same<br>beha=
vior=2E<br><br>Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Sign=
ed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>Acked-=
by: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt;<br>Gerrit URL: https://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089<br>Message-Id: &lt;20260728122355=
=2E2566-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2E=
com/openvpn-devel@lists=2Esourceforge=2Enet/msg37944=2Ehtml<br>Signed-off-b=
y: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M src/openvpn/dco=
=2Ec<br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/m=
ulti=2Ec<br>M src/openvpn/options=2Eh<br>M src/openvpn/push=2Ec<br>M src/op=
envpn/push_util=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2E=
h<br>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openv=
pn/ssl_util=2Eh<br>12 files changed, 168 insertions(+), 54 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span>=
<br><span>index 2584368=2E=2Ece73701 100644</span><br><span>--- a/src/openv=
pn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -54=
4,14 +544,15 @@</span><br><span>         c-&gt;c2=2Etls_multi-&gt;dco_peer_=
id =3D -1;</span><br><span>     }</span><br><span> #endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_peer(&amp;c-&gt=
;c1=2Etuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                           proto_is_d=
gram(sock-&gt;info=2Eproto) ? remoteaddr : NULL, NULL, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_new_peer(&amp=
;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
 proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                           NULL, NU=
LL);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</span><br>=
<span>         return ret;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=2Etls_multi-&gt;=
dco_peer_id =3D multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;rx_pe=
er_id;</span><br><span> </span><br><span>     return 0;</span><br><span> }<=
/span><br><span>@@ -626,7 +627,7 @@</span><br><span> {</span><br><span>    =
 struct context *c =3D &amp;mi-&gt;context;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =3D c-&gt;c2=2Etls_=
multi-&gt;peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><span>   =
  struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><br><span>     st=
ruct sockaddr_storage local =3D { 0 };</span><br><span>     const socket_de=
scriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><br><span>@@ -70=
6,7 +707,7 @@</span><br><span>     {</span><br><span> #if defined(_WIN32)</=
span><br><span>         dco_win_add_iroute_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;=
dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                c-&gt;c2=2Etls_multi-&=
gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                         c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><s=
pan> #else</span><br><span>         const struct in6_addr *gateway =3D &amp=
;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_local;</span><br><span>         i=
f (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)</span><br><span>@@ -723,7 +724,7=
 @@</span><br><span>     {</span><br><span> #if defined(_WIN32)</span><br><=
span>         dco_win_add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-=
&gt;v4=2Eaddr, addr-&gt;netbits,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                c-&gt;c2=2Etls_multi-&gt;peer_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
               c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span> #else=
</span><br><span>         in_addr_t dest =3D htonl(addr-&gt;v4=2Eaddr);</sp=
an><br><span>         const in_addr_t *gateway =3D &amp;mi-&gt;context=2Ec2=
=2Epush_ifconfig_local;</span><br><span>diff --git a/src/openvpn/init=2Ec b=
/src/openvpn/init=2Ec</span><br><span>index 0236886=2E=2E906a83c 100644</sp=
an><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/i=
nit=2Ec</span><br><span>@@ -2203,9 +2203,10 @@</span><br><span>            =
        md_kt_name(o-&gt;authname));</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (o-&gt;use_p=
eer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&g=
t;c2=2Etls_multi &amp;&amp; c-&gt;c2=2Etls_multi-&gt;use_peer_id)</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
buf_printf(&amp;out, &quot;, peer-id: %d&quot;, o-&gt;peer_id);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &q=
uot;, rx-peer-id: %u, tx-peer-id: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_pee=
r_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
     c-&gt;c2=2Etls_multi-&gt;tx_peer_id);</span><br><span>     }</span><br=
><span> </span><br><span> #ifdef USE_COMP</span><br><span>@@ -2322,6 +2323,=
11 @@</span><br><span>     }</span><br><span> #endif</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The peer-id can a=
lso be negotiated without being pushed, so sync the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * option before the frame is recalcu=
lated: it decides whether the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * DATA_V2 header is accounted for */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;options=2Euse_peer_id =3D c-&gt=
;c2=2Etls_multi-&gt;use_peer_id;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     struct tls_session *session =3D &amp;c-&=
gt;c2=2Etls_multi-&gt;session[TM_ACTIVE];</span><br><span>     if (!tls_ses=
sion_update_crypto_params(c-&gt;c2=2Etls_multi, session, &amp;c-&gt;options=
, &amp;c-&gt;c2=2Eframe,</span><br><span>                                  =
         frame_fragment, get_link_socket_info(c),</span><br><span>@@ -2675,=
7 +2681,8 @@</span><br><span>     {</span><br><span>         msg(D_PUSH_DEB=
UG, &quot;OPTIONS IMPORT: peer-id set&quot;);</span><br><span>         c-&g=
t;c2=2Etls_multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        c-&gt;c2=2Etls_multi-&gt;peer_id =3D c-&gt;opt=
ions=2Epeer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&gt;options=2Epeer_id;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c2=2Etls_mul=
ti-&gt;rx_peer_id =3D c-&gt;options=2Epeer_id;</span><br><span>     }</span=
><br><span> </span><br><span>     /* process (potentially) pushed options *=
/</span><br><span>@@ -2702,7 +2709,7 @@</span><br><span>     /* Ensure that=
 for epoch data format is only enabled if also data v2</span><br><span>    =
  * is enabled */</span><br><span>     bool epoch_data =3D c-&gt;options=2E=
imported_protocol_flags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    bool datav2_enabled =3D c-&gt;options=
=2Euse_peer_id &amp;&amp; c-&gt;options=2Epeer_id &lt; MAX_PEER_ID;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    bool datav2_enabled =3D=
 c-&gt;c2=2Etls_multi-&gt;use_peer_id &amp;&amp; c-&gt;c2=2Etls_multi-&gt;t=
x_peer_id &lt; MAX_PEER_ID;</span><br><span> </span><br><span>     if (epoc=
h_data &amp;&amp; !datav2_enabled)</span><br><span>     {</span><br><span>d=
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
/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index a4e9c1=
c=2E=2Ecfa2ad8 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br=
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
@ -3121,12 +3120,12 @@</span><br><span>          * has, so we disallow it=
=2E This can happen if a DCO netlink notification</span><br><span>         =
 * gets lost and we miss a floating step=2E</span><br><span>          */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m1-&gt;peer_=
id =3D=3D m2-&gt;peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;rx_peer_id)</span><br><sp=
an>         {</span><br><span>             msg(M_WARN,</span><br><span>    =
             &quot;disallowing peer %&quot; PRIu32 &quot; (%s) from floatin=
g to &quot;</span><br><span>                 &quot;its own address (%s)&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m1=
-&gt;peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                m1-&gt;r=
x_peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><=
br><span>                 mroute_addr_print(&amp;mi-&gt;real, &amp;gc));</s=
pan><br><span>             goto done;</span><br><span>         }</span><br>=
<span>@@ -3139,7 +3138,8 @@</span><br><span>     }</span><br><span> </span>=
<br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&quot; PRIu32 &quot; (%s) fl=
oated from %s to %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id, tls_common_name(m=
i-&gt;context=2Ec2=2Etls_multi, false),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_common_=
name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><br><span>         mrou=
te_addr_print_ex(&amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span><br><s=
pan>         mroute_addr_print_ex(&amp;real, MAPF_SHOW_FAMILY, &amp;gc));</=
span><br><span> </span><br><span>@@ -4099,7 +4099,7 @@</span><br><span>    =
 {</span><br><span>         if (!m-&gt;instances[i])</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mi-&g=
t;context=2Ec2=2Etls_multi-&gt;peer_id =3D i;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            mi-&gt;context=2Ec2=2Etls_multi-&gt;r=
x_peer_id =3D i;</span><br><span>             m-&gt;instances[i] =3D mi;</s=
pan><br><span>             break;</span><br><span>         }</span><br><spa=
n>@@ -4108,11 +4108,11 @@</span><br><span>     /* should not really end up =
here, since multi_create_instance returns null</span><br><span>      * if a=
mount of clients exceeds max_clients and this method would then</span><br><=
span>      * also not have been called */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    ASSERT(mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id =
&lt; m-&gt;max_clients);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ASSERT(mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id &lt; m-&gt;m=
ax_clients);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id &gt; m-&gt;max=
_peerid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi-=
&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id &gt; m-&gt;max_peerid)</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 m-&gt;max_peerid =3D mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        m-&gt;max_peerid =3D=
 mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id;</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/=
options=2Eh b/src/openvpn/options=2Eh</span><br><span>index 2f7fe30=2E=2E30=
a146f 100644</span><br><span>--- a/src/openvpn/options=2Eh</span><br><span>=
+++ b/src/openvpn/options=2Eh</span><br><span>@@ -697,6 +697,9 @@</span><br=
><span>     enum tun_driver_type windows_driver;</span><br><span> #endif</s=
pan><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/** Whether the data channel uses the DATA_V2 header (peer-id)=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     *  Mirror of tls_multi-&=
gt;use_peer_id, needed by the MTU/frame calculation</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     *  which only has access to struct o=
ptions=2E */</span><br><span>     bool use_peer_id;</span><br><span>     ui=
nt32_t peer_id;</span><br><span> </span><br><span>diff --git a/src/openvpn/=
push=2Ec b/src/openvpn/push=2Ec</span><br><span>index e391147=2E=2E633c007d=
 100644</span><br><span>--- a/src/openvpn/push=2Ec</span><br><span>+++ b/sr=
c/openvpn/push=2Ec</span><br><span>@@ -661,9 +661,9 @@</span><br><span>    =
                     print_in_addr_t(c-&gt;c2=2Epush_ifconfig_remote_netmas=
k, 0, gc));</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tls_multi-&gt;use_peer_id)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (tls_multi-&gt;use_pe=
er_id &amp;&amp; !tls_multi-&gt;use_asymmetric_peer_id)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        push_optio=
n_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;peer_id=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        push_opti=
on_fmt(gc, push_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;rx_pee=
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
/openvpn/ssl=2Ec</span><br><span>index ccd8264=2E=2Ed5100af 100644</span><b=
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
span><br><span> }</span><br><span>@@ -1181,6 +1184,15 @@</span><br><span> <=
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
r: hsl(120, 100%, 40%);">+            multi-&gt;rx_peer_id =3D (uint32_t)(g=
et_random() % (MAX_PEER_ID - 1));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span> }</span><br><span> </span><br><span> /*</span><b=
r><span>@@ -1858,6 +1870,25 @@</span><br><span>     return str;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pu=
sh_peer_info_peerid(struct buffer *out, struct tls_multi *multi, struct tls=
_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;r=
x_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_enabled)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* No valid peer id or DCO is enable=
d=2E Cannot use this feature */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* In server mod=
e we only add this when the client has announced its</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * support for the feature */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (session-&gt;opt-&gt=
;mode !=3D MODE_SERVER || multi-&gt;use_asymmetric_peer_id)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return buf_printf(out, &quot;ID=3D%x\n&qu=
ot;, multi-&gt;rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Prep=
ares the IV_ and UV_ variables that are part of the</span><br><span>  * exc=
hange to signal the peer&#39;s capabilities=2E The amount</span><br><span>@=
@ -1871,15 +1902,22 @@</span><br><span>  *</span><br><span>  * @param buf  =
     the buffer to write these variables to</span><br><span>  * @param sess=
ion   the TLS session object</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param multi     the TLS multi object</span><br><span>  * @retu=
rn          true if no error was encountered</span><br><span>  */</span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pu=
sh_peer_info(struct buffer *buf, struct tls_session *session)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+push_peer_info(struct buffer *buf=
, struct tls_multi *multi, struct tls_session *session)</span><br><span> {<=
/span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     =
bool ret =3D false;</span><br><span>     struct buffer out =3D alloc_buf_gc=
(512 * 3, &amp;gc);</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* The asymmetric peer-id is always written when enab=
led */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!push=
_peer_info_peerid(&amp;out, multi, session))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        goto error;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     if (session-&gt;opt-&gt;push_peer_info_detail &gt; 1)</s=
pan><br><span>     {</span><br><span>         /* push version */</span><br>=
<span>@@ -2019,7 +2057,11 @@</span><br><span>                 }</span><br><=
span>             }</span><br><span>         }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* write peer info string if there is an=
ything in it, empty string otherwise */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (BLEN(&amp;out) &gt; 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span>         if (!write_st=
ring(buf, BSTR(&amp;out), -1))</span><br><span>         {</span><br><span> =
            goto error;</span><br><span>@@ -2027,7 +2069,7 @@</span><br><sp=
an>     }</span><br><span>     else</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (!write_empty_string(buf)) =
/* no peer info */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!write_empty_string(buf))</span><br><span>         {</span><br><=
span>             goto error;</span><br><span>         }</span><br><span>@@=
 -2156,7 +2198,7 @@</span><br><span>         }</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
push_peer_info(buf, session))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (!push_peer_info(buf, multi, session))</span><br><span>   =
  {</span><br><span>         goto error;</span><br><span>     }</span><br><=
span>@@ -2269,6 +2311,19 @@</span><br><span>     if (multi-&gt;peer_info)</=
span><br><span>     {</span><br><span>         output_peer_info_env(session=
-&gt;opt-&gt;es, multi-&gt;peer_info);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        uint32_t peer_id =3D extract_asymmetric_peer_id(=
multi-&gt;peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (peer_id !=3D MAX_PEER_ID &amp;&amp; !session-&gt;opt-&gt;dco_=
enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt=
;tx_peer_id =3D peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            multi-&gt;use_asymmetric_peer_id =3D true;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_peer_id =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* Peer has no support fo=
r asymmetric peer-id, and DCO currently</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+             * can only handle symmetric peer IDs */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;=
tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </span><=
br><span>     free(multi-&gt;remote_ciphername);</span><br><span>@@ -4030,8=
 +4085,8 @@</span><br><span>     msg(D_TLS_DEBUG, __func__);</span><br><spa=
n> </span><br><span>     ASSERT(ks);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    pe=
er =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHIFT) | ks-&gt;key_id) &lt;&lt;=
 24 | (multi-&gt;peer_id &amp; 0xFFFFFF));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    peer =3D htonl(((P_DATA_V2 &lt;&lt; P_OPCODE_SHI=
FT) | ks-&gt;key_id) &lt;&lt; 24</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 | (multi-&gt;tx_peer_id &amp; 0xFFFFFF));</sp=
an><br><span>     ASSERT(buf_write_prepend(buf, &amp;peer, 4));</span><br><=
span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_comm=
on=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 9c90242=2E=2Ef639=
2f9 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><br><span=
>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -696,8 +696,10 @@</spa=
n><br><span> #define AUTH_TOKEN_VALID_EMPTYUSER (1 &lt;&lt; 2)</span><br><s=
pan> </span><br><span>     /* For P_DATA_V2 */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    uint32_t peer_id;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint32_t rx_peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t tx_peer_id;</span><br><span>=
     bool use_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool use_asymmetric_peer_id;</span><br><span> </span><br><span>     =
char *remote_ciphername; /**&lt; cipher specified in peer&#39;s config file=
 */</span><br><span>     bool remote_usescomp;    /**&lt; remote announced =
comp-lzo in OCC string */</span><br><span>diff --git a/src/openvpn/ssl_ncp=
=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index baf5a95=2E=2Eb450de8 1=
00644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl_ncp=2Ec</span><br><span>@@ -408,6 +408,7 @@</span><br><span>=
 {</span><br><span>     /* will return 0 if peer_info is null */</span><br>=
<span>     const unsigned int iv_proto_peer =3D extract_iv_proto(multi-&gt;=
peer_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t unsigned int tx_peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_inf=
o);</span><br><span> </span><br><span>     /* The other peer does not suppo=
rt P2P NCP */</span><br><span>     if (!(iv_proto_peer &amp; IV_PROTO_NCP_P=
2P))</span><br><span>@@ -418,7 +419,6 @@</span><br><span>     if (iv_proto_=
peer &amp; IV_PROTO_DATA_V2)</span><br><span>     {</span><br><span>       =
  multi-&gt;use_peer_id =3D true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        multi-&gt;peer_id =3D 0x76706e; /* &#39;v&#39; &#39;p&#=
39; &#39;n&#39; */</span><br><span>     }</span><br><span> </span><br><span=
>     if (iv_proto_peer &amp; IV_PROTO_CC_EXIT_NOTIFY)</span><br><span>@@ -=
441,27 +441,42 @@</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_TLS=
_KEY_EXPORT)</span><br><span>     {</span><br><span>         session-&gt;op=
t-&gt;crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (multi-&gt;use_peer_id)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;use_=
peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* The asymmetric=
 peer-id trumps on the EKM generated ones */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if ((iv_proto_peer &amp; IV_PROTO_TLS_KEY_=
EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&amp;&amp; (tx_peer_id !=3D MAX_PEER_ID) &amp;&amp; !multi-&gt;opt=2Edco_en=
abled)</span><br><span>         {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            multi-&gt;tx_peer_id =3D tx_peer_id;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;use_asymme=
tric_peer_id =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t peer=
id[3];</span><br><span>             /* Using a non hardcoded peer-id makes =
a tiny bit harder to</span><br><span>              * fingerprint packets an=
d also gives each connection a unique</span><br><span>              * peer-=
id that can be useful for NAT tracking etc=2E */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            uint8_t peerid[3];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (!key_state_export_keying_material(session, E=
XPORT_P2P_PEERID_LABEL,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                                  strlen(EXPORT_P2P_PEERI=
D_LABEL), &amp;peerid, 3))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if ((iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp;=
 key_state_export_keying_material(session, EXPORT_P2P_PEERID_LABEL,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
                         strlen(EXPORT_P2P_PEERID_LABEL), &amp;peerid, 3))<=
/span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                /* Non DCO setup might still work but also this sh=
ould never</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
      * happen or very likely the TLS encryption key exporter will</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 * also fail *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(=
M_NONFATAL, &quot;TLS key export for P2P peer id failed=2E &quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                               =
 &quot;Continuing anyway, expect problems&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                multi-&gt;rx_peer_id =3D (pee=
rid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</span><br><span> =
            }</span><br><span>             else</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                mu=
lti-&gt;peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peer=
id[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    /* Non DCO setup migh=
t still work but also this should never</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                     * happen or very likely the TLS en=
cryption key exporter will</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                     * also fail */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    msg(M_NONFATAL, &quot;TLS key ex=
port for P2P peer id failed=2E &quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                    &quot;Continuing anyw=
ay, expect problems&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                multi-&gt;rx_peer_id =3D 0x76706e; /* &#39;v&#39; &#3=
9;p&#39; &#39;n&#39; */</span><br><span>             }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            multi-&gt;tx_peer_id =3D mul=
ti-&gt;rx_peer_id;</span><br><span>         }</span><br><span>     }</span>=
<br><span>     if (iv_proto_peer &amp; IV_PROTO_DYN_TLS_CRYPT)</span><br><s=
pan>@@ -502,11 +517,13 @@</span><br><span>         common_cipher =3D BSTR(&=
amp;out);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_TLS_DEBUG_LOW,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        &quot;P2P mode NCP negotiation resu=
lt: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &qu=
ot;TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=3D%s&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (bool)(sessi=
on-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT), multi-&g=
t;use_peer_id,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 multi-&gt;peer_id, (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_EPOCH_=
DATA_KEY_FORMAT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiation result: &quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                         &=
quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%=
d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_KEY_MATE=
RIAL_EXPORT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  multi-&gt;use_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        multi-&gt;rx_peer_id,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        multi-&gt;tx_peer_id,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        (bool)(session-&gt;opt-&gt;crypto_flags &a=
mp; CO_EPOCH_DATA_KEY_FORMAT),</span><br><span>         common_cipher);</sp=
an><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span>diff =
--git a/src/openvpn/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec</span><br><span=
>index 71fbc9e=2E=2E2f01f8a 100644</span><br><span>--- a/src/openvpn/ssl_ut=
il=2Ec</span><br><span>+++ b/src/openvpn/ssl_util=2Ec</span><br><span>@@ -2=
4,7 +24,7 @@</span><br><span> #endif</span><br><span> </span><br><span> #in=
clude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;openvpn=2Eh&quot;</span><br><span> #include &quot;ssl_util=2Eh&quot;</s=
pan><br><span> </span><br><span> char *</span><br><span>@@ -72,6 +72,25 @@<=
/span><br><span>     return 0;</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+uint32_t</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+extract_asymmetric_peer_id(const char =
*peer_info)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    for (const char *p =3D=
 peer_info; p &amp;&amp; (p =3D strstr(p, &quot;ID=3D&quot;)); p +=3D 3)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* only accept &quot;ID=3D&q=
uot; at the start of a line, so it does not match</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+         * substrings like &quot;UV_ID=3D&quo=
t; or &quot;GUID=3D&quot; */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (p =3D=3D peer_info || p[-1] =3D=3D &#39;\n&#39;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            uint32_t peer_id =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (ssc=
anf(p, &quot;ID=3D%x&quot;, &amp;peer_id) =3D=3D 1 &amp;&amp; peer_id &lt; =
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

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div =
style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displa=
y:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-C=
hange-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9 </div>
<div style=3D"di=
splay:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none">=
 Gerrit-PatchSet: 30 </div>
<div style=3D"display:none"> Gerrit-Owner: its_=
Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: cron2 &lt;gert@greenie=2Emuc=2Ede&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC:=
 openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div =
style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@mandelbit=2Ecom&gt; </=
div>

</body></html>
--sHnoxS0tVAU=--


--===============3730947256412554091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3730947256412554091==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3730947256412554091==--

