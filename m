Return-Path: <openvpn-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2493CA5FC5
	for <openvpn-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tAFr/YsRMfXeaxDK5hdLjDjX2dvf68nUgyZlmBYWIGQ=; b=Gtusn7iGhzQzbK+k5bFybogfy8
	If2deDWyJHk3Cjv4wnYEbPn7UuVJSjx8hjJU2BWysoDgYjdov/SwDLKHC9Uxw86wXDez8As7UMN8Q
	jhIi61O+Z+g5ofXj/rl2d72ThxTAnuOflhlu8aXYTzwFKJrsmToNQtnWrgoAP25b97eY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xCBCO-0005JR-Rc;
	Thu, 01 Oct 2026 07:27:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gerrit@openvpn.net>) id 1xCBBy-0005Hp-Np
 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 07:26:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=iy08qyrhj4UiH7+kb2ZfcNNFzJgi0Rap1JRP4oM9ntc=; b=QVTYmHxJU9O78vCqOwSLj6puYi
 mxGjHcH3asylKx/MVNAwvEZrGQWxwsYK9IVEHxEs+DVqAlb40gRyZkVVaKFa/xook6Q6Mo0rShM1v
 XnJ53DUxcH8Tzg6gjriIv++wWhFK0cYXBtm1/BunYOA+0Xxq20er2VyeLd/WLJh6adFU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=iy08qyrhj4UiH7+kb2ZfcNNFzJgi0Rap1JRP4oM9ntc=; b=c
 HuGu8m1/F+rz0Iu4nI0nK1irGmz5FXesfOjLZojehhAKT0dWUrLnfBOn2UAWy7iis0P97BlArQuBC
 ml5N9XkgSSAb14WW0CKb3sPVtemAWrWlPZ8DBT7ybXb7D+zjhjCa5PXqo6xGYc8zrgiR6lrSN71Tc
 Axx4eq6CKyFOu7Mw=;
Received: from mail-wr2-f12.google.com ([74.125.225.76])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCBBv-0000Pi-93 for openvpn-devel@lists.sourceforge.net;
 Thu, 01 Oct 2026 07:26:59 +0000
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351831so3598535f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 01 Oct 2026 00:26:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1790839609; x=1791444409; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iy08qyrhj4UiH7+kb2ZfcNNFzJgi0Rap1JRP4oM9ntc=;
 b=SvmLjzTMZFJa5MwbEeCJhSUIN9erkh7B0QtQ7abshZdjZz9VZfxM0QRBJmsMEy8Fok
 MEPw5rW2ZplWSFOrOCxi376KAbxaOWWjB52ACJ/5tnSH5dNC+W81ndLIsdELGJ/F5fXe
 o44KACoymSF/ouMttXhREg5uLnwyiLITlGiu5HM3Au124b9jXIPKgf8Kqc2wyB+HkvEW
 LNMliXXwfxWj/tZrGM0kOzGiJOD5FbWwWKq5VKwABkahYlAkCbYmiyHtQw9eNtFl9eh4
 tZXTHE1AsVBpoFUTW0msUuotHWqlzwbOC4yc97yEwIcEiAAT9WCEOTRNhLpyhZRGiPRO
 baxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790839609; x=1791444409;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=iy08qyrhj4UiH7+kb2ZfcNNFzJgi0Rap1JRP4oM9ntc=;
 b=efb46utSl4UnBtLOssfAX2KY8xydA3+aQbOyoh1BY11gixA3fxhkGIL0sH2oX3T0A7
 B8DFKF2JQI7c3anwhECWA1+w0wiy41OrLj/wCz6FtQxZYvLSZVcaQqhA3ZErdE22Myjw
 Z53OsZ7KDBx703Z/2MR6Ds0OARbmyVjn7h01CfMts75hnMvf1gVB+pxYeKvHrSRJD0MS
 vYa4RdvdYKcQp+/DJYVOhHwYS0C3+Rd/ussI8bMhnlEU2Kr9zl9Q26ROP84CS/LVgZn3
 YxC3N1sNjhhve01JCI7JrMyj+9MNylm8aFzdETZFLC1sFr3jMvSJyomlIZ2Bu6zVy9oD
 Nt9g==
X-Gm-Message-State: AFq9FYLqD3d1ecGcZvCPg8T7dnkbWDpgRcNE4MLOhHeVSOy00uMCV2Nq
 6AIfdT+BNkGxAhrpDa4ndZQ0A7hbniLWerZCqcfJh2n77b9EvbPS/113MsIctGFUssyYQBM/fvk
 WlnuCPUxFkt0/wc/8nwaqNuSf5I+SH8SlI8YpWGecm6RtgcUQq5B+nTedUz03sKIkuPqA
X-Gm-Gg: AYBFou0X3xeJT3eRn75gO4oqgF9m1DwPJJ1LQ4jY8LoZvsd7oc7NhRWZevmMbs4iBJX
 Kn5xdl4W39RREJHP4tUc/R1bk86rTuYPNuvnGiKBHKZPUkIM68Z58cb7saQwzvvh4gQ/TH8n/7l
 5xqVOI20Fbpc1ULBko0wJ4BXFYvpyohRVnkbA6IIE8bwNc1OmIeqMgtV9M165nt7ByEIwjsyDMI
 ntVVSK4VOMhTISeTjz2IQUXGQNKHX+GCgLJLzDZfJmbiJL+fitAnQ8lj0z5HAselu8vkxKxMnp+
 TElCGk72HYhM9laVOyEvvJonTTGW8yNrYqIredUXPitAQ+W7qvMoY1RZI8DO2dSXt8YcqtSTdqp
 3abBJXDtzZv8XRyRvS7edQJBG/LSPJxp3OtZXuSOzHfq1OHW7Q5wDVbVw+/R7Kh81+LNZIxz4io
 invLmzBqy1dd2ukTKaBOhexfdgHWepa2+/wQZiTPK1yYK50AcBPdf6WMh7d9ZIDqnyYIDRdaO4v
 RE72bGpo3xohHPybAwDtxO33axzsE3s0k0bm/1lNqYMx8RaWDa6Y59I04Vlvr0dyXXntP9JqEe8
 wfdSR3nAAtSIAXIEaR0CMvZZUaGofzKb9OeSL87qZxvIHrSce8mXvS+LGaFASw==
X-Received: by 2002:a5d:5887:0:b0:488:5535:4157 with SMTP id
 ffacd0b85a97d-48b02517a71mr7636086f8f.37.1790839608162; 
 Thu, 01 Oct 2026 00:26:48 -0700 (PDT)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b068ff6f9sm5033559f8f.7.2026.10.01.00.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 00:26:47 -0700 (PDT)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 1 Oct 2026 07:26:44 +0000
To: plaisthos <arne-openvpn@rfc2549.org>, flichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 2
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: 0e38f4a6f61321adac1b61994facdc0129ad92ca
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <6bd57f5b5e53aa4674f2ae8ca3a42d87bfc6549b-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.2
X-Headers-End: 1xCBBv-0000Pi-93
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
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4265056759758075645=="
Errors-To: openvpn-devel-bounces@lists.sourceforge.net

--===============4265056759758075645==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M01Re4nJmkQ="; charset=UTF-8

--M01Re4nJmkQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Lev Stipakov, flichtenheld, plaisthos=
=2E

Hello flichtenheld, plaisthos, 

I'd like you to reexamine a change=2E=
 Please visit

    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Dem=
ail

to look at the new patch set (#2)=2E

The following approvals got outd=
ated and were removed:
Code-Review-1 by flichtenheld


Change subject: Add =
a shared TLV codec and use it for early negotiation
=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Add a shared TLV codec and use it =
for early negotiation

Early negotiation in the reset packets is a sequence=
 of TLVs, and the
out-of-band and control data messages use the same TLV fo=
rmat and type
space=2E Add one TLV codec for all of them, control_msg=2Ec/h=
, and move
early negotiation onto it=2E

The codec only handles the framing=
: reading and writing TLV headers,
writing a 16-bit TLV, and walking a payl=
oad TLV by TLV with each value
checked against the payload=2E How to treat =
an unknown type is up to each
message=2E All TLV types are defined in contr=
ol_msg=2Eh;
TLV_TYPE_EARLY_NEG_FLAGS moves there from ssl_pkt=2Eh=2E

The b=
ytes on the wire do not change=2E Since the top bit of the type
field is th=
e "optional" flag, a TLV of type 0x8001 is now read as the
flags TLV marked=
 optional rather than skipped as unknown, so one whose
length is not 2 now =
fails the handshake as malformed=2E

Change-Id: I89c3133e009dc75dc2c10c607b=
3f0a24c04e8146
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeL=
ists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openvpn/control_msg=2Ec
A src/=
openvpn/control_msg=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M s=
rc/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/uni=
t_tests/openvpn/test_control_msg=2Ec
M tests/unit_tests/openvpn/test_pkt=2E=
c
10 files changed, 447 insertions(+), 23 deletions(-)


  git pull ssh://g=
errit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1965/2

diff --git a/CM=
akeLists=2Etxt b/CMakeLists=2Etxt
index 6eb5954=2E=2Ee1a6079f 100644
--- a/=
CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -445,6 +445,8 @@
     src/openvp=
n/console=2Ec
     src/openvpn/console_builtin=2Ec
     src/openvpn/console=
=2Eh
+    src/openvpn/control_msg=2Ec
+    src/openvpn/control_msg=2Eh
    =
 src/openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
     src/openvpn/crypto=
_backend=2Eh
@@ -883,6 +885,8 @@
 
     target_sources(test_pkt PRIVATE
   =
      tests/unit_tests/openvpn/mock_win32_execve=2Ec
+        tests/unit_te=
sts/openvpn/test_control_msg=2Ec
+        src/openvpn/control_msg=2Ec
     =
    src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
         src/openv=
pn/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Ma=
kefile=2Eam
index 7fd12b4=2E=2Ea17ae8e 100644
--- a/src/openvpn/Makefile=2E=
am
+++ b/src/openvpn/Makefile=2Eam
@@ -53,6 +53,7 @@
 	common=2Eh \
 	comp=
=2Ec comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2E=
c control_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_o=
penssl=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls_legacy=2Ec crypto_mbedtls_=
legacy=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control=
_msg=2Ec
new file mode 100644
index 0000000=2E=2Ee3e4b17
--- /dev/null
+++ =
b/src/openvpn/control_msg=2Ec
@@ -0,0 +1,85 @@
+/*
+ *  OpenVPN -- An appli=
cation to securely tunnel IP networks
+ *             over a single TCP/UDP=
 port, with support for SSL/TLS-based
+ *             session authenticatio=
n and key exchange,
+ *             packet encryption, packet authenticatio=
n, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 2002-20=
26 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software=
; you can redistribute it and/or modify
+ *  it under the terms of the GNU =
General Public License version 2
+ *  as published by the Free Software Fou=
ndation=2E
+ *
+ *  This program is distributed in the hope that it will be=
 useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty o=
f
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ * =
 GNU General Public License for more details=2E
+ *
+ *  You should have re=
ceived a copy of the GNU General Public License along
+ *  with this progra=
m; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_C=
ONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#includ=
e "control_msg=2Eh"
+
+bool
+ctrl_msg_tlv_write_header(struct buffer *buf, =
uint16_t type, bool optional, uint16_t value_len)
+{
+    /* the type has 1=
5 bits; the top bit is the optional flag */
+    ASSERT(type <=3D CTRL_MSG_=
TLV_TYPE_MASK);
+    uint16_t field =3D type;
+    if (optional)
+    {
+  =
      field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u=
16(buf, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_w=
rite_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t value)
=
+{
+    return ctrl_msg_tlv_write_header(buf, type, optional, sizeof(uint16=
_t))
+           && buf_write_u16(buf, value);
+}
+
+bool
+ctrl_msg_tlv_rea=
d_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    int f=
ield =3D buf_read_u16(buf);
+    if (field < 0)
+    {
+        return fals=
e;
+    }
+    int len =3D buf_read_u16(buf);
+    if (len < 0)
+    {
+   =
     return false;
+    }
+    hdr->type =3D (uint16_t)(field & CTRL_MSG_TL=
V_TYPE_MASK);
+    hdr->optional =3D (field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=
=3D 0;
+    hdr->value_len =3D (uint16_t)len;
+    return true;
+}
+
+bool
=
+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, str=
uct buffer *value)
+{
+    if (!ctrl_msg_tlv_read_header(buf, hdr))
+    {
=
+        return false; /* fewer than 4 bytes left: truncated header */
+   =
 }
+    /* Advance past the value; fails if buf is shorter than the header =
claims=2E */
+    const uint8_t *v =3D buf_read_alloc(buf, hdr->value_len);=

+    if (!v)
+    {
+        return false;
+    }
+    buf_set_read(value,=
 v, hdr->value_len);
+    return true;
+}
diff --git a/src/openvpn/control_=
msg=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
index 0000000=2E=
=2E7ba5f4d
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,100 @=
@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *    =
         over a single TCP/UDP port, with support for SSL/TLS-based
+ *    =
         session authentication and key exchange,
+ *             packet en=
cryption, packet authentication, and
+ *             packet compression=2E
=
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ * =
 This program is free software; you can redistribute it and/or modify
+ *  =
it under the terms of the GNU General Public License version 2
+ *  as publ=
ished by the Free Software Foundation=2E
+ *
+ *  This program is distribut=
ed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; witho=
ut even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTI=
CULAR PURPOSE=2E  See the
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
+ * type must fit in the 15 bits of the type field=2E
+ *
=
+ * @return true on success, false if buf has insufficient space=2E
+ */
+b=
ool ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optio=
nal,
+                               uint16_t value_len);
+
+/**
+ * Write =
a complete TLV whose value is a single 16-bit integer to buf=2E
+ *
+ * @re=
turn true on success, false if buf has insufficient space=2E
+ */
+bool ctr=
l_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint1=
6_t value);
+
+/**
+ * Read a TLV header from buf, advancing past it=2E
+ *=

+ * @param buf  buffer positioned at the TLV header
+ * @param hdr  filled=
 with the type, optional flag and value length on success
+ * @return true =
on success, false if there are not enough bytes for a header=2E
+ */
+bool =
ctrl_msg_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hd=
r);
+
+/**
+ * Read the next TLV from buf, advancing past its header and va=
lue=2E Call it
+ * while BLEN(buf) > 0 to walk a whole payload=2E
+ *
+ * T=
he length from the header is validated against buf, so on success the
+ * w=
hole value is present: a header claiming more bytes than buf holds is
+ * r=
ejected=2E
+ *
+ * @param buf    buffer positioned at a TLV header
+ * @par=
am hdr    filled with the TLV's type, optional flag and value length
+ * @p=
aram value  set to a buffer covering exactly the TLV's value; it points
+ *=
               into buf and owns no storage
+ * @return true on success, fa=
lse if the header or the value is truncated; buf
+ *         may then be le=
ft partly consumed=2E
+ */
+bool ctrl_msg_tlv_next(struct buffer *buf, stru=
ct ctrl_msg_tlv_header *hdr, struct buffer *value);
+
+#endif /* ifndef CON=
TROL_MSG_H */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index =
76150d4=2E=2E92f1991 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=
=2Ec
@@ -52,6 +52,7 @@
 #include "pkcs11=2Eh"
 #include "route=2Eh"
 #inclu=
de "tls_crypt=2Eh"
+#include "control_msg=2Eh"
 
 #include "crypto_epoch=2E=
h"
 #include "ssl=2Eh"
@@ -2595,26 +2596,21 @@
 {
     while (buf->len > 0)=

     {
-        if (buf_len(buf) < 4)
-        {
-            goto error;
=
-        }
-        /* read type */
-        int type =3D buf_read_u16(buf)=
;
-        int len =3D buf_read_u16(buf);
-        if (type < 0 || len < 0 =
|| buf_len(buf) < len)
+        struct ctrl_msg_tlv_header hdr;
+        st=
ruct buffer value;
+        if (!ctrl_msg_tlv_next(buf, &hdr, &value))
    =
     {
             goto error;
         }
 
-        switch (type)
+      =
  switch (hdr=2Etype)
         {
             case TLV_TYPE_EARLY_NEG_FLAGS=
:
-                if (len !=3D sizeof(uint16_t))
+                if (BLEN=
(&value) !=3D sizeof(uint16_t))
                 {
                     got=
o error;
                 }
-                int flags =3D buf_read_u16(buf=
);
+                int flags =3D buf_read_u16(&value);
 
                 =
if (flags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
@@ -2623,8 +2619,=
8 @@
                 break;
 
             default:
-                /* Sk=
ip types we do not parse */
-                buf_advance(buf, len);
+      =
          /* Skip types we do not parse, marked optional or not */
+       =
         break;
         }
     }
     reliable_mark_deleted(ks->rec_reliab=
le, buf);
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
in=
dex 90b2aec=2E=2E405e5b4 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/ope=
nvpn/ssl_pkt=2Ec
@@ -33,6 +33,7 @@
 #include "reliable=2Eh"
 #include "siph=
ash=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_msg=2Eh"
 
 /*
  * De=
pendent on hmac size, opcode size, and session_id size=2E
@@ -431,9 +432,8 =
@@
     /* Add indication for tls-crypt-v2 to resend the WKc with the reply=
 */
     if (request_resend_wkc)
     {
-        buf_write_u16(&buf, TLV_TY=
PE_EARLY_NEG_FLAGS); /* TYPE: flags */
-        buf_write_u16(&buf, sizeof(=
uint16_t));
-        buf_write_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
+     =
   ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+  =
                                    EARLY_NEG_FLAG_RESEND_WKC));
     }
 
 =
    /* Add tls-auth/tls-crypt wrapping, this might replace buf with
diff --=
git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 03e8930=2E=2E=
5a1d194 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
=
@@ -305,10 +305,8 @@
 #define EARLY_NEG_START 0x0f000000
 
 
-/* Early nego=
tiation that part of the server response in the RESET_V2 packet=2E
- * Sinc=
e clients that announce early negotiation support will treat the payload
- =
* of reset packets special and parse it as TLV messages=2E
- * as TLV (type=
, length, value) */
-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001
+/* Early neg=
otiation: clients that announce support for it parse the payload of
+ * the=
 reset packets as TLVs (see control_msg=2Eh)=2E Flags carried in the value =
of
+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #define EARLY_NEG_FLAG_RESEND_=
WKC 0x0001
 #endif /* ifndef SSL_PKT_H */
diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 5954902=
=2E=2Ed9caa03 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tes=
ts/unit_tests/openvpn/Makefile=2Eam
@@ -157,10 +157,12 @@
 	-I$(top_srcdir)=
/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_C=
FLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOURCES =
=3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_commo=
n=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec test_control_msg=2Ec mock_=
msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
+	test_common=2Eh \
 	$(top_sr=
cdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(t=
op_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/control_msg=
=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn=
/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
diff -=
-git a/tests/unit_tests/openvpn/test_control_msg=2Ec b/tests/unit_tests/ope=
nvpn/test_control_msg=2Ec
new file mode 100644
index 0000000=2E=2Eea0ae0d
-=
-- /dev/null
+++ b/tests/unit_tests/openvpn/test_control_msg=2Ec
@@ -0,0 +1=
,192 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based
+=
 *             session authentication and key exchange,
+ *             pac=
ket encryption, packet authentication, and
+ *             packet compressi=
on=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ =
*
+ *  This program is free software; you can redistribute it and/or modify=

+ *  it under the terms of the GNU General Public License version 2
+ *  a=
s published by the Free Software Foundation=2E
+ *
+ *  This program is dis=
tributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY;=
 without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more de=
tails=2E
+ *
+ *  You should have received a copy of the GNU General Public=
 License along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg=
/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
=
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <stddef=2Eh>
+=
#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "control_msg=2Eh"
=
+#include "ssl_pkt=2Eh"
+#include "test_common=2Eh"
+
+/* The early negotia=
tion flags TLV of a reset packet asking a tls-crypt-v2
+ * client to resend=
 its WKc, as older versions wrote it by hand=2E */
+static void
+test_tlv_w=
rite_u16_wire_format(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_=
msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+                 =
                      EARLY_NEG_FLAG_RESEND_WKC));
+    const uint8_t expec=
ted[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLE=
N(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, =
sizeof(expected));
+
+    /* the optional flag is the most significant bit =
of the type field */
+    buf_clear(&buf);
+    assert_true(ctrl_msg_tlv_wr=
ite_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));
+    assert_int_equal(BP=
TR(&buf)[0], 0x80);
+    assert_int_equal(BPTR(&buf)[1], 0x01);
+
+    gc_f=
ree(&gc);
+}
+
+/* A TLV header survives the round trip, the optional flag =
kept apart from
+ * the 15-bit type=2E */
+static void
+test_tlv_header_rou=
ndtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct b=
uffer buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_=
header(&buf, 0x1234, true, 5));
+    assert_int_equal(BLEN(&buf), 4);
+
+  =
  struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_read_header=
(&buf, &hdr));
+    assert_int_equal(hdr=2Etype, 0x1234);
+    assert_true(=
hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, 5);
+    assert_int=
_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* Walking a payload retu=
rns each TLV in turn, with a value covering exactly
+ * its bytes, and cons=
umes the payload=2E */
+static void
+test_tlv_next_walks_payload(void **sta=
te)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D all=
oc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYP=
E_EARLY_NEG_FLAGS, false, 0xabcd));
+    assert_true(ctrl_msg_tlv_write_hea=
der(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0x11223344=
));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x5, false, 0)); /* em=
pty value */
+
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer valu=
e;
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_i=
nt_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_false(hdr=2Eopt=
ional);
+    assert_int_equal(BLEN(&value), 2);
+    assert_int_equal(buf_r=
ead_u16(&value), 0xabcd);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, =
&value));
+    assert_int_equal(hdr=2Etype, 0x7ff);
+    assert_true(hdr=2E=
optional);
+    assert_int_equal(BLEN(&value), 4);
+    assert_int_equal(bu=
f_read_u32(&value, NULL), 0x11223344);
+
+    assert_true(ctrl_msg_tlv_next=
(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, 0x5);
+    assert_=
int_equal(BLEN(&value), 0);
+
+    assert_int_equal(BLEN(&buf), 0);
+
+    =
gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than the payl=
oad holds is rejected,
+ * rather than read past the end of the payload=2E =
*/
+static void
+test_tlv_next_value_truncated(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(64, &gc)=
;
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLA=
GS, false, 8));
+    assert_true(buf_write_u32(&buf, 0));
+
+    struct ctr=
l_msg_tlv_header hdr;
+    struct buffer value;
+    assert_false(ctrl_msg_=
tlv_next(&buf, &hdr, &value));
+
+    gc_free(&gc);
+}
+
+/* Reading a TLV =
header must fail when the buffer holds less data than a
+ * complete 4-byte=
 header, rather than read past the available data=2E */
+static void
+test_=
tlv_header_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    const uint8_t bytes[] =3D { 0x00, 0x01, 0x00 };
+
+    /* 0 to 3 byte=
s: none, part of the type field, the type field, and the type
+     * field=
 with half of the length */
+    for (size_t n =3D 0; n <=3D sizeof(bytes);=
 n++)
+    {
+        struct buffer buf =3D alloc_buf_gc(16, &gc);
+       =
 assert_true(buf_write(&buf, bytes, n));
+        struct buffer copy =3D bu=
f;
+
+        struct ctrl_msg_tlv_header hdr;
+        struct buffer value;=

+        assert_false(ctrl_msg_tlv_read_header(&buf, &hdr));
+        asse=
rt_false(ctrl_msg_tlv_next(&copy, &hdr, &value));
+    }
+
+    gc_free(&gc=
);
+}
+
+/* Writing fails, rather than writes a partial TLV, when buf is to=
o small=2E */
+static void
+test_tlv_write_no_room(void **state)
+{
+    st=
ruct gc_arena gc =3D gc_new();
+
+    struct buffer buf =3D alloc_buf_gc(3,=
 &gc);
+    assert_false(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG=
_FLAGS, false, 2));
+
+    /* room for the header but not the value */
+   =
 buf =3D alloc_buf_gc(5, &gc);
+    assert_false(ctrl_msg_tlv_write_u16(&bu=
f, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));
+
+    gc_free(&gc);
+}
+
+/* The =
TLV codec tests run as a group of pkt_testdriver; see test_pkt=2Ec=2E */
+i=
nt
+run_control_msg_tests(void)
+{
+    const struct CMUnitTest tests[] =3D=
 {
+        cmocka_unit_test(test_tlv_write_u16_wire_format),
+        cmoc=
ka_unit_test(test_tlv_header_roundtrip),
+        cmocka_unit_test(test_tlv=
_next_walks_payload),
+        cmocka_unit_test(test_tlv_next_value_truncat=
ed),
+        cmocka_unit_test(test_tlv_header_truncated),
+        cmocka_=
unit_test(test_tlv_write_no_room),
+    };
+
+    return cmocka_run_group_t=
ests_name("control message TLV tests", tests, NULL, NULL);
+}
diff --git a/=
tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=
=2Ec
index a732c2b=2E=2E9ce9c50 100644
--- a/tests/unit_tests/openvpn/test_=
pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -37,6 +37,7 @@
 #inc=
lude "crypto=2Eh"
 #include "options=2Eh"
 #include "ssl_backend=2Eh"
+#inc=
lude "control_msg=2Eh"
 #include "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
=
@@ -44,6 +45,8 @@
 #include "reliable=2Eh"
 #include "siphash=2Eh"
 
+int r=
un_control_msg_tests(void); /* test_control_msg=2Ec */
+
 int
 parse_line(c=
onst char *line, char **p, const int n, const char *file, const int line_nu=
m,
            msglvl_t msglevel, struct gc_arena *gc)
@@ -654,6 +657,46 @@=

     free_buf(&tas=2Eworkbuf);
 }
 
+/* A reset reply asking a tls-crypt-v=
2 client to resend its WKc ends in the
+ * early negotiation flags TLV, the=
 bytes older versions wrote by hand, and the
+ * TLV parses back=2E */
+sta=
tic void
+test_generate_reset_packet_resend_wkc(void **ut_state)
+{
+    st=
ruct tls_auth_standalone tas =3D { 0 };
+
+    struct session_id client_id =
=3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };
+    struct session_id server_id =3D { =
{ 8, 9, 0, 9, 8, 7, 6, 2 } };
+
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NON=
E;
+    struct frame frame =3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epaylo=
ad_size =3D 1400 }, 0 };
+    tas=2Eframe =3D frame;
+    tas=2Eworkbuf =3D=
 alloc_buf(1600);
+
+    uint8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERVE=
R_V2 << P_OPCODE_SHIFT);
+
+    struct buffer plain =3D
+        tls_reset_=
standalone(&tas=2Etls_wrap, &tas, &client_id, &server_id, header, false);
+=
    const int plain_len =3D BLEN(&plain);
+    struct buffer buf =3D
+     =
   tls_reset_standalone(&tas=2Etls_wrap, &tas, &client_id, &server_id, head=
er, true);
+
+    const uint8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0=
x01 };
+    assert_int_equal(BLEN(&buf), plain_len + (int)sizeof(tlv));
+  =
  assert_memory_equal(BPTR(&buf) + plain_len, tlv, sizeof(tlv));
+
+    str=
uct buffer payload =3D buf;
+    assert_true(buf_advance(&payload, plain_le=
n));
+    struct ctrl_msg_tlv_header hdr;
+    struct buffer value;
+    as=
sert_true(ctrl_msg_tlv_next(&payload, &hdr, &value));
+    assert_int_equal=
(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_int_equal(buf_read_u16(=
&value), EARLY_NEG_FLAG_RESEND_WKC);
+    assert_int_equal(BLEN(&payload), =
0);
+
+    free_buf(&tas=2Eworkbuf);
+}
+
 static void
 test_generate_reset=
_packet_tls_auth(void **ut_state)
 {
@@ -744,9 +787,12 @@
         cmocka_u=
nit_test(test_verify_hmac_tls_auth),
         cmocka_unit_test(test_verify_=
hmac_none_out_of_range_ack),
         cmocka_unit_test(test_generate_reset_=
packet_plain),
+        cmocka_unit_test(test_generate_reset_packet_resend_=
wkc),
         cmocka_unit_test(test_generate_reset_packet_tls_auth),
     =
    cmocka_unit_test(test_extract_control_message)
     };
 
-    return cm=
ocka_run_group_tests_name("pkt tests", tests, NULL, NULL);
+    int failed =
=3D cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);
+    faile=
d +=3D run_control_msg_tests();
+    return failed ? 1 : 0;
 }

-- 
To view=
, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsu=
bscribe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=
=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project=
: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c10c60=
7b3f0a24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 2
Gerrit-Owner=
: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: flichtenheld <frank=
@lichtenheld=2Ecom>
Gerrit-Reviewer: plaisthos <arne-openvpn@rfc2549=2Eorg>=

Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-=
Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: plaisthos=
 <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: flichtenheld <frank@lichten=
held=2Ecom>

--M01Re4nJmkQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Lev Stipakov, flichtenheld, plaisthos=2E </p>
<p>Lev =
Stipakov <strong>uploaded patch set #2</strong> to this change=2E</p><p><a =
href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code=
-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">Add a shared TLV codec and use i=
t for early negotiation<br><br>Early negotiation in the reset packets is a =
sequence of TLVs, and the<br>out-of-band and control data messages use the =
same TLV format and type<br>space=2E Add one TLV codec for all of them, con=
trol_msg=2Ec/h, and move<br>early negotiation onto it=2E<br><br>The codec o=
nly handles the framing: reading and writing TLV headers,<br>writing a 16-b=
it TLV, and walking a payload TLV by TLV with each value<br>checked against=
 the payload=2E How to treat an unknown type is up to each<br>message=2E Al=
l TLV types are defined in control_msg=2Eh;<br>TLV_TYPE_EARLY_NEG_FLAGS mov=
es there from ssl_pkt=2Eh=2E<br><br>The bytes on the wire do not change=2E =
Since the top bit of the type<br>field is the &quot;optional&quot; flag, a =
TLV of type 0x8001 is now read as the<br>flags TLV marked optional rather t=
han skipped as unknown, so one whose<br>length is not 2 now fails the hands=
hake as malformed=2E<br><br>Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04=
e8146<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M =
CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_ms=
g=2Ec<br>A src/openvpn/control_msg=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/op=
envpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvp=
n/Makefile=2Eam<br>A tests/unit_tests/openvpn/test_control_msg=2Ec<br>M tes=
ts/unit_tests/openvpn/test_pkt=2Ec<br>10 files changed, 447 insertions(+), =
23 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=
=2Enet:29418/openvpn refs/changes/65/1965/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=
=2Etxt b/CMakeLists=2Etxt</span><br><span>index 6eb5954=2E=2Ee1a6079f 10064=
4</span><br><span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=
=2Etxt</span><br><span>@@ -445,6 +445,8 @@</span><br><span>     src/openvpn=
/console=2Ec</span><br><span>     src/openvpn/console_builtin=2Ec</span><br=
><span>     src/openvpn/console=2Eh</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    src/openvpn/control_msg=2Ec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Eh</span><br><span=
>     src/openvpn/crypto=2Ec</span><br><span>     src/openvpn/crypto=2Eh</s=
pan><br><span>     src/openvpn/crypto_backend=2Eh</span><br><span>@@ -883,6=
 +885,8 @@</span><br><span> </span><br><span>     target_sources(test_pkt P=
RIVATE</span><br><span>         tests/unit_tests/openvpn/mock_win32_execve=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/u=
nit_tests/openvpn/test_control_msg=2Ec</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        src/openvpn/control_msg=2Ec</span><br><span>    =
     src/openvpn/argv=2Ec</span><br><span>         src/openvpn/base64=2Ec</=
span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><span>diff -=
-git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</span><br><spa=
n>index 7fd12b4=2E=2Ea17ae8e 100644</span><br><span>--- a/src/openvpn/Makef=
ile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><br><span>@@=
 -53,6 +53,7 @@</span><br><span> 	common=2Eh \</span><br><span> 	comp=2Ec c=
omp=2Eh compstub=2Ec \</span><br><span> 	comp-lz4=2Ec comp-lz4=2Eh \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	control_msg=2Ec control_m=
sg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \</span=
><br><span> 	crypto_openssl=2Ec crypto_openssl=2Eh \</span><br><span> 	cryp=
to_mbedtls_legacy=2Ec crypto_mbedtls_legacy=2Eh \</span><br><span>diff --gi=
t a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><br><sp=
an>new file mode 100644</span><br><span>index 0000000=2E=2Ee3e4b17</span><b=
r><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=2Ec</sp=
an><br><span>@@ -0,0 +1,85 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port=
, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             session authentication and key exchange,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encr=
yption, packet authentication, and</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet compression=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=
=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free s=
oftware; you can redistribute it and/or modify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public=
 License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  as published by the Free Software Foundation=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is distributed in the hope that it will be u=
seful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHO=
UT ANY WARRANTY; without even the implied warranty of</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PART=
ICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  GNU General Public License for more details=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  You should have received a copy of the GNU General=
 Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&=
gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_wr=
ite_header(struct buffer *buf, uint16_t type, bool optional, uint16_t value=
_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /* the type has 15 bits; the=
 top bit is the optional flag */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    ASSERT(type &lt;=3D CTRL_MSG_TLV_TYPE_MASK);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D type;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (optional)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        field |=3D CTRL_MSG_TLV_OPTIONAL=
_FLAG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16(bu=
f, field) &amp;&amp; buf_write_u16(buf, value_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_write=
_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t value)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf,=
 type, optional, sizeof(uint16_t))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, value);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg=
_tlv_read_header(struct buffer *buf, struct ctrl_msg_tlv_header *hdr)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int field =3D buf_read_u16(buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (field &lt; 0)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int len =3D buf_read_u16(buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (len &lt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    hdr-&gt;type =3D (uint16_t)(field &amp; CTRL_MSG_TLV_TY=
PE_MASK);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&g=
t;optional =3D (field &amp; CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint=
16_t)len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header =
*hdr, struct buffer *value)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!c=
trl_msg_tlv_read_header(buf, hdr))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return false; /* fewer than 4 bytes left: truncated header */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* Advance past the value; fails i=
f buf is shorter than the header claims=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const uint8_t *v =3D buf_read_alloc(buf, hdr-=
&gt;value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!v)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(value, v, hdr-&gt;val=
ue_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><s=
pan>diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh<=
/span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2E7ba=
5f4d</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/contro=
l_msg=2Eh</span><br><span>@@ -0,0 +1,100 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             session authentication and key ex=
change,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet encryption, packet authentication, and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sa=
les@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progra=
m is free software; you can redistribute it and/or modify</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gen=
eral Public License version 2</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that i=
t will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  GNU General Public License for more details=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of th=
e GNU General Public License along</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eo=
rg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * TLV framing shared by the TLV-based control messages of the=
 wire protocol=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Such a message p=
ayload is a sequence of TLV entries=2E Each TLV starts with a</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * 4-byte header: a 16-bit field =
whose most significant bit is the &quot;optional&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * flag and whose remaining 15 bits are =
the type, followed by a 16-bit length</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * giving the size of the value that follows the header=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * All of these messages share on=
e TLV type space, so the TLV types are all</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * defined here=2E Only the framing is handled here:=
 what a message does with a</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * TLV type it does not know, marked optional or not, is up to its =
parser=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* TLV types */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the =
reset packets */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* TLV header bit layo=
ut of the first 16-bit field */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* The header every TLV carries: the 1=
5-bit type and optional flag packed into</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * the first 16-bit field, then the length of the valu=
e that follows=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct ctrl_msg_tlv_header</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16=
_t type;      /**&lt; the 15-bit TLV type */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool optional;      /**&lt; value of the optio=
nal flag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
16_t value_len; /**&lt; length of the value following the header */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * W=
rite a TLV header (type + optional flag + value length) to buf=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * type must fit in the 15 bi=
ts of the type field=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return tr=
ue on success, false if buf has insufficient space=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool ctrl_msg_tlv_write_header(struct buffer *buf, uint16=
_t type, bool optional,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                               uint16_t value_len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Write a complete TLV whose value is a single 16-bit integer to buf=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if b=
uf has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ct=
rl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint=
16_t value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Read a TLV header from buf, advancing =
past it=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf  buffer posi=
tioned at the TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param hdr  filled with the type, optional flag and value length on=
 success</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return =
true on success, false if there are not enough bytes for a header=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_read_header(struct buff=
er *buf, struct ctrl_msg_tlv_header *hdr);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read the =
next TLV from buf, advancing past its header and value=2E Call it</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * while BLEN(buf) &gt; 0 to =
walk a whole payload=2E</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The length=
 from the header is validated against buf, so on success the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * whole value is present: a heade=
r claiming more bytes than buf holds is</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * rejected=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param buf    buffer positioned at a TLV header</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param hdr    filled with the TLV&#39;s typ=
e, optional flag and value length</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param value  set to a buffer covering exactly the TLV&#39=
;s value; it points</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *               into buf and owns no storage</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return true on success, false if the header o=
r the value is truncated; buf</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *         may then be left partly consumed=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl=
_msg_tlv_header *hdr, struct buffer *value);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#endif /* ifndef CONTROL_MSG_H */</span><br><span>diff --git a/src/op=
envpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 76150d4=2E=2E92f1=
991 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/=
src/openvpn/ssl=2Ec</span><br><span>@@ -52,6 +52,7 @@</span><br><span> #inc=
lude &quot;pkcs11=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;=
</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</spa=
n><br><span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span>=
<br><span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -2595,26 +2596,2=
1 @@</span><br><span> {</span><br><span>     while (buf-&gt;len &gt; 0)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (buf_len(buf) &lt; 4)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* re=
ad type */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int=
 type =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        int len =3D buf_read_u16(buf);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (type &lt; 0 || len &lt; 0 || buf_len(bu=
f) &lt; len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        struct buffer value;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_next(buf, &amp;hdr, &amp;va=
lue))</span><br><span>         {</span><br><span>             goto error;</=
span><br><span>         }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        switch (type)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        switch (hdr=2Etype)</span><br><span>       =
  {</span><br><span>             case TLV_TYPE_EARLY_NEG_FLAGS:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                if (len !=3D size=
of(uint16_t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          if (BLEN(&amp;value) !=3D sizeof(uint16_t))</span><br><span>     =
            {</span><br><span>                     goto error;</span><br><s=
pan>                 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                int flags =3D buf_read_u16(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                int flags =3D buf_read_u16(&a=
mp;value);</span><br><span> </span><br><span>                 if (flags &am=
p; EARLY_NEG_FLAG_RESEND_WKC)</span><br><span>                 {</span><br>=
<span>@@ -2623,8 +2619,8 @@</span><br><span>                 break;</span><=
br><span> </span><br><span>             default:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                /* Skip types we do not parse */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_a=
dvance(buf, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              /* Skip types we do not parse, marked optional or not */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                break;</=
span><br><span>         }</span><br><span>     }</span><br><span>     relia=
ble_mark_deleted(ks-&gt;rec_reliable, buf);</span><br><span>diff --git a/sr=
c/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 90b2a=
ec=2E=2E405e5b4 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span>=
<br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -33,6 +33,7 @@</=
span><br><span> #include &quot;reliable=2Eh&quot;</span><br><span> #include=
 &quot;siphash=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;con=
trol_msg=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><span>  =
* Dependent on hmac size, opcode size, and session_id size=2E</span><br><sp=
an>@@ -431,9 +432,8 @@</span><br><span>     /* Add indication for tls-crypt=
-v2 to resend the WKc with the reply */</span><br><span>     if (request_re=
send_wkc)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        buf_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TY=
PE: flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        b=
uf_write_u16(&amp;buf, sizeof(uint16_t));</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        buf_write_u16(&amp;buf, EARLY_NEG_FLAG_RESEND_W=
KC);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(=
ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
         EARLY_NEG_FLAG_RESEND_WKC));</span><br><span>     }</span><br><spa=
n> </span><br><span>     /* Add tls-auth/tls-crypt wrapping, this might rep=
lace buf with</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/op=
envpn/ssl_pkt=2Eh</span><br><span>index 03e8930=2E=2E5a1d194 100644</span><=
br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ss=
l_pkt=2Eh</span><br><span>@@ -305,10 +305,8 @@</span><br><span> #define EAR=
LY_NEG_START 0x0f000000</span><br><span> </span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-/* Early negotiation that part of the=
 server response in the RESET_V2 packet=2E</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">- * Since clients that announce early negotiation suppo=
rt will treat the payload</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * of reset packets special and parse it as TLV messages=2E</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * as TLV (type, length, value) *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TLV_TYPE_EAR=
LY_NEG_FLAGS  0x0001</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Early negotiation: clients that announce support for it parse the paylo=
ad of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the reset p=
ackets as TLVs (see control_msg=2Eh)=2E Flags carried in the value of</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the TLV_TYPE_EARLY_NEG=
_FLAGS TLV: */</span><br><span> #define EARLY_NEG_FLAG_RESEND_WKC 0x0001</s=
pan><br><span> #endif /* ifndef SSL_PKT_H */</span><br><span>diff --git a/t=
ests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=
=2Eam</span><br><span>index 5954902=2E=2Ed9caa03 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile=2Eam</span><br><span>@@ -157,10 +157,12 @@</span><br=
><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)=
/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span> pkt_testdri=
ver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh =
mock_win32_execve=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+pkt_testdriver_SOURCES =3D test_pkt=2Ec test_control_ms=
g=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	test_common=2Eh \</span><br><span> 	$(=
top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcdir)/src/open=
vpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/op=
envpn/control_msg=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=
=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span=
><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span=
>diff --git a/tests/unit_tests/openvpn/test_control_msg=2Ec b/tests/unit_te=
sts/openvpn/test_control_msg=2Ec</span><br><span>new file mode 100644</span=
><br><span>index 0000000=2E=2Eea0ae0d</span><br><span>--- /dev/null</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><spa=
n>@@ -0,0 +1,192 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
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
 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;syshead=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
lt;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
nclude &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;setjmp=2Eh&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;ssl_pkt=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* The early negotiation flags TLV of a r=
eset packet asking a tls-crypt-v2</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * client to resend its WKc, as older versions wrote it by ha=
nd=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_u16_=
wire_format(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYP=
E_EARLY_NEG_FLAGS, false,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                       EARLY_NEG_FLAG_RESEND_WKC));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t exp=
ected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), size=
of(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_memory_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* the optional flag is the most significant b=
it of the type field */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    buf_clear(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NE=
G_FLAGS, true, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(BPTR(&amp;buf)[0], 0x80);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[1], 0x01);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* A TLV header survives the round trip, the optional flag kept apart from<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the 15-bit type=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_round=
trip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x1234, tru=
e, 5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(BLEN(&amp;buf), 4);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Etype, 0x1234);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(hdr=2Evalue_len, 5);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Walking a payload returns each TLV in turn, with a value covering exact=
ly</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its bytes, and=
 consumes the payload=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_tlv_next_walks_payload(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(64, &amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&=
amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header=
(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(buf_write_u32(&amp;buf, 0x11223344));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_wri=
te_header(&amp;buf, 0x5, false, 0)); /* empty value */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &=
amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&=
amp;value), 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(buf_read_u16(&amp;value), 0xabcd);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;v=
alue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(hdr=2Etype, 0x7ff);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(hdr=2Eoptional);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 4);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_read_=
u32(&amp;value, NULL), 0x11223344);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etyp=
e, 0x5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(BLEN(&amp;value), 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* A TLV header claiming more value byte=
s than the payload holds is rejected,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * rather than read past the end of the payload=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_next_value_truncated(v=
oid **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_=
NEG_FLAGS, false, 8));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_next(&amp;buf, =
&amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* Reading a TLV header must fail when the buffer =
holds less data than a</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * complete 4-byte header, rather than read past the available data=2E *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_header_truncated(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst uint8_t bytes[] =3D { 0x00, 0x01, 0x00 };</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* 0 to 3 bytes: none, part of the type field, the type field, a=
nd the type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * f=
ield with half of the length */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    for (size_t n =3D 0; n &lt;=3D sizeof(bytes); n++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer buf =3D alloc_buf_g=
c(16, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    assert_true(buf_write(&amp;buf, bytes, n));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer copy =3D buf;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header hdr;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer value;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_false(=
ctrl_msg_tlv_read_header(&amp;buf, &amp;hdr));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert_false(ctrl_msg_tlv_next(&amp;copy=
, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* Writing fails, rather than writes a partial TLV, when buf=
 is too small=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv=
_write_no_room(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
buffer buf =3D alloc_buf_gc(3, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_write_header(&amp;buf, T=
LV_TYPE_EARLY_NEG_FLAGS, false, 2));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /* room for the header but not the value */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_w=
rite_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The TLV codec =
tests run as a group of pkt_testdriver; see test_pkt=2Ec=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+run_control_msg_tests(void)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_wr=
ite_u16_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_tlv_header_roundtrip),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_next_w=
alks_payload),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_tlv_next_value_truncated),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_=
truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_tlv_write_no_room),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 cmocka_run_group_tests_name(&quot;control message TLV tests&quot;, tests, =
NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_=
tests/openvpn/test_pkt=2Ec</span><br><span>index a732c2b=2E=2E9ce9c50 10064=
4</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -37,6 +37=
,7 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #in=
clude &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backend=
=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;control_msg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quo=
t;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> </s=
pan><br><span>@@ -44,6 +45,8 @@</span><br><span> #include &quot;reliable=2E=
h&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int run_control_msg=
_tests(void); /* test_control_msg=2Ec */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> int</span><br><span> parse_line(cons=
t char *line, char **p, const int n, const char *file, const int line_num,<=
/span><br><span>            msglvl_t msglevel, struct gc_arena *gc)</span><=
br><span>@@ -654,6 +657,46 @@</span><br><span>     free_buf(&amp;tas=2Ework=
buf);</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/* A reset reply asking a tls-crypt-v2 client to res=
end its WKc ends in the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * early negotiation flags TLV, the bytes older versions wrote by hand,=
 and the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV pars=
es back=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_generate_=
reset_packet_resend_wkc(void **ut_state)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct tls_auth_standalone tas =3D { 0 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct sessio=
n_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =
=3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    tas=2Eworkbuf =3D alloc_=
buf(1600);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D 0 | (=
P_CONTROL_HARD_RESET_SERVER_V2 &lt;&lt; P_OPCODE_SHIFT);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer plain =3D</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tls_reset_standalone(&amp;tas=2Etls_wrap,=
 &amp;tas, &amp;client_id, &amp;server_id, header, false);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const int plain_len =3D BLEN(&am=
p;plain);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 buffer buf =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;client_id, &am=
p;server_id, header, true);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const u=
int8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), p=
lain_len + (int)sizeof(tlv));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_memory_equal(BPTR(&amp;buf) + plain_len, tlv, sizeof(t=
lv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D buf=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(bu=
f_advance(&amp;payload, plain_len));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&a=
mp;payload, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(buf_read_u16(&amp;value), EARLY_NEG_FLAG_RESEND_WKC);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;payload)=
, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas=2Eworkbuf);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><=
br><span> test_generate_reset_packet_tls_auth(void **ut_state)</span><br><s=
pan> {</span><br><span>@@ -744,9 +787,12 @@</span><br><span>         cmocka=
_unit_test(test_verify_hmac_tls_auth),</span><br><span>         cmocka_unit=
_test(test_verify_hmac_none_out_of_range_ack),</span><br><span>         cmo=
cka_unit_test(test_generate_reset_packet_plain),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_generate_reset_p=
acket_resend_wkc),</span><br><span>         cmocka_unit_test(test_generate_=
reset_packet_tls_auth),</span><br><span>         cmocka_unit_test(test_extr=
act_control_message)</span><br><span>     };</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    return cmocka_run_group_tests_=
name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int failed =3D cmocka_run_group_tests_name(=
&quot;pkt tests&quot;, tests, NULL, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    failed +=3D run_control_msg_tests();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return failed ? 1 : 0;</spa=
n><br><span> }</span><br></pre><p>To view, visit <a href=3D"https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"https://gerrit=2E=
openvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div itemscope itemt=
ype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D=
"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:no=
ne"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Ge=
rrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: ma=
ster </div>
<div style=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75=
dc2c10c607b3f0a24c04e8146 </div>
<div style=3D"display:none"> Gerrit-Change=
-Number: 1965 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>=

<div style=3D"display:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmai=
l=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenhe=
ld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerr=
it-Reviewer: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourc=
eforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Lev =
Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none"> =
Gerrit-Attention: plaisthos &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div =
style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--M01Re4nJmkQ=--


--===============4265056759758075645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4265056759758075645==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4265056759758075645==--

