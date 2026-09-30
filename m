Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AD5FCA5FB1
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=kobns+inZE7HHhuG+TE2B0swcpHSd6fuBZjoJBNlQWI=; b=iM/CH1ar+ZkU27
	UU6raDTppxEl10wAgfVAhoNbMvrWNR0neF3FNj9Gcm/n0vaprzazYgs3bFDViRfwLPpuYaNDyWo63
	50XZqqjfyVjTPdXZUsOPVIfKT/616Aeio/xJ0iIjFHB7q3NpzEqz0Vj7cSYMOuwVdOkL92tClQQJ2
	74s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xBpeE-0003aC-Es;
	Wed, 30 Sep 2026 08:26:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xBpe5-0003ZL-6H
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:
 From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LmnXGbt1NI5fVTwFuAyrIG56txZHMWiL1OEz0lnGqd4=; b=ROKxt85T1k+VmVMHJjcf56F3Zk
 aBakF+VK+k67Er1Kuisf69wuUVbaAKAapZ5bJGawuwyo1QCNwd3Q5jC0pSZ+GHAQH6qSoHjYi2F/7
 iiqx+n9xszOAx8jgUyInRu7wHcUUI3nNl8kf7P9R4Jv1uET8TxcZ3adJ0fssr7fpCHcc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:List-Unsubscribe:List-Id:Cc:To:Date:From:Sender:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:In-Reply-To:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LmnXGbt1NI5fVTwFuAyrIG56txZHMWiL1OEz0lnGqd4=; b=g
 HRoaBbgOKr8YnmSoMnIrtpRYJzm6oLaSC77CfPG2/A6BpQN13yfEFWkZqCMQo7vWcedJ/tGjf3PDL
 Y5s3FLo8CthpqloJckdIqVP8mvVUf39wJX9azyrutOmtUFLzSb2/K790gmT9LCd00ax4h7ryNcDbP
 /e/17C9+CeQQeQ4E=;
Received: from mail-wm2-f13.google.com ([74.125.225.141])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBpe1-0005pJ-7i for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:26:33 +0000
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49fe8bf173aso26694325e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 01:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790756783; x=1791361583; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=LmnXGbt1NI5fVTwFuAyrIG56txZHMWiL1OEz0lnGqd4=;
 b=GEv/4L/oW0IICyK8pkGEy3rF7a4rYC472FgQ8aFWXR4164F3lvrgmHqg9RyuVNRTSJ
 zgnK46f16J+0RKPguw3xAudq69BZMnPw7bpwctoUh/37iw5SNQROVLNdRyMDUMivbfCg
 QwJ8Vy0j9ERVmd6GES5EBNdkCeZmwaTduHnUbRbFMusp0EKF7yx50KGiMU0bzlM/zi9E
 AVCtiVrAr6/pFkQAXZmMOU7YMRnr43nju7FYNSFUGQ7QP6ahh0ka5CS5JKzCSxrwSVFR
 27cxAl2wfLWLJmXMsMr7tFXVJ0hKxvzLIdrwwuUIMd6RJV/UYfmU4JZLNzYsleQefIQG
 t4Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790756783; x=1791361583;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:list-unsubscribe:list-id:auto-submitted:cc
 :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LmnXGbt1NI5fVTwFuAyrIG56txZHMWiL1OEz0lnGqd4=;
 b=MPWVRbno1IzA1CTZhq4NgckE4du3urYlq2uNuk4puWAts/FjoUhdzkyciq2NGCkiWB
 rZL62Ir863MDpDpd7ooMm89cjjoE3GJrTr9xbDxwjDPA58j8pH65mfqLTwXOzB3rmPIP
 6LAIZN2rYNTc5hJ52mmuydGnYbRnryHboU1h+AVPKVg22jath/aLr9Y8v05CnBBd5YRG
 KvBfQco4/DkO+NYITlWbqhIsEeZKBOrrlefiywXN5aHe1XSxW12UFcNHSabfQY97Dtwf
 Q+Aa9OBDcL7qewaxDPP16uDDhVUj18jwWmfwwVg1Y8GWxKmgPxXyAhwjKUaKbJoi/ERb
 B4Sw==
X-Gm-Message-State: AFuF++m6Tken+2oL3WzvdcaiDpyjfxp3TkRztL4VdROD7kSDJdkvvTlK
 hhtjcDP0vNmGIb280cKgVWa7H0KJ/rdLTDb+iPFKEzQvyv8mSjLZMq0EQtzoObEoxNlB8oBf7cA
 CXELd2qp2UguwDBDL+vWmHOq1nu9BoRc6Bu26aAganp8HCeXvkM1zxg0LOLEAbpbN7gMD
X-Gm-Gg: AYBFou2dsnoMHK0uieZit9Ppwppex148N+ZJQi5dVatkCy5MLR/kWhZBGKALgiUoExH
 bpavVG1ly3cBdo2gDs3Rl2a4TnKIGwS9Dd2KmjX9cKLcGi6cQYn5cDGYcc0Jj+KMyTIi2tCUzC8
 AezQ4BjtgenLpTexDxWmy3dgrZWY1v3STKGXbqE/ApQqTQtrKwLLflLl3GvhdIMqhF4edu/VxRA
 WXmcf+/w0lrHr3YXD8GufQMM5mAWLyxK0fHCqEwSARsiJDTjCxm9INL6ekwcUuR/FVkt6nLC50L
 ifkzKfVeFWyfaxhSG9qo1n1ah55RGqaLw1aiB/qXWuACh5kE7BKBmqUbvdu0KPSEbNowTg3RC7Z
 lgSCvFD8HnKaBA8alGj/X13CAs9Jds6EO2qmViNetV/iVPf0T92CDvAZaCviq0/6/MqiZis26+H
 XlewYfKw7vNE9Ra4+F6060iU/iCyV8zpWAqSPN/zVSOfSA4s2eC6lXK1iBrvmM8BnWhmDg1ureI
 ZT0EMc38iU3yqcS3pMUNoZcnRqx80ap/BNShN5lh/vKmcHPs21kt/u2A3uhXYt59TOc2KTjl8Dv
 sA4ElSgbSiPdvxKA4OswqOljYSzKe7IyFIm8WiZQGo7p+Zr8U5UK9LYXHPpd
X-Received: by 2002:a05:600c:6815:b0:49f:cbf3:551c with SMTP id
 5b1f17b1804b1-4a01b004e5bmr9962045e9.12.1790756782115; 
 Wed, 30 Sep 2026 01:26:22 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a015aa016dsm31327465e9.1.2026.09.30.01.26.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 01:26:21 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 08:26:21 +0000
To: plaisthos <arne-openvpn@rfc2549.org>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newchange
X-Gerrit-PatchSet: 1
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 09ca456f4fe87a0c765407eecd86e2b0f944a300
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <8607127f261e26702cee31e3f1e3b5f69b0d9c1b-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xBpe1-0005pJ-7i
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add a shared TLV
 codec and use it for early negotiation
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
 openvpn-devel@lists.sourceforge.net
Cc: "stipa \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============0237712537702402697=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============0237712537702402697==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UFHRA7zgb0A="; charset=UTF-8

--UFHRA7zgb0A=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos=2E

Hello plaisthos,

I'd l=
ike you to do a code review=2E
Please visit

    http://gerrit=2Eopenvpn=2E=
net/c/openvpn/+/1965?usp=3Demail

to review the following change=2E


Chang=
e subject: Add a shared TLV codec and use it for early negotiation
=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add a shared TLV co=
dec and use it for early negotiation

Early negotiation in the reset packet=
s is a sequence of TLVs, and the
out-of-band and control data messages use =
the same TLV format and type
space=2E Add one TLV codec for all of them, co=
ntrol_msg=2Ec/h, and move
early negotiation onto it=2E

The codec only hand=
les the framing: reading and writing TLV headers,
writing a 16-bit TLV, and=
 walking a payload TLV by TLV with each value
checked against the payload=
=2E How to treat an unknown type is up to each
message=2E All TLV types are=
 defined in control_msg=2Eh;
TLV_TYPE_EARLY_NEG_FLAGS moves there from ssl_=
pkt=2Eh=2E

The bytes on the wire do not change=2E Since the top bit of the=
 type
field is the "optional" flag, a TLV of type 0x8001 is now read as the=

flags TLV marked optional rather than skipped as unknown, so one whose
len=
gth is not 2 now fails the handshake as malformed=2E

Change-Id: I89c3133e0=
09dc75dc2c10c607b3f0a24c04e8146
Signed-off-by: Lev Stipakov <lev@openvpn=2E=
net>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/contr=
ol_msg=2Ec
A src/openvpn/control_msg=2Eh
M src/openvpn/ssl=2Ec
M src/openvp=
n/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=
=2Eam
A tests/unit_tests/openvpn/test_control_msg=2Ec
M tests/unit_tests/op=
envpn/test_pkt=2Ec
10 files changed, 461 insertions(+), 23 deletions(-)



=
  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1965/=
1

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ee1a6=
079f 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -445,6 +445,8 =
@@
     src/openvpn/console=2Ec
     src/openvpn/console_builtin=2Ec
     s=
rc/openvpn/console=2Eh
+    src/openvpn/control_msg=2Ec
+    src/openvpn/co=
ntrol_msg=2Eh
     src/openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
     =
src/openvpn/crypto_backend=2Eh
@@ -883,6 +885,8 @@
 
     target_sources(te=
st_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_execve=2Ec
+   =
     tests/unit_tests/openvpn/test_control_msg=2Ec
+        src/openvpn/con=
trol_msg=2Ec
         src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
=
         src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Ea=
m b/src/openvpn/Makefile=2Eam
index 7fd12b4=2E=2Ea17ae8e 100644
--- a/src/o=
penvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -53,6 +53,7 @@
 	co=
mmon=2Eh \
 	comp=2Ec comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \=

+	control_msg=2Ec control_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=
=2Eh \
 	crypto_openssl=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls_legacy=2E=
c crypto_mbedtls_legacy=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/sr=
c/openvpn/control_msg=2Ec
new file mode 100644
index 0000000=2E=2Eca3aab9
-=
-- /dev/null
+++ b/src/openvpn/control_msg=2Ec
@@ -0,0 +1,83 @@
+/*
+ *  Op=
enVPN -- An application to securely tunnel IP networks
+ *             over=
 a single TCP/UDP port, with support for SSL/TLS-based
+ *             sess=
ion authentication and key exchange,
+ *             packet encryption, pac=
ket authentication, and
+ *             packet compression=2E
+ *
+ *  Copy=
right (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program=
 is free software; you can redistribute it and/or modify
+ *  it under the =
terms of the GNU General Public License version 2
+ *  as published by the =
Free Software Foundation=2E
+ *
+ *  This program is distributed in the hop=
e that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=
=2E  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  Y=
ou should have received a copy of the GNU General Public License along
+ * =
 with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */=

+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshea=
d=2Eh"
+
+#include "control_msg=2Eh"
+
+bool
+ctrl_msg_tlv_write_header(str=
uct buffer *buf, uint16_t type, bool optional, uint16_t value_len)
+{
+    =
uint16_t field =3D type & CTRL_MSG_TLV_TYPE_MASK;
+    if (optional)
+    {=

+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_wri=
te_u16(buf, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_t=
lv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t val=
ue)
+{
+    return ctrl_msg_tlv_write_header(buf, type, optional, sizeof(ui=
nt16_t))
+           && buf_write_u16(buf, value);
+}
+
+bool
+ctrl_msg_tlv=
_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    i=
nt field =3D buf_read_u16(buf);
+    if (field < 0)
+    {
+        return =
false;
+    }
+    int len =3D buf_read_u16(buf);
+    if (len < 0)
+    {
=
+        return false;
+    }
+    hdr->type =3D (uint16_t)(field & CTRL_MS=
G_TLV_TYPE_MASK);
+    hdr->optional =3D (field & CTRL_MSG_TLV_OPTIONAL_FLA=
G) !=3D 0;
+    hdr->value_len =3D (uint16_t)len;
+    return true;
+}
+
+b=
ool
+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr,=
 struct buffer *value)
+{
+    if (!ctrl_msg_tlv_read_header(buf, hdr))
+  =
  {
+        return false; /* fewer than 4 bytes left: truncated header */
=
+    }
+    /* Advance past the value; fails if buf is shorter than the hea=
der claims=2E */
+    uint8_t *v =3D buf_read_alloc(buf, hdr->value_len);
+=
    if (!v)
+    {
+        return false;
+    }
+    buf_set_read(value, v=
, hdr->value_len);
+    return true;
+}
diff --git a/src/openvpn/control_ms=
g=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
index 0000000=2E=
=2E73fd0a1
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,99 @@=

+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *     =
        over a single TCP/UDP port, with support for SSL/TLS-based
+ *     =
        session authentication and key exchange,
+ *             packet enc=
ryption, packet authentication, and
+ *             packet compression=2E
+=
 *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  =
This program is free software; you can redistribute it and/or modify
+ *  i=
t under the terms of the GNU General Public License version 2
+ *  as publi=
shed by the Free Software Foundation=2E
+ *
+ *  This program is distribute=
d in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; withou=
t even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTIC=
ULAR PURPOSE=2E  See the
+ *  GNU General Public License for more details=
=2E
+ *
+ *  You should have received a copy of the GNU General Public Lice=
nse along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/lice=
nses/>=2E
+ */
+
+/**
+ * @file
+ * TLV framing shared by the TLV-based con=
trol messages of the wire protocol=2E
+ *
+ * Such a message payload is a s=
equence of TLV entries=2E Each TLV starts with a
+ * 4-byte header: a 16-bi=
t field whose most significant bit is the "optional"
+ * flag and whose rem=
aining 15 bits are the type, followed by a 16-bit length
+ * giving the siz=
e of the value that follows the header=2E
+ *
+ * All of these messages sha=
re one TLV type space, so the TLV types are all
+ * defined here=2E Only th=
e framing is handled here: what a message does with a
+ * TLV type it does =
not know, marked optional or not, is up to its parser=2E
+ */
+
+#ifndef CO=
NTROL_MSG_H
+#define CONTROL_MSG_H
+
+#include "buffer=2Eh"
+
+/* TLV types=
 */
+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the r=
eset packets */
+
+/* TLV header bit layout of the first 16-bit field */
+#=
define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV_TYPE_MASK   =
  0x7fff
+
+/* The header every TLV carries: the 15-bit type and optional f=
lag packed into
+ * the first 16-bit field, then the length of the value th=
at follows=2E */
+struct ctrl_msg_tlv_header
+{
+    uint16_t type;      /*=
*< the 15-bit TLV type */
+    bool optional;      /**< value of the option=
al flag */
+    uint16_t value_len; /**< length of the value following the =
header */
+};
+
+/**
+ * Write a TLV header (type + optional flag + value l=
ength) to buf=2E
+ *
+ * @return true on success, false if buf has insuffic=
ient space=2E
+ */
+bool ctrl_msg_tlv_write_header(struct buffer *buf, uint=
16_t type, bool optional,
+                               uint16_t value_le=
n);
+
+/**
+ * Write a complete TLV whose value is a single 16-bit integer =
to buf=2E
+ *
+ * @return true on success, false if buf has insufficient sp=
ace=2E
+ */
+bool ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type,=
 bool optional, uint16_t value);
+
+/**
+ * Read a TLV header from buf, adv=
ancing past it=2E
+ *
+ * @param buf  buffer positioned at the TLV header
+=
 * @param hdr  filled with the type, optional flag and value length on succ=
ess
+ * @return true on success, false if there are not enough bytes for a =
header=2E
+ */
+bool ctrl_msg_tlv_read_header(struct buffer *buf, struct ct=
rl_msg_tlv_header *hdr);
+
+/**
+ * Read the next TLV from buf, advancing p=
ast its header and value=2E Call it
+ * while BLEN(buf) > 0 to walk a whole=
 payload=2E
+ *
+ * The length from the header is validated against buf, so=
 on success the
+ * whole value is present: a header claiming more bytes th=
an buf holds is
+ * rejected=2E
+ *
+ * @param buf    buffer positioned at =
a TLV header
+ * @param hdr    filled with the TLV's type, optional flag an=
d value length
+ * @param value  set to a buffer covering exactly the TLV's=
 value; it points
+ *               into buf and owns no storage
+ * @retur=
n true on success, false if the header or the value is truncated; buf
+ *  =
       may then be left partly consumed=2E
+ */
+bool ctrl_msg_tlv_next(str=
uct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);
+
=
+#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec
index 76150d4=2E=2E92f1991 100644
--- a/src/openvpn/ssl=2Ec
=
+++ b/src/openvpn/ssl=2Ec
@@ -52,6 +52,7 @@
 #include "pkcs11=2Eh"
 #includ=
e "route=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_msg=2Eh"
 
 #inc=
lude "crypto_epoch=2Eh"
 #include "ssl=2Eh"
@@ -2595,26 +2596,21 @@
 {
    =
 while (buf->len > 0)
     {
-        if (buf_len(buf) < 4)
-        {
-   =
         goto error;
-        }
-        /* read type */
-        int type =
=3D buf_read_u16(buf);
-        int len =3D buf_read_u16(buf);
-        if =
(type < 0 || len < 0 || buf_len(buf) < len)
+        struct ctrl_msg_tlv_he=
ader hdr;
+        struct buffer value;
+        if (!ctrl_msg_tlv_next(buf=
, &hdr, &value))
         {
             goto error;
         }
 
-        =
switch (type)
+        switch (hdr=2Etype)
         {
             case TLV=
_TYPE_EARLY_NEG_FLAGS:
-                if (len !=3D sizeof(uint16_t))
+   =
             if (BLEN(&value) !=3D sizeof(uint16_t))
                 {
   =
                  goto error;
                 }
-                int flags=
 =3D buf_read_u16(buf);
+                int flags =3D buf_read_u16(&value)=
;
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
               =
  {
@@ -2623,8 +2619,8 @@
                 break;
 
             default:
-=
                /* Skip types we do not parse */
-                buf_advan=
ce(buf, len);
+                /* Skip types we do not parse, marked option=
al or not */
+                break;
         }
     }
     reliable_mark_d=
eleted(ks->rec_reliable, buf);
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/o=
penvpn/ssl_pkt=2Ec
index 90b2aec=2E=2E405e5b4 100644
--- a/src/openvpn/ssl_=
pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -33,6 +33,7 @@
 #include "reliable=
=2Eh"
 #include "siphash=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_=
msg=2Eh"
 
 /*
  * Dependent on hmac size, opcode size, and session_id size=
=2E
@@ -431,9 +432,8 @@
     /* Add indication for tls-crypt-v2 to resend t=
he WKc with the reply */
     if (request_resend_wkc)
     {
-        buf_w=
rite_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */
-        buf_wr=
ite_u16(&buf, sizeof(uint16_t));
-        buf_write_u16(&buf, EARLY_NEG_FLA=
G_RESEND_WKC);
+        ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_=
NEG_FLAGS, false,
+                                      EARLY_NEG_FLAG_RES=
END_WKC));
     }
 
     /* Add tls-auth/tls-crypt wrapping, this might rep=
lace buf with
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2E=
h
index 03e8930=2E=2E5a1d194 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src=
/openvpn/ssl_pkt=2Eh
@@ -305,10 +305,8 @@
 #define EARLY_NEG_START 0x0f0000=
00
 
 
-/* Early negotiation that part of the server response in the RESET_=
V2 packet=2E
- * Since clients that announce early negotiation support will=
 treat the payload
- * of reset packets special and parse it as TLV message=
s=2E
- * as TLV (type, length, value) */
-#define TLV_TYPE_EARLY_NEG_FLAGS =
 0x0001
+/* Early negotiation: clients that announce support for it parse t=
he payload of
+ * the reset packets as TLVs (see control_msg=2Eh)=2E Flags =
carried in the value of
+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #define E=
ARLY_NEG_FLAG_RESEND_WKC 0x0001
 #endif /* ifndef SSL_PKT_H */
diff --git a=
/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam
index 5954902=2E=2Ed9caa03 100644
--- a/tests/unit_tests/openvpn/Make=
file=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -157,10 +157,12 @=
@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/=
openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_t=
estdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_exe=
cve=2Ec test_common=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec test_con=
trol_msg=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
+	test_commo=
n=2Eh \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/=
base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/o=
penvpn/control_msg=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_s=
rcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mb=
edtls=2Ec \
diff --git a/tests/unit_tests/openvpn/test_control_msg=2Ec b/te=
sts/unit_tests/openvpn/test_control_msg=2Ec
new file mode 100644
index 0000=
000=2E=2E40794ab
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_control_=
msg=2Ec
@@ -0,0 +1,209 @@
+/*
+ *  OpenVPN -- An application to securely tu=
nnel IP networks
+ *             over a single TCP/UDP port, with support f=
or SSL/TLS-based
+ *             session authentication and key exchange,
+=
 *             packet encryption, packet authentication, and
+ *           =
  packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales=
@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistribut=
e it and/or modify
+ *  it under the terms of the GNU General Public Licens=
e version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  T=
his program is distributed in the hope that it will be useful,
+ *  but WIT=
HOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILIT=
Y or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public L=
icense for more details=2E
+ *
+ *  You should have received a copy of the =
GNU General Public License along
+ *  with this program; if not, see <https=
://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "co=
nfig=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#incl=
ude <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include =
"control_msg=2Eh"
+#include "ssl_pkt=2Eh"
+#include "test_common=2Eh"
+
+/*=
 The early negotiation flags TLV of a reset packet asking a tls-crypt-v2
+ =
* client to resend its WKc, as older versions wrote it by hand=2E */
+stati=
c void
+test_tlv_write_u16_wire_format(void **state)
+{
+    struct gc_aren=
a gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+
+   =
 assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
=
+                                       EARLY_NEG_FLAG_RESEND_WKC));
+    c=
onst uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    as=
sert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR=
(&buf), expected, sizeof(expected));
+
+    /* the optional flag is the mos=
t significant bit of the type field */
+    buf_clear(&buf);
+    assert_tr=
ue(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));
+    a=
ssert_int_equal(BPTR(&buf)[0], 0x80);
+    assert_int_equal(BPTR(&buf)[1], =
0x01);
+
+    gc_free(&gc);
+}
+
+/* A TLV header survives the round trip, =
the optional flag kept apart from
+ * the 15-bit type=2E */
+static void
+t=
est_tlv_header_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_ne=
w();
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(c=
trl_msg_tlv_write_header(&buf, 0x1234, true, 5));
+    assert_int_equal(BLE=
N(&buf), 4);
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_m=
sg_tlv_read_header(&buf, &hdr));
+    assert_int_equal(hdr=2Etype, 0x1234);=

+    assert_true(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, 5=
);
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* Walk=
ing a payload returns each TLV in turn, with a value covering exactly
+ * i=
ts bytes, and consumes the payload=2E */
+static void
+test_tlv_next_walks_=
payload(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct =
buffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write=
_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));
+    assert_true(ctrl=
_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u3=
2(&buf, 0x11223344));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x5,=
 false, 0)); /* empty value */
+
+    struct ctrl_msg_tlv_header hdr;
+    =
struct buffer value;
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &valu=
e));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
+    asse=
rt_false(hdr=2Eoptional);
+    assert_int_equal(BLEN(&value), 2);
+    asse=
rt_int_equal(buf_read_u16(&value), 0xabcd);
+
+    assert_true(ctrl_msg_tlv=
_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, 0x7ff);
+    =
assert_true(hdr=2Eoptional);
+    assert_int_equal(BLEN(&value), 4);
+
+   =
 assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(=
hdr=2Etype, 0x5);
+    assert_int_equal(BLEN(&value), 0);
+
+    assert_int=
_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming =
more value bytes than the payload holds is rejected,
+ * rather than read p=
ast the end of the payload=2E */
+static void
+test_tlv_next_value_truncate=
d(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer=
 buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write_heade=
r(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));
+    assert_true(buf_write_u3=
2(&buf, 0));
+
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer valu=
e;
+    assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value));
+
+    gc_free=
(&gc);
+}
+
+/* Reading a TLV header must fail when the buffer holds less d=
ata than a
+ * complete 4-byte header, rather than read past the available =
data=2E */
+static void
+test_tlv_header_truncated(void **state)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+    const uint8_t bytes[] =3D { 0x00, 0x01,=
 0x00 };
+
+    /* 0 to 3 bytes: none, part of the type field, the type fie=
ld, and the type
+     * field with half of the length */
+    for (size_t =
n =3D 0; n <=3D sizeof(bytes); n++)
+    {
+        struct buffer buf =3D a=
lloc_buf_gc(16, &gc);
+        assert_true(buf_write(&buf, bytes, n));
+   =
     struct buffer copy =3D buf;
+
+        struct ctrl_msg_tlv_header hdr;=

+        struct buffer value;
+        assert_false(ctrl_msg_tlv_read_head=
er(&buf, &hdr));
+        assert_false(ctrl_msg_tlv_next(&copy, &hdr, &valu=
e));
+    }
+
+    gc_free(&gc);
+}
+
+/* Writing fails, rather than writes=
 a partial TLV, when buf is too small=2E */
+static void
+test_tlv_write_no=
_room(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+
+    struct =
buffer buf =3D alloc_buf_gc(3, &gc);
+    assert_false(ctrl_msg_tlv_write_h=
eader(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));
+
+    /* room for the he=
ader but not the value */
+    buf =3D alloc_buf_gc(5, &gc);
+    assert_fa=
lse(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));
+
+ =
   gc_free(&gc);
+}
+
+/* A type does not spill into the optional flag: onl=
y its 15 bits are written=2E */
+static void
+test_tlv_write_masks_type(voi=
d **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&bu=
f, 0x8123, false, 0));
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_t=
rue(ctrl_msg_tlv_read_header(&buf, &hdr));
+    assert_int_equal(hdr=2Etype=
, 0x0123);
+    assert_false(hdr=2Eoptional);
+
+    gc_free(&gc);
+}
+
+/*=
 The TLV codec tests run as a group of pkt_testdriver; see test_pkt=2Ec=2E =
*/
+int
+run_control_msg_tests(void)
+{
+    const struct CMUnitTest tests[=
] =3D {
+        cmocka_unit_test(test_tlv_write_u16_wire_format),
+       =
 cmocka_unit_test(test_tlv_header_roundtrip),
+        cmocka_unit_test(tes=
t_tlv_next_walks_payload),
+        cmocka_unit_test(test_tlv_next_value_tr=
uncated),
+        cmocka_unit_test(test_tlv_header_truncated),
+        cm=
ocka_unit_test(test_tlv_write_no_room),
+        cmocka_unit_test(test_tlv_=
write_masks_type),
+    };
+
+    return cmocka_run_group_tests_name("contr=
ol message TLV tests", tests, NULL, NULL);
+}
diff --git a/tests/unit_tests=
/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index a732c2b=
=2E=2E9ce9c50 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/test=
s/unit_tests/openvpn/test_pkt=2Ec
@@ -37,6 +37,7 @@
 #include "crypto=2Eh"
=
 #include "options=2Eh"
 #include "ssl_backend=2Eh"
+#include "control_msg=
=2Eh"
 #include "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
@@ -44,6 +45,8 @@=

 #include "reliable=2Eh"
 #include "siphash=2Eh"
 
+int run_control_msg_te=
sts(void); /* test_control_msg=2Ec */
+
 int
 parse_line(const char *line, =
char **p, const int n, const char *file, const int line_num,
            ms=
glvl_t msglevel, struct gc_arena *gc)
@@ -654,6 +657,46 @@
     free_buf(&t=
as=2Eworkbuf);
 }
 
+/* A reset reply asking a tls-crypt-v2 client to resen=
d its WKc ends in the
+ * early negotiation flags TLV, the bytes older vers=
ions wrote by hand, and the
+ * TLV parses back=2E */
+static void
+test_ge=
nerate_reset_packet_resend_wkc(void **ut_state)
+{
+    struct tls_auth_sta=
ndalone tas =3D { 0 };
+
+    struct session_id client_id =3D { { 0, 1, 2, =
3, 4, 5, 6, 7 } };
+    struct session_id server_id =3D { { 8, 9, 0, 9, 8, =
7, 6, 2 } };
+
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    struct fr=
ame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 =
}, 0 };
+    tas=2Eframe =3D frame;
+    tas=2Eworkbuf =3D alloc_buf(1600);=

+
+    uint8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_=
SHIFT);
+
+    struct buffer plain =3D
+        tls_reset_standalone(&tas=
=2Etls_wrap, &tas, &client_id, &server_id, header, false);
+    const int p=
lain_len =3D BLEN(&plain);
+    struct buffer buf =3D
+        tls_reset_st=
andalone(&tas=2Etls_wrap, &tas, &client_id, &server_id, header, true);
+
+ =
   const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    ass=
ert_int_equal(BLEN(&buf), plain_len + (int)sizeof(tlv));
+    assert_memory=
_equal(BPTR(&buf) + plain_len, tlv, sizeof(tlv));
+
+    struct buffer payl=
oad =3D buf;
+    assert_true(buf_advance(&payload, plain_len));
+    struc=
t ctrl_msg_tlv_header hdr;
+    struct buffer value;
+    assert_true(ctrl_=
msg_tlv_next(&payload, &hdr, &value));
+    assert_int_equal(hdr=2Etype, TL=
V_TYPE_EARLY_NEG_FLAGS);
+    assert_int_equal(buf_read_u16(&value), EARLY_=
NEG_FLAG_RESEND_WKC);
+    assert_int_equal(BLEN(&payload), 0);
+
+    free=
_buf(&tas=2Eworkbuf);
+}
+
 static void
 test_generate_reset_packet_tls_aut=
h(void **ut_state)
 {
@@ -744,9 +787,12 @@
         cmocka_unit_test(test_v=
erify_hmac_tls_auth),
         cmocka_unit_test(test_verify_hmac_none_out_o=
f_range_ack),
         cmocka_unit_test(test_generate_reset_packet_plain),
=
+        cmocka_unit_test(test_generate_reset_packet_resend_wkc),
         =
cmocka_unit_test(test_generate_reset_packet_tls_auth),
         cmocka_unit=
_test(test_extract_control_message)
     };
 
-    return cmocka_run_group_=
tests_name("pkt tests", tests, NULL, NULL);
+    int failed =3D cmocka_run_=
group_tests_name("pkt tests", tests, NULL, NULL);
+    failed +=3D run_cont=
rol_msg_tests();
+    return failed ? 1 : 0;
 }

-- 
To view, visit http://=
gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for =
help writing mail filters, visit http://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Bran=
ch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerr=
it-Change-Number: 1965
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@gm=
ail=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
Gerrit-C=
C: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention=
: plaisthos <arne-openvpn@rfc2549=2Eorg>

--UFHRA7zgb0A=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos=2E </p>
<p>stipa would like plaisthos to <s=
trong>review</strong> this change=2E
</p><p><a href=3D"http://gerrit=2Eopen=
vpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Change</a></p><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">Ad=
d a shared TLV codec and use it for early negotiation<br><br>Early negotiat=
ion in the reset packets is a sequence of TLVs, and the<br>out-of-band and =
control data messages use the same TLV format and type<br>space=2E Add one =
TLV codec for all of them, control_msg=2Ec/h, and move<br>early negotiation=
 onto it=2E<br><br>The codec only handles the framing: reading and writing =
TLV headers,<br>writing a 16-bit TLV, and walking a payload TLV by TLV with=
 each value<br>checked against the payload=2E How to treat an unknown type =
is up to each<br>message=2E All TLV types are defined in control_msg=2Eh;<b=
r>TLV_TYPE_EARLY_NEG_FLAGS moves there from ssl_pkt=2Eh=2E<br><br>The bytes=
 on the wire do not change=2E Since the top bit of the type<br>field is the=
 &quot;optional&quot; flag, a TLV of type 0x8001 is now read as the<br>flag=
s TLV marked optional rather than skipped as unknown, so one whose<br>lengt=
h is not 2 now fails the handshake as malformed=2E<br><br>Change-Id: I89c31=
33e009dc75dc2c10c607b3f0a24c04e8146<br>Signed-off-by: Lev Stipakov &lt;lev@=
openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2E=
am<br>A src/openvpn/control_msg=2Ec<br>A src/openvpn/control_msg=2Eh<br>M s=
rc/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2E=
h<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn=
/test_control_msg=2Ec<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>10 file=
s changed, 461 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"bl=
ocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1965/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>inde=
x 6eb5954=2E=2Ee1a6079f 100644</span><br><span>--- a/CMakeLists=2Etxt</span=
><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -445,6 +445,8 @@</span=
><br><span>     src/openvpn/console=2Ec</span><br><span>     src/openvpn/co=
nsole_builtin=2Ec</span><br><span>     src/openvpn/console=2Eh</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/cont=
rol_msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span><br><span>   =
  src/openvpn/crypto=2Eh</span><br><span>     src/openvpn/crypto_backend=2E=
h</span><br><span>@@ -883,6 +885,8 @@</span><br><span> </span><br><span>   =
  target_sources(test_pkt PRIVATE</span><br><span>         tests/unit_tests=
/openvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        tests/unit_tests/openvpn/test_control_msg=2Ec</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/control_ms=
g=2Ec</span><br><span>         src/openvpn/argv=2Ec</span><br><span>       =
  src/openvpn/base64=2Ec</span><br><span>         src/openvpn/crypto_epoch=
=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/M=
akefile=2Eam</span><br><span>index 7fd12b4=2E=2Ea17ae8e 100644</span><br><s=
pan>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makef=
ile=2Eam</span><br><span>@@ -53,6 +53,7 @@</span><br><span> 	common=2Eh \</=
span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	comp-lz=
4=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	control_msg=2Ec control_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh=
 crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec crypto_openssl=
=2Eh \</span><br><span> 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_legacy=2E=
h \</span><br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/=
control_msg=2Ec</span><br><span>new file mode 100644</span><br><span>index =
0000000=2E=2Eca3aab9</span><br><span>--- /dev/null</span><br><span>+++ b/sr=
c/openvpn/control_msg=2Ec</span><br><span>@@ -0,0 +1,83 @@</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP n=
etworks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   over a single TCP/UDP port, with support for SSL/TLS-based</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             session authentica=
tion and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             packet encryption, packet authentication, and</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compressi=
on=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 Ope=
nVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  This program is free software; you can redistribute it and/or modify</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms=
 of the GNU General Public License version 2</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed i=
n the hope that it will be useful,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTA=
BILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have receiv=
ed a copy of the GNU General Public License along</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https:=
//www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;conf=
ig=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, b=
ool optional, uint16_t value_len)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
uint16_t field =3D type &amp; CTRL_MSG_TLV_TYPE_MASK;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (optional)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(buf, field) &amp=
;&amp; buf_write_u16(buf, value_len);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write_u16(struct buff=
er *buf, uint16_t type, bool optional, uint16_t value)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, type, optional, =
sizeof(uint16_t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         &amp;&amp; buf_write_u16(buf, value);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_read_header(=
struct buffer *buf, struct ctrl_msg_tlv_header *hdr)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    int field =3D buf_read_u16(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (field &lt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int len =3D buf_read_u16(buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   hdr-&gt;type =3D (uint16_t)(field &amp; CTRL_MSG_TLV_TYPE_MASK);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;optional =3D (f=
ield &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint16_t)len;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_ms=
g_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buff=
er *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ctrl_msg_tlv_read_=
header(buf, hdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse; /* fewer than 4 bytes left: truncated header */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* Advance past the value; fails if buf is shorter =
than the header claims=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint8_t *v =3D buf_read_alloc(buf, hdr-&gt;value_len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!v)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    buf_set_read(value, v, hdr-&gt;value_len);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/op=
envpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2E73fd0a1</span><br><span>--=
- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Eh</span><br><sp=
an>@@ -0,0 +1,99 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An=
 application to securely tunnel IP networks</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with sup=
port for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *             session authentication and key exchange,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, pa=
cket authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet compression=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you =
can redistribute it and/or modify</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  it under the terms of the GNU General Public License vers=
ion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publish=
ed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  This program is distributed in the hope that it will be useful,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRAN=
TY; without even the implied warranty of</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GN=
U General Public License for more details=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  You should have received a copy of the GNU General Public Licen=
se along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with th=
is program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV frami=
ng shared by the TLV-based control messages of the wire protocol=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * Such a message payload is a sequence of T=
LV entries=2E Each TLV starts with a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * 4-byte header: a 16-bit field whose most significant bi=
t is the &quot;optional&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * flag and whose remaining 15 bits are the type, followed by a 1=
6-bit length</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * givi=
ng the size of the value that follows the header=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * All of these messages share one TLV type space, so the =
TLV types are all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 defined here=2E Only the framing is handled here: what a message does with=
 a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV type it do=
es not know, marked optional or not, is up to its parser=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV types */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_EARL=
Y_NEG_FLAGS 0x0001 /* early negotiation, in the reset packets */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* TLV header bit layout of the first 16-bit fiel=
d */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MS=
G_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* The header every TLV carries: the 15-bit type and optional fla=
g packed into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the=
 first 16-bit field, then the length of the value that follows=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_header=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;      /**&lt; the 1=
5-bit TLV type */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool optional;      /**&lt; value of the optional flag */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len; /**&lt; len=
gth of the value following the header */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV header (type + o=
ptional flag + value length) to buf=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return true on success, false if buf has insufficient space=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_header(struct buf=
fer *buf, uint16_t type, bool optional,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                               uint16_t value_len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Write a complete TLV whose value is a single 16-bit in=
teger to buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on su=
ccess, false if buf has insufficient space=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bo=
ol optional, uint16_t value);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV header from=
 buf, advancing past it=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
buf  buffer positioned at the TLV header</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param hdr  filled with the type, optional flag and=
 value length on success</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return true on success, false if there are not enough bytes for a =
header=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_hea=
der(struct buffer *buf, struct ctrl_msg_tlv_header *hdr);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Read the next TLV from buf, advancing past its header and value=2E Ca=
ll it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * while BLEN(=
buf) &gt; 0 to walk a whole payload=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * The length from the header is validated against buf, so on success the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whole value is p=
resent: a header claiming more bytes than buf holds is</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * rejected=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param buf    buffer positioned at a TLV header</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @param hdr    filled with th=
e TLV&#39;s type, optional flag and value length</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param value  set to a buffer covering exac=
tly the TLV&#39;s value; it points</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *               into buf and owns no storage</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false =
if the header or the value is truncated; buf</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *         may then be left partly consumed=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_next(struct buffer *b=
uf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* ifndef CONTROL_MSG_H */</span><br><span>diff=
 --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 76=
150d4=2E=2E92f1991 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><=
br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -52,6 +52,7 @@</span>=
<br><span> #include &quot;pkcs11=2Eh&quot;</span><br><span> #include &quot;=
route=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=
=2Eh&quot;</span><br><span> </span><br><span> #include &quot;crypto_epoch=
=2Eh&quot;</span><br><span> #include &quot;ssl=2Eh&quot;</span><br><span>@@=
 -2595,26 +2596,21 @@</span><br><span> {</span><br><span>     while (buf-&g=
t;len &gt; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        if (buf_len(buf) &lt; 4)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            goto error;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        /* read type */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        int type =3D buf_read_u16(buf);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        int len =3D buf_read_u16(buf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (type &lt; 0 || len &lt=
; 0 || buf_len(buf) &lt; len)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_next(buf, =
&amp;hdr, &amp;value))</span><br><span>         {</span><br><span>         =
    goto error;</span><br><span>         }</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        switch (type)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        switch (hdr=2Etype)</span>=
<br><span>         {</span><br><span>             case TLV_TYPE_EARLY_NEG_F=
LAGS:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
if (len !=3D sizeof(uint16_t))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                if (BLEN(&amp;value) !=3D sizeof(uint16_t))</spa=
n><br><span>                 {</span><br><span>                     goto er=
ror;</span><br><span>                 }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                int flags =3D buf_read_u16(buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                int flags =
=3D buf_read_u16(&amp;value);</span><br><span> </span><br><span>           =
      if (flags &amp; EARLY_NEG_FLAG_RESEND_WKC)</span><br><span>          =
       {</span><br><span>@@ -2623,8 +2619,8 @@</span><br><span>            =
     break;</span><br><span> </span><br><span>             default:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                /* Skip types=
 we do not parse */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              buf_advance(buf, len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                /* Skip types we do not parse, marked opti=
onal or not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           break;</span><br><span>         }</span><br><span>     }</span><=
br><span>     reliable_mark_deleted(ks-&gt;rec_reliable, buf);</span><br><s=
pan>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><b=
r><span>index 90b2aec=2E=2E405e5b4 100644</span><br><span>--- a/src/openvpn=
/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>=
@@ -33,6 +33,7 @@</span><br><span> #include &quot;reliable=2Eh&quot;</span>=
<br><span> #include &quot;siphash=2Eh&quot;</span><br><span> #include &quot=
;tls_crypt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;control_msg=2Eh&quot;</span><br><span> </span><br><span> /*=
</span><br><span>  * Dependent on hmac size, opcode size, and session_id si=
ze=2E</span><br><span>@@ -431,9 +432,8 @@</span><br><span>     /* Add indic=
ation for tls-crypt-v2 to resend the WKc with the reply */</span><br><span>=
     if (request_resend_wkc)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, TLV_TYPE_EA=
RLY_NEG_FLAGS); /* TYPE: flags */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        buf_write_u16(&amp;buf, sizeof(uint16_t));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, EA=
RLY_NEG_FLAG_RESEND_WKC);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ASSERT(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FL=
AGS, false,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                              EARLY_NEG_FLAG_RESEND_WKC));</span><br><span>=
     }</span><br><span> </span><br><span>     /* Add tls-auth/tls-crypt wra=
pping, this might replace buf with</span><br><span>diff --git a/src/openvpn=
/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 03e8930=2E=2E5=
a1d194 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span=
>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -305,10 +305,8 @@</span><=
br><span> #define EARLY_NEG_START 0x0f000000</span><br><span> </span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Early negotia=
tion that part of the server response in the RESET_V2 packet=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * Since clients that announce ea=
rly negotiation support will treat the payload</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * of reset packets special and parse it as TLV me=
ssages=2E</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * as TLV (t=
ype, length, value) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Early negotiation: clients that announce support f=
or it parse the payload of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * the reset packets as TLVs (see control_msg=2Eh)=2E Flags carried =
in the value of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * t=
he TLV_TYPE_EARLY_NEG_FLAGS TLV: */</span><br><span> #define EARLY_NEG_FLAG=
_RESEND_WKC 0x0001</span><br><span> #endif /* ifndef SSL_PKT_H */</span><br=
><span>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tes=
ts/openvpn/Makefile=2Eam</span><br><span>index 5954902=2E=2Ed9caa03 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><spa=
n>+++ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -157,10 +=
157,12 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/com=
pat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br=
><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_ms=
g=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=2Eh \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+pkt_testdriver_SOURCES =3D test_pkt=
=2Ec test_control_msg=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_common=2Eh \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(=
top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/op=
envpn/buffer=2Ec \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypt=
o_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2E=
c \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_control_msg=
=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><span>new fi=
le mode 100644</span><br><span>index 0000000=2E=2E40794ab</span><br><span>-=
-- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_control_ms=
g=2Ec</span><br><span>@@ -0,0 +1,209 @@</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TC=
P/UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             session authentication and key exchan=
ge,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             p=
acket encryption, packet authentication, and</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@=
openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is=
 free software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is distributed in the hope that it wi=
ll be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  bu=
t WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR=
 A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  GNU General Public License for more details=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/lic=
enses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_co=
mmon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The early negotiation=
 flags TLV of a reset packet asking a tls-crypt-v2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * client to resend its WKc, as older versio=
ns wrote it by hand=2E */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_tlv_write_u16_wire_format(void **state)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(=
&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                       EARLY_NEG_FLA=
G_RESEND_WKC));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
const uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(=
&amp;buf), sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expected=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* the optional flag is the mos=
t significant bit of the type field */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_clear(&amp;buf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TL=
V_TYPE_EARLY_NEG_FLAGS, true, 0));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[0], 0x80);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;bu=
f)[1], 0x01);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* A TLV header survives the round trip, the optional flag k=
ept apart from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * th=
e 15-bit type=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv=
_header_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf=
, 0x1234, true, 5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(BLEN(&amp;buf), 4);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;buf, &amp;=
hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(hdr=2Etype, 0x1234);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(hdr=2Eoptional);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, 5);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;=
buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Walking a payload returns each TLV in turn, with a value cove=
ring exactly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its =
bytes, and consumes the payload=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_tlv_next_walks_payload(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(64=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_w=
rite_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_=
msg_tlv_write_header(&amp;buf, 0x5, false, 0)); /* empty value */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &a=
mp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(BLEN(&amp;value), 2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(buf_read_u16(&amp;value), 0xabcd);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, =
&amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(hdr=2Etype, 0x7ff);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(hdr=2Eoptional);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 4);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;bu=
f, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(hdr=2Etype, 0x5);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* A TLV header claiming more value bytes than the payload holds is rejected=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rather than rea=
d past the end of the payload=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_tlv_next_value_truncated(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(64=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&a=
mp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_he=
ader hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Reading=
 a TLV header must fail when the buffer holds less data than a</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * complete 4-byte header, rathe=
r than read past the available data=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+test_tlv_header_truncated(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint8_t bytes[] =3D { 0x00, 0x0=
1, 0x00 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 to 3 bytes: none, p=
art of the type field, the type field, and the type</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * field with half of the length */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t n =3D=
 0; n &lt;=3D sizeof(bytes); n++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        assert_true(buf_write(&amp;buf=
, bytes, n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  struct buffer copy =3D buf;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        struct buffer value;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        assert_false(ctrl_msg_tlv_read_header(&amp;buf,=
 &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 assert_false(ctrl_msg_tlv_next(&amp;copy, &amp;hdr, &amp;value));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Writing fails, ra=
ther than writes a partial TLV, when buf is too small=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_no_room(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(3,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_false(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false=
, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* room for the header but n=
ot the value */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EA=
RLY_NEG_FLAGS, false, 1));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(=
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* A type does not spill into the optional flag=
: only its 15 bits are written=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_tlv_write_masks_type(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_writ=
e_header(&amp;buf, 0x8123, false, 0));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(hdr=2Etype, 0x0123);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_false(hdr=2Eoptional);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* The TLV codec tests run as a gr=
oup of pkt_testdriver; see test_pkt=2Ec=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+run_control_msg_tests(void)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const struct CMUnitTest tests[] =3D {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_write_u16_wire_form=
at),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_tlv_header_roundtrip),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_tlv_next_walks_payload),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_te=
st(test_tlv_next_value_truncated),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        cmocka_unit_test(test_tlv_header_truncated),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_tlv_write_no_room),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_tlv_write_masks_type),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return cmocka_run_group_tests_name(&quot;control message TLV tests&=
quot;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec=
 b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index a732c2b=2E=
=2E9ce9c50 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=
=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br>=
<span>@@ -37,6 +37,7 @@</span><br><span> #include &quot;crypto=2Eh&quot;</s=
pan><br><span> #include &quot;options=2Eh&quot;</span><br><span> #include &=
quot;ssl_backend=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;control_msg=2Eh&quot;</span><br><span> #include &quot=
;ssl_pkt=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</spa=
n><br><span> </span><br><span>@@ -44,6 +45,8 @@</span><br><span> #include &=
quot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+int=
 run_control_msg_tests(void); /* test_control_msg=2Ec */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span>=
 parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,</span><br><span>            msglvl_t msglevel, struct gc_ar=
ena *gc)</span><br><span>@@ -654,6 +657,46 @@</span><br><span>     free_buf=
(&amp;tas=2Eworkbuf);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/* A reset reply asking a tls-crypt-=
v2 client to resend its WKc ends in the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * early negotiation flags TLV, the bytes older version=
s wrote by hand, and the</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * TLV parses back=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_generate_reset_packet_resend_wkc(void **ut_state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct tls_auth_standalone tas =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct session_id client_id =3D { { 0, 1, 2, =
3, 4, 5, 6, 7 } };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct frame frame=
 =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D f=
rame;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Ework=
buf =3D alloc_buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t he=
ader =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 &lt;&lt; P_OPCODE_SHIFT);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer plain =3D</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        tls_reset_standalone(&amp=
;tas=2Etls_wrap, &amp;tas, &amp;client_id, &amp;server_id, header, false);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int plain_=
len =3D BLEN(&amp;plain);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer buf =3D</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &am=
p;client_id, &amp;server_id, header, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(B=
LEN(&amp;buf), plain_len + (int)sizeof(tlv));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf) + plain_le=
n, tlv, sizeof(tlv));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer=
 payload =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(buf_advance(&amp;payload, plain_len));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl=
_msg_tlv_next(&amp;payload, &amp;hdr, &amp;value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE=
_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(buf_read_u16(&amp;value), EARLY_NEG_FLAG_RESEND_WKC);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
BLEN(&amp;payload), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&a=
mp;tas=2Eworkbuf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic void</span><br><span> test_generate_reset_packet_tls_auth(void **ut_s=
tate)</span><br><span> {</span><br><span>@@ -744,9 +787,12 @@</span><br><sp=
an>         cmocka_unit_test(test_verify_hmac_tls_auth),</span><br><span>  =
       cmocka_unit_test(test_verify_hmac_none_out_of_range_ack),</span><br>=
<span>         cmocka_unit_test(test_generate_reset_packet_plain),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_generate_reset_packet_resend_wkc),</span><br><span>         cmocka_unit_t=
est(test_generate_reset_packet_tls_auth),</span><br><span>         cmocka_u=
nit_test(test_extract_control_message)</span><br><span>     };</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cmock=
a_run_group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int failed =3D cmocka_run=
_group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    failed +=3D run_control_msg_te=
sts();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return fa=
iled ? 1 : 0;</span><br><span> }</span><br></pre><p>To view, visit <a href=
=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965=
</a>=2E To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div=
 itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div styl=
e=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"disp=
lay:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerr=
it-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89=
c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display:none"> =
Gerrit-Change-Number: 1965 </div>
<div style=3D"display:none"> Gerrit-Patch=
Set: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipako=
v@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plai=
sthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"=
> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; =
</div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-op=
envpn@rfc2549=2Eorg&gt; </div>

</body></html>
--UFHRA7zgb0A=--


--===============0237712537702402697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0237712537702402697==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============0237712537702402697==--

