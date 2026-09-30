Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F346CA5FC1
	for <openvpn-devel@archiver.kernel.org>; Wed, 30 Sep 2026 20:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rnni524LPLSZWRCweBiHg9BaePmJ6f9d0yr8CReKSW4=; b=J5FZcBJhpzS8MoYFxI8nxJFKcO
	xsBLG3aMVgaBSu1Dkwqup22bjl/8WKeFG+dPiA4dNHhx2OK0O/aZk4qEfjE6sdmVVmh0EtBUiscta
	wL3q8qezVHJtEnBX9ucMBZP37nYHu4JnBoP4KxKub/W20qAnNz9TFtexG5Oow7ZfD9tE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xC0mi-0002Eg-RC;
	Wed, 30 Sep 2026 20:20:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xC0mh-0002EZ-6D
 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 20:20:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=vfVcU66LSfYeb5oroSij+ADBf+EUdUJOxqtli/nHdBc=; b=jixc+RnsPsDh0CbyesBimTr8Hu
 NiFtT/GjPa5cZ0mFkKnj/EVuwNSlpxdmH/3ehuUtbQn2yd+deMNiWnDKFMwEu/6R+tI3KMT66JYuV
 ftLCdMe/gNCeymHOC67bZKmEXz64Wu8z+r+DaIhqzkopVLA8QisdMNtVNWLon1gi1VNs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vfVcU66LSfYeb5oroSij+ADBf+EUdUJOxqtli/nHdBc=; b=W
 +BxaXSQrFf4KrDYO+YV4H4vg+jHtwAQkrUv32/0GDa0JYfpFxgvoI5GVs1cauwrBFtbLeyGVd7rXg
 RrWh2/n8P1TCH+611ZtIY5OiaGO0bpKzHtHnT0rlSeU6IaXWM0BjFpHzfKROjSFtsd/QKLjFEaCgB
 Kqy55Fj8VrREdLfc=;
Received: from mail-wm2-f12.google.com ([74.125.225.140])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xC0mc-0006WB-B0 for openvpn-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 20:20:11 +0000
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49e66390995so33357065e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 13:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790799600; x=1791404400; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vfVcU66LSfYeb5oroSij+ADBf+EUdUJOxqtli/nHdBc=;
 b=grnKecgmevbch/EYCNN2FQ7OJCoA6Qg7sbUdRmkJYuvwvJE/fAMANR7JHklOUZW8FS
 KqHbl0iAMOQ5eJyoKB/kuhMJth4w/UjowxL8UvXJeChHwMyMauU8FFc5FWhyFRFhL1JV
 ndgTYPmVMOJuVjAGW9gk4y8KFhSV4LtLI1TjAm9roJd+Tfb1uTtsmeZoYF2Z1Khh/g/0
 5kyGYPNrm3SCwfqRVAU6QQTReRBuaNAhXzpYcUtU10xROUKt+ratbQgdTcCTkbabGwyw
 PHs41BB+wwOVQf/d2ILHAzW8fob88+hXi1Fos5MGJnxTmKoKMAzKasGPf+mWe57f5wlg
 bvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790799600; x=1791404400;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vfVcU66LSfYeb5oroSij+ADBf+EUdUJOxqtli/nHdBc=;
 b=Z5DWAPu9jHhik4qDpEWjasxFWxwSGQ4zP81nEkZzoP6nbBbsUpv+tgWBWRxcw5CyKo
 Diznokd9Ge7pdU+CrtW8bSs6UqWwnUDI6RIJXEe0TKcyIfMXyNnrNQ2us4uyOOoqKDdu
 UXzZZfEODrNJiETWnp0gHfIsSforfHuV3IqbN69EvfsWfCP8sbK0gwZqzYo8vDbWkF5+
 qwR7Egy3Oxcsl/uskN2/2IZyCcSCnHvUZJtovleo6ltdoC78xbzp0cwEHnDHZ8kQzICl
 tC0SNy0Y1wqo8iS1RaFytROaGzayXr+ooTjv0uSpVwsCQhZlPj5BLlcH8yrW+EmrEqf2
 Dxdg==
X-Gm-Message-State: AFuF++lvkYs0xERqTzQbj6xiIRCxeLhZhu/lZTLOX73LSIRCvnMChfPf
 p+TfKEMOXIDS0jmE124jiyps3auWLrLYUaH07/fThrmjMQlsdTk3a9HtXuvjegDuNJE6ouS3fd1
 k29TLEJA9Li31YqcT7yoUl5Dbn4WmIRye5MwYMtIZ7j4jUbFz1bYblHOGIODwiYWRFIss
X-Gm-Gg: AYBFou1YLaFv/X22AsAOpT3SL6JCxNgj/3lz5YCuAdHC24Z0k6TUa6bxQUoJ6onYS/o
 qXAELzaqNCW2JGyJ0nEbbtPYw+IZMGK6XAwmm0M9BYRTz7Q4WwLX0kT04VZa+sNdHD7TSI9ztcE
 pPg/sVJ/wNUbhoF3CZipjTTA4Xtdvthr58UGfGTNLI8q2Ug6NIB0KKagBSh7hcpe4Qv0v4CoCdg
 imIRor/OUTaoFXWgfbQ76o7imrWp4Ixxlo7qn5dD/oie1dDLVlOzIPzXb05L9VBMdpOCQ72Ao84
 CY2n9EBZyHgcPyQoEInFQJapsW8YIJJDLVYEddELbyzhWIZAznCYcIJGGByRDg5CrUb6RppUIwo
 4UCJj0oNB/mSSSNN8Itf1Z07dRvuGusQTjFmB3koutIJY07PjNkIpozNIYHnQhf9XLmOtmFW+A+
 Dean1cKdsVXNbYpT7PevE0/jP06pDioMNHNcv8NFEQPnt226Ut3FtuvkX1V1yPjPvatn1z5wDQH
 /zT2UZqFf/iwA2Wm9TgSNafXpE2P1NeW5/dbDTGiKzcFYSJfH10UK2enCxafTucQEwpqa+BEbpW
 n9sI5S6WgWMmb+Zb0Wws1Ohp19MaDSekEKL0sPkb/zeQuvuZISb2p8kv4B0z
X-Received: by 2002:a05:600c:a05:b0:4a0:6bb:237e with SMTP id
 5b1f17b1804b1-4a01b01b407mr39146105e9.29.1790799599338; 
 Wed, 30 Sep 2026 13:19:59 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01fa137basm6798505e9.1.2026.09.30.13.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 13:19:58 -0700 (PDT)
X-Google-Original-From: "stipa (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 30 Sep 2026 20:19:52 +0000
To: ralf_lici <ralf@mandelbit.com>, plaisthos <arne-openvpn@rfc2549.org>,
 flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 20
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <http://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: e3fc273fd285d76d4e1d590ace37158a1d4fc364
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <45e4c4ed73ca2a2f027571d01b87d23aa2d197a4-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xC0mc-0006WB-B0
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
Content-Type: multipart/mixed; boundary="===============7683515928935060295=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============7683515928935060295==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cFaH5DKTB8Y="; charset=UTF-8

--cFaH5DKTB8Y=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, ralf_lici=2E=


Hello flichtenheld, plaisthos, ralf_lici, 

I'd like you to reexamine a c=
hange=2E Please visit

    http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?u=
sp=3Demail

to look at the new patch set (#20)=2E


Change subject: oob: Ad=
d P_CONTROL_OOB_V1 and the probe request and reply TLVs
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

oob: Add P_CONTROL_OOB_V1 and t=
he probe request and reply TLVs

Out-of-band control messages carry control=
 data but belong to no
session, so a client can ask a server about itself b=
efore connecting=2E
Reserve opcode 12 for them and add the TLV codecs the p=
robe needs: the
probe request a client probes a server with, and the probe =
reply the
server answers with=2E

A message is just a sequence of TLVs, and=
 the TLVs it carries say what
it is=2E The probe request carries a request_=
id chosen by the client,
which the probe reply echoes=2E

The TLVs use the =
shared TLV codec, control_msg=2Ec/h, and their two types
join the others in=
 control_msg=2Eh=2E The codec gains ctrl_msg_find_tlv(),
which scans a payl=
oad for the one mandatory TLV of a message=2E The scan
is strict: a truncat=
ed TLV header or value, or an unknown TLV not marked
optional, rejects the =
whole message=2E

P_LAST_OPCODE becomes 12=2E tls_pre_decrypt() rejects the=
 OOB opcodes
explicitly: they are not part of the reliable control channel =
(no
control message id, no ACK array); the server answers them
statelessly =
in a follow-up=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Sig=
ned-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M src/o=
penvpn/Makefile=2Eam
M src/openvpn/control_msg=2Ec
M src/openvpn/control_ms=
g=2Eh
A src/openvpn/oob=2Ec
A src/openvpn/oob=2Eh
M src/openvpn/ssl=2Ec
M s=
rc/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn=
/Makefile=2Eam
A tests/unit_tests/openvpn/test_oob=2Ec
M tests/unit_tests/o=
penvpn/test_pkt=2Ec
12 files changed, 660 insertions(+), 6 deletions(-)


 =
 git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/2=
0

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index e1a6079f=2E=2E8a0=
62b8 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -525,6 +525,8 =
@@
     src/openvpn/multi_io=2Ec
     src/openvpn/occ=2Ec
     src/openvpn/=
occ=2Eh
+    src/openvpn/oob=2Ec
+    src/openvpn/oob=2Eh
     src/openvpn/=
openvpn=2Ec
     src/openvpn/openvpn=2Eh
     src/openvpn/openvpn_win32_res=
ources=2Erc
@@ -886,7 +888,9 @@
     target_sources(test_pkt PRIVATE
      =
   tests/unit_tests/openvpn/mock_win32_execve=2Ec
         tests/unit_tests=
/openvpn/test_control_msg=2Ec
+        tests/unit_tests/openvpn/test_oob=2E=
c
         src/openvpn/control_msg=2Ec
+        src/openvpn/oob=2Ec
       =
  src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
         src/openvpn=
/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Make=
file=2Eam
index a17ae8e=2E=2E5e6b4d9 100644
--- a/src/openvpn/Makefile=2Eam=

+++ b/src/openvpn/Makefile=2Eam
@@ -108,6 +108,7 @@
 	pkcs11=2Ec pkcs11=2E=
h pkcs11_backend=2Eh \
 	pkcs11_openssl=2Ec \
 	pkcs11_mbedtls=2Ec \
+	oob=
=2Ec oob=2Eh \
 	openvpn=2Ec openvpn=2Eh \
 	options=2Ec options=2Eh \
 	op=
tions_show=2Ec options_show=2Eh \
diff --git a/src/openvpn/control_msg=2Ec =
b/src/openvpn/control_msg=2Ec
index ca3aab9=2E=2Ea0a23d6 100644
--- a/src/o=
penvpn/control_msg=2Ec
+++ b/src/openvpn/control_msg=2Ec
@@ -81,3 +81,32 @@=

     buf_set_read(value, v, hdr->value_len);
     return true;
 }
+
+bool
=
+ctrl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct buf=
fer *value)
+{
+    bool found =3D false;
+    while (BLEN(payload) > 0)
+ =
   {
+        struct ctrl_msg_tlv_header hdr;
+        struct buffer v;
+  =
      if (!ctrl_msg_tlv_next(payload, &hdr, &v))
+        {
+            re=
turn false;
+        }
+        if (hdr=2Etype =3D=3D wanted_type)
+       =
 {
+            if (found)
+            {
+                return false; /*=
 the TLV may occur only once */
+            }
+            *value =3D v;
+=
            found =3D true;
+        }
+        else if (!hdr=2Eoptional)
+=
        {
+            return false; /* a mandatory TLV we do not understan=
d, wherever it sits */
+        }
+    }
+    return found;
+}
diff --git a=
/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh
index 73fd0a1=2E=
=2E468b887 100644
--- a/src/openvpn/control_msg=2Eh
+++ b/src/openvpn/contr=
ol_msg=2Eh
@@ -41,6 +41,8 @@
 
 /* TLV types */
 #define TLV_TYPE_EARLY_NEG=
_FLAGS 0x0001 /* early negotiation, in the reset packets */
+#define TLV_TY=
PE_PROBE_REQUEST   0x0002 /* out-of-band, sent by a client probing a server=
 */
+#define TLV_TYPE_PROBE_REPLY     0x0003 /* out-of-band, a server's ans=
wer to a probe request */
 
 /* TLV header bit layout of the first 16-bit f=
ield */
 #define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
@@ -96,4 +98,28 @@
  */
=
 bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr=
, struct buffer *value);
 
+/**
+ * Scan payload for the TLV of type wanted=
_type, skipping any other (e=2Eg=2E
+ * future) TLV type that is marked opt=
ional=2E
+ *
+ * This is for messages that carry exactly one mandatory TLV,=
 which matches the
+ * currently supported OOB messages: any other TLV that=
 is not marked optional
+ * invalidates the message wherever it is present,=
 as does a second TLV of
+ * wanted_type, so the whole sequence is walked=
=2E A message with several
+ * mandatory TLVs walks them with ctrl_msg_tlv_=
next() instead=2E
+ *
+ * On success value covers exactly the found TLV's v=
alue bytes; as with
+ * ctrl_msg_tlv_next(), a header claiming more bytes t=
han payload holds is
+ * rejected rather than reported as found=2E payload =
is consumed as it is read=2E
+ *
+ * @param payload      buffer positioned =
at a TLV header
+ * @param wanted_type  the TLV type to look for
+ * @param=
 value        set to a buffer covering the found TLV's value; it points
+ *=
                     into payload and owns no storage
+ * @return true if t=
he TLV was found, false if it is not present or present
+ *         more th=
an once, a TLV header or value is malformed or truncated, or a
+ *         =
TLV we do not understand is not marked optional=2E
+ */
+bool ctrl_msg_find=
_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *value);
+=

 #endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/oob=2Ec b/src/=
openvpn/oob=2Ec
new file mode 100644
index 0000000=2E=2E5f624be
--- /dev/nu=
ll
+++ b/src/openvpn/oob=2Ec
@@ -0,0 +1,85 @@
+/*
+ *  OpenVPN -- An applic=
ation to securely tunnel IP networks
+ *             over a single TCP/UDP =
port, with support for SSL/TLS-based
+ *             session authentication=
 and key exchange,
+ *             packet encryption, packet authentication=
, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-202=
6 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software;=
 you can redistribute it and/or modify
+ *  it under the terms of the GNU G=
eneral Public License version 2
+ *  as published by the Free Software Foun=
dation=2E
+ *
+ *  This program is distributed in the hope that it will be =
useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of=

+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  =
GNU General Public License for more details=2E
+ *
+ *  You should have rec=
eived a copy of the GNU General Public License along
+ *  with this program=
; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CO=
NFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include=
 "oob=2Eh"
+#include "control_msg=2Eh"
+
+bool
+oob_probe_request_write(str=
uct buffer *buf, const struct oob_probe_request *r)
+{
+    return ctrl_msg=
_tlv_write_header(buf, TLV_TYPE_PROBE_REQUEST, false, OOB_PROBE_REQUEST_LEN=
)
+           && buf_write_u32(buf, r->request_id)
+           && buf_write=
_u64(buf, r->timestamp)
+           && buf_write_u32(buf, r->flags);
+}
+
+=
bool
+oob_probe_request_read(struct buffer *buf, struct oob_probe_request *=
r)
+{
+    /* One bounds check covers the whole value: every field read bel=
ow then fits
+     * by construction (OOB_PROBE_REQUEST_LEN is the sum of t=
heir sizes), so
+     * none of them needs its own error handling=2E Traili=
ng bytes this version
+     * does not understand are simply left unread=2E=
 */
+    if (buf_len(buf) < OOB_PROBE_REQUEST_LEN)
+    {
+        return f=
alse;
+    }
+    r->request_id =3D buf_read_u32(buf, NULL);
+    r->timest=
amp =3D buf_read_u64(buf, NULL);
+    r->flags =3D buf_read_u32(buf, NULL);=

+    return true;
+}
+
+bool
+oob_probe_reply_write(struct buffer *buf, co=
nst struct oob_probe_reply *r)
+{
+    return ctrl_msg_tlv_write_header(buf=
, TLV_TYPE_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)
+           && buf_writ=
e_u32(buf, r->request_id)
+           && buf_write_u16(buf, r->priority)
+ =
          && buf_write_u16(buf, r->weight)
+           && buf_write_u16(buf=
, r->max_latency_diff)
+           && buf_write_u16(buf, r->connect_lifetim=
e)
+           && buf_write_u16(buf, r->flags);
+}
+
+bool
+oob_probe_reply=
_read(struct buffer *buf, struct oob_probe_reply *r)
+{
+    /* One bounds =
check for the whole value, as in oob_probe_request_read()=2E */
+    if (bu=
f_len(buf) < OOB_PROBE_REPLY_LEN)
+    {
+        return false;
+    }
+   =
 r->request_id =3D buf_read_u32(buf, NULL);
+    r->priority =3D (uint16_t)=
buf_read_u16(buf);
+    r->weight =3D (uint16_t)buf_read_u16(buf);
+    r->=
max_latency_diff =3D (uint16_t)buf_read_u16(buf);
+    r->connect_lifetime =
=3D (uint16_t)buf_read_u16(buf);
+    r->flags =3D (uint16_t)buf_read_u16(b=
uf);
+    return true;
+}
diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oo=
b=2Eh
new file mode 100644
index 0000000=2E=2Ee3e4144
--- /dev/null
+++ b/s=
rc/openvpn/oob=2Eh
@@ -0,0 +1,102 @@
+/*
+ *  OpenVPN -- An application to =
securely tunnel IP networks
+ *             over a single TCP/UDP port, wit=
h support for SSL/TLS-based
+ *             session authentication and key =
exchange,
+ *             packet encryption, packet authentication, and
+ *=
             packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN=
 Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can =
redistribute it and/or modify
+ *  it under the terms of the GNU General Pu=
blic License version 2
+ *  as published by the Free Software Foundation=2E=

+ *
+ *  This program is distributed in the hope that it will be useful,
+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Gener=
al Public License for more details=2E
+ *
+ *  You should have received a c=
opy of the GNU General Public License along
+ *  with this program; if not,=
 see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Encod=
ing/decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E
+ *
+ * =
An OOB message payload is a sequence of TLV entries; the TLVs it carries sa=
y
+ * what the message is: a client probes a server with a probe request TL=
V, and
+ * the server answers with a probe reply TLV=2E The TLV framing and=
 the TLV types
+ * are shared with the other TLV-based control messages and=
 live in
+ * control_msg=2Eh; this file defines the values of the OOB TLVs =
and the
+ * OOB-specific decisions taken on them=2E
+ */
+
+#ifndef OOB_H
+=
#define OOB_H
+
+#include "buffer=2Eh"
+#include "control_msg=2Eh"
+#includ=
e "session_id=2Eh"
+
+/* Minimum on-wire value length (excluding the 4-byte=
 TLV header) of each TLV:
+ * the sizes of its fixed fields in wire order (=
see the structs below)=2E The
+ * value may be longer for forward compatibi=
lity; trailing bytes that are not
+ * understood are ignored on read=2E
+ *=

+ * probe request: request_id (u32), timestamp (u64), flags (u32)
+ * prob=
e reply: request_id (u32), then priority, weight, max_latency_diff,
+ * con=
nect_lifetime and flags (u16 each) */
+#define OOB_PROBE_REQUEST_LEN ((uint=
16_t)(sizeof(uint32_t) + sizeof(uint64_t) + sizeof(uint32_t)))
+#define OOB=
_PROBE_REPLY_LEN   ((uint16_t)(sizeof(uint32_t) + 5 * sizeof(uint16_t)))
+
=
+/* probe request TLV (sent by the client to probe a server) */
+struct oob=
_probe_request
+{
+    uint32_t request_id; /**< chosen by the client, echo=
ed in the reply */
+    uint64_t timestamp;  /**< client clock as a UNIX ti=
mestamp */
+    uint32_t flags;      /**< client capability flags, currentl=
y must be 0 */
+};
+
+/* probe reply TLV (sent by the server to answer a pr=
obe request) */
+struct oob_probe_reply
+{
+    uint32_t request_id;       =
/**< echoes the request_id of the request */
+    uint16_t priority;       =
  /**< DNS-SRV style priority (lower is preferred) */
+    uint16_t weight;=
           /**< DNS-SRV style weight */
+    uint16_t max_latency_diff; /**=
< advertised candidate-band margin in ms;
+                                =
*   used unless the client configured its own */
+    uint16_t connect_life=
time; /**< seconds the reply stays valid as the handshake reset */
+    uin=
t16_t flags;            /**< server behaviour flags */
+};
+
+/**
+ * Write=
 a complete probe request TLV (header + value) to buf=2E It is the whole
+ =
* payload of the OOB message probing a server=2E
+ */
+bool oob_probe_reque=
st_write(struct buffer *buf, const struct oob_probe_request *r);
+
+/**
+ *=
 Read a probe request TLV value from buf=2E
+ *
+ * buf must cover exactly =
the TLV's value, as returned by ctrl_msg_find_tlv()=2E
+ * Trailing bytes b=
eyond the fields understood here are ignored, so a longer
+ * value from a =
future version still parses=2E
+ *
+ * @return true on success, false if bu=
f is shorter than the mandatory fields=2E
+ */
+bool oob_probe_request_read=
(struct buffer *buf, struct oob_probe_request *r);
+
+/**
+ * Write a compl=
ete probe reply TLV (header + value) to buf=2E It is the whole
+ * payload =
of the OOB message answering a probe request=2E
+ */
+bool oob_probe_reply_=
write(struct buffer *buf, const struct oob_probe_reply *r);
+
+/**
+ * Read=
 a probe reply TLV value from buf=2E See oob_probe_request_read() for the
+=
 * calling convention=2E
+ */
+bool oob_probe_reply_read(struct buffer *buf=
, struct oob_probe_reply *r);
+
+#endif /* OOB_H */
diff --git a/src/openvp=
n/ssl=2Ec b/src/openvpn/ssl=2Ec
index 92f1991=2E=2E8e2a459 100644
--- a/src=
/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3701,8 +3701,9 @@
     bool =
new_link =3D false;
     struct session_id sid; /* remote session ID */
 
-=
    /* verify legal opcode */
-    if (op < P_FIRST_OPCODE || op > P_LAST_O=
PCODE)
+    /* verify legal opcode=2E An out-of-band packet has no control =
message id and
+     * no ACK array, which is what we parse next=2E */
+   =
 if (op < P_FIRST_OPCODE || op > P_LAST_OPCODE || opcode_is_oob(op))
     {=

         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTR=
OL_HARD_RESET_SERVER_V1)
         {
diff --git a/src/openvpn/ssl_pkt=2Ec b/=
src/openvpn/ssl_pkt=2Ec
index 405e5b4=2E=2E38fb8ed 100644
--- a/src/openvpn=
/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -169,6 +169,8 @@
 {
     ASSE=
RT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
     ASSERT(opcode =
>=3D 0 && opcode <=3D P_LAST_OPCODE);
+    /* OOB packets carry no message =
id or ACK array */
+    ASSERT(!opcode_is_oob(opcode));
     uint8_t header=
 =3D (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT));
 
     /* Workarou=
nd for Softether servers=2E Softether has a bug that it only
diff --git a/s=
rc/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 5a1d194=2E=2Ed477d5a=
 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,=
11 +58,23 @@
  * like P_CONTROL_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_=
WKC_V1 11
 
-/* define the range of legal opcodes
+/* Out-of-band control m=
essage, e=2Eg=2E a server probe=2E Not part of the reliable
+ * control cha=
nnel: no control message id and no ACK array, just TLVs
+ * after the sessi=
on id; never handled by tls_pre_decrypt()=2E */
+#define P_CONTROL_OOB_V1 1=
2
+
+/* define the range of defined opcodes, in- and out-of-band
  * Since =
we do no longer support key-method 1 we consider
  * the v1 op codes invali=
d */
 #define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  11
+#define P_LAST_O=
PCODE  12
+
+/* Is op one of the out-of-band opcodes? */
+static inline boo=
l
+opcode_is_oob(int op)
+{
+    return op =3D=3D P_CONTROL_OOB_V1;
+}
 
 /=
*
  * Define number of buffers for send and receive in the reliability laye=
r=2E
@@ -256,6 +268,9 @@
         case P_CONTROL_WKC_V1:
             retur=
n "P_CONTROL_WKC_V1";
 
+        case P_CONTROL_OOB_V1:
+            return=
 "P_CONTROL_OOB_V1";
+
         case P_ACK_V1:
             return "P_ACK_V=
1";
 
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_test=
s/openvpn/Makefile=2Eam
index d9caa03=2E=2Ecb2ffd8 100644
--- a/tests/unit_=
tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@=
 -157,12 +157,13 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I=
$(top_srcdir)/src/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TE=
ST_LDFLAGS@
-pkt_testdriver_SOURCES =3D test_pkt=2Ec test_control_msg=2Ec m=
ock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
-	test_common=2Eh \
+pkt_t=
estdriver_SOURCES =3D test_pkt=2Ec test_control_msg=2Ec test_oob=2Ec mock_m=
sg=2Ec mock_msg=2Eh \
+	mock_win32_execve=2Ec test_common=2Eh \
 	$(top_src=
dir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(to=
p_srcdir)/src/openvpn/buffer=2Ec \
 	$(top_srcdir)/src/openvpn/control_msg=
=2Ec \
+	$(top_srcdir)/src/openvpn/oob=2Ec \
 	$(top_srcdir)/src/openvpn/cr=
ypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/s=
rc/openvpn/crypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/openvpn/test_=
oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec
new file mode 100644
index =
0000000=2E=2E5b4b24939
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_oo=
b=2Ec
@@ -0,0 +1,386 @@
+/*
+ *  OpenVPN -- An application to securely tunn=
el IP networks
+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based
+ *             session authentication and key exchange,
+ *=
             packet encryption, packet authentication, and
+ *             =
packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@o=
penvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute =
it and/or modify
+ *  it under the terms of the GNU General Public License =
version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Thi=
s program is distributed in the hope that it will be useful,
+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY =
or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lic=
ense for more details=2E
+ *
+ *  You should have received a copy of the GN=
U General Public License along
+ *  with this program; if not, see <https:/=
/www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "conf=
ig=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#includ=
e <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "c=
ontrol_msg=2Eh"
+#include "oob=2Eh"
+#include "test_common=2Eh"
+
+/* Write=
 a probe request TLV and read it back; fields must survive the round
+ * tr=
ip and the whole buffer must be consumed=2E */
+static void
+test_probe_req=
uest_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    =
struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_probe=
_request in =3D {
+        =2Erequest_id =3D 0xdeadbeef,
+        =2Etimest=
amp =3D 0x0123456789abcdefULL,
+        =2Eflags =3D 0,
+    };
+    assert=
_true(oob_probe_request_write(&buf, &in));
+    /* header (4) + value (16) =
*/
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_REQUEST_LEN);
+
+    /* =
the header codec, read from a copy so the scan below still sees it */
+    =
struct buffer peek =3D buf;
+    struct ctrl_msg_tlv_header hdr;
+    asser=
t_true(ctrl_msg_tlv_read_header(&peek, &hdr));
+    assert_int_equal(hdr=2E=
type, TLV_TYPE_PROBE_REQUEST);
+    assert_false(hdr=2Eoptional);
+    asse=
rt_int_equal(hdr=2Evalue_len, OOB_PROBE_REQUEST_LEN);
+
+    struct buffer =
value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &va=
lue));
+    assert_int_equal(BLEN(&value), OOB_PROBE_REQUEST_LEN);
+
+    s=
truct oob_probe_request out =3D { 0 };
+    assert_true(oob_probe_request_r=
ead(&value, &out));
+    assert_int_equal(in=2Erequest_id, out=2Erequest_id=
);
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);
+    assert_int=
_equal(in=2Eflags, out=2Eflags);
+    /* the scan consumed header and value=
 alike */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+=
/* The probe request wire format is locked to the spec's field order
+ * (r=
equest_id, timestamp, flags), big-endian=2E */
+static void
+test_probe_req=
uest_wire_format(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct oob_pro=
be_request in =3D {
+        =2Erequest_id =3D 0x11223344,
+        =2Etime=
stamp =3D 0x0102030405060708ULL,
+        =2Eflags =3D 0,
+    };
+    asse=
rt_true(oob_probe_request_write(&buf, &in));
+
+    const uint8_t expected[=
] =3D {
+        0x00,
+        0x02, /* TLV type 2 (not optional) */
+    =
    0x00,
+        0x10, /* TLV value length =3D 16 */
+        0x11,
+    =
    0x22,
+        0x33,
+        0x44, /* request_id */
+        0x01,
+  =
      0x02,
+        0x03,
+        0x04,
+        0x05,
+        0x06,
+  =
      0x07,
+        0x08, /* timestamp */
+        0x00,
+        0x00,
+ =
       0x00,
+        0x00, /* flags */
+    };
+    assert_int_equal(BLEN(=
&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, si=
zeof(expected));
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV and =
read it back=2E */
+static void
+test_probe_reply_roundtrip(void **state)
+=
{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_bu=
f_gc(128, &gc);
+
+    struct oob_probe_reply in =3D {
+        =2Erequest_=
id =3D 0x11223344,
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,=

+        =2Econnect_lifetime =3D 30,
+        =2Eflags =3D 1,
+        =2E=
max_latency_diff =3D 25,
+    };
+
+    assert_true(oob_probe_reply_write(&=
buf, &in));
+    assert_int_equal(BLEN(&buf), 4 + OOB_PROBE_REPLY_LEN);
+
+=
    struct buffer peek =3D buf;
+    struct ctrl_msg_tlv_header hdr;
+    a=
ssert_true(ctrl_msg_tlv_read_header(&peek, &hdr));
+    assert_int_equal(hd=
r=2Etype, TLV_TYPE_PROBE_REPLY);
+    assert_int_equal(hdr=2Evalue_len, OOB=
_PROBE_REPLY_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_fi=
nd_tlv(&buf, TLV_TYPE_PROBE_REPLY, &value));
+
+    struct oob_probe_reply =
out =3D { 0 };
+    assert_true(oob_probe_reply_read(&value, &out));
+    a=
ssert_int_equal(in=2Erequest_id, out=2Erequest_id);
+    assert_int_equal(i=
n=2Epriority, out=2Epriority);
+    assert_int_equal(in=2Eweight, out=2Ewei=
ght);
+    assert_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);=

+    assert_int_equal(in=2Eflags, out=2Eflags);
+    assert_int_equal(in=
=2Emax_latency_diff, out=2Emax_latency_diff);
+    assert_int_equal(BLEN(&b=
uf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe reply wire format is locke=
d to the spec's field order (request_id,
+ * priority, weight, max_latency_=
diff, connect_lifetime, flags), big-endian=2E */
+static void
+test_probe_r=
eply_wire_format(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    struct oob_probe_rep=
ly in =3D {
+        =2Erequest_id =3D 0x11223344,
+        =2Epriority =3D=
 10,
+        =2Eweight =3D 100,
+        =2Econnect_lifetime =3D 30,
+    =
    =2Eflags =3D 1,
+        =2Emax_latency_diff =3D 25,
+    };
+
+    ass=
ert_true(oob_probe_reply_write(&buf, &in));
+
+    const uint8_t expected[]=
 =3D {
+        0x00,
+        0x03, /* TLV type 3 (not optional) */
+     =
   0x00,
+        0x0e, /* TLV value length =3D 14 */
+        0x11,
+     =
   0x22,
+        0x33,
+        0x44, /* request_id */
+        0x00,
+   =
     0x0a, /* priority =3D 10 */
+        0x00,
+        0x64, /* weight =
=3D 100 */
+        0x00,
+        0x19, /* max_latency_diff =3D 25 */
+   =
     0x00,
+        0x1e, /* connect_lifetime =3D 30 */
+        0x00,
+   =
     0x01, /* flags =3D 1 */
+    };
+    assert_int_equal(BLEN(&buf), size=
of(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expect=
ed));
+
+    gc_free(&gc);
+}
+
+/* A TLV with a longer-than-known value mu=
st still parse: the known fields are
+ * read and the trailing bytes are sk=
ipped (forward compatibility)=2E */
+static void
+test_probe_request_forwar=
d_compat(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct=
 buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint16_t extended_len =
=3D OOB_PROBE_REQUEST_LEN + 4;
+    assert_true(ctrl_msg_tlv_write_header(&=
buf, TLV_TYPE_PROBE_REQUEST, false, extended_len));
+    assert_true(buf_wr=
ite_u32(&buf, 7));          /* request_id */
+    assert_true(buf_write_u32=
(&buf, 0));          /* timestamp high */
+    assert_true(buf_write_u32(&b=
uf, 0xdeadbeef)); /* timestamp low */
+    assert_true(buf_write_u32(&buf, =
0));          /* flags */
+    assert_true(buf_write_u32(&buf, 0x11223344))=
; /* unknown trailing field */
+
+    struct buffer value;
+    assert_true=
(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_=
equal(BLEN(&value), extended_len);
+
+    struct oob_probe_request out =3D =
{ 0 };
+    assert_true(oob_probe_request_read(&value, &out));
+    assert_=
int_equal(out=2Erequest_id, 7);
+    assert_true(out=2Etimestamp =3D=3D 0xd=
eadbeefULL);
+    assert_int_equal(out=2Eflags, 0);
+    /* the unknown tra=
iling field must have been consumed from the payload */
+    assert_int_equ=
al(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A value shorter than the m=
andatory fields must be rejected, even when it
+ * holds enough bytes for s=
ome of the individual fields to read successfully=2E */
+static void
+test_=
probe_request_too_short(void **state)
+{
+    struct gc_arena gc =3D gc_new=
();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* 4 of the 1=
6 mandatory value bytes: enough for the request_id alone */
+    assert_tru=
e(buf_write_u32(&buf, 0xdeadbeef));
+
+    struct oob_probe_request out =3D=
 { 0 };
+    assert_false(oob_probe_request_read(&buf, &out));
+
+    gc_fr=
ee(&gc);
+}
+
+/* A TLV header claiming more value bytes than the payload h=
olds must be
+ * rejected by the scan rather than reported as found -- for =
the TLV being
+ * looked for as much as for one that would merely be skippe=
d=2E */
+static void
+test_find_tlv_value_truncated(void **state)
+{
+    s=
truct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+    /* the wan=
ted TLV declares 12 value bytes, only 4 are present */
+    struct buffer b=
uf =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&=
buf, TLV_TYPE_PROBE_REQUEST, false,
+                                      =
    OOB_PROBE_REQUEST_LEN));
+    assert_true(buf_write_u32(&buf, 0xdeadbee=
f));
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &val=
ue));
+
+    /* same defect on a TLV that would be skipped: the scan must n=
ot walk past
+     * the end of the payload looking for the next header */
=
+    struct buffer buf2 =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_m=
sg_tlv_write_header(&buf2, 0x7ff, false, 64));
+    assert_true(buf_write_u=
32(&buf2, 0));
+    assert_false(ctrl_msg_find_tlv(&buf2, TLV_TYPE_PROBE_RE=
QUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* Bytes left over after the la=
st TLV that are too few for a header make the
+ * message malformed, even w=
hen the wanted TLV was already found=2E */
+static void
+test_find_tlv_trai=
ling_bytes(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    stru=
ct buffer value;
+
+    /* 1 to 3 bytes: less than a 4-byte TLV header */
+=
    for (int trailing =3D 1; trailing <=3D 3; trailing++)
+    {
+        s=
truct buffer buf =3D alloc_buf_gc(128, &gc);
+        const struct oob_prob=
e_request in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 };
+        assert_tr=
ue(oob_probe_request_write(&buf, &in));
+        for (int i =3D 0; i < trai=
ling; i++)
+        {
+            assert_true(buf_write_u8(&buf, 0));
+   =
     }
+        assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST=
, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV marked opti=
onal after the wanted one is skipped, and the
+ * wanted value is still the=
 one returned=2E */
+static void
+test_find_tlv_skips_optional_after_wanted=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer =
buf =3D alloc_buf_gc(128, &gc);
+    struct buffer value;
+
+    const stru=
ct oob_probe_request in =3D { =2Etimestamp =3D 7, =2Eflags =3D 0 };
+    as=
sert_true(oob_probe_request_write(&buf, &in));
+    assert_true(ctrl_msg_tl=
v_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf,=
 0));
+
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &v=
alue));
+    assert_int_equal(BLEN(&value), OOB_PROBE_REQUEST_LEN);
+    st=
ruct oob_probe_request out =3D { 0 };
+    assert_true(oob_probe_request_re=
ad(&value, &out));
+    assert_true(out=2Etimestamp =3D=3D 7);
+
+    gc_fr=
ee(&gc);
+}
+
+/* The wanted TLV may occur only once: a second one rejects =
the message=2E Repeats
+ * of an unknown TLV marked optional are skipped li=
ke any other=2E */
+static void
+test_find_tlv_rejects_duplicate(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer value;
+   =
 const struct oob_probe_request in =3D { =2Erequest_id =3D 1 };
+
+    stru=
ct buffer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(oob_probe_reques=
t_write(&buf, &in));
+    assert_true(oob_probe_request_write(&buf, &in));
=
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));=

+
+    buf =3D alloc_buf_gc(128, &gc);
+    for (int i =3D 0; i < 2; i++)
=
+    {
+        assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4)=
);
+        assert_true(buf_write_u32(&buf, 0));
+    }
+    assert_true(oo=
b_probe_request_write(&buf, &in));
+    assert_true(ctrl_msg_find_tlv(&buf,=
 TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* An empty p=
ayload holds no TLV=2E */
+static void
+test_find_tlv_empty_payload(void **=
state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D =
alloc_buf_gc(16, &gc);
+    struct buffer value;
+
+    assert_false(ctrl_m=
sg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}=

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
+        cmocka_unit_test(test_find_tlv_rejects_duplicate),
=
+        cmocka_unit_test(test_find_tlv_empty_payload),
+    };
+
+    retu=
rn cmocka_run_group_tests_name("oob tests", tests, NULL, NULL);
+}
diff --g=
it a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_=
pkt=2Ec
index 9ce9c50=2E=2E0398a1f 100644
--- a/tests/unit_tests/openvpn/te=
st_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -46,6 +46,7 @@
 #=
include "siphash=2Eh"
 
 int run_control_msg_tests(void); /* test_control_m=
sg=2Ec */
+int run_oob_tests(void);         /* test_oob=2Ec */
 
 int
 pars=
e_line(const char *line, char **p, const int n, const char *file, const int=
 line_num,
@@ -794,5 +795,6 @@
 
     int failed =3D cmocka_run_group_tests=
_name("pkt tests", tests, NULL, NULL);
     failed +=3D run_control_msg_tes=
ts();
+    failed +=3D run_oob_tests();
     return failed ? 1 : 0;
 }

-- =

To view, visit http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
=
To unsubscribe, or for help writing mail filters, visit http://gerrit=2Eope=
nvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Pro=
ject: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622=
a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: 20
Gerrit-=
Owner: stipa <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank@l=
ichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Reviewer: ralf_lici <ralf@mandelbit=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: ralf_lici <ralf@=
mandelbit=2Ecom>
Gerrit-Attention: plaisthos <arne-openvpn@rfc2549=2Eorg>
G=
errit-Attention: flichtenheld <frank@lichtenheld=2Ecom>

--cFaH5DKTB8Y=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, ralf_lici=2E </p>
<p>stipa <=
strong>uploaded patch set #20</strong> to this change=2E</p><p><a href=3D"h=
ttp://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">View Change</a><=
/p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">oob: Add P_CONTROL_OOB_V1 and the probe request and reply =
TLVs<br><br>Out-of-band control messages carry control data but belong to n=
o<br>session, so a client can ask a server about itself before connecting=
=2E<br>Reserve opcode 12 for them and add the TLV codecs the probe needs: t=
he<br>probe request a client probes a server with, and the probe reply the<=
br>server answers with=2E<br><br>A message is just a sequence of TLVs, and =
the TLVs it carries say what<br>it is=2E The probe request carries a reques=
t_id chosen by the client,<br>which the probe reply echoes=2E<br><br>The TL=
Vs use the shared TLV codec, control_msg=2Ec/h, and their two types<br>join=
 the others in control_msg=2Eh=2E The codec gains ctrl_msg_find_tlv(),<br>w=
hich scans a payload for the one mandatory TLV of a message=2E The scan<br>=
is strict: a truncated TLV header or value, or an unknown TLV not marked<br=
>optional, rejects the whole message=2E<br><br>P_LAST_OPCODE becomes 12=2E =
tls_pre_decrypt() rejects the OOB opcodes<br>explicitly: they are not part =
of the reliable control channel (no<br>control message id, no ACK array); t=
he server answers them<br>statelessly in a follow-up=2E<br><br>Change-Id: I=
1c8d302ac57c5603d622a7be14be369437388268<br>Signed-off-by: Lev Stipakov &lt=
;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefi=
le=2Eam<br>M src/openvpn/control_msg=2Ec<br>M src/openvpn/control_msg=2Eh<b=
r>A src/openvpn/oob=2Ec<br>A src/openvpn/oob=2Eh<br>M src/openvpn/ssl=2Ec<b=
r>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_te=
sts/openvpn/Makefile=2Eam<br>A tests/unit_tests/openvpn/test_oob=2Ec<br>M t=
ests/unit_tests/openvpn/test_pkt=2Ec<br>12 files changed, 660 insertions(+)=
, 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/41/1741/20</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeList=
s=2Etxt b/CMakeLists=2Etxt</span><br><span>index e1a6079f=2E=2E8a062b8 1006=
44</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -525,6 +525,8 @@</span><br><span>     src/openvpn=
/multi_io=2Ec</span><br><span>     src/openvpn/occ=2Ec</span><br><span>    =
 src/openvpn/occ=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    src/openvpn/oob=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    src/openvpn/oob=2Eh</span><br><span>     src/openvpn/openvpn=2Ec</=
span><br><span>     src/openvpn/openvpn=2Eh</span><br><span>     src/openvp=
n/openvpn_win32_resources=2Erc</span><br><span>@@ -886,7 +888,9 @@</span><b=
r><span>     target_sources(test_pkt PRIVATE</span><br><span>         tests=
/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>         tests/un=
it_tests/openvpn/test_control_msg=2Ec</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        tests/unit_tests/openvpn/test_oob=2Ec</span><br><=
span>         src/openvpn/control_msg=2Ec</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/oob=2Ec</span><br><span>         =
src/openvpn/argv=2Ec</span><br><span>         src/openvpn/base64=2Ec</span>=
<br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff --git =
a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><span>ind=
ex a17ae8e=2E=2E5e6b4d9 100644</span><br><span>--- a/src/openvpn/Makefile=
=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@ -1=
08,6 +108,7 @@</span><br><span> 	pkcs11=2Ec pkcs11=2Eh pkcs11_backend=2Eh \=
</span><br><span> 	pkcs11_openssl=2Ec \</span><br><span> 	pkcs11_mbedtls=2E=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	oob=2Ec oob=2Eh=
 \</span><br><span> 	openvpn=2Ec openvpn=2Eh \</span><br><span> 	options=2E=
c options=2Eh \</span><br><span> 	options_show=2Ec options_show=2Eh \</span=
><br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_m=
sg=2Ec</span><br><span>index ca3aab9=2E=2Ea0a23d6 100644</span><br><span>--=
- a/src/openvpn/control_msg=2Ec</span><br><span>+++ b/src/openvpn/control_m=
sg=2Ec</span><br><span>@@ -81,3 +81,32 @@</span><br><span>     buf_set_read=
(value, v, hdr-&gt;value_len);</span><br><span>     return true;</span><br>=
<span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ctrl_msg_find_tlv(struct buffer *payload, uin=
t16_t wanted_type, struct buffer *value)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    bool found =3D false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    while (BLEN(payload) &gt; 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer v;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_next(payload, &=
amp;hdr, &amp;v))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (hdr=
=2Etype =3D=3D wanted_type)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           return false; /* the TLV may occur only once */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            *value =3D v;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            found =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else if (!hdr=2Eoptional)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            return false; /* a ma=
ndatory TLV we do not understand, wherever it sits */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return found;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span>diff --git a/src/openvpn/control_msg=2Eh b/src/op=
envpn/control_msg=2Eh</span><br><span>index 73fd0a1=2E=2E468b887 100644</sp=
an><br><span>--- a/src/openvpn/control_msg=2Eh</span><br><span>+++ b/src/op=
envpn/control_msg=2Eh</span><br><span>@@ -41,6 +41,8 @@</span><br><span> </=
span><br><span> /* TLV types */</span><br><span> #define TLV_TYPE_EARLY_NEG=
_FLAGS 0x0001 /* early negotiation, in the reset packets */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REQUEST   0x=
0002 /* out-of-band, sent by a client probing a server */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REPLY     0x00=
03 /* out-of-band, a server&#39;s answer to a probe request */</span><br><s=
pan> </span><br><span> /* TLV header bit layout of the first 16-bit field *=
/</span><br><span> #define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><spa=
n>@@ -96,4 +98,28 @@</span><br><span>  */</span><br><span> bool ctrl_msg_tl=
v_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *=
value);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scan pa=
yload for the TLV of type wanted_type, skipping any other (e=2Eg=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * future) TLV type that is=
 marked optional=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This is for me=
ssages that carry exactly one mandatory TLV, which matches the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * currently supported OOB messa=
ges: any other TLV that is not marked optional</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * invalidates the message wherever it is presen=
t, as does a second TLV of</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * wanted_type, so the whole sequence is walked=2E A message with se=
veral</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * mandatory T=
LVs walks them with ctrl_msg_tlv_next() instead=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * On success value covers exactly the found TLV&#39;s value =
bytes; as with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * ct=
rl_msg_tlv_next(), a header claiming more bytes than payload holds is</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejected rather than r=
eported as found=2E payload is consumed as it is read=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param payload      buffer positioned at a TLV heade=
r</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param wanted_t=
ype  the TLV type to look for</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param value        set to a buffer covering the found TLV&#39=
;s value; it points</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *                     into payload and owns no storage</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return true if the TLV was found, f=
alse if it is not present or present</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *         more than once, a TLV header or value is malfor=
med or truncated, or a</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *         TLV we do not understand is not marked optional=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool ctrl_msg_find_tlv(struct buffer *payload,=
 uint16_t wanted_type, struct buffer *value);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef CONTROL_MSG_H =
*/</span><br><span>diff --git a/src/openvpn/oob=2Ec b/src/openvpn/oob=2Ec</=
span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E5f62=
4be</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Ec=
</span><br><span>@@ -0,0 +1,85 @@</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 OpenVPN -- An application to securely tunnel IP networks</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP =
port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             session authentication and key exchange,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet =
encryption, packet authentication, and</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *             packet compression=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvp=
n=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free =
software; you can redistribute it and/or modify</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publi=
c License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  as published by the Free Software Foundation=2E</span><br><span style=
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
);">+#include &quot;oob=2Eh&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+oob=
_probe_request_write(struct buffer *buf, const struct oob_probe_request *r)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(=
buf, TLV_TYPE_PROBE_REQUEST, false, OOB_PROBE_REQUEST_LEN)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(=
buf, r-&gt;request_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+           &amp;&amp; buf_write_u64(buf, r-&gt;timestamp)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u3=
2(buf, r-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+oob_probe_request_read(struct buffer *buf, struct o=
ob_probe_request *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds=
 check covers the whole value: every field read below then fits</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * by construction (OOB_PRO=
BE_REQUEST_LEN is the sum of their sizes), so</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * none of them needs its own error handling=
=2E Trailing bytes this version</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * does not understand are simply left unread=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; O=
OB_PROBE_REQUEST_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;request_id =3D=
 buf_read_u32(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    r-&gt;timestamp =3D buf_read_u64(buf, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+oob_probe_reply_write(struct buffer *buf, const struct oob_probe_reply=
 *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_hea=
der(buf, TLV_TYPE_PROBE_REPLY, false, OOB_PROBE_REPLY_LEN)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u32(=
buf, r-&gt;request_id)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+           &amp;&amp; buf_write_u16(buf, r-&gt;priority)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16=
(buf, r-&gt;weight)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
           &amp;&amp; buf_write_u16(buf, r-&gt;max_latency_diff)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_writ=
e_u16(buf, r-&gt;connect_lifetime)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;flags);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
oob_probe_reply_read(struct buffer *buf, struct oob_probe_reply *r)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* One bounds check for the whole value, =
as in oob_probe_request_read()=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (buf_len(buf) &lt; OOB_PROBE_REPLY_LEN)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    r-&gt;request_id =3D buf_read_u32(buf, NULL);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (u=
int16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    r-&gt;weight =3D (uint16_t)buf_read_u16(buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16=
_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    r-&gt;connect_lifetime =3D (uint16_t)buf_read_u16(buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D (uint16_t)buf=
_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span>diff --git a/src/openvpn/oob=2Eh b/src/openvpn/oob=2Eh</span><br=
><span>new file mode 100644</span><br><span>index 0000000=2E=2Ee3e4144</spa=
n><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/oob=2Eh</span><=
br><span>@@ -0,0 +1,102 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVP=
N -- An application to securely tunnel IP networks</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, w=
ith support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             session authentication and key exchange,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypt=
ion, packet authentication, and</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *             packet compression=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet=
&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free softwar=
e; you can redistribute it and/or modify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Licen=
se version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as =
published by the Free Software Foundation=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is distributed in the hope that it will be useful,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY=
 WARRANTY; without even the implied warranty of</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR=
 PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  GNU General Public License for more details=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  You should have received a copy of the GNU General Pub=
lic License along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @file</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
Encoding/decoding of out-of-band (P_CONTROL_OOB_V1) control messages=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * An OOB message payload is a sequence =
of TLV entries; the TLVs it carries say</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * what the message is: a client probes a server with a=
 probe request TLV, and</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * the server answers with a probe reply TLV=2E The TLV framing and the=
 TLV types</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * are sh=
ared with the other TLV-based control messages and live in</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * control_msg=2Eh; this file define=
s the values of the OOB TLVs and the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * OOB-specific decisions taken on them=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef OOB_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OOB_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;session_id=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* Minimum on-wire value length (excluding the 4-byte TLV header) of each T=
LV:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the sizes of =
its fixed fields in wire order (see the structs below)=2E The</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * value may be longer for forwar=
d compatibility; trailing bytes that are not</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * understood are ignored on read=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * probe request: request_id (u32), timestamp (u64=
), flags (u32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * pr=
obe reply: request_id (u32), then priority, weight, max_latency_diff,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connect_lifetime and f=
lags (u16 each) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define OOB_PROBE_REQUEST_LEN ((uint16_t)(sizeof(uint32_t) + sizeof(uint64_t=
) + sizeof(uint32_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define OOB_PROBE_REPLY_LEN   ((uint16_t)(sizeof(uint32_t) + 5 * sizeof(=
uint16_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe request TLV (sent =
by the client to probe a server) */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+struct oob_probe_request</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint32_t request_id; /**&lt; chosen by the client, echoed in the rep=
ly */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t t=
imestamp;  /**&lt; client clock as a UNIX timestamp */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags;      /**&lt; client =
capability flags, currently must be 0 */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe reply =
TLV (sent by the server to answer a probe request) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct oob_probe_reply</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    uint32_t request_id;       /**&lt; echoes the reques=
t_id of the request */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint16_t priority;         /**&lt; DNS-SRV style priority (lower is =
preferred) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt16_t weight;           /**&lt; DNS-SRV style weight */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    uint16_t max_latency_diff; /**&lt;=
 advertised candidate-band margin in ms;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                *   used unless the cl=
ient configured its own */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint16_t connect_lifetime; /**&lt; seconds the reply stays valid=
 as the handshake reset */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uint16_t flags;            /**&lt; server behaviour flags */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Write a complete probe request TLV (header + value) to buf=2E It is the =
whole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * payload of =
the OOB message probing a server=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool oob_probe_request_write(struct buffer *buf, const struct oob_probe_req=
uest *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Read a probe request TLV value from buf=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * buf must cover exactly the TLV&#3=
9;s value, as returned by ctrl_msg_find_tlv()=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Trailing bytes beyond the fields understood=
 here are ignored, so a longer</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * value from a future version still parses=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return true on success, false if buf is shorter th=
an the mandatory fields=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool oob_=
probe_request_read(struct buffer *buf, struct oob_probe_request *r);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Write a complete probe reply TLV (header + value) to buf=
=2E It is the whole</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * payload of the OOB message answering a probe request=2E</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+bool oob_probe_reply_write(struct buffer *buf, const=
 struct oob_probe_reply *r);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe reply TLV =
value from buf=2E See oob_probe_request_read() for the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * calling convention=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool oob_probe_reply_read(struct buffer *buf, struc=
t oob_probe_reply *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* OOB_H =
*/</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</=
span><br><span>index 92f1991=2E=2E8e2a459 100644</span><br><span>--- a/src/=
openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@=
@ -3701,8 +3701,9 @@</span><br><span>     bool new_link =3D false;</span><b=
r><span>     struct session_id sid; /* remote session ID */</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* verify legal=
 opcode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op =
&lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* verify legal opcode=2E An out-of-band pack=
et has no control message id and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * no ACK array, which is what we parse next=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op &lt; P_FIRST_OPC=
ODE || op &gt; P_LAST_OPCODE || opcode_is_oob(op))</span><br><span>     {</=
span><br><span>         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =
=3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span>         {</span><br=
><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span=
><br><span>index 405e5b4=2E=2E38fb8ed 100644</span><br><span>--- a/src/open=
vpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><sp=
an>@@ -169,6 +169,8 @@</span><br><span> {</span><br><span>     ASSERT(ks-&g=
t;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><=
br><span>     ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCO=
DE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* OOB pack=
ets carry no message id or ACK array */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(!opcode_is_oob(opcode));</span><br><span>   =
  uint8_t header =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SH=
IFT));</span><br><span> </span><br><span>     /* Workaround for Softether s=
ervers=2E Softether has a bug that it only</span><br><span>diff --git a/src=
/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 5a1d19=
4=2E=2Ed477d5a 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><=
br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,11 +58,23 @@<=
/span><br><span>  * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span>=
 #define P_CONTROL_WKC_V1 11</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* define the range of legal opcodes</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* Out-of-band control message, e=
=2Eg=2E a server probe=2E Not part of the reliable</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * control channel: no control message id an=
d no ACK array, just TLVs</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * after the session id; never handled by tls_pre_decrypt()=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_OOB_V=
1 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/* define the range of defined opc=
odes, in- and out-of-band</span><br><span>  * Since we do no longer support=
 key-method 1 we consider</span><br><span>  * the v1 op codes invalid */</s=
pan><br><span> #define P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#define P_LAST_OPCODE  11</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define P_LAST_OPCODE  12</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* Is op one of the out-of-band opcodes? */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+opcode_is_oob(int op)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return op =3D=3D P_CONTROL_OOB_V1;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> /=
*</span><br><span>  * Define number of buffers for send and receive in the =
reliability layer=2E</span><br><span>@@ -256,6 +268,9 @@</span><br><span>  =
       case P_CONTROL_WKC_V1:</span><br><span>             return &quot;P_C=
ONTROL_WKC_V1&quot;;</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        case P_CONTROL_OOB_V1:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return &quot;P_CONTROL_OOB_V1&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>         case P_ACK_V1:</span><br><span>             return &quot;P_ACK_V1=
&quot;;</span><br><span> </span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>index d9caa03=2E=2Ecb2ffd8 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>@@ -157,12 +157,13 @@</span><br><span> 	-I$(top_srcd=
ir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span>=
<br><span> 	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST=
_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriv=
er_SOURCES =3D test_pkt=2Ec test_control_msg=2Ec mock_msg=2Ec mock_msg=2Eh =
mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+pkt_testdriver_SOURCES =3D test_pkt=2Ec test_control_msg=2Ec test_oob=2Ec =
mock_msg=2Ec mock_msg=2Eh \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	mock_win32_execve=2Ec test_common=2Eh \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ba=
se64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><=
br><span> 	$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/oob=2Ec \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(t=
op_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/crypto_mbedtls=2Ec \</span><br><span>diff --git a/tests/unit_tes=
ts/openvpn/test_oob=2Ec b/tests/unit_tests/openvpn/test_oob=2Ec</span><br><=
span>new file mode 100644</span><br><span>index 0000000=2E=2E5b4b24939</spa=
n><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_oob=2Ec</span><br><span>@@ -0,0 +1,386 @@</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sing=
le TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             session authentication and key e=
xchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         =
    packet encryption, packet authentication, and</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;s=
ales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progr=
am is free software; you can redistribute it and/or modify</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Ge=
neral Public License version 2</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that =
it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNES=
S FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  GNU General Public License for more details=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;oob=2Eh&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_c=
ommon=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe reques=
t TLV and read it back; fields must survive the round</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * trip and the whole buffer must be cons=
umed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reques=
t_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct oob_probe_request in =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0xdea=
dbeef,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eti=
mestamp =3D 0x0123456789abcdefULL,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(oob_probe_request_write(&amp;buf, &amp;in));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* header (4) + value (1=
6) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;buf), 4 + OOB_PROBE_REQUEST_LEN);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* the header codec, read from a copy so the scan below sti=
ll sees it */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer peek =3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &=
amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue=
_len, OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(BLEN(&amp;value), OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct oob_probe_request out =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_read(&amp;=
value, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(in=2Erequest_id, out=2Erequest_id);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D o=
ut=2Etimestamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* the scan consumed header and value alike */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* The probe request wire format is locked to the spe=
c&#39;s field order</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * (request_id, timestamp, flags), big-endian=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_probe_request_wire_format(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st struct oob_probe_request in =3D {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        =2Erequest_id =3D 0x11223344,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0102030405060=
708ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ef=
lags =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_p=
robe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const uint8_t expected[] =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        0x02, /* TLV type 2 (not optional) */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        0x10, /* TLV value length =3D 16 */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x11,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        0x22,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        0x33,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        0x44, /* request_id */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        0x01,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        0x02,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        0x03,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        0x04,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        0x05,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        0x06,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        0x07,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        0x08, /* timestamp */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     0x00, /* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected,=
 sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Write a probe reply TLV and read it back=2E */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_roundtrip(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct b=
uffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct oob_probe_reply in =3D {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        =2Erequest_id =3D 0x11223344,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_life=
time =3D 30,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 =2Eflags =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     =2Emax_latency_diff =3D 25,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob=
_probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 4 + OOB_PROBE_REPL=
Y_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =3D buf;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg=
_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, T=
LV_TYPE_PROBE_REPLY);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(hdr=2Evalue_len, OOB_PROBE_REPLY_LEN);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, TLV=
_TYPE_PROBE_REPLY, &amp;value));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct oob_probe_reply out =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(oob_probe_reply_read(&amp;value, &amp;out))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(in=2Erequest_id, out=2Erequest_id);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(in=2Epriority, out=2Epriority);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=
=2Eweight, out=2Eweight);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* The probe reply wire format is locked to the spec=
&#39;s field order (request_id,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * priority, weight, max_latency_diff, connect_lifetime, flags)=
, big-endian=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_prob=
e_reply_wire_format(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct oob_probe_reply in =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0x112=
23344,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Epr=
iority =3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Eweight =3D 100,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        =2Eflags =3D 1,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(oob_probe_reply_write(&amp;buf, &amp;in));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const uint8_t expected[] =3D {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        0x03, /* TLV type 3 (not optiona=
l) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x0e, /* TLV=
 value length =3D 14 */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        0x11,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      0x22,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
0x33,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x44, =
/* request_id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0=
x0a, /* priority =3D 10 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        0x64, /* weight =3D 100 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0x00,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        0x19, /* max_latency_diff =3D 25 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        0x1e, /* connect_lifetime =3D 30 */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        0x01, /* flags =3D 1 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp=
;buf), sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expected));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* A TLV with a longer-than-known value must still parse: the known fields=
 are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read and the=
 trailing bytes are skipped (forward compatibility)=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_probe_request_forward_compat(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new()=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const uint16_t extended_len =3D OOB_PROBE_REQUEST_LEN + 4;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_=
header(&amp;buf, TLV_TYPE_PROBE_REQUEST, false, extended_len));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&=
amp;buf, 7));          /* request_id */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));          /=
* timestamp high */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(buf_write_u32(&amp;buf, 0xdeadbeef)); /* timestamp low */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_w=
rite_u32(&amp;buf, 0));          /* flags */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344=
)); /* unknown trailing field */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;val=
ue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;value), extended_len);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct oob_probe_request out =3D { 0 };</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_read(&amp;value,=
 &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(out=2Erequest_id, 7);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(out=
=2Eflags, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 the unknown trailing field must have been consumed from the payload */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BL=
EN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* A value shorter than the mandatory fields must be rej=
ected, even when it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * holds enough bytes for some of the individual fields to read successfull=
y=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_t=
oo_short(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* 4 of the 16 mandatory value bytes: enough for the r=
equest_id alone */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct oob_probe_request out =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(oob_probe_request_r=
ead(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* A TLV header claiming more value bytes than t=
he payload holds must be</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * rejected by the scan rather than reported as found -- for the TLV b=
eing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * looked for a=
s much as for one that would merely be skipped=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_find_tlv_value_truncated(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* the wanted TLV declares 12 valu=
e bytes, only 4 are present */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_w=
rite_header(&amp;buf, TLV_TYPE_PROBE_REQUEST, false,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
 OOB_PROBE_REQUEST_LEN));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(buf_write_u32(&amp;buf, 0xdeadbeef));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(=
&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* same defect on a TLV that would be skipped: the scan must n=
ot walk past</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
the end of the payload looking for the next header */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf2 =3D alloc_buf_gc(1=
28, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(ctrl_msg_tlv_write_header(&amp;buf2, 0x7ff, false, 64));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u3=
2(&amp;buf2, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_false(ctrl_msg_find_tlv(&amp;buf2, TLV_TYPE_PROBE_REQUEST, &amp;va=
lue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* Bytes left over after the last TLV that are too few for a header=
 make the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * message=
 malformed, even when the wanted TLV was already found=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_trailing_bytes(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer v=
alue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* 1 to 3 bytes: less than a =
4-byte TLV header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    for (int trailing =3D 1; trailing &lt;=3D 3; trailing++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(128,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst struct oob_probe_request in =3D { =2Etimestamp =3D 1, =2Eflags =3D 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_tru=
e(oob_probe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; trailing; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            assert_true(buf_wr=
ite_u8(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
assert_false(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unk=
nown TLV marked optional after the wanted one is skipped, and the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * wanted value is still the =
one returned=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find=
_tlv_skips_optional_after_wanted(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buff=
er value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_re=
quest in =3D { =2Etimestamp =3D 7, =2Eflags =3D 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_write(&=
amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write=
_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;v=
alue), OOB_PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct oob_probe_request out =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(oob_probe_request_read(&=
amp;value, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(out=2Etimestamp =3D=3D 7);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* The wanted TLV may occur =
only once: a second one rejects the message=2E Repeats</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * of an unknown TLV marked optional are=
 skipped like any other=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_find_tlv_rejects_duplicate(void **state)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const struct oob_probe_request in =3D=
 { =2Erequest_id =3D 1 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(oob_probe_request_write(&amp;buf, &amp=
;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(oob_probe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, TL=
V_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    for (int i =3D 0; i &lt; 2; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        assert_true(ctrl_msg_tlv_write_header(&amp;buf,=
 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(oob_probe_request_write(&amp;buf, &amp;in));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl=
_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An empty =
payload holds no TLV=2E */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_find_tlv_empty_payload(void **state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer valu=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&=
amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* The OOB tests run as a s=
econd group of pkt_testdriver; see test_pkt=2Ec=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+run_oob_tests(void)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    const struct CMUnitTest tests[] =3D {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_request_roundtrip=
),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(test_probe_request_wire_format),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_roundtrip),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_probe_reply_wire_format),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_probe_request_forward_compat)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_uni=
t_test(test_probe_request_too_short),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_value_truncated),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_find_tlv_trailing_bytes),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_skips_optional_after=
_wanted),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_find_tlv_rejects_duplicate),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_empty_p=
ayload),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&q=
uot;oob tests&quot;, tests, NULL, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>inde=
x 9ce9c50=2E=2E0398a1f 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec<=
/span><br><span>@@ -46,6 +46,7 @@</span><br><span> #include &quot;siphash=
=2Eh&quot;</span><br><span> </span><br><span> int run_control_msg_tests(voi=
d); /* test_control_msg=2Ec */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+int run_oob_tests(void);         /* test_oob=2Ec */</span><br><s=
pan> </span><br><span> int</span><br><span> parse_line(const char *line, ch=
ar **p, const int n, const char *file, const int line_num,</span><br><span>=
@@ -794,5 +795,6 @@</span><br><span> </span><br><span>     int failed =3D c=
mocka_run_group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span=
><br><span>     failed +=3D run_control_msg_tests();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    failed +=3D run_oob_tests();</span><b=
r><span>     return failed ? 1 : 0;</span><br><span> }</span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">se=
ttings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit=2Eopenvpn=2Enet/c/openv=
pn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </=
div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=
=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"=
> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div s=
tyle=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"disp=
lay:none"> Gerrit-PatchSet: 20 </div>
<div style=3D"display:none"> Gerrit-O=
wner: stipa &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@rfc25=
49=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici=
 &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-CC=
: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div=
 style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@mandelbit=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;=
arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-A=
ttention: flichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></htm=
l>
--cFaH5DKTB8Y=--


--===============7683515928935060295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7683515928935060295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7683515928935060295==--

