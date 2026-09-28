Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB7DCA5FA5
	for <openvpn-devel@archiver.kernel.org>; Mon, 28 Sep 2026 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=XO9GgEu7AyNLbbCzK+p21Sg8wKD31p9RBs9ou2UXgi4=; b=OJDZyR6ev7+9qO
	En89BkDk3cJU/WVBZ/smS4z4MekOLzdP+woKmJxdPneCiYO8suyHmmZ+y+Uyr0Eyh4CAwvJxxLzct
	sXAaSgke71Q4zGkaBagERX6QlnJk1zjwO9GOb959ZauduJ2FTBeKgYVLlSAmd0V1GEIo1bbP9RhKa
	VVQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBDZ5-0007EZ-EV;
	Mon, 28 Sep 2026 15:46:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBDZ3-0007EH-Aw
 for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:46:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DoMxeF7LU2fjWh2NSCU1bUD5URnkEI84spBXF0l8bh0=; b=K37hMizri0sfAmGGuqoitIHllG
 APRBlLZL4Dppw/c0aNFVgUJqvw/bisyzGj32tvG/phg7C7a99ifyUsFOskof4+iElv5+oHqoznxF5
 sg30WRTYuHloeSGji5O2j7vYjCkJpU/5EXhCEumhV9+okxliui+6L8atzu3A6BJzKREU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=DoMxeF7LU2fjWh2NSCU1bUD5URnkEI84spBXF0l8bh0=; b=g
 UFSE6rtOSRjk2alfSHwYPmmfA4SwJ7P32WhBJ4M8bwBslF4D/GsQDFJu39qv6KL6/8tybqefXpS8l
 FN+A1IJhoXlxs9Q24Sy11FQCo6Ed7+Wj5tNZ2QggZ9t8HLN6/1JoxMCE/Hpk1z1Fik/mmZQIMeWr9
 Sfu2oBn9HVqP8XvU=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBDYx-0005uY-Oe for openvpn-devel@lists.sourceforge.net;
 Mon, 28 Sep 2026 15:46:50 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912d37b6so17384095e9.0
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 28 Sep 2026 08:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790610397; x=1791215197; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DoMxeF7LU2fjWh2NSCU1bUD5URnkEI84spBXF0l8bh0=;
 b=CRvqdqXdEeAoNeiD/VXSbnChdv4rkvT0XOP928dx0yQwRMS+P3V1NFsyrg2p0fQ+M/
 IABpITrGO67ne29Oc3KMtHQ8hG2BjJYKyUeoxsQJLWgvQ1sDggSr7RqZSxhGy6PEVIjq
 I4DqFsNr0BGsv6IGcP8Oh03DMA0eaQrhBMygtU6kRPs4xc+lM1+xasDPEJ6ToxeUIXxp
 igHmFRF3AeOMMuqJBqilX4SbCjDo6h0MdB8QRpjqUzidp3HMuFbpe+MuAVmHN6ob7Ls0
 ciNiSduzyig4zMGUnMCQZVZBqCfnFxK1H3XzyMrpet83S3kM6GsjUkb6xfSiUCGLn3Yq
 s5zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790610397; x=1791215197;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DoMxeF7LU2fjWh2NSCU1bUD5URnkEI84spBXF0l8bh0=;
 b=iwdR6KIfbZno9ULmA9tp1U17IEP77OQMs/ueEk7rhNArJDcwnx7BcpqkME9DOtd/Cc
 STS77PeyMEMcixnmb4aoROy+4F7oxq9IMUkf7x/vnCxsVEONCgvmzPPcjBtxNkr9KKDT
 nt1ad1utemFZ32IMh+5wftxTlBkbX1Kt92whm82DgCNcLHvHnFFoZ5fsOBWCxbr4t336
 mEdgrM6JeD/LL8Qu6k6pGPQKv8jf7eIJocI92eoONUqq87XQRFPCWXY/LydbHmjeC7di
 M0qHmizm3Bq9wBOvdYNrt1zygCECA0pK7L1PggxUxZSlyjI9pbcZP1T70oz0WLaOa2Bq
 8opg==
X-Gm-Message-State: AFuF++kH8NsM959MM6HTUDhrUG+PAkO9n1mOwB0VWeoib0/RIsWkolnv
 QlxSqyTeNYjHgxXrBGFZ7kv8KZDjcz6IDL9bZKQqoG35lPOAMWFim290uKbolgcv+//XE5+6n+T
 veXnTSRt8Jdciy7A52V51kCPs+zoNFveFjwZS9+pjvAr5AaS4xwmpCLnB9meGRrgje9KPhwoIh4
 zdZcpV0A==
X-Gm-Gg: AYBFou1CLkSCD/pRiaXhDnb+gZk10ZzRI+a1mn7iacyLp7PMutzVvYQ5ApTwLh07uEN
 H1zrWeR/vrWmtkEgsMYI8l3ZGP1if3SEXvKBhejhjLCFDjhmUyKQ0fgKeq5vx4zkWtN193C+zoC
 yRB9HB6/vCRxONFp7ogqd404cQWMkKimYAO1cECESPdYO/PVp7vnkJ0duMnvnlj18wb+tySALZT
 VxOHOv2tzc6/h8DnstJCAH60l5bRr6K/GDWu2q7pw99kanc1CngPAubTeNH8F1Bv/1pG38v/xS5
 n+a0tkcV/SMl2QbatU8BR4wu8D0yvKEZVNyBC1dsyC/O3daNW/QS6hHkVw2cW1jrmpaNsZ0NT6n
 Ni54WXBWtH6y8ZWRKOz2YU4FJ/2vE5WqkXC4J42Q4T058Bnvodsgg8Lgr8a26xyFntMh8LLCEpx
 bUO+E+pLNzNCQJZGXw7Ppe6wEG6N7WAf6IIEaFOxBViXt8UQpK1WBQg4SRD9QHdA9/GX79UDuhT
 VV9HHL07KetRk9O0ilhgbCGFtE6H63ypidinkkv6tB6z8Xg4lvDLft8e1WWjqMa8ZZexwIh/qFc
 5fc2ylPIrFVNvKUjNOtKpD1dBAXaB24DdiTZFFqLTzj/B+jHcUxh9flKuWbv
X-Received: by 2002:a05:600c:4f12:b0:49f:ce78:356b with SMTP id
 5b1f17b1804b1-49fe6700d0cmr266068265e9.28.1790610396738; 
 Mon, 28 Sep 2026 08:46:36 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00c130538sm10310065e9.4.2026.09.28.08.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:46:36 -0700 (PDT)
X-Google-Original-From: "flichtenheld (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 28 Sep 2026 15:46:35 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3
X-Gerrit-Change-Number: 1958
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1958?usp=email>
X-Gerrit-Commit: 5a689be8103e81f30b85520fee54e40f3fffba28
References: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkkwYjM5ZDZhMGZiMmU2ZGJiNjgzZTk1NTVmMDM2NTM1M2M0ZWRhOGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <9208151360ce3677326d49f028367ab6c7ab47d5-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBDYx-0005uY-Oe
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Fix all occurrences
 of cppcheck invalidPrintfArgType_sint
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
From: "flichtenheld \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: frank@lichtenheld.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net
Cc: "flichtenheld \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============1563168212386872203=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============1563168212386872203==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NTUru9YBHdc="; charset=UTF-8

--NTUru9YBHdc=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1958?usp=3Demail

to review the following change=2E


Chang=
e subject: Fix all occurrences of cppcheck invalidPrintfArgType_sint
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Fix all occurrences=
 of cppcheck invalidPrintfArgType_sint

Mostly trivially correct=2E The onl=
y exception is socklen_t which
can be of various types=2E In Linux it is ui=
nt32_t and in all cases
it should be a small unsigned number=2E So print it=
 as that=2E

Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3
Signed-of=
f-by: Frank Lichtenheld <frank@lichtenheld=2Ecom>
---
M dev-tools/cppcheck-=
suppressions=2Exml
M src/openvpn/crypto=2Ec
M src/openvpn/dco_linux=2Ec
M s=
rc/openvpn/dco_win=2Ec
M src/openvpn/event=2Ec
M src/openvpn/manage=2Ec
M s=
rc/openvpn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/networking_si=
tnl=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options_show=2Ec
M src/open=
vpn/platform=2Ec
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/ope=
nvpn/ssl_ncp=2Ec
15 files changed, 59 insertions(+), 61 deletions(-)



  g=
it pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1958/1

=
diff --git a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-sup=
pressions=2Exml
index c3d81d8=2E=2E12521e1 100644
--- a/dev-tools/cppcheck-=
suppressions=2Exml
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ -9,9 +9,6=
 @@
     <id>constParameterCallback</id>
   </suppress>
   <suppress>
-    =
<id>invalidPrintfArgType_sint</id>
-  </suppress>
-  <suppress>
     <id>in=
validPrintfArgType_uint</id>
   </suppress>
   <suppress>
diff --git a/src/=
openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec
index aee18bc=2E=2E8196c26 1006=
44
--- a/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -261,7 +261=
,7 @@
             if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ct=
x->cipher)))
             {
                 msg(D_CRYPT_ERRORS,
-         =
           "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=
=3D%d wl=3D%d cbs=3D%d",
+                    "ENCRYPT: buffer size error, =
bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u",
                =
     buf->capacity, buf->offset, buf->len, work=2Ecapacity, work=2Eoffset, =
work=2Elen,
                     cipher_ctx_block_size(ctx->cipher));
     =
            goto err;
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/=
dco_linux=2Ec
index b023ade=2E=2E4412ad0 100644
--- a/src/openvpn/dco_linux=
=2Ec
+++ b/src/openvpn/dco_linux=2Ec
@@ -231,7 +231,7 @@
     {
         re=
motestr =3D print_sockaddr(remoteaddr, &gc);
     }
-    msg(D_DCO_DEBUG, "=
%s: peer-id %d, fd %d, remote addr: %s", __func__, peerid, sd, remotestr);
=
+    msg(D_DCO_DEBUG, "%s: peer-id %u, fd %d, remote addr: %s", __func__, p=
eerid, sd, remotestr);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_crea=
te(dco, OVPN_CMD_PEER_NEW);
     struct nlattr *attr =3D nla_nest_start(nl_=
msg, OVPN_A_PEER);
@@ -574,7 +574,7 @@
 int
 dco_swap_keys(dco_context_t *d=
co, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func_=
_, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);
 
  =
   struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_SWAP);=

     if (!nl_msg)
@@ -598,7 +598,7 @@
 int
 dco_del_peer(dco_context_t *dc=
o, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id=
 %d", __func__, peerid);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %=
u", __func__, peerid);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_crea=
te(dco, OVPN_CMD_PEER_DEL);
     if (!nl_msg)
@@ -623,7 +623,7 @@
 dco_del_=
key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
     i=
nt ret =3D -EMSGSIZE;
-    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __fu=
nc__, peerid, slot);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d", __fun=
c__, peerid, slot);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(=
dco, OVPN_CMD_KEY_DEL);
     if (!nl_msg)
@@ -648,7 +648,7 @@
             =
const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decry=
pt_key,
             const uint8_t *decrypt_iv, const char *ciphername, boo=
l epoch)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, ciph=
er %s, epoch %d", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s:=
 slot %d, key-id %d, peer-id %u, cipher %s, epoch %d", __func__, slot, keyi=
d, peerid,
         ciphername, epoch);
 
     const size_t key_len =3D cip=
her_kt_key_size(ciphername);
@@ -701,7 +701,7 @@
 dco_set_peer(dco_context_=
t *dco, unsigned int peerid, int keepalive_interval, int keepalive_timeout,=

              int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive=
 %d/%d, mss %d", __func__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, k=
eepalive %d/%d, mss %d", __func__, peerid,
         keepalive_interval, kee=
palive_timeout, mss);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_creat=
e(dco, OVPN_CMD_PEER_SET);
@@ -968,7 +968,7 @@
     uint32_t ifindex =3D nl=
a_get_u32(attrs[OVPN_A_IFINDEX]);
     if (ifindex !=3D dco->ifindex)
     =
{
-        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex=
 %d", ifindex);
+        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for f=
oreign ifindex %u", ifindex);
         return false;
     }
 
@@ -1010,7 +1=
010,7 @@
     int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);=

     unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
 
-   =
 msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, ifind=
ex: %d, peer-id %u, reason: %d",
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-=
dco: received CMD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reason: %d",
     =
    dco->ifindex, peerid, reason);
     dco->dco_message_peer_id =3D peerid=
;
     dco->dco_del_peer_reason =3D reason;
@@ -1097,7 +1097,7 @@
     int =
key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
     unsigned int =
peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
 
-    msg(D_DCO=
_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-=
id: %d",
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifinde=
x: %u, peer-id %u, key-id: %d",
         dco->ifindex, peer_id, key_id);
  =
   dco->dco_message_peer_id =3D peer_id;
     dco->dco_message_key_id =3D k=
ey_id;
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index=
 e605867=2E=2Ec01a4e5 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvp=
n/dco_win=2Ec
@@ -56,7 +56,7 @@
         {
             break;
         }
-=
        msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
+  =
      msg(D_DCO_DEBUG, "interface %lu not yet ready, retrying", idx);
     =
    Sleep(50);
     }
 }
@@ -409,7 +409,7 @@
              struct sockaddr =
*localaddr, struct sockaddr *remoteaddr,
              const struct in_addr=
 *vpn_ipv4, const struct in6_addr *vpn_ipv6)
 {
-    msg(D_DCO_DEBUG, "%s: =
peer-id %d, fd " SOCKET_PRINTF, __func__, peerid, sd);
+    msg(D_DCO_DEBUG=
, "%s: peer-id %u, fd " SOCKET_PRINTF, __func__, peerid, sd);
 
     if (dc=
o->ifmode =3D=3D DCO_MODE_P2P)
     {
@@ -460,7 +460,7 @@
 int
 dco_del_pee=
r(dco_context_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: pe=
er-id %d", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __fun=
c__, peerid);
 
     OVPN_MP_DEL_PEER del_peer =3D { peerid };
     VOID *b=
uf =3D NULL;
@@ -487,7 +487,7 @@
 dco_set_peer(dco_context_t *dco, unsigned=
 int peerid, int keepalive_interval, int keepalive_timeout,
              i=
nt mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d",=
 __func__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, keepalive %d/%d, =
mss %d", __func__, peerid,
         keepalive_interval, keepalive_timeout, =
mss);
 
     OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, kee=
palive_timeout, mss };
@@ -522,7 +522,7 @@
             const uint8_t *encr=
ypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
           =
  const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-    ms=
g(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __func__, s=
lot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id =
%u, cipher %s", __func__, slot, keyid, peerid,
         ciphername);
 
    =
 const int nonce_len =3D 8;
@@ -575,7 +575,7 @@
 int
 dco_del_key(dco_conte=
xt_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
-    msg(D_DCO, "%s=
: peer-id %d, slot %d called but ignored", __func__, peerid, slot);
+    ms=
g(D_DCO, "%s: peer-id %u, slot %d called but ignored", __func__, peerid, sl=
ot);
     /* FIXME: Implement in driver first */
     return 0;
 }
@@ -583,=
7 +583,7 @@
 int
 dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
 =
{
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+    msg(D_DC=
O_DEBUG, "%s: peer-id %u", __func__, peer_id);
 
     OVPN_MP_SWAP_KEYS swa=
p =3D { peer_id };
     DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;
@@ -667,7 +66=
7,7 @@
     BOOL res =3D GetOverlappedResult(dco->tt->hand, &dco->ov, &byte=
s_read, FALSE);
     if (res)
     {
-        msg(D_DCO_DEBUG, "%s: complet=
ion%s success [%ld]", __func__, queued ? "" : " non-queued",
+        msg(D=
_DCO_DEBUG, "%s: completion%s success [%lu]", __func__, queued ? "" : " non=
-queued",
             bytes_read);
 
         dco->dco_message_peer_id =3D=
 dco->notif_buf=2EPeerId;
@@ -1016,7 +1016,7 @@
         =2EAddr=2EAddr4=2E=
S_un=2ES_addr =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D peer_id, =2EIP=
v6 =3D 0
     };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, =
print_in_addr_t(dst, IA_NET_ORDER, &gc),
+    msg(D_DCO_DEBUG, "%s: %s/%u -=
> peer %u", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc),
         net=
bits, peer_id);
 
     DWORD bytes_returned =3D 0;
@@ -1037,7 +1037,7 @@
 
=
     OVPN_MP_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENetbits =3D net=
bits, =2EPeerId =3D peer_id, =2EIPv6 =3D 1 };
 
-    msg(D_DCO_DEBUG, "%s: =
%s/%d -> peer %d", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc),
+    m=
sg(D_DCO_DEBUG, "%s: %s/%u -> peer %u", __func__, print_in6_addr(dst, IA_NE=
T_ORDER, &gc),
         netbits, peer_id);
 
     DWORD bytes_returned =3D =
0;
@@ -1059,7 +1059,7 @@
         =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =
=2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 0
     };
 
-    msg(=
D_DCO_DEBUG, "%s: %s/%d", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc)=
, netbits);
+    msg(D_DCO_DEBUG, "%s: %s/%u", __func__, print_in_addr_t(ds=
t, IA_NET_ORDER, &gc), netbits);
 
     DWORD bytes_returned =3D 0;
     if=
 (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route, sizeof(=
route), NULL, 0,
@@ -1078,7 +1078,7 @@
 
     OVPN_MP_IROUTE route =3D { =
=2EAddr=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =
=3D 1 };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in6_addr(dst,=
 IA_NET_ORDER, &gc), netbits);
+    msg(D_DCO_DEBUG, "%s: %s/%u", __func__,=
 print_in6_addr(dst, IA_NET_ORDER, &gc), netbits);
 
     DWORD bytes_retur=
ned =3D 0;
     if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUT=
E, &route, sizeof(route), NULL, 0,
diff --git a/src/openvpn/event=2Ec b/src=
/openvpn/event=2Ec
index f1492f8=2E=2E5e17ea1 100644
--- a/src/openvpn/even=
t=2Ec
+++ b/src/openvpn/event=2Ec
@@ -117,7 +117,7 @@
     }
     else
    =
 {
-        msg(M_FATAL, "fatal error in we_set_events: rwflags=3D%d", rwfl=
ags);
+        msg(M_FATAL, "fatal error in we_set_events: rwflags=3D%u", r=
wflags);
     }
 
     wes->esr[i]=2Erwflags =3D rwflags;
@@ -378,7 +378,7 =
@@
                 break;
 
             default:
-                msg(M_F=
ATAL, "fatal error in we_ctl: rwflags=3D%d", rwflags);
+                msg=
(M_FATAL, "fatal error in we_ctl: rwflags=3D%u", rwflags);
         }
     =
}
     return;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec=

index b7913bd=2E=2E2f1ca95 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/o=
penvpn/manage=2Ec
@@ -1502,7 +1502,7 @@
     }
     else if (streq(p[0], "p=
id"))
     {
-        msg(M_CLIENT, "SUCCESS: pid=3D%d", platform_getpid())=
;
+        msg(M_CLIENT, "SUCCESS: pid=3D%u", platform_getpid());
     }
  =
   else if (streq(p[0], "nclients"))
     {
diff --git a/src/openvpn/multi=
=2Ec b/src/openvpn/multi=2Ec
index c571c26=2E=2Eb6c428c 100644
--- a/src/op=
envpn/multi=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -164,7 +164,7 @@
     struct=
 hash_iterator hi;
     struct hash_element *he;
 
-    dmsg(D_MULTI_DEBUG,=
 "MULTI: REAP range %d -> %d", start_bucket, end_bucket);
+    dmsg(D_MULTI=
_DEBUG, "MULTI: REAP range %u -> %u", start_bucket, end_bucket);
     hash_=
iterator_init_range(m->vhash, &hi, start_bucket, end_bucket);
     while ((=
he =3D hash_iterator_next(&hi)) !=3D NULL)
     {
@@ -271,7 +271,7 @@
     =
struct multi_context *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
- =
   msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d", t->options=
=2Ereal_hash_size,
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%u =
v=3D%u", t->options=2Ereal_hash_size,
         t->options=2Evirtual_hash_si=
ze);
 
     /*
@@ -430,7 +430,7 @@
         if (mi->context=2Ec2=2Etls_mult=
i && check_debug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->contex=
t=2Eoptions))
         {
-            buf_printf(&out, " rx-peer-id=3D%d", =
mi->context=2Ec2=2Etls_multi->rx_peer_id);
+            buf_printf(&out, " =
rx-peer-id=3D%u", mi->context=2Ec2=2Etls_multi->rx_peer_id);
         }
   =
      return BSTR(&out);
     }
@@ -730,7 +730,7 @@
     if (hash_n_element=
s(m->hash) >=3D m->max_clients)
     {
         msg(D_MULTI_ERRORS,
-      =
      "MULTI: new incoming connection would exceed maximum number of client=
s (%d)",
+            "MULTI: new incoming connection would exceed maximum =
number of clients (%u)",
             m->max_clients);
         goto err;
 =
    }
@@ -991,7 +991,7 @@
 #ifdef ENABLE_ASYNC_PUSH
     if (m->inotify_wat=
chers)
     {
-        msg(D_MULTI_DEBUG, "inotify watchers count: %d", has=
h_n_elements(m->inotify_watchers));
+        msg(D_MULTI_DEBUG, "inotify wa=
tchers count: %u", hash_n_elements(m->inotify_watchers));
     }
 #endif
 }=

@@ -1295,7 +1295,7 @@
         }
         for (ir6 =3D mi->context=2Eoptio=
ns=2Eiroutes_ipv6; ir6 !=3D NULL; ir6 =3D ir6->next)
         {
-          =
  msg(D_MULTI_LOW, "MULTI: internal route %s/%d -> %s",
+            msg(D_=
MULTI_LOW, "MULTI: internal route %s/%u -> %s",
                 print_in6_=
addr(ir6->network, 0, &gc), ir6->netbits,
                 multi_instance_s=
tring(mi, false, &gc));
 
diff --git a/src/openvpn/multi_io=2Ec b/src/openv=
pn/multi_io=2Ec
index 31084cb=2E=2E4d9d7fb 100644
--- a/src/openvpn/multi_i=
o=2Ec
+++ b/src/openvpn/multi_io=2Ec
@@ -439,7 +439,7 @@
         default:
=
         {
             struct gc_arena gc =3D gc_new();
-            msg(M=
_FATAL, "MULTI IO: multi_io_post bad state, mi=3D%s flags=3D%d",
+         =
   msg(M_FATAL, "MULTI IO: multi_io_post bad state, mi=3D%s flags=3D%u",
  =
               multi_instance_string(mi, false, &gc), flags);
             =
gc_free(&gc);
             break;
diff --git a/src/openvpn/networking_sitnl=
=2Ec b/src/openvpn/networking_sitnl=2Ec
index 13e0f0b=2E=2Ebb29781 100644
-=
-- a/src/openvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2E=
c
@@ -222,7 +222,7 @@
 
     if (addr_len !=3D sizeof(local))
     {
-     =
   msg(M_WARN, "%s: wrong address length %d", __func__, addr_len);
+       =
 msg(M_WARN, "%s: wrong address length %u", __func__, (unsigned int)addr_le=
n);
         return -EINVAL;
     }
 
@@ -528,7 +528,7 @@
 
     if (!if_in=
dextoname(ifindex, res->iface))
     {
-        msg(M_WARN | M_ERRNO, "%s: =
rtnl: can't get ifname for index %d", __func__, ifindex);
+        msg(M_WA=
RN | M_ERRNO, "%s: rtnl: can't get ifname for index %u", __func__, ifindex)=
;
         return -1;
     }
 
@@ -1216,7 +1216,7 @@
         gw_ptr =3D &g=
w_be;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %=
d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d=
", __func__,
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str))=
, prefixlen,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), n=
p(iface), table, metric);
 
@@ -1242,7 +1242,7 @@
         gw_v6=2Eipv6 =3D=
 *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %=
d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d=
", __func__,
         inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeof(d=
st_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str, si=
zeof(gw_str)), np(iface), table, metric);
 
@@ -1293,7 +1293,7 @@
         =
gw_v4=2Eipv4 =3D htonl(*gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s d=
ev %s table %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s de=
v %s table %u metric %d", __func__,
         inet_ntop(AF_INET, &dst_v4=2Ei=
pv4, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_=
v4=2Eipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1319,7=
 +1319,7 @@
         gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s: =
%s/%d via %s dev %s table %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %=
s/%d via %s dev %s table %u metric %d", __func__,
         inet_ntop(AF_INE=
T6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_nto=
p(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metri=
c);
 
diff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index =
daa52b7=2E=2E95e93da 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn=
/options=2Ec
@@ -4549,7 +4549,7 @@
         {
             if (netbits < 64=
 || netbits > 124)
             {
-                msg(msglevel, "ifconfig-=
ipv6: /netbits must be between 64 and 124, not '/%d'",
+                msg=
(msglevel, "ifconfig-ipv6: /netbits must be between 64 and 124, not '/%u'",=

                     netbits);
                 goto err;
             }
@=
@ -5827,7 +5827,7 @@
         }
         if (netbits < 64 || netbits > 124)=

         {
-            msg(msglevel, "--server-ipv6 settings: network mus=
t be between /64 and /124 (not /%d)",
+            msg(msglevel, "--server-=
ipv6 settings: network must be between /64 and /124 (not /%u)",
           =
      netbits);
 
             goto err;
@@ -5940,7 +5940,7 @@
         if =
(netbits < 64 || netbits > 124)
         {
             msg(msglevel,
-    =
            "--ifconfig-ipv6-pool settings: network must be between /64 and=
 /124 (not /%d)",
+                "--ifconfig-ipv6-pool settings: network =
must be between /64 and /124 (not /%u)",
                 netbits);
       =
      goto err;
         }
diff --git a/src/openvpn/options_show=2Ec b/src/=
openvpn/options_show=2Ec
index ff090774=2E=2E80d36f0 100644
--- a/src/openv=
pn/options_show=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -136,7 +136,7 @@
=
     msg(D_SHOW_PARMS, "  server_network =3D %s", print_in_addr_t(o->server=
_network, 0, &gc));
     msg(D_SHOW_PARMS, "  server_netmask =3D %s", print=
_in_addr_t(o->server_netmask, 0, &gc));
     msg(D_SHOW_PARMS, "  server_ne=
twork_ipv6 =3D %s", print_in6_addr(o->server_network_ipv6, 0, &gc));
-    S=
HOW_INT(server_netbits_ipv6);
+    SHOW_UINT(server_netbits_ipv6);
     msg=
(D_SHOW_PARMS, "  server_bridge_ip =3D %s", print_in_addr_t(o->server_bridg=
e_ip, 0, &gc));
     msg(D_SHOW_PARMS, "  server_bridge_netmask =3D %s",
  =
       print_in_addr_t(o->server_bridge_netmask, 0, &gc));
@@ -170,8 +170,8=
 @@
     SHOW_INT(ifconfig_ipv6_pool_netbits);
     SHOW_INT(n_bcast_buf);
=
     SHOW_INT(tcp_queue_limit);
-    SHOW_INT(real_hash_size);
-    SHOW_IN=
T(virtual_hash_size);
+    SHOW_UINT(real_hash_size);
+    SHOW_UINT(virtua=
l_hash_size);
     SHOW_STR(client_connect_script);
     SHOW_STR(learn_add=
ress_script);
     SHOW_STR(client_disconnect_script);
@@ -444,10 +444,10 @=
@
 #if defined(TARGET_LINUX)
     SHOW_INT(mark);
 #endif
-    SHOW_INT(soc=
kflags);
+    SHOW_UINT(sockflags);
 
     SHOW_INT(comp=2Ealg);
-    SHOW_=
INT(comp=2Eflags);
+    SHOW_UINT(comp=2Eflags);
 
     SHOW_STR(route_scri=
pt);
     SHOW_STR(route_default_gateway);
@@ -482,7 +482,7 @@
     SHOW_IN=
T(management_echo_buffer_size);
     SHOW_STR(management_client_user);
    =
 SHOW_STR(management_client_group);
-    SHOW_INT(management_flags);
+    S=
HOW_UINT(management_flags);
 #endif
 #ifdef ENABLE_PLUGIN
     if (o->plugi=
n_list)
@@ -547,7 +547,7 @@
         int i;
         for (i =3D 0; i < MAX_=
PARMS; i++)
         {
-            SHOW_INT(remote_cert_ku[i]);
+         =
   SHOW_UINT(remote_cert_ku[i]);
         }
     }
     SHOW_STR(remote_cer=
t_eku);
@@ -567,7 +567,7 @@
         }
         gc_free(&gc);
     }
-    S=
HOW_INT(ssl_flags);
+    SHOW_UINT(ssl_flags);
 
     SHOW_INT(tls_timeout)=
;
 
diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec
index =
6c766c2=2E=2Eab581f4 100644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvp=
n/platform=2Ec
@@ -580,7 +580,7 @@
         }
     }
 
-    msg(M_WARN, "Fa=
iled to create temporary file after %i attempts", attempts);
+    msg(M_WAR=
N, "Failed to create temporary file after %u attempts", attempts);
     ret=
urn NULL;
 }
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
i=
ndex 8b85eac=2E=2E469edb3 100644
--- a/src/openvpn/route=2Ec
+++ b/src/open=
vpn/route=2Ec
@@ -823,7 +823,7 @@
                 {
                     n=
eed_remote_ipv6_route =3D true;
                     msg(D_ROUTE,
-        =
                "ROUTE6: %s/%d overlaps IPv6 remote %s, adding host route t=
o VPN endpoint",
+                        "ROUTE6: %s/%u overlaps IPv6 remo=
te %s, adding host route to VPN endpoint",
                         print_i=
n6_addr(r6->network, 0, &gc), r6->netbits,
                         print_i=
n6_addr(*remote_host_ipv6, 0, &gc));
                 }
@@ -1355,7 +1355,7 =
@@
         struct buffer name2 =3D alloc_buf_gc(256, &gc);
 
         buf_=
printf(&name1, "route_ipv6_network_%d", i);
-        buf_printf(&val, "%s/%=
d", print_in6_addr(r6->network, 0, &gc), r6->netbits);
+        buf_printf(=
&val, "%s/%u", print_in6_addr(r6->network, 0, &gc), r6->netbits);
         =
setenv_str(es, BSTR(&name1), BSTR(&val));
 
         buf_printf(&name2, "ro=
ute_ipv6_gateway_%d", i);
@@ -1803,10 +1803,10 @@
 #endif
 
 #ifndef _WIN32=

-    msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) dev %s", network,=
 r6->netbits, gateway,
+    msg(D_ROUTE, "add_route_ipv6(%s/%u -> %s metric=
 %d) dev %s", network, r6->netbits, gateway,
         r6->metric, device);
=
 #else
-    msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) IF %lu", ne=
twork, r6->netbits, gateway,
+    msg(D_ROUTE, "add_route_ipv6(%s/%u -> %s =
metric %d) IF %lu", network, r6->netbits, gateway,
         r6->metric, r6-=
>adapter_index ? r6->adapter_index : tt->adapter_index);
 #endif
 
@@ -1832=
,7 +1832,7 @@
             "ROUTE6 WARNING: " PACKAGE_NAME " needs a gatewa=
y "
             "parameter for a --route-ipv6 option and no default was se=
t via "
             "--ifconfig-ipv6 or --route-ipv6-gateway option=2E  No=
t installing "
-            "IPv6 route to %s/%d=2E",
+            "IPv6 ro=
ute to %s/%u=2E",
             network, r6->netbits);
         status =3D 0=
;
         goto done;
@@ -2222,7 +2222,7 @@
     }
 #endif
 
-    msg(D_ROU=
TE, "delete_route_ipv6(%s/%d)", network, r6->netbits);
+    msg(D_ROUTE, "d=
elete_route_ipv6(%s/%u)", network, r6->netbits);
 
 #if defined(TARGET_LINU=
X)
     int metric =3D -1;
diff --git a/src/openvpn/socket=2Ec b/src/openvp=
n/socket=2Ec
index c893c9b=2E=2Edf8e400 100644
--- a/src/openvpn/socket=2Ec=

+++ b/src/openvpn/socket=2Ec
@@ -831,7 +831,8 @@
     else if (remote_len_=
af && remote_len !=3D remote_len_af)
     {
         msg(D_LINK_ERRORS,
-  =
          "TCP: Received strange incoming connection with unknown address l=
ength=3D%d", remote_len);
+            "TCP: Received strange incoming conn=
ection with unknown address length=3D%u",
+            (unsigned int)remote=
_len);
         openvpn_close_socket(new_sd);
         new_sd =3D SOCKET_UN=
DEFINED;
     }
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=
=2Ec
index 8b0f28d=2E=2Ef13f507 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/=
src/openvpn/ssl_ncp=2Ec
@@ -508,7 +508,7 @@
     }
 
     msg(D_TLS_DEBUG_L=
OW, "P2P mode NCP negotiation result: "
-                         "TLS_expo=
rt=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%=
s",
+                         "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %u=
, tx-peer-id %u, epoch=3D%d, cipher=3D%s",
         (bool)(session->opt->cr=
ypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
         multi->use_peer_id,
=
         multi->rx_peer_id,

-- 
To view, visit http://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1958?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Mes=
sageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Ch=
ange-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3
Gerrit-Change-Number: 19=
58
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@lichtenheld=2Ecom>
=
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-=
devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>

--NTUru9YBHdc=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>flichtenheld would like plaistho=
s to <strong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1958?usp=3Demail">View Change</a></p><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">Fix all occurrences of cppcheck invalidPrintfArgType_sint<br><br>Mostl=
y trivially correct=2E The only exception is socklen_t which<br>can be of v=
arious types=2E In Linux it is uint32_t and in all cases<br>it should be a =
small unsigned number=2E So print it as that=2E<br><br>Change-Id: I0b39d6a0=
fb2e6dbb683e9555f0365353c4eda8d3<br>Signed-off-by: Frank Lichtenheld &lt;fr=
ank@lichtenheld=2Ecom&gt;<br>---<br>M dev-tools/cppcheck-suppressions=2Exml=
<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M src/openvp=
n/dco_win=2Ec<br>M src/openvpn/event=2Ec<br>M src/openvpn/manage=2Ec<br>M s=
rc/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/network=
ing_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options_show=2E=
c<br>M src/openvpn/platform=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn=
/socket=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>15 files changed, 59 insertions=
(+), 61 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eope=
nvpn=2Enet:29418/openvpn refs/changes/58/1958/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-to=
ols/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</sp=
an><br><span>index c3d81d8=2E=2E12521e1 100644</span><br><span>--- a/dev-to=
ols/cppcheck-suppressions=2Exml</span><br><span>+++ b/dev-tools/cppcheck-su=
ppressions=2Exml</span><br><span>@@ -9,9 +9,6 @@</span><br><span>     &lt;i=
d&gt;constParameterCallback&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;=
</span><br><span>   &lt;suppress&gt;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &lt;id&gt;invalidPrintfArgType_sint&lt;/id&gt;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&gt;</span><br><spa=
n>     &lt;id&gt;invalidPrintfArgType_uint&lt;/id&gt;</span><br><span>   &l=
t;/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>diff --=
git a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index=
 aee18bc=2E=2E8196c26 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</=
span><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -261,7 +261,=
7 @@</span><br><span>             if (!buf_safe(&amp;work, buf-&gt;len + ci=
pher_ctx_block_size(ctx-&gt;cipher)))</span><br><span>             {</span>=
<br><span>                 msg(D_CRYPT_ERRORS,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    &quot;ENCRYPT: buffer size err=
or, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%d&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;E=
NCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d =
cbs=3D%u&quot;,</span><br><span>                     buf-&gt;capacity, buf-=
&gt;offset, buf-&gt;len, work=2Ecapacity, work=2Eoffset, work=2Elen,</span>=
<br><span>                     cipher_ctx_block_size(ctx-&gt;cipher));</spa=
n><br><span>                 goto err;</span><br><span>diff --git a/src/ope=
nvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index b023ad=
e=2E=2E4412ad0 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span=
><br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -231,7 +231,7=
 @@</span><br><span>     {</span><br><span>         remotestr =3D print_soc=
kaddr(remoteaddr, &amp;gc);</span><br><span>     }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd =
%d, remote addr: %s&quot;, __func__, peerid, sd, remotestr);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: pee=
r-id %u, fd %d, remote addr: %s&quot;, __func__, peerid, sd, remotestr);</s=
pan><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlm=
sg_create(dco, OVPN_CMD_PEER_NEW);</span><br><span>     struct nlattr *attr=
 =3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span>@@ -574,7 +574,7 =
@@</span><br><span> int</span><br><span> dco_swap_keys(dco_context_t *dco, =
unsigned int peerid)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__=
, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peerid);</span><br><span>=
 </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco,=
 OVPN_CMD_KEY_SWAP);</span><br><span>     if (!nl_msg)</span><br><span>@@ -=
598,7 +598,7 @@</span><br><span> int</span><br><span> dco_del_peer(dco_cont=
ext_t *dco, unsigned int peerid)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s=
: peer-id %d&quot;, __func__, peerid);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %u&=
quot;, __func__, peerid);</span><br><span> </span><br><span>     struct nl_=
msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL);</span><br><s=
pan>     if (!nl_msg)</span><br><span>@@ -623,7 +623,7 @@</span><br><span> =
dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)</=
span><br><span> {</span><br><span>     int ret =3D -EMSGSIZE;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer=
-id %d, slot %d&quot;, __func__, peerid, slot);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, slot=
 %d&quot;, __func__, peerid, slot);</span><br><span> </span><br><span>     =
struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_DEL);</sp=
an><br><span>     if (!nl_msg)</span><br><span>@@ -648,7 +648,7 @@</span><b=
r><span>             const uint8_t *encrypt_key, const uint8_t *encrypt_iv,=
 const uint8_t *decrypt_key,</span><br><span>             const uint8_t *de=
crypt_iv, const char *ciphername, bool epoch)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: s=
lot %d, key-id %d, peer-id %d, cipher %s, epoch %d&quot;, __func__, slot, k=
eyid, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms=
g(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %=
d&quot;, __func__, slot, keyid, peerid,</span><br><span>         ciphername=
, epoch);</span><br><span> </span><br><span>     const size_t key_len =3D c=
ipher_kt_key_size(ciphername);</span><br><span>@@ -701,7 +701,7 @@</span><b=
r><span> dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepaliv=
e_interval, int keepalive_timeout,</span><br><span>              int mss)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
msg(D_DCO_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __fun=
c__, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_DCO_DEBUG, &quot;%s: peer-id %u, keepalive %d/%d, mss %d&quot;, __func__=
, peerid,</span><br><span>         keepalive_interval, keepalive_timeout, m=
ss);</span><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_=
dco_nlmsg_create(dco, OVPN_CMD_PEER_SET);</span><br><span>@@ -968,7 +968,7 =
@@</span><br><span>     uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFIND=
EX]);</span><br><span>     if (ifindex !=3D dco-&gt;ifindex)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D=
_DCO_DEBUG, &quot;ovpn-dco: ignoring message for foreign ifindex %d&quot;, =
ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_DCO_DEBUG, &quot;ovpn-dco: ignoring message for foreign ifindex %u&quot=
;, ifindex);</span><br><span>         return false;</span><br><span>     }<=
/span><br><span> </span><br><span>@@ -1010,7 +1010,7 @@</span><br><span>   =
  int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><=
span>     unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco: received CMD_PEER_DEL_NTF, ifi=
ndex: %d, peer-id %u, reason: %d&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco: rece=
ived CMD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reason: %d&quot;,</span><br=
><span>         dco-&gt;ifindex, peerid, reason);</span><br><span>     dco-=
&gt;dco_message_peer_id =3D peerid;</span><br><span>     dco-&gt;dco_del_pe=
er_reason =3D reason;</span><br><span>@@ -1097,7 +1097,7 @@</span><br><span=
>     int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);</span><b=
r><span>     unsigned int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_P=
EER_ID]);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_NTF, ifind=
ex: %d, peer-id %u, key-id: %d&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWA=
P_NTF, ifindex: %u, peer-id %u, key-id: %d&quot;,</span><br><span>         =
dco-&gt;ifindex, peer_id, key_id);</span><br><span>     dco-&gt;dco_message=
_peer_id =3D peer_id;</span><br><span>     dco-&gt;dco_message_key_id =3D k=
ey_id;</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/d=
co_win=2Ec</span><br><span>index e605867=2E=2Ec01a4e5 100644</span><br><spa=
n>--- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=
=2Ec</span><br><span>@@ -56,7 +56,7 @@</span><br><span>         {</span><br=
><span>             break;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;interface %l=
d not yet ready, retrying&quot;, idx);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;interface %lu not yet rea=
dy, retrying&quot;, idx);</span><br><span>         Sleep(50);</span><br><sp=
an>     }</span><br><span> }</span><br><span>@@ -409,7 +409,7 @@</span><br>=
<span>              struct sockaddr *localaddr, struct sockaddr *remoteaddr=
,</span><br><span>              const struct in_addr *vpn_ipv4, const struc=
t in6_addr *vpn_ipv6)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd &quot; SOC=
KET_PRINTF, __func__, peerid, sd);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd &quot; SOCKET_=
PRINTF, __func__, peerid, sd);</span><br><span> </span><br><span>     if (d=
co-&gt;ifmode =3D=3D DCO_MODE_P2P)</span><br><span>     {</span><br><span>@=
@ -460,7 +460,7 @@</span><br><span> int</span><br><span> dco_del_peer(dco_c=
ontext_t *dco, unsigned int peerid)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&=
quot;, __func__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peerid);</=
span><br><span> </span><br><span>     OVPN_MP_DEL_PEER del_peer =3D { peeri=
d };</span><br><span>     VOID *buf =3D NULL;</span><br><span>@@ -487,7 +48=
7,7 @@</span><br><span> dco_set_peer(dco_context_t *dco, unsigned int peeri=
d, int keepalive_interval, int keepalive_timeout,</span><br><span>         =
     int mss)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss =
%d&quot;, __func__, peerid,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, keepalive %d/%d, mss %d&=
quot;, __func__, peerid,</span><br><span>         keepalive_interval, keepa=
live_timeout, mss);</span><br><span> </span><br><span>     OVPN_MP_SET_PEER=
 mp_peer =3D { peerid, keepalive_interval, keepalive_timeout, mss };</span>=
<br><span>@@ -522,7 +522,7 @@</span><br><span>             const uint8_t *e=
ncrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><b=
r><span>             const uint8_t *decrypt_iv, const char *ciphername, boo=
l epoch)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher=
 %s&quot;, __func__, slot, keyid, peerid,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, pe=
er-id %u, cipher %s&quot;, __func__, slot, keyid, peerid,</span><br><span> =
        ciphername);</span><br><span> </span><br><span>     const int nonce=
_len =3D 8;</span><br><span>@@ -575,7 +575,7 @@</span><br><span> int</span>=
<br><span> dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slo=
t_t slot)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    msg(D_DCO, &quot;%s: peer-id %d, slot %d called but ignored&quot=
;, __func__, peerid, slot);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_DCO, &quot;%s: peer-id %u, slot %d called but ignored&quo=
t;, __func__, peerid, slot);</span><br><span>     /* FIXME: Implement in dr=
iver first */</span><br><span>     return 0;</span><br><span> }</span><br><=
span>@@ -583,7 +583,7 @@</span><br><span> int</span><br><span> dco_swap_key=
s(dco_context_t *dco, unsigned int peer_id)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: pee=
r-id %d&quot;, __func__, peer_id);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, p=
eer_id);</span><br><span> </span><br><span>     OVPN_MP_SWAP_KEYS swap =3D =
{ peer_id };</span><br><span>     DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;</sp=
an><br><span>@@ -667,7 +667,7 @@</span><br><span>     BOOL res =3D GetOverl=
appedResult(dco-&gt;tt-&gt;hand, &amp;dco-&gt;ov, &amp;bytes_read, FALSE);<=
/span><br><span>     if (res)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s: completi=
on%s success [%ld]&quot;, __func__, queued ? &quot;&quot; : &quot; non-queu=
ed&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ms=
g(D_DCO_DEBUG, &quot;%s: completion%s success [%lu]&quot;, __func__, queued=
 ? &quot;&quot; : &quot; non-queued&quot;,</span><br><span>             byt=
es_read);</span><br><span> </span><br><span>         dco-&gt;dco_message_pe=
er_id =3D dco-&gt;notif_buf=2EPeerId;</span><br><span>@@ -1016,7 +1016,7 @@=
</span><br><span>         =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbi=
ts =3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D 0</span><br><span>     }=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(D_DCO_DEBUG, &quot;%s: %s/%d -&gt; peer %d&quot;, __func__, print_in_=
addr_t(dst, IA_NET_ORDER, &amp;gc),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%u -&gt; peer %u&quot;, _=
_func__, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc),</span><br><span>     =
    netbits, peer_id);</span><br><span> </span><br><span>     DWORD bytes_r=
eturned =3D 0;</span><br><span>@@ -1037,7 +1037,7 @@</span><br><span> </spa=
n><br><span>     OVPN_MP_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENet=
bits =3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D 1 };</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, =
&quot;%s: %s/%d -&gt; peer %d&quot;, __func__, print_in6_addr(dst, IA_NET_O=
RDER, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(D_DCO_DEBUG, &quot;%s: %s/%u -&gt; peer %u&quot;, __func__, print_in6_a=
ddr(dst, IA_NET_ORDER, &amp;gc),</span><br><span>         netbits, peer_id)=
;</span><br><span> </span><br><span>     DWORD bytes_returned =3D 0;</span>=
<br><span>@@ -1059,7 +1059,7 @@</span><br><span>         =2EAddr=2EAddr4=2E=
S_un=2ES_addr =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =
=3D 0</span><br><span>     };</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: %s/%d&quot;, __fun=
c__, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc), netbits);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%=
u&quot;, __func__, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc), netbits);</=
span><br><span> </span><br><span>     DWORD bytes_returned =3D 0;</span><br=
><span>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IRO=
UTE, &amp;route, sizeof(route), NULL, 0,</span><br><span>@@ -1078,7 +1078,7=
 @@</span><br><span> </span><br><span>     OVPN_MP_IROUTE route =3D { =2EAd=
dr=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 1=
 };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    msg(D_DCO_DEBUG, &quot;%s: %s/%d&quot;, __func__, print_in6_addr(dst, I=
A_NET_ORDER, &amp;gc), netbits);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%u&quot;, __func__, print_in=
6_addr(dst, IA_NET_ORDER, &amp;gc), netbits);</span><br><span> </span><br><=
span>     DWORD bytes_returned =3D 0;</span><br><span>     if (!DeviceIoCon=
trol(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IROUTE, &amp;route, sizeof(rout=
e), NULL, 0,</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openv=
pn/event=2Ec</span><br><span>index f1492f8=2E=2E5e17ea1 100644</span><br><s=
pan>--- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec=
</span><br><span>@@ -117,7 +117,7 @@</span><br><span>     }</span><br><span=
>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(M_FATAL, &quot;fatal error in we_set_events: rwflag=
s=3D%d&quot;, rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_FATAL, &quot;fatal error in we_set_events: rwflags=3D%u&q=
uot;, rwflags);</span><br><span>     }</span><br><span> </span><br><span>  =
   wes-&gt;esr[i]=2Erwflags =3D rwflags;</span><br><span>@@ -378,7 +378,7 @=
@</span><br><span>                 break;</span><br><span> </span><br><span=
>             default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                msg(M_FATAL, &quot;fatal error in we_ctl: rwflags=3D%d&quo=
t;, rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msg(M_FATAL, &quot;fatal error in we_ctl: rwflags=3D%u&quot;, rwf=
lags);</span><br><span>         }</span><br><span>     }</span><br><span>  =
   return;</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvp=
n/manage=2Ec</span><br><span>index b7913bd=2E=2E2f1ca95 100644</span><br><s=
pan>--- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=
=2Ec</span><br><span>@@ -1502,7 +1502,7 @@</span><br><span>     }</span><br=
><span>     else if (streq(p[0], &quot;pid&quot;))</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_CLIENT, &=
quot;SUCCESS: pid=3D%d&quot;, platform_getpid());</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;SUCCESS: pid=3D%u=
&quot;, platform_getpid());</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;nclients&quot;))</span><br><span>     {</span><br><=
span>diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><=
span>index c571c26=2E=2Eb6c428c 100644</span><br><span>--- a/src/openvpn/mu=
lti=2Ec</span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -164=
,7 +164,7 @@</span><br><span>     struct hash_iterator hi;</span><br><span>=
     struct hash_element *he;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI: REAP range %=
d -&gt; %d&quot;, start_bucket, end_bucket);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    dmsg(D_MULTI_DEBUG, &quot;MULTI: REAP range %u=
 -&gt; %u&quot;, start_bucket, end_bucket);</span><br><span>     hash_itera=
tor_init_range(m-&gt;vhash, &amp;hi, start_bucket, end_bucket);</span><br><=
span>     while ((he =3D hash_iterator_next(&amp;hi)) !=3D NULL)</span><br>=
<span>     {</span><br><span>@@ -271,7 +271,7 @@</span><br><span>     struc=
t multi_context *m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TY=
PE_UNDEF;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d&qu=
ot;, t-&gt;options=2Ereal_hash_size,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%=
u v=3D%u&quot;, t-&gt;options=2Ereal_hash_size,</span><br><span>         t-=
&gt;options=2Evirtual_hash_size);</span><br><span> </span><br><span>     /*=
</span><br><span>@@ -430,7 +430,7 @@</span><br><span>         if (mi-&gt;co=
ntext=2Ec2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br>=
<span>             &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;c=
ontext=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            buf_printf(&amp;out, &quot; rx-peer-id=3D%=
u&quot;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span> =
        }</span><br><span>         return BSTR(&amp;out);</span><br><span> =
    }</span><br><span>@@ -730,7 +730,7 @@</span><br><span>     if (hash_n_e=
lements(m-&gt;hash) &gt;=3D m-&gt;max_clients)</span><br><span>     {</span=
><br><span>         msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            &quot;MULTI: new incoming connection would ex=
ceed maximum number of clients (%d)&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;MULTI: new incoming connection wou=
ld exceed maximum number of clients (%u)&quot;,</span><br><span>           =
  m-&gt;max_clients);</span><br><span>         goto err;</span><br><span>  =
   }</span><br><span>@@ -991,7 +991,7 @@</span><br><span> #ifdef ENABLE_ASY=
NC_PUSH</span><br><span>     if (m-&gt;inotify_watchers)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MUL=
TI_DEBUG, &quot;inotify watchers count: %d&quot;, hash_n_elements(m-&gt;ino=
tify_watchers));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(D_MULTI_DEBUG, &quot;inotify watchers count: %u&quot;, hash_n_elem=
ents(m-&gt;inotify_watchers));</span><br><span>     }</span><br><span> #end=
if</span><br><span> }</span><br><span>@@ -1295,7 +1295,7 @@</span><br><span=
>         }</span><br><span>         for (ir6 =3D mi-&gt;context=2Eoptions=
=2Eiroutes_ipv6; ir6 !=3D NULL; ir6 =3D ir6-&gt;next)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(=
D_MULTI_LOW, &quot;MULTI: internal route %s/%d -&gt; %s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_LOW, &qu=
ot;MULTI: internal route %s/%u -&gt; %s&quot;,</span><br><span>            =
     print_in6_addr(ir6-&gt;network, 0, &amp;gc), ir6-&gt;netbits,</span><b=
r><span>                 multi_instance_string(mi, false, &amp;gc));</span>=
<br><span> </span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/ope=
nvpn/multi_io=2Ec</span><br><span>index 31084cb=2E=2E4d9d7fb 100644</span><=
br><span>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/m=
ulti_io=2Ec</span><br><span>@@ -439,7 +439,7 @@</span><br><span>         de=
fault:</span><br><span>         {</span><br><span>             struct gc_ar=
ena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           msg(M_FATAL, &quot;MULTI IO: multi_io_post bad state, mi=3D%s fl=
ags=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(M_FATAL, &quot;MULTI IO: multi_io_post bad state, mi=3D%s flags=
=3D%u&quot;,</span><br><span>                 multi_instance_string(mi, fal=
se, &amp;gc), flags);</span><br><span>             gc_free(&amp;gc);</span>=
<br><span>             break;</span><br><span>diff --git a/src/openvpn/netw=
orking_sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index 1=
3e0f0b=2E=2Ebb29781 100644</span><br><span>--- a/src/openvpn/networking_sit=
nl=2Ec</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><sp=
an>@@ -222,7 +222,7 @@</span><br><span> </span><br><span>     if (addr_len =
!=3D sizeof(local))</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        msg(M_WARN, &quot;%s: wrong address length %d&=
quot;, __func__, addr_len);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        msg(M_WARN, &quot;%s: wrong address length %u&quot;, __func=
__, (unsigned int)addr_len);</span><br><span>         return -EINVAL;</span=
><br><span>     }</span><br><span> </span><br><span>@@ -528,7 +528,7 @@</sp=
an><br><span> </span><br><span>     if (!if_indextoname(ifindex, res-&gt;if=
ace))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifname f=
or index %d&quot;, __func__, ifindex);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t =
get ifname for index %u&quot;, __func__, ifindex);</span><br><span>        =
 return -1;</span><br><span>     }</span><br><span> </span><br><span>@@ -12=
16,7 +1216,7 @@</span><br><span>         gw_ptr =3D &amp;gw_be;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&q=
uot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func=
__,</span><br><span>         inet_ntop(AF_INET, &amp;dst_be, dst_str, sizeo=
f(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw=
_be, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><span> <=
/span><br><span>@@ -1242,7 +1242,7 @@</span><br><span>         gw_v6=2Eipv6=
 =3D *gw;</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s=
 table %d metric %d&quot;, __func__,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u me=
tric %d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET6, &amp;=
dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>      =
   inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface=
), table, metric);</span><br><span> </span><br><span>@@ -1293,7 +1293,7 @@<=
/span><br><span>         gw_v4=2Eipv4 =3D htonl(*gw);</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&quot;, __fu=
nc__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUT=
E, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,</span>=
<br><span>         inet_ntop(AF_INET, &amp;dst_v4=2Eipv4, dst_str, sizeof(d=
st_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_v4=
=2Eipv4, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><spa=
n> </span><br><span>@@ -1319,7 +1319,7 @@</span><br><span>         gw_v6=2E=
ipv6 =3D *gw;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s de=
v %s table %d metric %d&quot;, __func__,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %=
u metric %d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET6, &=
amp;dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>  =
       inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(i=
face), table, metric);</span><br><span> </span><br><span>diff --git a/src/o=
penvpn/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index daa52b7=
=2E=2E95e93da 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><b=
r><span>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -4549,7 +4549,7 @@=
</span><br><span>         {</span><br><span>             if (netbits &lt; 6=
4 || netbits &gt; 124)</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;ifconfi=
g-ipv6: /netbits must be between 64 and 124, not &#39;/%d&#39;&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msgle=
vel, &quot;ifconfig-ipv6: /netbits must be between 64 and 124, not &#39;/%u=
&#39;&quot;,</span><br><span>                     netbits);</span><br><span=
>                 goto err;</span><br><span>             }</span><br><span>=
@@ -5827,7 +5827,7 @@</span><br><span>         }</span><br><span>         i=
f (netbits &lt; 64 || netbits &gt; 124)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quo=
t;--server-ipv6 settings: network must be between /64 and /124 (not /%d)&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(msglevel, &quot;--server-ipv6 settings: network must be between /64 and /1=
24 (not /%u)&quot;,</span><br><span>                 netbits);</span><br><s=
pan> </span><br><span>             goto err;</span><br><span>@@ -5940,7 +59=
40,7 @@</span><br><span>         if (netbits &lt; 64 || netbits &gt; 124)</=
span><br><span>         {</span><br><span>             msg(msglevel,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;--ifco=
nfig-ipv6-pool settings: network must be between /64 and /124 (not /%d)&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
&quot;--ifconfig-ipv6-pool settings: network must be between /64 and /124 (=
not /%u)&quot;,</span><br><span>                 netbits);</span><br><span>=
             goto err;</span><br><span>         }</span><br><span>diff --gi=
t a/src/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec</span><br><=
span>index ff090774=2E=2E80d36f0 100644</span><br><span>--- a/src/openvpn/o=
ptions_show=2Ec</span><br><span>+++ b/src/openvpn/options_show=2Ec</span><b=
r><span>@@ -136,7 +136,7 @@</span><br><span>     msg(D_SHOW_PARMS, &quot;  =
server_network =3D %s&quot;, print_in_addr_t(o-&gt;server_network, 0, &amp;=
gc));</span><br><span>     msg(D_SHOW_PARMS, &quot;  server_netmask =3D %s&=
quot;, print_in_addr_t(o-&gt;server_netmask, 0, &amp;gc));</span><br><span>=
     msg(D_SHOW_PARMS, &quot;  server_network_ipv6 =3D %s&quot;, print_in6_=
addr(o-&gt;server_network_ipv6, 0, &amp;gc));</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    SHOW_INT(server_netbits_ipv6);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(server_netbits_ipv6);<=
/span><br><span>     msg(D_SHOW_PARMS, &quot;  server_bridge_ip =3D %s&quot=
;, print_in_addr_t(o-&gt;server_bridge_ip, 0, &amp;gc));</span><br><span>  =
   msg(D_SHOW_PARMS, &quot;  server_bridge_netmask =3D %s&quot;,</span><br>=
<span>         print_in_addr_t(o-&gt;server_bridge_netmask, 0, &amp;gc));</=
span><br><span>@@ -170,8 +170,8 @@</span><br><span>     SHOW_INT(ifconfig_i=
pv6_pool_netbits);</span><br><span>     SHOW_INT(n_bcast_buf);</span><br><s=
pan>     SHOW_INT(tcp_queue_limit);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    SHOW_INT(real_hash_size);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    SHOW_INT(virtual_hash_size);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(real_hash_size);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(virtual_hash_si=
ze);</span><br><span>     SHOW_STR(client_connect_script);</span><br><span>=
     SHOW_STR(learn_address_script);</span><br><span>     SHOW_STR(client_d=
isconnect_script);</span><br><span>@@ -444,10 +444,10 @@</span><br><span> #=
if defined(TARGET_LINUX)</span><br><span>     SHOW_INT(mark);</span><br><sp=
an> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_IN=
T(sockflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SH=
OW_UINT(sockflags);</span><br><span> </span><br><span>     SHOW_INT(comp=2E=
alg);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(com=
p=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW=
_UINT(comp=2Eflags);</span><br><span> </span><br><span>     SHOW_STR(route_=
script);</span><br><span>     SHOW_STR(route_default_gateway);</span><br><s=
pan>@@ -482,7 +482,7 @@</span><br><span>     SHOW_INT(management_echo_buffe=
r_size);</span><br><span>     SHOW_STR(management_client_user);</span><br><=
span>     SHOW_STR(management_client_group);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    SHOW_INT(management_flags);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(management_flags);</span><=
br><span> #endif</span><br><span> #ifdef ENABLE_PLUGIN</span><br><span>    =
 if (o-&gt;plugin_list)</span><br><span>@@ -547,7 +547,7 @@</span><br><span=
>         int i;</span><br><span>         for (i =3D 0; i &lt; MAX_PARMS; i=
++)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            SHOW_INT(remote_cert_ku[i]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            SHOW_UINT(remote_cert_ku[i]);</sp=
an><br><span>         }</span><br><span>     }</span><br><span>     SHOW_ST=
R(remote_cert_eku);</span><br><span>@@ -567,7 +567,7 @@</span><br><span>   =
      }</span><br><span>         gc_free(&amp;gc);</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ssl_flags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(ssl_=
flags);</span><br><span> </span><br><span>     SHOW_INT(tls_timeout);</span=
><br><span> </span><br><span>diff --git a/src/openvpn/platform=2Ec b/src/op=
envpn/platform=2Ec</span><br><span>index 6c766c2=2E=2Eab581f4 100644</span>=
<br><span>--- a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/=
platform=2Ec</span><br><span>@@ -580,7 +580,7 @@</span><br><span>         }=
</span><br><span>     }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    msg(M_WARN, &quot;Failed to create temporary file a=
fter %i attempts&quot;, attempts);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(M_WARN, &quot;Failed to create temporary file after =
%u attempts&quot;, attempts);</span><br><span>     return NULL;</span><br><=
span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/route=2E=
c b/src/openvpn/route=2Ec</span><br><span>index 8b85eac=2E=2E469edb3 100644=
</span><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/open=
vpn/route=2Ec</span><br><span>@@ -823,7 +823,7 @@</span><br><span>         =
        {</span><br><span>                     need_remote_ipv6_route =3D t=
rue;</span><br><span>                     msg(D_ROUTE,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        &quot;ROUTE6: %s/%=
d overlaps IPv6 remote %s, adding host route to VPN endpoint&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                        &qu=
ot;ROUTE6: %s/%u overlaps IPv6 remote %s, adding host route to VPN endpoint=
&quot;,</span><br><span>                         print_in6_addr(r6-&gt;netw=
ork, 0, &amp;gc), r6-&gt;netbits,</span><br><span>                         =
print_in6_addr(*remote_host_ipv6, 0, &amp;gc));</span><br><span>           =
      }</span><br><span>@@ -1355,7 +1355,7 @@</span><br><span>         stru=
ct buffer name2 =3D alloc_buf_gc(256, &amp;gc);</span><br><span> </span><br=
><span>         buf_printf(&amp;name1, &quot;route_ipv6_network_%d&quot;, i=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(=
&amp;val, &quot;%s/%d&quot;, print_in6_addr(r6-&gt;network, 0, &amp;gc), r6=
-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   buf_printf(&amp;val, &quot;%s/%u&quot;, print_in6_addr(r6-&gt;network, 0=
, &amp;gc), r6-&gt;netbits);</span><br><span>         setenv_str(es, BSTR(&=
amp;name1), BSTR(&amp;val));</span><br><span> </span><br><span>         buf=
_printf(&amp;name2, &quot;route_ipv6_gateway_%d&quot;, i);</span><br><span>=
@@ -1803,10 +1803,10 @@</span><br><span> #endif</span><br><span> </span><br=
><span> #ifndef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(D_ROUTE, &quot;add_route_ipv6(%s/%d -&gt; %s metric %d) dev %s&quo=
t;, network, r6-&gt;netbits, gateway,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    msg(D_ROUTE, &quot;add_route_ipv6(%s/%u -&gt; %s metr=
ic %d) dev %s&quot;, network, r6-&gt;netbits, gateway,</span><br><span>    =
     r6-&gt;metric, device);</span><br><span> #else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;add_route_ipv6(%s/%d=
 -&gt; %s metric %d) IF %lu&quot;, network, r6-&gt;netbits, gateway,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;add=
_route_ipv6(%s/%u -&gt; %s metric %d) IF %lu&quot;, network, r6-&gt;netbits=
, gateway,</span><br><span>         r6-&gt;metric, r6-&gt;adapter_index ? r=
6-&gt;adapter_index : tt-&gt;adapter_index);</span><br><span> #endif</span>=
<br><span> </span><br><span>@@ -1832,7 +1832,7 @@</span><br><span>         =
    &quot;ROUTE6 WARNING: &quot; PACKAGE_NAME &quot; needs a gateway &quot;=
</span><br><span>             &quot;parameter for a --route-ipv6 option and=
 no default was set via &quot;</span><br><span>             &quot;--ifconfi=
g-ipv6 or --route-ipv6-gateway option=2E  Not installing &quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            &quot;IPv6 route to %=
s/%d=2E&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       &quot;IPv6 route to %s/%u=2E&quot;,</span><br><span>             net=
work, r6-&gt;netbits);</span><br><span>         status =3D 0;</span><br><sp=
an>         goto done;</span><br><span>@@ -2222,7 +2222,7 @@</span><br><spa=
n>     }</span><br><span> #endif</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;delete_route_ipv6(%s/%d=
)&quot;, network, r6-&gt;netbits);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_ROUTE, &quot;delete_route_ipv6(%s/%u)&quot;, netwo=
rk, r6-&gt;netbits);</span><br><span> </span><br><span> #if defined(TARGET_=
LINUX)</span><br><span>     int metric =3D -1;</span><br><span>diff --git a=
/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index c893=
c9b=2E=2Edf8e400 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span>=
<br><span>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -831,7 +831,8 @@<=
/span><br><span>     else if (remote_len_af &amp;&amp; remote_len !=3D remo=
te_len_af)</span><br><span>     {</span><br><span>         msg(D_LINK_ERROR=
S,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;T=
CP: Received strange incoming connection with unknown address length=3D%d&q=
uot;, remote_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;TCP: Received strange incoming connection with unknown add=
ress length=3D%u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            (unsigned int)remote_len);</span><br><span>         openvpn=
_close_socket(new_sd);</span><br><span>         new_sd =3D SOCKET_UNDEFINED=
;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/ssl_ncp=
=2Ec b/src/openvpn/ssl_ncp=2Ec</span><br><span>index 8b0f28d=2E=2Ef13f507 1=
00644</span><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/s=
rc/openvpn/ssl_ncp=2Ec</span><br><span>@@ -508,7 +508,7 @@</span><br><span>=
     }</span><br><span> </span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;P2=
P mode NCP negotiation result: &quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                         &quot;TLS_export=3D%d, DATA_v2=3D%=
d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                         &quot;=
TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %u, tx-peer-id %u, epoch=3D%d, ci=
pher=3D%s&quot;,</span><br><span>         (bool)(session-&gt;opt-&gt;crypto=
_flags &amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span>         mult=
i-&gt;use_peer_id,</span><br><span>         multi-&gt;rx_peer_id,</span><br=
></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn=
/+/1958?usp=3Demail">change 1958</a>=2E To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1958?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div=
>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3 <=
/div>
<div style=3D"display:none"> Gerrit-Change-Number: 1958 </div>
<div s=
tyle=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none=
"> Gerrit-Owner: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=
=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt=
;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:n=
one"> Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>=


</body></html>
--NTUru9YBHdc=--


--===============1563168212386872203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1563168212386872203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1563168212386872203==--

