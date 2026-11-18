Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF25606A31C
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XHCkmbiW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fXM6IVkr;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XpYEBVZk;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=YrWv9rS0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=oBFk3Z1G3FP4r/l1DwOdtvBXMI+q129AFXr+6gBYf/M=; b=XHCkmbiWyr7FfwFcG0IBnQdqpX
	FQgBv4hh+QV46g12P5FBkk1pM//3Pzl4Bw1/O1TUYLo3AxFbdUKiqFVKYqqmTJ0PPwa8KcfU/oWvx
	rubjke9eKAjmrHRUMLTeehuaQnXErw5UWMymDT1ixlTBW1OaVB+hRFJQCqwibFLBKgec=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiKC-000000001lS-3xC2;
	Wed, 18 Nov 2026 16:15:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTiKB-000000001lM-3ezC
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OsOe6ZK4TBP7Ik12SG9cDMdIt3QBp+nasMSUDcPvNRk=; b=fXM6IVkrtdq4PvqOQz7y/TSF06
 kysYPxp1JiHho7AGb8Erndt8WdJVF/sjx/Q5ZYEFT/qkMQXe01nOC4eoAzwwl5RkL14498zT17dzN
 y4qPSn3U4H14dgNregfcj34R8c28a+sk8Y9zr8RYHlMOorTT4VMYjHYlhKrscZXzxyqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OsOe6ZK4TBP7Ik12SG9cDMdIt3QBp+nasMSUDcPvNRk=; b=XpYEBVZkUoc+PDf+21z4OKSsUq
 iOJPzI16GWND0Wg7RK2XcxAiK9qkoEemMvbTRgLdrHzuVrRoVQdheEQvi4YQQLNil06y5cU8GBus4
 LFxveKQqVGVenQlE5/MJ93yUs3qQZNELDURz5Szk6+e+q1pEJufWiLaAlzwsZrxUAPxM=;
Received: from mail-wr1-f54.google.com ([209.85.221.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTiK7-000000003fX-2kou for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:15:55 +0000
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-4a68190a2a7so998457f8f.1
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 08:15:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795018545; x=1795623345; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=OsOe6ZK4TBP7Ik12SG9cDMdIt3QBp+nasMSUDcPvNRk=;
 b=YrWv9rS0LTqJnShEi6h8Qx7rGU2m4nsRW20Diti3vbnzcDVXJPdD+FVfieP09lwRxv
 fzU5WL9Narniw7SZ3mAKxfmLb5H5bEBe9T/EWMTXhc9c0khIG043cQLrnzHsw6Y7I4b4
 9BiHgLZUalLEBquAUEvgrk94X0t9MyAtKWnvQMy2tMmnnfPpc95LkBwuGpBxICJ3jyXm
 KZjT5dUO7zjHE8BT7L5Ud0yt1o91FvuyTjJRLjFUcJfw4MUjaa7o39ECERRya68b36Rd
 oOyiMB5Vc5uMnCcID1W6NDYCTYE3w2FUy0FvgpFTy4NPx2Rhx4sYiJO7FwLBfcIiH7ky
 ejoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018545; x=1795623345;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=OsOe6ZK4TBP7Ik12SG9cDMdIt3QBp+nasMSUDcPvNRk=;
 b=wcRnZ3a7l6hOWOsajyFrVY6iztLqYCwXzManmF+cP/Tv8jg1SXtx1HBB005k+kxVll
 1MIGuxfbxVtGwYTYRGpsIsvEgEYm29vuXE+n8G9ZWSMOVal2dQu7IxsotnTksejvzFmr
 ufXPOWB/J26dsE9+RF6OauToidIdJcIYdkpsjF0qHWD/KHrrSYlsMlPcJePeXEVAxmol
 /xmeakhJTN93fd6mALDEWZx0ujkWFweId8FF3rT/gNXZqpvSrAiiBdW+82SOFm630vuf
 veftdc4rAiQNr5RQrE5uu3WhK+lcrEBGpRatFMh4Ytdut3NvGqgGDc6QUnLSdN9s/L9J
 dquQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE33pSv/SQXiQ8qkIcb3vUURCZG5QoRb4pKxZuLAUsrx9DIfLlLTMddtWLGy7HmmEhzEDD+bpAw+6DIFQhn@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/rsfa5J5DdsOxgYK86V9X1fbrVA+Jqfu5DbIitZhWbQ7+OLFWw
 Bje8fFOLSlTBi5y48JxeNvOGVN6ZOIqAPsA/mu5VQTggKng65SqLIzOLgHD51VFbaLIe22ZRUCv
 eV6peupEHsIQbk9OKiGb8njRWVV/QsWm9wUsIpBHqGZPzia20CeIG7/m3ejvpmcPCAdd9pvbFH7
 f+JgC4Tg==
X-Gm-Gg: AZFdTZeeEuafjehChKE0aoT2nYpiPzWGqHUBxpX2xUgDdsJGGZoYtjL0FUYRAbRS+vz
 Glj+mxKWVIKj6I4vQbPLS8nrLHXBMNM4sXXv2RUELyGtFzPjQmWE7NhW7gn6qzxkC3rnVyGRQ8R
 pVJeLwAnVAHdePdv6MVVjpNZgU60HELLECXD6tlSVV9fvIjjP0dJrCrNWyC587zvN4SNWsa7SSy
 m5+6h8CUIaRevPj6v9WCEkfwgZexugLaestb5zrMA5WCDI/+tcIpPOK/0ZfUaRg5S++e+OO5rDE
 OTUEPn0Tsl4kkXi5wWpX/jVq+5kl6I6+zk/gIXdm97/8mGP7E2sdZwA+Ir0aF+ns9OcOh15FFze
 1ZZ53AClvKQYGQ7JGQvLcWFfWQ0+au5cku2/pEWh81WiPGpeCxySEloNydSEO2jCEMi7hUx89DD
 rfiuCY0yriHpMy/1EQ0ICwzcVWndEo5Iw4oVdaYZqiKodEo2MGzsyahpw8Gf3kAlQSEfO0IlC9k
 wuBMQ3HcYqiX7DpXhT5JCFjXfy0lmKGnfP41mn67wevxknceMLmIxSxc5jio2vProW8O/QKaePB
 4+el9Nz2IeM0Zf37ve9W2uSmIP22mqqwLjR/ToddJ7/bocF+C6CXc7NbpX2/Ws6HvOJej0mNdoo
 g7dLm4H7D4GJhdjBVqP7JDP7vYDNPorVtLXepHA6ZqJOaXVFzdACX5se8Cq0ZBmoKsCylmtaYm5
 O3
X-Received: by 2002:a05:6000:29d4:b0:498:b92a:30b with SMTP id
 ffacd0b85a97d-4a63a1e0245mr4620138f8f.15.1795018544628; 
 Wed, 18 Nov 2026 08:15:44 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656933956sm6043372f8f.44.2026.11.18.08.15.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:15:44 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 16:15:43 +0000
To: Lev Stipakov <lstipakov@gmail.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: merged
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cb48d4f77f9077bb3017b865b4e622bc0654399f
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0885d3f561bb27675f511f4ef50b4d2772cf8dcf-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTiK7-000000003fX-2kou
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add a
 shared TLV codec and use it for early negotiation
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Gert Doering \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: gert@greenie.muc.de, arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com, steffan@karger.me,
 lstipakov@gmail.com
Cc: "Gert Doering \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>,
 Arne Schwabe <arne-openvpn@rfc2549.org>
Content-Type: multipart/mixed; boundary="===============1363100755788795870=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1363100755788795870==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="orR1lrmKgCw="; charset=UTF-8

--orR1lrmKgCw=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has submitted this change=2E ( https://gerrit=2Eopenvpn=2Enet/=
c/openvpn/+/1965?usp=3Demail )

Change subject: control_msg: Add a shared T=
LV codec and use it for early negotiation
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E

control_msg: Add a shared TLV codec and use it=
 for early negotiation

Early negotiation in the reset packets is a sequenc=
e of TLVs, and
planned out-of-band and control data messages will use the s=
ame TLV
format and type space=2E Add one TLV codec for all of them,
control=
_msg=2Ec/h, and move early negotiation onto it=2E

The codec only handles t=
he framing: reading and writing TLV headers,
writing a 16-bit TLV, and walk=
ing a payload TLV by TLV with each value
checked against the payload=2E How=
 to treat an unknown type is up to each
message=2E With the optional flag c=
lear the codec writes the same bytes as
the hand-rolled code it replaces=2E=


In the codec the most significant bit of the type field is the
"optional"=
 flag rather than part of the type=2E The old parser compared
the whole typ=
e word, so 0x8001 did not match the flags TLV and was
skipped as unknown; n=
ow it matches and is parsed as one=2E

Change-Id: I89c3133e009dc75dc2c10c60=
7b3f0a24c04e8146
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
Acked-by: =
Steffan Karger <steffan@karger=2Eme>
Gerrit URL: https://gerrit=2Eopenvpn=
=2Enet/c/openvpn/+/1965
Message-Id: <20261116172950=2E23858-1-gert@greenie=
=2Emuc=2Ede>
URL: https://www=2Email-archive=2Ecom/openvpn-devel@lists=2Eso=
urceforge=2Enet/msg41473=2Ehtml
Signed-off-by: Gert Doering <gert@greenie=
=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
A src/openv=
pn/control_msg=2Ec
A src/openvpn/control_msg=2Eh
M src/openvpn/ssl=2Ec
M sr=
c/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/=
Makefile=2Eam
A tests/unit_tests/openvpn/test_control_msg=2Ec
A tests/unit_=
tests/openvpn/test_control_msg=2Eh
M tests/unit_tests/openvpn/test_pkt=2Ec
=
11 files changed, 493 insertions(+), 23 deletions(-)




diff --git a/CMake=
Lists=2Etxt b/CMakeLists=2Etxt
index 4f48990=2E=2E50b2d68 100644
--- a/CMak=
eLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -457,6 +457,8 @@
     src/openvpn/co=
nsole=2Ec
     src/openvpn/console_builtin=2Ec
     src/openvpn/console=2Eh=

+    src/openvpn/control_msg=2Ec
+    src/openvpn/control_msg=2Eh
     src=
/openvpn/crypto=2Ec
     src/openvpn/crypto=2Eh
     src/openvpn/crypto_bac=
kend=2Eh
@@ -896,6 +898,8 @@
 
     target_sources(test_pkt PRIVATE
       =
  tests/unit_tests/openvpn/mock_win32_execve=2Ec
+        tests/unit_tests/=
openvpn/test_control_msg=2Ec
+        src/openvpn/control_msg=2Ec
         =
src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
         src/openvpn/c=
rypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefi=
le=2Eam
index bb31053=2E=2Ebe1044d 100644
--- a/src/openvpn/Makefile=2Eam
+=
++ b/src/openvpn/Makefile=2Eam
@@ -57,6 +57,7 @@
 	common=2Eh \
 	comp=2Ec =
comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec comp-lz4=2Eh \
+	control_msg=2Ec con=
trol_msg=2Eh \
 	crypto=2Ec crypto=2Eh crypto_backend=2Eh \
 	crypto_openss=
l=2Ec crypto_openssl=2Eh \
 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \
diff -=
-git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec
new file m=
ode 100644
index 0000000=2E=2Ee14355c
--- /dev/null
+++ b/src/openvpn/contr=
ol_msg=2Ec
@@ -0,0 +1,93 @@
+/*
+ *  OpenVPN -- An application to securely =
tunnel IP networks
+ *             over a single TCP/UDP port, with support=
 for SSL/TLS-based
+ *             session authentication and key exchange,=

+ *             packet encryption, packet authentication, and
+ *         =
    packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sal=
es@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistrib=
ute it and/or modify
+ *  it under the terms of the GNU General Public Lice=
nse version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ * =
 This program is distributed in the hope that it will be useful,
+ *  but W=
ITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABIL=
ITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public=
 License for more details=2E
+ *
+ *  You should have received a copy of th=
e GNU General Public License along
+ *  with this program; if not, see <htt=
ps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "=
config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include "control_msg=2Eh"=

+
+bool
+ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool=
 optional, uint16_t value_len)
+{
+    /* the type has 15 bits; the top bit=
 is the optional flag */
+    ASSERT(type <=3D CTRL_MSG_TLV_TYPE_MASK);
+
+=
    /* Write nothing unless the whole TLV fits=2E The header promises that
=
+     * value_len bytes follow it, so a header written without room for the=

+     * value would leave a partial TLV in buf=2E */
+    if (!buf_safe(bu=
f, (size_t)CTRL_MSG_TLV_HEADER_LEN + value_len))
+    {
+        return fal=
se;
+    }
+    uint16_t field =3D type;
+    if (optional)
+    {
+       =
 field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
+    }
+    return buf_write_u16(bu=
f, field) && buf_write_u16(buf, value_len);
+}
+
+bool
+ctrl_msg_tlv_write_=
u16(struct buffer *buf, uint16_t type, bool optional, uint16_t value)
+{
+ =
   return ctrl_msg_tlv_write_header(buf, type, optional, sizeof(uint16_t))
=
+           && buf_write_u16(buf, value);
+}
+
+bool
+ctrl_msg_tlv_peek_hea=
der(const struct buffer *buf, struct ctrl_msg_tlv_header *hdr)
+{
+    if (=
BLEN(buf) < CTRL_MSG_TLV_HEADER_LEN)
+    {
+        return false; /* fewer=
 than 4 bytes left: truncated header */
+    }
+    /* read from a copy, so=
 that buf is left where it was */
+    struct buffer tmp =3D *buf;
+    uin=
t16_t field =3D (uint16_t)buf_read_u16(&tmp);
+    hdr->value_len =3D (uint=
16_t)buf_read_u16(&tmp);
+    hdr->type =3D field & CTRL_MSG_TLV_TYPE_MASK;=

+    hdr->optional =3D (field & CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;
+    r=
eturn true;
+}
+
+bool
+ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_m=
sg_tlv_header *hdr, struct buffer *value)
+{
+    if (!ctrl_msg_tlv_peek_he=
ader(buf, hdr))
+    {
+        return false;
+    }
+    /* Consume nothin=
g unless the whole TLV is there, so that a value shorter
+     * than the h=
eader claims leaves buf untouched=2E */
+    if (BLEN(buf) < CTRL_MSG_TLV_H=
EADER_LEN + hdr->value_len)
+    {
+        return false;
+    }
+    ASSER=
T(buf_advance(buf, CTRL_MSG_TLV_HEADER_LEN));
+    const uint8_t *v =3D buf=
_read_alloc(buf, hdr->value_len);
+    ASSERT(v);
+    buf_set_read(value, =
v, hdr->value_len);
+    return true;
+}
diff --git a/src/openvpn/control_m=
sg=2Eh b/src/openvpn/control_msg=2Eh
new file mode 100644
index 0000000=2E=
=2E92572cb
--- /dev/null
+++ b/src/openvpn/control_msg=2Eh
@@ -0,0 +1,108 @=
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
+/* A TLV header is a 16-bit type/optional field plus a 1=
6-bit length */
+#define CTRL_MSG_TLV_HEADER_LEN 4
+
+/* bit layout of the =
first 16-bit field */
+#define CTRL_MSG_TLV_OPTIONAL_FLAG 0x8000
+#define C=
TRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/** The header every TLV carries: the 1=
5-bit type and optional flag packed into
+ * the first 16-bit field, then t=
he length of the value that follows=2E */
+struct ctrl_msg_tlv_header
+{
+ =
   uint16_t type;      /**< the 15-bit TLV type */
+    bool optional;     =
 /**< value of the optional flag */
+    uint16_t value_len; /**< length of=
 the value following the header */
+};
+
+/**
+ * Write a TLV header (type =
+ optional flag + value length) to buf=2E
+ * type must fit in the 15 bits =
of the type field=2E
+ *
+ * Nothing is written unless the header and the v=
alue_len bytes of value
+ * that follow it both fit, so a failed write neve=
r leaves a partial TLV
+ * behind=2E
+ *
+ * @return true on success, false=
 if buf has insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_header(stru=
ct buffer *buf, uint16_t type, bool optional,
+                            =
   uint16_t value_len);
+
+/**
+ * Write a complete TLV whose value is a si=
ngle 16-bit integer to buf=2E
+ *
+ * @return true on success, false if buf=
 has insufficient space=2E
+ */
+bool ctrl_msg_tlv_write_u16(struct buffer =
*buf, uint16_t type, bool optional, uint16_t value);
+
+/**
+ * Read a TLV =
header from buf without consuming it=2E
+ *
+ * @param buf  buffer position=
ed at the TLV header
+ * @param hdr  filled with the type, optional flag an=
d value length on success
+ * @return true on success, false if there are n=
ot enough bytes for a header=2E
+ */
+bool ctrl_msg_tlv_peek_header(const s=
truct buffer *buf, struct ctrl_msg_tlv_header *hdr);
+
+/**
+ * Read the ne=
xt TLV from buf, advancing past its header and value=2E Call it
+ * while B=
LEN(buf) > 0 to walk a whole payload=2E
+ *
+ * The length from the header =
is validated against buf, so on success the
+ * whole value is present: a h=
eader claiming more bytes than buf holds is
+ * rejected=2E Nothing is cons=
umed unless the whole TLV is there, so a failed
+ * read never leaves a par=
tial TLV behind=2E
+ *
+ * @param buf    buffer positioned at a TLV header
=
+ * @param hdr    filled with the TLV's type, optional flag and value lengt=
h
+ * @param value  set to a buffer covering exactly the TLV's value; it po=
ints
+ *               into buf and owns no storage
+ * @return true on suc=
cess, false if the header or the value is truncated,
+ *         with buf l=
eft untouched=2E
+ */
+bool ctrl_msg_tlv_next(struct buffer *buf, struct ct=
rl_msg_tlv_header *hdr, struct buffer *value);
+
+#endif /* ifndef CONTROL_=
MSG_H */
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 00e17=
12=2E=2Ee06659a 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
=
@@ -52,6 +52,7 @@
 #include "pkcs11=2Eh"
 #include "route=2Eh"
 #include "t=
ls_crypt=2Eh"
+#include "control_msg=2Eh"
 
 #include "crypto_epoch=2Eh"
 #=
include "ssl=2Eh"
@@ -2662,26 +2663,21 @@
 {
     while (buf->len > 0)
    =
 {
-        if (buf_len(buf) < 4)
-        {
-            goto error;
-    =
    }
-        /* read type */
-        int type =3D buf_read_u16(buf);
-  =
      int len =3D buf_read_u16(buf);
-        if (type < 0 || len < 0 || bu=
f_len(buf) < len)
+        struct ctrl_msg_tlv_header hdr;
+        struct =
buffer value;
+        if (!ctrl_msg_tlv_next(buf, &hdr, &value))
         =
{
             goto error;
         }
 
-        switch (type)
+        swi=
tch (hdr=2Etype)
         {
             case TLV_TYPE_EARLY_NEG_FLAGS:
-  =
              if (len !=3D sizeof(uint16_t))
+                if (BLEN(&val=
ue) !=3D sizeof(uint16_t))
                 {
                     goto err=
or;
                 }
-                int flags =3D buf_read_u16(buf);
+ =
               int flags =3D buf_read_u16(&value);
 
                 if (f=
lags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
@@ -2700,8 +2696,8 @@
=
                 break;
 
             default:
-                /* Skip ty=
pes we do not parse */
-                buf_advance(buf, len);
+           =
     /* Skip types we do not parse, marked optional or not */
+            =
    break;
         }
     }
     reliable_mark_deleted(ks->rec_reliable, b=
uf);
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index 6=
0573ee=2E=2Edad58c3 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/=
ssl_pkt=2Ec
@@ -33,6 +33,7 @@
 #include "reliable=2Eh"
 #include "siphash=
=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_msg=2Eh"
 
 /*
  * Depen=
dent on hmac size, opcode size, and session_id size=2E
@@ -437,9 +438,8 @@
=
     /* Add indication for tls-crypt-v2 to resend the WKc with the reply */=

     if (request_resend_wkc)
     {
-        buf_write_u16(&buf, TLV_TYPE_=
EARLY_NEG_FLAGS); /* TYPE: flags */
-        buf_write_u16(&buf, sizeof(uin=
t16_t));
-        buf_write_u16(&buf, EARLY_NEG_FLAG_RESEND_WKC);
+        =
ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+     =
                                 EARLY_NEG_FLAG_RESEND_WKC));
     }
 
    =
 /* Add tls-auth/tls-crypt wrapping, this might replace buf with
diff --git=
 a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index 8203e4a=2E=2E218=
c6bb 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ =
-306,10 +306,8 @@
 #define EARLY_NEG_START 0x0f000000
 
 
-/* Early negotia=
tion that part of the server response in the RESET_V2 packet=2E
- * Since c=
lients that announce early negotiation support will treat the payload
- * o=
f reset packets special and parse it as TLV messages=2E
- * as TLV (type, l=
ength, value) */
-#define TLV_TYPE_EARLY_NEG_FLAGS  0x0001
+/* Early negoti=
ation: clients that announce support for it parse the payload of
+ * the re=
set packets as TLVs (see control_msg=2Eh)=2E Flags carried in the value of
=
+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #define EARLY_NEG_FLAG_RESEND_WKC=
 0x0001
 #endif /* ifndef SSL_PKT_H */
diff --git a/tests/unit_tests/openvp=
n/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 6091264=2E=
=2Ee3404754 100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests=
/unit_tests/openvpn/Makefile=2Eam
@@ -164,11 +164,15 @@
 	-I$(top_srcdir)/i=
nclude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \
 	@TEST_CFL=
AGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOURCES =3D=
 test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec test_common=
=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec \
+	test_control_msg=2Ec te=
st_control_msg=2Eh \
+	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
+	=
test_common=2Eh \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_s=
rcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(=
top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_srcdir)/src/openvpn/control_ms=
g=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvp=
n/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
diff =
--git a/tests/unit_tests/openvpn/test_control_msg=2Ec b/tests/unit_tests/op=
envpn/test_control_msg=2Ec
new file mode 100644
index 0000000=2E=2Ead4c565
=
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_control_msg=2Ec
@@ -0,0 +=
1,181 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
=
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
=
+ *             session authentication and key exchange,
+ *             pa=
cket encryption, packet authentication, and
+ *             packet compress=
ion=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+=
 *
+ *  This program is free software; you can redistribute it and/or modif=
y
+ *  it under the terms of the GNU General Public License version 2
+ *  =
as published by the Free Software Foundation=2E
+ *
+ *  This program is di=
stributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY=
; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR =
A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License for more d=
etails=2E
+ *
+ *  You should have received a copy of the GNU General Publi=
c License along
+ *  with this program; if not, see <https://www=2Egnu=2Eor=
g/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif=

+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#include <stddef=2Eh>
=
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "control_msg=2Eh"=

+#include "ssl_pkt=2Eh"
+#include "test_common=2Eh"
+#include "test_contro=
l_msg=2Eh"
+
+/* The early negotiation flags TLV of a reset packet asking a=
 tls-crypt-v2
+ * client to resend its WKc=2E */
+void
+test_tlv_write_u16_=
wire_format(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    str=
uct buffer buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_w=
rite_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false,
+                          =
             EARLY_NEG_FLAG_RESEND_WKC));
+    const uint8_t expected[] =3D=
 { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equal(BLEN(&buf), =
sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(ex=
pected));
+
+    /* the optional flag is the most significant bit of the ty=
pe field */
+    buf_clear(&buf);
+    assert_true(ctrl_msg_tlv_write_u16(&=
buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));
+    assert_int_equal(BPTR(&buf)[=
0], 0x80);
+    assert_int_equal(BPTR(&buf)[1], 0x01);
+
+    gc_free(&gc);=

+}
+
+/* A TLV header survives the round trip, the optional flag kept apar=
t from
+ * the 15-bit type=2E */
+void
+test_tlv_header_roundtrip(void **st=
ate)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D al=
loc_buf_gc(16, &gc);
+
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x1=
234, true, 5));
+    assert_int_equal(BLEN(&buf), 4);
+
+    struct ctrl_ms=
g_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+=
    assert_int_equal(hdr=2Etype, 0x1234);
+    assert_true(hdr=2Eoptional);=

+    assert_int_equal(hdr=2Evalue_len, 5);
+    assert_int_equal(BLEN(&buf=
), CTRL_MSG_TLV_HEADER_LEN); /* peek consumes nothing */
+
+    gc_free(&gc=
);
+}
+
+/* Walking a payload returns each TLV in turn, with a value coveri=
ng exactly
+ * its bytes, and consumes the payload=2E */
+void
+test_tlv_ne=
xt_walks_payload(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+  =
  struct buffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg_=
tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 0xabcd));
+    assert_=
true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf=
_write_u32(&buf, 0x11223344));
+    assert_true(ctrl_msg_tlv_write_header(&=
buf, 0x5, false, 0)); /* empty value */
+
+    struct ctrl_msg_tlv_header h=
dr;
+    struct buffer value;
+
+    assert_true(ctrl_msg_tlv_next(&buf, &h=
dr, &value));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);
=
+    assert_false(hdr=2Eoptional);
+    assert_int_equal(BLEN(&value), 2);
=
+    assert_int_equal(buf_read_u16(&value), 0xabcd);
+
+    assert_true(ctr=
l_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype, 0x7f=
f);
+    assert_true(hdr=2Eoptional);
+    assert_int_equal(BLEN(&value), 4=
);
+    assert_int_equal(buf_read_u32(&value, NULL), 0x11223344);
+
+    as=
sert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=
=2Etype, 0x5);
+    assert_int_equal(BLEN(&value), 0);
+
+    assert_int_eq=
ual(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming mor=
e value bytes than the payload holds is rejected,
+ * rather than read past=
 the end of the payload, and leaves buf untouched=2E */
+void
+test_tlv_nex=
t_value_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+ =
   struct buffer buf =3D alloc_buf_gc(64, &gc);
+
+    assert_true(ctrl_msg=
_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 8));
+    assert_t=
rue(buf_write_u32(&buf, 0));
+
+    struct ctrl_msg_tlv_header hdr;
+    st=
ruct buffer value;
+    assert_false(ctrl_msg_tlv_next(&buf, &hdr, &value))=
;
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + sizeof(uint32=
_t));
+
+    gc_free(&gc);
+}
+
+/* Reading a TLV header must fail, rather =
than read past the available data,
+ * when the buffer holds less than a co=
mplete 4-byte header, and must leave
+ * buf untouched=2E */
+void
+test_tl=
v_header_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+=
    const uint8_t bytes[] =3D { 0x00, 0x01, 0x00 };
+
+    /* 0 to 3 bytes:=
 none, part of the type field, the type field, and the type
+     * field w=
ith half of the length */
+    for (size_t n =3D 0; n <=3D sizeof(bytes); n=
++)
+    {
+        struct buffer buf =3D alloc_buf_gc(16, &gc);
+        a=
ssert_true(buf_write(&buf, bytes, n));
+
+        struct ctrl_msg_tlv_heade=
r hdr;
+        struct buffer value;
+        assert_false(ctrl_msg_tlv_pee=
k_header(&buf, &hdr));
+        assert_false(ctrl_msg_tlv_next(&buf, &hdr, =
&value));
+        assert_int_equal(BLEN(&buf), n);
+    }
+
+    gc_free(&=
gc);
+}
+
+/* Writing fails, rather than writes a partial TLV, when buf is =
too small=2E */
+void
+test_tlv_write_no_room(void **state)
+{
+    struct =
gc_arena gc =3D gc_new();
+
+    struct buffer buf =3D alloc_buf_gc(3, &gc)=
;
+    assert_false(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_EARLY_NEG_FLAG=
S, false, 2));
+    assert_int_equal(BLEN(&buf), 0);
+
+    /* room for the=
 header but not the value */
+    buf =3D alloc_buf_gc(5, &gc);
+    assert=
_false(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));
+=
    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
diff --git a/t=
ests/unit_tests/openvpn/test_control_msg=2Eh b/tests/unit_tests/openvpn/tes=
t_control_msg=2Eh
new file mode 100644
index 0000000=2E=2Eef7a030
--- /dev/=
null
+++ b/tests/unit_tests/openvpn/test_control_msg=2Eh
@@ -0,0 +1,37 @@
+=
/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *       =
      over a single TCP/UDP port, with support for SSL/TLS-based
+ *       =
      session authentication and key exchange,
+ *             packet encry=
ption, packet authentication, and
+ *             packet compression=2E
+ *=

+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  Th=
is program is free software; you can redistribute it and/or modify
+ *  it =
under the terms of the GNU General Public License version 2
+ *  as publish=
ed by the Free Software Foundation=2E
+ *
+ *  This program is distributed =
in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without =
even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICUL=
AR PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
=
+ *
+ *  You should have received a copy of the GNU General Public License =
along
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses=
/>=2E
+ */
+
+#ifndef TEST_CONTROL_MSG_H
+#define TEST_CONTROL_MSG_H
+
+voi=
d test_tlv_write_u16_wire_format(void **state);
+
+void test_tlv_header_rou=
ndtrip(void **state);
+
+void test_tlv_next_walks_payload(void **state);
+
=
+void test_tlv_next_value_truncated(void **state);
+
+void test_tlv_header_=
truncated(void **state);
+
+void test_tlv_write_no_room(void **state);
+#en=
dif
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/o=
penvpn/test_pkt=2Ec
index 49ba833=2E=2Ef34bd41 100644
--- a/tests/unit_test=
s/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -37,1=
2 +37,14 @@
 #include "crypto=2Eh"
 #include "options=2Eh"
 #include "ssl_b=
ackend=2Eh"
+#include "control_msg=2Eh"
 #include "ssl_pkt=2Eh"
 #include "=
tls_crypt=2Eh"
 
 #include "mss=2Eh"
 #include "reliable=2Eh"
 #include "si=
phash=2Eh"
+#include "test_control_msg=2Eh"
 
 int
 parse_line(const char *=
line, char **p, const int n, const char *file, const int line_num,
@@ -655,=
6 +657,45 @@
     free_buf(&tas=2Eworkbuf);
 }
 
+/* A reset reply asking a=
 tls-crypt-v2 client to resend its WKc ends in the
+ * early negotiation fl=
ags TLV, and that TLV parses back=2E */
+static void
+test_generate_reset_p=
acket_resend_wkc(void **ut_state)
+{
+    struct tls_auth_standalone tas =
=3D { 0 };
+
+    struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, =
7 } };
+    struct session_id server_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };=

+
+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;
+    struct frame frame =
=3D { =2Ebuf =3D { =2Eheadroom =3D 200, =2Epayload_size =3D 1400 }, 0 };
+ =
   tas=2Eframe =3D frame;
+    tas=2Eworkbuf =3D alloc_buf(1600);
+
+    ui=
nt8_t header =3D 0 | (P_CONTROL_HARD_RESET_SERVER_V2 << P_OPCODE_SHIFT);
+
=
+    struct buffer plain =3D
+        tls_reset_standalone(&tas=2Etls_wrap,=
 &tas, &client_id, &server_id, header, false);
+    const int plain_len =3D=
 BLEN(&plain);
+    struct buffer buf =3D
+        tls_reset_standalone(&ta=
s=2Etls_wrap, &tas, &client_id, &server_id, header, true);
+
+    const uin=
t8_t tlv[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    assert_int_equa=
l(BLEN(&buf), plain_len + (int)sizeof(tlv));
+    assert_memory_equal(BPTR(=
&buf) + plain_len, tlv, sizeof(tlv));
+
+    struct buffer payload =3D buf;=

+    assert_true(buf_advance(&payload, plain_len));
+    struct ctrl_msg_t=
lv_header hdr;
+    struct buffer value;
+    assert_true(ctrl_msg_tlv_next=
(&payload, &hdr, &value));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY=
_NEG_FLAGS);
+    assert_int_equal(buf_read_u16(&value), EARLY_NEG_FLAG_RES=
END_WKC);
+    assert_int_equal(BLEN(&payload), 0);
+
+    free_buf(&tas=2E=
workbuf);
+}
+
 static void
 test_generate_reset_packet_tls_auth(void **ut_=
state)
 {
@@ -791,9 +832,16 @@
         cmocka_unit_test(test_verify_hmac_t=
ls_auth),
         cmocka_unit_test(test_verify_hmac_none_out_of_range_ack)=
,
         cmocka_unit_test(test_generate_reset_packet_plain),
+        cmo=
cka_unit_test(test_generate_reset_packet_resend_wkc),
         cmocka_unit_=
test(test_generate_reset_packet_tls_auth),
         cmocka_unit_test(test_w=
kc_not_appended_without_key),
-        cmocka_unit_test(test_extract_contro=
l_message)
+        cmocka_unit_test(test_extract_control_message),
+      =
  cmocka_unit_test(test_tlv_write_u16_wire_format),
+        cmocka_unit_te=
st(test_tlv_header_roundtrip),
+        cmocka_unit_test(test_tlv_next_walk=
s_payload),
+        cmocka_unit_test(test_tlv_next_value_truncated),
+    =
    cmocka_unit_test(test_tlv_header_truncated),
+        cmocka_unit_test(=
test_tlv_write_no_room)
     };
 
     return cmocka_run_group_tests_name("=
pkt tests", tests, NULL, NULL);

-- 
To view, visit https://gerrit=2Eopenvp=
n=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscribe, or for help writing ma=
il filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerr=
it-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Gerrit-Change-Number:=
 1965
Gerrit-PatchSet: 9
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>=

Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer=
: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: R=C4=83zvan =
Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Reviewer: Steffan Karger <steffan@k=
arger=2Eme>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2En=
et>

--orR1lrmKgCw=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>submitted</strong> this change=2E</p><p><a href=3D"https://gerrit=2Eope=
nvpn=2Enet/c/openvpn/+/1965?usp=3Demail">View Change</a></p><div style=3D"w=
hite-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">control_msg: Add a shared TLV code=
c and use it for early negotiation<br><br>Early negotiation in the reset pa=
ckets is a sequence of TLVs, and<br>planned out-of-band and control data me=
ssages will use the same TLV<br>format and type space=2E Add one TLV codec =
for all of them,<br>control_msg=2Ec/h, and move early negotiation onto it=
=2E<br><br>The codec only handles the framing: reading and writing TLV head=
ers,<br>writing a 16-bit TLV, and walking a payload TLV by TLV with each va=
lue<br>checked against the payload=2E How to treat an unknown type is up to=
 each<br>message=2E With the optional flag clear the codec writes the same =
bytes as<br>the hand-rolled code it replaces=2E<br><br>In the codec the mos=
t significant bit of the type field is the<br>&quot;optional&quot; flag rat=
her than part of the type=2E The old parser compared<br>the whole type word=
, so 0x8001 did not match the flags TLV and was<br>skipped as unknown; now =
it matches and is parsed as one=2E<br><br>Change-Id: I89c3133e009dc75dc2c10=
c607b3f0a24c04e8146<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt=
;<br>Acked-by: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965<br>Message-Id: &lt;2026111617=
2950=2E23858-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41473=2Ehtml<br>Signed-=
off-by: Gert Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=
=2Etxt<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/control_msg=2Ec<br>A=
 src/openvpn/control_msg=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_=
pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=
=2Eam<br>A tests/unit_tests/openvpn/test_control_msg=2Ec<br>A tests/unit_te=
sts/openvpn/test_control_msg=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec=
<br>11 files changed, 493 insertions(+), 23 deletions(-)<br><br></pre>
<pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index 4f489=
90=2E=2E50b2d68 100644</span><br><span>--- a/CMakeLists=2Etxt</span><br><sp=
an>+++ b/CMakeLists=2Etxt</span><br><span>@@ -457,6 +457,8 @@</span><br><sp=
an>     src/openvpn/console=2Ec</span><br><span>     src/openvpn/console_bu=
iltin=2Ec</span><br><span>     src/openvpn/console=2Eh</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=
=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span><br><span>     src/o=
penvpn/crypto=2Eh</span><br><span>     src/openvpn/crypto_backend=2Eh</span=
><br><span>@@ -896,6 +898,8 @@</span><br><span> </span><br><span>     targe=
t_sources(test_pkt PRIVATE</span><br><span>         tests/unit_tests/openvp=
n/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/control_msg=2Ec</=
span><br><span>         src/openvpn/argv=2Ec</span><br><span>         src/o=
penvpn/base64=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</sp=
an><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=
=2Eam</span><br><span>index bb31053=2E=2Ebe1044d 100644</span><br><span>---=
 a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Ea=
m</span><br><span>@@ -57,6 +57,7 @@</span><br><span> 	common=2Eh \</span><b=
r><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	comp-lz4=2Ec c=
omp-lz4=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	contr=
ol_msg=2Ec control_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh crypto=
_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec crypto_openssl=2Eh \</s=
pan><br><span> 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \</span><br><span>dif=
f --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec</span><=
br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ee14355c</s=
pan><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/control_msg=
=2Ec</span><br><span>@@ -0,0 +1,93 @@</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  OpenVPN -- An application to securely tunnel IP networks</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/=
UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             session authentication and key exchange=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket encryption, packet authentication, and</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@op=
envpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is f=
ree software; you can redistribute it and/or modify</span><br><span style=
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
 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg=
_tlv_write_header(struct buffer *buf, uint16_t type, bool optional, uint16_=
t value_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the type has 15 bi=
ts; the top bit is the optional flag */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(type &lt;=3D CTRL_MSG_TLV_TYPE_MASK);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Write nothing unless the whole TLV fit=
s=2E The header promises that</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * value_len bytes follow it, so a header written without roo=
m for the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * val=
ue would leave a partial TLV in buf=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (!buf_safe(buf, (size_t)CTRL_MSG_TLV_HEADER_LE=
N + value_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D type;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (optional)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        field |=3D CTRL_MSG_TLV_OPTIO=
NAL_FLAG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write_u16=
(buf, field) &amp;&amp; buf_write_u16(buf, value_len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_writ=
e_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t value)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf,=
 type, optional, sizeof(uint16_t))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, value);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg=
_tlv_peek_header(const struct buffer *buf, struct ctrl_msg_tlv_header *hdr)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(buf) &lt; CTRL_MSG_TLV_H=
EADER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false; /=
* fewer than 4 bytes left: truncated header */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* read from a copy, so that buf is left where it was */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer tmp=
 =3D *buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint1=
6_t field =3D (uint16_t)buf_read_u16(&amp;tmp);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint16_t)buf_read_u1=
6(&amp;tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hdr=
-&gt;type =3D field &amp; CTRL_MSG_TLV_TYPE_MASK;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    hdr-&gt;optional =3D (field &amp; CTRL_MS=
G_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ctrl_msg_tlv_next(struct buffer *buf, struct c=
trl_msg_tlv_header *hdr, struct buffer *value)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!ctrl_msg_tlv_peek_header(buf, hdr))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* Consume nothing unless the whole TLV is there, so that a val=
ue shorter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * th=
an the header claims leaves buf untouched=2E */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (BLEN(buf) &lt; CTRL_MSG_TLV_HEADER_LEN =
+ hdr-&gt;value_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_advance(bu=
f, CTRL_MSG_TLV_HEADER_LEN));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const uint8_t *v =3D buf_read_alloc(buf, hdr-&gt;value_len);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(v);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(value, v=
, hdr-&gt;value_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span>diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/con=
trol_msg=2Eh</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2E92572cb</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/control_msg=2Eh</span><br><span>@@ -0,0 +1,108 @@</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP net=
works</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 over a single TCP/UDP port, with support for SSL/TLS-based</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticati=
on and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet encryption, packet authentication, and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenV=
PN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is free software; you can redistribute it and/or modify</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms o=
f the GNU General Public License version 2</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  as published by the Free Software Foundation=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in th=
e hope that it will be useful,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty =
of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILI=
TY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more deta=
ils=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a=
 copy of the GNU General Public License along</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://ww=
w=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * TLV framing shared by the TLV-based control mess=
ages of the wire protocol=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Such =
a message payload is a sequence of TLV entries=2E Each TLV starts with a</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 4-byte header: a 16=
-bit field whose most significant bit is the &quot;optional&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * flag and whose remaining 1=
5 bits are the type, followed by a 16-bit length</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * giving the size of the value that follows t=
he header=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * All of these messages=
 share one TLV type space, so the TLV types are all</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * defined here=2E Only the framing is ha=
ndled here: what a message does with a</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * TLV type it does not know, marked optional or not, is=
 up to its parser=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* TLV types */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation=
, in the reset packets */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV head=
er is a 16-bit type/optional field plus a 16-bit length */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_HEADER_LEN 4</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* bit layout of the first 16-bit field *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_T=
LV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/** The header every TLV carries: the 15-bit type and optional flag =
packed into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the f=
irst 16-bit field, then the length of the value that follows=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_header</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;      /**&lt; the 15-=
bit TLV type */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
bool optional;      /**&lt; value of the optional flag */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len; /**&lt; lengt=
h of the value following the header */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV header (type + opt=
ional flag + value length) to buf=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * type must fit in the 15 bits of the type field=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Nothing is written unless the header a=
nd the value_len bytes of value</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * that follow it both fit, so a failed write never leaves a pa=
rtial TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * behind=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false=
 if buf has insufficient space=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool option=
al,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
               uint16_t value_len);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete=
 TLV whose value is a single 16-bit integer to buf=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @return true on success, false if buf has insufficient =
space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_write_u16=
(struct buffer *buf, uint16_t type, bool optional, uint16_t value);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Read a TLV header from buf without consuming it=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param buf  buffer positioned at the TLV h=
eader</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hdr =
 filled with the type, optional flag and value length on success</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fa=
lse if there are not enough bytes for a header=2E</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+bool ctrl_msg_tlv_peek_header(const struct buffer *buf, struc=
t ctrl_msg_tlv_header *hdr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read the next TLV from =
buf, advancing past its header and value=2E Call it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * while BLEN(buf) &gt; 0 to walk a whole=
 payload=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The length from the he=
ader is validated against buf, so on success the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * whole value is present: a header claiming m=
ore bytes than buf holds is</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * rejected=2E Nothing is consumed unless the whole TLV is there, s=
o a failed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read n=
ever leaves a partial TLV behind=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @param buf    buffer positioned at a TLV header</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param hdr    filled with the TLV&#39;s ty=
pe, optional flag and value length</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param value  set to a buffer covering exactly the TLV&#3=
9;s value; it points</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *               into buf and owns no storage</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return true on success, false if the header =
or the value is truncated,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *         with buf left untouched=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_hea=
der *hdr, struct buffer *value);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
 /* ifndef CONTROL_MSG_H */</span><br><span>diff --git a/src/openvpn/ssl=2E=
c b/src/openvpn/ssl=2Ec</span><br><span>index 00e1712=2E=2Ee06659a 100644</=
span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/=
ssl=2Ec</span><br><span>@@ -52,6 +52,7 @@</span><br><span> #include &quot;p=
kcs11=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;</span><br><=
span> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span> =
</span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br><span> #i=
nclude &quot;ssl=2Eh&quot;</span><br><span>@@ -2662,26 +2663,21 @@</span><b=
r><span> {</span><br><span>     while (buf-&gt;len &gt; 0)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf=
_len(buf) &lt; 4)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto=
 error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* read type */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        int type =3D buf=
_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  int len =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (type &lt; 0 || len &lt; 0 || buf_len(buf) &lt; len)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ctrl_=
msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        struct buffer value;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!ctrl_msg_tlv_next(buf, &amp;hdr, &amp;value))</span><=
br><span>         {</span><br><span>             goto error;</span><br><spa=
n>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        switch (type)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        switch (hdr=2Etype)</span><br><span>         {</span><br=
><span>             case TLV_TYPE_EARLY_NEG_FLAGS:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                if (len !=3D sizeof(uint16_t))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(BLEN(&amp;value) !=3D sizeof(uint16_t))</span><br><span>                 {=
</span><br><span>                     goto error;</span><br><span>         =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    int flags =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                int flags =3D buf_read_u16(&amp;value);</s=
pan><br><span> </span><br><span>                 if (flags &amp; EARLY_NEG_=
FLAG_RESEND_WKC)</span><br><span>                 {</span><br><span>@@ -270=
0,8 +2696,8 @@</span><br><span>                 break;</span><br><span> </s=
pan><br><span>             default:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                /* Skip types we do not parse */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                buf_advance(buf, l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 /* Skip types we do not parse, marked optional or not */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><spa=
n>         }</span><br><span>     }</span><br><span>     reliable_mark_dele=
ted(ks-&gt;rec_reliable, buf);</span><br><span>diff --git a/src/openvpn/ssl=
_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 60573ee=2E=2Edad58=
c3 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++=
 b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -33,6 +33,7 @@</span><br><spa=
n> #include &quot;reliable=2Eh&quot;</span><br><span> #include &quot;siphas=
h=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&=
quot;</span><br><span> </span><br><span> /*</span><br><span>  * Dependent o=
n hmac size, opcode size, and session_id size=2E</span><br><span>@@ -437,9 =
+438,8 @@</span><br><span>     /* Add indication for tls-crypt-v2 to resend=
 the WKc with the reply */</span><br><span>     if (request_resend_wkc)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      buf_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_write_u16(=
&amp;buf, sizeof(uint16_t));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        buf_write_u16(&amp;buf, EARLY_NEG_FLAG_RESEND_WKC);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(ctrl_msg_tlv_=
write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                      EAR=
LY_NEG_FLAG_RESEND_WKC));</span><br><span>     }</span><br><span> </span><b=
r><span>     /* Add tls-auth/tls-crypt wrapping, this might replace buf wit=
h</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pk=
t=2Eh</span><br><span>index 8203e4a=2E=2E218c6bb 100644</span><br><span>---=
 a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</s=
pan><br><span>@@ -306,10 +306,8 @@</span><br><span> #define EARLY_NEG_START=
 0x0f000000</span><br><span> </span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/* Early negotiation that part of the server resp=
onse in the RESET_V2 packet=2E</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Since clients that announce early negotiation support will trea=
t the payload</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * of re=
set packets special and parse it as TLV messages=2E</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * as TLV (type, length, value) */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define TLV_TYPE_EARLY_NEG_FLA=
GS  0x0001</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Early =
negotiation: clients that announce support for it parse the payload of</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the reset packets as =
TLVs (see control_msg=2Eh)=2E Flags carried in the value of</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV=
: */</span><br><span> #define EARLY_NEG_FLAG_RESEND_WKC 0x0001</span><br><s=
pan> #endif /* ifndef SSL_PKT_H */</span><br><span>diff --git a/tests/unit_=
tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span>=
<br><span>index 6091264=2E=2Ee3404754 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openv=
pn/Makefile=2Eam</span><br><span>@@ -164,11 +164,15 @@</span><br><span> 	-I=
$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvp=
n \</span><br><span> 	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLAGS=
 =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pk=
t_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_win32_=
execve=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+pkt_testdriver_SOURCES =3D test_pkt=2Ec \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	test_control_msg=2Ec test_control_msg=2Eh \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=2Ec mock_=
msg=2Eh mock_win32_execve=2Ec \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	test_common=2Eh \</span><br><span> 	$(top_srcdir)/src/compat/c=
ompat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br><span> 	=
$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/control_msg=2Ec \</span><br><=
span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openv=
pn/crypto_mbedtls=2Ec \</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_control_msg=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec</sp=
an><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ead4c56=
5</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_control_msg=2Ec</span><br><span>@@ -0,0 +1,181 @@</span><br><span =
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
color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=2Eh&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;test_control_msg=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* The early negotiation flags TLV of a reset packet as=
king a tls-crypt-v2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * client to resend its WKc=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_tlv_write_u16_wire_format(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16=
(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                       EARLY_NEG_FL=
AG_RESEND_WKC));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN=
(&amp;buf), sizeof(expected));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expecte=
d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* the optional flag is the mo=
st significant bit of the type field */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buf_clear(&amp;buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, T=
LV_TYPE_EARLY_NEG_FLAGS, true, 0));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[0], 0x80);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;b=
uf)[1], 0x01);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* A TLV header survives the round trip, the optional flag =
kept apart from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * t=
he 15-bit type=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_heade=
r_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct g=
c_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x12=
34, true, 5));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(BLEN(&amp;buf), 4);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(ctrl_msg_tlv_peek_header(&amp;buf, &amp;hdr));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(hdr=2Etype, 0x1234);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, 5);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), =
CTRL_MSG_TLV_HEADER_LEN); /* peek consumes nothing */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Walking a payload=
 returns each TLV in turn, with a value covering exactly</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * its bytes, and consumes the payload=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_next_walks_payload(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer buf =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG=
_FLAGS, false, 0xabcd));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_=
write_u32(&amp;buf, 0x11223344));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x5, fals=
e, 0)); /* empty value */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct ct=
rl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct buffer value;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_T=
YPE_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_false(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 2);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_read_u16(&a=
mp;value), 0xabcd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, 0x7ff);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(hdr=2Eopt=
ional);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(BLEN(&amp;value), 4);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(buf_read_u32(&amp;value, NULL), 0x11223344)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&am=
p;buf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(hdr=2Etype, 0x5);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 0);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* A TLV header claiming more value bytes than the payload holds is reject=
ed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rather than r=
ead past the end of the payload, and leaves buf untouched=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_tlv_next_value_truncated(void **state)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =
=3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false=
, 8));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_false(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;v=
alue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(BLEN(&amp;buf), CTRL_MSG_TLV_HEADER_LEN + sizeof(uint32_t));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Reading a TLV header must fail, rather than read past the available data,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * when the buffer ho=
lds less than a complete 4-byte header, and must leave</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * buf untouched=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_tlv_header_truncated(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t bytes[] =3D { 0=
x00, 0x01, 0x00 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 to 3 bytes:=
 none, part of the type field, the type field, and the type</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * field with half of the lengt=
h */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t=
 n =3D 0; n &lt;=3D sizeof(bytes); n++)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        assert_true(buf_write(&a=
mp;buf, bytes, n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct ctrl=
_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        struct buffer value;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        assert_false(ctrl_msg_tlv_peek_header(&amp;buf, &amp;hdr)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_fa=
lse(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(BLEN(&amp;buf)=
, n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Writ=
ing fails, rather than writes a partial TLV, when buf is too small=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_no_room(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(3=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_false(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, fals=
e, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* roo=
m for the header but not the value */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_write_u16=
(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_control_msg=2Eh b/tests/unit_tests/openvpn/test_control=
_msg=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2Eef7a030</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_control_msg=2Eh</span><br><span>@@ -0,0 +1,37 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  This program is free software; you can redistribute it and/=
or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it und=
er the terms of the GNU General Public License version 2</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software =
Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is dis=
tributed in the hope that it will be useful,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the imp=
lied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License=
 for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should h=
ave received a copy of the GNU General Public License along</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see =
&lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef TE=
ST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_w=
rite_u16_wire_format(void **state);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d test_tlv_header_roundtrip(void **state);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void test_tlv_next_walks_payload(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_tlv_next_value_truncated(void **state);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void test_tlv_header_truncated(void **state);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_tlv_write_no_room(void **state)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/=
openvpn/test_pkt=2Ec</span><br><span>index 49ba833=2E=2Ef34bd41 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -37,12 +37,14 @=
@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #includ=
e &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backend=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
control_msg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&quot;</sp=
an><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> </span><b=
r><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &quot;relia=
ble=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_control_msg=
=2Eh&quot;</span><br><span> </span><br><span> int</span><br><span> parse_li=
ne(const char *line, char **p, const int n, const char *file, const int lin=
e_num,</span><br><span>@@ -655,6 +657,45 @@</span><br><span>     free_buf(&=
amp;tas=2Eworkbuf);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* A reset reply asking a tls-crypt-v2=
 client to resend its WKc ends in the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * early negotiation flags TLV, and that TLV parses back=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_generate_reset_p=
acket_resend_wkc(void **ut_state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct tls_auth_standalone tas =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct session_id client_id =3D { { 0, 1, 2, 3, 4, 5, 6, 7 } };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct session_id se=
rver_id =3D { { 8, 9, 0, 9, 8, 7, 6, 2 } };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    tas=2Etls_wrap=2Emode =3D TLS_WRAP_NONE;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct frame frame =3D { =2Ebuf =3D { =2E=
headroom =3D 200, =2Epayload_size =3D 1400 }, 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    tas=2Eframe =3D frame;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    tas=2Eworkbuf =3D alloc_buf(1600)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    uint8_t header =3D 0 | (P_CONTROL=
_HARD_RESET_SERVER_V2 &lt;&lt; P_OPCODE_SHIFT);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer plain =3D</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        tls_reset_standalone(&amp;tas=2Etls_wrap, &amp;tas=
, &amp;client_id, &amp;server_id, header, false);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const int plain_len =3D BLEN(&amp;plain);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer b=
uf =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tls_r=
eset_standalone(&amp;tas=2Etls_wrap, &amp;tas, &amp;client_id, &amp;server_=
id, header, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t tl=
v[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), plain_len =
+ (int)sizeof(tlv));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_memory_equal(BPTR(&amp;buf) + plain_len, tlv, sizeof(tlv));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer payload =3D buf;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_advanc=
e(&amp;payload, plain_len));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_next(&amp;payloa=
d, &amp;hdr, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE_EARLY_NEG_FLAGS);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_rea=
d_u16(&amp;value), EARLY_NEG_FLAG_RESEND_WKC);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;payload), 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;tas=2Eworkbuf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span=
> test_generate_reset_packet_tls_auth(void **ut_state)</span><br><span> {</=
span><br><span>@@ -791,9 +832,16 @@</span><br><span>         cmocka_unit_te=
st(test_verify_hmac_tls_auth),</span><br><span>         cmocka_unit_test(te=
st_verify_hmac_none_out_of_range_ack),</span><br><span>         cmocka_unit=
_test(test_generate_reset_packet_plain),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        cmocka_unit_test(test_generate_reset_packet_re=
send_wkc),</span><br><span>         cmocka_unit_test(test_generate_reset_pa=
cket_tls_auth),</span><br><span>         cmocka_unit_test(test_wkc_not_appe=
nded_without_key),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     cmocka_unit_test(test_extract_control_message)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_extract_con=
trol_message),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   cmocka_unit_test(test_tlv_write_u16_wire_format),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_header_=
roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
cmocka_unit_test(test_tlv_next_walks_payload),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_next_value_tru=
ncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmo=
cka_unit_test(test_tlv_header_truncated),</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_write_no_room)</spa=
n><br><span>     };</span><br><span> </span><br><span>     return cmocka_ru=
n_group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br></p=
re><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/=
1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3D=
email">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2E=
org/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merg=
ed </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div =
style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:=
none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146 </div>
<=
div style=3D"display:none"> Gerrit-Change-Number: 1965 </div>
<div style=3D=
"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerr=
it-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld =
&lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-=
Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div st=
yle=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;steffan@karger=2E=
me&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></html>
--orR1lrmKgCw=--


--===============1363100755788795870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1363100755788795870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1363100755788795870==--

