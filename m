Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0BECA5FCE
	for <openvpn-devel@archiver.kernel.org>; Sun,  4 Oct 2026 09:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vt+6nZgSR2knJUQEafTzrdzlxAyK80VArOwn5znmRF4=; b=Z6PIpimaegkhhUzt+fEBdjko2a
	qA5v2fYoCtfZ0/vSDnR2XgxwG1NhVUe3NbDg2txOoDZGkRnDMvzNPiB0HrNERAd82h5nx2VPlgLWW
	ew4WgmM99knvonhNl2080IDeW+kXF5t8QX8SoxE9dyKzB3Fm6EwTGW0g0Kh41SC7kyY0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xDICK-000849-K6;
	Sun, 04 Oct 2026 09:07:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xDICI-00083n-3c
 for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:07:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=ZATCUuSKoNRM4MlJGTDmtauT4/S0jF3CURxIG8QByIQ=; b=dXyYbtkXiMHLif2r0JHRvU4tbn
 FhMFJZedQvFfynftVJRGpDsKbn7ZNY0euHAdAY/JyMaAy7T6uQPYmq5n3SRC3huIKPb2ziTTPdE7t
 ZwFOs1iSyaSEspumfohu6HpQFMrktHvAVYynECItGBdS6DU/64sV3vjxn9RwGDNMTrc4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ZATCUuSKoNRM4MlJGTDmtauT4/S0jF3CURxIG8QByIQ=; b=k
 +1I3XxmAR5CqDpdw3D4TgvNdXxTivNWZYaJHetl3bhbGXUhtSVGVJLjOCf+vAqz0lW3InYGQsyUJP
 wPnOFBZWaGhLetQuZCaC2+cXFYH2NLurXJ++Xb4/+ixZELOgQU5AhA9DGyYSPybxsBP6jA00adhQe
 bayq+ZZMARJTjnSA=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDICC-0005IM-KS for openvpn-devel@lists.sourceforge.net;
 Sun, 04 Oct 2026 09:07:51 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a024e16179so4927115e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Sun, 04 Oct 2026 02:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1791104862; x=1791709662; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZATCUuSKoNRM4MlJGTDmtauT4/S0jF3CURxIG8QByIQ=;
 b=JmmNF710I+jWGI9WodLYDzI9pWPyD3PFIQTkZfaXIfqn2/4yERSrYR+VH1XJVCZyab
 7PSKUAYoMXouRkS2sHkhuXx64VFZxFimh/x1pg2VP/Mk3S2mnkXDr9Qeqe70//suT9To
 DzC8t1KGzGpaPX6MTuLJqLBAqQae+/FBpghxMHvVHP1I32uw8proTu1s7k2Ha3tew7S6
 89yALZhQGBzZiB5eNsuSvnHqi52EBBa258djBhWVhDC3Mbv05OvV8S0rD5dff7Iwfghy
 Fa7nPH8zddv966459f7O4pjoL6NfbcUFAx6zookUdvNxERYPE7BJP8FCu6nOeXw8S0B/
 p2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791104862; x=1791709662;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZATCUuSKoNRM4MlJGTDmtauT4/S0jF3CURxIG8QByIQ=;
 b=eBcl81diOYTyKy70ZIXV369MmHndedwiDAU745WEzm94faUBYHPqS5Ho9TJM2h8w/a
 vqH3Hk+2DFUcHWBndaGnz54RKBIxoqXGI9JQPTGmtu12fPylZxLA9KrrLaGIuWQ+y0xV
 wImQERW636yXHSaYqkjxYimwVYcMSBP4D1W14OlVFlx+2iWevBZtkcfEOOBQFoKtR1VH
 8VoGiMr7UuPXqqBe9I4vUdT2P1I92itquThwRyNd2uCxzrKE5M/UwI/bU9t8NBZ9Zkj9
 galSEp8duR8aLQJdsbXekRHjsA3Bhx77NhGM45YS0+j12l46Irr8Sv38a8y+lcckOvKo
 lXGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkvdLx/hRbVkG48M47kyI9hzHh41mBDB7lqo4G9fkSo5bJYoJav2432s/WikHkl/yF4LjtK3Q7/g4u8LEN@lists.sourceforge.net
X-Gm-Message-State: AFuF++n1b/oezHBj6hwxyhPF7e0kPwIpUYzSxljZO27hNYresMC3tzkF
 p6MWyP6gUiPx9VgFz9NoGUPJ2oblhZ938LvkgXaM3mQRQFfu9x1/6oHj9Uz6Pvh02RNls5KhgFR
 gJdTM9pJqvGsDBrsWsHQ9Z+qB7JEFdR8/xfdZ8jzSNzx/MqA6HTQ1tAK/fcRCp77GsaHE
X-Gm-Gg: AYBFou2Un4tTJpIhvb5h0GWV0c8u5VoMAWLZmBxowBpoYx/WbnPHyl5QygKrQpprdC6
 bilfHDQ7hWNK0Gl6UgLR4kteaPftUQvnAY4ic+4W5UgfjytyuUH1kZw52JdyCLxOGy6Xd8Veg1U
 vryWpZT4gmUwE0VaEcRgtf/q/IU0Lqr6xh1X/WCYabodbMtFGJnwS7Nm4tIlRCRNyv4oCfXelGH
 HA+m97Gfd6BJqRfLEOIOPPeUzKr7jk88SHel3In3fKD7xpgAak5cKOdzTI00TergapDLsAvSpxQ
 g/X73pXuKgFM246upa01UB1JlnIgdE4NYkXbPs5tzSpGK9pKzNiXk9SlHY9yvHAP6vasb5FWbyU
 AcfNUz1LI/wSRwuL8zbOjnbdSSgDz3oN69o2C7eApjXaTmBTOOed1HIbceSXkKn3+OMGe7dme+1
 kGgtVAZu9ybBAyNLh//PTQkHiDfzlQpr8RytHxS9SJSj3hIaTea5SM5Dwoni0P+XkJfhibxW7/8
 W7AamR+0kVhu2cJwf11HwBjugRFOWIQxiM45UkU5EXI0EHpLP/kHIb1tASGdEWz2b9hgoAVCZyJ
 hL3Fqfw/0RGcniT1p0/PqgGyNl6eRBSn1b8Gscqz0deyiPA5qprSnmyHTnL7
X-Received: by 2002:a05:600c:3ca2:b0:4a1:70ed:882b with SMTP id
 5b1f17b1804b1-4a170ed8cb8mr9684705e9.8.1791104861643; 
 Sun, 04 Oct 2026 02:07:41 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0e1afbc44sm235243115e9.4.2026.10.04.02.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 02:07:41 -0700 (PDT)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Sun, 4 Oct 2026 09:07:40 +0000
To: Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 4
X-Gerrit-Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3
X-Gerrit-Change-Number: 1958
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1958?usp=email>
X-Gerrit-Commit: 02d1e01f93d1125646e2645795a5c60acbc68b47
In-Reply-To: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
References: <gerrit.1790610390000.I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNjEwMzkwMDAwLkkwYjM5ZDZhMGZiMmU2ZGJiNjgzZTk1NTVmMDM2NTM1M2M0ZWRhOGQzQGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <58ee08cf87717cf1104f507aae524eb15e9d95d3-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xDICC-0005IM-KS
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 plaisthos <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============8246891799577679112=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============8246891799577679112==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t345T9Nvzuw="; charset=UTF-8

--t345T9Nvzuw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1958?usp=3Demail )

Change subject: Fix all occurrences of cppc=
heck invalidPrintfArgType_sint
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E

Fix all occurrences of cppcheck invalidPrintfArgType_si=
nt

Mostly trivially correct=2E The only exception is socklen_t which
can b=
e of various types=2E In Linux it is uint32_t and in all cases
it should be=
 a small unsigned number=2E So print it as that=2E

Change-Id: I0b39d6a0fb2=
e6dbb683e9555f0365353c4eda8d3
Signed-off-by: Frank Lichtenheld <frank@licht=
enheld=2Ecom>
Acked-by: Razvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit URL:=
 https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958
Message-Id: <2026100320434=
2=2E19505-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/=
openvpn-devel@lists=2Esourceforge=2Enet/msg39678=2Ehtml
Signed-off-by: Gert=
 Doering <gert@greenie=2Emuc=2Ede>
---
M dev-tools/cppcheck-suppressions=2E=
xml
M src/openvpn/crypto=2Ec
M src/openvpn/dco_linux=2Ec
M src/openvpn/dco_=
win=2Ec
M src/openvpn/event=2Ec
M src/openvpn/manage=2Ec
M src/openvpn/mult=
i=2Ec
M src/openvpn/multi_io=2Ec
M src/openvpn/networking_sitnl=2Ec
M src/o=
penvpn/options=2Ec
M src/openvpn/options_show=2Ec
M src/openvpn/platform=2E=
c
M src/openvpn/route=2Ec
M src/openvpn/socket=2Ec
M src/openvpn/ssl_ncp=2E=
c
15 files changed, 59 insertions(+), 61 deletions(-)




diff --git a/dev-=
tools/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml
i=
ndex cd37c41=2E=2E0d5416a 100644
--- a/dev-tools/cppcheck-suppressions=2Exm=
l
+++ b/dev-tools/cppcheck-suppressions=2Exml
@@ -12,9 +12,6 @@
     <id>co=
nstParameterPointer</id>
   </suppress>
   <suppress>
-    <id>invalidPrint=
fArgType_sint</id>
-  </suppress>
-  <suppress>
     <id>invalidPrintfArgTy=
pe_uint</id>
   </suppress>
   <suppress>
diff --git a/src/openvpn/crypto=
=2Ec b/src/openvpn/crypto=2Ec
index 243cf27=2E=2E1703d4d 100644
--- a/src/o=
penvpn/crypto=2Ec
+++ b/src/openvpn/crypto=2Ec
@@ -261,7 +261,7 @@
        =
     if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
 =
            {
                 msg(D_CRYPT_ERRORS,
-                    "EN=
CRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d c=
bs=3D%d",
+                    "ENCRYPT: buffer size error, bc=3D%d bo=3D%d=
 bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%u",
                     buf->capac=
ity, buf->offset, buf->len, work=2Ecapacity, work=2Eoffset, work=2Elen,
   =
                  cipher_ctx_block_size(ctx->cipher));
                 got=
o err;
diff --git a/src/openvpn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec
i=
ndex e583696=2E=2Ea397fb8 100644
--- a/src/openvpn/dco_linux=2Ec
+++ b/src/=
openvpn/dco_linux=2Ec
@@ -231,7 +231,7 @@
     {
         remotestr =3D pri=
nt_sockaddr(remoteaddr, &gc);
     }
-    msg(D_DCO_DEBUG, "%s: peer-id %d,=
 fd %d, remote addr: %s", __func__, peerid, sd, remotestr);
+    msg(D_DCO_=
DEBUG, "%s: peer-id %u, fd %d, remote addr: %s", __func__, peerid, sd, remo=
testr);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CM=
D_PEER_NEW);
     struct nlattr *attr =3D nla_nest_start(nl_msg, OVPN_A_PEE=
R);
@@ -574,7 +574,7 @@
 int
 dco_swap_keys(dco_context_t *dco, unsigned in=
t peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __func__, peerid);
+  =
  msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);
 
     struct nl_ms=
g *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_SWAP);
     if (!nl_m=
sg)
@@ -598,7 +598,7 @@
 int
 dco_del_peer(dco_context_t *dco, unsigned int=
 peerid)
 {
-    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %d", __func__,=
 peerid);
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "%s: peer-id %u", __func__, p=
eerid);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CM=
D_PEER_DEL);
     if (!nl_msg)
@@ -623,7 +623,7 @@
 dco_del_key(dco_context=
_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
     int ret =3D -EMS=
GSIZE;
-    msg(D_DCO_DEBUG, "%s: peer-id %d, slot %d", __func__, peerid, s=
lot);
+    msg(D_DCO_DEBUG, "%s: peer-id %u, slot %d", __func__, peerid, sl=
ot);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_K=
EY_DEL);
     if (!nl_msg)
@@ -648,7 +648,7 @@
             const uint8_t *=
encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
       =
      const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-  =
  msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d=
", __func__, slot, keyid, peerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-i=
d %d, peer-id %u, cipher %s, epoch %d", __func__, slot, keyid, peerid,
    =
     ciphername, epoch);
 
     const size_t key_len =3D cipher_kt_key_size=
(ciphername);
@@ -701,7 +701,7 @@
 dco_set_peer(dco_context_t *dco, unsigne=
d int peerid, int keepalive_interval, int keepalive_timeout,
              =
int mss)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d"=
, __func__, peerid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, keepalive %d/%d,=
 mss %d", __func__, peerid,
         keepalive_interval, keepalive_timeout,=
 mss);
 
     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD=
_PEER_SET);
@@ -968,7 +968,7 @@
     uint32_t ifindex =3D nla_get_u32(attrs=
[OVPN_A_IFINDEX]);
     if (ifindex !=3D dco->ifindex)
     {
-        msg(=
D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex %d", ifindex);=

+        msg(D_DCO_DEBUG, "ovpn-dco: ignoring message for foreign ifindex =
%u", ifindex);
         return false;
     }
 
@@ -1010,7 +1010,7 @@
     i=
nt reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);
     unsigned =
int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);
 
-    msg(D_DCO_DEBU=
G | M_NOIPREFIX, "ovpn-dco: received CMD_PEER_DEL_NTF, ifindex: %d, peer-id=
 %u, reason: %d",
+    msg(D_DCO_DEBUG | M_NOIPREFIX, "ovpn-dco: received C=
MD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reason: %d",
         dco->ifinde=
x, peerid, reason);
     dco->dco_message_peer_id =3D peerid;
     dco->dco=
_del_peer_reason =3D reason;
@@ -1097,7 +1097,7 @@
     int key_id =3D nla_=
get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);
     unsigned int peer_id =3D nla=
_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER_ID]);
 
-    msg(D_DCO_DEBUG, "ovpn-d=
co: received CMD_KEY_SWAP_NTF, ifindex: %d, peer-id %u, key-id: %d",
+    m=
sg(D_DCO_DEBUG, "ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex: %u, peer-id =
%u, key-id: %d",
         dco->ifindex, peer_id, key_id);
     dco->dco_mes=
sage_peer_id =3D peer_id;
     dco->dco_message_key_id =3D key_id;
diff --g=
it a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_win=2Ec
index bd94c1a=2E=2E2=
0d3c27 100644
--- a/src/openvpn/dco_win=2Ec
+++ b/src/openvpn/dco_win=2Ec
@=
@ -56,7 +56,7 @@
         {
             break;
         }
-        msg(D_D=
CO_DEBUG, "interface %ld not yet ready, retrying", idx);
+        msg(D_DCO=
_DEBUG, "interface %lu not yet ready, retrying", idx);
         Sleep(50);
=
     }
 }
@@ -409,7 +409,7 @@
              struct sockaddr *localaddr, str=
uct sockaddr *remoteaddr,
              const struct in_addr *vpn_ipv4, con=
st struct in6_addr *vpn_ipv6)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d, fd =
" SOCKET_PRINTF, __func__, peerid, sd);
+    msg(D_DCO_DEBUG, "%s: peer-id =
%u, fd " SOCKET_PRINTF, __func__, peerid, sd);
 
     if (dco->ifmode =3D=
=3D DCO_MODE_P2P)
     {
@@ -460,7 +460,7 @@
 int
 dco_del_peer(dco_context=
_t *dco, unsigned int peerid)
 {
-    msg(D_DCO_DEBUG, "%s: peer-id %d", __=
func__, peerid);
+    msg(D_DCO_DEBUG, "%s: peer-id %u", __func__, peerid);=

 
     OVPN_MP_DEL_PEER del_peer =3D { peerid };
     VOID *buf =3D NULL;
=
@@ -487,7 +487,7 @@
 dco_set_peer(dco_context_t *dco, unsigned int peerid, =
int keepalive_interval, int keepalive_timeout,
              int mss)
 {
- =
   msg(D_DCO_DEBUG, "%s: peer-id %d, keepalive %d/%d, mss %d", __func__, pe=
erid,
+    msg(D_DCO_DEBUG, "%s: peer-id %u, keepalive %d/%d, mss %d", __fu=
nc__, peerid,
         keepalive_interval, keepalive_timeout, mss);
 
     =
OVPN_MP_SET_PEER mp_peer =3D { peerid, keepalive_interval, keepalive_timeou=
t, mss };
@@ -522,7 +522,7 @@
             const uint8_t *encrypt_key, cons=
t uint8_t *encrypt_iv, const uint8_t *decrypt_key,
             const uint8=
_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-    msg(D_DCO_DEBUG=
, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __func__, slot, keyid, p=
eerid,
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %u, cipher %s=
", __func__, slot, keyid, peerid,
         ciphername);
 
     const int no=
nce_len =3D 8;
@@ -575,7 +575,7 @@
 int
 dco_del_key(dco_context_t *dco, un=
signed int peerid, dco_key_slot_t slot)
 {
-    msg(D_DCO, "%s: peer-id %d,=
 slot %d called but ignored", __func__, peerid, slot);
+    msg(D_DCO, "%s:=
 peer-id %u, slot %d called but ignored", __func__, peerid, slot);
     /* =
FIXME: Implement in driver first */
     return 0;
 }
@@ -583,7 +583,7 @@
 =
int
 dco_swap_keys(dco_context_t *dco, unsigned int peer_id)
 {
-    msg(D_=
DCO_DEBUG, "%s: peer-id %d", __func__, peer_id);
+    msg(D_DCO_DEBUG, "%s:=
 peer-id %u", __func__, peer_id);
 
     OVPN_MP_SWAP_KEYS swap =3D { peer_=
id };
     DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;
@@ -667,7 +667,7 @@
     B=
OOL res =3D GetOverlappedResult(dco->tt->hand, &dco->ov, &bytes_read, FALSE=
);
     if (res)
     {
-        msg(D_DCO_DEBUG, "%s: completion%s success=
 [%ld]", __func__, queued ? "" : " non-queued",
+        msg(D_DCO_DEBUG, "=
%s: completion%s success [%lu]", __func__, queued ? "" : " non-queued",
   =
          bytes_read);
 
         dco->dco_message_peer_id =3D dco->notif_b=
uf=2EPeerId;
@@ -1016,7 +1016,7 @@
         =2EAddr=2EAddr4=2ES_un=2ES_addr=
 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D 0
    =
 };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d -> peer %d", __func__, print_in_addr=
_t(dst, IA_NET_ORDER, &gc),
+    msg(D_DCO_DEBUG, "%s: %s/%u -> peer %u", _=
_func__, print_in_addr_t(dst, IA_NET_ORDER, &gc),
         netbits, peer_id=
);
 
     DWORD bytes_returned =3D 0;
@@ -1037,7 +1037,7 @@
 
     OVPN_MP_=
IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENetbits =3D netbits, =2EPeer=
Id =3D peer_id, =2EIPv6 =3D 1 };
 
-    msg(D_DCO_DEBUG, "%s: %s/%d -> peer=
 %d", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc),
+    msg(D_DCO_DEBU=
G, "%s: %s/%u -> peer %u", __func__, print_in6_addr(dst, IA_NET_ORDER, &gc)=
,
         netbits, peer_id);
 
     DWORD bytes_returned =3D 0;
@@ -1059,7=
 +1059,7 @@
         =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbits =
=3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 0
     };
 
-    msg(D_DCO_DEBUG=
, "%s: %s/%d", __func__, print_in_addr_t(dst, IA_NET_ORDER, &gc), netbits);=

+    msg(D_DCO_DEBUG, "%s: %s/%u", __func__, print_in_addr_t(dst, IA_NET_O=
RDER, &gc), netbits);
 
     DWORD bytes_returned =3D 0;
     if (!DeviceIo=
Control(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route, sizeof(route), NUL=
L, 0,
@@ -1078,7 +1078,7 @@
 
     OVPN_MP_IROUTE route =3D { =2EAddr=2EAdd=
r6 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 1 };
 
- =
   msg(D_DCO_DEBUG, "%s: %s/%d", __func__, print_in6_addr(dst, IA_NET_ORDER=
, &gc), netbits);
+    msg(D_DCO_DEBUG, "%s: %s/%u", __func__, print_in6_ad=
dr(dst, IA_NET_ORDER, &gc), netbits);
 
     DWORD bytes_returned =3D 0;
  =
   if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_MP_DEL_IROUTE, &route, si=
zeof(route), NULL, 0,
diff --git a/src/openvpn/event=2Ec b/src/openvpn/even=
t=2Ec
index 2cb4e04=2E=2E4089401 100644
--- a/src/openvpn/event=2Ec
+++ b/s=
rc/openvpn/event=2Ec
@@ -117,7 +117,7 @@
     }
     else
     {
-        m=
sg(M_FATAL, "fatal error in we_set_events: rwflags=3D%d", rwflags);
+      =
  msg(M_FATAL, "fatal error in we_set_events: rwflags=3D%u", rwflags);
    =
 }
 
     wes->esr[i]=2Erwflags =3D rwflags;
@@ -378,7 +378,7 @@
          =
       break;
 
             default:
-                msg(M_FATAL, "fatal =
error in we_ctl: rwflags=3D%d", rwflags);
+                msg(M_FATAL, "fa=
tal error in we_ctl: rwflags=3D%u", rwflags);
         }
     }
     return=
;
diff --git a/src/openvpn/manage=2Ec b/src/openvpn/manage=2Ec
index b6d93c=
7=2E=2E0aef2d4 100644
--- a/src/openvpn/manage=2Ec
+++ b/src/openvpn/manage=
=2Ec
@@ -1503,7 +1503,7 @@
     }
     else if (streq(p[0], "pid"))
     {
=
-        msg(M_CLIENT, "SUCCESS: pid=3D%d", platform_getpid());
+        ms=
g(M_CLIENT, "SUCCESS: pid=3D%u", platform_getpid());
     }
     else if (s=
treq(p[0], "nclients"))
     {
diff --git a/src/openvpn/multi=2Ec b/src/ope=
nvpn/multi=2Ec
index 959f7b3=2E=2E1cf2a21 100644
--- a/src/openvpn/multi=2E=
c
+++ b/src/openvpn/multi=2Ec
@@ -164,7 +164,7 @@
     struct hash_iterator=
 hi;
     struct hash_element *he;
 
-    dmsg(D_MULTI_DEBUG, "MULTI: REAP =
range %d -> %d", start_bucket, end_bucket);
+    dmsg(D_MULTI_DEBUG, "MULTI=
: REAP range %u -> %u", start_bucket, end_bucket);
     hash_iterator_init_=
range(m->vhash, &hi, start_bucket, end_bucket);
     while ((he =3D hash_it=
erator_next(&hi)) !=3D NULL)
     {
@@ -271,7 +271,7 @@
     struct multi_c=
ontext *m =3D t->multi;
     int dev =3D DEV_TYPE_UNDEF;
 
-    msg(D_MULTI=
_LOW, "MULTI: multi_init called, r=3D%d v=3D%d", t->options=2Ereal_hash_siz=
e,
+    msg(D_MULTI_LOW, "MULTI: multi_init called, r=3D%u v=3D%u", t->opti=
ons=2Ereal_hash_size,
         t->options=2Evirtual_hash_size);
 
     /*
@=
@ -430,7 +430,7 @@
         if (mi->context=2Ec2=2Etls_multi && check_debug=
_level(D_DCO_DEBUG)
             && dco_enabled(&mi->context=2Eoptions))
  =
       {
-            buf_printf(&out, " rx-peer-id=3D%d", mi->context=2Ec2=
=2Etls_multi->rx_peer_id);
+            buf_printf(&out, " rx-peer-id=3D%u"=
, mi->context=2Ec2=2Etls_multi->rx_peer_id);
         }
         return BST=
R(&out);
     }
@@ -735,7 +735,7 @@
     if (hash_n_elements(m->hash) >=3D =
m->max_clients)
     {
         msg(D_MULTI_ERRORS,
-            "MULTI: ne=
w incoming connection would exceed maximum number of clients (%d)",
+      =
      "MULTI: new incoming connection would exceed maximum number of client=
s (%u)",
             m->max_clients);
         goto err;
     }
@@ -996,7 =
+996,7 @@
 #ifdef ENABLE_ASYNC_PUSH
     if (m->inotify_watchers)
     {
- =
       msg(D_MULTI_DEBUG, "inotify watchers count: %d", hash_n_elements(m->=
inotify_watchers));
+        msg(D_MULTI_DEBUG, "inotify watchers count: %u=
", hash_n_elements(m->inotify_watchers));
     }
 #endif
 }
@@ -1302,7 +130=
2,7 @@
         }
         for (ir6 =3D mi->context=2Eoptions=2Eiroutes_ipv=
6; ir6 !=3D NULL; ir6 =3D ir6->next)
         {
-            msg(D_MULTI_LO=
W, "MULTI: internal route %s/%d -> %s",
+            msg(D_MULTI_LOW, "MULT=
I: internal route %s/%u -> %s",
                 print_in6_addr(ir6->networ=
k, 0, &gc), ir6->netbits,
                 multi_instance_string(mi, false,=
 &gc));
 
diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/multi_io=2Ec
=
index bce5018=2E=2E51c7d31 100644
--- a/src/openvpn/multi_io=2Ec
+++ b/src/=
openvpn/multi_io=2Ec
@@ -439,7 +439,7 @@
         default:
         {
     =
        struct gc_arena gc =3D gc_new();
-            msg(M_FATAL, "MULTI I=
O: multi_io_post bad state, mi=3D%s flags=3D%d",
+            msg(M_FATAL, =
"MULTI IO: multi_io_post bad state, mi=3D%s flags=3D%u",
                 m=
ulti_instance_string(mi, false, &gc), flags);
             gc_free(&gc);
  =
           break;
diff --git a/src/openvpn/networking_sitnl=2Ec b/src/openv=
pn/networking_sitnl=2Ec
index 8a0a360=2E=2E83915db 100644
--- a/src/openvpn=
/networking_sitnl=2Ec
+++ b/src/openvpn/networking_sitnl=2Ec
@@ -222,7 +222=
,7 @@
 
     if (addr_len !=3D sizeof(local))
     {
-        msg(M_WARN, "=
%s: wrong address length %d", __func__, addr_len);
+        msg(M_WARN, "%s=
: wrong address length %u", __func__, (unsigned int)addr_len);
         ret=
urn -EINVAL;
     }
 
@@ -528,7 +528,7 @@
 
     if (!if_indextoname(ifinde=
x, res->iface))
     {
-        msg(M_WARN | M_ERRNO, "%s: rtnl: can't get =
ifname for index %d", __func__, ifindex);
+        msg(M_WARN | M_ERRNO, "%=
s: rtnl: can't get ifname for index %u", __func__, ifindex);
         retur=
n -1;
     }
 
@@ -1216,7 +1216,7 @@
         gw_ptr =3D &gw_be;
     }
 
-=
    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+ =
   msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
   =
      inet_ntop(AF_INET, &dst_be, dst_str, sizeof(dst_str)), prefixlen,
   =
      inet_ntop(AF_INET, &gw_be, gw_str, sizeof(gw_str)), np(iface), table,=
 metric);
 
@@ -1242,7 +1242,7 @@
         gw_v6=2Eipv6 =3D *gw;
     }
 
-=
    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d metric %d", __func__,
+ =
   msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u metric %d", __func__,
   =
      inet_ntop(AF_INET6, &dst_v6=2Eipv6, dst_str, sizeof(dst_str)), prefix=
len,
         inet_ntop(AF_INET6, &gw_v6=2Eipv6, gw_str, sizeof(gw_str)), n=
p(iface), table, metric);
 
@@ -1293,7 +1293,7 @@
         gw_v4=2Eipv4 =3D=
 htonl(*gw);
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %d m=
etric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev %s table %u me=
tric %d", __func__,
         inet_ntop(AF_INET, &dst_v4=2Eipv4, dst_str, si=
zeof(dst_str)), prefixlen,
         inet_ntop(AF_INET, &gw_v4=2Eipv4, gw_st=
r, sizeof(gw_str)), np(iface), table, metric);
 
@@ -1319,7 +1319,7 @@
    =
     gw_v6=2Eipv6 =3D *gw;
     }
 
-    msg(D_ROUTE, "%s: %s/%d via %s dev=
 %s table %d metric %d", __func__,
+    msg(D_ROUTE, "%s: %s/%d via %s dev =
%s table %u metric %d", __func__,
         inet_ntop(AF_INET6, &dst_v6=2Eip=
v6, dst_str, sizeof(dst_str)), prefixlen,
         inet_ntop(AF_INET6, &gw_=
v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), table, metric);
 
diff --git=
 a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index dcc4dac=2E=2E30e=
497c 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/options=2Ec
@@ =
-4548,7 +4548,7 @@
         {
             if (netbits < 64 || netbits > 12=
4)
             {
-                msg(msglevel, "ifconfig-ipv6: /netbits m=
ust be between 64 and 124, not '/%d'",
+                msg(msglevel, "ifco=
nfig-ipv6: /netbits must be between 64 and 124, not '/%u'",
               =
      netbits);
                 goto err;
             }
@@ -5826,7 +5826,=
7 @@
         }
         if (netbits < 64 || netbits > 124)
         {
-   =
         msg(msglevel, "--server-ipv6 settings: network must be between /64=
 and /124 (not /%d)",
+            msg(msglevel, "--server-ipv6 settings: n=
etwork must be between /64 and /124 (not /%u)",
                 netbits);
=
 
             goto err;
@@ -5939,7 +5939,7 @@
         if (netbits < 64 ||=
 netbits > 124)
         {
             msg(msglevel,
-                "--i=
fconfig-ipv6-pool settings: network must be between /64 and /124 (not /%d)"=
,
+                "--ifconfig-ipv6-pool settings: network must be between =
/64 and /124 (not /%u)",
                 netbits);
             goto err;
=
         }
diff --git a/src/openvpn/options_show=2Ec b/src/openvpn/options_=
show=2Ec
index ff090774=2E=2E80d36f0 100644
--- a/src/openvpn/options_show=
=2Ec
+++ b/src/openvpn/options_show=2Ec
@@ -136,7 +136,7 @@
     msg(D_SHOW=
_PARMS, "  server_network =3D %s", print_in_addr_t(o->server_network, 0, &g=
c));
     msg(D_SHOW_PARMS, "  server_netmask =3D %s", print_in_addr_t(o->s=
erver_netmask, 0, &gc));
     msg(D_SHOW_PARMS, "  server_network_ipv6 =3D =
%s", print_in6_addr(o->server_network_ipv6, 0, &gc));
-    SHOW_INT(server_=
netbits_ipv6);
+    SHOW_UINT(server_netbits_ipv6);
     msg(D_SHOW_PARMS, =
"  server_bridge_ip =3D %s", print_in_addr_t(o->server_bridge_ip, 0, &gc));=

     msg(D_SHOW_PARMS, "  server_bridge_netmask =3D %s",
         print_in=
_addr_t(o->server_bridge_netmask, 0, &gc));
@@ -170,8 +170,8 @@
     SHOW_I=
NT(ifconfig_ipv6_pool_netbits);
     SHOW_INT(n_bcast_buf);
     SHOW_INT(t=
cp_queue_limit);
-    SHOW_INT(real_hash_size);
-    SHOW_INT(virtual_hash_=
size);
+    SHOW_UINT(real_hash_size);
+    SHOW_UINT(virtual_hash_size);
 =
    SHOW_STR(client_connect_script);
     SHOW_STR(learn_address_script);
 =
    SHOW_STR(client_disconnect_script);
@@ -444,10 +444,10 @@
 #if defined(=
TARGET_LINUX)
     SHOW_INT(mark);
 #endif
-    SHOW_INT(sockflags);
+    S=
HOW_UINT(sockflags);
 
     SHOW_INT(comp=2Ealg);
-    SHOW_INT(comp=2Eflag=
s);
+    SHOW_UINT(comp=2Eflags);
 
     SHOW_STR(route_script);
     SHOW_=
STR(route_default_gateway);
@@ -482,7 +482,7 @@
     SHOW_INT(management_ec=
ho_buffer_size);
     SHOW_STR(management_client_user);
     SHOW_STR(manag=
ement_client_group);
-    SHOW_INT(management_flags);
+    SHOW_UINT(manage=
ment_flags);
 #endif
 #ifdef ENABLE_PLUGIN
     if (o->plugin_list)
@@ -547=
,7 +547,7 @@
         int i;
         for (i =3D 0; i < MAX_PARMS; i++)
   =
      {
-            SHOW_INT(remote_cert_ku[i]);
+            SHOW_UINT(re=
mote_cert_ku[i]);
         }
     }
     SHOW_STR(remote_cert_eku);
@@ -567=
,7 +567,7 @@
         }
         gc_free(&gc);
     }
-    SHOW_INT(ssl_fla=
gs);
+    SHOW_UINT(ssl_flags);
 
     SHOW_INT(tls_timeout);
 
diff --git =
a/src/openvpn/platform=2Ec b/src/openvpn/platform=2Ec
index 400c722=2E=2E91=
cc0ad 100644
--- a/src/openvpn/platform=2Ec
+++ b/src/openvpn/platform=2Ec
=
@@ -578,7 +578,7 @@
         }
     }
 
-    msg(M_WARN, "Failed to create =
temporary file after %i attempts", attempts);
+    msg(M_WARN, "Failed to c=
reate temporary file after %u attempts", attempts);
     return NULL;
 }
 
=
diff --git a/src/openvpn/route=2Ec b/src/openvpn/route=2Ec
index b3aee37=2E=
=2Ece25cc0 100644
--- a/src/openvpn/route=2Ec
+++ b/src/openvpn/route=2Ec
@=
@ -823,7 +823,7 @@
                 {
                     need_remote_ipv6=
_route =3D true;
                     msg(D_ROUTE,
-                       =
 "ROUTE6: %s/%d overlaps IPv6 remote %s, adding host route to VPN endpoint"=
,
+                        "ROUTE6: %s/%u overlaps IPv6 remote %s, adding h=
ost route to VPN endpoint",
                         print_in6_addr(r6->net=
work, 0, &gc), r6->netbits,
                         print_in6_addr(*remote=
_host_ipv6, 0, &gc));
                 }
@@ -1353,7 +1353,7 @@
         str=
uct buffer name2 =3D alloc_buf_gc(256, &gc);
 
         buf_printf(&name1, =
"route_ipv6_network_%d", i);
-        buf_printf(&val, "%s/%d", print_in6_a=
ddr(r6->network, 0, &gc), r6->netbits);
+        buf_printf(&val, "%s/%u", =
print_in6_addr(r6->network, 0, &gc), r6->netbits);
         setenv_str(es, =
BSTR(&name1), BSTR(&val));
 
         buf_printf(&name2, "route_ipv6_gatewa=
y_%d", i);
@@ -1801,10 +1801,10 @@
 #endif
 
 #ifndef _WIN32
-    msg(D_ROU=
TE, "add_route_ipv6(%s/%d -> %s metric %d) dev %s", network, r6->netbits, g=
ateway,
+    msg(D_ROUTE, "add_route_ipv6(%s/%u -> %s metric %d) dev %s", n=
etwork, r6->netbits, gateway,
         r6->metric, device);
 #else
-    msg=
(D_ROUTE, "add_route_ipv6(%s/%d -> %s metric %d) IF %lu", network, r6->netb=
its, gateway,
+    msg(D_ROUTE, "add_route_ipv6(%s/%u -> %s metric %d) IF %=
lu", network, r6->netbits, gateway,
         r6->metric, r6->adapter_index =
? r6->adapter_index : tt->adapter_index);
 #endif
 
@@ -1830,7 +1830,7 @@
 =
            "ROUTE6 WARNING: " PACKAGE_NAME " needs a gateway "
           =
  "parameter for a --route-ipv6 option and no default was set via "
       =
      "--ifconfig-ipv6 or --route-ipv6-gateway option=2E  Not installing "
=
-            "IPv6 route to %s/%d=2E",
+            "IPv6 route to %s/%u=2E=
",
             network, r6->netbits);
         status =3D 0;
         goto=
 done;
@@ -2220,7 +2220,7 @@
     }
 #endif
 
-    msg(D_ROUTE, "delete_rou=
te_ipv6(%s/%d)", network, r6->netbits);
+    msg(D_ROUTE, "delete_route_ipv=
6(%s/%u)", network, r6->netbits);
 
 #if defined(TARGET_LINUX)
     int met=
ric =3D -1;
diff --git a/src/openvpn/socket=2Ec b/src/openvpn/socket=2Ec
in=
dex 41c8bac=2E=2E33def4e 100644
--- a/src/openvpn/socket=2Ec
+++ b/src/open=
vpn/socket=2Ec
@@ -831,7 +831,8 @@
     else if (remote_len_af && remote_le=
n !=3D remote_len_af)
     {
         msg(D_LINK_ERRORS,
-            "TCP:=
 Received strange incoming connection with unknown address length=3D%d", re=
mote_len);
+            "TCP: Received strange incoming connection with unk=
nown address length=3D%u",
+            (unsigned int)remote_len);
        =
 openvpn_close_socket(new_sd);
         new_sd =3D SOCKET_UNDEFINED;
     }=

diff --git a/src/openvpn/ssl_ncp=2Ec b/src/openvpn/ssl_ncp=2Ec
index 8b0f2=
8d=2E=2Ef13f507 100644
--- a/src/openvpn/ssl_ncp=2Ec
+++ b/src/openvpn/ssl_=
ncp=2Ec
@@ -508,7 +508,7 @@
     }
 
     msg(D_TLS_DEBUG_LOW, "P2P mode NC=
P negotiation result: "
-                         "TLS_export=3D%d, DATA_v2=
=3D%d, rx-peer-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s",
+           =
              "TLS_export=3D%d, DATA_v2=3D%d, rx-peer-id %u, tx-peer-id %u,=
 epoch=3D%d, cipher=3D%s",
         (bool)(session->opt->crypto_flags & CO_=
USE_TLS_KEY_MATERIAL_EXPORT),
         multi->use_peer_id,
         multi->=
rx_peer_id,

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1958?usp=3Demail
To unsubscribe, or for help writing mail filters, visit ht=
tps://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: merg=
ed
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0b39d6a=
0fb2e6dbb683e9555f0365353c4eda8d3
Gerrit-Change-Number: 1958
Gerrit-PatchSe=
t: 4
Gerrit-Owner: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Revie=
wer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: plaistho=
s <arne-openvpn@rfc2549=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@list=
s=2Esourceforge=2Enet>

--t345T9Nvzuw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1958?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">Fix all occurrences of cppcheck in=
validPrintfArgType_sint<br><br>Mostly trivially correct=2E The only excepti=
on is socklen_t which<br>can be of various types=2E In Linux it is uint32_t=
 and in all cases<br>it should be a small unsigned number=2E So print it as=
 that=2E<br><br>Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt;<br>Acked-by: =
Razvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1958<br>Message-Id: &lt;20261003204342=2E19505=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg39678=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M dev-tools/cppcheck-sup=
pressions=2Exml<br>M src/openvpn/crypto=2Ec<br>M src/openvpn/dco_linux=2Ec<=
br>M src/openvpn/dco_win=2Ec<br>M src/openvpn/event=2Ec<br>M src/openvpn/ma=
nage=2Ec<br>M src/openvpn/multi=2Ec<br>M src/openvpn/multi_io=2Ec<br>M src/=
openvpn/networking_sitnl=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/=
options_show=2Ec<br>M src/openvpn/platform=2Ec<br>M src/openvpn/route=2Ec<b=
r>M src/openvpn/socket=2Ec<br>M src/openvpn/ssl_ncp=2Ec<br>15 files changed=
, 59 insertions(+), 61 deletions(-)<br><br></pre>
<pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/dev-tools=
/cppcheck-suppressions=2Exml b/dev-tools/cppcheck-suppressions=2Exml</span>=
<br><span>index cd37c41=2E=2E0d5416a 100644</span><br><span>--- a/dev-tools=
/cppcheck-suppressions=2Exml</span><br><span>+++ b/dev-tools/cppcheck-suppr=
essions=2Exml</span><br><span>@@ -12,9 +12,6 @@</span><br><span>     &lt;id=
&gt;constParameterPointer&lt;/id&gt;</span><br><span>   &lt;/suppress&gt;</=
span><br><span>   &lt;suppress&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    &lt;id&gt;invalidPrintfArgType_sint&lt;/id&gt;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  &lt;/suppress&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  &lt;suppress&gt;</span><br><span>=
     &lt;id&gt;invalidPrintfArgType_uint&lt;/id&gt;</span><br><span>   &lt;=
/suppress&gt;</span><br><span>   &lt;suppress&gt;</span><br><span>diff --gi=
t a/src/openvpn/crypto=2Ec b/src/openvpn/crypto=2Ec</span><br><span>index 2=
43cf27=2E=2E1703d4d 100644</span><br><span>--- a/src/openvpn/crypto=2Ec</sp=
an><br><span>+++ b/src/openvpn/crypto=2Ec</span><br><span>@@ -261,7 +261,7 =
@@</span><br><span>             if (!buf_safe(&amp;work, buf-&gt;len + ciph=
er_ctx_block_size(ctx-&gt;cipher)))</span><br><span>             {</span><b=
r><span>                 msg(D_CRYPT_ERRORS,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    &quot;ENCRYPT: buffer size error=
, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cbs=3D%d&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    &quot;ENC=
RYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d cb=
s=3D%u&quot;,</span><br><span>                     buf-&gt;capacity, buf-&g=
t;offset, buf-&gt;len, work=2Ecapacity, work=2Eoffset, work=2Elen,</span><b=
r><span>                     cipher_ctx_block_size(ctx-&gt;cipher));</span>=
<br><span>                 goto err;</span><br><span>diff --git a/src/openv=
pn/dco_linux=2Ec b/src/openvpn/dco_linux=2Ec</span><br><span>index e583696=
=2E=2Ea397fb8 100644</span><br><span>--- a/src/openvpn/dco_linux=2Ec</span>=
<br><span>+++ b/src/openvpn/dco_linux=2Ec</span><br><span>@@ -231,7 +231,7 =
@@</span><br><span>     {</span><br><span>         remotestr =3D print_sock=
addr(remoteaddr, &amp;gc);</span><br><span>     }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd %=
d, remote addr: %s&quot;, __func__, peerid, sd, remotestr);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer=
-id %u, fd %d, remote addr: %s&quot;, __func__, peerid, sd, remotestr);</sp=
an><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlms=
g_create(dco, OVPN_CMD_PEER_NEW);</span><br><span>     struct nlattr *attr =
=3D nla_nest_start(nl_msg, OVPN_A_PEER);</span><br><span>@@ -574,7 +574,7 @=
@</span><br><span> int</span><br><span> dco_swap_keys(dco_context_t *dco, u=
nsigned int peerid)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;, __func__,=
 peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_=
DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peerid);</span><br><span> =
</span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, =
OVPN_CMD_KEY_SWAP);</span><br><span>     if (!nl_msg)</span><br><span>@@ -5=
98,7 +598,7 @@</span><br><span> int</span><br><span> dco_del_peer(dco_conte=
xt_t *dco, unsigned int peerid)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: p=
eer-id %d&quot;, __func__, peerid);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;%s: peer-id %u&quo=
t;, __func__, peerid);</span><br><span> </span><br><span>     struct nl_msg=
 *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_PEER_DEL);</span><br><span=
>     if (!nl_msg)</span><br><span>@@ -623,7 +623,7 @@</span><br><span> dco=
_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)</spa=
n><br><span> {</span><br><span>     int ret =3D -EMSGSIZE;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id=
 %d, slot %d&quot;, __func__, peerid, slot);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, slot %d=
&quot;, __func__, peerid, slot);</span><br><span> </span><br><span>     str=
uct nl_msg *nl_msg =3D ovpn_dco_nlmsg_create(dco, OVPN_CMD_KEY_DEL);</span>=
<br><span>     if (!nl_msg)</span><br><span>@@ -648,7 +648,7 @@</span><br><=
span>             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, co=
nst uint8_t *decrypt_key,</span><br><span>             const uint8_t *decry=
pt_iv, const char *ciphername, bool epoch)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: slot=
 %d, key-id %d, peer-id %d, cipher %s, epoch %d&quot;, __func__, slot, keyi=
d, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %u, cipher %s, epoch %d&q=
uot;, __func__, slot, keyid, peerid,</span><br><span>         ciphername, e=
poch);</span><br><span> </span><br><span>     const size_t key_len =3D ciph=
er_kt_key_size(ciphername);</span><br><span>@@ -701,7 +701,7 @@</span><br><=
span> dco_set_peer(dco_context_t *dco, unsigned int peerid, int keepalive_i=
nterval, int keepalive_timeout,</span><br><span>              int mss)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg=
(D_DCO_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&quot;, __func__=
, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_=
DCO_DEBUG, &quot;%s: peer-id %u, keepalive %d/%d, mss %d&quot;, __func__, p=
eerid,</span><br><span>         keepalive_interval, keepalive_timeout, mss)=
;</span><br><span> </span><br><span>     struct nl_msg *nl_msg =3D ovpn_dco=
_nlmsg_create(dco, OVPN_CMD_PEER_SET);</span><br><span>@@ -968,7 +968,7 @@<=
/span><br><span>     uint32_t ifindex =3D nla_get_u32(attrs[OVPN_A_IFINDEX]=
);</span><br><span>     if (ifindex !=3D dco-&gt;ifindex)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_DC=
O_DEBUG, &quot;ovpn-dco: ignoring message for foreign ifindex %d&quot;, ifi=
ndex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D=
_DCO_DEBUG, &quot;ovpn-dco: ignoring message for foreign ifindex %u&quot;, =
ifindex);</span><br><span>         return false;</span><br><span>     }</sp=
an><br><span> </span><br><span>@@ -1010,7 +1010,7 @@</span><br><span>     i=
nt reason =3D nla_get_u32(dp_attrs[OVPN_A_PEER_DEL_REASON]);</span><br><spa=
n>     unsigned int peerid =3D nla_get_u32(dp_attrs[OVPN_A_PEER_ID]);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D=
_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco: received CMD_PEER_DEL_NTF, ifinde=
x: %d, peer-id %u, reason: %d&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_DCO_DEBUG | M_NOIPREFIX, &quot;ovpn-dco: receive=
d CMD_PEER_DEL_NTF, ifindex: %u, peer-id %u, reason: %d&quot;,</span><br><s=
pan>         dco-&gt;ifindex, peerid, reason);</span><br><span>     dco-&gt=
;dco_message_peer_id =3D peerid;</span><br><span>     dco-&gt;dco_del_peer_=
reason =3D reason;</span><br><span>@@ -1097,7 +1097,7 @@</span><br><span>  =
   int key_id =3D nla_get_u16(dp_attrs[OVPN_A_KEYCONF_KEY_ID]);</span><br><=
span>     unsigned int peer_id =3D nla_get_u32(dp_attrs[OVPN_A_KEYCONF_PEER=
_ID]);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_NTF, ifindex:=
 %d, peer-id %u, key-id: %d&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;ovpn-dco: received CMD_KEY_SWAP_N=
TF, ifindex: %u, peer-id %u, key-id: %d&quot;,</span><br><span>         dco=
-&gt;ifindex, peer_id, key_id);</span><br><span>     dco-&gt;dco_message_pe=
er_id =3D peer_id;</span><br><span>     dco-&gt;dco_message_key_id =3D key_=
id;</span><br><span>diff --git a/src/openvpn/dco_win=2Ec b/src/openvpn/dco_=
win=2Ec</span><br><span>index bd94c1a=2E=2E20d3c27 100644</span><br><span>-=
-- a/src/openvpn/dco_win=2Ec</span><br><span>+++ b/src/openvpn/dco_win=2Ec<=
/span><br><span>@@ -56,7 +56,7 @@</span><br><span>         {</span><br><spa=
n>             break;</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;interface %ld not=
 yet ready, retrying&quot;, idx);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(D_DCO_DEBUG, &quot;interface %lu not yet ready, r=
etrying&quot;, idx);</span><br><span>         Sleep(50);</span><br><span>  =
   }</span><br><span> }</span><br><span>@@ -409,7 +409,7 @@</span><br><span=
>              struct sockaddr *localaddr, struct sockaddr *remoteaddr,</sp=
an><br><span>              const struct in_addr *vpn_ipv4, const struct in6=
_addr *vpn_ipv6)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, fd &quot; SOCKET_P=
RINTF, __func__, peerid, sd);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, fd &quot; SOCKET_PRINT=
F, __func__, peerid, sd);</span><br><span> </span><br><span>     if (dco-&g=
t;ifmode =3D=3D DCO_MODE_P2P)</span><br><span>     {</span><br><span>@@ -46=
0,7 +460,7 @@</span><br><span> int</span><br><span> dco_del_peer(dco_contex=
t_t *dco, unsigned int peerid)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d&quot;=
, __func__, peerid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peerid);</span>=
<br><span> </span><br><span>     OVPN_MP_DEL_PEER del_peer =3D { peerid };<=
/span><br><span>     VOID *buf =3D NULL;</span><br><span>@@ -487,7 +487,7 @=
@</span><br><span> dco_set_peer(dco_context_t *dco, unsigned int peerid, in=
t keepalive_interval, int keepalive_timeout,</span><br><span>              =
int mss)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id %d, keepalive %d/%d, mss %d&qu=
ot;, __func__, peerid,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u, keepalive %d/%d, mss %d&quot;=
, __func__, peerid,</span><br><span>         keepalive_interval, keepalive_=
timeout, mss);</span><br><span> </span><br><span>     OVPN_MP_SET_PEER mp_p=
eer =3D { peerid, keepalive_interval, keepalive_timeout, mss };</span><br><=
span>@@ -522,7 +522,7 @@</span><br><span>             const uint8_t *encryp=
t_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,</span><br><sp=
an>             const uint8_t *decrypt_iv, const char *ciphername, bool epo=
ch)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id %d, cipher %s&q=
uot;, __func__, slot, keyid, peerid,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: slot %d, key-id %d, peer-id=
 %u, cipher %s&quot;, __func__, slot, keyid, peerid,</span><br><span>      =
   ciphername);</span><br><span> </span><br><span>     const int nonce_len =
=3D 8;</span><br><span>@@ -575,7 +575,7 @@</span><br><span> int</span><br><=
span> dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t s=
lot)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    msg(D_DCO, &quot;%s: peer-id %d, slot %d called but ignored&quot;, __=
func__, peerid, slot);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(D_DCO, &quot;%s: peer-id %u, slot %d called but ignored&quot;, _=
_func__, peerid, slot);</span><br><span>     /* FIXME: Implement in driver =
first */</span><br><span>     return 0;</span><br><span> }</span><br><span>=
@@ -583,7 +583,7 @@</span><br><span> int</span><br><span> dco_swap_keys(dco=
_context_t *dco, unsigned int peer_id)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: peer-id =
%d&quot;, __func__, peer_id);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: peer-id %u&quot;, __func__, peer_i=
d);</span><br><span> </span><br><span>     OVPN_MP_SWAP_KEYS swap =3D { pee=
r_id };</span><br><span>     DWORD ioctl =3D OVPN_IOCTL_SWAP_KEYS;</span><b=
r><span>@@ -667,7 +667,7 @@</span><br><span>     BOOL res =3D GetOverlapped=
Result(dco-&gt;tt-&gt;hand, &amp;dco-&gt;ov, &amp;bytes_read, FALSE);</span=
><br><span>     if (res)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        msg(D_DCO_DEBUG, &quot;%s: completion%s s=
uccess [%ld]&quot;, __func__, queued ? &quot;&quot; : &quot; non-queued&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_DC=
O_DEBUG, &quot;%s: completion%s success [%lu]&quot;, __func__, queued ? &qu=
ot;&quot; : &quot; non-queued&quot;,</span><br><span>             bytes_rea=
d);</span><br><span> </span><br><span>         dco-&gt;dco_message_peer_id =
=3D dco-&gt;notif_buf=2EPeerId;</span><br><span>@@ -1016,7 +1016,7 @@</span=
><br><span>         =2EAddr=2EAddr4=2ES_un=2ES_addr =3D dst, =2ENetbits =3D=
 netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D 0</span><br><span>     };</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
D_DCO_DEBUG, &quot;%s: %s/%d -&gt; peer %d&quot;, __func__, print_in_addr_t=
(dst, IA_NET_ORDER, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%u -&gt; peer %u&quot;, __func_=
_, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc),</span><br><span>         ne=
tbits, peer_id);</span><br><span> </span><br><span>     DWORD bytes_returne=
d =3D 0;</span><br><span>@@ -1037,7 +1037,7 @@</span><br><span> </span><br>=
<span>     OVPN_MP_IROUTE route =3D { =2EAddr=2EAddr6 =3D dst, =2ENetbits =
=3D netbits, =2EPeerId =3D peer_id, =2EIPv6 =3D 1 };</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot=
;%s: %s/%d -&gt; peer %d&quot;, __func__, print_in6_addr(dst, IA_NET_ORDER,=
 &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D=
_DCO_DEBUG, &quot;%s: %s/%u -&gt; peer %u&quot;, __func__, print_in6_addr(d=
st, IA_NET_ORDER, &amp;gc),</span><br><span>         netbits, peer_id);</sp=
an><br><span> </span><br><span>     DWORD bytes_returned =3D 0;</span><br><=
span>@@ -1059,7 +1059,7 @@</span><br><span>         =2EAddr=2EAddr4=2ES_un=
=2ES_addr =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 0<=
/span><br><span>     };</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    msg(D_DCO_DEBUG, &quot;%s: %s/%d&quot;, __func__, p=
rint_in_addr_t(dst, IA_NET_ORDER, &amp;gc), netbits);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%u&quot=
;, __func__, print_in_addr_t(dst, IA_NET_ORDER, &amp;gc), netbits);</span><=
br><span> </span><br><span>     DWORD bytes_returned =3D 0;</span><br><span=
>     if (!DeviceIoControl(dco-&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IROUTE, &=
amp;route, sizeof(route), NULL, 0,</span><br><span>@@ -1078,7 +1078,7 @@</s=
pan><br><span> </span><br><span>     OVPN_MP_IROUTE route =3D { =2EAddr=2EA=
ddr6 =3D dst, =2ENetbits =3D netbits, =2EPeerId =3D -1, =2EIPv6 =3D 1 };</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ms=
g(D_DCO_DEBUG, &quot;%s: %s/%d&quot;, __func__, print_in6_addr(dst, IA_NET_=
ORDER, &amp;gc), netbits);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg(D_DCO_DEBUG, &quot;%s: %s/%u&quot;, __func__, print_in6_addr=
(dst, IA_NET_ORDER, &amp;gc), netbits);</span><br><span> </span><br><span> =
    DWORD bytes_returned =3D 0;</span><br><span>     if (!DeviceIoControl(d=
co-&gt;tt-&gt;hand, OVPN_IOCTL_MP_DEL_IROUTE, &amp;route, sizeof(route), NU=
LL, 0,</span><br><span>diff --git a/src/openvpn/event=2Ec b/src/openvpn/eve=
nt=2Ec</span><br><span>index 2cb4e04=2E=2E4089401 100644</span><br><span>--=
- a/src/openvpn/event=2Ec</span><br><span>+++ b/src/openvpn/event=2Ec</span=
><br><span>@@ -117,7 +117,7 @@</span><br><span>     }</span><br><span>     =
else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        msg(M_FATAL, &quot;fatal error in we_set_events: rwflags=3D%d=
&quot;, rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(M_FATAL, &quot;fatal error in we_set_events: rwflags=3D%u&quot;, =
rwflags);</span><br><span>     }</span><br><span> </span><br><span>     wes=
-&gt;esr[i]=2Erwflags =3D rwflags;</span><br><span>@@ -378,7 +378,7 @@</spa=
n><br><span>                 break;</span><br><span> </span><br><span>     =
        default:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           msg(M_FATAL, &quot;fatal error in we_ctl: rwflags=3D%d&quot;, rw=
flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    msg(M_FATAL, &quot;fatal error in we_ctl: rwflags=3D%u&quot;, rwflags);=
</span><br><span>         }</span><br><span>     }</span><br><span>     ret=
urn;</span><br><span>diff --git a/src/openvpn/manage=2Ec b/src/openvpn/mana=
ge=2Ec</span><br><span>index b6d93c7=2E=2E0aef2d4 100644</span><br><span>--=
- a/src/openvpn/manage=2Ec</span><br><span>+++ b/src/openvpn/manage=2Ec</sp=
an><br><span>@@ -1503,7 +1503,7 @@</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;pid&quot;))</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        msg(M_CLIENT, &quot;SUC=
CESS: pid=3D%d&quot;, platform_getpid());</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;SUCCESS: pid=3D%u&quot;, =
platform_getpid());</span><br><span>     }</span><br><span>     else if (st=
req(p[0], &quot;nclients&quot;))</span><br><span>     {</span><br><span>dif=
f --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec</span><br><span>ind=
ex 959f7b3=2E=2E1cf2a21 100644</span><br><span>--- a/src/openvpn/multi=2Ec<=
/span><br><span>+++ b/src/openvpn/multi=2Ec</span><br><span>@@ -164,7 +164,=
7 @@</span><br><span>     struct hash_iterator hi;</span><br><span>     str=
uct hash_element *he;</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    dmsg(D_MULTI_DEBUG, &quot;MULTI: REAP range %d -&gt; =
%d&quot;, start_bucket, end_bucket);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    dmsg(D_MULTI_DEBUG, &quot;MULTI: REAP range %u -&gt; %=
u&quot;, start_bucket, end_bucket);</span><br><span>     hash_iterator_init=
_range(m-&gt;vhash, &amp;hi, start_bucket, end_bucket);</span><br><span>   =
  while ((he =3D hash_iterator_next(&amp;hi)) !=3D NULL)</span><br><span>  =
   {</span><br><span>@@ -271,7 +271,7 @@</span><br><span>     struct multi_=
context *m =3D t-&gt;multi;</span><br><span>     int dev =3D DEV_TYPE_UNDEF=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%d v=3D%d&quot;, t-&=
gt;options=2Ereal_hash_size,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    msg(D_MULTI_LOW, &quot;MULTI: multi_init called, r=3D%u v=3D%u=
&quot;, t-&gt;options=2Ereal_hash_size,</span><br><span>         t-&gt;opti=
ons=2Evirtual_hash_size);</span><br><span> </span><br><span>     /*</span><=
br><span>@@ -430,7 +430,7 @@</span><br><span>         if (mi-&gt;context=2E=
c2=2Etls_multi &amp;&amp; check_debug_level(D_DCO_DEBUG)</span><br><span>  =
           &amp;&amp; dco_enabled(&amp;mi-&gt;context=2Eoptions))</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        buf_printf(&amp;out, &quot; rx-peer-id=3D%d&quot;, mi-&gt;context=
=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            buf_printf(&amp;out, &quot; rx-peer-id=3D%u&quot=
;, mi-&gt;context=2Ec2=2Etls_multi-&gt;rx_peer_id);</span><br><span>       =
  }</span><br><span>         return BSTR(&amp;out);</span><br><span>     }<=
/span><br><span>@@ -735,7 +735,7 @@</span><br><span>     if (hash_n_element=
s(m-&gt;hash) &gt;=3D m-&gt;max_clients)</span><br><span>     {</span><br><=
span>         msg(D_MULTI_ERRORS,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            &quot;MULTI: new incoming connection would exceed m=
aximum number of clients (%d)&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            &quot;MULTI: new incoming connection would exc=
eed maximum number of clients (%u)&quot;,</span><br><span>             m-&g=
t;max_clients);</span><br><span>         goto err;</span><br><span>     }</=
span><br><span>@@ -996,7 +996,7 @@</span><br><span> #ifdef ENABLE_ASYNC_PUS=
H</span><br><span>     if (m-&gt;inotify_watchers)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_DEB=
UG, &quot;inotify watchers count: %d&quot;, hash_n_elements(m-&gt;inotify_w=
atchers));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(D_MULTI_DEBUG, &quot;inotify watchers count: %u&quot;, hash_n_elements(m=
-&gt;inotify_watchers));</span><br><span>     }</span><br><span> #endif</sp=
an><br><span> }</span><br><span>@@ -1302,7 +1302,7 @@</span><br><span>     =
    }</span><br><span>         for (ir6 =3D mi-&gt;context=2Eoptions=2Eirou=
tes_ipv6; ir6 !=3D NULL; ir6 =3D ir6-&gt;next)</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_MULTI=
_LOW, &quot;MULTI: internal route %s/%d -&gt; %s&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            msg(D_MULTI_LOW, &quot;MULT=
I: internal route %s/%u -&gt; %s&quot;,</span><br><span>                 pr=
int_in6_addr(ir6-&gt;network, 0, &amp;gc), ir6-&gt;netbits,</span><br><span=
>                 multi_instance_string(mi, false, &amp;gc));</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/multi_io=2Ec b/src/openvpn/mu=
lti_io=2Ec</span><br><span>index bce5018=2E=2E51c7d31 100644</span><br><spa=
n>--- a/src/openvpn/multi_io=2Ec</span><br><span>+++ b/src/openvpn/multi_io=
=2Ec</span><br><span>@@ -439,7 +439,7 @@</span><br><span>         default:<=
/span><br><span>         {</span><br><span>             struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(M_FATAL, &quot;MULTI IO: multi_io_post bad state, mi=3D%s flags=3D%=
d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(M_FATAL, &quot;MULTI IO: multi_io_post bad state, mi=3D%s flags=3D%u&q=
uot;,</span><br><span>                 multi_instance_string(mi, false, &am=
p;gc), flags);</span><br><span>             gc_free(&amp;gc);</span><br><sp=
an>             break;</span><br><span>diff --git a/src/openvpn/networking_=
sitnl=2Ec b/src/openvpn/networking_sitnl=2Ec</span><br><span>index 8a0a360=
=2E=2E83915db 100644</span><br><span>--- a/src/openvpn/networking_sitnl=2Ec=
</span><br><span>+++ b/src/openvpn/networking_sitnl=2Ec</span><br><span>@@ =
-222,7 +222,7 @@</span><br><span> </span><br><span>     if (addr_len !=3D s=
izeof(local))</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        msg(M_WARN, &quot;%s: wrong address length %d&quot;,=
 __func__, addr_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        msg(M_WARN, &quot;%s: wrong address length %u&quot;, __func__, (u=
nsigned int)addr_len);</span><br><span>         return -EINVAL;</span><br><=
span>     }</span><br><span> </span><br><span>@@ -528,7 +528,7 @@</span><br=
><span> </span><br><span>     if (!if_indextoname(ifindex, res-&gt;iface))<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get ifname for ind=
ex %d&quot;, __func__, ifindex);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_WARN | M_ERRNO, &quot;%s: rtnl: can&#39;t get if=
name for index %u&quot;, __func__, ifindex);</span><br><span>         retur=
n -1;</span><br><span>     }</span><br><span> </span><br><span>@@ -1216,7 +=
1216,7 @@</span><br><span>         gw_ptr =3D &amp;gw_be;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&quot;, =
__func__,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_=
ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,</s=
pan><br><span>         inet_ntop(AF_INET, &amp;dst_be, dst_str, sizeof(dst_=
str)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_be, g=
w_str, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </span>=
<br><span>@@ -1242,7 +1242,7 @@</span><br><span>         gw_v6=2Eipv6 =3D *=
gw;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table=
 %d metric %d&quot;, __func__,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u metric %=
d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET6, &amp;dst_v6=
=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>         ine=
t_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface), tab=
le, metric);</span><br><span> </span><br><span>@@ -1293,7 +1293,7 @@</span>=
<br><span>         gw_v4=2Eipv4 =3D htonl(*gw);</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(=
D_ROUTE, &quot;%s: %s/%d via %s dev %s table %d metric %d&quot;, __func__,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &qu=
ot;%s: %s/%d via %s dev %s table %u metric %d&quot;, __func__,</span><br><s=
pan>         inet_ntop(AF_INET, &amp;dst_v4=2Eipv4, dst_str, sizeof(dst_str=
)), prefixlen,</span><br><span>         inet_ntop(AF_INET, &amp;gw_v4=2Eipv=
4, gw_str, sizeof(gw_str)), np(iface), table, metric);</span><br><span> </s=
pan><br><span>@@ -1319,7 +1319,7 @@</span><br><span>         gw_v6=2Eipv6 =
=3D *gw;</span><br><span>     }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s =
table %d metric %d&quot;, __func__,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    msg(D_ROUTE, &quot;%s: %s/%d via %s dev %s table %u met=
ric %d&quot;, __func__,</span><br><span>         inet_ntop(AF_INET6, &amp;d=
st_v6=2Eipv6, dst_str, sizeof(dst_str)), prefixlen,</span><br><span>       =
  inet_ntop(AF_INET6, &amp;gw_v6=2Eipv6, gw_str, sizeof(gw_str)), np(iface)=
, table, metric);</span><br><span> </span><br><span>diff --git a/src/openvp=
n/options=2Ec b/src/openvpn/options=2Ec</span><br><span>index dcc4dac=2E=2E=
30e497c 100644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><spa=
n>+++ b/src/openvpn/options=2Ec</span><br><span>@@ -4548,7 +4548,7 @@</span=
><br><span>         {</span><br><span>             if (netbits &lt; 64 || n=
etbits &gt; 124)</span><br><span>             {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;ifconfig-ipv6=
: /netbits must be between 64 and 124, not &#39;/%d&#39;&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &=
quot;ifconfig-ipv6: /netbits must be between 64 and 124, not &#39;/%u&#39;&=
quot;,</span><br><span>                     netbits);</span><br><span>     =
            goto err;</span><br><span>             }</span><br><span>@@ -58=
26,7 +5826,7 @@</span><br><span>         }</span><br><span>         if (net=
bits &lt; 64 || netbits &gt; 124)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--se=
rver-ipv6 settings: network must be between /64 and /124 (not /%d)&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msgle=
vel, &quot;--server-ipv6 settings: network must be between /64 and /124 (no=
t /%u)&quot;,</span><br><span>                 netbits);</span><br><span> <=
/span><br><span>             goto err;</span><br><span>@@ -5939,7 +5939,7 @=
@</span><br><span>         if (netbits &lt; 64 || netbits &gt; 124)</span><=
br><span>         {</span><br><span>             msg(msglevel,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                &quot;--ifconfig-i=
pv6-pool settings: network must be between /64 and /124 (not /%d)&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;=
--ifconfig-ipv6-pool settings: network must be between /64 and /124 (not /%=
u)&quot;,</span><br><span>                 netbits);</span><br><span>      =
       goto err;</span><br><span>         }</span><br><span>diff --git a/sr=
c/openvpn/options_show=2Ec b/src/openvpn/options_show=2Ec</span><br><span>i=
ndex ff090774=2E=2E80d36f0 100644</span><br><span>--- a/src/openvpn/options=
_show=2Ec</span><br><span>+++ b/src/openvpn/options_show=2Ec</span><br><spa=
n>@@ -136,7 +136,7 @@</span><br><span>     msg(D_SHOW_PARMS, &quot;  server=
_network =3D %s&quot;, print_in_addr_t(o-&gt;server_network, 0, &amp;gc));<=
/span><br><span>     msg(D_SHOW_PARMS, &quot;  server_netmask =3D %s&quot;,=
 print_in_addr_t(o-&gt;server_netmask, 0, &amp;gc));</span><br><span>     m=
sg(D_SHOW_PARMS, &quot;  server_network_ipv6 =3D %s&quot;, print_in6_addr(o=
-&gt;server_network_ipv6, 0, &amp;gc));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_INT(server_netbits_ipv6);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(server_netbits_ipv6);</span=
><br><span>     msg(D_SHOW_PARMS, &quot;  server_bridge_ip =3D %s&quot;, pr=
int_in_addr_t(o-&gt;server_bridge_ip, 0, &amp;gc));</span><br><span>     ms=
g(D_SHOW_PARMS, &quot;  server_bridge_netmask =3D %s&quot;,</span><br><span=
>         print_in_addr_t(o-&gt;server_bridge_netmask, 0, &amp;gc));</span>=
<br><span>@@ -170,8 +170,8 @@</span><br><span>     SHOW_INT(ifconfig_ipv6_p=
ool_netbits);</span><br><span>     SHOW_INT(n_bcast_buf);</span><br><span> =
    SHOW_INT(tcp_queue_limit);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    SHOW_INT(real_hash_size);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    SHOW_INT(virtual_hash_size);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_UINT(real_hash_size);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(virtual_hash_size);<=
/span><br><span>     SHOW_STR(client_connect_script);</span><br><span>     =
SHOW_STR(learn_address_script);</span><br><span>     SHOW_STR(client_discon=
nect_script);</span><br><span>@@ -444,10 +444,10 @@</span><br><span> #if de=
fined(TARGET_LINUX)</span><br><span>     SHOW_INT(mark);</span><br><span> #=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(soc=
kflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UI=
NT(sockflags);</span><br><span> </span><br><span>     SHOW_INT(comp=2Ealg);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(comp=2Ef=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT=
(comp=2Eflags);</span><br><span> </span><br><span>     SHOW_STR(route_scrip=
t);</span><br><span>     SHOW_STR(route_default_gateway);</span><br><span>@=
@ -482,7 +482,7 @@</span><br><span>     SHOW_INT(management_echo_buffer_siz=
e);</span><br><span>     SHOW_STR(management_client_user);</span><br><span>=
     SHOW_STR(management_client_group);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    SHOW_INT(management_flags);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    SHOW_UINT(management_flags);</span><br><s=
pan> #endif</span><br><span> #ifdef ENABLE_PLUGIN</span><br><span>     if (=
o-&gt;plugin_list)</span><br><span>@@ -547,7 +547,7 @@</span><br><span>    =
     int i;</span><br><span>         for (i =3D 0; i &lt; MAX_PARMS; i++)</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            SHOW_INT(remote_cert_ku[i]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            SHOW_UINT(remote_cert_ku[i]);</span><b=
r><span>         }</span><br><span>     }</span><br><span>     SHOW_STR(rem=
ote_cert_eku);</span><br><span>@@ -567,7 +567,7 @@</span><br><span>        =
 }</span><br><span>         gc_free(&amp;gc);</span><br><span>     }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    SHOW_INT(ssl_flags);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_UINT(ssl_flags=
);</span><br><span> </span><br><span>     SHOW_INT(tls_timeout);</span><br>=
<span> </span><br><span>diff --git a/src/openvpn/platform=2Ec b/src/openvpn=
/platform=2Ec</span><br><span>index 400c722=2E=2E91cc0ad 100644</span><br><=
span>--- a/src/openvpn/platform=2Ec</span><br><span>+++ b/src/openvpn/platf=
orm=2Ec</span><br><span>@@ -578,7 +578,7 @@</span><br><span>         }</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    msg(M_WARN, &quot;Failed to create temporary file after =
%i attempts&quot;, attempts);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    msg(M_WARN, &quot;Failed to create temporary file after %u at=
tempts&quot;, attempts);</span><br><span>     return NULL;</span><br><span>=
 }</span><br><span> </span><br><span>diff --git a/src/openvpn/route=2Ec b/s=
rc/openvpn/route=2Ec</span><br><span>index b3aee37=2E=2Ece25cc0 100644</spa=
n><br><span>--- a/src/openvpn/route=2Ec</span><br><span>+++ b/src/openvpn/r=
oute=2Ec</span><br><span>@@ -823,7 +823,7 @@</span><br><span>              =
   {</span><br><span>                     need_remote_ipv6_route =3D true;<=
/span><br><span>                     msg(D_ROUTE,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        &quot;ROUTE6: %s/%d ove=
rlaps IPv6 remote %s, adding host route to VPN endpoint&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        &quot;RO=
UTE6: %s/%u overlaps IPv6 remote %s, adding host route to VPN endpoint&quot=
;,</span><br><span>                         print_in6_addr(r6-&gt;network, =
0, &amp;gc), r6-&gt;netbits,</span><br><span>                         print=
_in6_addr(*remote_host_ipv6, 0, &amp;gc));</span><br><span>                =
 }</span><br><span>@@ -1353,7 +1353,7 @@</span><br><span>         struct bu=
ffer name2 =3D alloc_buf_gc(256, &amp;gc);</span><br><span> </span><br><spa=
n>         buf_printf(&amp;name1, &quot;route_ipv6_network_%d&quot;, i);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_printf(&amp;=
val, &quot;%s/%d&quot;, print_in6_addr(r6-&gt;network, 0, &amp;gc), r6-&gt;=
netbits);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bu=
f_printf(&amp;val, &quot;%s/%u&quot;, print_in6_addr(r6-&gt;network, 0, &am=
p;gc), r6-&gt;netbits);</span><br><span>         setenv_str(es, BSTR(&amp;n=
ame1), BSTR(&amp;val));</span><br><span> </span><br><span>         buf_prin=
tf(&amp;name2, &quot;route_ipv6_gateway_%d&quot;, i);</span><br><span>@@ -1=
801,10 +1801,10 @@</span><br><span> #endif</span><br><span> </span><br><spa=
n> #ifndef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
msg(D_ROUTE, &quot;add_route_ipv6(%s/%d -&gt; %s metric %d) dev %s&quot;, n=
etwork, r6-&gt;netbits, gateway,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    msg(D_ROUTE, &quot;add_route_ipv6(%s/%u -&gt; %s metric %d=
) dev %s&quot;, network, r6-&gt;netbits, gateway,</span><br><span>         =
r6-&gt;metric, device);</span><br><span> #else</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;add_route_ipv6(%s/%d -&gt; =
%s metric %d) IF %lu&quot;, network, r6-&gt;netbits, gateway,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    msg(D_ROUTE, &quot;add_route_=
ipv6(%s/%u -&gt; %s metric %d) IF %lu&quot;, network, r6-&gt;netbits, gatew=
ay,</span><br><span>         r6-&gt;metric, r6-&gt;adapter_index ? r6-&gt;a=
dapter_index : tt-&gt;adapter_index);</span><br><span> #endif</span><br><sp=
an> </span><br><span>@@ -1830,7 +1830,7 @@</span><br><span>             &qu=
ot;ROUTE6 WARNING: &quot; PACKAGE_NAME &quot; needs a gateway &quot;</span>=
<br><span>             &quot;parameter for a --route-ipv6 option and no def=
ault was set via &quot;</span><br><span>             &quot;--ifconfig-ipv6 =
or --route-ipv6-gateway option=2E  Not installing &quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            &quot;IPv6 route to %s/%d=2E=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;IPv6 route to %s/%u=2E&quot;,</span><br><span>             network, r=
6-&gt;netbits);</span><br><span>         status =3D 0;</span><br><span>    =
     goto done;</span><br><span>@@ -2220,7 +2220,7 @@</span><br><span>     =
}</span><br><span> #endif</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    msg(D_ROUTE, &quot;delete_route_ipv6(%s/%d)&quot;=
, network, r6-&gt;netbits);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    msg(D_ROUTE, &quot;delete_route_ipv6(%s/%u)&quot;, network, r6-=
&gt;netbits);</span><br><span> </span><br><span> #if defined(TARGET_LINUX)<=
/span><br><span>     int metric =3D -1;</span><br><span>diff --git a/src/op=
envpn/socket=2Ec b/src/openvpn/socket=2Ec</span><br><span>index 41c8bac=2E=
=2E33def4e 100644</span><br><span>--- a/src/openvpn/socket=2Ec</span><br><s=
pan>+++ b/src/openvpn/socket=2Ec</span><br><span>@@ -831,7 +831,8 @@</span>=
<br><span>     else if (remote_len_af &amp;&amp; remote_len !=3D remote_len=
_af)</span><br><span>     {</span><br><span>         msg(D_LINK_ERRORS,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;TCP: Re=
ceived strange incoming connection with unknown address length=3D%d&quot;, =
remote_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;TCP: Received strange incoming connection with unknown address l=
ength=3D%u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          (unsigned int)remote_len);</span><br><span>         openvpn_close=
_socket(new_sd);</span><br><span>         new_sd =3D SOCKET_UNDEFINED;</spa=
n><br><span>     }</span><br><span>diff --git a/src/openvpn/ssl_ncp=2Ec b/s=
rc/openvpn/ssl_ncp=2Ec</span><br><span>index 8b0f28d=2E=2Ef13f507 100644</s=
pan><br><span>--- a/src/openvpn/ssl_ncp=2Ec</span><br><span>+++ b/src/openv=
pn/ssl_ncp=2Ec</span><br><span>@@ -508,7 +508,7 @@</span><br><span>     }</=
span><br><span> </span><br><span>     msg(D_TLS_DEBUG_LOW, &quot;P2P mode N=
CP negotiation result: &quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                         &quot;TLS_export=3D%d, DATA_v2=3D%d, rx-pe=
er-id %d, tx-peer-id %d, epoch=3D%d, cipher=3D%s&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                         &quot;TLS_expo=
rt=3D%d, DATA_v2=3D%d, rx-peer-id %u, tx-peer-id %u, epoch=3D%d, cipher=3D%=
s&quot;,</span><br><span>         (bool)(session-&gt;opt-&gt;crypto_flags &=
amp; CO_USE_TLS_KEY_MATERIAL_EXPORT),</span><br><span>         multi-&gt;us=
e_peer_id,</span><br><span>         multi-&gt;rx_peer_id,</span><br></pre><=
p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1958=
?usp=3Demail">change 1958</a>=2E To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demai=
l">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/=
ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1958?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged <=
/div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div styl=
e=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none=
"> Gerrit-Change-Id: I0b39d6a0fb2e6dbb683e9555f0365353c4eda8d3 </div>
<div =
style=3D"display:none"> Gerrit-Change-Number: 1958 </div>
<div style=3D"dis=
play:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-O=
wner: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbo=
x=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos =
&lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerr=
it-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>=


</body></html>
--t345T9Nvzuw=--


--===============8246891799577679112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8246891799577679112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============8246891799577679112==--

