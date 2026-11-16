Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379B606A31C
	for <openvpn-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lnFB2meH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=nPV9GnWW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=akw63xrD;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=g/YJtZJC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=s0raOqCxxLT0Cv71FhRton3J+wAq8GMQ3pxfpq8kzIs=; b=lnFB2meHTWx3NeklKhnWdic/I1
	g79El3dnJaKgHv86xAiupTINSUIi5XE2te384cSYc0A1beIY1UXiYXil+i4/MT1xnhQuhThlL6SNc
	eYIFyZINEPQoJeAEDhHaA8ckX68LwFgIhVD5tLewqX5KMVELhognMeZD62Yn//cy3cbU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xSxmn-000000004SU-0CIM;
	Mon, 16 Nov 2026 14:34:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xSxmT-000000004Rw-11gE
 for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:34:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MNbIJv/h2Jp2oTPOos/7VO1flFPg3kU7aC4iONdlvuY=; b=nPV9GnWWsZ5VroG9t9tFj3imvJ
 WD7kHW4KCGAX/Sn97tMuTzQnU23lYakO9PUgPClMLEKJ8Y8dTJZgeCd6PbHjaQIKKytV9R2gYhoX3
 AwqAxlK/yjA1mY+OEIHKEMsdtGi1TGdbNQxcaHIXCclIAKmIvqcjNvvDJ1sAr8giTQxk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MNbIJv/h2Jp2oTPOos/7VO1flFPg3kU7aC4iONdlvuY=; b=akw63xrDa/iVvmYfM0na2Qe1lx
 FjBZFAhx9wafYNTS9rf2QmAB+pYxWm+v5KgKVgWTiw0yC/2Z1Urge+OnFKcPEuF14my3nB4FUmXzw
 Kp8q24ymZOzuvYIibHaZ2QzOtkCRWZhuLlWkho+naRiwaWn1DVxF79QMdXi1pvBMe5W0=;
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSxmB-000000000M9-34uo for openvpn-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 14:33:51 +0000
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so43733325e9.2
 for <openvpn-devel@lists.sourceforge.net>;
 Mon, 16 Nov 2026 06:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1794839617; x=1795444417; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=MNbIJv/h2Jp2oTPOos/7VO1flFPg3kU7aC4iONdlvuY=;
 b=g/YJtZJCvGxny/0kSUQNupLn4zEzcuznxhB++Z8xOjRzCnvaFHSrCJaUbdPyu9Az1v
 nhheaRUsePU+No9BZTzvJdkTX8ZZbZF2APohPLhc5NruMOsLFoZIMk8AyLhEr+nFcl+0
 zgAiWiwBIQWUFxDl4nH9s+HJA3rBiBK+i4YIwitMpwcZSCd1Z7MMGrTPlQUck/OREmUW
 EIOG1HUrQH5vE6XxVHu3/KX6RAE+ntdfUK5nUpuhwoijk3pqCAlHENEy/1Udd0pj7tir
 zBvfuhzSGwVUXCT1oZ8xN935YuVLjHEH83RopPWONq6CLZxDWI7bEnDmbpi1V5Drfq8v
 e+rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794839617; x=1795444417;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=MNbIJv/h2Jp2oTPOos/7VO1flFPg3kU7aC4iONdlvuY=;
 b=2LHw55goEqFrZA9IQdagL97doLwRsAMigL6P7co+GHULujbFRVtcrNpgcbgsz5s0He
 VsNoxzHQQA5s47VuKnDUYFAmi/+gsJ63BpETN5crg0Zb0Bl6D2ZNSMDApUpQ2Ga8uiIG
 rctY/uEX0O2viXH1j7uU+nwqp+BFoWEzTte7BIjJEJOY9iwqwazcNX/wD7xUEs2ZDwPG
 06MWOQF7uLpanIrOMQkpIQFcMu9+xW1lgcnn6qSaLf27HSt4/y70aVmKrFVc5j2clKvb
 X6iA+WtKLQ5WBVpg+6VDEI8LntzqGLsYOI/97bkRj0d9VzrVwy1IIVbOIRdXtOchPOju
 POmg==
X-Gm-Message-State: APuU4Z8o7mZiNgCAb0JVnHA3T08fdW/aej3a4FBv19nIl4dtcvfWLS3O
 xwk1mzEW6I8NgXaxur9uVaYlaG1NNTmqrDRFWhstC6UDumWHNsFinQuTyj4qM+TBtvxnp34F/gv
 duEL/0LMTGuCY9gVfhC7pd4lDincQdcphCtxaDjquLIsVYVoh3zGDBArOS008dxPf0aWI
X-Gm-Gg: AYBFou2AvK1fWfEA4O+VRcojyiMOn/oOQGsYHVsoM5o2HpjWnpkKFOUUV8HT4A7iAue
 rEvKluZMscA7xfgnjGCRp8rjwLxpgtnMdlM4ngyZrJxp4TEvRVqGIRmTpdVnJsb1b/nAhVeLjiJ
 H7zzVdSzFgpdLc+ETbAhldsGNXX4AQhQkikCrRgJY+IAuLqMtkh2Q9PVge2YnrRRpRt4ZDIc6BU
 oKkYlBrFthDBO4U70zItTPPZANXyHf8Rxw8stVgg6i2fyzfdKewXBqvIl0LzVTjPxX6isOMOCec
 /qSV8o1CUFEtsAzigjnb/qnJf8WQmXL5mZR3mEnLC/AtvXlE/isrdM7gWksw3cK7fbJKyYxjfAq
 zPNXOQhxW5yLujQN9GhA/QS6/lfR695SCYD805K5ORFbbqvZHWz6et9XnPmA68Cq+SlRUdmzCO6
 hHtSy1VNMSvOZi0d5BitjOB3Gg700J0rD+DN4wl07TaSCYkOP8B8SkirOzfkVaNpg8q0oVvjE6G
 ubhs17NHYBTClqGobfTIJcmgOfXEc+4b+4BkoZHGEdILINRdGhN2/keTI+mrwwPU0J08Nx4mhdu
 GMpEUKYxuPmTNSMN6bpf/EzODNmzHmTk7zl0JJxXPyRHefesGwn0f4rv06fUv+QZn1zhvPgeLKn
 BnQgh16nY4yK2aUCS2SIUZJAFnxLgXlVjTMXL1cpNKo+lIqrJyPOtnWKJMKd5lKp4maWvT+3Dnw
 +jzifHcktx37MGzkE=
X-Received: by 2002:a05:600c:1daa:b0:4a1:dade:f049 with SMTP id
 5b1f17b1804b1-4bb55a4da43mr242444055e9.15.1794839616494; 
 Mon, 16 Nov 2026 06:33:36 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb4e2adf53sm404793015e9.15.2026.11.16.06.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:33:36 -0800 (PST)
X-Google-Original-From: "Lev Stipakov (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Mon, 16 Nov 2026 14:33:32 +0000
To: Ralf Lici <ralf@mandelbit.com>, Arne Schwabe <arne-openvpn@rfc2549.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 25
X-Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268
X-Gerrit-Change-Number: 1741
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/1741?usp=email>
X-Gerrit-Commit: 85f9ed752840f709f814b288638bbc24a71cce1a
In-Reply-To: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
References: <gerrit.1782719911000.I1c8d302ac57c5603d622a7be14be369437388268@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNzgyNzE5OTExMDAwLkkxYzhkMzAyYWM1N2M1NjAzZDYyMmE3YmUxNGJlMzY5NDM3Mzg4MjY4QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <5355dbb235d71af73f99c832e22d8a4e0225df9c-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xSxmB-000000000M9-34uo
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
Content-Type: multipart/mixed; boundary="===============1950908201781515229=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============1950908201781515229==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NoV8CDyGtYQ="; charset=UTF-8

--NoV8CDyGtYQ=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Frank Lichtenheld, Lev Stipakov, Ralf=
 Lici=2E

Hello Arne Schwabe, Frank Lichtenheld, Ralf Lici, 

I'd like you =
to reexamine a change=2E Please visit

    https://gerrit=2Eopenvpn=2Enet/c=
/openvpn/+/1741?usp=3Demail

to look at the new patch set (#25)=2E


Change=
 subject: control_msg: Add P_CONTROL_V2 and the probe request and reply TLV=
s
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

control_ms=
g: Add P_CONTROL_V2 and the probe request and reply TLVs

A client probes a=
 server before connecting by sending a P_CONTROL_V2
message carrying a prob=
e request TLV, and the server answers with a
P_CONTROL_V2 carrying a probe =
reply=2E The reply tells the client how the
server wants to be ranked again=
st the other remotes, and can also serve
as the second packet of the three-=
way handshake=2E

Add the two opcodes and the two TLV codecs the probe need=
s=2E P_CONTROL_V2
is framed like P_CONTROL_V1 but without the fields of the=
 reliability
layer: a session id and then the TLVs, with no control message=
 id and no
ACK array=2E P_CONTROL_WKC_V2 is the same with the wrapped clien=
t key
appended, as P_CONTROL_WKC_V1 is to P_CONTROL_V1=2E

The TLVs use the=
 shared TLV codec, control_msg=2Ec/h, and their two types
join the others t=
here=2E The codec gains ctrl_msg_find_tlv(), which scans
a payload for the =
one mandatory TLV of a message=2E The scan is strict: a
truncated TLV heade=
r or value, a second TLV of the wanted type, or an
unknown TLV not marked o=
ptional rejects the whole message=2E

Both readers accept a value longer th=
an the fields they know and ignore
the excess, which is how the TLVs are me=
ant to be extended=2E The probe
reply reader does reject the two flag combi=
nations the protocol rules
out, as neither can be acted on: the other addre=
sses of a remote cannot
be both the same server and distinct ones, and the =
connect_lifetime
cannot be extended to those addresses without first callin=
g them the
same server=2E

The reliable control path no longer decides what=
 it handles from an
opcode range=2E P_FIRST_OPCODE and P_LAST_OPCODE give w=
ay to
opcode_is_reliable_control(), which lists the opcodes that carry a
me=
ssage id and an ACK array, and tls_pre_decrypt() and
write_control_auth() t=
est that instead=2E Defining an opcode therefore no
longer joins it to that=
 set, so neither the two added here nor
CONTROL_AUX_V1 after them needs to =
be carved back out of a range=2E

No opcode changes hands: the old range co=
vered exactly the seven listed,
plus the two data channel opcodes, which ar=
e handled before the check is
reached=2E

The probe is not sent or answered=
 yet; that follows=2E

Change-Id: I1c8d302ac57c5603d622a7be14be369437388268=

Signed-off-by: Lev Stipakov <lev@openvpn=2Enet>
---
M CMakeLists=2Etxt
M s=
rc/openvpn/Makefile=2Eam
M src/openvpn/control_msg=2Ec
M src/openvpn/contro=
l_msg=2Eh
A src/openvpn/probe=2Ec
A src/openvpn/probe=2Eh
M src/openvpn/ssl=
=2Ec
M src/openvpn/ssl_pkt=2Ec
M src/openvpn/ssl_pkt=2Eh
M tests/unit_tests=
/openvpn/Makefile=2Eam
M tests/unit_tests/openvpn/test_pkt=2Ec
A tests/unit=
_tests/openvpn/test_probe=2Ec
A tests/unit_tests/openvpn/test_probe=2Eh
13 =
files changed, 829 insertions(+), 14 deletions(-)


  git pull ssh://gerrit=
=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/25

diff --git a/CMakeL=
ists=2Etxt b/CMakeLists=2Etxt
index 305c26c=2E=2Ec650468 100644
--- a/CMake=
Lists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -565,6 +565,8 @@
     src/openvpn/plu=
gin=2Eh
     src/openvpn/pool=2Ec
     src/openvpn/pool=2Eh
+    src/openvp=
n/probe=2Ec
+    src/openvpn/probe=2Eh
     src/openvpn/proto=2Ec
     src/=
openvpn/proto=2Eh
     src/openvpn/proxy=2Ec
@@ -899,7 +901,9 @@
     targe=
t_sources(test_pkt PRIVATE
         tests/unit_tests/openvpn/mock_win32_exe=
cve=2Ec
         tests/unit_tests/openvpn/test_control_msg=2Ec
+        tes=
ts/unit_tests/openvpn/test_probe=2Ec
         src/openvpn/control_msg=2Ec
+=
        src/openvpn/probe=2Ec
         src/openvpn/argv=2Ec
         src/op=
envpn/base64=2Ec
         src/openvpn/crypto_epoch=2Ec
diff --git a/src/ope=
nvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam
index be1044d=2E=2E2797a1c 1=
00644
--- a/src/openvpn/Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -1=
20,7 +120,7 @@
 	packet_id=2Ec packet_id=2Eh \
 	ping=2Ec ping=2Eh \
 	plug=
in=2Ec plugin=2Eh \
-	pool=2Ec pool=2Eh \
+	pool=2Ec pool=2Eh 	probe=2Ec pr=
obe=2Eh \
 	proto=2Ec proto=2Eh \
 	proxy=2Ec proxy=2Eh \
 	ps=2Ec ps=2Eh \=

diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=2Ec
ind=
ex e14355c=2E=2Ea77413f 100644
--- a/src/openvpn/control_msg=2Ec
+++ b/src/=
openvpn/control_msg=2Ec
@@ -91,3 +91,32 @@
     buf_set_read(value, v, hdr-=
>value_len);
     return true;
 }
+
+bool
+ctrl_msg_find_tlv(struct buffer =
*payload, uint16_t wanted_type, struct buffer *value)
+{
+    bool found =
=3D false;
+    while (BLEN(payload) > 0)
+    {
+        struct ctrl_msg_t=
lv_header hdr;
+        struct buffer v;
+        if (!ctrl_msg_tlv_next(pa=
yload, &hdr, &v))
+        {
+            return false;
+        }
+       =
 if (hdr=2Etype =3D=3D wanted_type)
+        {
+            if (found)
+   =
         {
+                return false; /* the TLV may occur only once */=

+            }
+            *value =3D v;
+            found =3D true;
+  =
      }
+        else if (!hdr=2Eoptional)
+        {
+            return f=
alse; /* a mandatory TLV we do not understand, wherever it sits */
+       =
 }
+    }
+    return found;
+}
diff --git a/src/openvpn/control_msg=2Eh b/=
src/openvpn/control_msg=2Eh
index 92572cb=2E=2E8ad5530 100644
--- a/src/ope=
nvpn/control_msg=2Eh
+++ b/src/openvpn/control_msg=2Eh
@@ -41,6 +41,8 @@
 
=
 /* TLV types */
 #define TLV_TYPE_EARLY_NEG_FLAGS 0x0001 /* early negotiat=
ion, in the reset packets */
+#define TLV_TYPE_PROBE_REQUEST   0x0002 /* a =
client probing a server, in P_CONTROL_V2 */
+#define TLV_TYPE_PROBE_REPLY  =
   0x0003 /* the server's answer, in P_CONTROL_V2 */
 
 /* A TLV header is =
a 16-bit type/optional field plus a 16-bit length */
 #define CTRL_MSG_TLV_=
HEADER_LEN 4
@@ -105,4 +107,28 @@
  */
 bool ctrl_msg_tlv_next(struct buffe=
r *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);
 
+/**
+ * =
Scan payload for the TLV of type wanted_type, skipping any other TLV type
+=
 * that is marked optional=2E
+ *
+ * This is for messages that carry exact=
ly one mandatory TLV, which is what the
+ * probe messages are=2E Any other=
 TLV that is not marked optional invalidates
+ * the message wherever it ap=
pears, as does a second TLV of wanted_type, so the
+ * whole sequence is wa=
lked even once the wanted TLV has been found=2E A message
+ * carrying seve=
ral mandatory TLVs walks them with ctrl_msg_tlv_next() instead=2E
+ *
+ * O=
n success value covers exactly the found TLV's value bytes; as in
+ * ctrl_=
msg_tlv_next(), a header claiming more bytes than payload holds is
+ * reje=
cted rather than reported as found=2E payload is consumed as it is read=2E
=
+ *
+ * @param payload      buffer positioned at a TLV header
+ * @param wa=
nted_type  the TLV type to look for
+ * @param value        set to a buffer=
 covering the found TLV's value; it points
+ *                     into pay=
load and owns no storage
+ * @return true if the TLV was found, false if it=
 is absent or present more
+ *         than once, if a TLV header or value =
is malformed or truncated, or if
+ *         a TLV we do not understand is =
not marked optional=2E
+ */
+bool ctrl_msg_find_tlv(struct buffer *payload,=
 uint16_t wanted_type, struct buffer *value);
+
 #endif /* ifndef CONTROL_M=
SG_H */
diff --git a/src/openvpn/probe=2Ec b/src/openvpn/probe=2Ec
new file=
 mode 100644
index 0000000=2E=2E2497b07
--- /dev/null
+++ b/src/openvpn/pro=
be=2Ec
@@ -0,0 +1,94 @@
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
+#include "probe=2Eh"
+#include=
 "control_msg=2Eh"
+
+bool
+probe_request_write(struct buffer *buf, const s=
truct probe_request *r)
+{
+    return ctrl_msg_tlv_write_header(buf, TLV_T=
YPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN)
+           && buf_write_u64(b=
uf, r->request_id) && buf_write_u64(buf, r->timestamp)
+           && buf_w=
rite_u32(buf, r->flags);
+}
+
+bool
+probe_request_read(struct buffer *buf,=
 struct probe_request *r)
+{
+    /* One bounds check covers the whole valu=
e: every field read below then fits
+     * by construction, PROBE_REQUEST_=
LEN being the sum of their sizes, so none
+     * of them needs its own err=
or handling=2E Trailing bytes this version does
+     * not understand are =
simply left unread=2E */
+    if (buf_len(buf) < PROBE_REQUEST_LEN)
+    {
=
+        return false;
+    }
+    r->request_id =3D buf_read_u64(buf, NULL=
);
+    r->timestamp =3D buf_read_u64(buf, NULL);
+    r->flags =3D buf_rea=
d_u32(buf, NULL);
+    return true;
+}
+
+bool
+probe_reply_write(struct bu=
ffer *buf, const struct probe_reply *r)
+{
+    return ctrl_msg_tlv_write_h=
eader(buf, TLV_TYPE_PROBE_REPLY, false, PROBE_REPLY_LEN)
+           && buf=
_write_u64(buf, r->request_id) && buf_write_u16(buf, r->priority)
+        =
   && buf_write_u16(buf, r->weight) && buf_write_u16(buf, r->max_latency_di=
ff)
+           && buf_write_u16(buf, r->connect_lifetime) && buf_write_u16=
(buf, r->flags);
+}
+
+bool
+probe_reply_read(struct buffer *buf, struct pr=
obe_reply *r)
+{
+    /* One bounds check for the whole value, as in probe_=
request_read()=2E */
+    if (buf_len(buf) < PROBE_REPLY_LEN)
+    {
+     =
   return false;
+    }
+    r->request_id =3D buf_read_u64(buf, NULL);
+  =
  r->priority =3D (uint16_t)buf_read_u16(buf);
+    r->weight =3D (uint16_t=
)buf_read_u16(buf);
+    r->max_latency_diff =3D (uint16_t)buf_read_u16(buf=
);
+    r->connect_lifetime =3D (uint16_t)buf_read_u16(buf);
+    r->flags =
=3D (uint16_t)buf_read_u16(buf);
+
+    /* The other addresses of the remot=
e cannot be both the same server and
+     * distinct ones=2E And LIFETIME_=
SHARED extends the connect_lifetime to those
+     * other addresses, which=
 says nothing unless ADDRS_EQUAL has declared them
+     * the same server =
to begin with=2E */
+    if ((r->flags & PROBE_REPLY_FLAG_ADDRS_EQUAL) && (=
r->flags & PROBE_REPLY_FLAG_PROBE_MORE))
+    {
+        return false;
+   =
 }
+    if ((r->flags & PROBE_REPLY_FLAG_LIFETIME_SHARED) && !(r->flags & P=
ROBE_REPLY_FLAG_ADDRS_EQUAL))
+    {
+        return false;
+    }
+    ret=
urn true;
+}
diff --git a/src/openvpn/probe=2Eh b/src/openvpn/probe=2Eh
new=
 file mode 100644
index 0000000=2E=2Ee8b0299
--- /dev/null
+++ b/src/openvp=
n/probe=2Eh
@@ -0,0 +1,141 @@
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
+/**
+ * @file
+ * Encoding and=
 decoding of the server probe TLVs=2E
+ *
+ * A client probes a server by s=
ending a P_CONTROL_V2 message whose payload
+ * carries a probe request TLV=
, and the server answers with a P_CONTROL_V2
+ * message carrying a probe r=
eply TLV=2E The reply tells the client how the
+ * server wants to be ranke=
d against the other remotes, and can also serve
+ * as the second packet of=
 the three-way handshake=2E
+ *
+ * The TLV framing and the TLV type space =
are shared with the other TLV-based
+ * control messages and live in contro=
l_msg=2Eh; this file holds the two probe
+ * TLVs and what their fields mea=
n=2E
+ */
+
+#ifndef PROBE_H
+#define PROBE_H
+
+#include "buffer=2Eh"
+#in=
clude "control_msg=2Eh"
+
+/* Smallest on-wire value length (the TLV header=
 not counted) of each TLV: the
+ * sizes of the fixed fields below, in wire=
 order=2E A value may be longer, which
+ * is how the TLVs are extended; tr=
ailing bytes that are not understood are
+ * ignored on read=2E */
+
+/* re=
quest_id (u64), timestamp (u64), flags (u32) */
+#define PROBE_REQUEST_LEN =
((uint16_t)(2 * sizeof(uint64_t) + sizeof(uint32_t)))
+
+/* request_id (u64=
), then priority, weight, max_latency_diff,
+ * connect_lifetime and flags =
(u16 each) */
+#define PROBE_REPLY_LEN ((uint16_t)(sizeof(uint64_t) + 5 * s=
izeof(uint16_t)))
+
+/* probe request flags=2E The client is only probing: =
it does not want to
+ * continue into a handshake, and the server may forge=
t it right away=2E */
+#define PROBE_REQUEST_FLAG_PROBE_ONLY 0x00000001
+
+=
/* probe reply flags */
+/* complete the handshake with P_CONTROL_WKC_V1 ra=
ther than P_CONTROL_V1 */
+#define PROBE_REPLY_FLAG_RESEND_WKC      0x0001
=
+/* the other addresses of this remote are the same server, no need to prob=
e them */
+#define PROBE_REPLY_FLAG_ADDRS_EQUAL     0x0002
+/* the connect_=
lifetime holds against those other addresses too, so a reply
+ * from one o=
f them can skip the handshake with another=2E Only meaningful
+ * together =
with ADDRS_EQUAL, which is what names those addresses=2E */
+#define PROBE_=
REPLY_FLAG_LIFETIME_SHARED 0x0004
+/* the other addresses of this remote ar=
e distinct servers, so probe them too */
+#define PROBE_REPLY_FLAG_PROBE_MO=
RE      0x0008
+
+/** probe request TLV, sent by a client to probe a server=
 */
+struct probe_request
+{
+    uint64_t request_id; /**< identifies this=
 probe, echoed in the reply */
+    /** The client clock as a UNIX timestam=
p in seconds=2E It is there for the
+     * server, which uses it to bound =
how old a request it will answer and so
+     * how long a captured one can=
 be replayed=2E The reply does not echo it: a
+     * client times the roun=
d trip itself, by the request_id=2E */
+    uint64_t timestamp;
+    uint32=
_t flags; /**< PROBE_REQUEST_FLAG_* */
+};
+
+/** probe reply TLV, a server=
's answer to a probe request */
+struct probe_reply
+{
+    uint64_t reques=
t_id;       /**< echoes the request_id of the request */
+    uint16_t prio=
rity;         /**< DNS SRV style priority, lower is preferred */
+    uint1=
6_t weight;           /**< DNS SRV style weight */
+    uint16_t max_latenc=
y_diff; /**< candidate band in ms around the fastest server */
+    /** For=
 how many seconds, counted from the moment the client sent its own
+     * =
probe request, the server will still treat this exchange as the first
+    =
 * two packets of the handshake=2E Within that window the client may send t=
he
+     * third packet straight away instead of starting a handshake of it=
s own=2E
+     * 0 means it cannot, so it has to begin a fresh one=2E */
+ =
   uint16_t connect_lifetime;
+    uint16_t flags; /**< PROBE_REPLY_FLAG_* =
*/
+};
+
+/**
+ * Write a complete probe request TLV, header and value, to =
buf=2E
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
index 11f92f4=2E=2E209a9a1 100644
--- a/tests/unit_tests/openvpn/Makefil=
e=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ -165,14 +165,14 @@
 =
	@TEST_CFLAGS@
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
 pkt_testdriver_S=
OURCES =3D test_pkt=2Ec \
-	test_control_msg=2Ec test_control_msg=2Eh \
+	t=
est_control_msg=2Ec test_control_msg=2Eh 	test_probe=2Ec test_probe=2Eh \
 =
	mock_msg=2Ec mock_msg=2Eh mock_win32_execve=2Ec \
 	test_common=2Eh \
 	$(=
top_srcdir)/src/compat/compat-strlcpy=2Ec \
 	$(top_srcdir)/src/openvpn/arg=
v=2Ec \
 	$(top_srcdir)/src/openvpn/base64=2Ec \
 	$(top_srcdir)/src/openvp=
n/buffer=2Ec \
-	$(top_srcdir)/src/openvpn/control_msg=2Ec \
+	$(top_srcdir=
)/src/openvpn/control_msg=2Ec 	$(top_srcdir)/src/openvpn/probe=2Ec \
 	$(to=
p_srcdir)/src/openvpn/crypto=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_epoch=
=2Ec \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \
diff --git a/tests/=
unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/test_pkt=2Ec
ind=
ex 7dc07aa=2E=2Eb84ef36 100644
--- a/tests/unit_tests/openvpn/test_pkt=2Ec
=
+++ b/tests/unit_tests/openvpn/test_pkt=2Ec
@@ -45,6 +45,7 @@
 #include "re=
liable=2Eh"
 #include "siphash=2Eh"
 #include "test_control_msg=2Eh"
+#incl=
ude "test_probe=2Eh"
 
 int
 parse_line(const char *line, char **p, const i=
nt n, const char *file, const int line_num,
@@ -841,7 +842,20 @@
         c=
mocka_unit_test(test_tlv_next_walks_payload),
         cmocka_unit_test(tes=
t_tlv_next_value_truncated),
         cmocka_unit_test(test_tlv_header_trun=
cated),
-        cmocka_unit_test(test_tlv_write_no_room)
+        cmocka_u=
nit_test(test_tlv_write_no_room),
+        cmocka_unit_test(test_probe_requ=
est_roundtrip),
+        cmocka_unit_test(test_probe_request_wire_format),
=
+        cmocka_unit_test(test_probe_reply_roundtrip),
+        cmocka_unit=
_test(test_probe_reply_wire_format),
+        cmocka_unit_test(test_probe_r=
equest_forward_compat),
+        cmocka_unit_test(test_probe_request_too_sh=
ort),
+        cmocka_unit_test(test_probe_reply_too_short),
+        cmock=
a_unit_test(test_probe_reply_flags_contradict),
+        cmocka_unit_test(t=
est_find_tlv_value_truncated),
+        cmocka_unit_test(test_find_tlv_trai=
ling_bytes),
+        cmocka_unit_test(test_find_tlv_skips_optional_after_w=
anted),
+        cmocka_unit_test(test_find_tlv_rejects_duplicate),
+      =
  cmocka_unit_test(test_find_tlv_empty_payload)
     };
 
     return cmock=
a_run_group_tests_name("pkt tests", tests, NULL, NULL);
diff --git a/tests/=
unit_tests/openvpn/test_probe=2Ec b/tests/unit_tests/openvpn/test_probe=2Ec=

new file mode 100644
index 0000000=2E=2Ec4ca385
--- /dev/null
+++ b/tests/=
unit_tests/openvpn/test_probe=2Ec
@@ -0,0 +1,399 @@
+/*
+ *  OpenVPN -- An =
application to securely tunnel IP networks
+ *             over a single TC=
P/UDP port, with support for SSL/TLS-based
+ *             session authenti=
cation and key exchange,
+ *             packet encryption, packet authenti=
cation, and
+ *             packet compression=2E
+ *
+ *  Copyright (C) 20=
02-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *
+ *  This program is free sof=
tware; you can redistribute it and/or modify
+ *  it under the terms of the=
 GNU General Public License version 2
+ *  as published by the Free Softwar=
e Foundation=2E
+ *
+ *  This program is distributed in the hope that it wi=
ll be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warra=
nty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the=

+ *  GNU General Public License for more details=2E
+ *
+ *  You should ha=
ve received a copy of the GNU General Public License along
+ *  with this p=
rogram; if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef H=
AVE_CONFIG_H
+#include "config=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#i=
nclude <stdarg=2Eh>
+#include <stddef=2Eh>
+#include <setjmp=2Eh>
+#include=
 <cmocka=2Eh>
+
+#include "control_msg=2Eh"
+#include "probe=2Eh"
+#include=
 "test_common=2Eh"
+#include "test_probe=2Eh"
+
+/* Write a probe request T=
LV and read it back; the fields must survive the
+ * round trip and the who=
le buffer must be consumed=2E */
+void
+test_probe_request_roundtrip(void *=
*state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D=
 alloc_buf_gc(128, &gc);
+
+    const struct probe_request in =3D {
+      =
  =2Erequest_id =3D 0xdeadbeefcafef00dULL,
+        =2Etimestamp =3D 0x0123=
456789abcdefULL,
+        =2Eflags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,
+    =
};
+    assert_true(probe_request_write(&buf, &in));
+    assert_int_equal(=
BLEN(&buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REQUEST_LEN);
+
+    struct ctr=
l_msg_tlv_header hdr;
+    assert_true(ctrl_msg_tlv_peek_header(&buf, &hdr)=
);
+    assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);
+    assert_f=
alse(hdr=2Eoptional);
+    assert_int_equal(hdr=2Evalue_len, PROBE_REQUEST_=
LEN);
+
+    struct buffer value;
+    assert_true(ctrl_msg_find_tlv(&buf, =
TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value), PROBE=
_REQUEST_LEN);
+
+    struct probe_request out =3D { 0 };
+    assert_true(=
probe_request_read(&value, &out));
+    assert_true(in=2Erequest_id =3D=3D =
out=2Erequest_id);
+    assert_true(in=2Etimestamp =3D=3D out=2Etimestamp);=

+    assert_int_equal(in=2Eflags, out=2Eflags);
+    /* the scan consumed =
header and value alike */
+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_f=
ree(&gc);
+}
+
+/* The probe request wire format is locked to the field ord=
er of the spec
+ * (request_id, timestamp, flags), big-endian=2E */
+void
+=
test_probe_request_wire_format(void **state)
+{
+    struct gc_arena gc =3D=
 gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    const =
struct probe_request in =3D {
+        =2Erequest_id =3D 0x1122334455667788=
ULL,
+        =2Etimestamp =3D 0x0102030405060708ULL,
+        =2Eflags =3D=
 0,
+    };
+    assert_true(probe_request_write(&buf, &in));
+
+    /* cla=
ng-format off */
+    const uint8_t expected[] =3D {
+        0x00, 0x02,  =
                                   /* TLV type 2, not optional */
+        =
0x00, 0x14,                                     /* TLV value length =3D 20 =
*/
+        0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id *=
/
+        0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, /* timestamp */
=
+        0x00, 0x00, 0x00, 0x00,                         /* flags */
+    }=
;
+    /* clang-format on */
+    assert_int_equal(BLEN(&buf), sizeof(expec=
ted));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expected));
+
=
+    gc_free(&gc);
+}
+
+/* Write a probe reply TLV and read it back=2E */
=
+void
+test_probe_reply_roundtrip(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    con=
st struct probe_reply in =3D {
+        =2Erequest_id =3D 0x112233445566778=
8ULL,
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,
+        =2E=
max_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 30,
+        =2Ef=
lags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert_true(probe_repl=
y_write(&buf, &in));
+    assert_int_equal(BLEN(&buf), CTRL_MSG_TLV_HEADER_=
LEN + PROBE_REPLY_LEN);
+
+    struct ctrl_msg_tlv_header hdr;
+    assert_=
true(ctrl_msg_tlv_peek_header(&buf, &hdr));
+    assert_int_equal(hdr=2Etyp=
e, TLV_TYPE_PROBE_REPLY);
+    assert_false(hdr=2Eoptional);
+    assert_in=
t_equal(hdr=2Evalue_len, PROBE_REPLY_LEN);
+
+    struct buffer value;
+   =
 assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REPLY, &value));
+
+   =
 struct probe_reply out =3D { 0 };
+    assert_true(probe_reply_read(&value=
, &out));
+    assert_true(in=2Erequest_id =3D=3D out=2Erequest_id);
+    a=
ssert_int_equal(in=2Epriority, out=2Epriority);
+    assert_int_equal(in=2E=
weight, out=2Eweight);
+    assert_int_equal(in=2Emax_latency_diff, out=2Em=
ax_latency_diff);
+    assert_int_equal(in=2Econnect_lifetime, out=2Econnec=
t_lifetime);
+    assert_int_equal(in=2Eflags, out=2Eflags);
+    assert_in=
t_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* The probe reply wire =
format is locked to the field order of the spec
+ * (request_id, priority, =
weight, max_latency_diff, connect_lifetime, flags),
+ * big-endian=2E */
+v=
oid
+test_probe_reply_wire_format(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    con=
st struct probe_reply in =3D {
+        =2Erequest_id =3D 0x112233445566778=
8ULL,
+        =2Epriority =3D 10,
+        =2Eweight =3D 100,
+        =2E=
max_latency_diff =3D 25,
+        =2Econnect_lifetime =3D 30,
+        =2Ef=
lags =3D PROBE_REPLY_FLAG_RESEND_WKC,
+    };
+
+    assert_true(probe_repl=
y_write(&buf, &in));
+
+    /* clang-format off */
+    const uint8_t expec=
ted[] =3D {
+        0x00, 0x03,                                     /* TLV=
 type 3, not optional */
+        0x00, 0x12,                              =
       /* TLV value length =3D 18 */
+        0x11, 0x22, 0x33, 0x44, 0x55,=
 0x66, 0x77, 0x88, /* request_id */
+        0x00, 0x0a,                   =
                  /* priority =3D 10 */
+        0x00, 0x64,               =
                      /* weight =3D 100 */
+        0x00, 0x19,            =
                         /* max_latency_diff =3D 25 */
+        0x00, 0x1e,=
                                     /* connect_lifetime =3D 30 */
+       =
 0x00, 0x01,                                     /* flags =3D RESEND_WKC */=

+    };
+    /* clang-format on */
+    assert_int_equal(BLEN(&buf), sizeo=
f(expected));
+    assert_memory_equal(BPTR(&buf), expected, sizeof(expecte=
d));
+
+    gc_free(&gc);
+}
+
+/* A TLV with a longer-than-known value mus=
t still parse: the known fields are
+ * read and the trailing bytes are ski=
pped=2E Flag bits we do not know are kept
+ * rather than rejected, for the=
 same forward compatibility=2E */
+void
+test_probe_request_forward_compat(=
void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer b=
uf =3D alloc_buf_gc(128, &gc);
+
+    const uint16_t extended_len =3D PROBE=
_REQUEST_LEN + 4;
+    assert_true(ctrl_msg_tlv_write_header(&buf, TLV_TYPE=
_PROBE_REQUEST, false, extended_len));
+    assert_true(buf_write_u64(&buf,=
 7));             /* request_id */
+    assert_true(buf_write_u64(&buf, 0xd=
eadbeefULL)); /* timestamp */
+    assert_true(buf_write_u32(&buf, 0x800000=
00));    /* flags, unknown bit set */
+    assert_true(buf_write_u32(&buf, =
0x11223344));    /* unknown trailing field */
+
+    struct buffer value;
+=
    assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+=
    assert_int_equal(BLEN(&value), extended_len);
+
+    struct probe_reque=
st out =3D { 0 };
+    assert_true(probe_request_read(&value, &out));
+    =
assert_true(out=2Erequest_id =3D=3D 7);
+    assert_true(out=2Etimestamp =
=3D=3D 0xdeadbeefULL);
+    assert_true(out=2Eflags =3D=3D 0x80000000);
+  =
  /* the unknown trailing field must have been consumed from the payload */=

+    assert_int_equal(BLEN(&buf), 0);
+
+    gc_free(&gc);
+}
+
+/* A valu=
e shorter than the mandatory fields must be rejected, even when it
+ * hold=
s enough bytes for some of the individual fields to read successfully=2E */=

+void
+test_probe_request_too_short(void **state)
+{
+    struct gc_arena =
gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+
+    =
/* 8 of the 20 mandatory value bytes: enough for the request_id alone */
+ =
   assert_true(buf_write_u64(&buf, 0xdeadbeefULL));
+
+    struct probe_req=
uest out =3D { 0 };
+    assert_false(probe_request_read(&buf, &out));
+
+ =
   gc_free(&gc);
+}
+
+/* The same for the reply, one u16 short of its 18 m=
andatory bytes=2E */
+void
+test_probe_reply_too_short(void **state)
+{
+  =
  struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(=
128, &gc);
+
+    assert_true(buf_write_u64(&buf, 1));
+    for (int i =3D =
0; i < 4; i++)
+    {
+        assert_true(buf_write_u16(&buf, 0));
+    }
=
+
+    struct probe_reply out =3D { 0 };
+    assert_false(probe_reply_read=
(&buf, &out));
+
+    gc_free(&gc);
+}
+
+/* The flag combinations the prot=
ocol rules out must be rejected: the other
+ * addresses of a remote cannot=
 be both the same server and distinct ones, and
+ * a shared connect_lifeti=
me needs them to have been called equal=2E */
+void
+test_probe_reply_flags=
_contradict(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    con=
st uint16_t bad[] =3D {
+        PROBE_REPLY_FLAG_ADDRS_EQUAL | PROBE_REPLY=
_FLAG_PROBE_MORE,
+        PROBE_REPLY_FLAG_LIFETIME_SHARED,
+        PROBE=
_REPLY_FLAG_LIFETIME_SHARED | PROBE_REPLY_FLAG_PROBE_MORE,
+    };
+    con=
st uint16_t good[] =3D {
+        0,
+        PROBE_REPLY_FLAG_ADDRS_EQUAL,=

+        PROBE_REPLY_FLAG_PROBE_MORE,
+        PROBE_REPLY_FLAG_ADDRS_EQUA=
L | PROBE_REPLY_FLAG_LIFETIME_SHARED,
+    };
+
+    for (size_t i =3D 0; i=
 < SIZE(bad) + SIZE(good); i++)
+    {
+        const bool expect_ok =3D i =
>=3D SIZE(bad);
+        const uint16_t flags =3D expect_ok ? good[i - SIZE=
(bad)] : bad[i];
+
+        struct buffer buf =3D alloc_buf_gc(128, &gc);
+=
        const struct probe_reply in =3D { =2Erequest_id =3D 1, =2Eflags =3D=
 flags };
+        assert_true(probe_reply_write(&buf, &in));
+
+        st=
ruct buffer value;
+        assert_true(ctrl_msg_find_tlv(&buf, TLV_TYPE_PR=
OBE_REPLY, &value));
+
+        struct probe_reply out =3D { 0 };
+        =
assert_int_equal(probe_reply_read(&value, &out), expect_ok);
+    }
+
+    =
gc_free(&gc);
+}
+
+/* A TLV header claiming more value bytes than the payl=
oad holds must be
+ * rejected by the scan rather than reported as found --=
 for the TLV being
+ * looked for as much as for one that would merely be s=
kipped=2E */
+void
+test_find_tlv_value_truncated(void **state)
+{
+    str=
uct gc_arena gc =3D gc_new();
+    struct buffer value;
+
+    /* the wante=
d TLV declares 20 value bytes, only 8 are present */
+    struct buffer buf=
 =3D alloc_buf_gc(128, &gc);
+    assert_true(ctrl_msg_tlv_write_header(&bu=
f, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN));
+    assert_true(buf=
_write_u64(&buf, 0xdeadbeefULL));
+    assert_false(ctrl_msg_find_tlv(&buf,=
 TLV_TYPE_PROBE_REQUEST, &value));
+
+    /* same defect on a TLV that woul=
d be skipped: the scan must not walk past
+     * the end of the payload lo=
oking for the next header */
+    struct buffer buf2 =3D alloc_buf_gc(128, =
&gc);
+    assert_true(ctrl_msg_tlv_write_header(&buf2, 0x7ff, false, 64));=

+    assert_true(buf_write_u32(&buf2, 0));
+    assert_false(ctrl_msg_find=
_tlv(&buf2, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/*=
 Bytes left over after the last TLV that are too few for a header make the
=
+ * message malformed, even when the wanted TLV was already found=2E */
+vo=
id
+test_find_tlv_trailing_bytes(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer value;
+
+    /* 1 to 3 bytes: less than a=
 4-byte TLV header */
+    for (int trailing =3D 1; trailing < CTRL_MSG_TLV=
_HEADER_LEN; trailing++)
+    {
+        struct buffer buf =3D alloc_buf_gc=
(128, &gc);
+        const struct probe_request in =3D { =2Erequest_id =3D =
1, =2Etimestamp =3D 1 };
+        assert_true(probe_request_write(&buf, &in=
));
+        for (int i =3D 0; i < trailing; i++)
+        {
+            a=
ssert_true(buf_write_u8(&buf, 0));
+        }
+        assert_false(ctrl_ms=
g_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    }
+
+    gc_free(&g=
c);
+}
+
+/* An unknown TLV marked optional after the wanted one is skipped=
, and the
+ * wanted value is still the one returned=2E */
+void
+test_find=
_tlv_skips_optional_after_wanted(void **state)
+{
+    struct gc_arena gc =
=3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+    struc=
t buffer value;
+
+    const struct probe_request in =3D { =2Erequest_id =
=3D 1, =2Etimestamp =3D 7 };
+    assert_true(probe_request_write(&buf, &in=
));
+    assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4));
+   =
 assert_true(buf_write_u32(&buf, 0));
+
+    assert_true(ctrl_msg_find_tlv(=
&buf, TLV_TYPE_PROBE_REQUEST, &value));
+    assert_int_equal(BLEN(&value),=
 PROBE_REQUEST_LEN);
+    struct probe_request out =3D { 0 };
+    assert_t=
rue(probe_request_read(&value, &out));
+    assert_true(out=2Etimestamp =3D=
=3D 7);
+
+    gc_free(&gc);
+}
+
+/* The wanted TLV may occur only once: a=
 second one rejects the message=2E Repeats
+ * of an unknown TLV marked opt=
ional are skipped like any other=2E */
+void
+test_find_tlv_rejects_duplica=
te(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffe=
r value;
+    const struct probe_request in =3D { =2Erequest_id =3D 1 };
+
=
+    struct buffer buf =3D alloc_buf_gc(128, &gc);
+    assert_true(probe_r=
equest_write(&buf, &in));
+    assert_true(probe_request_write(&buf, &in));=

+    assert_false(ctrl_msg_find_tlv(&buf, TLV_TYPE_PROBE_REQUEST, &value))=
;
+
+    buf =3D alloc_buf_gc(128, &gc);
+    for (int i =3D 0; i < 2; i++)=

+    {
+        assert_true(ctrl_msg_tlv_write_header(&buf, 0x7ff, true, 4=
));
+        assert_true(buf_write_u32(&buf, 0));
+    }
+    assert_true(p=
robe_request_write(&buf, &in));
+    assert_true(ctrl_msg_find_tlv(&buf, TL=
V_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
+
+/* An empty payl=
oad holds no TLV=2E */
+void
+test_find_tlv_empty_payload(void **state)
+{
=
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_=
gc(16, &gc);
+    struct buffer value;
+
+    assert_false(ctrl_msg_find_tl=
v(&buf, TLV_TYPE_PROBE_REQUEST, &value));
+
+    gc_free(&gc);
+}
diff --gi=
t a/tests/unit_tests/openvpn/test_probe=2Eh b/tests/unit_tests/openvpn/test=
_probe=2Eh
new file mode 100644
index 0000000=2E=2Ebc51721
--- /dev/null
++=
+ b/tests/unit_tests/openvpn/test_probe=2Eh
@@ -0,0 +1,51 @@
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
+#ifndef TEST_PROBE_H
+#define TEST_PROBE_H
+
+void test_probe_request_roun=
dtrip(void **state);
+
+void test_probe_request_wire_format(void **state);
=
+
+void test_probe_reply_roundtrip(void **state);
+
+void test_probe_reply_=
wire_format(void **state);
+
+void test_probe_request_forward_compat(void *=
*state);
+
+void test_probe_request_too_short(void **state);
+
+void test_p=
robe_reply_too_short(void **state);
+
+void test_probe_reply_flags_contradi=
ct(void **state);
+
+void test_find_tlv_value_truncated(void **state);
+
+v=
oid test_find_tlv_trailing_bytes(void **state);
+
+void test_find_tlv_skips=
_optional_after_wanted(void **state);
+
+void test_find_tlv_rejects_duplica=
te(void **state);
+
+void test_find_tlv_empty_payload(void **state);
+#endi=
f

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=
=3Demail
To unsubscribe, or for help writing mail filters, visit https://ge=
rrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatchset
=
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c8d302ac5=
7c5603d622a7be14be369437388268
Gerrit-Change-Number: 1741
Gerrit-PatchSet: =
25
Gerrit-Owner: Lev Stipakov <lstipakov@gmail=2Ecom>
Gerrit-Reviewer: Arne=
 Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Reviewer: Frank Lichtenheld <f=
rank@lichtenheld=2Ecom>
Gerrit-Reviewer: Ralf Lici <ralf@mandelbit=2Ecom>
G=
errit-CC: chugly <charlie=2Evigue@openvpn=2Ecom>
Gerrit-CC: openvpn-devel <=
openvpn-devel@lists=2Esourceforge=2Enet>
Gerrit-Attention: Ralf Lici <ralf@=
mandelbit=2Ecom>
Gerrit-Attention: Lev Stipakov <lstipakov@gmail=2Ecom>
Ger=
rit-Attention: Frank Lichtenheld <frank@lichtenheld=2Ecom>

--NoV8CDyGtYQ=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Frank Lichtenheld, Lev Stipakov, Ralf Lici=2E </p>
<p=
>Lev Stipakov <strong>uploaded patch set #25</strong> to this change=2E</p>=
<p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?usp=3Demail">=
View Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">control_msg: Add P_CONTROL_V2 and the prob=
e request and reply TLVs<br><br>A client probes a server before connecting =
by sending a P_CONTROL_V2<br>message carrying a probe request TLV, and the =
server answers with a<br>P_CONTROL_V2 carrying a probe reply=2E The reply t=
ells the client how the<br>server wants to be ranked against the other remo=
tes, and can also serve<br>as the second packet of the three-way handshake=
=2E<br><br>Add the two opcodes and the two TLV codecs the probe needs=2E P_=
CONTROL_V2<br>is framed like P_CONTROL_V1 but without the fields of the rel=
iability<br>layer: a session id and then the TLVs, with no control message =
id and no<br>ACK array=2E P_CONTROL_WKC_V2 is the same with the wrapped cli=
ent key<br>appended, as P_CONTROL_WKC_V1 is to P_CONTROL_V1=2E<br><br>The T=
LVs use the shared TLV codec, control_msg=2Ec/h, and their two types<br>joi=
n the others there=2E The codec gains ctrl_msg_find_tlv(), which scans<br>a=
 payload for the one mandatory TLV of a message=2E The scan is strict: a<br=
>truncated TLV header or value, a second TLV of the wanted type, or an<br>u=
nknown TLV not marked optional rejects the whole message=2E<br><br>Both rea=
ders accept a value longer than the fields they know and ignore<br>the exce=
ss, which is how the TLVs are meant to be extended=2E The probe<br>reply re=
ader does reject the two flag combinations the protocol rules<br>out, as ne=
ither can be acted on: the other addresses of a remote cannot<br>be both th=
e same server and distinct ones, and the connect_lifetime<br>cannot be exte=
nded to those addresses without first calling them the<br>same server=2E<br=
><br>The reliable control path no longer decides what it handles from an<br=
>opcode range=2E P_FIRST_OPCODE and P_LAST_OPCODE give way to<br>opcode_is_=
reliable_control(), which lists the opcodes that carry a<br>message id and =
an ACK array, and tls_pre_decrypt() and<br>write_control_auth() test that i=
nstead=2E Defining an opcode therefore no<br>longer joins it to that set, s=
o neither the two added here nor<br>CONTROL_AUX_V1 after them needs to be c=
arved back out of a range=2E<br><br>No opcode changes hands: the old range =
covered exactly the seven listed,<br>plus the two data channel opcodes, whi=
ch are handled before the check is<br>reached=2E<br><br>The probe is not se=
nt or answered yet; that follows=2E<br><br>Change-Id: I1c8d302ac57c5603d622=
a7be14be369437388268<br>Signed-off-by: Lev Stipakov &lt;lev@openvpn=2Enet&g=
t;<br>---<br>M CMakeLists=2Etxt<br>M src/openvpn/Makefile=2Eam<br>M src/ope=
nvpn/control_msg=2Ec<br>M src/openvpn/control_msg=2Eh<br>A src/openvpn/prob=
e=2Ec<br>A src/openvpn/probe=2Eh<br>M src/openvpn/ssl=2Ec<br>M src/openvpn/=
ssl_pkt=2Ec<br>M src/openvpn/ssl_pkt=2Eh<br>M tests/unit_tests/openvpn/Make=
file=2Eam<br>M tests/unit_tests/openvpn/test_pkt=2Ec<br>A tests/unit_tests/=
openvpn/test_probe=2Ec<br>A tests/unit_tests/openvpn/test_probe=2Eh<br>13 f=
iles changed, 829 insertions(+), 14 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/41/1741/2=
5</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt</span><br><span>=
index 305c26c=2E=2Ec650468 100644</span><br><span>--- a/CMakeLists=2Etxt</s=
pan><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ -565,6 +565,8 @@</s=
pan><br><span>     src/openvpn/plugin=2Eh</span><br><span>     src/openvpn/=
pool=2Ec</span><br><span>     src/openvpn/pool=2Eh</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    src/openvpn/probe=2Ec</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/probe=2Eh</span><br><s=
pan>     src/openvpn/proto=2Ec</span><br><span>     src/openvpn/proto=2Eh</=
span><br><span>     src/openvpn/proxy=2Ec</span><br><span>@@ -899,7 +901,9 =
@@</span><br><span>     target_sources(test_pkt PRIVATE</span><br><span>   =
      tests/unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>      =
   tests/unit_tests/openvpn/test_control_msg=2Ec</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/test_probe=2E=
c</span><br><span>         src/openvpn/control_msg=2Ec</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/probe=2Ec</span><br>=
<span>         src/openvpn/argv=2Ec</span><br><span>         src/openvpn/ba=
se64=2Ec</span><br><span>         src/openvpn/crypto_epoch=2Ec</span><br><s=
pan>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makefile=2Eam</spa=
n><br><span>index be1044d=2E=2E2797a1c 100644</span><br><span>--- a/src/ope=
nvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=2Eam</span><b=
r><span>@@ -120,7 +120,7 @@</span><br><span> 	packet_id=2Ec packet_id=2Eh \=
</span><br><span> 	ping=2Ec ping=2Eh \</span><br><span> 	plugin=2Ec plugin=
=2Eh \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	pool=2Ec pool=
=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	pool=2Ec poo=
l=2Eh 	probe=2Ec probe=2Eh \</span><br><span> 	proto=2Ec proto=2Eh \</span>=
<br><span> 	proxy=2Ec proxy=2Eh \</span><br><span> 	ps=2Ec ps=2Eh \</span><=
br><span>diff --git a/src/openvpn/control_msg=2Ec b/src/openvpn/control_msg=
=2Ec</span><br><span>index e14355c=2E=2Ea77413f 100644</span><br><span>--- =
a/src/openvpn/control_msg=2Ec</span><br><span>+++ b/src/openvpn/control_msg=
=2Ec</span><br><span>@@ -91,3 +91,32 @@</span><br><span>     buf_set_read(v=
alue, v, hdr-&gt;value_len);</span><br><span>     return true;</span><br><s=
pan> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ctrl_msg_find_tlv(struct buffer *payload, uint1=
6_t wanted_type, struct buffer *value)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bool found =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    while (BLEN(payload) &gt; 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct ctrl_msg_tlv_header hdr;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        struct buffer v;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!ctrl_msg_tlv_next(payload, &amp=
;hdr, &amp;v))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (hdr=2Et=
ype =3D=3D wanted_type)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       return false; /* the TLV may occur only once */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            *value =3D v;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            found =3D true;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else if (!hdr=2Eoptional)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return false; /* a mandat=
ory TLV we do not understand, wherever it sits */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return found;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span>diff --git a/src/openvpn/control_msg=2Eh b/src/openvp=
n/control_msg=2Eh</span><br><span>index 92572cb=2E=2E8ad5530 100644</span><=
br><span>--- a/src/openvpn/control_msg=2Eh</span><br><span>+++ b/src/openvp=
n/control_msg=2Eh</span><br><span>@@ -41,6 +41,8 @@</span><br><span> </span=
><br><span> /* TLV types */</span><br><span> #define TLV_TYPE_EARLY_NEG_FLA=
GS 0x0001 /* early negotiation, in the reset packets */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REQUEST   0x0002=
 /* a client probing a server, in P_CONTROL_V2 */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define TLV_TYPE_PROBE_REPLY     0x0003 /* th=
e server&#39;s answer, in P_CONTROL_V2 */</span><br><span> </span><br><span=
> /* A TLV header is a 16-bit type/optional field plus a 16-bit length */</=
span><br><span> #define CTRL_MSG_TLV_HEADER_LEN 4</span><br><span>@@ -105,4=
 +107,28 @@</span><br><span>  */</span><br><span> bool ctrl_msg_tlv_next(st=
ruct buffer *buf, struct ctrl_msg_tlv_header *hdr, struct buffer *value);</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Scan payload for=
 the TLV of type wanted_type, skipping any other TLV type</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * that is marked optional=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * This is for messages that carry exactly o=
ne mandatory TLV, which is what the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * probe messages are=2E Any other TLV that is not marked o=
ptional invalidates</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * the message wherever it appears, as does a second TLV of wanted_type, so=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * whole sequen=
ce is walked even once the wanted TLV has been found=2E A message</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * carrying several mandatory=
 TLVs walks them with ctrl_msg_tlv_next() instead=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * On success value covers exactly the found TLV&#39;s val=
ue bytes; as in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c=
trl_msg_tlv_next(), a header claiming more bytes than payload holds is</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rejected rather than =
reported as found=2E payload is consumed as it is read=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param payload      buffer positioned at a TLV head=
er</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param wanted_=
type  the TLV type to look for</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param value        set to a buffer covering the found TLV&#3=
9;s value; it points</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *                     into payload and owns no storage</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @return true if the TLV was found, =
false if it is absent or present more</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *         than once, if a TLV header or value is malform=
ed or truncated, or if</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *         a TLV we do not understand is not marked optional=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+bool ctrl_msg_find_tlv(struct buffer *payloa=
d, uint16_t wanted_type, struct buffer *value);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef CONTROL_MSG_=
H */</span><br><span>diff --git a/src/openvpn/probe=2Ec b/src/openvpn/probe=
=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=2E=
=2E2497b07</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/=
probe=2Ec</span><br><span>@@ -0,0 +1,94 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single=
 TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *             session authentication and key exc=
hange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  packet encryption, packet authentication, and</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *             packet compression=2E</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sal=
es@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program=
 is free software; you can redistribute it and/or modify</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU Gene=
ral Public License version 2</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  as published by the Free Software Foundation=2E</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that it=
 will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS =
FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  GNU General Public License for more details=2E</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the G=
NU General Public License along</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  with this program; if not, see &lt;https://www=2Egnu=2Eorg/=
licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=2Eh&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;probe=2Eh&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;control_msg=2Eh&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+probe_request_write(struct buffer *buf, const struct probe_request *r=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header=
(buf, TLV_TYPE_PROBE_REQUEST, false, PROBE_REQUEST_LEN)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u64(buf=
, r-&gt;request_id) &amp;&amp; buf_write_u64(buf, r-&gt;timestamp)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_wr=
ite_u32(buf, r-&gt;flags);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+probe_request_read(struct buffer *buf, struct=
 probe_request *r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* One bounds c=
heck covers the whole value: every field read below then fits</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * by construction, PROBE_REQ=
UEST_LEN being the sum of their sizes, so none</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * of them needs its own error handling=2E T=
railing bytes this version does</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+     * not understand are simply left unread=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(buf) &lt; PROBE_=
REQUEST_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;request_id =3D buf_read=
_u64(buf, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 r-&gt;timestamp =3D buf_read_u64(buf, NULL);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    r-&gt;flags =3D buf_read_u32(buf, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+prob=
e_reply_write(struct buffer *buf, const struct probe_reply *r)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return ctrl_msg_tlv_write_header(buf, TLV_TYPE=
_PROBE_REPLY, false, PROBE_REPLY_LEN)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+           &amp;&amp; buf_write_u64(buf, r-&gt;request_id=
) &amp;&amp; buf_write_u16(buf, r-&gt;priority)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u16(buf, r-&gt;=
weight) &amp;&amp; buf_write_u16(buf, r-&gt;max_latency_diff)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+           &amp;&amp; buf_write_u=
16(buf, r-&gt;connect_lifetime) &amp;&amp; buf_write_u16(buf, r-&gt;flags);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+probe_reply_read(struct buffer *buf, struct probe_reply *r)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* One bounds check for the whole value, as i=
n probe_request_read()=2E */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (buf_len(buf) &lt; PROBE_REPLY_LEN)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return false;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    r-&gt;request_id =3D buf_read_u64(buf, NULL);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    r-&gt;priority =3D (uint16_t)buf_=
read_u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
-&gt;weight =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    r-&gt;max_latency_diff =3D (uint16_t)buf_read_=
u16(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r-&gt;=
connect_lifetime =3D (uint16_t)buf_read_u16(buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    r-&gt;flags =3D (uint16_t)buf_read_u16(bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* The other addresses of the r=
emote cannot be both the same server and</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * distinct ones=2E And LIFETIME_SHARED extends th=
e connect_lifetime to those</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * other addresses, which says nothing unless ADDRS_EQUAL has d=
eclared them</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
the same server to begin with=2E */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if ((r-&gt;flags &amp; PROBE_REPLY_FLAG_ADDRS_EQUAL) &a=
mp;&amp; (r-&gt;flags &amp; PROBE_REPLY_FLAG_PROBE_MORE))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if ((r-&gt;flags &amp; PROBE_REPLY_FLAG_LIFETIME_SHARED) &a=
mp;&amp; !(r-&gt;flags &amp; PROBE_REPLY_FLAG_ADDRS_EQUAL))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span>diff --git a/src/openvpn/probe=2Eh b/src/openv=
pn/probe=2Eh</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2Ee8b0299</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/probe=2Eh</span><br><span>@@ -0,0 +1,141 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over =
a single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This=
 program is free software; you can redistribute it and/or modify</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the =
GNU General Public License version 2</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  as published by the Free Software Foundation=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed in the ho=
pe that it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY o=
r FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  GNU General Public License for more details=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received a co=
py of the GNU General Public License along</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https://www=
=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @file</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Encoding and decoding of the server probe TLVs=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * A client probes a server by sendi=
ng a P_CONTROL_V2 message whose payload</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * carries a probe request TLV, and the server answers =
with a P_CONTROL_V2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * message carrying a probe reply TLV=2E The reply tells the client how the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * server wants to =
be ranked against the other remotes, and can also serve</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * as the second packet of the three-wa=
y handshake=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The TLV framing and=
 the TLV type space are shared with the other TLV-based</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * control messages and live in control=
_msg=2Eh; this file holds the two probe</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * TLVs and what their fields mean=2E</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#ifndef PROBE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define PROBE_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;control_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Smallest on=
-wire value length (the TLV header not counted) of each TLV: the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * sizes of the fixed fields b=
elow, in wire order=2E A value may be longer, which</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * is how the TLVs are extended; trailing=
 bytes that are not understood are</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * ignored on read=2E */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* request_id (u64), timestamp (u64), flags (u32) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REQUEST_LEN ((uint16_t)(2 *=
 sizeof(uint64_t) + sizeof(uint32_t)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* request_id (u64), then priority, weight, max_latency_diff,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * connect_lifetime and flags (u1=
6 each) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define P=
ROBE_REPLY_LEN ((uint16_t)(sizeof(uint64_t) + 5 * sizeof(uint16_t)))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* probe request flags=2E The client is only =
probing: it does not want to</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * continue into a handshake, and the server may forget it right a=
way=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PR=
OBE_REQUEST_FLAG_PROBE_ONLY 0x00000001</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* probe reply flags */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* complete the handshake with P_CONTROL_WKC_V1 rather than P_CONTROL_V=
1 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_R=
EPLY_FLAG_RESEND_WKC      0x0001</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* the other addresses of this remote are the same server, no =
need to probe them */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define PROBE_REPLY_FLAG_ADDRS_EQUAL     0x0002</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* the connect_lifetime holds against those o=
ther addresses too, so a reply</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * from one of them can skip the handshake with another=2E Only =
meaningful</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * togeth=
er with ADDRS_EQUAL, which is what names those addresses=2E */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REPLY_FLAG_LIFETIM=
E_SHARED 0x0004</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* t=
he other addresses of this remote are distinct servers, so probe them too *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROBE_REPL=
Y_FLAG_PROBE_MORE      0x0008</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/** probe=
 request TLV, sent by a client to probe a server */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct probe_request</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint64_t request_id; /**&lt; identifies this probe, ec=
hoed in the reply */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /** The client clock as a UNIX timestamp in seconds=2E It is there for=
 the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * server, =
which uses it to bound how old a request it will answer and so</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * how long a captured one c=
an be replayed=2E The reply does not echo it: a</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * client times the round trip itself, by t=
he request_id=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint64_t timestamp;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    uint32_t flags; /**&lt; PROBE_REQUEST_FLAG_* */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/** probe reply TLV, a server&#39;s answer to a probe request */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+struct probe_reply</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint64_t request_id;       /**&lt; echoes the=
 request_id of the request */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    uint16_t priority;         /**&lt; DNS SRV style priority, lo=
wer is preferred */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    uint16_t weight;           /**&lt; DNS SRV style weight */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    uint16_t max_latency_diff; /=
**&lt; candidate band in ms around the fastest server */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /** For how many seconds, counted =
from the moment the client sent its own</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * probe request, the server will still treat this =
exchange as the first</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * two packets of the handshake=2E Within that window the client may =
send the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * thir=
d packet straight away instead of starting a handshake of its own=2E</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * 0 means it cannot, =
so it has to begin a fresh one=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    uint16_t connect_lifetime;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    uint16_t flags; /**&lt; PROBE_REPLY_FLAG_* =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Write a complete probe request TLV, header and value, to buf=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @return true on success, false if bu=
f has insufficient space=2E</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool pro=
be_request_write(struct buffer *buf, const struct probe_request *r);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * Read a probe request TLV value from buf=2E</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * buf must cover exactly the TLV&#39;s value, as ct=
rl_msg_find_tlv() returns it=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * Bytes beyond the fields understood here are ignored, so a lo=
nger value from</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a=
 future version still parses=2E Flag bits that are not known are kept in</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * flags rather than r=
ejected, for the same reason=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn true on success, false if buf is shorter than the mandatory fields=2E=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+bool probe_request_read(struct buff=
er *buf, struct probe_request *r);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Write a complete =
probe reply TLV, header and value, to buf=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @return true on success, false if buf has insufficient space=2E<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+bool probe_reply_write(struct buffer=
 *buf, const struct probe_reply *r);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a probe re=
ply TLV value from buf=2E The calling convention is that of</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * probe_request_read()=2E</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * The two flag combinations the protocol rul=
es out are rejected here, since</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * neither can be acted on: a reply must not call the other add=
resses of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * rem=
ote both the same server and distinct ones, and it must not extend the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * connect_lifetime to t=
hose addresses without first calling them the same</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * server=2E</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @return true on success, false if buf is shorter than the mandato=
ry fields</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        =
 or the flags contradict each other=2E</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool probe_reply_read(struct buffer *buf, struct probe_reply *r);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* ifndef PROBE_H */</span><br><span>d=
iff --git a/src/openvpn/ssl=2Ec b/src/openvpn/ssl=2Ec</span><br><span>index=
 9a72614=2E=2E2533b1e 100644</span><br><span>--- a/src/openvpn/ssl=2Ec</spa=
n><br><span>+++ b/src/openvpn/ssl=2Ec</span><br><span>@@ -3783,15 +3783,26 =
@@</span><br><span>     bool new_link =3D false;</span><br><span>     struc=
t session_id sid; /* remote session ID */</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    /* verify legal opcode */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (op &lt; P_FIRST_OPCOD=
E || op &gt; P_LAST_OPCODE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* verify the opcode belongs to the reliable control channel, w=
hose</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * message =
id and ACK array we parse below */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!opcode_is_reliable_control(op))</span><br><span>   =
  {</span><br><span>         if (op =3D=3D P_CONTROL_HARD_RESET_CLIENT_V1 |=
| op =3D=3D P_CONTROL_HARD_RESET_SERVER_V1)</span><br><span>         {</spa=
n><br><span>             msg(D_TLS_ERRORS, &quot;Peer tried unsupported key=
-method 1&quot;);</span><br><span>         }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS, &quot;TLS Error: unknown o=
pcode received from %s op=3D%d&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            print_link_socket_actual(from, &amp;gc), op);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (op =3D=3D=
 P_CONTROL_V2 || op =3D=3D P_CONTROL_WKC_V2)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* a defined opcode, just not one this path can =
parse */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(D_TLS_ERRORS, &quot;TLS Error: %s received from %s, which is not part =
of &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                    &quot;the reliable control channel&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                packet_opcode_nam=
e(op), print_link_socket_actual(from, &amp;gc));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(D_TLS_ERRORS, &quot;TLS Error: unknown opcode received fr=
om %s op=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                print_link_socket_actual(from, &amp;gc), op);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>      =
   goto error;</span><br><span>     }</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/ssl_pkt=2Ec b/src/openvpn/ssl_pkt=2Ec</span><br><span=
>index f4564ef=2E=2Eccb841e 100644</span><br><span>--- a/src/openvpn/ssl_pk=
t=2Ec</span><br><span>+++ b/src/openvpn/ssl_pkt=2Ec</span><br><span>@@ -169=
,7 +169,8 @@</span><br><span>                    bool prepend_ack)</span><b=
r><span> {</span><br><span>     ASSERT(ks-&gt;key_id &gt;=3D 0 &amp;&amp; k=
s-&gt;key_id &lt;=3D P_KEY_ID_MASK);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASSERT(opcode &gt;=3D 0 &amp;&amp; opcode &lt;=3D P_LAST=
_OPCODE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* thi=
s writes the message id and ACK array, which only these opcodes have */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(opcode_is_re=
liable_control(opcode));</span><br><span>     uint8_t header =3D (uint8_t)(=
ks-&gt;key_id | (opcode &lt;&lt; P_OPCODE_SHIFT));</span><br><span> </span>=
<br><span>     /* Workaround for Softether servers=2E Softether has a bug t=
hat it only</span><br><span>diff --git a/src/openvpn/ssl_pkt=2Eh b/src/open=
vpn/ssl_pkt=2Eh</span><br><span>index 218c6bb=2E=2E3b45492 100644</span><br=
><span>--- a/src/openvpn/ssl_pkt=2Eh</span><br><span>+++ b/src/openvpn/ssl_=
pkt=2Eh</span><br><span>@@ -58,11 +58,50 @@</span><br><span>  * like P_CONT=
ROL_HARD_RESET_CLIENT_V3 */</span><br><span> #define P_CONTROL_WKC_V1 11</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* def=
ine the range of legal opcodes</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">- * Since we do no longer support key-method 1 we consider</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- * the v1 op codes invalid */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define P_FIRST_OPCODE=
 3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define P_LAST_OPCO=
DE  11</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Control ch=
annel packet carrying a TLV payload, e=2Eg=2E a server probe=2E Framed</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * like P_CONTROL_V1 but=
 without the fields of the reliability layer: a session</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * id and then the TLVs, with no messag=
e id and no ACK array=2E It is wrapped by</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * tls-auth or tls-crypt like any other control chann=
el packet, and with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * neither configured it travels unauthenticated, as they do=2E */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define P_CONTROL_V2 12</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Variant of P_CONTROL_V2 with the wrapp=
ed client key appended,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * like P_CONTROL_WKC_V1 is to P_CONTROL_V1 */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define P_CONTROL_WKC_V2 13</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Is a packet with opcode op carried by the reliable control channel?<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * These opcodes are followed by an A=
CK array and a control message id, which</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * is what the reliable path reads once it is past the=
 session id=2E An opcode</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * that is not one of them has something else there: P_CONTROL_V2 has =
its TLVs=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Handi=
ng such a packet to that path would read the first bytes of that</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * payload as an ACK count and=
 a message id, and ACK or queue whatever it made</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * of them=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * The opcodes are listed rather than bounded by a range, so that def=
ining one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * does no=
t silently add it to the set=2E Key method 1 is no longer supported, so</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * its two reset opcode=
s are not here, and the data channel opcodes are handled</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * before this is reached=2E</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static inline bool</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+opcode_is_reliable_control(int op)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    switch (op)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        case P_CONTROL_SOFT_RESET_V1:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        case P_CONTROL_V1:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case P_ACK_V1:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_HARD_RESET_CLIE=
NT_V2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case =
P_CONTROL_HARD_RESET_SERVER_V2:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        case P_CONTROL_HARD_RESET_CLIENT_V3:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        case P_CONTROL_WKC_V1:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> /*</span><br><s=
pan>  * Define number of buffers for send and receive in the reliability la=
yer=2E</span><br><span>@@ -257,6 +296,12 @@</span><br><span>         case P=
_CONTROL_WKC_V1:</span><br><span>             return &quot;P_CONTROL_WKC_V1=
&quot;;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case P_CONTROL_V2:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            return &quot;P_CONTROL_V2&quot;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        case P_CONTROL_WKC_V2:</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return &quot;P_CONTROL_WKC_V2&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>         case P_ACK_V1:</span><br><span>             return &quot;P_ACK_V1=
&quot;;</span><br><span> </span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/Makefile=2Eam b/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span=
>index 11f92f4=2E=2E209a9a1 100644</span><br><span>--- a/tests/unit_tests/o=
penvpn/Makefile=2Eam</span><br><span>+++ b/tests/unit_tests/openvpn/Makefil=
e=2Eam</span><br><span>@@ -165,14 +165,14 @@</span><br><span> 	@TEST_CFLAGS=
@</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><spa=
n> pkt_testdriver_SOURCES =3D test_pkt=2Ec \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	test_control_msg=2Ec test_control_msg=2Eh \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	test_control_msg=2Ec test_=
control_msg=2Eh 	test_probe=2Ec test_probe=2Eh \</span><br><span> 	mock_msg=
=2Ec mock_msg=2Eh mock_win32_execve=2Ec \</span><br><span> 	test_common=2Eh=
 \</span><br><span> 	$(top_srcdir)/src/compat/compat-strlcpy=2Ec \</span><b=
r><span> 	$(top_srcdir)/src/openvpn/argv=2Ec \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/base64=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/bu=
ffer=2Ec \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(top_srcd=
ir)/src/openvpn/control_msg=2Ec \</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	$(top_srcdir)/src/openvpn/control_msg=2Ec 	$(top_srcdir)/src=
/openvpn/probe=2Ec \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto=2Ec=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch=2Ec \</span><br=
><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls=2Ec \</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_pkt=2Ec b/tests/unit_tests/openvpn/=
test_pkt=2Ec</span><br><span>index 7dc07aa=2E=2Eb84ef36 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_pkt=2Ec</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_pkt=2Ec</span><br><span>@@ -45,6 +45,7 @@</span><b=
r><span> #include &quot;reliable=2Eh&quot;</span><br><span> #include &quot;=
siphash=2Eh&quot;</span><br><span> #include &quot;test_control_msg=2Eh&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tes=
t_probe=2Eh&quot;</span><br><span> </span><br><span> int</span><br><span> p=
arse_line(const char *line, char **p, const int n, const char *file, const =
int line_num,</span><br><span>@@ -841,7 +842,20 @@</span><br><span>        =
 cmocka_unit_test(test_tlv_next_walks_payload),</span><br><span>         cm=
ocka_unit_test(test_tlv_next_value_truncated),</span><br><span>         cmo=
cka_unit_test(test_tlv_header_truncated),</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        cmocka_unit_test(test_tlv_write_no_room)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(t=
est_tlv_write_no_room),</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_probe_request_roundtrip),</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe=
_request_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cmocka_unit_test(test_probe_reply_roundtrip),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_re=
ply_wire_format),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_probe_request_forward_compat),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_=
request_too_short),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_probe_reply_too_short),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_probe_reply=
_flags_contradict),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_find_tlv_value_truncated),</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_find_tlv=
_trailing_bytes),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      cmocka_unit_test(test_find_tlv_skips_optional_after_wanted),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_find_tlv_rejects_duplicate),</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        cmocka_unit_test(test_find_tlv_empty_payload)</span><br>=
<span>     };</span><br><span> </span><br><span>     return cmocka_run_grou=
p_tests_name(&quot;pkt tests&quot;, tests, NULL, NULL);</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/test_probe=2Ec b/tests/unit_tests/openvp=
n/test_probe=2Ec</span><br><span>new file mode 100644</span><br><span>index=
 0000000=2E=2Ec4ca385</span><br><span>--- /dev/null</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_probe=2Ec</span><br><span>@@ -0,0 +1,399 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secure=
ly tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             over a single TCP/UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C)=
 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  This program is free software; you can redistribute it an=
d/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it u=
nder the terms of the GNU General Public License version 2</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Softwar=
e Foundation=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is d=
istributed in the hope that it will be useful,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the i=
mplied warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public Licen=
se for more details=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should=
 have received a copy of the GNU General Public License along</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, se=
e &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef H=
AVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;config=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=2Eh&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg=2Eh&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stddef=2Eh&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setj=
mp=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;contr=
ol_msg=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &quot;probe=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#include &quot;test_common=2Eh&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;test_probe=2Eh&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Write a probe request TLV and read it back; the fi=
elds must survive the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * round trip and the whole buffer must be consumed=2E */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+test_probe_request_roundtrip(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D al=
loc_buf_gc(128, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const str=
uct probe_request in =3D {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        =2Erequest_id =3D 0xdeadbeefcafef00dULL,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0123456789ab=
cdefULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2E=
flags =3D PROBE_REQUEST_FLAG_PROBE_ONLY,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(probe_request_write(&amp;buf, &amp;in));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&amp=
;buf), CTRL_MSG_TLV_HEADER_LEN + PROBE_REQUEST_LEN);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    struct ctrl_msg_tlv_header hdr;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(ctrl_msg_tlv_peek_header(&am=
p;buf, &amp;hdr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(hdr=2Etype, TLV_TYPE_PROBE_REQUEST);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(hdr=2Eoptional);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hdr=
=2Evalue_len, PROBE_REQUEST_LEN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;va=
lue));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(BLEN(&amp;value), PROBE_REQUEST_LEN);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct probe_request out =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(probe_request_read(&amp;value, &=
amp;out));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(in=2Erequest_id =3D=3D out=2Erequest_id);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(in=2Etimestamp =3D=3D out=2Eti=
mestamp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(in=2Eflags, out=2Eflags);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* the scan consumed header and value alike */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLEN(&=
amp;buf), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* The probe request wire format is locked to the field orde=
r of the spec</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * (re=
quest_id, timestamp, flags), big-endian=2E */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_probe_request_wire_format(void **state)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1=
28, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct probe_re=
quest in =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   =2Erequest_id =3D 0x1122334455667788ULL,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        =2Etimestamp =3D 0x0102030405060708ULL,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        =2Eflags =3D 0,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_wr=
ite(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-f=
ormat off */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st uint8_t expected[] =3D {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        0x00, 0x02,                                     /* TLV type=
 2, not optional */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        0x00, 0x14,                                     /* TLV value length=
 =3D 20 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        0=
x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, /* request_id */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        0x01, 0x02, 0x03, 0x04,=
 0x05, 0x06, 0x07, 0x08, /* timestamp */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        0x00, 0x00, 0x00, 0x00,                       =
  /* flags */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* clang-format=
 on */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(BLEN(&amp;buf), sizeof(expected));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), expected, si=
zeof(expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/* Write a probe reply TLV and read it back=2E */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
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
l(120, 100%, 40%);">+/* The wanted TLV may occur only once: a second one re=
jects the message=2E Repeats</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * of an unknown TLV marked optional are skipped like any other=2E=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_find_tlv_rejects_duplicate=
(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =
=3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   const struct probe_request in =3D { =2Erequest_id =3D 1 };</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(128, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(pr=
obe_request_write(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(probe_request_write(&amp;buf, &amp;in));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ct=
rl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    buf =3D alloc_buf_gc(128, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 2=
; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(ctrl_ms=
g_tlv_write_header(&amp;buf, 0x7ff, true, 4));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert_true(buf_write_u32(&amp;buf, 0));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(probe_request_wri=
te(&amp;buf, &amp;in));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(ctrl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &am=
p;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* An empty payload holds no TLV=2E */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+test_find_tlv_empty_payload(void **state)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc=
(16, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct buffer value;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(ct=
rl_msg_find_tlv(&amp;buf, TLV_TYPE_PROBE_REQUEST, &amp;value));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_probe=2Eh b/tests/unit_tests/openvpn/test_probe=2Eh</span><br>=
<span>new file mode 100644</span><br><span>index 0000000=2E=2Ebc51721</span=
><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_probe=2Eh</span><br><span>@@ -0,0 +1,51 @@</span><br><span style=3D"color=
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
 style=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_PROBE_H</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define TEST_PROBE_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void test_probe_request_roundtrip(void **state);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void test_probe_request_wire_format(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_reply_roundtr=
ip(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_probe_reply=
_wire_format(void **state);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_p=
robe_request_forward_compat(void **state);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void test_probe_request_too_short(void **state);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void test_probe_reply_too_short(void **state);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void test_probe_reply_flags_contradict(void **state)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void test_find_tlv_value_truncated(vo=
id **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+void test_find_tlv_trailin=
g_bytes(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_find_t=
lv_skips_optional_after_wanted(void **state);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void test_find_tlv_rejects_duplicate(void **state);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void test_find_tlv_empty_payload(void **state);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br></pre><p>T=
o view, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/1741?us=
p=3Demail">change 1741</a>=2E To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"https://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">=
settings</a>=2E</p><div itemscope itemtype=3D"http://schema=2Eorg/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=2Eorg/Vie=
wAction"><link itemprop=3D"url" href=3D"https://gerrit=2Eopenvpn=2Enet/c/op=
envpn/+/1741?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset=
 </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div st=
yle=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:no=
ne"> Gerrit-Change-Id: I1c8d302ac57c5603d622a7be14be369437388268 </div>
<di=
v style=3D"display:none"> Gerrit-Change-Number: 1741 </div>
<div style=3D"d=
isplay:none"> Gerrit-PatchSet: 25 </div>
<div style=3D"display:none"> Gerri=
t-Owner: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<div style=3D"di=
splay:none"> Gerrit-Reviewer: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&g=
t; </div>
<div style=3D"display:none"> Gerrit-Reviewer: Frank Lichtenheld &=
lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"display:none"> Gerrit-R=
eviewer: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"displa=
y:none"> Gerrit-CC: chugly &lt;charlie=2Evigue@openvpn=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@lists=
=2Esourceforge=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attenti=
on: Ralf Lici &lt;ralf@mandelbit=2Ecom&gt; </div>
<div style=3D"display:non=
e"> Gerrit-Attention: Lev Stipakov &lt;lstipakov@gmail=2Ecom&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;frank@lic=
htenheld=2Ecom&gt; </div>

</body></html>
--NoV8CDyGtYQ=--


--===============1950908201781515229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1950908201781515229==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============1950908201781515229==--

