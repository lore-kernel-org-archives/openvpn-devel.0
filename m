Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652E606A319
	for <openvpn-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=OZ3TtXcn;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fNavljQg;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fqkz0uwa;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=FauBRXKx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kYfHvIimj51D0XXX0XvF7QMyicBLfNqnk870ZKuv8xk=; b=OZ3TtXcnBvMLfzyxR3F9qM9uTk
	nTorkCrtVnrgJXmJA80HDlELCAf73XYOn+5AGb9BVSoUPZAdTQAvlPobvAlTfQknOhADHZhN9HfnB
	FTQ7KW74rSScLB4qqoksj4xOwGXaktkg74/VHkJkMo65HUwAv4tmPaKYKyy1EcYNLUgs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xJ5yC-0001R2-2g;
	Tue, 20 Oct 2026 09:17:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xJ5yB-0001Qw-JX
 for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:17:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=YDfprdtXsklci7YazSp/K0MuKeRsDM3l8dj8wE9HvUs=; b=fNavljQgAG1nhHOUvEv0571yOM
 Uj8PhMlMkh7ytUgFwr3sdFNKhjpRS1EEiUIDceCFVPhao4J6Oxg5bIuY+fZ7PSlhP8++8uoD3CM9N
 OIm81wphf9XuuHVK8E+biIvpj+ql/e72rdlz8+64Lp+yBSH/WRtgsZxuo4Tf+5bSG2qE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YDfprdtXsklci7YazSp/K0MuKeRsDM3l8dj8wE9HvUs=; b=f
 qkz0uwaNVu4lSFTQCwcZJdtgq6r1ja7X5U/z1Jt0T1XXsIKWi575wn/rjBZiXrLDh+rLZMQs55ey+
 bTi1j527TuiGKltVhzptbqtnQlFlRJMc1CsAi/LrUhPPJ+8Q/AoPM0SWuzXKinn86L5SglrzDC+iP
 DJmcfvx3w+7reEVc=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xJ5y3-0004BX-OZ for openvpn-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:17:19 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1986898f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 20 Oct 2026 02:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1792487825; x=1793092625; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=YDfprdtXsklci7YazSp/K0MuKeRsDM3l8dj8wE9HvUs=;
 b=FauBRXKxMzXjlFzFpZyLzPOUUoqrAs5ggrJP+3he4Ob39PrW3wcS/cv5QsXh0VjG0m
 tGFbHgNpGW48NKXsgW7df02QhMbAgdNANjfbwWTGm7yGrjNIrK4UvAIxuS2EAmVY1RII
 PE+/GFVAPaSiv30oNRZ+qoUA3qYkRrQ0CNK3BTNZ/wr2flJcwIudwI+AO8rno854V1qr
 4BcjAr90GOC9yO9A/FBNoCyGWPXIj65pWe1MpSaDCk4F6uIc119dqz+kjyp8t0LQKtA9
 FknvqWkWdfkJt4tSnWmbV4vDc7JDAD3/buEdK+k+7gMusGn+65CjdS3EaISREqAe9I6W
 FDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792487825; x=1793092625;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YDfprdtXsklci7YazSp/K0MuKeRsDM3l8dj8wE9HvUs=;
 b=aZXpnn/MKRgKHcyfLl2kGP0dGn88OwuE0ebnsyUqYi/uSkc2REnXWeCNYWf4WgZ3zQ
 uSGV2sx2uNiHArPy5N5XMk+vZwYhVgdP/+bNoaT8SzqQDzkHOcHTJzR7rWZ3+FDfR2x0
 KzsZs7qY0m64NjyGDYcAF47At1IbBp1Wal1zTjNQmKYSuTbWO84TOI39NOIbevWMoBeZ
 1D2ZJygI7FT3r4kosladR/F88yPWh6LdG4kCdcWpnLvBdflX6Dv0VgoRBBGEEonMMjtj
 aV/o3zzG9vADr1F/uwcEGscQWRMBOh6MkjW+kmPq/Y3UP7IpMSsevFdaveT5/2QMXXYJ
 qHVw==
X-Gm-Message-State: AFq9FYLoop7LdiZr5fQhH558hs5jQgawzQp2GKnZYqZF9uaOrM4jy4Nt
 1tskxIE+gKn/1hhlFz0YCLOnM9LBNvx6Jj2o04wqG6vNf+ADEN6B88/sTF+84oZkfe5csGfKvwT
 ynyjl/MutYTPa4EjbpBphwZW5GuvdLAFrUQXykierFiUhgwsjdOXPq4coubjTpC5BYJiy
X-Gm-Gg: AYBFou3Vz5snezwv6VO0QlYp09Q5CLQMB/CVTFTcF5T5sj4tZ/64spaeJvUa1NdsRtR
 808RWTfHZ5wrw2d793YIY0eSoxWPx4lTf5KvNO7rKXkipp8YYnZrnFsHR8cUsTC9jPaS7VsSHxS
 zt4o7+5YGxrFNxp2V5ySVk/hC3UZMOoYDhSqXwD2Hc9MvXiVm7XC+jhk9K+U8/cxtIvREJVTGKH
 dBa1fo35zQgQFsLNg88LA3HZFafThwSNi7Byag6WK4xut0yCe1Yy2Wo7kciw5r5UVXOnoU4LvgV
 keOxvdhg1XySzrJnLGGhvHc7AOR4LjMXqJFupkXcUnIBSHz7YYBsAnIVbgkx0tuRgE3EOd+ayU6
 HOFtBzZg8yeIgVCsGeZpsxLAnB8nbWC1ACy88m7v42D43N4Cr8L0Nrc9ULShVFSdkD/UKQTlF8v
 +zwFLhYTlbuX7Fqfh1twfLIa1vGIAJ7RKMl/Eu+lMUXsmOuL43QaWhw3K+tj2SqlVZBhK8d/jun
 kp+6n91d7SSve/fJ1PishTj4I2Z78s+1RaV/qDUVdeNeZCuSZLm8zZ2HPXmS+gsYdDaa1oRJcq5
 uJcD9i0ZGEpefuNJJRFbt9vO+mPG3Dt1EcxOQNco5iUe9NJoVUZRiPnesoun
X-Received: by 2002:a05:6000:46cd:b0:48d:f014:63ee with SMTP id
 ffacd0b85a97d-48e07bbc7d5mr13631173f8f.20.1792487824781; 
 Tue, 20 Oct 2026 02:17:04 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d8214e1sm4791989f8f.37.2026.10.20.02.17.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 02:17:04 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 20 Oct 2026 09:16:58 +0000
To: Ralf Lici <ralf@mandelbit.com>,
	Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: Ic5c421ec2e9627340924a05509bb8aff0bbf17da
X-Gerrit-Change-Number: 1983
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1983?usp=email>
X-Gerrit-Commit: 01ec466253cf9f79303be3824f43018f0b3342ac
In-Reply-To: <gerrit.1791286452000.Ic5c421ec2e9627340924a05509bb8aff0bbf17da@gerrit.openvpn.net>
References: <gerrit.1791286452000.Ic5c421ec2e9627340924a05509bb8aff0bbf17da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkljNWM0MjFlYzJlOTYyNzM0MDkyNGEwNTUwOWJiOGFmZjBiYmYxN2RhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <cd6c428abcef50b0f3f05c4a05b8e55169b80369-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xJ5y3-0004BX-OZ
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 asymmetric peer IDs when supported
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
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============7997981853302567466=="
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	MXG_THREAD_INDEX_BAD,PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,
	T_KAM_HTML_FONT_INVALID,WEIRD_PORT autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7997981853302567466==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hjKyCvOSGUQ="; charset=UTF-8

--hjKyCvOSGUQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe, =


I'd like you to reexamine a change=2E Please visit

    https://gerrit=2E=
openvpn=2Enet/c/openvpn/+/1983?usp=3Demail

to look at the new patch set (#=
2)=2E


Change subject: dco_linux: enable asymmetric peer IDs when supporte=
d
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux:=
 enable asymmetric peer IDs when supported

When notifying ovpn about a new=
 peer, also send the TX peer ID so the
module can forward packets with the =
correct peer ID value=2E This
attribute is optional: if tx_peer_id is missi=
ng, the module falls back
to the non-multipeer configuration, where tx_peer=
_id equals rx_peer_id=2E

The attribute is sent only to a kernel that knows=
 it, since older ones
reject OVPN_CMD_PEER_NEW with EINVAL on an attribute =
they cannot parse=2E
Define the first DCO capability, DCO_CAP_ASYM_PEER_ID,=
 as a row in the
requirement table: the doit policy of OVPN_CMD_PEER_NEW mu=
st expose
OVPN_A_PEER_TX_ID as a u32 inside OVPN_A_PEER=2E

The bit is then=
 consumed=2E It travels in tls_options, so a peer announces
its own ID only=
 when it can use asymmetric peer-ids, and a server
replies with its own onl=
y when the client announced one and the local
kernel can do it too=2E A pee=
r that announces nothing leaves the other
side on symmetric peer-ids, so th=
ere is nothing to exchange over the
wire=2E The local ID is generated under=
 the same bit, which also lifts the
blanket skip tls_multi_init_finalize() =
applied whenever DCO was enabled=2E

Change-Id: Ic5c421ec2e9627340924a05509=
bb8aff0bbf17da
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
Signed-off-b=
y: Gianmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/dco=
=2Ec
M src/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_=
internal=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M src/op=
envpn/init=2Ec
M src/openvpn/ovpn_dco_linux=2Eh
M src/openvpn/ssl=2Ec
M src=
/openvpn/ssl_common=2Eh
M src/openvpn/ssl_ncp=2Ec
11 files changed, 118 ins=
ertions(+), 49 deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/83/1983/2

diff --git a/src/openvpn/dco=2Ec b/src/ope=
nvpn/dco=2Ec
index 0681c81=2E=2E50691fb 100644
--- a/src/openvpn/dco=2Ec
++=
+ b/src/openvpn/dco=2Ec
@@ -57,8 +57,10 @@
 
 {
     bool epoch =3D ks->cry=
pto_options=2Eflags & CO_EPOCH_DATA_KEY_FORMAT;
-    msg(D_DCO_DEBUG, "%s: =
rx_peer_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys installed",
-     =
   __func__, multi->dco_rx_peer_id, ks->key_id, epoch, multi->dco_keys_inst=
alled);
+    msg(D_DCO_DEBUG,
+        "%s: rx_peer_id=3D%d tx_peer_id=3D%u=
 keyid=3D%d epoch=3D%d, currently %d keys installed",
+        __func__, mu=
lti->dco_rx_peer_id, multi->tx_peer_id, ks->key_id, epoch,
+        multi->=
dco_keys_installed);
 
     /* Install a key in the PRIMARY slot only when =
no other key exist=2E
      * From that moment on, any new key will be inst=
alled in the SECONDARY
@@ -510,9 +512,11 @@
 }
 
 bool
-dco_check_pull_opti=
ons(msglvl_t msglevel, const struct options *o)
+dco_check_pull_options(msg=
lvl_t msglevel, const struct tls_multi *multi)
 {
-    if (!o->use_peer_id)=

+    /* asymmetric peer-ids are negotiated, not pushed, so options=2Euse_p=
eer_id
+     * is not yet in sync when this runs */
+    if (!multi->use_pe=
er_id)
     {
         msg(msglevel, "OPTIONS IMPORT: Server did not reques=
t DATA_V2 packet "
                       "format required for data channel=
 offload");
@@ -544,8 +548,8 @@
         c->c2=2Etls_multi->dco_rx_peer_id =
=3D -1;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, =
multi->rx_peer_id, sock->sd, NULL,
-                           proto_is_dgr=
am(sock->info=2Eproto) ? remoteaddr : NULL,
+    int ret =3D dco_new_peer(&=
c->c1=2Etuntap->dco, multi->rx_peer_id, multi->tx_peer_id,
+               =
            sock->sd, NULL, proto_is_dgram(sock->info=2Eproto) ? remoteaddr=
 : NULL,
                            NULL, NULL);
     if (ret < 0)
     {
=
@@ -628,6 +632,7 @@
     const struct context *c =3D &mi->context;
 
     u=
int32_t rx_peer_id =3D c->c2=2Etls_multi->rx_peer_id;
+    uint32_t tx_peer=
_id =3D c->c2=2Etls_multi->tx_peer_id;
     struct sockaddr *remoteaddr, *l=
ocaladdr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     const=
 socket_descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ -665,7 +670,7 @=
@
     }
 
     int ret =3D
-        dco_new_peer(&c->c1=2Etuntap->dco, rx_=
peer_id, sd, localaddr, remoteaddr, vpn_addr4, vpn_addr6);
+        dco_new=
_peer(&c->c1=2Etuntap->dco, rx_peer_id, tx_peer_id, sd, localaddr, remotead=
dr, vpn_addr4, vpn_addr6);
     if (ret < 0)
     {
         return ret;
di=
ff --git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index e9a0348=2E=2Ed20=
acc3 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -46,6 +4=
6,9 @@
 #define DCO_IROUTE_METRIC  100
 #define DCO_DEFAULT_METRIC 200
 
+/=
** Local DCO capability bits, derived from kernel introspection */
+#define=
 DCO_CAP_ASYM_PEER_ID (1u << 0) /**< kernel supports OVPN_A_PEER_TX_ID */
+=

 #if defined(ENABLE_DCO)
 
 /**
@@ -95,10 +98,10 @@
  * for the first conf=
licting option found and return false=2E
  *
  * @param msglevel  the msg l=
evel to use to print the warnings
- * @param o         the options struct t=
hat hold the options
+ * @param multi     the TLS state holding the negotia=
ted parameters
  * @return          true if no conflict was detected, false=
 otherwise
  */
-bool dco_check_pull_options(msglvl_t msglevel, const struc=
t options *o);
+bool dco_check_pull_options(msglvl_t msglevel, const struct=
 tls_multi *multi);
 
 /**
  * Initialize the DCO context
@@ -265,6 +268,7 =
@@
  *          of them and when it could not be asked
  */
 unsigned int d=
co_probe_capabilities(void);
+
 #else  /* if defined(ENABLE_DCO) */
 
 type=
def void *dco_context_t;
@@ -294,7 +298,7 @@
 }
 
 static inline bool
-dco_=
check_pull_options(msglvl_t msglevel, const struct options *o)
+dco_check_p=
ull_options(msglvl_t msglevel, const struct tls_multi *multi)
 {
     retur=
n false;
 }
@@ -405,5 +409,6 @@
 {
     return 0;
 }
+
 #endif /* defined(E=
NABLE_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/dco_freeb=
sd=2Ec b/src/openvpn/dco_freebsd=2Ec
index 7130398=2E=2Ebe7608c 100644
--- =
a/src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -133,9 +=
133,9 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned int rx_peer_i=
d, int sd, struct sockaddr *localaddr,
-             struct sockaddr *remot=
eaddr, const struct in_addr *vpn_ipv4,
-             const struct in6_addr =
*vpn_ipv6)
+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, unsig=
ned int tx_peer_id, int sd,
+             struct sockaddr *localaddr, struc=
t sockaddr *remoteaddr,
+             const struct in_addr *vpn_ipv4, const=
 struct in6_addr *vpn_ipv6)
 {
     struct ifdrv drv;
     nvlist_t *nvl, *=
local_nvl, *remote_nvl;
@@ -143,7 +143,8 @@
 
     nvl =3D nvlist_create(0)=
;
 
-    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, fd %d", __func__, rx_peer_id,=
 sd);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, tx-peer-id %u, fd %d",
+   =
     __func__, rx_peer_id, tx_peer_id, sd);
 
     if (localaddr)
     {
di=
ff --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh
inde=
x a9203163=2E=2Eb4821d3 100644
--- a/src/openvpn/dco_internal=2Eh
+++ b/src=
/openvpn/dco_internal=2Eh
@@ -59,8 +59,8 @@
  * They are implemented by dco=
_linux=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned int rx_pee=
r_id, socket_descriptor_t sd,
-                 struct sockaddr *localaddr,=
 struct sockaddr *remoteaddr,
+int dco_new_peer(dco_context_t *dco, unsigne=
d int rx_peer_id, unsigned int tx_peer_id,
+                 socket_descrip=
tor_t sd, struct sockaddr *localaddr, struct sockaddr *remoteaddr,
        =
          const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);=

 
 int dco_del_peer(dco_context_t *dco, unsigned int rx_peer_id);
diff --g=
it a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 1235207=2E=
=2E265d74b 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_lin=
ux=2Ec
@@ -120,6 +120,10 @@
     int expected_type;
 };
 
+static const str=
uct dco_capability_req dco_capability_reqs[] =3D {
+    { DCO_CAP_ASYM_PEER=
_ID, OVPN_CMD_PEER_NEW, OVPN_A_PEER, OVPN_A_PEER_TX_ID, NL_ATTR_TYPE_U32 },=

+};
+
 /** the outcome of resolving one capability requirement */
 enum ov=
pn_cap_status
 {
@@ -141,7 +145,8 @@
 };
 
 /* What the local kernel suppor=
ts=2E It cannot change while we run, so the first
- * caller resolves it an=
d the rest just read it=2E */
+ * caller resolves it and the rest just read=
 it=2E That caller is
+ * do_init_crypto_tls(), which runs before any peer =
is added=2E */
 static unsigned int dco_caps =3D 0;
 static bool dco_caps_r=
esolved =3D false;
 
@@ -390,14 +395,30 @@
         return dco_caps;
     }=

 
-    /* no capability is defined yet: resolve one whose answer we alread=
y know */
-    static const struct dco_capability_req self_test =3D { 0, OV=
PN_CMD_PEER_NEW, OVPN_A_PEER,
-                                            =
             OVPN_A_PEER_ID, NL_ATTR_TYPE_U32 };
-    int err =3D 0;
-    e=
num ovpn_cap_status status =3D ovpn_cap_probe_one(&self_test, &err);
+    f=
or (size_t i =3D 0; i < SIZE(dco_capability_reqs); i++)
+    {
+        con=
st struct dco_capability_req *req =3D &dco_capability_reqs[i];
+        int=
 err =3D 0;
 
-    msg(D_DCO_DEBUG, "%s: policy introspection self-test: %s=
 (status %d, err %d)", __func__,
-        status =3D=3D OVPN_CAP_SUPPORTED =
? "ok" : "unexpected", (int)status, err);
+        switch (ovpn_cap_probe_o=
ne(req, &err))
+        {
+            case OVPN_CAP_SUPPORTED:
+          =
      dco_caps |=3D req->cap;
+                break;
+
+            case O=
VPN_CAP_UNSUPPORTED:
+                msg(D_DCO_DEBUG, "%s: kernel does not=
 support DCO capability 0x%x", __func__,
+                    req->cap);
+ =
               break;
+
+            case OVPN_CAP_UNKNOWN:
+              =
  msg(M_WARN,
+                    "Note: cannot determine DCO capability 0=
x%x from the kernel (%s), "
+                    "assuming it is unsupporte=
d",
+                    req->cap, err ? nl_geterror(err) : "incomplete pol=
icy dump");
+                break;
+        }
+    }
 
     dco_caps_resol=
ved =3D true;
     msg(D_DCO_DEBUG, "%s: DCO local capabilities: 0x%x", __f=
unc__, dco_caps);
@@ -523,9 +544,9 @@
 }
 
 int
-dco_new_peer(dco_context_t=
 *dco, unsigned int rx_peer_id, int sd, struct sockaddr *localaddr,
-      =
       struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,
-      =
       const struct in6_addr *vpn_ipv6)
+dco_new_peer(dco_context_t *dco, u=
nsigned int rx_peer_id, unsigned int tx_peer_id, int sd,
+             stru=
ct sockaddr *localaddr, struct sockaddr *remoteaddr,
+             const st=
ruct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
     struct gc_=
arena gc =3D gc_new();
     const char *remotestr =3D "[undefined]";
@@ -53=
3,13 +554,21 @@
     {
         remotestr =3D print_sockaddr(remoteaddr, &g=
c);
     }
-    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, fd %d, remote addr: %s=
", __func__, rx_peer_id, sd, remotestr);
+    msg(D_DCO_DEBUG, "%s: rx-peer=
-id %u, tx-peer-id %u, fd %d, remote addr: %s",
+        __func__, rx_peer_=
id, tx_peer_id, sd, remotestr);
 
     struct nl_msg *nl_msg =3D ovpn_dco_n=
lmsg_create(dco, OVPN_CMD_PEER_NEW);
     struct nlattr *attr =3D nla_nest_=
start(nl_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
 
     NLA_PUT_U32(=
nl_msg, OVPN_A_PEER_ID, rx_peer_id);
+    /* old kernels reject the whole c=
ommand if they see an attribute they do not
+     * know=2E This is the sam=
e answer the TLS layer used to decide whether to
+     * negotiate an asymm=
etric ID, so the two cannot disagree */
+    if (dco_caps & DCO_CAP_ASYM_PE=
ER_ID)
+    {
+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_TX_ID, tx_peer_id);
=
+    }
     NLA_PUT_U32(nl_msg, OVPN_A_PEER_SOCKET, sd);
 
     /* Set the =
remote endpoint if defined (for UDP) */
@@ -719,12 +748,6 @@
 {
     dco->o=
vpn_dco_id =3D resolve_ovpn_netlink_id(M_FATAL);
 
-    /* nothing consumes=
 the bitmap yet; resolve it here to exercise the path */
-    if (check_deb=
ug_level(D_DCO_DEBUG))
-    {
-        dco_probe_capabilities();
-    }
-
 =
    dco->nl_sock =3D nl_socket_alloc();
 
     if (!dco->nl_sock)
diff --gi=
t a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index fbe1624=2E=2E27=
f5b92 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@=
 -406,11 +406,12 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned in=
t rx_peer_id, socket_descriptor_t sd,
-             struct sockaddr *locala=
ddr, struct sockaddr *remoteaddr,
+dco_new_peer(dco_context_t *dco, unsigne=
d int rx_peer_id, unsigned int tx_peer_id,
+             socket_descriptor_=
t sd, struct sockaddr *localaddr, struct sockaddr *remoteaddr,
            =
  const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
-    =
msg(D_DCO_DEBUG, "%s: rx-peer-id %u, fd " SOCKET_PRINTF, __func__, rx_peer_=
id, sd);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, tx-peer-id %u, fd " SOCK=
ET_PRINTF,
+        __func__, rx_peer_id, tx_peer_id, sd);
 
     if (dco->=
ifmode =3D=3D DCO_MODE_P2P)
     {
diff --git a/src/openvpn/init=2Ec b/src/=
openvpn/init=2Ec
index ddcfaf4=2E=2Ec8b6bf0 100644
--- a/src/openvpn/init=
=2Ec
+++ b/src/openvpn/init=2Ec
@@ -2677,7 +2677,7 @@
         }
 
        =
 /* Check if pushed options are compatible with DCO, if enabled */
-       =
 if (dco_enabled(&c->options) && !dco_check_pull_options(D_PUSH_ERRORS, &c-=
>options))
+        if (dco_enabled(&c->options) && !dco_check_pull_options=
(D_PUSH_ERRORS, c->c2=2Etls_multi))
         {
             msg(D_PUSH_ERRO=
RS, "OPTIONS ERROR: pushed options are incompatible "
                     =
           "with data channel offload=2E Use --disable-dco to connect to "
=
@@ -3447,6 +3447,10 @@
 
     /* let the TLS engine know if keys have to be=
 installed in DCO or not */
     to=2Edco_enabled =3D dco_enabled(options);=

+    if (to=2Edco_enabled)
+    {
+        to=2Edco_capabilities =3D dco_p=
robe_capabilities();
+    }
 
     /*
      * Initialize OpenVPN's master T=
LS-mode object=2E
diff --git a/src/openvpn/ovpn_dco_linux=2Eh b/src/openvpn=
/ovpn_dco_linux=2Eh
index b3c9ff0=2E=2E28cf97a 100644
--- a/src/openvpn/ovp=
n_dco_linux=2Eh
+++ b/src/openvpn/ovpn_dco_linux=2Eh
@@ -54,6 +54,7 @@
 	OV=
PN_A_PEER_LINK_TX_BYTES,
 	OVPN_A_PEER_LINK_RX_PACKETS,
 	OVPN_A_PEER_LINK_=
TX_PACKETS,
+	OVPN_A_PEER_TX_ID,
 
 	__OVPN_A_PEER_MAX,
 	OVPN_A_PEER_MAX =
=3D (__OVPN_A_PEER_MAX - 1)
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/=
ssl=2Ec
index 8e8d4a0=2E=2E0a7dffb 100644
--- a/src/openvpn/ssl=2Ec
+++ b/s=
rc/openvpn/ssl=2Ec
@@ -1202,9 +1202,10 @@
     tls_session_init(multi, &mul=
ti->session[TM_ACTIVE]);
     tls_session_init(multi, &multi->session[TM_IN=
ITIAL]);
 
-    if (!multi->opt=2Edco_enabled)
+    /* Calculate the asymme=
tric peer-id=2E Leaving it unset is what keeps us from
+     * announcing o=
ne to the peer, so DCO needs the kernel to support it */
+    if (dco_can_a=
sym_peer_id(&multi->opt))
     {
-        /* Calculate the asymmetric peer-=
id */
         if (multi->rx_peer_id =3D=3D MAX_PEER_ID && multi->session[T=
M_INITIAL]=2Eopt->mode !=3D MODE_SERVER)
         {
             multi->rx_=
peer_id =3D (uint32_t)(get_random() % (MAX_PEER_ID - 1));
@@ -1934,9 +1935,=
16 @@
 push_peer_info_peerid(struct buffer *out, const struct tls_multi *mu=
lti,
                       const struct tls_session *session)
 {
-    if (=
multi->rx_peer_id =3D=3D MAX_PEER_ID || session->opt->dco_enabled)
+    if =
(multi->rx_peer_id =3D=3D MAX_PEER_ID)
     {
-        /* No valid peer id =
or DCO is enabled=2E Cannot use this feature */
+        /* No valid peer i=
d */
+        return true;
+    }
+
+    if (!dco_can_asym_peer_id(session-=
>opt))
+    {
+        /* DCO is in use but the local kernel cannot do asym=
metric peer-ids:
+         * do not announce our ID so that the peer falls =
back as well */
         return true;
     }
 
@@ -2373,16 +2381,18 @@
    =
 {
         output_peer_info_env(session->opt->es, multi->peer_info);
     =
    uint32_t peer_id =3D extract_asymmetric_peer_id(multi->peer_info);
-   =
     if (peer_id !=3D MAX_PEER_ID && !session->opt->dco_enabled)
+        i=
f (peer_id !=3D MAX_PEER_ID && dco_can_asym_peer_id(session->opt))
        =
 {
+            /* set before key_method_2_write() runs, so that a server k=
nows
+             * whether to announce its own ID back */
             mu=
lti->tx_peer_id =3D peer_id;
             multi->use_asymmetric_peer_id =3D=
 true;
             multi->use_peer_id =3D true;
         }
         else
 =
        {
-            /* Peer has no support for asymmetric peer-id, and D=
CO currently
-             * can only handle symmetric peer IDs */
+       =
     /* the peer announced nothing, or we cannot use asymmetric peer-ids
+ =
            * locally: stay symmetric */
             multi->tx_peer_id =3D=
 multi->rx_peer_id;
         }
     }
diff --git a/src/openvpn/ssl_common=
=2Eh b/src/openvpn/ssl_common=2Eh
index 38b360a=2E=2Ed678da6 100644
--- a/s=
rc/openvpn/ssl_common=2Eh
+++ b/src/openvpn/ssl_common=2Eh
@@ -456,9 +456,2=
1 @@
     size_t ekm_label_size;
     size_t ekm_size;
 
-    bool dco_enab=
led; /**< Whether keys have to be installed in DCO or not */
+    bool dco_=
enabled;              /**< Whether keys have to be installed in DCO or not =
*/
+    unsigned int dco_capabilities; /**< local kernel DCO capability bit=
map (DCO_CAP_*) */
 };
 
+/**
+ * Whether asymmetric peer-ids can be used: =
either DCO is not in the way, or the
+ * local kernel supports them=2E When=
 false we neither generate nor announce an
+ * ID, so the remote peer falls=
 back as well=2E
+ */
+static inline bool
+dco_can_asym_peer_id(const struc=
t tls_options *o)
+{
+    return !o->dco_enabled || (o->dco_capabilities & =
DCO_CAP_ASYM_PEER_ID);
+}
+
 /** @addtogroup control_processor
  *  @{ */
 =
/** @name Index of key_state objects within a tls_session structure
diff --=
git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index f13f507=2E=2E=
6cfe408 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
=
@@ -398,7 +398,7 @@
 {
     /* will return 0 if peer_info is null */
     c=
onst unsigned int iv_proto_peer =3D extract_iv_proto(multi->peer_info);
-  =
  const unsigned int tx_peer_id =3D extract_asymmetric_peer_id(multi->peer_=
info);
+    uint32_t tx_peer_id =3D extract_asymmetric_peer_id(multi->peer_=
info);
 
     /* The other peer does not support P2P NCP */
     if (!(iv_p=
roto_peer & IV_PROTO_NCP_P2P))
@@ -406,6 +406,14 @@
         return;
     }=

 
+    if (!dco_can_asym_peer_id(session->opt))
+    {
+        /* We cann=
ot use asymmetric peer-ids locally: ignore the announced
+         * ID and=
 use the legacy shared peer-id selection below */
+        tx_peer_id =3D M=
AX_PEER_ID;
+        multi->use_asymmetric_peer_id =3D false;
+    }
+
    =
 if (iv_proto_peer & IV_PROTO_DATA_V2)
     {
         multi->use_peer_id =
=3D true;
@@ -436,8 +444,7 @@
     if (multi->use_peer_id)
     {
         =
/* The asymmetric peer-id trumps on the EKM generated ones */
-        if (=
(iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
-            && (tx_peer_id !=3D =
MAX_PEER_ID) && !multi->opt=2Edco_enabled)
+        if ((iv_proto_peer & IV=
_PROTO_TLS_KEY_EXPORT) && (tx_peer_id !=3D MAX_PEER_ID))
         {
       =
      multi->tx_peer_id =3D tx_peer_id;
             multi->use_asymmetric_=
peer_id =3D true;

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/open=
vpn/+/1983?usp=3Demail
To unsubscribe, or for help writing mail filters, vi=
sit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType=
: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-I=
d: Ic5c421ec2e9627340924a05509bb8aff0bbf17da
Gerrit-Change-Number: 1983
Ger=
rit-PatchSet: 2
Gerrit-Owner: Gianmarco De Gregori <gianmarco@mandelbit=2Ec=
om>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: R=
alf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lis=
ts=2Esourceforge=2Enet>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc254=
9=2Eorg>

--hjKyCvOSGUQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori <strong>=
uploaded patch set #2</strong> to this change=2E</p><p><a href=3D"https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1983?usp=3Demail">View Change</a></p><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">dco_linux: enable asymmetric peer IDs when supported<br><br>When =
notifying ovpn about a new peer, also send the TX peer ID so the<br>module =
can forward packets with the correct peer ID value=2E This<br>attribute is =
optional: if tx_peer_id is missing, the module falls back<br>to the non-mul=
tipeer configuration, where tx_peer_id equals rx_peer_id=2E<br><br>The attr=
ibute is sent only to a kernel that knows it, since older ones<br>reject OV=
PN_CMD_PEER_NEW with EINVAL on an attribute they cannot parse=2E<br>Define =
the first DCO capability, DCO_CAP_ASYM_PEER_ID, as a row in the<br>requirem=
ent table: the doit policy of OVPN_CMD_PEER_NEW must expose<br>OVPN_A_PEER_=
TX_ID as a u32 inside OVPN_A_PEER=2E<br><br>The bit is then consumed=2E It =
travels in tls_options, so a peer announces<br>its own ID only when it can =
use asymmetric peer-ids, and a server<br>replies with its own only when the=
 client announced one and the local<br>kernel can do it too=2E A peer that =
announces nothing leaves the other<br>side on symmetric peer-ids, so there =
is nothing to exchange over the<br>wire=2E The local ID is generated under =
the same bit, which also lifts the<br>blanket skip tls_multi_init_finalize(=
) applied whenever DCO was enabled=2E<br><br>Change-Id: Ic5c421ec2e96273409=
24a05509bb8aff0bbf17da<br>Signed-off-by: Ralf Lici &lt;ralf@mandelbit=2Ecom=
&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&g=
t;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M src/openvp=
n/dco_freebsd=2Ec<br>M src/openvpn/dco_internal=2Eh<br>M src/openvpn/dco_li=
nux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/init=2Ec<br>M src/ope=
nvpn/ovpn_dco_linux=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_commo=
n=2Eh<br>M src/openvpn/ssl_ncp=2Ec<br>11 files changed, 118 insertions(+), =
49 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/83/1983/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 0681c81=2E=2E50691fb =
100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span>+++ b/src/=
openvpn/dco=2Ec</span><br><span>@@ -57,8 +57,10 @@</span><br><span> </span>=
<br><span> {</span><br><span>     bool epoch =3D ks-&gt;crypto_options=2Efl=
ags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: rx_peer_id=3D%d keyid=3D%d epo=
ch=3D%d, currently %d keys installed&quot;,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        __func__, multi-&gt;dco_rx_peer_id, ks-&gt;ke=
y_id, epoch, multi-&gt;dco_keys_installed);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        &quot;%s: rx_peer_id=3D%d tx_peer_id=3D%u =
keyid=3D%d epoch=3D%d, currently %d keys installed&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        __func__, multi-&gt;dco_rx_pe=
er_id, multi-&gt;tx_peer_id, ks-&gt;key_id, epoch,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        multi-&gt;dco_keys_installed);</span=
><br><span> </span><br><span>     /* Install a key in the PRIMARY slot only=
 when no other key exist=2E</span><br><span>      * From that moment on, an=
y new key will be installed in the SECONDARY</span><br><span>@@ -510,9 +512=
,11 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_pull_options(msglvl_t=
 msglevel, const struct options *o)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dco_check_pull_options(msglvl_t msglevel, const struct tls_=
multi *multi)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!o-&gt;use_peer_id)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* asymmetric peer-ids are negotiated, not pushed, s=
o options=2Euse_peer_id</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * is not yet in sync when this runs */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!multi-&gt;use_peer_id)</span><br><span=
>     {</span><br><span>         msg(msglevel, &quot;OPTIONS IMPORT: Server=
 did not request DATA_V2 packet &quot;</span><br><span>                    =
   &quot;format required for data channel offload&quot;);</span><br><span>@=
@ -544,8 +548,8 @@</span><br><span>         c-&gt;c2=2Etls_multi-&gt;dco_rx=
_peer_id =3D -1;</span><br><span>     }</span><br><span> #endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_new_peer(&amp=
;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, NULL,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                           p=
roto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_new_peer(&amp;c-&=
gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, multi-&gt;tx_peer_id,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
sock-&gt;sd, NULL, proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NUL=
L,</span><br><span>                            NULL, NULL);</span><br><span=
>     if (ret &lt; 0)</span><br><span>     {</span><br><span>@@ -628,6 +632=
,7 @@</span><br><span>     const struct context *c =3D &amp;mi-&gt;context;=
</span><br><span> </span><br><span>     uint32_t rx_peer_id =3D c-&gt;c2=2E=
tls_multi-&gt;rx_peer_id;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint32_t tx_peer_id =3D c-&gt;c2=2Etls_multi-&gt;tx_peer_id;</spa=
n><br><span>     struct sockaddr *remoteaddr, *localaddr =3D NULL;</span><b=
r><span>     struct sockaddr_storage local =3D { 0 };</span><br><span>     =
const socket_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;sd;</span><=
br><span>@@ -665,7 +670,7 @@</span><br><span>     }</span><br><span> </span=
><br><span>     int ret =3D</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, rx_peer_id, sd, =
localaddr, remoteaddr, vpn_addr4, vpn_addr6);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;d=
co, rx_peer_id, tx_peer_id, sd, localaddr, remoteaddr, vpn_addr4, vpn_addr6=
);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</span><br><s=
pan>         return ret;</span><br><span>diff --git a/src/openvpn/dco=2Eh b=
/src/openvpn/dco=2Eh</span><br><span>index e9a0348=2E=2Ed20acc3 100644</spa=
n><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/openvpn/dco=
=2Eh</span><br><span>@@ -46,6 +46,9 @@</span><br><span> #define DCO_IROUTE_=
METRIC  100</span><br><span> #define DCO_DEFAULT_METRIC 200</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Local DCO cap=
ability bits, derived from kernel introspection */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define DCO_CAP_ASYM_PEER_ID (1u &lt;&lt; 0)=
 /**&lt; kernel supports OVPN_A_PEER_TX_ID */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #if defined(ENABLE_DCO)</span><=
br><span> </span><br><span> /**</span><br><span>@@ -95,10 +98,10 @@</span><=
br><span>  * for the first conflicting option found and return false=2E</sp=
an><br><span>  *</span><br><span>  * @param msglevel  the msg level to use =
to print the warnings</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @param o         the options struct that hold the options</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param multi     the TLS state =
holding the negotiated parameters</span><br><span>  * @return          true=
 if no conflict was detected, false otherwise</span><br><span>  */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-bool dco_check_pull_options(ms=
glvl_t msglevel, const struct options *o);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool dco_check_pull_options(msglvl_t msglevel, const=
 struct tls_multi *multi);</span><br><span> </span><br><span> /**</span><br=
><span>  * Initialize the DCO context</span><br><span>@@ -265,6 +268,7 @@</=
span><br><span>  *          of them and when it could not be asked</span><b=
r><span>  */</span><br><span> unsigned int dco_probe_capabilities(void);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #els=
e  /* if defined(ENABLE_DCO) */</span><br><span> </span><br><span> typedef =
void *dco_context_t;</span><br><span>@@ -294,7 +298,7 @@</span><br><span> }=
</span><br><span> </span><br><span> static inline bool</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-dco_check_pull_options(msglvl_t msglevel, =
const struct options *o)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+dco_check_pull_options(msglvl_t msglevel, const struct tls_multi *mult=
i)</span><br><span> {</span><br><span>     return false;</span><br><span> }=
</span><br><span>@@ -405,5 +409,6 @@</span><br><span> {</span><br><span>   =
  return 0;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> #endif /* defined(ENABLE_DCO) */</span><br><sp=
an> #endif /* ifndef DCO_H */</span><br><span>diff --git a/src/openvpn/dco_=
freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index 7130398=2E=
=2Ebe7608c 100644</span><br><span>--- a/src/openvpn/dco_freebsd=2Ec</span><=
br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -133,9 +133,9=
 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_context_t *dco, un=
signed int rx_peer_id, int sd, struct sockaddr *localaddr,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-             struct sockaddr *remotead=
dr, const struct in_addr *vpn_ipv4,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-             const struct in6_addr *vpn_ipv6)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+dco_new_peer(dco_context_t *dco, un=
signed int rx_peer_id, unsigned int tx_peer_id, int sd,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+             struct sockaddr *localaddr=
, struct sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+             const struct in_addr *vpn_ipv4, const struct in6_ad=
dr *vpn_ipv6)</span><br><span> {</span><br><span>     struct ifdrv drv;</sp=
an><br><span>     nvlist_t *nvl, *local_nvl, *remote_nvl;</span><br><span>@=
@ -143,7 +143,8 @@</span><br><span> </span><br><span>     nvl =3D nvlist_cr=
eate(0);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, fd %d&quot;, __func__, r=
x_peer_id, sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, tx-peer-id %u, fd %d&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, rx_peer=
_id, tx_peer_id, sd);</span><br><span> </span><br><span>     if (localaddr)=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/dco_intern=
al=2Eh b/src/openvpn/dco_internal=2Eh</span><br><span>index a9203163=2E=2Eb=
4821d3 100644</span><br><span>--- a/src/openvpn/dco_internal=2Eh</span><br>=
<span>+++ b/src/openvpn/dco_internal=2Eh</span><br><span>@@ -59,8 +59,8 @@<=
/span><br><span>  * They are implemented by dco_linux=2Ec</span><br><span> =
 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
int dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, socket_descri=
ptor_t sd,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
      struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_context_t *=
dco, unsigned int rx_peer_id, unsigned int tx_peer_id,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                 socket_descriptor_t sd,=
 struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span> =
                 const struct in_addr *vpn_ipv4, const struct in6_addr *vpn=
_ipv6);</span><br><span> </span><br><span> int dco_del_peer(dco_context_t *=
dco, unsigned int rx_peer_id);</span><br><span>diff --git a/src/openvpn/dco=
_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index 1235207=2E=2E2=
65d74b 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><sp=
an>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -120,6 +120,10 @@</sp=
an><br><span>     int expected_type;</span><br><span> };</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const struct =
dco_capability_req dco_capability_reqs[] =3D {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    { DCO_CAP_ASYM_PEER_ID, OVPN_CMD_PEER_NEW, O=
VPN_A_PEER, OVPN_A_PEER_TX_ID, NL_ATTR_TYPE_U32 },</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> /** the outcome of resolving one capability=
 requirement */</span><br><span> enum ovpn_cap_status</span><br><span> {</s=
pan><br><span>@@ -141,7 +145,8 @@</span><br><span> };</span><br><span> </sp=
an><br><span> /* What the local kernel supports=2E It cannot change while w=
e run, so the first</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 caller resolves it and the rest just read it=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * caller resolves it and the rest just r=
ead it=2E That caller is</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * do_init_crypto_tls(), which runs before any peer is added=2E */</sp=
an><br><span> static unsigned int dco_caps =3D 0;</span><br><span> static b=
ool dco_caps_resolved =3D false;</span><br><span> </span><br><span>@@ -390,=
14 +395,30 @@</span><br><span>         return dco_caps;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* no capability is defined yet: resolve one whose answer we already kn=
ow */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static const=
 struct dco_capability_req self_test =3D { 0, OVPN_CMD_PEER_NEW, OVPN_A_PEE=
R,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                                      OVPN_A_PEER_ID, NL_ATTR_TYPE_U32 };</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int err =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    enum ovpn_cap_status s=
tatus =3D ovpn_cap_probe_one(&amp;self_test, &amp;err);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(dc=
o_capability_reqs); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst struct dco_capability_req *req =3D &amp;dco_capability_reqs[i];</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        int err =3D 0;</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_DCO_DEBUG, &quot;%s: policy introspection self-test: %s (status %d, err =
%d)&quot;, __func__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       status =3D=3D OVPN_CAP_SUPPORTED ? &quot;ok&quot; : &quot;unexpected=
&quot;, (int)status, err);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        switch (ovpn_cap_probe_one(req, &amp;err))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            case OVPN_CAP_SUPPORTED:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                dco_caps |=3D =
req-&gt;cap;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            case OVPN_C=
AP_UNSUPPORTED:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            msg(D_DCO_DEBUG, &quot;%s: kernel does not support DCO capabili=
ty 0x%x&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    req-&gt;cap);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                break;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            case OVPN_CAP_UNKNOWN:</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                msg(M_WARN,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    &quot;Note: cannot determine =
DCO capability 0x%x from the kernel (%s), &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    &quot;assuming it is unsup=
ported&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              req-&gt;cap, err ? nl_geterror(err) : &quot;incomplete policy=
 dump&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span> </span><br><span>     dco_caps_resolved =3D true;</span><br><span=
>     msg(D_DCO_DEBUG, &quot;%s: DCO local capabilities: 0x%x&quot;, __func=
__, dco_caps);</span><br><span>@@ -523,9 +544,9 @@</span><br><span> }</span=
><br><span> </span><br><span> int</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, int s=
d, struct sockaddr *localaddr,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-             struct sockaddr *remoteaddr, const struct in_addr *vp=
n_ipv4,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             c=
onst struct in6_addr *vpn_ipv6)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, unsig=
ned int tx_peer_id, int sd,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+             struct sockaddr *localaddr, struct sockaddr *remoteadd=
r,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             cons=
t struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)</span><br><spa=
n> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>=
     const char *remotestr =3D &quot;[undefined]&quot;;</span><br><span>@@ =
-533,13 +554,21 @@</span><br><span>     {</span><br><span>         remotest=
r =3D print_sockaddr(remoteaddr, &amp;gc);</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: =
rx-peer-id %u, fd %d, remote addr: %s&quot;, __func__, rx_peer_id, sd, remo=
testr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DC=
O_DEBUG, &quot;%s: rx-peer-id %u, tx-peer-id %u, fd %d, remote addr: %s&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__=
, rx_peer_id, tx_peer_id, sd, remotestr);</span><br><span> </span><br><span=
>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NE=
W);</span><br><span>     struct nlattr *attr =3D nla_nest_start(nl_msg, OVP=
N_A_PEER);</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span> </s=
pan><br><span>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* old kernels reject t=
he whole command if they see an attribute they do not</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * know=2E This is the same answer th=
e TLS layer used to decide whether to</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * negotiate an asymmetric ID, so the two cannot disa=
gree */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_=
caps &amp; DCO_CAP_ASYM_PEER_ID)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       NLA_PUT_U32(nl_msg, OVPN_A_PEER_TX_ID, tx_peer_id);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     NLA_PUT_U=
32(nl_msg, OVPN_A_PEER_SOCKET, sd);</span><br><span> </span><br><span>     =
/* Set the remote endpoint if defined (for UDP) */</span><br><span>@@ -719,=
12 +748,6 @@</span><br><span> {</span><br><span>     dco-&gt;ovpn_dco_id =
=3D resolve_ovpn_netlink_id(M_FATAL);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    /* nothing consumes the bitmap yet; r=
esolve it here to exercise the path */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (check_debug_level(D_DCO_DEBUG))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        dco_probe_capabilities();</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     dco-&gt;nl_sock =3D nl_socket_alloc()=
;</span><br><span> </span><br><span>     if (!dco-&gt;nl_sock)</span><br><s=
pan>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><b=
r><span>index fbe1624=2E=2E27f5b92 100644</span><br><span>--- a/src/openvpn=
/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>=
@@ -406,11 +406,12 @@</span><br><span> }</span><br><span> </span><br><span>=
 int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_=
context_t *dco, unsigned int rx_peer_id, socket_descriptor_t sd,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-             struct sockaddr *lo=
caladdr, struct sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id,=
 unsigned int tx_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+             socket_descriptor_t sd, struct sockaddr *localaddr, stru=
ct sockaddr *remoteaddr,</span><br><span>              const struct in_addr=
 *vpn_ipv4, const struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: rx=
-peer-id %u, fd &quot; SOCKET_PRINTF, __func__, rx_peer_id, sd);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s:=
 rx-peer-id %u, tx-peer-id %u, fd &quot; SOCKET_PRINTF,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        __func__, rx_peer_id, tx_peer_i=
d, sd);</span><br><span> </span><br><span>     if (dco-&gt;ifmode =3D=3D DC=
O_MODE_P2P)</span><br><span>     {</span><br><span>diff --git a/src/openvpn=
/init=2Ec b/src/openvpn/init=2Ec</span><br><span>index ddcfaf4=2E=2Ec8b6bf0=
 100644</span><br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/sr=
c/openvpn/init=2Ec</span><br><span>@@ -2677,7 +2677,7 @@</span><br><span>  =
       }</span><br><span> </span><br><span>         /* Check if pushed opti=
ons are compatible with DCO, if enabled */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (dco_enabled(&amp;c-&gt;options) &amp;&amp;=
 !dco_check_pull_options(D_PUSH_ERRORS, &amp;c-&gt;options))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (dco_enabled(&amp;c-&gt=
;options) &amp;&amp; !dco_check_pull_options(D_PUSH_ERRORS, c-&gt;c2=2Etls_=
multi))</span><br><span>         {</span><br><span>             msg(D_PUSH_=
ERRORS, &quot;OPTIONS ERROR: pushed options are incompatible &quot;</span><=
br><span>                                &quot;with data channel offload=2E=
 Use --disable-dco to connect to &quot;</span><br><span>@@ -3447,6 +3447,10=
 @@</span><br><span> </span><br><span>     /* let the TLS engine know if ke=
ys have to be installed in DCO or not */</span><br><span>     to=2Edco_enab=
led =3D dco_enabled(options);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (to=2Edco_enabled)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        to=2Edco_capabilities =3D dco_probe_capabilities();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br=
><span>     /*</span><br><span>      * Initialize OpenVPN&#39;s master TLS-=
mode object=2E</span><br><span>diff --git a/src/openvpn/ovpn_dco_linux=2Eh =
b/src/openvpn/ovpn_dco_linux=2Eh</span><br><span>index b3c9ff0=2E=2E28cf97a=
 100644</span><br><span>--- a/src/openvpn/ovpn_dco_linux=2Eh</span><br><spa=
n>+++ b/src/openvpn/ovpn_dco_linux=2Eh</span><br><span>@@ -54,6 +54,7 @@</s=
pan><br><span> 	OVPN_A_PEER_LINK_TX_BYTES,</span><br><span> 	OVPN_A_PEER_LI=
NK_RX_PACKETS,</span><br><span> 	OVPN_A_PEER_LINK_TX_PACKETS,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_TX_ID,</span><br><sp=
an> </span><br><span> 	__OVPN_A_PEER_MAX,</span><br><span> 	OVPN_A_PEER_MAX=
 =3D (__OVPN_A_PEER_MAX - 1)</span><br><span>diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 8e8d4a0=2E=2E0a7dffb 10064=
4</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openv=
pn/ssl=2Ec</span><br><span>@@ -1202,9 +1202,10 @@</span><br><span>     tls_=
session_init(multi, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span>   =
  tls_session_init(multi, &amp;multi-&gt;session[TM_INITIAL]);</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!multi-&=
gt;opt=2Edco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Calculate the asymmetric peer-id=2E Leaving it unset is what keeps=
 us from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * anno=
uncing one to the peer, so DCO needs the kernel to support it */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_can_asym_peer_id(&=
amp;multi-&gt;opt))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* Calculate the asymmetric peer-id */</span><=
br><span>         if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; mu=
lti-&gt;session[TM_INITIAL]=2Eopt-&gt;mode !=3D MODE_SERVER)</span><br><spa=
n>         {</span><br><span>             multi-&gt;rx_peer_id =3D (uint32_=
t)(get_random() % (MAX_PEER_ID - 1));</span><br><span>@@ -1934,9 +1935,16 @=
@</span><br><span> push_peer_info_peerid(struct buffer *out, const struct t=
ls_multi *multi,</span><br><span>                       const struct tls_se=
ssion *session)</span><br><span> {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID || session-&gt=
;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* No valid pee=
r id or DCO is enabled=2E Cannot use this feature */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* No valid peer id */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!dco_can_asym_peer_id(session-&gt;opt))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* DCO is in use but the local kernel =
cannot do asymmetric peer-ids:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+         * do not announce our ID so that the peer falls back as=
 well */</span><br><span>         return true;</span><br><span>     }</span=
><br><span> </span><br><span>@@ -2373,16 +2381,18 @@</span><br><span>     {=
</span><br><span>         output_peer_info_env(session-&gt;opt-&gt;es, mult=
i-&gt;peer_info);</span><br><span>         uint32_t peer_id =3D extract_asy=
mmetric_peer_id(multi-&gt;peer_info);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (peer_id !=3D MAX_PEER_ID &amp;&amp; !session-&g=
t;opt-&gt;dco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (peer_id !=3D MAX_PEER_ID &amp;&amp; dco_can_asym_peer_id(ses=
sion-&gt;opt))</span><br><span>         {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            /* set before key_method_2_write() runs, =
so that a server knows</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+             * whether to announce its own ID back */</span><br><span>  =
           multi-&gt;tx_peer_id =3D peer_id;</span><br><span>             m=
ulti-&gt;use_asymmetric_peer_id =3D true;</span><br><span>             mult=
i-&gt;use_peer_id =3D true;</span><br><span>         }</span><br><span>    =
     else</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            /* Peer has no support for asymmetric peer-id, a=
nd DCO currently</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        * can only handle symmetric peer IDs */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            /* the peer announced nothing, or w=
e cannot use asymmetric peer-ids</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+             * locally: stay symmetric */</span><br><span>    =
         multi-&gt;tx_peer_id =3D multi-&gt;rx_peer_id;</span><br><span>   =
      }</span><br><span>     }</span><br><span>diff --git a/src/openvpn/ssl=
_common=2Eh b/src/openvpn/ssl_common=2Eh</span><br><span>index 38b360a=2E=
=2Ed678da6 100644</span><br><span>--- a/src/openvpn/ssl_common=2Eh</span><b=
r><span>+++ b/src/openvpn/ssl_common=2Eh</span><br><span>@@ -456,9 +456,21 =
@@</span><br><span>     size_t ekm_label_size;</span><br><span>     size_t =
ekm_size;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    bool dco_enabled; /**&lt; Whether keys have to be installed in DC=
O or not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 dco_enabled;              /**&lt; Whether keys have to be installed in DCO=
 or not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsig=
ned int dco_capabilities; /**&lt; local kernel DCO capability bitmap (DCO_C=
AP_*) */</span><br><span> };</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Whether asymmetric peer-ids can be used: either DCO is not in=
 the way, or the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
local kernel supports them=2E When false we neither generate nor announce a=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ID, so the remo=
te peer falls back as well=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 inline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_can=
_asym_peer_id(const struct tls_options *o)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return !o-&gt;dco_enabled || (o-&gt;dco_capabilities &amp; DCO_CAP=
_ASYM_PEER_ID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /** =
@addtogroup control_processor</span><br><span>  *  @{ */</span><br><span> /=
** @name Index of key_state objects within a tls_session structure</span><b=
r><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</spa=
n><br><span>index f13f507=2E=2E6cfe408 100644</span><br><span>--- a/src/ope=
nvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><s=
pan>@@ -398,7 +398,7 @@</span><br><span> {</span><br><span>     /* will ret=
urn 0 if peer_info is null */</span><br><span>     const unsigned int iv_pr=
oto_peer =3D extract_iv_proto(multi-&gt;peer_info);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const unsigned int tx_peer_id =3D extra=
ct_asymmetric_peer_id(multi-&gt;peer_info);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uint32_t tx_peer_id =3D extract_asymmetric_peer=
_id(multi-&gt;peer_info);</span><br><span> </span><br><span>     /* The oth=
er peer does not support P2P NCP */</span><br><span>     if (!(iv_proto_pee=
r &amp; IV_PROTO_NCP_P2P))</span><br><span>@@ -406,6 +406,14 @@</span><br><=
span>         return;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!dco_can_asym_peer_id(se=
ssion-&gt;opt))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* We cann=
ot use asymmetric peer-ids locally: ignore the announced</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         * ID and use the legacy share=
d peer-id selection below */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        tx_peer_id =3D MAX_PEER_ID;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        multi-&gt;use_asymmetric_peer_id =3D false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (iv_pro=
to_peer &amp; IV_PROTO_DATA_V2)</span><br><span>     {</span><br><span>    =
     multi-&gt;use_peer_id =3D true;</span><br><span>@@ -436,8 +444,7 @@</s=
pan><br><span>     if (multi-&gt;use_peer_id)</span><br><span>     {</span>=
<br><span>         /* The asymmetric peer-id trumps on the EKM generated on=
es */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((iv_=
proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            &amp;&amp; (tx_peer_id !=3D MAX_PEER_ID) &a=
mp;&amp; !multi-&gt;opt=2Edco_enabled)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if ((iv_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT=
) &amp;&amp; (tx_peer_id !=3D MAX_PEER_ID))</span><br><span>         {</spa=
n><br><span>             multi-&gt;tx_peer_id =3D tx_peer_id;</span><br><sp=
an>             multi-&gt;use_asymmetric_peer_id =3D true;</span><br></pre>=
<p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/198=
3?usp=3Demail">change 1983</a>=2E To unsubscribe, or for help writing mail =
filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Dema=
il">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg=
/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1983?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatc=
hset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<di=
v style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"displa=
y:none"> Gerrit-Change-Id: Ic5c421ec2e9627340924a05509bb8aff0bbf17da </div>=

<div style=3D"display:none"> Gerrit-Change-Number: 1983 </div>
<div style=
=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> G=
errit-Owner: Gianmarco De Gregori &lt;gianmarco@mandelbit=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: Ralf Lici=
 &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rf=
c2549=2Eorg&gt; </div>

</body></html>
--hjKyCvOSGUQ=--


--===============7997981853302567466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7997981853302567466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7997981853302567466==--

