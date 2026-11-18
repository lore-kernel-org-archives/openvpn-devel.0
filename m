Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA7A606A325
	for <openvpn-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=KzlxNIWR;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AOtcUVhM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DHPtc5ih;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=Vrv8ADwM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9W+34kAr2ghb7Tc2w5S67o5UQucsiI2xHRx3r8TuJvM=; b=KzlxNIWRZRoqIeDcBuSfY9iNou
	4e8w6DnPrMeeSQurI83NmI/yl60J0YXvoTdWmZLqZppz6XvdT39ug5grqBZZZZ9t5wup7gYQ8thbI
	qIcqScAmLRO+iJ8JT5kFNlZN4SceiY7s4hQPCdCD/fjgSHokqLrm3TJiY4mg0dPWrcFo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTiKE-000000004q4-1AXd;
	Wed, 18 Nov 2026 16:15:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTiKB-000000004pi-3eRy
 for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:15:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bjd/qlF2ImVLUWIS+iJ+E8fF2tRbroZ96ZEBiDFQNJ0=; b=AOtcUVhMqxGsmcTrMcA/iniKJb
 NRIk26cB/FBYo/DqGmOteKSbvI3Ln59JvpYK9EhDJEio79y8QIOVPuj5V72/5vD+Dnqj6+62LZTpJ
 3ZO8V1yWxJpuXB86e4mpukgBcmnD0O5BwBVl1F7YARtKb+vORTGdyRXdpVodywV7P+JU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bjd/qlF2ImVLUWIS+iJ+E8fF2tRbroZ96ZEBiDFQNJ0=; b=DHPtc5ihFqlVaC1kOsObLurbjq
 LJAdU2UgCLFA6txoVx6CjEZbDp0onXNu8urEC3E+gU7QBBNDILOBxS5nBZPW/wku5YU26RmEOVFo3
 Snpyy4fgesB06qY0u+xVYDSkklgIhYugyYw5MqlJ1kdpNQTZ+TNrlq7m0bsXB8+UxglA=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTiK6-000000005bg-3hHL for openvpn-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 16:15:54 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a214c5c4c0so12606375e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Wed, 18 Nov 2026 08:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1795018544; x=1795623344; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bjd/qlF2ImVLUWIS+iJ+E8fF2tRbroZ96ZEBiDFQNJ0=;
 b=Vrv8ADwMiHWaKgfUC1HU64kgGTvNLa2nHYd/eGOp2WK35vy0MqXtx/r4GSLC1SRBab
 aIPjKZJpQidDXAy7N+pjFZi4Xl7kTwr365voJkVREfxYmyz9HWq3hbt1/6kmkj3V2vdC
 b3QaWh20aZJPnSGJebfgNCiekr3D0XGnxBhWPRytI4bs46EVfJ0NMaC/qNzbrGmvh/Vz
 gQbNJz45hzsqQCKOEqg6i/V2CpzJGdt5w76ugap8k+mXwsA4/8hzWzb+zjMOuCwtoBdk
 LMhJ0Qm4Ic+nyLufwZuVAm4FYuq22zKl/jE5o/b9Qx+TTOJZ9uJG4gU9T50xNnACos9l
 9hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795018544; x=1795623344;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=bjd/qlF2ImVLUWIS+iJ+E8fF2tRbroZ96ZEBiDFQNJ0=;
 b=n633te9C80L8QI7i0KxNBlqFc9j9b6/zbguXWUuOG+b8zzzMTPNs7nXvYTat0IRl8P
 K7c8bI2CHwtOpiLIohiMuiuFflNLJHkhyrHV8VeUcC/Lb+w8p7Rji8g9ZqxumIYeuOi9
 52iu+a5YBxfV4dFYBJgRfsq9RkV/r9rL10gAn46WNkE4+TfacWEdcruDOVMHWFUEuclN
 lixEgQnuYmoEaTLJtd+JuKLlNjCq/lIbT0VaRsbEErBREtbq7aQeFGhFSeY5JSJY7c8+
 aEcUeshHtKiah0ckHW1lloJuvHZLwJNNbV0aIMD5jhH9lWPuEPWysg1Auo79d1DcORco
 CUSw==
X-Gm-Message-State: APuU4Z9hebtDZDZGqwi1/FTCm/XJ3K5yIV1rWz0XuSYhwhb2L/9n+Wzd
 odQPOPRnV9LvtU+k5VgwNaDhuL8KI5FFPXlQy2yiGkxfHk2XW2nqUgWqsHtgxudr2fy31UKUw/x
 Kx0R1OCERgPyqXqTxIIcvteqR09ChTjudLrgXUSlaYb//xqWrSqKBYeUA541YWe+xKBYO
X-Gm-Gg: AYBFou0i31hLMGRuY07kdn/DrtSlgLnoRIZMaJ0+VtEbPGb3e1HVMkV42E/GxF5R4rm
 NHzTdekTUif2770AP0WTJsQdVq9mN4nBCdrbC7s66U0TDCCuC/cn0LN1usnUwGOZEpWvYSfFXqI
 WBoV648LJXqCDBJbzq9XJh1CDNOuQzw5TUjuWtT17s6Y39CKGyDKmWn/j3DLYoLp0MVeNtopKML
 StMNK2MtR5TOVQ5KGqDMo8V6ItEV42WTA/vpU5zq/77ZIPUH8i8J/FV6VpnJj+nfbk6dvO3QvU1
 89Ghe6N4SRt8+NByGQy1hzA2GSErqTnGAXdWcB4g575Nwj1WwWLqORlWb0E6OBdRaKNo9r8P/O5
 r/nHVRCmgNHUnRkZg1Z9tamgDhJqBG9pSXALRS8N/sep7zit1pnHB9/Vqlm9Fv8Jnq7wKONzldx
 Bpr28F3ot2c6EY1bPF2st+VG4/y1S/J4xqQ5tda0o1R26sKwM+cfCojdCKLiK8vJw1JsRiLMWxl
 BVOG6XaQ8XnBVE8yGyTflvWVKZXILkFgwNGEiHFvP2Sh1dwovR2SzIba9NEa6C/kKGQ+Qgvw0bK
 tKgzEoVMeLGiTFGIbAe7RhDj9PAj9UQw7hzKRBwROA6jdaq6WqJecPoJhh37xubpAi8SRpECeWh
 Hhu++dVE/isTl3jesEU6nnL8/P753aWClwSREZxGQggkCeFufmEPN8I46smXvwZysEnr6GVT5tu
 aCFaozauIP3BkDepo=
X-Received: by 2002:a05:600c:3541:b0:4a3:d327:6ed with SMTP id
 5b1f17b1804b1-4bb7da23d3bmr62436805e9.17.1795018543629; 
 Wed, 18 Nov 2026 08:15:43 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7840b05bsm225292185e9.7.2026.11.18.08.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 08:15:43 -0800 (PST)
X-Google-Original-From: "Gert Doering (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Wed, 18 Nov 2026 16:15:42 +0000
To: Lev Stipakov <lstipakov@gmail.com>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Steffan Karger <steffan@karger.me>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 9
X-Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
X-Gerrit-Change-Number: 1965
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1965?usp=email>
X-Gerrit-Commit: cb48d4f77f9077bb3017b865b4e622bc0654399f
In-Reply-To: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
References: <gerrit.1790756729000.I89c3133e009dc75dc2c10c607b3f0a24c04e8146@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzkwNzU2NzI5MDAwLkk4OWMzMTMzZTAwOWRjNzVkYzJjMTBjNjA3YjNmMGEyNGMwNGU4MTQ2QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <0885d3f561bb27675f511f4ef50b4d2772cf8dcf-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTiK6-000000005bg-3hHL
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
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6588852661697285039=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6588852661697285039==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p3sUl/onkdg="; charset=UTF-8

--p3sUl/onkdg=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Gert Doering has uploaded a new patch set (#9) to the change originally cre=
ated by Lev Stipakov=2E ( https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?u=
sp=3Demail )

The following approvals got outdated and were removed:
Code-R=
eview+1 by R=C4=83zvan Cojocaru, Code-Review+2 by Steffan Karger


Change s=
ubject: control_msg: Add a shared TLV codec and use it for early negotiatio=
n
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

control_ms=
g: Add a shared TLV codec and use it for early negotiation

Early negotiati=
on in the reset packets is a sequence of TLVs, and
planned out-of-band and =
control data messages will use the same TLV
format and type space=2E Add on=
e TLV codec for all of them,
control_msg=2Ec/h, and move early negotiation =
onto it=2E

The codec only handles the framing: reading and writing TLV hea=
ders,
writing a 16-bit TLV, and walking a payload TLV by TLV with each valu=
e
checked against the payload=2E How to treat an unknown type is up to each=

message=2E With the optional flag clear the codec writes the same bytes as=

the hand-rolled code it replaces=2E

In the codec the most significant bit=
 of the type field is the
"optional" flag rather than part of the type=2E T=
he old parser compared
the whole type word, so 0x8001 did not match the fla=
gs TLV and was
skipped as unknown; now it matches and is parsed as one=2E

=
Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c04e8146
Signed-off-by: Lev Sti=
pakov <lev@openvpn=2Enet>
Acked-by: Steffan Karger <steffan@karger=2Eme>
Ge=
rrit URL: https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965
Message-Id: <2026=
1116172950=2E23858-1-gert@greenie=2Emuc=2Ede>
URL: https://www=2Email-archi=
ve=2Ecom/openvpn-devel@lists=2Esourceforge=2Enet/msg41473=2Ehtml
Signed-off=
-by: Gert Doering <gert@greenie=2Emuc=2Ede>
---
M CMakeLists=2Etxt
M src/op=
envpn/Makefile=2Eam
A src/openvpn/control_msg=2Ec
A src/openvpn/control_msg=
=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=
=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/te=
st_control_msg=2Ec
A tests/unit_tests/openvpn/test_control_msg=2Eh
M tests/=
unit_tests/openvpn/test_pkt=2Ec
11 files changed, 493 insertions(+), 23 del=
etions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/chan=
ges/65/1965/9

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 4f489=
90=2E=2E50b2d68 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -45=
7,6 +457,8 @@
     src/openvpn/console=2Ec
     src/openvpn/console_builtin=
=2Ec
     src/openvpn/console=2Eh
+    src/openvpn/control_msg=2Ec
+    src=
/openvpn/control_msg=2Eh
     src/openvpn/crypto=2Ec
     src/openvpn/crypt=
o=2Eh
     src/openvpn/crypto_backend=2Eh
@@ -896,6 +898,8 @@
 
     target=
_sources(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_exec=
ve=2Ec
+        tests/unit_tests/openvpn/test_control_msg=2Ec
+        src/=
openvpn/control_msg=2Ec
         src/openvpn/argv=2Ec
         src/openvpn/=
base64=2Ec
         src/openvpn/crypto_epoch=2Ec
diff --git a/src/openvpn/M=
akefile=2Eam b/src/openvpn/Makefile=2Eam
index bb31053=2E=2Ebe1044d 100644
=
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -57,6 +5=
7,7 @@
 	common=2Eh \
 	comp=2Ec comp=2Eh compstub=2Ec \
 	comp-lz4=2Ec com=
p-lz4=2Eh \
+	control_msg=2Ec control_msg=2Eh \
 	crypto=2Ec crypto=2Eh cry=
pto_backend=2Eh \
 	crypto_openssl=2Ec crypto_openssl=2Eh \
 	crypto_mbedtl=
s=2Ec crypto_mbedtls=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/o=
penvpn/control_msg=2Ec
new file mode 100644
index 0000000=2E=2Ee14355c
--- =
/dev/null
+++ b/src/openvpn/control_msg=2Ec
@@ -0,0 +1,93 @@
+/*
+ *  OpenV=
PN -- An application to securely tunnel IP networks
+ *             over a =
single TCP/UDP port, with support for SSL/TLS-based
+ *             session=
 authentication and key exchange,
+ *             packet encryption, packet=
 authentication, and
+ *             packet compression=2E
+ *
+ *  Copyrig=
ht (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is=
 free software; you can redistribute it and/or modify
+ *  it under the ter=
ms of the GNU General Public License version 2
+ *  as published by the Fre=
e Software Foundation=2E
+ *
+ *  This program is distributed in the hope t=
hat it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the impl=
ied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E=
  See the
+ *  GNU General Public License for more details=2E
+ *
+ *  You =
should have received a copy of the GNU General Public License along
+ *  wi=
th this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
=
+#ifdef HAVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=
=2Eh"
+
+#include "control_msg=2Eh"
+
+bool
+ctrl_msg_tlv_write_header(stru=
ct buffer *buf, uint16_t type, bool optional, uint16_t value_len)
+{
+    /=
* the type has 15 bits; the top bit is the optional flag */
+    ASSERT(typ=
e <=3D CTRL_MSG_TLV_TYPE_MASK);
+
+    /* Write nothing unless the whole TL=
V fits=2E The header promises that
+     * value_len bytes follow it, so a =
header written without room for the
+     * value would leave a partial TLV=
 in buf=2E */
+    if (!buf_safe(buf, (size_t)CTRL_MSG_TLV_HEADER_LEN + val=
ue_len))
+    {
+        return false;
+    }
+    uint16_t field =3D type;=

+    if (optional)
+    {
+        field |=3D CTRL_MSG_TLV_OPTIONAL_FLAG;
=
+    }
+    return buf_write_u16(buf, field) && buf_write_u16(buf, value_le=
n);
+}
+
+bool
+ctrl_msg_tlv_write_u16(struct buffer *buf, uint16_t type, b=
ool optional, uint16_t value)
+{
+    return ctrl_msg_tlv_write_header(buf,=
 type, optional, sizeof(uint16_t))
+           && buf_write_u16(buf, value)=
;
+}
+
+bool
+ctrl_msg_tlv_peek_header(const struct buffer *buf, struct ctr=
l_msg_tlv_header *hdr)
+{
+    if (BLEN(buf) < CTRL_MSG_TLV_HEADER_LEN)
+  =
  {
+        return false; /* fewer than 4 bytes left: truncated header */
=
+    }
+    /* read from a copy, so that buf is left where it was */
+    s=
truct buffer tmp =3D *buf;
+    uint16_t field =3D (uint16_t)buf_read_u16(&=
tmp);
+    hdr->value_len =3D (uint16_t)buf_read_u16(&tmp);
+    hdr->type =
=3D field & CTRL_MSG_TLV_TYPE_MASK;
+    hdr->optional =3D (field & CTRL_MS=
G_TLV_OPTIONAL_FLAG) !=3D 0;
+    return true;
+}
+
+bool
+ctrl_msg_tlv_nex=
t(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value=
)
+{
+    if (!ctrl_msg_tlv_peek_header(buf, hdr))
+    {
+        return f=
alse;
+    }
+    /* Consume nothing unless the whole TLV is there, so that=
 a value shorter
+     * than the header claims leaves buf untouched=2E */
=
+    if (BLEN(buf) < CTRL_MSG_TLV_HEADER_LEN + hdr->value_len)
+    {
+    =
    return false;
+    }
+    ASSERT(buf_advance(buf, CTRL_MSG_TLV_HEADER_L=
EN));
+    const uint8_t *v =3D buf_read_alloc(buf, hdr->value_len);
+    A=
SSERT(v);
+    buf_set_read(value, v, hdr->value_len);
+    return true;
+}=

diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/control_msg=2Eh
new=
 file mode 100644
index 0000000=2E=2E92572cb
--- /dev/null
+++ b/src/openvp=
n/control_msg=2Eh
@@ -0,0 +1,108 @@
+/*
+ *  OpenVPN -- An application to s=
ecurely tunnel IP networks
+ *             over a single TCP/UDP port, with=
 support for SSL/TLS-based
+ *             session authentication and key e=
xchange,
+ *             packet encryption, packet authentication, and
+ * =
            packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN =
Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can r=
edistribute it and/or modify
+ *  it under the terms of the GNU General Pub=
lic License version 2
+ *  as published by the Free Software Foundation=2E
=
+ *
+ *  This program is distributed in the hope that it will be useful,
+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Genera=
l Public License for more details=2E
+ *
+ *  You should have received a co=
py of the GNU General Public License along
+ *  with this program; if not, =
see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * TLV fr=
aming shared by the TLV-based control messages of the wire protocol=2E
+ *
=
+ * Such a message payload is a sequence of TLV entries=2E Each TLV starts =
with a
+ * 4-byte header: a 16-bit field whose most significant bit is the =
"optional"
+ * flag and whose remaining 15 bits are the type, followed by a=
 16-bit length
+ * giving the size of the value that follows the header=2E
=
+ *
+ * All of these messages share one TLV type space, so the TLV types ar=
e all
+ * defined here=2E Only the framing is handled here: what a message =
does with a
+ * TLV type it does not know, marked optional or not, is up to=
 its parser=2E
+ */
+
+#ifndef CONTROL_MSG_H
+#define CONTROL_MSG_H
+
+#inc=
lude "buffer=2Eh"
+
+/* TLV types */
+#define TLV_TYPE_EARLY_NEG_FLAGS 0x00=
01 /* early negotiation, in the reset packets */
+
+/* A TLV header is a 16=
-bit type/optional field plus a 16-bit length */
+#define CTRL_MSG_TLV_HEAD=
ER_LEN 4
+
+/* bit layout of the first 16-bit field */
+#define CTRL_MSG_TL=
V_OPTIONAL_FLAG 0x8000
+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff
+
+/** Th=
e header every TLV carries: the 15-bit type and optional flag packed into
+=
 * the first 16-bit field, then the length of the value that follows=2E */
=
+struct ctrl_msg_tlv_header
+{
+    uint16_t type;      /**< the 15-bit TLV=
 type */
+    bool optional;      /**< value of the optional flag */
+    u=
int16_t value_len; /**< length of the value following the header */
+};
+
+=
/**
+ * Write a TLV header (type + optional flag + value length) to buf=2E
=
+ * type must fit in the 15 bits of the type field=2E
+ *
+ * Nothing is wr=
itten unless the header and the value_len bytes of value
+ * that follow it=
 both fit, so a failed write never leaves a partial TLV
+ * behind=2E
+ *
+=
 * @return true on success, false if buf has insufficient space=2E
+ */
+bo=
ol ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool option=
al,
+                               uint16_t value_len);
+
+/**
+ * Write a=
 complete TLV whose value is a single 16-bit integer to buf=2E
+ *
+ * @ret=
urn true on success, false if buf has insufficient space=2E
+ */
+bool ctrl=
_msg_tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16=
_t value);
+
+/**
+ * Read a TLV header from buf without consuming it=2E
+ =
*
+ * @param buf  buffer positioned at the TLV header
+ * @param hdr  fille=
d with the type, optional flag and value length on success
+ * @return true=
 on success, false if there are not enough bytes for a header=2E
+ */
+bool=
 ctrl_msg_tlv_peek_header(const struct buffer *buf, struct ctrl_msg_tlv_hea=
der *hdr);
+
+/**
+ * Read the next TLV from buf, advancing past its header=
 and value=2E Call it
+ * while BLEN(buf) > 0 to walk a whole payload=2E
+ =
*
+ * The length from the header is validated against buf, so on success th=
e
+ * whole value is present: a header claiming more bytes than buf holds i=
s
+ * rejected=2E Nothing is consumed unless the whole TLV is there, so a f=
ailed
+ * read never leaves a partial TLV behind=2E
+ *
+ * @param buf    b=
uffer positioned at a TLV header
+ * @param hdr    filled with the TLV's ty=
pe, optional flag and value length
+ * @param value  set to a buffer coveri=
ng exactly the TLV's value; it points
+ *               into buf and owns n=
o storage
+ * @return true on success, false if the header or the value is =
truncated,
+ *         with buf left untouched=2E
+ */
+bool ctrl_msg_tlv_n=
ext(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *val=
ue);
+
+#endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/ssl=2Ec =
b/src/openvpn/ssl=2Ec
index 00e1712=2E=2Ee06659a 100644
--- a/src/openvpn/s=
sl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -52,6 +52,7 @@
 #include "pkcs11=2Eh"
 =
#include "route=2Eh"
 #include "tls_crypt=2Eh"
+#include "control_msg=2Eh"
=
 
 #include "crypto_epoch=2Eh"
 #include "ssl=2Eh"
@@ -2662,26 +2663,21 @@
=
 {
     while (buf->len > 0)
     {
-        if (buf_len(buf) < 4)
-       =
 {
-            goto error;
-        }
-        /* read type */
-        in=
t type =3D buf_read_u16(buf);
-        int len =3D buf_read_u16(buf);
-    =
    if (type < 0 || len < 0 || buf_len(buf) < len)
+        struct ctrl_msg=
_tlv_header hdr;
+        struct buffer value;
+        if (!ctrl_msg_tlv_n=
ext(buf, &hdr, &value))
         {
             goto error;
         }
 
- =
       switch (type)
+        switch (hdr=2Etype)
         {
             c=
ase TLV_TYPE_EARLY_NEG_FLAGS:
-                if (len !=3D sizeof(uint16_t=
))
+                if (BLEN(&value) !=3D sizeof(uint16_t))
               =
  {
                     goto error;
                 }
-                in=
t flags =3D buf_read_u16(buf);
+                int flags =3D buf_read_u16(=
&value);
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
        =
         {
@@ -2700,8 +2696,8 @@
                 break;
 
             def=
ault:
-                /* Skip types we do not parse */
-                bu=
f_advance(buf, len);
+                /* Skip types we do not parse, marked=
 optional or not */
+                break;
         }
     }
     reliable=
_mark_deleted(ks->rec_reliable, buf);
diff --git a/src/openvpn/ssl_pkt=2Ec =
b/src/openvpn/ssl_pkt=2Ec
index 60573ee=2E=2Edad58c3 100644
--- a/src/openv=
pn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -33,6 +33,7 @@
 #include "r=
eliable=2Eh"
 #include "siphash=2Eh"
 #include "tls_crypt=2Eh"
+#include "c=
ontrol_msg=2Eh"
 
 /*
  * Dependent on hmac size, opcode size, and session_=
id size=2E
@@ -437,9 +438,8 @@
     /* Add indication for tls-crypt-v2 to r=
esend the WKc with the reply */
     if (request_resend_wkc)
     {
-      =
  buf_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE: flags */
-       =
 buf_write_u16(&buf, sizeof(uint16_t));
-        buf_write_u16(&buf, EARLY_=
NEG_FLAG_RESEND_WKC);
+        ASSERT(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE=
_EARLY_NEG_FLAGS, false,
+                                      EARLY_NEG_F=
LAG_RESEND_WKC));
     }
 
     /* Add tls-auth/tls-crypt wrapping, this mi=
ght replace buf with
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl=
_pkt=2Eh
index 8203e4a=2E=2E218c6bb 100644
--- a/src/openvpn/ssl_pkt=2Eh
++=
+ b/src/openvpn/ssl_pkt=2Eh
@@ -306,10 +306,8 @@
 #define EARLY_NEG_START 0=
x0f000000
 
 
-/* Early negotiation that part of the server response in the=
 RESET_V2 packet=2E
- * Since clients that announce early negotiation suppo=
rt will treat the payload
- * of reset packets special and parse it as TLV =
messages=2E
- * as TLV (type, length, value) */
-#define TLV_TYPE_EARLY_NEG=
_FLAGS  0x0001
+/* Early negotiation: clients that announce support for it =
parse the payload of
+ * the reset packets as TLVs (see control_msg=2Eh)=2E=
 Flags carried in the value of
+ * the TLV_TYPE_EARLY_NEG_FLAGS TLV: */
 #d=
efine EARLY_NEG_FLAG_RESEND_WKC 0x0001
 #endif /* ifndef SSL_PKT_H */
diff =
--git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/M=
akefile=2Eam
index 6091264=2E=2Ee3404754 100644
--- a/tests/unit_tests/open=
vpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -164,11 +=
164,15 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcd=
ir)/src/openvpn \
 	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS=
@
-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh mock_w=
in32_execve=2Ec test_common=2Eh \
+pkt_testdriver_SOURCES =3D test_pkt=2Ec =
\
+	test_control_msg=2Ec test_control_msg=2Eh \
+	mock_msg=2Ec mock_msg=2Eh=
 mock_win32_execve=2Ec \
+	test_common=2Eh \
 	$(top_srcdir)/src/compat/com=
pat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/sr=
c/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
+	$(top_src=
dir)/src/openvpn/control_msg=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=2Ec \=

 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/openvpn=
/crypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/openvpn/test_control_ms=
g=2Ec b/tests/unit_tests/openvpn/test_control_msg=2Ec
new file mode 100644
=
index 0000000=2E=2Ead4c565
--- /dev/null
+++ b/tests/unit_tests/openvpn/tes=
t_control_msg=2Ec
@@ -0,0 +1,181 @@
+/*
+ *  OpenVPN -- An application to s=
ecurely tunnel IP networks
+ *             over a single TCP/UDP port, with=
 support for SSL/TLS-based
+ *             session authentication and key e=
xchange,
+ *             packet encryption, packet authentication, and
+ * =
            packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN =
Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free software; you can r=
edistribute it and/or modify
+ *  it under the terms of the GNU General Pub=
lic License version 2
+ *  as published by the Free Software Foundation=2E
=
+ *
+ *  This program is distributed in the hope that it will be useful,
+ =
*  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Genera=
l Public License for more details=2E
+ *
+ *  You should have received a co=
py of the GNU General Public License along
+ *  with this program; if not, =
see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#i=
nclude "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=
=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
=
+
+#include "control_msg=2Eh"
+#include "ssl_pkt=2Eh"
+#include "test_commo=
n=2Eh"
+#include "test_control_msg=2Eh"
+
+/* The early negotiation flags T=
LV of a reset packet asking a tls-crypt-v2
+ * client to resend its WKc=2E =
*/
+void
+test_tlv_write_u16_wire_format(void **state)
+{
+    struct gc_ar=
ena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+
+ =
   assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false=
,
+                                       EARLY_NEG_FLAG_RESEND_WKC));
+   =
 const uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x01 };
+    =
assert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BP=
TR(&buf), expected, sizeof(expected));
+
+    /* the optional flag is the m=
ost significant bit of the type field */
+    buf_clear(&buf);
+    assert_=
true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));
+   =
 assert_int_equal(BPTR(&buf)[0], 0x80);
+    assert_int_equal(BPTR(&buf)[1]=
, 0x01);
+
+    gc_free(&gc);
+}
+
+/* A TLV header survives the round trip=
, the optional flag kept apart from
+ * the 15-bit type=2E */
+void
+test_t=
lv_header_roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
=
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+
+    assert_true(ctrl_m=
sg_tlv_write_header(&buf, 0x1234, true, 5));
+    assert_int_equal(BLEN(&bu=
f), 4);
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tl=
v_peek_header(&buf, &hdr));
+    assert_int_equal(hdr=2Etype, 0x1234);
+   =
 assert_true(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, 5);
+ =
   assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN); /* peek consumes =
nothing */
+
+    gc_free(&gc);
+}
+
+/* Walking a payload returns each TLV=
 in turn, with a value covering exactly
+ * its bytes, and consumes the pay=
load=2E */
+void
+test_tlv_next_walks_payload(void **state)
+{
+    struct =
gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(64, &gc);=

+
+    assert_true(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_EARLY_NEG_FLAGS, =
false, 0xabcd));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, tr=
ue, 4));
+    assert_true(buf_write_u32(&buf, 0x11223344));
+    assert_tru=
e(ctrl_msg_tlv_write_header(&buf, 0x5, false, 0)); /* empty value */
+
+   =
 struct ctrl_msg_tlv_header hdr;
+    struct buffer value;
+
+    assert_tr=
ue(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    assert_int_equal(hdr=2Etype=
, TLV_TYPE_EARLY_NEG_FLAGS);
+    assert_false(hdr=2Eoptional);
+    assert=
_int_equal(BLEN(&value), 2);
+    assert_int_equal(buf_read_u16(&value), 0x=
abcd);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value));
+    asse=
rt_int_equal(hdr=2Etype, 0x7ff);
+    assert_true(hdr=2Eoptional);
+    ass=
ert_int_equal(BLEN(&value), 4);
+    assert_int_equal(buf_read_u32(&value, =
NULL), 0x11223344);
+
+    assert_true(ctrl_msg_tlv_next(&buf, &hdr, &value=
));
+    assert_int_equal(hdr=2Etype, 0x5);
+    assert_int_equal(BLEN(&val=
ue), 0);
+
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
=
+/* A TLV header claiming more value bytes than the payload holds is reject=
ed,
+ * rather than read past the end of the payload, and leaves buf untouc=
hed=2E */
+void
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
+    assert_int_equal(BLEN(&buf), CTRL_MSG_T=
LV_HEADER_LEN + sizeof(uint32_t));
+
+    gc_free(&gc);
+}
+
+/* Reading a =
TLV header must fail, rather than read past the available data,
+ * when th=
e buffer holds less than a complete 4-byte header, and must leave
+ * buf u=
ntouched=2E */
+void
+test_tlv_header_truncated(void **state)
+{
+    struc=
t gc_arena gc =3D gc_new();
+    const uint8_t bytes[] =3D { 0x00, 0x01, 0x=
00 };
+
+    /* 0 to 3 bytes: none, part of the type field, the type field,=
 and the type
+     * field with half of the length */
+    for (size_t n =
=3D 0; n <=3D sizeof(bytes); n++)
+    {
+        struct buffer buf =3D all=
oc_buf_gc(16, &gc);
+        assert_true(buf_write(&buf, bytes, n));
+
+   =
     struct ctrl_msg_tlv_header hdr;
+        struct buffer value;
+       =
 assert_false(ctrl_msg_tlv_peek_header(&buf, &hdr));
+        assert_false(=
ctrl_msg_tlv_next(&buf, &hdr, &value));
+        assert_int_equal(BLEN(&buf=
), n);
+    }
+
+    gc_free(&gc);
+}
+
+/* Writing fails, rather than writ=
es a partial TLV, when buf is too small=2E */
+void
+test_tlv_write_no_room=
(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+
+    struct buffe=
r buf =3D alloc_buf_gc(3, &gc);
+    assert_false(ctrl_msg_tlv_write_header=
(&buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 2));
+    assert_int_equal(BLEN(&bu=
f), 0);
+
+    /* room for the header but not the value */
+    buf =3D all=
oc_buf_gc(5, &gc);
+    assert_false(ctrl_msg_tlv_write_u16(&buf, TLV_TYPE_=
EARLY_NEG_FLAGS, false, 1));
+    assert_int_equal(BLEN(&buf), 0);
+
+    g=
c_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_control_msg=2Eh =
b/tests/unit_tests/openvpn/test_control_msg=2Eh
new file mode 100644
index =
0000000=2E=2Eef7a030
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_cont=
rol_msg=2Eh
@@ -0,0 +1,37 @@
+/*
+ *  OpenVPN -- An application to securely=
 tunnel IP networks
+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based
+ *             session authentication and key exchange=
,
+ *             packet encryption, packet authentication, and
+ *        =
     packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sa=
les@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistri=
bute it and/or modify
+ *  it under the terms of the GNU General Public Lic=
ense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *=
  This program is distributed in the hope that it will be useful,
+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABI=
LITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publi=
c License for more details=2E
+ *
+ *  You should have received a copy of t=
he GNU General Public License along
+ *  with this program; if not, see <ht=
tps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_CONTROL_MSG_H
+#de=
fine TEST_CONTROL_MSG_H
+
+void test_tlv_write_u16_wire_format(void **state=
);
+
+void test_tlv_header_roundtrip(void **state);
+
+void test_tlv_next_w=
alks_payload(void **state);
+
+void test_tlv_next_value_truncated(void **st=
ate);
+
+void test_tlv_header_truncated(void **state);
+
+void test_tlv_wri=
te_no_room(void **state);
+#endif
diff --git a/tests/unit_tests/openvpn/tes=
t_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 49ba833=2E=2Ef34bd4=
1 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests=
/openvpn/test_pkt=2Ec
@@ -37,12 +37,14 @@
 #include "crypto=2Eh"
 #include =
"options=2Eh"
 #include "ssl_backend=2Eh"
+#include "control_msg=2Eh"
 #inc=
lude "ssl_pkt=2Eh"
 #include "tls_crypt=2Eh"
 
 #include "mss=2Eh"
 #includ=
e "reliable=2Eh"
 #include "siphash=2Eh"
+#include "test_control_msg=2Eh"
 =

 int
 parse_line(const char *line, char **p, const int n, const char *file=
, const int line_num,
@@ -655,6 +657,45 @@
     free_buf(&tas=2Eworkbuf);
 =
}
 
+/* A reset reply asking a tls-crypt-v2 client to resend its WKc ends i=
n the
+ * early negotiation flags TLV, and that TLV parses back=2E */
+stat=
ic void
+test_generate_reset_packet_resend_wkc(void **ut_state)
+{
+    str=
uct tls_auth_standalone tas =3D { 0 };
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
@@ -791,9 +832,16 @@
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
    cmocka_unit_test(test_wkc_not_appended_without_key),
-        cmocka_un=
it_test(test_extract_control_message)
+        cmocka_unit_test(test_extrac=
t_control_message),
+        cmocka_unit_test(test_tlv_write_u16_wire_forma=
t),
+        cmocka_unit_test(test_tlv_header_roundtrip),
+        cmocka_u=
nit_test(test_tlv_next_walks_payload),
+        cmocka_unit_test(test_tlv_n=
ext_value_truncated),
+        cmocka_unit_test(test_tlv_header_truncated),=

+        cmocka_unit_test(test_tlv_write_no_room)
     };
 
     return cm=
ocka_run_group_tests_name("pkt tests", tests, NULL, NULL);

-- 
To view, vi=
sit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1965?usp=3Demail
To unsubscr=
ibe, or for help writing mail filters, visit https://gerrit=2Eopenvpn=2Enet=
/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: open=
vpn
Gerrit-Branch: master
Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a=
24c04e8146
Gerrit-Change-Number: 1965
Gerrit-PatchSet: 9
Gerrit-Owner: Lev =
Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvp=
n@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Eco=
m>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Rev=
iewer: Steffan Karger <steffan@karger=2Eme>
Gerrit-CC: openvpn-devel <openv=
pn-devel@lists=2Esourceforge=2Enet>

--p3sUl/onkdg=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>Gert Doering <str=
ong>uploaded patch set #9</strong> to the change originally created by Lev =
Stipakov=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/196=
5?usp=3Demail">View Change</a></p><p>The following approvals got outdated a=
nd were removed:
Code-Review+1 by R=C4=83zvan Cojocaru, Code-Review+2 by St=
effan Karger</p><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">control_msg: Add a shared TLV codec and use i=
t for early negotiation<br><br>Early negotiation in the reset packets is a =
sequence of TLVs, and<br>planned out-of-band and control data messages will=
 use the same TLV<br>format and type space=2E Add one TLV codec for all of =
them,<br>control_msg=2Ec/h, and move early negotiation onto it=2E<br><br>Th=
e codec only handles the framing: reading and writing TLV headers,<br>writi=
ng a 16-bit TLV, and walking a payload TLV by TLV with each value<br>checke=
d against the payload=2E How to treat an unknown type is up to each<br>mess=
age=2E With the optional flag clear the codec writes the same bytes as<br>t=
he hand-rolled code it replaces=2E<br><br>In the codec the most significant=
 bit of the type field is the<br>&quot;optional&quot; flag rather than part=
 of the type=2E The old parser compared<br>the whole type word, so 0x8001 d=
id not match the flags TLV and was<br>skipped as unknown; now it matches an=
d is parsed as one=2E<br><br>Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c0=
4e8146<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&gt;<br>Acked-by=
: Steffan Karger &lt;steffan@karger=2Eme&gt;<br>Gerrit URL: https://gerrit=
=2Eopenvpn=2Enet/c/openvpn/+/1965<br>Message-Id: &lt;20261116172950=2E23858=
-1-gert@greenie=2Emuc=2Ede&gt;<br>URL: https://www=2Email-archive=2Ecom/ope=
nvpn-devel@lists=2Esourceforge=2Enet/msg41473=2Ehtml<br>Signed-off-by: Gert=
 Doering &lt;gert@greenie=2Emuc=2Ede&gt;<br>---<br>M CMakeLists=2Etxt<br>M =
src/openvpn/Makefile=2Eam<br>A src/openvpn/control_msg=2Ec<br>A src/openvpn=
/control_msg=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M=
 src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A t=
ests/unit_tests/openvpn/test_control_msg=2Ec<br>A tests/unit_tests/openvpn/=
test_control_msg=2Eh<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>11 files=
 changed, 493 insertions(+), 23 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/65/1965/9</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>index=
 4f48990=2E=2E50b2d68 100644</span><br><span>--- a/CMakeLists=2Etxt</span><=
br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -457,6 +457,8 @@</span><=
br><span>     src/openvpn/console=2Ec</span><br><span>     src/openvpn/cons=
ole_builtin=2Ec</span><br><span>     src/openvpn/console=2Eh</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/control_msg=2Ec</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/contro=
l_msg=2Eh</span><br><span>     src/openvpn/crypto=2Ec</span><br><span>     =
src/openvpn/crypto=2Eh</span><br><span>     src/openvpn/crypto_backend=2Eh<=
/span><br><span>@@ -896,6 +898,8 @@</span><br><span> </span><br><span>     =
target_sources(test_pkt PRIVATE</span><br><span>         tests/unit_tests/o=
penvpn/mock_win32_execve=2Ec</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/control_msg=
=2Ec</span><br><span>         src/openvpn/argv=2Ec</span><br><span>        =
 src/openvpn/base64=2Ec</span><br><span>         src/openvpn/crypto_epoch=
=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/M=
akefile=2Eam</span><br><span>index bb31053=2E=2Ebe1044d 100644</span><br><s=
pan>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makef=
ile=2Eam</span><br><span>@@ -57,6 +57,7 @@</span><br><span> 	common=2Eh \</=
span><br><span> 	comp=2Ec comp=2Eh compstub=2Ec \</span><br><span> 	comp-lz=
4=2Ec comp-lz4=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	control_msg=2Ec control_msg=2Eh \</span><br><span> 	crypto=2Ec crypto=2Eh=
 crypto_backend=2Eh \</span><br><span> 	crypto_openssl=2Ec crypto_openssl=
=2Eh \</span><br><span> 	crypto_mbedtls=2Ec crypto_mbedtls=2Eh \</span><br>=
<span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2E=
c</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=2Ee=
14355c</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/cont=
rol_msg=2Ec</span><br><span>@@ -0,0 +1,93 @@</span><br><span style=3D"color=
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
 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool optional,=
 uint16_t value_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the type h=
as 15 bits; the top bit is the optional flag */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(type &lt;=3D CTRL_MSG_TLV_TYPE_MASK)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Write nothing unless the whole=
 TLV fits=2E The header promises that</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * value_len bytes follow it, so a header written wit=
hout room for the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * value would leave a partial TLV in buf=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!buf_safe(buf, (size_t)CTRL_MSG_TLV_H=
EADER_LEN + value_len))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t field =3D=
 type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (optio=
nal)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        field |=3D CTRL_MSG_T=
LV_OPTIONAL_FLAG;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_w=
rite_u16(buf, field) &amp;&amp; buf_write_u16(buf, value_len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_=
tlv_write_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t va=
lue)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_hea=
der(buf, type, optional, sizeof(uint16_t))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, value);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
ctrl_msg_tlv_peek_header(const struct buffer *buf, struct ctrl_msg_tlv_head=
er *hdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(buf) &lt; CTRL_M=
SG_TLV_HEADER_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
false; /* fewer than 4 bytes left: truncated header */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* read from a copy, so that buf is left where it =
was */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer tmp =3D *buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uint16_t field =3D (uint16_t)buf_read_u16(&amp;tmp);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;value_len =3D (uint16_t)buf=
_read_u16(&amp;tmp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    hdr-&gt;type =3D field &amp; CTRL_MSG_TLV_TYPE_MASK;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    hdr-&gt;optional =3D (field &amp;=
 CTRL_MSG_TLV_OPTIONAL_FLAG) !=3D 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_tlv_next(struct buffer *buf, =
struct ctrl_msg_tlv_header *hdr, struct buffer *value)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!ctrl_msg_tlv_peek_header(buf, hdr))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    /* Consume nothing unless the whole TLV is there, so th=
at a value shorter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * than the header claims leaves buf untouched=2E */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(buf) &lt; CTRL_MSG_TLV_HEA=
DER_LEN + hdr-&gt;value_len)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_ad=
vance(buf, CTRL_MSG_TLV_HEADER_LEN));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const uint8_t *v =3D buf_read_alloc(buf, hdr-&gt;valu=
e_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(v=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_set_read(=
value, v, hdr-&gt;value_len);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span>diff --git a/src/openvpn/control_msg=2Eh b/src/ope=
nvpn/control_msg=2Eh</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000=2E=2E92572cb</span><br><span>--- /dev/null</span><br><span>+++=
 b/src/openvpn/control_msg=2Eh</span><br><span>@@ -0,0 +1,108 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunne=
l IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         over a single TCP/UDP port, with support for SSL/TLS-based</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session auth=
entication and key exchange,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             packet encryption, packet authentication, and</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet com=
pression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-20=
26 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  This program is free software; you can redistribute it and/or mod=
ify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the=
 terms of the GNU General Public License version 2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Founda=
tion=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribut=
ed in the hope that it will be useful,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied w=
arranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCH=
ANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for m=
ore details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have re=
ceived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;ht=
tps://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * TLV framing shared by the TLV-based co=
ntrol messages of the wire protocol=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Such a message payload is a sequence of TLV entries=2E Each TLV starts=
 with a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 4-byte he=
ader: a 16-bit field whose most significant bit is the &quot;optional&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * flag and whose r=
emaining 15 bits are the type, followed by a 16-bit length</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * giving the size of the value that=
 follows the header=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * All of thes=
e messages share one TLV type space, so the TLV types are all</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * defined here=2E Only the frami=
ng is handled here: what a message does with a</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * TLV type it does not know, marked optional or=
 not, is up to its parser=2E</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef CONTROL_MSG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CONTROL_MSG_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* TLV types */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early neg=
otiation, in the reset packets */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A =
TLV header is a 16-bit type/optional field plus a 16-bit length */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define CTRL_MSG_TLV_HEADER_=
LEN 4</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* bit layout of the first 16-bit=
 field */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CT=
RL_MSG_TLV_OPTIONAL_FLAG 0x8000</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define CTRL_MSG_TLV_TYPE_MASK     0x7fff</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/** The header every TLV carries: the 15-bit type and option=
al flag packed into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * the first 16-bit field, then the length of the value that follows=2E */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ctrl_msg_tlv_=
header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t type;      /**&lt;=
 the 15-bit TLV type */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    bool optional;      /**&lt; value of the optional flag */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t value_len; /**&l=
t; length of the value following the header */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a TLV header (ty=
pe + optional flag + value length) to buf=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * type must fit in the 15 bits of the type field=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Nothing is written unless the =
header and the value_len bytes of value</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * that follow it both fit, so a failed write never lea=
ves a partial TLV</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 behind=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success=
, false if buf has insufficient space=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool ctrl_msg_tlv_write_header(struct buffer *buf, uint16_t type, bool=
 optional,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                      uint16_t value_len);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a c=
omplete TLV whose value is a single 16-bit integer to buf=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @return true on success, false if buf has insuff=
icient space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_tlv_wr=
ite_u16(struct buffer *buf, uint16_t type, bool optional, uint16_t value);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Read a TLV header from buf without consuming it=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param buf  buffer positioned at th=
e TLV header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am hdr  filled with the type, optional flag and value length on success</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on succ=
ess, false if there are not enough bytes for a header=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool ctrl_msg_tlv_peek_header(const struct buffer *buf=
, struct ctrl_msg_tlv_header *hdr);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read the next TL=
V from buf, advancing past its header and value=2E Call it</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * while BLEN(buf) &gt; 0 to walk a =
whole payload=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The length from t=
he header is validated against buf, so on success the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * whole value is present: a header claim=
ing more bytes than buf holds is</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * rejected=2E Nothing is consumed unless the whole TLV is the=
re, so a failed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * r=
ead never leaves a partial TLV behind=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * @param buf    buffer positioned at a TLV header</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param hdr    filled with the TLV&#39=
;s type, optional flag and value length</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param value  set to a buffer covering exactly the T=
LV&#39;s value; it points</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *               into buf and owns no storage</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if the =
header or the value is truncated,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *         with buf left untouched=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_ms=
g_tlv_header *hdr, struct buffer *value);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* ifndef CONTROL_MSG_H */</span><br><span>diff --git a/src/openv=
pn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index 00e1712=2E=2Ee06659a=
 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src=
/openvpn/ssl=2Ec</span><br><span>@@ -52,6 +52,7 @@</span><br><span> #includ=
e &quot;pkcs11=2Eh&quot;</span><br><span> #include &quot;route=2Eh&quot;</s=
pan><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><b=
r><span> </span><br><span> #include &quot;crypto_epoch=2Eh&quot;</span><br>=
<span> #include &quot;ssl=2Eh&quot;</span><br><span>@@ -2662,26 +2663,21 @@=
</span><br><span> {</span><br><span>     while (buf-&gt;len &gt; 0)</span><=
br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (buf_len(buf) &lt; 4)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     goto error;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* read t=
ype */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int typ=
e =3D buf_read_u16(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int len =3D buf_read_u16(buf);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (type &lt; 0 || len &lt; 0 || buf_len(buf) &=
lt; len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        str=
uct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct buffer value;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!ctrl_msg_tlv_next(buf, &amp;hdr, &amp;value)=
)</span><br><span>         {</span><br><span>             goto error;</span=
><br><span>         }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        switch (type)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        switch (hdr=2Etype)</span><br><span>         {<=
/span><br><span>             case TLV_TYPE_EARLY_NEG_FLAGS:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                if (len !=3D sizeof(u=
int16_t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      if (BLEN(&amp;value) !=3D sizeof(uint16_t))</span><br><span>         =
        {</span><br><span>                     goto error;</span><br><span>=
                 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             int flags =3D buf_read_u16(buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                int flags =3D buf_read_u16(&amp;v=
alue);</span><br><span> </span><br><span>                 if (flags &amp; E=
ARLY_NEG_FLAG_RESEND_WKC)</span><br><span>                 {</span><br><spa=
n>@@ -2700,8 +2696,8 @@</span><br><span>                 break;</span><br><=
span> </span><br><span>             default:</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                /* Skip types we do not parse */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                buf_advan=
ce(buf, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          /* Skip types we do not parse, marked optional or not */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                break;</span=
><br><span>         }</span><br><span>     }</span><br><span>     reliable_=
mark_deleted(ks-&gt;rec_reliable, buf);</span><br><span>diff --git a/src/op=
envpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span>index 60573ee=
=2E=2Edad58c3 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><b=
r><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -33,6 +33,7 @@</sp=
an><br><span> #include &quot;reliable=2Eh&quot;</span><br><span> #include &=
quot;siphash=2Eh&quot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;contr=
ol_msg=2Eh&quot;</span><br><span> </span><br><span> /*</span><br><span>  * =
Dependent on hmac size, opcode size, and session_id size=2E</span><br><span=
>@@ -437,9 +438,8 @@</span><br><span>     /* Add indication for tls-crypt-v=
2 to resend the WKc with the reply */</span><br><span>     if (request_rese=
nd_wkc)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        buf_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS); /* TYPE=
: flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf=
_write_u16(&amp;buf, sizeof(uint16_t));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        buf_write_u16(&amp;buf, EARLY_NEG_FLAG_RESEND_WKC=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(ct=
rl_msg_tlv_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
       EARLY_NEG_FLAG_RESEND_WKC));</span><br><span>     }</span><br><span>=
 </span><br><span>     /* Add tls-auth/tls-crypt wrapping, this might repla=
ce buf with</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/open=
vpn/ssl_pkt=2Eh</span><br><span>index 8203e4a=2E=2E218c6bb 100644</span><br=
><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_=
pkt=2Eh</span><br><span>@@ -306,10 +306,8 @@</span><br><span> #define EARLY=
_NEG_START 0x0f000000</span><br><span> </span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/* Early negotiation that part of the s=
erver response in the RESET_V2 packet=2E</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * Since clients that announce early negotiation support=
 will treat the payload</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * of reset packets special and parse it as TLV messages=2E</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- * as TLV (type, length, value) */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TLV_TYPE_EARLY=
_NEG_FLAGS  0x0001</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* Early negotiation: clients that announce support for it parse the payload=
 of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the reset pac=
kets as TLVs (see control_msg=2Eh)=2E Flags carried in the value of</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * the TLV_TYPE_EARLY_NEG_F=
LAGS TLV: */</span><br><span> #define EARLY_NEG_FLAG_RESEND_WKC 0x0001</spa=
n><br><span> #endif /* ifndef SSL_PKT_H */</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Ea=
m</span><br><span>index 6091264=2E=2Ee3404754 100644</span><br><span>--- a/=
tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tes=
ts/openvpn/Makefile=2Eam</span><br><span>@@ -164,11 +164,15 @@</span><br><s=
pan> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/sr=
c/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span> pkt_testdriver=
_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-pkt_testdriver_SOURCES =3D test_pkt=2Ec mock_msg=2Ec mock_msg=2Eh moc=
k_win32_execve=2Ec test_common=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+pkt_testdriver_SOURCES =3D test_pkt=2Ec \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	test_control_msg=2Ec test_control_m=
sg=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg=
=2Ec mock_msg=2Eh mock_win32_execve=2Ec \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	test_common=2Eh \</span><br><span> 	$(top_srcdir)/sr=
c/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/a=
rgv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/control_msg=2Ec \</=
span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$=
(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)=
/src/openvpn/crypto_mbedtls=2Ec \</span><br><span>diff --git a/tests/unit_t=
ests/openvpn/test_control_msg=2Ec b/tests/unit_tests/openvpn/test_control_m=
sg=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2Ead4c565</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_control_msg=2Ec</span><br><span>@@ -0,0 +1,181 @@</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
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
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAV=
E_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;control=
_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;ssl_pkt=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;test_control_msg=2Eh&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* The early negotiation flags TLV of a reset p=
acket asking a tls-crypt-v2</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * client to resend its WKc=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_tlv_write_u16_wire_format(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                       E=
ARLY_NEG_FLAG_RESEND_WKC));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const uint8_t expected[] =3D { 0x00, 0x01, 0x00, 0x02, 0x00, 0x=
01 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, siz=
eof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the optional fla=
g is the most significant bit of the type field */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_clear(&amp;buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(=
&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, true, 0));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(BPTR(&amp;buf)[0], 0x80);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(=
BPTR(&amp;buf)[1], 0x01);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* A TLV header survives the round trip, the opt=
ional flag kept apart from</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * the 15-bit type=2E */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_tlv_header_roundtrip(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&am=
p;buf, 0x1234, true, 5));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(BLEN(&amp;buf), 4);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_peek_header(&amp;buf, =
&amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(hdr=2Etype, 0x1234);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(hdr=2Eoptional);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, 5);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(=
&amp;buf), CTRL_MSG_TLV_HEADER_LEN); /* peek consumes nothing */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Walkin=
g a payload returns each TLV in turn, with a value covering exactly</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * its bytes, and consumes =
the payload=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+vo=
id</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_next_wal=
ks_payload(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct buffer buf =3D alloc_buf_gc(64, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_u16(&amp;buf, TLV_TYPE=
_EARLY_NEG_FLAGS, false, 0xabcd));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, t=
rue, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u32(&amp;buf, 0x11223344));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf,=
 0x5, false, 0)); /* empty value */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer value;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Et=
ype, TLV_TYPE_EARLY_NEG_FLAGS);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), 2);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_r=
ead_u16(&amp;value), 0xabcd);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, 0x7=
ff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(BLEN(&amp;value), 4);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(buf_read_u32(&amp;value, NULL), 0=
x11223344);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tl=
v_next(&amp;buf, &amp;hdr, &amp;value));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, 0x5);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;valu=
e), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;=
buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* A TLV header claiming more value bytes than the payload holds=
 is rejected,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rat=
her than read past the end of the payload, and leaves buf untouched=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_tlv_next_value_truncated(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer buf =3D alloc_buf_gc(64, &amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FLA=
GS, false, 8));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(buf_write_u32(&amp;buf, 0));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_next(&amp;buf, &amp;hd=
r, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(BLEN(&amp;buf), CTRL_MSG_TLV_HEADER_LEN + sizeof(uint32_t=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* Reading a TLV header must fail, rather than read past the available=
 data,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * when the b=
uffer holds less than a complete 4-byte header, and must leave</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * buf untouched=2E */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+test_tlv_header_truncated(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint8_t bytes[=
] =3D { 0x00, 0x01, 0x00 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 0 to=
 3 bytes: none, part of the type field, the type field, and the type</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * field with half of =
the length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (size_t n =3D 0; n &lt;=3D sizeof(bytes); n++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(16, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(buf=
_write(&amp;buf, bytes, n));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct buffer value;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        assert_false(ctrl_msg_tlv_peek_header(&amp;buf, =
&amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
assert_false(ctrl_msg_tlv_next(&amp;buf, &amp;hdr, &amp;value));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(BLEN(=
&amp;buf), n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Writing fails, rather than writes a partial TLV, when buf is too small=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_tlv_write_no_room(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc=
_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc=
_buf_gc(3, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_EARLY_NEG_FL=
AGS, false, 2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /* room for the header but not the value */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(5, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_tlv_=
write_u16(&amp;buf, TLV_TYPE_EARLY_NEG_FLAGS, false, 1));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), =
0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_control_msg=2Eh b/tests/unit_tests/openvpn/test=
_control_msg=2Eh</span><br><span>new file mode 100644</span><br><span>index=
 0000000=2E=2Eef7a030</span><br><span>--- /dev/null</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_control_msg=2Eh</span><br><span>@@ -0,0 +1,37 =
@@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to s=
ecurely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *             over a single TCP/UDP port, with support for SSL/TLS-=
based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 session authentication and key exchange,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             packet encryption, packet authenticati=
on, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyrigh=
t (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is free software; you can redistribute =
it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 it under the terms of the GNU General Public License version 2</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free So=
ftware Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is distributed in the hope that it will be useful,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Publi=
c License for more details=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define TEST_CONTROL_MSG_H</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void t=
est_tlv_write_u16_wire_format(void **state);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void test_tlv_header_roundtrip(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_tlv_next_walks_payload(void **state);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void test_tlv_next_value_truncated(void **state);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+void test_tlv_header_truncated(void **st=
ate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void test_tlv_write_no_room(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/uni=
t_tests/openvpn/test_pkt=2Ec</span><br><span>index 49ba833=2E=2Ef34bd41 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -37,12 =
+37,14 @@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span>=
 #include &quot;options=2Eh&quot;</span><br><span> #include &quot;ssl_backe=
nd=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;control_msg=2Eh&quot;</span><br><span> #include &quot;ssl_pkt=2Eh&q=
uot;</span><br><span> #include &quot;tls_crypt=2Eh&quot;</span><br><span> <=
/span><br><span> #include &quot;mss=2Eh&quot;</span><br><span> #include &qu=
ot;reliable=2Eh&quot;</span><br><span> #include &quot;siphash=2Eh&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_con=
trol_msg=2Eh&quot;</span><br><span> </span><br><span> int</span><br><span> =
parse_line(const char *line, char **p, const int n, const char *file, const=
 int line_num,</span><br><span>@@ -655,6 +657,45 @@</span><br><span>     fr=
ee_buf(&amp;tas=2Eworkbuf);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* A reset reply asking a tls-=
crypt-v2 client to resend its WKc ends in the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * early negotiation flags TLV, and that TLV pars=
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
pan> {</span><br><span>@@ -791,9 +832,16 @@</span><br><span>         cmocka=
_unit_test(test_verify_hmac_tls_auth),</span><br><span>         cmocka_unit=
_test(test_verify_hmac_none_out_of_range_ack),</span><br><span>         cmo=
cka_unit_test(test_generate_reset_packet_plain),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_generate_reset_p=
acket_resend_wkc),</span><br><span>         cmocka_unit_test(test_generate_=
reset_packet_tls_auth),</span><br><span>         cmocka_unit_test(test_wkc_=
not_appended_without_key),</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        cmocka_unit_test(test_extract_control_message)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_extra=
ct_control_message),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_tlv_write_u16_wire_format),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_he=
ader_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     cmocka_unit_test(test_tlv_next_walks_payload),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_next_va=
lue_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_tlv_header_truncated),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_tlv_write_no_roo=
m)</span><br><span>     };</span><br><span> </span><br><span>     return cm=
ocka_run_group_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span>=
<br></pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/ope=
nvpn/+/1965?usp=3Demail">change 1965</a>=2E To unsubscribe, or for help wri=
ting mail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings=
?usp=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=
=2Eorg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eop=
envpn=2Enet/c/openvpn/+/1965?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Message=
Type: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openv=
pn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div st=
yle=3D"display:none"> Gerrit-Change-Id: I89c3133e009dc75dc2c10c607b3f0a24c0=
4e8146 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1965 </div=
>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"disp=
lay:none"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
=
<div style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn=
@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Fra=
nk Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display=
:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: Steffan Karger &lt;st=
effan@karger=2Eme&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvp=
n-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>

</body></ht=
ml>
--p3sUl/onkdg=--


--===============6588852661697285039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6588852661697285039==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6588852661697285039==--

