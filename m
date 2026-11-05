Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2CF606A326
	for <openvpn-devel@archiver.kernel.org>; Thu,  5 Nov 2026 13:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ZmTpur/B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TF9vIi5i;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MuPv3xJR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=eVqWKULC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=AUKdqgUofrLbzDkip9peKcU63r63ylT2qqIcjuz5uKU=; b=ZmTpur/BojP70evhOs2/O5j/4G
	HaV+QVj+7yf30OEF54g3+Hk2QpBs8x6JzceYQlzkawkm6sI4y6LLyiGWS3EExSRc2uqgpWePW+xgm
	2nWb2KBf4kOXZ7MkSgMH+71ymMZAPRDURa6ZjWLGLOyg+CtBUZ1wnpq61bHY0ETRRfeg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xOxNH-000000005lh-1Ltt;
	Thu, 05 Nov 2026 13:19:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xOxNF-000000005lU-1EAb
 for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:19:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F9UK5Kfi8SIn2Wr9x5Jbv6fGm3BSE1fDRqpRQIbvQm0=; b=TF9vIi5iTRyL0RiZ7rpRtnhsUG
 yhTFjaygsNAYkXZ+fPa58fj4gZfYdwPCVZRQtE01lYSLEzutpf3mfWffM1UsrrsFYbKoe0N5PFFUO
 Ns1WLjoT/YE+USfG60gPQrVONB8m2Gxmw4+VAx01BP8NadroMf86uAC9L/3N0w4uvl0g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=F9UK5Kfi8SIn2Wr9x5Jbv6fGm3BSE1fDRqpRQIbvQm0=; b=MuPv3xJRhLuhLyIiGqWS6Z7Wv0
 zj3yDb0UZ90BTOTyLBQa3cmwcGQjFxBO5IsPMi5HvpLf6fMhv5BS/TEAYJSQIM3z7N2vec5x/nhB+
 BjtK7AY91x39R3kwiTOmQC0fIO7UVPgmIPUo4QBIU8CPfk6krMPpgBYmyLsrZpMs3HhA=;
Received: from mail-wr1-f43.google.com ([209.85.221.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOxN9-000000004WN-1SJY for openvpn-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 13:19:25 +0000
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1614748f8f.2
 for <openvpn-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 05:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793884753; x=1794489553; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=F9UK5Kfi8SIn2Wr9x5Jbv6fGm3BSE1fDRqpRQIbvQm0=;
 b=eVqWKULC2WIMzmOqjWh7PzLKSRFjYw7ERLZO9tCz+eAFF8o298LHI8L5Nsl73n6AoO
 RRoktWaJ1z0CU6SXNHcCiFiRZp6Q2CqBEb7XJsiE9CHt27Zkd36EcpCMh8AoduteeRvo
 g6Q/ZO7N8s1D/Vo551Bd9k915kEaj8LmJdv7I4KUyWR/sXBEZeOqBVU1+pLzPwOWpqJF
 JtUXoalb+4Qaz19g024Pbj6Fvs+XdTGTQ02SoT+zUyQHK8yXJ0O9k4Rd7C+bNFFjyE2V
 yYtzK2kVAjTa5DuZbRb5//EqkUo8Yd1NXgdC2BnrGXtcVxwf2+Mnw77Ue0tVuPlnWgKA
 f7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793884753; x=1794489553;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=F9UK5Kfi8SIn2Wr9x5Jbv6fGm3BSE1fDRqpRQIbvQm0=;
 b=jCdwkvooLIFcsF2obUlQbxn0ItVeD8rEXAaax+pWZStePmsXjbO2Mh5/4fDZ1mKyqd
 wsYs57DdnoOSIMoQ3Zcpfr5Avv5NSLOYvJTzEYgeUFUO4LCHQr6kMUypsd/aGjHv9QvV
 Oq82wCaUoyFKqLwKiJ4Z3+G8Kex3HoguP8E8lx/6lz+QWd27cWgRID+VnvowIW+8sPY5
 Cu5b4bw+VMYYZyBo963kzwahpnueDoBJDhnU/1ztKv9jTUaYk7AUMs+cjX9MU9rogmp4
 yZYM/gaKFz9RdlAB/2FjdiB9QRxkpJwjt+d63/VyZaI7jQpLCTg/Aj8kdf14PZrYH6sh
 HX4w==
X-Gm-Message-State: APuU4Z9PxCVSRdmwUal1Mo3umA1Mlp7XAJMAJDbkeakmz2XWnmBC96Q7
 OQRVpd4rkI3gQRzAyeJ1AI8MTobgD2H2LkDKYOf39RUmwIv08Y3SbcgUCsQ7fJ2pjHRNwn1gDVB
 c0Llfo8dRbGADWtQgRSElEW/e1FM91C3p5SvVjl1cQuB1DmhWMfJxFVkoU6NfVnyFIWJO
X-Gm-Gg: AYBFou0hI4/U7iL9OYV1AB+cIQ5hcQ3xLRkk2JV99Ojm747DdVrDNwq9wqRHljmfwaH
 tW6+Zhq7XUHRw5gCTMW1I8n2TWqBp0Rvm8WkyUVRimsW5aQfENbGztmJskBqxaa+1EW1mCSlvzR
 VeJwlxcY1jv4tHhXkUe8kME5hibyTMyZprMX0lXs5EcJHUXWfZWqr1nyNBU+ouU6zxsxY7f+K5F
 fr2TymUaX+bfIhJKgQhDyt+ftAHoQazmC4OoinvcUvPlTinYXa1nW+sizGWjo87mhRh7HoCAQUX
 LaMYlYHpoIuMfVgu3sHu/81MGLW5tyftUGC7Vrrx3rT/dl9itx6fa3IrwtZF/cClIhR9mswyT0k
 LvUqOCTuhyGQJMBAnixi4Sjpee5NVoFAhzF2PrNY4rJNW0j1ScwSFLGhpWAACvzAl44zVu1T8EU
 iEG7IruRc3AFfUuDvE1o1xusK+SXFn9mi9Sh6d+Ls8VaWPHRtnL0y3UnJv6rmKNTrA3j5yXiSOO
 3Brs+R1TlDIprw4DoS7lRcNl9S4ckIjpYjnI8ejGSHbWku7Nd1t9ZwPqtbk11nlbB0GL20v1Ovc
 Tjv5LSDjVV8wcO0UPKXfaPB15f8Rd6szj1Y7DhO+0YWH7QWsrxqU6mFhZMa1ILXhYvWUUj5fMMF
 U/Z/etmTtfLas6G6lRHRvDTMZTnRpCriBWghf55IluZEpMadxL/K90jrDK8W6r5qX6FwysLINeG
 mY5kJb5wCPD++1oA==
X-Received: by 2002:a5d:5e8d:0:b0:48d:fd53:828d with SMTP id
 ffacd0b85a97d-48e6e50d75fmr37834565f8f.30.1793884751934; 
 Thu, 05 Nov 2026 05:19:11 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feda2007esm9968460f8f.47.2026.11.05.05.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 05:19:11 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Thu, 5 Nov 2026 13:19:08 +0000
To: Ralf Lici <ralf@mandelbit.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 23
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 56f107a0d912541dcb20f932e82fc2668c3fb01f
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <4d3bd1d728b16ebd96aa4a3f0df559b376a01bb0-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xOxN9-000000004WN-1SJY
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
Content-Type: multipart/mixed; boundary="===============7401313150848495634=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============7401313150848495634==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="v6y0n1CzNPM="; charset=UTF-8

--v6y0n1CzNPM=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Lev =
Stipakov, Ralf Lici=2E

Hello Arne Schwabe, Frank Lichtenheld, Ralf Lici, 
=

I'd like you to reexamine a change=2E Please visit

    https://gerrit=2Eo=
penvpn=2Enet/c/openvpn/+/1741?usp=3Demail

to look at the new patch set (#2=
3)=2E


Change subject: control_msg: Add P_CONTROL_V2 and the probe request=
 and reply TLVs
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E

control_msg: Add P_CONTROL_V2 and the probe request and reply TLVs

A =
client probes a server before connecting by sending a P_CONTROL_V2
message =
carrying a probe request TLV, and the server answers with a
P_CONTROL_V2 ca=
rrying a probe reply=2E The reply tells the client how the
server wants to =
be ranked against the other remotes, and can also serve
as the second packe=
t of the three-way handshake=2E

Add the two opcodes and the two TLV codecs=
 the probe needs=2E P_CONTROL_V2
is framed like P_CONTROL_V1 but without th=
e fields of the reliability
layer: a session id and then the TLVs, with no =
control message id and no
ACK array=2E P_CONTROL_WKC_V2 is the same with th=
e wrapped client key
appended, as P_CONTROL_WKC_V1 is to P_CONTROL_V1=2E

T=
he TLVs use the shared TLV codec, control_msg=2Ec/h, and their two types
jo=
in the others there=2E The codec gains ctrl_msg_find_tlv(), which scans
a p=
ayload for the one mandatory TLV of a message=2E The scan is strict: a
trun=
cated TLV header or value, a second TLV of the wanted type, or an
unknown T=
LV not marked optional rejects the whole message=2E

Both readers accept a =
value longer than the fields they know and ignore
the excess, which is how =
the TLVs are meant to be extended=2E The probe
reply reader does reject the=
 two flag combinations the protocol rules
out, as neither can be acted on: =
the other addresses of a remote cannot
be both the same server and distinct=
 ones, and the connect_lifetime
cannot be extended to those addresses witho=
ut first calling them the
same server=2E

The reliable control path no long=
er decides what it handles from an
opcode range=2E P_FIRST_OPCODE and P_LAS=
T_OPCODE give way to
opcode_is_reliable_control(), which lists the opcodes =
that carry a
message id and an ACK array, and tls_pre_decrypt() and
write_c=
ontrol_auth() test that instead=2E Defining an opcode therefore no
longer j=
oins it to that set, so neither the two added here nor
CONTROL_AUX_V1 after=
 them needs to be carved back out of a range=2E

No opcode changes hands: t=
he old range covered exactly the seven listed,
plus the two data channel op=
codes, which are handled before the check is
reached=2E

The probe is not s=
ent or answered yet; that follows=2E

Change-Id: I1c8d302ac57c5603d622a7be1=
4be369437388268
Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMake=
Lists=2Etxt
M src/openvpn/Makefile=2Eam
M src/openvpn/control_msg=2Ec
M src=
/openvpn/control_msg=2Eh
A src/openvpn/probe=2Ec
A src/openvpn/probe=2Eh
M =
src/openvpn/ssl=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M t=
ests/unit_tests/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_pkt=
=2Ec
A tests/unit_tests/openvpn/test_probe=2Ec
A tests/unit_tests/openvpn/t=
est_probe=2Eh
13 files changed, 832 insertions(+), 14 deletions(-)


  git =
pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/23

di=
ff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 305c26c=2E=2Ec650468 1=
00644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -565,6 +565,8 @@
   =
  src/openvpn/plugin=2Eh
     src/openvpn/pool=2Ec
     src/openvpn/pool=2E=
h
+    src/openvpn/probe=2Ec
+    src/openvpn/probe=2Eh
     src/openvpn/pr=
oto=2Ec
     src/openvpn/proto=2Eh
     src/openvpn/proxy=2Ec
@@ -899,7 +90=
1,9 @@
     target_sources(test_pkt PRIVATE
         tests/unit_tests/openv=
pn/mock_win32_execve=2Ec
         tests/unit_tests/openvpn/test_control_msg=
=2Ec
+        tests/unit_tests/openvpn/test_probe=2Ec
         src/openvpn/=
control_msg=2Ec
+        src/openvpn/probe=2Ec
         src/openvpn/argv=2E=
c
         src/openvpn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
dif=
f --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index be104=
4d=2E=2E2797a1c 100644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Ma=
kefile=2Eam
@@ -120,7 +120,7 @@
 	packet_id=2Ec packet_id=2Eh \
 	ping=2Ec =
ping=2Eh \
 	plugin=2Ec plugin=2Eh \
-	pool=2Ec pool=2Eh \
+	pool=2Ec pool=
=2Eh 	probe=2Ec probe=2Eh \
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \=

 	ps=2Ec ps=2Eh \
diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/c=
ontrol_msg=2Ec
index 872191f=2E=2E8a744b0 100644
--- a/src/openvpn/control_=
msg=2Ec
+++ b/src/openvpn/control_msg=2Ec
@@ -91,3 +91,32 @@
     buf_set_r=
ead(value, v, hdr->value_len);
     return true;
 }
+
+bool
+ctrl_msg_find_=
tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *value)
+{
=
+    bool found =3D false;
+    while (BLEN(payload) > 0)
+    {
+        s=
truct ctrl_msg_tlv_header hdr;
+        struct buffer v;
+        if (!ctrl=
_msg_tlv_next(payload, &hdr, &v))
+        {
+            return false;
+  =
      }
+        if (hdr=2Etype =3D=3D wanted_type)
+        {
+           =
 if (found)
+            {
+                return false; /* the TLV may oc=
cur only once */
+            }
+            *value =3D v;
+            fou=
nd =3D true;
+        }
+        else if (!hdr=2Eoptional)
+        {
+    =
        return false; /* a mandatory TLV we do not understand, wherever it =
sits */
+        }
+    }
+    return found;
+}
diff --git a/src/openvpn/co=
ntrol_msg=2Eh b/src/openvpn/control_msg=2Eh
index 7d25545=2E=2E1abd66b 1006=
44
--- a/src/openvpn/control_msg=2Eh
+++ b/src/openvpn/control_msg=2Eh
@@ -=
41,6 +41,8 @@
 
 /* TLV types */
 #define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /=
* early negotiation, in the reset packets */
+#define TLV_TYPE_PROBE_REQUES=
T   0x0002 /* a client probing a server, in P_CONTROL_V2 */
+#define TLV_TY=
PE_PROBE_REPLY     0x0003 /* the server's answer, in P_CONTROL_V2 */
 
 /* =
TLV header bit layout of the first 16-bit field */
 /* A TLV header is a 16=
-bit type/optional field plus a 16-bit length */
@@ -104,4 +106,28 @@
  */
=
 bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_header *hdr=
, struct buffer *value);
 
+/**
+ * Scan payload for the TLV of type wanted=
_type, skipping any other TLV type
+ * that is marked optional=2E
+ *
+ * T=
his is for messages that carry exactly one mandatory TLV, which is what the=

+ * probe messages are=2E Any other TLV that is not marked optional invali=
dates
+ * the message wherever it appears, as does a second TLV of wanted_t=
ype, so the
+ * whole sequence is walked even once the wanted TLV has been =
found=2E A message
+ * carrying several mandatory TLVs walks them with ctrl=
_msg_tlv_next() instead=2E
+ *
+ * On success value covers exactly the foun=
d TLV's value bytes; as in
+ * ctrl_msg_tlv_next(), a header claiming more =
bytes than payload holds is
+ * rejected rather than reported as found=2E p=
ayload is consumed as it is read=2E
+ *
+ * @param payload      buffer posi=
tioned at a TLV header
+ * @param wanted_type  the TLV type to look for
+ *=
 @param value        set to a buffer covering the found TLV's value; it poi=
nts
+ *                     into payload and owns no storage
+ * @return tr=
ue if the TLV was found, false if it is absent or present more
+ *         =
than once, if a TLV header or value is malformed or truncated, or if
+ *   =
      a TLV we do not understand is not marked optional=2E
+ */
+bool ctrl_=
msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct buffer *v=
alue);
+
 #endif /* ifndef CONTROL_MSG_H */
diff --git a/src/openvpn/probe=
=2Ec b/src/openvpn/probe=2Ec
new file mode 100644
index 0000000=2E=2E2497b0=
7
--- /dev/null
+++ b/src/openvpn/probe=2Ec
@@ -0,0 +1,94 @@
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
+#include "probe=2Eh"
+#include "control_msg=2Eh"
+
+bool
+probe_re=
quest_write(struct buffer *buf, const struct probe_request *r)
+{
+    retu=
rn ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQU=
EST_LEN)
+           && buf_write_u64(buf, r->request_id) && buf_write_u64(=
buf, r->timestamp)
+           && buf_write_u32(buf, r->flags);
+}
+
+bool
=
+probe_request_read(struct buffer *buf, struct probe_request *r)
+{
+    /*=
 One bounds check covers the whole value: every field read below then fits
=
+     * by construction, PROBE_REQUEST_LEN being the sum of their sizes, so=
 none
+     * of them needs its own error handling=2E Trailing bytes this v=
ersion does
+     * not understand are simply left unread=2E */
+    if (bu=
f_len(buf) < PROBE_REQUEST_LEN)
+    {
+        return false;
+    }
+    r=
->request_id =3D buf_read_u64(buf, NULL);
+    r->timestamp =3D buf_read_u6=
4(buf, NULL);
+    r->flags =3D buf_read_u32(buf, NULL);
+    return true;
=
+}
+
+bool
+probe_reply_write(struct buffer *buf, const struct probe_reply =
*r)
+{
+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REPLY, fal=
se, PROBE_REPLY_LEN)
+           && buf_write_u64(buf, r->request_id) && bu=
f_write_u16(buf, r->priority)
+           && buf_write_u16(buf, r->weight) =
&& buf_write_u16(buf, r->max_latency_diff)
+           && buf_write_u16(buf=
, r->connect_lifetime) && buf_write_u16(buf, r->flags);
+}
+
+bool
+probe_r=
eply_read(struct buffer *buf, struct probe_reply *r)
+{
+    /* One bounds =
check for the whole value, as in probe_request_read()=2E */
+    if (buf_le=
n(buf) < PROBE_REPLY_LEN)
+    {
+        return false;
+    }
+    r->requ=
est_id =3D buf_read_u64(buf, NULL);
+    r->priority =3D (uint16_t)buf_read=
_u16(buf);
+    r->weight =3D (uint16_t)buf_read_u16(buf);
+    r->max_late=
ncy_diff =3D (uint16_t)buf_read_u16(buf);
+    r->connect_lifetime =3D (uin=
t16_t)buf_read_u16(buf);
+    r->flags =3D (uint16_t)buf_read_u16(buf);
+
+=
    /* The other addresses of the remote cannot be both the same server and=

+     * distinct ones=2E And LIFETIME_SHARED extends the connect_lifetime =
to those
+     * other addresses, which says nothing unless ADDRS_EQUAL has=
 declared them
+     * the same server to begin with=2E */
+    if ((r->fla=
gs & PROBE_REPLY_FLAG_ADDRS_EQUAL) && (r->flags & PROBE_REPLY_FLAG_PROBE_MO=
RE))
+    {
+        return false;
+    }
+    if ((r->flags & PROBE_REPLY_=
FLAG_LIFETIME_SHARED) && !(r->flags & PROBE_REPLY_FLAG_ADDRS_EQUAL))
+    {=

+        return false;
+    }
+    return true;
+}
diff --git a/src/openvp=
n/probe=2Eh b/src/openvpn/probe=2Eh
new file mode 100644
index 0000000=2E=
=2Ee8b0299
--- /dev/null
+++ b/src/openvpn/probe=2Eh
@@ -0,0 +1,141 @@
+/*
=
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *          =
   over a single TCP/UDP port, with support for SSL/TLS-based
+ *          =
   session authentication and key exchange,
+ *             packet encrypti=
on, packet authentication, and
+ *             packet compression=2E
+ *
+ =
*  Copyright (C) 2002-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This =
program is free software; you can redistribute it and/or modify
+ *  it und=
er the terms of the GNU General Public License version 2
+ *  as published =
by the Free Software Foundation=2E
+ *
+ *  This program is distributed in =
the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without eve=
n the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR =
PURPOSE=2E  See the
+ *  GNU General Public License for more details=2E
+ *=

+ *  You should have received a copy of the GNU General Public License alo=
ng
+ *  with this program; if not, see <https://www=2Egnu=2Eorg/licenses/>=
=2E
+ */
+
+/**
+ * @file
+ * Encoding and decoding of the server probe TLV=
s=2E
+ *
+ * A client probes a server by sending a P_CONTROL_V2 message who=
se payload
+ * carries a probe request TLV, and the server answers with a P=
_CONTROL_V2
+ * message carrying a probe reply TLV=2E The reply tells the c=
lient how the
+ * server wants to be ranked against the other remotes, and =
can also serve
+ * as the second packet of the three-way handshake=2E
+ *
+=
 * The TLV framing and the TLV type space are shared with the other TLV-bas=
ed
+ * control messages and live in control_msg=2Eh; this file holds the tw=
o probe
+ * TLVs and what their fields mean=2E
+ */
+
+#ifndef PROBE_H
+#de=
fine PROBE_H
+
+#include "buffer=2Eh"
+#include "control_msg=2Eh"
+
+/* Sma=
llest on-wire value length (the TLV header not counted) of each TLV: the
+ =
* sizes of the fixed fields below, in wire order=2E A value may be longer, =
which
+ * is how the TLVs are extended; trailing bytes that are not underst=
ood are
+ * ignored on read=2E */
+
+/* request_id (u64), timestamp (u64), =
flags (u32) */
+#define PROBE_REQUEST_LEN ((uint16_t)(2 * sizeof(uint64_t) =
+ sizeof(uint32_t)))
+
+/* request_id (u64), then priority, weight, max_lat=
ency_diff,
+ * connect_lifetime and flags (u16 each) */
+#define PROBE_REPL=
Y_LEN ((uint16_t)(sizeof(uint64_t) + 5 * sizeof(uint16_t)))
+
+/* probe req=
uest flags=2E The client is only probing: it does not want to
+ * continue =
into a handshake, and the server may forget it right away=2E */
+#define PR=
OBE_REQUEST_FLAG_PROBE_ONLY 0x00000001
+
+/* probe reply flags */
+/* compl=
ete the handshake with P_CONTROL_WKC_V1 rather than P_CONTROL_V1 */
+#defin=
e PROBE_REPLY_FLAG_RESEND_WKC      0x0001
+/* the other addresses of this r=
emote are the same server, no need to probe them */
+#define PROBE_REPLY_FL=
AG_ADDRS_EQUAL     0x0002
+/* the connect_lifetime holds against those othe=
r addresses too, so a reply
+ * from one of them can skip the handshake wit=
h another=2E Only meaningful
+ * together with ADDRS_EQUAL, which is what n=
ames those addresses=2E */
+#define PROBE_REPLY_FLAG_LIFETIME_SHARED 0x0004=

+/* the other addresses of this remote are distinct servers, so probe them=
 too */
+#define PROBE_REPLY_FLAG_PROBE_MORE      0x0008
+
+/** probe reque=
st TLV, sent by a client to probe a server */
+struct probe_request
+{
+   =
 uint64_t request_id; /**< identifies this probe, echoed in the reply */
+ =
   /** The client clock as a UNIX timestamp in seconds=2E It is there for t=
he
+     * server, which uses it to bound how old a request it will answer =
and so
+     * how long a captured one can be replayed=2E The reply does no=
t echo it: a
+     * client times the round trip itself, by the request_id=
=2E */
+    uint64_t timestamp;
+    uint32_t flags; /**< PROBE_REQUEST_FLA=
G_* */
+};
+
+/** probe reply TLV, a server's answer to a probe request */
=
+struct probe_reply
+{
+    uint64_t request_id;       /**< echoes the requ=
est_id of the request */
+    uint16_t priority;         /**< DNS SRV style=
 priority, lower is preferred */
+    uint16_t weight;           /**< DNS S=
RV style weight */
+    uint16_t max_latency_diff; /**< candidate band in m=
s around the fastest server */
+    /** For how many seconds, counted from =
the moment the client sent its own
+     * probe request, the server will s=
till treat this exchange as the first
+     * two packets of the handshake=
=2E Within that window the client may send the
+     * third packet straigh=
t away instead of starting a handshake of its own=2E
+     * 0 means it can=
not, so it has to begin a fresh one=2E */
+    uint16_t connect_lifetime;
+=
    uint16_t flags; /**< PROBE_REPLY_FLAG_* */
+};
+
+/**
+ * Write a compl=
ete probe request TLV, header and value, to buf=2E
+ *
+ * @return true on =
success, false if buf has insufficient space=2E
+ */
+bool probe_request_wr=
ite(struct buffer *buf, const struct probe_request *r);
+
+/**
+ * Read a p=
robe request TLV value from buf=2E
+ *
+ * buf must cover exactly the TLV's=
 value, as ctrl_msg_find_tlv() returns it=2E
+ * Bytes beyond the fields un=
derstood here are ignored, so a longer value from
+ * a future version stil=
l parses=2E Flag bits that are not known are kept in
+ * flags rather than =
rejected, for the same reason=2E
+ *
+ * @return true on success, false if =
buf is shorter than the mandatory fields=2E
+ */
+bool probe_request_read(s=
truct buffer *buf, struct probe_request *r);
+
+/**
+ * Write a complete pr=
obe reply TLV, header and value, to buf=2E
+ *
+ * @return true on success,=
 false if buf has insufficient space=2E
+ */
+bool probe_reply_write(struct=
 buffer *buf, const struct probe_reply *r);
+
+/**
+ * Read a probe reply T=
LV value from buf=2E The calling convention is that of
+ * probe_request_re=
ad()=2E
+ *
+ * The two flag combinations the protocol rules out are reject=
ed here, since
+ * neither can be acted on: a reply must not call the other=
 addresses of the
+ * remote both the same server and distinct ones, and it=
 must not extend the
+ * connect_lifetime to those addresses without first =
calling them the same
+ * server=2E
+ *
+ * @return true on success, false =
if buf is shorter than the mandatory fields
+ *         or the flags contra=
dict each other=2E
+ */
+bool probe_reply_read(struct buffer *buf, struct p=
robe_reply *r);
+
+#endif /* ifndef PROBE_H */
diff --git a/src/openvpn/ssl=
=2Ec b/src/openvpn/ssl=2Ec
index e531613=2E=2Eb4b89aa 100644
--- a/src/open=
vpn/ssl=2Ec
+++ b/src/openvpn/ssl=2Ec
@@ -3791,15 +3791,26 @@
     bool new=
_link =3D false;
     struct session_id sid; /* remote session ID */
 
-   =
 /* verify legal opcode */
-    if (op < P_FIRST_OPCODE || op > P_LAST_OPCO=
DE)
+    /* verify the opcode belongs to the reliable control channel, whos=
e
+     * message id and ACK array we parse below */
+    if (!opcode_is_re=
liable_control(op))
     {
         if (op =3D=3D P_CONTROL_HARD_RESET_CLIE=
NT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)
         {
             =
msg(D_TLS_ERRORS, "Peer tried unsupported key-method 1");
         }
-     =
   msg(D_TLS_ERRORS, "TLS Error: unknown opcode received from %s op=3D%d",
=
-            print_link_socket_actual(from, &gc), op);
+        if (op =3D=
=3D P_CONTROL_V2 || op =3D=3D P_CONTROL_WKC_V2)
+        {
+            /* =
a defined opcode, just not one this path can parse */
+            msg(D_TL=
S_ERRORS, "TLS Error: %s received from %s, which is not part of "
+        =
                      "the reliable control channel",
+                pack=
et_opcode_name(op), print_link_socket_actual(from, &gc));
+        }
+     =
   else
+        {
+            msg(D_TLS_ERRORS, "TLS Error: unknown opcod=
e received from %s op=3D%d",
+                print_link_socket_actual(from=
, &gc), op);
+        }
         goto error;
     }
 
diff --git a/src/open=
vpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec
index f4564ef=2E=2Eccb841e 100644=

--- a/src/openvpn/ssl_pkt=2Ec
+++ b/src/openvpn/ssl_pkt=2Ec
@@ -169,7 +169=
,8 @@
                    bool prepend_ack)
 {
     ASSERT(ks->key_id >=3D =
0 && ks->key_id <=3D P_KEY_ID_MASK);
-    ASSERT(opcode >=3D 0 && opcode <=
=3D P_LAST_OPCODE);
+    /* this writes the message id and ACK array, which=
 only these opcodes have */
+    ASSERT(opcode_is_reliable_control(opcode))=
;
     uint8_t header =3D (uint8_t)(ks->key_id | (opcode << P_OPCODE_SHIFT)=
);
 
     /* Workaround for Softether servers=2E Softether has a bug that i=
t only
diff --git a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh
index=
 218c6bb=2E=2E3b45492 100644
--- a/src/openvpn/ssl_pkt=2Eh
+++ b/src/openvp=
n/ssl_pkt=2Eh
@@ -58,11 +58,50 @@
  * like P_CONTROL_HARD_RESET_CLIENT_V3 *=
/
 #define P_CONTROL_WKC_V1 11
 
-/* define the range of legal opcodes
- * =
Since we do no longer support key-method 1 we consider
- * the v1 op codes =
invalid */
-#define P_FIRST_OPCODE 3
-#define P_LAST_OPCODE  11
+/* Control=
 channel packet carrying a TLV payload, e=2Eg=2E a server probe=2E Framed
+=
 * like P_CONTROL_V1 but without the fields of the reliability layer: a ses=
sion
+ * id and then the TLVs, with no message id and no ACK array=2E It is=
 wrapped by
+ * tls-auth or tls-crypt like any other control channel packet=
, and with
+ * neither configured it travels unauthenticated, as they do=2E=
 */
+#define P_CONTROL_V2 12
+
+/* Variant of P_CONTROL_V2 with the wrapped=
 client key appended,
+ * like P_CONTROL_WKC_V1 is to P_CONTROL_V1 */
+#def=
ine P_CONTROL_WKC_V2 13
+
+/**
+ * Is a packet with opcode op carried by th=
e reliable control channel?
+ *
+ * These opcodes are followed by an ACK ar=
ray and a control message id, which
+ * is what the reliable path reads onc=
e it is past the session id=2E An opcode
+ * that is not one of them has so=
mething else there: P_CONTROL_V2 has its TLVs=2E
+ * Handing such a packet =
to that path would read the first bytes of that
+ * payload as an ACK count=
 and a message id, and ACK or queue whatever it made
+ * of them=2E
+ *
+ *=
 The opcodes are listed rather than bounded by a range, so that defining on=
e
+ * does not silently add it to the set=2E Key method 1 is no longer supp=
orted, so
+ * its two reset opcodes are not here, and the data channel opco=
des are handled
+ * before this is reached=2E
+ */
+static inline bool
+opc=
ode_is_reliable_control(int op)
+{
+    switch (op)
+    {
+        case P_=
CONTROL_SOFT_RESET_V1:
+        case P_CONTROL_V1:
+        case P_ACK_V1:
=
+        case P_CONTROL_HARD_RESET_CLIENT_V2:
+        case P_CONTROL_HARD_=
RESET_SERVER_V2:
+        case P_CONTROL_HARD_RESET_CLIENT_V3:
+        cas=
e P_CONTROL_WKC_V1:
+            return true;
+
+        default:
+        =
    return false;
+    }
+}
 
 /*
  * Define number of buffers for send and=
 receive in the reliability layer=2E
@@ -257,6 +296,12 @@
         case P_C=
ONTROL_WKC_V1:
             return "P_CONTROL_WKC_V1";
 
+        case P_CO=
NTROL_V2:
+            return "P_CONTROL_V2";
+
+        case P_CONTROL_WKC=
_V2:
+            return "P_CONTROL_WKC_V2";
+
         case P_ACK_V1:
    =
         return "P_ACK_V1";
 
diff --git a/tests/unit_tests/openvpn/Makefil=
e=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam
index 11f92f4=2E=2E209a9a1 =
100644
--- a/tests/unit_tests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/=
openvpn/Makefile=2Eam
@@ -165,14 +165,14 @@
 	@TEST_CFLAGS@
 pkt_testdriver=
_LDFLAGS =3D @TEST_LDFLAGS@
 pkt_testdriver_SOURCES =3D test_pkt=2Ec \
-	te=
st_control_msg=2Ec test_control_msg=2Eh \
+	test_control_msg=2Ec test_contr=
ol_msg=2Eh 	test_probe=2Ec test_probe=2Eh \
 	mock_msg=2Ec mock_msg=2Eh moc=
k_win32_execve=2Ec \
 	test_common=2Eh \
 	$(top_srcdir)/src/compat/compat-=
strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/argv=2Ec \
 	$(top_srcdir)/src/op=
envpn/base64=2Ec \
 	$(top_srcdir)/src/openvpn/buffer=2Ec \
-	$(top_srcdir)=
/src/openvpn/control_msg=2Ec \
+	$(top_srcdir)/src/openvpn/control_msg=2Ec =
	$(top_srcdir)/src/openvpn/probe=2Ec \
 	$(top_srcdir)/src/openvpn/crypto=
=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \
 	$(top_srcdir)/src/o=
penvpn/crypto_mbedtls=2Ec \
diff --git a/tests/unit_tests/openvpn/test_pkt=
=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
index 990a317=2E=2E75a1b31 100=
644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
+++ b/tests/unit_tests/open=
vpn/test_pkt=2Ec
@@ -45,6 +45,7 @@
 #include "reliable=2Eh"
 #include "siph=
ash=2Eh"
 #include "test_control_msg=2Eh"
+#include "test_probe=2Eh"
 
 int=

 parse_line(const char *line, char **p, const int n, const char *file, con=
st int line_num,
@@ -842,7 +843,20 @@
         cmocka_unit_test(test_tlv_ne=
xt_walks_payload),
         cmocka_unit_test(test_tlv_next_value_truncated)=
,
         cmocka_unit_test(test_tlv_header_truncated),
-        cmocka_uni=
t_test(test_tlv_write_no_room)
+        cmocka_unit_test(test_tlv_write_no_=
room),
+        cmocka_unit_test(test_probe_request_roundtrip),
+        cm=
ocka_unit_test(test_probe_request_wire_format),
+        cmocka_unit_test(t=
est_probe_reply_roundtrip),
+        cmocka_unit_test(test_probe_reply_wire=
_format),
+        cmocka_unit_test(test_probe_request_forward_compat),
+  =
      cmocka_unit_test(test_probe_request_too_short),
+        cmocka_unit_=
test(test_probe_reply_too_short),
+        cmocka_unit_test(test_probe_repl=
y_flags_contradict),
+        cmocka_unit_test(test_find_tlv_value_truncate=
d),
+        cmocka_unit_test(test_find_tlv_trailing_bytes),
+        cmock=
a_unit_test(test_find_tlv_skips_optional_after_wanted),
+        cmocka_uni=
t_test(test_find_tlv_rejects_duplicate),
+        cmocka_unit_test(test_fin=
d_tlv_empty_payload)
     };
 
     return cmocka_run_group_tests_name("pkt=
 tests", tests, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_pro=
be=2Ec b/tests/unit_tests/openvpn/test_probe=2Ec
new file mode 100644
index=
 0000000=2E=2E7cfb63d
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_pro=
be=2Ec
@@ -0,0 +1,402 @@
+/*
+ *  OpenVPN -- An application to securely tun=
nel IP networks
+ *             over a single TCP/UDP port, with support fo=
r SSL/TLS-based
+ *             session authentication and key exchange,
+ =
*             packet encryption, packet authentication, and
+ *            =
 packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@=
openvpn=2Enet>
+ *
+ *  This program is free software; you can redistribute=
 it and/or modify
+ *  it under the terms of the GNU General Public License=
 version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  Th=
is program is distributed in the hope that it will be useful,
+ *  but WITH=
OUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY=
 or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public Li=
cense for more details=2E
+ *
+ *  You should have received a copy of the G=
NU General Public License along
+ *  with this program; if not, see <https:=
//www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "con=
fig=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdarg=2Eh>
+#inclu=
de <stddef=2Eh>
+#include <setjmp=2Eh>
+#include <cmocka=2Eh>
+
+#include "=
control_msg=2Eh"
+#include "probe=2Eh"
+#include "test_common=2Eh"
+#includ=
e "test_probe=2Eh"
+
+/* Write a probe request TLV and read it back; the fi=
elds must survive the
+ * round trip and the whole buffer must be consumed=
=2E */
+void
+test_probe_request_roundtrip(void **state)
+{
+    struct gc_=
arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+=

+    const struct probe_request in =3D {
+        =2Erequest_id =3D 0xdead=
beefcafef00dULL,
+        =2Etimestamp =3D 0x0123456789abcdefULL,
+        =
=2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,
+    };
+    assert_true(probe_=
request_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_H=
EADER_LEN + PROBE_REQUEST_LEN);
+
+    /* the header codec, read from a cop=
y so the scan below still sees it */
+    struct buffer peek =3D buf;
+    =
struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_read_header(&=
peek, &hdr));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);
+ =
   assert_false(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, PRO=
BE_REQUEST_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_find=
_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&va=
lue), PROBE_REQUEST_LEN);
+
+    struct probe_request out =3D { 0 };
+    a=
ssert_true(probe_request_read(&value, &out));
+    assert_true(in=2Erequest=
_id =3D=3D out=2Erequest_id);
+    assert_true(in=2Etimestamp =3D=3D out=2E=
timestamp);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    /* the sca=
n consumed header and value alike */
+    assert_int_equal(BLEN(&buf), 0);
=
+
+    gc_free(&gc);
+}
+
+/* The probe request wire format is locked to th=
e field order of the spec
+ * (request_id, timestamp, flags), big-endian=2E=
 */
+void
+test_probe_request_wire_format(void **state)
+{
+    struct gc_a=
rena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
=
+    const struct probe_request in =3D {
+        =2Erequest_id =3D 0x11223=
34455667788ULL,
+        =2Etimestamp =3D 0x0102030405060708ULL,
+        =
=2Eflags =3D 0,
+    };
+    assert_true(probe_request_write(&buf, &in));
+=

+    /* clang-format off */
+    const uint8_t expected[] =3D {
+        0=
x00, 0x02,                                     /* TLV type 2, not optional =
*/
+        0x00, 0x14,                                     /* TLV value le=
ngth =3D 20 */
+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* =
request_id */
+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, /* t=
imestamp */
+        0x00, 0x00, 0x00, 0x00,                         /* fla=
gs */
+    };
+    /* clang-format on */
+    assert_int_equal(BLEN(&buf), =
sizeof(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(ex=
pected));
+
+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV and read it=
 back=2E */
+void
+test_probe_reply_roundtrip(void **state)
+{
+    struct =
gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc)=
;
+
+    const struct probe_reply in =3D {
+        =2Erequest_id =3D 0x112=
2334455667788ULL,
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,
=
+        =2Emax_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 30,
+=
        =2Eflags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert_tru=
e(probe_reply_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), CTRL_MSG=
_TLV_HEADER_LEN + PROBE_REPLY_LEN);
+
+    struct buffer peek =3D buf;
+   =
 struct ctrl_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_read_header(=
&peek, &hdr));
+    assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REPLY);
+  =
  assert_false(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, PROB=
E_REPLY_LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tl=
v(&buf, TLV_TYPE_PROBE_REPLY, &value));
+
+    struct probe_reply out =3D {=
 0 };
+    assert_true(probe_reply_read(&value, &out));
+    assert_true(in=
=2Erequest_id =3D=3D out=2Erequest_id);
+    assert_int_equal(in=2Epriority=
, out=2Epriority);
+    assert_int_equal(in=2Eweight, out=2Eweight);
+    a=
ssert_int_equal(in=2Emax_latency_diff, out=2Emax_latency_diff);
+    assert=
_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);
+    assert_int_=
equal(in=2Eflags, out=2Eflags);
+    assert_int_equal(BLEN(&buf), 0);
+
+  =
  gc_free(&gc);
+}
+
+/* The probe reply wire format is locked to the field=
 order of the spec
+ * (request_id, priority, weight, max_latency_diff, con=
nect_lifetime, flags),
+ * big-endian=2E */
+void
+test_probe_reply_wire_fo=
rmat(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buf=
fer buf =3D alloc_buf_gc(128, &gc);
+
+    const struct probe_reply in =3D =
{
+        =2Erequest_id =3D 0x1122334455667788ULL,
+        =2Epriority =
=3D 10,
+        =2Eweight =3D 100,
+        =2Emax_latency_diff =3D 25,
+ =
       =2Econnect_lifetime =3D 30,
+        =2Eflags =3D PROBE_REPLY_FLAG_R=
ESEND_WKC,
+    };
+
+    assert_true(probe_reply_write(&buf, &in));
+
+   =
 /* clang-format off */
+    const uint8_t expected[] =3D {
+        0x00, =
0x03,                                     /* TLV type 3, not optional */
+ =
       0x00, 0x12,                                     /* TLV value length =
=3D 18 */
+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* reque=
st_id */
+        0x00, 0x0a,                                     /* priori=
ty =3D 10 */
+        0x00, 0x64,                                     /* we=
ight =3D 100 */
+        0x00, 0x19,                                     /*=
 max_latency_diff =3D 25 */
+        0x00, 0x1e,                           =
          /* connect_lifetime =3D 30 */
+        0x00, 0x01,               =
                      /* flags =3D RESEND_WKC */
+    };
+    /* clang-form=
at on */
+    assert_int_equal(BLEN(&buf), sizeof(expected));
+    assert_m=
emory_equal(BPTR(&buf), expected, sizeof(expected));
+
+    gc_free(&gc);
+=
}
+
+/* A TLV with a longer-than-known value must still parse: the known fi=
elds are
+ * read and the trailing bytes are skipped=2E Flag bits we do not=
 know are kept
+ * rather than rejected, for the same forward compatibility=
=2E */
+void
+test_probe_request_forward_compat(void **state)
+{
+    struc=
t gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &g=
c);
+
+    const uint16_t extended_len =3D PROBE_REQUEST_LEN + 4;
+    asse=
rt_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST, false, exte=
nded_len));
+    assert_true(buf_write_u64(&buf, 7));             /* reques=
t_id */
+    assert_true(buf_write_u64(&buf, 0xdeadbeefULL)); /* timestamp =
*/
+    assert_true(buf_write_u32(&buf, 0x80000000));    /* flags, unknown =
bit set */
+    assert_true(buf_write_u32(&buf, 0x11223344));    /* unknown=
 trailing field */
+
+    struct buffer value;
+    assert_true(ctrl_msg_fi=
nd_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&=
value), extended_len);
+
+    struct probe_request out =3D { 0 };
+    asse=
rt_true(probe_request_read(&value, &out));
+    assert_true(out=2Erequest_i=
d =3D=3D 7);
+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL);
+    a=
ssert_true(out=2Eflags =3D=3D 0x80000000);
+    /* the unknown trailing fie=
ld must have been consumed from the payload */
+    assert_int_equal(BLEN(&=
buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A value shorter than the mandatory =
fields must be rejected, even when it
+ * holds enough bytes for some of th=
e individual fields to read successfully=2E */
+void
+test_probe_request_to=
o_short(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct =
buffer buf =3D alloc_buf_gc(128, &gc);
+
+    /* 8 of the 20 mandatory valu=
e bytes: enough for the request_id alone */
+    assert_true(buf_write_u64(=
&buf, 0xdeadbeefULL));
+
+    struct probe_request out =3D { 0 };
+    asse=
rt_false(probe_request_read(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* The=
 same for the reply, one u16 short of its 18 mandatory bytes=2E */
+void
+t=
est_probe_reply_too_short(void **state)
+{
+    struct gc_arena gc =3D gc_n=
ew();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    assert_true=
(buf_write_u64(&buf, 1));
+    for (int i =3D 0; i < 4; i++)
+    {
+      =
  assert_true(buf_write_u16(&buf, 0));
+    }
+
+    struct probe_reply out=
 =3D { 0 };
+    assert_false(probe_reply_read(&buf, &out));
+
+    gc_free=
(&gc);
+}
+
+/* The flag combinations the protocol rules out must be reject=
ed: the other
+ * addresses of a remote cannot be both the same server and =
distinct ones, and
+ * a shared connect_lifetime needs them to have been ca=
lled equal=2E */
+void
+test_probe_reply_flags_contradict(void **state)
+{
=
+    struct gc_arena gc =3D gc_new();
+    const uint16_t bad[] =3D {
+    =
    PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_PROBE_MORE,
+        PR=
OBE_REPLY_FLAG_LIFETIME_SHARED,
+        PROBE_REPLY_FLAG_LIFETIME_SHARED |=
 PROBE_REPLY_FLAG_PROBE_MORE,
+    };
+    const uint16_t good[] =3D {
+   =
     0,
+        PROBE_REPLY_FLAG_ADDRS_EQUAL,
+        PROBE_REPLY_FLAG_PR=
OBE_MORE,
+        PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_LIFETIME=
_SHARED,
+    };
+
+    for (size_t i =3D 0; i < SIZE(bad) + SIZE(good); i+=
+)
+    {
+        const bool expect_ok =3D i >=3D SIZE(bad);
+        cons=
t uint16_t flags =3D expect_ok ? good[i - SIZE(bad)] : bad[i];
+
+        s=
truct buffer buf =3D alloc_buf_gc(128, &gc);
+        const struct probe_re=
ply in =3D { =2Erequest_id =3D 1, =2Eflags =3D flags };
+        assert_tru=
e(probe_reply_write(&buf, &in));
+
+        struct buffer value;
+        a=
ssert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REPLY, &value));
+
+     =
   struct probe_reply out =3D { 0 };
+        assert_int_equal(probe_reply_=
read(&value, &out), expect_ok);
+    }
+
+    gc_free(&gc);
+}
+
+/* A TLV =
header claiming more value bytes than the payload holds must be
+ * rejecte=
d by the scan rather than reported as found -- for the TLV being
+ * looked=
 for as much as for one that would merely be skipped=2E */
+void
+test_find=
_tlv_value_truncated(void **state)
+{
+    struct gc_arena gc =3D gc_new();=

+    struct buffer value;
+
+    /* the wanted TLV declares 20 value bytes=
, only 8 are present */
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
=
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE_PROBE_REQUEST, fa=
lse, PROBE_REQUEST_LEN));
+    assert_true(buf_write_u64(&buf, 0xdeadbeefUL=
L));
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
+void
+test_find_tlv_trailing_by=
tes(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buff=
er value;
+
+    /* 1 to 3 bytes: less than a 4-byte TLV header */
+    for=
 (int trailing =3D 1; trailing < CTRL_MSG_TLV_HEADER_LEN; trailing++)
+    =
{
+        struct buffer buf =3D alloc_buf_gc(128, &gc);
+        const str=
uct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D 1 };
+    =
    assert_true(probe_request_write(&buf, &in));
+        for (int i =3D 0;=
 i < trailing; i++)
+        {
+            assert_true(buf_write_u8(&buf, =
0));
+        }
+        assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROB=
E_REQUEST, &value));
+    }
+
+    gc_free(&gc);
+}
+
+/* An unknown TLV ma=
rked optional after the wanted one is skipped, and the
+ * wanted value is =
still the one returned=2E */
+void
+test_find_tlv_skips_optional_after_want=
ed(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffe=
r buf =3D alloc_buf_gc(128, &gc);
+    struct buffer value;
+
+    const st=
ruct probe_request in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D 7 };
+   =
 assert_true(probe_request_write(&buf, &in));
+    assert_true(ctrl_msg_tlv=
_write_header(&buf, 0x7ff, true, 4));
+    assert_true(buf_write_u32(&buf, =
0));
+
+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &va=
lue));
+    assert_int_equal(BLEN(&value), PROBE_REQUEST_LEN);
+    struct =
probe_request out =3D { 0 };
+    assert_true(probe_request_read(&value, &o=
ut));
+    assert_true(out=2Etimestamp =3D=3D 7);
+
+    gc_free(&gc);
+}
+=

+/* The wanted TLV may occur only once: a second one rejects the message=
=2E Repeats
+ * of an unknown TLV marked optional are skipped like any othe=
r=2E */
+void
+test_find_tlv_rejects_duplicate(void **state)
+{
+    struct=
 gc_arena gc =3D gc_new();
+    struct buffer value;
+    const struct prob=
e_request in =3D { =2Erequest_id =3D 1 };
+
+    struct buffer buf =3D allo=
c_buf_gc(128, &gc);
+    assert_true(probe_request_write(&buf, &in));
+    =
assert_true(probe_request_write(&buf, &in));
+    assert_false(ctrl_msg_fin=
d_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    buf =3D alloc_buf_gc(1=
28, &gc);
+    for (int i =3D 0; i < 2; i++)
+    {
+        assert_true(ct=
rl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+        assert_true(buf_wr=
ite_u32(&buf, 0));
+    }
+    assert_true(probe_request_write(&buf, &in));=

+    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));=

+
+    gc_free(&gc);
+}
+
+/* An empty payload holds no TLV=2E */
+void
+t=
est_find_tlv_empty_payload(void **state)
+{
+    struct gc_arena gc =3D gc_=
new();
+    struct buffer buf =3D alloc_buf_gc(16, &gc);
+    struct buffer=
 value;
+
+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST,=
 &value));
+
+    gc_free(&gc);
+}
diff --git a/tests/unit_tests/openvpn/te=
st_probe=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh
new file mode 100644=

index 0000000=2E=2Ebc51721
--- /dev/null
+++ b/tests/unit_tests/openvpn/te=
st_probe=2Eh
@@ -0,0 +1,51 @@
+/*
+ *  OpenVPN -- An application to securel=
y tunnel IP networks
+ *             over a single TCP/UDP port, with suppo=
rt for SSL/TLS-based
+ *             session authentication and key exchang=
e,
+ *             packet encryption, packet authentication, and
+ *       =
      packet compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <s=
ales@openvpn=2Enet>
+ *
+ *  This program is free software; you can redistr=
ibute it and/or modify
+ *  it under the terms of the GNU General Public Li=
cense version 2
+ *  as published by the Free Software Foundation=2E
+ *
+ =
*  This program is distributed in the hope that it will be useful,
+ *  but=
 WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTAB=
ILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Publ=
ic License for more details=2E
+ *
+ *  You should have received a copy of =
the GNU General Public License along
+ *  with this program; if not, see <h=
ttps://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_PROBE_H
+#define =
TEST_PROBE_H
+
+void test_probe_request_roundtrip(void **state);
+
+void te=
st_probe_request_wire_format(void **state);
+
+void test_probe_reply_roundt=
rip(void **state);
+
+void test_probe_reply_wire_format(void **state);
+
+v=
oid test_probe_request_forward_compat(void **state);
+
+void test_probe_req=
uest_too_short(void **state);
+
+void test_probe_reply_too_short(void **sta=
te);
+
+void test_probe_reply_flags_contradict(void **state);
+
+void test_=
find_tlv_value_truncated(void **state);
+
+void test_find_tlv_trailing_byte=
s(void **state);
+
+void test_find_tlv_skips_optional_after_wanted(void **s=
tate);
+
+void test_find_tlv_rejects_duplicate(void **state);
+
+void test_=
find_tlv_empty_payload(void **state);
+#endif

-- 
To view, visit https://g=
errit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail
To unsubscribe, or for h=
elp writing mail filters, visit https://gerrit=2Eopenvpn=2Enet/settings?usp=
=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Br=
anch: master
Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
Ge=
rrit-Change-Number: 1741
Gerrit-PatchSet: 23
Gerrit-Owner: Lev Stipakov <ls=
tipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne Schwabe <arne-openvpn@rfc2549=2E=
org>
Gerrit-Reviewer: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Re=
viewer: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-CC: chugly <charlie=2Evigue=
@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforge=
=2Enet>
Gerrit-Attention: Ralf Lici <ralf@mandelbit=2Ecom>
Gerrit-Attention=
: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Attention: Arne Schwabe <arne=
-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld <frank@lichtenh=
eld=2Ecom>

--v6y0n1CzNPM=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Lev Stipakov, Ralf L=
ici=2E </p>
<p>Lev Stipakov <strong>uploaded patch set #23</strong> to this=
 change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741=
?usp=3Demail">View Change</a></p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">control_msg: Add P_CONTROL_V=
2 and the probe request and reply TLVs<br><br>A client probes a server befo=
re connecting by sending a P_CONTROL_V2<br>message carrying a probe request=
 TLV, and the server answers with a<br>P_CONTROL_V2 carrying a probe reply=
=2E The reply tells the client how the<br>server wants to be ranked against=
 the other remotes, and can also serve<br>as the second packet of the three=
-way handshake=2E<br><br>Add the two opcodes and the two TLV codecs the pro=
be needs=2E P_CONTROL_V2<br>is framed like P_CONTROL_V1 but without the fie=
lds of the reliability<br>layer: a session id and then the TLVs, with no co=
ntrol message id and no<br>ACK array=2E P_CONTROL_WKC_V2 is the same with t=
he wrapped client key<br>appended, as P_CONTROL_WKC_V1 is to P_CONTROL_V1=
=2E<br><br>The TLVs use the shared TLV codec, control_msg=2Ec/h, and their =
two types<br>join the others there=2E The codec gains ctrl_msg_find_tlv(), =
which scans<br>a payload for the one mandatory TLV of a message=2E The scan=
 is strict: a<br>truncated TLV header or value, a second TLV of the wanted =
type, or an<br>unknown TLV not marked optional rejects the whole message=2E=
<br><br>Both readers accept a value longer than the fields they know and ig=
nore<br>the excess, which is how the TLVs are meant to be extended=2E The p=
robe<br>reply reader does reject the two flag combinations the protocol rul=
es<br>out, as neither can be acted on: the other addresses of a remote cann=
ot<br>be both the same server and distinct ones, and the connect_lifetime<b=
r>cannot be extended to those addresses without first calling them the<br>s=
ame server=2E<br><br>The reliable control path no longer decides what it ha=
ndles from an<br>opcode range=2E P_FIRST_OPCODE and P_LAST_OPCODE give way =
to<br>opcode_is_reliable_control(), which lists the opcodes that carry a<br=
>message id and an ACK array, and tls_pre_decrypt() and<br>write_control_au=
th() test that instead=2E Defining an opcode therefore no<br>longer joins i=
t to that set, so neither the two added here nor<br>CONTROL_AUX_V1 after th=
em needs to be carved back out of a range=2E<br><br>No opcode changes hands=
: the old range covered exactly the seven listed,<br>plus the two data chan=
nel opcodes, which are handled before the check is<br>reached=2E<br><br>The=
 probe is not sent or answered yet; that follows=2E<br><br>Change-Id: I1c8d=
302ac57c5603d622a7be14be369437388268<br>Signed-off-by: Lev Stipakov &lt;lev=
@openvpn=2Enet&gt;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=
=2Eam<br>M src/openvpn/control_msg=2Ec<br>M src/openvpn/control_msg=2Eh<br>=
A src/openvpn/probe=2Ec<br>A src/openvpn/probe=2Eh<br>M src/openvpn/ssl=2Ec=
<br>M src/openvpn/ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_=
tests/openvpn/Makefile=2Eam<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>A=
 tests/unit_tests/openvpn/test_probe=2Ec<br>A tests/unit_tests/openvpn/test=
_probe=2Eh<br>13 files changed, 832 insertions(+), 14 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs=
/changes/41/1741/23</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etx=
t</span><br><span>index 305c26c=2E=2Ec650468 100644</span><br><span>--- a/C=
MakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -=
565,6 +565,8 @@</span><br><span>     src/openvpn/plugin=2Eh</span><br><span=
>     src/openvpn/pool=2Ec</span><br><span>     src/openvpn/pool=2Eh</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/probe=2Ec<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/prob=
e=2Eh</span><br><span>     src/openvpn/proto=2Ec</span><br><span>     src/o=
penvpn/proto=2Eh</span><br><span>     src/openvpn/proxy=2Ec</span><br><span=
>@@ -899,7 +901,9 @@</span><br><span>     target_sources(test_pkt PRIVATE</=
span><br><span>         tests/unit_tests/openvpn/mock_win32_execve=2Ec</spa=
n><br><span>         tests/unit_tests/openvpn/test_control_msg=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/ope=
nvpn/test_probe=2Ec</span><br><span>         src/openvpn/control_msg=2Ec</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/pr=
obe=2Ec</span><br><span>         src/openvpn/argv=2Ec</span><br><span>     =
    src/openvpn/base64=2Ec</span><br><span>         src/openvpn/crypto_epoc=
h=2Ec</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/=
Makefile=2Eam</span><br><span>index be1044d=2E=2E2797a1c 100644</span><br><=
span>--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Make=
file=2Eam</span><br><span>@@ -120,7 +120,7 @@</span><br><span> 	packet_id=
=2Ec packet_id=2Eh \</span><br><span> 	ping=2Ec ping=2Eh \</span><br><span>=
 	plugin=2Ec plugin=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	pool=2Ec pool=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	pool=2Ec pool=2Eh 	probe=2Ec probe=2Eh \</span><br><span> 	proto=2Ec =
proto=2Eh \</span><br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2E=
c ps=2Eh \</span><br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/o=
penvpn/control_msg=2Ec</span><br><span>index 872191f=2E=2E8a744b0 100644</s=
pan><br><span>--- a/src/openvpn/control_msg=2Ec</span><br><span>+++ b/src/o=
penvpn/control_msg=2Ec</span><br><span>@@ -91,3 +91,32 @@</span><br><span> =
    buf_set_read(value, v, hdr-&gt;value_len);</span><br><span>     return =
true;</span><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ctrl_msg_find_tlv(struct buff=
er *payload, uint16_t wanted_type, struct buffer *value)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    bool found =3D false;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    while (BLEN(payload) &gt; 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct ctrl_msg_tlv_header hdr;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        struct buffer v;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_=
next(payload, &amp;hdr, &amp;v))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            return false;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (hdr=2Etype =3D=3D wanted_type)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (found)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                return false; /* the TLV may occur only once */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            *value =3D v;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            found =3D =
true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (!hdr=2E=
optional)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return f=
alse; /* a mandatory TLV we do not understand, wherever it sits */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return found;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/control_msg=
=2Eh b/src/openvpn/control_msg=2Eh</span><br><span>index 7d25545=2E=2E1abd6=
6b 100644</span><br><span>--- a/src/openvpn/control_msg=2Eh</span><br><span=
>+++ b/src/openvpn/control_msg=2Eh</span><br><span>@@ -41,6 +41,8 @@</span>=
<br><span> </span><br><span> /* TLV types */</span><br><span> #define TLV_T=
YPE_EARLY_NEG_FLAGS 0x0001 /* early negotiation, in the reset packets */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE=
_REQUEST   0x0002 /* a client probing a server, in P_CONTROL_V2 */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REPLY=
     0x0003 /* the server&#39;s answer, in P_CONTROL_V2 */</span><br><span>=
 </span><br><span> /* TLV header bit layout of the first 16-bit field */</s=
pan><br><span> /* A TLV header is a 16-bit type/optional field plus a 16-bi=
t length */</span><br><span>@@ -104,4 +106,28 @@</span><br><span>  */</span=
><br><span> bool ctrl_msg_tlv_next(struct buffer *buf, struct ctrl_msg_tlv_=
header *hdr, struct buffer *value);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Scan payload for the TLV of type wanted_type, skipping=
 any other TLV type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * that is marked optional=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This=
 is for messages that carry exactly one mandatory TLV, which is what the</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * probe messages are=
=2E Any other TLV that is not marked optional invalidates</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * the message wherever it appears, a=
s does a second TLV of wanted_type, so the</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * whole sequence is walked even once the wanted TLV=
 has been found=2E A message</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * carrying several mandatory TLVs walks them with ctrl_msg_tlv_ne=
xt() instead=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * On success value c=
overs exactly the found TLV&#39;s value bytes; as in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * ctrl_msg_tlv_next(), a header claiming=
 more bytes than payload holds is</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * rejected rather than reported as found=2E payload is consu=
med as it is read=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param payloa=
d      buffer positioned at a TLV header</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param wanted_type  the TLV type to look for</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param value        set=
 to a buffer covering the found TLV&#39;s value; it points</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *                     into payload =
and owns no storage</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @return true if the TLV was found, false if it is absent or present more=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         than onc=
e, if a TLV header or value is malformed or truncated, or if</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *         a TLV we do not underst=
and is not marked optional=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool c=
trl_msg_find_tlv(struct buffer *payload, uint16_t wanted_type, struct buffe=
r *value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #endif /* ifndef CONTROL_MSG_H */</span><br><span>diff --git a/src=
/openvpn/probe=2Ec b/src/openvpn/probe=2Ec</span><br><span>new file mode 10=
0644</span><br><span>index 0000000=2E=2E2497b07</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/src/openvpn/probe=2Ec</span><br><span>@@ -0,0 +1,9=
4 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             over a single TCP/UDP port, with support for SSL/TL=
S-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   session authentication and key exchange,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet encryption, packet authentica=
tion, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
     packet compression=2E</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyri=
ght (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  This program is free software; you can redistribut=
e it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  it under the terms of the GNU General Public License version 2</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free =
Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This progr=
am is distributed in the hope that it will be useful,</span><br><span style=
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
ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshe=
ad=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;probe=2Eh&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;=
control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+probe_request_write(struct buffe=
r *buf, const struct probe_request *r)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REQUEST, false, P=
ROBE_REQUEST_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
         &amp;&amp; buf_write_u64(buf, r-&gt;request_id) &amp;&amp; buf_wri=
te_u64(buf, r-&gt;timestamp)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+           &amp;&amp; buf_write_u32(buf, r-&gt;flags);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+probe_re=
quest_read(struct buffer *buf, struct probe_request *r)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* One bounds check covers the whole value: every fie=
ld read below then fits</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * by construction, PROBE_REQUEST_LEN being the sum of their sizes,=
 so none</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * of t=
hem needs its own error handling=2E Trailing bytes this version does</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * not understand are =
simply left unread=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (buf_len(buf) &lt; PROBE_REQUEST_LEN)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    r-&gt;request_id =3D buf_read_u64(buf, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    r-&gt;timestamp =3D buf_read_u64(buf,=
 NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;fl=
ags =3D buf_read_u32(buf, NULL);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+probe_reply_write(struct buffer *buf, con=
st struct probe_reply *r)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return c=
trl_msg_tlv_write_header(buf, TLV_TYPE_PROBE_REPLY, false, PROBE_REPLY_LEN)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&am=
p; buf_write_u64(buf, r-&gt;request_id) &amp;&amp; buf_write_u16(buf, r-&gt=
;priority)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
  &amp;&amp; buf_write_u16(buf, r-&gt;weight) &amp;&amp; buf_write_u16(buf,=
 r-&gt;max_latency_diff)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+           &amp;&amp; buf_write_u16(buf, r-&gt;connect_lifetime) &amp;=
&amp; buf_write_u16(buf, r-&gt;flags);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+probe_reply_read(struct buffer *b=
uf, struct probe_reply *r)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One =
bounds check for the whole value, as in probe_request_read()=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; PR=
OBE_REPLY_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fals=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;request_id =3D buf_re=
ad_u64(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   r-&gt;priority =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    r-&gt;weight =3D (uint16_t)buf_read_u16(=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;max_=
latency_diff =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    r-&gt;connect_lifetime =3D (uint16_t)buf_read=
_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt=
;flags =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* The other addresses of the remote cannot be both the same server an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * distinct on=
es=2E And LIFETIME_SHARED extends the connect_lifetime to those</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * other addresses, which s=
ays nothing unless ADDRS_EQUAL has declared them</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     * the same server to begin with=2E */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &a=
mp; PROBE_REPLY_FLAG_ADDRS_EQUAL) &amp;&amp; (r-&gt;flags &amp; PROBE_REPLY=
_FLAG_PROBE_MORE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((r-&gt;flags &amp; =
PROBE_REPLY_FLAG_LIFETIME_SHARED) &amp;&amp; !(r-&gt;flags &amp; PROBE_REPL=
Y_FLAG_ADDRS_EQUAL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git=
 a/src/openvpn/probe=2Eh b/src/openvpn/probe=2Eh</span><br><span>new file m=
ode 100644</span><br><span>index 0000000=2E=2Ee8b0299</span><br><span>--- /=
dev/null</span><br><span>+++ b/src/openvpn/probe=2Eh</span><br><span>@@ -0,=
0 +1,141 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An applica=
tion to securely tunnel IP networks</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             over a single TCP/UDP port, with support for=
 SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          session authentication and key exchange,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *             packet encryption, packet aut=
hentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            packet compression=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  This program is free software; you can redi=
stribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  it under the terms of the GNU General Public License version 2</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by th=
e Free Software Foundation=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Thi=
s program is distributed in the hope that it will be useful,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  Se=
e the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Genera=
l Public License for more details=2E</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @file</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Encoding and decod=
ing of the server probe TLVs=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A =
client probes a server by sending a P_CONTROL_V2 message whose payload</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * carries a probe reque=
st TLV, and the server answers with a P_CONTROL_V2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * message carrying a probe reply TLV=2E The=
 reply tells the client how the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * server wants to be ranked against the other remotes, and can=
 also serve</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * as th=
e second packet of the three-way handshake=2E</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * The TLV framing and the TLV type space are shared with the othe=
r TLV-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * contr=
ol messages and live in control_msg=2Eh; this file holds the two probe</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * TLVs and what their f=
ields mean=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef PROBE_H</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define PROBE_H</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* Smallest on-wire value length (the TLV header not count=
ed) of each TLV: the</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * sizes of the fixed fields below, in wire order=2E A value may be longer=
, which</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is how th=
e TLVs are extended; trailing bytes that are not understood are</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * ignored on read=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* request_id (u64), timestamp (u64), flags (=
u32) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROB=
E_REQUEST_LEN ((uint16_t)(2 * sizeof(uint64_t) + sizeof(uint32_t)))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* request_id (u64), then priority, weight, ma=
x_latency_diff,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c=
onnect_lifetime and flags (u16 each) */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define PROBE_REPLY_LEN ((uint16_t)(sizeof(uint64_t) + =
5 * sizeof(uint16_t)))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* probe request=
 flags=2E The client is only probing: it does not want to</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * continue into a handshake, and the=
 server may forget it right away=2E */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define PROBE_REQUEST_FLAG_PROBE_ONLY 0x00000001</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/* probe reply flags */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* complete the handshake with P_CONTROL_=
WKC_V1 rather than P_CONTROL_V1 */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define PROBE_REPLY_FLAG_RESEND_WKC      0x0001</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* the other addresses of this r=
emote are the same server, no need to probe them */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_ADDRS_EQUAL     =
0x0002</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* the connec=
t_lifetime holds against those other addresses too, so a reply</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * from one of them can skip the=
 handshake with another=2E Only meaningful</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * together with ADDRS_EQUAL, which is what names th=
ose addresses=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define PROBE_REPLY_FLAG_LIFETIME_SHARED 0x0004</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* the other addresses of this remote are disti=
nct servers, so probe them too */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define PROBE_REPLY_FLAG_PROBE_MORE      0x0008</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/** probe request TLV, sent by a client to probe a s=
erver */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct prob=
e_request</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t request_id; /**=
&lt; identifies this probe, echoed in the reply */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /** The client clock as a UNIX timestamp=
 in seconds=2E It is there for the</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * server, which uses it to bound how old a request it w=
ill answer and so</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * how long a captured one can be replayed=2E The reply does not echo it:=
 a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * client tim=
es the round trip itself, by the request_id=2E */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint64_t timestamp;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint32_t flags; /**&lt; PROBE_REQUEST=
_FLAG_* */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/** probe reply TLV, a server&#39;s answer to=
 a probe request */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
struct probe_reply</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint64_t reques=
t_id;       /**&lt; echoes the request_id of the request */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uint16_t priority;         /**&=
lt; DNS SRV style priority, lower is preferred */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    uint16_t weight;           /**&lt; DNS SR=
V style weight */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  uint16_t max_latency_diff; /**&lt; candidate band in ms around the fastes=
t server */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** =
For how many seconds, counted from the moment the client sent its own</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * probe request, the=
 server will still treat this exchange as the first</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * two packets of the handshake=2E Wi=
thin that window the client may send the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * third packet straight away instead of starting =
a handshake of its own=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * 0 means it cannot, so it has to begin a fresh one=2E */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t connect_lifet=
ime;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t fl=
ags; /**&lt; PROBE_REPLY_FLAG_* */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * Write a complete probe request TLV=
, header and value, to buf=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ret=
urn true on success, false if buf has insufficient space=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool probe_request_write(struct buffer *buf, const =
struct probe_request *r);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe request TLV v=
alue from buf=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buf must cover ex=
actly the TLV&#39;s value, as ctrl_msg_find_tlv() returns it=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Bytes beyond the fields unde=
rstood here are ignored, so a longer value from</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * a future version still parses=2E Flag bits t=
hat are not known are kept in</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * flags rather than rejected, for the same reason=2E</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @return true on success, false if buf is shor=
ter than the mandatory fields=2E</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+boo=
l probe_request_read(struct buffer *buf, struct probe_request *r);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Write a complete probe reply TLV, header and value, to buf=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false=
 if buf has insufficient space=2E</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol probe_reply_write(struct buffer *buf, const struct probe_reply *r);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Read a probe reply TLV value from buf=2E The calling c=
onvention is that of</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * probe_request_read()=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The tw=
o flag combinations the protocol rules out are rejected here, since</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * neither can be acted on:=
 a reply must not call the other addresses of the</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * remote both the same server and distinct o=
nes, and it must not extend the</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * connect_lifetime to those addresses without first calling th=
em the same</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * serve=
r=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, fals=
e if buf is shorter than the mandatory fields</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *         or the flags contradict each other=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool probe_reply_read(struct buffer =
*buf, struct probe_reply *r);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 ifndef PROBE_H */</span><br><span>diff --git a/src/openvpn/ssl=2Ec b/src/o=
penvpn/ssl=2Ec</span><br><span>index e531613=2E=2Eb4b89aa 100644</span><br>=
<span>--- a/src/openvpn/ssl=2Ec</span><br><span>+++ b/src/openvpn/ssl=2Ec</=
span><br><span>@@ -3791,15 +3791,26 @@</span><br><span>     bool new_link =
=3D false;</span><br><span>     struct session_id sid; /* remote session ID=
 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    /* verify legal opcode */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (op &lt; P_FIRST_OPCODE || op &gt; P_LAST_OPCODE)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /* verify the opcode belon=
gs to the reliable control channel, whose</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+     * message id and ACK array we parse below */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!opcode_is_reli=
able_control(op))</span><br><span>     {</span><br><span>         if (op =
=3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 || op =3D=3D P_CONTROL_HARD_RESET_SER=
VER_V1)</span><br><span>         {</span><br><span>             msg(D_TLS_E=
RRORS, &quot;Peer tried unsupported key-method 1&quot;);</span><br><span>  =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D=
_TLS_ERRORS, &quot;TLS Error: unknown opcode received from %s op=3D%d&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_li=
nk_socket_actual(from, &amp;gc), op);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (op =3D=3D P_CONTROL_V2 || op =3D=3D P_CONTROL=
_WKC_V2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* a defi=
ned opcode, just not one this path can parse */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &quot;TLS Error: =
%s received from %s, which is not part of &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                              &quot;the reliab=
le control channel&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                packet_opcode_name(op), print_link_socket_actual(from=
, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(D_TLS_ERRORS, &quo=
t;TLS Error: unknown opcode received from %s op=3D%d&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                print_link_socket_a=
ctual(from, &amp;gc), op);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span>         goto error;</span><br><span>     =
}</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_pkt=2Ec b/=
src/openvpn/ssl_pkt=2Ec</span><br><span>index f4564ef=2E=2Eccb841e 100644</=
span><br><span>--- a/src/openvpn/ssl_pkt=2Ec</span><br><span>+++ b/src/open=
vpn/ssl_pkt=2Ec</span><br><span>@@ -169,7 +169,8 @@</span><br><span>       =
             bool prepend_ack)</span><br><span> {</span><br><span>     ASSE=
RT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; ks-&gt;key_id &lt;=3D P_KEY_ID_MASK);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(opcode &gt=
;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST_OPCODE);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* this writes the message id and ACK arra=
y, which only these opcodes have */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(opcode_is_reliable_control(opcode));</span><br><=
span>     uint8_t header =3D (uint8_t)(ks-&gt;key_id | (opcode &lt;&lt; P_O=
PCODE_SHIFT));</span><br><span> </span><br><span>     /* Workaround for Sof=
tether servers=2E Softether has a bug that it only</span><br><span>diff --g=
it a/src/openvpn/ssl_pkt=2Eh b/src/openvpn/ssl_pkt=2Eh</span><br><span>inde=
x 218c6bb=2E=2E3b45492 100644</span><br><span>--- a/src/openvpn/ssl_pkt=2Eh=
</span><br><span>+++ b/src/openvpn/ssl_pkt=2Eh</span><br><span>@@ -58,11 +5=
8,50 @@</span><br><span>  * like P_CONTROL_HARD_RESET_CLIENT_V3 */</span><b=
r><span> #define P_CONTROL_WKC_V1 11</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/* define the range of legal opcodes</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Since we do no longer su=
pport key-method 1 we consider</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * the v1 op codes invalid */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define P_FIRST_OPCODE 3</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define P_LAST_OPCODE  11</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* Control channel packet carrying a TLV payload,=
 e=2Eg=2E a server probe=2E Framed</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * like P_CONTROL_V1 but without the fields of the reliabili=
ty layer: a session</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * id and then the TLVs, with no message id and no ACK array=2E It is wrapp=
ed by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * tls-auth or=
 tls-crypt like any other control channel packet, and with</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * neither configured it travels una=
uthenticated, as they do=2E */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#define P_CONTROL_V2 12</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* V=
ariant of P_CONTROL_V2 with the wrapped client key appended,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * like P_CONTROL_WKC_V1 is to P_C=
ONTROL_V1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 P_CONTROL_WKC_V2 13</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Is a packet with opcode op carr=
ied by the reliable control channel?</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * These opcodes are followed by an ACK array and a control message id, whi=
ch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is what the re=
liable path reads once it is past the session id=2E An opcode</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * that is not one of them has so=
mething else there: P_CONTROL_V2 has its TLVs=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Handing such a packet to that path would re=
ad the first bytes of that</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * payload as an ACK count and a message id, and ACK or queue whatev=
er it made</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * of the=
m=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * The opcodes are listed rather=
 than bounded by a range, so that defining one</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * does not silently add it to the set=2E Key me=
thod 1 is no longer supported, so</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * its two reset opcodes are not here, and the data channel o=
pcodes are handled</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* before this is reached=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static i=
nline bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+opcode_is=
_reliable_control(int op)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (=
op)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_SOFT_RE=
SET_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case=
 P_CONTROL_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   case P_ACK_V1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      case P_CONTROL_HARD_RESET_CLIENT_V2:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        case P_CONTROL_HARD_RESET_SERVER_V2:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_HARD=
_RESET_CLIENT_V3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      case P_CONTROL_WKC_V1:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            return true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   default:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n> </span><br><span> /*</span><br><span>  * Define number of buffers for se=
nd and receive in the reliability layer=2E</span><br><span>@@ -257,6 +296,1=
2 @@</span><br><span>         case P_CONTROL_WKC_V1:</span><br><span>      =
       return &quot;P_CONTROL_WKC_V1&quot;;</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_V2:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;P=
_CONTROL_V2&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case P_CONTR=
OL_WKC_V2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return &quot;P_CONTROL_WKC_V2&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>         case P_ACK_V1:</span><br><spa=
n>             return &quot;P_ACK_V1&quot;;</span><br><span> </span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>index 11f92f4=2E=2E209a9a1 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>++=
+ b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -165,14 +165,=
14 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> pkt_testdriver_LDFLA=
GS =3D @TEST_LDFLAGS@</span><br><span> pkt_testdriver_SOURCES =3D test_pkt=
=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	test_control_m=
sg=2Ec test_control_msg=2Eh \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	test_control_msg=2Ec test_control_msg=2Eh 	test_probe=2Ec test_p=
robe=2Eh \</span><br><span> 	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2E=
c \</span><br><span> 	test_common=2Eh \</span><br><span> 	$(top_srcdir)/src=
/compat/compat-strlcpy=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/ar=
gv=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/base64=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/buffer=2Ec \</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	$(top_srcdir)/src/openvpn/control_msg=2Ec \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openv=
pn/control_msg=2Ec 	$(top_srcdir)/src/openvpn/probe=2Ec \</span><br><span> =
	$(top_srcdir)/src/openvpn/crypto=2Ec \</span><br><span> 	$(top_srcdir)/src=
/openvpn/crypto_epoch=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/cry=
pto_mbedtls=2Ec \</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>index 990=
a317=2E=2E75a1b31 100644</span><br><span>--- a/tests/unit_tests/openvpn/tes=
t_pkt=2Ec</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt=2Ec</span=
><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;reliable=2Eh&q=
uot;</span><br><span> #include &quot;siphash=2Eh&quot;</span><br><span> #in=
clude &quot;test_control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;test_probe=2Eh&quot;</span><br><span> </s=
pan><br><span> int</span><br><span> parse_line(const char *line, char **p, =
const int n, const char *file, const int line_num,</span><br><span>@@ -842,=
7 +843,20 @@</span><br><span>         cmocka_unit_test(test_tlv_next_walks_=
payload),</span><br><span>         cmocka_unit_test(test_tlv_next_value_tru=
ncated),</span><br><span>         cmocka_unit_test(test_tlv_header_truncate=
d),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmocka_uni=
t_test(test_tlv_write_no_room)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_tlv_write_no_room),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_prob=
e_request_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        cmocka_unit_test(test_probe_request_wire_format),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe=
_reply_roundtrip),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_probe_reply_wire_format),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_requ=
est_forward_compat),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        cmocka_unit_test(test_probe_request_too_short),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_re=
ply_too_short),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cmocka_unit_test(test_probe_reply_flags_contradict),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv=
_value_truncated),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cmocka_unit_test(test_find_tlv_trailing_bytes),</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv_s=
kips_optional_after_wanted),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_find_tlv_rejects_duplicate),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(te=
st_find_tlv_empty_payload)</span><br><span>     };</span><br><span> </span>=
<br><span>     return cmocka_run_group_tests_name(&quot;pkt tests&quot;, te=
sts, NULL, NULL);</span><br><span>diff --git a/tests/unit_tests/openvpn/tes=
t_probe=2Ec b/tests/unit_tests/openvpn/test_probe=2Ec</span><br><span>new f=
ile mode 100644</span><br><span>index 0000000=2E=2E7cfb63d</span><br><span>=
--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_probe=2Ec=
</span><br><span>@@ -0,0 +1,402 @@</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  OpenVPN -- An application to securely tunnel IP networks</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP=
 port, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *             session authentication and key exchange,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet=
 encryption, packet authentication, and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet compression=2E</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openv=
pn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free=
 software; you can redistribute it and/or modify</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Publ=
ic License version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  as published by the Free Software Foundation=2E</span><br><span style=
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
e=3D"color: hsl(120, 100%, 40%);">+#include &quot;probe=2Eh&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_common=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;test_probe=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a prob=
e request TLV and read it back; the fields must survive the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * round trip and the whole buffer =
must be consumed=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_r=
equest_roundtrip(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct probe_request in =3D {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0xde=
adbeefcafef00dULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       =2Etimestamp =3D 0x0123456789abcdefULL,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ON=
LY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request=
_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(BLEN(&amp;buf), CTRL_MSG_TLV_HEADER_LEN + PROB=
E_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the header codec=
, read from a copy so the scan below still sees it */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =3D buf;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct ctrl_msg_tlv_heade=
r hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Etype, TLV_TYPE_PR=
OBE_REQUEST);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_false(hdr=2Eoptional);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(hdr=2Evalue_len, PROBE_REQUEST_LEN);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;bu=
f, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;value), PROBE_REQUEST_L=
EN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct probe_request out =3D {=
 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(probe_request_read(&amp;value, &amp;out));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(in=2Erequest_id =3D=3D out=2Ereque=
st_id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(in=2Etimestamp =3D=3D out=2Etimestamp);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(in=2Eflags, out=2Eflags);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* the scan consumed=
 header and value alike */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* The probe request wire =
format is locked to the field order of the spec</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * (request_id, timestamp, flags), big-endian=
=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_request_wire_form=
at(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena g=
c =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    const struct probe_request in =3D {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0x1122334455667788=
ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Etime=
stamp =3D 0x0102030405060708ULL,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        =2Eflags =3D 0,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* clang-format off */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const uint8_t expected[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x02,            =
                         /* TLV type 2, not optional */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x14,                    =
                 /* TLV value length =3D 20 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77=
, 0x88, /* request_id */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, /* timestamp *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x00=
, 0x00, 0x00,                         /* flags */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* clang-format on */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf), sizeof(expected=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memor=
y_equal(BPTR(&amp;buf), expected, sizeof(expected));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Write a probe rep=
ly TLV and read it back=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
probe_reply_roundtrip(void **state)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const struct probe_reply in =3D {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0=
x1122334455667788ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        =2Epriority =3D 10,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        =2Eweight =3D 100,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 30,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D PROB=
E_REPLY_FLAG_RESEND_WKC,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_reply=
_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(BLEN(&amp;buf), CTRL_MSG_TLV_HEADER_LEN + PROB=
E_REPLY_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer peek =
=3D buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
ctrl_msg_tlv_header hdr;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(ctrl_msg_tlv_read_header(&amp;peek, &amp;hdr));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Etype, TLV_TYPE_PROBE_REPLY);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_false(hdr=2Eoptional);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=2Evalue_len, PROBE_REPLY=
_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_fi=
nd_tlv(&amp;buf, TLV_TYPE_PROBE_REPLY, &amp;value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct probe_reply out =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_reply_read(&amp;val=
ue, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(in=2Erequest_id =3D=3D out=2Erequest_id);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Epriority, out=
=2Epriority);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(in=2Eweight, out=2Eweight);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(in=2Emax_latency_diff, out=2Ema=
x_latency_diff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(in=2Econnect_lifetime, out=2Econnect_lifetime);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(in=2Efla=
gs, out=2Eflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* The probe reply wire format is l=
ocked to the field order of the spec</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * (request_id, priority, weight, max_latency_diff, connec=
t_lifetime, flags),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * big-endian=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_repl=
y_wire_format(void **state)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const struct probe_reply in =3D {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        =2Erequest_id =3D 0x1122334=
455667788ULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  =2Epriority =3D 10,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        =2Eweight =3D 100,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        =2Emax_latency_diff =3D 25,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        =2Econnect_lifetime =3D 30,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D PROBE_REPLY_F=
LAG_RESEND_WKC,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_reply_write(&a=
mp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-format =
off */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uin=
t8_t expected[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        0x00, 0x03,                                     /* TLV type 3, no=
t optional */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  0x00, 0x12,                                     /* TLV value length =3D 1=
8 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x11, 0=
x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        0x00, 0x0a,                  =
                   /* priority =3D 10 */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        0x00, 0x64,                                   =
  /* weight =3D 100 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        0x00, 0x19,                                     /* max_latency_d=
iff =3D 25 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  0x00, 0x1e,                                     /* connect_lifetime =3D 3=
0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0x00, 0=
x01,                                     /* flags =3D RESEND_WKC */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* clang-format on */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp;buf=
), sizeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_memory_equal(BPTR(&amp;buf), expected, sizeof(expected));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
* A TLV with a longer-than-known value must still parse: the known fields a=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * read and the t=
railing bytes are skipped=2E Flag bits we do not know are kept</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * rather than rejected, for the=
 same forward compatibility=2E */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+t=
est_probe_request_forward_compat(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;=
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const uint16_t extended_len =
=3D PROBE_REQUEST_LEN + 4;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_true(ctrl_msg_tlv_write_header(&amp;buf, TLV_TYPE_PROBE_R=
EQUEST, false, extended_len));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(buf_write_u64(&amp;buf, 7));             /* requ=
est_id */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(buf_write_u64(&amp;buf, 0xdeadbeefULL)); /* timestamp */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&a=
mp;buf, 0x80000000));    /* flags, unknown bit set */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0=
x11223344));    /* unknown trailing field */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct buffer value;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUE=
ST, &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(BLEN(&amp;value), extended_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct probe_request out =3D { 0 };</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_read(&amp;=
value, &amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(out=2Erequest_id =3D=3D 7);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D 0xdeadbeefULL=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(o=
ut=2Eflags =3D=3D 0x80000000);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* the unknown trailing field must have been consumed from t=
he payload */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(BLEN(&amp;buf), 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* A value shorter than the mandatory f=
ields must be rejected, even when it</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * holds enough bytes for some of the individual fields to=
 read successfully=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe=
_request_too_short(void **state)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* 8 of the 20 mandatory value bytes: enough=
 for the request_id alone */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(buf_write_u64(&amp;buf, 0xdeadbeefULL));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    struct probe_request out =3D { 0 };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(probe_reque=
st_read(&amp;buf, &amp;out));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_fr=
ee(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* The same for the reply, one u16 short of =
its 18 mandatory bytes=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_p=
robe_reply_too_short(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(buf_write_u64(&amp;buf, 1));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0;=
 i &lt; 4; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_tru=
e(buf_write_u16(&amp;buf, 0));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_reply=
 out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_false(probe_reply_read(&amp;buf, &amp;out));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* The flag combinat=
ions the protocol rules out must be rejected: the other</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * addresses of a remote cannot be both=
 the same server and distinct ones, and</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * a shared connect_lifetime needs them to have been ca=
lled equal=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_probe_reply_f=
lags_contradict(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    const uint16_t bad[] =3D {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG=
_PROBE_MORE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 PROBE_REPLY_FLAG_LIFETIME_SHARED,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        PROBE_REPLY_FLAG_LIFETIME_SHARED | PROBE_REPLY_FLAG_=
PROBE_MORE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint16_t go=
od[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        PROBE_REPL=
Y_FLAG_ADDRS_EQUAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        PROBE_REPLY_FLAG_PROBE_MORE,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY_FLAG_LI=
FETIME_SHARED,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; SIZE(=
bad) + SIZE(good); i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst bool expect_ok =3D i &gt;=3D SIZE(bad);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        const uint16_t flags =3D expect_ok ? good[i=
 - SIZE(bad)] : bad[i];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        const struct probe_reply in =3D { =2Erequest=
_id =3D 1, =2Eflags =3D flags };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        assert_true(probe_reply_write(&amp;buf, &amp;in));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct buffer value;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        assert_true(ctrl_msg_fin=
d_tlv(&amp;buf, TLV_TYPE_PROBE_REPLY, &amp;value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct probe_reply out =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        assert_int_equal(probe_reply_r=
ead(&amp;value, &amp;out), expect_ok);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&a=
mp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/* A TLV header claiming more value bytes than th=
e payload holds must be</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * rejected by the scan rather than reported as found -- for the TLV be=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * looked for as=
 much as for one that would merely be skipped=2E */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_find_tlv_value_truncated(void **state)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* the wanted TLV declares 20 value bytes, =
only 8 are present */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_head=
er(&amp;buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_write_u64(=
&amp;buf, 0xdeadbeefULL));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_false(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST,=
 &amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* same defect on a =
TLV that would be skipped: the scan must not walk past</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * the end of the payload looking fo=
r the next header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct buffer buf2 =3D alloc_buf_gc(128, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_write_head=
er(&amp;buf2, 0x7ff, false, 64));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(buf_write_u32(&amp;buf2, 0));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ctrl_msg_find_tlv(=
&amp;buf2, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Bytes left over after =
the last TLV that are too few for a header make the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * message malformed, even when the wante=
d TLV was already found=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
find_tlv_trailing_bytes(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer value;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* 1 to 3 bytes: less than a 4-byte TLV header */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int trailing =3D 1; trailing =
&lt; CTRL_MSG_TLV_HEADER_LEN; trailing++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        const struct probe_re=
quest in =3D { =2Erequest_id =3D 1, =2Etimestamp =3D 1 };</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        assert_true(probe_request_wri=
te(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        for (int i =3D 0; i &lt; trailing; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            assert_true(buf_write_u8(&amp;buf, 0));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        assert_false(ctrl_msg=
_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/* An unknown TLV marked optio=
nal after the wanted one is skipped, and the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * wanted value is still the one returned=2E */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_skips_optional_after_wa=
nted(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena=
 gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct buffer buf =3D alloc_buf_gc(128, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct buffer value;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const struct probe_request in =3D { =2Erequest_id =
=3D 1, =2Etimestamp =3D 7 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_=
write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(buf_write_u32(&amp;buf, 0));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_=
TYPE_PROBE_REQUEST, &amp;value));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(BLEN(&amp;value), PROBE_REQUEST_LEN);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct probe_reque=
st out =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(probe_request_read(&amp;value, &amp;out));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(out=2Etimestamp =3D=3D=
 7);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
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
e mode 100644</span><br><span>index 0000000=2E=2Ebc51721</span><br><span>--=
- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_probe=2Eh</=
span><br><span>@@ -0,0 +1,51 @@</span><br><span style=3D"color: hsl(120, 10=
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
est_find_tlv_rejects_duplicate(void **state);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void test_find_tlv_empty_payload(void **state);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></pre><p>To view, visit=
 <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">ch=
ange 1741</a>=2E To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=
=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><li=
nk itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div=
>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div=
 style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"displ=
ay:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-=
Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<div style=3D"d=
isplay:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"display:none"=
> Gerrit-PatchSet: 23 </div>
<div style=3D"display:none"> Gerrit-Owner: Lev=
 Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"display:none">=
 Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; </div>
<d=
iv style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Ral=
f Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Ger=
rit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=2Esourceforg=
e=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Ralf Lici=
 &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-At=
tention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld=
 &lt;frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--v6y0n1CzNPM=--


--===============7401313150848495634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7401313150848495634==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============7401313150848495634==--

