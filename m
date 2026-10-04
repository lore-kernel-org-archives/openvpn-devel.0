Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB6ACA5FEC
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8MSpkqC88iJFaNhfBmLHxj1wgBCDS+/nNDq9UZ6LeXA=; b=NGiPUJLKxdFuJRaKCrYeLWtCUv
	UJsiClV3h3KPQUv9P2+V1EeGzIi95b7T7LUVvkfYkc22bsU2+LpUPs4WzdCsmLGcFZMfNpzBiajEa
	DQO75mvcliTomiutSwrZG/5M5qzh3NPpFHKMdwA1MkIWNef7V2J5X5zIdH9/6eSKRboo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDICG-0000Gb-38;
	Sun, 04 Oct 2026 09:07:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDICE-0000GU-Vu
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:07:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=r/yeXlRGAzcFZZgokeD0umEX0OHZMMAktqcPx7lCCcQ=; b=HJ1TCYdziWM4e8yDfYULZZb8mA
 GnAfH8QgvEaX146B6JFfY/O9KQ9nkGEvcp5TGMMO3Ub1N5409uYR5V/GXq9/Lsq1APf1ktbllHW8G
 clxNMGaFTdYAIbUDjAsPOyJ55XuqzjUZ3PYIZTEKEFr4HkVCx7W5OYNuXhYa2HDnd9KY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=r/yeXlRGAzcFZZgokeD0umEX0OHZMMAktqcPx7lCCcQ=; b=V
 AuRjmO+kZABiXsmTVg4U6I0sMqRW9C1IyjWWO7nd8Qivc1syK8xvfvRuRBVs46s60OPY+iqW0HrnI
 UgIh+qrQac5e0uAAqDux2nD9L9DS9Z+2Uep6i/7vwbSVn2+Cj1cVJME45H3NwXgwMDMI6YDy4p+SO
 1GjDUq2iEluxLxzg=;
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDICB-0002lf-KP for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:07:50 +0000
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-48b9d8055dfso635151f8f.3
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791104861; x=1791709661; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=r/yeXlRGAzcFZZgokeD0umEX0OHZMMAktqcPx7lCCcQ=;
 b=fU/t8QwfICusp/rJUFrER3EdzpIuQo3J8gGh55AetVKJBBKOXIG+du4tNhAA/J+fbg
 egT+C7iuVTuw3bICkNVdVd9lcTC4737We1vN0PE3cvgmF5DAFPO1s75fg5KWZFMWUwHT
 kOoCMNE1hgBtWmG2V8cnKlIfon6ECpC2gibrhUgrkwS64O7QRFBW15fczVlr7ok9swkx
 nOUZjWpA88al3vu7HnCU8/Lt4OfeCBDc8dSopoLQGK7XTW6TizX6K/ndmsfGYthJeeJT
 Mh1wO1VTn9kN2CG3975CIlikiOqad4ezqKIYOTnk+IQMQZSSXbGVia1fEeFwav9IGmKp
 EpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791104861; x=1791709661;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=r/yeXlRGAzcFZZgokeD0umEX0OHZMMAktqcPx7lCCcQ=;
 b=yRh96Rk48tmqnZanCSS+nMqTClAhNZ1GrAyacSPSldGLFMbMNiegWWOxaeA3jnt6DE
 NVT+bGZ5oCtpMtrX++JoYWlQJ8H3/XnhO+zMK+cEusIBKicz7G7W3rs4y3iFeR2mJC3b
 Vteck1JqrwwfH57GZ2RTrzbV5aaB58C7OP5LEabW5yjuHsS/G9I3Fkn2hw3IiDtVKrR4
 L+r8WToMGzqyVDYnSITQNIfnfCwwfCy1aKND/zykkpoy2/uPaI+PZczXuNIViepdyD+4
 YTQLHWqtfqf+/kNXj3pfmTL7+v1jffwSQoUmmIj9ktHNqiZk9/SGgSQRYKsNjz4k0t1G
 5opw==
X-Gm-Message-State: AFuF++kDKgVu+6mMezpkTeOw7jRcuQO/01lhz9P35Rx0PYRrGyqVRTFH
 SoLMzdJIOVxzCJCIu4P9ATGs5+xpbX4ctrx+W1zmEogw/OH/s4UZuVo+ttpMMwIKHtQaCgWTZCI
 DXtTcjFThkl0P2RzA0m6Y+OhaZwsV6H1N2ZYEE5pYwJ1FjNVDfNKgabN8P41POQpjRFFo
X-Gm-Gg: AYBFou1rEGta97ZUzwEb+cIiYQkT6HMFt7HvYPKSFxTwBI6SIHVoMheKaTS/htvERVC
 6BCf6zL5HTtNkOZfcTSeFls5PGSHlNbAQNCkohVo0q3BEm9Kg6tvYWBmBt6UJs7nUlr2ZHC49+T
 eNQgDohHg10CptjdeR33eI1wHL+7gvvenqa20FFnK6jdwmLhCBi3EW7tEvBqH0We7ow9kK/6N5I
 QjXzAeVxqAsNTzsXLL1QSCSaXZcQoa/CnGI4QDT15msGtu3nR6NLen7so0cDG6xhBuA0Rz3ogWE
 QnAKpgjyw6KcNyrSSD+K0wiydRXOXxv/olVgBpyURJDK2YgMKqq9Y62g/tPpdbLEFINxuf/noi9
 KQEn9HS7hM4V+31znUA0PwZYDsh7B/ERT6QjCh8D1npf5jMf7YhWY7Spxo2BSkVELlUEs3dsvsr
 nWZiGPz2bQnFd7UyXFwOyRJh9zEMB1/Eo4W6/O8p7bLV2iBy3TLSWDbf3911NHgFSGIdUBrlWmf
 lKM9tNnQ2Fh8KbAK2C0HnDiNQA4tkxdkN1NsQ3Ygx3wStBWTcUwbRK7UwvT94oKotjOd7C1FSrL
 RRCP4vjEEh088adf4liKcyFXwsj70ps+uAOtydvjM028gNJE/h1HJiWPOVIfvA==
X-Received: by 2002:a05:600d:8641:20b0:4a0:1efa:c748 with SMTP id
 5b1f17b1804b1-4a1680e5c71mr44695695e9.15.1791104860664; 
 Sun, 04 Oct 2026 02:07:40 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b38104f89sm18689484f8f.30.2026.10.04.02.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 02:07:40 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 09:07:38 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3
X-Gerrit-Change-Number: 1958
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1958?usp=email>
X-Gerrit-Commit: 02d1e01f93d1125646e2645795a5c60acbc68b47
In-Reply-To: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
References: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkkwYjM5ZDZhMGZiMmU2ZGJiNjgzZTk1NTVmMDM2NTM1M2M0ZWRhOGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <58ee08cf87717cf1104f507aae524eb15e9d95d3-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDICB-0002lf-KP
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
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============2015864109445951225=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============2015864109445951225==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pJIS5gicZlU="; charset=UTF-8

--pJIS5gicZlU=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#4) to the change originally cre=
ated by Frank Lichtenheld=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1=
958?usp=3Demail )

The following approvals got outdated and were removed:
C=
ode-Review+2 by R=C4=83zvan Cojocaru


Change subject: Fix all occurrences =
of cppcheck invalidPrintfArgType_sint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

Fix all occurrences of cppcheck invalidPrintfArgT=
ype_sint

Mostly trivially correct=2E The only exception is socklen_t which=

can be of various types=2E In Linux it is uint32_t and in all cases
it sho=
uld be a small unsigned number=2E So print it as that=2E

Change-Id: I0b39d=
6a0fb2e6dbb683e9555f0365353c4eda8d3
Signed-off-by: Frank Lichtenheld <frank=
@lichtenheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerri=
t URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958
Message-Id: <2026100=
3204342=2E19505-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=
=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg39678=2Ehtml
Signed-off-b=
y: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppress=
ions=2Exml
M src/openvpn/crypto=2Ec
M src/openvpn/dco_linux=2Ec
M src/openv=
pn/dco_win=2Ec
M src/openvpn/event=2Ec
M src/openvpn/manage=2Ec
M src/openv=
pn/multi=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/networking_sitnl=2Ec
=
M src/openvpn/options=2Ec
M src/openvpn/options_show=2Ec
M src/openvpn/plat=
form=2Ec
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/ssl=
_ncp=2Ec
15 files changed, 59 insertions(+), 61 deletions(-)


  git pull s=
sh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/58/1958/4

diff --gi=
t a/dev-tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=
=2Exml
index cd37c41=2E=2E0d5416a 100644
--- a/dev-tools/cppcheck-suppressi=
ons=2Exml
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ -12,9 +12,6 @@
   =
  <id>constParameterPointer</id>
   </suppress>
   <suppress>
-    <id>inva=
lidPrintfArgType_sint</id>
-  </suppress>
-  <suppress>
     <id>invalidPri=
ntfArgType_uint</id>
   </suppress>
   <suppress>
diff --git a/src/openvpn/=
crypto=2Ec b/src/openvpn/crypto=2Ec
index 243cf27=2E=2E1703d4d 100644
--- a=
/src/openvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -261,7 +261,7 @@
  =
           if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->ciphe=
r)))
             {
                 msg(D_CRYPT_ERRORS,
-                 =
   "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=
=3D%d cbs=3D%d",
+                    "ENCRYPT: buffer size error, bc=3D%d =
bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u",
                     buf=
->capacity, buf->offset, buf->len, work=2Ecapacity, work=2Eoffset, work=2El=
en,
                     cipher_ctx_block_size(ctx->cipher));
             =
    goto err;
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linu=
x=2Ec
index e583696=2E=2Ea397fb8 100644
--- a/src/openvpn/dco_linux=2Ec
+++=
 b/src/openvpn/dco_linux=2Ec
@@ -231,7 +231,7 @@
     {
         remotestr =
=3D print_sockaddr(remoteaddr, &gc);
     }
-    msg(D_DCO_DEBUG, "%s: peer=
-id %d, fd %d, remote addr: %s", __func__, peerid, sd, remotestr);
+    msg=
(D_DCO_DEBUG, "%s: peer-id %u, fd %d, remote addr: %s", __func__, peerid, s=
d, remotestr);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, =
OVPN_CMD_PEER_NEW);
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVP=
N_A_PEER);
@@ -574,7 +574,7 @@
 int
 dco_swap_keys(dco_context_t *dco, unsi=
gned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peeri=
d);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);
 
     struc=
t nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_SWAP);
     if=
 (!nl_msg)
@@ -598,7 +598,7 @@
 int
 dco_del_peer(dco_context_t *dco, unsig=
ned int peerid)
 {
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __=
func__, peerid);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %u", __fu=
nc__, peerid);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, =
OVPN_CMD_PEER_DEL);
     if (!nl_msg)
@@ -623,7 +623,7 @@
 dco_del_key(dco_=
context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
     int ret =
=3D -EMSGSIZE;
-    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, p=
eerid, slot);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d", __func__, pe=
erid, slot);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OV=
PN_CMD_KEY_DEL);
     if (!nl_msg)
@@ -648,7 +648,7 @@
             const u=
int8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,=

             const uint8_t *decrypt_iv, const char *ciphername, bool epoch=
)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, =
epoch %d", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %=
d, key-id %d, peer-id %u, cipher %s, epoch %d", __func__, slot, keyid, peer=
id,
         ciphername, epoch);
 
     const size_t key_len =3D cipher_kt_=
key_size(ciphername);
@@ -701,7 +701,7 @@
 dco_set_peer(dco_context_t *dco,=
 unsigned int peerid, int keepalive_interval, int keepalive_timeout,
      =
        int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d,=
 mss %d", __func__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, keepaliv=
e %d/%d, mss %d", __func__, peerid,
         keepalive_interval, keepalive_=
timeout, mss);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, =
OVPN_CMD_PEER_SET);
@@ -968,7 +968,7 @@
     uint32_t ifindex =3D nla_get_u=
32(attrs[OVPN_A_IFINDEX]);
     if (ifindex !=3D dco->ifindex)
     {
-    =
    msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %d", i=
findex);
+        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign =
ifindex %u", ifindex);
         return false;
     }
 
@@ -1010,7 +1010,7 @=
@
     int reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
     u=
nsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
 
-    msg(D_=
DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d,=
 peer-id %u, reason: %d",
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: re=
ceived CMD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reason: %d",
         dco=
->ifindex, peerid, reason);
     dco->dco_message_peer_id =3D peerid;
     =
dco->dco_del_peer_reason =3D reason;
@@ -1097,7 +1097,7 @@
     int key_id =
=3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
     unsigned int peer_id=
 =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
 
-    msg(D_DCO_DEBUG,=
 "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-id: %d"=
,
+    msg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %u, =
peer-id %u, key-id: %d",
         dco->ifindex, peer_id, key_id);
     dco-=
>dco_message_peer_id =3D peer_id;
     dco->dco_message_key_id =3D key_id;
=
diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index bd94c1=
a=2E=2E20d3c27 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_w=
in=2Ec
@@ -56,7 +56,7 @@
         {
             break;
         }
-       =
 msg(D_DCO_DEBUG, "interface %ld not yet ready, retrying", idx);
+        m=
sg(D_DCO_DEBUG, "interface %lu not yet ready, retrying", idx);
         Sle=
ep(50);
     }
 }
@@ -409,7 +409,7 @@
              struct sockaddr *locala=
ddr, struct sockaddr *remoteaddr,
              const struct in_addr *vpn_i=
pv4, const struct in6_addr *vpn_ipv6)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id=
 %d, fd " SOCKET_PRINTF, __func__, peerid, sd);
+    msg(D_DCO_DEBUG, "%s: =
peer-id %u, fd " SOCKET_PRINTF, __func__, peerid, sd);
 
     if (dco->ifmo=
de =3D=3D DCO_MODE_P2P)
     {
@@ -460,7 +460,7 @@
 int
 dco_del_peer(dco_c=
ontext_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %=
d", __func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, pe=
erid);
 
     OVPN_MP_DEL_PEER del_peer =3D { peerid };
     VOID *buf =3D =
NULL;
@@ -487,7 +487,7 @@
 dco_set_peer(dco_context_t *dco, unsigned int pe=
erid, int keepalive_interval, int keepalive_timeout,
              int mss)=

 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func=
__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, keepalive %d/%d, mss %d"=
, __func__, peerid,
         keepalive_interval, keepalive_timeout, mss);
 =

     OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, keepalive_=
timeout, mss };
@@ -522,7 +522,7 @@
             const uint8_t *encrypt_key=
, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
             const=
 uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-    msg(D_DCO=
_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __func__, slot, ke=
yid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cip=
her %s", __func__, slot, keyid, peerid,
         ciphername);
 
     const =
int nonce_len =3D 8;
@@ -575,7 +575,7 @@
 int
 dco_del_key(dco_context_t *d=
co, unsigned int peerid, dco_key_slot_t slot)
 {
-    msg(D_DCO, "%s: peer-=
id %d, slot %d called but ignored", __func__, peerid, slot);
+    msg(D_DCO=
, "%s: peer-id %u, slot %d called but ignored", __func__, peerid, slot);
  =
   /* FIXME: Implement in driver first */
     return 0;
 }
@@ -583,7 +583,=
7 @@
 int
 dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
 {
-    =
msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+    msg(D_DCO_DEBUG=
, "%s: peer-id %u", __func__, peer_id);
 
     OVPN_MP_SWAP_KEYS swap =3D {=
 peer_id };
     DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;
@@ -667,7 +667,7 @@
=
     BOOL res =3D GetOverlappedResult(dco->tt->hand, &dco->ov, &bytes_read,=
 FALSE);
     if (res)
     {
-        msg(D_DCO_DEBUG, "%s: completion%s s=
uccess [%ld]", __func__, queued ? "" : " non-queued",
+        msg(D_DCO_DE=
BUG, "%s: completion%s success [%lu]", __func__, queued ? "" : " non-queued=
",
             bytes_read);
 
         dco->dco_message_peer_id =3D dco->n=
otif_buf=2EPeerId;
@@ -1016,7 +1016,7 @@
         =2EAddr=2EAddr4=2ES_un=2E=
S_addr =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D =
0
     };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, print_i=
n_addr_t(dst, IA_NET_ORDER, &gc),
+    msg(D_DCO_DEBUG, "%s: %s/%u -> peer =
%u", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc),
         netbits, p=
eer_id);
 
     DWORD bytes_returned =3D 0;
@@ -1037,7 +1037,7 @@
 
     OV=
PN_MP_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENetbits =3D netbits, =
=2EPeerId =3D peer_id, =2EIPv6 =3D 1 };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d =
-> peer %d", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc),
+    msg(D_D=
CO_DEBUG, "%s: %s/%u -> peer %u", __func__, print_in6_addr(dst, IA_NET_ORDE=
R, &gc),
         netbits, peer_id);
 
     DWORD bytes_returned =3D 0;
@@ =
-1059,7 +1059,7 @@
         =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENet=
bits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 0
     };
 
-    msg(D_DCO_=
DEBUG, "%s: %s/%d", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc), netb=
its);
+    msg(D_DCO_DEBUG, "%s: %s/%u", __func__, print_in_addr_t(dst, IA_=
NET_ORDER, &gc), netbits);
 
     DWORD bytes_returned =3D 0;
     if (!Dev=
iceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route, sizeof(route)=
, NULL, 0,
@@ -1078,7 +1078,7 @@
 
     OVPN_MP_IROUTE route =3D { =2EAddr=
=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 1 }=
;
 
-    msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in6_addr(dst, IA_NET=
_ORDER, &gc), netbits);
+    msg(D_DCO_DEBUG, "%s: %s/%u", __func__, print_=
in6_addr(dst, IA_NET_ORDER, &gc), netbits);
 
     DWORD bytes_returned =3D=
 0;
     if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &rou=
te, sizeof(route), NULL, 0,
diff --git a/src/openvpn/event=2Ec b/src/openvp=
n/event=2Ec
index 2cb4e04=2E=2E4089401 100644
--- a/src/openvpn/event=2Ec
+=
++ b/src/openvpn/event=2Ec
@@ -117,7 +117,7 @@
     }
     else
     {
-   =
     msg(M_FATAL, "fatal error in we_set_events: rwflags=3D%d", rwflags);
+=
        msg(M_FATAL, "fatal error in we_set_events: rwflags=3D%u", rwflags)=
;
     }
 
     wes->esr[i]=2Erwflags =3D rwflags;
@@ -378,7 +378,7 @@
    =
             break;
 
             default:
-                msg(M_FATAL, "=
fatal error in we_ctl: rwflags=3D%d", rwflags);
+                msg(M_FATA=
L, "fatal error in we_ctl: rwflags=3D%u", rwflags);
         }
     }
     =
return;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index =
b6d93c7=2E=2E0aef2d4 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/=
manage=2Ec
@@ -1503,7 +1503,7 @@
     }
     else if (streq(p[0], "pid"))
 =
    {
-        msg(M_CLIENT, "SUCCESS: pid=3D%d", platform_getpid());
+    =
    msg(M_CLIENT, "SUCCESS: pid=3D%u", platform_getpid());
     }
     else=
 if (streq(p[0], "nclients"))
     {
diff --git a/src/openvpn/multi=2Ec b/s=
rc/openvpn/multi=2Ec
index 959f7b3=2E=2E1cf2a21 100644
--- a/src/openvpn/mu=
lti=2Ec
+++ b/src/openvpn/multi=2Ec
@@ -164,7 +164,7 @@
     struct hash_it=
erator hi;
     struct hash_element *he;
 
-    dmsg(D_MULTI_DEBUG, "MULTI:=
 REAP range %d -> %d", start_bucket, end_bucket);
+    dmsg(D_MULTI_DEBUG, =
"MULTI: REAP range %u -> %u", start_bucket, end_bucket);
     hash_iterator=
_init_range(m->vhash, &hi, start_bucket, end_bucket);
     while ((he =3D h=
ash_iterator_next(&hi)) !=3D NULL)
     {
@@ -271,7 +271,7 @@
     struct m=
ulti_context *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
-    msg(D=
_MULTI_LOW, "MULTI: multi_init called, r=3D%d v=3D%d", t->options=2Ereal_ha=
sh_size,
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%u v=3D%u", t=
->options=2Ereal_hash_size,
         t->options=2Evirtual_hash_size);
 
   =
  /*
@@ -430,7 +430,7 @@
         if (mi->context=2Ec2=2Etls_multi && check=
_debug_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context=2Eoption=
s))
         {
-            buf_printf(&out, " rx-peer-id=3D%d", mi->contex=
t=2Ec2=2Etls_multi->rx_peer_id);
+            buf_printf(&out, " rx-peer-id=
=3D%u", mi->context=2Ec2=2Etls_multi->rx_peer_id);
         }
         retu=
rn BSTR(&out);
     }
@@ -735,7 +735,7 @@
     if (hash_n_elements(m->hash)=
 >=3D m->max_clients)
     {
         msg(D_MULTI_ERRORS,
-            "MUL=
TI: new incoming connection would exceed maximum number of clients (%d)",
+=
            "MULTI: new incoming connection would exceed maximum number of =
clients (%u)",
             m->max_clients);
         goto err;
     }
@@ -=
996,7 +996,7 @@
 #ifdef ENABLE_ASYNC_PUSH
     if (m->inotify_watchers)
   =
  {
-        msg(D_MULTI_DEBUG, "inotify watchers count: %d", hash_n_elemen=
ts(m->inotify_watchers));
+        msg(D_MULTI_DEBUG, "inotify watchers cou=
nt: %u", hash_n_elements(m->inotify_watchers));
     }
 #endif
 }
@@ -1302,=
7 +1302,7 @@
         }
         for (ir6 =3D mi->context=2Eoptions=2Eirout=
es_ipv6; ir6 !=3D NULL; ir6 =3D ir6->next)
         {
-            msg(D_MU=
LTI_LOW, "MULTI: internal route %s/%d -> %s",
+            msg(D_MULTI_LOW,=
 "MULTI: internal route %s/%u -> %s",
                 print_in6_addr(ir6->=
network, 0, &gc), ir6->netbits,
                 multi_instance_string(mi, =
false, &gc));
 
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_i=
o=2Ec
index bce5018=2E=2E51c7d31 100644
--- a/src/openvpn/multi_io=2Ec
+++ =
b/src/openvpn/multi_io=2Ec
@@ -439,7 +439,7 @@
         default:
         {=

             struct gc_arena gc =3D gc_new();
-            msg(M_FATAL, "M=
ULTI IO: multi_io_post bad state, mi=3D%s flags=3D%d",
+            msg(M_F=
ATAL, "MULTI IO: multi_io_post bad state, mi=3D%s flags=3D%u",
            =
     multi_instance_string(mi, false, &gc), flags);
             gc_free(&g=
c);
             break;
diff --git a/src/openvpn/networking_sitnl=2Ec b/src=
/openvpn/networking_sitnl=2Ec
index 8a0a360=2E=2E83915db 100644
--- a/src/o=
penvpn/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -222,=
7 +222,7 @@
 
     if (addr_len !=3D sizeof(local))
     {
-        msg(M_W=
ARN, "%s: wrong address length %d", __func__, addr_len);
+        msg(M_WAR=
N, "%s: wrong address length %u", __func__, (unsigned int)addr_len);
      =
   return -EINVAL;
     }
 
@@ -528,7 +528,7 @@
 
     if (!if_indextoname(=
ifindex, res->iface))
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: can'=
t get ifname for index %d", __func__, ifindex);
+        msg(M_WARN | M_ERR=
NO, "%s: rtnl: can't get ifname for index %u", __func__, ifindex);
        =
 return -1;
     }
 
@@ -1216,7 +1216,7 @@
         gw_ptr =3D &gw_be;
    =
 }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func=
__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func_=
_,
         inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixle=
n,
         inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), =
table, metric);
 
@@ -1242,7 +1242,7 @@
         gw_v6=2Eipv6 =3D *gw;
    =
 }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func=
__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func_=
_,
         inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), =
prefixlen,
         inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_st=
r)), np(iface), table, metric);
 
@@ -1293,7 +1293,7 @@
         gw_v4=2Eip=
v4 =3D htonl(*gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s tabl=
e %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table=
 %u metric %d", __func__,
         inet_ntop(AF_INET, &dst_v4=2Eipv4, dst_s=
tr, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_v4=2Eipv4,=
 gw_str, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1319,7 +1319,7 @=
@
         gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via =
%s dev %s table %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %=
s dev %s table %u metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v=
6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6=
, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
diff=
 --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index dcc4dac=2E=
=2E30e497c 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=
=2Ec
@@ -4548,7 +4548,7 @@
         {
             if (netbits < 64 || netb=
its > 124)
             {
-                msg(msglevel, "ifconfig-ipv6: /n=
etbits must be between 64 and 124, not '/%d'",
+                msg(msgleve=
l, "ifconfig-ipv6: /netbits must be between 64 and 124, not '/%u'",
       =
              netbits);
                 goto err;
             }
@@ -5826,=
7 +5826,7 @@
         }
         if (netbits < 64 || netbits > 124)
       =
  {
-            msg(msglevel, "--server-ipv6 settings: network must be bet=
ween /64 and /124 (not /%d)",
+            msg(msglevel, "--server-ipv6 set=
tings: network must be between /64 and /124 (not /%u)",
                 ne=
tbits);
 
             goto err;
@@ -5939,7 +5939,7 @@
         if (netbits=
 < 64 || netbits > 124)
         {
             msg(msglevel,
-            =
    "--ifconfig-ipv6-pool settings: network must be between /64 and /124 (n=
ot /%d)",
+                "--ifconfig-ipv6-pool settings: network must be =
between /64 and /124 (not /%u)",
                 netbits);
             go=
to err;
         }
diff --git a/src/openvpn/options_show=2Ec b/src/openvpn/=
options_show=2Ec
index ff090774=2E=2E80d36f0 100644
--- a/src/openvpn/optio=
ns_show=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -136,7 +136,7 @@
     msg=
(D_SHOW_PARMS, "  server_network =3D %s", print_in_addr_t(o->server_network=
, 0, &gc));
     msg(D_SHOW_PARMS, "  server_netmask =3D %s", print_in_addr=
_t(o->server_netmask, 0, &gc));
     msg(D_SHOW_PARMS, "  server_network_ip=
v6 =3D %s", print_in6_addr(o->server_network_ipv6, 0, &gc));
-    SHOW_INT(=
server_netbits_ipv6);
+    SHOW_UINT(server_netbits_ipv6);
     msg(D_SHOW_=
PARMS, "  server_bridge_ip =3D %s", print_in_addr_t(o->server_bridge_ip, 0,=
 &gc));
     msg(D_SHOW_PARMS, "  server_bridge_netmask =3D %s",
         p=
rint_in_addr_t(o->server_bridge_netmask, 0, &gc));
@@ -170,8 +170,8 @@
    =
 SHOW_INT(ifconfig_ipv6_pool_netbits);
     SHOW_INT(n_bcast_buf);
     SHO=
W_INT(tcp_queue_limit);
-    SHOW_INT(real_hash_size);
-    SHOW_INT(virtua=
l_hash_size);
+    SHOW_UINT(real_hash_size);
+    SHOW_UINT(virtual_hash_s=
ize);
     SHOW_STR(client_connect_script);
     SHOW_STR(learn_address_scr=
ipt);
     SHOW_STR(client_disconnect_script);
@@ -444,10 +444,10 @@
 #if d=
efined(TARGET_LINUX)
     SHOW_INT(mark);
 #endif
-    SHOW_INT(sockflags);=

+    SHOW_UINT(sockflags);
 
     SHOW_INT(comp=2Ealg);
-    SHOW_INT(comp=
=2Eflags);
+    SHOW_UINT(comp=2Eflags);
 
     SHOW_STR(route_script);
   =
  SHOW_STR(route_default_gateway);
@@ -482,7 +482,7 @@
     SHOW_INT(manage=
ment_echo_buffer_size);
     SHOW_STR(management_client_user);
     SHOW_ST=
R(management_client_group);
-    SHOW_INT(management_flags);
+    SHOW_UINT=
(management_flags);
 #endif
 #ifdef ENABLE_PLUGIN
     if (o->plugin_list)
=
@@ -547,7 +547,7 @@
         int i;
         for (i =3D 0; i < MAX_PARMS; i=
++)
         {
-            SHOW_INT(remote_cert_ku[i]);
+            SHOW_=
UINT(remote_cert_ku[i]);
         }
     }
     SHOW_STR(remote_cert_eku);
=
@@ -567,7 +567,7 @@
         }
         gc_free(&gc);
     }
-    SHOW_INT(=
ssl_flags);
+    SHOW_UINT(ssl_flags);
 
     SHOW_INT(tls_timeout);
 
diff=
 --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec
index 400c722=
=2E=2E91cc0ad 100644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/platf=
orm=2Ec
@@ -578,7 +578,7 @@
         }
     }
 
-    msg(M_WARN, "Failed to=
 create temporary file after %i attempts", attempts);
+    msg(M_WARN, "Fai=
led to create temporary file after %u attempts", attempts);
     return NUL=
L;
 }
 
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index b3=
aee37=2E=2Ece25cc0 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/rou=
te=2Ec
@@ -823,7 +823,7 @@
                 {
                     need_rem=
ote_ipv6_route =3D true;
                     msg(D_ROUTE,
-               =
         "ROUTE6: %s/%d overlaps IPv6 remote %s, adding host route to VPN e=
ndpoint",
+                        "ROUTE6: %s/%u overlaps IPv6 remote %s, =
adding host route to VPN endpoint",
                         print_in6_addr=
(r6->network, 0, &gc), r6->netbits,
                         print_in6_addr=
(*remote_host_ipv6, 0, &gc));
                 }
@@ -1353,7 +1353,7 @@
    =
     struct buffer name2 =3D alloc_buf_gc(256, &gc);
 
         buf_printf(=
&name1, "route_ipv6_network_%d", i);
-        buf_printf(&val, "%s/%d", pri=
nt_in6_addr(r6->network, 0, &gc), r6->netbits);
+        buf_printf(&val, "=
%s/%u", print_in6_addr(r6->network, 0, &gc), r6->netbits);
         setenv_=
str(es, BSTR(&name1), BSTR(&val));
 
         buf_printf(&name2, "route_ipv=
6_gateway_%d", i);
@@ -1801,10 +1801,10 @@
 #endif
 
 #ifndef _WIN32
-    m=
sg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) dev %s", network, r6->ne=
tbits, gateway,
+    msg(D_ROUTE, "add_route_ipv6(%s/%u -> %s metric %d) de=
v %s", network, r6->netbits, gateway,
         r6->metric, device);
 #else
=
-    msg(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) IF %lu", network, =
r6->netbits, gateway,
+    msg(D_ROUTE, "add_route_ipv6(%s/%u -> %s metric =
%d) IF %lu", network, r6->netbits, gateway,
         r6->metric, r6->adapte=
r_index ? r6->adapter_index : tt->adapter_index);
 #endif
 
@@ -1830,7 +183=
0,7 @@
             "ROUTE6 WARNING: " PACKAGE_NAME " needs a gateway "
   =
          "parameter for a --route-ipv6 option and no default was set via "=

             "--ifconfig-ipv6 or --route-ipv6-gateway option=2E  Not insta=
lling "
-            "IPv6 route to %s/%d=2E",
+            "IPv6 route to =
%s/%u=2E",
             network, r6->netbits);
         status =3D 0;
     =
    goto done;
@@ -2220,7 +2220,7 @@
     }
 #endif
 
-    msg(D_ROUTE, "de=
lete_route_ipv6(%s/%d)", network, r6->netbits);
+    msg(D_ROUTE, "delete_r=
oute_ipv6(%s/%u)", network, r6->netbits);
 
 #if defined(TARGET_LINUX)
    =
 int metric =3D -1;
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socke=
t=2Ec
index 41c8bac=2E=2E33def4e 100644
--- a/src/openvpn/socket=2Ec
+++ b/=
src/openvpn/socket=2Ec
@@ -831,7 +831,8 @@
     else if (remote_len_af && r=
emote_len !=3D remote_len_af)
     {
         msg(D_LINK_ERRORS,
-         =
   "TCP: Received strange incoming connection with unknown address length=
=3D%d", remote_len);
+            "TCP: Received strange incoming connectio=
n with unknown address length=3D%u",
+            (unsigned int)remote_len)=
;
         openvpn_close_socket(new_sd);
         new_sd =3D SOCKET_UNDEFIN=
ED;
     }
diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
i=
ndex 8b0f28d=2E=2Ef13f507 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/op=
envpn/ssl_ncp=2Ec
@@ -508,7 +508,7 @@
     }
 
     msg(D_TLS_DEBUG_LOW, "P=
2P mode NCP negotiation result: "
-                         "TLS_export=3D%=
d, DATA_v2=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s",
+ =
                        "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %u, tx-p=
eer-id %u, epoch=3D%d, cipher=3D%s",
         (bool)(session->opt->crypto_f=
lags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
         multi->use_peer_id,
      =
   multi->rx_peer_id,

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/=
openvpn/+/1958?usp=3Demail
To unsubscribe, or for help writing mail filters=
, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Message=
Type: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Chan=
ge-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3
Gerrit-Change-Number: 1958=

Gerrit-PatchSet: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Rev=
iewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <ope=
nvpn-devel@lists=2Esourceforge=2Enet>

--pJIS5gicZlU=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #4</strong> to the change originally created by Fran=
k Lichtenheld=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/=
+/1958?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by R=C4=83zvan Cojocaru</p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Fix all occurrences of cppcheck invalidPrintfArgType_sint<br><br>Mostly=
 trivially correct=2E The only exception is socklen_t which<br>can be of va=
rious types=2E In Linux it is uint32_t and in all cases<br>it should be a s=
mall unsigned number=2E So print it as that=2E<br><br>Change-Id: I0b39d6a0f=
b2e6dbb683e9555f0365353c4eda8d3<br>Signed-off-by: Frank Lichtenheld &lt;fra=
nk@lichtenheld=2Ecom&gt;<br>Acked-by: Razvan Cojocaru &lt;razvanc@mailbox=
=2Eorg&gt;<br>Gerrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958<b=
r>Message-Id: &lt;20261003204342=2E19505-1-gert@greenie=2Emuc=2Ede&gt;<br>U=
RL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Esourceforge=2Ene=
t/msg39678=2Ehtml<br>Signed-off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ed=
e&gt;<br>---<br>M dev-tools/cppcheck-suppressions=2Exml<br>M src/openvpn/cr=
ypto=2Ec<br>M src/openvpn/dco_linux=2Ec<br>M src/openvpn/dco_win=2Ec<br>M s=
rc/openvpn/event=2Ec<br>M src/openvpn/manage=2Ec<br>M src/openvpn/multi=2Ec=
<br>M src/openvpn/multi_io=2Ec<br>M src/openvpn/networking_sitnl=2Ec<br>M s=
rc/openvpn/options=2Ec<br>M src/openvpn/options_show=2Ec<br>M src/openvpn/p=
latform=2Ec<br>M src/openvpn/route=2Ec<br>M src/openvpn/socket=2Ec<br>M src=
/openvpn/ssl_ncp=2Ec<br>15 files changed, 59 insertions(+), 61 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/ope=
nvpn refs/changes/58/1958/4</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/dev-tools/cppcheck-suppres=
sions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span><br><span>index c=
d37c41=2E=2E0d5416a 100644</span><br><span>--- a/dev-tools/cppcheck-suppres=
sions=2Exml</span><br><span>+++ b/dev-tools/cppcheck-suppressions=2Exml</sp=
an><br><span>@@ -12,9 +12,6 @@</span><br><span>     &lt;id&gt;constParamete=
rPointer&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</span><br><span>  =
 &lt;suppress&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
&lt;id&gt;invalidPrintfArgType_sint&lt;/id&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  &lt;suppress&gt;</span><br><span>     &lt;id&gt;in=
validPrintfArgType_uint&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</sp=
an><br><span>   &lt;suppress&gt;</span><br><span>diff --git a/src/openvpn/c=
rypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 243cf27=2E=2E1703d=
4d 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</span><br><span>+++ =
b/src/openvpn/crypto=2Ec</span><br><span>@@ -261,7 +261,7 @@</span><br><spa=
n>             if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size=
(ctx-&gt;cipher)))</span><br><span>             {</span><br><span>         =
        msg(D_CRYPT_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    &quot;ENCRYPT: buffer size error, bc=3D%d bo=3D%d=
 bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%d&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    &quot;ENCRYPT: buffer size=
 error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u&quot;,</sp=
an><br><span>                     buf-&gt;capacity, buf-&gt;offset, buf-&gt=
;len, work=2Ecapacity, work=2Eoffset, work=2Elen,</span><br><span>         =
            cipher_ctx_block_size(ctx-&gt;cipher));</span><br><span>       =
          goto err;</span><br><span>diff --git a/src/openvpn/dco_linux=2Ec =
b/src/openvpn/dco_linux=2Ec</span><br><span>index e583696=2E=2Ea397fb8 1006=
44</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span><br><span>+++ b/sr=
c/openvpn/dco_linux=2Ec</span><br><span>@@ -231,7 +231,7 @@</span><br><span=
>     {</span><br><span>         remotestr =3D print_sockaddr(remoteaddr, &=
amp;gc);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %d, remote addr: %s=
&quot;, __func__, peerid, sd, remotestr);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd %d, rem=
ote addr: %s&quot;, __func__, peerid, sd, remotestr);</span><br><span> </sp=
an><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN=
_CMD_PEER_NEW);</span><br><span>     struct nlattr *attr =3D nla_nest_start=
(nl_msg, OVPN_A_PEER);</span><br><span>@@ -574,7 +574,7 @@</span><br><span>=
 int</span><br><span> dco_swap_keys(dco_context_t *dco, unsigned int peerid=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peerid);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%=
s: peer-id %u&quot;, __func__, peerid);</span><br><span> </span><br><span> =
    struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_SWAP)=
;</span><br><span>     if (!nl_msg)</span><br><span>@@ -598,7 +598,7 @@</sp=
an><br><span> int</span><br><span> dco_del_peer(dco_context_t *dco, unsigne=
d int peerid)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %d&quot;, _=
_func__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %u&quot;, __func__, peer=
id);</span><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_=
dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL);</span><br><span>     if (!nl_msg)=
</span><br><span>@@ -623,7 +623,7 @@</span><br><span> dco_del_key(dco_conte=
xt_t *dco, unsigned int peerid, dco_key_slot_t slot)</span><br><span> {</sp=
an><br><span>     int ret =3D -EMSGSIZE;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, slot %d&quot;=
, __func__, peerid, slot);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, slot %d&quot;, __func__, =
peerid, slot);</span><br><span> </span><br><span>     struct nl_msg *nl_msg=
 =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_DEL);</span><br><span>     if =
(!nl_msg)</span><br><span>@@ -648,7 +648,7 @@</span><br><span>             =
const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decry=
pt_key,</span><br><span>             const uint8_t *decrypt_iv, const char =
*ciphername, bool epoch)</span><br><span> {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, pe=
er-id %d, cipher %s, epoch %d&quot;, __func__, slot, keyid, peerid,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;=
%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d&quot;, __func__, sl=
ot, keyid, peerid,</span><br><span>         ciphername, epoch);</span><br><=
span> </span><br><span>     const size_t key_len =3D cipher_kt_key_size(cip=
hername);</span><br><span>@@ -701,7 +701,7 @@</span><br><span> dco_set_peer=
(dco_context_t *dco, unsigned int peerid, int keepalive_interval, int keepa=
live_timeout,</span><br><span>              int mss)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quo=
t;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __func__, peerid,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%=
s: peer-id %u, keepalive %d/%d, mss %d&quot;, __func__, peerid,</span><br><=
span>         keepalive_interval, keepalive_timeout, mss);</span><br><span>=
 </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco,=
 OVPN_CMD_PEER_SET);</span><br><span>@@ -968,7 +968,7 @@</span><br><span>  =
   uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]);</span><br><span=
>     if (ifindex !=3D dco-&gt;ifindex)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;ovp=
n-dco: ignoring message for foreign ifindex %d&quot;, ifindex);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;=
ovpn-dco: ignoring message for foreign ifindex %u&quot;, ifindex);</span><b=
r><span>         return false;</span><br><span>     }</span><br><span> </sp=
an><br><span>@@ -1010,7 +1010,7 @@</span><br><span>     int reason =3D nla_=
get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><span>     unsigned in=
t peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG | M_NOI=
PREFIX, &quot;ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id %u,=
 reason: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco: received CMD_PEER_DEL_NTF=
, ifindex: %u, peer-id %u, reason: %d&quot;,</span><br><span>         dco-&=
gt;ifindex, peerid, reason);</span><br><span>     dco-&gt;dco_message_peer_=
id =3D peerid;</span><br><span>     dco-&gt;dco_del_peer_reason =3D reason;=
</span><br><span>@@ -1097,7 +1097,7 @@</span><br><span>     int key_id =3D =
nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);</span><br><span>     unsigned=
 int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_D=
EBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, k=
ey-id: %d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %u, p=
eer-id %u, key-id: %d&quot;,</span><br><span>         dco-&gt;ifindex, peer=
_id, key_id);</span><br><span>     dco-&gt;dco_message_peer_id =3D peer_id;=
</span><br><span>     dco-&gt;dco_message_key_id =3D key_id;</span><br><spa=
n>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec</span><br>=
<span>index bd94c1a=2E=2E20d3c27 100644</span><br><span>--- a/src/openvpn/d=
co_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec</span><br><span>@@=
 -56,7 +56,7 @@</span><br><span>         {</span><br><span>             bre=
ak;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        msg(D_DCO_DEBUG, &quot;interface %ld not yet ready, retryi=
ng&quot;, idx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    msg(D_DCO_DEBUG, &quot;interface %lu not yet ready, retrying&quot;, idx=
);</span><br><span>         Sleep(50);</span><br><span>     }</span><br><sp=
an> }</span><br><span>@@ -409,7 +409,7 @@</span><br><span>              str=
uct sockaddr *localaddr, struct sockaddr *remoteaddr,</span><br><span>     =
         const struct in_addr *vpn_ipv4, const struct in6_addr *vpn_ipv6)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd &quot; SOCKET_PRINTF, __func__, p=
eerid, sd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_DCO_DEBUG, &quot;%s: peer-id %u, fd &quot; SOCKET_PRINTF, __func__, peeri=
d, sd);</span><br><span> </span><br><span>     if (dco-&gt;ifmode =3D=3D DC=
O_MODE_P2P)</span><br><span>     {</span><br><span>@@ -460,7 +460,7 @@</spa=
n><br><span> int</span><br><span> dco_del_peer(dco_context_t *dco, unsigned=
 int peerid)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__, peerid=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEB=
UG, &quot;%s: peer-id %u&quot;, __func__, peerid);</span><br><span> </span>=
<br><span>     OVPN_MP_DEL_PEER del_peer =3D { peerid };</span><br><span>  =
   VOID *buf =3D NULL;</span><br><span>@@ -487,7 +487,7 @@</span><br><span>=
 dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_interv=
al, int keepalive_timeout,</span><br><span>              int mss)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DC=
O_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __func__, pee=
rid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_D=
EBUG, &quot;%s: peer-id %u, keepalive %d/%d, mss %d&quot;, __func__, peerid=
,</span><br><span>         keepalive_interval, keepalive_timeout, mss);</sp=
an><br><span> </span><br><span>     OVPN_MP_SET_PEER mp_peer =3D { peerid, =
keepalive_interval, keepalive_timeout, mss };</span><br><span>@@ -522,7 +52=
2,7 @@</span><br><span>             const uint8_t *encrypt_key, const uint8=
_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><span>             co=
nst uint8_t *decrypt_iv, const char *ciphername, bool epoch)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEB=
UG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s&quot;, __func__, sl=
ot, keyid, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %u, cipher %s&quo=
t;, __func__, slot, keyid, peerid,</span><br><span>         ciphername);</s=
pan><br><span> </span><br><span>     const int nonce_len =3D 8;</span><br><=
span>@@ -575,7 +575,7 @@</span><br><span> int</span><br><span> dco_del_key(=
dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO, &=
quot;%s: peer-id %d, slot %d called but ignored&quot;, __func__, peerid, sl=
ot);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO, =
&quot;%s: peer-id %u, slot %d called but ignored&quot;, __func__, peerid, s=
lot);</span><br><span>     /* FIXME: Implement in driver first */</span><br=
><span>     return 0;</span><br><span> }</span><br><span>@@ -583,7 +583,7 @=
@</span><br><span> int</span><br><span> dco_swap_keys(dco_context_t *dco, u=
nsigned int peer_id)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__=
, peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peer_id);</span><br><spa=
n> </span><br><span>     OVPN_MP_SWAP_KEYS swap =3D { peer_id };</span><br>=
<span>     DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;</span><br><span>@@ -667,7 =
+667,7 @@</span><br><span>     BOOL res =3D GetOverlappedResult(dco-&gt;tt-=
&gt;hand, &amp;dco-&gt;ov, &amp;bytes_read, FALSE);</span><br><span>     if=
 (res)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        msg(D_DCO_DEBUG, &quot;%s: completion%s success [%ld]&quot;=
, __func__, queued ? &quot;&quot; : &quot; non-queued&quot;,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DCO_DEBUG, &quot;%s:=
 completion%s success [%lu]&quot;, __func__, queued ? &quot;&quot; : &quot;=
 non-queued&quot;,</span><br><span>             bytes_read);</span><br><spa=
n> </span><br><span>         dco-&gt;dco_message_peer_id =3D dco-&gt;notif_=
buf=2EPeerId;</span><br><span>@@ -1016,7 +1016,7 @@</span><br><span>       =
  =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbits =3D netbits, =2EPeerI=
d =3D peer_id, =2EIPv6 =3D 0</span><br><span>     };</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot=
;%s: %s/%d -&gt; peer %d&quot;, __func__, print_in_addr_t(dst, IA_NET_ORDER=
, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_DCO_DEBUG, &quot;%s: %s/%u -&gt; peer %u&quot;, __func__, print_in_addr_t=
(dst, IA_NET_ORDER, &amp;gc),</span><br><span>         netbits, peer_id);</=
span><br><span> </span><br><span>     DWORD bytes_returned =3D 0;</span><br=
><span>@@ -1037,7 +1037,7 @@</span><br><span> </span><br><span>     OVPN_MP=
_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPee=
rId =3D peer_id, =2EIPv6 =3D 1 };</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: %s/%d -&gt; =
peer %d&quot;, __func__, print_in6_addr(dst, IA_NET_ORDER, &amp;gc),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot=
;%s: %s/%u -&gt; peer %u&quot;, __func__, print_in6_addr(dst, IA_NET_ORDER,=
 &amp;gc),</span><br><span>         netbits, peer_id);</span><br><span> </s=
pan><br><span>     DWORD bytes_returned =3D 0;</span><br><span>@@ -1059,7 +=
1059,7 @@</span><br><span>         =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst,=
 =2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 0</span><br><span>  =
   };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    msg(D_DCO_DEBUG, &quot;%s: %s/%d&quot;, __func__, print_in_addr_t(dst=
, IA_NET_ORDER, &amp;gc), netbits);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%u&quot;, __func__, print=
_in_addr_t(dst, IA_NET_ORDER, &amp;gc), netbits);</span><br><span> </span><=
br><span>     DWORD bytes_returned =3D 0;</span><br><span>     if (!DeviceI=
oControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IROUTE, &amp;route, sizeof(=
route), NULL, 0,</span><br><span>@@ -1078,7 +1078,7 @@</span><br><span> </s=
pan><br><span>     OVPN_MP_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2EN=
etbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 1 };</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &qu=
ot;%s: %s/%d&quot;, __func__, print_in6_addr(dst, IA_NET_ORDER, &amp;gc), n=
etbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_D=
CO_DEBUG, &quot;%s: %s/%u&quot;, __func__, print_in6_addr(dst, IA_NET_ORDER=
, &amp;gc), netbits);</span><br><span> </span><br><span>     DWORD bytes_re=
turned =3D 0;</span><br><span>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand=
, OVPN_IOCTL_MP_DEL_IROUTE, &amp;route, sizeof(route), NULL, 0,</span><br><=
span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/event=2Ec</span><br><=
span>index 2cb4e04=2E=2E4089401 100644</span><br><span>--- a/src/openvpn/ev=
ent=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span><br><span>@@ -117=
,7 +117,7 @@</span><br><span>     }</span><br><span>     else</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_FATAL, &quot;fatal error in we_set_events: rwflags=3D%d&quot;, rwflags);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL,=
 &quot;fatal error in we_set_events: rwflags=3D%u&quot;, rwflags);</span><b=
r><span>     }</span><br><span> </span><br><span>     wes-&gt;esr[i]=2Erwfl=
ags =3D rwflags;</span><br><span>@@ -378,7 +378,7 @@</span><br><span>      =
           break;</span><br><span> </span><br><span>             default:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_F=
ATAL, &quot;fatal error in we_ctl: rwflags=3D%d&quot;, rwflags);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_FATAL, &=
quot;fatal error in we_ctl: rwflags=3D%u&quot;, rwflags);</span><br><span> =
        }</span><br><span>     }</span><br><span>     return;</span><br><sp=
an>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec</span><br><=
span>index b6d93c7=2E=2E0aef2d4 100644</span><br><span>--- a/src/openvpn/ma=
nage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</span><br><span>@@ -1=
503,7 +1503,7 @@</span><br><span>     }</span><br><span>     else if (streq=
(p[0], &quot;pid&quot;))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(M_CLIENT, &quot;SUCCESS: pid=3D%d&quo=
t;, platform_getpid());</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_CLIENT, &quot;SUCCESS: pid=3D%u&quot;, platform_getpid())=
;</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;nc=
lients&quot;))</span><br><span>     {</span><br><span>diff --git a/src/open=
vpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>index 959f7b3=2E=2E1c=
f2a21 100644</span><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>++=
+ b/src/openvpn/multi=2Ec</span><br><span>@@ -164,7 +164,7 @@</span><br><sp=
an>     struct hash_iterator hi;</span><br><span>     struct hash_element *=
he;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    dmsg(D_MULTI_DEBUG, &quot;MULTI: REAP range %d -&gt; %d&quot;, start_bu=
cket, end_bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   dmsg(D_MULTI_DEBUG, &quot;MULTI: REAP range %u -&gt; %u&quot;, start_buc=
ket, end_bucket);</span><br><span>     hash_iterator_init_range(m-&gt;vhash=
, &amp;hi, start_bucket, end_bucket);</span><br><span>     while ((he =3D h=
ash_iterator_next(&amp;hi)) !=3D NULL)</span><br><span>     {</span><br><sp=
an>@@ -271,7 +271,7 @@</span><br><span>     struct multi_context *m =3D t-&=
gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDEF;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_MULTI_LOW,=
 &quot;MULTI: multi_init called, r=3D%d v=3D%d&quot;, t-&gt;options=2Ereal_=
hash_size,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%u v=3D%u&quot;, t-&gt;opti=
ons=2Ereal_hash_size,</span><br><span>         t-&gt;options=2Evirtual_hash=
_size);</span><br><span> </span><br><span>     /*</span><br><span>@@ -430,7=
 +430,7 @@</span><br><span>         if (mi-&gt;context=2Ec2=2Etls_multi &am=
p;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span>             &amp;&a=
mp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_printf=
(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=2Ec2=2Etls_multi-&g=
t;rx_peer_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       buf_printf(&amp;out, &quot; rx-peer-id=3D%u&quot;, mi-&gt;context=2E=
c2=2Etls_multi-&gt;rx_peer_id);</span><br><span>         }</span><br><span>=
         return BSTR(&amp;out);</span><br><span>     }</span><br><span>@@ -=
735,7 +735,7 @@</span><br><span>     if (hash_n_elements(m-&gt;hash) &gt;=
=3D m-&gt;max_clients)</span><br><span>     {</span><br><span>         msg(=
D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      &quot;MULTI: new incoming connection would exceed maximum number of c=
lients (%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;MULTI: new incoming connection would exceed maximum number=
 of clients (%u)&quot;,</span><br><span>             m-&gt;max_clients);</s=
pan><br><span>         goto err;</span><br><span>     }</span><br><span>@@ =
-996,7 +996,7 @@</span><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span>=
     if (m-&gt;inotify_watchers)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_DEBUG, &quot;inotify =
watchers count: %d&quot;, hash_n_elements(m-&gt;inotify_watchers));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_DEBUG, =
&quot;inotify watchers count: %u&quot;, hash_n_elements(m-&gt;inotify_watch=
ers));</span><br><span>     }</span><br><span> #endif</span><br><span> }</s=
pan><br><span>@@ -1302,7 +1302,7 @@</span><br><span>         }</span><br><s=
pan>         for (ir6 =3D mi-&gt;context=2Eoptions=2Eiroutes_ipv6; ir6 !=3D=
 NULL; ir6 =3D ir6-&gt;next)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI_LOW, &quot;MULTI:=
 internal route %s/%d -&gt; %s&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;MULTI: internal route =
%s/%u -&gt; %s&quot;,</span><br><span>                 print_in6_addr(ir6-&=
gt;network, 0, &amp;gc), ir6-&gt;netbits,</span><br><span>                 =
multi_instance_string(mi, false, &amp;gc));</span><br><span> </span><br><sp=
an>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec</span><=
br><span>index bce5018=2E=2E51c7d31 100644</span><br><span>--- a/src/openvp=
n/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=2Ec</span><br><sp=
an>@@ -439,7 +439,7 @@</span><br><span>         default:</span><br><span>  =
       {</span><br><span>             struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_FATAL, &=
quot;MULTI IO: multi_io_post bad state, mi=3D%s flags=3D%d&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL, &quo=
t;MULTI IO: multi_io_post bad state, mi=3D%s flags=3D%u&quot;,</span><br><s=
pan>                 multi_instance_string(mi, false, &amp;gc), flags);</sp=
an><br><span>             gc_free(&amp;gc);</span><br><span>             br=
eak;</span><br><span>diff --git a/src/openvpn/networking_sitnl=2Ec b/src/op=
envpn/networking_sitnl=2Ec</span><br><span>index 8a0a360=2E=2E83915db 10064=
4</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec</span><br><span>++=
+ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ -222,7 +222,7 @@</s=
pan><br><span> </span><br><span>     if (addr_len !=3D sizeof(local))</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    msg(M_WARN, &quot;%s: wrong address length %d&quot;, __func__, addr_len=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WAR=
N, &quot;%s: wrong address length %u&quot;, __func__, (unsigned int)addr_le=
n);</span><br><span>         return -EINVAL;</span><br><span>     }</span><=
br><span> </span><br><span>@@ -528,7 +528,7 @@</span><br><span> </span><br>=
<span>     if (!if_indextoname(ifindex, res-&gt;iface))</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_WARN=
 | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifname for index %d&quot;, __func=
__, ifindex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifname for index %u&q=
uot;, __func__, ifindex);</span><br><span>         return -1;</span><br><sp=
an>     }</span><br><span> </span><br><span>@@ -1216,7 +1216,7 @@</span><br=
><span>         gw_ptr =3D &amp;gw_be;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, =
&quot;%s: %s/%d via %s dev %s table %d metric %d&quot;, __func__,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s=
/%d via %s dev %s table %u metric %d&quot;, __func__,</span><br><span>     =
    inet_ntop(AF_INET, &amp;dst_be, dst_str, sizeof(dst_str)), prefixlen,</=
span><br><span>         inet_ntop(AF_INET, &amp;gw_be, gw_str, sizeof(gw_st=
r)), np(iface), table, metric);</span><br><span> </span><br><span>@@ -1242,=
7 +1242,7 @@</span><br><span>         gw_v6=2Eipv6 =3D *gw;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&quot;=
, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,<=
/span><br><span>         inet_ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_str, s=
izeof(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET6, &a=
mp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);</span>=
<br><span> </span><br><span>@@ -1293,7 +1293,7 @@</span><br><span>         =
gw_v4=2Eipv4 =3D htonl(*gw);</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: =
%s/%d via %s dev %s table %d metric %d&quot;, __func__,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s=
 dev %s table %u metric %d&quot;, __func__,</span><br><span>         inet_n=
top(AF_INET, &amp;dst_v4=2Eipv4, dst_str, sizeof(dst_str)), prefixlen,</spa=
n><br><span>         inet_ntop(AF_INET, &amp;gw_v4=2Eipv4, gw_str, sizeof(g=
w_str)), np(iface), table, metric);</span><br><span> </span><br><span>@@ -1=
319,7 +1319,7 @@</span><br><span>         gw_v6=2Eipv6 =3D *gw;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&q=
uot;, __func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func=
__,</span><br><span>         inet_ntop(AF_INET6, &amp;dst_v6=2Eipv6, dst_st=
r, sizeof(dst_str)), prefixlen,</span><br><span>         inet_ntop(AF_INET6=
, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/options=2Ec b/src/=
openvpn/options=2Ec</span><br><span>index dcc4dac=2E=2E30e497c 100644</span=
><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/src/openvpn/=
options=2Ec</span><br><span>@@ -4548,7 +4548,7 @@</span><br><span>         =
{</span><br><span>             if (netbits &lt; 64 || netbits &gt; 124)</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                msg(msglevel, &quot;ifconfig-ipv6: /netbits must be b=
etween 64 and 124, not &#39;/%d&#39;&quot;,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                msg(msglevel, &quot;ifconfig-ipv6: =
/netbits must be between 64 and 124, not &#39;/%u&#39;&quot;,</span><br><sp=
an>                     netbits);</span><br><span>                 goto err=
;</span><br><span>             }</span><br><span>@@ -5826,7 +5826,7 @@</spa=
n><br><span>         }</span><br><span>         if (netbits &lt; 64 || netb=
its &gt; 124)</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            msg(msglevel, &quot;--server-ipv6 settings: =
network must be between /64 and /124 (not /%d)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;--server-=
ipv6 settings: network must be between /64 and /124 (not /%u)&quot;,</span>=
<br><span>                 netbits);</span><br><span> </span><br><span>    =
         goto err;</span><br><span>@@ -5939,7 +5939,7 @@</span><br><span>  =
       if (netbits &lt; 64 || netbits &gt; 124)</span><br><span>         {<=
/span><br><span>             msg(msglevel,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                &quot;--ifconfig-ipv6-pool settings: n=
etwork must be between /64 and /124 (not /%d)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                &quot;--ifconfig-ipv6-poo=
l settings: network must be between /64 and /124 (not /%u)&quot;,</span><br=
><span>                 netbits);</span><br><span>             goto err;</s=
pan><br><span>         }</span><br><span>diff --git a/src/openvpn/options_s=
how=2Ec b/src/openvpn/options_show=2Ec</span><br><span>index ff090774=2E=2E=
80d36f0 100644</span><br><span>--- a/src/openvpn/options_show=2Ec</span><br=
><span>+++ b/src/openvpn/options_show=2Ec</span><br><span>@@ -136,7 +136,7 =
@@</span><br><span>     msg(D_SHOW_PARMS, &quot;  server_network =3D %s&quo=
t;, print_in_addr_t(o-&gt;server_network, 0, &amp;gc));</span><br><span>   =
  msg(D_SHOW_PARMS, &quot;  server_netmask =3D %s&quot;, print_in_addr_t(o-=
&gt;server_netmask, 0, &amp;gc));</span><br><span>     msg(D_SHOW_PARMS, &q=
uot;  server_network_ipv6 =3D %s&quot;, print_in6_addr(o-&gt;server_network=
_ipv6, 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   SHOW_INT(server_netbits_ipv6);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_UINT(server_netbits_ipv6);</span><br><span>     msg(=
D_SHOW_PARMS, &quot;  server_bridge_ip =3D %s&quot;, print_in_addr_t(o-&gt;=
server_bridge_ip, 0, &amp;gc));</span><br><span>     msg(D_SHOW_PARMS, &quo=
t;  server_bridge_netmask =3D %s&quot;,</span><br><span>         print_in_a=
ddr_t(o-&gt;server_bridge_netmask, 0, &amp;gc));</span><br><span>@@ -170,8 =
+170,8 @@</span><br><span>     SHOW_INT(ifconfig_ipv6_pool_netbits);</span>=
<br><span>     SHOW_INT(n_bcast_buf);</span><br><span>     SHOW_INT(tcp_que=
ue_limit);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_IN=
T(real_hash_size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 SHOW_INT(virtual_hash_size);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_UINT(real_hash_size);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    SHOW_UINT(virtual_hash_size);</span><br><span>    =
 SHOW_STR(client_connect_script);</span><br><span>     SHOW_STR(learn_addre=
ss_script);</span><br><span>     SHOW_STR(client_disconnect_script);</span>=
<br><span>@@ -444,10 +444,10 @@</span><br><span> #if defined(TARGET_LINUX)<=
/span><br><span>     SHOW_INT(mark);</span><br><span> #endif</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(sockflags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(sockflags);</span=
><br><span> </span><br><span>     SHOW_INT(comp=2Ealg);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(comp=2Eflags);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(comp=2Eflags);</spa=
n><br><span> </span><br><span>     SHOW_STR(route_script);</span><br><span>=
     SHOW_STR(route_default_gateway);</span><br><span>@@ -482,7 +482,7 @@</=
span><br><span>     SHOW_INT(management_echo_buffer_size);</span><br><span>=
     SHOW_STR(management_client_user);</span><br><span>     SHOW_STR(manage=
ment_client_group);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  SHOW_INT(management_flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    SHOW_UINT(management_flags);</span><br><span> #endif</span><b=
r><span> #ifdef ENABLE_PLUGIN</span><br><span>     if (o-&gt;plugin_list)</=
span><br><span>@@ -547,7 +547,7 @@</span><br><span>         int i;</span><b=
r><span>         for (i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span>     =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            SHOW=
_INT(remote_cert_ku[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            SHOW_UINT(remote_cert_ku[i]);</span><br><span>         }</=
span><br><span>     }</span><br><span>     SHOW_STR(remote_cert_eku);</span=
><br><span>@@ -567,7 +567,7 @@</span><br><span>         }</span><br><span> =
        gc_free(&amp;gc);</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    SHOW_INT(ssl_flags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(ssl_flags);</span><br><span=
> </span><br><span>     SHOW_INT(tls_timeout);</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec</spa=
n><br><span>index 400c722=2E=2E91cc0ad 100644</span><br><span>--- a/src/ope=
nvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platform=2Ec</span><br>=
<span>@@ -578,7 +578,7 @@</span><br><span>         }</span><br><span>     }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 msg(M_WARN, &quot;Failed to create temporary file after %i attempts&quot;,=
 attempts);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
M_WARN, &quot;Failed to create temporary file after %u attempts&quot;, atte=
mpts);</span><br><span>     return NULL;</span><br><span> }</span><br><span=
> </span><br><span>diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=
=2Ec</span><br><span>index b3aee37=2E=2Ece25cc0 100644</span><br><span>--- =
a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/route=2Ec</span><=
br><span>@@ -823,7 +823,7 @@</span><br><span>                 {</span><br><=
span>                     need_remote_ipv6_route =3D true;</span><br><span>=
                     msg(D_ROUTE,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                        &quot;ROUTE6: %s/%d overlaps IPv6 remot=
e %s, adding host route to VPN endpoint&quot;,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                        &quot;ROUTE6: %s/%u over=
laps IPv6 remote %s, adding host route to VPN endpoint&quot;,</span><br><sp=
an>                         print_in6_addr(r6-&gt;network, 0, &amp;gc), r6-=
&gt;netbits,</span><br><span>                         print_in6_addr(*remot=
e_host_ipv6, 0, &amp;gc));</span><br><span>                 }</span><br><sp=
an>@@ -1353,7 +1353,7 @@</span><br><span>         struct buffer name2 =3D a=
lloc_buf_gc(256, &amp;gc);</span><br><span> </span><br><span>         buf_p=
rintf(&amp;name1, &quot;route_ipv6_network_%d&quot;, i);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;val, &quot;%s/%d=
&quot;, print_in6_addr(r6-&gt;network, 0, &amp;gc), r6-&gt;netbits);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;va=
l, &quot;%s/%u&quot;, print_in6_addr(r6-&gt;network, 0, &amp;gc), r6-&gt;ne=
tbits);</span><br><span>         setenv_str(es, BSTR(&amp;name1), BSTR(&amp=
;val));</span><br><span> </span><br><span>         buf_printf(&amp;name2, &=
quot;route_ipv6_gateway_%d&quot;, i);</span><br><span>@@ -1801,10 +1801,10 =
@@</span><br><span> #endif</span><br><span> </span><br><span> #ifndef _WIN3=
2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &qu=
ot;add_route_ipv6(%s/%d -&gt; %s metric %d) dev %s&quot;, network, r6-&gt;n=
etbits, gateway,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 msg(D_ROUTE, &quot;add_route_ipv6(%s/%u -&gt; %s metric %d) dev %s&quot;, =
network, r6-&gt;netbits, gateway,</span><br><span>         r6-&gt;metric, d=
evice);</span><br><span> #else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    msg(D_ROUTE, &quot;add_route_ipv6(%s/%d -&gt; %s metric %d) IF=
 %lu&quot;, network, r6-&gt;netbits, gateway,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;add_route_ipv6(%s/%u -&gt;=
 %s metric %d) IF %lu&quot;, network, r6-&gt;netbits, gateway,</span><br><s=
pan>         r6-&gt;metric, r6-&gt;adapter_index ? r6-&gt;adapter_index : t=
t-&gt;adapter_index);</span><br><span> #endif</span><br><span> </span><br><=
span>@@ -1830,7 +1830,7 @@</span><br><span>             &quot;ROUTE6 WARNIN=
G: &quot; PACKAGE_NAME &quot; needs a gateway &quot;</span><br><span>      =
       &quot;parameter for a --route-ipv6 option and no default was set via=
 &quot;</span><br><span>             &quot;--ifconfig-ipv6 or --route-ipv6-=
gateway option=2E  Not installing &quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            &quot;IPv6 route to %s/%d=2E&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;IPv6 route=
 to %s/%u=2E&quot;,</span><br><span>             network, r6-&gt;netbits);<=
/span><br><span>         status =3D 0;</span><br><span>         goto done;<=
/span><br><span>@@ -2220,7 +2220,7 @@</span><br><span>     }</span><br><spa=
n> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_ROUTE, &quot;delete_route_ipv6(%s/%d)&quot;, network, r6-&g=
t;netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(=
D_ROUTE, &quot;delete_route_ipv6(%s/%u)&quot;, network, r6-&gt;netbits);</s=
pan><br><span> </span><br><span> #if defined(TARGET_LINUX)</span><br><span>=
     int metric =3D -1;</span><br><span>diff --git a/src/openvpn/socket=2Ec=
 b/src/openvpn/socket=2Ec</span><br><span>index 41c8bac=2E=2E33def4e 100644=
</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><span>+++ b/src/ope=
nvpn/socket=2Ec</span><br><span>@@ -831,7 +831,8 @@</span><br><span>     el=
se if (remote_len_af &amp;&amp; remote_len !=3D remote_len_af)</span><br><s=
pan>     {</span><br><span>         msg(D_LINK_ERRORS,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            &quot;TCP: Received strange in=
coming connection with unknown address length=3D%d&quot;, remote_len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;TCP: R=
eceived strange incoming connection with unknown address length=3D%u&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            (unsign=
ed int)remote_len);</span><br><span>         openvpn_close_socket(new_sd);<=
/span><br><span>         new_sd =3D SOCKET_UNDEFINED;</span><br><span>     =
}</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_nc=
p=2Ec</span><br><span>index 8b0f28d=2E=2Ef13f507 100644</span><br><span>---=
 a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openvpn/ssl_ncp=2Ec</s=
pan><br><span>@@ -508,7 +508,7 @@</span><br><span>     }</span><br><span> <=
/span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;P2P mode NCP negotiation re=
sult: &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %d, tx-peer=
-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                         &quot;TLS_export=3D%d, DATA_v2=
=3D%d, rx-peer-id %u, tx-peer-id %u, epoch=3D%d, cipher=3D%s&quot;,</span><=
br><span>         (bool)(session-&gt;opt-&gt;crypto_flags &amp; CO_USE_TLS_=
KEY_MATERIAL_EXPORT),</span><br><span>         multi-&gt;use_peer_id,</span=
><br><span>         multi-&gt;rx_peer_id,</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958?usp=3Demail">ch=
ange 1958</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1958 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: Fran=
k Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-ope=
nvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openv=
pn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></h=
tml>
--pJIS5gicZlU=--


--===============2015864109445951225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2015864109445951225==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============2015864109445951225==--

