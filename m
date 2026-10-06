Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3942CA5FFC
	for <openvpn-devel@archiver.kernel.org>; Tue,  6 Oct 2026 11:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=zsYmRY38ONzOznhvAAsQycym5XOfWsMTHX0iGjgUPEg=; b=Ou+Do9NMJgGKV/
	AihxN+pLMaMIKYTrw5JGwQwVRNApmXJIguN+WilaLZjjsajhSFBCGAKnCIos6YiuXZ1fDDUU6cV41
	LANKeas0wws9rFsAOJQIgB1hgd/QgCIdQjdZFafzZLx7HlC2BcSrAFC6uX62VKia1Y/IpRoKz9C8a
	r90=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xE3RJ-0002E7-JD;
	Tue, 06 Oct 2026 11:34:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xE3RI-0002Dz-5U
 for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 11:34:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ovt3735eFYMn2G3hexoXpgD9GU43lzCxf6ZfsqUw+iM=; b=Alcz1wqvLHilzfvhdATAmsP8/J
 XTDaUNWMUXLt01S+agjnaQ8TC19nu2uOW/WWXxbexgjZo0wXhYZP6vRSeHnWIRI6WgcHXkQddlKa3
 VLVtz/F0h/W07TxoXUuFLi4qRkqKFbHrlsdBBVLGb3ouoYEMVveCw93BdU7LRlr65TQU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Ovt3735eFYMn2G3hexoXpgD9GU43lzCxf6ZfsqUw+iM=; b=S
 0M3xho02FUVt6Yr7IFMpHrNcRBll7SO8v9mj6NOhirKnXNT0dM5RGc1rnVxkfB3nTNmtQDQZdVphG
 HVl2s9ffeA1CVOxzp0bnz/8f/tJUWUGTkFhPLbLbtMY2VJje8E8Asf88zxUFBvz4LRBoqztX6XauD
 bbpXtvdKc3Z6CyCA=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xE3RD-0003oQ-7k for openvpn-devel@lists.sourceforge.net;
 Tue, 06 Oct 2026 11:34:29 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a16af2a232so4885635e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 06 Oct 2026 04:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791286461; x=1791891261; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ovt3735eFYMn2G3hexoXpgD9GU43lzCxf6ZfsqUw+iM=;
 b=NuHfzcfeDyjAxpvOlaNpzFHuHu62Y+M3QGGCmiImNdU0TzmCWYSLiVk3+SlJwVrAhV
 xn5fL1U2UirRlPb7En7OlRa0dRtYvKIzGpwisAXIA4vTmvel8Dr9Ob1j1nek9b90qofu
 M8H2dbmNKyWBGwofAAaYjE/88Jna4qcd7ZzgL6HHGNPAjngAHjTUODMD04I57ZB7Wmbo
 e/63pKx5xdf0d6XJ455cTDlHjQzGSsukQ4yJIL6yMQBh3B88gzNeLlab+ExAsT6A6aui
 8hRnRFcLhvsAGbUYz1ZYcKdmjPBZSTfbXzBww8nL9bGHgtb6KvTtMB3MkSzh4ZFSWGIj
 6H1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791286461; x=1791891261;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ovt3735eFYMn2G3hexoXpgD9GU43lzCxf6ZfsqUw+iM=;
 b=njCZV4+gqJIyQ5uHAfF/M8NUqE1LiDt86rPHGDZfNi5lq3qYfCEOYj9JDMS3aVKhQ0
 NcLMZce+FEorfghjesretc9eUI1FsL5BDz81gzx9hn84uIpERWhu1cwjbngFUirlJ+QT
 ypKUURQSA2lWKJeOWSsWC5tjaJXUrK5ZRQ2tuEs7bZS1ihIovpKnJZ3Nl6vwHyexl4jt
 i0WqfIRSUXWz8eQYQX6C+H5tmwPtTe6lXQVX6h13IWkJAyjv4Fpf9MNyxMV5AWfdJlxN
 saQVLmugHQVb3BypSp0tUhN/eZOm3qzDc9V8b+CZ7IBTPqsI/018f9Ym6VinQQ/jfE0H
 3TSA==
X-Gm-Message-State: AFuF++mwUOWkArg0nG25b12GPBYc4xOrnGRfVuuPUxKWbQfzmyLzX+G/
 jJcL+wCuy5WIbT6jCGDtYMZ26G9WRHVI5KJ+1GKF6esdl5u8ii8qpta6f5LuJ5+hv42SebTQFpa
 dyfSiKgwuvBE7CWQkJQOz+rp6tEhm4UDtNThZ9msJ3/1M2aEMEnDt5XQApiQqUQlIwbushX7MnF
 yNRuXa/g==
X-Gm-Gg: AYBFou3UK/HoONbacznjth/eE7OBLfBX8tV0W1E0DiprERn88aIKRTBCBPpAWiueuGE
 Zymq08IzA3n9kTldjUPJDxgCDx4+BadoTAwTjD768RiQRbjIh6c0o1qvbF8x4kVIfQHSqTwFXeO
 GSMB27ceDW8oPTEUCb3ZTGV8B+ElrBNwzVa1Wb6xTRRcveUmv+f7+heT4KiyQRkfX4YAucKq9Jk
 Izi8RgLnPkprklmTPqVvwi4aHQG8CTrU9uEh5A2tA5rIG2vACIXxxi2QVIXtvbh6w+PJDWTylEm
 mMbBZTWO788eSkwYtg5dc0y1Pumgl4SEJTT/2bDxIXeUkthJX0EB3KW6NOoMqUab5FtadMg7off
 TTkDQP4WqqzSZ/+MskIMhnDAdFUjie6GJa/Dp14E/jbyFy8n+AAJgHHTGkmb87+80TUiGd/fb4W
 J1a9A7o5FcmcMTnlZuiQuWzyP+/SQdY6XWthQdiqhEJA4IVBfGAJFwRcM2UQApN3nZBdl/P5yz2
 QeOiPe0FWZ7R7MmSTRK/8Cbe0DxOBKv5F8280uRM+JrTrsyZ5Hfwae2Ne2ObU9rKzSjeOTBoWae
 JcmiRmfhPV1hXbJ0D6T3hmbF0Z128xfSh479xYcwv2IiamRfemkLP8RR6KZp
X-Received: by 2002:a05:600c:1394:b0:4a0:2391:6533 with SMTP id
 5b1f17b1804b1-4a17b54b23bmr17378785e9.21.1791286459957; 
 Tue, 06 Oct 2026 04:34:19 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c4927esm96231145e9.8.2026.10.06.04.34.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 04:34:19 -0700 (PDT)
X-Google-Original-From: "Gianmarco De Gregori (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 6 Oct 2026 11:34:19 +0000
To: Arne Schwabe <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: Ic5c421ec2e9627340924a05509bb8aff0bbf17da
X-Gerrit-Change-Number: 1983
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1983?usp=email>
X-Gerrit-Commit: 0c52b0dfe98e5ead44d85439d1ee766ed7682335
References: <gerrit.1791286452000.Ic5c421ec2e9627340924a05509bb8aff0bbf17da@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkxMjg2NDUyMDAwLkljNWM0MjFlYzJlOTYyNzM0MDkyNGEwNTUwOWJiOGFmZjBiYmYxN2RhQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <abc7f7c939dcc95338492a38285186c7765de3a7-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xE3RD-0003oQ-7k
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: enable
 asymmetric peer IDs when supported
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
From: "Gianmarco De Gregori \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gianmarco@mandelbit.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "Gianmarco De Gregori \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2744745827834699850=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2744745827834699850==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5OgsYxL2AJY="; charset=UTF-8

--5OgsYxL2AJY=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe=2E

Hello Arne Schwabe,
=

I'd like you to do a code review=2E
Please visit

    https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1983?usp=3Demail

to review the following change=2E
=


Change subject: dco_linux: enable asymmetric peer IDs when supported
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

dco_linux: enabl=
e asymmetric peer IDs when supported

When notifying ovpn about a new peer,=
 also send the TX peer ID so the
module can forward packets with the correc=
t peer ID value=2E This
attribute is optional: if tx_peer_id is missing, th=
e module falls back
to the non-multipeer configuration, where tx_peer_id eq=
uals rx_peer_id=2E

The attribute is sent only to a kernel that knows it, s=
ince older ones
reject OVPN_CMD_PEER_NEW with EINVAL on an attribute they c=
annot parse=2E
Define the first DCO capability, DCO_CAP_ASYM_PEER_ID, as a =
row in the
requirement table: the doit policy of OVPN_CMD_PEER_NEW must exp=
ose
OVPN_A_PEER_TX_ID as a u32 inside OVPN_A_PEER=2E

The bit is then consu=
med=2E It travels in tls_options, so a peer announces
its own ID only when =
it can use asymmetric peer-ids, and a server
replies with its own only when=
 the client announced one and the local
kernel can do it too=2E A peer that=
 announces nothing leaves the other
side on symmetric peer-ids, so there is=
 nothing to exchange over the
wire=2E The local ID is generated under the s=
ame bit, which also lifts the
blanket skip tls_multi_init_finalize() applie=
d whenever DCO was enabled=2E

Change-Id: Ic5c421ec2e9627340924a05509bb8aff=
0bbf17da
Signed-off-by: Ralf Lici <ralf@mandelbit=2Ecom>
Signed-off-by: Gia=
nmarco De Gregori <gianmarco@mandelbit=2Ecom>
---
M src/openvpn/dco=2Ec
M s=
rc/openvpn/dco=2Eh
M src/openvpn/dco_freebsd=2Ec
M src/openvpn/dco_internal=
=2Eh
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_win=2Ec
M src/openvpn/in=
it=2Ec
M src/openvpn/ovpn_dco_linux=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn=
/ssl_common=2Eh
M src/openvpn/ssl_ncp=2Ec
11 files changed, 119 insertions(=
+), 49 deletions(-)



  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvp=
n refs/changes/83/1983/1

diff --git a/src/openvpn/dco=2Ec b/src/openvpn/dc=
o=2Ec
index 15f32e1=2E=2E6aa29b8 100644
--- a/src/openvpn/dco=2Ec
+++ b/src=
/openvpn/dco=2Ec
@@ -57,8 +57,10 @@
 
 {
     bool epoch =3D ks->crypto_opt=
ions=2Eflags & CO_EPOCH_DATA_KEY_FORMAT;
-    msg(D_DCO_DEBUG, "%s: rx_peer=
_id=3D%d keyid=3D%d epoch=3D%d, currently %d keys installed",
-        __fu=
nc__, multi->dco_rx_peer_id, ks->key_id, epoch, multi->dco_keys_installed);=

+    msg(D_DCO_DEBUG,
+        "%s: rx_peer_id=3D%d tx_peer_id=3D%u keyid=
=3D%d epoch=3D%d, currently %d keys installed",
+        __func__, multi->d=
co_rx_peer_id, multi->tx_peer_id, ks->key_id, epoch,
+        multi->dco_ke=
ys_installed);
 
     /* Install a key in the PRIMARY slot only when no oth=
er key exist=2E
      * From that moment on, any new key will be installed =
in the SECONDARY
@@ -510,9 +512,11 @@
 }
 
 bool
-dco_check_pull_options(ms=
glvl_t msglevel, const struct options *o)
+dco_check_pull_options(msglvl_t =
msglevel, const struct tls_multi *multi)
 {
-    if (!o->use_peer_id)
+    =
/* asymmetric peer-ids are negotiated, not pushed, so options=2Euse_peer_id=

+     * is not yet in sync when this runs */
+    if (!multi->use_peer_id)=

     {
         msg(msglevel, "OPTIONS IMPORT: Server did not request DATA=
_V2 packet "
                       "format required for data channel offlo=
ad");
@@ -544,8 +548,8 @@
         c->c2=2Etls_multi->dco_rx_peer_id =3D -1=
;
     }
 #endif
-    int ret =3D dco_new_peer(&c->c1=2Etuntap->dco, multi-=
>rx_peer_id, sock->sd, NULL,
-                           proto_is_dgram(soc=
k->info=2Eproto) ? remoteaddr : NULL,
+    int ret =3D dco_new_peer(&c->c1=
=2Etuntap->dco, multi->rx_peer_id, multi->tx_peer_id,
+                    =
       sock->sd, NULL, proto_is_dgram(sock->info=2Eproto) ? remoteaddr : NU=
LL,
                            NULL, NULL);
     if (ret < 0)
     {
@@ -6=
28,6 +632,7 @@
     const struct context *c =3D &mi->context;
 
     uint32=
_t rx_peer_id =3D c->c2=2Etls_multi->rx_peer_id;
+    uint32_t tx_peer_id =
=3D c->c2=2Etls_multi->tx_peer_id;
     struct sockaddr *remoteaddr, *local=
addr =3D NULL;
     struct sockaddr_storage local =3D { 0 };
     const soc=
ket_descriptor_t sd =3D c->c2=2Elink_sockets[0]->sd;
@@ -665,7 +670,7 @@
  =
   }
 
     int ret =3D
-        dco_new_peer(&c->c1=2Etuntap->dco, rx_peer=
_id, sd, localaddr, remoteaddr, vpn_addr4, vpn_addr6);
+        dco_new_pee=
r(&c->c1=2Etuntap->dco, rx_peer_id, tx_peer_id, sd, localaddr, remoteaddr, =
vpn_addr4, vpn_addr6);
     if (ret < 0)
     {
         return ret;
diff -=
-git a/src/openvpn/dco=2Eh b/src/openvpn/dco=2Eh
index 0a8c9da=2E=2E6f6b983=
 100644
--- a/src/openvpn/dco=2Eh
+++ b/src/openvpn/dco=2Eh
@@ -46,6 +46,9 =
@@
 #define DCO_IROUTE_METRIC  100
 #define DCO_DEFAULT_METRIC 200
 
+/** L=
ocal DCO capability bits, derived from kernel introspection */
+#define DCO=
_CAP_ASYM_PEER_ID (1u << 0) /**< kernel supports OVPN_A_PEER_TX_ID */
+
 #i=
f defined(ENABLE_DCO)
 
 /**
@@ -95,10 +98,10 @@
  * for the first conflict=
ing option found and return false=2E
  *
  * @param msglevel  the msg level=
 to use to print the warnings
- * @param o         the options struct that =
hold the options
+ * @param multi     the TLS state holding the negotiated =
parameters
  * @return          true if no conflict was detected, false oth=
erwise
  */
-bool dco_check_pull_options(msglvl_t msglevel, const struct op=
tions *o);
+bool dco_check_pull_options(msglvl_t msglevel, const struct tls=
_multi *multi);
 
 /**
  * Initialize the DCO context
@@ -265,6 +268,7 @@
 =
 *          of them and when it could not be asked
  */
 unsigned int dco_p=
robe_capabilities(void);
+
 #else  /* if defined(ENABLE_DCO) */
 
 typedef =
void *dco_context_t;
@@ -294,7 +298,7 @@
 }
 
 static inline bool
-dco_chec=
k_pull_options(msglvl_t msglevel, const struct options *o)
+dco_check_pull_=
options(msglvl_t msglevel, const struct tls_multi *multi)
 {
     return fa=
lse;
 }
@@ -405,5 +409,6 @@
 {
     return 0;
 }
+
 #endif /* defined(ENABL=
E_DCO) */
 #endif /* ifndef DCO_H */
diff --git a/src/openvpn/dco_freebsd=
=2Ec b/src/openvpn/dco_freebsd=2Ec
index 178b754=2E=2Edd8cd6f 100644
--- a/=
src/openvpn/dco_freebsd=2Ec
+++ b/src/openvpn/dco_freebsd=2Ec
@@ -133,9 +13=
3,9 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id,=
 int sd, struct sockaddr *localaddr,
-             struct sockaddr *remotea=
ddr, const struct in_addr *vpn_ipv4,
-             const struct in6_addr *v=
pn_ipv6)
+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, unsigne=
d int tx_peer_id, int sd,
+             struct sockaddr *localaddr, struct =
sockaddr *remoteaddr,
+             const struct in_addr *vpn_ipv4, const s=
truct in6_addr *vpn_ipv6)
 {
     struct ifdrv drv;
     nvlist_t *nvl, *lo=
cal_nvl, *remote_nvl;
@@ -143,7 +143,8 @@
 
     nvl =3D nvlist_create(0);
=
 
-    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, fd %d", __func__, rx_peer_id, s=
d);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, tx-peer-id %u, fd %d",
+     =
   __func__, rx_peer_id, tx_peer_id, sd);
 
     if (localaddr)
     {
diff=
 --git a/src/openvpn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh
index =
c507184=2E=2Eb4821d3 100644
--- a/src/openvpn/dco_internal=2Eh
+++ b/src/op=
envpn/dco_internal=2Eh
@@ -59,8 +59,9 @@
  * They are implemented by dco_li=
nux=2Ec
  */
 
-int dco_new_peer(dco_context_t *dco, unsigned int rx_peer_i=
d, socket_descriptor_t sd, struct sockaddr *localaddr,
-                 st=
ruct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4, const struct in6=
_addr *vpn_ipv6);
+int dco_new_peer(dco_context_t *dco, unsigned int rx_pee=
r_id, unsigned int tx_peer_id,
+                 socket_descriptor_t sd, st=
ruct sockaddr *localaddr, struct sockaddr *remoteaddr,
+                 co=
nst struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);
 
 int dco_=
del_peer(dco_context_t *dco, unsigned int rx_peer_id);
 
diff --git a/src/o=
penvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
index 96b7521=2E=2Eff50405=
 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ =
-120,6 +120,10 @@
     int expected_type;
 };
 
+static const struct dco_ca=
pability_req dco_capability_reqs[] =3D {
+    { DCO_CAP_ASYM_PEER_ID, OVPN_=
CMD_PEER_NEW, OVPN_A_PEER, OVPN_A_PEER_TX_ID, NL_ATTR_TYPE_U32 },
+};
+
 /*=
* the outcome of resolving one capability requirement */
 enum ovpn_cap_sta=
tus
 {
@@ -141,7 +145,8 @@
 };
 
 /* What the local kernel supports=2E It c=
annot change while we run, so the first
- * caller resolves it and the rest=
 just read it=2E */
+ * caller resolves it and the rest just read it=2E Tha=
t caller is
+ * do_init_crypto_tls(), which runs before any peer is added=
=2E */
 static unsigned int dco_caps =3D 0;
 static bool dco_caps_resolved =
=3D false;
 
@@ -390,14 +395,30 @@
         return dco_caps;
     }
 
-    =
/* no capability is defined yet: resolve one whose answer we already know *=
/
-    static const struct dco_capability_req self_test =3D { 0, OVPN_CMD_P=
EER_NEW, OVPN_A_PEER,
-                                                    =
     OVPN_A_PEER_ID, NL_ATTR_TYPE_U32 };
-    int err =3D 0;
-    enum ovpn=
_cap_status status =3D ovpn_cap_probe_one(&self_test, &err);
+    for (size=
_t i =3D 0; i < SIZE(dco_capability_reqs); i++)
+    {
+        const struc=
t dco_capability_req *req =3D &dco_capability_reqs[i];
+        int err =3D=
 0;
 
-    msg(D_DCO_DEBUG, "%s: policy introspection self-test: %s (status=
 %d, err %d)", __func__,
-        status =3D=3D OVPN_CAP_SUPPORTED ? "ok" :=
 "unexpected", (int)status, err);
+        switch (ovpn_cap_probe_one(req, =
&err))
+        {
+            case OVPN_CAP_SUPPORTED:
+                dc=
o_caps |=3D req->cap;
+                break;
+
+            case OVPN_CAP_=
UNSUPPORTED:
+                msg(D_DCO_DEBUG, "%s: kernel does not support=
 DCO capability 0x%x", __func__,
+                    req->cap);
+         =
       break;
+
+            case OVPN_CAP_UNKNOWN:
+                msg(M_=
WARN,
+                    "Note: cannot determine DCO capability 0x%x from=
 the kernel (%s), "
+                    "assuming it is unsupported",
+   =
                 req->cap, err ? nl_geterror(err) : "incomplete policy dump=
");
+                break;
+        }
+    }
 
     dco_caps_resolved =3D =
true;
     msg(D_DCO_DEBUG, "%s: DCO local capabilities: 0x%x", __func__, d=
co_caps);
@@ -523,9 +544,9 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, u=
nsigned int rx_peer_id, int sd, struct sockaddr *localaddr,
-             s=
truct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,
-             c=
onst struct in6_addr *vpn_ipv6)
+dco_new_peer(dco_context_t *dco, unsigned =
int rx_peer_id, unsigned int tx_peer_id, int sd,
+             struct socka=
ddr *localaddr, struct sockaddr *remoteaddr,
+             const struct in_=
addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
     struct gc_arena gc=
 =3D gc_new();
     const char *remotestr =3D "[undefined]";
@@ -533,13 +55=
4,21 @@
     {
         remotestr =3D print_sockaddr(remoteaddr, &gc);
    =
 }
-    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, fd %d, remote addr: %s", __fun=
c__, rx_peer_id, sd, remotestr);
+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, =
tx-peer-id %u, fd %d, remote addr: %s",
+        __func__, rx_peer_id, tx_p=
eer_id, sd, remotestr);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_cre=
ate(dco, OVPN_CMD_PEER_NEW);
     struct nlattr *attr =3D nla_nest_start(nl=
_msg, OVPN_A_PEER);
     int ret =3D -EMSGSIZE;
 
     NLA_PUT_U32(nl_msg, =
OVPN_A_PEER_ID, rx_peer_id);
+    /* old kernels reject the whole command i=
f they see an attribute they do not
+     * know=2E This is the same answer=
 the TLS layer used to decide whether to
+     * negotiate an asymmetric ID=
, so the two cannot disagree */
+    if (dco_caps & DCO_CAP_ASYM_PEER_ID)
+=
    {
+        NLA_PUT_U32(nl_msg, OVPN_A_PEER_TX_ID, tx_peer_id);
+    }
 =
    NLA_PUT_U32(nl_msg, OVPN_A_PEER_SOCKET, sd);
 
     /* Set the remote e=
ndpoint if defined (for UDP) */
@@ -719,12 +748,6 @@
 {
     dco->ovpn_dco_=
id =3D resolve_ovpn_netlink_id(M_FATAL);
 
-    /* nothing consumes the bit=
map yet; resolve it here to exercise the path */
-    if (check_debug_level=
(D_DCO_DEBUG))
-    {
-        dco_probe_capabilities();
-    }
-
     dco-=
>nl_sock =3D nl_socket_alloc();
 
     if (!dco->nl_sock)
diff --git a/src/=
openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index f1e0418=2E=2E3fce358 10=
0644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@@ -405,11=
 +405,12 @@
 }
 
 int
-dco_new_peer(dco_context_t *dco, unsigned int rx_pee=
r_id, socket_descriptor_t sd,
-             struct sockaddr *localaddr, str=
uct sockaddr *remoteaddr,
+dco_new_peer(dco_context_t *dco, unsigned int rx=
_peer_id, unsigned int tx_peer_id,
+             socket_descriptor_t sd, st=
ruct sockaddr *localaddr, struct sockaddr *remoteaddr,
              const =
struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
-    msg(D_DC=
O_DEBUG, "%s: rx-peer-id %u, fd " SOCKET_PRINTF, __func__, rx_peer_id, sd);=

+    msg(D_DCO_DEBUG, "%s: rx-peer-id %u, tx-peer-id %u, fd " SOCKET_PRINT=
F,
+        __func__, rx_peer_id, tx_peer_id, sd);
 
     if (dco->ifmode =
=3D=3D DCO_MODE_P2P)
     {
diff --git a/src/openvpn/init=2Ec b/src/openvpn=
/init=2Ec
index 9306a96=2E=2E7083d1a 100644
--- a/src/openvpn/init=2Ec
+++ =
b/src/openvpn/init=2Ec
@@ -2677,7 +2677,7 @@
         }
 
         /* Check=
 if pushed options are compatible with DCO, if enabled */
-        if (dco_=
enabled(&c->options) && !dco_check_pull_options(D_PUSH_ERRORS, &c->options)=
)
+        if (dco_enabled(&c->options) && !dco_check_pull_options(D_PUSH_E=
RRORS, c->c2=2Etls_multi))
         {
             msg(D_PUSH_ERRORS, "OPTI=
ONS ERROR: pushed options are incompatible "
                              =
  "with data channel offload=2E Use --disable-dco to connect to "
@@ -3446,=
6 +3446,10 @@
 
     /* let the TLS engine know if keys have to be installe=
d in DCO or not */
     to=2Edco_enabled =3D dco_enabled(options);
+    if =
(to=2Edco_enabled)
+    {
+        to=2Edco_capabilities =3D dco_probe_capa=
bilities();
+    }
 
     /*
      * Initialize OpenVPN's master TLS-mode o=
bject=2E
diff --git a/src/openvpn/ovpn_dco_linux=2Eh b/src/openvpn/ovpn_dco=
_linux=2Eh
index b3c9ff0=2E=2E28cf97a 100644
--- a/src/openvpn/ovpn_dco_lin=
ux=2Eh
+++ b/src/openvpn/ovpn_dco_linux=2Eh
@@ -54,6 +54,7 @@
 	OVPN_A_PEER=
_LINK_TX_BYTES,
 	OVPN_A_PEER_LINK_RX_PACKETS,
 	OVPN_A_PEER_LINK_TX_PACKET=
S,
+	OVPN_A_PEER_TX_ID,
 
 	__OVPN_A_PEER_MAX,
 	OVPN_A_PEER_MAX =3D (__OVP=
N_A_PEER_MAX - 1)
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
in=
dex 137e340=2E=2E889a9ae 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn=
/ssl=2Ec
@@ -1197,9 +1197,10 @@
     tls_session_init(multi, &multi->sessio=
n[TM_ACTIVE]);
     tls_session_init(multi, &multi->session[TM_INITIAL]);
 =

-    if (!multi->opt=2Edco_enabled)
+    /* Calculate the asymmetric peer-=
id=2E Leaving it unset is what keeps us from
+     * announcing one to the =
peer, so DCO needs the kernel to support it */
+    if (dco_can_asym_peer_i=
d(&multi->opt))
     {
-        /* Calculate the asymmetric peer-id */
    =
     if (multi->rx_peer_id =3D=3D MAX_PEER_ID && multi->session[TM_INITIAL]=
=2Eopt->mode !=3D MODE_SERVER)
         {
             multi->rx_peer_id =
=3D (uint32_t)(get_random() % (MAX_PEER_ID - 1));
@@ -1922,9 +1923,16 @@
 s=
tatic bool
 push_peer_info_peerid(struct buffer *out, struct tls_multi *mul=
ti, struct tls_session *session)
 {
-    if (multi->rx_peer_id =3D=3D MAX_P=
EER_ID || session->opt->dco_enabled)
+    if (multi->rx_peer_id =3D=3D MAX_=
PEER_ID)
     {
-        /* No valid peer id or DCO is enabled=2E Cannot us=
e this feature */
+        /* No valid peer id */
+        return true;
+  =
  }
+
+    if (!dco_can_asym_peer_id(session->opt))
+    {
+        /* DCO =
is in use but the local kernel cannot do asymmetric peer-ids:
+         * d=
o not announce our ID so that the peer falls back as well */
         retur=
n true;
     }
 
@@ -2361,16 +2369,18 @@
     {
         output_peer_info_e=
nv(session->opt->es, multi->peer_info);
         uint32_t peer_id =3D extra=
ct_asymmetric_peer_id(multi->peer_info);
-        if (peer_id !=3D MAX_PEER=
_ID && !session->opt->dco_enabled)
+        if (peer_id !=3D MAX_PEER_ID &&=
 dco_can_asym_peer_id(session->opt))
         {
+            /* set before =
key_method_2_write() runs, so that a server knows
+             * whether t=
o announce its own ID back */
             multi->tx_peer_id =3D peer_id;
 =
            multi->use_asymmetric_peer_id =3D true;
             multi->use=
_peer_id =3D true;
         }
         else
         {
-            /* Peer=
 has no support for asymmetric peer-id, and DCO currently
-             * c=
an only handle symmetric peer IDs */
+            /* the peer announced not=
hing, or we cannot use asymmetric peer-ids
+             * locally: stay sy=
mmetric */
             multi->tx_peer_id =3D multi->rx_peer_id;
         }=

     }
diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_common=2E=
h
index f32d188=2E=2E2c9ad53 100644
--- a/src/openvpn/ssl_common=2Eh
+++ b/=
src/openvpn/ssl_common=2Eh
@@ -451,9 +451,21 @@
     size_t ekm_label_size;=

     size_t ekm_size;
 
-    bool dco_enabled; /**< Whether keys have to b=
e installed in DCO or not */
+    bool dco_enabled;              /**< Wheth=
er keys have to be installed in DCO or not */
+    unsigned int dco_capabil=
ities; /**< local kernel DCO capability bitmap (DCO_CAP_*) */
 };
 
+/**
+ =
* Whether asymmetric peer-ids can be used: either DCO is not in the way, or=
 the
+ * local kernel supports them=2E When false we neither generate nor a=
nnounce an
+ * ID, so the remote peer falls back as well=2E
+ */
+static in=
line bool
+dco_can_asym_peer_id(const struct tls_options *o)
+{
+    return=
 !o->dco_enabled || (o->dco_capabilities & DCO_CAP_ASYM_PEER_ID);
+}
+
 /**=
 @addtogroup control_processor
  *  @{ */
 /** @name Index of key_state obj=
ects within a tls_session structure
diff --git a/src/openvpn/ssl_ncp=2Ec b/=
src/openvpn/ssl_ncp=2Ec
index f13f507=2E=2E6cfe408 100644
--- a/src/openvpn=
/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_ncp=2Ec
@@ -398,7 +398,7 @@
 {
     /* w=
ill return 0 if peer_info is null */
     const unsigned int iv_proto_peer =
=3D extract_iv_proto(multi->peer_info);
-    const unsigned int tx_peer_id =
=3D extract_asymmetric_peer_id(multi->peer_info);
+    uint32_t tx_peer_id =
=3D extract_asymmetric_peer_id(multi->peer_info);
 
     /* The other peer =
does not support P2P NCP */
     if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
@=
@ -406,6 +406,14 @@
         return;
     }
 
+    if (!dco_can_asym_peer_i=
d(session->opt))
+    {
+        /* We cannot use asymmetric peer-ids local=
ly: ignore the announced
+         * ID and use the legacy shared peer-id s=
election below */
+        tx_peer_id =3D MAX_PEER_ID;
+        multi->use_=
asymmetric_peer_id =3D false;
+    }
+
     if (iv_proto_peer & IV_PROTO_DA=
TA_V2)
     {
         multi->use_peer_id =3D true;
@@ -436,8 +444,7 @@
   =
  if (multi->use_peer_id)
     {
         /* The asymmetric peer-id trumps =
on the EKM generated ones */
-        if ((iv_proto_peer & IV_PROTO_TLS_KEY=
_EXPORT)
-            && (tx_peer_id !=3D MAX_PEER_ID) && !multi->opt=2Edco=
_enabled)
+        if ((iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT) && (tx_pee=
r_id !=3D MAX_PEER_ID))
         {
             multi->tx_peer_id =3D tx_pe=
er_id;
             multi->use_asymmetric_peer_id =3D true;

-- 
To view, v=
isit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1983?usp=3Demail
To unsubsc=
ribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Ene=
t/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openv=
pn
Gerrit-Branch: master
Gerrit-Change-Id: Ic5c421ec2e9627340924a05509bb8af=
f0bbf17da
Gerrit-Change-Number: 1983
Gerrit-PatchSet: 1
Gerrit-Owner: Gianm=
arco De Gregori <gianmarco@mandelbit=2Ecom>
Gerrit-Reviewer: Arne Schwabe <=
arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: Ralf Lici <ralf@mandelbit=2Ecom>
Ger=
rit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Atte=
ntion: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>

--5OgsYxL2AJY=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe=2E </p>
<p>Gianmarco De Gregori would li=
ke Arne Schwabe to <strong>review</strong> this change=2E
</p><p><a href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1983?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">dco_linux: enable asymmetric peer IDs when supported<br=
><br>When notifying ovpn about a new peer, also send the TX peer ID so the<=
br>module can forward packets with the correct peer ID value=2E This<br>att=
ribute is optional: if tx_peer_id is missing, the module falls back<br>to t=
he non-multipeer configuration, where tx_peer_id equals rx_peer_id=2E<br><b=
r>The attribute is sent only to a kernel that knows it, since older ones<br=
>reject OVPN_CMD_PEER_NEW with EINVAL on an attribute they cannot parse=2E<=
br>Define the first DCO capability, DCO_CAP_ASYM_PEER_ID, as a row in the<b=
r>requirement table: the doit policy of OVPN_CMD_PEER_NEW must expose<br>OV=
PN_A_PEER_TX_ID as a u32 inside OVPN_A_PEER=2E<br><br>The bit is then consu=
med=2E It travels in tls_options, so a peer announces<br>its own ID only wh=
en it can use asymmetric peer-ids, and a server<br>replies with its own onl=
y when the client announced one and the local<br>kernel can do it too=2E A =
peer that announces nothing leaves the other<br>side on symmetric peer-ids,=
 so there is nothing to exchange over the<br>wire=2E The local ID is genera=
ted under the same bit, which also lifts the<br>blanket skip tls_multi_init=
_finalize() applied whenever DCO was enabled=2E<br><br>Change-Id: Ic5c421ec=
2e9627340924a05509bb8aff0bbf17da<br>Signed-off-by: Ralf Lici &lt;ralf@mande=
lbit=2Ecom&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@mandelb=
it=2Ecom&gt;<br>---<br>M src/openvpn/dco=2Ec<br>M src/openvpn/dco=2Eh<br>M =
src/openvpn/dco_freebsd=2Ec<br>M src/openvpn/dco_internal=2Eh<br>M src/open=
vpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/init=2Ec<br=
>M src/openvpn/ovpn_dco_linux=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn=
/ssl_common=2Eh<br>M src/openvpn/ssl_ncp=2Ec<br>11 files changed, 119 inser=
tions(+), 49 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/83/1983/1</pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/=
src/openvpn/dco=2Ec b/src/openvpn/dco=2Ec</span><br><span>index 15f32e1=2E=
=2E6aa29b8 100644</span><br><span>--- a/src/openvpn/dco=2Ec</span><br><span=
>+++ b/src/openvpn/dco=2Ec</span><br><span>@@ -57,8 +57,10 @@</span><br><sp=
an> </span><br><span> {</span><br><span>     bool epoch =3D ks-&gt;crypto_o=
ptions=2Eflags &amp; CO_EPOCH_DATA_KEY_FORMAT;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: rx_peer_id=3D%d key=
id=3D%d epoch=3D%d, currently %d keys installed&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        __func__, multi-&gt;dco_rx_peer_id=
, ks-&gt;key_id, epoch, multi-&gt;dco_keys_installed);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        &quot;%s: rx_peer_id=3D%d tx_pe=
er_id=3D%u keyid=3D%d epoch=3D%d, currently %d keys installed&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, multi-&g=
t;dco_rx_peer_id, multi-&gt;tx_peer_id, ks-&gt;key_id, epoch,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        multi-&gt;dco_keys_instal=
led);</span><br><span> </span><br><span>     /* Install a key in the PRIMAR=
Y slot only when no other key exist=2E</span><br><span>      * From that mo=
ment on, any new key will be installed in the SECONDARY</span><br><span>@@ =
-510,9 +512,11 @@</span><br><span> }</span><br><span> </span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_pull_optio=
ns(msglvl_t msglevel, const struct options *o)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+dco_check_pull_options(msglvl_t msglevel, const =
struct tls_multi *multi)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!o-&gt;use_peer_id)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* asymmetric peer-ids are negotiated, no=
t pushed, so options=2Euse_peer_id</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * is not yet in sync when this runs */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!multi-&gt;use_peer_id)</spa=
n><br><span>     {</span><br><span>         msg(msglevel, &quot;OPTIONS IMP=
ORT: Server did not request DATA_V2 packet &quot;</span><br><span>         =
              &quot;format required for data channel offload&quot;);</span>=
<br><span>@@ -544,8 +548,8 @@</span><br><span>         c-&gt;c2=2Etls_multi=
-&gt;dco_rx_peer_id =3D -1;</span><br><span>     }</span><br><span> #endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ret =3D dco_ne=
w_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, sock-&gt;sd, N=
ULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
          proto_is_dgram(sock-&gt;info=2Eproto) ? remoteaddr : NULL,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret =3D dco_new_pe=
er(&amp;c-&gt;c1=2Etuntap-&gt;dco, multi-&gt;rx_peer_id, multi-&gt;tx_peer_=
id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
           sock-&gt;sd, NULL, proto_is_dgram(sock-&gt;info=2Eproto) ? remot=
eaddr : NULL,</span><br><span>                            NULL, NULL);</spa=
n><br><span>     if (ret &lt; 0)</span><br><span>     {</span><br><span>@@ =
-628,6 +632,7 @@</span><br><span>     const struct context *c =3D &amp;mi-&=
gt;context;</span><br><span> </span><br><span>     uint32_t rx_peer_id =3D =
c-&gt;c2=2Etls_multi-&gt;rx_peer_id;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint32_t tx_peer_id =3D c-&gt;c2=2Etls_multi-&gt;tx_pe=
er_id;</span><br><span>     struct sockaddr *remoteaddr, *localaddr =3D NUL=
L;</span><br><span>     struct sockaddr_storage local =3D { 0 };</span><br>=
<span>     const socket_descriptor_t sd =3D c-&gt;c2=2Elink_sockets[0]-&gt;=
sd;</span><br><span>@@ -665,7 +670,7 @@</span><br><span>     }</span><br><s=
pan> </span><br><span>     int ret =3D</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        dco_new_peer(&amp;c-&gt;c1=2Etuntap-&gt;dco, rx_pe=
er_id, sd, localaddr, remoteaddr, vpn_addr4, vpn_addr6);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        dco_new_peer(&amp;c-&gt;c1=2Et=
untap-&gt;dco, rx_peer_id, tx_peer_id, sd, localaddr, remoteaddr, vpn_addr4=
, vpn_addr6);</span><br><span>     if (ret &lt; 0)</span><br><span>     {</=
span><br><span>         return ret;</span><br><span>diff --git a/src/openvp=
n/dco=2Eh b/src/openvpn/dco=2Eh</span><br><span>index 0a8c9da=2E=2E6f6b983 =
100644</span><br><span>--- a/src/openvpn/dco=2Eh</span><br><span>+++ b/src/=
openvpn/dco=2Eh</span><br><span>@@ -46,6 +46,9 @@</span><br><span> #define =
DCO_IROUTE_METRIC  100</span><br><span> #define DCO_DEFAULT_METRIC 200</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** Lo=
cal DCO capability bits, derived from kernel introspection */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define DCO_CAP_ASYM_PEER_ID (1u =
&lt;&lt; 0) /**&lt; kernel supports OVPN_A_PEER_TX_ID */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(ENABLE_D=
CO)</span><br><span> </span><br><span> /**</span><br><span>@@ -95,10 +98,10=
 @@</span><br><span>  * for the first conflicting option found and return f=
alse=2E</span><br><span>  *</span><br><span>  * @param msglevel  the msg le=
vel to use to print the warnings</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * @param o         the options struct that hold the options</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param multi     the=
 TLS state holding the negotiated parameters</span><br><span>  * @return   =
       true if no conflict was detected, false otherwise</span><br><span>  =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool dco_check_pull=
_options(msglvl_t msglevel, const struct options *o);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool dco_check_pull_options(msglvl_t msgl=
evel, const struct tls_multi *multi);</span><br><span> </span><br><span> /*=
*</span><br><span>  * Initialize the DCO context</span><br><span>@@ -265,6 =
+268,7 @@</span><br><span>  *          of them and when it could not be ask=
ed</span><br><span>  */</span><br><span> unsigned int dco_probe_capabilitie=
s(void);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> #else  /* if defined(ENABLE_DCO) */</span><br><span> </span><br><spa=
n> typedef void *dco_context_t;</span><br><span>@@ -294,7 +298,7 @@</span><=
br><span> }</span><br><span> </span><br><span> static inline bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-dco_check_pull_options(msglvl_t=
 msglevel, const struct options *o)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+dco_check_pull_options(msglvl_t msglevel, const struct tls_=
multi *multi)</span><br><span> {</span><br><span>     return false;</span><=
br><span> }</span><br><span>@@ -405,5 +409,6 @@</span><br><span> {</span><b=
r><span>     return 0;</span><br><span> }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> #endif /* defined(ENABLE_DCO) */</s=
pan><br><span> #endif /* ifndef DCO_H */</span><br><span>diff --git a/src/o=
penvpn/dco_freebsd=2Ec b/src/openvpn/dco_freebsd=2Ec</span><br><span>index =
178b754=2E=2Edd8cd6f 100644</span><br><span>--- a/src/openvpn/dco_freebsd=
=2Ec</span><br><span>+++ b/src/openvpn/dco_freebsd=2Ec</span><br><span>@@ -=
133,9 +133,9 @@</span><br><span> }</span><br><span> </span><br><span> int</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_contex=
t_t *dco, unsigned int rx_peer_id, int sd, struct sockaddr *localaddr,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-             struct sockad=
dr *remoteaddr, const struct in_addr *vpn_ipv4,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-             const struct in6_addr *vpn_ipv6)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+dco_new_peer(dco_contex=
t_t *dco, unsigned int rx_peer_id, unsigned int tx_peer_id, int sd,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+             struct sockadd=
r *localaddr, struct sockaddr *remoteaddr,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             const struct in_addr *vpn_ipv4, const s=
truct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span>     struct if=
drv drv;</span><br><span>     nvlist_t *nvl, *local_nvl, *remote_nvl;</span=
><br><span>@@ -143,7 +143,8 @@</span><br><span> </span><br><span>     nvl =
=3D nvlist_create(0);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, fd %d&quot;=
, __func__, rx_peer_id, sd);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, tx-peer-id %u, fd %d=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        __fu=
nc__, rx_peer_id, tx_peer_id, sd);</span><br><span> </span><br><span>     i=
f (localaddr)</span><br><span>     {</span><br><span>diff --git a/src/openv=
pn/dco_internal=2Eh b/src/openvpn/dco_internal=2Eh</span><br><span>index c5=
07184=2E=2Eb4821d3 100644</span><br><span>--- a/src/openvpn/dco_internal=2E=
h</span><br><span>+++ b/src/openvpn/dco_internal=2Eh</span><br><span>@@ -59=
,8 +59,9 @@</span><br><span>  * They are implemented by dco_linux=2Ec</span=
><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-int dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, s=
ocket_descriptor_t sd, struct sockaddr *localaddr,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                 struct sockaddr *remoteaddr, =
const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int dco_new_peer(dco_context_=
t *dco, unsigned int rx_peer_id, unsigned int tx_peer_id,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                 socket_descriptor_t =
sd, struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 const struct in_a=
ddr *vpn_ipv4, const struct in6_addr *vpn_ipv6);</span><br><span> </span><b=
r><span> int dco_del_peer(dco_context_t *dco, unsigned int rx_peer_id);</sp=
an><br><span> </span><br><span>diff --git a/src/openvpn/dco_linux=2Ec b/src=
/openvpn/dco_linux=2Ec</span><br><span>index 96b7521=2E=2Eff50405 100644</s=
pan><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/src/ope=
nvpn/dco_linux=2Ec</span><br><span>@@ -120,6 +120,10 @@</span><br><span>   =
  int expected_type;</span><br><span> };</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static const struct dco_capability_r=
eq dco_capability_reqs[] =3D {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    { DCO_CAP_ASYM_PEER_ID, OVPN_CMD_PEER_NEW, OVPN_A_PEER, OVPN=
_A_PEER_TX_ID, NL_ATTR_TYPE_U32 },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> /** the outcome of resolving one capability requirement */<=
/span><br><span> enum ovpn_cap_status</span><br><span> {</span><br><span>@@=
 -141,7 +145,8 @@</span><br><span> };</span><br><span> </span><br><span> /*=
 What the local kernel supports=2E It cannot change while we run, so the fi=
rst</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * caller resolves=
 it and the rest just read it=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * caller resolves it and the rest just read it=2E That cal=
ler is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * do_init_cr=
ypto_tls(), which runs before any peer is added=2E */</span><br><span> stat=
ic unsigned int dco_caps =3D 0;</span><br><span> static bool dco_caps_resol=
ved =3D false;</span><br><span> </span><br><span>@@ -390,14 +395,30 @@</spa=
n><br><span>         return dco_caps;</span><br><span>     }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* no capabili=
ty is defined yet: resolve one whose answer we already know */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    static const struct dco_capabi=
lity_req self_test =3D { 0, OVPN_CMD_PEER_NEW, OVPN_A_PEER,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
                    OVPN_A_PEER_ID, NL_ATTR_TYPE_U32 };</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    int err =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    enum ovpn_cap_status status =3D ovpn_ca=
p_probe_one(&amp;self_test, &amp;err);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(dco_capability_reqs=
); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct dco_c=
apability_req *req =3D &amp;dco_capability_reqs[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        int err =3D 0;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &=
quot;%s: policy introspection self-test: %s (status %d, err %d)&quot;, __fu=
nc__,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status =
=3D=3D OVPN_CAP_SUPPORTED ? &quot;ok&quot; : &quot;unexpected&quot;, (int)s=
tatus, err);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 switch (ovpn_cap_probe_one(req, &amp;err))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            case OVPN_CAP_SUPPORTED:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                dco_caps |=3D req-&gt;cap;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            case OVPN_CAP_UNSUPPORTED=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ms=
g(D_DCO_DEBUG, &quot;%s: kernel does not support DCO capability 0x%x&quot;,=
 __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           req-&gt;cap);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 case OVPN_CAP_UNKNOWN:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                msg(M_WARN,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    &quot;Note: cannot determine DCO capability=
 0x%x from the kernel (%s), &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    &quot;assuming it is unsupported&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
req-&gt;cap, err ? nl_geterror(err) : &quot;incomplete policy dump&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                brea=
k;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </sp=
an><br><span>     dco_caps_resolved =3D true;</span><br><span>     msg(D_DC=
O_DEBUG, &quot;%s: DCO local capabilities: 0x%x&quot;, __func__, dco_caps);=
</span><br><span>@@ -523,9 +544,9 @@</span><br><span> }</span><br><span> </=
span><br><span> int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dc=
o_new_peer(dco_context_t *dco, unsigned int rx_peer_id, int sd, struct sock=
addr *localaddr,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
        struct sockaddr *remoteaddr, const struct in_addr *vpn_ipv4,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             const struct in=
6_addr *vpn_ipv6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+dc=
o_new_peer(dco_context_t *dco, unsigned int rx_peer_id, unsigned int tx_pee=
r_id, int sd,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       struct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             const struct in_ad=
dr *vpn_ipv4, const struct in6_addr *vpn_ipv6)</span><br><span> {</span><br=
><span>     struct gc_arena gc =3D gc_new();</span><br><span>     const cha=
r *remotestr =3D &quot;[undefined]&quot;;</span><br><span>@@ -533,13 +554,2=
1 @@</span><br><span>     {</span><br><span>         remotestr =3D print_so=
ckaddr(remoteaddr, &amp;gc);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %=
u, fd %d, remote addr: %s&quot;, __func__, rx_peer_id, sd, remotestr);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &qu=
ot;%s: rx-peer-id %u, tx-peer-id %u, fd %d, remote addr: %s&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        __func__, rx_peer_id=
, tx_peer_id, sd, remotestr);</span><br><span> </span><br><span>     struct=
 nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_NEW);</span><b=
r><span>     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEER);</=
span><br><span>     int ret =3D -EMSGSIZE;</span><br><span> </span><br><spa=
n>     NLA_PUT_U32(nl_msg, OVPN_A_PEER_ID, rx_peer_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* old kernels reject the whole com=
mand if they see an attribute they do not</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * know=2E This is the same answer the TLS layer =
used to decide whether to</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * negotiate an asymmetric ID, so the two cannot disagree */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (dco_caps &amp; D=
CO_CAP_ASYM_PEER_ID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        NLA_P=
UT_U32(nl_msg, OVPN_A_PEER_TX_ID, tx_peer_id);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span>     NLA_PUT_U32(nl_msg, O=
VPN_A_PEER_SOCKET, sd);</span><br><span> </span><br><span>     /* Set the r=
emote endpoint if defined (for UDP) */</span><br><span>@@ -719,12 +748,6 @@=
</span><br><span> {</span><br><span>     dco-&gt;ovpn_dco_id =3D resolve_ov=
pn_netlink_id(M_FATAL);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* nothing consumes the bitmap yet; resolve it here=
 to exercise the path */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (check_debug_level(D_DCO_DEBUG))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        dco_probe_capabilities();</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>     dco-&gt;nl_sock =3D nl_socket_alloc();</span><br><sp=
an> </span><br><span>     if (!dco-&gt;nl_sock)</span><br><span>diff --git =
a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br><span>index f=
1e0418=2E=2E3fce358 100644</span><br><span>--- a/src/openvpn/dco_win=2Ec</s=
pan><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@ -405,11 +405=
,12 @@</span><br><span> }</span><br><span> </span><br><span> int</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-dco_new_peer(dco_context_t *dco,=
 unsigned int rx_peer_id, socket_descriptor_t sd,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-             struct sockaddr *localaddr, struct=
 sockaddr *remoteaddr,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+dco_new_peer(dco_context_t *dco, unsigned int rx_peer_id, unsigned int t=
x_peer_id,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
    socket_descriptor_t sd, struct sockaddr *localaddr, struct sockaddr *re=
moteaddr,</span><br><span>              const struct in_addr *vpn_ipv4, con=
st struct in6_addr *vpn_ipv6)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u, fd=
 &quot; SOCKET_PRINTF, __func__, rx_peer_id, sd);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: rx-peer-id %u,=
 tx-peer-id %u, fd &quot; SOCKET_PRINTF,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        __func__, rx_peer_id, tx_peer_id, sd);</span><=
br><span> </span><br><span>     if (dco-&gt;ifmode =3D=3D DCO_MODE_P2P)</sp=
an><br><span>     {</span><br><span>diff --git a/src/openvpn/init=2Ec b/src=
/openvpn/init=2Ec</span><br><span>index 9306a96=2E=2E7083d1a 100644</span><=
br><span>--- a/src/openvpn/init=2Ec</span><br><span>+++ b/src/openvpn/init=
=2Ec</span><br><span>@@ -2677,7 +2677,7 @@</span><br><span>         }</span=
><br><span> </span><br><span>         /* Check if pushed options are compat=
ible with DCO, if enabled */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (dco_enabled(&amp;c-&gt;options) &amp;&amp; !dco_check_pu=
ll_options(D_PUSH_ERRORS, &amp;c-&gt;options))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (dco_enabled(&amp;c-&gt;options) &amp=
;&amp; !dco_check_pull_options(D_PUSH_ERRORS, c-&gt;c2=2Etls_multi))</span>=
<br><span>         {</span><br><span>             msg(D_PUSH_ERRORS, &quot;=
OPTIONS ERROR: pushed options are incompatible &quot;</span><br><span>     =
                           &quot;with data channel offload=2E Use --disable=
-dco to connect to &quot;</span><br><span>@@ -3446,6 +3446,10 @@</span><br>=
<span> </span><br><span>     /* let the TLS engine know if keys have to be =
installed in DCO or not */</span><br><span>     to=2Edco_enabled =3D dco_en=
abled(options);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (to=2Edco_enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        to=
=2Edco_capabilities =3D dco_probe_capabilities();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><span>     =
/*</span><br><span>      * Initialize OpenVPN&#39;s master TLS-mode object=
=2E</span><br><span>diff --git a/src/openvpn/ovpn_dco_linux=2Eh b/src/openv=
pn/ovpn_dco_linux=2Eh</span><br><span>index b3c9ff0=2E=2E28cf97a 100644</sp=
an><br><span>--- a/src/openvpn/ovpn_dco_linux=2Eh</span><br><span>+++ b/src=
/openvpn/ovpn_dco_linux=2Eh</span><br><span>@@ -54,6 +54,7 @@</span><br><sp=
an> 	OVPN_A_PEER_LINK_TX_BYTES,</span><br><span> 	OVPN_A_PEER_LINK_RX_PACKE=
TS,</span><br><span> 	OVPN_A_PEER_LINK_TX_PACKETS,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	OVPN_A_PEER_TX_ID,</span><br><span> </span>=
<br><span> 	__OVPN_A_PEER_MAX,</span><br><span> 	OVPN_A_PEER_MAX =3D (__OVP=
N_A_PEER_MAX - 1)</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/op=
envpn/ssl=2Ec</span><br><span>index 137e340=2E=2E889a9ae 100644</span><br><=
span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</s=
pan><br><span>@@ -1197,9 +1197,10 @@</span><br><span>     tls_session_init(=
multi, &amp;multi-&gt;session[TM_ACTIVE]);</span><br><span>     tls_session=
_init(multi, &amp;multi-&gt;session[TM_INITIAL]);</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!multi-&gt;opt=2Edco_=
enabled)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Calc=
ulate the asymmetric peer-id=2E Leaving it unset is what keeps us from</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * announcing one to=
 the peer, so DCO needs the kernel to support it */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dco_can_asym_peer_id(&amp;multi-&=
gt;opt))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        /* Calculate the asymmetric peer-id */</span><br><span>  =
       if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_ID &amp;&amp; multi-&gt;ses=
sion[TM_INITIAL]=2Eopt-&gt;mode !=3D MODE_SERVER)</span><br><span>         =
{</span><br><span>             multi-&gt;rx_peer_id =3D (uint32_t)(get_rand=
om() % (MAX_PEER_ID - 1));</span><br><span>@@ -1922,9 +1923,16 @@</span><br=
><span> static bool</span><br><span> push_peer_info_peerid(struct buffer *o=
ut, struct tls_multi *multi, struct tls_session *session)</span><br><span> =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (multi-&gt;rx=
_peer_id =3D=3D MAX_PEER_ID || session-&gt;opt-&gt;dco_enabled)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (multi-&gt;rx_peer_id =
=3D=3D MAX_PEER_ID)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        /* No valid peer id or DCO is enabled=2E Canno=
t use this feature */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* No valid peer id */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dco_can_as=
ym_peer_id(session-&gt;opt))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* DCO is in use but the local kernel cannot do asymmetric peer-ids:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * do not annou=
nce our ID so that the peer falls back as well */</span><br><span>         =
return true;</span><br><span>     }</span><br><span> </span><br><span>@@ -2=
361,16 +2369,18 @@</span><br><span>     {</span><br><span>         output_p=
eer_info_env(session-&gt;opt-&gt;es, multi-&gt;peer_info);</span><br><span>=
         uint32_t peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_inf=
o);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (peer_i=
d !=3D MAX_PEER_ID &amp;&amp; !session-&gt;opt-&gt;dco_enabled)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (peer_id !=3D MAX_PE=
ER_ID &amp;&amp; dco_can_asym_peer_id(session-&gt;opt))</span><br><span>   =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
/* set before key_method_2_write() runs, so that a server knows</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+             * whether to annou=
nce its own ID back */</span><br><span>             multi-&gt;tx_peer_id =
=3D peer_id;</span><br><span>             multi-&gt;use_asymmetric_peer_id =
=3D true;</span><br><span>             multi-&gt;use_peer_id =3D true;</spa=
n><br><span>         }</span><br><span>         else</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* Pe=
er has no support for asymmetric peer-id, and DCO currently</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             * can only handle symmet=
ric peer IDs */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        /* the peer announced nothing, or we cannot use asymmetric peer-ids=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * loca=
lly: stay symmetric */</span><br><span>             multi-&gt;tx_peer_id =
=3D multi-&gt;rx_peer_id;</span><br><span>         }</span><br><span>     }=
</span><br><span>diff --git a/src/openvpn/ssl_common=2Eh b/src/openvpn/ssl_=
common=2Eh</span><br><span>index f32d188=2E=2E2c9ad53 100644</span><br><spa=
n>--- a/src/openvpn/ssl_common=2Eh</span><br><span>+++ b/src/openvpn/ssl_co=
mmon=2Eh</span><br><span>@@ -451,9 +451,21 @@</span><br><span>     size_t e=
km_label_size;</span><br><span>     size_t ekm_size;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool dco_enabled; /**&=
lt; Whether keys have to be installed in DCO or not */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool dco_enabled;              /**&l=
t; Whether keys have to be installed in DCO or not */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int dco_capabilities; /**&lt=
; local kernel DCO capability bitmap (DCO_CAP_*) */</span><br><span> };</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Whether asymmetric=
 peer-ids can be used: either DCO is not in the way, or the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * local kernel supports them=2E Wh=
en false we neither generate nor announce an</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * ID, so the remote peer falls back as well=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+dco_can_asym_peer_id(const struct tls_o=
ptions *o)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return !o-&gt;dco_enabl=
ed || (o-&gt;dco_capabilities &amp; DCO_CAP_ASYM_PEER_ID);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> /** @addtogroup control_processor</s=
pan><br><span>  *  @{ */</span><br><span> /** @name Index of key_state obje=
cts within a tls_session structure</span><br><span>diff --git a/src/openvpn=
/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index f13f507=2E=2E6=
cfe408 100644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span=
>+++ b/src/openvpn/ssl_ncp=2Ec</span><br><span>@@ -398,7 +398,7 @@</span><b=
r><span> {</span><br><span>     /* will return 0 if peer_info is null */</s=
pan><br><span>     const unsigned int iv_proto_peer =3D extract_iv_proto(mu=
lti-&gt;peer_info);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const unsigned int tx_peer_id =3D extract_asymmetric_peer_id(multi-&gt;pe=
er_info);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint32=
_t tx_peer_id =3D extract_asymmetric_peer_id(multi-&gt;peer_info);</span><b=
r><span> </span><br><span>     /* The other peer does not support P2P NCP *=
/</span><br><span>     if (!(iv_proto_peer &amp; IV_PROTO_NCP_P2P))</span><=
br><span>@@ -406,6 +406,14 @@</span><br><span>         return;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!dco_can_asym_peer_id(session-&gt;opt))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* We cannot use asymmetric peer-ids locally=
: ignore the announced</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * ID and use the legacy shared peer-id selection below */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        tx_peer_id =3D MA=
X_PEER_ID;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
ulti-&gt;use_asymmetric_peer_id =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     if (iv_proto_peer &amp; IV_PROTO_DATA_V2)</s=
pan><br><span>     {</span><br><span>         multi-&gt;use_peer_id =3D tru=
e;</span><br><span>@@ -436,8 +444,7 @@</span><br><span>     if (multi-&gt;u=
se_peer_id)</span><br><span>     {</span><br><span>         /* The asymmetr=
ic peer-id trumps on the EKM generated ones */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if ((iv_proto_peer &amp; IV_PROTO_TLS_KEY_=
EXPORT)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &a=
mp;&amp; (tx_peer_id !=3D MAX_PEER_ID) &amp;&amp; !multi-&gt;opt=2Edco_enab=
led)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((iv=
_proto_peer &amp; IV_PROTO_TLS_KEY_EXPORT) &amp;&amp; (tx_peer_id !=3D MAX_=
PEER_ID))</span><br><span>         {</span><br><span>             multi-&gt=
;tx_peer_id =3D tx_peer_id;</span><br><span>             multi-&gt;use_asym=
metric_peer_id =3D true;</span><br></pre><p>To view, visit <a href=3D"https=
://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1983?usp=3Demail">change 1983</a>=2E =
To unsubscribe, or for help writing mail filters, visit <a href=3D"https://=
gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemsc=
ope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1983?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D=
"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic5c421=
ec2e9627340924a05509bb8aff0bbf17da </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 1983 </div>
<div style=3D"display:none"> Gerrit-PatchSet:=
 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Gianmarco De Gregori &=
lt;gianmarco@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit=
-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-CC: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div=
>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@l=
ists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Att=
ention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>

</body></ht=
ml>
--5OgsYxL2AJY=--


--===============2744745827834699850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2744745827834699850==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2744745827834699850==--

