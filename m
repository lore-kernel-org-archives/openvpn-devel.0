Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39899CD98C5
	for <openvpn-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u0nfY/7VD+9itF5FXkpX3y0+nki16ejD1WAnEwCrKJM=; b=E7XBMYCelQaXIeh8UK8KjssXXS
	bnQ/tq5t7jSQN8FRWZfrZvHcSIJIsRCIgnar95ZhSS8RURZh/gyJbQtkeIA7mY94rsdNvjGEWn2xp
	nMBhTn1kdbZUF2Hqsx5DuoYj0qE4S6ZpLYLvjKJUYeKZqV5BV9PAhr424QlSdbUpt3E0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1wWymh-0000on-EG;
	Tue, 09 Jun 2026 15:54:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1wWymf-0000md-Po
 for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:54:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=cTiBKHvlYRJ5kzzQ0EZFaK85X1J9tiAVFqD5s0NlSRI=; b=VOQ+RlInIcytMEjXW2ereJcOvC
 xS4+W+gvquqN2P7V13ZLk3EMrGTm3hVFXOQJJsFCYOoKnE2tKrA5OFyyZczQpOw5CjjLDMYF4EKBe
 VU3X9GCAwj2ndYoUHogHJugqQzUxS5/Fj6nbnGzAROpW9rLKUtG3DeCpnDrqsDKhQYzk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cTiBKHvlYRJ5kzzQ0EZFaK85X1J9tiAVFqD5s0NlSRI=; b=K
 /YAVdyElufTYKvNtZe4hzSXQ3NeooT9zqT8UoiLgyLfATwkM+zHiZ/3gp1K4DCWRb53iaWNOUD8yG
 iVU5sd7z0j0Kl8LLlvLbQtZ1YDkqnHcFJ+YDF3jrce2R/nb6LldvXQ3GTO1xrKU8uW6/p28Ym11SH
 7v3vaYENUE003tXE=;
Received: from mail-lj1-f175.google.com ([209.85.208.175])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wWym6-0008V6-6a for openvpn-devel@lists.sourceforge.net;
 Tue, 09 Jun 2026 15:54:03 +0000
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-39697a4e16cso54119481fa.3
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1781020432; x=1781625232; darn=lists.sourceforge.net;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cTiBKHvlYRJ5kzzQ0EZFaK85X1J9tiAVFqD5s0NlSRI=;
 b=DfxL2GrWQOBz0ym3idwiDqztUsdEfr25IyRhavOcj6W1JqIVUybTW2ZuQeaDyywIal
 4lNxJfLPKQTfvdz2BYQf2RV7g/tJvI1Xfl0IZIjwl0Yf3MIouS5tnhC6DEpOEpm1oIaM
 /daBQfPc4xLz5QZ4g4DX4mvuR4yyBy+7R4l7b4Wjvpoz57fNKrz8pqFSvO3wDf18oecf
 oyUfftjzVijC007fKVtfh+SxLqj+Omza4tter5I8e5xYjQ/jWbrtfKq63i0XnYxw3w00
 o+TJ+1Xdz2sWM99ZBoPvnmvpIe7iANxXuyrJ1mEFPP7y9PQRqRLbQoQIxjASfTo6RZtV
 ltGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781020432; x=1781625232;
 h=user-agent:content-disposition:content-transfer-encoding
 :mime-version:message-id:reply-to:subject:thread-index:references
 :in-reply-to:list-unsubscribe:list-id:auto-submitted:cc:to:date:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cTiBKHvlYRJ5kzzQ0EZFaK85X1J9tiAVFqD5s0NlSRI=;
 b=OkUUugwDhI8/Nw5AxBzbLyUX2oT8IKkZ5nqdK24FxqEHuqtEDFzKr4zUcoVJ5gxrhS
 chD0xcRwltMv9FGIE6/NrbNjs7uDdNiYKO9hgZHpgMUXWZNa9R/B3wKsD1XkfmlzL59y
 LGrysEXelW77OCri+xJ8AevCO5LJspegpsMBjvbczihdqtvPQLpJEfyFKpDBX/7JbFsm
 JMf3ONPT25QqffXq5nbaP8woU3FZ77hpqBqQQlgOxhd/NoAtTm/PgH10rbt/esQYbv+0
 9hAYE7yN6yab+EHYrGqlg9WMwEaWgkTorr9LMShi/FbaBq7JfMUOkz+I5VddZFBdylbO
 7fBg==
X-Gm-Message-State: AOJu0Yy0Bu0gWK8kQj+v5FxrGr2dsGN6kz/sZisW4TpJmhOxDMWw7iKY
 6FiTQELg8xxCyJXJf78kruk2c5PuvblmVSH48ZVK7HpZQdCtsbuBru2Z+oIqymKACGLYO5AWKRV
 vnTrWdOaEM6I157gYmH3/yz+chAtdhArb1FJq4ikTETC51yXMdOQSviFenGDAwi12+kZnoihrZF
 IMZc3Ohw==
X-Gm-Gg: Acq92OGzrn6uE7xkVyVInXWG3CSMly74pCvJf7NSuLsl9ZMfWjl/jZ3WAJoBlocfmTI
 bSx6sQ1ehSCZ1YR7c1fQlQbWMRNmblr3k+0AD4ZbyTspGCb74rCVVn4zSm7v48raLulmw+Dhb62
 cN5MxY6BJUYwHV3pmdQc0oKYGGAN9ekx1wT0krGxpQHpQuYNfRGMHWAzs4QnPBRgUmPtLcIq2zy
 E1qRnUDWaWLVREAG1OJii4yT2gO+mO6zaf043n6uxQwVzq4DYBkE5dM09r09tPSHPtVa1txPbcM
 3EYyzD2ZbP/G2seegtj5lBmd6hZAADVMpARM4Dz6QclKYt2R+gpGTQ7o+dFSWJnhTyTJsJD3Euy
 qnfCBqKUbSv6TqR0Y+1QVrXKan4CkUKnD98JDZLJ9QVZr94Q6Hw3PcGeBptlscw+v/suSl6VISb
 BDQ5CR9uYkxUoW++Hdo3mdBbnAzi++4CsKrW23CtVDPPC8OL4Nx5a1/5mZO2KASzEcPYlSQpn8n
 rLhORO5YKlixOculbbwlzuWmgUM9aA5+dJ3msMbseIMa10r0P0AsaiNhxVs2zsdIRfnCEVIOfOh
 m+KSsFk67Ha7c4aH5ZorETqY
X-Received: by 2002:a05:600c:190f:b0:490:53d3:47a9 with SMTP id
 5b1f17b1804b1-490d71ecc8bmr31027195e9.3.1781006121267; 
 Tue, 09 Jun 2026 04:55:21 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f3444fesm61696646f8f.20.2026.06.09.04.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 04:55:20 -0700 (PDT)
X-Google-Original-From: "its_Giaan (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 9 Jun 2026 11:55:18 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
X-Gerrit-Change-Number: 1089
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1089?usp=email>
X-Gerrit-Commit: 945fac1b51d7eba143abca65da6f8ccacd12c3be
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzUyNzQzODU0MDAwLkkwYTEzZWU5MGI2NzA2YWNmMjBlYWJjZWUzYmFiM2YyZGZmNjM5YmY5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9b6168086f0d03deb4c046e2e2d58ab7a6857f6e-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.11.5
X-Headers-End: 1wWym6-0008V6-6a
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
Content-Type: multipart/mixed; boundary="===============7906176586709037092=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7906176586709037092==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TxeAtXoOIpQ="; charset=UTF-8

--TxeAtXoOIpQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan=2E

Hello cro=
n2, flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E Please=
 visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail

to =
look at the new patch set (#12)=2E


Change subject: multipeer: introduce a=
symmetric peer-id
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

multipeer: introduce asymmetric peer-id

In order to achieve a multipe=
er functionality, peers now
use separate IDs for sending (tx_peer_id) and r=
eceiving
(rx_peer_id)=2E

Each peer announces its own ID through pushing pe=
er-info
using 'ID=3D7f1' hex format so identification can still
happen even=
 if IP/port changes=2E

In P2P mode, peer switch to using the announced IDs=
 after
mutual exchange=2E
In P2MP mode, clients always announce their ID, a=
nd servers
can optionally respond with their own to enable the same
behavio=
r=2E

Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Signed-off-by: G=
ianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M=
 src/openvpn/init=2Ec
M src/openvpn/misc=2Ec
M src/openvpn/multi=2Ec
M src/=
openvpn/options=2Ec
M src/openvpn/push=2Ec
M src/openvpn/push_util=2Ec
M sr=
c/openvpn/ssl=2Ec
M src/openvpn/ssl_common=2Eh
M src/openvpn/ssl_ncp=2Ec
M =
src/openvpn/ssl_util=2Ec
M src/openvpn/ssl_util=2Eh
12 files changed, 191 i=
nsertions(+), 47 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:294=
18/openvpn refs/changes/89/1089/12

diff --git a/src/openvpn/dco=2Ec b/src/=
openvpn/dco=2Ec
index f5b7081=2E=2E901b9bd 100644
--- a/src/openvpn/dco=2Ec=

+++ b/src/openvpn/dco=2Ec
@@ -528,14 +528,15 @@
         c->c2=2Etls_multi=
->dco_peer_id =3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1=
=2Etuntap->dco, multi->peer_id, sock->sd, NULL,
-                          =
 proto_is_dgram(sock->info=2Eproto) ? remoteaddr : NULL, NULL, NULL);
+    =
int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi->rx_peer_id, sock->sd,=
 NULL,
+                           proto_is_dgram(sock->info=2Eproto) ? rem=
oteaddr : NULL,
+                           NULL, NULL);
     if (ret < 0)
=
     {
         return ret;
     }
 
-    c->c2=2Etls_multi->dco_peer_id =
=3D multi->peer_id;
+    c->c2=2Etls_multi->dco_peer_id =3D multi->rx_peer_=
id;
 
     return 0;
 }
@@ -610,7 +611,7 @@
 {
     struct context *c =3D &=
mi->context;
 
-    int peer_id =3D c->c2=2Etls_multi->peer_id;
+    int pe=
er_id =3D c->c2=2Etls_multi->rx_peer_id;
     struct sockaddr *remoteaddr, =
*localaddr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     con=
st socket_descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ -689,8 +690,7=
 @@
     if (addrtype =3D=3D MR_ADDR_IPV6)
     {
 #if defined(_WIN32)
-   =
     dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->v6=2Eaddr, addr->n=
etbits,
-                                c->c2=2Etls_multi->peer_id);
+    =
    dco_win_add_iroute_ipv6(&c->c1=2Etuntap->dco, addr->v6=2Eaddr, addr->ne=
tbits, c->c2=2Etls_multi->rx_peer_id);
 #else
         const struct in6_add=
r *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_ipv6_local;
         if (a=
ddr->type & MR_ONLINK_DCO_ADDR)
@@ -706,8 +706,7 @@
     else if (addrtype =
=3D=3D MR_ADDR_IPV4)
     {
 #if defined(_WIN32)
-        dco_win_add_irout=
e_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits,
-             =
                   c->c2=2Etls_multi->peer_id);
+        dco_win_add_iroute=
_ipv4(&c->c1=2Etuntap->dco, addr->v4=2Eaddr, addr->netbits, c->c2=2Etls_mul=
ti->rx_peer_id);
 #else
         in_addr_t dest =3D htonl(addr->v4=2Eaddr);=

         const in_addr_t *gateway =3D &mi->context=2Ec2=2Epush_ifconfig_lo=
cal;
diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec
index caaa769=
=2E=2E468c260 100644
--- a/src/openvpn/init=2Ec
+++ b/src/openvpn/init=2Ec
=
@@ -2209,7 +2209,7 @@
 
     if (o->use_peer_id)
     {
-        buf_printf=
(&out, ", peer-id: %d", o->peer_id);
+        buf_printf(&out, ", rx-peer-i=
d: %u, tx-peer-id: %u", c->c2=2Etls_multi->rx_peer_id, c->c2=2Etls_multi->t=
x_peer_id);
     }
 
 #ifdef USE_COMP
@@ -2688,7 +2688,12 @@
     {
       =
  msg(D_PUSH_DEBUG, "OPTIONS IMPORT: peer-id set");
         c->c2=2Etls_mu=
lti->use_peer_id =3D true;
-        c->c2=2Etls_multi->peer_id =3D c->optio=
ns=2Epeer_id;
+        c->c2=2Etls_multi->tx_peer_id =3D c->options=2Epeer_=
id;
+        if (!c->c2=2Etls_multi->use_asymmetric_peer_id)
+        {
+  =
          c->c2=2Etls_multi->rx_peer_id =3D c->options=2Epeer_id;
+        =
    c->c2=2Etls_multi->tx_peer_id =3D c->options=2Epeer_id;
+        }
    =
 }
 
     /* process (potentially) pushed options */
@@ -3485,6 +3490,10 @@=

     if (c->c2=2Etls_multi)
     {
         tls_multi_init_finalize(c->c2=
=2Etls_multi, c->options=2Ece=2Etls_mtu);
+        if (c->c2=2Etls_multi->r=
x_peer_id !=3D MAX_PEER_ID)
+        {
+            c->options=2Euse_peer_i=
d =3D true;
+        }
         ASSERT(c->c2=2Etls_multi->opt=2Eframe=2Ebuf=
=2Epayload_size <=3D c->c2=2Eframe=2Ebuf=2Epayload_size);
         frame_pr=
int(&c->c2=2Etls_multi->opt=2Eframe, D_MTU_INFO, "Control Channel MTU parms=
");
 
diff --git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec
index 10bfc3=
5=2E=2Ea8c88c9 100644
--- a/src/openvpn/misc=2Ec
+++ b/src/openvpn/misc=2Ec=

@@ -765,14 +765,15 @@
     {
         chomp(line);
         if (validate_p=
eer_info_line(line)
-            && (strncmp(line, "IV_", 3) =3D=3D 0 || st=
rncmp(line, "UV_", 3) =3D=3D 0))
+            && (strncmp(line, "IV_", 3) =
=3D=3D 0 || strncmp(line, "UV_", 3) =3D=3D 0
+                || strncmp(li=
ne, "ID", 2) =3D=3D 0))
         {
             msg(M_INFO, "peer info: %s"=
, line);
             env_set_add(es, line);
         }
         else
     =
    {
-            msg(M_WARN, "validation failed on peer_info line receive=
d from client");
+            msg(M_WARN, "validation failed on peer_info l=
ine received");
         }
     }
 }
diff --git a/src/openvpn/multi=2Ec b/s=
rc/openvpn/multi=2Ec
index a957fdf=2E=2Ee96d43c 100644
--- a/src/openvpn/mu=
lti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -430,7 +430,7 @@
         if (mi->co=
ntext=2Ec2=2Etls_multi && check_debug_level(D_DCO_DEBUG)
             && dc=
o_enabled(&mi->context=2Eoptions))
         {
-            buf_printf(&out,=
 " peer-id=3D%d", mi->context=2Ec2=2Etls_multi->peer_id);
+            buf_=
printf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=2Etls_multi->rx_peer_id);=

         }
         return BSTR(&out);
     }
@@ -598,9 +598,9 @@
        =
 }
 #endif
 
-        if (mi->context=2Ec2=2Etls_multi->peer_id !=3D MAX_PE=
ER_ID)
+        if (mi->context=2Ec2=2Etls_multi->rx_peer_id !=3D MAX_PEER_=
ID)
         {
-            m->instances[mi->context=2Ec2=2Etls_multi->peer=
_id] =3D NULL;
+            m->instances[mi->context=2Ec2=2Etls_multi->rx_p=
eer_id] =3D NULL;
 
             /* Adjust the max_peerid as this might hav=
e been the highest
              * peer id instance */
@@ -908,8 +908,7 @@
=
 #else
                         sep,
 #endif
-                        sep,
=
-                        mi->context=2Ec2=2Etls_multi ? mi->context=2Ec2=2E=
tls_multi->peer_id : UINT32_MAX,
+                        sep, mi->context=
=2Ec2=2Etls_multi ? mi->context=2Ec2=2Etls_multi->rx_peer_id : MAX_PEER_ID,=

                         sep, translate_cipher_name_to_openvpn(mi->context=
=2Eoptions=2Eciphername));
                 }
                 gc_free(&gc)=
;
@@ -1727,6 +1726,7 @@
         tls_multi->use_peer_id =3D true;
         =
o->use_peer_id =3D true;
     }
+
     else if (dco_enabled(o))
     {
    =
     msg(M_INFO, "Client does not support DATA_V2=2E Data channel offloadin=
g "
@@ -3121,12 +3121,12 @@
          * has, so we disallow it=2E This can =
happen if a DCO netlink notification
          * gets lost and we miss a fl=
oating step=2E
          */
-        if (m1->peer_id =3D=3D m2->peer_id)
+ =
       if (m1->rx_peer_id =3D=3D m2->rx_peer_id)
         {
             ms=
g(M_WARN,
                 "disallowing peer %" PRIu32 " (%s) from floating=
 to "
                 "its own address (%s)",
-                m1->peer_id=
, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
+                m1=
->rx_peer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
       =
          mroute_addr_print(&mi->real, &gc));
             goto done;
     =
    }
@@ -3139,9 +3139,10 @@
     }
 
     msg(D_MULTI_MEDIUM, "peer %" PRI=
u32 " (%s) floated from %s to %s",
-        mi->context=2Ec2=2Etls_multi->p=
eer_id, tls_common_name(mi->context=2Ec2=2Etls_multi, false),
-        mrou=
te_addr_print_ex(&mi->real, MAPF_SHOW_FAMILY, &gc),
-        mroute_addr_pr=
int_ex(&real, MAPF_SHOW_FAMILY, &gc));
+        mi->context=2Ec2=2Etls_mult=
i->rx_peer_id,
+        tls_common_name(mi->context=2Ec2=2Etls_multi, false=
),
+        mroute_addr_print(&mi->real, &gc),
+        print_link_socket_a=
ctual(&m->top=2Ec2=2Efrom, &gc));
 
     /* remove old address from hash ta=
ble before changing address */
     ASSERT(hash_remove(m->hash, &mi->real))=
;
@@ -4086,7 +4087,7 @@
     {
         if (!m->instances[i])
         {
- =
           mi->context=2Ec2=2Etls_multi->peer_id =3D i;
+            mi->co=
ntext=2Ec2=2Etls_multi->rx_peer_id =3D i;
             m->instances[i] =3D =
mi;
             break;
         }
@@ -4095,11 +4096,11 @@
     /* should n=
ot really end up here, since multi_create_instance returns null
      * if =
amount of clients exceeds max_clients and this method would then
      * al=
so not have been called */
-    ASSERT(mi->context=2Ec2=2Etls_multi->peer_i=
d < m->max_clients);
+    ASSERT(mi->context=2Ec2=2Etls_multi->rx_peer_id <=
 m->max_clients);
 
-    if (mi->context=2Ec2=2Etls_multi->peer_id > m->max=
_peerid)
+    if (mi->context=2Ec2=2Etls_multi->rx_peer_id > m->max_peerid)=

     {
-        m->max_peerid =3D mi->context=2Ec2=2Etls_multi->peer_id;
+=
        m->max_peerid =3D mi->context=2Ec2=2Etls_multi->rx_peer_id;
     }
=
 }
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 6=
2c0bbb=2E=2E157032d 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/=
options=2Ec
@@ -3876,6 +3876,7 @@
                      "incompatible with =
each other=2E");
     }
 
+
     if (dco_enabled(o))
     {
         /* che=
ck if any option should force disabling DCO */
diff --git a/src/openvpn/pus=
h=2Ec b/src/openvpn/push=2Ec
index 564ce86=2E=2Eddd1b7e 100644
--- a/src/op=
envpn/push=2Ec
+++ b/src/openvpn/push=2Ec
@@ -661,9 +661,10 @@
            =
             print_in_addr_t(c->c2=2Epush_ifconfig_remote_netmask, 0, gc));=

     }
 
-    if (tls_multi->use_peer_id)
+    if (!tls_multi->use_asymmet=
ric_peer_id)
     {
-        push_option_fmt(gc, push_list, M_USAGE, "peer-=
id %d", tls_multi->peer_id);
+        push_option_fmt(gc, push_list, M_USAG=
E, "peer-id %d",
+                        tls_multi->rx_peer_id);
     }
  =
   /*
      * If server uses --auth-gen-token and we have an auth token
dif=
f --git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec
index f57f5=
4d=2E=2Ec927f26 100644
--- a/src/openvpn/push_util=2Ec
+++ b/src/openvpn/pu=
sh_util=2Ec
@@ -188,7 +188,7 @@
         unsigned int permission_mask =3D p=
ull_permission_mask(c);
         if (process_push_update(c, &o, permission_=
mask, &option_types_found, &tmp_msg, true) =3D=3D PUSH_MSG_ERROR)
         =
{
-            msg(M_WARN, "Failed to process push update message sent to c=
lient ID: %u", c->c2=2Etls_multi->peer_id);
+            msg(M_WARN, "Faile=
d to process push update message sent to client ID: %u", c->c2=2Etls_multi-=
>rx_peer_id);
         }
         e =3D e->next;
     }
@@ -294,7 +294,7 @@=

 
         if (!support_push_update(mi))
         {
-            msg(M_CLI=
ENT, "PUSH_UPDATE: not sending message to unsupported peer with ID: %u", mi=
->context=2Ec2=2Etls_multi->peer_id);
+            msg(M_CLIENT, "PUSH_UPDA=
TE: not sending message to unsupported peer with ID: %u", mi->context=2Ec2=
=2Etls_multi->rx_peer_id);
             buffer_list_free(msgs);
           =
  gc_free(&gc);
             return 0;
@@ -329,7 +329,7 @@
         /* Type=
 is UPT_BROADCAST so we update every client */
         if (!send_single_pu=
sh_update(m, curr_mi, msgs))
         {
-            msg(M_CLIENT, "ERROR: =
Peer ID: %u has not been updated", curr_mi->context=2Ec2=2Etls_multi->peer_=
id);
+            msg(M_CLIENT, "ERROR: Peer ID: %u has not been updated", =
curr_mi->context=2Ec2=2Etls_multi->rx_peer_id);
             continue;
    =
     }
         count++;
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=
=2Ec
index 0998bd6=2E=2E044e852 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/=
openvpn/ssl=2Ec
@@ -1168,7 +1168,10 @@
     /* get command line derived opt=
ions */
     ret->opt =3D *tls_options;
     ret->dco_peer_id =3D -1;
-    =
ret->peer_id =3D MAX_PEER_ID;
+    ret->use_asymmetric_peer_id =3D false;
+=
    /* The rx_peer_id is also used to identify DCO clients */
+    ret->rx_=
peer_id =3D MAX_PEER_ID;
+    ret->tx_peer_id =3D MAX_PEER_ID;
 
     retur=
n ret;
 }
@@ -1181,6 +1184,24 @@
 
     tls_session_init(multi, &multi->ses=
sion[TM_ACTIVE]);
     tls_session_init(multi, &multi->session[TM_INITIAL])=
;
+
+    if (!multi->opt=2Edco_enabled)
+    {
+        /* Calculate the as=
ymmetric peer-id */
+        if (multi->rx_peer_id =3D=3D MAX_PEER_ID && mu=
lti->session[TM_INITIAL]=2Eopt->mode !=3D MODE_SERVER)
+        {
+        =
    uint8_t peerid[3];
+
+            if (rand_bytes(peerid, sizeof(peerid)=
) !=3D 1)
+            {
+                msg(M_FATAL, "rand_bytes() failed=
");
+            }
+
+            multi->rx_peer_id =3D ((uint32_t)peerid[0=
] << 16)
+                                | ((uint32_t)peerid[1] << 8)
+   =
                             | (uint32_t)peerid[2];
+        }
+    }
 }
 
=
 /*
@@ -1858,6 +1879,25 @@
     return str;
 }
 
+static bool
+push_peer_in=
fo_peerid(struct buffer *out, struct tls_multi *multi, struct tls_session *=
session)
+{
+    if (multi->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->=
dco_enabled)
+    {
+        /* No valid peer id or DCO is enabled=2E Canno=
t use this feature */
+        return true;
+    }
+
+    /* In server mode=
 we only add this when the client has announced its
+     * support for the=
 feature */
+    if (session->opt->mode !=3D MODE_SERVER || multi->use_asym=
metric_peer_id)
+    {
+        return buf_printf(out, "ID=3D%x\n", multi->=
rx_peer_id);
+    }
+
+    return true;
+}
+
 /**
  * Prepares the IV_ and =
UV_ variables that are part of the
  * exchange to signal the peer's capabi=
lities=2E The amount
@@ -1871,15 +1911,22 @@
  *
  * @param buf       the b=
uffer to write these variables to
  * @param session   the TLS session obje=
ct
+ * @param multi     the TLS multi object
  * @return          true if n=
o error was encountered
  */
 static bool
-push_peer_info(struct buffer *bu=
f, struct tls_session *session)
+push_peer_info(struct buffer *buf, struct =
tls_multi *multi, struct tls_session *session)
 {
     struct gc_arena gc =
=3D gc_new();
     bool ret =3D false;
     struct buffer out =3D alloc_buf=
_gc(512 * 3, &gc);
 
+    /* The asymmetric peer-id is always written when =
enabled */
+    if (!push_peer_info_peerid(&out, multi, session))
+    {
+ =
       goto error;
+    }
+
     if (session->opt->push_peer_info_detail > =
1)
     {
         /* push version */
@@ -2027,7 +2074,9 @@
     }
     els=
e
     {
-        if (!write_empty_string(buf)) /* no peer info */
+       =
 if (!(session->opt->mode =3D=3D MODE_SERVER && multi->use_asymmetric_peer_=
id
+                  ? write_string(buf, BSTR(&out), -1)
+                =
  : write_empty_string(buf)))
         {
             goto error;
         =
}
@@ -2156,7 +2205,7 @@
         }
     }
 
-    if (!push_peer_info(buf, s=
ession))
+    if (!push_peer_info(buf, multi, session))
     {
         got=
o error;
     }
@@ -2269,6 +2318,44 @@
     if (multi->peer_info)
     {
  =
       output_peer_info_env(session->opt->es, multi->peer_info);
+        i=
f (session->opt->mode =3D=3D MODE_SERVER)
+        {
+            if (!sess=
ion->opt->dco_enabled)
+            {
+                uint32_t peer_id =3D=
 extract_asymmetric_peer_id(multi->peer_info);
+                if (peer_id=
 !=3D MAX_PEER_ID)
+                {
+                    multi->tx_peer_i=
d =3D peer_id;
+                    multi->use_asymmetric_peer_id =3D true;=

+                    multi->use_peer_id =3D true;
+                }
+    =
            else
+                {
+                    /* Client has no a=
symmetric peer-id capability */
+                    multi->tx_peer_id =3D =
multi->rx_peer_id;
+                }
+            }
+            else
+   =
         {
+                /* With DCO we don't need the tx_peer_id atm */=

+                multi->tx_peer_id =3D multi->rx_peer_id;
+            }
+=
        }
+    }
+    else
+    {
+        free(multi->peer_info);
+       =
 multi->peer_info =3D read_string_alloc(buf);
+    }
+    if (session->opt-=
>mode =3D=3D MODE_POINT_TO_POINT && !session->opt->dco_enabled)
+    {
+   =
     uint32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_info);
+  =
      if (peer_id !=3D MAX_PEER_ID)
+        {
+            multi->tx_peer_=
id =3D peer_id;
+            multi->use_asymmetric_peer_id =3D true;
+     =
       multi->use_peer_id =3D true;
+        }
     }
 
     free(multi->re=
mote_ciphername);
@@ -4005,8 +4092,8 @@
     msg(D_TLS_DEBUG, __func__);
 
=
     ASSERT(ks);
-
-    peer =3D htonl(((P_DATA_V2 << P_OPCODE_SHIFT) | ks-=
>key_id) << 24 | (multi->peer_id & 0xFFFFFF));
+    peer =3D htonl(((P_DATA=
_V2 << P_OPCODE_SHIFT) | ks->key_id) << 24
+                 | (multi->tx_p=
eer_id & 0xFFFFFF));
     ASSERT(buf_write_prepend(buf, &peer, 4));
 }
 
di=
ff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2Eh
index 6f=
310a5=2E=2E9a36fcf 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/src/openvp=
n/ssl_common=2Eh
@@ -697,8 +697,10 @@
 #define AUTH_TOKEN_VALID_EMPTYUSER (=
1 << 2)
 
     /* For P_DATA_V2 */
-    uint32_t peer_id;
+    uint32_t rx_=
peer_id;
+    uint32_t tx_peer_id;
     bool use_peer_id;
+    bool use_asy=
mmetric_peer_id;
 
     char *remote_ciphername; /**< cipher specified in p=
eer's config file */
     bool remote_usescomp;    /**< remote announced co=
mp-lzo in OCC string */
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/=
ssl_ncp=2Ec
index 649665a=2E=2Ee860f6d 100644
--- a/src/openvpn/ssl_ncp=2Ec=

+++ b/src/openvpn/ssl_ncp=2Ec
@@ -406,6 +406,7 @@
 {
     /* will return 0=
 if peer_info is null */
     const unsigned int iv_proto_peer =3D extract_=
iv_proto(multi->peer_info);
+    const unsigned int tx_peer_id =3D extract_=
asymmetric_peer_id(multi->peer_info);
 
     /* The other peer does not sup=
port P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@@ -416,7 +41=
7,11 @@
     if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->u=
se_peer_id =3D true;
-        multi->peer_id =3D 0x76706e; /* 'v' 'p' 'n' *=
/
+        if (tx_peer_id =3D=3D MAX_PEER_ID)
+        {
+            multi=
->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+            multi->tx_peer_id=
 =3D 0x76706e; /* 'v' 'p' 'n' */
+        }
     }
 
     if (iv_proto_peer=
 & IV_PROTO_CC_EXIT_NOTIFY)
@@ -440,8 +445,16 @@
     {
         session->o=
pt->crypto_flags |=3D CO_USE_TLS_KEY_MATERIAL_EXPORT;
 
-        if (multi-=
>use_peer_id)
+        /* The asymmetric peer-id trumps on the EKM generate=
d ones */
+        if ((tx_peer_id !=3D MAX_PEER_ID) && (!multi->opt=2Edco_=
enabled))
         {
+            multi->tx_peer_id =3D tx_peer_id;
+      =
      multi->use_asymmetric_peer_id =3D true;
+        }
+        else
+   =
     {
+            multi->rx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
+    =
        multi->tx_peer_id =3D 0x76706e; /* 'v' 'p' 'n' */
             /* U=
sing a non hardcoded peer-id makes a tiny bit harder to
              * fin=
gerprint packets and also gives each connection a unique
              * pe=
er-id that can be useful for NAT tracking etc=2E */
@@ -458,7 +471,8 @@
   =
          }
             else
             {
-                multi->peer_i=
d =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+                mu=
lti->rx_peer_id =3D (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+    =
            multi->tx_peer_id =3D multi->rx_peer_id;
             }
       =
  }
     }
@@ -500,11 +514,13 @@
         common_cipher =3D BSTR(&out);
   =
  }
 
-    msg(D_TLS_DEBUG_LOW,
-        "P2P mode NCP negotiation result: =
"
-        "TLS_export=3D%d, DATA_v2=3D%d, peer-id %d, epoch=3D%d, cipher=
=3D%s",
-        (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIA=
L_EXPORT), multi->use_peer_id,
-        multi->peer_id, (bool)(session->opt=
->crypto_flags & CO_EPOCH_DATA_KEY_FORMAT),
+    msg(D_TLS_DEBUG_LOW, "P2P =
mode NCP negotiation result: "
+                         "TLS_export=3D%d, =
DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s",
+    =
    (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
+ =
       multi->use_peer_id,
+        multi->rx_peer_id,
+        multi->tx_p=
eer_id,
+        (bool)(session->opt->crypto_flags & CO_EPOCH_DATA_KEY_FORM=
AT),
         common_cipher);
 
     gc_free(&gc);
diff --git a/src/openvpn=
/ssl_util=2Ec b/src/openvpn/ssl_util=2Ec
index 71fbc9e=2E=2E6561c48 100644
=
--- a/src/openvpn/ssl_util=2Ec
+++ b/src/openvpn/ssl_util=2Ec
@@ -24,7 +24,=
7 @@
 #endif
 
 #include "syshead=2Eh"
-
+#include "openvpn=2Eh"
 #include =
"ssl_util=2Eh"
 
 char *
@@ -72,6 +72,24 @@
     return 0;
 }
 
+uint32_t
+=
extract_asymmetric_peer_id(const char *peer_info)
+{
+    const char *optst=
r =3D peer_info ? strstr(peer_info, "ID=3D") : NULL;
+    if (optstr)
+    =
{
+        uint32_t peer_id =3D 0;
+        int r =3D sscanf(optstr, "ID=3D=
%x", &peer_id);
+        {
+            if (r =3D=3D 1 && peer_id < MAX_PEE=
R_ID)
+            {
+                return peer_id;
+            }
+     =
   }
+    }
+    return MAX_PEER_ID;
+}
+
 const char *
 options_string_com=
pat_lzo(const char *options, struct gc_arena *gc)
 {
diff --git a/src/openv=
pn/ssl_util=2Eh b/src/openvpn/ssl_util=2Eh
index 2177d94=2E=2E1a69e6f 10064=
4
--- a/src/openvpn/ssl_util=2Eh
+++ b/src/openvpn/ssl_util=2Eh
@@ -53,6 +5=
3,15 @@
  */
 unsigned int extract_iv_proto(const char *peer_info);
 
+
+/*=
*
+ * Extracts the ID variable and returns its value or
+ * MAX_PEER_ID if =
it cannot be extracted=2E
+ *
+ * @param peer_info     peer info string to =
search for ID
+ */
+uint32_t extract_asymmetric_peer_id(const char *peer_in=
fo);
+
 /**
  * Takes a locally produced OCC string for TLS server mode and=
 modifies as
  * if the option comp-lzo was enabled=2E This is to send a cl=
ient in

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1089?=
usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchse=
t
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90=
b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet=
: 12
Gerrit-Owner: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: c=
ron2 <gert@greenie=2Emuc=2Ede>
Gerrit-Reviewer: flichtenheld <frank@lichten=
held=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attentio=
n: its_Giaan <gianmarco@mandelbit=2Ecom>
Gerrit-Attention: flichtenheld <fr=
ank@lichtenheld=2Ecom>

--TxeAtXoOIpQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, its_Giaan=2E </p>
<p>its_Giaan <strong>=
uploaded patch set #12</strong> to this change=2E</p><p><a href=3D"http://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1089?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">multipeer: introduce asymmetric peer-id<br><br>In order to achiev=
e a multipeer functionality, peers now<br>use separate IDs for sending (tx_=
peer_id) and receiving<br>(rx_peer_id)=2E<br><br>Each peer announces its ow=
n ID through pushing peer-info<br>using &#39;ID=3D7f1&#39; hex format so id=
entification can still<br>happen even if IP/port changes=2E<br><br>In P2P m=
ode, peer switch to using the announced IDs after<br>mutual exchange=2E<br>=
In P2MP mode, clients always announce their ID, and servers<br>can optional=
ly respond with their own to enable the same<br>behavior=2E<br><br>Change-I=
d: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9<br>Signed-off-by: Gianmarco De=
 Gregori &lt;gianmarco@mandelbit=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<=
br>M src/openvpn/init=2Ec<br>M src/openvpn/misc=2Ec<br>M src/openvpn/multi=
=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/push=2Ec<br>M src/openvp=
n/push_util=2Ec<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_common=2Eh<br=
>M src/openvpn/ssl_ncp=2Ec<br>M src/openvpn/ssl_util=2Ec<br>M src/openvpn/s=
sl_util=2Eh<br>12 files changed, 191 insertions(+), 47 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn ref=
s/changes/89/1089/12</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/dco=2Ec b/src/openvpn=
/dco=2Ec</span><br><span>index f5b7081=2E=2E901b9bd 100644</span><br><span>=
--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/openvpn/dco=2Ec</span><=
br><span>@@ -528,14 +528,15 @@</span><br><span>         c-&gt;c2=2Etls_mult=
i-&gt;dco_peer_id =3D -1;</span><br><span>     }</span><br><span> #endif</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_=
peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;peer_id, sock-&gt;sd, NULL,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
     proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL, NULL, NULL)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dc=
o_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;s=
d, NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
       NULL, NULL);</span><br><span>     if (ret &lt; 0)</span><br><span>  =
   {</span><br><span>         return ret;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2=
=2Etls_multi-&gt;dco_peer_id =3D multi-&gt;peer_id;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    c-&gt;c2=2Etls_multi-&gt;dco_peer_id =
=3D multi-&gt;rx_peer_id;</span><br><span> </span><br><span>     return 0;<=
/span><br><span> }</span><br><span>@@ -610,7 +611,7 @@</span><br><span> {</=
span><br><span>     struct context *c =3D &amp;mi-&gt;context;</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int peer_id =
=3D c-&gt;c2=2Etls_multi-&gt;peer_id;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int peer_id =3D c-&gt;c2=2Etls_multi-&gt;rx_peer_id;<=
/span><br><span>     struct sockaddr *remoteaddr, *localaddr =3D NULL;</spa=
n><br><span>     struct sockaddr_storage local =3D { 0 };</span><br><span> =
    const socket_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</sp=
an><br><span>@@ -689,8 +690,7 @@</span><br><span>     if (addrtype =3D=3D M=
R_ADDR_IPV6)</span><br><span>     {</span><br><span> #if defined(_WIN32)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_add_irou=
te_ipv6(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbit=
s,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
             c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv6(&amp;c-&gt;c1=
=2Etuntap-&gt;dco, addr-&gt;v6=2Eaddr, addr-&gt;netbits, c-&gt;c2=2Etls_mul=
ti-&gt;rx_peer_id);</span><br><span> #else</span><br><span>         const s=
truct in6_addr *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_ipv6_l=
ocal;</span><br><span>         if (addr-&gt;type &amp; MR_ONLINK_DCO_ADDR)<=
/span><br><span>@@ -706,8 +706,7 @@</span><br><span>     else if (addrtype =
=3D=3D MR_ADDR_IPV4)</span><br><span>     {</span><br><span> #if defined(_W=
IN32)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dco_win_=
add_iroute_ipv4(&amp;c-&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-&g=
t;netbits,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                     c-&gt;c2=2Etls_multi-&gt;peer_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        dco_win_add_iroute_ipv4(&amp;c-=
&gt;c1=2Etuntap-&gt;dco, addr-&gt;v4=2Eaddr, addr-&gt;netbits, c-&gt;c2=2Et=
ls_multi-&gt;rx_peer_id);</span><br><span> #else</span><br><span>         i=
n_addr_t dest =3D htonl(addr-&gt;v4=2Eaddr);</span><br><span>         const=
 in_addr_t *gateway =3D &amp;mi-&gt;context=2Ec2=2Epush_ifconfig_local;</sp=
an><br><span>diff --git a/src/openvpn/init=2Ec b/src/openvpn/init=2Ec</span=
><br><span>index caaa769=2E=2E468c260 100644</span><br><span>--- a/src/open=
vpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=2Ec</span><br><span>@@ =
-2209,7 +2209,7 @@</span><br><span> </span><br><span>     if (o-&gt;use_pee=
r_id)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        buf_printf(&amp;out, &quot;, peer-id: %d&quot;, o-&gt;peer_i=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_prin=
tf(&amp;out, &quot;, rx-peer-id: %u, tx-peer-id: %u&quot;, c-&gt;c2=2Etls_m=
ulti-&gt;rx_peer_id, c-&gt;c2=2Etls_multi-&gt;tx_peer_id);</span><br><span>=
     }</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span>@=
@ -2688,7 +2688,12 @@</span><br><span>     {</span><br><span>         msg(D=
_PUSH_DEBUG, &quot;OPTIONS IMPORT: peer-id set&quot;);</span><br><span>    =
     c-&gt;c2=2Etls_multi-&gt;use_peer_id =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2=2Etls_multi-&gt;peer_id =
=3D c-&gt;options=2Epeer_id;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&gt;options=2Epe=
er_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
c-&gt;c2=2Etls_multi-&gt;use_asymmetric_peer_id)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            c-&gt;c2=2Etls_multi-&gt;rx_peer_id =3D c-&g=
t;options=2Epeer_id;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            c-&gt;c2=2Etls_multi-&gt;tx_peer_id =3D c-&gt;options=2Epeer_i=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span>     }</span><br><span> </span><br><span>     /* process (potentia=
lly) pushed options */</span><br><span>@@ -3485,6 +3490,10 @@</span><br><sp=
an>     if (c-&gt;c2=2Etls_multi)</span><br><span>     {</span><br><span>  =
       tls_multi_init_finalize(c-&gt;c2=2Etls_multi, c-&gt;options=2Ece=2Et=
ls_mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(c-&gt;c2=2Etls_multi-&gt;rx_peer_id !=3D MAX_PEER_ID)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            c-&gt;options=2Euse_peer_id =3D true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span>         ASSERT(c-&gt;c2=2Etls_multi-&gt;opt=2Eframe=2Ebuf=2Epayload_=
size &lt;=3D c-&gt;c2=2Eframe=2Ebuf=2Epayload_size);</span><br><span>      =
   frame_print(&amp;c-&gt;c2=2Etls_multi-&gt;opt=2Eframe, D_MTU_INFO, &quot=
;Control Channel MTU parms&quot;);</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/misc=2Ec b/src/openvpn/misc=2Ec</span><br><span>index 10=
bfc35=2E=2Ea8c88c9 100644</span><br><span>--- a/src/openvpn/misc=2Ec</span>=
<br><span>+++ b/src/openvpn/misc=2Ec</span><br><span>@@ -765,14 +765,15 @@<=
/span><br><span>     {</span><br><span>         chomp(line);</span><br><spa=
n>         if (validate_peer_info_line(line)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            &amp;&amp; (strncmp(line, &quot;IV_&quot=
;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=3D 0))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (strncmp(=
line, &quot;IV_&quot;, 3) =3D=3D 0 || strncmp(line, &quot;UV_&quot;, 3) =3D=
=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  || strncmp(line, &quot;ID&quot;, 2) =3D=3D 0))</span><br><span>         {=
</span><br><span>             msg(M_INFO, &quot;peer info: %s&quot;, line);=
</span><br><span>             env_set_add(es, line);</span><br><span>      =
   }</span><br><span>         else</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;valid=
ation failed on peer_info line received from client&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &quot;valid=
ation failed on peer_info line received&quot;);</span><br><span>         }<=
/span><br><span>     }</span><br><span> }</span><br><span>diff --git a/src/=
openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index a957fdf=2E=
=2Ee96d43c 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><sp=
an>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -430,7 +430,7 @@</span><b=
r><span>         if (mi-&gt;context=2Ec2=2Etls_multi &amp;&amp; check_debug=
_level(D_DCO_DEBUG)</span><br><span>             &amp;&amp; dco_enabled(&am=
p;mi-&gt;context=2Eoptions))</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            buf_printf(&amp;out, &quot; p=
eer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;peer_id);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;ou=
t, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_pee=
r_id);</span><br><span>         }</span><br><span>         return BSTR(&amp=
;out);</span><br><span>     }</span><br><span>@@ -598,9 +598,9 @@</span><br=
><span>         }</span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (mi-&gt;context=2Ec2=2Etls=
_multi-&gt;peer_id !=3D MAX_PEER_ID)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id=
 !=3D MAX_PEER_ID)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            m-&gt;instances[mi-&gt;context=2Ec2=2Et=
ls_multi-&gt;peer_id] =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            m-&gt;instances[mi-&gt;context=2Ec2=2Etls_multi-&gt=
;rx_peer_id] =3D NULL;</span><br><span> </span><br><span>             /* Ad=
just the max_peerid as this might have been the highest</span><br><span>   =
           * peer id instance */</span><br><span>@@ -908,8 +908,7 @@</span>=
<br><span> #else</span><br><span>                         sep,</span><br><s=
pan> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              sep,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     mi-&gt;context=2Ec2=2Etls_multi ? mi-&gt;context=2Ec2=
=2Etls_multi-&gt;peer_id : UINT32_MAX,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        sep, mi-&gt;context=2Ec2=2Etls_m=
ulti ? mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id : MAX_PEER_ID,</span>=
<br><span>                         sep, translate_cipher_name_to_openvpn(mi=
-&gt;context=2Eoptions=2Eciphername));</span><br><span>                 }</=
span><br><span>                 gc_free(&amp;gc);</span><br><span>@@ -1727,=
6 +1726,7 @@</span><br><span>         tls_multi-&gt;use_peer_id =3D true;</=
span><br><span>         o-&gt;use_peer_id =3D true;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  else if (dco_enabled(o))</span><br><span>     {</span><br><span>         =
msg(M_INFO, &quot;Client does not support DATA_V2=2E Data channel offloadin=
g &quot;</span><br><span>@@ -3121,12 +3121,12 @@</span><br><span>          =
* has, so we disallow it=2E This can happen if a DCO netlink notification</=
span><br><span>          * gets lost and we miss a floating step=2E</span><=
br><span>          */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (m1-&gt;peer_id =3D=3D m2-&gt;peer_id)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (m1-&gt;rx_peer_id =3D=3D m2-&gt;r=
x_peer_id)</span><br><span>         {</span><br><span>             msg(M_WA=
RN,</span><br><span>                 &quot;disallowing peer %&quot; PRIu32 =
&quot; (%s) from floating to &quot;</span><br><span>                 &quot;=
its own address (%s)&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                m1-&gt;peer_id, tls_common_name(mi-&gt;context=2Ec2=
=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                m1-&gt;rx_peer_id, tls_common_name(mi-&gt;context=2Ec2=2E=
tls_multi, false),</span><br><span>                 mroute_addr_print(&amp;=
mi-&gt;real, &amp;gc));</span><br><span>             goto done;</span><br><=
span>         }</span><br><span>@@ -3139,9 +3139,10 @@</span><br><span>    =
 }</span><br><span> </span><br><span>     msg(D_MULTI_MEDIUM, &quot;peer %&=
quot; PRIu32 &quot; (%s) floated from %s to %s&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;context=2Ec2=2Etls_multi-&gt=
;peer_id, tls_common_name(mi-&gt;context=2Ec2=2Etls_multi, false),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        mroute_addr_print_ex(&=
amp;mi-&gt;real, MAPF_SHOW_FAMILY, &amp;gc),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        mroute_addr_print_ex(&amp;real, MAPF_SHOW_FA=
MILY, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tls_common_name(mi-&gt;context=2E=
c2=2Etls_multi, false),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        print_link_socket_actual(&amp=
;m-&gt;top=2Ec2=2Efrom, &amp;gc));</span><br><span> </span><br><span>     /=
* remove old address from hash table before changing address */</span><br><=
span>     ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real));</span><br><spa=
n>@@ -4086,7 +4087,7 @@</span><br><span>     {</span><br><span>         if =
(!m-&gt;instances[i])</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            mi-&gt;context=2Ec2=2Etls_multi-&gt;=
peer_id =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id =3D i;</span><br><spa=
n>             m-&gt;instances[i] =3D mi;</span><br><span>             brea=
k;</span><br><span>         }</span><br><span>@@ -4095,11 +4096,11 @@</span=
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
n> </span><br><span>diff --git a/src/openvpn/options=2Ec b/src/openvpn/opti=
ons=2Ec</span><br><span>index 62c0bbb=2E=2E157032d 100644</span><br><span>-=
-- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/options=2Ec<=
/span><br><span>@@ -3876,6 +3876,7 @@</span><br><span>                     =
 &quot;incompatible with each other=2E&quot;);</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     if (dco_enabled(o))</span><br><span>     {</span><br><span> =
        /* check if any option should force disabling DCO */</span><br><spa=
n>diff --git a/src/openvpn/push=2Ec b/src/openvpn/push=2Ec</span><br><span>=
index 564ce86=2E=2Eddd1b7e 100644</span><br><span>--- a/src/openvpn/push=2E=
c</span><br><span>+++ b/src/openvpn/push=2Ec</span><br><span>@@ -661,9 +661=
,10 @@</span><br><span>                         print_in_addr_t(c-&gt;c2=2E=
push_ifconfig_remote_netmask, 0, gc));</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tls_multi=
-&gt;use_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!tls_multi-&gt;use_asymmetric_peer_id)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        push_option_fmt(gc, p=
ush_list, M_USAGE, &quot;peer-id %d&quot;, tls_multi-&gt;peer_id);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        push_option_fmt(gc, =
push_list, M_USAGE, &quot;peer-id %d&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                        tls_multi-&gt;rx_peer_id);<=
/span><br><span>     }</span><br><span>     /*</span><br><span>      * If s=
erver uses --auth-gen-token and we have an auth token</span><br><span>diff =
--git a/src/openvpn/push_util=2Ec b/src/openvpn/push_util=2Ec</span><br><sp=
an>index f57f54d=2E=2Ec927f26 100644</span><br><span>--- a/src/openvpn/push=
_util=2Ec</span><br><span>+++ b/src/openvpn/push_util=2Ec</span><br><span>@=
@ -188,7 +188,7 @@</span><br><span>         unsigned int permission_mask =
=3D pull_permission_mask(c);</span><br><span>         if (process_push_upda=
te(c, &amp;o, permission_mask, &amp;option_types_found, &amp;tmp_msg, true)=
 =3D=3D PUSH_MSG_ERROR)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;Failed to proces=
s push update message sent to client ID: %u&quot;, c-&gt;c2=2Etls_multi-&gt=
;peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   msg(M_WARN, &quot;Failed to process push update message sent to client I=
D: %u&quot;, c-&gt;c2=2Etls_multi-&gt;rx_peer_id);</span><br><span>        =
 }</span><br><span>         e =3D e-&gt;next;</span><br><span>     }</span>=
<br><span>@@ -294,7 +294,7 @@</span><br><span> </span><br><span>         if=
 (!support_push_update(mi))</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;PUSH_UPDAT=
E: not sending message to unsupported peer with ID: %u&quot;, mi-&gt;contex=
t=2Ec2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            msg(M_CLIENT, &quot;PUSH_UPDATE: not sending messa=
ge to unsupported peer with ID: %u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&=
gt;rx_peer_id);</span><br><span>             buffer_list_free(msgs);</span>=
<br><span>             gc_free(&amp;gc);</span><br><span>             retur=
n 0;</span><br><span>@@ -329,7 +329,7 @@</span><br><span>         /* Type i=
s UPT_BROADCAST so we update every client */</span><br><span>         if (!=
send_single_push_update(m, curr_mi, msgs))</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &=
quot;ERROR: Peer ID: %u has not been updated&quot;, curr_mi-&gt;context=2Ec=
2=2Etls_multi-&gt;peer_id);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_CLIENT, &quot;ERROR: Peer ID: %u has not been upd=
ated&quot;, curr_mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br=
><span>             continue;</span><br><span>         }</span><br><span>  =
       count++;</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/open=
vpn/ssl=2Ec</span><br><span>index 0998bd6=2E=2E044e852 100644</span><br><sp=
an>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</spa=
n><br><span>@@ -1168,7 +1168,10 @@</span><br><span>     /* get command line=
 derived options */</span><br><span>     ret-&gt;opt =3D *tls_options;</spa=
n><br><span>     ret-&gt;dco_peer_id =3D -1;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    ret-&gt;peer_id =3D MAX_PEER_ID;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;use_asymmetric_peer_id =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Th=
e rx_peer_id is also used to identify DCO clients */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;rx_peer_id =3D MAX_PEER_ID;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;tx_peer_i=
d =3D MAX_PEER_ID;</span><br><span> </span><br><span>     return ret;</span=
><br><span> }</span><br><span>@@ -1181,6 +1184,24 @@</span><br><span> </spa=
n><br><span>     tls_session_init(multi, &amp;multi-&gt;session[TM_ACTIVE])=
;</span><br><span>     tls_session_init(multi, &amp;multi-&gt;session[TM_IN=
ITIAL]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;opt=2Edco_e=
nabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Calculate the a=
symmetric peer-id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; multi-&gt;s=
ession[TM_INITIAL]=2Eopt-&gt;mode !=3D MODE_SERVER)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            uint8_t peerid[3];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            if (rand_bytes(peerid, sizeof(peerid)) !=3D 1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_FATA=
L, &quot;rand_bytes() failed&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    multi-&gt;rx_peer_id =3D ((uint32_t)peerid[0] &lt;&lt; 16)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
| ((uint32_t)peerid[1] &lt;&lt; 8)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                | (uint32_t)peerid[2];</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br>=
<span> </span><br><span> /*</span><br><span>@@ -1858,6 +1879,25 @@</span><b=
r><span>     return str;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+push_peer_info_peerid(struct buffer *out,=
 struct tls_multi *multi, struct tls_session *session)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session=
-&gt;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
/* No valid peer id or DCO is enabled=2E Cannot use this feature */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* In server mode we only add this when the client has =
announced its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 support for the feature */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (session-&gt;opt-&gt;mode !=3D MODE_SERVER || multi-&gt;use_=
asymmetric_peer_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 buf_printf(out, &quot;ID=3D%x\n&quot;, multi-&gt;rx_peer_id);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /**</span><br><span>  * Prepares the IV_ and UV_ variables that are =
part of the</span><br><span>  * exchange to signal the peer&#39;s capabilit=
ies=2E The amount</span><br><span>@@ -1871,15 +1911,22 @@</span><br><span> =
 *</span><br><span>  * @param buf       the buffer to write these variables=
 to</span><br><span>  * @param session   the TLS session object</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi     the TLS mul=
ti object</span><br><span>  * @return          true if no error was encount=
ered</span><br><span>  */</span><br><span> static bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-push_peer_info(struct buffer *buf, struct =
tls_session *session)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+push_peer_info(struct buffer *buf, struct tls_multi *multi, struct tls_se=
ssion *session)</span><br><span> {</span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     bool ret =3D false;</span><br><span>    =
 struct buffer out =3D alloc_buf_gc(512 * 3, &amp;gc);</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The asymmetric =
peer-id is always written when enabled */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!push_peer_info_peerid(&amp;out, multi, sessi=
on))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto error;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
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
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_=
Giaan &lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</b=
ody></html>
--TxeAtXoOIpQ=--


--===============7906176586709037092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7906176586709037092==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7906176586709037092==--

