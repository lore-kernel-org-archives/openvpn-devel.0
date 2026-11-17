Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5D606A33A
	for <openvpn-devel@archiver.kernel.org>; Tue, 17 Nov 2026 12:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YQ00O+fN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=GcgjOMG9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=F/5HPp0U;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=HPmf5ytW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=UwTIOApGeRgt1y/GR4ClP4qiaFlM7ljxB73XS/DPy94=; b=YQ00O+fNwrfHiP9d1AClI1OKYt
	7m8AZzk6sRpADVykg3vyWbWNFlLamJQODg+ZqndkeQwbA5XTtPa9oX/A/MkUOoe6JTD1dd7LeB9je
	uM4Dl3Yv6IjyAicL6OspDiuZGyVSC9G2I2OV8apTI1XgQsn1d9PwrHj3q12KcfQ6B6rI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xTI5G-000000007u8-2hUK;
	Tue, 17 Nov 2026 12:14:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xTI5F-000000007u2-3I61
 for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 12:14:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vlUAuUVdDD23Y49Uz+Ih4DJZOak+hkZEqOd9UPcD98I=; b=GcgjOMG9ola0SAfX6+a7vHa3Yi
 TB/ImW5Xdt8dzm4ruc5oUTgrjd/F/Wl1mqaDzKwhZJ+4DNoqpUcpQVmQo9RzhhLGzlTx3OnM3AIdH
 eoh5C5QciVCerTFIk9ibkbQYI3Ngi8Ipoy8Pspo9zBc/xiwzGFGzT2ZMODYT3QYxv3V4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vlUAuUVdDD23Y49Uz+Ih4DJZOak+hkZEqOd9UPcD98I=; b=F/5HPp0UOYV2blhN3JNSSxYX64
 tskWKHam6MdmUSpL5Lfum0o6psOTK3pfG6kVoso2TDfHlhT0/wq9HIbo1sAN6BLTTDh4AAyUEO8V2
 ToeJneOMFG7Co+Q+uITydiUwkBY7HztOGcrR5OijRRj7tSo1QKBNeR411CyO+bwDVa18=;
Received: from mail-wm1-f49.google.com ([209.85.128.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xTI57-000000004gZ-0mTa for openvpn-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 12:14:45 +0000
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso51840295e9.1
 for <openvpn-devel@lists.sourceforge.net>;
 Tue, 17 Nov 2026 04:14:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794917671; x=1795522471; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vlUAuUVdDD23Y49Uz+Ih4DJZOak+hkZEqOd9UPcD98I=;
 b=HPmf5ytW9bWtuz1Fir7XAJLupO3Qq1H80P+ulBAW13ChDtYn8/Ami+mtZ8I6p6rRqn
 RwJUj0UATlXWuCR2yXXL4ljFD5v78V+dUuSSY7UNeZMEl+ThVdxOZ9H8vtLFIIJU25ab
 UF/vXuVWxstAXWwpfBu7hG7yTO9yChZnKs6Q57xt4f9Z5PlYst0+H6ivyDIdigkfBlSS
 xfGaddcnncsdJ6nPbyR8fEA7fuW2CM0891Wx13qUUL8idQEX47wNTstuqm/70QqMy0Dh
 yBTXk1EnU2A1+6QeTHaKlpDqLBw1jpo6/+1fMvk4uXur3c/tjNhK0kG9uoV7iPQ28IFK
 wV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794917671; x=1795522471;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vlUAuUVdDD23Y49Uz+Ih4DJZOak+hkZEqOd9UPcD98I=;
 b=g4ZgOckauWQ3E0YpvavpFtoeGpxx2t52sYTSQwLoYMMgOk25Ykh9EfatQNb/RACJoU
 jIMw6yRoInE39JuPIkWF+v4naV599H/TM5JkBffTLgLTHkmId8QpNMFtjzkCIOJ2aoRG
 HSbxHcPUPOKsBh1WNZEcOgmC2mdj426BToT8K3od8vmGcWe3Om9LYTgZR6YT2cAlKfMx
 apnY4+HH/S3BM5psK7s3y3G0oGKCKQMtMyfctuCLw+AaL7060KXOgYBtTH4Jn+cDc3/S
 AooV7IV7KoZqb1eC6NffUdWMWRLIq1cZ3lN3TOWJQiijOpWXVRDSu53Z9auTUAb5vWYb
 X3Ww==
X-Gm-Message-State: APuU4Z/Evg/YEOrUrSMWleNLvZbaYdf5rmUp8p3l/lyNbjQu1bbaFMX+
 8aWgMVUiybff4HOGM48vuZstdAjUgfrNLSUqoNY2bFIAXormVFEwauwwWXckrKD1BlWm8nnBVXe
 Hpmd3GBbgeTRNztnhV7gqulExf1dYFsBGzDPS1p2Q5NNuGoxOjCuLwkOGKP6I/iOWuDBq
X-Gm-Gg: AYBFou2EHcUXINcmFzdxRNj4+hxC7gVwwpm1NkaVsAR+ZuF2RMkvPBqIO+IMVCFMWLc
 iusmR15KAaV/oRa16oNQvOmUotfYFJeiINSF3HQSk+j0Z+JfnRD77tSa3pVfj+4YIbOlcil+3nz
 DPoTK1HhucrjFGhlimf+Y8CynnT1K/VO/8gZjVs3b10E+nQiRnD4CxtkkteFLIw/dlBzA8yhPAQ
 ZWOGP6fsbhGO35kM+NA2XuYWKyx2lvvd9yuK6Xpvd+lxej5rfi6c7juoBWOeFZbytjMXytDRCdx
 vk1q5nVzMD1RBfxTon7UqXCH/bfI0TFbP/BeV9KUMckjVoumQZxECnOHDA2l+styhs2khqyXwZq
 /sUbxftKmN+fuBPUw2PYfrsC9J53OH5zZC6Kx1tgMb0tpHYPvAwyZ3WhXu8HY1EgsZz2qoR5DLO
 CU6FNCHJI7w2iWAnohiiIsaih5faxjXnHGaFeDCbPfEPzuceIg/SXlrZBSlLj/ve9daPJp4W9TP
 8zUSP30Q5Nzf0fgdiyzzvOVBTW7+I6KT3Cb0Tt79jyAkUt3ZT0VnJAU7rpNLd1e7hAvugUCt/iT
 YNN8bWFujwgI+D8D+OZlJpXMJdf2wnIj5ps6IIBShBNeaH1N/8FJjyRMVJGgXle82ANV1oR224v
 u+tAvZ2CUo0/UfdtwfwnBQaNS0G0UWAIuhzrhzH3meRNvn/Xx/4PXOVRkn9mSJ77UffSMJhOcFo
 /Dk7C+AleHVnN9Qrw=
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id
 5b1f17b1804b1-4bb55a58e1amr309069605e9.20.1794917669750; 
 Tue, 17 Nov 2026 04:14:29 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f7eecsm112857915e9.3.2026.11.17.04.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:14:29 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Tue, 17 Nov 2026 12:14:26 +0000
To: Ralf Lici <ralf@mandelbit.com>, chugly <charlie.vigue@openvpn.com>,
 Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 27
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 1bf5d4802590689fd3d337aad4408f227c0713e9
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <7626473faf00eeaa54fd3c4710bd84c902fa9749-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xTI57-000000004gZ-0mTa
Subject: [Openvpn-devel] [L] Change in openvpn[master]: control_msg: Add
 P_CONTROL_V2 and the probe request and reply TLVs
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Lev Stipakov \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: lstipakov@gmail.com, arne-openvpn@rfc2549.org,
 openvpn-devel@lists.sourceforge.net, ralf@mandelbit.com, frank@lichtenheld.com,
 charlie.vigue@openvpn.com
Cc: "Lev Stipakov \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============4241175539455697802=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============4241175539455697802==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="epAJZ0bcu10="; charset=UTF-8

--epAJZ0bcu10=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici, chugly=2E

Hello Arne Schwabe, Frank Lichtenheld, Ralf=
 Lici, chugly, 

I'd like you to reexamine a change=2E Please visit

    ht=
tps://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail

to look at the n=
ew patch set (#27)=2E

The following approvals got outdated and were remove=
d:
Code-Review+1 by chugly


Change subject: control_msg: Add P_CONTROL_V2 =
and the probe request and reply TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E

control_msg: Add P_CONTROL_V2 and the probe reque=
st and reply TLVs

A client probes a server before connecting by sending a =
P_CONTROL_V2
message carrying a probe request TLV, and the server answers w=
ith a
P_CONTROL_V2 carrying a probe reply=2E The reply tells the client how=
 the
server wants to be ranked against the other remotes, and can also serv=
e
as the second packet of the three-way handshake=2E

Add the two opcodes a=
nd the two TLV codecs the probe needs=2E P_CONTROL_V2
is framed like P_CONT=
ROL_V1 but without the fields of the reliability
layer: a session id and th=
en the TLVs, with no control message id and no
ACK array=2E P_CONTROL_WKC_V=
2 is the same with the wrapped client key
appended, as P_CONTROL_WKC_V1 is =
to P_CONTROL_V1=2E

The TLVs use the shared TLV codec, control_msg=2Ec/h, a=
nd their two types
join the others there=2E The codec gains ctrl_msg_find_t=
lv(), which scans
a payload for the one mandatory TLV of a message=2E The s=
can is strict: a
truncated TLV header or value, a second TLV of the wanted =
type, or an
unknown TLV not marked optional rejects the whole message=2E

B=
oth readers accept a value longer than the fields they know and ignore
the =
excess, which is how the TLVs are meant to be extended=2E The probe
reply r=
eader does reject the two flag combinations the protocol rules
out, as neit=
her can be acted on: the other addresses of a remote cannot
be both the sam=
e server and distinct ones, and the connect_lifetime
cannot be extended to =
those addresses without first calling them the
same server=2E

The reliable=
 control path no longer decides what it handles from an
opcode range=2E P_F=
IRST_OPCODE and P_LAST_OPCODE give way to
opcode_is_reliable_control(), whi=
ch lists the opcodes that carry a
message id and an ACK array, and tls_pre_=
decrypt() and
write_control_auth() test that instead=2E Defining an opcode =
therefore no
longer joins it to that set, so neither the two added here nor=

CONTROL_AUX_V1 after them needs to be carved back out of a range=2E

No op=
code changes hands: the old range covered exactly the seven listed,
plus th=
e two data channel opcodes, which are handled before the check is
reached=
=2E

The probe is not sent or answered yet; that follows=2E

Change-Id: I1c=
8d302ac57c5603d622a7be14be369437388268
Signed-off-by: Lev Stipakov <lev@ope=
nvpn=2Enet>
---
M CMakeLists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvp=
n/control_msg=2Ec
M src/openvpn/control_msg=2Eh
A src/openvpn/probe=2Ec
A s=
rc/openvpn/probe=2Eh
M src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/=
openvpn/ssl_pkt=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_t=
ests/openvpn/test_pkt=2Ec
A tests/unit_tests/openvpn/test_probe=2Ec
A tests=
/unit_tests/openvpn/test_probe=2Eh
13 files changed, 858 insertions(+), 11 =
deletions(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/c=
hanges/41/1741/27

diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 3=
05c26c=2E=2Ec650468 100644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@=
 -565,6 +565,8 @@
     src/openvpn/plugin=2Eh
     src/openvpn/pool=2Ec
   =
  src/openvpn/pool=2Eh
+    src/openvpn/probe=2Ec
+    src/openvpn/probe=2E=
h
     src/openvpn/proto=2Ec
     src/openvpn/proto=2Eh
     src/openvpn/pr=
oxy=2Ec
@@ -899,7 +901,9 @@
     target_sources(test_pkt PRIVATE
         t=
ests/unit_tests/openvpn/mock_win32_execve=2Ec
         tests/unit_tests/ope=
nvpn/test_control_msg=2Ec
+        tests/unit_tests/openvpn/test_probe=2Ec
=
         src/openvpn/control_msg=2Ec
+        src/openvpn/probe=2Ec
       =
  src/openvpn/argv=2Ec
         src/openvpn/base64=2Ec
         src/openvpn=
/crypto_epoch=2Ec
diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Make=
file=2Eam
index be1044d=2E=2E4c8edea 100644
--- a/src/openvpn/Makefile=2Eam=

+++ b/src/openvpn/Makefile=2Eam
@@ -121,6 +121,7 @@
 	ping=2Ec ping=2Eh \
=
 	plugin=2Ec plugin=2Eh \
 	pool=2Ec pool=2Eh \
+	probe=2Ec probe=2Eh \
 	p=
roto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \
diff --git a=
/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec
index e14355c=2E=
=2Ea77413f 100644
--- a/src/openvpn/control_msg=2Ec
+++ b/src/openvpn/contr=
ol_msg=2Ec
@@ -91,3 +91,32 @@
     buf_set_read(value, v, hdr->value_len);
=
     return true;
 }
+
+bool
+ctrl_msg_find_tlv(struct buffer *payload, uin=
t16_t wanted_type, struct buffer *value)
+{
+    bool found =3D false;
+   =
 while (BLEN(payload) > 0)
+    {
+        struct ctrl_msg_tlv_header hdr;
=
+        struct buffer v;
+        if (!ctrl_msg_tlv_next(payload, &hdr, &v=
))
+        {
+            return false;
+        }
+        if (hdr=2Etype=
 =3D=3D wanted_type)
+        {
+            if (found)
+            {
+   =
             return false; /* the TLV may occur only once */
+            }=

+            *value =3D v;
+            found =3D true;
+        }
+      =
  else if (!hdr=2Eoptional)
+        {
+            return false; /* a mand=
atory TLV we do not understand, wherever it sits */
+        }
+    }
+    =
return found;
+}
diff --git a/src/openvpn/control_msg=2Eh b/src/openvpn/con=
trol_msg=2Eh
index 92572cb=2E=2E8ad5530 100644
--- a/src/openvpn/control_ms=
g=2Eh
+++ b/src/openvpn/control_msg=2Eh
@@ -41,6 +41,8 @@
 
 /* TLV types *=
/
 #define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the res=
et packets */
+#define TLV_TYPE_PROBE_REQUEST   0x0002 /* a client probing =
a server, in P_CONTROL_V2 */
+#define TLV_TYPE_PROBE_REPLY     0x0003 /* th=
e server's answer, in P_CONTROL_V2 */
 
 /* A TLV header is a 16-bit type/o=
ptional field plus a 16-bit length */
 #define CTRL_MSG_TLV_HEADER_LEN 4
@@=
 -105,4 +107,28 @@
  */
 bool ctrl_msg_tlv_next(struct buffer *buf, struct =
ctrl_msg_tlv_header *hdr, struct buffer *value);
 
+/**
+ * Scan payload fo=
r the TLV of type wanted_type, skipping any other TLV type
+ * that is mark=
ed optional=2E
+ *
+ * This is for messages that carry exactly one mandator=
y TLV, which is what the
+ * probe messages are=2E Any other TLV that is no=
t marked optional invalidates
+ * the message wherever it appears, as does =
a second TLV of wanted_type, so the
+ * whole sequence is walked even once =
the wanted TLV has been found=2E A message
+ * carrying several mandatory T=
LVs walks them with ctrl_msg_tlv_next() instead=2E
+ *
+ * On success value=
 covers exactly the found TLV's value bytes; as in
+ * ctrl_msg_tlv_next(),=
 a header claiming more bytes than payload holds is
+ * rejected rather tha=
n reported as found=2E payload is consumed as it is read=2E
+ *
+ * @param =
payload      buffer positioned at a TLV header
+ * @param wanted_type  the =
TLV type to look for
+ * @param value        set to a buffer covering the f=
ound TLV's value; it points
+ *                     into payload and owns n=
o storage
+ * @return true if the TLV was found, false if it is absent or p=
resent more
+ *         than once, if a TLV header or value is malformed or=
 truncated, or if
+ *         a TLV we do not understand is not marked opti=
onal=2E
+ */
+bool ctrl_msg_find_tlv(struct buffer *payload, uint16_t wante=
d_type, struct buffer *value);
+
 #endif /* ifndef CONTROL_MSG_H */
diff --=
git a/src/openvpn/probe=2Ec b/src/openvpn/probe=2Ec
new file mode 100644
in=
dex 0000000=2E=2E2497b07
--- /dev/null
+++ b/src/openvpn/probe=2Ec
@@ -0,0 =
+1,94 @@
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
+#include "probe=2Eh"
+#include "control_msg=
=2Eh"
+
+bool
+probe_request_write(struct buffer *buf, const struct probe_r=
equest *r)
+{
+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REQ=
UEST, false, PROBE_REQUEST_LEN)
+           && buf_write_u64(buf, r->reques=
t_id) && buf_write_u64(buf, r->timestamp)
+           && buf_write_u32(buf,=
 r->flags);
+}
+
+bool
+probe_request_read(struct buffer *buf, struct probe=
_request *r)
+{
+    /* One bounds check covers the whole value: every fiel=
d read below then fits
+     * by construction, PROBE_REQUEST_LEN being the=
 sum of their sizes, so none
+     * of them needs its own error handling=
=2E Trailing bytes this version does
+     * not understand are simply left=
 unread=2E */
+    if (buf_len(buf) < PROBE_REQUEST_LEN)
+    {
+        re=
turn false;
+    }
+    r->request_id =3D buf_read_u64(buf, NULL);
+    r->=
timestamp =3D buf_read_u64(buf, NULL);
+    r->flags =3D buf_read_u32(buf, =
NULL);
+    return true;
+}
+
+bool
+probe_reply_write(struct buffer *buf, =
const struct probe_reply *r)
+{
+    return ctrl_msg_tlv_write_header(buf, =
TLV_TYPE_PROBE_REPLY, false, PROBE_REPLY_LEN)
+           && buf_write_u64(=
buf, r->request_id) && buf_write_u16(buf, r->priority)
+           && buf_w=
rite_u16(buf, r->weight) && buf_write_u16(buf, r->max_latency_diff)
+      =
     && buf_write_u16(buf, r->connect_lifetime) && buf_write_u16(buf, r->fl=
ags);
+}
+
+bool
+probe_reply_read(struct buffer *buf, struct probe_reply *=
r)
+{
+    /* One bounds check for the whole value, as in probe_request_rea=
d()=2E */
+    if (buf_len(buf) < PROBE_REPLY_LEN)
+    {
+        return f=
alse;
+    }
+    r->request_id =3D buf_read_u64(buf, NULL);
+    r->priori=
ty =3D (uint16_t)buf_read_u16(buf);
+    r->weight =3D (uint16_t)buf_read_u=
16(buf);
+    r->max_latency_diff =3D (uint16_t)buf_read_u16(buf);
+    r->=
connect_lifetime =3D (uint16_t)buf_read_u16(buf);
+    r->flags =3D (uint16=
_t)buf_read_u16(buf);
+
+    /* The other addresses of the remote cannot be=
 both the same server and
+     * distinct ones=2E And LIFETIME_SHARED exte=
nds the connect_lifetime to those
+     * other addresses, which says nothi=
ng unless ADDRS_EQUAL has declared them
+     * the same server to begin wi=
th=2E */
+    if ((r->flags & PROBE_REPLY_FLAG_ADDRS_EQUAL) && (r->flags & =
PROBE_REPLY_FLAG_PROBE_MORE))
+    {
+        return false;
+    }
+    if =
((r->flags & PROBE_REPLY_FLAG_LIFETIME_SHARED) && !(r->flags & PROBE_REPLY_=
FLAG_ADDRS_EQUAL))
+    {
+        return false;
+    }
+    return true;
+=
}
diff --git a/src/openvpn/probe=2Eh b/src/openvpn/probe=2Eh
new file mode =
100644
index 0000000=2E=2E6001774
--- /dev/null
+++ b/src/openvpn/probe=2Eh=

@@ -0,0 +1,141 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP=
 networks
+ *             over a single TCP/UDP port, with support for SSL/=
TLS-based
+ *             session authentication and key exchange,
+ *     =
        packet encryption, packet authentication, and
+ *             packe=
t compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvp=
n=2Enet>
+ *
+ *  This program is free software; you can redistribute it an=
d/or modify
+ *  it under the terms of the GNU General Public License versi=
on 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This pro=
gram is distributed in the hope that it will be useful,
+ *  but WITHOUT AN=
Y WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FI=
TNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License =
for more details=2E
+ *
+ *  You should have received a copy of the GNU Gen=
eral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/**
+ * @file
+ * Encoding and decoding =
of the server probe TLVs=2E
+ *
+ * A client probes a server by sending a P=
_CONTROL_V2 message whose payload
+ * carries a probe request TLV, and the =
server answers with a P_CONTROL_V2
+ * message carrying a probe reply TLV=
=2E The reply tells the client how the
+ * server wants to be ranked agains=
t the other remotes, and can also serve
+ * as the second packet of the thr=
ee-way handshake=2E
+ *
+ * The TLV framing and the TLV type space are shar=
ed with the other TLV-based
+ * control messages and live in control_msg=2E=
h; this file holds the two probe
+ * TLVs and what their fields mean=2E
+ *=
/
+
+#ifndef PROBE_H
+#define PROBE_H
+
+#include "buffer=2Eh"
+#include "c=
ontrol_msg=2Eh"
+
+/** probe request flags=2E The client is only probing: i=
t does not want to
+ * continue into a handshake, and the server may forget=
 it right away=2E */
+#define PROBE_REQUEST_FLAG_PROBE_ONLY 0x00000001
+
+/=
* probe reply flags */
+/** complete the handshake with P_CONTROL_WKC_V1 ra=
ther than P_CONTROL_V1 */
+#define PROBE_REPLY_FLAG_RESEND_WKC      0x0001
=
+/** the other addresses of this remote are the same server, no need to pro=
be them */
+#define PROBE_REPLY_FLAG_ADDRS_EQUAL     0x0002
+/** the connec=
t_lifetime holds against those other addresses too, so a reply
+ * from one=
 of them can skip the handshake with another=2E Only meaningful
+ * togethe=
r with ADDRS_EQUAL, which is what names those addresses=2E */
+#define PROB=
E_REPLY_FLAG_LIFETIME_SHARED 0x0004
+/** the other addresses of this remote=
 are distinct servers, so probe them too */
+#define PROBE_REPLY_FLAG_PROBE=
_MORE      0x0008
+
+/** probe request TLV, sent by a client to probe a ser=
ver */
+struct probe_request
+{
+    uint64_t request_id; /**< identifies t=
his probe, echoed in the reply */
+    /** The client clock as a UNIX times=
tamp in seconds=2E It is there for the
+     * server, which uses it to bou=
nd how old a request it will answer and so
+     * how long a captured one =
can be replayed=2E The reply does not echo it: a
+     * client times the r=
ound trip itself, by the request_id=2E */
+    uint64_t timestamp;
+    uin=
t32_t flags; /**< PROBE_REQUEST_FLAG_* */
+};
+
+/** probe reply TLV, a ser=
ver's answer to a probe request */
+struct probe_reply
+{
+    uint64_t req=
uest_id;       /**< echoes the request_id of the request */
+    uint16_t p=
riority;         /**< DNS SRV style priority, lower is preferred */
+    ui=
nt16_t weight;           /**< DNS SRV style weight */
+    uint16_t max_lat=
ency_diff; /**< candidate band in ms around the fastest server */
+    /** =
For how many seconds, counted from the moment the client sent its own
+    =
 * probe request, the server will still treat this exchange as the first
+ =
    * two packets of the handshake=2E Within that window the client may sen=
d the
+     * third packet straight away instead of starting a handshake of=
 its own=2E
+     * 0 means it cannot, so it has to begin a fresh one=2E */=

+    uint16_t connect_lifetime;
+    uint16_t flags; /**< PROBE_REPLY_FLAG=
_* */
+};
+
+/* Smallest on-wire value length (the TLV header not counted) =
of each TLV: the
+ * sizes of the fixed fields above, in wire order=2E A va=
lue may be longer, which
+ * is how the TLVs are extended; trailing bytes t=
hat are not understood are
+ * ignored on read=2E */
+
+/** request_id (u64=
), timestamp (u64), flags (u32) */
+#define PROBE_REQUEST_LEN ((uint16_t)(2=
 * sizeof(uint64_t) + sizeof(uint32_t)))
+
+/** request_id (u64), then prio=
rity, weight, max_latency_diff,
+ * connect_lifetime and flags (u16 each) *=
/
+#define PROBE_REPLY_LEN ((uint16_t)(sizeof(uint64_t) + 5 * sizeof(uint16=
_t)))
+
+/**
+ * Write a complete probe request TLV, header and value, to b=
uf=2E
+ *
+ * @return true on success, false if buf has insufficient space=
=2E
+ */
+bool probe_request_write(struct buffer *buf, const struct probe_r=
equest *r);
+
+/**
+ * Read a probe request TLV value from buf=2E
+ *
+ * b=
uf must cover exactly the TLV's value, as ctrl_msg_find_tlv() returns it=2E=

+ * Bytes beyond the fields understood here are ignored, so a longer value=
 from
+ * a future version still parses=2E Flag bits that are not known are=
 kept in
+ * flags rather than rejected, for the same reason=2E
+ *
+ * @re=
turn true on success, false if buf is shorter than the mandatory fields=2E
=
+ */
+bool probe_request_read(struct buffer *buf, struct probe_request *r);=

+
+/**
+ * Write a complete probe reply TLV, header and value, to buf=2E
+=
 *
+ * @return true on success, false if buf has insufficient space=2E
+ */=

+bool probe_reply_write(struct buffer *buf, const struct probe_reply *r);
=
+
+/**
+ * Read a probe reply TLV value from buf=2E The calling convention =
is that of
+ * probe_request_read()=2E
+ *
+ * The two flag combinations th=
e protocol rules out are rejected here, since
+ * neither can be acted on: =
a reply must not call the other addresses of the
+ * remote both the same s=
erver and distinct ones, and it must not extend the
+ * connect_lifetime to=
 those addresses without first calling them the same
+ * server=2E
+ *
+ * =
@return true on success, false if buf is shorter than the mandatory fields
=
+ *         or the flags contradict each other=2E
+ */
+bool probe_reply_re=
ad(struct buffer *buf, struct probe_reply *r);
+
+#endif /* ifndef PROBE_H =
*/
diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec
index 9a72614=2E=
=2E2533b1e 100644
--- a/src/openvpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3=
783,15 +3783,26 @@
     bool new_link =3D false;
     struct session_id sid=
; /* remote session ID */
 
-    /* verify legal opcode */
-    if (op < P_=
FIRST_OPCODE || op > P_LAST_OPCODE)
+    /* verify the opcode belongs to th=
e reliable control channel, whose
+     * message id and ACK array we parse=
 below */
+    if (!opcode_is_reliable_control(op))
     {
         if (op =
=3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SER=
VER_V1)
         {
             msg(D_TLS_ERRORS, "Peer tried unsupported k=
ey-method 1");
         }
-        msg(D_TLS_ERRORS, "TLS Error: unknown op=
code received from %s op=3D%d",
-            print_link_socket_actual(from,=
 &gc), op);
+        if (op =3D=3D P_CONTROL_V2 || op =3D=3D P_CONTROL_WKC_=
V2)
+        {
+            /* a defined opcode, just not one this path can=
 parse */
+            msg(D_TLS_ERRORS, "TLS Error: %s received from %s, w=
hich is not part of "
+                              "the reliable control =
channel",
+                packet_opcode_name(op), print_link_socket_actual=
(from, &gc));
+        }
+        else
+        {
+            msg(D_TLS_ER=
RORS, "TLS Error: unknown opcode received from %s op=3D%d",
+              =
  print_link_socket_actual(from, &gc), op);
+        }
         goto error;=

     }
 
diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
in=
dex f4564ef=2E=2Eccb841e 100644
--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/ope=
nvpn/ssl_pkt=2Ec
@@ -169,7 +169,8 @@
                    bool prepend_ack)
=
 {
     ASSERT(ks->key_id >=3D 0 && ks->key_id <=3D P_KEY_ID_MASK);
-    AS=
SERT(opcode >=3D 0 && opcode <=3D P_LAST_OPCODE);
+    /* this writes the m=
essage id and ACK array, which only these opcodes have */
+    ASSERT(opcod=
e_is_reliable_control(opcode));
     uint8_t header =3D (uint8_t)(ks->key_i=
d | (opcode << P_OPCODE_SHIFT));
 
     /* Workaround for Softether servers=
=2E Softether has a bug that it only
diff --git a/src/openvpn/ssl_pkt=2Eh b=
/src/openvpn/ssl_pkt=2Eh
index 218c6bb=2E=2E3b45492 100644
--- a/src/openvp=
n/ssl_pkt=2Eh
+++ b/src/openvpn/ssl_pkt=2Eh
@@ -58,11 +58,50 @@
  * like P_=
CONTROL_HARD_RESET_CLIENT_V3 */
 #define P_CONTROL_WKC_V1 11
 
-/* define t=
he range of legal opcodes
- * Since we do no longer support key-method 1 we=
 consider
- * the v1 op codes invalid */
-#define P_FIRST_OPCODE 3
-#define=
 P_LAST_OPCODE  11
+/* Control channel packet carrying a TLV payload, e=2Eg=
=2E a server probe=2E Framed
+ * like P_CONTROL_V1 but without the fields o=
f the reliability layer: a session
+ * id and then the TLVs, with no messag=
e id and no ACK array=2E It is wrapped by
+ * tls-auth or tls-crypt like an=
y other control channel packet, and with
+ * neither configured it travels =
unauthenticated, as they do=2E */
+#define P_CONTROL_V2 12
+
+/* Variant of=
 P_CONTROL_V2 with the wrapped client key appended,
+ * like P_CONTROL_WKC_=
V1 is to P_CONTROL_V1 */
+#define P_CONTROL_WKC_V2 13
+
+/**
+ * Is a packe=
t with opcode op carried by the reliable control channel?
+ *
+ * These opc=
odes are followed by an ACK array and a control message id, which
+ * is wh=
at the reliable path reads once it is past the session id=2E An opcode
+ * =
that is not one of them has something else there: P_CONTROL_V2 has its TLVs=
=2E
+ * Handing such a packet to that path would read the first bytes of th=
at
+ * payload as an ACK count and a message id, and ACK or queue whatever =
it made
+ * of them=2E
+ *
+ * The opcodes are listed rather than bounded b=
y a range, so that defining one
+ * does not silently add it to the set=2E =
Key method 1 is no longer supported, so
+ * its two reset opcodes are not h=
ere, and the data channel opcodes are handled
+ * before this is reached=2E=

+ */
+static inline bool
+opcode_is_reliable_control(int op)
+{
+    switc=
h (op)
+    {
+        case P_CONTROL_SOFT_RESET_V1:
+        case P_CONTRO=
L_V1:
+        case P_ACK_V1:
+        case P_CONTROL_HARD_RESET_CLIENT_V2:=

+        case P_CONTROL_HARD_RESET_SERVER_V2:
+        case P_CONTROL_HARD=
_RESET_CLIENT_V3:
+        case P_CONTROL_WKC_V1:
+            return true;=

+
+        default:
+            return false;
+    }
+}
 
 /*
  * Define =
number of buffers for send and receive in the reliability layer=2E
@@ -257,=
6 +296,12 @@
         case P_CONTROL_WKC_V1:
             return "P_CONTROL=
_WKC_V1";
 
+        case P_CONTROL_V2:
+            return "P_CONTROL_V2";=

+
+        case P_CONTROL_WKC_V2:
+            return "P_CONTROL_WKC_V2";
=
+
         case P_ACK_V1:
             return "P_ACK_V1";
 
diff --git a/te=
sts/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2E=
am
index 11f92f4=2E=2E53882df 100644
--- a/tests/unit_tests/openvpn/Makefil=
e=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -166,6 +166,7 @@
 pk=
t_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 pkt_testdriver_SOURCES =3D test_pk=
t=2Ec \
 	test_control_msg=2Ec test_control_msg=2Eh \
+	test_probe=2Ec test=
_probe=2Eh \
 	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
 	test_com=
mon=2Eh \
 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \
@@ -181,6 +182,7 =
@@
 	$(top_srcdir)/src/openvpn/otime=2Ec \
 	$(top_srcdir)/src/openvpn/pack=
et_id=2Ec \
 	$(top_srcdir)/src/openvpn/platform=2Ec \
+	$(top_srcdir)/src/=
openvpn/probe=2Ec \
 	$(top_srcdir)/src/openvpn/reliable=2Ec \
 	$(top_srcd=
ir)/src/openvpn/run_command=2Ec \
 	$(top_srcdir)/src/openvpn/session_id=2E=
c \
diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/o=
penvpn/test_pkt=2Ec
index 7dc07aa=2E=2E7fd74f4 100644
--- a/tests/unit_test=
s/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -45,6=
 +45,7 @@
 #include "reliable=2Eh"
 #include "siphash=2Eh"
 #include "test_=
control_msg=2Eh"
+#include "test_probe=2Eh"
 
 int
 parse_line(const char *=
line, char **p, const int n, const char *file, const int line_num,
@@ -841,=
7 +842,21 @@
         cmocka_unit_test(test_tlv_next_walks_payload),
      =
   cmocka_unit_test(test_tlv_next_value_truncated),
         cmocka_unit_te=
st(test_tlv_header_truncated),
-        cmocka_unit_test(test_tlv_write_no_=
room)
+        cmocka_unit_test(test_tlv_write_no_room),
+        cmocka_un=
it_test(test_probe_request_roundtrip),
+        cmocka_unit_test(test_probe=
_request_wire_format),
+        cmocka_unit_test(test_probe_reply_roundtrip=
),
+        cmocka_unit_test(test_probe_reply_wire_format),
+        cmocka=
_unit_test(test_probe_request_forward_compat),
+        cmocka_unit_test(te=
st_probe_request_too_short),
+        cmocka_unit_test(test_probe_reply_too=
_short),
+        cmocka_unit_test(test_probe_reply_flags_contradict),
+   =
     cmocka_unit_test(test_find_tlv_value_truncated),
+        cmocka_unit_=
test(test_find_tlv_trailing_bytes),
+        cmocka_unit_test(test_find_tlv=
_skips_optional_after_wanted),
+        cmocka_unit_test(test_find_tlv_reje=
cts_unknown_mandatory),
+        cmocka_unit_test(test_find_tlv_rejects_dup=
licate),
+        cmocka_unit_test(test_find_tlv_empty_payload)
     };
 
 =
    return cmocka_run_group_tests_name("pkt tests", tests, NULL, NULL);
dif=
f --git a/tests/unit_tests/openvpn/test_probe=2Ec b/tests/unit_tests/openvp=
n/test_probe=2Ec
new file mode 100644
index 0000000=2E=2E967252c
--- /dev/n=
ull
+++ b/tests/unit_tests/openvpn/test_probe=2Ec
@@ -0,0 +1,425 @@
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
+#include "prob=
e=2Eh"
+#include "test_common=2Eh"
+#include "test_probe=2Eh"
+
+/* Write a=
 probe request TLV and read it back; the fields must survive the
+ * round =
trip and the whole buffer must be consumed=2E */
+void
+test_probe_request_=
roundtrip(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struc=
t buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct probe_request =
in =3D {
+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,
+        =2Etime=
stamp =3D 0x0123456789abcdefULL,
+        =2Eflags =3D PROBE_REQUEST_FLAG_P=
ROBE_ONLY,
+    };
+    assert_true(probe_request_write(&buf, &in));
+    a=
ssert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REQUEST_LEN);
+=

+    struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_peek_he=
ader(&buf, &hdr));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST=
);
+    assert_false(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len=
, PROBE_REQUEST_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg=
_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLE=
N(&value), PROBE_REQUEST_LEN);
+
+    struct probe_request out =3D { 0 };
+=
    assert_true(probe_request_read(&value, &out));
+    assert_true(in=2Ere=
quest_id =3D=3D out=2Erequest_id);
+    assert_true(in=2Etimestamp =3D=3D o=
ut=2Etimestamp);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    /* th=
e scan consumed header and value alike */
+    assert_int_equal(BLEN(&buf),=
 0);
+
+    gc_free(&gc);
+}
+
+/* The probe request wire format is locked =
to the field order of the spec
+ * (request_id, timestamp, flags), big-endi=
an=2E */
+void
+test_probe_request_wire_format(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc=
);
+
+    const struct probe_request in =3D {
+        =2Erequest_id =3D 0x=
1122334455667788ULL,
+        =2Etimestamp =3D 0x0102030405060708ULL,
+    =
    =2Eflags =3D 0,
+    };
+    assert_true(probe_request_write(&buf, &in)=
);
+
+    /* clang-format off */
+    const uint8_t expected[] =3D {
+     =
   0x00, 0x02,                                     /* TLV type 2, not optio=
nal */
+        0x00, 0x14,                                     /* TLV valu=
e length =3D 20 */
+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88,=
 /* request_id */
+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, =
/* timestamp */
+        0x00, 0x00, 0x00, 0x00,                         /*=
 flags */
+    };
+    /* clang-format on */
+    assert_int_equal(BLEN(&bu=
f), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeo=
f(expected));
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV and rea=
d it back=2E */
+void
+test_probe_reply_roundtrip(void **state)
+{
+    str=
uct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, =
&gc);
+
+    const struct probe_reply in =3D {
+        =2Erequest_id =3D 0=
x1122334455667788ULL,
+        =2Epriority =3D 10,
+        =2Eweight =3D 1=
00,
+        =2Emax_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 3=
0,
+        =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert=
_true(probe_reply_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), CTRL=
_MSG_TLV_HEADER_LEN + PROBE_REPLY_LEN);
+
+    struct ctrl_msg_tlv_header h=
dr;
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+    assert_int=
_equal(hdr=2Etype, TLV_TYPE_PROBE_REPLY);
+    assert_false(hdr=2Eoptional)=
;
+    assert_int_equal(hdr=2Evalue_len, PROBE_REPLY_LEN);
+
+    struct bu=
ffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REPLY, =
&value));
+
+    struct probe_reply out =3D { 0 };
+    assert_true(probe_r=
eply_read(&value, &out));
+    assert_true(in=2Erequest_id =3D=3D out=2Ereq=
uest_id);
+    assert_int_equal(in=2Epriority, out=2Epriority);
+    assert=
_int_equal(in=2Eweight, out=2Eweight);
+    assert_int_equal(in=2Emax_laten=
cy_diff, out=2Emax_latency_diff);
+    assert_int_equal(in=2Econnect_lifeti=
me, out=2Econnect_lifetime);
+    assert_int_equal(in=2Eflags, out=2Eflags)=
;
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The p=
robe reply wire format is locked to the field order of the spec
+ * (reques=
t_id, priority, weight, max_latency_diff, connect_lifetime, flags),
+ * big=
-endian=2E */
+void
+test_probe_reply_wire_format(void **state)
+{
+    str=
uct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, =
&gc);
+
+    const struct probe_reply in =3D {
+        =2Erequest_id =3D 0=
x1122334455667788ULL,
+        =2Epriority =3D 10,
+        =2Eweight =3D 1=
00,
+        =2Emax_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 3=
0,
+        =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert=
_true(probe_reply_write(&buf, &in));
+
+    /* clang-format off */
+    con=
st uint8_t expected[] =3D {
+        0x00, 0x03,                           =
          /* TLV type 3, not optional */
+        0x00, 0x12,              =
                       /* TLV value length =3D 18 */
+        0x11, 0x22, 0=
x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id */
+        0x00, 0x0a,   =
                                  /* priority =3D 10 */
+        0x00, 0x64=
,                                     /* weight =3D 100 */
+        0x00, 0=
x19,                                     /* max_latency_diff =3D 25 */
+   =
     0x00, 0x1e,                                     /* connect_lifetime =
=3D 30 */
+        0x00, 0x01,                                     /* flags=
 =3D RESEND_WKC */
+    };
+    /* clang-format on */
+    assert_int_equal=
(BLEN(&buf), sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expect=
ed, sizeof(expected));
+
+    gc_free(&gc);
+}
+
+/* A TLV with a longer-th=
an-known value must still parse: the known fields are
+ * read and the trai=
ling bytes are skipped=2E Flag bits we do not know are kept
+ * rather than=
 rejected, for the same forward compatibility=2E */
+void
+test_probe_reque=
st_forward_compat(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+ =
   struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const uint16_t exte=
nded_len =3D PROBE_REQUEST_LEN + 4;
+    assert_true(ctrl_msg_tlv_write_hea=
der(&buf, TLV_TYPE_PROBE_REQUEST, false, extended_len));
+    assert_true(b=
uf_write_u64(&buf, 7));             /* request_id */
+    assert_true(buf_w=
rite_u64(&buf, 0xdeadbeefULL)); /* timestamp */
+    assert_true(buf_write_=
u32(&buf, 0x80000000));    /* flags, unknown bit set */
+    assert_true(bu=
f_write_u32(&buf, 0x11223344));    /* unknown trailing field */
+
+    stru=
ct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_RE=
QUEST, &value));
+    assert_int_equal(BLEN(&value), extended_len);
+
+    =
struct probe_request out =3D { 0 };
+    assert_true(probe_request_read(&va=
lue, &out));
+    assert_true(out=2Erequest_id =3D=3D 7);
+    assert_true(=
out=2Etimestamp =3D=3D 0xdeadbeefULL);
+    assert_true(out=2Eflags =3D=3D =
0x80000000);
+    /* the unknown trailing field must have been consumed fro=
m the payload */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);=

+}
+
+/* A value shorter than the mandatory fields must be rejected, even =
when it
+ * holds enough bytes for some of the individual fields to read su=
ccessfully=2E */
+void
+test_probe_request_too_short(void **state)
+{
+    =
struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(12=
8, &gc);
+
+    /* 8 of the 20 mandatory value bytes: enough for the reques=
t_id alone */
+    assert_true(buf_write_u64(&buf, 0xdeadbeefULL));
+
+    =
struct probe_request out =3D { 0 };
+    assert_false(probe_request_read(&b=
uf, &out));
+
+    gc_free(&gc);
+}
+
+/* The same for the reply, one u16 s=
hort of its 18 mandatory bytes=2E */
+void
+test_probe_reply_too_short(void=
 **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =
=3D alloc_buf_gc(128, &gc);
+
+    assert_true(buf_write_u64(&buf, 1));
+  =
  for (int i =3D 0; i < 4; i++)
+    {
+        assert_true(buf_write_u16(&=
buf, 0));
+    }
+
+    struct probe_reply out =3D { 0 };
+    assert_false=
(probe_reply_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* The flag comb=
inations the protocol rules out must be rejected: the other
+ * addresses o=
f a remote cannot be both the same server and distinct ones, and
+ * a shar=
ed connect_lifetime needs them to have been called equal=2E */
+void
+test_=
probe_reply_flags_contradict(void **state)
+{
+    struct gc_arena gc =3D g=
c_new();
+    const uint16_t bad[] =3D {
+        PROBE_REPLY_FLAG_ADDRS_EQ=
UAL | PROBE_REPLY_FLAG_PROBE_MORE,
+        PROBE_REPLY_FLAG_LIFETIME_SHARE=
D,
+        PROBE_REPLY_FLAG_LIFETIME_SHARED | PROBE_REPLY_FLAG_PROBE_MORE,=

+    };
+    const uint16_t good[] =3D {
+        0,
+        PROBE_REPLY_=
FLAG_ADDRS_EQUAL,
+        PROBE_REPLY_FLAG_PROBE_MORE,
+        PROBE_REPL=
Y_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_LIFETIME_SHARED,
+    };
+
+    for (=
size_t i =3D 0; i < SIZE(bad) + SIZE(good); i++)
+    {
+        const bool=
 expect_ok =3D i >=3D SIZE(bad);
+        const uint16_t flags =3D expect_o=
k ? good[i - SIZE(bad)] : bad[i];
+
+        struct buffer buf =3D alloc_bu=
f_gc(128, &gc);
+        const struct probe_reply in =3D { =2Erequest_id =
=3D 1, =2Eflags =3D flags };
+        assert_true(probe_reply_write(&buf, &=
in));
+
+        struct buffer value;
+        assert_true(ctrl_msg_find_tl=
v(&buf, TLV_TYPE_PROBE_REPLY, &value));
+
+        struct probe_reply out =
=3D { 0 };
+        assert_int_equal(probe_reply_read(&value, &out), expect=
_ok);
+    }
+
+    gc_free(&gc);
+}
+
+/* A TLV header claiming more value=
 bytes than the payload holds must be
+ * rejected by the scan rather than =
reported as found -- for the TLV being
+ * looked for as much as for one th=
at would merely be skipped=2E */
+void
+test_find_tlv_value_truncated(void =
**state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer value;=

+
+    /* the wanted TLV declares 20 value bytes, only 8 are present */
+ =
   struct buffer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_=
tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN));
=
+    assert_true(buf_write_u64(&buf, 0xdeadbeefULL));
+    assert_false(ctr=
l_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    /* same defec=
t on a TLV that would be skipped: the scan must not walk past
+     * the e=
nd of the payload looking for the next header */
+    struct buffer buf2 =
=3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&buf=
2, 0x7ff, false, 64));
+    assert_true(buf_write_u32(&buf2, 0));
+    asse=
rt_false(ctrl_msg_find_tlv(&buf2, TLV_TYPE_PROBE_REQUEST, &value));
+
+    =
gc_free(&gc);
+}
+
+/* Bytes left over after the last TLV that are too few =
for a header make the
+ * message malformed, even when the wanted TLV was a=
lready found=2E */
+void
+test_find_tlv_trailing_bytes(void **state)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+    /* 1 to=
 3 bytes: less than a 4-byte TLV header */
+    for (int trailing =3D 1; tr=
ailing < CTRL_MSG_TLV_HEADER_LEN; trailing++)
+    {
+        struct buffer=
 buf =3D alloc_buf_gc(128, &gc);
+        const struct probe_request in =3D=
 { =2Erequest_id =3D 1, =2Etimestamp =3D 1 };
+        assert_true(probe_re=
quest_write(&buf, &in));
+        for (int i =3D 0; i < trailing; i++)
+   =
     {
+            assert_true(buf_write_u8(&buf, 0));
+        }
+       =
 assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+  =
  }
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV marked optional after the =
wanted one is skipped, and the
+ * wanted value is still the one returned=
=2E */
+void
+test_find_tlv_skips_optional_after_wanted(void **state)
+{
+ =
   struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc=
(128, &gc);
+    struct buffer value;
+
+    const struct probe_request in =
=3D { =2Erequest_id =3D 1, =2Etimestamp =3D 7 };
+    assert_true(probe_req=
uest_write(&buf, &in));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x=
7ff, true, 4));
+    assert_true(buf_write_u32(&buf, 0));
+
+    assert_tru=
e(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int=
_equal(BLEN(&value), PROBE_REQUEST_LEN);
+    struct probe_request out =3D =
{ 0 };
+    assert_true(probe_request_read(&value, &out));
+    assert_true=
(out=2Etimestamp =3D=3D 7);
+
+    gc_free(&gc);
+}
+
+/* A TLV we do not k=
now that is not marked optional carries something its
+ * sender requires u=
s to act on, so the scan rejects the message whether that
+ * TLV comes bef=
ore or after the wanted one=2E */
+void
+test_find_tlv_rejects_unknown_mand=
atory(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct bu=
ffer value;
+    const struct probe_request in =3D { =2Erequest_id =3D 1, =
=2Etimestamp =3D 7 };
+
+    struct buffer before =3D alloc_buf_gc(128, &gc=
);
+    assert_true(ctrl_msg_tlv_write_header(&before, 0x7ff, false, 4));
+=
    assert_true(buf_write_u32(&before, 0xcafef00d));
+    assert_true(probe=
_request_write(&before, &in));
+
+    struct buffer after =3D alloc_buf_gc(=
128, &gc);
+    assert_true(probe_request_write(&after, &in));
+    assert_=
true(ctrl_msg_tlv_write_header(&after, 0x7ff, false, 4));
+    assert_true(=
buf_write_u32(&after, 0xcafef00d));
+
+    assert_false(ctrl_msg_find_tlv(&=
before, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_false(ctrl_msg_find_t=
lv(&after, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* =
The wanted TLV may occur only once: a second one rejects the message=2E Rep=
eats
+ * of an unknown TLV marked optional are skipped like any other=2E */=

+void
+test_find_tlv_rejects_duplicate(void **state)
+{
+    struct gc_are=
na gc =3D gc_new();
+    struct buffer value;
+    const struct probe_reque=
st in =3D { =2Erequest_id =3D 1 };
+
+    struct buffer buf =3D alloc_buf_g=
c(128, &gc);
+    assert_true(probe_request_write(&buf, &in));
+    assert_=
true(probe_request_write(&buf, &in));
+    assert_false(ctrl_msg_find_tlv(&=
buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    buf =3D alloc_buf_gc(128, &gc=
);
+    for (int i =3D 0; i < 2; i++)
+    {
+        assert_true(ctrl_msg_=
tlv_write_header(&buf, 0x7ff, true, 4));
+        assert_true(buf_write_u32=
(&buf, 0));
+    }
+    assert_true(probe_request_write(&buf, &in));
+    a=
ssert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+   =
 gc_free(&gc);
+}
+
+/* An empty payload holds no TLV=2E */
+void
+test_fin=
d_tlv_empty_payload(void **state)
+{
+    struct gc_arena gc =3D gc_new();
=
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+    struct buffer value;=

+
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value=
));
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/test_prob=
e=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh
new file mode 100644
index =
0000000=2E=2Ee60aa45
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_prob=
e=2Eh
@@ -0,0 +1,53 @@
+/*
+ *  OpenVPN -- An application to securely tunne=
l IP networks
+ *             over a single TCP/UDP port, with support for =
SSL/TLS-based
+ *             session authentication and key exchange,
+ * =
            packet encryption, packet authentication, and
+ *             p=
acket compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@op=
envpn=2Enet>
+ *
+ *  This program is free software; you can redistribute i=
t and/or modify
+ *  it under the terms of the GNU General Public License v=
ersion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This=
 program is distributed in the hope that it will be useful,
+ *  but WITHOU=
T ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Lice=
nse for more details=2E
+ *
+ *  You should have received a copy of the GNU=
 General Public License along
+ *  with this program; if not, see <https://=
www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_PROBE_H
+#define TEST_PR=
OBE_H
+
+void test_probe_request_roundtrip(void **state);
+
+void test_prob=
e_request_wire_format(void **state);
+
+void test_probe_reply_roundtrip(voi=
d **state);
+
+void test_probe_reply_wire_format(void **state);
+
+void tes=
t_probe_request_forward_compat(void **state);
+
+void test_probe_request_to=
o_short(void **state);
+
+void test_probe_reply_too_short(void **state);
+
=
+void test_probe_reply_flags_contradict(void **state);
+
+void test_find_tl=
v_value_truncated(void **state);
+
+void test_find_tlv_trailing_bytes(void =
**state);
+
+void test_find_tlv_skips_optional_after_wanted(void **state);
=
+
+void test_find_tlv_rejects_unknown_mandatory(void **state);
+
+void test=
_find_tlv_rejects_duplicate(void **state);
+
+void test_find_tlv_empty_payl=
oad(void **state);
+#endif

-- 
To view, visit https://gerrit=2Eopenvpn=2En=
et/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for help writing mail fi=
lters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-Me=
ssageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit=
-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Gerrit-Change-Number:=
 1741
Gerrit-PatchSet: 27
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom=
>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewe=
r: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf Lici <=
ralf@mandelbit=2Ecom>
Gerrit-Reviewer: chugly <charlie=2Evigue@openvpn=2Eco=
m>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=2Enet>
Gerri=
t-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention: Lev Stipako=
v <lstipakov@gmail=2Ecom>
Gerrit-Attention: chugly <charlie=2Evigue@openvpn=
=2Ecom>
Gerrit-Attention: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-=
Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--epAJZ0bcu10=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici, chugly=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #27</strong>=
 to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvp=
n/+/1741?usp=3Demail">View Change</a></p><p>The following approvals got out=
dated and were removed:
Code-Review+1 by chugly</p><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">control_ms=
g: Add P_CONTROL_V2 and the probe request and reply TLVs<br><br>A client pr=
obes a server before connecting by sending a P_CONTROL_V2<br>message carryi=
ng a probe request TLV, and the server answers with a<br>P_CONTROL_V2 carry=
ing a probe reply=2E The reply tells the client how the<br>server wants to =
be ranked against the other remotes, and can also serve<br>as the second pa=
cket of the three-way handshake=2E<br><br>Add the two opcodes and the two T=
LV codecs the probe needs=2E P_CONTROL_V2<br>is framed like P_CONTROL_V1 bu=
t without the fields of the reliability<br>layer: a session id and then the=
 TLVs, with no control message id and no<br>ACK array=2E P_CONTROL_WKC_V2 i=
s the same with the wrapped client key<br>appended, as P_CONTROL_WKC_V1 is =
to P_CONTROL_V1=2E<br><br>The TLVs use the shared TLV codec, control_msg=2E=
c/h, and their two types<br>join the others there=2E The codec gains ctrl_m=
sg_find_tlv(), which scans<br>a payload for the one mandatory TLV of a mess=
age=2E The scan is strict: a<br>truncated TLV header or value, a second TLV=
 of the wanted type, or an<br>unknown TLV not marked optional rejects the w=
hole message=2E<br><br>Both readers accept a value longer than the fields t=
hey know and ignore<br>the excess, which is how the TLVs are meant to be ex=
tended=2E The probe<br>reply reader does reject the two flag combinations t=
he protocol rules<br>out, as neither can be acted on: the other addresses o=
f a remote cannot<br>be both the same server and distinct ones, and the con=
nect_lifetime<br>cannot be extended to those addresses without first callin=
g them the<br>same server=2E<br><br>The reliable control path no longer dec=
ides what it handles from an<br>opcode range=2E P_FIRST_OPCODE and P_LAST_O=
PCODE give way to<br>opcode_is_reliable_control(), which lists the opcodes =
that carry a<br>message id and an ACK array, and tls_pre_decrypt() and<br>w=
rite_control_auth() test that instead=2E Defining an opcode therefore no<br=
>longer joins it to that set, so neither the two added here nor<br>CONTROL_=
AUX_V1 after them needs to be carved back out of a range=2E<br><br>No opcod=
e changes hands: the old range covered exactly the seven listed,<br>plus th=
e two data channel opcodes, which are handled before the check is<br>reache=
d=2E<br><br>The probe is not sent or answered yet; that follows=2E<br><br>C=
hange-Id: I1c8d302ac57c5603d622a7be14be369437388268<br>Signed-off-by: Lev S=
tipakov &lt;lev@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/ope=
nvpn/Makefile=2Eam<br>M src/openvpn/control_msg=2Ec<br>M src/openvpn/contro=
l_msg=2Eh<br>A src/openvpn/probe=2Ec<br>A src/openvpn/probe=2Eh<br>M src/op=
envpn/ssl=2Ec<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>=
M tests/unit_tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test=
_pkt=2Ec<br>A tests/unit_tests/openvpn/test_probe=2Ec<br>A tests/unit_tests=
/openvpn/test_probe=2Eh<br>13 files changed, 858 insertions(+), 11 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418=
/openvpn refs/changes/41/1741/27</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CM=
akeLists=2Etxt</span><br><span>index 305c26c=2E=2Ec650468 100644</span><br>=
<span>--- a/CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><=
br><span>@@ -565,6 +565,8 @@</span><br><span>     src/openvpn/plugin=2Eh</s=
pan><br><span>     src/openvpn/pool=2Ec</span><br><span>     src/openvpn/po=
ol=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openv=
pn/probe=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src=
/openvpn/probe=2Eh</span><br><span>     src/openvpn/proto=2Ec</span><br><sp=
an>     src/openvpn/proto=2Eh</span><br><span>     src/openvpn/proxy=2Ec</s=
pan><br><span>@@ -899,7 +901,9 @@</span><br><span>     target_sources(test_=
pkt PRIVATE</span><br><span>         tests/unit_tests/openvpn/mock_win32_ex=
ecve=2Ec</span><br><span>         tests/unit_tests/openvpn/test_control_msg=
=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tests/u=
nit_tests/openvpn/test_probe=2Ec</span><br><span>         src/openvpn/contr=
ol_msg=2Ec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
rc/openvpn/probe=2Ec</span><br><span>         src/openvpn/argv=2Ec</span><b=
r><span>         src/openvpn/base64=2Ec</span><br><span>         src/openvp=
n/crypto_epoch=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b=
/src/openvpn/Makefile=2Eam</span><br><span>index be1044d=2E=2E4c8edea 10064=
4</span><br><span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src=
/openvpn/Makefile=2Eam</span><br><span>@@ -121,6 +121,7 @@</span><br><span>=
 	ping=2Ec ping=2Eh \</span><br><span> 	plugin=2Ec plugin=2Eh \</span><br><=
span> 	pool=2Ec pool=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	probe=2Ec probe=2Eh \</span><br><span> 	proto=2Ec proto=2Eh \</span=
><br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span>=
<br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_ms=
g=2Ec</span><br><span>index e14355c=2E=2Ea77413f 100644</span><br><span>---=
 a/src/openvpn/control_msg=2Ec</span><br><span>+++ b/src/openvpn/control_ms=
g=2Ec</span><br><span>@@ -91,3 +91,32 @@</span><br><span>     buf_set_read(=
value, v, hdr-&gt;value_len);</span><br><span>     return true;</span><br><=
span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ctrl_msg_find_tlv(struct buffer *payload, uint=
16_t wanted_type, struct buffer *value)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    bool found =3D false;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    while (BLEN(payload) &gt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        struct buffer v;</span><br><span style=
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
envpn/control_msg=2Eh</span><br><span>index 92572cb=2E=2E8ad5530 100644</sp=
an><br><span>--- a/src/openvpn/control_msg=2Eh</span><br><span>+++ b/src/op=
envpn/control_msg=2Eh</span><br><span>@@ -41,6 +41,8 @@</span><br><span> </=
span><br><span> /* TLV types */</span><br><span> #define TLV_TYPE_EARLY_NEG=
_FLAGS 0x0001 /* early negotiation, in the reset packets */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REQUEST   0x=
0002 /* a client probing a server, in P_CONTROL_V2 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REPLY     0x0003 /=
* the server&#39;s answer, in P_CONTROL_V2 */</span><br><span> </span><br><=
span> /* A TLV header is a 16-bit type/optional field plus a 16-bit length =
*/</span><br><span> #define CTRL_MSG_TLV_HEADER_LEN 4</span><br><span>@@ -1=
05,4 +107,28 @@</span><br><span>  */</span><br><span> bool ctrl_msg_tlv_nex=
t(struct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value=
);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scan payload=
 for the TLV of type wanted_type, skipping any other TLV type</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * that is marked optional=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * This is for messages that carry exact=
ly one mandatory TLV, which is what the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * probe messages are=2E Any other TLV that is not mark=
ed optional invalidates</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * the message wherever it appears, as does a second TLV of wanted_type=
, so the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whole se=
quence is walked even once the wanted TLV has been found=2E A message</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * carrying several manda=
tory TLVs walks them with ctrl_msg_tlv_next() instead=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * On success value covers exactly the found TLV&#39;s =
value bytes; as in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* ctrl_msg_tlv_next(), a header claiming more bytes than payload holds is</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejected rather th=
an reported as found=2E payload is consumed as it is read=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param payload      buffer positioned at a TLV h=
eader</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param want=
ed_type  the TLV type to look for</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param value        set to a buffer covering the found TLV=
&#39;s value; it points</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *                     into payload and owns no storage</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the TLV was foun=
d, false if it is absent or present more</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *         than once, if a TLV header or value is malf=
ormed or truncated, or if</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *         a TLV we do not understand is not marked optional=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool ctrl_msg_find_tlv(struct buffer *pay=
load, uint16_t wanted_type, struct buffer *value);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef CONTROL_M=
SG_H */</span><br><span>diff --git a/src/openvpn/probe=2Ec b/src/openvpn/pr=
obe=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E2497b07</span><br><span>--- /dev/null</span><br><span>+++ b/src/openv=
pn/probe=2Ec</span><br><span>@@ -0,0 +1,94 @@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a sin=
gle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             session authentication and key =
exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet encryption, packet authentication, and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;=
sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is free software; you can redistribute it and/or modify</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU G=
eneral Public License version 2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  as published by the Free Software Foundation=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that=
 it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  GNU General Public License for more details=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
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
 100%, 40%);">+#include &quot;probe=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+probe_request_write(struct buffer *buf, const struct probe_request=
 *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_hea=
der(buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u64(=
buf, r-&gt;request_id) &amp;&amp; buf_write_u64(buf, r-&gt;timestamp)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf=
_write_u32(buf, r-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+probe_request_read(struct buffer *buf, st=
ruct probe_request *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One boun=
ds check covers the whole value: every field read below then fits</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * by construction, PROBE=
_REQUEST_LEN being the sum of their sizes, so none</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * of them needs its own error handling=
=2E Trailing bytes this version does</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     * not understand are simply left unread=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; P=
ROBE_REQUEST_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;request_id =3D buf=
_read_u64(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    r-&gt;timestamp =3D buf_read_u64(buf, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NULL);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+probe_reply_write(struct buffer *buf, const struct probe_reply *r)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, TLV=
_TYPE_PROBE_REPLY, false, PROBE_REPLY_LEN)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u64(buf, r-&gt;reque=
st_id) &amp;&amp; buf_write_u16(buf, r-&gt;priority)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, =
r-&gt;weight) &amp;&amp; buf_write_u16(buf, r-&gt;max_latency_diff)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_w=
rite_u16(buf, r-&gt;connect_lifetime) &amp;&amp; buf_write_u16(buf, r-&gt;f=
lags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+probe_reply_read(struct buffer *buf, struct probe_reply *r)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* One bounds check for the whole val=
ue, as in probe_request_read()=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (buf_len(buf) &lt; PROBE_REPLY_LEN)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    r-&gt;request_id =3D buf_read_u64(buf, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16_=
t)buf_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    r-&gt;weight =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)buf=
_read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
r-&gt;connect_lifetime =3D (uint16_t)buf_read_u16(buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D (uint16_t)buf_read_=
u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* The other addresses of=
 the remote cannot be both the same server and</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * distinct ones=2E And LIFETIME_SHARED exte=
nds the connect_lifetime to those</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * other addresses, which says nothing unless ADDRS_EQUAL=
 has declared them</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * the same server to begin with=2E */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; PROBE_REPLY_FLAG_ADDRS_EQU=
AL) &amp;&amp; (r-&gt;flags &amp; PROBE_REPLY_FLAG_PROBE_MORE))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if ((r-&gt;flags &amp; PROBE_REPLY_FLAG_LIFETIME_SH=
ARED) &amp;&amp; !(r-&gt;flags &amp; PROBE_REPLY_FLAG_ADDRS_EQUAL))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/probe=2Eh b/s=
rc/openvpn/probe=2Eh</span><br><span>new file mode 100644</span><br><span>i=
ndex 0000000=2E=2E6001774</span><br><span>--- /dev/null</span><br><span>+++=
 b/src/openvpn/probe=2Eh</span><br><span>@@ -0,0 +1,141 @@</span><br><span =
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
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * Encoding and decoding of the server probe TL=
Vs=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * A client probes a server by =
sending a P_CONTROL_V2 message whose payload</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * carries a probe request TLV, and the server ans=
wers with a P_CONTROL_V2</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * message carrying a probe reply TLV=2E The reply tells the client ho=
w the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server want=
s to be ranked against the other remotes, and can also serve</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * as the second packet of the thr=
ee-way handshake=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The TLV framin=
g and the TLV type space are shared with the other TLV-based</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * control messages and live in co=
ntrol_msg=2Eh; this file holds the two probe</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * TLVs and what their fields mean=2E</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifndef PROBE_H</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define PROBE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buff=
er=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** probe=
 request flags=2E The client is only probing: it does not want to</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * continue into a handshake,=
 and the server may forget it right away=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#define PROBE_REQUEST_FLAG_PROBE_ONLY 0x00000001=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* probe reply flags */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/** complete the handshake with P_=
CONTROL_WKC_V1 rather than P_CONTROL_V1 */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_RESEND_WKC      0x0001</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/** the other addresses =
of this remote are the same server, no need to probe them */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_ADDRS_EQU=
AL     0x0002</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** th=
e connect_lifetime holds against those other addresses too, so a reply</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * from one of them can =
skip the handshake with another=2E Only meaningful</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * together with ADDRS_EQUAL, which is what =
names those addresses=2E */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define PROBE_REPLY_FLAG_LIFETIME_SHARED 0x0004</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/** the other addresses of this remote =
are distinct servers, so probe them too */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_PROBE_MORE      0x0008</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/** probe request TLV, sent by a client t=
o probe a server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
struct probe_request</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t requ=
est_id; /**&lt; identifies this probe, echoed in the reply */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /** The client clock as a UNI=
X timestamp in seconds=2E It is there for the</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     * server, which uses it to bound how old a r=
equest it will answer and so</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * how long a captured one can be replayed=2E The reply does n=
ot echo it: a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *=
 client times the round trip itself, by the request_id=2E */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint64_t timestamp;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags; /**&lt; PR=
OBE_REQUEST_FLAG_* */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/** probe reply TLV, a server&#39;=
s answer to a probe request */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct probe_reply</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint=
64_t request_id;       /**&lt; echoes the request_id of the request */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t priority;  =
       /**&lt; DNS SRV style priority, lower is preferred */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint16_t weight;           /**=
&lt; DNS SRV style weight */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint16_t max_latency_diff; /**&lt; candidate band in ms around=
 the fastest server */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /** For how many seconds, counted from the moment the client sent it=
s own</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * probe r=
equest, the server will still treat this exchange as the first</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * two packets of the handsh=
ake=2E Within that window the client may send the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+     * third packet straight away instead of =
starting a handshake of its own=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * 0 means it cannot, so it has to begin a fresh one=2E =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t conn=
ect_lifetime;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt16_t flags; /**&lt; PROBE_REPLY_FLAG_* */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Smallest =
on-wire value length (the TLV header not counted) of each TLV: the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * sizes of the fixed fields=
 above, in wire order=2E A value may be longer, which</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * is how the TLVs are extended; trailing=
 bytes that are not understood are</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * ignored on read=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/** request_id (u64), timestamp (u64), flags (u32) */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REQUEST_LEN ((uint16_t)(2 =
* sizeof(uint64_t) + sizeof(uint32_t)))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/** request_id (u64), then priority, weight, max_latency_diff,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * connect_lifetime and flags (=
u16 each) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 PROBE_REPLY_LEN ((uint16_t)(sizeof(uint64_t) + 5 * sizeof(uint16_t)))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Write a complete probe request TLV, header and value, =
to buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success,=
 false if buf has insufficient space=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool probe_request_write(struct buffer *buf, const struct probe_request=
 *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Read a probe request TLV value from buf=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * buf must cover exactly the TLV&#39;s =
value, as ctrl_msg_find_tlv() returns it=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Bytes beyond the fields understood here are igno=
red, so a longer value from</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * a future version still parses=2E Flag bits that are not known ar=
e kept in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * flags r=
ather than rejected, for the same reason=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return true on success, false if buf is shorter than the mandato=
ry fields=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+bool probe_request_read=
(struct buffer *buf, struct probe_request *r);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write=
 a complete probe reply TLV, header and value, to buf=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @return true on success, false if buf has insufficie=
nt space=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool probe_reply_write(s=
truct buffer *buf, const struct probe_reply *r);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Rea=
d a probe reply TLV value from buf=2E The calling convention is that of</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * probe_request_read()=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * The two flag combinations the =
protocol rules out are rejected here, since</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * neither can be acted on: a reply must not call t=
he other addresses of the</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * remote both the same server and distinct ones, and it must not ext=
end the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connect_l=
ifetime to those addresses without first calling them the same</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * server=2E</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @return true on success, false if buf is shorter than=
 the mandatory fields</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *         or the flags contradict each other=2E</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool probe_reply_read(struct buffer *buf, struct probe_reply=
 *r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef PROBE_H */</span=
><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br=
><span>index 9a72614=2E=2E2533b1e 100644</span><br><span>--- a/src/openvpn/=
ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3783,=
15 +3783,26 @@</span><br><span>     bool new_link =3D false;</span><br><spa=
n>     struct session_id sid; /* remote session ID */</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* verify legal opcod=
e */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P=
_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* verify the opcode belongs to the reliable contro=
l channel, whose</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
  * message id and ACK array we parse below */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (!opcode_is_reliable_control(op))</span><=
br><span>     {</span><br><span>         if (op =3D=3D P_CONTROL_HARD_RESET=
_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span>   =
      {</span><br><span>             msg(D_TLS_ERRORS, &quot;Peer tried uns=
upported key-method 1&quot;);</span><br><span>         }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS, &quot;TLS Erro=
r: unknown opcode received from %s op=3D%d&quot;,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            print_link_socket_actual(from, &amp=
;gc), op);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (op =3D=3D P_CONTROL_V2 || op =3D=3D P_CONTROL_WKC_V2)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            /* a defined opcode, just not one th=
is path can parse */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            msg(D_TLS_ERRORS, &quot;TLS Error: %s received from %s, which =
is not part of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                              &quot;the reliable control channel&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                packe=
t_opcode_name(op), print_link_socket_actual(from, &amp;gc));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: unknown opcode=
 received from %s op=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                print_link_socket_actual(from, &amp;gc), op);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br>=
<span>         goto error;</span><br><span>     }</span><br><span> </span><=
br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</sp=
an><br><span>index f4564ef=2E=2Eccb841e 100644</span><br><span>--- a/src/op=
envpn/ssl_pkt=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><=
span>@@ -169,7 +169,8 @@</span><br><span>                    bool prepend_a=
ck)</span><br><span> {</span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 =
&amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &l=
t;=3D P_LAST_OPCODE);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* this writes the message id and ACK array, which only these opcodes=
 have */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
opcode_is_reliable_control(opcode));</span><br><span>     uint8_t header =
=3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><br>=
<span> </span><br><span>     /* Workaround for Softether servers=2E Softeth=
er has a bug that it only</span><br><span>diff --git a/src/openvpn/ssl_pkt=
=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>index 218c6bb=2E=2E3b45492 1=
00644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/s=
rc/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,11 +58,50 @@</span><br><span>=
  * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CONTR=
OL_WKC_V1 11</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-/* define the range of legal opcodes</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Since we do no longer support key-method 1 we co=
nsider</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the v1 op co=
des invalid */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 P_FIRST_OPCODE 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine P_LAST_OPCODE  11</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Control channel packet carrying a TLV payload, e=2Eg=2E a server probe=
=2E Framed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * like P=
_CONTROL_V1 but without the fields of the reliability layer: a session</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * id and then the TLVs,=
 with no message id and no ACK array=2E It is wrapped by</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * tls-auth or tls-crypt like any othe=
r control channel packet, and with</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * neither configured it travels unauthenticated, as they do=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P_CON=
TROL_V2 12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/* Variant of P_CONTROL_V2 w=
ith the wrapped client key appended,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * like P_CONTROL_WKC_V1 is to P_CONTROL_V1 */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_WKC_V2 13</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Is a packet with opcode op carried by the reliable con=
trol channel?</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * These opcodes are fo=
llowed by an ACK array and a control message id, which</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * is what the reliable path reads once =
it is past the session id=2E An opcode</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * that is not one of them has something else there: P_C=
ONTROL_V2 has its TLVs=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Handing such a packet to that path would read the first bytes of t=
hat</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * payload as an=
 ACK count and a message id, and ACK or queue whatever it made</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * of them=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * The opcodes are listed rather than bounded by a rang=
e, so that defining one</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * does not silently add it to the set=2E Key method 1 is no longer sup=
ported, so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its tw=
o reset opcodes are not here, and the data channel opcodes are handled</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * before this is reache=
d=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+opcode_is_reliable_control(int o=
p)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    switch (op)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        case P_CONTROL_SOFT_RESET_V1:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_V1:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        case P_ACK_V1:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_HA=
RD_RESET_CLIENT_V2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        case P_CONTROL_HARD_RESET_SERVER_V2:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        case P_CONTROL_HARD_RESET_CLIENT_V3:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_WK=
C_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> /*=
</span><br><span>  * Define number of buffers for send and receive in the r=
eliability layer=2E</span><br><span>@@ -257,6 +296,12 @@</span><br><span>  =
       case P_CONTROL_WKC_V1:</span><br><span>             return &quot;P_C=
ONTROL_WKC_V1&quot;;</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        case P_CONTROL_V2:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return &quot;P_CONTROL_V2&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_WKC_V2:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;P_CON=
TROL_WKC_V2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>         case P_ACK_V1:</span><br><span>             return=
 &quot;P_ACK_V1&quot;;</span><br><span> </span><br><span>diff --git a/tests=
/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam<=
/span><br><span>index 11f92f4=2E=2E53882df 100644</span><br><span>--- a/tes=
ts/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/=
openvpn/Makefile=2Eam</span><br><span>@@ -166,6 +166,7 @@</span><br><span> =
pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> pkt_testdriver_S=
OURCES =3D test_pkt=2Ec \</span><br><span> 	test_control_msg=2Ec test_contr=
ol_msg=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	test_p=
robe=2Ec test_probe=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh mock_=
win32_execve=2Ec \</span><br><span> 	test_common=2Eh \</span><br><span> 	$(=
top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><br><span>@@ -181,6 +182,=
7 @@</span><br><span> 	$(top_srcdir)/src/openvpn/otime=2Ec \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/packet_id=2Ec \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/platform=2Ec \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	$(top_srcdir)/src/openvpn/probe=2Ec \</span><br><span> 	$(top_sr=
cdir)/src/openvpn/reliable=2Ec \</span><br><span> 	$(top_srcdir)/src/openvp=
n/run_command=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/session_id=
=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=2Ec b=
/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index 7dc07aa=2E=2E7=
fd74f4 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>=
@@ -45,6 +45,7 @@</span><br><span> #include &quot;reliable=2Eh&quot;</span>=
<br><span> #include &quot;siphash=2Eh&quot;</span><br><span> #include &quot=
;test_control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;test_probe=2Eh&quot;</span><br><span> </span><br><sp=
an> int</span><br><span> parse_line(const char *line, char **p, const int n=
, const char *file, const int line_num,</span><br><span>@@ -841,7 +842,21 @=
@</span><br><span>         cmocka_unit_test(test_tlv_next_walks_payload),</=
span><br><span>         cmocka_unit_test(test_tlv_next_value_truncated),</s=
pan><br><span>         cmocka_unit_test(test_tlv_header_truncated),</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test=
_tlv_write_no_room)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_tlv_write_no_room),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_request_r=
oundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_probe_request_wire_format),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_roun=
dtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_probe_reply_wire_format),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_request_forward=
_compat),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cm=
ocka_unit_test(test_probe_request_too_short),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply_too_sho=
rt),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_probe_reply_flags_contradict),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_value_trun=
cated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmoc=
ka_unit_test(test_find_tlv_trailing_bytes),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_skips_option=
al_after_wanted),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_find_tlv_rejects_unknown_mandatory),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_=
find_tlv_rejects_duplicate),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_find_tlv_empty_payload)</span><br><s=
pan>     };</span><br><span> </span><br><span>     return cmocka_run_group_=
tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_probe=2Ec b/tests/unit_tests/openvpn/=
test_probe=2Ec</span><br><span>new file mode 100644</span><br><span>index 0=
000000=2E=2E967252c</span><br><span>--- /dev/null</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/test_probe=2Ec</span><br><span>@@ -0,0 +1,425 @@</spa=
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
ude &quot;probe=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;test_probe=2Eh&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* Write a probe request TLV and read it back; the fiel=
ds must survive the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * round trip and the whole buffer must be consumed=2E */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+test_probe_request_roundtrip(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D allo=
c_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struc=
t probe_request in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0123456789abcd=
efULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Efl=
ags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;b=
uf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REQUEST_LEN);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_peek_header(&amp;b=
uf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2E=
value_len, PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(BLEN(&amp;value), PROBE_REQUEST_LEN);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct probe_request out =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(probe_request_read(&amp;value, &amp=
;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(in=2Erequest_id =3D=3D out=2Erequest_id);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Etimes=
tamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /* the scan consumed header and value alike */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp=
;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* The probe request wire format is locked to the field order o=
f the spec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (reque=
st_id, timestamp, flags), big-endian=2E */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+test_probe_request_wire_format(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct probe_req=
uest in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  =2Erequest_id =3D 0x1122334455667788ULL,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0102030405060708ULL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_wri=
te(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-fo=
rmat off */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t uint8_t expected[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        0x00, 0x02,                                     /* TLV type =
2, not optional */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       0x00, 0x14,                                     /* TLV value length =
=3D 20 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x=
11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        0x01, 0x02, 0x03, 0x04, =
0x05, 0x06, 0x07, 0x08, /* timestamp */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        0x00, 0x00, 0x00, 0x00,                        =
 /* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-format =
on */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, siz=
eof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Write a probe reply TLV and read it back=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_roundtrip(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
 =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst struct probe_reply in =3D {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        =2Erequest_id =3D 0x1122334455667788ULL,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        =2Epriority =3D 10,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eweight =3D 100,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Emax_late=
ncy_diff =3D 25,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     =2Econnect_lifetime =3D 30,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(probe_reply_write(&amp;buf, &amp;in));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&am=
p;buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REPLY_LEN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_peek_header(&am=
p;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REPLY);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Evalue_len, PROBE_REPLY_LEN);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REPLY, &amp;value)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct probe_reply out =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(pr=
obe_reply_read(&amp;value, &amp;out));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(in=2Erequest_id =3D=3D out=2Erequest_id)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(in=2Epriority, out=2Epriority);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(in=2Eweight, out=2Eweight);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Emax_l=
atency_diff, out=2Emax_latency_diff);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(in=2Econnect_lifetime, out=2Econnect=
_lifetime);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe r=
eply wire format is locked to the field order of the spec</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * (request_id, priority, weight, max=
_latency_diff, connect_lifetime, flags),</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * big-endian=2E */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_probe_reply_wire_format(void **state)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const struct probe_reply in =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ereq=
uest_id =3D 0x1122334455667788ULL,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        =2Epriority =3D 10,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        =2Eweight =3D 100,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =
=3D 30,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Ef=
lags =3D PROBE_REPLY_FLAG_RESEND_WKC,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(probe_reply_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* clang-format off */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const uint8_t expected[] =3D {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        0x00, 0x03,                                =
     /* TLV type 3, not optional */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0x00, 0x12,                                     /* =
TLV value length =3D 18 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_i=
d */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0=
x0a,                                     /* priority =3D 10 */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x64,             =
                        /* weight =3D 100 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        0x00, 0x19,                               =
      /* max_latency_diff =3D 25 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0x00, 0x1e,                                     /* =
connect_lifetime =3D 30 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        0x00, 0x01,                                     /* flags =3D=
 RESEND_WKC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-forma=
t on */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, s=
izeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* A TLV with a longer-than-known value must still parse=
: the known fields are</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * read and the trailing bytes are skipped=2E Flag bits we do not know a=
re kept</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rather th=
an rejected, for the same forward compatibility=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_probe_request_forward_compat(void **state)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D all=
oc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint=
16_t extended_len =3D PROBE_REQUEST_LEN + 4;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf=
, TLV_TYPE_PROBE_REQUEST, false, extended_len));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(buf_write_u64(&amp;buf, 7));  =
           /* request_id */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(buf_write_u64(&amp;buf, 0xdeadbeefULL)); /* timesta=
mp */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(buf_write_u32(&amp;buf, 0x80000000));    /* flags, unknown bit set */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_wri=
te_u32(&amp;buf, 0x11223344));    /* unknown trailing field */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, TL=
V_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), extended_len);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct probe_request out =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_re=
quest_read(&amp;value, &amp;out));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(out=2Erequest_id =3D=3D 7);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=
=3D 0xdeadbeefULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(out=2Eflags =3D=3D 0x80000000);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* the unknown trailing field must have bee=
n consumed from the payload */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* A value shorter t=
han the mandatory fields must be rejected, even when it</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * holds enough bytes for some of the i=
ndividual fields to read successfully=2E */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+test_probe_request_too_short(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(12=
8, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 8 of the 20 mandato=
ry value bytes: enough for the request_id alone */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u64(&amp;buf, 0xde=
adbeefULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_request o=
ut =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(probe_request_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The same for the =
reply, one u16 short of its 18 mandatory bytes=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_probe_reply_too_short(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_=
gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_w=
rite_u64(&amp;buf, 1));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; 4; i++)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        assert_true(buf_write_u16(&amp;buf, 0));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    struct probe_reply out =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_false(probe_reply_read(&amp;buf, &amp;out))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* The flag combinations the protocol rules out must be rejected: the ot=
her</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * addresses of =
a remote cannot be both the same server and distinct ones, and</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * a shared connect_lifetime nee=
ds them to have been called equal=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+test_probe_reply_flags_contradict(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const uint16_t bad[] =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_ADDRS=
_EQUAL | PROBE_REPLY_FLAG_PROBE_MORE,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        PROBE_REPLY_FLAG_LIFETIME_SHARED,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_LIFETIME_S=
HARED | PROBE_REPLY_FLAG_PROBE_MORE,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    const uint16_t good[] =3D {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        0,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        PROBE_REPLY_FLAG_ADDRS_EQUAL,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_PROBE_MORE,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPLY_FLAG_ADDRS_EQ=
UAL | PROBE_REPLY_FLAG_LIFETIME_SHARED,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (siz=
e_t i =3D 0; i &lt; SIZE(bad) + SIZE(good); i++)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const bool expect_ok =3D i &gt;=3D SIZE(bad);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        const uint16_t fla=
gs =3D expect_ok ? good[i - SIZE(bad)] : bad[i];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct probe_=
reply in =3D { =2Erequest_id =3D 1, =2Eflags =3D flags };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        assert_true(probe_reply_write=
(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct bu=
ffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REPLY, &amp;value));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct probe_reply out =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_i=
nt_equal(probe_reply_read(&amp;value, &amp;out), expect_ok);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* A TLV header claiming mo=
re value bytes than the payload holds must be</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * rejected by the scan rather than reported as f=
ound -- for the TLV being</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * looked for as much as for one that would merely be skipped=2E */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_value_truncated(void *=
*state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bu=
ffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the wanted TLV decla=
res 20 value bytes, only 8 are present */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_tlv_write_header(&amp;buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUE=
ST_LEN));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u64(&amp;buf, 0xdeadbeefULL));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, TLV=
_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* same defect on a TLV that would be skipped: the scan must not walk past<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * the end of th=
e payload looking for the next header */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct buffer buf2 =3D alloc_buf_gc(128, &amp;gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctr=
l_msg_tlv_write_header(&amp;buf2, 0x7ff, false, 64));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf2, =
0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_fals=
e(ctrl_msg_find_tlv(&amp;buf2, TLV_TYPE_PROBE_REQUEST, &amp;value));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* =
Bytes left over after the last TLV that are too few for a header make the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * message malformed,=
 even when the wanted TLV was already found=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+test_find_tlv_trailing_bytes(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* 1 to 3 bytes: less than a 4-byte TLV header *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int trail=
ing =3D 1; trailing &lt; CTRL_MSG_TLV_HEADER_LEN; trailing++)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        struct buffer buf =3D alloc_buf_gc(128,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst struct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D 1 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_tr=
ue(probe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; trailing; i++)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            assert_true(buf_write=
_u8(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ass=
ert_false(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* An unknow=
n TLV marked optional after the wanted one is skipped, and the</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * wanted value is still the one=
 returned=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_skips=
_optional_after_wanted(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct probe_request in =3D {=
 =2Erequest_id =3D 1, =2Etimestamp =3D 7 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(probe_request_write(&amp;buf, &amp;=
in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(ctrl_msg_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf,=
 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv=
(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), PROBE_R=
EQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct probe_request out =3D { 0 };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(probe_request_read(&amp;value, &amp;out));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Et=
imestamp =3D=3D 7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* A TLV we do not know that is not marked optional ca=
rries something its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * sender requires us to act on, so the scan rejects the message whether th=
at</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLV comes befo=
re or after the wanted one=2E */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_find_tlv_rejects_unknown_mandatory(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct probe_request in =
=3D { =2Erequest_id =3D 1, =2Etimestamp =3D 7 };</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer before =3D alloc_buf_gc(128, &amp;gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv=
_write_header(&amp;before, 0x7ff, false, 4));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;before, 0xcafe=
f00d));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(probe_request_write(&amp;before, &amp;in));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct buffer after =3D alloc_buf_gc(128, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_=
write(&amp;after, &amp;in));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;after, 0x7ff, false=
, 4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(buf_write_u32(&amp;after, 0xcafef00d));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_false(ctrl_msg_find_tlv(&amp;before, TLV_TYPE_PROBE_REQUEST,=
 &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(ctrl_msg_find_tlv(&amp;after, TLV_TYPE_PROBE_REQUEST, &amp;valu=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/* The wanted TLV may occur only once: a second one rejects the messa=
ge=2E Repeats</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of =
an unknown TLV marked optional are skipped like any other=2E */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+test_find_tlv_rejects_duplicate(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer val=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct=
 probe_request in =3D { =2Erequest_id =3D 1 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_wri=
te(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv=
(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 2; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        assert_true(ctrl_msg_tlv_write_he=
ader(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        assert_true(buf_write_u32(&amp;buf, 0));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(probe_request_write(&amp;buf, &=
amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* An empty payload holds no TLV=2E */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_find_tlv_empty_payload(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(16, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer =
value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_t=
lv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/openvpn/test_=
probe=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000=2E=2Ee60aa45</span><br><span>--=
- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_probe=2Eh</=
span><br><span>@@ -0,0 +1,53 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  O=
penVPN -- An application to securely tunnel IP networks</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP po=
rt, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             session authentication and key exchange,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet en=
cryption, packet authentication, and</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet compression=2E</span><br><span style=
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
or: hsl(120, 100%, 40%);">+#ifndef TEST_PROBE_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define TEST_PROBE_H</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void test_probe_request_roundtrip(void **state);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void test_probe_request_wire_format(void **state);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_probe_reply_roundtrip(void **st=
ate);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void test_probe_reply_wire_format=
(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_request=
_forward_compat(void **state);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void tes=
t_probe_request_too_short(void **state);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+void test_probe_reply_too_short(void **state);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void test_probe_reply_flags_contradict(void **state);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void test_find_tlv_value_truncated(void **state);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void test_find_tlv_trailing_bytes(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void test_find_tlv_skips_opti=
onal_after_wanted(void **state);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void t=
est_find_tlv_rejects_unknown_mandatory(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_find_tlv_rejects_duplicate(void **state);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void test_find_tlv_empty_payload(void **state);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></=
pre><p>To view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+=
/1741?usp=3Demail">change 1741</a>=2E To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail">settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
=2Eorg/ViewAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=
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
 style=3D"display:none"> Gerrit-PatchSet: 27 </div>
<div style=3D"display:n=
one"> Gerrit-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div =
style=3D"display:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2=
549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Li=
chtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none=
"> Gerrit-Reviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Reviewer: chugly &lt;charlie=2Evigue@openvpn=2Ec=
om&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;ope=
nvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"=
> Gerrit-Attention: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div styl=
e=3D"display:none"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Eco=
m&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: chugly &lt;char=
lie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<div style=
=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lichtenhel=
d=2Ecom&gt; </div>

</body></html>
--epAJZ0bcu10=--


--===============4241175539455697802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4241175539455697802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============4241175539455697802==--

