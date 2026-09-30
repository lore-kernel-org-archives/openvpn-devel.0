Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0424BCA5FC1
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qk8GGGnwCuESu952R9LQMxR7yQh72QJMhNVfoc+TJsM=; b=UPatlje14sfuzqWriMa3ZBhDMo
	xOJD3j9z4eoDIsM0hzDsCIljZn20zA14jbAQA7Q8DfeVowpFWXUc5zXfa/dl7ThX/4Tf5LcyLranb
	yo1q4SVSmLcve6yzFyZcaSLVjrxyZS/cDQFJOPqreKt8jFTTemFfe6Qd2jy2PKkncf88=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpdg-0002hn-1X;
	Wed, 30 Sep 2026 08:26:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpdR-0002h4-He
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:25:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=51WdnEf1pUx0t/ypu1pgYRS3X60eKhApeX3shwD6iGI=; b=KUMtvwTs3HnzItwx02GxdzEVRO
 bAHdooP0yUGVlLXEQIjQTTOYGB0l6b9ZUksGfS+ASbw/aXcCwXK5e8UWHCzEspvIv9AFJeK5ivDup
 kvFaJhiNVzmEOBME9EoAM4wUxYreCKVGsquMQUad3jcDRUTZCMgsus/yBjF64qbe+YjY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=51WdnEf1pUx0t/ypu1pgYRS3X60eKhApeX3shwD6iGI=; b=T
 MMEc+iMA0zdEVMT5R+aaaV7LZ+9lLfjAmIlYM3Btrbyb3xOiQXxCv1lyy0wIDjMrtwBjm4X4k1zrw
 u1L0caVVDhdBlEU1j/A/h0hYcd2HQJZmqK8IZUQWf6IBvYpQJlCfFuaJQnh0epeAjxxFhzZcaV0FT
 eyW82OsiKF9exSXA=;
Received: from mail-wr2-f34.google.com ([74.125.225.98])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpdN-0006j0-Aq for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:25:54 +0000
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48b00a0ac65so240980f8f.0
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756743; x=1791361543; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=51WdnEf1pUx0t/ypu1pgYRS3X60eKhApeX3shwD6iGI=;
 b=ZLg76ZE4I3lcT1wEX8rPeu8vBtzsLnyMFK2L8ziqm0UJQKNS8zCTPuPZ8xVdY1czSZ
 FIZ5vgNCgErlKg24SG/OqSGfmwWaFhtunpbXQK9RXS+196XpowrdaBfXYbX9bmqdA3m6
 LMfqvvn40yHJo1RkdqE/ulp7TLF2pVw3gxqA55/2aRIz7BhhJuYgzyGijwqMIsqWDjN0
 OTeeDGao1i21yBI4pBHXab3u6a1zlUy7ULNVox4PKJ3KlV2sUMQi+w657zy4vvOu0sq0
 A9QysFo8ku1BxV7rgZfsx79slHI5H4vnMnCrCwAfcUufrMndhrBOy5xfqXFboC972T/o
 Y/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756743; x=1791361543;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=51WdnEf1pUx0t/ypu1pgYRS3X60eKhApeX3shwD6iGI=;
 b=eT7afbGhAZmopDKyjUY2vlP/7eQqNGxm2K5TG+vX7c/+7uWBFzRhQrwnLKYM37wEln
 UsTx2XX8l3m5V9zz84Fpm40JDh6PNQXKygxLBmRlW4BRE0nyi5gkOGAeo5r1gQ27LIIh
 huxQ0xWaXE6+e3WA4ZfA1LqXQdtBxmBHusP/BndxQD7zwib4z/CLRseqPgU3aia7sWYe
 bF2k6r8hl6GMx6zKAXHt/fM9TO5mhnmjj12oEesYhxJBwrn47Ygiy0r33XGId4O3hHt5
 tHwZ7OJWfxojZROmFuZxs9yTV2i3kp+d+vvzm3pX5aH8hVGAadyKpM9yMxBXhOsZj8xT
 YGxg==
X-Gm-Message-State: AFuF++kSICUapqZMaJXUaCpsbOSX01uXwbQnn3jS4nIY1za37hpOwasT
 3p1HuYLPo35hwcm+bUBoBpBIeDP//ekrntebrOtHkf9mkvVNOk+MtzHIPoK7+umMQkS5Wf0Oh7S
 zKg0A9DKTWDR4gMHCoTx23STMXnL3WhqV1ZEBUIagybkuaznxCGR0C0b7I4vYPRD9YAtv9s0PAP
 xxE1U0ag==
X-Gm-Gg: AYBFou1j4xC7/7d80b65UmjoAjNyK85eGYI5ITDyAM6N8qNXKaMTm/+wg0t2Cmi6AEz
 UR86StL4MUziywZORn/Cc6V+SD4oWPrfuxwiOLKFLaME6Ba39Qe7dTw2zCN2oO2ItW24ApDpZI5
 O6IBP1u1PVv4gwGSY0B1gWiWQWj+AhyG+5f88IW3D1SvBr0d617ocu+CeFZKh34t8SzKY0WGsc4
 UucH7QElOj2Rkg6UgSXL8+qjttCetKmJ+p8noYkLhvo2JbGEnT+MH7GnOMGkmKB3xM9H49ZuZCk
 TAWeDasT5ptgcPa2dBntzXEFGgNRLOUzdRCYDIKpw1seYT3zuTcvP2nntbqJOvN73xvg9A1oUdH
 BhvIZZknRU33P6GTpNSNRWKE68fth95C+xfWsLgbMKBpjcDczKaCogZjbFoBKuzOFzQHz51ADpe
 kEa8UwnfYGzS7wwNLroxo/w3vxLSfOzH9AvvofVe+LiArQV3TnXJDb04febLsT0W6VVN+J0fccO
 elBCGck01qaih0NdyX2K6Y7e9GEPITk2fSRHn0wXOfQ2OgHtW6gp8UP3W7Fw00IdHgFxNx4C3Bw
 WtjlubkREo3BGgtLOoxM+8RgYQE55M7PCBbEp4ofGYNWEszOs+FzFFv2Jkdr
X-Received: by 2002:a05:600c:628b:b0:49f:fe7e:dc61 with SMTP id
 5b1f17b1804b1-4a01ab4e424mr10304805e9.0.1790756742187; 
 Wed, 30 Sep 2026 01:25:42 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029bfbcdsm1840851f8f.6.2026.09.30.01.25.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:25:41 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:25:29 +0000
To: ralf_lici <ralf@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 19
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 9b66f9d7f01932ff34ea618d1557b7cbee7ca158
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0d42f7d7ef30af9598147e8a7343f33fa14b08f7-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpdN-0006j0-Aq
Subject: [Openvpn-devel] [L] Change in openvpn[master]: oob: Add
 P_CONTROL_OOB_V1 and the probe request and reply TLVs
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
From: "stipa \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============3549954409028963887=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============3549954409028963887==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6DDGakVHOBA="; charset=UTF-8

--6DDGakVHOBA=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici, s=
tipa=2E

Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexam=
ine a change=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail

to look at the new patch set (#19)=2E

The following app=
rovals got outdated and were removed:
Code-Review-1 by plaisthos


Change s=
ubject: oob: Add P_CONTROL_OOB_V1 and the probe request and reply TLVs
=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add P_CONTR=
OL_OOB_V1 and the probe request and reply TLVs

Out-of-band control message=
s carry control data but belong to no
session, so a client can ask a server=
 about itself before connecting=2E
Reserve opcode 12 for them and add the T=
LV codecs the probe needs: the
probe request a client probes a server with,=
 and the probe reply the
server answers with=2E

A message is just a sequen=
ce of TLVs, and the TLVs it carries say what
it is=2E The probe request car=
ries a request_id chosen by the client,
which the probe reply echoes=2E

Th=
e TLVs use the shared TLV codec, control_msg=2Ec/h, and their two types
joi=
n the others in control_msg=2Eh=2E The codec gains ctrl_msg_find_tlv(),
whi=
ch scans a payload for the one mandatory TLV of a message=2E The scan
is st=
rict: a truncated TLV header or value, or an unknown TLV not marked
optiona=
l, rejects the whole message=2E

P_LAST_OPCODE becomes 12=2E tls_pre_decryp=
t() rejects the OOB opcodes
explicitly: they are not part of the reliable c=
ontrol channel (no
control message id, no ACK array); the server answers th=
em
statelessly in a follow-up=2E

Change-Id: I1c8d302ac57c5603d622a7be14be3=
69437388268
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeList=
s=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/control_msg=2Ec
M src/ope=
nvpn/control_msg=2Eh
A src/openvpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/open=
vpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/uni=
t_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/test_oob=2Ec
M tes=
ts/unit_tests/openvpn/test_pkt=2Ec
12 files changed, 632 insertions(+), 6 d=
eletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/ch=
anges/41/1741/19

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index e1=
a6079f=2E=2E8a062b8 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@=
 -525,6 +525,8 @@
     src/openvpn/multi_io=2Ec
     src/openvpn/occ=2Ec
  =
   src/openvpn/occ=2Eh
+    src/openvpn/oob=2Ec
+    src/openvpn/oob=2Eh
  =
   src/openvpn/openvpn=2Ec
     src/openvpn/openvpn=2Eh
     src/openvpn/op=
envpn_win32_resources=2Erc
@@ -886,7 +888,9 @@
     target_sources(test_pkt=
 PRIVATE
         tests/unit_tests/openvpn/mock_win32_execve=2Ec
         t=
ests/unit_tests/openvpn/test_control_msg=2Ec
+        tests/unit_tests/open=
vpn/test_oob=2Ec
         src/openvpn/control_msg=2Ec
+        src/openvpn/=
oob=2Ec
         src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
     =
    src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/s=
rc/openvpn/Makefile=2Eam
index a17ae8e=2E=2E5e6b4d9 100644
--- a/src/openvp=
n/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -108,6 +108,7 @@
 	pkcs1=
1=2Ec pkcs11=2Eh pkcs11_backend=2Eh \
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedt=
ls=2Ec \
+	oob=2Ec oob=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec opti=
ons=2Eh \
 	options_show=2Ec options_show=2Eh \
diff --git a/src/openvpn/co=
ntrol_msg=2Ec b/src/openvpn/control_msg=2Ec
index ca3aab9=2E=2E76f0cfa 1006=
44
--- a/src/openvpn/control_msg=2Ec
+++ b/src/openvpn/control_msg=2Ec
@@ -=
81,3 +81,31 @@
     buf_set_read(value, v, hdr->value_len);
     return tru=
e;
 }
+
+bool
+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_ty=
pe, struct buffer *value)
+{
+    bool found =3D false;
+    while (BLEN(pa=
yload) > 0)
+    {
+        struct ctrl_msg_tlv_header hdr;
+        struct=
 buffer v;
+        if (!ctrl_msg_tlv_next(payload, &hdr, &v))
+        {
+=
            return false;
+        }
+        if (hdr=2Etype =3D=3D wanted_=
type)
+        {
+            if (!found)
+            {
+                *=
value =3D v;
+                found =3D true;
+            }
+        }
+  =
      else if (!hdr=2Eoptional)
+        {
+            return false; /* a =
mandatory TLV we do not understand, wherever it sits */
+        }
+    }
+=
    return found;
+}
diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn=
/control_msg=2Eh
index 73fd0a1=2E=2Ee731590 100644
--- a/src/openvpn/contro=
l_msg=2Eh
+++ b/src/openvpn/control_msg=2Eh
@@ -41,6 +41,8 @@
 
 /* TLV typ=
es */
 #define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the=
 reset packets */
+#define TLV_TYPE_PROBE_REQUEST   0x0002 /* out-of-band, =
sent by a client probing a server */
+#define TLV_TYPE_PROBE_REPLY     0x00=
03 /* out-of-band, a server's answer to a probe request */
 
 /* TLV header=
 bit layout of the first 16-bit field */
 #define CTRL_MSG_TLV_OPTIONAL_FLA=
G 0x8000
@@ -96,4 +98,28 @@
  */
 bool ctrl_msg_tlv_next(struct buffer *buf=
, struct ctrl_msg_tlv_header *hdr, struct buffer *value);
 
+/**
+ * Scan p=
ayload for the TLV of type wanted_type, skipping any other (e=2Eg=2E
+ * fu=
ture) TLV type that is marked optional=2E
+ *
+ * This is for messages that=
 carry exactly one mandatory TLV, which matches the
+ * currently supported=
 OOB messages: any other TLV that is not marked optional
+ * invalidates th=
e message wherever it is present, so the whole sequence is
+ * walked=2E A =
message with several mandatory TLVs walks them with
+ * ctrl_msg_tlv_next()=
 instead=2E
+ *
+ * On success value covers exactly the found TLV's value b=
ytes; as with
+ * ctrl_msg_tlv_next(), a header claiming more bytes than pa=
yload holds is
+ * rejected rather than reported as found=2E payload is con=
sumed as it is read=2E
+ *
+ * @param payload      buffer positioned at a T=
LV header
+ * @param wanted_type  the TLV type to look for
+ * @param value=
        set to a buffer covering the found TLV's value; it points
+ *      =
               into payload and owns no storage
+ * @return true if the TLV=
 was found, false if it is not present, a TLV header
+ *         or value i=
s malformed or truncated, or a TLV we do not understand is
+ *         not =
marked optional=2E
+ */
+bool ctrl_msg_find_tlv(struct buffer *payload, uin=
t16_t wanted_type, struct buffer *value);
+
 #endif /* ifndef CONTROL_MSG_H=
 */
diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec
new file mode 10=
0644
index 0000000=2E=2E5f624be
--- /dev/null
+++ b/src/openvpn/oob=2Ec
@@ =
-0,0 +1,85 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP netw=
orks
+ *             over a single TCP/UDP port, with support for SSL/TLS-b=
ased
+ *             session authentication and key exchange,
+ *          =
   packet encryption, packet authentication, and
+ *             packet com=
pression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2En=
et>
+ *
+ *  This program is free software; you can redistribute it and/or =
modify
+ *  it under the terms of the GNU General Public License version 2
=
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This program =
is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for m=
ore details=2E
+ *
+ *  You should have received a copy of the GNU General =
Public License along
+ *  with this program; if not, see <https://www=2Egnu=
=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#=
endif
+
+#include "syshead=2Eh"
+
+#include "oob=2Eh"
+#include "control_ms=
g=2Eh"
+
+bool
+oob_probe_request_write(struct buffer *buf, const struct oo=
b_probe_request *r)
+{
+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_=
PROBE_REQUEST, false, OOB_PROBE_REQUEST_LEN)
+           && buf_write_u32(b=
uf, r->request_id)
+           && buf_write_u64(buf, r->timestamp)
+       =
    && buf_write_u32(buf, r->flags);
+}
+
+bool
+oob_probe_request_read(str=
uct buffer *buf, struct oob_probe_request *r)
+{
+    /* One bounds check c=
overs the whole value: every field read below then fits
+     * by construc=
tion (OOB_PROBE_REQUEST_LEN is the sum of their sizes), so
+     * none of =
them needs its own error handling=2E Trailing bytes this version
+     * do=
es not understand are simply left unread=2E */
+    if (buf_len(buf) < OOB_=
PROBE_REQUEST_LEN)
+    {
+        return false;
+    }
+    r->request_id =
=3D buf_read_u32(buf, NULL);
+    r->timestamp =3D buf_read_u64(buf, NULL);=

+    r->flags =3D buf_read_u32(buf, NULL);
+    return true;
+}
+
+bool
+o=
ob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply *r)
+=
{
+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REPLY, false, O=
OB_PROBE_REPLY_LEN)
+           && buf_write_u32(buf, r->request_id)
+     =
      && buf_write_u16(buf, r->priority)
+           && buf_write_u16(buf, =
r->weight)
+           && buf_write_u16(buf, r->max_latency_diff)
+        =
   && buf_write_u16(buf, r->connect_lifetime)
+           && buf_write_u16(=
buf, r->flags);
+}
+
+bool
+oob_probe_reply_read(struct buffer *buf, struct=
 oob_probe_reply *r)
+{
+    /* One bounds check for the whole value, as in=
 oob_probe_request_read()=2E */
+    if (buf_len(buf) < OOB_PROBE_REPLY_LEN=
)
+    {
+        return false;
+    }
+    r->request_id =3D buf_read_u32(=
buf, NULL);
+    r->priority =3D (uint16_t)buf_read_u16(buf);
+    r->weigh=
t =3D (uint16_t)buf_read_u16(buf);
+    r->max_latency_diff =3D (uint16_t)b=
uf_read_u16(buf);
+    r->connect_lifetime =3D (uint16_t)buf_read_u16(buf);=

+    r->flags =3D (uint16_t)buf_read_u16(buf);
+    return true;
+}
diff -=
-git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh
new file mode 100644
index=
 0000000=2E=2Ee3e4144
--- /dev/null
+++ b/src/openvpn/oob=2Eh
@@ -0,0 +1,10=
2 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ * =
            over a single TCP/UDP port, with support for SSL/TLS-based
+ * =
            session authentication and key exchange,
+ *             packet=
 encryption, packet authentication, and
+ *             packet compression=
=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
=
+ *  This program is free software; you can redistribute it and/or modify
+=
 *  it under the terms of the GNU General Public License version 2
+ *  as =
published by the Free Software Foundation=2E
+ *
+ *  This program is distr=
ibuted in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; w=
ithout even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more deta=
ils=2E
+ *
+ *  You should have received a copy of the GNU General Public L=
icense along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/l=
icenses/>=2E
+ */
+
+/**
+ * @file
+ * Encoding/decoding of out-of-band (P_=
CONTROL_OOB_V1) control messages=2E
+ *
+ * An OOB message payload is a seq=
uence of TLV entries; the TLVs it carries say
+ * what the message is: a cl=
ient probes a server with a probe request TLV, and
+ * the server answers w=
ith a probe reply TLV=2E The TLV framing and the TLV types
+ * are shared w=
ith the other TLV-based control messages and live in
+ * control_msg=2Eh; t=
his file defines the values of the OOB TLVs and the
+ * OOB-specific decisi=
ons taken on them=2E
+ */
+
+#ifndef OOB_H
+#define OOB_H
+
+#include "buff=
er=2Eh"
+#include "control_msg=2Eh"
+#include "session_id=2Eh"
+
+/* Minimu=
m on-wire value length (excluding the 4-byte TLV header) of each TLV:
+ * t=
he sizes of its fixed fields in wire order (see the structs below)=2E The
+=
 * value may be longer for forward compatibility; trailing bytes that are n=
ot
+ * understood are ignored on read=2E
+ *
+ * probe request: request_id =
(u32), timestamp (u64), flags (u32)
+ * probe reply: request_id (u32), then=
 priority, weight, max_latency_diff,
+ * connect_lifetime and flags (u16 ea=
ch) */
+#define OOB_PROBE_REQUEST_LEN ((uint16_t)(sizeof(uint32_t) + sizeof=
(uint64_t) + sizeof(uint32_t)))
+#define OOB_PROBE_REPLY_LEN   ((uint16_t)(=
sizeof(uint32_t) + 5 * sizeof(uint16_t)))
+
+/* probe request TLV (sent by =
the client to probe a server) */
+struct oob_probe_request
+{
+    uint32_t=
 request_id; /**< chosen by the client, echoed in the reply */
+    uint64_=
t timestamp;  /**< client clock as a UNIX timestamp */
+    uint32_t flags;=
      /**< client capability flags, currently must be 0 */
+};
+
+/* probe =
reply TLV (sent by the server to answer a probe request) */
+struct oob_pro=
be_reply
+{
+    uint32_t request_id;       /**< echoes the request_id of t=
he request */
+    uint16_t priority;         /**< DNS-SRV style priority (=
lower is preferred) */
+    uint16_t weight;           /**< DNS-SRV style w=
eight */
+    uint16_t max_latency_diff; /**< advertised candidate-band mar=
gin in ms;
+                                *   used unless the client conf=
igured its own */
+    uint16_t connect_lifetime; /**< seconds the reply st=
ays valid as the handshake reset */
+    uint16_t flags;            /**< se=
rver behaviour flags */
+};
+
+/**
+ * Write a complete probe request TLV (=
header + value) to buf=2E It is the whole
+ * payload of the OOB message pr=
obing a server=2E
+ */
+bool oob_probe_request_write(struct buffer *buf, co=
nst struct oob_probe_request *r);
+
+/**
+ * Read a probe request TLV value=
 from buf=2E
+ *
+ * buf must cover exactly the TLV's value, as returned by=
 ctrl_msg_find_tlv()=2E
+ * Trailing bytes beyond the fields understood her=
e are ignored, so a longer
+ * value from a future version still parses=2E
=
+ *
+ * @return true on success, false if buf is shorter than the mandatory=
 fields=2E
+ */
+bool oob_probe_request_read(struct buffer *buf, struct oob=
_probe_request *r);
+
+/**
+ * Write a complete probe reply TLV (header + v=
alue) to buf=2E It is the whole
+ * payload of the OOB message answering a =
probe request=2E
+ */
+bool oob_probe_reply_write(struct buffer *buf, const=
 struct oob_probe_reply *r);
+
+/**
+ * Read a probe reply TLV value from b=
uf=2E See oob_probe_request_read() for the
+ * calling convention=2E
+ */
+=
bool oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r);
+=

+#endif /* OOB_H */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec=

index 92f1991=2E=2E8e2a459 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/open=
vpn/ssl=2Ec
@@ -3701,8 +3701,9 @@
     bool new_link =3D false;
     struct=
 session_id sid; /* remote session ID */
 
-    /* verify legal opcode */
-=
    if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE)
+    /* verify legal opc=
ode=2E An out-of-band packet has no control message id and
+     * no ACK a=
rray, which is what we parse next=2E */
+    if (op < P_FIRST_OPCODE || op =
> P_LAST_OPCODE || opcode_is_oob(op))
     {
         if (op =3D=3D P_CONTR=
OL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
      =
   {
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 4=
05e5b4=2E=2E38fb8ed 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/=
ssl_pkt=2Ec
@@ -169,6 +169,8 @@
 {
     ASSERT(ks->key_id >=3D 0 && ks->key=
_id <=3D P_KEY_ID_MASK);
     ASSERT(opcode >=3D 0 && opcode <=3D P_LAST_OP=
CODE);
+    /* OOB packets carry no message id or ACK array */
+    ASSERT(=
!opcode_is_oob(opcode));
     uint8_t header =3D (uint8_t)(ks->key_id | (op=
code << P_OPCODE_SHIFT));
 
     /* Workaround for Softether servers=2E Sof=
tether has a bug that it only
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/op=
envpn/ssl_pkt=2Eh
index 5a1d194=2E=2Ed477d5a 100644
--- a/src/openvpn/ssl_p=
kt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,11 +58,23 @@
  * like P_CONTROL=
_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* define the rang=
e of legal opcodes
+/* Out-of-band control message, e=2Eg=2E a server probe=
=2E Not part of the reliable
+ * control channel: no control message id and=
 no ACK array, just TLVs
+ * after the session id; never handled by tls_pre=
_decrypt()=2E */
+#define P_CONTROL_OOB_V1 12
+
+/* define the range of def=
ined opcodes, in- and out-of-band
  * Since we do no longer support key-met=
hod 1 we consider
  * the v1 op codes invalid */
 #define P_FIRST_OPCODE 3
=
-#define P_LAST_OPCODE  11
+#define P_LAST_OPCODE  12
+
+/* Is op one of th=
e out-of-band opcodes? */
+static inline bool
+opcode_is_oob(int op)
+{
+  =
  return op =3D=3D P_CONTROL_OOB_V1;
+}
 
 /*
  * Define number of buffers =
for send and receive in the reliability layer=2E
@@ -256,6 +268,9 @@
      =
   case P_CONTROL_WKC_V1:
             return "P_CONTROL_WKC_V1";
 
+      =
  case P_CONTROL_OOB_V1:
+            return "P_CONTROL_OOB_V1";
+
        =
 case P_ACK_V1:
             return "P_ACK_V1";
 
diff --git a/tests/unit_t=
ests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index d=
9caa03=2E=2Ecb2ffd8 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++=
 b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -157,12 +157,13 @@
 	-I$(top_s=
rcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@=
TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOU=
RCES =3D test_pkt=2Ec test_control_msg=2Ec mock_msg=2Ec mock_msg=2Eh mock_w=
in32_execve=2Ec \
-	test_common=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=
=2Ec test_control_msg=2Ec test_oob=2Ec mock_msg=2Ec mock_msg=2Eh \
+	mock_w=
in32_execve=2Ec test_common=2Eh \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	=
$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=
=2Ec \
 	$(top_srcdir)/src/openvpn/control_msg=2Ec \
+	$(top_srcdir)/src/op=
envpn/oob=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec=
 \
diff --git a/tests/unit_tests/openvpn/test_oob=2Ec b/tests/unit_tests/op=
envpn/test_oob=2Ec
new file mode 100644
index 0000000=2E=2E4e06cfd
--- /dev=
/null
+++ b/tests/unit_tests/openvpn/test_oob=2Ec
@@ -0,0 +1,359 @@
+/*
+ *=
  OpenVPN -- An application to securely tunnel IP networks
+ *             =
over a single TCP/UDP port, with support for SSL/TLS-based
+ *             =
session authentication and key exchange,
+ *             packet encryption,=
 packet authentication, and
+ *             packet compression=2E
+ *
+ *  =
Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This pro=
gram is free software; you can redistribute it and/or modify
+ *  it under =
the terms of the GNU General Public License version 2
+ *  as published by =
the Free Software Foundation=2E
+ *
+ *  This program is distributed in the=
 hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even t=
he implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ =
*  You should have received a copy of the GNU General Public License along
=
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
=
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "sy=
shead=2Eh"
+
+#include <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <setjm=
p=2Eh>
+#include <cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#include "oob=
=2Eh"
+#include "test_common=2Eh"
+
+/* Write a probe request TLV and read =
it back; fields must survive the round
+ * trip and the whole buffer must b=
e consumed=2E */
+static void
+test_probe_request_roundtrip(void **state)
+=
{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_bu=
f_gc(128, &gc);
+
+    const struct oob_probe_request in =3D {
+        =2E=
request_id =3D 0xdeadbeef,
+        =2Etimestamp =3D 0x0123456789abcdefULL,=

+        =2Eflags =3D 0,
+    };
+    assert_true(oob_probe_request_write(=
&buf, &in));
+    /* header (4) + value (16) */
+    assert_int_equal(BLEN(=
&buf), 4 + OOB_PROBE_REQUEST_LEN);
+
+    /* the header codec, read from a =
copy so the scan below still sees it */
+    struct buffer peek =3D buf;
+ =
   struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_read_heade=
r(&peek, &hdr));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);=

+    assert_false(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, =
OOB_PROBE_REQUEST_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_m=
sg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(B=
LEN(&value), OOB_PROBE_REQUEST_LEN);
+
+    struct oob_probe_request out =
=3D { 0 };
+    assert_true(oob_probe_request_read(&value, &out));
+    ass=
ert_int_equal(in=2Erequest_id, out=2Erequest_id);
+    assert_true(in=2Etim=
estamp =3D=3D out=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Efla=
gs);
+    /* the scan consumed header and value alike */
+    assert_int_eq=
ual(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe request wire fo=
rmat is locked to the spec's field order
+ * (request_id, timestamp, flags)=
, big-endian=2E */
+static void
+test_probe_request_wire_format(void **stat=
e)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D allo=
c_buf_gc(128, &gc);
+
+    const struct oob_probe_request in =3D {
+       =
 =2Erequest_id =3D 0x11223344,
+        =2Etimestamp =3D 0x0102030405060708=
ULL,
+        =2Eflags =3D 0,
+    };
+    assert_true(oob_probe_request_wr=
ite(&buf, &in));
+
+    const uint8_t expected[] =3D {
+        0x00,
+    =
    0x02, /* TLV type 2 (not optional) */
+        0x00,
+        0x10, /* =
TLV value length =3D 16 */
+        0x11,
+        0x22,
+        0x33,
+  =
      0x44, /* request_id */
+        0x01,
+        0x02,
+        0x03,
+=
        0x04,
+        0x05,
+        0x06,
+        0x07,
+        0x08, /=
* timestamp */
+        0x00,
+        0x00,
+        0x00,
+        0x00, =
/* flags */
+    };
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+ =
   assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    gc_f=
ree(&gc);
+}
+
+/* Write a probe reply TLV and read it back=2E */
+static v=
oid
+test_probe_reply_roundtrip(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    str=
uct oob_probe_reply in =3D {
+        =2Erequest_id =3D 0x11223344,
+      =
  =2Epriority =3D 10,
+        =2Eweight =3D 100,
+        =2Econnect_lifet=
ime =3D 30,
+        =2Eflags =3D 1,
+        =2Emax_latency_diff =3D 25,
+=
    };
+
+    assert_true(oob_probe_reply_write(&buf, &in));
+    assert_in=
t_equal(BLEN(&buf), 4 + OOB_PROBE_REPLY_LEN);
+
+    struct buffer peek =3D=
 buf;
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_re=
ad_header(&peek, &hdr));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_R=
EPLY);
+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);
+
+    =
struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROB=
E_REPLY, &value));
+
+    struct oob_probe_reply out =3D { 0 };
+    assert=
_true(oob_probe_reply_read(&value, &out));
+    assert_int_equal(in=2Ereque=
st_id, out=2Erequest_id);
+    assert_int_equal(in=2Epriority, out=2Epriori=
ty);
+    assert_int_equal(in=2Eweight, out=2Eweight);
+    assert_int_equa=
l(in=2Econnect_lifetime, out=2Econnect_lifetime);
+    assert_int_equal(in=
=2Eflags, out=2Eflags);
+    assert_int_equal(in=2Emax_latency_diff, out=2E=
max_latency_diff);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc=
);
+}
+
+/* The probe reply wire format is locked to the spec's field order=
 (request_id,
+ * priority, weight, max_latency_diff, connect_lifetime, fla=
gs), big-endian=2E */
+static void
+test_probe_reply_wire_format(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D all=
oc_buf_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+        =2Ereq=
uest_id =3D 0x11223344,
+        =2Epriority =3D 10,
+        =2Eweight =3D=
 100,
+        =2Econnect_lifetime =3D 30,
+        =2Eflags =3D 1,
+      =
  =2Emax_latency_diff =3D 25,
+    };
+
+    assert_true(oob_probe_reply_wr=
ite(&buf, &in));
+
+    const uint8_t expected[] =3D {
+        0x00,
+    =
    0x03, /* TLV type 3 (not optional) */
+        0x00,
+        0x0e, /* =
TLV value length =3D 14 */
+        0x11,
+        0x22,
+        0x33,
+  =
      0x44, /* request_id */
+        0x00,
+        0x0a, /* priority =3D =
10 */
+        0x00,
+        0x64, /* weight =3D 100 */
+        0x00,
+  =
      0x19, /* max_latency_diff =3D 25 */
+        0x00,
+        0x1e, /* =
connect_lifetime =3D 30 */
+        0x00,
+        0x01, /* flags =3D 1 */
=
+    };
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_me=
mory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    gc_free(&gc);
+}=

+
+/* A TLV with a longer-than-known value must still parse: the known fie=
lds are
+ * read and the trailing bytes are skipped (forward compatibility)=
=2E */
+static void
+test_probe_request_forward_compat(void **state)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(=
128, &gc);
+
+    const uint16_t extended_len =3D OOB_PROBE_REQUEST_LEN + 4=
;
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST, =
false, extended_len));
+    assert_true(buf_write_u32(&buf, 7));          /=
* request_id */
+    assert_true(buf_write_u32(&buf, 0));          /* times=
tamp high */
+    assert_true(buf_write_u32(&buf, 0xdeadbeef)); /* timestam=
p low */
+    assert_true(buf_write_u32(&buf, 0));          /* flags */
+  =
  assert_true(buf_write_u32(&buf, 0x11223344)); /* unknown trailing field *=
/
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_=
TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value), extended_=
len);
+
+    struct oob_probe_request out =3D { 0 };
+    assert_true(oob_p=
robe_request_read(&value, &out));
+    assert_int_equal(out=2Erequest_id, 7=
);
+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);
+    assert_int_=
equal(out=2Eflags, 0);
+    /* the unknown trailing field must have been co=
nsumed from the payload */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_=
free(&gc);
+}
+
+/* A value shorter than the mandatory fields must be rejec=
ted, even when it
+ * holds enough bytes for some of the individual fields =
to read successfully=2E */
+static void
+test_probe_request_too_short(void =
**state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    /* 4 of the 16 mandatory value bytes: en=
ough for the request_id alone */
+    assert_true(buf_write_u32(&buf, 0xdea=
dbeef));
+
+    struct oob_probe_request out =3D { 0 };
+    assert_false(o=
ob_probe_request_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* A TLV hea=
der claiming more value bytes than the payload holds must be
+ * rejected b=
y the scan rather than reported as found -- for the TLV being
+ * looked fo=
r as much as for one that would merely be skipped=2E */
+static void
+test_=
find_tlv_value_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_ne=
w();
+    struct buffer value;
+
+    /* the wanted TLV declares 12 value b=
ytes, only 4 are present */
+    struct buffer buf =3D alloc_buf_gc(128, &g=
c);
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST=
, false,
+                                          OOB_PROBE_REQUEST_LEN))=
;
+    assert_true(buf_write_u32(&buf, 0xdeadbeef));
+    assert_false(ctrl=
_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    /* same defect=
 on a TLV that would be skipped: the scan must not walk past
+     * the en=
d of the payload looking for the next header */
+    struct buffer buf2 =3D=
 alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&buf2, =
0x7ff, false, 64));
+    assert_true(buf_write_u32(&buf2, 0));
+    assert_=
false(ctrl_msg_find_tlv(&buf2, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_=
free(&gc);
+}
+
+/* Bytes left over after the last TLV that are too few for=
 a header make the
+ * message malformed, even when the wanted TLV was alre=
ady found=2E */
+static void
+test_find_tlv_trailing_bytes(void **state)
+{=

+    struct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+    /* =
1 to 3 bytes: less than a 4-byte TLV header */
+    for (int trailing =3D 1=
; trailing <=3D 3; trailing++)
+    {
+        struct buffer buf =3D alloc_=
buf_gc(128, &gc);
+        const struct oob_probe_request in =3D { =2Etimes=
tamp =3D 1, =2Eflags =3D 0 };
+        assert_true(oob_probe_request_write(=
&buf, &in));
+        for (int i =3D 0; i < trailing; i++)
+        {
+    =
        assert_true(buf_write_u8(&buf, 0));
+        }
+        assert_fals=
e(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    }
+
+    g=
c_free(&gc);
+}
+
+/* An unknown TLV marked optional after the wanted one i=
s skipped, and the
+ * wanted value is still the one returned=2E */
+static=
 void
+test_find_tlv_skips_optional_after_wanted(void **state)
+{
+    stru=
ct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &=
gc);
+    struct buffer value;
+
+    const struct oob_probe_request in =3D=
 { =2Etimestamp =3D 7, =2Eflags =3D 0 };
+    assert_true(oob_probe_request=
_write(&buf, &in));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff,=
 true, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    assert_true(ct=
rl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equ=
al(BLEN(&value), OOB_PROBE_REQUEST_LEN);
+    struct oob_probe_request out =
=3D { 0 };
+    assert_true(oob_probe_request_read(&value, &out));
+    ass=
ert_true(out=2Etimestamp =3D=3D 7);
+
+    gc_free(&gc);
+}
+
+/* An empty =
payload holds no TLV=2E */
+static void
+test_find_tlv_empty_payload(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(16, &gc);
+    struct buffer value;
+
+    assert_false(ctrl_=
msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+=
}
+
+/* The OOB tests run as a second group of pkt_testdriver; see test_pkt=
=2Ec=2E */
+int
+run_oob_tests(void)
+{
+    const struct CMUnitTest tests[=
] =3D {
+        cmocka_unit_test(test_probe_request_roundtrip),
+        c=
mocka_unit_test(test_probe_request_wire_format),
+        cmocka_unit_test(=
test_probe_reply_roundtrip),
+        cmocka_unit_test(test_probe_reply_wir=
e_format),
+        cmocka_unit_test(test_probe_request_forward_compat),
+ =
       cmocka_unit_test(test_probe_request_too_short),
+        cmocka_unit=
_test(test_find_tlv_value_truncated),
+        cmocka_unit_test(test_find_t=
lv_trailing_bytes),
+        cmocka_unit_test(test_find_tlv_skips_optional_=
after_wanted),
+        cmocka_unit_test(test_find_tlv_empty_payload),
+   =
 };
+
+    return cmocka_run_group_tests_name("oob tests", tests, NULL, NUL=
L);
+}
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_test=
s/openvpn/test_pkt=2Ec
index 9ce9c50=2E=2E0398a1f 100644
--- a/tests/unit_t=
ests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -4=
6,6 +46,7 @@
 #include "siphash=2Eh"
 
 int run_control_msg_tests(void); /*=
 test_control_msg=2Ec */
+int run_oob_tests(void);         /* test_oob=2Ec =
*/
 
 int
 parse_line(const char *line, char **p, const int n, const char *=
file, const int line_num,
@@ -794,5 +795,6 @@
 
     int failed =3D cmocka_=
run_group_tests_name("pkt tests", tests, NULL, NULL);
     failed +=3D run_=
control_msg_tests();
+    failed +=3D run_oob_tests();
     return failed ?=
 1 : 0;
 }

-- 
To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/17=
41?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d3=
02ac57c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-Patch=
Set: 19
Gerrit-Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flicht=
enheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@r=
fc2549=2Eorg>
Gerrit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: =
openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: r=
alf_lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: stipa <lstipakov@gmail=2E=
com>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attent=
ion: flichtenheld <frank@lichtenheld=2Ecom>

--6DDGakVHOBA=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici, stipa=2E </p>
<p>=
stipa <strong>uploaded patch set #19</strong> to this change=2E</p><p><a hr=
ef=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Re=
view-1 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">oob: Add P_CONTROL_OOB_V1 and the prob=
e request and reply TLVs<br><br>Out-of-band control messages carry control =
data but belong to no<br>session, so a client can ask a server about itself=
 before connecting=2E<br>Reserve opcode 12 for them and add the TLV codecs =
the probe needs: the<br>probe request a client probes a server with, and th=
e probe reply the<br>server answers with=2E<br><br>A message is just a sequ=
ence of TLVs, and the TLVs it carries say what<br>it is=2E The probe reques=
t carries a request_id chosen by the client,<br>which the probe reply echoe=
s=2E<br><br>The TLVs use the shared TLV codec, control_msg=2Ec/h, and their=
 two types<br>join the others in control_msg=2Eh=2E The codec gains ctrl_ms=
g_find_tlv(),<br>which scans a payload for the one mandatory TLV of a messa=
ge=2E The scan<br>is strict: a truncated TLV header or value, or an unknown=
 TLV not marked<br>optional, rejects the whole message=2E<br><br>P_LAST_OPC=
ODE becomes 12=2E tls_pre_decrypt() rejects the OOB opcodes<br>explicitly: =
they are not part of the reliable control channel (no<br>control message id=
, no ACK array); the server answers them<br>statelessly in a follow-up=2E<b=
r><br>Change-Id: I1c8d302ac57c5603d622a7be14be369437388268<br>Signed-off-by=
: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M =
src/openvpn/Makefile=2Eam<br>M src/openvpn/control_msg=2Ec<br>M src/openvpn=
/control_msg=2Eh<br>A src/openvpn/oob=2Ec<br>A src/openvpn/oob=2Eh<br>M src=
/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<=
br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/t=
est_oob=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>12 files changed,=
 632 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/19</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index e1a6079f=
=2E=2E8a062b8 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><span=
>+++ b/CMakeLists=2Etxt</span><br><span>@@ -525,6 +525,8 @@</span><br><span=
>     src/openvpn/multi_io=2Ec</span><br><span>     src/openvpn/occ=2Ec</sp=
an><br><span>     src/openvpn/occ=2Eh</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    src/openvpn/oob=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    src/openvpn/oob=2Eh</span><br><span>     src/open=
vpn/openvpn=2Ec</span><br><span>     src/openvpn/openvpn=2Eh</span><br><spa=
n>     src/openvpn/openvpn_win32_resources=2Erc</span><br><span>@@ -886,7 +=
888,9 @@</span><br><span>     target_sources(test_pkt PRIVATE</span><br><sp=
an>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>=
         tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/test_oo=
b=2Ec</span><br><span>         src/openvpn/control_msg=2Ec</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/oob=2Ec</span><b=
r><span>         src/openvpn/argv=2Ec</span><br><span>         src/openvpn/=
base64=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br>=
<span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</s=
pan><br><span>index a17ae8e=2E=2E5e6b4d9 100644</span><br><span>--- a/src/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span>=
<br><span>@@ -108,6 +108,7 @@</span><br><span> 	pkcs11=2Ec pkcs11=2Eh pkcs1=
1_backend=2Eh \</span><br><span> 	pkcs11_openssl=2Ec \</span><br><span> 	pk=
cs11_mbedtls=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
oob=2Ec oob=2Eh \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><br><sp=
an> 	options=2Ec options=2Eh \</span><br><span> 	options_show=2Ec options_s=
how=2Eh \</span><br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/op=
envpn/control_msg=2Ec</span><br><span>index ca3aab9=2E=2E76f0cfa 100644</sp=
an><br><span>--- a/src/openvpn/control_msg=2Ec</span><br><span>+++ b/src/op=
envpn/control_msg=2Ec</span><br><span>@@ -81,3 +81,31 @@</span><br><span>  =
   buf_set_read(value, v, hdr-&gt;value_len);</span><br><span>     return t=
rue;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_find_tlv(struct buffe=
r *payload, uint16_t wanted_type, struct buffer *value)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool found =3D false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    while (BLEN(payload) &gt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header hdr;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct buffer v;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_n=
ext(payload, &amp;hdr, &amp;v))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            return false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (hdr=2Etype =3D=3D wanted_type)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            if (!found)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                *value =3D v;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                found =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        else if (!hdr=2Eoptional)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return false; /* a mandatory TLV we do not u=
nderstand, wherever it sits */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fo=
und;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an>diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</=
span><br><span>index 73fd0a1=2E=2Ee731590 100644</span><br><span>--- a/src/=
openvpn/control_msg=2Eh</span><br><span>+++ b/src/openvpn/control_msg=2Eh</=
span><br><span>@@ -41,6 +41,8 @@</span><br><span> </span><br><span> /* TLV =
types */</span><br><span> #define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early =
negotiation, in the reset packets */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define TLV_TYPE_PROBE_REQUEST   0x0002 /* out-of-band, se=
nt by a client probing a server */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define TLV_TYPE_PROBE_REPLY     0x0003 /* out-of-band, a se=
rver&#39;s answer to a probe request */</span><br><span> </span><br><span> =
/* TLV header bit layout of the first 16-bit field */</span><br><span> #def=
ine CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span>@@ -96,4 +98,28 @@</s=
pan><br><span>  */</span><br><span> bool ctrl_msg_tlv_next(struct buffer *b=
uf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Scan payload for the TLV of ty=
pe wanted_type, skipping any other (e=2Eg=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * future) TLV type that is marked optional=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * This is for messages that carry exact=
ly one mandatory TLV, which matches the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * currently supported OOB messages: any other TLV that=
 is not marked optional</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * invalidates the message wherever it is present, so the whole sequenc=
e is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * walked=2E A =
message with several mandatory TLVs walks them with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * ctrl_msg_tlv_next() instead=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * On success value covers exactly the found=
 TLV&#39;s value bytes; as with</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * ctrl_msg_tlv_next(), a header claiming more bytes than paylo=
ad holds is</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejec=
ted rather than reported as found=2E payload is consumed as it is read=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param payload      buffer position=
ed at a TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param wanted_type  the TLV type to look for</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param value        set to a buffer covering =
the found TLV&#39;s value; it points</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *                     into payload and owns no storage</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the=
 TLV was found, false if it is not present, a TLV header</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *         or value is malformed or tr=
uncated, or a TLV we do not understand is</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *         not marked optional=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool ctrl_msg_find_tlv(struct buffer *payload, uint16_t=
 wanted_type, struct buffer *value);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span> #endif /* ifndef CONTROL_MSG_H */</span>=
<br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2E5f624be</span=
><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Ec</span><b=
r><span>@@ -0,0 +1,85 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN =
-- An application to securely tunnel IP networks</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             session authentication and key exchange,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryptio=
n, packet authentication, and</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet compression=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software;=
 you can redistribute it and/or modify</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  it under the terms of the GNU General Public License=
 version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pu=
blished by the Free Software Foundation=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  This program is distributed in the hope that it will be useful,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY W=
ARRANTY; without even the implied warranty of</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR P=
URPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  GNU General Public License for more details=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  You should have received a copy of the GNU General Public =
License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wi=
th this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;oob=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_probe_re=
quest_write(struct buffer *buf, const struct oob_probe_request *r)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, TLV_=
TYPE_PROBE_REQUEST, false, OOB_PROBE_REQUEST_LEN)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, r-&g=
t;request_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
     &amp;&amp; buf_write_u64(buf, r-&gt;timestamp)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, =
r-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+oob_probe_request_read(struct buffer *buf, struct oob_pr=
obe_request *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds chec=
k covers the whole value: every field read below then fits</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * by construction (OOB_PROBE_RE=
QUEST_LEN is the sum of their sizes), so</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * none of them needs its own error handling=2E Tr=
ailing bytes this version</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * does not understand are simply left unread=2E */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; OOB_PRO=
BE_REQUEST_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;request_id =3D buf_r=
ead_u32(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    r-&gt;timestamp =3D buf_read_u64(buf, NULL);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply *r)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(b=
uf, TLV_TYPE_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(buf, =
r-&gt;request_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         &amp;&amp; buf_write_u16(buf, r-&gt;priority)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf,=
 r-&gt;weight)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
      &amp;&amp; buf_write_u16(buf, r-&gt;max_latency_diff)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16=
(buf, r-&gt;connect_lifetime)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;flags);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob_pro=
be_reply_read(struct buffer *buf, struct oob_probe_reply *r)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* One bounds check for the whole value, as in o=
ob_probe_request_read()=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (buf_len(buf) &lt; OOB_PROBE_REPLY_LEN)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    r-&gt;request_id =3D buf_read_u32(buf, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16_t)b=
uf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  r-&gt;weight =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)buf_re=
ad_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&=
gt;connect_lifetime =3D (uint16_t)buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D (uint16_t)buf_read_u1=
6(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000=2E=2Ee3e4144</span><br><s=
pan>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Eh</span><br><span=
>@@ -0,0 +1,102 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An =
application to securely tunnel IP networks</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with supp=
ort for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             session authentication and key exchange,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pac=
ket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *             packet compression=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is distributed in the hope that it will be useful,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANT=
Y; without even the implied warranty of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU=
 General Public License for more details=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Encoding/=
decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * An OOB message payload is a sequence of TLV en=
tries; the TLVs it carries say</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * what the message is: a client probes a server with a probe re=
quest TLV, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * th=
e server answers with a probe reply TLV=2E The TLV framing and the TLV type=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are shared with=
 the other TLV-based control messages and live in</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * control_msg=2Eh; this file defines the val=
ues of the OOB TLVs and the</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * OOB-specific decisions taken on them=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def OOB_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OO=
B_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_=
msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Minimu=
m on-wire value length (excluding the 4-byte TLV header) of each TLV:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the sizes of its fixed=
 fields in wire order (see the structs below)=2E The</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * value may be longer for forward compat=
ibility; trailing bytes that are not</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * understood are ignored on read=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * probe request: request_id (u32), timestamp (u64), flags=
 (u32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * probe repl=
y: request_id (u32), then priority, weight, max_latency_diff,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * connect_lifetime and flags (u1=
6 each) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define O=
OB_PROBE_REQUEST_LEN ((uint16_t)(sizeof(uint32_t) + sizeof(uint64_t) + size=
of(uint32_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne OOB_PROBE_REPLY_LEN   ((uint16_t)(sizeof(uint32_t) + 5 * sizeof(uint16_t=
)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* probe request TLV (sent by the c=
lient to probe a server) */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+struct oob_probe_request</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int32_t request_id; /**&lt; chosen by the client, echoed in the reply */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t timestamp=
;  /**&lt; client clock as a UNIX timestamp */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    uint32_t flags;      /**&lt; client capabili=
ty flags, currently must be 0 */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe reply TLV (sen=
t by the server to answer a probe request) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+struct oob_probe_reply</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    uint32_t request_id;       /**&lt; echoes the request_id of =
the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
int16_t priority;         /**&lt; DNS-SRV style priority (lower is preferre=
d) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t w=
eight;           /**&lt; DNS-SRV style weight */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    uint16_t max_latency_diff; /**&lt; adverti=
sed candidate-band margin in ms;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                *   used unless the client con=
figured its own */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t connect_lifetime; /**&lt; seconds the reply stays valid as the =
handshake reset */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t flags;            /**&lt; server behaviour flags */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write=
 a complete probe request TLV (header + value) to buf=2E It is the whole</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * payload of the OOB =
message probing a server=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob=
_probe_request_write(struct buffer *buf, const struct oob_probe_request *r)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Read a probe request TLV value from buf=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * buf must cover exactly the TLV&#39;s valu=
e, as returned by ctrl_msg_find_tlv()=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Trailing bytes beyond the fields understood here ar=
e ignored, so a longer</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * value from a future version still parses=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @return true on success, false if buf is shorter than the m=
andatory fields=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_probe_re=
quest_read(struct buffer *buf, struct oob_probe_request *r);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Write a complete probe reply TLV (header + value) to buf=2E It is =
the whole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * payload=
 of the OOB message answering a probe request=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool oob_probe_reply_write(struct buffer *buf, const struct oo=
b_probe_reply *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe reply TLV value from=
 buf=2E See oob_probe_request_read() for the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * calling convention=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool oob_probe_reply_read(struct buffer *buf, struct oob_prob=
e_reply *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_H */</span><=
br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><=
span>index 92f1991=2E=2E8e2a459 100644</span><br><span>--- a/src/openvpn/ss=
l=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3701,8 =
+3701,9 @@</span><br><span>     bool new_link =3D false;</span><br><span>  =
   struct session_id sid; /* remote session ID */</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* verify legal opcode */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIR=
ST_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* verify legal opcode=2E An out-of-band packet has no =
control message id and</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * no ACK array, which is what we parse next=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (op &lt; P_FIRST_OPCODE || op =
&gt; P_LAST_OPCODE || opcode_is_oob(op))</span><br><span>     {</span><br><=
span>         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_C=
ONTROL_HARD_RESET_SERVER_V1)</span><br><span>         {</span><br><span>dif=
f --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span=
>index 405e5b4=2E=2E38fb8ed 100644</span><br><span>--- a/src/openvpn/ssl_pk=
t=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -169=
,6 +169,8 @@</span><br><span> {</span><br><span>     ASSERT(ks-&gt;key_id &=
gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span> =
    ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB packets carry =
no message id or ACK array */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(!opcode_is_oob(opcode));</span><br><span>     uint8_t =
header =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</sp=
an><br><span> </span><br><span>     /* Workaround for Softether servers=2E =
Softether has a bug that it only</span><br><span>diff --git a/src/openvpn/s=
sl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 5a1d194=2E=2Ed47=
7d5a 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+=
++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,11 +58,23 @@</span><br>=
<span>  * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P=
_CONTROL_WKC_V1 11</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-/* define the range of legal opcodes</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Out-of-band control message, e=2Eg=2E =
a server probe=2E Not part of the reliable</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * control channel: no control message id and no ACK=
 array, just TLVs</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 after the session id; never handled by tls_pre_decrypt()=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_V1 12</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* define the range of defined opcodes, i=
n- and out-of-band</span><br><span>  * Since we do no longer support key-me=
thod 1 we consider</span><br><span>  * the v1 op codes invalid */</span><br=
><span> #define P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define P_LAST_OPCODE  11</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define P_LAST_OPCODE  12</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Is op one of the out-of-band opcodes? */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+opcode_is_oob(int op)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return op =3D=3D P_CONTROL_OOB_V1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> /*</span=
><br><span>  * Define number of buffers for send and receive in the reliabi=
lity layer=2E</span><br><span>@@ -256,6 +268,9 @@</span><br><span>         =
case P_CONTROL_WKC_V1:</span><br><span>             return &quot;P_CONTROL_=
WKC_V1&quot;;</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        case P_CONTROL_OOB_V1:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            return &quot;P_CONTROL_OOB_V1&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>      =
   case P_ACK_V1:</span><br><span>             return &quot;P_ACK_V1&quot;;=
</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/Ma=
kefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>index =
d9caa03=2E=2Ecb2ffd8 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>@@ -157,12 +157,13 @@</span><br><span> 	-I$(top_srcdir)/inc=
lude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><sp=
an> 	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAG=
S@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOUR=
CES =3D test_pkt=2Ec test_control_msg=2Ec mock_msg=2Ec mock_msg=2Eh mock_wi=
n32_execve=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	test=
_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkt_te=
stdriver_SOURCES =3D test_pkt=2Ec test_control_msg=2Ec test_oob=2Ec mock_ms=
g=2Ec mock_msg=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	mock_win32_execve=2Ec test_common=2Eh \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2E=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/crypto_mbedtls=2Ec \</span><br><span>diff --git a/tests/unit_tests/open=
vpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000=2E=2E4e06cfd</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_oob=2E=
c</span><br><span>@@ -0,0 +1,359 @@</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  OpenVPN -- An application to securely tunnel IP networks</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UD=
P port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             session authentication and key exchange,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packe=
t encryption, packet authentication, and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet compression=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@open=
vpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is fre=
e software; you can redistribute it and/or modify</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Pub=
lic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  as published by the Free Software Foundation=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  This program is distributed in the hope that it will b=
e useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WI=
THOUT ANY WARRANTY; without even the implied warranty of</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A P=
ARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Gene=
ral Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/license=
s/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe request TLV and =
read it back; fields must survive the round</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * trip and the whole buffer must be consumed=2E */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_roundtri=
p(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc=
 =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const struct oob_probe_request in =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0xdeadbeef,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =
=3D 0x0123456789abcdefULL,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(oob_probe_request_write(&amp;buf, &amp;in));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* header (4) + value (16) */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(B=
LEN(&amp;buf), 4 + OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* the header codec, read from a copy so the scan below still sees =
it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buf=
fer peek =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, OO=
B_PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN=
(&amp;value), OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct oob_probe_request out =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_read(&amp;value, &=
amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(in=2Erequest_id, out=2Erequest_id);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etim=
estamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* the scan consumed header and value alike */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&a=
mp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* The probe request wire format is locked to the spec&#39;s=
 field order</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (req=
uest_id, timestamp, flags), big-endian=2E */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_probe_request_wire_format(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_bu=
f_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oo=
b_probe_request in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        =2Erequest_id =3D 0x11223344,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0102030405060708ULL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request=
_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t expected[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      0x02, /* TLV type 2 (not optional) */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        0x10, /* TLV value length =3D 16 */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        0x11,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        0x22,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        0x33,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        0x44, /* request_id */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        0x01,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        0x02,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        0x03,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        0x04,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        0x05,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        0x06,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       0x07,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 0x08, /* timestamp */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0=
x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, /=
* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(B=
LEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expe=
cted));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Write a probe reply TLV and read it back=2E */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+test_probe_reply_roundtrip(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct oob_probe_reply in =3D {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        =2Erequest_id =3D 0x11223344,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 3=
0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =
=3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ema=
x_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_rep=
ly_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE_REPLY_LEN);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =3D buf;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_heade=
r hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE_PR=
OBE_REPLY);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PR=
OBE_REPLY, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct oob=
_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(oob_probe_reply_read(&amp;value, &amp;out));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2E=
request_id, out=2Erequest_id);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(in=2Epriority, out=2Epriority);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eweigh=
t, out=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Efl=
ags, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&=
amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* The probe reply wire format is locked to the spec&#39;s f=
ield order (request_id,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * priority, weight, max_latency_diff, connect_lifetime, flags), big-en=
dian=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_=
wire_format(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0x11223344,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =
=3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ew=
eight =3D 100,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const uint8_t expected[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0x03, /* TLV type 3 (not optional) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        0x0e, /* TLV value =
length =3D 14 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     0x11,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0=
x22,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x33,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x44, /* requ=
est_id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x=
00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x0a, /*=
 priority =3D 10 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  0x64, /* weight =3D 100 */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        0x19, /* max_latency_diff =3D 25 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        0x1e, /* connect_lifetime =3D 30 */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        0x01, /* flags =3D 1 */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), =
sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A T=
LV with a longer-than-known value must still parse: the known fields are</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read and the traili=
ng bytes are skipped (forward compatibility)=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_probe_request_forward_compat(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint16_t extended_len =3D OOB_PROBE_REQUEST_LEN + 4;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_head=
er(&amp;buf, TLV_TYPE_PROBE_REQUEST, false, extended_len));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;=
buf, 7));          /* request_id */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));          /* ti=
mestamp high */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(buf_write_u32(&amp;buf, 0xdeadbeef)); /* timestamp low */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write=
_u32(&amp;buf, 0));          /* flags */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344)); =
/* unknown trailing field */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(BLEN(&amp;value), extended_len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct oob_probe_request out =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(oob_probe_request_read(&amp;value, &am=
p;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(out=2Erequest_id, 7);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=2Ef=
lags, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the=
 unknown trailing field must have been consumed from the payload */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&=
amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* A value shorter than the mandatory fields must be rejecte=
d, even when it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * h=
olds enough bytes for some of the individual fields to read successfully=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_too_s=
hort(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* 4 of the 16 mandatory value bytes: enough for the req=
uest_id alone */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct oob_probe_request out =3D { 0 };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_probe_request_read=
(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* A TLV header claiming more value bytes than the =
payload holds must be</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * rejected by the scan rather than reported as found -- for the TLV bein=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * looked for as m=
uch as for one that would merely be skipped=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+test_find_tlv_value_truncated(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* the wanted TLV declares 12 value byte=
s, only 4 are present */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_h=
eader(&amp;buf, TLV_TYPE_PROBE_REQUEST, false,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                          OOB_PR=
OBE_REQUEST_LEN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;b=
uf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* same defect on a TLV that would be skipped: the scan must not wal=
k past</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the en=
d of the payload looking for the next header */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf2 =3D alloc_buf_gc(128, &a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(ctrl_msg_tlv_write_header(&amp;buf2, 0x7ff, false, 64));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp=
;buf2, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_false(ctrl_msg_find_tlv(&amp;buf2, TLV_TYPE_PROBE_REQUEST, &amp;value));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Bytes left over after the last TLV that are too few for a header make =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * message malfo=
rmed, even when the wanted TLV was already found=2E */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_find_tlv_trailing_bytes(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* 1 to 3 bytes: less than a 4-byt=
e TLV header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
for (int trailing =3D 1; trailing &lt;=3D 3; trailing++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(128, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const =
struct oob_probe_request in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(oob=
_probe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; trailing; i++)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            assert_true(buf_write_u=
8(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        asser=
t_false(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknown =
TLV marked optional after the wanted one is skipped, and the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * wanted value is still the one r=
eturned=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_=
skips_optional_after_wanted(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer va=
lue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_request=
 in =3D { =2Etimestamp =3D 7, =2Eflags =3D 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_write(&amp;bu=
f, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&=
amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_=
find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value),=
 OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct oob_probe_request out =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_read(&amp;va=
lue, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(out=2Etimestamp =3D=3D 7);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* An empty payload holds no TLV=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_empty_p=
ayload(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_P=
ROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* The OOB tests run as a second group of pkt_=
testdriver; see test_pkt=2Ec=2E */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
un_oob_tests(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct CM=
UnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_probe_request_roundtrip),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_=
request_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_probe_reply_roundtrip),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_rep=
ly_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_probe_request_forward_compat),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_r=
equest_too_short),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_find_tlv_value_truncated),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_=
trailing_bytes),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test=
_find_tlv_empty_payload),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_grou=
p_tests_name(&quot;oob tests&quot;, tests, NULL, NULL);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span=
><br><span>index 9ce9c50=2E=2E0398a1f 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>@@ -46,6 +46,7 @@</span><br><span> #include =
&quot;siphash=2Eh&quot;</span><br><span> </span><br><span> int run_control_=
msg_tests(void); /* test_control_msg=2Ec */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+int run_oob_tests(void);         /* test_oob=2Ec */=
</span><br><span> </span><br><span> int</span><br><span> parse_line(const c=
har *line, char **p, const int n, const char *file, const int line_num,</sp=
an><br><span>@@ -794,5 +795,6 @@</span><br><span> </span><br><span>     int=
 failed =3D cmocka_run_group_tests_name(&quot;pkt tests&quot;, tests, NULL,=
 NULL);</span><br><span>     failed +=3D run_control_msg_tests();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    failed +=3D run_oob_tests=
();</span><br><span>     return failed ? 1 : 0;</span><br><span> }</span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: =
newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </d=
iv>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D=
"display:none"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268=
 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div=
 style=3D"display:none"> Gerrit-PatchSet: 19 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=
=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;ar=
ne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Rev=
iewer: ralf_lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:=
none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ra=
lf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Attention=
: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> G=
errit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div s=
tyle=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenheld=
=2Ecom&gt; </div>

</body></html>
--6DDGakVHOBA=--


--===============3549954409028963887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3549954409028963887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============3549954409028963887==--

