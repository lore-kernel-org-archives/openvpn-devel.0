Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED542606A33A
	for <openvpn-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YDmJ5uce;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=dodYxiMF;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Kh0yynfR;
	dkim=neutral header.d=openvpn.net header.i=@openvpn.net header.a=rsa-sha256 header.s=google header.b=IfeaJSyq
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Cc:Reply-To:From:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:References:In-Reply-To:To:Date:Sender:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Ozddk9A1rBUmxZK8Q7TfWXm5G0da80XphG+uPTyFM4Y=; b=YDmJ5uceENztz34DlEBDphf0V8
	hbnzYohKTJhDTSqpglXHR3v8OpUnfBNZFAyAB8sPVoJoy7tgJiV3W5hEhnqDiI48yXvfzUg6sxVvX
	wm/Ly3GvQRoLAGAKP70VzTQQjvVa9oXNDyC6ffrvesD8tji/t6ZlbjH5EBbQdoJ1OCv8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <openvpn-devel-bounces@lists.sourceforge.net>)
	id 1xPHr9-000000005KV-0hj0;
	Fri, 06 Nov 2026 11:11:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <gerrit@openvpn.net>) id 1xPHr7-000000005KM-2EbQ
 for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:11:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Reply-To:Subject:References:In-Reply-To:List-Unsubscribe:List-Id:
 Cc:To:Date:From:Sender:Content-ID:Content-Description:Resent-Date:Resent-From
 :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Help:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3MPgXujtwhC3cYEJ7plBiYaH8MmZiTOSqjUTZO7MO/c=; b=dodYxiMF7XS6xA2wq7H/wAR3NL
 ITpr5cEZDDpW8h/vnKzfJBNxy32omBATpQLfAvqZv1jJMqAvsxKjHGJAv5/41avYPhE+HJaLo8bCJ
 qe1hMZgFhIx3e/dI2V3zpzxAXbd3bGZ6vuQhO8eeBBvCsPZEioBIpReiv0TkZ0LPDtD8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Reply-To:
 Subject:References:In-Reply-To:List-Unsubscribe:List-Id:Cc:To:Date:From:
 Sender:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Help:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3MPgXujtwhC3cYEJ7plBiYaH8MmZiTOSqjUTZO7MO/c=; b=Kh0yynfRtH7nXs/90ek40sqrs9
 V5ENaC2Ej1erJ/0ajtm+ZTzXy1aZXZLTXe40zRIablp/9EVFgAmSXaQHS41H3/jKWEzm//MppJJqW
 /SjzWKSXZJDUr7m3OP/Q0vXdkjiurCEVGxuiM/UxedDh8CSBO5QczYn4v5VqLm0dv5V0=;
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPHqz-000000000NF-2wdC for openvpn-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 11:11:37 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso4933425e9.3
 for <openvpn-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 03:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvpn.net; s=google; t=1793963483; x=1794568283; darn=lists.sourceforge.net;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3MPgXujtwhC3cYEJ7plBiYaH8MmZiTOSqjUTZO7MO/c=;
 b=IfeaJSyqdP9vQq33Gn08nypvrT40FmfoCSTwFkaROpaoewjh4XcrARYBHWLfcPYZQO
 5DGPOCck/JZ+LCuUsAFvGI1r3R+OHvzqOz+Oscd3HjrZDYZWEBtBDbJNDIuGSUiL8NCU
 Xvygwa1heVEABVBIK/InmE0075LwbT6vcLuLdtnH5kRnT7gg1pNLUaN7Qjpck/krCWsg
 2e8i2ti1Z81L/3UOX6M47tmYIBhMc6T3Xb6jNsYp/T/KpQuy2KGHD5S3yCAQi6kphEtA
 c2o+BRR4tdVJGPTbKGEBgRYSudXlozHvHK1HgEay/pCfEdMzDirUAiD0C0ZY0atewrSL
 B+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793963483; x=1794568283;
 h=content-type:user-agent:content-disposition
 :content-transfer-encoding:mime-version:message-id:reply-to:subject
 :thread-index:references:in-reply-to:list-unsubscribe:list-id
 :auto-submitted:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=3MPgXujtwhC3cYEJ7plBiYaH8MmZiTOSqjUTZO7MO/c=;
 b=rdEdrH3r/ohNZR5gCFerhSDuYOANwkCwAnvnUjTALO0uaTCss6qJTnZBi7StO6I/wK
 U6d9XXYmPFOPqyEZfyeFy3EJoyIl3zViZrr76VrU23AhVZsgimomlKaRFfIwtVQ5z0Bu
 rvnqhuAlS7IGMbfc3Lg/ntFLbwqHKbS480DqQRBnoX24q/htQqjEZE/4ZS8YZnFmVuEh
 fcQkF3KhcaJXgp1N/5qfwJ34YBaFdws7Z3vwj+tJgfg8mt1MzLVJgalWRkcqQ3KpidBu
 SUjhn4DxvMoZQoK/ssWPMKE70TBcqiTQvUPcVx5NPFaQ6hZVPzcRquDSATBkHeKnZR8M
 GOGg==
X-Gm-Message-State: APuU4Z+wqkfAMqr6rcE63HROdN12vyC0FDGLalRkhobpnoYBu7mtB1LI
 X2GHLKBwv0RDqHeadQgK8pTyZlxTpkaL2s3HPWPZzipRzjBdxmo8TNZ6L9otGD02eqSdbm9uEeg
 uCaoMsW9d7zlpdRsBge41TRS7B+6FVwYxZCW8rrOod2V5QiROVXsRFXT8AQdQsmLDd+kn
X-Gm-Gg: AYBFou1JoZDYjr3icO2mz2AQ9aZZL/hNKvYgSVWVDKw7j9yb3jv9J/E4gxymmM7Qbun
 yeYW1az3a+sB9dFGs2FFTq02u3pd2PgIxjgCuTTXXBLkTU32KHX+Rj7af66TkDifO2j+iYyUGOr
 QmiBjmnHIXbaEtzNm5Qngar5I8TyYPLuMjiM03cbZ3y3pOC2KdD/lJM3U3TLPZWapvOF+TTOJ87
 2BZdqz6yTTtdyAYlPWVx6E1vzIWueFNGQZPoW4vSng9G1a3FweFWrN/AJFGrpgIbXjNlLrQv4+7
 33V6IfmjiQDaYPZsv3geMhYIijknSSDvPmP1r559+cxNq66HMm4PA8kNNMRyuN1iRgwVaWYeTPY
 UNPybL6ES4AxoqOCvFCTlRPOSWyjx9suNLkO4AbeapgufRlGeLORHW8WlstzIHldVnuEwrk4nSV
 z38U47ZcNz061/vwjk5dm9Y3TwFjBr58sQcULkuDwDc3mIx+gSqMSwGKN+kxsYqkNMU5pxtOLa9
 u7uzfzV44StFXkhxhH5eaMqY/jjQMAdUDePSPKiXWXzmnkQ1//8RpzGLFRdZzpwHlZFFoHvlPxj
 1agBRJB6UJTWCAqJPL9cEOZiSuA1Xbva09gPQHFTtBhMo5PXekcZnf/A1HISozdeRTyP72lmYp6
 s1T8ukO3HHm8NpsnqNTmIzx+6mbcpPwYAYcvZYjQX2wmZ8VdQhXhaXkCyo673oNyKe9BBlfhZAI
 bCUzdSepibd95kJw==
X-Received: by 2002:a05:600c:1914:b0:4b4:49d7:bc62 with SMTP id
 5b1f17b1804b1-4b6dff8540bmr33813565e9.26.1793963480948; 
 Fri, 06 Nov 2026 03:11:20 -0800 (PST)
Received: from ip-10-18-1-162.eu-central-1.compute.internal
 (ec2-18-159-0-78.eu-central-1.compute.amazonaws.com. [18.159.0.78])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57317cb8esm134487555e9.13.2026.11.06.03.11.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 03:11:20 -0800 (PST)
X-Google-Original-From: "Arne Schwabe (Code Review)"
 <gerrit@ip-10-18-1-162.eu-central-1.compute.internal>
Date: Fri, 6 Nov 2026 11:11:18 +0000
To: Max Fillinger <max@max-fillinger.net>,
 =?UTF-8?Q?R=C4=83zvan_Cojocaru?= <razvanc@mailbox.org>,
 Frank Lichtenheld <frank@lichtenheld.com>
Auto-Submitted: auto-generated
X-Gerrit-MessageType: newpatchset
X-Gerrit-PatchSet: 12
X-Gerrit-Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9
X-Gerrit-Change-Number: 30
X-Gerrit-Project: openvpn
X-Gerrit-ChangeURL: <https://gerrit.openvpn.net/c/openvpn/+/30?usp=email>
X-Gerrit-Commit: 6082437e8d6fdfa1415ddd74f57c8e4897a78ade
In-Reply-To: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
References: <gerrit.1677175662000.I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9@gerrit.openvpn.net>
Thread-Index: PGdlcnJpdC4xNjc3MTc1NjYyMDAwLkkwYTkyNzRjYWI3ZmVmY2UzYjEzYzA1MDUyZmI5YTA3MmUwYmZhNmI5QGdlcnJpdC5vcGVudnBuLm5ldD4=
Message-ID: <72e29ceb5aaf0e31d84c12e6701ef8c27d779cfc-EmailReplacePatchSet-HTML@gerrit.openvpn.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Gerrit/3.14.5
X-Spam-Score: 0.8 (/)
X-Headers-End: 1xPHqz-000000000NF-2wdC
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Implement initial
 packet reflection protection using bloom filter
X-BeenThere: openvpn-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
From: "Arne Schwabe \(Code Review\) via Openvpn-devel"
 <openvpn-devel@lists.sourceforge.net>
Reply-To: arne-openvpn@rfc2549.org, razvanc@mailbox.org,
 openvpn-devel@lists.sourceforge.net, frank@lichtenheld.com,
 max@max-fillinger.net
Cc: "Arne Schwabe \(Code Review\)" <gerrit@openvpn.net>,
 openvpn-devel <openvpn-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="===============6590316927641074764=="
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	PDS_BAD_THREAD_QP_64,SPF_HELO_PASS,SPF_PASS,T_KAM_HTML_FONT_INVALID,
	WEIRD_PORT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--===============6590316927641074764==
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WAaBP99Hz0w="; charset=UTF-8

--WAaBP99Hz0w=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Arne Schwabe, Frank Lichtenheld, Max =
Fillinger, R=C4=83zvan Cojocaru=2E

Hello Frank Lichtenheld, Max Fillinger,=
 R=C4=83zvan Cojocaru, 

I'd like you to reexamine a change=2E Please visit=


    https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail

to look at=
 the new patch set (#12)=2E

The following approvals got outdated and were =
removed:
Code-Review-1 by R=C4=83zvan Cojocaru


Change subject: Implement =
initial packet reflection protection using bloom filter
=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=
=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E=2E

Implement initial packet reflec=
tion protection using bloom filter

When an OpenVPN server is used/tried to=
 be used in a reflection attack
the protection with the simple --connect-fr=
eq-initial also blocks legitimate
clients from other networks that are not =
attacked by a reflection attack=2E

To allow a server to still reply to the=
se clients, we need to make the counts
rather more detailed and count per s=
ubnet or IP address=2E On the other hand
when we keep all this state, we el=
iminate the advantage of having a stateless
cookie based initial packet han=
dshake=2E

As compromise we use a bloom filter to store the information=2E =
This data
structure is probabilistic and can have false positive and more p=
ackets
being dropped but since it is a constant size and the size of this m=
ap
is small enough for non-embedded systems (tests were done with a 2MB
blo=
om filter), it is a good compromise=2E

The code is split into the bloom fi=
lter implementation and the actual logic
implementing tracking the subnets,=
 so the bloom filter should be relatively
easily be exchangable by another =
data structure=2E

As hash function SIPHASH has been chosen since it was de=
signed for this kind
of application=2E

Change-Id: I0a9274cab7fefce3b13c050=
52fb9a072e0bfa6b9
Signed-off-by: Arne Schwabe <arne@rfc2549=2Eorg>
---
M =
=2Egithub/workflows/build=2Eyaml
M CMakeLists=2Etxt
M Changes=2Emd
M doc/ma=
n-sections/server-options=2Erst
M src/openvpn/Makefile=2Eam
A src/openvpn/b=
loom=2Ec
A src/openvpn/bloom=2Eh
M src/openvpn/mudp=2Ec
M src/openvpn/multi=
=2Ec
M src/openvpn/options=2Ec
M src/openvpn/options=2Eh
M src/openvpn/ovpn=
_dco_linux=2Eh
M src/openvpn/reflect_filter=2Ec
M src/openvpn/reflect_filte=
r=2Eh
M tests/unit_tests/openvpn/Makefile=2Eam
A tests/unit_tests/openvpn/t=
est_reflect=2Ec
A tests/unit_tests/openvpn/test_reflect=2Eh
M tests/unit_te=
sts/openvpn/test_ssl=2Ec
18 files changed, 1,421 insertions(+), 97 deletion=
s(-)


  git pull ssh://gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/3=
0/30/12

diff --git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflow=
s/build=2Eyaml
index 27f08df=2E=2E39b7357 100644
--- a/=2Egithub/workflows/=
build=2Eyaml
+++ b/=2Egithub/workflows/build=2Eyaml
@@ -157,6 +157,9 @@
   =
      env:
           srcdir: "${{ github=2Eworkspace }}/tests/unit_tests/o=
penvpn"
 
+      - name: Run reflect unit test
+        run: =2E/unittests/=
test_reflect=2Eexe
+
   ubuntu:
     strategy:
       fail-fast: false
diff=
 --git a/CMakeLists=2Etxt b/CMakeLists=2Etxt
index 5cf1a30=2E=2Ec7f743a 100=
644
--- a/CMakeLists=2Etxt
+++ b/CMakeLists=2Etxt
@@ -441,6 +441,7 @@
     =
src/openvpn/base64=2Ec
     src/openvpn/base64=2Eh
     src/openvpn/basic=
=2Eh
+    src/openvpn/bloom=2Ec
     src/openvpn/buffer=2Ec
     src/openvp=
n/buffer=2Eh
     src/openvpn/check_file_access=2Ec
@@ -824,9 +825,12 @@
  =
           tests/unit_tests/openvpn/mock_ssl_dependencies=2Ec
             =
tests/unit_tests/openvpn/mock_win32_execve=2Ec
             tests/unit_test=
s/openvpn/test_acc=2Ec
+            tests/unit_tests/openvpn/test_reflect=
=2Ec
+            tests/unit_tests/openvpn/test_reflect=2Eh
             sr=
c/openvpn/acc=2Ec
             src/openvpn/argv=2Ec
             src/openvp=
n/base64=2Ec
+            src/openvpn/bloom=2Ec
             src/openvpn/cr=
ypto_epoch=2Ec
             src/openvpn/crypto_mbedtls=2Ec
             src=
/openvpn/crypto_openssl=2Ec
@@ -838,7 +842,11 @@
             src/openvpn/o=
ptions_util=2Ec
             src/openvpn/otime=2Ec
             src/openvpn=
/packet_id=2Ec
+            src/openvpn/reflect_filter=2Ec
             src=
/openvpn/run_command=2Ec
+            src/openvpn/siphash=2Ec
+            =
src/openvpn/siphash=2Eh
+            src/openvpn/siphash_reference=2Ec
    =
         src/openvpn/ssl_mbedtls=2Ec
             src/openvpn/ssl_ncp=2Ec
 =
            src/openvpn/ssl_openssl=2Ec
diff --git a/Changes=2Emd b/Changes=
=2Emd
index b5ae881=2E=2E41e111e 100644
--- a/Changes=2Emd
+++ b/Changes=2E=
md
@@ -23,6 +23,15 @@
   the characters mentioned above were already escape=
d=2E However, the behavior of
   Mbed TLS is slightly different from OpenSS=
L in that it also escapes "=3D"=2E
 
+* **Bloom filter based reflection pro=
tection**
+
+  To avoid the limitation of ``--connect-freq-initial`` to blo=
ck legitimate
+  clients when an OpenVPN server is tried to be used in a re=
flection attack,
+  the new ``--connect-freq-initial-bloom-limit`` can impo=
se limit on a
+  per-subnet basis=2E See the manual for more details=2E Not=
e: this option
+  requires 2MB of extra memory in the default configuration=
=2E
+
+
 ## Maintainer-visible changes
 
 - The configure-time option `--en=
able-debug` is no longer  available
diff --git a/doc/man-sections/server-op=
tions=2Erst b/doc/man-sections/server-options=2Erst
index 7a09809=2E=2E4eb0=
239 100644
--- a/doc/man-sections/server-options=2Erst
+++ b/doc/man-sectio=
ns/server-options=2Erst
@@ -226,6 +226,77 @@
   will not be counted against=
 the limit=2E The default is to allow
   100 initial connection per 10s=2E
=
 
+
+--connect-freq-initial-bloom-size args
+
+   Valid syntax:
+   ::
+
+ =
     connect-freq-initial-bloom-size size [numhashes]
+
+   Configures the =
size of the bloom filter used for the initial connection
+   packet respons=
es=2E See `--connect-freq-initial-bloom-limit` for a full
+   description o=
f the feature=2E
+
+   Bloom filters are probabilistic by their nature and =
the larger the size
+   of the bloom filter is, the more accurate they are=
=2E This option configures
+   the number of buckets in the bloom filter=2E=
 Each bucket takes up 4 bits=2E
+   E=2Eg=2E the default of  8336608 (8 * 2=
^20) when the option is not set
+   will require 2MB of memory=2E The numha=
shes will control the number of hash
+   functions that are used for the bl=
oom filter=2E The default is 7=2E
+
+--connect-freq-initial-bloom-limit arg=

+
+   Valid syntax:
+   ::
+
+      connect-freq-initial-bloom-limit inet =
netmask limit
+      connect-freq-initial-bloom-limit inet6 netmask limit
+=

+   This option implements a rate limiting function for initial packet lik=
e
+   ``--connect-freq-initial`` but takes the source of the initial packet=
 into
+   account=2E This function shares the reset after a time period and=

+   enabling this function will not disable the overall limit of
+   ``--c=
onnect-freq-initial``=2E
+
+   To avoid resource exhaustion on the OpenVPN =
server side from reflection
+   attacks and also trying to avoid blocking l=
egitimate clients when an
+   attacker tries to use an OpenVPN server, the =
limits are not applied globally
+   but rather a per netmask granularity=2E=
 Each line of this command configures
+   a separate granularity=2E As exam=
ple, the following configuration,
+
+   ::
+
+        connect-freq-initial =
1000 60
+        connect-freq-initial-bloom-limit inet 24 50
+        conne=
ct-freq-initial-bloom-limit inet 8 100
+        connect-freq-initial-bloom-=
limit inet6 56 50
+        connect-freq-initial-bloom-limit inet6 32 100
+
=
+    will limit the number of (unanswered) replies per /24 network to 50
+ =
   packets=2E After 50 packets from the same /24, the server will
+    drop=
 any further packets=2E Similarly, if a /16 network receives more than
+   =
 100 connection requests, the server will drop further packets=2E
+    If t=
he count of all packets exceeds 1000, further packets will be
+    complete=
ly dropped regardless of their origin=2E
+
+   The implementation uses a co=
unting bloom filter to store information of how
+   many packets the server=
 has seen per subnet=2E A bloom filter is a
+   probabilistic data structur=
e can yield false positives=2E In this case, the
+   server will drop packe=
ts even though the limit
+   for that particular subnet is not yet reached=
=2E Since we are using a
+   counting bloom filter, a reply from a client t=
hat triggers a removal of an
+   entry can also lead to a false negative=2E=
 However, this is limited in the
+   sense a reply can at most trigger one =
false negative=2E
+
+   Every limit configured with this option will put mo=
re entries into
+   the bloom filter since per limit (per family), one entr=
y is put into the
+   bloom filter=2E So a large number of entries requires=
 a larger bloom filter
+   to avoid too many false positives=2E
+
+   IPv6 =
mapped IPv4 addresses (::ffff:0:0/96) are treated as IPv4 addresses
+   for=
 these limits=2E
+
 --duplicate-cn
   Allow multiple clients with the same =
common name to concurrently
   connect=2E In the absence of this option, Op=
enVPN will disconnect a client
diff --git a/src/openvpn/Makefile=2Eam b/src=
/openvpn/Makefile=2Eam
index bb31053=2E=2E96c2979 100644
--- a/src/openvpn/=
Makefile=2Eam
+++ b/src/openvpn/Makefile=2Eam
@@ -50,6 +50,7 @@
 	auth_toke=
n=2Ec auth_token=2Eh \
 	base64=2Ec base64=2Eh \
 	basic=2Eh \
+	bloom=2Ec =
bloom=2Eh \
 	buffer=2Ec buffer=2Eh \
 	check_file_access=2Ec check_file_ac=
cess=2Eh \
 	circ_list=2Eh \
diff --git a/src/openvpn/bloom=2Ec b/src/openv=
pn/bloom=2Ec
new file mode 100644
index 0000000=2E=2E6604cb3
--- /dev/null
=
+++ b/src/openvpn/bloom=2Ec
@@ -0,0 +1,250 @@
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
+ *  Copyright (C) 2023-202=
6 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 Arne Schwa=
be <arne@rfc2549=2Eorg>
+ *
+ *  This program is free software; you can red=
istribute it and/or modify
+ *  it under the terms of the GNU General Publi=
c License version 2
+ *  as published by the Free Software Foundation=2E
+ =
*
+ *  This program is distributed in the hope that it will be useful,
+ * =
 but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHA=
NTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General =
Public License for more details=2E
+ *
+ *  You should have received a copy=
 of the GNU General Public License along
+ *  with this program; if not, se=
e <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+/* This file implements a =
specialised counting bloom filter implementation
+ * used in OpenVPN to mit=
igate it being used in reflection attacks=2E The bloom
+ * implementation s=
hould be general enough to be used in other contexts
+ * however */
+
+#ifd=
ef HAVE_CONFIG_H
+#include "config=2Eh"
+#elif defined(_MSC_VER)
+#include =
"config-msvc=2Eh"
+#endif
+
+#include "syshead=2Eh"
+
+#include <stdint=2Eh=
>
+#include <stddef=2Eh>
+#include <stdlib=2Eh>
+#include <string=2Eh>
+#in=
clude <stdbool=2Eh>
+#include "siphash=2Eh"
+#include "crypto=2Eh"
+
+#incl=
ude "bloom=2Eh"
+
+static size_t
+calc_ceil_log2(size_t num)
+{
+    /* Fig=
ure out how many bits we have in our hash by doing
+     * ceil(log2(bf->si=
ze) */
+
+    size_t numbits =3D 0;
+    while (num >>=3D 1)
+    {
+      =
  numbits++;
+    }
+    return numbits;
+}
+
+/**
+ * Calculate number of =
bytes needed for each hash function in the bloom filter
+ *
+ */
+static in=
line size_t
+calculate_num_bytes_hashfun(size_t size)
+{
+    size_t hash_b=
its =3D calc_ceil_log2(size);
+    /* round up to the nearest byte size */
=
+    size_t hash_bytes =3D (hash_bits + 7) / 8;
+    return hash_bytes;
+}
=
+
+/**
+ * A bloom filter uses a number of hashes to perform its functional=
ity=2E
+ *
+ * Instead of using the same number of siphash function we spli=
t the bytes of
+ * the siphash to the different hashes=2E
+ *
+ * We could =
also optimise this further by splitting at the bit level but that
+ * crate=
s a lot of extra code for bit shifting, etc=2E so we waste some bits
+ *
+ =
* @param bf
+ * @param num_hashes
+ * @return
+ */
+size_t
+calculate_num_s=
ip_hash_hashes(struct bloom_filter *bf)
+{
+    size_t hash_bytes =3D calcu=
late_num_bytes_hashfun(bf->size);
+    size_t total_bytes =3D bf->num_hashe=
s * hash_bytes;
+
+    /* Round up to next SIPHASH_HASH_SIZE */
+    size_t=
 num_siphash =3D (total_bytes + BLOOM_HASH_SIZE - 1) / BLOOM_HASH_SIZE;
+
+=
    return num_siphash;
+}
+
+/**
+ * Calculates the number of bytes we nee=
d for storing a bloom filter of size
+ * size=2E */
+static inline size_t
+=
bloom_get_filter_byte_count(size_t size)
+{
+    size_t bits_required =3D s=
ize * BLOOM_FILTER_BITS_COUNT;
+    /* Add 7 round up to the next byte */
+=
    return (bits_required + 7) / 8;
+}
+
+static inline size_t
+bloom_get_f=
ilter_bit_offset(size_t bucket)
+{
+    return (bucket * BLOOM_FILTER_BITS_=
COUNT) % (8 * sizeof(bloom_counter_t));
+}
+
+static inline size_t
+bloom_g=
et_filter_array_index(size_t bucket)
+{
+    return (bucket * BLOOM_FILTER_=
BITS_COUNT) / (8 * sizeof(bloom_counter_t));
+}
+
+static inline bloom_coun=
ter_t
+bloom_get_filter_get_counter(struct bloom_filter *bf, size_t bucket)=

+{
+    static_assert((BLOOM_FILTER_BITS_MASK + 1) =3D=3D (1 << BLOOM_FILT=
ER_BITS_COUNT),
+                  "BLOOM_FILTER_BITMASK and BLOOM_FILTER_B=
IT_COUNT are inconsistent");
+
+    bloom_counter_t counter =3D bf->buckets=
[bloom_get_filter_array_index(bucket)];
+    size_t bitoffset =3D bloom_get=
_filter_bit_offset(bucket);
+
+    return (counter >> bitoffset) & BLOOM_FI=
LTER_BITS_MASK;
+}
+
+static inline void
+bloom_set_filter_counter(struct b=
loom_filter *bf, size_t bucket, bloom_counter_t value)
+{
+    bloom_counte=
r_t data =3D bf->buckets[bloom_get_filter_array_index(bucket)];
+    size_t=
 bitoffset =3D bloom_get_filter_bit_offset(bucket);
+
+    data =3D data & =
~(BLOOM_FILTER_BITS_MASK << bitoffset);
+
+    data =3D data | ((value & BL=
OOM_FILTER_BITS_MASK) << bitoffset);
+
+    bf->buckets[bloom_get_filter_ar=
ray_index(bucket)] =3D data;
+}
+
+/**
+ * Creates a new bloom filter struc=
ture
+ * @param size the number of buckets=2E
+ * @return  the newly create=
d bloom filter structure
+ */
+struct bloom_filter *
+bloom_create(size_t s=
ize, size_t num_hashes, struct gc_arena *gc)
+{
+    size_t bloomfilter_byt=
es =3D bloom_get_filter_byte_count(size);
+    struct bloom_filter *bf =3D =
gc_malloc(sizeof(struct bloom_filter) + bloomfilter_bytes,
+               =
                         false,
+                                        gc=
);
+    bf->size =3D size;
+    bf->num_hashes =3D num_hashes;
+
+    bf->h=
ash_bytes =3D calculate_num_bytes_hashfun(size);
+    bf->num_siphash =3D c=
alculate_num_sip_hash_hashes(bf);
+
+    ALLOC_ARRAY_GC(bf->siphash_keys, s=
truct siphash_key, bf->num_siphash, gc);
+    bloom_clear(bf);
+    return =
bf;
+}
+
+/**
+ * Clear the bloom filter, making it empty again as if it we=
re freshly created
+ * @param bf the bloom structure to clear
+ */
+void
+b=
loom_clear(struct bloom_filter *bf)
+{
+    memset(bf->buckets, 0, bloom_ge=
t_filter_byte_count(bf->size));
+
+    /* We randomise the bloom filter key=
s on every clear of the bloom filter
+     * to avoid scenarios where an at=
tacker might learn specific pattern
+     * that could exploit false positi=
ves in the bloom filter */
+    for (size_t i =3D 0; i < bf->num_siphash; i=
++)
+    {
+        prng_bytes(bf->siphash_keys[i]=2Ekey, SIPHASH_KEY_SIZE)=
;
+    }
+}
+
+static bloom_counter_t
+bloom_add_test(struct bloom_filter *=
bf, const uint8_t *item, size_t len, int inc)
+{
+    uint8_t result[BLOOM_=
HASH_SIZE];
+    size_t j =3D 0;
+    size_t idx =3D 0;
+    bloom_counter_=
t ret =3D bloom_counter_max;
+
+    for (size_t i =3D 0; i < bf->num_hashes=
; i++)
+    {
+        size_t bucket =3D 0;
+        for (size_t k =3D 0; k=
 < bf->hash_bytes; k++)
+        {
+            if (idx =3D=3D 0)
+        =
    {
+                /* We have no longer unused bytes in result, generat=
e the next hash */
+                siphash(item, len, bf->siphash_keys[j++=
]=2Ekey, result, BLOOM_HASH_SIZE);
+            }
+
+            bucket =3D=
 bucket << 8;
+            bucket |=3D result[idx];
+
+            idx =3D =
(idx + 1) % BLOOM_HASH_SIZE;
+        }
+
+        bucket =3D bucket % bf->=
size;
+        bloom_counter_t value =3D bloom_get_filter_get_counter(bf, b=
ucket);
+
+        ret =3D min_bloom_counter(ret, value);
+
+        if (in=
c =3D=3D 1)
+        {
+            value =3D min_bloom_counter(bloom_count=
er_max, value + 1);
+            bloom_set_filter_counter(bf, bucket, value=
);
+        }
+        else if (inc =3D=3D -1 && value !=3D bloom_counter_m=
ax && value > 0)
+        {
+            /* If a bloom has the maximum valu=
e, we cannot decrease it as
+             * do not know how many hashes con=
tributed to it=2E */
+            value--;
+            bloom_set_filter_co=
unter(bf, bucket, value);
+        }
+    }
+    return ret;
+}
+
+bloom_co=
unter_t
+bloom_add(struct bloom_filter *bf, const uint8_t *item, size_t len=
)
+{
+    return bloom_add_test(bf, item, len, 1);
+}
+
+bloom_counter_t
+b=
loom_remove(struct bloom_filter *bf, const uint8_t *item, size_t len)
+{
+ =
   return bloom_add_test(bf, item, len, -1);
+}
+
+bloom_counter_t
+bloom_t=
est(struct bloom_filter *bf, const uint8_t *item, size_t len)
+{
+    retur=
n bloom_add_test(bf, item, len, 0);
+}
diff --git a/src/openvpn/bloom=2Eh b=
/src/openvpn/bloom=2Eh
new file mode 100644
index 0000000=2E=2E3dd41bc
--- =
/dev/null
+++ b/src/openvpn/bloom=2Eh
@@ -0,0 +1,147 @@
+/*
+ *  OpenVPN --=
 An application to securely tunnel IP networks
+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based
+ *             session auth=
entication and key exchange,
+ *             packet encryption, packet auth=
entication, and
+ *             packet compression=2E
+ *
+ *  Copyright (C=
) 2023-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 =
Arne Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This program is free software; y=
ou can redistribute it and/or modify
+ *  it under the terms of the GNU Gen=
eral Public License version 2
+ *  as published by the Free Software Founda=
tion=2E
+ *
+ *  This program is distributed in the hope that it will be us=
eful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+=
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GN=
U General Public License for more details=2E
+ *
+ *  You should have recei=
ved a copy of the GNU General Public License along
+ *  with this program; =
if not, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef BLOOM_H
=
+#define BLOOM_H
+
+#include <stdint=2Eh>
+#include "siphash=2Eh"
+#include=
 "buffer=2Eh"
+
+/* This is the type we use for the buckets=2E This is spli=
t into small buckets
+ * with BLOOM_FILTER_BITS_COUNT size */
+typedef uint=
32_t bloom_counter_t;
+#define BLOOM_FILTER_BITS_COUNT 4
+#define BLOOM_FIL=
TER_BITS_MASK  0x0f
+#define bloom_counter_max       0x0f
+
+/* we want blo=
om_counter_t bits to be a multiple of BLOOM_FILTER_BITS_COUNT to
+ * allow =
our operations to calculate bucket indexes to assume that that a bucket
+ *=
 is always inside a single index bloom_counter_t and never stretches over
+=
 * two adjacent bloom_counter_t */
+static_assert((sizeof(bloom_counter_t) =
* 8) % BLOOM_FILTER_BITS_COUNT =3D=3D 0,
+              "bloom_counter_t mu=
st be a multiple of BLOOM_FILTER_BIT_COUNT");
+
+/* We use 64 bit output fr=
om siphash for the bloom filter */
+#define BLOOM_HASH_SIZE 8
+
+static inl=
ine bloom_counter_t
+min_bloom_counter(bloom_counter_t x, bloom_counter_t y=
)
+{
+    if (x < y)
+    {
+        return x;
+    }
+    else
+    {
+   =
     return y;
+    }
+}
+
+struct siphash_key
+{
+    uint8_t key[SIPHASH_=
KEY_SIZE];
+};
+
+/**
+ * A structure holding a bloom filter=2E A bloom fil=
ter is a probabilistic
+ * data structure used to test whether an element i=
s a member of a set=2E
+ * It may return false positives but never false ne=
gatives=2E
+ *
+ * A bloom filter has a size N of entries, and each entry o=
r bucket is a
+ * counter=2E E=2Eg=2E a bloom filer of size 1024 with entri=
es of 4 bits each
+ * will have 4096 bits or 512 bytes in total size=2E
+ *=

+ * Whenever an entry is added to the bloom filter, n hash function are
+ =
* calculated=2E These map a key -> [0, size of bloom filter]=2E For each of=

+ * hash function use the result as index for the bucket to increase the
+=
 * counter=2E
+ *
+ * For our example of a bloom filter with 1024 entries a=
nd 5 hash functions,
+ * hashing an entry might yield 77,323, 662, 789, and=
 8=2E That would then
+ * increase the buckets (bit counters) at the index =
positions 77, 323,
+ * 662, 789, and 8=2E If an entry is at its maximum (15=
 for 4 bits counters)
+ * it will stop increasing the counter=2E
+ *
+ * To=
 test if an entry is in the bloom filter we do the same hashing and
+ * che=
ck if all the counters positions have at least a value of 1=2E
+ *
+ * Remo=
ving an entry is similar to adding an entry, we decrement the
+ * counter a=
t each bit position=2E But with the caveat that buckets with
+ * already at=
 maximum, the counter is not decremented in order to preserve
+ * the prope=
rty of never false negatives=2E
+ *
+ * Instead of using n separate hash fu=
nctions that map to output log(N) bits,
+ * our implementation uses multipl=
e siphash functions with 64 bit output
+ * and slices them into multiple ha=
sh functions of log(N) bits=2E
+ *
+ * E=2Eg=2E when using a bloom filter o=
f size 1048576 (1024 * 1024),
+ * we need 20 bits output for each of the ha=
sh functions=2E We round up
+ * to bytes, So that are 3 bytes=2E To realize=
 7 hash function we need
+ * then 21 bytes or three siphash function each w=
ith 8 byte (64 bit)
+ */
+struct bloom_filter
+{
+    /** Size (N) of the b=
loom filter in entries
+     * This is also equal to (total bits)/(bits per=
 counter) */
+    size_t size;
+
+    /** Number of bytes used by each hash=
 function=2E
+     *
+     * log2(size * 8) bits rounded up to the next byt=
e
+     *
+     * This is a cached value since log2 is surprisingly slow
+ =
    * (5% of total time of if we do not cache it) */
+    size_t hash_bytes=
;
+
+    /** number of hashes (n) we use to determine the bit positions */
=
+    size_t num_hashes;
+
+    /** number of siphash functions needed to ca=
lculate=2E This can be
+     * calculated from the other members of the str=
uct but we store it
+     * in the struct for fast access */
+    size_t nu=
m_siphash;
+
+    /** keys for the siphash functions */
+    struct siphash=
_key *siphash_keys;
+
+    /** the actual buckets that hold the data */
+  =
  bloom_counter_t buckets[];
+};
+
+
+struct bloom_filter *
+bloom_create(s=
ize_t size, size_t num_hashes, struct gc_arena *gc);
+
+bloom_counter_t
+bl=
oom_test(struct bloom_filter *bf, const uint8_t *item, size_t len);
+
+bloo=
m_counter_t
+bloom_add(struct bloom_filter *bf, const uint8_t *item, size_t=
 len);
+
+bloom_counter_t
+bloom_remove(struct bloom_filter *bf, const uint=
8_t *item, size_t len);
+
+void
+bloom_clear(struct bloom_filter *bf);
+#en=
dif /* ifndef BLOOM_H */
diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mu=
dp=2Ec
index 217b299=2E=2E02bbeff 100644
--- a/src/openvpn/mudp=2Ec
+++ b/s=
rc/openvpn/mudp=2Ec
@@ -34,6 +34,7 @@
 #include "memdbg=2Eh"
 #include "ssl=
_pkt=2Eh"
 #include "sid_hash=2Eh"
+#include "reflect_filter=2Eh"
 
 #ifdef=
 HAVE_SYS_INOTIFY_H
 #include <sys/inotify=2Eh>
@@ -131,7 +132,7 @@
     {
=
         /* Check if we are still below our limit for sending out
         =
 * responses */
-        if (!reflect_filter_rate_limit_check(m->initial_ra=
te_limiter))
+        if (!reflect_filter_check(m->initial_rate_limiter, fr=
om))
         {
             return PRE_DECRYPT_NO_ACTION;
         }
@@ -2=
70,9 +271,10 @@
 
         if (frequency_limit_event_allowed(m->new_connect=
ion_limiter))
         {
+            struct link_socket_actual *from =3D &=
m->top=2Ec2=2Efrom;
             /* a successful three-way handshake only c=
ounts against
              * connect-freq but not against connect-freq-ini=
tial */
-            reflect_filter_rate_limit_decrease(m->initial_rate_lim=
iter);
+            reflect_filter_rate_limit_decrease(m->initial_rate_limi=
ter, &from->dest);
 
             mi =3D multi_create_instance(m, real, soc=
k);
             if (mi)
@@ -286,7 +288,7 @@
                 {
           =
          ASSERT(session_id_defined(&state=2Epeer_session_id));
           =
          mi->context=2Ec2=2Etls_multi->n_sessions++;
-                    =
session_skip_to_pre_start(session, &state, &m->top=2Ec2=2Efrom);
+         =
           session_skip_to_pre_start(session, &state, from);
              =
   }
                 multi_hash_sid_add(m, &state=2Epeer_session_id, mi);
=
             }
diff --git a/src/openvpn/multi=2Ec b/src/openvpn/multi=2Ec
i=
ndex 3f514d6=2E=2E7c0f35a 100644
--- a/src/openvpn/multi=2Ec
+++ b/src/open=
vpn/multi=2Ec
@@ -331,9 +331,12 @@
      * Limit frequency of incoming conn=
ections to control
      * DoS=2E
      */
-    m->new_connection_limiter =
=3D frequency_limit_init(t->options=2Ecf_max, t->options=2Ecf_per);
-    m-=
>initial_rate_limiter =3D
-        initial_rate_limit_init(t->options=2Ecf_=
initial_max, t->options=2Ecf_initial_per);
+    m->new_connection_limiter =
=3D frequency_limit_init(t->options=2Ecf_max,
+                            =
                         t->options=2Ecf_per);
+    m->initial_rate_limiter=
 =3D initial_rate_limit_init(t->options=2Ecf_initial_max,
+                =
                                      t->options=2Ecf_initial_per,
+       =
                                               &t->options=2Einitial_cf_blo=
om_config);
+
 
     /*
      * Allocate broadcast/multicast buffer list
di=
ff --git a/src/openvpn/options=2Ec b/src/openvpn/options=2Ec
index 4dfc719=
=2E=2E1b3f17d 100644
--- a/src/openvpn/options=2Ec
+++ b/src/openvpn/option=
s=2Ec
@@ -2621,6 +2621,23 @@
 }
 
 static void
+check_filter_tier_over_glob=
al_limit(struct filter_tier *ft, int limit,
+                              =
      const char *family)
+{
+    while (ft)
+    {
+        if (ft->limit =
> limit)
+        {
+            msg(M_WARN, "Note: --connect-freq-initial-=
bloom-limit %s %d %d "
+                        "has a larger limit than co=
nnect-freq-initial "
+                        "limit (%d)=2E",
+           =
     family, ft->netmask, ft->limit, limit);
+        }
+        ft =3D ft-=
>next;
+    }
+}
+
+static void
 options_postprocess_verify(const struct op=
tions *o)
 {
     if (o->connection_list)
@@ -2655,6 +2672,18 @@
          =
               "Ignoring these options=2E");
         }
     }
+
+    if ((=
bool)(o->initial_cf_bloom_config=2Einet_tiers)
+            + (bool)(o->ini=
tial_cf_bloom_config=2Einet6_tiers)
+        =3D=3D 1)
+    {
+        msg(=
M_FATAL, "connect-freq-initial-bloom-limit must be provided for "
+        =
             "both inet and inet6");
+    }
+    check_filter_tier_over_glo=
bal_limit(o->initial_cf_bloom_config=2Einet_tiers,
+                       =
                 o->cf_initial_max, "inet");
+    check_filter_tier_over_gl=
obal_limit(o->initial_cf_bloom_config=2Einet6_tiers,
+                     =
                   o->cf_initial_max, "inet6");
 }
 
 static void
@@ -5985,=
6 +6014,73 @@
         options->cf_initial_max =3D cf_max;
         options=
->cf_initial_per =3D cf_per;
     }
+    else if (streq(p[0], "connect-freq=
-initial-bloom-size") && p[1] && !p[3])
+    {
+        VERIFY_PERMISSION(O=
PT_P_GENERAL);
+
+        int cf_bloom_size =3D positive_atoi(p[1], msgleve=
l);
+
+        if (cf_bloom_size =3D=3D 0)
+        {
+            msg(msgl=
evel, "--connect-freq-initial-bloom-size size must be > 0");
+            g=
oto err;
+        }
+        options->initial_cf_bloom_config=2Esize =3D cf=
_bloom_size;
+        if (p[2])
+        {
+            int num_hash =3D po=
sitive_atoi(p[2], msglevel);
+            if (num_hash =3D=3D 0)
+         =
   {
+                msg(msglevel, "--connect-freq-initial-bloom-size numb=
er of hash "
+                              "functions must be > 0");
+    =
            goto err;
+            }
+            options->initial_cf_bloom=
_config=2Enum_hashes =3D num_hash;
+        }
+    }
+    else if (streq(p[=
0], "connect-freq-initial-bloom-limit") && p[1] && p[2]
+             && p[=
3] && !p[4])
+    {
+        int netmask =3D atoi(p[2]);
+        int limit=
 =3D atoi(p[3]);
+
+        if (limit <=3D 0)
+        {
+            msg(m=
sglevel, "Limit parameter to %s must be > 0", p[0]);
+            goto err;=

+        }
+
+        if (streq(p[1], "inet"))
+        {
+            if =
(netmask < 0 || netmask > 32)
+            {
+                msg(msglevel,=
 "Netmask parameter (%s) for IPv4 for %s must be "
+                       =
       "between 0 and 32",
+                    p[2], p[0]);
+             =
   goto err;
+            }
+            reflect_add_filter_tier(&options->=
initial_cf_bloom_config,
+                                    &options->gc,=
 false, netmask, limit);
+        }
+        else if (streq(p[1], "inet6"))=

+        {
+            if (netmask < 0 || netmask > 128)
+            {
+=
                msg(msglevel, "Netmask parameter (%s) for IPv6 for %s must =
be "
+                              "between 0 and 128",
+                 =
   p[2], p[0]);
+                goto err;
+            }
+            refl=
ect_add_filter_tier(&options->initial_cf_bloom_config,
+                   =
                 &options->gc, true, netmask, limit);
+        }
+        e=
lse
+        {
+            msg(msglevel, "Unknown parameter %s for %s=2E M=
ust be inet or inet6",
+                p[1], p[0]);
+            goto err;=

+        }
+    }
     else if (streq(p[0], "max-clients") && p[1] && !p[2=
])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openv=
pn/options=2Eh b/src/openvpn/options=2Eh
index 73c1354=2E=2Ea1b1983 100644
=
--- a/src/openvpn/options=2Eh
+++ b/src/openvpn/options=2Eh
@@ -42,6 +42,7 =
@@
 #include "clinat=2Eh"
 #include "crypto_backend=2Eh"
 #include "dns=2Eh=
"
+#include "reflect_filter=2Eh"
 
 
 /*
@@ -533,6 +534,8 @@
     int cf_in=
itial_max;
     int cf_initial_per;
 
+    struct bloom_filter_conf initial=
_cf_bloom_config;
+
     uint32_t max_clients;
     int max_routes_per_clie=
nt;
     int stale_routes_check_interval;
diff --git a/src/openvpn/ovpn_dco=
_linux=2Eh b/src/openvpn/ovpn_dco_linux=2Eh
index b3c9ff0=2E=2E7366177 1006=
44
--- a/src/openvpn/ovpn_dco_linux=2Eh
+++ b/src/openvpn/ovpn_dco_linux=2E=
h
@@ -6,105 +6,113 @@
 #ifndef _UAPI_LINUX_OVPN_H
 #define _UAPI_LINUX_OVPN=
_H
 
-#define OVPN_FAMILY_NAME	"ovpn"
-#define OVPN_FAMILY_VERSION	1
+#defi=
ne OVPN_FAMILY_NAME    "ovpn"
+#define OVPN_FAMILY_VERSION 1
 
-#define OVP=
N_NONCE_TAIL_SIZE	8
+#define OVPN_NONCE_TAIL_SIZE 8
 
-enum ovpn_cipher_alg=
 {
-	OVPN_CIPHER_ALG_NONE,
-	OVPN_CIPHER_ALG_AES_GCM,
-	OVPN_CIPHER_ALG_CHA=
CHA20_POLY1305,
+enum ovpn_cipher_alg
+{
+    OVPN_CIPHER_ALG_NONE,
+    OV=
PN_CIPHER_ALG_AES_GCM,
+    OVPN_CIPHER_ALG_CHACHA20_POLY1305,
 };
 
-enum =
ovpn_del_peer_reason {
-	OVPN_DEL_PEER_REASON_TEARDOWN,
-	OVPN_DEL_PEER_REA=
SON_USERSPACE,
-	OVPN_DEL_PEER_REASON_EXPIRED,
-	OVPN_DEL_PEER_REASON_TRANS=
PORT_ERROR,
-	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
+enum ovpn_del_pee=
r_reason
+{
+    OVPN_DEL_PEER_REASON_TEARDOWN,
+    OVPN_DEL_PEER_REASON_U=
SERSPACE,
+    OVPN_DEL_PEER_REASON_EXPIRED,
+    OVPN_DEL_PEER_REASON_TRAN=
SPORT_ERROR,
+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
 };
 
-enum ov=
pn_key_slot {
-	OVPN_KEY_SLOT_PRIMARY,
-	OVPN_KEY_SLOT_SECONDARY,
+enum ovp=
n_key_slot
+{
+    OVPN_KEY_SLOT_PRIMARY,
+    OVPN_KEY_SLOT_SECONDARY,
 };=

 
-enum {
-	OVPN_A_PEER_ID =3D 1,
-	OVPN_A_PEER_REMOTE_IPV4,
-	OVPN_A_PEER=
_REMOTE_IPV6,
-	OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
-	OVPN_A_PEER_REMOTE_PORT=
,
-	OVPN_A_PEER_SOCKET,
-	OVPN_A_PEER_SOCKET_NETNSID,
-	OVPN_A_PEER_VPN_IPV=
4,
-	OVPN_A_PEER_VPN_IPV6,
-	OVPN_A_PEER_LOCAL_IPV4,
-	OVPN_A_PEER_LOCAL_IP=
V6,
-	OVPN_A_PEER_LOCAL_PORT,
-	OVPN_A_PEER_KEEPALIVE_INTERVAL,
-	OVPN_A_PE=
ER_KEEPALIVE_TIMEOUT,
-	OVPN_A_PEER_DEL_REASON,
-	OVPN_A_PEER_VPN_RX_BYTES,=

-	OVPN_A_PEER_VPN_TX_BYTES,
-	OVPN_A_PEER_VPN_RX_PACKETS,
-	OVPN_A_PEER_VP=
N_TX_PACKETS,
-	OVPN_A_PEER_LINK_RX_BYTES,
-	OVPN_A_PEER_LINK_TX_BYTES,
-	O=
VPN_A_PEER_LINK_RX_PACKETS,
-	OVPN_A_PEER_LINK_TX_PACKETS,
+enum
+{
+    OV=
PN_A_PEER_ID =3D 1,
+    OVPN_A_PEER_REMOTE_IPV4,
+    OVPN_A_PEER_REMOTE_I=
PV6,
+    OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,
+    OVPN_A_PEER_REMOTE_PORT,
+=
    OVPN_A_PEER_SOCKET,
+    OVPN_A_PEER_SOCKET_NETNSID,
+    OVPN_A_PEER_V=
PN_IPV4,
+    OVPN_A_PEER_VPN_IPV6,
+    OVPN_A_PEER_LOCAL_IPV4,
+    OVPN_=
A_PEER_LOCAL_IPV6,
+    OVPN_A_PEER_LOCAL_PORT,
+    OVPN_A_PEER_KEEPALIVE_=
INTERVAL,
+    OVPN_A_PEER_KEEPALIVE_TIMEOUT,
+    OVPN_A_PEER_DEL_REASON,
=
+    OVPN_A_PEER_VPN_RX_BYTES,
+    OVPN_A_PEER_VPN_TX_BYTES,
+    OVPN_A_P=
EER_VPN_RX_PACKETS,
+    OVPN_A_PEER_VPN_TX_PACKETS,
+    OVPN_A_PEER_LINK_=
RX_BYTES,
+    OVPN_A_PEER_LINK_TX_BYTES,
+    OVPN_A_PEER_LINK_RX_PACKETS,=

+    OVPN_A_PEER_LINK_TX_PACKETS,
 
-	__OVPN_A_PEER_MAX,
-	OVPN_A_PEER_MAX=
 =3D (__OVPN_A_PEER_MAX - 1)
+    __OVPN_A_PEER_MAX,
+    OVPN_A_PEER_MAX =
=3D (__OVPN_A_PEER_MAX - 1)
 };
 
-enum {
-	OVPN_A_KEYCONF_PEER_ID =3D 1,
-=
	OVPN_A_KEYCONF_SLOT,
-	OVPN_A_KEYCONF_KEY_ID,
-	OVPN_A_KEYCONF_CIPHER_ALG,=

-	OVPN_A_KEYCONF_ENCRYPT_DIR,
-	OVPN_A_KEYCONF_DECRYPT_DIR,
+enum
+{
+    =
OVPN_A_KEYCONF_PEER_ID =3D 1,
+    OVPN_A_KEYCONF_SLOT,
+    OVPN_A_KEYCONF=
_KEY_ID,
+    OVPN_A_KEYCONF_CIPHER_ALG,
+    OVPN_A_KEYCONF_ENCRYPT_DIR,
+=
    OVPN_A_KEYCONF_DECRYPT_DIR,
 
-	__OVPN_A_KEYCONF_MAX,
-	OVPN_A_KEYCONF_=
MAX =3D (__OVPN_A_KEYCONF_MAX - 1)
+    __OVPN_A_KEYCONF_MAX,
+    OVPN_A_K=
EYCONF_MAX =3D (__OVPN_A_KEYCONF_MAX - 1)
 };
 
-enum {
-	OVPN_A_KEYDIR_CIP=
HER_KEY =3D 1,
-	OVPN_A_KEYDIR_NONCE_TAIL,
+enum
+{
+    OVPN_A_KEYDIR_CIPH=
ER_KEY =3D 1,
+    OVPN_A_KEYDIR_NONCE_TAIL,
 
-	__OVPN_A_KEYDIR_MAX,
-	OVP=
N_A_KEYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)
+    __OVPN_A_KEYDIR_MAX,
+   =
 OVPN_A_KEYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)
 };
 
-enum {
-	OVPN_A_IFI=
NDEX =3D 1,
-	OVPN_A_PEER,
-	OVPN_A_KEYCONF,
+enum
+{
+    OVPN_A_IFINDEX =
=3D 1,
+    OVPN_A_PEER,
+    OVPN_A_KEYCONF,
 
-	__OVPN_A_MAX,
-	OVPN_A_MA=
X =3D (__OVPN_A_MAX - 1)
+    __OVPN_A_MAX,
+    OVPN_A_MAX =3D (__OVPN_A_M=
AX - 1)
 };
 
-enum {
-	OVPN_CMD_PEER_NEW =3D 1,
-	OVPN_CMD_PEER_SET,
-	OVP=
N_CMD_PEER_GET,
-	OVPN_CMD_PEER_DEL,
-	OVPN_CMD_PEER_DEL_NTF,
-	OVPN_CMD_KE=
Y_NEW,
-	OVPN_CMD_KEY_GET,
-	OVPN_CMD_KEY_SWAP,
-	OVPN_CMD_KEY_SWAP_NTF,
-	=
OVPN_CMD_KEY_DEL,
-	OVPN_CMD_PEER_FLOAT_NTF,
+enum
+{
+    OVPN_CMD_PEER_NE=
W =3D 1,
+    OVPN_CMD_PEER_SET,
+    OVPN_CMD_PEER_GET,
+    OVPN_CMD_PEER=
_DEL,
+    OVPN_CMD_PEER_DEL_NTF,
+    OVPN_CMD_KEY_NEW,
+    OVPN_CMD_KEY_=
GET,
+    OVPN_CMD_KEY_SWAP,
+    OVPN_CMD_KEY_SWAP_NTF,
+    OVPN_CMD_KEY_=
DEL,
+    OVPN_CMD_PEER_FLOAT_NTF,
 
-	__OVPN_CMD_MAX,
-	OVPN_CMD_MAX =3D (=
__OVPN_CMD_MAX - 1)
+    __OVPN_CMD_MAX,
+    OVPN_CMD_MAX =3D (__OVPN_CMD_=
MAX - 1)
 };
 
-#define OVPN_MCGRP_PEERS	"peers"
+#define OVPN_MCGRP_PEERS =
"peers"
 
 #endif /* _UAPI_LINUX_OVPN_H */
diff --git a/src/openvpn/reflect=
_filter=2Ec b/src/openvpn/reflect_filter=2Ec
index e5226e4=2E=2E0ae54e1 100=
644
--- a/src/openvpn/reflect_filter=2Ec
+++ b/src/openvpn/reflect_filter=
=2Ec
@@ -5,7 +5,8 @@
  *             packet encryption, packet authenticati=
on, and
  *             packet compression=2E
  *
- *  Copyright (C) 2022-2=
026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 OpenVPN =
Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 Arne Schwabe <arne@r=
fc2549=2Eorg>
  *
  *  This program is free software; you can redistribute =
it and/or modify
  *  it under the terms of the GNU General Public License =
version 2
@@ -37,8 +38,7 @@
 #include "crypto=2Eh"
 #include "reflect_filte=
r=2Eh"
 
-
-bool
+static bool
 reflect_filter_rate_limit_check(struct initi=
al_packet_rate_limit *irl)
 {
     if (now > irl->last_period_reset + irl->=
period_length)
@@ -73,34 +73,367 @@
     return !over_limit;
 }
 
-void
-re=
flect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl)
+st=
atic void
+reset_filter_tier(struct initial_packet_rate_limit *irl,
+      =
            struct filter_tier *tier, const char *prefix)
 {
+    for (; ti=
er !=3D NULL; tier =3D tier->next)
+    {
+        if (tier->dropped > 0)
+=
        {
+            msg(D_TLS_DEBUG_LOW, "Dropped %zu initial handshake =
packets due to "
+                                 "--connect-freq-initial-=
bloom-limit %s %d %d",
+                tier->dropped, prefix, tier->netmas=
k, tier->limit);
+            tier->dropped =3D 0;
+        }
+    }
+}
+
+=
static void
+bloom_filter_check_reset(struct initial_packet_rate_limit *irl=
)
+{
+    if (now > irl->last_period_reset + irl->period_length)
+    {
+  =
      reset_filter_tier(irl, irl->bloom_conf=2Einet_tiers, "inet");
+      =
  reset_filter_tier(irl, irl->bloom_conf=2Einet6_tiers, "inet6");
+
+      =
  bloom_clear(irl->bf);
+    }
+}
+
+
+/**
+ * structure used as lookup key=
 for the bloom structure=2E We used the
+ * netmask as part of the structur=
e to avoid the look for the first
+ * IP of a subnet and the subnet to be s=
ame key=2E
+ */
+struct bloom_filter_key
+{
+    union
+    {
+        stru=
ct in_addr in;
+        struct in6_addr in6;
+    };
+    int netmask;
+   =
 /* we keep the count in the key instead of in the bloom filter table as
+ =
    * can then keep the counter in the bloom filter itself small
+     * an=
d bloom filter usage is the same for 20000 request from the same IP
+     *=
 (20k entries with different count but same IP) and from 20000 random ips
+=
     * (20k entries with count 1 but different IP) */
+    int count;
+};
+=

+static inline struct bloom_filter_key
+filter_mask_inet6(const struct ope=
nvpn_sockaddr *addr, int netmask)
+{
+    struct bloom_filter_key ret =3D {=
 0 };
+    ret=2Ein6 =3D addr->addr=2Ein6=2Esin6_addr;
+
+    int bits_to_c=
lear =3D 128 - netmask;
+    int bytes_to_clear =3D bits_to_clear / 8;
+   =
 bits_to_clear =3D bits_to_clear % 8;
+
+    memset(&ret=2Ein6=2Es6_addr[15=
 - bytes_to_clear], 0x00, bytes_to_clear);
+
+    ret=2Ein6=2Es6_addr[15 - =
bytes_to_clear - 1] &=3D (0xff << bits_to_clear);
+
+    ret=2Enetmask =3D =
netmask;
+
+    return ret;
+}
+
+static inline struct bloom_filter_key
+fi=
lter_mask_inet(const struct openvpn_sockaddr *addr, int netmask)
+{
+    st=
ruct bloom_filter_key ret =3D { 0 };
+    ret=2Ein =3D addr->addr=2Ein4=2Es=
in_addr;
+    ret=2Ein=2Es_addr &=3D htonl(0xffffffff << (32 - netmask));
+=
    ret=2Enetmask =3D netmask;
+    return ret;
+}
+
+/* We use one functio=
n and an action argument to avoid repeating
+ * the code to iterate to the =
tiers and the creating the lookup
+ * keys */
+enum bloom_filter_action
+{
=
+    REFLECT_CHECK,
+    REFLECT_INCREASE,
+    REFLECT_DECREASE,
+};
+
+st=
atic int
+reflect_lookup_bf_key(struct bloom_filter *bf, struct bloom_filte=
r_key *key, int limit)
+{
+    /* we do a lookup for 1,2,3, and 4 and the l=
imit first
+     * and after that do regular binary search=2E This is meant=
 to optimise
+     * the common case where just a small number of requests =
are coming from
+     * each IP */
+    key->count =3D limit;
+    if (bloo=
m_test(bf, (const uint8_t *)key, sizeof(struct bloom_filter_key)) > 0)
+   =
 {
+        return limit;
+    }
+
+    key->count =3D 4;
+    if (bloom_te=
st(bf, (const uint8_t *)key, sizeof(struct bloom_filter_key)) =3D=3D 0)
+  =
  {
+        /* The value for 4 has not been found, so the real value might=
 be 1, 2, or 3=2E */
+        for (int i =3D 3; i > 0; i--)
+        {
+   =
         key->count =3D i;
+            if (bloom_test(bf, (const uint8_t *=
)key, sizeof(struct bloom_filter_key)) > 0)
+            {
+               =
 return i;
+            }
+        }
+
+        /* 4 was no in the map and =
1-3 are also not there, so assume the key is not in the map */
+        ret=
urn 0;
+    }
+
+    int low =3D 3;
+    int high =3D limit;
+
+    while (=
low < high)
+    {
+        key->count =3D (high + low + 1) / 2;
+        b=
loom_counter_t count =3D bloom_test(bf, (const uint8_t *)key, sizeof(struct=
 bloom_filter_key));
+        if (count > 0)
+        {
+            low =
=3D key->count;
+        }
+        else
+        {
+            high =3D k=
ey->count - 1;
+        }
+    }
+
+    return low;
+}
+
+/**
+ * Convert a=
 mapped IPv6 mapped IPv4 address (::ffff:0:0/96) to an
+ * equivalent IPv4 =
adress=2E
+ *
+ * @note: This function only converts the IP itself and igno=
res other
+ * parts of the \c from structure like port or protocol=2E
+ */
=
+static struct openvpn_sockaddr
+convert_mapped_inet_sockaddr(const struct =
openvpn_sockaddr *from)
+{
+    struct openvpn_sockaddr from_mapped =3D { 0=
 };
+    /* we ignore the fields like port that the key in the bloom filter=

+     * ignores too=2E This makes this function non-generic */
+
+    from=
_mapped=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+
+    memcpy(&from_mapped=
=2Eaddr=2Ein4=2Esin_addr=2Es_addr,
+           &from->addr=2Ein6=2Esin6_add=
r=2Es6_addr[12],
+           sizeof(from_mapped=2Eaddr=2Ein4=2Esin_addr=2Es=
_addr));
+
+    return from_mapped;
+}
+
+static bool
+bloom_filter_action(=
struct initial_packet_rate_limit *irl,
+                    const struct op=
envpn_sockaddr *from,
+                    enum bloom_filter_action action)=

+{
+    bool found =3D false;
+    struct filter_tier *tier =3D NULL;
+
+ =
   struct openvpn_sockaddr from_mapped;
+
+    if (from->addr=2Esa=2Esa_fam=
ily =3D=3D AF_INET6
+        && IN6_IS_ADDR_V4MAPPED(&from->addr=2Ein6=2Esi=
n6_addr))
+    {
+        from_mapped =3D convert_mapped_inet_sockaddr(from=
);
+        from =3D &from_mapped;
+    }
+
+    if (from->addr=2Esa=2Esa_f=
amily =3D=3D AF_INET)
+    {
+        tier =3D irl->bloom_conf=2Einet_tiers=
;
+    }
+    else if (from->addr=2Esa=2Esa_family =3D=3D AF_INET6)
+    {
=
+        tier =3D irl->bloom_conf=2Einet6_tiers;
+    }
+
+    while (tier)=

+    {
+        struct filter_tier *next_tier =3D tier->next;
+        str=
uct bloom_filter_key key;
+
+        if (from->addr=2Esa=2Esa_family =3D=3D=
 AF_INET6)
+        {
+            key =3D filter_mask_inet6(from, tier->ne=
tmask);
+        }
+        else
+        {
+            key =3D filter_mas=
k_inet(from, tier->netmask);
+        }
+
+        /* fetch the current cou=
nt of the key in the bloom filter */
+        int result =3D reflect_lookup=
_bf_key(irl->bf, &key, tier->limit);
+
+        switch (action)
+        {
=
+            case REFLECT_CHECK:
+                if (result >=3D tier->lim=
it)
+                {
+                    found =3D true;
+              =
      tier->dropped++;
+                    if (tier->dropped =3D=3D 1)
+  =
                  {
+                        msg(M_WARN, "Note: --connect-f=
req-initial-bloom-limit "
+                                    "limit for n=
etmask /%d exceeded=2E Expect additional "
+                               =
     "initial packet drops for the next %d seconds",
+                     =
       tier->netmask,
+                            (int)(irl->last_period_r=
eset + irl->period_length - now));
+                    }
+                =
}
+                break;
+
+            case REFLECT_INCREASE:
+          =
      ASSERT(result < tier->limit);
+                key=2Ecount =3D result=
 + 1;
+                bloom_add(irl->bf, (const uint8_t *)&key, sizeof(key=
));
+                break;
+
+            case REFLECT_DECREASE:
+        =
        key=2Ecount =3D result - 1;
+                bloom_remove(irl->bf, =
(const uint8_t *)&key, sizeof(key));
+                break;
+        }
+
+=
        tier =3D next_tier;
+    }
+    if (!found && action =3D=3D REFLECT=
_CHECK)
+    {
+        /* We only want to increase the counters if the IP =
is not already
+         * in the set=2E */
+        bloom_filter_action(ir=
l, from, REFLECT_INCREASE);
+    }
+    return found;
+}
+
+static bool
+bl=
oom_filter_check(struct initial_packet_rate_limit *irl,
+                  =
 const struct openvpn_sockaddr *from)
+{
+    if (now > irl->last_period_re=
set + irl->period_length)
+    {
+        bloom_filter_check_reset(irl);
+ =
   }
+
+    return bloom_filter_action(irl, from, REFLECT_CHECK);
+}
+
+
+b=
ool
+reflect_filter_check(struct initial_packet_rate_limit *irl,
+         =
            const struct openvpn_sockaddr *from)
+{
+    /* We are doing th=
e bloom filter check first so packets that are already
+     * rejected by =
the bloom filter do not count against the limit of the
+     * simple rate =
limiter */
+    if (irl->bf && bloom_filter_check(irl, from))
+    {
+     =
   return false;
+    }
+
+    if (!reflect_filter_rate_limit_check(irl))
+=
    {
+        return false;
+    }
+
+    return true;
+}
+
+
+void
+refle=
ct_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl, struct=
 openvpn_sockaddr *from)
+{
+    if (irl->bf && bloom_filter_action(irl, fr=
om, REFLECT_CHECK))
+    {
+        /* Only remove if it is actually presen=
t=2E This might be a packet
+         * coming from an early period or be r=
elayed */
+        bloom_filter_action(irl, from, REFLECT_DECREASE);
+    }=

+
     if (irl->curr_period_counter > 0)
     {
         irl->curr_period_=
counter--;
     }
 }
 
+void
+reflect_add_filter_tier(struct bloom_filter_c=
onf *bfconf, struct gc_arena *gc,
+                        bool ipv6, int n=
etmask, int limit)
+{
+    struct filter_tier *ftnew =3D gc_malloc(sizeof(s=
truct filter_tier), true, gc);
+
+    ftnew->netmask =3D netmask;
+    ftne=
w->limit =3D limit;
+
+    if (ipv6)
+    {
+        ftnew->next =3D bfconf=
->inet6_tiers;
+        bfconf->inet6_tiers =3D ftnew;
+    }
+    else
+  =
  {
+        ftnew->next =3D bfconf->inet_tiers;
+        bfconf->inet_tier=
s =3D ftnew;
+    }
+}
+
+void
+init_bloom_filter(struct initial_packet_rat=
e_limit *irl)
+{
+    if (!irl->bloom_conf=2Esize)
+    {
+        /* the d=
efault allocates 2MB for bloom filter entries */
+        irl->bloom_conf=
=2Esize =3D 1024ul * 1024 * 8;
+    }
+    if (!irl->bloom_conf=2Enum_hashe=
s)
+    {
+        irl->bloom_conf=2Enum_hashes =3D 7;
+    }
+
+    irl->b=
f =3D bloom_create(irl->bloom_conf=2Esize, irl->bloom_conf=2Enum_hashes,
+ =
                          &irl->gc);
+    bloom_clear(irl->bf);
+}
 
 struc=
t initial_packet_rate_limit *
-initial_rate_limit_init(int max_per_period, =
int period_length)
+initial_rate_limit_init(int max_per_period, int period_=
length,
+                        struct bloom_filter_conf *bconf)
 {
-    s=
truct initial_packet_rate_limit *irl;
+    struct initial_packet_rate_limit=
 *irl =3D NULL;
+    ALLOC_OBJ_CLEAR(irl, struct initial_packet_rate_limit)=
;
 
-
-    ALLOC_OBJ(irl, struct initial_packet_rate_limit);
+    irl->gc =
=3D gc_new();
 
     irl->max_per_period =3D max_per_period;
     irl->peri=
od_length =3D period_length;
     irl->curr_period_counter =3D 0;
     irl-=
>last_period_reset =3D 0;
 
+    if (bconf->inet6_tiers || bconf->inet_tier=
s)
+    {
+        irl->bloom_conf =3D *bconf;
+        init_bloom_filter(i=
rl);
+    }
+
     return irl;
 }
 
 void
 initial_rate_limit_free(struct i=
nitial_packet_rate_limit *irl)
 {
+    gc_free(&irl->gc);
     free(irl);
 =
}
diff --git a/src/openvpn/reflect_filter=2Eh b/src/openvpn/reflect_filter=
=2Eh
index 84915e8c6=2E=2Ebe2b926 100644
--- a/src/openvpn/reflect_filter=
=2Eh
+++ b/src/openvpn/reflect_filter=2Eh
@@ -23,6 +23,30 @@
 #define REFLE=
CT_FILTER_H
 
 #include <limits=2Eh>
+#include "socket=2Eh"
+#include "bloo=
m=2Eh"
+
+struct filter_tier
+{
+    struct filter_tier *next;
+
+    int l=
imit;
+    int netmask;
+
+    /** The number of packets we dropped since w=
e went over this limit */
+    size_t dropped;
+};
+
+struct bloom_filter_c=
onf
+{
+    struct filter_tier *inet_tiers;
+    struct filter_tier *inet6_=
tiers;
+
+    /* Configuration of the bloom filter */
+    size_t num_hashe=
s;
+    size_t size;
+};
+
 
 /** struct that handles all the rate limiting=
 logic for initial
  * responses */
@@ -35,7 +59,7 @@
     int period_lengt=
h;
 
     /** Number of packets in the current period=2E We use int64_t her=
e
-     * to avoid any potiential issues with overflow */
+     * to avoid =
any potential issues with overflow */
     int64_t curr_period_counter;
 
 =
    /* Last time we reset our timer */
@@ -44,29 +68,57 @@
     /* we want =
to warn once per period that packets are being started to
      * be droppe=
d */
     bool warning_displayed;
+
+    struct bloom_filter_conf bloom_con=
f;
+    struct bloom_filter *bf;
+
+    /* gc_arena used for the various al=
locations by this struct */
+    struct gc_arena gc;
 };
 
+/**
+ * Adds a =
bloom filter tier to the bloom filter config=2E
+ */
+void
+reflect_add_fil=
ter_tier(struct bloom_filter_conf *bfconf, struct gc_arena *gc,
+          =
              bool ipv6, int netmask, int limit);
 
 /**
  * checks if the =
connection is still allowed to connect under the rate
  * limit=2E This als=
o increases the internal counter at the same time
  */
-bool reflect_filter=
_rate_limit_check(struct initial_packet_rate_limit *irl);
+bool
+reflect_fi=
lter_check(struct initial_packet_rate_limit *irl,
+                     con=
st struct openvpn_sockaddr *from);
+
 
 /**
  * decreases the counter of in=
itial packets seen, so connections that
  * successfully completed the thre=
e-way handshake do not count against
  * the counter of initial connection =
attempts
  */
-void reflect_filter_rate_limit_decrease(struct initial_packe=
t_rate_limit *irl);
+void
+reflect_filter_rate_limit_decrease(struct initia=
l_packet_rate_limit *irl,
+                                   struct openvp=
n_sockaddr *from);
 
 /**
  * allocate and initialize the initial-packet ra=
te limiter structure
+ *
+ * Note: this function does not copy bconf's cont=
ents=2E
  */
-struct initial_packet_rate_limit *initial_rate_limit_init(int=
 max_per_period, int period_length);
+struct initial_packet_rate_limit *
+i=
nitial_rate_limit_init(int max_per_period, int period_length,
+            =
            struct bloom_filter_conf *bconf);
 
 /**
  * free the initial-p=
acket rate limiter structure
  */
 void initial_rate_limit_free(struct init=
ial_packet_rate_limit *irl);
+
+/**
+ * Initialises the bloom filter with t=
he configuration values of
+ * irl->bloom_conf
+ */
+void
+init_bloom_filte=
r(struct initial_packet_rate_limit *irl);
 #endif /* ifndef REFLECT_FILTER_=
H */
diff --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests=
/openvpn/Makefile=2Eam
index 70cf7b2=2E=2E1484790 100644
--- a/tests/unit_t=
ests/openvpn/Makefile=2Eam
+++ b/tests/unit_tests/openvpn/Makefile=2Eam
@@ =
-107,6 +107,7 @@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRY=
PTO_LIBS)
 ssl_testdriver_SOURCES =3D test_ssl=2Ec \
 	test_acc=2Ec test_ac=
c=2Eh \
+	test_reflect=2Ec test_reflect=2Eh \
 	mock_msg=2Ec mock_msg=2Eh t=
est_common=2Eh \
 	mock_management=2Ec \
 	mock_ssl_dependencies=2Ec mock_w=
in32_execve=2Ec \
diff --git a/tests/unit_tests/openvpn/test_reflect=2Ec b/=
tests/unit_tests/openvpn/test_reflect=2Ec
new file mode 100644
index 000000=
0=2E=2Ed0d11c6
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_reflect=2E=
c
@@ -0,0 +1,293 @@
+/*
+ *  OpenVPN -- An application to securely tunnel I=
P networks
+ *             over a single TCP/UDP port, with support for SSL=
/TLS-based
+ *             session authentication and key exchange,
+ *    =
         packet encryption, packet authentication, and
+ *             pack=
et compression=2E
+ *
+ *  Copyright (C) 2002-2026 OpenVPN Inc <sales@openv=
pn=2Enet>
+ *
+ *  This program is free software; you can redistribute it a=
nd/or modify
+ *  it under the terms of the GNU General Public License vers=
ion 2
+ *  as published by the Free Software Foundation=2E
+ *
+ *  This pr=
ogram is distributed in the hope that it will be useful,
+ *  but WITHOUT A=
NY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or F=
ITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU General Public License=
 for more details=2E
+ *
+ *  You should have received a copy of the GNU Ge=
neral Public License along
+ *  with this program; if not, see <https://www=
=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config=
=2Eh"
+#elif defined(_MSC_VER)
+#include "config-msvc=2Eh"
+#endif
+
+#incl=
ude "syshead=2Eh"
+
+#include "bloom=2Eh"
+#include "buffer=2Eh"
+#include =
"reflect_filter=2Eh"
+#include "test_common=2Eh"
+
+#include <setjmp=2Eh>
+=
#include <stdarg=2Eh>
+#include <cmocka=2Eh>
+
+#include <stdio=2Eh>
+
+sta=
tic_assert(BLOOM_FILTER_BITS_COUNT =3D=3D 4, "unit test not in sync");
+sta=
tic_assert(BLOOM_FILTER_BITS_MASK =3D=3D 0xf, "unit test not in sync");
+
+=
void
+test_bloom(void **state)
+{
+    static const int present_mod =3D 77;=

+
+    struct gc_arena gc =3D gc_new();
+    /* Use a bloom filter with 1M=
 entries (256kB) for the unit test */
+    struct bloom_filter *bf =3D bloo=
m_create(1024ul * 1024, 8, &gc);
+
+    for (int32_t i =3D 0; i < 20000; i =
+=3D present_mod)
+    {
+        bloom_add(bf, (const uint8_t *)&i, sizeof=
(i));
+    }
+
+    /* all these should be positive, for the small unit tes=
t we do not expect
+     * false positive */
+    for (int32_t i =3D 0; i <=
 20000; i++)
+    {
+        int present =3D (i % present_mod =3D=3D 0) ? 1=
 : 0;
+        /* cast to bool to only get 1 and 0 for present/not present =
and not */
+        assert_int_equal((bool)bloom_test(bf, (const uint8_t *)=
&i, sizeof(i)), present);
+    }
+
+    gc_free(&gc);
+}
+
+void
+test_refl=
ect_ddos(void **state)
+{
+    /* This tests if the bloom filter implementa=
tion does actually work with
+     * the goal of dropping packets to a refl=
ected /24 while still allowing
+     * other clients */
+
+    /* Disable t=
he normal fallback that puts a hard cap on the reflection filter */
+    st=
ruct initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_MAX, 30=
0, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false,=
 24, 5);
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 8,=
 20);
+    init_bloom_filter(irl);
+
+    int num_legimate_reject =3D 0;
+ =
   int num_legimate_accepted =3D 0;
+
+    int num_ddos_rejected =3D 0;
+  =
  int num_ddos_accepted =3D 0;
+
+
+    /* /24 net addresses in host byte o=
rder */
+    in_addr_t net_attack[4];
+    for (int i =3D 0; i < 3; i++)
+ =
   {
+        net_attack[i] =3D random() % 0xff;
+    }
+
+    /* The 4th n=
etwork is close enough to the 3rd to fall in the same /16 */
+    /* XOR th=
e 3rd byte to achieve this */
+    net_attack[3] =3D net_attack[2] ^ 000023=
00;
+
+    /* Assume 200000 packets, including roughly 200 legitimate packe=
ts,
+     * the unit test works also with 20 millions packet but takes too =
long*/
+    static const int total_packets =3D 200 * 1000;
+
+    for (int =
i =3D 0; i < total_packets; i++)
+    {
+        struct openvpn_sockaddr fr=
om =3D { 0 };
+        from=2Eaddr=2Ein4=2Esin_family =3D AF_INET;
+       =
 from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in_addr_t)random();
+        fr=
om=2Eaddr=2Ein4=2Esin_port =3D (uint16_t)random();
+
+        if (i % 1023 =
=3D=3D 0)
+        {
+            /* roughly 200 legitimate clients with ra=
ndom addresses */
+            from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (i=
n_addr_t)random();
+
+            bool allowed =3D reflect_filter_check(irl=
, &from);
+            if (allowed)
+            {
+                num_leg=
imate_accepted++;
+            }
+            else
+            {
+        =
        num_legimate_reject++;
+            }
+        }
+        else
+   =
     {
+            /* We attack the 4 networks at random */
+            f=
rom=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in_addr_t)(net_attack[random() % =
4] + (random() % 256));
+
+            bool allowed =3D reflect_filter_chec=
k(irl, &from);
+            if (allowed)
+            {
+                nu=
m_ddos_accepted++;
+            }
+            else
+            {
+       =
         num_ddos_rejected++;
+            }
+        }
+    }
+
+    asser=
t_int_equal(num_legimate_reject + num_legimate_accepted + num_ddos_accepted=
 + num_ddos_rejected, total_packets);
+
+    /* We assume that most legitim=
ate made it through but a few were unfortunate to be in an attacked network=
 */
+    assert_int_in_range(num_legimate_reject, 0, 10);
+
+    /* We disa=
bled total number of packets, so we expect all /8 to have their
+     * 20 =
packets, which is 5120=2E */
+    assert_int_in_range(num_ddos_accepted, 0,=
 256 * 20);
+
+    initial_rate_limit_free(irl);
+}
+
+
+void
+test_bloom_m=
inimal(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct b=
loom_filter *bf =3D bloom_create(2048, 3, &gc);
+
+    int item =3D 0xbabe;=

+
+    bloom_add(bf, (const uint8_t *)&item, sizeof(item));
+    assert_in=
t_equal(bloom_test(bf, (const uint8_t *)&item, sizeof(item)), 1);
+
+    it=
em =3D 0xf00f;
+    assert_int_equal(bloom_test(bf, (const uint8_t *)&item,=
 sizeof(item)), 0);
+
+    gc_free(&gc);
+}
+
+void
+test_reflect_reflect_b=
loom_simple(void **state)
+{
+    struct initial_packet_rate_limit *irl =3D=
 initial_rate_limit_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tie=
r(&irl->bloom_conf, &irl->gc, true, 32, 50);
+    reflect_add_filter_tier(&=
irl->bloom_conf, &irl->gc, true, 56, 200);
+    init_bloom_filter(irl);
+
+=
    struct openvpn_sockaddr from =3D { 0 };
+    from=2Eaddr=2Ein6=2Esin6_f=
amily =3D AF_INET6;
+    from=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random=
();
+    from=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 1; /* ::1 */
+
+  =
  /* There are 50 attempts that should work until one fails */
+    for (in=
t i =3D 0; i < 50; i++)
+    {
+        assert_true(reflect_filter_check(ir=
l, &from));
+    }
+
+    /* 2002::1 */
+    struct openvpn_sockaddr from2 =
=3D from;
+    from2=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[0] =3D 0x7;
+    fr=
om2=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[1] =3D 0x7;
+
+    assert_true(refle=
ct_filter_check(irl, &from2));
+
+    /* Any more attempts from ::1 should =
fail */
+    assert_false(reflect_filter_check(irl, &from));
+
+    initial=
_rate_limit_free(irl);
+}
+
+void
+test_reflect_bloom_netmask_masking(void =
**state)
+{
+    struct initial_packet_rate_limit *irl =3D initial_rate_lim=
it_init(INT_MAX, 300, NULL);
+
+    reflect_add_filter_tier(&irl->bloom_con=
f, &irl->gc, true, 45, 10);
+    init_bloom_filter(irl);
+
+    struct open=
vpn_sockaddr from =3D { 0 };
+    from=2Eaddr=2Ein6=2Esin6_family =3D AF_IN=
ET6;
+    from=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random();
+    for (i=
nt i =3D 0; i < 15; i++)
+    {
+        from=2Eaddr=2Ein6=2Esin6_addr=2Es6=
_addr[i] =3D (uint8_t)random();
+    }
+
+    for (int i =3D 0; i < 10; i++=
)
+    {
+        /* /45 means that if we leave the leave first 8 bytes and=
 5 bits
+         * untouched, it is still the same subnet  */
+        for=
 (int j =3D 8; j < 15; j++)
+        {
+            from=2Eaddr=2Ein6=2Esin=
6_addr=2Es6_addr[j] =3D (uint8_t)random();
+            from=2Eaddr=2Ein6=
=2Esin6_addr=2Es6_addr[7] ^=3D (uint8_t)(random() & 0x7);
+        }
+     =
   assert_true(reflect_filter_check(irl, &from));
+    }
+
+    /* testing =
the last IP again should give us a negative result */
+    assert_false(ref=
lect_filter_check(irl, &from));
+
+    initial_rate_limit_free(irl);
+}
+
+=

+void
+test_reflect_reflect_bloom_mapped(void **state)
+{
+    struct init=
ial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);=

+
+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 24, 50);=

+    reflect_add_filter_tier(&irl->bloom_conf, &irl->gc, false, 8, 80);
+ =
   init_bloom_filter(irl);
+
+    /* Our OpenVPN server will not receive IP=
v4 as well as IPv4 mapped
+     * addresses in the same process but for the=
 unit test it is convient
+     * to see if they actually mapped to the sam=
e entries */
+
+    struct openvpn_sockaddr mapped_v4 =3D { 0 };
+    mappe=
d_v4=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;
+    mapped_v4=2Eaddr=2Ein6=
=2Esin6_port =3D (uint16_t)random();
+    /* ::ffff:192=2E168=2E0=2E99 */
+=
    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[10] =3D 0xff;
+    mapped_=
v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[11] =3D 0xff;
+    mapped_v4=2Eaddr=
=2Ein6=2Esin6_addr=2Es6_addr[12] =3D 192;
+    mapped_v4=2Eaddr=2Ein6=2Esin=
6_addr=2Es6_addr[13] =3D 168;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_=
addr[14] =3D 0;
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 9=
9;
+
+    assert_true(IN6_IS_ADDR_V4MAPPED(&mapped_v4=2Eaddr=2Ein6=2Esin6_a=
ddr));
+
+    /* Not the same address but in the same /8 */
+    struct ope=
nvpn_sockaddr v4addr =3D { 0 };
+    v4addr=2Eaddr=2Ein4=2Esin_family =3D A=
F_INET;
+    v4addr=2Eaddr=2Ein4=2Esin_port =3D (uint16_t)random();
+    /*=
 192=2E168=2E123=2E244 */
+    v4addr=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D =
htonl(0xc0a87bf4);
+
+    /* check that we run into the 50 limit with our m=
apped address */
+    for (int i =3D 0; i < 50; i++)
+    {
+        assert=
_true(reflect_filter_check(irl, &mapped_v4));
+    }
+    assert_false(refl=
ect_filter_check(irl, &mapped_v4));
+
+
+    /* Check that the non-mapped I=
Pv4 address uses the same /8 subnet limit */
+    for (int i =3D 0; i < 30;=
 i++)
+    {
+        assert_true(reflect_filter_check(irl, &v4addr));
+   =
 }
+    assert_false(reflect_filter_check(irl, &v4addr));
+
+    initial_ra=
te_limit_free(irl);
+}
\ No newline at end of file
diff --git a/tests/unit_=
tests/openvpn/test_reflect=2Eh b/tests/unit_tests/openvpn/test_reflect=2Eh
=
new file mode 100644
index 0000000=2E=2E0dc1e4c
--- /dev/null
+++ b/tests/u=
nit_tests/openvpn/test_reflect=2Eh
@@ -0,0 +1,37 @@
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
23-2026 OpenVPN Inc <sales@openvpn=2Enet>
+ *  Copyright (C) 2023-2026 Arne=
 Schwabe <arne@rfc2549=2Eorg>
+ *
+ *  This program is free software; you c=
an redistribute it and/or modify
+ *  it under the terms of the GNU General=
 Public License version 2
+ *  as published by the Free Software Foundation=
=2E
+ *
+ *  This program is distributed in the hope that it will be useful=
,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  =
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE=2E  See the
+ *  GNU Ge=
neral Public License for more details=2E
+ *
+ *  You should have received =
a copy of the GNU General Public License along
+ *  with this program; if n=
ot, see <https://www=2Egnu=2Eorg/licenses/>=2E
+ */
+
+#ifndef TEST_REFLECT=
_H
+#define TEST_REFLECT_H
+void test_reflect_ddos(void **state);
+
+void t=
est_bloom(void **state);
+
+void test_bloom_minimal(void **state);
+
+void =
test_reflect_reflect_bloom_simple(void **state);
+
+void test_reflect_bloom=
_netmask_masking(void **state);
+
+void test_reflect_reflect_bloom_mapped(v=
oid **state);
+#endif
\ No newline at end of file
diff --git a/tests/unit_t=
ests/openvpn/test_ssl=2Ec b/tests/unit_tests/openvpn/test_ssl=2Ec
index 498=
7dd0=2E=2E8791b2a 100644
--- a/tests/unit_tests/openvpn/test_ssl=2Ec
+++ b/=
tests/unit_tests/openvpn/test_ssl=2Ec
@@ -51,6 +51,7 @@
 #include "ssl_util=
=2Eh"
 #include "ssl_verify=2Eh"
 #include "openvpn=2Eh"
+#include "test_re=
flect=2Eh"
 
 #include "test_acc=2Eh"
 
@@ -1132,7 +1133,13 @@
         cmo=
cka_unit_test(test_parse_acc_parameters),
         cmocka_unit_test(test_ac=
c_common_protocols),
         cmocka_unit_test(test_acc_send_message),
-   =
     cmocka_unit_test(test_list_intersection)
+        cmocka_unit_test(tes=
t_list_intersection),
+        cmocka_unit_test(test_bloom),
+        cmock=
a_unit_test(test_bloom_minimal),
+        cmocka_unit_test(test_reflect_ref=
lect_bloom_simple),
+        cmocka_unit_test(test_reflect_reflect_bloom_ma=
pped),
+        cmocka_unit_test(test_reflect_bloom_netmask_masking),
+    =
    cmocka_unit_test(test_reflect_ddos)
     };
 
 #if defined(ENABLE_CRYPT=
O_OPENSSL)

-- 
To view, visit https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/3=
0?usp=3Demail
To unsubscribe, or for help writing mail filters, visit https=
://gerrit=2Eopenvpn=2Enet/settings?usp=3Demail

Gerrit-MessageType: newpatc=
hset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a927=
4cab7fefce3b13c05052fb9a072e0bfa6b9
Gerrit-Change-Number: 30
Gerrit-PatchSe=
t: 12
Gerrit-Owner: Arne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Review=
er: Frank Lichtenheld <frank@lichtenheld=2Ecom>
Gerrit-Reviewer: Max Fillin=
ger <max@max-fillinger=2Enet>
Gerrit-Reviewer: R=C4=83zvan Cojocaru <razvan=
c@mailbox=2Eorg>
Gerrit-CC: openvpn-devel <openvpn-devel@lists=2Esourceforg=
e=2Enet>
Gerrit-Attention: Max Fillinger <max@max-fillinger=2Enet>
Gerrit-A=
ttention: R=C4=83zvan Cojocaru <razvanc@mailbox=2Eorg>
Gerrit-Attention: Ar=
ne Schwabe <arne-openvpn@rfc2549=2Eorg>
Gerrit-Attention: Frank Lichtenheld=
 <frank@lichtenheld=2Ecom>

--WAaBP99Hz0w=
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Arne Schwabe, Frank Lichtenheld, Max Fillinger, R=C4=
=83zvan Cojocaru=2E </p>
<p>Arne Schwabe <strong>uploaded patch set #12</st=
rong> to this change=2E</p><p><a href=3D"https://gerrit=2Eopenvpn=2Enet/c/o=
penvpn/+/30?usp=3Demail">View Change</a></p><p>The following approvals got =
outdated and were removed:
Code-Review-1 by R=C4=83zvan Cojocaru</p><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Implement initial packet reflection protection using bloom filter<br=
><br>When an OpenVPN server is used/tried to be used in a reflection attack=
<br>the protection with the simple --connect-freq-initial also blocks legit=
imate<br>clients from other networks that are not attacked by a reflection =
attack=2E<br><br>To allow a server to still reply to these clients, we need=
 to make the counts<br>rather more detailed and count per subnet or IP addr=
ess=2E On the other hand<br>when we keep all this state, we eliminate the a=
dvantage of having a stateless<br>cookie based initial packet handshake=2E<=
br><br>As compromise we use a bloom filter to store the information=2E This=
 data<br>structure is probabilistic and can have false positive and more pa=
ckets<br>being dropped but since it is a constant size and the size of this=
 map<br>is small enough for non-embedded systems (tests were done with a 2M=
B<br>bloom filter), it is a good compromise=2E<br><br>The code is split int=
o the bloom filter implementation and the actual logic<br>implementing trac=
king the subnets, so the bloom filter should be relatively<br>easily be exc=
hangable by another data structure=2E<br><br>As hash function SIPHASH has b=
een chosen since it was designed for this kind<br>of application=2E<br><br>=
Change-Id: I0a9274cab7fefce3b13c05052fb9a072e0bfa6b9<br>Signed-off-by: Arne=
 Schwabe &lt;arne@rfc2549=2Eorg&gt;<br>---<br>M =2Egithub/workflows/build=
=2Eyaml<br>M CMakeLists=2Etxt<br>M Changes=2Emd<br>M doc/man-sections/serve=
r-options=2Erst<br>M src/openvpn/Makefile=2Eam<br>A src/openvpn/bloom=2Ec<b=
r>A src/openvpn/bloom=2Eh<br>M src/openvpn/mudp=2Ec<br>M src/openvpn/multi=
=2Ec<br>M src/openvpn/options=2Ec<br>M src/openvpn/options=2Eh<br>M src/ope=
nvpn/ovpn_dco_linux=2Eh<br>M src/openvpn/reflect_filter=2Ec<br>M src/openvp=
n/reflect_filter=2Eh<br>M tests/unit_tests/openvpn/Makefile=2Eam<br>A tests=
/unit_tests/openvpn/test_reflect=2Ec<br>A tests/unit_tests/openvpn/test_ref=
lect=2Eh<br>M tests/unit_tests/openvpn/test_ssl=2Ec<br>18 files changed, 1,=
421 insertions(+), 97 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit=2Eopenvpn=2Enet:29418/openvpn refs/changes/30/30/12</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/=2Egithub/workflows/build=2Eyaml b/=2Egithub/workflows/build=2Eyaml<=
/span><br><span>index 27f08df=2E=2E39b7357 100644</span><br><span>--- a/=2E=
github/workflows/build=2Eyaml</span><br><span>+++ b/=2Egithub/workflows/bui=
ld=2Eyaml</span><br><span>@@ -157,6 +157,9 @@</span><br><span>         env:=
</span><br><span>           srcdir: &quot;${{ github=2Eworkspace }}/tests/u=
nit_tests/openvpn&quot;</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - name: Run reflect unit test</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        run: =2E/unittests/test_refle=
ct=2Eexe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>   ubuntu:</span><br><span>     strategy:</span><br><span>       fail=
-fast: false</span><br><span>diff --git a/CMakeLists=2Etxt b/CMakeLists=2Et=
xt</span><br><span>index 5cf1a30=2E=2Ec7f743a 100644</span><br><span>--- a/=
CMakeLists=2Etxt</span><br><span>+++ b/CMakeLists=2Etxt</span><br><span>@@ =
-441,6 +441,7 @@</span><br><span>     src/openvpn/base64=2Ec</span><br><spa=
n>     src/openvpn/base64=2Eh</span><br><span>     src/openvpn/basic=2Eh</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/bloom=
=2Ec</span><br><span>     src/openvpn/buffer=2Ec</span><br><span>     src/o=
penvpn/buffer=2Eh</span><br><span>     src/openvpn/check_file_access=2Ec</s=
pan><br><span>@@ -824,9 +825,12 @@</span><br><span>             tests/unit_=
tests/openvpn/mock_ssl_dependencies=2Ec</span><br><span>             tests/=
unit_tests/openvpn/mock_win32_execve=2Ec</span><br><span>             tests=
/unit_tests/openvpn/test_acc=2Ec</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            tests/unit_tests/openvpn/test_reflect=2Ec</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            tests/unit_tests=
/openvpn/test_reflect=2Eh</span><br><span>             src/openvpn/acc=2Ec<=
/span><br><span>             src/openvpn/argv=2Ec</span><br><span>         =
    src/openvpn/base64=2Ec</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            src/openvpn/bloom=2Ec</span><br><span>             src/o=
penvpn/crypto_epoch=2Ec</span><br><span>             src/openvpn/crypto_mbe=
dtls=2Ec</span><br><span>             src/openvpn/crypto_openssl=2Ec</span>=
<br><span>@@ -838,7 +842,11 @@</span><br><span>             src/openvpn/opt=
ions_util=2Ec</span><br><span>             src/openvpn/otime=2Ec</span><br>=
<span>             src/openvpn/packet_id=2Ec</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            src/openvpn/reflect_filter=2Ec</span><=
br><span>             src/openvpn/run_command=2Ec</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            src/openvpn/siphash=2Ec</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/sipha=
sh=2Eh</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
rc/openvpn/siphash_reference=2Ec</span><br><span>             src/openvpn/s=
sl_mbedtls=2Ec</span><br><span>             src/openvpn/ssl_ncp=2Ec</span><=
br><span>             src/openvpn/ssl_openssl=2Ec</span><br><span>diff --gi=
t a/Changes=2Emd b/Changes=2Emd</span><br><span>index b5ae881=2E=2E41e111e =
100644</span><br><span>--- a/Changes=2Emd</span><br><span>+++ b/Changes=2Em=
d</span><br><span>@@ -23,6 +23,15 @@</span><br><span>   the characters ment=
ioned above were already escaped=2E However, the behavior of</span><br><spa=
n>   Mbed TLS is slightly different from OpenSSL in that it also escapes &q=
uot;=3D&quot;=2E</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+* **Bloom filter based reflection protection**</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  To avoid the limitation of ``--connect-freq-initia=
l`` to block legitimate</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  clients when an OpenVPN server is tried to be used in a reflection at=
tack,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  the new ``--=
connect-freq-initial-bloom-limit`` can impose limit on a</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  per-subnet basis=2E See the manual f=
or more details=2E Note: this option</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+  requires 2MB of extra memory in the default configuratio=
n=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> ## Maintainer-vi=
sible changes</span><br><span> </span><br><span> - The configure-time optio=
n `--enable-debug` is no longer  available</span><br><span>diff --git a/doc=
/man-sections/server-options=2Erst b/doc/man-sections/server-options=2Erst<=
/span><br><span>index 7a09809=2E=2E4eb0239 100644</span><br><span>--- a/doc=
/man-sections/server-options=2Erst</span><br><span>+++ b/doc/man-sections/s=
erver-options=2Erst</span><br><span>@@ -226,6 +226,77 @@</span><br><span>  =
 will not be counted against the limit=2E The default is to allow</span><br=
><span>   100 initial connection per 10s=2E</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+--connect-freq-initial-bloom-size args</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+   Valid syntax:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+   ::</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      connect=
-freq-initial-bloom-size size [numhashes]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+   Configures the size of the bloom filter used for the initial connecti=
on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   packet respons=
es=2E See `--connect-freq-initial-bloom-limit` for a full</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   description of the feature=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   Bloom filters are probabilistic by the=
ir nature and the larger the size</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+   of the bloom filter is, the more accurate they are=2E This=
 option configures</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
  the number of buckets in the bloom filter=2E Each bucket takes up 4 bits=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   E=2Eg=2E the =
default of  8336608 (8 * 2^20) when the option is not set</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+   will require 2MB of memory=2E The =
numhashes will control the number of hash</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+   functions that are used for the bloom filter=2E Th=
e default is 7=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+--connect-freq-initia=
l-bloom-limit arg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+   Valid syntax:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+   ::</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      connect-freq-initial-bloom-limit inet netmask limit=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      connect-freq-=
initial-bloom-limit inet6 netmask limit</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+   This option implements a rate limiting function for initial packet like=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ``--connect-freq=
-initial`` but takes the source of the initial packet into</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+   account=2E This function shares t=
he reset after a time period and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+   enabling this function will not disable the overall limit o=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   ``--connect-fre=
q-initial``=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+   To avoid resource exh=
austion on the OpenVPN server side from reflection</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+   attacks and also trying to avoid blocking=
 legitimate clients when an</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+   attacker tries to use an OpenVPN server, the limits are not appl=
ied globally</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   but =
rather a per netmask granularity=2E Each line of this command configures</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+   a separate granular=
ity=2E As example, the following configuration,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+   ::</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        connect-freq-ini=
tial 1000 60</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 connect-freq-initial-bloom-limit inet 24 50</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        connect-freq-initial-bloom-limit inet 8 10=
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        connect-fr=
eq-initial-bloom-limit inet6 56 50</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        connect-freq-initial-bloom-limit inet6 32 100</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    will limit the number of (unanswered) rep=
lies per /24 network to 50</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    packets=2E After 50 packets from the same /24, the server will</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    drop any further =
packets=2E Similarly, if a /16 network receives more than</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    100 connection requests, the serv=
er will drop further packets=2E</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    If the count of all packets exceeds 1000, further packets w=
ill be</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    completel=
y dropped regardless of their origin=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+   The implementation uses a counting bloom filter to store information of=
 how</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   many packets=
 the server has seen per subnet=2E A bloom filter is a</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+   probabilistic data structure can yiel=
d false positives=2E In this case, the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+   server will drop packets even though the limit</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   for that particular sub=
net is not yet reached=2E Since we are using a</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+   counting bloom filter, a reply from a client =
that triggers a removal of an</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   entry can also lead to a false negative=2E However, this is li=
mited in the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   sens=
e a reply can at most trigger one false negative=2E</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+   Every limit configured with this option will put more ent=
ries into</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   the blo=
om filter since per limit (per family), one entry is put into the</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+   bloom filter=2E So a large=
 number of entries requires a larger bloom filter</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+   to avoid too many false positives=2E</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+   IPv6 mapped IPv4 addresses (::ffff:0:0/96=
) are treated as IPv4 addresses</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+   for these limits=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> --duplicate-cn</span><br><span>   Allow mu=
ltiple clients with the same common name to concurrently</span><br><span>  =
 connect=2E In the absence of this option, OpenVPN will disconnect a client=
</span><br><span>diff --git a/src/openvpn/Makefile=2Eam b/src/openvpn/Makef=
ile=2Eam</span><br><span>index bb31053=2E=2E96c2979 100644</span><br><span>=
--- a/src/openvpn/Makefile=2Eam</span><br><span>+++ b/src/openvpn/Makefile=
=2Eam</span><br><span>@@ -50,6 +50,7 @@</span><br><span> 	auth_token=2Ec au=
th_token=2Eh \</span><br><span> 	base64=2Ec base64=2Eh \</span><br><span> 	=
basic=2Eh \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	bloom=
=2Ec bloom=2Eh \</span><br><span> 	buffer=2Ec buffer=2Eh \</span><br><span>=
 	check_file_access=2Ec check_file_access=2Eh \</span><br><span> 	circ_list=
=2Eh \</span><br><span>diff --git a/src/openvpn/bloom=2Ec b/src/openvpn/blo=
om=2Ec</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E6604cb3</span><br><span>--- /dev/null</span><br><span>+++ b/src/openv=
pn/bloom=2Ec</span><br><span>@@ -0,0 +1,250 @@</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a si=
ngle TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *             session authentication and key=
 exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
      packet encryption, packet authentication, and</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2023-2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; yo=
u can redistribute it and/or modify</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  it under the terms of the GNU General Public License ve=
rsion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publi=
shed by the Free Software Foundation=2E</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
GNU General Public License for more details=2E</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  You should have received a copy of the GNU General Public Lic=
ense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with =
this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* This file implements a specialised counting bloom filter=
 implementation</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * u=
sed in OpenVPN to mitigate it being used in reflection attacks=2E The bloom=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * implementation s=
hould be general enough to be used in other contexts</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * however */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;config-msvc=2Eh&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &lt;stdint=2Eh&gt;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &lt;stddef=2Eh&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;stdlib=2Eh&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;string=2Eh&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool=2Eh&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;siphash=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;c=
rypto=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;bloom=2E=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+static size_t</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+calc_ceil_log2(size_t num)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* Figure out how many bits we have in our h=
ash by doing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
ceil(log2(bf-&gt;size) */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t nu=
mbits =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    whi=
le (num &gt;&gt;=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        num=
bits++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return numbits;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * C=
alculate number of bytes needed for each hash function in the bloom filter<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static inline size_t</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+calculate_num_bytes_hashfun(size_t size)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    size_t hash_bits =3D calc_ceil_log2(size);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* round up to the=
 nearest byte size */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t hash_bytes =3D (hash_bits + 7) / 8;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return hash_bytes;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * A bloom filter u=
ses a number of hashes to perform its functionality=2E</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Instead of using the same number of siphash function w=
e split the bytes of</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * the siphash to the different hashes=2E</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * We could also optimise this further by splitting at the bit level =
but that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * crates a=
 lot of extra code for bit shifting, etc=2E so we waste some bits</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @param bf</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param num_hashes</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+si=
ze_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+calculate_num_s=
ip_hash_hashes(struct bloom_filter *bf)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    size_t hash_bytes =3D calculate_num_bytes_hashfun(bf-&gt;size);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t total_bytes =
=3D bf-&gt;num_hashes * hash_bytes;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Round up to next SIPHASH_HASH_SIZE */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    size_t num_siphash =3D (total_bytes + BLOOM_HASH_=
SIZE - 1) / BLOOM_HASH_SIZE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 num_siphash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Calculates the number of bytes we need for storing a b=
loom filter of size</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * size=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static=
 inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom=
_get_filter_byte_count(size_t size)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  size_t bits_required =3D size * BLOOM_FILTER_BITS_COUNT;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* Add 7 round up to the next by=
te */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (bi=
ts_required + 7) / 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static inline size_t</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+bloom_get_filter_bit_offset(size_t=
 bucket)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return (bucket * BLOOM_FI=
LTER_BITS_COUNT) % (8 * sizeof(bloom_counter_t));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_=
get_filter_array_index(size_t bucket)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return (bucket * BLOOM_FILTER_BITS_COUNT) / (8 * sizeof(bloom_counter_t=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static inline bloom_counter_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bloom_get_filter_get_counter(struct bloom=
_filter *bf, size_t bucket)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static=
_assert((BLOOM_FILTER_BITS_MASK + 1) =3D=3D (1 &lt;&lt; BLOOM_FILTER_BITS_C=
OUNT),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
     &quot;BLOOM_FILTER_BITMASK and BLOOM_FILTER_BIT_COUNT are inconsistent=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t counter =
=3D bf-&gt;buckets[bloom_get_filter_array_index(bucket)];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    size_t bitoffset =3D bloom_get_fi=
lter_bit_offset(bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (co=
unter &gt;&gt; bitoffset) &amp; BLOOM_FILTER_BITS_MASK;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bl=
oom_set_filter_counter(struct bloom_filter *bf, size_t bucket, bloom_counte=
r_t value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t data =
=3D bf-&gt;buckets[bloom_get_filter_array_index(bucket)];</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    size_t bitoffset =3D bloom_get_fi=
lter_bit_offset(bucket);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    data =3D d=
ata &amp; ~(BLOOM_FILTER_BITS_MASK &lt;&lt; bitoffset);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    data =3D data | ((value &amp; BLOOM_FILTER_BITS_MASK) =
&lt;&lt; bitoffset);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;buckets=
[bloom_get_filter_array_index(bucket)] =3D data;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Creates a new bloom f=
ilter structure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param size the number of buckets=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * @return  the newly created bloom filter structure</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+struct bloom_filter *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bloom_create(size_t size, size_t num_ha=
shes, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t =
bloomfilter_bytes =3D bloom_get_filter_byte_count(size);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter *bf =3D gc_mal=
loc(sizeof(struct bloom_filter) + bloomfilter_bytes,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                        f=
alse,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                          gc);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    bf-&gt;size =3D size;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    bf-&gt;num_hashes =3D num_hashes;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    bf-&gt;hash_bytes =3D calculate_num_bytes_hashfun(size)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bf-&gt;num_sip=
hash =3D calculate_num_sip_hash_hashes(bf);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ALLOC_ARRAY_GC(bf-&gt;siphash_keys, struct siphash_key, bf-&gt;num=
_siphash, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    b=
loom_clear(bf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return bf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Clear the bloom filter, making it empty again as if it were=
 freshly created</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param bf the bloom structure to clear</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_clear(=
struct bloom_filter *bf)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(bf=
-&gt;buckets, 0, bloom_get_filter_byte_count(bf-&gt;size));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* We randomise the bloom filter keys on every cle=
ar of the bloom filter</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * to avoid scenarios where an attacker might learn specific pattern=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * that could e=
xploit false positives in the bloom filter */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt; bf-&gt;num_siphas=
h; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        prng_bytes(bf-&gt;=
siphash_keys[i]=2Ekey, SIPHASH_KEY_SIZE);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static bloom_counter_t</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_add_test(struct bloo=
m_filter *bf, const uint8_t *item, size_t len, int inc)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    uint8_t result[BLOOM_HASH_SIZE];</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t j =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    size_t idx =3D 0;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t ret =3D bloom_coun=
ter_max;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    for (size_t i =3D 0; i &lt=
; bf-&gt;num_hashes; i++)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
size_t bucket =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        for (size_t k =3D 0; k &lt; bf-&gt;hash_bytes; k++)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (idx =3D=3D 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                /* We have no longer unu=
sed bytes in result, generate the next hash */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                siphash(item, len, bf-&gt;siphas=
h_keys[j++]=2Ekey, result, BLOOM_HASH_SIZE);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            bucket =3D bucket &lt;&lt; 8;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            bucket |=3D result[idx];</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            idx =3D (idx + 1) % BLOOM_HASH_SIZE;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        bucket =3D bucket % bf-&gt;size;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        bloom_counter_t value =3D =
bloom_get_filter_get_counter(bf, bucket);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        ret =3D min_bloom_counter(ret, value);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (inc =3D=3D 1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            value =3D min_bloom_counter(bloom_counter_max, value + 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            bloom=
_set_filter_counter(bf, bucket, value);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        else if (inc =3D=3D -1 &amp;&amp; value !=3D bloom_counte=
r_max &amp;&amp; value &gt; 0)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* If a bloom has the maximum value, we cannot decrease it as<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * do no=
t know how many hashes contributed to it=2E */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            value--;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            bloom_set_filter_counter(bf, bucket=
, value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bloom_counter_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloo=
m_add(struct bloom_filter *bf, const uint8_t *item, size_t len)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return bloom_add_test(bf, item, len, 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bloom_counter_t</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bloom_remove(struct bloom_filter *bf, const uint8_t *item, size_=
t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return bloom_add_test(bf, i=
tem, len, -1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bloom_test(struct bloom_filter *bf, const uin=
t8_t *item, size_t len)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return blo=
om_add_test(bf, item, len, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span>diff --git a/src/openvpn/bloom=2Eh b/src/openv=
pn/bloom=2Eh</span><br><span>new file mode 100644</span><br><span>index 000=
0000=2E=2E3dd41bc</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/bloom=2Eh</span><br><span>@@ -0,0 +1,147 @@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networks<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over =
a single TCP/UDP port, with support for SSL/TLS-based</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             session authentication and=
 key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          packet encryption, packet authentication, and</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 OpenVPN Inc=
 &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  Copyright (C) 2023-2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; =
you can redistribute it and/or modify</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  it under the terms of the GNU General Public License =
version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pub=
lished by the Free Software Foundation=2E</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  This program is distributed in the hope that it will be useful,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WA=
RRANTY; without even the implied warranty of</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PU=
RPOSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  GNU General Public License for more details=2E</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  You should have received a copy of the GNU General Public L=
icense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wit=
h this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef BLOOM_H</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define BLOOM_H</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&lt;stdint=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;siphash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/* This is the type we use for the buckets=2E This is split into small=
 buckets</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * with BLO=
OM_FILTER_BITS_COUNT size */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+typedef uint32_t bloom_counter_t;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define BLOOM_FILTER_BITS_COUNT 4</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define BLOOM_FILTER_BITS_MASK  0x0f</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define bloom_counter=
_max       0x0f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* we want bloom_counte=
r_t bits to be a multiple of BLOOM_FILTER_BITS_COUNT to</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * allow our operations to calculate bu=
cket indexes to assume that that a bucket</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * is always inside a single index bloom_counter_t an=
d never stretches over</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * two adjacent bloom_counter_t */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static_assert((sizeof(bloom_counter_t) * 8) % BLOOM_FILTE=
R_BITS_COUNT =3D=3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+              &quot;bloom_counter_t must be a multiple of BLOOM_FILTER_B=
IT_COUNT&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* We use 64 bit outpu=
t from siphash for the bloom filter */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define BLOOM_HASH_SIZE 8</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static inline bloom_counter_t</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+min_bloom_counter(bloom_counter_t x, bloom_counter_t y)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (x &lt; y)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        return x;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return y;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+struct siphash_key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t key[SI=
PHASH_KEY_SIZE];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * A structure holding a bloom filter=2E A bloom filter=
 is a probabilistic</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * data structure used to test whether an element is a member of a set=2E</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * It may return fals=
e positives but never false negatives=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * A bloom filter has a size N of entries, and each entry or bucket is =
a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * counter=2E E=2E=
g=2E a bloom filer of size 1024 with entries of 4 bits each</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * will have 4096 bits or 512 bytes=
 in total size=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Whenever an entr=
y is added to the bloom filter, n hash function are</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * calculated=2E These map a key -&gt; [0=
, size of bloom filter]=2E For each of</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * hash function use the result as index for the bucket =
to increase the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * c=
ounter=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * For our example of a blo=
om filter with 1024 entries and 5 hash functions,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * hashing an entry might yield 77,323, 662, =
789, and 8=2E That would then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * increase the buckets (bit counters) at the index positions 77,=
 323,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * 662, 789, a=
nd 8=2E If an entry is at its maximum (15 for 4 bits counters)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * it will stop increasing the c=
ounter=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * To test if an entry is i=
n the bloom filter we do the same hashing and</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * check if all the counters positions have at le=
ast a value of 1=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Removing an en=
try is similar to adding an entry, we decrement the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * counter at each bit position=2E But wi=
th the caveat that buckets with</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * already at maximum, the counter is not decremented in order =
to preserve</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the p=
roperty of never false negatives=2E</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* Instead of using n separate hash functions that map to output log(N) bits=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * our implementat=
ion uses multiple siphash functions with 64 bit output</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * and slices them into multiple hash fu=
nctions of log(N) bits=2E</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * E=2Eg=2E=
 when using a bloom filter of size 1048576 (1024 * 1024),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * we need 20 bits output for each of=
 the hash functions=2E We round up</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * to bytes, So that are 3 bytes=2E To realize 7 hash functi=
on we need</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * then 2=
1 bytes or three siphash function each with 8 byte (64 bit)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+struct bloom_filter</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /** Size (N) of the bloom filter in entries</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * This is also equal to (total bits)=
/(bits per counter) */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    size_t size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Number of b=
ytes used by each hash function=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * log2(size * 8) bits rounded up to the next byte</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * This is a cached value since log2 is surpris=
ingly slow</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * (5=
% of total time of if we do not cache it) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    size_t hash_bytes;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /** number of hashes (n) we use to determine the bit positions=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t num_h=
ashes;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /** number of siphash functi=
ons needed to calculate=2E This can be</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     * calculated from the other members of the struct b=
ut we store it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
* in the struct for fast access */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    size_t num_siphash;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /** keys for the siphash functions */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct siphash_key *siphash_keys;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /** the actual buckets that hold the data */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    bloom_counter_t bucke=
ts[];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+struct bloom_filter *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bloom_create(size_t size, size_t num_hashes, struct gc_arena *gc);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+bloom_counter_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bloom_test(struct bloom_filter *bf, const=
 uint8_t *item, size_t len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_coun=
ter_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_add(stru=
ct bloom_filter *bf, const uint8_t *item, size_t len);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+bloom_counter_t</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bloom_remove(struct bloom_filter *bf, const uint8_t *item, size=
_t len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bloom_clear(struct bloom_filter *bf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef BLOOM_H */=
</span><br><span>diff --git a/src/openvpn/mudp=2Ec b/src/openvpn/mudp=2Ec</=
span><br><span>index 217b299=2E=2E02bbeff 100644</span><br><span>--- a/src/=
openvpn/mudp=2Ec</span><br><span>+++ b/src/openvpn/mudp=2Ec</span><br><span=
>@@ -34,6 +34,7 @@</span><br><span> #include &quot;memdbg=2Eh&quot;</span><=
br><span> #include &quot;ssl_pkt=2Eh&quot;</span><br><span> #include &quot;=
sid_hash=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;reflect_filter=2Eh&quot;</span><br><span> </span><br><span> #=
ifdef HAVE_SYS_INOTIFY_H</span><br><span> #include &lt;sys/inotify=2Eh&gt;<=
/span><br><span>@@ -131,7 +132,7 @@</span><br><span>     {</span><br><span>=
         /* Check if we are still below our limit for sending out</span><br=
><span>          * responses */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (!reflect_filter_rate_limit_check(m-&gt;initial_rate_l=
imiter))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!reflect_filter_check(m-&gt;initial_rate_limiter, from))</span><br><span> =
        {</span><br><span>             return PRE_DECRYPT_NO_ACTION;</span>=
<br><span>         }</span><br><span>@@ -270,9 +271,10 @@</span><br><span> =
</span><br><span>         if (frequency_limit_event_allowed(m-&gt;new_conne=
ction_limiter))</span><br><span>         {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            struct link_socket_actual *from =3D &amp=
;m-&gt;top=2Ec2=2Efrom;</span><br><span>             /* a successful three-=
way handshake only counts against</span><br><span>              * connect-f=
req but not against connect-freq-initial */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            reflect_filter_rate_limit_decrease(m-&gt;=
initial_rate_limiter);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            reflect_filter_rate_limit_decrease(m-&gt;initial_rate_limite=
r, &amp;from-&gt;dest);</span><br><span> </span><br><span>             mi =
=3D multi_create_instance(m, real, sock);</span><br><span>             if (=
mi)</span><br><span>@@ -286,7 +288,7 @@</span><br><span>                 {<=
/span><br><span>                     ASSERT(session_id_defined(&amp;state=
=2Epeer_session_id));</span><br><span>                     mi-&gt;context=
=2Ec2=2Etls_multi-&gt;n_sessions++;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    session_skip_to_pre_start(session, &amp;s=
tate, &amp;m-&gt;top=2Ec2=2Efrom);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    session_skip_to_pre_start(session, &amp;=
state, from);</span><br><span>                 }</span><br><span>          =
       multi_hash_sid_add(m, &amp;state=2Epeer_session_id, mi);</span><br><=
span>             }</span><br><span>diff --git a/src/openvpn/multi=2Ec b/sr=
c/openvpn/multi=2Ec</span><br><span>index 3f514d6=2E=2E7c0f35a 100644</span=
><br><span>--- a/src/openvpn/multi=2Ec</span><br><span>+++ b/src/openvpn/mu=
lti=2Ec</span><br><span>@@ -331,9 +331,12 @@</span><br><span>      * Limit =
frequency of incoming connections to control</span><br><span>      * DoS=2E=
</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    m-&gt;new_connection_limiter =3D frequency_limit_init(t-&gt;options=
=2Ecf_max, t-&gt;options=2Ecf_per);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    m-&gt;initial_rate_limiter =3D</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        initial_rate_limit_init(t-&gt;options=2E=
cf_initial_max, t-&gt;options=2Ecf_initial_per);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    m-&gt;new_connection_limiter =3D frequency=
_limit_init(t-&gt;options=2Ecf_max,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                                     t-&gt;=
options=2Ecf_per);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   m-&gt;initial_rate_limiter =3D initial_rate_limit_init(t-&gt;options=2Ec=
f_initial_max,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                                 t-&gt;options=2Ecf_initial=
_per,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                                        &amp;t-&gt;options=2Einitial_cf_blo=
om_config);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> </span><br><span>     /*</span><br><span>      * Allocate broadca=
st/multicast buffer list</span><br><span>diff --git a/src/openvpn/options=
=2Ec b/src/openvpn/options=2Ec</span><br><span>index 4dfc719=2E=2E1b3f17d 1=
00644</span><br><span>--- a/src/openvpn/options=2Ec</span><br><span>+++ b/s=
rc/openvpn/options=2Ec</span><br><span>@@ -2621,6 +2621,23 @@</span><br><sp=
an> }</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_filter_tier_over_global_limit(struc=
t filter_tier *ft, int limit,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                    const char *family)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    while (ft)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (ft-&gt;limit &gt; limit)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(M_WARN, &quot;Note: --connect-freq-initial-=
bloom-limit %s %d %d &quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                        &quot;has a larger limit than connect-freq-=
initial &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   &quot;limit (%d)=2E&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                family, ft-&gt;netmask, ft-&gt;li=
mit, limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ft =3D ft=
-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static void</span><br><span> options_postprocess_verify(cons=
t struct options *o)</span><br><span> {</span><br><span>     if (o-&gt;conn=
ection_list)</span><br><span>@@ -2655,6 +2672,18 @@</span><br><span>       =
                  &quot;Ignoring these options=2E&quot;);</span><br><span> =
        }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 ((bool)(o-&gt;initial_cf_bloom_config=2Einet_tiers)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            + (bool)(o-&gt;initial_cf_blo=
om_config=2Einet6_tiers)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        =3D=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg=
(M_FATAL, &quot;connect-freq-initial-bloom-limit must be provided for &quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
   &quot;both inet and inet6&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    check_filter_tier_over_global_limit(o-&gt;initial_cf_bloom_config=2E=
inet_tiers,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                                o-&gt;cf_initial_max, &quot;inet&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_filter_tier_=
over_global_limit(o-&gt;initial_cf_bloom_config=2Einet6_tiers,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
        o-&gt;cf_initial_max, &quot;inet6&quot;);</span><br><span> }</span>=
<br><span> </span><br><span> static void</span><br><span>@@ -5985,6 +6014,7=
3 @@</span><br><span>         options-&gt;cf_initial_max =3D cf_max;</span>=
<br><span>         options-&gt;cf_initial_per =3D cf_per;</span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;connect-freq-initial-bloom-size&quot;) &amp;&amp; p[1] &am=
p;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        VERIFY_PERM=
ISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int cf_b=
loom_size =3D positive_atoi(p[1], msglevel);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (cf_bloom_size =3D=3D 0)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(msglevel, &quot;--connect-freq-initial-bloom-si=
ze size must be &gt; 0&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            goto err;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        options-&gt;initial_cf_bloom_config=2Esize =3D cf_bloom_size;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[2])</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            int num_hash =3D posit=
ive_atoi(p[2], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (num_hash =3D=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                msg(msglevel, &quot;--connect-freq-initial-b=
loom-size number of hash &quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                              &quot;functions must be &gt; 0&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            op=
tions-&gt;initial_cf_bloom_config=2Enum_hashes =3D num_hash;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (streq(p[0], &quot;connect-freq-initial-bloom-=
limit&quot;) &amp;&amp; p[1] &amp;&amp; p[2]</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             &amp;&amp; p[3] &amp;&amp; !p[4])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        int netmask =3D atoi(p[2]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int limit =3D=
 atoi(p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (limit &lt;=3D =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &=
quot;Limit parameter to %s must be &gt; 0&quot;, p[0]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (streq(p[1], &quot;inet&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (netmask &lt; 0 || netmask &gt; 32)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglev=
el, &quot;Netmask parameter (%s) for IPv4 for %s must be &quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                              &=
quot;between 0 and 32&quot;,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    p[2], p[0]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                goto err;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            reflect_add_filter_tier(&amp;options-&gt;=
initial_cf_bloom_config,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                                    &amp;options-&gt;gc, false, netmas=
k, limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if (st=
req(p[1], &quot;inet6&quot;))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (netmask &lt; 0 || netmask &gt; 128)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;Netmask par=
ameter (%s) for IPv6 for %s must be &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                              &quot;between 0 and 12=
8&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         p[2], p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                goto err;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            reflect_add_filter_tier(&amp;options-&gt;initial_cf_bloom_con=
fig,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                     &amp;options-&gt;gc, true, netmask, limit);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            msg(msglevel, &quot;Unknown parameter %s for =
%s=2E Must be inet or inet6&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                p[1], p[0]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            goto err;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span>     else if (streq(p[0], &quot;max-c=
lients&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</spa=
n><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>diff=
 --git a/src/openvpn/options=2Eh b/src/openvpn/options=2Eh</span><br><span>=
index 73c1354=2E=2Ea1b1983 100644</span><br><span>--- a/src/openvpn/options=
=2Eh</span><br><span>+++ b/src/openvpn/options=2Eh</span><br><span>@@ -42,6=
 +42,7 @@</span><br><span> #include &quot;clinat=2Eh&quot;</span><br><span>=
 #include &quot;crypto_backend=2Eh&quot;</span><br><span> #include &quot;dn=
s=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;reflect_filter=2Eh&quot;</span><br><span> </span><br><span> </span><=
br><span> /*</span><br><span>@@ -533,6 +534,8 @@</span><br><span>     int c=
f_initial_max;</span><br><span>     int cf_initial_per;</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filt=
er_conf initial_cf_bloom_config;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     uint32_t max_clients;</span><br><span>  =
   int max_routes_per_client;</span><br><span>     int stale_routes_check_i=
nterval;</span><br><span>diff --git a/src/openvpn/ovpn_dco_linux=2Eh b/src/=
openvpn/ovpn_dco_linux=2Eh</span><br><span>index b3c9ff0=2E=2E7366177 10064=
4</span><br><span>--- a/src/openvpn/ovpn_dco_linux=2Eh</span><br><span>+++ =
b/src/openvpn/ovpn_dco_linux=2Eh</span><br><span>@@ -6,105 +6,113 @@</span>=
<br><span> #ifndef _UAPI_LINUX_OVPN_H</span><br><span> #define _UAPI_LINUX_=
OVPN_H</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define OVPN_FAMILY_NAME	&quot;ovpn&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define OVPN_FAMILY_VERSION	1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define OVPN_FAMILY_NAME    &quot;ovpn&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVPN_FAM=
ILY_VERSION 1</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#define OVPN_NONCE_TAIL_SIZE	8</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define OVPN_NONCE_TAIL_SIZE 8</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_cipher_alg {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_NONE,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_AES_GCM,=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CIPHER_ALG_CHAC=
HA20_POLY1305,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum =
ovpn_cipher_alg</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CIPHER_ALG_NO=
NE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CIPHER_=
ALG_AES_GCM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_CIPHER_ALG_CHACHA20_POLY1305,</span><br><span> };</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-enum ovpn_del_peer_reason {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON=
_TEARDOWN,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_DEL_P=
EER_REASON_USERSPACE,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	OVPN_DEL_PEER_REASON_EXPIRED,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+enum ovpn_del_peer_reason=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TEARDOWN,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REAS=
ON_USERSPACE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OV=
PN_DEL_PEER_REASON_EXPIRED,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT=
,</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-enum ovpn_key_slot {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	OVPN_KEY_SLOT_PRIMARY,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	OVPN_KEY_SLOT_SECONDARY,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+enum ovpn_key_slot</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    OVPN_KEY_SLOT_PRIMARY,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_KEY_SLOT_SECONDARY,</span><br><span> };</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-enum {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_ID =3D 1,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_REMOTE_IPV4,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_REMOTE_IPV6,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_REMOTE_IPV=
6_SCOPE_ID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PE=
ER_REMOTE_PORT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_=
A_PEER_SOCKET,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A=
_PEER_SOCKET_NETNSID,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	OVPN_A_PEER_VPN_IPV4,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	OVPN_A_PEER_VPN_IPV6,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	OVPN_A_PEER_LOCAL_IPV4,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_A_PEER_LOCAL_IPV6,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	OVPN_A_PEER_LOCAL_PORT,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	OVPN_A_PEER_KEEPALIVE_INTERVAL,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	OVPN_A_PEER_KEEPALIVE_TIMEOUT,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_DEL_REASON,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_RX_BYTES,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_TX_BYTES,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_RX_PACKETS,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_VPN_TX_PAC=
KETS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PEER_LIN=
K_RX_BYTES,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_PE=
ER_LINK_TX_BYTES,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVP=
N_A_PEER_LINK_RX_PACKETS,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	OVPN_A_PEER_LINK_TX_PACKETS,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+enum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_ID =
=3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PE=
ER_REMOTE_IPV4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OVPN_A_PEER_REMOTE_IPV6,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_A_PEER_REMOTE_IPV6_SCOPE_ID,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    OVPN_A_PEER_REMOTE_PORT,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_SOCKET,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_SOCKET_NETNSID,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_IPV4,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN=
_IPV6,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PE=
ER_LOCAL_IPV4,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
VPN_A_PEER_LOCAL_IPV6,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_A_PEER_LOCAL_PORT,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    OVPN_A_PEER_KEEPALIVE_INTERVAL,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    OVPN_A_PEER_KEEPALIVE_TIMEOUT,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_DEL_REASON,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_VPN_RX_BY=
TES,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER=
_VPN_TX_BYTES,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    O=
VPN_A_PEER_VPN_RX_PACKETS,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_A_PEER_VPN_TX_PACKETS,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OVPN_A_PEER_LINK_RX_BYTES,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LINK_TX_BYTES,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LINK_RX_PACKETS,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_LINK_=
TX_PACKETS,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	__OVPN_A_PEER_MAX,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_A_PEER_MAX =3D (__OVPN_A_PEER_MAX - 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    __OVPN_A_PEER_MAX,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER_MAX =3D (__OVPN_A_PEER_MA=
X - 1)</span><br><span> };</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-enum {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	OVPN_A_KEYCONF_PEER_ID =3D 1,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	OVPN_A_KEYCONF_SLOT,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-	OVPN_A_KEYCONF_KEY_ID,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	OVPN_A_KEYCONF_CIPHER_ALG,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_ENCRYPT_DIR,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCONF_DECRYPT_DIR,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+enum</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    OVPN_A_KEYCONF_PEER_ID =3D 1,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OVPN_A_KEYCONF_SLOT,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF_KEY_ID,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF_CIPHER_ALG,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF_ENCRYPT_DIR=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF=
_DECRYPT_DIR,</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	__OVPN_A_KEYCONF_MAX,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	OVPN_A_KEYCONF_MAX =3D (__OVPN_A_KEYCONF_MAX - 1)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_A_KEYCONF_MAX,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF_MAX =3D =
(__OVPN_A_KEYCONF_MAX - 1)</span><br><span> };</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-enum {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	OVPN_A_KEYDIR_CIPHER_KEY =3D 1,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYDIR_NONCE_TAIL,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+enum</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OVPN_A_KEYDIR_CIPHER_KEY =3D 1,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    OVPN_A_KEYDIR_NONCE_TAIL,</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_A_KEYDIR_MAX=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYDIR_MAX =
=3D (__OVPN_A_KEYDIR_MAX - 1)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    __OVPN_A_KEYDIR_MAX,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    OVPN_A_KEYDIR_MAX =3D (__OVPN_A_KEYDIR_MAX - 1)</span><b=
r><span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-enum {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A=
_IFINDEX =3D 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_=
A_PEER,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_KEYCON=
F,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+enum</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    OVPN_A_IFINDEX =3D 1,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    OVPN_A_PEER,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    OVPN_A_KEYCONF,</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_A_MAX,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	OVPN_A_MAX =3D (__OVPN_A_MAX - 1)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_A_MAX,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_A_MAX =3D (__OVP=
N_A_MAX - 1)</span><br><span> };</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-enum {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	OVPN_CMD_PEER_NEW =3D 1,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	OVPN_CMD_PEER_SET,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-	OVPN_CMD_PEER_GET,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	OVPN_CMD_PEER_DEL,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	OVPN_CMD_PEER_DEL_NTF,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	OVPN_CMD_KEY_NEW,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-	OVPN_CMD_KEY_GET,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	OVPN_CMD_KEY_SWAP,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	OVPN_CMD_KEY_SWAP_NTF,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	OVPN_CMD_KEY_DEL,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	OVPN_CMD_PEER_FLOAT_NTF,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+enum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_PEER_NEW =
=3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_=
PEER_SET,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_C=
MD_PEER_GET,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVP=
N_CMD_PEER_DEL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
OVPN_CMD_PEER_DEL_NTF,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    OVPN_CMD_KEY_NEW,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    OVPN_CMD_KEY_GET,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    OVPN_CMD_KEY_SWAP,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    OVPN_CMD_KEY_SWAP_NTF,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    OVPN_CMD_KEY_DEL,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    OVPN_CMD_PEER_FLOAT_NTF,</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	__OVPN_CMD_MAX,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	OVPN_CMD_MAX =3D (__OVPN_CMD_MAX - =
1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __OVPN_CMD_MA=
X,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OVPN_CMD_MAX =
=3D (__OVPN_CMD_MAX - 1)</span><br><span> };</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define OVPN_MCGRP_PEERS	&quot;pee=
rs&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define OVP=
N_MCGRP_PEERS &quot;peers&quot;</span><br><span> </span><br><span> #endif /=
* _UAPI_LINUX_OVPN_H */</span><br><span>diff --git a/src/openvpn/reflect_fi=
lter=2Ec b/src/openvpn/reflect_filter=2Ec</span><br><span>index e5226e4=2E=
=2E0ae54e1 100644</span><br><span>--- a/src/openvpn/reflect_filter=2Ec</spa=
n><br><span>+++ b/src/openvpn/reflect_filter=2Ec</span><br><span>@@ -5,7 +5=
,8 @@</span><br><span>  *             packet encryption, packet authenticat=
ion, and</span><br><span>  *             packet compression=2E</span><br><s=
pan>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *  Copyright =
(C) 2022-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 OpenVPN Inc &=
lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  Copyright (C) 2023-2026 Arne Schwabe &lt;arne@rfc2549=2Eorg&gt;<=
/span><br><span>  *</span><br><span>  *  This program is free software; you=
 can redistribute it and/or modify</span><br><span>  *  it under the terms =
of the GNU General Public License version 2</span><br><span>@@ -37,8 +38,7 =
@@</span><br><span> #include &quot;crypto=2Eh&quot;</span><br><span> #inclu=
de &quot;reflect_filter=2Eh&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic bool</span><br><span> reflect_filter_rate_limit_check(struct initial_pac=
ket_rate_limit *irl)</span><br><span> {</span><br><span>     if (now &gt; i=
rl-&gt;last_period_reset + irl-&gt;period_length)</span><br><span>@@ -73,34=
 +73,367 @@</span><br><span>     return !over_limit;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-reflect_filter_rate_limi=
t_decrease(struct initial_packet_rate_limit *irl)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+reset_filter_tier(struct initial_packet_rate_limit *i=
rl,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
  struct filter_tier *tier, const char *prefix)</span><br><span> {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (; tier !=3D NULL; t=
ier =3D tier-&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(tier-&gt;dropped &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(D_TLS_DEBUG_LOW, &quot;Dropped %zu initial handshake packets du=
e to &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                         &quot;--connect-freq-initial-bloom-limit %s %d %d&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   tier-&gt;dropped, prefix, tier-&gt;netmask, tier-&gt;limit);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            tier-&gt;dropped =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_f=
ilter_check_reset(struct initial_packet_rate_limit *irl)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (now &gt; irl-&gt;last_period_reset + irl-&gt;per=
iod_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        reset_filter_t=
ier(irl, irl-&gt;bloom_conf=2Einet_tiers, &quot;inet&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        reset_filter_tier(irl, irl=
-&gt;bloom_conf=2Einet6_tiers, &quot;inet6&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        bloom_clear(irl-&gt;bf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * structure used as lookup key for the bloom structure=2E We=
 used the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * netmask=
 as part of the structure to avoid the look for the first</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * IP of a subnet and the subnet to b=
e same key=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+struct bloom_filter_ke=
y</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    union</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        struct in_addr in;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct in6_addr in6;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    int netmask;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* we keep the count in the key instead of in the bloom =
filter table as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * can then keep the counter in the bloom filter itself small</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * and bloom filter usage is =
the same for 20000 request from the same IP</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * (20k entries with different count but same I=
P) and from 20000 random ips</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * (20k entries with count 1 but different IP) */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int count;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline struct bloom_filter_key</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+filter_mask_inet6(const struct openvpn_sockaddr *addr, =
int netmask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter_k=
ey ret =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ret=2Ein6 =3D addr-&gt;addr=2Ein6=2Esin6_addr;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int bits_to_clear =3D 128 - netmask;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    int bytes_to_clear =3D bits_to_clear / 8=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bits_to_clear =
=3D bits_to_clear % 8;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset(&amp;=
ret=2Ein6=2Es6_addr[15 - bytes_to_clear], 0x00, bytes_to_clear);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ret=2Ein6=2Es6_addr[15 - bytes_to_clear - 1] =
&amp;=3D (0xff &lt;&lt; bits_to_clear);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    ret=2Enetmask =3D netmask;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+static inline struct bloom_filter_key</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+filter_mask_inet(const struct =
openvpn_sockaddr *addr, int netmask)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct bloom_filter_key ret =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    ret=2Ein =3D addr-&gt;addr=2Ein4=2Esin_addr;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=2Ein=2Es_addr &a=
mp;=3D htonl(0xffffffff &lt;&lt; (32 - netmask));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ret=2Enetmask =3D netmask;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* We use one function and an action argument to avoid repeating</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * the code to iterate to the =
tiers and the creating the lookup</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * keys */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+enum bloom_filter_action</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    REFL=
ECT_CHECK,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    REFLE=
CT_INCREASE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    REF=
LECT_DECREASE,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+reflect_lookup_bf_key(struct bloom_filter *bf, str=
uct bloom_filter_key *key, int limit)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* we do a lookup for 1,2,3, and 4 and the limit first</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * and after that do regular bin=
ary search=2E This is meant to optimise</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * the common case where just a small number of req=
uests are coming from</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * each IP */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    key-&gt;count =3D limit;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (bloom_test(bf, (const uint8_t *)key, sizeof(struct bloom_f=
ilter_key)) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return=
 limit;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    key-&gt;count =3D 4;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (bloom_test(bf, (const uint8_t *)=
key, sizeof(struct bloom_filter_key)) =3D=3D 0)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* The value for 4 has not been found, so the real va=
lue might be 1, 2, or 3=2E */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        for (int i =3D 3; i &gt; 0; i--)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            key-&gt;count =3D i;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (bloom_test(bf, (const uin=
t8_t *)key, sizeof(struct bloom_filter_key)) &gt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                return i;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* 4 was no in the map and 1-3 are also not there, so assume the key=
 is not in the map */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    int low =3D 3;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int high =3D limit;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    while (low &lt; high)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        key-&gt;count =3D (high + low + 1) / 2;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        bloom_counter_t cou=
nt =3D bloom_test(bf, (const uint8_t *)key, sizeof(struct bloom_filter_key)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (count=
 &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            low =3D k=
ey-&gt;count;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            high =3D key-&gt;coun=
t - 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    return low;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Convert a mapped IPv6 mapped IPv4 a=
ddress (::ffff:0:0/96) to an</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * equivalent IPv4 adress=2E</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @note: This function only converts the IP itself and ignores other</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * parts of the \c from =
structure like port or protocol=2E</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic struct openvpn_sockaddr</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+convert_mapped_inet_sockaddr(const struct openvpn_sockaddr *from)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from_mapp=
ed =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 we ignore the fields like port that the key in the bloom filter</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * ignores too=2E This mak=
es this function non-generic */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fro=
m_mapped=2Eaddr=2Ein4=2Esin_family =3D AF_INET;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    memcpy(&amp;from_mapped=2Eaddr=2Ein4=2Esin_addr=2Es_addr,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+           &amp;from-&gt=
;addr=2Ein6=2Esin6_addr=2Es6_addr[12],</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+           sizeof(from_mapped=2Eaddr=2Ein4=2Esin_addr=2E=
s_addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return from_mapped;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+bloom_filter_action(struct initial_packet_rate_limit *irl,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    const str=
uct openvpn_sockaddr *from,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    enum bloom_filter_action action)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    bool found =3D false;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct filter_tier *tier =3D NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from_mapped;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (from-&gt;addr=2Esa=2Esa_family =3D=
=3D AF_INET6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 &amp;&amp; IN6_IS_ADDR_V4MAPPED(&amp;from-&gt;addr=2Ein6=2Esin6_addr))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        from_mapped =3D convert_mappe=
d_inet_sockaddr(from);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        from =3D &amp;from_mapped;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (from-&g=
t;addr=2Esa=2Esa_family =3D=3D AF_INET)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        tier =3D irl-&gt;bloom_conf=2Einet_tiers;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (from-&gt;addr=2Esa=2Esa_family =3D=3D AF=
_INET6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tier =3D irl-&gt;b=
loom_conf=2Einet6_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    while (tier)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct filter_tier *next_tier =3D tie=
r-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct bloom_filter_key key;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (from-&gt;addr=2Esa=2Esa_family =3D=3D AF_INET6)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            key =3D filter_mask_inet6(from, tier-&gt;ne=
tmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            key =3D filter_mask_inet(fr=
om, tier-&gt;netmask);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* fetch the curre=
nt count of the key in the bloom filter */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        int result =3D reflect_lookup_bf_key(irl-&gt=
;bf, &amp;key, tier-&gt;limit);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 switch (action)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
ase REFLECT_CHECK:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               if (result &gt;=3D tier-&gt;limit)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    found =3D true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    tier-&gt;dr=
opped++;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         if (tier-&gt;dropped =3D=3D 1)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        msg(M_WARN, &quot;Note: --con=
nect-freq-initial-bloom-limit &quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                    &quot;limit for netmas=
k /%d exceeded=2E Expect additional &quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                    &quot;initial pa=
cket drops for the next %d seconds&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                            tier-&gt;netmask,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
 (int)(irl-&gt;last_period_reset + irl-&gt;period_length - now));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                break;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            case REFLECT_INCREASE:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                ASSERT(result =
&lt; tier-&gt;limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                key=2Ecount =3D result + 1;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                bloom_add(irl-&gt;bf, (const uint=
8_t *)&amp;key, sizeof(key));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      case REFLECT_DECREASE:</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                key=2Ecount =3D result - 1;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                bloom_remove(irl-&gt;bf, =
(const uint8_t *)&amp;key, sizeof(key));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                break;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   tier =3D next_tier;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!fo=
und &amp;&amp; action =3D=3D REFLECT_CHECK)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* We only want to increase the counters if the IP is not=
 already</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
in the set=2E */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     bloom_filter_action(irl, from, REFLECT_INCREASE);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return found;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bloom_filter_check(struct =
initial_packet_rate_limit *irl,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                   const struct openvpn_sockaddr *from)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (now &gt; irl-&gt;last_period_reset + =
irl-&gt;period_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        blo=
om_filter_check_reset(irl);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return bloom_filter_a=
ction(irl, from, REFLECT_CHECK);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+reflect_filter_check(struct initial_packet_rate_limit *i=
rl,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
     const struct openvpn_sockaddr *from)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* We are doing the bloom filter check first so packets that are al=
ready</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * rejecte=
d by the bloom filter do not count against the limit of the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     * simple rate limiter */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (irl-&gt;bf &amp;&=
amp; bloom_filter_check(irl, from))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!reflect_filter_rate_=
limit_check(irl))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return f=
alse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+reflect_filter_rate_limit_decrease(struct init=
ial_packet_rate_limit *irl, struct openvpn_sockaddr *from)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (irl-&gt;bf &amp;&amp; bloom_filter_action(irl,=
 from, REFLECT_CHECK))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* =
Only remove if it is actually present=2E This might be a packet</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+         * coming from an early=
 period or be relayed */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        bloom_filter_action(irl, from, REFLECT_DECREASE);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     if (irl-&gt;curr_period_=
counter &gt; 0)</span><br><span>     {</span><br><span>         irl-&gt;cur=
r_period_counter--;</span><br><span>     }</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+reflect_add_filter_tier(struct=
 bloom_filter_conf *bfconf, struct gc_arena *gc,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        bool ipv6, int netmask=
, int limit)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct filter_tier *f=
tnew =3D gc_malloc(sizeof(struct filter_tier), true, gc);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ftnew-&gt;netmask =3D netmask;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ftnew-&gt;limit =3D limit;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (ipv6)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ftnew-&gt;next =3D bfconf-&gt;inet6_tiers;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        bfconf-&gt;inet6_tiers =3D ftn=
ew;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        ftnew-&gt;next =3D bfconf-&gt;inet_tiers;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        bfconf-&gt;inet_t=
iers =3D ftnew;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+init_bloom_filter(struct initial_packet_rate_limit *irl)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!irl-&gt;bloom_conf=2Esize)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* the default allocates 2MB for bloom fi=
lter entries */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    irl-&gt;bloom_conf=2Esize =3D 1024ul * 1024 * 8;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!irl-&gt;bloom_conf=2Enum_hashes)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        irl-&gt;bloom_conf=2Enum_hashes =3D 7;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    irl-&gt;bf =3D bloom_create(irl-&gt;bloom_conf=2E=
size, irl-&gt;bloom_conf=2Enum_hashes,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                           &amp;irl-&gt;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    bloom_clear(irl-&gt;bf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </s=
pan><br><span> struct initial_packet_rate_limit *</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-initial_rate_limit_init(int max_per_period, int=
 period_length)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init=
ial_rate_limit_init(int max_per_period, int period_length,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                        struct bloom=
_filter_conf *bconf)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    struct initial_packet_rate_limit *irl;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct initial_packet_rate_lim=
it *irl =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ALLOC_OBJ_CLEAR(irl, struct initial_packet_rate_limit);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ALLOC_OBJ(irl, struct initial_packet_r=
ate_limit);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    irl-=
&gt;gc =3D gc_new();</span><br><span> </span><br><span>     irl-&gt;max_per=
_period =3D max_per_period;</span><br><span>     irl-&gt;period_length =3D =
period_length;</span><br><span>     irl-&gt;curr_period_counter =3D 0;</spa=
n><br><span>     irl-&gt;last_period_reset =3D 0;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (bconf-&gt;inet6_tie=
rs || bconf-&gt;inet_tiers)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  irl-&gt;bloom_conf =3D *bconf;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        init_bloom_filter(irl);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     return irl;</span><br><span> }</span><br><=
span> </span><br><span> void</span><br><span> initial_rate_limit_free(struc=
t initial_packet_rate_limit *irl)</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;irl-&gt;gc);</span><br><=
span>     free(irl);</span><br><span> }</span><br><span>diff --git a/src/op=
envpn/reflect_filter=2Eh b/src/openvpn/reflect_filter=2Eh</span><br><span>i=
ndex 84915e8c6=2E=2Ebe2b926 100644</span><br><span>--- a/src/openvpn/reflec=
t_filter=2Eh</span><br><span>+++ b/src/openvpn/reflect_filter=2Eh</span><br=
><span>@@ -23,6 +23,30 @@</span><br><span> #define REFLECT_FILTER_H</span><=
br><span> </span><br><span> #include &lt;limits=2Eh&gt;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket=2Eh&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;bloom=2Eh&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+struct filter_tier</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct filter_tier *next;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    int limit;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int netmask;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** The num=
ber of packets we dropped since we went over this limit */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t dropped;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+struct bloom_filter_conf</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 filter_tier *inet_tiers;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct filter_tier *inet6_tiers;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* Configuration of the bloom filter */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    size_t num_hashes;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    size_t size;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> </span><br><span> /** struct that handles all =
the rate limiting logic for initial</span><br><span>  * responses */</span>=
<br><span>@@ -35,7 +59,7 @@</span><br><span>     int period_length;</span><=
br><span> </span><br><span>     /** Number of packets in the current period=
=2E We use int64_t here</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * to avoid any potiential issues with overflow */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * to avoid any potential issues w=
ith overflow */</span><br><span>     int64_t curr_period_counter;</span><br=
><span> </span><br><span>     /* Last time we reset our timer */</span><br>=
<span>@@ -44,29 +68,57 @@</span><br><span>     /* we want to warn once per =
period that packets are being started to</span><br><span>      * be dropped=
 */</span><br><span>     bool warning_displayed;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct bloom_filter_conf bloom_conf;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct bloom_filter *bf;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /* gc_arena used for the various allocations by th=
is struct */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc;</span><br><span> };</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Adds a bloom filter tier to the bloom filter config=
=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+reflect_add_filter_tier(struct bloom_filter_con=
f *bfconf, struct gc_arena *gc,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        bool ipv6, int netmask, int limit);</sp=
an><br><span> </span><br><span> /**</span><br><span>  * checks if the conne=
ction is still allowed to connect under the rate</span><br><span>  * limit=
=2E This also increases the internal counter at the same time</span><br><sp=
an>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool reflect_f=
ilter_rate_limit_check(struct initial_packet_rate_limit *irl);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+reflect_filter_check(struct initial_packet_rate=
_limit *irl,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
              const struct openvpn_sockaddr *from);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /**</=
span><br><span>  * decreases the counter of initial packets seen, so connec=
tions that</span><br><span>  * successfully completed the three-way handsha=
ke do not count against</span><br><span>  * the counter of initial connecti=
on attempts</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-void reflect_filter_rate_limit_decrease(struct initial_packet_ra=
te_limit *irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reflect_filter_rate=
_limit_decrease(struct initial_packet_rate_limit *irl,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                                   struc=
t openvpn_sockaddr *from);</span><br><span> </span><br><span> /**</span><br=
><span>  * allocate and initialize the initial-packet rate limiter structur=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Note: this function does not cop=
y bconf&#39;s contents=2E</span><br><span>  */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-struct initial_packet_rate_limit *initial_rate_lim=
it_init(int max_per_period, int period_length);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+struct initial_packet_rate_limit *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+initial_rate_limit_init(int max_=
per_period, int period_length,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        struct bloom_filter_conf *bconf);</span>=
<br><span> </span><br><span> /**</span><br><span>  * free the initial-packe=
t rate limiter structure</span><br><span>  */</span><br><span> void initial=
_rate_limit_free(struct initial_packet_rate_limit *irl);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Initialises the bloom filter with the configuration values of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * irl-&gt;bloom_conf</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+init_bloom_filter(struct initial_packet_rate_limit *irl)=
;</span><br><span> #endif /* ifndef REFLECT_FILTER_H */</span><br><span>dif=
f --git a/tests/unit_tests/openvpn/Makefile=2Eam b/tests/unit_tests/openvpn=
/Makefile=2Eam</span><br><span>index 70cf7b2=2E=2E1484790 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/Makefile=2Eam</span><br><span>+++ b/te=
sts/unit_tests/openvpn/Makefile=2Eam</span><br><span>@@ -107,6 +107,7 @@</s=
pan><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO=
_LIBS)</span><br><span> ssl_testdriver_SOURCES =3D test_ssl=2Ec \</span><br=
><span> 	test_acc=2Ec test_acc=2Eh \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	test_reflect=2Ec test_reflect=2Eh \</span><br><span> 	moc=
k_msg=2Ec mock_msg=2Eh test_common=2Eh \</span><br><span> 	mock_management=
=2Ec \</span><br><span> 	mock_ssl_dependencies=2Ec mock_win32_execve=2Ec \<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/test_reflect=2Ec b/te=
sts/unit_tests/openvpn/test_reflect=2Ec</span><br><span>new file mode 10064=
4</span><br><span>index 0000000=2E=2Ed0d11c6</span><br><span>--- /dev/null<=
/span><br><span>+++ b/tests/unit_tests/openvpn/test_reflect=2Ec</span><br><=
span>@@ -0,0 +1,293 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN --=
 An application to securely tunnel IP networks</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with =
support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             session authentication and key exchange,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption,=
 packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet compression=2E</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  Copyright (C) 2002-2026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; y=
ou can redistribute it and/or modify</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  it under the terms of the GNU General Public License v=
ersion 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publ=
ished by the Free Software Foundation=2E</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is distributed in the hope that it will be useful,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE=2E  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 GNU General Public License for more details=2E</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  You should have received a copy of the GNU General Public Li=
cense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with=
 this program; if not, see &lt;https://www=2Egnu=2Eorg/licenses/&gt;=2E</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config=2Eh&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#elif defined(_MSC_VER)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;config-msvc=2Eh&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;syshead=2Eh&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;bloom=2Eh&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;buffer=2Eh&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;reflect_filter=2Eh&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;te=
st_common=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp=
=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;stdarg=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#in=
clude &lt;cmocka=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;s=
tdio=2Eh&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static_assert(BLOOM_FILTER=
_BITS_COUNT =3D=3D 4, &quot;unit test not in sync&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static_assert(BLOOM_FILTER_BITS_MASK =
=3D=3D 0xf, &quot;unit test not in sync&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_b=
loom(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static const in=
t present_mod =3D 77;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_are=
na gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Use a bloom filter with 1M entries (256kB) for the unit test */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct bloom_filter =
*bf =3D bloom_create(1024ul * 1024, 8, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int32_t i =3D 0; i &lt; 20000; i +=3D present_mod)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        bloom_add(bf, (const uint8_t *)=
&amp;i, sizeof(i));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* all these should be positi=
ve, for the small unit test we do not expect</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * false positive */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (int32_t i =3D 0; i &lt; 20000; i++)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        int present =3D (i % prese=
nt_mod =3D=3D 0) ? 1 : 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        /* cast to bool to only get 1 and 0 for present/not present a=
nd not */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        as=
sert_int_equal((bool)bloom_test(bf, (const uint8_t *)&amp;i, sizeof(i)), pr=
esent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_reflect_ddos(=
void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* This tests if the=
 bloom filter implementation does actually work with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * the goal of dropping packets to a =
reflected /24 while still allowing</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     * other clients */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* Disable the normal fallback that puts a hard cap on the reflection f=
ilter */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
initial_packet_rate_limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&amp;i=
rl-&gt;bloom_conf, &amp;irl-&gt;gc, false, 24, 5);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;blo=
om_conf, &amp;irl-&gt;gc, false, 8, 20);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    init_bloom_filter(irl);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    int num_legimate_reject =3D 0;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int num_legimate_accepted =3D 0;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int num_ddos_rejected =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    int num_ddos_accepted =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* /24 net addresses in host byte order */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    in_addr_t net_attack[4];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt;=
 3; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        net_attack[i] =3D=
 random() % 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* The 4th network is close eno=
ugh to the 3rd to fall in the same /16 */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /* XOR the 3rd byte to achieve this */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    net_attack[3] =3D net_atta=
ck[2] ^ 00002300;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Assume 200000 =
packets, including roughly 200 legitimate packets,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     * the unit test works also with 20 mill=
ions packet but takes too long*/</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    static const int total_packets =3D 200 * 1000;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; total_packets; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        struct openvpn_sockaddr fro=
m =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 from=2Eaddr=2Ein4=2Esin_family =3D AF_INET;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D =
(in_addr_t)random();</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        from=2Eaddr=2Ein4=2Esin_port =3D (uint16_t)random();</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (i % 1023 =3D=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            /* roughly 200 legitimate clients with =
random addresses */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            from=2Eaddr=2Ein4=2Esin_addr=2Es_addr =3D (in_addr_t)random();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            bool allowed =3D reflect_fi=
lter_check(irl, &amp;from);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (allowed)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                num_legimate_accepted++;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                num_legimate_reject++;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            /* We attack the 4 networks at random */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            from=2Eaddr=2Ein4=2Esin_addr=
=2Es_addr =3D (in_addr_t)(net_attack[random() % 4] + (random() % 256));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            bool allowed =3D reflect_filt=
er_check(irl, &amp;from);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            if (allowed)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                num_ddos_accepted++;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                num_ddos_rejected++;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(num_=
legimate_reject + num_legimate_accepted + num_ddos_accepted + num_ddos_reje=
cted, total_packets);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* We assume =
that most legitimate made it through but a few were unfortunate to be in an=
 attacked network */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_in_range(num_legimate_reject, 0, 10);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* We disabled total number of packets, so we expect all=
 /8 to have their</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * 20 packets, which is 5120=2E */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_in_range(num_ddos_accepted, 0, 256 * 20);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    initial_rate_limit_free(irl);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+test_bloom_minimal(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D =
gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 bloom_filter *bf =3D bloom_create(2048, 3, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int item =3D 0xbabe;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    bloom_add(bf, (const uint8_t *)&amp;item, sizeof(item));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(bloom_test(b=
f, (const uint8_t *)&amp;item, sizeof(item)), 1);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    item =3D 0xf00f;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(bloom_test(bf, (const uint8_t *)&amp;item,=
 sizeof(item)), 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+test_reflect_reflect_bloom_simple(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct initial_packet_rate_limit *irl =3D initial_rate_=
limit_init(INT_MAX, 300, NULL);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ref=
lect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true, 32, 50=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reflect_add_f=
ilter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true, 56, 200);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    init_bloom_filter(irl)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr from =3D =
{ 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from=2Ead=
dr=2Ein6=2Esin6_family =3D AF_INET6;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    from=2Eaddr=2Ein6=2Esin6_port =3D (uint16_t)random();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    from=2Eaddr=2Ein=
6=2Esin6_addr=2Es6_addr[15] =3D 1; /* ::1 */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* There are 50 attempts that should work until one fails */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i =
&lt; 50; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_true(=
reflect_filter_check(irl, &amp;from));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* 2002::1=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openv=
pn_sockaddr from2 =3D from;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    from2=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[0] =3D 0x7;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    from2=2Eaddr=2Ein6=2Esin6_=
addr=2Es6_addr[1] =3D 0x7;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(reflect_filter_check(irl, &amp;from2));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Any more attempts from ::1 should fail */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(reflect_filter_check(irl=
, &amp;from));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    initial_rate_limit_f=
ree(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_reflect_bloom_netmask_masking(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct initial_packet_rate_limit *irl =3D initi=
al_rate_limit_init(INT_MAX, 300, NULL);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;irl-&gt;gc, true=
, 45, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_=
bloom_filter(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_s=
ockaddr from =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    from=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    from=2Eaddr=2Ein6=2Esin6_port =3D (ui=
nt16_t)random();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; 15; i++)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        from=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[i] =3D (uint8_t)random();<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; 10; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* /45 means that if we leave the leave f=
irst 8 bytes and 5 bits</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+         * untouched, it is still the same subnet  */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for (int j =3D 8; j &lt; 15; =
j++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            from=2Eaddr=
=2Ein6=2Esin6_addr=2Es6_addr[j] =3D (uint8_t)random();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            from=2Eaddr=2Ein6=2Esin6_add=
r=2Es6_addr[7] ^=3D (uint8_t)(random() &amp; 0x7);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        assert_true(reflect_filter_check(irl, &amp;fro=
m));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* testing the last IP again should give us =
a negative result */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_false(reflect_filter_check(irl, &amp;from));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    initial_rate_limit_free(irl);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_reflect_reflect_bloom_mapped(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct initial_packet_r=
ate_limit *irl =3D initial_rate_limit_init(INT_MAX, 300, NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_con=
f, &amp;irl-&gt;gc, false, 24, 50);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    reflect_add_filter_tier(&amp;irl-&gt;bloom_conf, &amp;i=
rl-&gt;gc, false, 8, 80);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    init_bloom_filter(irl);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
* Our OpenVPN server will not receive IPv4 as well as IPv4 mapped</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     * addresses in the same =
process but for the unit test it is convient</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * to see if they actually mapped to the same =
entries */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr =
mapped_v4 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mapped_v4=2Eaddr=2Ein6=2Esin6_family =3D AF_INET6;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_port =
=3D (uint16_t)random();</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /* ::ffff:192=2E168=2E0=2E99 */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[10] =
=3D 0xff;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mapped=
_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[11] =3D 0xff;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2E=
s6_addr[12] =3D 192;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[13] =3D 168;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin=
6_addr=2Es6_addr[14] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    mapped_v4=2Eaddr=2Ein6=2Esin6_addr=2Es6_addr[15] =3D 99;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_true(IN6_IS_ADDR_V4MAPPED(&amp;map=
ped_v4=2Eaddr=2Ein6=2Esin6_addr));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Not the same address but in the same /8 */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr v4addr =3D { 0 };</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    v4addr=2Eaddr=2Ein4=
=2Esin_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    v4addr=2Eaddr=2Ein4=2Esin_port =3D (uint16_t)random();</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* 192=2E168=2E123=2E244 =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    v4addr=2Eaddr=
=2Ein4=2Esin_addr=2Es_addr =3D htonl(0xc0a87bf4);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* check that we run into the 50 limit with our mapped addre=
ss */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i=
 =3D 0; i &lt; 50; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        as=
sert_true(reflect_filter_check(irl, &amp;mapped_v4));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_false(reflect_filter_check(irl, &amp;mapped_=
v4));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* Check that the non-mapped IPv4 address uses t=
he same /8 subnet limit */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    for (int i =3D 0; i &lt; 30; i++)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        assert_true(reflect_filter_check(irl, &amp;v4addr));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_false(reflect_filter_check=
(irl, &amp;v4addr));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    initial_rate_l=
imit_free(irl);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span>\ No newline at end of file</span><br><span>diff --git a/test=
s/unit_tests/openvpn/test_reflect=2Eh b/tests/unit_tests/openvpn/test_refle=
ct=2Eh</span><br><span>new file mode 100644</span><br><span>index 0000000=
=2E=2E0dc1e4c</span><br><span>--- /dev/null</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_reflect=2Eh</span><br><span>@@ -0,0 +1,37 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunn=
el IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *   =
          over a single TCP/UDP port, with support for SSL/TLS-based</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             session aut=
hentication and key exchange,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             packet encryption, packet authentication, and</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet co=
mpression=2E</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2=
026 OpenVPN Inc &lt;sales@openvpn=2Enet&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  Copyright (C) 2023-2026 Arne Schwabe &lt;arne@r=
fc2549=2Eorg&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is =
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
=3D"color: hsl(120, 100%, 40%);">+#ifndef TEST_REFLECT_H</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define TEST_REFLECT_H</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void test_reflect_ddos(void **state=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+void test_bloom(void **state);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void test_bloom_minimal(void **state);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+void test_reflect_reflect_bloom_simple(void =
**state);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void test_reflect_bloom_netma=
sk_masking(void **state);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void test_ref=
lect_reflect_bloom_mapped(void **state);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span>\ No newline at end of file</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl=2Ec b/tests/uni=
t_tests/openvpn/test_ssl=2Ec</span><br><span>index 4987dd0=2E=2E8791b2a 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><=
span>+++ b/tests/unit_tests/openvpn/test_ssl=2Ec</span><br><span>@@ -51,6 +=
51,7 @@</span><br><span> #include &quot;ssl_util=2Eh&quot;</span><br><span>=
 #include &quot;ssl_verify=2Eh&quot;</span><br><span> #include &quot;openvp=
n=2Eh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;test_reflect=2Eh&quot;</span><br><span> </span><br><span> #include &=
quot;test_acc=2Eh&quot;</span><br><span> </span><br><span>@@ -1132,7 +1133,=
13 @@</span><br><span>         cmocka_unit_test(test_parse_acc_parameters),=
</span><br><span>         cmocka_unit_test(test_acc_common_protocols),</spa=
n><br><span>         cmocka_unit_test(test_acc_send_message),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_list_=
intersection)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  cmocka_unit_test(test_list_intersection),</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        cmocka_unit_test(test_bloom),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_blo=
om_minimal),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 cmocka_unit_test(test_reflect_reflect_bloom_simple),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_reflect_ref=
lect_bloom_mapped),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        cmocka_unit_test(test_reflect_bloom_netmask_masking),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_ref=
lect_ddos)</span><br><span>     };</span><br><span> </span><br><span> #if d=
efined(ENABLE_CRYPTO_OPENSSL)</span><br></pre><p>To view, visit <a href=3D"=
https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail">change 30</a>=2E=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"https:/=
/gerrit=2Eopenvpn=2Enet/settings?usp=3Demail">settings</a>=2E</p><div items=
cope itemtype=3D"http://schema=2Eorg/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema=2Eorg/ViewAction"><link itemprop=3D"u=
rl" href=3D"https://gerrit=2Eopenvpn=2Enet/c/openvpn/+/30?usp=3Demail"/><me=
ta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"d=
isplay:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:=
none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-B=
ranch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a9274=
cab7fefce3b13c05052fb9a072e0bfa6b9 </div>
<div style=3D"display:none"> Gerr=
it-Change-Number: 30 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1=
2 </div>
<div style=3D"display:none"> Gerrit-Owner: Arne Schwabe &lt;arne-o=
penvpn@rfc2549=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewe=
r: Frank Lichtenheld &lt;frank@lichtenheld=2Ecom&gt; </div>
<div style=3D"d=
isplay:none"> Gerrit-Reviewer: Max Fillinger &lt;max@max-fillinger=2Enet&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: R=C4=83zvan Cojocaru=
 &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display:none"> Gerrit-C=
C: openvpn-devel &lt;openvpn-devel@lists=2Esourceforge=2Enet&gt; </div>
<di=
v style=3D"display:none"> Gerrit-Attention: Max Fillinger &lt;max@max-filli=
nger=2Enet&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: R=C4=
=83zvan Cojocaru &lt;razvanc@mailbox=2Eorg&gt; </div>
<div style=3D"display=
:none"> Gerrit-Attention: Arne Schwabe &lt;arne-openvpn@rfc2549=2Eorg&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: Frank Lichtenheld &lt;=
frank@lichtenheld=2Ecom&gt; </div>

</body></html>
--WAaBP99Hz0w=--


--===============6590316927641074764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6590316927641074764==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

--===============6590316927641074764==--

